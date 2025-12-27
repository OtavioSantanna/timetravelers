extends Area2D

const RESTART_DELAY : float = 2.0
const SUCCESS_DELAY : float = 0.4

@onready var label_de_pergunta : Label = $pergunta

var in_combat : bool = false
var correct_answer : int = 1
var combat_player : Node = null


var perguntas: Array = [
	{"pergunta":"Quem comandava os feudos?", "resp1":"Cavaleiro", "resp2":"Senhor feudal", "certa":2},
	{"pergunta":"Qual era a principal língua escrita na Idade Média?", "resp1":"Latim", "resp2":"Francês", "certa":1},
	{"pergunta":"Qual evento marcou a disseminação da peste na Europa?", "resp1":"Peste Negra", "resp2":"Cruzadas", "certa":1},
	{"pergunta":"O que era o sistema feudal?", "resp1":"Governo centralizado", "resp2":"Troca de terra por serviço", "certa":2},
	{"pergunta":"Quem era responsável por ensinar na Idade Média?", "resp1":"Clérigos", "resp2":"Reis", "certa":1},
	{"pergunta":"O que eram as Cruzadas?", "resp1":"Feiras comerciais", "resp2":"Guerras religiosas", "certa":2},
	{"pergunta":"Onde ocorriam as reuniões importantes da cidade?", "resp1":"Fórum", "resp2":"Castelo", "certa":1},
	{"pergunta":"O que eram as guildas?", "resp1":"Associações de ofício", "resp2":"Exércitos privados", "certa":1},
	{"pergunta":"Qual era o papel do cavaleiro?", "resp1":"Administrar cidades", "resp2":"Proteger feudos", "certa":2},
	{"pergunta":"Qual foi um dos principais problemas da Idade Média?", "resp1":"Doenças", "resp2":"Tecnologia", "certa":1}
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
