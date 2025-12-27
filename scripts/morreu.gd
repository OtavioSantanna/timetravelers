extends Node2D

func _ready() -> void:
	var newgame = $newgame
	var quit = $quit
	newgame.connect("pressed", Callable(self, "_on_newgame_pressed"))
	quit.connect("pressed", Callable(self, "_on_quit_pressed"))


func _on_newgame_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
