# Generated by Django 4.1.13 on 2024-07-17 13:51

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('authen', '0006_somemodel'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='produits',
        ),
        migrations.DeleteModel(
            name='SomeModel',
        ),
    ]
