extends Node2D


func _on_princess_body_enter(body):
	# The name of this editor-generated callback is unfortunate
	if body.get_name() == "player":
		$youwin.show()


func _on_moving_platform1_body_entered(body):
	print("Hit something")
	$moving_platform1.switch(body);