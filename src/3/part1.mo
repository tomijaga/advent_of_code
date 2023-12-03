import Text "mo:base/Text";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Int "mo:base/Int";
import Input "input";
import Set "mo:map/Set";

import Itertools "mo:itertools/Iter";

import { char_to_digit } "../utils";
import Part1 "../1/part1";

module {

    let { nhash } = Set;

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

    public func find_start(arr: [[Char]], i: Nat, j: Nat) : Nat {
        var y = 0;

        if (j == y){
            return 0;
        };

        while (j > y and Char.isDigit(arr[i][j - y])){
            y += 1;

            if (j == y and Char.isDigit(arr[i][0])){
                return 0;
            };
        };

        j - (y - 1) 
    };

    public func hash(x: Nat, y: Nat): Nat {
        x * 1000 + y
    };

    public func get_coords(hash: Nat): (Nat, Nat) {
        (hash / 1000, hash % 1000)
    };

    public func solution(): Nat {
        var total = 0;

        let mapped = Iter.map(
            Text.split(Input.text1, #text "\n"),
            func(text: Text): [Char] = Text.toArray(text)
        );

        let set = Set.new<Nat>();

        let matrix = Iter.toArray(mapped);

        for (i in Iter.range(0, matrix.size() - 1)){
            for (j in Iter.range(0, matrix[i].size() - 1)){
                let c = matrix[i][j];

                let int_i : Int = i;
                let int_j : Int = j;

                if (not Char.isDigit(c) and not Char.isAlphabetic(c) and c != '.'){
                    // Debug.print(" symbol " # debug_show c);
                    let adjacents = [
                        (int_i, int_j + 1), (int_i, int_j - 1),
                        (int_i + 1, int_j), (int_i - 1, int_j),
                        (int_i + 1, int_j + 1), (int_i - 1, int_j - 1),
                        (int_i + 1, int_j - 1), (int_i - 1, int_j + 1),
                    ];
                    
                    for ((_x, _y) in adjacents.vals()){
                        let y = Int.abs(_y);
                        let x = Int.abs(_x);

                        if (_x >= 0 and _y >= 0 and x < matrix.size() and y < matrix[x].size()){
                            let c2 = matrix[x][y];
                            if (Char.isDigit(c2) ){
                                let y2 = find_start(matrix, x, y);
                                // Debug.print("c2 = " # debug_show c2);
                                // Debug.print("(x, y) = " # debug_show (x, y));
                                // Debug.print("y2 = " # debug_show y2);

                                if (not Set.has(set, nhash, hash(x, y2))){
                                    let (num, j2) = get_num(matrix[x], y2);
                                    // Debug.print(debug_show num );

                                    ignore Set.put<Nat>(set, nhash, hash(x, y2));
                                    total += num;
                                };
                            };
                        };
                    }
                };
            }
        };

        total;
    };
}