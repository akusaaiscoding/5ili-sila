extends Control

var dialog = [
	{"name": "Koru", "text": "???", "emotion": "konor"},
	{"name": "Koru", "text": "HELLO?? What’s the meaning of this? You’re supposed to be in a deep sleep! And where’s that weak little star gone?", "emotion": "kosho"},
	{"name": "Garu", "text": "I’m here to bring an end to this! I’ve cleansed all the silas who you’ve tainted, and now I’m here to get rid of the source!", "emotion": "ang"},
	{"name": "Koru", "text": "HAHAHAH!! You REALLY think that you can defeat ME?? I’ll just corrupt everyone again, and you can say bye bye to your sorry little friends.", "emotion": "kohap"},
	{"name": "Garu", "text": "Not if I defeat you first! Don’t bother using cheap tricks, Esa has you trapped in here!", "emotion": "ang"},
	{"name": "Koru", "text": "What the?! Grr… I’ll show you the true power of corruption, and how nothing else in this world matters!", "emotion": "kohap"}
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
	if Input.is_key_pressed(KEY_J):
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
