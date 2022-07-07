def prefixed_key(f):
    """
    A method decorator that prefixes return values.
    Prefixes any string that the decorated method `f` returns with the value of
    the `prefix` attribute on the owner object `self`.
    """

    def prefixed_method(*args, **kwargs):
        self = args[0]
        key = f(*args, **kwargs)
        return f'{self.prefix}:{key}'

    return prefixed_method


class Keys:
    """Methods to generate key names for Redis data structures."""

    def __init__(self, tweet_url: str, last_update: int):
        self.tweet_url = tweet_url
        self.last_update = int
        self.prefix = self.generate_prefix()

    @staticmethod
    def generate_prefix():
        return 

    @prefixed_key
    def sentiment_key(self) -> str:
        """A time series containing 30-second snapshots of BTC sentiment."""
        return f'sentiment:mean:30s'