import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Nat32 "mo:base/Nat32";

module {

    public func char_to_digit(char: Char): Nat {
        Nat32.toNat(Char.toNat32(char) - Char.toNat32('0'));
    };

    public func get_num(arr: [Char], i: Nat): (Nat, Nat) {
        var num = 0;
        var j = 0;

        while (i + j < arr.size() and Char.isDigit(arr[i + j])){
            num *= 10;
            num += char_to_digit(arr[i + j]);
            j += 1;
        };

        (num, j)
    };

    public func text_lines(text: Text): Iter.Iter<Text> = Text.split(text, #text"\n");
}