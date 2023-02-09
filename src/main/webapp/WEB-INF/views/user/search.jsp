<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>Hands free Search</title>
	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<!-- Font Awesome -->
	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
	<!-- Google Fonts Roboto -->
	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" />
	
	<!-- Custom styles -->
	<link href="${path}/resources/user/css/search.css" rel="stylesheet" />
	<link href="${path}/resources/user/css/customSearch.css" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"
		integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw=="
		crossorigin="anonymous"></script>
	
	<!-- 아이콘 -->
	<script src="https://kit.fontawesome.com/418779817b.js" crossorigin="anonymous"></script>
	
	<!--Main layout-->
	<!-- MDB -->
<!-- 	<script type="text/javascript" src="js/mdb.min.js"></script>
	Custom scripts
	<script type="text/javascript" src="js/admin.js"></script>
 -->


</head>
	<!-- 지도 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f8465e5d46edf4274cf5a48ed2ce318&libraries=services"></script>


		<script type="text/javascript">
		$(document).ready(function(){
			
			// ***************** 카카오API *****************
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places(); 
			
			if (navigator.geolocation) {
				  navigator.geolocation.getCurrentPosition(function(position) {
				        var lat = position.coords.latitude, // 위도
				            lon = position.coords.longitude; // 경도
				        var locPosition = new kakao.maps.LatLng(lat, lon);
				        console.log(locPosition);
				        displayMarker(locPosition);
				  });
			}
			
			
			// 키워드로 장소를 검색합니다
			ps.keywordSearch('<c:out value="${destination}" />', placesSearchCB);	

			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
			
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();
			
			        for (var i=0; i<data.length; i++) {
			            displayMarker(data[i]);    
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			    } 
			}
			
			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(place.y, place.x) 
			    });
			
			    // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			    });
			}
			
			$(document).on("click", "#detailBtn", function(){
/* 				var data = $(this).parent();
				console.log(data);
				var data1 = $(this).parents()
				console.log(data1); */
				var list_data = $(this).parents().eq(1);
				var title = list_data.find("h4").text();
				console.log(title);
				var data = {
						title : list_data.find("h4").text(),
						name : 'asd'
				};
				console.log(data);
				/* console.log(JSON.stringify(data)); */
 			$.ajax({
					type : "get",
					url : 'item',
					data:data,
					success : function(data){
						console.log(data);
						createForm(data);
						
						/* $('#listGroup').empty();
						var jsonData = JSON.parse(data);
						$('#listGroup').append */
						
					},
					error:function (request, status, error){
		                   console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
		            }
				}) 
			});

			
			
			
			
			$(document).on("click", "#information", function(){
				var list_data = $(this).parents().eq(1);
				var title = list_data.find("h4").text();
				console.log(title);
				var data = {
						title : title,
						type : 'information'
				};
				
				$.ajax({
					type : "get",
					url : 'item/information',
					data:data,
					success : function(data){
						console.log(data);
						createTabView(data, 'information');
					},
					error:function (request, status, error){
		                   console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
		            }
				}) 
			});
			
			$(document).on("click", "#review", function(){
				var list_data = $(this).parents().eq(1);
				var title = list_data.find("h4").text();
				console.log(title);
				var data = {
						title : title,
						type : 'review'
				};

				$.ajax({
					type : "get",
					url : 'item/review',
					data:data,
					success : function(data){
						console.log(data);
						createTabView(data, 'review');

						
					},
					error:function (request, status, error){
		                   console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
		            }
				}) 
			});
			
			
			$(document).on("click", "#suggestion", function(){
				var list_data = $(this).parents().eq(1);
				var title = list_data.find("h4").text();
				console.log(title);
				var data = {
						title : title,
						type : 'suggestion'
				};
				$.ajax({
					type : "get",
					url : 'item/suggestion',
					data:data,
					success : function(data){
						console.log(data);
						createForm(data);
						
						/* $('#listGroup').empty();
						var jsonData = JSON.parse(data);
						$('#listGroup').append */
						
					},
					error:function (request, status, error){
		                   console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
		            }
				}) 
			});
			
			
			
			
			
			//Json 전용 table 생성
			function createForm(data, way){
				$('#listGroup').empty();
				const itemDetail =`
									<div class="itemDetails" >
									<img class="item_img" alt="없음"
										src="${path}/resources/user/assets/img/shop.jpg">
										<div class="detailsHeader">
											짐 보관소<br>
											<h4>\${data.title}</h4>
											옷가게<br> <i class="fa-solid fa-star"></i>
										</div>
										<ul class="nav nav-tabs">
										  <li class="nav-item">
										    <a id="information" class="nav-link active" aria-current="page" href="#">정보</a>
										  </li>
										  <li class="nav-item">
										    <a id="review" class="nav-link" href="#">리뷰</a>
										  </li>
										  <li class="nav-item">
										    <a id="suggestion" class="nav-link" href="#">추천</a>
										  </li>
										</ul>
										<div id="tabView"></div>
								</div>
								`;
				$('#listGroup').append(itemDetail);
				/* var opr="<table id='fresh-table' class='table'><tr>"+way+"</tr><thead><tr>"+
				    "<th>EMPNO</th>"+
	            	"<th>ENAME</th>"+
	            	"<th>JOB</th>"+
	            	"<th>SAL</th>"+
	            	"<th>EDIT</th><th>DELETE</th></tr></thead><tbody>";
				$.each(data,function(index,emp){
					opr += "<tr><td>"+emp.empno+
					"</td><td>"+emp.ename+
					"</td><td>"+emp.job+
					"</td><td>"+emp.sal+
					"</td><td><input type='button' onclick='empupdate(this)' value='수정' class ='update'  value2="+emp.empno+
					"></td><td><input type='button' value='삭제' class ='delete' value2="+emp.empno+"></td></tr>";
				});
				opr+="<tr><td colspan='10'><input type='button' onclick='createinput(this)' value='추가'></td></tr></tbody></table>"; */

			}
			
			function createTabView(data, type){
				$('#tabView').empty();
				let itemTab = '';
				if(type === 'information')
				{
					itemTab = `
						<div class="">
							<div id="">공지 : </div>
							<div id="">주소 : </div>
							<div id="">운영시간 : </div>
							<div id="">번호 : </div>
						</div>`;
				}else if(type == 'review'){
					itemTab = `
						<div class="nanny-opinions">
					    <div class="comments">
					        <div>
					            <div class="d-flex resume-review">
					                <div class="nanny-icon yellow star"></div>
					                5/5
					                <span class="type-point">
					                    •
					                </span>
					                366 reviews
					            </div>
					            <hr class="nanny-s<div class=" nanny-opinions">
					            <div class="comments">
					                <div class="comment">
					                    <div class="top-part d-flex justify-content-between align-items-center">
					                        <div class="d-flex">
					                            <div class="user-infos">
					                                <div class="picture"
					                                    style="background-image: url(&quot;/img/avatars/default_avatar.svg&quot;);">
					                                </div>
					                            </div>
					                            <div class="name-date">
					                                <div class="name"><b>Sylva</b>
					                                </div>
					                                <div class="date">
					                                    09/10/2022
					                                </div>
					                            </div>
					                        </div>
					                        <div class="stars">
					                            <div class="score">
					                                5/5
					                            </div>
					                            <div class="all-stars">
					                                <div class="nanny-icon star yellow"></div>
					                                <div class="nanny-icon star yellow"></div>
					                                <div class="nanny-icon star yellow"></div>
					                                <div class="nanny-icon star yellow"></div>
					                                <div class="nanny-icon star yellow"></div>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="comment-content"><b> It was very useful. Would use this service again.</b><br>
					                        Nannybag is a brilliant idea and a genuinely needed service. I only wish the distance mentioned
					                        was more accurate before choosing the location. It mentioned .2km while it was actually .5km
					                        once the accurate address was given.
					                    </div>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
							`;
				}else if(type == 'suggestion'){
					itemTab = `
						<div class="">
							<div id="">공지 : </div>
							<div id="">주소 : </div>
							<div id="">운영시간 : </div>
							<div id="">번호 : </div>
						</div>`;	
				}
				
				
				$('#tabView').append(itemTab);
			}
	})
	</script>	


