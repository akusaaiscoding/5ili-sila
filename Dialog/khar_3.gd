extends Control

var dialog = [
	{"name": "Kharmia", "text": "I saw you fight out there, how are you feeling?", "emotion": "kcon"},
	{"name": "Garu", "text": "I’m feeling a little worn out… That fight was rough!", "emotion": "tir"},
	{"name": "Kharmia", "text": "Don’t worry, I’ll heal you up again! And it’s good to see some of the Silas getting back to their normal selves.", "emotion": "khap"},
	{"name": "Garu", "text": "Yeah, I kinda feel guilty for being asleep for a while, y’know hearing what they said earlier kind of opened my eyes a little.", "emotion": "sad"},
	{"name": "Kharmia", "text": "Don’t feel guilty, it wasn’t your fault you were cursed into a deep slumber! Those are just words from a corrupted mind.", "emotion": "khap"},
	{"name": "Garu", "text": "Well… I guess so! Alright, I’m all ready for the next destination! Musya said Siti was wandering about in that forest, is that right?", "emotion": "norm"},
	{"name": "Kharmia", "text": "Yep! Well, I got some more tips for you to face her, so listen carefully!", "emotion": "kcoo"},
	{"name": "Kharmia", "text": "Like Musya, Siti’s vine attacks will slow you down once you get hit, but thankfully with two of the Silas cleansed, you’ve got some speed boosts to counter that!", "emotion": "kexc"},
	{"name": "Kharmia", "text": "You’ll see little lightning icons pop around which will speed you up when you grab them!", "emotion": "kexc"},
	{"name": "Garu", "text": "Sweet, glad to know some of our efforts are taking fruition already!", "emotion": "hap"},
	{"name": "Garu", "text": "Alright, no time to waste, I’ll set off to the forest, see you Kharmia!", "emotion": "ang"},
	{"name": "Kharmia", "text": "Good luck and stay safe, Garu!", "emotion": "khap"},
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
	if Input.is_key_pressed(KEY_9):
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
