// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// require jquery_ujs
//= require jquery
//= require jquery.jscroll.min.js
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load', function(){
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });

  $('.menu-trigger').on('click',function(event){
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
      // event.PreventDefault();
  });

  $("#images").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'fade',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'block',
    // 子要素の種類("div" or "img")
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 3000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });

  $(window).on('load scroll', function(){
    //現時点のスクロールの高さ取得
    var scrollPosition = $(window).scrollTop();
    //ウィンドウの高さ取得
    var windowHeight = $(window).height();

    $('.animation_box').each(function(){
      //要素の位置（高さ）を取得
      var elemPosition = $(this).offset().top;
      //スクロールの高さが要素の位置を超えたら以下のスタイルを適用
      if(elemPosition < scrollPosition + windowHeight){
        $(this).css({
          opacity: 1,
          transform: 'translateX(0)'
        });
      }
    });
  });

  $(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
      $('.jscroll').jscroll({
        contentSelector: '.scroll-list',
        nextSelector: 'span.next:last a'
      });
    }
  });

  var getMap = (function() {
  function codeAddress(address) {
    // google.maps.Geocoder()コンストラクタのインスタンスを生成
    var geocoder = new google.maps.Geocoder();
    // 地図表示に関するオプション
    var mapOptions = {
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // 地図を表示させるインスタンスを生成
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    //マーカー変数用意
    var marker;
    // geocoder.geocode()メソッドを実行
    geocoder.geocode( { 'address': address}, function(results, status) {
      // ジオコーディングが成功した場合
      if (status == google.maps.GeocoderStatus.OK) {
        // 変換した緯度・経度情報を地図の中心に表示
        map.setCenter(results[0].geometry.location);
        //☆表示している地図上の緯度経度
        document.getElementById('lat').value=results[0].geometry.location.lat();
        document.getElementById('lng').value=results[0].geometry.location.lng();
        // マーカー設定
        marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
      // ジオコーディングが成功しなかった場合
      } else {
        console.log('Geocode was not successful for the following reason: ' + status);
      }
    });
    // マップをクリックで位置変更
    map.addListener('click', function(e) {
      getClickLatLng(e.latLng, map);
    });
    function getClickLatLng(lat_lng, map) {
      //☆表示している地図上の緯度経度
      document.getElementById('lat').value=lat_lng.lat();
      document.getElementById('lng').value=lat_lng.lng();
      // マーカーを設置
      marker.setMap(null);
      marker = new google.maps.Marker({
        position: lat_lng,
        map: map
      });
      // 座標の中心をずらす
      map.panTo(lat_lng);
    }
  }
  //inputのvalueで検索して地図を表示
  return {
    getAddress: function() {
      // ボタンに指定したid要素を取得
      var button = document.getElementById("map_button");
      // ボタンが押された時の処理
      if (button != null) {
        //ボタンが存在した場合
        //ボタンが押された時の処理
        button.onclick = function() {
        // フォームに入力された住所情報を取得
        var address = document.getElementById("address").value;
        // 取得した住所を引数に指定してcodeAddress()関数を実行
        codeAddress(address);
        }
      }
      //読み込まれたときに地図を表示
      window.onload = function(){
        if ( document.getElementById("address")  != null){
          // フォームに入力された住所情報を取得
          var address = document.getElementById("address").value;
          // 取得した住所を引数に指定してcodeAddress()関数を実行
          codeAddress(address);
        }
      }
    }
  };
})();
getMap.getAddress();
});
