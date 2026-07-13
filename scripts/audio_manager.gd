extends Node
class_name AudioManager

# Audio players
var bgm_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var voice_player: AudioStreamPlayer

# Volume settings
var master_volume = 1.0
var bgm_volume = 0.7
var sfx_volume = 1.0
var voice_volume = 1.0

func _ready():
    setup_audio_players()

func setup_audio_players():
    bgm_player = AudioStreamPlayer.new()
    sfx_player = AudioStreamPlayer.new()
    voice_player = AudioStreamPlayer.new()
    
    add_child(bgm_player)
    add_child(sfx_player)
    add_child(voice_player)

func play_bgm(bgm_name: String):
    var stream = load("res://assets/audio/bgm/" + bgm_name + ".wav")
    if stream:
        bgm_player.stream = stream
        bgm_player.volume_db = linear_to_db(bgm_volume * master_volume)
        bgm_player.play()

func stop_bgm():
    bgm_player.stop()

func play_sfx(sfx_name: String):
    var stream = load("res://assets/audio/sfx/" + sfx_name + ".wav")
    if stream:
        sfx_player.stream = stream
        sfx_player.volume_db = linear_to_db(sfx_volume * master_volume)
        sfx_player.play()

func play_voice(voice_name: String):
    var stream = load("res://assets/audio/voice/" + voice_name + ".wav")
    if stream:
        voice_player.stream = stream
        voice_player.volume_db = linear_to_db(voice_volume * master_volume)
        voice_player.play()

func set_master_volume(vol: float):
    master_volume = clamp(vol, 0.0, 1.0)

func set_bgm_volume(vol: float):
    bgm_volume = clamp(vol, 0.0, 1.0)

func set_sfx_volume(vol: float):
    sfx_volume = clamp(vol, 0.0, 1.0)

# Combat sounds
func play_attack():
    play_sfx("combat_slash")

func play_hit():
    play_sfx("combat_hit")

func play_critical():
    play_sfx("combat_critical_hit")

func play_block():
    play_sfx("combat_block")

# Skill sounds
func play_rasengan():
    play_sfx("skill_rasengan")

func play_chidori():
    play_sfx("skill_chidori")

func play_explosion():
    play_sfx("skill_explosion")

func play_heal():
    play_sfx("skill_heal")

func play_ultimate():
    play_sfx("skill_ultimate_charge")
    await get_tree().create_timer(0.8).timeout
    play_sfx("skill_ultimate_release")

# UI sounds
func play_click():
    play_sfx("ui_click")

func play_select():
    play_sfx("ui_select")

func play_confirm():
    play_sfx("ui_confirm")

func play_cancel():
    play_sfx("ui_cancel")

func play_level_up():
    play_sfx("ui_level_up")

func play_quest_complete():
    play_sfx("ui_quest_complete")

func play_error():
    play_sfx("ui_error")

# BGM
func play_village_theme():
    play_bgm("village_theme")

func play_battle_theme():
    play_bgm("battle_theme")

func play_boss_theme():
    play_bgm("boss_theme")

func play_victory():
    play_bgm("victory")

func play_game_over():
    play_bgm("game_over")
