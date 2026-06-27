extends Node
class_name ProjectileModifier

var projectile: Projectile

func _ready() -> void:
	projectile = get_parent().get_parent().find_child("Shoot")

func apply(projectile):
	pass
