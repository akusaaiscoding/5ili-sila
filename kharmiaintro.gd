extends Control

var dialog = [
	{"name": "???", "text": "Hi there! Is there something you need?", "emotion": "knor"},
	{"name": "Garu", "text": "Yes, I’m trying to find my friends!", "emotion": "hap"},
	{"name": "Garu", "text": "They’re the Silas, have you seen any of them?", "emotion": "norm"},
	{"name": "???", "text": "The Silas? Friends? Then.. you must be Garu! The protector! But I fear they’ve changed…", "emotion": "kshoc"},
	{"name": "???", "text": "Ever since the corruption spread across the land, things have been going terribly…", "emotion": "ksad"},
	{"name": "???", "text": "With the Silas being engulfed by corruption… They’ve gone rogue!", "emotion": "kcon"},
	{"name": "Garu", "text": "Oh dear… that’s awful…", "emotion": "sad"},
	{"name": "Garu", "text": "There has to be a way to save them… Do you know how?", "emotion": "ang"},
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
	"kshoc": preload("res://Image Assets/kharemo/Kharmia_Shocked.PNG")
}

var dialog_index = 0
var finished = false
var char_index = 0
var typing_speed = 75
var current_text = ""

@onready var charimg = $charimg
@onready var dialogue_text = $RichTextLabel
@onready var name_label = $namelabel

func _ready():
	visible = false
	set_process_input(false)

func show_dialog():
	visible = true
	set_process_input(true)
	dialog_index = 0
	load_dialog()

func hide_dialog():
	visible = false
	set_process_input(false)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and finished and visible:
		load_dialog()

func _process(delta):
	if Input.is_key_pressed(KEY_2):
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
		hide_dialog()

func _physics_process(delta):
	if not finished:
		char_index += typing_speed * delta
		dialogue_text.visible_characters = int(char_index)
		if dialogue_text.visible_characters >= current_text.length():
			dialogue_text.visible_characters = current_text.length()
			finished = true
