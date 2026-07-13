extends Node

var learned_skills = []
var equipped_skills = []

func _ready():
    load_skills_data()

func load_skills_data():
    var file = FileAccess.open("res://data/skills.json", FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text())
    for skill_name in data:
        learned_skills.append(skill_name)

func learn_skill(skill_name):
    if skill_name not in learned_skills:
        learned_skills.append(skill_name)
        print("Learned: ", skill_name)

func equip_skill(skill_name, slot):
    if slot < 4:
        if equipped_skills.size() <= slot:
            equipped_skills.resize(slot + 1)
        equipped_skills[slot] = skill_name

func use_skill(slot, user):
    if slot < equipped_skills.size():
        var skill_name = equipped_skills[slot]
        return get_skill_data(skill_name)
    return null

func get_skill_data(skill_name):
    var file = FileAccess.open("res://data/skills.json", FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text())
    return data.get(skill_name, null)
