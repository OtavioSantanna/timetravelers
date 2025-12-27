extends Area2D

@onready var label_fim: Label = $Label

var player_ref: Node = null
var message_shown: bool = false
const DELAY_BEFORE_QUIT: float = 2.0 

func _ready() -> void:
	label_fim.visible = false

func _on_body_entered(body: Node2D) -> void:
	print("Total de moedas coletadas: ", Global.moedas)
	if message_shown:
		return  

	player_ref = body
	message_shown = true

	# Exibe a mensagem
	label_fim.text = "Parabéns, você chegou ao final da fase!
Agora você domina os segredos da Grécia Antiga como ninguém!
Pegue esta chave egípcia como recompensa para avançar."

	label_fim.visible = true


	if player_ref != null and player_ref.has_method("disable_input"):
		player_ref.disable_input()


	_end_game()

func _end_game() -> void:
	var timer = get_tree().create_timer(DELAY_BEFORE_QUIT)
	await timer.timeout

	get_tree().change_scene_to_file("res://scene/mapa3.tscn")
