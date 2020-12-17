//タブ表示
$(document).ready(function() {
    $('#tab-contents .tab[id != "tab1"]').hide();

    $('#tab-menu a').on('click', function(event) {
      $("#tab-contents .tab").hide();
      $("#tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
});

//画像プレビュー表示
$(document).ready(function(){
    function readURL(input) {
      if(input.files && input.files[0]){
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#file").change(function(){
      readURL(this);
    });
  });

//アコーディオン表示
$(document).ready(function(){
  $("#acMenu dt").on("click", function() {
    $(this).next().slideToggle();
  });
});