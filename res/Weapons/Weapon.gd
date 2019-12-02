extends Node2D

var projectile_resources := preload("res://Weapons/Projectiles/Fireball.tscn")
var projectiles_node: Node2D
var firing_interval := 0.2
var can_fire := true
var group

onready var timer = $Timer

func reload_gun():
	can_fire = true

func setup_weapon(firing_field: Node2D , group_: int):
	group = group_
	projectiles_node = firing_field

func _ready():
	timer.set_wait_time(firing_interval)

func fire(position: Vector2 , angle: float , spaceship_speed: Vector2):
	if not can_fire:
		return
	
	var radians_angle = deg2rad(angle)
	var projectile = projectile_resources.instance()
	projectile.set_projectile_trajectory(
			position + Vector2(cos(radians_angle) , sin(radians_angle)) * 93,
			angle,
			spaceship_speed
	)
	projectile.group = group
	projectiles_node.add_child(projectile)
	
	timer.start()
	can_fire = false
