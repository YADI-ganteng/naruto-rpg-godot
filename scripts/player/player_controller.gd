extends CharacterBody2D

# Signals
signal player_died
signal player_attacked(target)
signal player_used_skill(skill_name)

# Movement
@export var speed = 400
@export var jump_force = -600
@export var dash_speed = 1000

# Stats
var hp = 500
var max_hp = 500
var cp = 200
var max_cp = 200
var gold = 0
var level = 1
var exp = 0
var kills = 0
var attack_power = 50
var defense = 20

# States
var is_attacking = false
var is_dashing = false
var is_jumping = false
var is_invincible = false
var facing_right = true

# References
@onready var sprite = $Sprite2D
@onready var attack_area = $AttackArea
@onready var camera = $Camera2D
@onready var hp_bar = $HPBar
@onready var cp_bar = $CPBar
@onready var name_label = $NameLabel
@onready var animation_player = $AnimationPlayer

func _ready():
    hp_bar.max_value = max_hp
    hp_bar.value = hp
    cp_bar.max_value = max_cp
    cp_bar.value = cp
    name_label.text = "Naruto"

func _physics_process(delta):
    if is_attacking or is_dashing:
        return
    
    # Movement
    var direction = Input.get_vector("left", "right", "up", "down")
    velocity = direction * speed
    
    # Flip sprite
    if direction.x != 0:
        facing_right = direction.x > 0
        sprite.flip_h = !facing_right
        attack_area.position.x = 30 if facing_right else -30
    
    move_and_slide()
    
    # Jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force
    
    # Dash
    if Input.is_action_just_pressed("dash") and cp >= 20:
        dash()
    
    # Regenerate
    if cp < max_cp:
        cp += 3 * delta
        cp_bar.value = cp

func _input(event):
    if Input.is_action_just_pressed("attack"):
        attack()
    if Input.is_action_just_pressed("skill"):
        use_skill()
    if Input.is_action_just_pressed("ultimate"):
        use_ultimate()
    if Input.is_action_just_pressed("interact"):
        interact()

func attack():
    if is_attacking: return
    is_attacking = true
    
    animation_player.play("attack")
    
    # Check hit
    for body in attack_area.get_overlapping_bodies():
        if body.has_method("take_damage"):
            body.take_damage(attack_power)
            emit_signal("player_attacked", body)
    
    await get_tree().create_timer(0.3).timeout
    is_attacking = false

func use_skill():
    if cp < 30: return
    cp -= 30
    cp_bar.value = cp
    attack_power = 80
    attack()
    attack_power = 50

func use_ultimate():
    if cp < 100: return
    cp -= 100
    cp_bar.value = cp
    attack_power = 200
    attack()
    attack_power = 50

func dash():
    if is_dashing: return
    is_dashing = true
    cp -= 20
    
    var dash_direction = 1 if facing_right else -1
    var tween = create_tween()
    tween.tween_property(self, "position:x", position.x + dash_direction * 100, 0.15)
    tween.tween_callback(func(): is_dashing = false)

func interact():
    for body in $InteractArea.get_overlapping_bodies():
        if body.has_method("on_interact"):
            body.on_interact(self)

func take_damage(damage):
    if is_invincible: return
    
    var actual_damage = max(1, damage - defense)
    hp -= actual_damage
    hp_bar.value = hp
    
    # Flash red
    sprite.modulate = Color.RED
    await get_tree().create_timer(0.1).timeout
    sprite.modulate = Color.WHITE
    
    if hp <= 0:
        die()

func heal(amount):
    hp = min(hp + amount, max_hp)
    hp_bar.value = hp

func add_exp(amount):
    exp += amount
    if exp >= level * 100:
        level_up()

func level_up():
    level += 1
    exp = 0
    max_hp += 50
    hp = max_hp
    max_cp += 20
    cp = max_cp
    attack_power += 10
    defense += 5
    
    hp_bar.max_value = max_hp
    hp_bar.value = hp
    cp_bar.max_value = max_cp
    cp_bar.value = cp
    
    print("Level Up! Now Level ", level)

func die():
    emit_signal("player_died")
    queue_free()

func save_data():
    return {
        "hp": hp,
        "max_hp": max_hp,
        "cp": cp,
        "max_cp": max_cp,
        "gold": gold,
        "level": level,
        "exp": exp,
        "kills": kills,
        "position": {"x": position.x, "y": position.y}
    }

func load_data(data):
    hp = data.hp
    max_hp = data.max_hp
    cp = data.cp
    max_cp = data.max_cp
    gold = data.gold
    level = data.level
    exp = data.exp
    kills = data.kills
    position = Vector2(data.position.x, data.position.y)
