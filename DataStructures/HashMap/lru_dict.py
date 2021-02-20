from collections import OrderedDict

"""
In production, `lru_cache` from `functools` should be preferred.
"""

class LRUDict(OrderedDict):
    def __init__(self, capacity: int, *args, **kwargs):
        self.capacity = capacity
        super().__init__(*args, **kwargs)
    
    def __getitem__(self, key):
        try:
            val = super().__getitem__(key)
            # move this key to the last position so that this key becomes the most recently used one
            self.move_to_end(key)
            
            return val
        except KeyError:
            return None

    def __setitem__(self, key, value):
        if key in self:
            # update so that this key becomes the most recently used one
            self.move_to_end(key)
        super().__setitem__(key, value)

        if len(self) > self.capacity:
            least_used_key = next(iter(self))
            del self[least_used_key]