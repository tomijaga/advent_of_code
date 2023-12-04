import Text "mo:base/Text";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Set "mo:map/Set";

import Input "input";

import Itertools "mo:itertools/Iter";

import { char_to_digit; get_num } "../utils";

module {

    let { nhash } = Set;

    public func solution(): Nat {
        var total = 0;

        for (line_text in Text.split(Input.text1, #text"\n")){
            
            let set = Set.new<Nat>();
            let line = Text.toArray(line_text);
            var points = 0;
            let (card_num, _) = get_num(line, 5);

            var i = 8;
            var num = 0;
            var before_seperator = true;

            label while_loop
            while (i < line.size()){
                if (line[i] == '|'){
                    before_seperator := false;
                    i += 1;
                    continue while_loop;
                };

                let (n, cnt) = get_num(line, i);

                if (cnt == 0) { i += 1; continue while_loop; };

                if (before_seperator) {
                    ignore Set.put(set, nhash, n);
                } else {
                    if (Set.has(set, nhash, n)){
                        if (points == 0){
                            points := 1;
                        } else {
                            points *= 2;
                        };
                        ignore Set.remove(set, nhash, n);
                    };
                };

                i += cnt;
            };

            total += points;
        };

        total;
    };
}