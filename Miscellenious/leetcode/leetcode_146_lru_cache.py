from collections import OrderedDict

"""
146. LRU Cache (Medium)

20 / 20 test cases passed.
Runtime: 192 ms (beats 68.58 % of python3 submissions)
Memory Usage: 23.8 MB (beats 44.01 % of python3 submissions)
"""

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)

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
        
class LRUCache:
    def __init__(self, capacity: int):
        self._cacheDict = LRUDict(capacity=capacity)

    def get(self, key: int) -> int:
        val: int = self._cacheDict[key]
        return val if val is not None else -1
        
    def put(self, key: int, value: int) -> None:
        self._cacheDict[key] = value