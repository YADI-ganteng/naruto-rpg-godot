extends Node
var active=[]
var done=[]
func accept(q):active.append(q)
func complete(q):active.erase(q);done.append(q)
