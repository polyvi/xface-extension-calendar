describe('Calendar (xFace.ui.Calendar)', function () {
	/**define some constants*/
	var MAX_YEARS    = 2100;
	var MAX_MONTHS   = 12;
	var MAX_DAYS     = 31;
	var MAX_HOURS    = 23;
	var MAX_MINUTES  = 59;
	var MIN_YEARS    = 1900;
	var MIN_MONTHS   = 1;
	var MIN_DAYS     = 1;
	var MIN_HOURS    = 0;
	var MIN_MINUTES  = 0;

    it("calendar.spec.1 should exist", function() {
        expect(xFace.ui.Calendar).toBeDefined();
    });

    it("calendar.spec.2 should contain a getTime function", function() {
        expect(xFace.ui.Calendar.getTime).toBeDefined();
        expect(typeof xFace.ui.Calendar.getTime == 'function').toBe(true);
    });

    it("calendar.spec.3 should contain a getDate function", function() {
        expect(xFace.ui.Calendar.getDate).toBeDefined();
        expect(typeof xFace.ui.Calendar.getDate == 'function').toBe(true);
    });

    describe("getTime method", function() {
        it("calendar.spec.4 it should be  error  with hour over 23", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var hour = 24;
			var minute = 14;
            runs(function () {
                xFace.ui.Calendar.getTime(win, fail, hour, minute);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.5 it should be  error  with hour less 0", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var hour = -1;
			var minute = 14;
            runs(function () {
                xFace.ui.Calendar.getTime(win, fail, hour, minute);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.6 it should be  error  with minutes over 59", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var hour = 22;
			var minute = 60;
            runs(function () {
                xFace.ui.Calendar.getTime(win, fail, hour, minute);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.7 it should be  error  with minutes less 0", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var hour = 22;
			var minute = -1;
            runs(function () {
                xFace.ui.Calendar.getTime(win, fail, hour, minute);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });
    });

    describe("getDate method", function() {
        it("calendar.spec.8 it should be  error  with year over 2100", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 2101;
			var month = 11;
			var day = 14;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.9 it should be  error  with year less 1900", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 1899;
			var month = 11;
			var day = 14;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.10 it should be  error  with month over 12", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 2012;
			var month = 13;
			var day = 14;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.11 it should be  error  with month less 1", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 2012;
			var month = 0;
			var day = 14;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.12 it should be  error  with day over 31", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 2012;
			var month = 11;
			var day = 32;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });

        it("calendar.spec.13 it should be  error  with day less 1", function() {
            var win = jasmine.createSpy(),
                fail = jasmine.createSpy().andCallFake(function() {
                });
			var year = 2012;
			var month = 11;
			var day = 0;
            runs(function () {
                xFace.ui.Calendar.getDate(win, fail, year, month , day);
            });
            waitsFor(function () { return fail.wasCalled; }, "fail never called", Tests.TEST_TIMEOUT);
            runs(function () {
                expect(win).not.toHaveBeenCalled();
            });
        });
    });
});
