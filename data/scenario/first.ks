@wait time=1
[title name="Mythos"]

[call target=*start storage="tyrano.ks"]
[call storage="dice/dice.ks"]

;メッセージウィンドウを非表示にする
@layopt layer=message0 page=fore visible=false
@layopt layer=message0 page=back visible=false

;背景の表示
[back storage="room.jpg" ]

[ptext name="chara_name_area" layer=message0 width="200" color=white x=40 y=300 size=26]

;メッセージエリアを下部に持ってきて、フレーム画像の設定
[position height=200 top=280]
[position layer=message0 page=fore top=280 left=30 width=580 height=170 margint="50" marginl="30" marginr="40" marginb="30"]
[cm]

;レイヤの表示
@layopt layer=message0 visible=true

[chara_config ptext="chara_name_area"]

[chara_new name="yuko" storage="normal.png" jname="ゆうこ"]
[chara_new name="haruko" storage="haruko.png" jname="はるこ"]

[dice d12=1 d8=1]
[s]

[iscript]
TG.kag.ftag.array_tag = "";

tag_stack = [];

function popTagStack(){
    if (TG.kag.ftag.array_tag.length <= TG.kag.ftag.current_order_index && 0 < tag_stack.length) {
        TG.kag.stat.is_script = false;
        TG.kag.ftag.array_tag = tag_stack;
        tag_stack = [];

        TG.kag.ftag.nextOrderWithLabel("");
    }
}

Tracker.autorun(function(){
    try {
        latest = Messages.find({}, {'sort': {'createdAt': -1}}).fetch()[0];

        if(latest){
            var commands = mythos.executeCommand(latest);
            var result = TG.kag.parser.parseScenario(commands);
            tag_stack = tag_stack.concat(result.array_s);

            popTagStack();

        }
    } catch (e) {
        console.log(e);
    }
});

$("#tyrano_base").click(function(){
    popTagStack();
});
[endscript]

[s]