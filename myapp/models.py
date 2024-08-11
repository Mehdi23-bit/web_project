from django.db import models

# Create your models here.
class Produit(models.Model):
    nom=models.CharField(max_length=20)
    prix=models.DecimalField(max_digits=10,decimal_places=2)
    quantite=models.IntegerField()
    image=models.ImageField(default='NUll.png',blank=True,upload_to='photos/')
    def __str__(self):
        return self.nom
    