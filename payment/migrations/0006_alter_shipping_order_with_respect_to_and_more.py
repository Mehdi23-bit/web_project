# Generated by Django 4.2.6 on 2024-08-30 17:10

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('payment', '0005_alter_shipping_user'),
    ]

    operations = [
        migrations.AlterOrderWithRespectTo(
            name='shipping',
            order_with_respect_to=None,
        ),
        migrations.RemoveField(
            model_name='shipping',
            name='time',
        ),
    ]
