# Generated by Django 4.1.13 on 2024-07-17 15:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0002_produit_matricule'),
        ('authen', '0009_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='Produits',
            field=models.ManyToManyField(null=True, to='myapp.produit'),
        ),
    ]
