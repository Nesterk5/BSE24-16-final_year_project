import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqs = [
    FAQItem(
      question: 'What is the shelf life of inspected meat?',
      answer:
          'The shelf life depends on various factors including storage conditions and packaging. Generally, inspected meat can be stored for a certain number of days under proper refrigeration.',
    ),
    FAQItem(
      question: 'How is meat quality inspection conducted?',
      answer:
          'Meat quality inspection involves visual inspection, palpation, and sometimes laboratory testing to ensure meat safety and quality standards are met.',
    ),
    FAQItem(
      question: 'Who performs meat quality inspection?',
      answer:
          'Meat quality inspection is typically performed by trained inspectors and veterinarians who are responsible for ensuring compliance with health and safety regulations.',
    ),
    FAQItem(
      question: 'What are the benefits of meat quality inspection?',
      answer:
          'Meat quality inspection ensures that meat products are safe for consumption, meet regulatory standards, and maintain consumer confidence in food safety.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            // elevation: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

            child: ExpansionTile(
              title: Text(
                faqs[index].question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading:
                  const Icon(Icons.question_answer, color: AppColors.appGreen),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faqs[index].answer,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
