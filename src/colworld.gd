extends Node2D
export(String, FILE, "*.tscn") var world_scene

func _on_princess_body_enter(body):
	# The name of this editor-generated callback is unfortunate
	if body.get_name() == "player":
		get_tree().change_scene(world_scene)
