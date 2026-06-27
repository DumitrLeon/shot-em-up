extends Sprite2D
class_name weapon

@export var weapon_data:WeaponData

var projectile: Projectile
var modifiers: Array[ProjectileModifier] = []

func _ready() -> void:
	projectile = $Shoot
	apply_modifiers()

func shoot():
	apply_modifiers()
	var shoot: Projectile = $Shoot.duplicate()
	shoot.damage = weapon_data.damage
	
	get_tree().current_scene.add_child(shoot)
	shoot.monitoring = true
	shoot.position = to_global(shoot.position)
	shoot.visible = true
	shoot.travel(weapon_data.projectile_speed)

func apply_modifiers():
	for modifier in find_child("Modifiers").get_children():
		if modifier is ProjectileModifier:
			modifiers.append(modifier)
