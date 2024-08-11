from django.contrib.auth.models import User
from django.db import models
from myapp.models import Produit

 
class Profile(models.Model):
    user =models.OneToOneField(User,null=True,on_delete=models.CASCADE)
    Produits=models.ManyToManyField(Produit,blank=True)
    def _str__(self):
        return self.user.username
    