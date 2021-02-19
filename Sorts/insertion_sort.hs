insertionSort :: Ord a => [a] -> [a]
insertionSort []       = []
insertionSort (x : xs) = insert x (insertionSort xs)
  where
    -- a naive implementation for sorted insertion
    -- for production, please use @Data.List (insert)@
    insert x [] = [x]
    insert x xs@(y : ys) | x < y     = x : xs
                         | otherwise = y : insert x ys
