extends Node2D

@onready var label_moedas: Label = $label_moedas

func _ready() -> void:
	$BotaoGame.connect("pressed", Callable(self, "_on_game_pressed"))


	label_moedas.text = str(Global.moedas)
# Fase Medieval
func _on_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")

# Fase Grécia
func _on_grecia_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/grecia.tscn")

# Fase Egito
func _on_egito_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/egito.tscn")
