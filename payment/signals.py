from django.dispatch import receiver
from paypal.standard.ipn.signals import valid_ipn_received, invalid_ipn_received
from myapp.cart import Cart
from authen.middleware import RequestMiddleware
print("Signals module loaded")

@receiver(valid_ipn_received)
def valid_ipn_received_handler(sender, **kwargs):
    ipn_obj=sender
    print("Valid IPN received")
    products_ids=ipn_obj.custom.split(',')
    print('begin deleting')
    request = RequestMiddleware.get_request()
    for id in products_ids:
      Cart(request).delete(id)
    print('end deleting')

@receiver(invalid_ipn_received)
def invalid_ipn_received_handler(sender, **kwargs):
    print("Invalid IPN received")
    print('bad ipn message')
    print('i am done')
    print("i won't give up")