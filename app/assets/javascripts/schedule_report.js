function report(){
  if($("#startDate").val().trim() != ""){
    optionReport = $("#option").val();
    //var url = optionReport != "" || optionReport != "abscence" ? '/admins/'+$("#employeeId").val() + "/doReportDays/" : '/admins/'+$("#employeeId").val() + "/doReport/";
    data = {startDate: $("#startDate").val().trim(), endDate: $("#endDate").val().trim(), id:$("#employeeId").val(), option: optionReport};
    $.ajax({
      url:'/admins/'+$("#employeeId").val() + "/doReport/",
      data:data,
      success:function(response){
        //console.log(response);
        $("#tableReport").html(response);
      },
      error: function(error){
        alert("An error ocurred: " + error);
      }
    });
  }else{
    $("#tableReport").children().remove();
  }
}

$( document ).ready(function() {

  $(".date").datepicker({
    format: "yyyy-mm-dd",
    autoclose: true
  });

  $(".date").on("change",function(){
    report();
  });

  $('[data_toggle="optionsReport"] > .btn').click(function() {
    var button = $(this).find("input")[0];
    $('#option').val($(button).attr("id"));
    report();
  });
});
