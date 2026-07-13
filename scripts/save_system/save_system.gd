extends Node

var save_path = "user://savegame.save"

func save_game(player_data, world_data):
    var save_dict = {
        "player": player_data,
        "world": world_data,
        "timestamp": Time.get_unix_time_from_system()
    }
    var file = FileAccess.open(save_path, FileAccess.WRITE)
    file.store_var(save_dict)
    print("Game saved!")

func load_game():
    if not FileAccess.file_exists(save_path):
        return null
    var file = FileAccess.open(save_path, FileAccess.READ)
    var save_dict = file.get_var()
    print("Game loaded!")
    return save_dict

func delete_save():
    if FileAccess.file_exists(save_path):
        DirAccess.remove_absolute(save_path)
        print("Save deleted!")
