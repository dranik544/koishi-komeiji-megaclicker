extends Control

var q = [
	{"question": "[pulse]Seen my subconscious?[/pulse] It ran away again!", "answers": ["Under my bed", "No", "It's talking now"]},
	
	{"question": "[shake]Was this in a dream?[/shake] Or real?", "answers": ["Dream", "Real", "Same thing", "Dunno"]},
	
	{"question": "[wave]Believe in invisible rabbits?[/wave]", "answers": ["Yes!", "No", "Maybe?", "Magic mushrooms?"]},
	
	{"question": "How are you?", "answers": ["Good", "Confused", "Great!", "Meh"]},
	
	{"question": "[tornado]Remember before here?[/tornado]", "answers": ["Yes", "No", "Why?", "Nope"]},
	
	{"question": "Cirno fell in snow. Funny?", "answers": ["Yes!", "Help her", "Ignore", "Film it"]},
	
	{"question": "Voices in my head argue about you.", "answers": ["I'm hungry", "They're wrong", "Continue", "Hi"]},
	
	{"question": "Thoughts as color?", "answers": ["Blue", "Red", "Rainbow", "Clear"]},
	
	{"question": "Talked to reflection?", "answers": ["Often", "No", "When drunk", "It's quiet"]},
	
	{"question": "[pulse]Yuyuko dreams of?[/pulse]", "answers": ["Mochi!", "Past", "Nothing", "Cats"]},
	
	{"question": "[shake]Magic trick?[/shake] I disappear!", "answers": ["Show!", "No", "Still here", "No magic"]},
	
	{"question": "Invisible friends in forest?", "answers": ["Yes", "No", "Tea please", "Scary"]},
	
	{"question": "Asked this already?", "answers": ["Yes", "No", "Whatever", "Deja vu"]},
	
	{"question": "Superpower?", "answers": ["Read minds", "Invisible", "None", "Both"]},
	
	{"question": "[wave]Marisa stole books?[/wave]", "answers": ["Yes", "Not surprised", "Typical", "Maybe not"]},
	
	{"question": "Reimu dreams of?", "answers": ["Peace", "Sake", "Alone", "Dunno"]},
	
	{"question": "[tornado]Fly on carp?[/tornado]", "answers": ["Yes!", "Scared", "Allergic", "You drive"]},
	
	{"question": "Why sky so blue?", "answers": ["Dunno", "Always blue", "Not always", "Magic"]},
	
	{"question": "Dreams taste like?", "answers": ["Sweet", "Salty", "Bitter", "Tasteless"]},
	
	{"question": "[shake]Being watched?[/shake]", "answers": ["Always", "No", "By you", "Stop!"]},
	
	{"question": "What Flan thinks?", "answers": ["Laughs", "Doesn't care", "Sleeping", "Watching"]},
	
	{"question": "We're someone's dream?", "answers": ["Yukari's", "God's", "Cat's", "No one's"]},
	
	{"question": "!<>?<><?><!@>?!>@<>!@<?>!@<><?>!@#12.,3,/@<>!#?!<#?@><>?#@!<?><<>@!<#>!@<#!><>?<#@!><@<?><#<>!<@>#<>@!<>#<>!?@<<#>@!<>#@!>?<#<@!?<>@<><>!<@!<#<!>@<#>!<>>", "answers": ["FDSFSDFSDFSD", "OIUOYUIIUYOYIU", "MVNBBNMBNMVB", "ZXZXCVZXCVXC", "3124324123"]},
	
	{"question": "Read minds?", "answers": ["Yes", "No", "Sometimes", "Can already"]},
	
	{"question": "[pulse]Red Mist incident real?[/pulse]", "answers": ["Yes", "Vaguely", "No", "Forget it"]},
	
	{"question": "[tornado]If I stop thinking...[/tornado] you vanish?", "answers": ["Stay!", "Not real", "Try", "No!"]},
	
	{"question": "[wave]World is a joke?[/wave]", "answers": ["Yes", "No", "Funny one", "Not funny"]},
]


func _ready() -> void:
	get_window().mouse_passthrough = false
	get_window().title = "hohoho lmao"
	get_window().unfocusable = true
	get_window().always_on_top = true
	
	if Global.settings["transparentbg"]:
		get_window().transparent_bg = true
		get_window().transparent = true
		get_tree().get_root().set_transparent_background(true)
	elif !Global.settings["transparentbg"]:
		get_window().transparent_bg = false
		get_window().transparent = false
		get_tree().get_root().set_transparent_background(true)
	
	$vbox/confirm.pressed.connect(confirm)
	
	makequestion()

func makequestion():
	var randomquestion = randi_range(0, q.size() - 1)
	$vbox/question.text = str(q[randomquestion]["question"])
	
	$vbox/answer.clear()
	for i in q[randomquestion]["answers"].size():
		$vbox/answer.add_item(str(q[randomquestion]["answers"][i]))

func confirm():
	get_window().queue_free()
