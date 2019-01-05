extends Node2D

export(String, FILE, "*.tscn") var world_scene

func _ready():
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene(world_scene)
