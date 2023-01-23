import Array "mo:base/Array";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor {

    /** 1. In your file called `utils.mo`: create a function called `second_maximum` that takes an array [Int] of integers and returns the second largest number in the array.
    ```
    second_maximum(array : [Int]) ->  Int;
    ```

    Function `second_maximum_short`, implemented below, is simple and easy to understand, but is only suitable for a small input array. Since it uses Array.sort, it is O(n*log(n)). The version `second_maximum`, however, does just one pass over the array, so is O(n).
    */
    public func second_maximum(array : [Int]) : async Int {
        type Top2 = { biggest : Int; secondBiggest : Int; init2nd : Bool };

        func is2ndBiggestSoFar(x : Int, t2 : Top2) : Bool {
            x != t2.biggest and (t2.init2nd or x > t2.secondBiggest)
        };

        Array.foldLeft(
            array,
            { biggest = array[0]; secondBiggest = array[0]; init2nd = true },
            func(top2 : Top2, this : Int) : Top2 {
                if (this > top2.biggest)({
                    biggest = this;
                    secondBiggest = top2.biggest;
                    init2nd = false;
                }) else if (is2ndBiggestSoFar(this, top2))({
                    top2 with secondBiggest = this;
                    init2nd = false;
                }) else top2;
            },
        ).secondBiggest;
    };

    /** Function `second_maximum_short`, implemented below, is simple and easy to understand, but is only suitable for a small input array. Since it uses Array.sort, it is O(n*log(n)). However, the version `second_maximum`, above, does just one pass over the array, so is O(n).
    */
    public func second_maximum_short(array : [Int]) : async Int {
        if (array.size() == 1) array[0] else {
            Array.sort(array, Int.compare)[array.size() - 2];
        };
    };

    /** 2. In your file called `utils.mo`: create a function called `remove_even` that takes an array [Nat] and returns a new array with only the odd numbers from the original array.
    ```
    remove_event(array : [Nat]) -> [Nat];
    ```
    */
    public func remove_even(array : [Nat]) : async [Nat] {
        Array.filter<Nat>(array, func(n) { Nat.rem(n, 2) != 0 });
    };

    /** 3. In your file called `utils.mo`:  write a function `drop` <T> that takes 2 parameters: an array [T] and a **Nat** n. This function will drop the n first elements of the array and returns the remainder.
    > ⛔️ Do not use a loop.
    ```
    drop<T> : (xs : [T], n : Nat) -> [T]
    ```
    */
    func drop<T>(array : [T], n : Nat) : [T] {
        List.toArray(List.drop(List.fromArray(array), n));
    };

    /** Here's a different implementation that employs mapEntries and mapFilter.
    */
    func drop_basic<T>(array : [T], n : Nat) : [T] {
        Array.mapFilter<(T, Nat), T>(
            Array.mapEntries<T, (T, Nat)>(
                array,
                func(t, i) { (t, i) },
            ),
            func((t : T, i : Nat)) { if (i < n) null else ?t },
        );
    };
};
