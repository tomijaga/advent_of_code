import Text "mo:base/Text";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Set "mo:map/Set";
import Map "mo:map/Map";

import Input "input";

import Itertools "mo:itertools/Iter";

import { char_to_digit; get_num; text_lines } "../utils";

module {

    let { nhash } = Set;

    func inc_by(n: Nat): (Nat, ?Nat)-> ?Nat = func (_: Nat, prev: ?Nat): ?Nat {
        let updated = switch(prev){
            case (?x) x + n;
            case (_) n;
        };

        ?updated
    };

    public func solution(): Nat {
        var total = 0;
        let clones = Map.new<Nat, Nat>();

        for (line_text in text_lines(Input.text2)){
            
            let set = Set.new<Nat>();
            let line = Text.toArray(line_text);
            var matches = 0;

            var i = 5;
            
            while (line[i] == ' '){
                i += 1;
            };

            let (card_num, cnt) = get_num(line, i);
            ignore Map.update(clones, nhash, card_num, inc_by(1));

            i += cnt;
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
                        matches += 1;
                        ignore Set.remove(set, nhash, n);
                    };
                };

                i += cnt;
            };

            let ?card_cnt = Map.remove(clones, nhash, card_num) else Debug.trap("card not found");
            // Debug.print("card_num: " # debug_show card_num # ", card_cnt " # debug_show card_cnt # ", matches " # debug_show matches);
            
            for (card in Iter.range(card_num + 1, card_num + matches)){
                // Debug.print("updating card: " # debug_show card);
                let prev =  Map.update(clones, nhash, card, inc_by(card_cnt));
            };

            total += card_cnt;
        };
        
        total;
    };
}