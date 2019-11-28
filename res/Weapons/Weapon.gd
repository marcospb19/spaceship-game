extends Node

var projectile_resources := preload("res://Weapons/Projectiles/Fireball.tscn")
var projectiles_node: Node2D

func setup_weapon(firing_field: Node2D):
	projectiles_node = firing_field

func fire(position: Vector2 , angle: float , spaceship_speed: float):
	var radians_angle = deg2rad(angle)
	var projectile = projectile_resources.instance()
	projectile.set_projectile_trajectory(
			position + Vector2(cos(radians_angle) , sin(radians_angle)) * 93,
			angle,
			spaceship_speed
	)
	projectiles_node.add_child(projectile)
	print("Fire In The Hole!")
