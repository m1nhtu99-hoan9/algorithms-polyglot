-- | FizzBuzz solution implementing SKIP-HALT-PRINT pattern
-- | References: "FizzBuzz in Haskell by Embedding a Domain-Specific Language" by Maciej Pirog
-- |             https://themonadreader.files.wordpress.com/2014/04/fizzbuzz.pdf
fizzbuzz :: Integer -> String
fizzbuzz n = (fizz . buzz) id (show n)
  where
    fizz | n `mod` 3 == 0 = \f -> const ("fizz" <> f "")
         | otherwise      = id
    buzz | n `mod` 5 == 0 = \f -> const ("buzz" <> f "")
         | otherwise      = id