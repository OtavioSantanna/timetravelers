# 🏰 Jogo Educativo de História – Idade Média, Grécia e Egito

Este é um **jogo educativo desenvolvido na Godot Engine**, com o objetivo de ensinar História de forma interativa e divertida.  
O jogador avança por fases respondendo perguntas históricas, coletando moedas e desbloqueando novas civilizações.

---

## 🌐 Jogue Online

🎮 **Link do jogo:**  
👉 https://SEU-LINK-AQUI

_(Substitua pelo link do site onde o jogo está hospedado)_

---

## 🎮 Sobre o Jogo

O jogo é dividido em **três fases históricas**, cada uma desbloqueada ao concluir a anterior:

1. **Idade Média**
2. **Grécia Antiga**
3. **Egito Antigo**

Cada fase apresenta desafios baseados em perguntas históricas. Ao concluir uma fase, o jogador desbloqueia a próxima por meio de uma “chave” temática.

---

## 🧠 Mecânicas Principais

- 📚 **Sistema de Perguntas e Respostas**  
  O jogador precisa responder corretamente para avançar. Respostas erradas resultam em derrota.

- 🔀 **Respostas Embaralhadas**  
  As alternativas mudam de posição, evitando respostas decoradas.

- 🪙 **Sistema de Moedas**  
  Moedas são coletadas durante as fases e contabilizadas ao final do jogo.

- 🔊 **Trilha Sonora e Efeitos Sonoros**  
  Música de fundo contínua e efeitos para ações importantes, como dano e morte.

- 🗺️ **Mapa de Seleção de Fases**  
  Após concluir uma fase, o jogador retorna ao mapa para escolher a próxima.

---

## 🗂️ Fases do Jogo

| Fase | Arquivo |
|------|--------|
| Idade Média | `game.tscn` |
| Grécia Antiga | `grecia.tscn` |
| Egito Antigo | `egito.tscn` |

---

## 🏁 Finais do Jogo

- **Idade Média** → Desbloqueia a Grécia Antiga  
- **Grécia Antiga** → Desbloqueia o Egito Antigo  
- **Egito Antigo** → Final do jogo, tornando o jogador um **expert em História**

---

## 🧩 Tecnologias Utilizadas

- 🎮 **Godot Engine**
- 📜 **GDScript**
- 🖼️ **AnimatedSprite2D**
- 🔊 **AudioStreamPlayer**
- 🌍 **Autoload (Global.gd)** para dados persistentes (moedas e progresso)

---

## 📦 Sistema Global

O jogo utiliza um script global para manter informações entre fases, como:

```gdscript
var moedas: int = 0
