# myapp/middleware.py

import logging
from  .save_session import *

class RequestLoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # This code is executed for each request before the view (and later middleware) are called.
        logging.info(f"Request Method: {request.method}, Path: {request.path}")
        print('i am in middleware')
        request.session['session_key'] = load_persistent_data(request.user)
        # Call the next middleware or the view
        response = self.get_response(request)

        # This code is executed for each request/response after the view is called.
        return response
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
