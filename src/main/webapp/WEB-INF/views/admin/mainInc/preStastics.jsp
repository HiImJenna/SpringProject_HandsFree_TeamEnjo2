<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<script src="https://code.highcharts.com/highcharts.js"></script>

        <!--Main layout-->
    <main style="margin-top: 58px">
      <div class="container pt-4">
        <!-- Section: Main chart -->
        <section class="mb-4">
          <div class="card">
            <div class="card-header py-3">
              <h5 class="mb-0 text-left">
                <strong>[Hands Free] 교촌치킨 서울역점</strong>
              </h5>
              <br />
              <div style="color: #ff6e6e; font-size: x-small">
                *이 페이지는 통계차트를 볼 수 있는 페이지 입니다.
              </div>
            </div>
            <br />
            <h5 class="mb-0 text-center"><strong>Sales</strong></h5>
            <div class="card-body">
              <canvas class="my-4 w-100" id="myChart" height="380"></canvas>
            </div>
          </div>
        </section>
        <!-- Section: Main chart -->

        <!--Section: Sales Performance KPIs-->
        <section class="mb-4">
          <div class="card">
            <div class="card-header text-center py-3">
              <h5 class="mb-0 text-center">
                <strong>Sales Performance KPIs</strong>
              </h5>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th scope="col"></th>
                      <th scope="col">Product Detail Views</th>
                      <th scope="col">Unique Purchases</th>
                      <th scope="col">Quantity</th>
                      <th scope="col">Product Revenue</th>
                      <th scope="col">Avg. Price</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th scope="row">Value</th>
                      <td>18,492</td>
                      <td>228</td>
                      <td>350</td>
                      <td>$4,787.64</td>
                      <td>$13.68</td>
                    </tr>
                    <tr>
                      <th scope="row">Percentage change</th>
                      <td>
                        <span class="text-danger">
                          <i class="fas fa-caret-down me-1"></i
                          ><span>-48.8%%</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i><span>14.0%</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i><span>46.4%</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i><span>29.6%</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-danger">
                          <i class="fas fa-caret-down me-1"></i
                          ><span>-11.5%</span>
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">Absolute change</th>
                      <td>
                        <span class="text-danger">
                          <i class="fas fa-caret-down me-1"></i
                          ><span>-17,654</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i><span>28</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i><span>111</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-success">
                          <i class="fas fa-caret-up me-1"></i
                          ><span>$1,092.72</span>
                        </span>
                      </td>
                      <td>
                        <span class="text-danger">
                          <i class="fas fa-caret-down me-1"></i
                          ><span>$-1.78</span>
                        </span>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </section>
        <!--Section: Sales Performance KPIs-->
      </div>
    </main>
    <!--Main layout-->