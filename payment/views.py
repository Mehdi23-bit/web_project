from django.shortcuts import render
from payment.forms import CustomPayPalPaymentsForm
from django.urls import reverse
from ll_project.settings import PAYPAL_RECEIVER_EMAIL
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from django.core.cache import cache 
from django.http import JsonResponse
from myapp.cart import Cart

def pay(request):
    paypal_dict = {
        "business": PAYPAL_RECEIVER_EMAIL,
        "amount": "50",
        "item_name": "item_names",
        "invoice": "unique-invoice-id",
        "notify_url": request.build_absolute_uri(reverse('paypal-ipn')),
        "return": request.build_absolute_uri(reverse('payment:return-view')),
        "cancel_return": request.build_absolute_uri(reverse('payment:cancel-view')),
        "custom":"primary",  # Custom command to correlate to some function later (optional)
    }
    print("myapp view")
    print(f"IPN URL: {paypal_dict['notify_url']}")
    # Create the instance.
    form = CustomPayPalPaymentsForm(initial=paypal_dict)
    context = {"form": form}
    return render(request,'payment.html',context)

@csrf_exempt
def return_view(request):
    return render(request,'success.html')

@csrf_exempt
def cancel_view(request):
    return render(request,'cancel.html')

@require_POST
def check_payment_status(request):
    user_id = request.user.id  
    payment_status = cache.get(f'payment_status_{user_id}', 'pending')  
    return JsonResponse({'status': payment_status})

def clear(request):
    cart=Cart(request)
    cart.clear()
    print("i am clearing the fucking cart ,yes i am clearing i am gone shut the fuck the fucking teacher ,shut the fuck up")   
    return JsonResponse({}, status=200)
    