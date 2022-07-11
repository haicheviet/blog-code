import os

LOGGER_DIR = os.getenv("LOGGER_DIR", "logs")
level_log = "DEBUG"
format_log = (
    "%(asctime)s [%(threadName)-12.12s] "
    "[%(levelname)-5.5s] "
    "%(filename)s:%(funcName)s:%(lineno)d: %(message)s"
)


DEFAULT_LOGGER = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {"standard": {"format": format_log}},
    "handlers": {
        "api": {
            "level": "INFO",
            "class": "logging.StreamHandler",
            "formatter": "standard",
        },
    },
    "loggers": {
        "app.main": {"handlers": ["api"], "level": level_log},
    },
}
