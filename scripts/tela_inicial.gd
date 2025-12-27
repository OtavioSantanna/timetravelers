extends Node2D

func _ready() -> void:
	print("passou1")
	var button = $StartButton
	button.connect("pressed", Callable(self, "_on_start_pressed"))
	print("passou2")

func _on_start_pressed() -> void:
	print("passou3")
	get_tree().change_scene_to_file("res://scene/mapa.tscn")
