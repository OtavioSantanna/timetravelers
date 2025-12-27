extends Area2D

const RESTART_DELAY : float = 2.0
const SUCCESS_DELAY : float = 0.4

@onready var label_de_pergunta : Label = $pergunta

var in_combat : bool = false
var correct_answer : int = 1
var combat_player : Node = null


var perguntas: Array = [
	{"pergunta":"Como se chamava a principal cidade militar da Grécia?", "resp1":"Esparta", "resp2":"Atenas", "certa":1},
	{"pergunta":"Quem era o deus principal do Olimpo?", "resp1":"Hades", "resp2":"Zeus", "certa":2},
	{"pergunta":"Qual era a principal atividade dos espartanos?", "resp1":"Comércio", "resp2":"Guerra", "certa":2},
	{"pergunta":"Onde nasceu a democracia?", "resp1":"Atenas", "resp2":"Roma", "certa":1},
	{"pergunta":"Quem era o deus da guerra?", "resp1":"Apolo", "resp2":"Ares", "certa":2},
	{"pergunta":"Quem foi um grande filósofo grego?", "resp1":"Sócrates", "resp2":"Nero", "certa":1},
	{"pergunta":"O que eram as Olimpíadas?", "resp1":"Festivais religiosos", "resp2":"Jogos esportivos", "certa":2},
	{"pergunta":"Quem era a deusa da sabedoria?", "resp1":"Atena", "resp2":"Afrodite", "certa":1},
	{"pergunta":"O que é a mitologia?", "resp1":"Relatos históricos", "resp2":"Histórias sobre os deuses", "certa":2},
	{"pergunta":"Quem era o deus dos mares?", "resp1":"Poseidon", "resp2":"Hades", "certa":1}
]




func _ready() -> void:
	label_de_pergunta.visible = false

func _on_body_entered(body: Node2D) -> void:
	if in_combat:
		return

	in_combat = true
	combat_player = body
	if combat_player != null and combat_player.has_method("disable_input"):
		combat_player.disable_input()


	set_deferred("monitoring", false)

	# 🔹 Sorteia uma pergunta aleatória
	var pergunta_sorteada = perguntas[randi() % perguntas.size()]
	correct_answer = pergunta_sorteada.certa

	label_de_pergunta.text = "%s\n[1] %s  \n[2] %s" % [
		pergunta_sorteada.pergunta,
		pergunta_sorteada.resp1,
		pergunta_sorteada.resp2
	]
	label_de_pergunta.visible = true

func _process(_delta: float) -> void:
	if not in_combat:
		return

	if Input.is_action_just_pressed("resp1"):
		_handle_response(1)
	elif Input.is_action_just_pressed("resp2"):
		_handle_response(2)

func _handle_response(choice : int) -> void:
	if not in_combat:
		return
	in_combat = false

	if choice == correct_answer:
		print("Resposta correta!")
		await _on_correct()
	else:
		print("Resposta errada! Jogador morreu.")
		await _on_wrong()

func _on_correct() -> void:
	label_de_pergunta.visible = false

	if combat_player != null and combat_player.has_method("enable_input"):
		combat_player.enable_input()


	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5).from(1.0)
	tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.5).from(self.scale)
	tween.play()
	await tween.finished

	queue_free()

func _on_wrong() -> void:
	if $somMorte:
		$somMorte.play()

	label_de_pergunta.text = "Errou! Você morreu!"
	await get_tree().create_timer(RESTART_DELAY).timeout
	get_tree().change_scene_to_file("res://scene/morreu.tscn")
