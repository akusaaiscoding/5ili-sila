extends Control

var dialog = [
	{"name": "???", "text": "Hi there! Is there something you need?", "emotion": "knor"},
	{"name": "Garu", "text": "Yes, I’m trying to find my friends.", "emotion": "hap"},
	{"name": "Garu", "text": "They’re the Silas, have you seen any of them?", "emotion": "sad"},
	{"name": "???", "text": "The Silas? Friends? Then.. you must be Garu! The protector! But I fear they’ve changed…", "emotion": "ksho"},
	{"name": "???", "text": "Ever since the corruption spread across the land, things have been going terribly…", "emotion": "ksad"},
	{"name": "???", "text": "With the Silas being engulfed by corruption… They’ve gone rogue!", "emotion": "kcon"},
	{"name": "Garu", "text": "Oh dear… that’s awful…", "emotion": "sad"},
	{"name": "Garu", "text": "There has to be a way to save them… Do you know how?", "emotion": "tir"},
	{"name": "???", "text": "I’m not sure, but everything started changing when someone by the name of Koru showed up.", "emotion": "kexc"},
	{"name": "???", "text": "As far as I know, he resides in that tower.", "emotion": "ksho"},
	{"name": "Garu", "text": "Huh? I’ve never seen that tower before. I’ll need to check who this Koru is.", "emotion": "sup"},
	{"name": "???", "text": "Now hold on, you need to know that no one has been able to enter the tower.", "emotion": "ksho"},
	{"name": "???", "text": "I haven’t been there myself but I heard that the Silas are preventing us from going anywhere near it…", "emotion": "kcon"},
	{"name": "???", "text": "So if you’re going there, could you please find a way to free us from this corruption?", "emotion": "ksad"},
	{"name": "???", "text": "I hate pointing fingers but that rat might just be the cause of all this.", "emotion": "knor"},
	{"name": "Garu", "text": "Okay! I’ll try my best… Where should I head first?", "emotion": "norm"},
	{"name": "???", "text": "Over there at the farmland, then through the forest to the tower. You should be able to find the Silas on the way.", "emotion": "knor"},
	{"name": "Garu", "text": "Alright… but… how do I defeat them?", "emotion": "norm"},
	{"name": "???", "text": "I’m not quite sure… but I heard you have to survive their attacks for a period of time.", "emotion": "kexc"},
	{"name": "???", "text": "Good luck, you're our only hope.", "emotion": "khap"},
	{"name": "Garu", "text": "Thank you… uhh what's your name again?", "emotion": "hap"},
	{"name": "Kharmia", "text": "It’s Kharmia!", "emotion": "khap"},
	{"name": "Garu", "text": "Ok, Kharmia. I promise to return victorious!", "emotion": "hap"}
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"kcon": preload("res://Image Assets/kharemo/Kharmia_Concern.PNG"),
	"kcoo": preload("res://Image Assets/kharemo/Kharmia_Cool.PNG"),
	"kexc": preload("res://Image Assets/kharemo/Kharmia_Excited.PNG"),
	"khap": preload("res://Image Assets/kharemo/Kharmia_Happy.PNG"),
	"knor": preload("res://Image Assets/kharemo/Kharmia_Normal.PNG"),
	"ksad": preload("res://Image Assets/kharemo/Kharmia_Sad_Worried.PNG"),
	"ksho": preload("res://Image Assets/kharemo/Kharmia_Shocked.PNG")
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
	if Input.is_key_pressed(KEY_3):
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
