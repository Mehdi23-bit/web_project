from django import forms
from .models import Shipping

class ShippingForm(forms.ModelForm):
    class Meta:
        model=Shipping
        fields=['first_name','last_name','email','adresse1','adresse2','country','city','province','zipcode']
    def save(self, user, commit=True):
        shipping_address = self.instance
        shipping_address.user = user
        
        if commit:
            shipping_address.save()
        return shipping_address