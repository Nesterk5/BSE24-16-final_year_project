# -*- coding: utf-8 -*-
{
    'name': "Meat Quality Inspection",

    'summary': """
            Meat quality inspection
    """,

    'description': """
        Meat quality inspection
    """,
    "license": "LGPL-3",
    'author': "Kola Technologies LTD",
    'website': "https://kolapro.com",
    'category': "Human Resources",
    'version': '0.1',
    'depends': [
        'base',
    ],

    'data': [
        'security/ir.model.access.csv',
        'data/sequence.xml',

        'views/meat_inspection_views.xml',
       
    ],
   
}

