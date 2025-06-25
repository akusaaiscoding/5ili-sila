extends Control

var dialog = [
	{"name": "Siti", "text": "Oh. My. God!! Garu, I’m so so sorry, I was TOTALLY super mean just now! Thanks for saving me, bestie!", "emotion": "ssup"},
	{"name": "Garu", "text": "Ahaa… yeahhhh! I’m glad you’re back too, bestie!", "emotion": "emba"},
	{"name": "Garu", "text": "So, uh, any idea where I should go next?", "emotion": "emba"},
	{"name": "Siti", "text": "Uh yeah! Just take a look at that completely inconspicuously ominous tower over there!", "emotion": "snor"},
	{"name": "Garu", "text": "Oh!", "emotion": "sup"},
	{"name": "Siti", "text": "Mhm, good luck with that, Garu! I’ll send my big love and support from afar!", "emotion": "shap"},
	{"name": "Garu", "text": "Hehe, thanks Siti! I’ll see you when I return victorious!", "emotion": "hap"},
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"shap": preload("res://Image Assets/sila 3 expressions/Siti_Happy.PNG"),
	"snor": preload("res://Image Assets/sila 3 expressions/Siti_Normal.PNG"),
	"ssup": preload("res://Image Assets/sila 3 expressions/Siti_Surprised.PNG")
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
	if Input.is_key_pressed(KEY_P):
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
