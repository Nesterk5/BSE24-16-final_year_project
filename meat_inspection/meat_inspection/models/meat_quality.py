from odoo import models, fields, api,_
import tensorflow as tf
from PIL import Image,ImageDraw
import numpy as np
from io import BytesIO
import os
import base64



CLASS_LABELS = ['spoiled', 'half-fresh', 'fresh']

class MeatQuality(models.Model):
    _name = "meat.quality"
    _description = "Meat Quality"
    # _inherit = ['mail.thread', 'mail.activity.mixin', 'image.mixin']

    
    
    name = fields.Char(string='Code', required=True,
                          readonly=True, default=lambda self: _('New'))
    
    image = fields.Binary(
        string='Image',
    )

    
    date_scanned = fields.Date(
        string='date_scanned',
        default=fields.Date.context_today,
    )

    
    score = fields.Float(
        string='score',
    )

    
    comment = fields.Char(
        string='comment',
    )
    
    class_label = fields.Selection(
        string='Class Label',
        selection=[('fresh', 'FRESH'), ('half_fresh', 'Half-FRESH'),('spoiled','SPOILED')]
    )
    

    user_id = fields.Many2one(
        string='User', 
        comodel_name='res.users', 
    )

    
    company_id = fields.Many2one(
        string='Company', 
        comodel_name='res.company', 
        default=lambda self: self.env.user.company_id
    )
    
    
    # @api.model
    # def create(self, vals):
    #     if vals.get('name', _('New')) == _('New'):
    #         vals['name'] = self.env['ir.sequence'].next_by_code(
    #             'meat.inspection.sequence') or _('New')


    def process_image(self,input_data):
        image = False
        binary_data = False
        img_str = False
        model_path = f'{os.path.dirname(__file__)}/ml/yolov5.tflite'

        if 'image' in input_data and input_data['image']:
            image = input_data['image']
            image_path = base64.b64decode(image)

            recognitions = self.run_model_on_image(image_path, model_path)

            for recognition in recognitions:
                print(f"Label: {recognition['label']}, Confidence: {recognition['confidence']}")
            
            return recognitions[0]

  
    def image_to_byte_array(self,image: Image, size: int, mean: float, std: float) -> np.ndarray:
        image = image.resize((size, size))
        img_array = np.array(image).astype(np.float32)
        img_array = (img_array - mean) / std
        img_array = np.expand_dims(img_array, axis=0)  # Add batch dimension
        return img_array
    
    def run_model_on_image(self,image_path, model_path, num_results=6, threshold=0.05):
        # Load image
        image = Image.open(BytesIO(image_path))

        # Convert image to byte array
        input_data = self.image_to_byte_array(image, 640, 0, 255)

        # Load the TFLite model
        interpreter = tf.lite.Interpreter(model_path=model_path)
        interpreter.allocate_tensors()

        # Get input and output tensors
        input_details = interpreter.get_input_details()
        output_details = interpreter.get_output_details()

        # Set the tensor to point to the input data
        interpreter.set_tensor(input_details[0]['index'], input_data)

        # Run inference
        interpreter.invoke()

        # Get the output results
        output_data = interpreter.get_tensor(output_details[0]['index'])

        print('')
        print('',output_data.shape[1])
        print('')

        # Process the output results
        recognitions = self.process_output(output_data, num_results, threshold)

        return recognitions
    

    def process_output(self,output_data, num_results, threshold):
        results = []
        for i in range(output_data.shape[1]):
            confidence = output_data[0, i, 4]  # Confidence score
            if confidence > threshold:
                class_index = np.argmax(output_data[0, i, 5:])  # Class with highest probability
                class_confidence = output_data[0, i, 5 + class_index]
                results.append({
                    "index": class_index,
                    "label": CLASS_LABELS[class_index],  # Replace with actual class labels if available
                    "confidence": class_confidence
                })

        # Sort results by confidence score in descending order and return top num_results
        results = sorted(results, key=lambda x: x['confidence'], reverse=True)[:num_results]
        return results

   
