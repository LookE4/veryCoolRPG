/// @description Insert description here
var _numSlots = gamepad_get_device_count();

for (var i = 0; i < _numSlots; i++) {
	if (gamepad_is_connected(i)) {
		global.controle = i;
	}
}