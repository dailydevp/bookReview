
$(function() {
	
	$("#listPagenation a").click(function (e) {
		e.preventDefault();
		
		console.log("a요소 클릭됨");
		
	var actionForm = $("#actionForm");
	
	actionForm.find("[name=pageNo]").val($(this).attr("href"));
	
	actionForm.submit();
	});
	
});

$(function () {
	if(history.state == null){
		$("#board-modal").modal('show');
		history.replaceState({},null);
	}
})
