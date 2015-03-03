;3D dice roller plugin
;;;Parameters;;;
;width: Width of canvas (default: 640)
;height: Height of canvas (default: 480)
;d4: The number of 4 sided dice[1-4] (default: 0)
;d6: The number of 6 sided dice[1-6] (default: 0)
;d8: The number of 8 sided dice[1-8] (default: 0)
;d10: The number of 10 sided dice[0-9] (default: 0)
;d12: The number of 12 sided dice[1-12][ (default: 0)
;d20: The number of 20 sided dice[1-20] (default: 0)
;d100: The number of 10 sided dice[00-90] (default: 0)
;constant: Correction constant (default: 0)
;duration: Waiting time to clear dice (default: 4000[ms])

[loadjs storage="dice/three.min.js"]
[loadjs storage="dice/cannon.min.js"]
[loadjs storage="dice/dice.js"]

[macro name="dice"]
[html]
<div class="center_field">
    <span id="formula"></span>
</div>
<div id="dice"></div>
<script type="text/javascript" defer="defer">
$('#dice').width('[emb exp=%width|640]').height('[emb exp=%height|480]');
$('.center_field').css({
    'position': 'absolute',
    'text-align': 'center',
    'height': '100%',
    'width': '100%'
});
$('#formula').css({
    'background-color': 'rgba(255, 255, 255, 0.6)',
    'color': 'rgba(21, 26, 26, 0.6)',
    'font-family': 'Trebuchet MS',
    'font-size': '32pt',
    'position': 'relative',
    'padding': '5px 15px',
    'top': '45%',
    'word-spacing': '0.5em'
});

var set = {d4: [emb exp=%d4|0],
           d6: [emb exp=%d6|0],
           d8: [emb exp=%d8|0],
           d10: [emb exp=%d10|0],
           d12: [emb exp=%d12|0],
           d20: [emb exp=%d20|0],
           d100: [emb exp=%d100|0]};
var constant = [emb exp=%constant|0];
</script>
[endhtml]

[iscript]
var d = new dice();
var box = new d.dice_box($('#dice').get(0));

function get_set_array(set) {
    var set_array = [];

    Object.keys(set).forEach(function(key) {
        var value = this[key];
        for (var i = 0; i < value; i++){
            set_array.push(key);
        }
    }, set);

    return set_array;
}

function before_roll(vectors) {
}

function after_roll(notation, result) {
    var res = result.join('+');
    if (notation.constant) {
        res += ' +' + notation.constant;
    }
    if (result.length > 1) {
        f.total = (result.reduce(function(s, a) { return s + a; }) + notation.constant);
        res += ' = ' + f.total;
    }

    $('#formula').html(res);
    f.formula = res;
}

box.roll({'set':get_set_array(set), 'constant':constant}, before_roll, after_roll);
[endscript]

[wait time=%duration|4000]
[cm]

[endmacro]