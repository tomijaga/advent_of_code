import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";

module {

    public func char_to_digit(char: Char): Nat {
        Nat32.toNat(Char.toNat32(char) - Char.toNat32('0'));
    };
}