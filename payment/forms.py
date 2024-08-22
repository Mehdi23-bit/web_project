from django import forms
from .models import Shipping
from paypal.standard.forms import PayPalPaymentsForm
from paypal.standard.widgets import ValueHiddenInput
from django.utils.html import format_html

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
    


class CustomPayPalPaymentsForm(PayPalPaymentsForm):
    def __init__(self, button_type="donate", *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.button_type = button_type
        if "initial" in kwargs:
            kwargs["initial"] = self._fix_deprecated_return_url(kwargs["initial"])
            # Dynamically create, so we can support everything PayPal does.
            for k, v in kwargs["initial"].items():
                if k not in self.base_fields:
                    self.fields[k] = forms.CharField(label=k, widget=ValueHiddenInput(), initial=v)

    def get_html_submit_element(self):
       return format_html(
            """<input type="image" src="{0}" name="submit" alt="Buy it Now" />""",
            self.get_image(),
        )