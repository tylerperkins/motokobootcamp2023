import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Char "mo:base/Char";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import TrieSet "mo:base/TrieSet";

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
        let aSet = TrieSet.fromArray(a, Nat32.fromNat, Nat.equal)

    };

    /** 6. Write a function **convert_to_binary** that takes a natural number n and returns a string representing the binary representation of n.
    ```
    convert_to_binary(n : Nat) -> async Text
    ```
    */

};
