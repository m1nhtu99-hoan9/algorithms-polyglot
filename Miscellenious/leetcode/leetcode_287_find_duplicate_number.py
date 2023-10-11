from typing import List

"""
287. Find Duplicate Number (Medium)

53 / 53 test cases passed.
Runtime: 64 ms (beats 76.99 % of python3 submissions)
Memory Usage: 17 MB (beats 26.87 % of python3 submissions)
"""

def findDuplicate(nums: List[int]) -> int:
    cache = {}
    
    for x in nums:
        if cache.get(x) is None:
            cache[x] = True
        else: 
            return x