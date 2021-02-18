insertionSort :: Ord a => [a] -> [a]
insertionSort []       = []
insertionSort (x : xs) = insert x (insertionSort xs)
  where
    insert x [] = [x]
    insert x xs@(y : ys) | x < y     = x : xs
                         | otherwise = y : insert x xs
