from typing import Optional, List

"""
414. Third Maximum Number
Find the third largest number in a given list

Example 1:
    Input: nums = [3,2,1]
    Output: 1
    Explanation: The third maximum is 1.

Example 2:
    Input: nums = [1,2]
    Output: 2
    Explanation: The third maximum does not exist, so the maximum (2) is returned instead.

Example 3:
    Input: nums = [2,2,3,1]
    Output: 1
    Explanation: Note that the third maximum here means the third maximum distinct number.
        Both numbers with value 2 are both considered as second maximum.


27 / 27 test cases passed.
Runtime: 52 ms (beats 72.50 % of python3 submissions)
Memory Usage: 14.9 MB (beats 99.68 % of python3 submissions)
"""

class Solution:
    def thirdMax(self, nums: List[int]) -> int:
        LEN_NUMS = len(nums)
        def compare(x: Optional[int], y: Optional[int]) -> int:
            if x is None:
                return 0 if y is None else -1
            if y is None:
                return 1
            return -1 if x < y else (0 if x == y else 1)
                                
        if not nums: 
            return None
        elif LEN_NUMS < 3:
            return max(nums)
        else:   
            max_fst, max_snd, max_thd = None, None, None
        
            for num in nums:
                if compare(max_thd, num) == -1 and compare(max_snd, num) == 1:
                    max_thd = num
                elif compare(max_snd, num) == -1 and compare(max_fst, num) == 1:
                    max_thd, max_snd = max_snd, num
                elif compare(max_fst, num) == -1:
                    max_thd, max_snd, max_fst = max_snd, max_fst, num
            
            # edge cases: among 3 max variables, there are only 2 distinct values
            return max_fst if max_thd is None else max_thd