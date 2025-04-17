extends Label

var format_string = "%d. %s %d I %d:%d"

var month_arr: Array = ["NaM","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]

func _process(_delta: float) -> void:
	var date = Time.get_datetime_dict_from_system()
	text = format_string % [date.day, month_arr[date.month], date.year, date.hour, date.minute]
