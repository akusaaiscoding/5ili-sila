extends Control

var dialog = [
	{"name": "Koru", "text": "NO… NOOO!!", "emotion": "koups"},
	{"name": "Garu", "text": "I’ll use my cleansing powers to get rid of you once and for all!", "emotion": "ang"},
	{"name": "Koru", "text": "Wait! Wait… before you get rid of me… I want to apologize.", "emotion": "koups"},
	{"name": "Garu", "text": "…?!", "emotion": "sup"},
	{"name": "Koru", "text": "I’m sorry… everything I did, it’s all just an honest mistake, you see! I just wanted attention, I’m pathetic I know…", "emotion": "koups"},
	{"name": "Garu", "text": "Koru… I… I don’t really want to get rid of you either, that would be taking someone’s life, I-", "emotion": "sad"},
	{"name": "Koru", "text": "Don’t look behind you~", "emotion": "kohap"},
	{"name": "Garu", "text": "Oh no you don’t!", "emotion": "ang"},
	{"name": "Garu", "text": "I… I did it. It’s over, right?", "emotion": "tir"},
	{"name": "Garu", "text": "Yes!! I really did it! I’ll have to go back down and tell everyone!", "emotion": "hap"}
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"kohap": preload("res://Image Assets/koremo/Koru_Happy_Cheeky.PNG"),
	"konor": preload("res://Image Assets/koremo/Koru_Normal.PNG"),
	"kosho": preload("res://Image Assets/koremo/Koru_Shocked.PNG"),
	"koups": preload("res://Image Assets/koremo/Koru_Upset.PNG")
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
	if Input.is_key_pressed(KEY_K):
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
		get_tree().change_scene_to_file("res://Scenes/ending.tscn")

func _physics_process(delta):
	if not finished:
		char_index += typing_speed * delta
		dialogue_text.visible_characters = int(char_index)
		
		if dialogue_text.visible_characters >= current_text.length():
			dialogue_text.visible_characters = current_text.length()
			finished = true
