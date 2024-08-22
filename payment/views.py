from django.urls import reverse
from django.shortcuts import render
from paypal.standard.forms import PayPalPaymentsForm
from .forms import CustomPayPalPaymentsForm

def pay(request):

    # What you want the button to do.
    paypal_dict = {
        "business": "e.iskander4297@uca.ac.ma",
        "amount": "50.00",
        "item_name": "name of the item",
        "invoice": "unique-invoice-id",
        "notify_url": request.build_absolute_uri(reverse('payment:paypal-ipn')),
        "return": request.build_absolute_uri(reverse('payment:return-view')),
        "cancel_return": request.build_absolute_uri(reverse('payment:cancel-view')),
        "custom": "premium_plan",  # Custom command to correlate to some function later (optional)
    }

    # Create the instance.
    form = CustomPayPalPaymentsForm(initial=paypal_dict)
    context = {"form": form}
    return render(request, "payment.html", context)

def paypal_ipn(request):
    pass
def return_view(request):
    return render(request,'success.html')
def cancel_view(request):
    return render(request,'cancel.html')