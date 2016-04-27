_package = _this select 1;
_response = _package select 0;
_responseType = _package select 1;
//send the notification
[_responseType,[_response]] call ExileClient_gui_notification_event_addNotification;
