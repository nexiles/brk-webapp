function prettyDate(date_str){
	var time_formats = [
	[60, 'Jetzt', 1], // 60
	[120, 'vor einer Minute', '1 minute from now'], // 60*2
	[3600, 'Minuten', 60], // 60*60, 60
	[7200, 'vor einer Stunde', '1 hour from now'], // 60*60*2
	[86400, 'Stunden', 3600], // 60*60*24, 60*60
	[172800, 'Gestern', 'tomorrow'], // 60*60*24*2
	[604800, 'Tagen', 86400], // 60*60*24*7, 60*60*24
	[1209600, 'letzte Woche', 'next week'], // 60*60*24*7*4*2
	[2419200, 'Wochen', 604800], // 60*60*24*7*4, 60*60*24*7
	[4838400, 'letzten Monat', 'next month'], // 60*60*24*7*4*2
	[29030400, 'Monate', 2419200], // 60*60*24*7*4*12, 60*60*24*7*4
	[58060800, 'letztes Jahr', 'next year'], // 60*60*24*7*4*12*2
	[2903040000, 'Jahre', 29030400], // 60*60*24*7*4*12*100, 60*60*24*7*4*12
	[5806080000, 'last century', 'next century'], // 60*60*24*7*4*12*100*2
	[58060800000, 'centuries', 2903040000] // 60*60*24*7*4*12*100*20, 60*60*24*7*4*12*100
	];
	var time = ('' + date_str).replace(/-/g,"/").replace(/[TZ]/g," ").replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(time.substr(time.length-4,1)==".") time =time.substr(0,time.length-4);
	var seconds = (new Date - new Date(time)) / 1000;
	var token = 'vor', list_choice = 1;
	if (seconds < 0) {
		seconds = Math.abs(seconds);
		token = 'vor';
		list_choice = 2;
	}
	var i = 0, format;
	while (format = time_formats[i++])
		if (seconds < format[0]) {
			if (typeof format[2] == 'string')
				return format[list_choice];
			else
				return token + ' ' + Math.floor(seconds / format[2]) + ' ' + format[1];
		}
	return time;
};
