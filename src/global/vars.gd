extends Node

enum State {OPENING, PLAYING, PAUSED, GAME_OVER}

var game_state = State.OPENING

var zoom = 1.0
var spawn_scale = Vector2.ZERO

var skill_points = 10
var xp = 0
var xp_steps = [3]
var next_xp_step = 3


var skills = {
		"health1" : false, # Health +20%
		"health2" : false, # Health +50%
		"health3" : false, # Health x2
		"health4" : false, # Get health form DNA
		"health5" : false, # Health regeneration
		"speed1" : false, # Speed +20%
		"speed2" : false, # Speed +50%
		"speed3" : false, # Speed X2
		"speed4" : false, # Chance to dodge?
		"speed5" : false, # Bullet time? Dash?
		"dmg20" : false, # Damage +20%
		"dmg50" : false, # Damage +50%
		"scope" : false, # Range X2
		"dmgx2" : false, # Damage X2
		"rof2" : false, # Rate of fire X2
		"rof3" : false, # Rate of fire X3
		"explosive" : false, # Explosive ammo
		"piercing" : false, # Piercing ammo
		"double" : false, # Fire two bullets
		"triple" : false, # Fire three bullets
		"arm1" : false, # One extra armed arm
		"arm2" : false, # One extra armed arm
		"arm3" : false, # One extra armed arm
		"armsuper" : false, # Extra arms shoot even more
	}


# Bullet
var base_damage = 10.0
var max_random_damage = 4
var speed = 1200.0
var scope = 3000
var impact = 20.0
var piercing = false
var double = false
var triple = false
var explosive = false

func set_damage(base : float, extra : int, imp : float):
	base_damage = base
	max_random_damage = extra
	impact = imp

func set_scope(new_scope : int, new_speed : float):
	scope = new_scope
	speed = new_speed
