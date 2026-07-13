extends Node
var items = []
var max_slots = 20
var gold = 0

func add_item(item_name, quantity = 1):
    for i in range(quantity):
        if items.size() < max_slots:
            items.append(item_name)
            print("Added: ", item_name)
            return true
    return false

func remove_item(item_name, quantity = 1):
    for i in range(quantity):
        var idx = items.find(item_name)
        if idx != -1:
            items.remove_at(idx)

func has_item(item_name):
    return item_name in items

func count_item(item_name):
    return items.count(item_name)

func add_gold(amount):
    gold += amount

func remove_gold(amount):
    if gold >= amount:
        gold -= amount
        return true
    return false

func save():
    var save_data = {"items": items, "gold": gold}
    var file = FileAccess.open("user://inventory.save", FileAccess.WRITE)
    file.store_var(save_data)

func load():
    if FileAccess.file_exists("user://inventory.save"):
        var file = FileAccess.open("user://inventory.save", FileAccess.READ)
        var save_data = file.get_var()
        items = save_data.items
        gold = save_data.gold
