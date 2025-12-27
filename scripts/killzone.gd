extends Area2D

var RESTART_DELAY = 1.0

func _on_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(RESTART_DELAY).timeout
	get_tree().change_scene_to_file("res://scene/morreu.tscn")
