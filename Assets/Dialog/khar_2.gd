extends Control

var dialog = [
	{"name": "Garu", "text": "Kharmia!! Didn’t expect you to be here! I did it! I saved Kadita!", "emotion": "sup"},
	{"name": "Garu", "text": "I’m one step closer to saving this world!", "emotion": "hap"},
	{"name": "Kharmia", "text": "That was amazing Garu!!", "emotion": "khap"},
	{"name": "Garu", "text": "Looks like I’m starting to earn my badges back as well, but that fight did kind of wear me out…", "emotion": "tir"},
	{"name": "Kharmia", "text": "Don’t worry, I’ll help you heal up before your next confrontation.", "emotion": "kcoo"},
	{"name": "Garu", "text": "Oh, thanks! You’ve been such a help. But uh, any idea on who I’m facing next?", "emotion": "hap"},
	{"name": "Kharmia", "text": "The closest one should be Musya. Oh, I have some advice for fighting him!", "emotion": "ksho"},
	{"name": "Kharmia", "text": "Make sure to be careful of his horn attack, it makes you all dazed and slowed when you get hit.", "emotion": "kcon"},
	{"name": "Garu", "text": "Ahh alright, I’ll keep that in mind. Thanks again Kharmia, I’ll be on my way, the world can’t wait any longer for saving!", "emotion": "sup"},
	{"name": "Kharmia", "text": "Good luck, Garu!", "emotion": "khap"},
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
	if Input.is_key_pressed(KEY_6):
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
