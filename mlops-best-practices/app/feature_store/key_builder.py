from pydantic import HttpUrl


def prefixed_key(f):
    """
    A method decorator that prefixes return values.
    Prefixes any string that the decorated method `f` returns with the value of
    the `prefix` attribute on the owner object `self`.
    """

    def prefixed_method(*args, **kwargs):
        self = args[0]
        key = f(*args, **kwargs)
        return f"{self.prefix}:{key}"

    return prefixed_method


class Keys:
    def __init__(self, tweet_url: HttpUrl, last_update: int):
        self.prefix = self.generate_prefix(tweet_url)
        self.last_update = last_update

    @staticmethod
    def generate_prefix(tweet_url: HttpUrl):
        return

    @prefixed_key
    def cache_key(self) -> str:
        """A time series containing 30-second snapshots of BTC sentiment."""
        return "sentiment"
