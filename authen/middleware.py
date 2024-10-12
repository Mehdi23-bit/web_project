# myapp/middleware.py

import logging
from  .save_session import *

class RequestLoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # This code is executed for each request before the view (and later middleware) are called.
        logging.info(f"Request Method: {request.method}, Path: {request.path}")
        print('i am refreshing midlleware')
        if not request.user.is_anonymous:
          request.session['session_key'] = load_persistent_data(request.user)
        # Call the next middleware or the view
        response = self.get_response(request)
        
        return response

        # This code is executed for each request/response after the view is called.
        
# myapp/middleware.py
import threading

_thread_locals = threading.local()

class RequestMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        _thread_locals.request = request
        response = self.get_response(request)
        return response

    @staticmethod
    def get_request():
        return getattr(_thread_locals, 'request', None)

from myapp.cart import Cart

class PersistentCartMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if request.user.is_authenticated:
            print("Updating session with persistent data")
            session_data = load_persistent_data(request.user)
            print(request.session)
        response = self.get_response(request)
        return response
