<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>Hands free Search</title>
   <link href="https://webfontworld.github.io/nyj/NYJGothic.css" rel="stylesheet">
   <!-- Font Awesome -->
   <link rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
   <!-- CSS only -->
   <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous">
   <!-- JavaScript Bundle with Popper -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>
      
   <!-- Google Fonts -->
   <link href="https://webfontworld.github.io/nyj/NYJGothic.css" rel="stylesheet">
   <!-- Custom styles -->
    <link href="${path}/resources/user/css/search.css" rel="stylesheet" /> 
    <link href="${path}/resources/user/css/customSearch.css" rel="stylesheet" />
   <link href="${path}/resources/user/css/chat.css" rel="stylesheet" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"
      integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw=="
      crossorigin="anonymous"></script>
      <!-- Google tag (gtag.js) -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-R3NH3D2T1E"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-R3NH3D2T1E');
	</script>
   <!-- ????????? -->
   <script src="https://kit.fontawesome.com/418779817b.js" crossorigin="anonymous"></script>
   <!-- Bootstrap icons-->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
   <link href="https://webfontworld.github.io/nyj/NYJGothic.css" rel="stylesheet">
   <!-- sock js -->
   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"></script>
   <!-- STOMP -->
   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
   <!-- ????????? js -->
   <script type="text/javascript" src="${path}/resources/user/js/search.js"></script>
   <!-- ????????? -->
   <link rel="icon" href="${path}/resources/admin/img/loca3.png" /> 
<style>
body{
   font-family:"?????? ??????", "??????", "??????";
}
html, body {
margin: 0px; 
padding: 0px;
}
#wrapper{
   width: 1200px;
   margin: 0 auto;   
}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;margin:10px 0 30px 10px;padding:5px;}


#backBtn{
    font-size: 1.5rem;
    position: absolute;
    top: 0;
    left: 0;
    border: none;
    cursor: pointer;
    border-top-left-radius: 15px;
    margin: 5px;
    text-align: left;
}

</style>


