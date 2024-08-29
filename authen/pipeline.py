from .save_session import load_persistent_data
import logging

logger=logging.getLogger(__name__)

def load_user_persistent_data(strategy, user, *args, **kwargs):
    if user:
        request = strategy.request
        persistent_data = load_persistent_data(user)
        logger.info(f"Loaded persistent data in pipeline: {persistent_data}")
        request.session.update(persistent_data)
        logger.info(f"Session after update: {dict(request.session)}")
