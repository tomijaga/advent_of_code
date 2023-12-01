import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Buffer "mo:base/Buffer";

import Itertools "mo:itertools/Iter";

import Input "input";
import { char_to_digit } "../utils";

module {
    public func solution() : Nat {
        // The index of the number in the array is equal to the number itself
        let numbers : [Text] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

        var total = 0;

        for (line in Text.split(Input.text2, #text "\n")) {
            let array : [Char] = Iter.toArray(line.chars());

            var n = 0;
            var text = "";

            label left_iterator for (i in Iter.range(0, array.size() - 1)) {
                let char = array[i];
                text #= Char.toText(char);

                let opt_index : ?Nat = Itertools.findIndex(
                    numbers.vals(),
                    func(num : Text) : Bool = Text.contains(text, #text num),
                );

                switch (opt_index) {
                    case (?index) {
                        n := index;
                        break left_iterator;
                    };
                    case (_) {};
                };

                if (Char.isDigit(char)) {
                    n := char_to_digit(char);
                    break left_iterator;
                };

            };

            // reset text
            text := "";

            label right_iterator for (i in Iter.range(0, array.size() - 1)) {
                let j = array.size() - 1 - i : Nat;
                let char = array[j];
                text := Char.toText(char) # text;

                let opt_index : ?Nat = Itertools.findIndex(
                    numbers.vals(),
                    func(num : Text) : Bool = Text.contains(text, #text num),
                );

                switch (opt_index) {
                    case (?index) {
                        n := (n * 10) + index;
                        break right_iterator;
                    };
                    case (_) {};
                };

                if (Char.isDigit(char)) {
                    n := (n * 10) + char_to_digit(char);
                    break right_iterator;
                };
            };

            total += n;
        };

        total;
    };
};
