from django.db import models

# Create your models here.
class Produit(models.Model):
    categories={
        ('chair','chair'),
        ('table','table'),
        ('sofa','sofa'),
        ('shelving','shelving')
    }
    nom=models.CharField(max_length=20)
    prix=models.DecimalField(max_digits=10,decimal_places=2)
    quantite=models.IntegerField()
    image=models.ImageField(default='NUll.png',blank=True,upload_to='photos/')
    category=models.CharField(max_length=20,default=None,choices=categories)
    def __str__(self):
        return self.nom
    