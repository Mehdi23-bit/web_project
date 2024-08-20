from django.db import models
from django.contrib.auth.models import User

class Shipping(models.Model):
   user=models.OneToOneField(User,on_delete=models.CASCADE,related_name='shipping_address',unique=True)
   first_name=models.CharField(max_length=20)
   last_name=models.CharField(max_length=20)
   email=models.EmailField(max_length=255,null=False,blank=False,default=None)
   adresse1=models.CharField(max_length=255)
   adresse2=models.CharField(max_length=255)
   country=models.CharField(max_length=255)
   city=models.CharField(max_length=255)
   province=models.CharField(max_length=255)
   zipcode=models.CharField(max_length=255,null=True,blank=True)
   time=models.DateTimeField(auto_now_add=True)

   class Meta:
      order_with_respect_to='time'
      
   def __str__(self) -> str:
      return 'shipping : '+str(self.id)