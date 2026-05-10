extends Node2D

var velocidad: Vector2
var niveles = [
	#  NIVEL 1
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X    F        X       X      X",
		"X                      X     X",
		"X     X                X     X",
		"X   XXX    F     X     X     X",
		"X    F        X       X      X",
		"X    X        X       X      X",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X   F   X            XXX     X",
		"X       X                    X",
		"X     X                X     X",
		"X   XXX    F     X     X     X",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X   F   X            XXX     X",
		"X       X                    X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 2
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X        F              XF   X",
		"X     X   XXXXX F     X   F  X",
		"X   XXX    F     X     X     X",
		"X                            X",
		"X                X    F      X",
		"X       X        X           X",
		"X       X            XXX     X",
		"X       X                    X",
		"X     X                XF    X",
		"X   FXX    F     X     X    FX",
		"X                X           X",
		"X                F           X",
		"X       X        X           X",
		"X   F   X            XFX     X",
		"XF      X                   FX",
		"X   XXX    F     X     X     X",
		"X   XXX          X     F     X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 3
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X                      X     X",
		"X     X                X     X",
		"X   XXX    F     X     X     X",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X   F   X            XXX     X",
		"X       X                    X",
		"X     X                X     X",
		"X   XXX    F     X     X     X",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X   F   X            XXX     X",
		"X       X                    X",
		"X   X    F     X       F     X",
		"X       X        F     X     X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 4
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X   F                  XF    X",
		"X     X                X     X",
		"X   XXX    F     X     X     X",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X       X            XXX     X",
		"X       X                    X",
		"X     X                XF    X",
		"X   XXX    F     X     X    FX",
		"X                X           X",
		"X                X    F      X",
		"X       X        X           X",
		"X   F   X            XXX     X",
		"XF      X                   FX",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 5
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X        X           X       X",
		"X  F     X    F      X   F   X",
		"X   XXXXXXX   XXXXX   XXXXX   X",
		"X        X           X       X",
		"X  F     X    F      X   F   X",
		"X   XXXXXXX   XXXXX   XXXXX   X",
		"X        X           X       X",
		"X  F     X    F      X   F   X",
		"X   XXXXXXX   XXXXX   XXXXX   X",
		"X        X           X       X",
		"X  F     X    F      X   F   X",
		"X   XXXXXXX   XXXXX   XXXXX   X",
		"X        X           X       X",
		"X  F     X    F      X   F   X",
		"X        X           X       X",
		"X   F   X            XXX     X",
		"X       X                    X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 6
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X        X        X        F  X",
		"X  XXXX  X  XXXX  X  XXXX    X",
		"X     X     X     X     X     X",
		"FX    X     X     X     X    FX",
		"X     X     X     X     X     X",
		"X  XXXX  X  XXXX  X  XXXX  X  X",
		"X        X        X        X  X",
		"X  XXXX  X  XXXX  X  XXXX  X  X",
		"X     X     X     X     X     X",
		"X   F   X            XF X     X",
		"X       X                     X",
		"FX    X     X     X     X    FX",
		"X     X     X     X     X     X",
		"X  XXXX  X  XXXX  X  XXXX  X  X",
		"X        X        X        X  X",
		"X        X        X        F  X",
		"X                             X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	],
	#  NIVEL 7
	[
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
		"X   F       XXXXXXX       F   X",
		"X         XX       XX         X",
		"X  F     X   F   X   F     X  X",
		"X       X           X         X",
		"X      X   XXXXXXX   X        X",
		"X     X   X       X   X       X",
		"X    X   X   F   X   X        X",
		"X     X   X       X   X       X",
		"X      X   XXXXXXF   X        X",
		"X      X   XXXFXXX   X        X",
		"X     X   X       X   X       X",
		"X       X           X   F     X",
		"X  F     X       X   X        X",
		"X         XXXXXXX       F     X",
		"X                             X",
		"X   F   XXXXXXXXXXXXXX   F   X",
		"X                             X",
		"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	]
]

var tamanyoCasilla : int = 32
var segEspera : float = 0.400
var tiempoAcumulado : float = 0.0
var colaSerpiente = []
var casillaPared : PackedScene
var casillaFruta : PackedScene
var segmentoSerpiente : PackedScene
var nivelActual : int = 0
var frutasRestantes : int = 0
var enPartida : bool = false
var puntos: int = 0

func _ready() -> void:
	velocidad = Vector2(tamanyoCasilla,0)
	$Serpiente.position = Vector2(10*tamanyoCasilla + tamanyoCasilla/2.0, 
		7*tamanyoCasilla + tamanyoCasilla/2.0)
	segmentoSerpiente = preload("res://serpiente.tscn")
	casillaPared = preload("res://pared.tscn")
	casillaFruta = preload("res://fruta.tscn")
	
	generarLaberinto()
	terminarPartida()
	$textoPuntos.text = "Puntos: 0"
	$textoComenzar.text= "PULSA ESPACIO PARA EMPEZAR"
	$textoComenzar.visible = true
	
	var fondo = $fondo
	var tamPantalla = get_viewport_rect().size
	var escala_x = tamPantalla.x / fondo.texture.get_size().x
	var escala_y = tamPantalla.y / fondo.texture.get_size().y
	fondo.scale = Vector2(escala_x, escala_y)
	fondo.position = tamPantalla / 2
	
	$textoPuntos.position = Vector2(30, 0.5)
	$textoPuntos.custom_minimum_size = Vector2(450, 60)
	$textoPuntos.add_theme_color_override("font_color", Color(1, 1, 1))
	$textoPuntos.add_theme_color_override("outline_color", Color(0, 0, 0))
	$textoPuntos.add_theme_constant_override("outline_size", 3)
	$textoPuntos.add_theme_font_size_override("font_size", 25)
	$textoPuntos.horizontal_alignment = 0
	$textoPuntos.text = "Puntos: 0 | Nivel: 1"
	$textoPuntos.visible = true
	$textoPuntos.z_index = 10  # ✅ NÚMERO ALTO = SE DIBUJA ENCIMA

	$textoComenzar.position = Vector2(200, 0.5)
	$textoComenzar.custom_minimum_size = Vector2(600, 60)
	$textoComenzar.add_theme_color_override("font_color", Color(1, 0.8, 0))
	$textoComenzar.add_theme_color_override("outline_color", Color(0, 0, 0))
	$textoComenzar.add_theme_constant_override("outline_size", 3)
	$textoComenzar.add_theme_font_size_override("font_size", 25)
	$textoComenzar.horizontal_alignment = 1
	$textoComenzar.text = "PULSA ESPACIO PARA EMPEZAR"
	$textoComenzar.visible = true
	$textoComenzar.z_index = 10  # ✅ MISMO NÚMERO, ARRIBA DE TODO

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and enPartida:
		velocidad = Vector2(0, -tamanyoCasilla)
	if Input.is_action_pressed("ui_down") and enPartida:
		velocidad = Vector2(0, tamanyoCasilla)
	if Input.is_action_pressed("ui_left") and enPartida:
		velocidad = Vector2(-tamanyoCasilla, 0)
	if Input.is_action_pressed("ui_right") and enPartida:
		velocidad = Vector2(tamanyoCasilla, 0)

	if not enPartida and Input.is_action_just_pressed("comenzar"):
		comenzarPartida()

	tiempoAcumulado += delta
	if (tiempoAcumulado >= segEspera):
		moverSerpiente()
		tiempoAcumulado = 0

func generarLaberinto() -> void:
	frutasRestantes = 0	
	for y in range(niveles[nivelActual].size()):
		for x in range(niveles[nivelActual][y].length()):
			var caracter = niveles[nivelActual][y][x]
			var posicion = Vector2(x,y) * tamanyoCasilla + \
				Vector2(tamanyoCasilla/2.0, tamanyoCasilla/2.0)
			
			if caracter == "X":
				var pared = casillaPared.instantiate()
				pared.add_to_group("Pared")
				pared.position = posicion
				add_child(pared)
			elif caracter == "F":
				var fruta = casillaFruta.instantiate()
				fruta.add_to_group("Fruta")
				fruta.position = posicion
				add_child(fruta)
				frutasRestantes += 1

func _on_serpiente_area_entered(otro: Area2D) -> void:
	if otro.is_in_group("Pared") or otro.is_in_group("Serpiente"):
		$sonidoPared.play()
		terminarPartida()
	elif otro.is_in_group("Fruta"):
		call_deferred("aumentarSerpiente")
		$sonidoFruta.play()
		if segEspera > 0.060 :
			segEspera -= 0.030
		otro.queue_free()
		puntos += 1
		$textoPuntos.text = str(puntos)
		frutasRestantes -= 1
		if frutasRestantes == 0:
			avanzarNivel()

func aumentarSerpiente() -> void:
	var nuevoSegmento = segmentoSerpiente.instantiate()
	nuevoSegmento.add_to_group("Serpiente")
	nuevoSegmento.position = Vector2(-100, -100)
	colaSerpiente.append(nuevoSegmento)
	add_child(nuevoSegmento)
 
func moverSerpiente() -> void:
	if colaSerpiente.size() > 0 and enPartida:
		for i in range(colaSerpiente.size()-1, 0, -1):
			colaSerpiente[i].position = colaSerpiente[i-1].position
		colaSerpiente[0].position = $Serpiente.position
	$Serpiente.position += velocidad

func limpiarNodosNivel() -> void:
	for nodo in get_children():
		if nodo.is_in_group("Pared") or nodo.is_in_group("Fruta"):
			nodo.queue_free()

func avanzarNivel() -> void:
	nivelActual += 1
	if nivelActual >= niveles.size():
		nivelActual = 0
	limpiarNodosNivel()
	generarLaberinto()

func limpiarSerpiente() -> void:
	for segmento in colaSerpiente:
		segmento.queue_free()
	colaSerpiente.clear()

func comenzarPartida() -> void:
	$textoComenzar.visible = false
	enPartida = true
	velocidad = Vector2(tamanyoCasilla, 0)
	$Serpiente.position = Vector2(10*tamanyoCasilla + tamanyoCasilla/2, 
		7*tamanyoCasilla + tamanyoCasilla/2)
	puntos = 0
	$textoPuntos.text = "0"
	limpiarSerpiente()
	limpiarNodosNivel()
	nivelActual = 0
	generarLaberinto()
	segEspera = 0.400

func terminarPartida() -> void:
	$textoComenzar.visible = true
	velocidad = Vector2(0, 0)
	enPartida = false
