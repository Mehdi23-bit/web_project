from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Produit(models.Model):
    categories={
        ('Man','Man'),
        ('Women','Women'),
        ('Kid','Kid'),
            }
    nom=models.CharField(max_length=20)
    prix=models.DecimalField(max_digits=10,decimal_places=2)
    quantite=models.IntegerField()
    image=models.ImageField(default='NUll.png',blank=True,upload_to='photos/')
    description=models.TextField(default=None)
    category=models.CharField(max_length=20,default=None,choices=categories)
    def __str__(self):
        return self.nom

    