from django.dispatch import receiver
from paypal.standard.ipn.signals import valid_ipn_received, invalid_ipn_received
from authen.models import UserPersistentData ,Order
from django.contrib.auth.models import User
from payment.models import Shipping
from myapp.models import Produit
import copy


@receiver(valid_ipn_received)
def valid_ipn_received_handler(sender, **kwargs):
    ipn_obj=sender
    print("Valid IPN received")
    user_id, *products_ids = ipn_obj.custom.split(',')
    print(user_id)
    user=User.objects.get(pk=user_id)
    user_data=UserPersistentData.objects.get(user=user)
    data=user_data.data
    order_data = copy.deepcopy(user_data.data)
    for id in products_ids:
        if id in data:
            del data[id]

    user_data.data=data
    user_data.save()
    shipping=Shipping.objects.get(user=user)
    order=Order.objects.create(user=user)
    order.shipping_info(shipping=shipping)
    for id in products_ids:
        product=Produit.objects.get(pk=id)
        order.products.add(product)
    order.data=order_data
    order.save()
    print("order has been  created")
   

@receiver(invalid_ipn_received)
def invalid_ipn_received_handler(sender, **kwargs):
    print("Invalid IPN received")
    print('bad ipn message')
    print('i am done')
    print("i won't give up")