<body>
	<!--Main Navigation-->
	<header>
		<!-- 좌측 사이드바 -->
		<!-- Sidebar -->
		<nav id="sidebarMenu"
			class="collapse d-lg-block sidebar collapse bg-white">
			<div class="position-sticky">
				<div id="listGroup" class="list-group list-group-flush mx-2 mt-4">
					<div class="shopList" >
						<img class="shop_img" alt="없음"
							src="${path}/resources/user/assets/img/shop.jpg">
						<div class="shop_info">
							짐 보관소<br>
							<h4>루피가게</h4>
							옷가게<br> <i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
						</div>
						<div class="list_button">
							<button type="button" class="btn btn-primary" id="detailBtn"
								style="margin-bottom: 15px">상세보기</button>
							<br>
							<button type="button" class="btn btn-primary">예약하기</button>
						</div>
					</div>
					<div class="shopList">
						<img class="shop_img" alt="없음"
							src="${path}/resources/user/assets/img/shop.jpg">
						<div class="shop_info">
							짐 보관소<br>
							<h4 id="name">루피가게</h4>
							옷가게<br> <i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
						</div>
						<div class="list_button">
							<button type="button" class="btn btn-primary" id="detailBtn"
								style="margin-bottom: 15px">상세보기</button>
							<br>
							<button type="button" class="btn btn-primary">예약하기</button>
						</div>
					</div>
				</div>
			</div>
		</nav>
		<!-- Sidebar -->

		<!-- header -->
		<%
			pageContext.include("/WEB-INF/views/include/header.jsp");
		%>


		<!--Main layout-->
		<main style="margin-top: 58px">
			<div class="container pt-4">
				<section class="mb-4">
					<div class="card">
						<div class="card-header py-3">
							<h5 id="">${destination}</h5>
							<h5>${dropDate}</h5>
							<h5>${pickupDate}</h5>
						</div>
						<div id="map" class="card-body">

							<canvas class="my-4 w-100" height="380"></canvas>
						</div>
					</div>
				</section>

				<section class="mb-4"></section>
			</div>
		</main>
</body>
<%pageContext.include("/WEB-INF/views/include/footer.jsp");%>
</html>
