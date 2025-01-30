extends Area2D

var growing := false  # Impede múltiplas execuções simultâneas
var growth_stages := [5.0, 15.0, 20.0]  # Tempos de espera entre os estágios
var seeds := 1  # Quantidade de sementes

func _ready() -> void:
	hide()

func handle_seed() -> void:
	if growing:
		return
	growing = true

	# Itera sobre os frames de animação e os tempos de espera
	for i in range(len(growth_stages)):
		$animationCarrot.frame = i
		await get_tree().create_timer(growth_stages[i]).timeout

	# Último frame da cenoura completamente crescida
	$animationCarrot.frame = len(growth_stages)

	growing = false  # Permite reiniciar o crescimento se necessário

func _on_body_entered(_body: Node2D) -> void:
	if seeds > 0:  # Só planta se ainda tiver sementes
		seeds -= 1
		print("encostou - Sementes restantes:", seeds)
		show()
		handle_seed()
	else:
		print("Sem sementes restantes!")
