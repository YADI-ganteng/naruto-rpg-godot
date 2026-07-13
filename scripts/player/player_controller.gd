extends CharacterBody2D

@export var speed = 400
@export var jump_force = -600

var hp = 500
var max_hp = 500
var cp = 200
var max_cp = 200
var is_attacking = false

func _physics_process(delta):
    if is_attacking: return
    
    var direction = Input.get_vector("left", "right", "up", "down")
    velocity = direction * speed
    move_and_slide()
    
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force

func attack():
    is_attacking = true
    await get_tree().create_timer(0.5).timeout
    is_attacking = false

func take_damage(damage):
    hp -= damage
    if hp <= 0:
        die()

func die():
    get_tree().reload_current_scene()

func heal(amount):
    hp = min(hp + amount, max_hp)

func restore_cp(amount):
    cp = min(cp + amount, max_cp)
