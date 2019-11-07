/**
 * 
 */

var date = new Date();
var fullyear = date.getFullYear();
var month = date.getMonth() + 1;
var day = date.getDate();

if (month < 10) {
	month = "0" + month;
}

if (day < 10) {
	day = "0" + day;
}

var today = fullyear + "-" + month + "-" + day;
var today1 = fullyear + "-" + month + "-" + day;

$(function() { // document ready
	/*
	 * initialize the external events
	 * -----------------------------------------------------------------
	 */
	$('#external-events .fc-event').each(function() {
		// store data so the calendar knows to render an event upon drop
		$(this).data('event', {
			title : $.trim($(this).text()), // use the element's text as the
											// event title
			stick : true
		// maintain when user navigates (see docs on the renderEvent method)
		});

		// make the event draggable using jQuery UI
		$(this).draggable({
			zIndex : 999,
			revert : true, // will cause the event to go back to its
			revertDuration : 0
		// original position after the drag
		});

	});
	
	/*
	 * initialize the calendar
	 * -----------------------------------------------------------------
	 */
	
	$('#calendar').fullCalendar({
				height : 892,
				now : date,
				defaultDate: today,
				editable : true, // enable draggable events 
				droppable : true, // this allows things to be dropped onto the
				aspectRatio : 1.8,
				scrollTime : '00:00', // undo default 6am scrollTime
				header : {
					left : 'prev',
					center : 'title',
					right : 'next'
				},
				titleFormat : {
					month : "YYYY년 MMMM",
					day : "YYYY년 MMM D일 dddd"
				},
				monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
						"9월", "10월", "11월", "12월" ],
				monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
						"8월", "9월", "10월", "11월", "12월" ],
				dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
				dayNamesShort : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
				buttonText : {
					today : "오늘",
					month : "월별",
					week : "주별",
					day : "일별",
					timelineThreeDays : "3일"
				},
				defaultView : 'month',
				views : {
					timelineThreeDays : {
						type : 'timeline',
						duration : {
							days : 3
						}
					}
				},
				eventOverlap : true,
				resourceAreaWidth : '162px',
				resourceLabelText : '일정　',
				resourceGroupField : 'title',
				resources : {
					url : "opt.do?command=calendar",
					type : 'post'
				},
				businessHours: {
					  // days of week. an array of zero-based day of week integers (0=Sunday)
					  dow: [ 1, 2, 3, 4, 5 ], 
				},
				
				drop : function() {
					// is the "remove after drop" checkbox checked?
					if ($('#drop-remove').is(':checked')) {
						// if so, remove the element from the "Draggable Events"
						// list
						$(this).remove();
					}
				},

				eventRender : function (event, element) {
					element.find('.fc-title').html(element.find('.fc-title').text());
				},
				
				eventReceive : function(event) { // 새목록 추가시
					// called when a proper external event is dropped
					console.log('eventReceive', event);
				},
				
				eventDrop : function(event) { // 막대 옮길때
					var id = event.id;
					var start = moment(event.start).format('YYYY-MM-DD');
					var end = moment(event.end).format('YYYY-MM-DD');
					var date = new Date(end);
					var end_date = moment(date.setDate(date.getDate()-1)).format('YYYY-MM-DD');
					//var title = event.title;
					//var color = event.color;
					$.ajax({
						url: "opt.do?command=updateDrop&idx=" + id + "&start=" + start + "&end=" + end_date,
						error : function() {
							alert("전송실패");
						},
						success : function() {
							window.location.reload();
						}
					});
				},

				eventResize : function(event) { // 사이즈 늘이기, 줄이기
					//var title = event.title;
					//var color = event.color;
					var id = event.id;
					var start = moment(event.start).format('YYYY-MM-DD ');
					var end = moment(event.end).format('YYYY-MM-DD ');
					var date = new Date(end);
					var end_date = moment(date.setDate(date.getDate()-1)).format('YYYY-MM-DD');
					//console.log(date.toLocaleString());
					$.ajax({
						url : "opt.do?command=updateResize&idx=" + id + "&start=" + start + "&end=" + end_date,
						error : function() {
							alert("전송실패");
						},
						success : function() {
							window.location.reload();
						}
					});
				},
				
			/*	dayClick : function(event) {
					var url = encodeURI("addSchedule.do?event="+ event);

					cw = screen.availWidth;
					ch = screen.availHeight;
					
					sw=1024;    //띄울 창의 넓이
					sh=screen.height - 440;    //띄울 창의 높이

					ml = (cw - sw) / 2;
					mt = (ch - sh) / 2;

					window.open(url, 'event', 'width=' + sw + ',height=' + sh+ ',top=' + mt + ',left=' + ml+ ',resizable=no,scrollbars=yes');
				},*/

				eventClick : function(event) { //이벤트 클릭시
					var title = event.title;
					var id = event.id;
					var start = moment(event.start).format('YYYY-MM-DD');
					var end = moment(event.end).format('YYYY-MM-DD');
					var color = event.color;
					
					cw = screen.availWidth;
					ch = screen.availHeight;
					
					sw=500;    //띄울 창의 넓이
					sh=300;    //띄울 창의 높이

					ml = (cw - sw) / 2;
					mt = (ch - sh) / 2;

					var url = encodeURI("opt.do?command=caldetail&id=" + id);
					window.open(url, 'name444', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
					/*var url = encodeURI("scheduleDetail.do?idx="+ id);
					window.open(url, 'name444', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);*/
				},
				
				events : function(start, end, timezone, callback) { // 페이지로딩시
					$.ajax({
						url : "opt.do?command=calendar",
						dataType : 'json',
						async:false,
						error:function(request, status, error){
			    			 alert("request : " + request + "status :" + status + "error : " +error);
			    		},
						success : function(data) {
							var events = [];
							var title = [];
							var start = [];
							var end = [];
							var id = [];
							var nextDate = "";
							var count = 0;
							for (var i = 0; i < data.cal.length; i++) {
								title[i] = data.cal[i].title;
			                    start[i] = data.cal[i].start;
			                    end[i] = data.cal[i].end;
			                    id[i] = data.cal[i].id;
			                    count = data.cal[i].count;
			                    if(count != 0) {
			                    	nextDate = moment(data.cal[i].nextdate).format('YYYY-MM-DD');
			                    } else {
			                    	nextDate = data.cal[i].end;
			                    }

								events.push({
									"title" : title[i],
									"start" : start[i],
									"end" : nextDate,
									"id" : id[i]
								});
							}
							callback(events);
						}
					});
				}
			});
});