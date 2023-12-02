import Text "mo:base/Text";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

import Input "input";

import Itertools "mo:itertools/Iter";

import { char_to_digit } "../utils";

module {

    public func get_num(arr: [Char], i: Nat): (Nat, Nat) {
        var num = 0;
        var j = 0;

        while (Char.isDigit(arr[i + j])){
            num *= 10;
            num += char_to_digit(arr[i + j]);
            j += 1;
        };

        (num, j)
    };

    let colors = ["red", "green", "blue"];

    public func solution(): Nat {
        var total = 0;

        for (line_text in Text.split(Input.text2, #text"\n")){

            let line = Text.toArray(line_text);
            let (game_id, _) = get_num(line, 5);
            var text = "";

            var i = 6;
            var num = 0;

            var color_vals = [var 0, 0, 0];

            label while_loop
            while (i < line.size()){
                let (n, cnt) = get_num(line, i);

                if (cnt > 0){
                    num := n;
                    text := "";
                    i += cnt;
                    continue while_loop;    
                };

                text #= Char.toText(line[i]);

                let opt_index : ?Nat = Itertools.findIndex(
                    colors.vals(),
                    func(color : Text) : Bool = Text.contains(text, #text color),
                );

                switch(opt_index){
                    case (?index){
                        color_vals[index] := Nat.max(num, color_vals[index]);
                        text := "";
                        num := 0;
                    };
                    case (_){}
                };  

                i+=1;
            };

            let product = color_vals[0] * color_vals[1] * color_vals[2];
            total += product;

        };

        total;
    };
}