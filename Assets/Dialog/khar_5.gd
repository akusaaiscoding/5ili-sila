extends Control

var dialog = [
	{"name": "Kharmia", "text": "Seems like you emerged victorious again, as I expected nothing less from the hero!", "emotion": "khap"},
	{"name": "Garu", "text": "Hehehe, oh stop… But anyways, I’ll be heading up the tower with Adila soon. I don’t want to put you into any danger, so I guess we’ll have to part ways.", "emotion": "sad"},
	{"name": "Kharmia", "text": "Oh, I completely understand! I’ll give you one last heal up before you go!", "emotion": "knor"},
	{"name": "Kharmia", "text": "Woah, wait, looks like you unlocked some sort of healing ability?", "emotion": "kexc"},
	{"name": "Garu", "text": "I… I have?", "emotion": "sup"},
	{"name": "Kharmia", "text": "Yeah! This will be useful since I’m not there to heal you! Once you’re in battle, there will be these green plus symbols that will restore your health!", "emotion": "khap"},
	{"name": "Garu", "text": "Aw sweet! But… why do I have the feeling that things are only gonna get harder from here?", "emotion": "emba"},
	{"name": "Kharmia", "text": "Yes… you’ll have to face Esa at the top of the tower, then most likely Koru, the rat that caused all of this corruption.", "emotion": "kcon"},
	{"name": "Garu", "text": "Koru… just hearing that name gives me the shivers! Do you know anything about how to beat Koru?", "emotion": "sad"},
	{"name": "Kharmia", "text": "Unfortunately, I have limited information about him in particular, but I do know a bit about Esa!", "emotion": "kcon"},
	{"name": "Kharmia", "text": "You’re going to mainly have to dodge star and laser attacks, which should be quite challenging, but with your newfound healing skill I’m sure you’ll succeed!", "emotion": "kexc"},
	{"name": "Garu", "text": "That’s reassuring! I’m still a bit nervous… Having to face Koru all on my own…", "emotion": "sad"},
	{"name": "Kharmia", "text": "You’re not gonna be alone. I’ll be watching from down here and I’m sure the other Silas are going to support you from afar! You got this, Garu, believe in yourself!", "emotion": "khap"},
	{"name": "Garu", "text": "R-right! I’ve gotten stronger and stronger, I should be able to beat him!", "emotion": "ang"},
	{"name": "Garu", "text": "Well, I guess this is goodbye until I reach the end, Kharmia!", "emotion": "sad"},
	{"name": "Garu", "text": "Thank you for everything!", "emotion": "hap"},
	{"name": "Kharmia", "text": "Once again, good luck Garu, may you emerge victorious once again!", "emotion": "khap"}
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
	if Input.is_key_pressed(KEY_Y):
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
