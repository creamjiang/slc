// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require h5bp
//= require jquery.ui.all

$(".focus_dropdown").click(function(){
    if($(".focus_details").css("display") == "none"){
        $(".focus_details").show('fast');
        $(".plus_minus h3").html("-");
    }
    else{
        $(".focus_details").hide('fast');
        $(".plus_minus h3").html("+");
    }
});

$(function() {
    $('#info').click(function() {
        $( "#dialog" ).dialog();
    });
});
$(".comment_button").click(function(){
    $(".comment_button").hide();
    $(".comment_buttons").show();
    $(".comment_form").show();
});

$(".comment_submit").click(function(){
    $(".comment_form").hide()
    $(".comment_buttons").hide();
    $(".comment_reply").show();
});

$(".comment_cancel").click(function(){
    $(".comment_form").hide()
    $(".comment_buttons").hide();
    $(".comment_button").show();
});
