import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Char "mo:base/Char";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Trie "mo:base/Trie";

actor {

    /** 1. Write a function **average_array** that takes an array of integers and returns the average value of the elements in the array.

    N.B., the returned Int is `Float.trunc(real_avg)`, where `real_avg` is the Float average of Float.fromInt of each each Int in the array.
    ```
    average_array(array : [Int]) -> async Int.
    ```
    */
    public query func average_array(array : [Int]) : async Int {
        Array.foldLeft<Int, Int>(array, 0, Int.add) / array.size();
    };

    /** 2. **Character count**: Write a function that takes in a string and a character, and returns the number of occurrences of that character in the string.
    ```
    count_character(t : Text, c : Char) -> async Nat
    ```
    */
    public query func count_character(t : Text, c : Char) : async Nat {
        func isC(aChar : Char) : Bool { aChar == c };
        Iter.size<Char>(
            Iter.filter<Char>(t.chars(), isC),
        );
    };

    /** 3. Write a function **factorial** that takes a natural number n and returns the [factorial](https://www.britannica.com/science/factorial) of n.
    ```
    factorial(n : Nat) ->  async Nat
    ```
    */
    public query func factorial(n : Nat) : async Nat {
        if (n == 0) 1 else List.foldLeft(Iter.toList(Iter.range(1, n)), 1, Nat.mul);
    };

    /** 4.  Write a function **number_of_words** that takes a sentence and returns the number of words in the sentence.
    ```
    number_of_words(t : Text) -> async Nat
    ```
    N.B. This implementation separates words on non-alphanumeric characters, so "It's fancy-schmancy!" is considered four words.
    */
    public query func number_of_words(t : Text) : async Nat {
        List.size(
            Iter.toList(
                Text.tokens(
                    t,
                    #predicate(func(c) { Bool.lognot(Char.isAlphabetic(c)) }),
                ),
            ),
        );
    };

    /** 5. Write a function **find_duplicates** that takes an array of natural numbers and returns a new array containing all duplicate numbers. The order of the elements in the returned array should be the same as the order of the first occurrence in the input array.
    ```
    find_duplicates(a : [Nat]) -> async [Nat]
    ```
    */
    public query func find_duplicates(a : [Nat]) : async [Nat] {
        type FoldTrie = Trie.Trie<Nat, Bool>;
        type FoldDups = { dupTrie : FoldTrie; dupList : List.List<Nat> };

        func makeKey(n : Nat) : Trie.Key<Nat> {
            { hash = Nat32.fromNat(n); key = n };
        };

        func check(natsSoFar : FoldTrie, n : Nat) : FoldTrie {
            // The Trie requires we provide a Trie.Key of n, not just n.
            let nKey = makeKey(n);

            switch (Trie.find(natsSoFar, nKey, Nat.equal)) {
                case null {
                    // We've never seen this value of n, so record that it's been seen
                    // just once.
                    Trie.put(natsSoFar, nKey, Nat.equal, false).0;
                };
                case (?false) {
                    // We've seen n once before, so now we know that it's a duplicate.
                    // Push it onto the list so order is preserved, and record that we've
                    // seen it before.
                    Trie.put(natsSoFar, nKey, Nat.equal, true).0;
                };
                case (?true) {
                    // Found that n is a duplicate, but it's already been recorded, so
                    // just continue with no changes.
                    natsSoFar;
                };
            };
        };

        let natFreqs = Array.foldLeft(a, Trie.empty() : FoldTrie, check);

        func isDuplicate(n : Nat, freqs : FoldTrie) : Bool {
            Option.get(
                Trie.find(freqs, makeKey(n), Nat.equal),
                false,
            );
        };

        /** Traverse Array a once again and prepend the duplicates to a List in the same
             order as they appear in a. Since they are prepended, the List will be in reverse
             order, so we need to reverse the resulting Array.
         */
        Array.reverse(
            // Correct the order, since we prepended to a List.
            List.toArray(
                // An Array result is part of the requirements.
                Array.foldLeft(
                    a, // Scan a again.
                    { dupTrie = natFreqs; dupList = List.nil() }, // 1st FoldDups.
                    func(accum : FoldDups, n : Nat) : FoldDups {
                        // Reducing func.
                        if (isDuplicate(n, accum.dupTrie))({
                            dupTrie = Trie.remove(
                                accum.dupTrie,
                                makeKey(n),
                                Nat.equal,
                            ).0; // Don't record n again when we see it later in a.
                            dupList = List.push(n, accum.dupList); // Record n.
                        }) else accum;
                    },
                ).dupList,
            ),
        );
    };

    /** 6. Write a function **convert_to_binary** that takes a natural number n and returns a string representing the binary representation of n.
    ```
    convert_to_binary(n : Nat) -> async Text
    ```
    */

};
