extends AnimatedSprite2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"."  # opcional

func _on_animation_finished() -> void:
	queue_free()

func _on_moeda_body_entered(body: Node2D) -> void:
	# Adiciona moeda GLOBALMENTE
	Global.add_moeda()

	# Toca animação de coleta
	animated_sprite_2d.play("collect")
