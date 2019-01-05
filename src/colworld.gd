extends Node2D
export(String, FILE, "*.tscn") var world_scene

var pubsub_counter = 0

func _on_princess_body_enter(body):
	# The name of this editor-generated callback is unfortunate
	if body.get_name() == "player" and pubsub_counter >= 1:
		get_tree().change_scene(world_scene)


# When the player touches the pubsub it deletes it
func _on_Pubsub_body_entered(body):
	pubsub_counter += 1
	$Pubsub.queue_free()
	
