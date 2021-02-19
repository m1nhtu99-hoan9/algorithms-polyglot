class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def insertSorted(self, head: ListNode, new_node: ListNode):
        """
            Sorted insertion for a new node into the linked list
        """
        current: ListNode = head

        # cases for new node to be prepended into the list
        if head is None or new_node.val <= head.val:
            new_node.next = head
            return new_node
        else:
            # locate the node before insertion
            while current.next is not None and current.next.val < new_node.val:
                current = current.next
                
            # except:
            #     print(str(head))
            #     print(str(current))

            # insert `new_node` in between `cur_ref` and `cur_ref.next`
            new_node.next, current.next = current.next, new_node

            return head

    def insertionSortList(self, head: ListNode) -> ListNode:
        sorted_head: ListNode = None
        cur_ref: ListNode = head

        if head is None:
            return None
        elif head.next is None:
            return head
        else:
            while cur_ref is not None:
                cadr_ref = cur_ref.next
                
                # `insertSorted` will modify `cur_ref` reference
                sorted_head = self.insertSorted(sorted_head, cur_ref)

                cur_ref = cadr_ref

            return sorted_head

