# Generated by Django 4.2.6 on 2024-08-30 20:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authen', '0015_order'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='email',
            field=models.EmailField(blank=True, default=None, max_length=255, null=True),
        ),
    ]
