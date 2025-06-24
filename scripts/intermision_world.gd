func _ready():
	$Kharmia.connect("talk_requested", $DialogBox.show_dialog)