</head>
   <!-- ?????? -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f8465e5d46edf4274cf5a48ed2ce318&libraries=services"></script>
      <script type="text/javascript">
      var lat='';
      var lon='';

      $(document).ready(function(){
    	  
    	  
         
         //?????? ??????
         //webSocket ?????? SockJS??? ??????????????? Stomp.client() ??? ?????? Stomp.over()??? ????????????
         //const socket = new SockJS('http://localhost:8090/websocket');
         const socket = new SockJS('http://54.250.19.196:8080/websocket');
         const stomp = Stomp.over(socket);
         stomp.debug = null; //stomp ???????????? X
         //?????? ????????? ??????
         const subscribe = [];
         
         //   connect(header, connectCallback(????????? ???????????? ???????????? ????????? ))
         stomp.connect({}, function(){
            //main();
         });
         
         
         // ***************** ?????????API *****************
         // ????????? ???????????? ???????????? ????????? ??????????????? ?????????
         var infowindow = new kakao.maps.InfoWindow({zIndex:1});
         var mapContainer = document.getElementById('map'), // ????????? ????????? div 
             mapOption = {
                 center: new kakao.maps.LatLng(37.566826, 126.9786567), // ????????? ????????????
                 level: 3 // ????????? ?????? ??????
             };
         
         // ????????? ???????????????    
         var map = new kakao.maps.Map(mapContainer, mapOption); 

         // ?????? ?????? ????????? ???????????????
         var ps = new kakao.maps.services.Places(); 
         
         if("${destination}" == ""){
            if (navigator.geolocation) {
                 navigator.geolocation.getCurrentPosition(function(position) {
                       lat = position.coords.latitude; // ??????
                       lon = position.coords.longitude; // ??????
                       var locPosition = new kakao.maps.LatLng(lat, lon);
                       var bounds = new kakao.maps.LatLngBounds();
                      var marker = new kakao.maps.Marker({position: locPosition});
                      marker.setMap(map);
                      bounds.extend(locPosition);
                      map.setBounds(bounds);
                      map.setLevel(4);
                      
                      circle(lat, lon);
                      
                 });
            }
         }else{
            // ???????????? ????????? ???????????????
            ps.keywordSearch('<c:out value="${destination}" />', placesSearchCB);
         }
      
            function createList(data){
               const str = data.ADDRESS;
               var address = '';
               if(str.length >= 5){
                  address = str.substr(0,9) + "...";
               }
               const itemList = `
               <div class="shopList">
               
                  <img class="shop_img" alt="??????"
                     src=\${data.PROFILE_PATH }>
                  <div class="shop_info">
                        ????????? ????<br>
                     <h4>\${data.NAME}</h4>
                        \${address}<br>
                     
                  </div>
                  <div class="list_button" data-obj=\${data.STOREID}>
                     <button type="button" class="btn btn-primary" id="detailBtn"
                        style="margin-bottom: 15px; width: 80px; height: 30px; font-size: small;">????????????</button>
                     <br>														
                     <button style="margin-bottom: 15px; width: 80px; height: 30px; font-size: small;" type="button" class="btn btn-primary" onclick="location.href='/users/userBook?STOREID=' + '\${data.STOREID}' + '&sDate=' + '${sDate}' + '&eDate=' + '${eDate}'">????????????</button>
                  </div>
               </div>
               `;
               $('#listGroup').append(itemList);
            }
         // ????????? ?????? ?????? ??? ???????????? ???????????? ?????????
         function placesSearchCB (data, status, pagination) {
             if (status === kakao.maps.services.Status.OK) {
                 // ????????? ?????? ????????? ???????????? ?????? ????????? ?????????????????????
                 // LatLngBounds ????????? ????????? ???????????????
                 var bounds = new kakao.maps.LatLngBounds();

                 for (var i=0; i<data.length; i++) {
                     bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                 }
                 
                 // ????????? ?????? ????????? ???????????? ?????? ????????? ??????????????????lat1
                 map.setBounds(bounds);
                 map.setLevel(4);
               //?????? ?????? ???????????? 
               var lating = map.getCenter();
               var lat = lating.getLat(); //??????
               var lon = lating.getLng(); //??????
               var itemList = radiusItemList();
               $.each(itemList, function(index, obj){
                  var marketCheck = getDistance(obj.LATITUDE, obj.LONGITUDE, lat, lon, obj.NAME);
                  if(marketCheck)
                  {
                     displayMarker(obj);
                     
                     createList(obj);
                  }
               })
               
                                 
               circle(lat, lon);
             } 
         }
         
         // ????????? ????????? ???????????? ???????????????
         function displayMarker(place) {
             // ????????? ???????????? ????????? ???????????????
             var marker = new kakao.maps.Marker({
                 map: map,
                 position: new kakao.maps.LatLng(place.LATITUDE, place.LONGITUDE) 
             });
             // ????????? ?????????????????? ???????????????
             kakao.maps.event.addListener(marker, 'click', function() {
                 // ????????? ???????????? ???????????? ?????????????????? ???????????????
                 infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.NAME + '</div>');
                 infowindow.open(map, marker);
             });
         }
         
         //?????? ?????? ??????
         function getDistance(lat1,lng1,lat2,lng2, place_name) {
             function deg2rad(deg) {
                 return deg * (Math.PI/180)
             }
         
             var R = 6371; // Radius of the earth in km
             var dLat = deg2rad(lat2-lat1);  // deg2rad below
             var dLon = deg2rad(lng2-lng1);
             var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
             var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
             var d = R * c; // Distance in km
             var m = d * 500;
/*               console.log("?????? x : " + lat1);
             console.log("?????? y : " + lng1);
             console.log("?????? x : " + lat2);
             console.log("?????? y : " + lng2);
             console.log("?????? : " + place_name);
             console.log("??????  : " + d);
             console.log("????????????  : " + m); */
             if(m <= 500){
                return true;
             }else{
                return false;   
             }
             
         }
         //?????? 1000?????? ???
         function circle(lat, lon){
            //????????? ??????
            var circle = new kakao.maps.Circle({
                center : new kakao.maps.LatLng(lat, lon),  // ?????? ???????????? ????????? 
                radius: 550, // ?????? ????????? ?????? ?????????????????? 
                strokeWeight: 5, // ?????? ??????????????? 
                strokeColor: '#75B8FA', // ?????? ???????????????
                strokeOpacity: 1, // ?????? ???????????? ????????? 1?????? 0 ????????? ????????? 0??? ??????????????? ???????????????
                strokeStyle: 'dashed', // ?????? ????????? ?????????
                fillColor: '#CFE7FF', // ????????? ???????????????
                fillOpacity: 0.7  // ????????? ???????????? ?????????   
            }); 
            // ????????? ?????? ??????????????? 
            circle.setMap(map); 

         }
         
         
         
         //?????? ????????? ?????? ????????? ?????? ??????
         function radiusItemList(){
            var retval
            $.ajax({
               type : "get",
               url : '/selectStore',
               async :false,
               success : function(data){
                  retval = data;
               },
               error:function(request, status, error){
                  console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
               }
            });
            return retval;
         }

         
/*          $.ajax({
            type : "get",
            url : '/selectStore',
            success : function(data){
               $('#listGroup').empty();
               $.each(data, function(index, obj){
                  createList(obj)
               })
            },
            error:function(request, status, error){
               console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
         })    */
         
         //?????????
         

         
         
         /*  ??????   */
         
         $(document).on("click", "#chatBtn", function(){
           const storeId = $('#chatBtn').data('obj');
            createRoom(storeId);
         })
         
                  //?????? ?????? ?????? ??? ??????
         $(".chat_button_area button").click(function(){
            console.log("????????? ??????");
            console.log(subscribe.length);
            sendMessage();
            $(".chat_input_area textarea").focus();
         })
         
         $(".chat_input_area textarea").keypress(function(event){
            console.log("????????? ??????");
            console.log(subscribe.length);
            if(event.keyCode == 13){
               if(!event.shiftKey){
                  event.preventDefault();
                  sendMessage();
               }
            }
         })
         
         
         
         
         
         /* ??????  */
         
         //?????? ?????????
         function createRoom(storeId){
            //var test = $('#dropdownMenu2').attr('value');
            //var test = $('#dropdownMenu2').text();
            
            var nickname = $('#dropdownMenu2').text().trim();
         console.log(storeId);
         var data = {
               storeId : storeId
         }
            $.ajax({
               url : "/chatingRoom",
               type :  "POST",
               data : data,
               success : function(data){
                  //data??? ???????????? ????????? ????????? ?????????.
                  /* console.log(data); */
                  var roomData = data;
                  $.each(data.users, function(index, obj){
                     if(obj === nickname)
                     {
                        initRoom(roomData, nickname);
                     }      
                  })
                  
               },
                  error:function (request, status, error){
                      console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
                  }
            })
         }
         
         //????????? ?????????      
         function sendMessage(){
            const message = $(".chat_input_area textarea");
            
            if(message.val() == "")
               return
            
            const roomNumber = info.getRoomNumber();
            const nickname = info.getNickname();
            
            const data = {
                  message : message.val()
            }

            stomp.send("/socket/sendMessage/" + roomNumber, {}, JSON.stringify(data));
            message.val("");
         }
         
         //?????? ??????.!!
         function chatingConnect(roomNumber){
            //????????? ?????? ??????
            const id1 = stomp.subscribe("/topic/message/" + roomNumber, function(result){
               const message = JSON.parse(result.body);
               //?????? ?????????
               chating(message);
            })
            // ??????,?????? ????????? ?????? ??????
            const id2 = stomp.subscribe("/topic/notification/" + roomNumber, function(result){
               const room = JSON.parse(result.body);
               const message = room.message;
               userList(room.users);
               const chatHtml = `
                    <li>
                    </li>`;
               
/*                $(".chat ul.chat_list").append(chatHtml); */
               $(".chat ul").scrollTop($(".chat ul")[0].scrollHeight);
            })
         }
         
         //???????????????
         function errorMSG(result){
            if(result.status == 404){
               alert("?????????????????? ?????? ????????????.");
            }else{
               alert("????????? ??????????????????.");
            }
            location.href="${pageContext.request.contextPath}/websocket";
         }
         
         
         /*??????*/
         
         
         /*?????? ?????????*/
         
         
         /* ?????? ?????? ??? ?????? ????????????*/
         const info = (function(){
            let nickname = "";
            let roomNumber = "";
            
            const getNickname = function() {
               return nickname;
            }
            
            const setNickname = function(set){
               nickname = set;
            }
            
            const getRoomNumber = function() {
               return roomNumber;
            }
            
            const setRoomNumber = function(set) {
               roomNumber = set;
            }
            return {
               getNickname : getNickname,
               setNickname : setNickname,
               getRoomNumber : getRoomNumber,
               setRoomNumber : setRoomNumber,
            }
         })();
         /* ?????? ?????? ??? ?????? ????????????*/
         
         function initRoom(roomData, nickname){
            /* $("main").hide(); */
            info.setNickname(nickname);
            info.setRoomNumber(roomData.roomNumber);

            $(".chat").show();
            /* $(".chat .chat_title").text(roomData.roomName); */
            chatingConnect(roomData.roomNumber);
            
            $(".chat_input_area textarea").focus();
            
         }
         
         function userList(users){
            $(".chat .chat_users .user").text(users.length + "???");
            
            let userHtml = "";
            for(let i=0;i<users.length;i++){
               userHtml += `
                  <li>\${users[i]}</li>`;
            }
            
            $(".chat .chat_nickname ul").html(userHtml);
         }
         /*?????? ?????????*/
         
         
         /* ???????????? ????????? */
         
         function listHtml(roomList){
            let listHtml = "";
            
            for(let i=0; i<roomList.length; i++){
               listHtml += `
                  <li data-room_number=\${roomList[i].roomNumber}>
                     <span class="chat_title">\${roomList[i].roomName}</span>
                     <span class="chat_count">\${roomList[i].users.length}???</span>
                  </li>`;
            }
            $("main ul").html(listHtml);
         }
         

         
          // ????????? ?????????
         function chating(messageInfo){
            console.log(messageInfo);
             let nickname = messageInfo.userId;
             let message = messageInfo.content;
             
             message = message.replaceAll("\n", "<br>").replaceAll(" ", "&nbsp");
             
             
             const date = messageInfo.sdate;
             const d = new Date(date);
             const time = String(d.getHours()).padStart(2, "0") 
            + ":" 
            + String(d.getMinutes()).padStart(2, "0");
             
             let sender ="";
             
             if(info.getNickname() == nickname) {
                sender = "chat_me";
                nickname = "";
             } else {
                sender=  "chat_other";
             }
             
             const chatHtml = `
                  <li>
                      <div class=\${sender}>
                         <div>
                            <div class="nickname">\${nickname}</div>
                            <div class="message">
                                <span class=chat_in_time>\${time }</span>
                                <span class="chat_content">\${message}</span>
                             <span>
                          </div>
                      </div>
                  </li>`;
             $(".chat ul.chat_list").append(chatHtml);
             $(".chat ul").scrollTop($(".chat ul")[0].scrollHeight);
         
          }
         
         /* ???????????? ????????? */
   })
   </script>   

<body>
   <!--Main Navigation-->

      <!-- ?????? ???????????? -->
      <!-- Sidebar -->
      <nav style="background-color: #f8f8fb" id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-white">
         <div class="position-sticky">
            <div id="listGroup" class="list-group list-group-flush mx-2 mt-4">
            </div>
            
         </div>
      </nav>

      <%
         pageContext.include("/WEB-INF/views/include/header.jsp");
      %>
      <!--Main layout-->
      <main style="margin-top: 58px">
         <div class="container pt-4">
            <section class="mb-4">
               <div class="card">
                  
                  <div id="map" class="card-body">
                     <canvas class="my-4 w-100" height="500"></canvas>                     
                  </div>
                  <div id="menu_wrap" class="chat" draggable="true">
                     <div>
                        <div id="chat_body" class="chat_body">
                           <h2 class="chat_title"></h2>
                           <button class="chat_back"><i class="bi bi-caret-left"></i></button>
   
                           <ul class="chat_list">
                              <li></li>
                           </ul>
   
                           <div class="chat_input">
                              <div class="chat_input_area">
                                 <textarea class="textareaF"></textarea>
                              </div>
   
                              <div class="chat_button_area">
                                 <button>??????</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </section>
         </div>
      </main>
      
      
</body>
</html>