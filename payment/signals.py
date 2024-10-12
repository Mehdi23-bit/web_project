from django.dispatch import receiver
from paypal.standard.ipn.signals import valid_ipn_received, invalid_ipn_received
from authen.models import UserPersistentData, Order
from django.contrib.auth.models import User
from payment.models import Shipping
from myapp.models import Produit
import copy
from django.core.cache import cache

@receiver(valid_ipn_received)
def valid_ipn_received_handler(sender, **kwargs):
    ipn_obj = sender
    print("Valid IPN received")
    custom_parts = ipn_obj.custom.split(',')
    user_id = custom_parts[0] if custom_parts else None
    products_ids = [id.strip() for id in custom_parts[1:] if id.strip()]

     
    user = User.objects.get(pk=user_id)
    user_data = UserPersistentData.objects.get(user=user)
    data = user_data.data
    order_data = copy.deepcopy(data)
    shipping = Shipping.objects.get(user=user)
    order = Order.objects.create(user=user)
    order.shipping_info(shipping=shipping)

        
    for id in products_ids:
           
        product=Produit.objects.get(pk=id)
        order.products.add(product)
        
    order.data=order_data
    order.save()
               
            

        

    order.data = order_data
    order.save()

        # Clear the cart
        
    user_data.data = {}
           # Save the modified data back to UserPersistentData
    user_data.save()


    print("Order has been created and cart has been cleared")
    cache.set(f'payment_status_{user_id}', 'completed', timeout=3600)
    
@receiver(invalid_ipn_received)
def invalid_ipn_received_handler(sender, **kwargs):
    print("Invalid IPN received")
    print('bad ipn message')
    print('i am done')
    print("i won't give up")