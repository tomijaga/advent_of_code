import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";

import Input "input";
import { char_to_digit } "../utils";

module {
    public func solution(): Nat {
        var total = 0;
        for (line in Text.split(Input.text1, #text "\n")){
            let array: [Char] = Iter.toArray(line.chars());

            var n = 0;

            label _loop_1
            for (i in Iter.range(0, array.size() - 1)){
                let char = array[i];

                if (Char.isDigit(char)){
                    n := char_to_digit(char);
                    break _loop_1;
                };
            };

            label _loop_2
            for (i in Iter.range(0, array.size() - 1)){
                let j = array.size() - 1 - i : Nat;
                let char = array[j];

                if (Char.isDigit(char)){
                    n := (n * 10) + char_to_digit(char);
                    break _loop_2;
                };
            };

            total += n;
        };

        return total;
    };
}