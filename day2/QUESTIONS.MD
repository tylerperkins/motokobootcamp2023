# Questions 🙋

1. Who controls the ledger canister?

2. What is the subnet of the canister with the id: **mwrha-maaaa-aaaab-qabqq-cai**? How much nodes are running this subnet?

3. I have a neuron with 1O ICPs locked with a dissolve delay of 4 years - my neuron has been locked for 2 years. What is my expected voting power?

4. What is wrong with the following code?

```
actor {
  let n : Nat = 50;
  let t : Text = "Hello";

  public func convert_to_text(m : Nat) : async Text {
    Nat.toText(m);
  };

}
```

  - Need to have line `import Nat "mo:base/Nat"` at the beginning, since we're using `Nat.toText`

  - Should have `query` after `public`, since we're not modifying any shared state.

5. What is wrong with the following code?
```
actor {
  var languages : [var Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func show_languages(language : Text) : async [var Text] {
    return (languages);
  };

}
```

  - The initial array value should be `[var "English, ...]`.

  - A shared function can't return `[var Text]`, but must return immutable values. Could instead return `Array.freeze<Text>(languages);` of type `async [Text]`.

  - Should have `query` after `public`, since we're not modifying any shared state.

6. What is wrong with the following code?
```
actor {
  var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

  public func add_language(new_language: Text) : async [Text] {
    languages := Array.append<Text>(languages, [new_language]);
    return (languages);
  };

}
```

  - `Array.append` is depricated because it has linear complexity and returns a copy. Could use `Buffer.add` instead. Alternatively, prepend onto the front of a List instead using `List.push`, if you don't mind the resulting List being in reverse order.
