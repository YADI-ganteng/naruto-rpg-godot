extends Node
var skills = {
    "rasengan": {"damage": 80, "cp": 30},
    "chidori": {"damage": 90, "cp": 35},
    "amaterasu": {"damage": 120, "cp": 50},
    "ultimate": {"damage": 200, "cp": 100},
}

func use_skill(player, skill_name):
    if skill_name in skills:
        var skill = skills[skill_name]
        if player.cp >= skill.cp:
            player.cp -= skill.cp
            return skill.damage
    return 0
