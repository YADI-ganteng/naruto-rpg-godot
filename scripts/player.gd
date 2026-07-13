extends CharacterBody2D
var speed = 400
var hp = 500
var max_hp = 500
var cp = 200
var max_cp = 200
var gold = 0
var level = 1
var attack_power = 50

func _ready():
    print("Player ready!")

func _physics_process(delta):
    var direction = Input.get_vector("left", "right", "up", "down")
    velocity = direction * speed
    move_and_slide()

func attack():
    print("Attack! Damage: ", attack_power)

func skill():
    if cp < 30: return
    cp -= 30
    attack_power = 80

func ultimate():
    if cp < 100: return
    cp -= 100
    attack_power = 200

func take_damage(damage):
    hp -= damage
    if hp <= 0:
        die()

func die():
    get_tree().reload_current_scene()
