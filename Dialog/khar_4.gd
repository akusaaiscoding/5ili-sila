extends Control

var dialog = [
	{"name": "Garu", "text": "Hey, I’m guessing you were watching the whole thing? How did I do?", "emotion": "norm"},
	{"name": "Kharmia", "text": "You’re getting way better! Let me patch you up again…", "emotion": "khap"},
	{"name": "Kharmia", "text": "Woah, looks like your health has been going up by a bit ever since your first encounter!", "emotion": "kexc"},
	{"name": "Kharmia", "text": "Have you noticed?", "emotion": "khap"},
	{"name": "Garu", "text": "Uh, yeah, I guess I do feel a little sturdier than usual. Maybe because I’m getting some of my powers back through cleansing!", "emotion": "hap"},
	{"name": "Kharmia", "text": "Seems so! Glad to hear, this whole situation is seeming to look much better than I anticipated…", "emotion": "khap"},
	{"name": "Garu", "text": "Sure is! Okay then, give me the run down of the next one, chief Kharmia! Should be over there at the tower right?", "emotion": "hap"},
	{"name": "Kharmia", "text": "Hehe, you know it! The next one should be Adila, who currently serves as a guard dog for the tower’s entrance.", "emotion": "knor"},
	{"name": "Kharmia", "text": "You’re gonna need to be careful with his ferocious bites, he’ll stun you if you get bit! He also slows you down a bit with his chains.", "emotion": "kexc"},
	{"name": "Garu", "text": "Hah… another one with slowing attacks, and now locking me into place?! I’m starting to feel a little sluggish…", "emotion": "emba"},
	{"name": "Kharmia", "text": "Don’t lose hope just yet, Garu! We’re almost at the end, I can feel it. Good luck on your next battle!", "emotion": "khap"},
	{"name": "Garu", "text": "Thanks for everything again, Kharmia!", "emotion": "hap"}
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
	if Input.is_key_pressed(KEY_O):
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
