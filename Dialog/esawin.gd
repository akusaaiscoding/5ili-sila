extends Control

var dialog = [
	{"name": "Garu", "text": "Hah… that was exhausting… But you’re back! See?", "emotion": "tir"},
	{"name": "Esa", "text": "Oh dear… I must have been overreacting so much, I was so overstimulated I could barely tell what was happening anymore…", "emotion": "erel"},
	{"name": "Esa", "text": "Thank you for bringing me back, and all of the other Silas, Garu. We are truly indebted to you.", "emotion": "erel"},
	{"name": "Garu", "text": "Hehe, all good, I’m just doing my job! Hero stuff! And uh… Do you know where that Koru guy is?", "emotion": "norm"},
	{"name": "Esa", "text": "Oh. Him. Well, once you’re ready to face him, I’ll call him over here.", "emotion": "eups"},
	{"name": "Garu", "text": "Wait… you can just do that?", "emotion": "sup"},
	{"name": "Esa", "text": "Yes. I was used as his main pawn, as his puppet. Therefore, I had the closest connection to him.", "emotion": "eups"},
	{"name": "Esa", "text": "You need to be careful… Koru still has access to all our powers, he can do that and maybe even worse.", "emotion": "enor"},
	{"name": "Esa", "text": "I’ll make sure to keep him trapped here so he won’t escape.", "emotion": "ehap"},
	{"name": "Garu", "text": "*Gulps* Ah… you think I can do it, Esa?", "emotion": "sad"},
	{"name": "Esa", "text": "Well, I don’t think you can. I know you can. You have the support of everyone else, it’s all up to your own courage and tenacity.", "emotion": "ehap"},
	{"name": "Garu", "text": "Hoo… I’m a little nervous, but also pumped to bring that rat to his end! Alright, call him over!", "emotion": "hap"},
	{"name": "Esa", "text": "Of course, I’ll pray for your victory, Garu.", "emotion": "enor"}
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"ehap": preload("res://Image Assets/sila 1 expressions/Esa_Happy.PNG"),
	"enor": preload("res://Image Assets/sila 1 expressions/Esa_Normal.PNG"),
	"erel": preload("res://Image Assets/sila 1 expressions/Esa_Relieved.PNG"),
	"eups": preload("res://Image Assets/sila 1 expressions/Esa_Upset.PNG")
}

var dialog_index = 0
var finished = false
var char_index = 0
var typing_speed = 75  # characters per second
var current_text = ""

@onready var charimg = $charimg
@onready var dialogue_text = $RichTextLabel
@onready var name_label = $namelabel

func _ready():
	visible = false
	set_process_input(false)
	load_dialog()

func _input(event):
	if not visible:
		return  # Ignore all input if hidden

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and finished:
		load_dialog()

func _process(delta):
	if Input.is_key_pressed(KEY_H):
		visible = true
		set_process_input(true)

func load_dialog():
	if dialog_index < dialog.size():
		current_text = dialog[dialog_index]["text"]
		dialogue_text.text = current_text
		char_index = 0
		dialogue_text.visible_characters = 0
		finished = false

		var emotion = dialog[dialog_index]["emotion"]
		charimg.texture = emotions[emotion]

		name_label.text = dialog[dialog_index]["name"]

		dialog_index += 1
	else:
		queue_free()

func _physics_process(delta):
	if not finished:
		char_index += typing_speed * delta
		dialogue_text.visible_characters = int(char_index)
		
		if dialogue_text.visible_characters >= current_text.length():
			dialogue_text.visible_characters = current_text.length()
			finished = true
