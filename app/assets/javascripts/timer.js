function Timer() {
	this.startTime = 0;
	this.endTime = 0;
	this.start = function() {
		this.startTime = new Date().getTime();
	};
	this.stop = function() {
		this.endTime = new Date().getTime();
	};
	this.elapsed = function() {
		return this.endTime - this.startTime;
	};
}