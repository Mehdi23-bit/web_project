from django.shortcuts import render
import requests
from myapp.cart import Cart
 
def paypal_ipn(request):
   if request.method == 'POST':
       ipn_data=request.POST.copy()
       ipn_data.update({"cmd": "_notify-validate"})
       validation=requests.post("https://ipnpb.sandbox.paypal.com/cgi-bin/webscr", data=ipn_data)
       if validation.text == "VERIFIED":
          product_ids = ipn_data.get("custom").split(",")
          for id in product_ids:
              Cart(request).delete(id)
       else:
           print("it doesn't work")

def return_view(request):
    return render(request,'success.html')
def cancel_view(request):
    return render(request,'cancel.html')


