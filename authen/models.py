from django.contrib.auth.models import User
from django.db import models
from myapp.models import Produit

 
class Profile(models.Model):
    user =models.OneToOneField(User,null=True,on_delete=models.CASCADE)
    Produits=models.ManyToManyField(Produit,blank=True)
    def _str__(self):
        return self.user.username
    
class UserPersistentData(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    data = models.JSONField(default=dict)

    def __str__(self):
        return f"Persistent data for {self.user.username}"
    