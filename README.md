# ShowCar
차량 정보 검색 및 리뷰 웹 서비스

---

## 본 프로젝트는 팀 프로젝트로 진행되었으며, 기존 private repository를 기반으로 개인 포트폴리오용으로 재구성했습니다.

---
## 📌 프로젝트 개요
ShowCar는 사용자가 차량 정보를 쉽게 검색하고, 필터링하며, 리뷰를 남길 수 있는 웹 서비스입니다.  
검색 필터와 차량 리뷰 기능을 중심으로, 사용자 편의성을 강화하고 직관적인 UI/UX를 제공하는 것을 목표로 합니다.

---

## 📌 유스케이스

아래는 ShowCar 시스템의 주요 기능과 사용자 역할을 나타낸 유스케이스 다이어그램입니다.

![ShowCar Usecase Diagram](https://raw.githubusercontent.com/99Yoon/show_car/main/images/usecase.png)

## 📂 데이터베이스 설계 (ERD)

아래는 ShowCar 프로젝트의 데이터베이스 엔티티 및 관계를 나타낸 ERD 다이어그램입니다.

![ShowCar ERD Diagram](https://raw.githubusercontent.com/99Yoon/show_car/main/images/erd.png)


- **주요 테이블**  
  - 차량 정보 (Car)  
  - 사용자 (User)  
  - 리뷰 (Review)  


## 👥 팀 구성 및 역할

| 팀원   | 역할                                      |
| ------ | ----------------------------------------- |
| 강주영 | 팀장, 프론트엔드 개발, 회의 및 발표       |
| 윤찬열 | 백엔드 개발, DB 설계, DAO/VO 구현        |
| 최형진 | 백엔드 개발, DB 설계, DAO/VO 구현        |
| 홍준교 | 프론트엔드 개발, CSS/UI 구현             |

---

## 🛠 기술 스택
- **Backend:** Java Servlet, JSP  
- **Frontend:** HTML, CSS, JSP  
- **Database:** MySQL 
- **Server:** Apache Tomcat  
- **Build:** WAR 배포  

---

## 📸 화면 예시

![mainpage](https://raw.githubusercontent.com/99Yoon/show_car/main/images/287661942-83d6e59d-b046-400a-9920-0c8b59fa2d3e.png)
검색 필터가 있는 메인 페이지

![mypage](https://raw.githubusercontent.com/99Yoon/show_car/main/images/mypage.png)
나의 댓글을 확인하는 마이 페이지

![리뷰 등록 화면](https://raw.githubusercontent.com/99Yoon/show_car/main/images/review.png)  
사용자가 리뷰를 등록하는 화면

---

