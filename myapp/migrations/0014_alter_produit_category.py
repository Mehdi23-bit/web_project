# Generated by Django 4.2.6 on 2024-08-25 16:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0013_alter_produit_category'),
    ]

    operations = [
        migrations.AlterField(
            model_name='produit',
            name='category',
            field=models.CharField(choices=[('chair', 'chair'), ('shelving', 'shelving'), ('table', 'table'), ('sofa', 'sofa')], default=None, max_length=20),
        ),
    ]
