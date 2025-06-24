extends Control

var dialog = [
	{"name": "Siti", "text": "…", "emotion": "siti"},
	{"name": "Garu", "text": "Um… hello? Siti?", "emotion": "sad"},
	{"name": "Siti", "text": "Ugh, it’s you. What do you want?", "emotion": "siti"},
	{"name": "Garu", "text": "I’m here to uh, bring you back to normal, good friend! Also don’t point those vines at me.", "emotion": "sad"},
	{"name": "Siti", "text": "Shut up. I’m not your ‘friend’, there’s no point in friendship or cooperation. Only strife.", "emotion": "siti"},
	{"name": "Garu", "text": "W-woah, easy now, Don’t you remember your virtues? You know, ensuring unity and peace?", "emotion": "sup"},
	{"name": "Siti", "text": "How pathetic. You really believe in all that?", "emotion": "siti"},
	{"name": "Siti", "text": "Koru has opened my eyes to the true power of standing at the top alone. I don’t need anyone, I don’t need you.", "emotion": "siti"},
	{"name": "Garu", "text": "Koru… I’ve heard that name before. *sighs* Well, I guess it always comes to this. I’ll save you, Siti!", "emotion": "ang"},
	{"name": "Siti", "text": "You won’t.", "emotion": "siti"},
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"siti":preload("res://Image Assets/sila 3 expressions/Siti_Corrupt.PNG")
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
	if Input.is_key_pressed(KEY_0):
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
