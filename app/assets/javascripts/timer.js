function Timer() {
	// this.it = 1;
	// 	this.get_it = function() {
	// 		return this.it;
	// 	};
	
	this.start_time = 0;
	this.end_time = 0;
	this.astart = function() {
		this.start_time = new Date().getTime();
	};
	this.astop = function() {
		this.end_time = new Date().getTime();
	};
	this.elapsed = function() {
		return this.end_time - this.start_time;
	};
}