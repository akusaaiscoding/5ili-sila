extends Area2D

# Define your scene transitions manually
var level_transitions = {
	"res://overworld/cave_world.tscn": "res://overworld/intermision_world.tscn",
	"res://overworld/intermision_world.tscn": "res://overworld/cave_world.tscn"
}

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("garu"):
		var current_scene_path = get_tree().current_scene.scene_file_path
		if current_scene_path in level_transitions:
			var next_scene_path = level_transitions[current_scene_path]
			print("Next scene:", next_scene_path)
			
			get_tree().change_scene_to_file(next_scene_path)
		
			var posisi = Vector2(400,62)
			$"../garu".position = posisi
			print($"../garu1".position)
		else:
			print("No next scene defined for", current_scene_path)
