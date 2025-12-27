extends Node2D

@onready var label_moedas: Label = $label_moedas

func _ready() -> void:
	var newgame = $newgame
	var quit = $quit
	newgame.connect("pressed", Callable(self, "_on_newgame_pressed"))
	quit.connect("pressed", Callable(self, "_on_quit_pressed"))
	label_moedas.text = str(Global.moedas)


func _on_newgame_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/mapa.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
