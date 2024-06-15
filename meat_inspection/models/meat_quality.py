from odoo import models, fields, api,_
import tensorflow as tf
from PIL import Image,ImageDraw
import numpy as np
from io import BytesIO
import os
import base64
import cv2

CLASS_LABELS = ['Spoiled', 'Half-fresh', 'Fresh']

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
        model_path = f'{os.path.dirname(__file__)}/ml/model.tflite'

        if 'image' in input_data and input_data['image']:
            image = input_data['image']
            # image_path = base64.b64decode(image)

            recognitions = self.run_model_on_image(image, model_path)

            for recognition in recognitions:
                print(f"Label: {recognition['label']}, Confidence: {recognition['confidence']}")

            return recognitions[0]


    def image_to_byte_array(self,image, size: int, mean: float, std: float) -> np.ndarray:
        # image = np.resize((size, size))
        image = img_resized = cv2.resize(image, (128,128))
        img_array = np.array(image).astype(np.float32)
        img_array = (img_array - mean) / std
        img_array = np.expand_dims(img_array, axis=0)  # Add batch dimension
        return img_array


    def read_image_from_base64(self,base64_string):
        # Remove the header if it's included in the base64 string
        if base64_string.startswith('data:image'):
            base64_string = base64_string.split(';base64,')[-1]

        # Decode base64 string into bytes
        image_data = base64.b64decode(base64_string)

        # Convert the bytes data to a numpy array
        nparr = np.frombuffer(image_data, np.uint8)

        # Decode the numpy array into an image using OpenCV
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        return img

    def run_model_on_image(self,image_path, model_path, num_results=6, threshold=0.05):
        # Load image
        image = self.read_image_from_base64(image_path)

        input_data = self.image_to_byte_array(image, 128, 0, 255)

        interpreter = tf.lite.Interpreter(model_path=model_path)
        interpreter.allocate_tensors()


        input_details = interpreter.get_input_details()
        output_details = interpreter.get_output_details()


        interpreter.set_tensor(input_details[0]['index'], input_data)

        interpreter.invoke()

        output_data = interpreter.get_tensor(output_details[0]['index'])

        recognitions = self.process_output(output_data, num_results, threshold)

        return recognitions


    def process_output(self,output_data, num_results, threshold):
        results = []

        print('')
        print('output',output_data)
        print('')
        prediction = output_data[0]

        class_index = np.argmax(prediction)
        class_confidence = prediction[class_index]
        results.append({
            "index": class_index,
            "label": CLASS_LABELS[class_index],
            "confidence": class_confidence
        })

        results = sorted(results, key=lambda x: x['confidence'], reverse=True)[:num_results]
        return results

