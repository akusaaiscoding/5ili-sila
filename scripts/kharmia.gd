extends Area2D

@onready var anim = $AnimatedSprite2D

signal talk_requested(lines: Array)

func _ready():
	anim.play("idle")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var dialog_lines = [
			{ "speaker": "Kharmia", "text": "Hi there! Is there something you need?" },
			{ "speaker": "Garu", "text": "Yes, I’m trying to find my friends." },
			{ "speaker": "Garu", "text": "They’re the Silas, have you seen any of them?" },
			{ "speaker": "Kharmia", "text": "The Silas? Friends? Then.. you must be Garu! The protector! But I fear they’ve changed…" },
			{ "speaker": "Kharmia", "text": "Ever since the corruption spread across the land, things have been going terribly…" },
			{ "speaker": "Kharmia", "text": "With the Silas being engulfed by corruption… They’ve gone rogue!" },
			{ "speaker": "Garu", "text": "Oh dear… that’s awful…" },
			{ "speaker": "Garu", "text": "There has to be a way to save them… Do you know how?" },
			{ "speaker": "Kharmia", "text": "I’m not sure, but everything started changing when someone by the name of Koru showed up." },
			{ "speaker": "Kharmia", "text": "As far as I know, he resides in that tower." },
			{ "speaker": "Garu", "text": "Huh? I’ve never seen that tower before. I’ll need to check who this Koru is." },
			{ "speaker": "Kharmia", "text": "Now hold on, you need to know that no one has been able to enter the tower." },
			{ "speaker": "Kharmia", "text": "I haven’t been there myself but I heard that the Silas are preventing us from going anywhere near it…" },
			{ "speaker": "Kharmia", "text": "So if you’re going there, could you please find a way to free us from this corruption?" },
			{ "speaker": "Kharmia", "text": "I hate pointing fingers but that rat might just be the cause of all this" },
			{ "speaker": "Garu", "text": "Okay! I’ll try my best… Where should I head first?" },
			{ "speaker": "Kharmia", "text": "Over there at the farmland, then through the forest to the tower. You should be able to find the silas on the way." },
			{ "speaker": "Garu", "text": "Alright… but… how do I defeat them?" },
			{ "speaker": "Kharmia", "text": "I’m not quite sure… but I heard you have to survive their attacks for a period of time." },
			{ "speaker": "Kharmia", "text": "Good luck, you're our only hope." },
			{ "speaker": "Garu", "text": "Thank you… uhh what's your name again?" },
			{ "speaker": "Kharmia", "text": "It’s Kharmia!" },
			{ "speaker": "Garu", "text": "Ok, Kharmia. I promise to return victorious!" }
		]
		emit_signal("talk_requested", dialog_lines)
