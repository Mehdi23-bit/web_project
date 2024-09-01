from django.contrib.auth.models import User
from django.db import models
from myapp.models import Produit
from payment.models import * 
 
class Profile(models.Model):
    user =models.OneToOneField(User,null=True,on_delete=models.CASCADE)
    Produits=models.ManyToManyField(Produit,blank=True)
    def _str__(self):
        return self.user.username
    
class UserPersistentData(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    data = models.JSONField(default=dict)


class Order(models.Model):
   user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders')
   products = models.ManyToManyField(Produit, related_name='orders')
   data = models.JSONField(default=dict)
   email=models.EmailField(max_length=255,null=True,blank=True,default=None)
   adresse1=models.CharField(max_length=255)
   adresse2=models.CharField(max_length=255)
   country=models.CharField(max_length=255)
   city=models.CharField(max_length=255)
   province=models.CharField(max_length=255)
   zipcode=models.CharField(max_length=255,null=True,blank=True)
   time=models.DateTimeField(auto_now_add=True)


   class Meta:
      order_with_respect_to='time'

   def shipping_info(self,shipping):
       self.email=shipping.email
       self.adresse1=shipping.adresse1
       self.adresse2=shipping.adresse2
       self.country=shipping.country
       self.city=shipping.city
       self.province=shipping.province
       self.zipcode=shipping.zipcode
       
