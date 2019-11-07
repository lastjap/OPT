DROP SEQUENCE MEMBERSEQ;
DROP TABLE OPT_MEMBER CASCADE CONSTRAINT PURGE;

CREATE SEQUENCE MEMBERSEQ;      --회원번호 시퀀스

CREATE TABLE OPT_MEMBER(                                    --회원테이블
    OPT_NO_SEQ  NUMBER          PRIMARY KEY,                --회원번호
    OPT_ID      VARCHAR2(100)   NOT NULL    UNIQUE,         --아이디
    OPT_PW      VARCHAR2(100)   NOT NULL,                   --비밀번호
    OPT_NAME    VARCHAR2(100)   NOT NULL,                   --이름   
    OPT_BIRTH   VARCHAR2(500)   NOT NULL,                   --생년월일
    OPT_ADDR    VARCHAR2(500)   NOT NULL,                   --주소
    OPT_PHONE   VARCHAR2(500)   NOT NULL,                   --전화번호
    OPT_EMAIL   VARCHAR2(500)   NOT NULL    UNIQUE,         --이메일
    OPT_ENABLED VARCHAR2(2)     NOT NULL    CONSTRAINT enabled_ck CHECK (OPT_ENABLED IN('Y','N')),     --가입여부
    OPT_GENDER  VARCHAR2(10)    NOT NULL,                   --성별
    OPT_ROLE    VARCHAR2(100)   NOT NULL,                   --등급
    OPT_POINT   NUMBER          NOT NULL,                   --포인트
    OPT_REGDATE DATE            NOT NULL                    --가입일자
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'admin',
    'admin',
    '관리자',
    '1987/01/14',
    '서울시 관악구 청룡동 1536-4',
    '010-2662-5393',
    'last@gmail.com',
    'Y',
    'male',
    'admin',
    10000,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'admin1234',
    'admin1234',
    '관리자1234',
    '1987/02/14',
    '서울시 관악구 청룡동 1536-4',
    '010-1234-5393',
    'ABCtjap@gmail.com',
    'Y',
    'male',
    'admin',
    10000,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'user1',
    'user1',
    '유저1',
    '1991/02/16',
    '서울시 관악구 쑥고개로 57-1',
    '010-8787-5454',
    'newborn14@naver.com',
    'Y',
    'male',
    'user',
    0,
    SYSDATE
);


INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'ijw9209',
    '123123',
    '이재웅',
    '1992/09/01',
    '경기도 고양시 덕양구',
    '010-1234-5678',
    'ijw9209@naver.com',
    'Y',
    'male',
    'user',
    500,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'user2',
    'user2',
    '유저2',
    '1991/02/16',
    '인천시',
    '010-4427-3576',
    'user2@naver.com',
    'Y',
    'female',
    'user',
    0,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'user3',
    'user3',
    '유저3',
    '1991/02/16',
    '여수시',
    '010-6671-8464',
    'user3@naver.com',
    'Y',
    'female',
    'user',
    0,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'user4',
    'user4',
    '유저4',
    '1991/02/16',
    '부산시',
    '010-7210-1971',
    'user4@naver.com',
    'Y',
    'male',
    'user',
    0,
    SYSDATE
);

INSERT INTO OPT_MEMBER VALUES(
    MEMBERSEQ.NEXTVAL,
    'user5',
    'user5',
    '유저5',
    '1991/02/16',
    '일산시',
    '010-5602-7842',
    'user5@naver.com',
    'Y',
    'male',
    'user',
    0,
    SYSDATE
);

UPDATE OPT_MEMBER SET OPT_ENABLED='Y' WHERE OPT_NO_SEQ=2;

DELETE FROM OPT_MEMBER WHERE OPT_NO_SEQ = 10;
SELECT * FROM OPT_MEMBER;

--------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE VIDEOCLIPSEQ;
DROP TABLE OPT_VIDEO_CLIP CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE VIDEOCLIPSEQ;       --동영상 글번호 시퀀스

CREATE TABLE OPT_VIDEO_CLIP(                                 --동영상 게시판 테이블
    OPT_NO_SEQ      NUMBER          REFERENCES  OPT_MEMBER,  --회원테이블 회원번호 참조키
    VIDEO_NO_SEQ    NUMBER          PRIMARY KEY,             --동영상 글번호
    VIDEO_URL       VARCHAR2(1000)  NOT NULL,                --동영상 url
    VIDEO_TITLE     VARCHAR2(100)   NOT NULL,                --제목
    VIDEO_CONTENT   VARCHAR2(4000)  NOT NULL,                --내용
    VIDEO_REGDATE   DATE            NOT NULL,                --등록일  
    VIDEO_VIEWS_NO  NUMBER          NOT NULL                 --조회수    
);

DELETE FROM OPT_VIDEO_CLIP WHERE VIDEO_NO_SEQ =5;

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/oMOmp397z3U',
    '헬스장 처음이면 뭘 어떻게 할까요?초보자를 위한 완벽가이드 영상',
    '안녕하세요 여러분~~~
	이번 영상은 날 것 그대로의 영상이라 많이 부끄럽기도 하고
	영상으로 마주하니 열심히 해서 참 뿌듯하기도 하네요ㅋㅋㅋㅋㅋㅋ
	저의 첫 영상에서 말했듯이 훗날 이 영상을 보면서 저럴 때도 있었지 하고
	추억할 수 있길 바라봅니다
	..화이팅...! ㅎ_ㅎ',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/3VouSaW_LPw',
    '전신 다이어트 유산소운동 [홈트레이닝]',
    '안녕하세요, 땅끄와 오드리 입니다! 연휴동안 쉬면서 몸에 지방이 필요이
	상으로 많이 붙어버린듯 합니다. 집에서도 쉽게 할 수 있는 강도높은 다이
	어트 운동 프로그램을 계획하고 해보던중 저희끼리만 하기보다 많은 분들
	과 함께 서로 동기부여하며 할 수 있는 방법으로 본 영상까지 찍게 되었습
	니다. 최대한 집에서도 손쉽게 따라하실 수 있는 층간소음이 적은 동작들
	로 구성하였으며, 동시에 칼로리 소모가 많은 운동 중심 그리고 더 나아가 
	복근을 포함한 여러가지 근육들을 사용하여 몸을 탄력있게 만들 수 있는 
	운동들로 준비해 보았습니다. 원래 이전에도 이와 비슷한 전신 유산소 다
	이어트 운동 영상을 찍은것이 있으나, 그것보다도 조금 더 길게(20분) 그
	리고 조금 더 다양한 운동과 강도로 그리고 이전에 댓글로 요구해 주셨던 
	운동설명, 효과음, 음악 등을 더 보완하여 이번 영상을 만들어보게 되었습
	니다. 본 영상에 나오는 운동들과 구성, 순서등은 오드리가 실제로 집에서 
	홈트레이닝을 할때에 했던 운동들을 중심으로 국내외 유명 피트니스 칼로
	리 소모 많은 운동 영상들을 참고로 하여 구성하였으며 그만큼 효과 또한 
	검증되었다고도 말할 수 있습니다. 이점 참고하시어 다이어트 하시는데 조
	금이라도 도움이 되었으면 합니다.',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    4,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/XN9IKLEppR0',
    '짐볼을 이용한 하루 10분 전신 유산소 다이어트 운동 [딩고PT]',
    '솔찌키 집에 짐볼 나만 쳐 박혀있는 거 아니지?
	오늘부터 당장 짐볼로 전신운동ㄱㄱ
	ㅋㅋㅋ쉬운 건 줄 알고 샀는데 쉬운게 아니여써.....',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    4,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/YWRbuyneaXI',
    '무조건 PT받는게 옳은가?! 개인트레이닝 받기 전 꼭 봐야할 영상!! [지피티TV]',
    '구독과 좋아요! 공유 부탁드립니다!영상을 통해 많은 도움이 되셨으면 좋겠습니다!
	프로틴팩트 서포터즈 (인터넷에 프로틴팩트 검색)
	↓               ↓                 ↓
	https://proteinfact.co.kr/
	프로틴팩트 사이트에서 보충제 따로 구매하실때 구매 메모작성란에
	지피티 추천 이렇게 작성해주시면 유기농 카카오파우더를 추가로 증정해드린
	다고 합니다!  많은 애용부탁드립니다! :)',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    5,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/wR2bHEcum3E',
    'PT 다이어트 헬스 브이로그 | 운동하는 날 Vlog',
    '해-하!썬지에요!
	오늘은 운동을 하러 헬스장에 갔다왔어요!
	체력이 안 좋아서ㅠㅠ 
	완전 지옥의 트레이닝이었어욥ㅋㅋ
	오늘 영상도 재밌게 봐주시고
	다음에 또 마나용!
	해-바!',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    5,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/pJAAMXIAtqQ',
    '사기 PT 호구 안당하는 방법 (헬스 PT) 실태',
    '한국의 모든 헬린이들이 눈탱이 안맞는그날까지 
	PT를 받아본분 , 받으려는분 , 받고있는분
	현직트레이너 , 모두가 봐야할 영상입니다 
	부디 올바른 판단력을 기르시기를 기원하면서 
	없는실력으로 힘들게 영상 만들어 보았습니다
	모두들 정직하고 실력있는 지도자를 만나시기를 
	바랍니다',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    6,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/pqM7oK08HEU',
    '헬스초보! 첫 헬스장 어디로 가야할까???',
    '헬스장 관장이 알려드리는 헬린이 분들을 위한 첫 헬스장 선택 가이드!!!
	[미트리 닭가슴살] 아래 링크를 타고 들어가 회원가입하고 구매하면 추가 
	할인된 가격으로 구매하실 수 있습니다',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    7,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/5QX6jAyTc20',
    '비키니 입기 위해 개인PT 시작했습니다 운동하는여자, 몸짱녀 될거야',
    '안녕하세요 존경하는 구독자 여러분!
	제가 인복이 있는지, 어느분의 도움으로 운동을 시작하게 되었습니다^^
	(그 썰은 제가 차츰 풀겠습니다.)
	더군다나 한번도 안받아본 개인PT 기회가 주어져
	어제 처음 근력테스트 받고 왔는데요!
	간절하게 손꼽아 기다렸던 기회라서, 개인적으로 무척 기뻐요~
	조금 가볍게 운동하는 모습과 눈바디를 사진&영상으로
	남길 생각인데, 여러분에게도 공유 하고 싶어 영상 만듭니다!
	돌아올 여름을 위해 조금 멋진 몸을 만들고싶더라구요
	마지막 버킷리스트 처럼!!
	올해 초부터 생각했던건데, 이제서야 실행 할 수 있게 되었어요
	재밌게보세요^^',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/VNQpP6C1fJg',
    '집에서 하는 유산소운동 다이어트 [칼소폭]',
    '안녕하세요, 땅끄와 오드리 입니다! 저희가 운동을 할 때 가장 중점을 두
	고 생각하는 것은 바로 시간 대비 운동효율 입니다. 그래서 저희가 소개
	시켜드린 영상 대부분은 최대한 단시간 고효율을 목표로한 운동 루틴으로 
	구성되었고 그렇게하여 탄생한 영상들은 대부분은 10분 내외의 BEST 동
	작 영상등으로 여러분들께 소개되어 졌습니다. 오늘은 단시간 고효율 동작
	들을 모두 종합한 칼로리 소모 폭탄 운동 [칼소폭]을 준비해 보았습니다. 
	본 운동 영상은 초보자 분들도 집에서 쉽게 따라하실 수 있도록 아무런 도
	구없이 맨몸으로 하실 수 있는 동작들과 더불어 최대한 여러가지 다양한 
	근육무리를 사용하여 칼로리 소모에 특화된 동작들로만 선별하여 구성하
	였습니다. 영상에서 소개시켜 드리는 운동 및 효과는 다음과 같습니다.',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/eC2RTE8lQXk',
    '다이어트는 PT가 정답! 4개월만에 바디프로필까지!',
    '경도비만에서 체지방이 부족한 지경에 이르기 까지
	복부비만에서 복근이 생기기까지 전신사진은 찍지도 않았는데 바디프로필을 찍기까지
	4개월 동안 PT받으며 체지방 7kg 감량하고 다이어트에 성공한 저의 이야기를 담았습니다',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/Flx0PdzplMM',
    '평범한 사람이 헬스장에서 피티를 받으면 어떻게 될까? (헬스 PT)',
    '40일 동안 열심히 먹고 운동하고 느낀점을 기록해봤습니다.
	여름 대비해서 헬스장에서 PT받을 예정이신 분들께 도움이 되었으면 좋겠어요.
	내 돈 66만원....
	.
	.
	.
	문의 및 러브레터 : jungsungkwon@gmail.com
	Instagram : kimeptony',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/MlXGsjt7M7g',
    '웨이트 트레이닝 입문 하기전 꼭 해야되는 6가지 운동',
    '헬린이 특집 #2 
	웨이트 트레이닝 입문 하기전 꼭 해야되는 6가지 운동 
	이것만 제대로 연습하고 간다면 
	헬스장 적응 무지무지 쉬워요 
	헬린이 여러분 화이팅 !!',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/cIjvH7epOmY',
    'PT 2주차 인바디 충격적인 변화! PT 운동 2주차 상체운동 기록 운동의 중요성',
    '안녕하세요~ 오늘은 인바디 결과랑 PT 운동 2주차 상체운동 기록이에요!
	호호...인바디 결과가 만족스러워서 기분이 좋은데요!!!
	요즘 운동이 힘들기도 하고 식단도 어떻게 해야할지 고민스럽기도 하고 그렇습니당
	항상 응원해주시고 좋은댓글 좋아요 눌러주시는 분들 모두 감사합니다',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/bwER2gjNnNs',
    '많이 부족하지만 재밌게 봐주세용~~',
    '안녕하세요~ 오늘은 인바디 결과랑 PT 운동 2주차 상체운동 기록이에요!
	호호...인바디 결과가 만족스러워서 기분이 좋은데요!!!
	요즘 운동이 힘들기도 하고 식단도 어떻게 해야할지 고민스럽기도 하고 그렇습니당
	항상 응원해주시고 좋은댓글 좋아요 눌러주시는 분들 모두 감사합니다',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/2hg1U8BdtuQ',
    '헬스PT가격, 헬스장 알아보기 전에 좋은 PT가 뭔지부터!',
    '안녕하세요, 올어바웃바디 대표 트레이너낙입니다.
	곧 다가올 여름!
	자기관리, 혹은 체형 교정을 위해
	PT 신청을 생각하고 있진 않으신가요?
	그러나 많은 분들이
	제대로 된 지식 없이,
	자극적인 문구와 사진 등에 끌려
	무작정 PT를 등록하시고선
	후회하는 경우가 많습니다.
	그래서 이에 도움을 드리고자
	제가 생각하는 PT의 정의와,
	올바른 PT 고르는 팁을
	영상을 통해 알려드리려 하는데요,
	나에게 맞는, 올바른 PT!
	어떻게 해야 제대로 고를 수 있을까요?
	본 영상과 위의 블로그 링크에서
	그 해답을 찾으실 수 있습니다.',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/UgKL-kfdw-I',
    '[홍지원 & 김동호의 실전 PERSONAL TRAINING]',
    '홍지원과 김동호 선생님께 직접 PT를 받는다 ! 
	홍지원 선생님과 김동호 선생님께 직접 지도를 받으면서 
	운동을 배우고 싶다면 1:1 퍼스널 트레이닝을 적극 추천!!
	몸짱이 되는것과 건강을 관리하는것도 훨씬 더 쉬워질겁니다 ^^',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/7wu3b0B2EGk',
    '[VLOG] 운동 브이로그 / 리아의 PT 일기 in BELIEVE PT STUDIO',
    'BELIEVE PT STUDIO
	서울특별시 강서구 화곡로 141 2층',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/fkCCJ2Pqq4U',
    '[혼자서 하는 셀프 PT] 초급자 1, 1급레벨 전체동작',
    '초급자용 프로그램은 체력과 운동 수행능력이 약한 사람에게 초점을 두었
	다. 맨몸으로 하는 동작 중에서 자신의 체중과 근지구력을 컨트롤하기 어
	려운 사람들이 부상의 위험이 적고 더욱더 안정적인 효과를 얻기 위한 기
	본적인 단순 동작과, 반동을 이용해 체력과 운동 수행능력을 높일 수 있게 
	구성했다.
	초급자용 프로그램 동작들은 운동을 처음 하거나 많이 접하지 않은 사람들
	, 혹은 운동을 오래 쉬었다가 다시 하는 사람들이 부담 없이 컨트롤할 수 
	있는 프로그램이다.
	각기 다른 세 부분을 연속으로 운동해서 자극을 주는 프로그램으로, 근육 
	범핑에 대한 부담이 적고, 체지방 연소와 근력 높이기에 좋은 프로그램이 
	초급자용 프로그램 1이다.
	',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
    VIDEOCLIPSEQ.NEXTVAL,
    'https://www.youtube.com/embed/fkCCJ2Pqq4U',
    '[혼자서 하는 셀프 PT] 초급자 1, 1급레벨 전체동작',
    '초급자용 프로그램은 체력과 운동 수행능력이 약한 사람에게 초점을 두었
	다. 맨몸으로 하는 동작 중에서 자신의 체중과 근지구력을 컨트롤하기 어
	려운 사람들이 부상의 위험이 적고 더욱더 안정적인 효과를 얻기 위한 기
	본적인 단순 동작과, 반동을 이용해 체력과 운동 수행능력을 높일 수 있게 
	구성했다.
	초급자용 프로그램 동작들은 운동을 처음 하거나 많이 접하지 않은 사람들
	, 혹은 운동을 오래 쉬었다가 다시 하는 사람들이 부담 없이 컨트롤할 수 
	있는 프로그램이다.
	각기 다른 세 부분을 연속으로 운동해서 자극을 주는 프로그램으로, 근육 
	범핑에 대한 부담이 적고, 체지방 연소와 근력 높이기에 좋은 프로그램이 
	초급자용 프로그램 1이다.
	',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/Rjv7hnHkgXE',

'앉기. (허리만 세운다고 되는게 아님)',

'앉는 자세만 고쳐도 웬만한 허리 질병은 거의 다 예방이 가능합니다.꼭 명심해 주세요.',
    SYSDATE,
    0
);


INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/aoH7qNedO8k',

'푸쉬업 해도 몸변화가 없는 이유 [운동의 정석]',

'#운동 #다이어트 #헬스
푸쉬업을 해도 몸에 변화가 없으신가요?
운동의 정석 - 푸쉬업  -
빡빡이 아저씨의 본격 뇌피셜 푸쉬업 강의.avI',
    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/14w0rm0A_IY',

'(Ep2/90.9kg) 이영광 3대 500 만들기 2주차',

'#운동 #다이어트 #헬스
■극헬린이 이영광 PD의 3대 500 도전기
□ (2019.7.18) 97.4kg
□ (2019.7.24) 93.2kg
□ (2019.7.31) 90.9kg
235프로젝트'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/qMtyhDDmJ-U',

'50만명이 효과를 본 라운드숄더 교정루틴 A (by 호주물리치료사)',

'굽은 등, 라운드숄더 체형은 가장 흔한 체형 중 하나로 여러가지 문제를 유발하는 체형입니다.
이 체형을 교정하는 방법은 정말 간단합니다.
이 루틴을 매일 꾸준히 3개월만 해주시면 됩니다.
정말 놀라운 변화가 나타날 것입니다.'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/-rRmu0wfeYU',

'어깨 통증? 뼈소리? (매일 10분만 따라해보세요)',

'이번시간에는 Internal impingement에 대해서 이야기 해보겠습니다.'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/wYu5XrY5A2A',

'제발 하지 마세요! 어깨 망치는 최악의 마사지.',

'항상 어깨가 뻐근하다고 하는 사람들에게 반드시 알려줘야 할 정보입니다. 
어깨 통증 때문에 스트레스 받는 어르신분들에게 꼭 꼭 공유해 주세요.'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/5IBhz4c2D4o',

'절대로 하면 안되는 복근 운동',

'척추탈출넘버원 Ep2 - 레그레이즈 편 -'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/Fn1KWahfHnU',

'운동 전에 이걸 해보세요! 초간단 워밍업 (패시브 웜업 테크닉)',

'운동 전에 워밍업, 귀찮지만 꼭 해줘야 하는 일이죠.
그렇지만 이건 전혀 귀찮지도 않고 매우 간단한 방법입니다.'
,    SYSDATE,
    0
);
INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/1yJwleqY73s',

'과학적으로 검증된 족저근막염 탈출하는 방법',

'논문에 의하면 이 마사지와 운동법은 족저근막에 매우 효과적이라고 합니다. 
족저근막으로 고생하고 있는 분들에게 공유해 주세요!'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/JijbvAl75-A',
'오래 서 있는 사람들을 위한 다리 붓기(부기) 빼주는 시원한 테크닉',
'오래 서 있는 사람들, 하이힐을 주로 신는 사람들, 오래 걷는 사람들을 위한 최고의 마사지 방법입니다.',
SYSDATE,
	0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/2Kd4xhyxmDE',

'고중량. 손목 약한 사람들 꼭 보십쇼!!!!!! l TFCC 마사지 l 손목 통증',

'고중량 벤치프레스 하는 사람들도 꼭 보세요!
TFCC가 다치면 손목 안쪽이 아프고 손목에 힘을 과도하게 주는 경우 특히 뻑뻑하거나 무거운 문을 돌려서 열 때 통증이 더 심해지는데요.
이런 경우에는 마사지를 통해서 회복 속도를 훨씬 빠르게 촉진시켜줄 수가 있습니다.'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/qGGd2rL-gMQ',

'몸 만드는 "반박불가" 습관 2가지',

'기본적으로 다이어트를 실패하는 가장 큰 이유 중 하나는 바로 필요 이상으로 먹는 겁니다.
이제 필요 이상으로 먹는 이유는 여러 가지가 있는데 이건 딱 2가지 생활습관만 고쳐주면 훨씬 좋아지게 될 겁니다'
,    SYSDATE,
    0
);


INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/KzGmjwCJTXo',

'걷기만 잘해도, 최악은 막는다 (바르다 빡선생)',

'누구나 만족하는 생활자세. 바르다 빡선생이 만들겠습니다'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/q22grJuVOz4',

'빡저씨가 폼롤러를 쓰는 이유 (빡리뷰 Ep1)',

'이 피트니스 용품들을 구체적으로 조금 알아보는 콘텐츠!
본격 피트니스 용품 리뷰 콘텐츠!'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/AvHuwXWVHFo',

'0.1%만 알고 있는 골반 통증 꿀팁 (고관절 찝힘)',

'정말 많은 사람들이 여기 고관절이 아플 때, 여기 고관절 부위를 마사지 해주는데 이건 굉장히 안 좋은 방법입니다'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/EBjYQeeBI-0',

'완벽한 데드리프트 강의 [운동의 정석]',

'운동의 정석 Ep3 - 데드리프트 -
데드리프트, 잘 하고 계신가요?
빡빡이 아저씨의 본격 뇌피셜 데드리프트 강의.avi'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/0DsXTSHo3lU',

'완벽한 벤치프레스 강의 [운동의 정석]',

'운동의 정석 Ep4 - 벤치프레스 -
벤치프레스, 잘 하고 계신가요?
빡빡이 아저씨의 본격 뇌피셜 벤치프레스 강의.avi'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/6zsHvi7aqjE',

'유산소 도우미. 지루하지 않게 달리는 법 l 잠실 한강공원 l 페이스 메이커',

'빡빡이 아저씨와 함께 운동해요! 유산소 운동'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/p-S1Pjagbmo',

'고중량 스쿼트 워밍업 (핵꿀팁)',

'고중량 훈련을 하고 있거나 무릎이나 발목이 흔들리는 사람들에게 정말 유익한 운동입니다.'
,    SYSDATE,
    0
);

INSERT INTO OPT_VIDEO_CLIP VALUES(
    3,
 VIDEOCLIPSEQ.NEXTVAL,
'https://www.youtube.com/embed/piTKJeo6RSs',

'30초만 해도 효과 보는 라운드숄더(굽은 등) 스트레칭',

'굉장히 시원한 굽은 등 스트레칭입니다.
굽은 등이 있다면 꼭 해보시고 공유해 주세요.
언제 어디서든 할 수 있는 꿀 스트레칭/운동'
,    SYSDATE,
    0
);

SELECT * FROM OPT_VIDEO_CLIP;

--------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE VIDEOCOMMENTSEQ;
DROP TABLE OPT_VIDEO_COMMENT PURGE;

CREATE SEQUENCE VIDEOCOMMENTSEQ;        --동영상 댓글번호 시퀀스

CREATE TABLE OPT_VIDEO_COMMENT(
    OPT_NO_SEQ          NUMBER       REFERENCES  OPT_MEMBER,
    --회원테이블 회원번호 참조키
    VIDEO_NO_SEQ        NUMBER       REFERENCES  OPT_VIDEO_CLIP,
    --동영상게시판 게시글번호 참조키
    VIDEO_COMMENT_SEQ   NUMBER          PRIMARY KEY,        --댓글번호
    VIDEO_REPLE         VARCHAR2(2000)  NOT NULL,           --댓글내용
    VIDEO_COMMENT_DATE   DATE            NOT NULL            --댓글작성시간
);

DELETE FROM OPT_VIDEO_COMMENT
WHERE VIDEO_NO_SEQ = 

INSERT INTO OPT_VIDEO_COMMENT VALUES(
    3,
    2,
    VIDEOCOMMENTSEQ.NEXTVAL,
    '좋은 게시물 감사합니다 ^^',
    SYSDATE    
);

INSERT INTO OPT_VIDEO_COMMENT VALUES(
    4,
    1,
    VIDEOCOMMENTSEQ.NEXTVAL,
    '보니까 운동 열심히 해야겟다고 생각드네용',
    SYSDATE    
);

SELECT * FROM OPT_VIDEO_COMMENT;

--------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE CUSTOMERSEQ;
DROP TABLE OPT_CUSTOMER_SERVICE CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE CUSTOMERSEQ;            --고객센터 글 번호 시퀀스

CREATE TABLE OPT_CUSTOMER_SERVICE(      --고객센터 테이블
    OPT_NO_SEQ          NUMBER          REFERENCES  OPT_MEMBER (OPT_NO_SEQ),
    --회원테이블 회원번호 참조키
    CUSTOMER_NO_SEQ     NUMBER          PRIMARY KEY,  --고객센터 글 번호                
    CUSTOMER_TITLE      VARCHAR2(500)   NOT NULL,     --글 제목
    CUSTOMER_CONTENT    VARCHAR2(4000)  NOT NULL,     --글 내용
    CUSTOMER_REGDATE    DATE            NOT NULL,     --글 작성일 
    CUSTOMER_CATEGORY   VARCHAR2(100)   	  --질문 카테고리 FAQ,배송,
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    5,
    CUSTOMERSEQ.NEXTVAL,
    '도시락 금방오는편인가요??',
    '늦어도 모레까지는 받아야하는데 오늘 아침에 사면 언제쯤오나요?',
    SYSDATE,
    '배송'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    2,
    CUSTOMERSEQ.NEXTVAL,
    '당일배송 가능한가요??',
    '급합니다 빨리좀 부탁드려요',
    SYSDATE,
    '배송'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    3,
    CUSTOMERSEQ.NEXTVAL,
    '쿠폰 유효기간에 대해서 질문드립니다',
    '제곧내',
    SYSDATE,
    '쿠폰'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    4,
    CUSTOMERSEQ.NEXTVAL,
    '환불 절차에 대해 알려주세요',
    '환불하고싶어요 ㅎㅎ',
    SYSDATE,
    '환불'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    4,
    CUSTOMERSEQ.NEXTVAL,
    '상담원이 불친절해요',
    '왜이리 불친절한거죠?',
    SYSDATE,
    '고객응대'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    5,
    CUSTOMERSEQ.NEXTVAL,
    '도시락 성분 문의드립니다',
    'OO알레르기가 있는데 성분 함량 정보가 궁금해요',
    SYSDATE,
    '제품'
);

INSERT INTO OPT_CUSTOMER_SERVICE VALUES(
    5,
    CUSTOMERSEQ.NEXTVAL,
    '배송주소 수정은 어떻게 하나요?',
    '수정을 원합니다',
    SYSDATE,
    '배송'
);

SELECT * FROM OPT_CUSTOMER_SERVICE;

--------------------------------------------------------------------------------------------------------------------------------
--자주묻는질문답변 게시판

DROP SEQUENCE FAQSEQ;
DROP TABLE OPT_FAQ CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE FAQSEQ;

CREATE TABLE OPT_FAQ(
	FAQ_NO_SEQ	NUMBER		PRIMARY KEY,
	FAQ_TITLE	VARCHAR2(500)	NOT NULL,
	FAQ_ID VARCHAR2(500) NOT NULL,
	FAQ_CONTENT	VARCHAR2(4000)	NOT NULL,
	FAQ_REGDATE	DATE		NOT NULL
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'당일 배송 되나요',
	'ADMIN',
	'평일 오후 2시 이전 결제완료 시, 당일 출고되며, 출고일로부터 1~3일 정도의 배송기간이 소요됩니다. (지역별 택배 물량에 따라서 차이가 있을수 있습니다.)',
	SYSDATE
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'당일 배송 되나요',
	'ADMIN',
	'평일 오후 2시 이전 결제완료 시, 당일 출고되며, 출고일로부터 1~3일 정도의 배송기간이 소요됩니다. (지역별 택배 물량에 따라서 차이가 있을수 있습니다.)',
	SYSDATE
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'회원 아이디를 변경 할수 있나요?',
	'ADMIN',
	'아이디는 변경하실수 없습니다.',
	SYSDATE
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'결제는 어떻게 해야하나요?',
	'ADMIN',
	'OPT의 결제시스템은 카카오페이를 지원하고 있습니다',
	SYSDATE
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'개인정보를 변경하려면 어떻게 해야하나요?',
	'ADMIN',
	'로그인후 마이페이지에서 변경이 가능합니다',
	SYSDATE
);

INSERT INTO OPT_FAQ VALUES(
	FAQSEQ.NEXTVAL,
	'회사 주소가 어떻게 되나요',
	'ADMIN',
	'회사 주소는 상단 메뉴중 OPT를 누루시면 주소가 상세하게 지도로 표시됩니다',
	SYSDATE
);

SELECT * FROM OPT_FAQ;

--------------------------------------------------------------------------------------------------------------------------------
DROP SEQUENCE ADMINANSWERSEQ;
DROP TABLE OPT_ADMIN_ANSWER PURGE;

CREATE SEQUENCE ADMINANSWERSEQ;     --고객센터 관리자 댓글 글 번호 시퀀스

CREATE TABLE OPT_ADMIN_ANSWER(      --고객센터 관리자댓글
    CUSTOMER_NO_SEQ         NUMBER          REFERENCES  OPT_CUSTOMER_SERVICE,
    --고객센터 테이블 글번호 참조키
    OPT_NO_SEQ              NUMBER          REFERENCES  OPT_MEMBER,
    --회원테이블 회원번호 참조키(admin 회원번호)
    ADMIN_ANSWER_NO_SEQ     NUMBER          PRIMARY KEY,    --관리자댓글 글번호    
    ADMIN_ANSWER_CONTENT    VARCHAR2(4000)  NOT NULL,       --관리자댓글 내용
    ADMIN_ASNWER_REGDATE    DATE            NOT NULL        --작성일
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    1,
    3,
    ADMINANSWERSEQ.NEXTVAL,
    '오전에 주문하시면 내일안으로 배송완료 됩니다~ 감사합니다',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    2,
    3,
    ADMINANSWERSEQ.NEXTVAL,
    '오후 4시 이전 주문건은 당일배송 됩니다. 감사합니다.',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    3,
    4,
    ADMINANSWERSEQ.NEXTVAL,
    '쿠폰은 발급일로부터 한달이내 사용하셔야 합니다. 감사합니다.',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    4,
    5,
    ADMINANSWERSEQ.NEXTVAL,
    '자세한 환불 절차는 홈페이지 참고 부탁드립니다. 감사합니다.',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    5,
    4,
    ADMINANSWERSEQ.NEXTVAL,
    '담당부서 전달해서 고객응대를 위해 최선을 다하겠습니다. 감사합니다.',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    6,
    3,
    ADMINANSWERSEQ.NEXTVAL,
    '해당 제품은 안심하시고 드셔도 됩니다. 감사합니다.',
    SYSDATE
);

INSERT INTO OPT_ADMIN_ANSWER VALUES(
    7,
    4,
    ADMINANSWERSEQ.NEXTVAL,
    '배송주소 수정은 담당 기사님과 상의 부탁드립니다. 감사합니다.',
    SYSDATE
);

SELECT * 
FROM OPT_ADMIN_ANSWER A , OPT_CUSTOMER_SERVICE S
WHERE A.CUSTOMER_NO_SEQ = S.CUSTOMER_NO_SEQ;

--------------일정관리------------------------------------------------------
DROP SEQUENCE CALENDARSEQ;
DROP TABLE OPT_CALENDAR  CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE CALENDARSEQ;
CREATE TABLE OPT_CALENDAR(
    OPT_NO_SEQ NUMBER REFERENCES OPT_MEMBER (OPT_NO_SEQ),   --회원번호
    CALENDAR_NO_SEQ NUMBER PRIMARY KEY,                     --일정번호
    CALENDAR_TITLE VARCHAR2(100) NOT NULL,                  --일정제목
    CALENDAR_STARTDAY VARCHAR2(100) NOT NULL,                        --일정시작일 			--***일단 문자열로 수정****
    CALENDAR_ENDDATE VARCHAR2(100) NOT NULL,                         --일정완료일
    CALENDAR_URL VARCHAR2(500),                             --일정URL
    CALENDAR_REGDATE DATE NOT NULL                          --일정등록일
);

INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '일정1' ,'2019-07-20','2019-07-24', NULL,SYSDATE);
INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '일정2' ,'2019-06-25','2019-06-28', NULL,SYSDATE);
INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '일정3' ,'2019-06-01','2019-06-17', 'https://www.naver.com' ,SYSDATE);

INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '유산소','2019-08-10','2019-08-16',NULL,SYSDATE);
INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '무산소','2019-08-02','2019-08-27',NULL,SYSDATE);
INSERT INTO OPT_CALENDAR VALUES(3,CALENDARSEQ.NEXTVAL, '휴가','2019-08-20','2019-08-23',NULL,SYSDATE);

SELECT TO_DATE(REPLACE(CALENDAR_ENDDATE,'-',''))+1 FROM OPT_CALENDAR;
SELECT * FROM OPT_CALENDAR;

------------------쿠폰--------------------------
----------------쿠폰테이블 수정 PK를 쿠폰번호로잡아서 똑같은 번호가 안들어감 그래서 PK시퀀스 추가-----------
DROP SEQUENCE COUPONSEQ;
DROP TABLE OPT_COUPON CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE COUPONSEQ;
CREATE TABLE OPT_COUPON(
    OPT_NO_SEQ NUMBER REFERENCES OPT_MEMBER,  --회원번호
    COUPON_NO_SEQ NUMBER PRIMARY KEY,		   --쿠폰시퀀스
    COUPON_NO NUMBER,		                   --쿠폰번호(쿠폰 종류를 나눌수잇는 고유번호)
    COUPON_NAME VARCHAR2(100) NOT NULL,       --쿠폰이름
    COUPON_CONTENT VARCHAR2(1000) NOT NULL,   --쿠폰내용
    COUPON_DATE VARCHAR2(100) NOT NULL,       --유효기간
    COUPON_SALE VARCHAR2(100) NOT NULL        --할인가격
);

INSERT INTO OPT_COUPON VALUES(3,COUPONSEQ.NEXTVAL,111111,'회원가입쿠폰','회원가입시 1000원 쿠폰','2019-08-16','1000');
INSERT INTO OPT_COUPON VALUES(4,COUPONSEQ.NEXTVAL,111112,'3000원 할인쿠폰','고객감사 3000원 할인 쿠폰','2019-08-12','1000');
INSERT INTO OPT_COUPON VALUES(4,COUPONSEQ.NEXTVAL,111113,'배송비무료쿠폰',' 배송비 무료 쿠폰','2019-08-11','1000');

SELECT * FROM OPT_COUPON;

----------------장바구니-------------------------
DROP SEQUENCE BASKETSEQ;
DROP TABLE OPT_BASKET CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE BASKETSEQ;

CREATE TABLE OPT_BASKET(
    OPT_NO_SEQ NUMBER REFERENCES OPT_MEMBER,  --회원번호
    BASKET_NO_SEQ NUMBER PRIMARY KEY,         --장바구니 순서
    BASKET_ITEM_NO NUMBER NOT NULL,	      --상품 번호
    BASKET_ITEM_URL VARCHAR2(200) NOT NULL,   --상품 이미지
    BASKET_ITEM_NAME VARCHAR2(200) NOT NULL,  --상품 이름	
    BASKET_ITEM_COUNT NUMBER NOT NULL,        --장바구니 수량
    BASKET_ITEM_PRICE NUMBER NOT NULL         --상품가격
);

SELECT * FROM OPT_BASKET;

--------------상품리스트-------------------------
DROP SEQUENCE ITEM_NUM_SEQ;
DROP TABLE OPT_ITEM CASCADE CONSTRAINTS PURGE;
CREATE SEQUENCE ITEM_NUM_SEQ;
CREATE TABLE OPT_ITEM(
    ITEM_NUM_SEQ NUMBER PRIMARY KEY,    --상품번호
    ITEM_NAME VARCHAR2(100) NOT NULL,   --상품이름
    ITEM_PRICE NUMBER NOT NULL,  		--상품가격
    ITEM_VIEWS_NO NUMBER NOT NULL,      --조회수
    ITEM_CONTENT VARCHAR2(1000),         --상품설명
    ITEM_URL VARCHAR2(100),             --상품이미지URL
    ITEM_COUNT NUMBER DEFAULT 1,        --상품 개수
    ITEM_ENABLED VARCHAR2(2) NOT NULL CONSTRAINT item_enabled_ck CHECK (ITEM_ENABLED IN('Y','N')) -- 판매 여부
);

INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'순식단 식물성단백질 28개입', 49000, 0, '맛있는 식이조절 식단이 필요하시다면, 간편한 식사대용품이 필요하다면 순식단으로 선택하세요','image/item_img01.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'밀스원 바디케어 도시락 10팩', 37900, 0, '칼로리는 낮지만 매일매일 질리지 않고 맛있는 식사를 위해 맛, 영양, 식감까지 고려한 최적의 하모니~','image/item_img02.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'비타북스 2주 완성 식단', 11700, 0, '2주 완성, 살이 쭉쭉 빠지는 저칼로리 식단 하루 세 끼, 든든히 먹으면서 뺀다!','image/item_img03.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'포르미 한입도시락 10종 20팩', 54900, 0, '간편하게 한입! 바쁜 출근시간에 2분30초만 전자렌지에 돌려서 드세요 적은 칼로리로 야식이 땡길때도 한입 도시락으로!!','image/item_img04.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'나마시떼 도시락 8팩', 29900, 0, '식이섬유가 풍부한 갓 지은 영양밥으로 만든 맞춤 도시락 ','image/item_img05.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'포켓샐러드 6팩 패키지', 31800, 0, '매일 먹어도 질리지 않는 취향따라 기분따라 골라먹는 3가지맛!! 풍부한 식이섬유가 포함된 샐러드로 건강을 챙겨보세요!','image/item_img06.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'비타할로 다이어트 쉐이크', 12300, 0, '아직도 굶으면서 다이어트 하시나요? 칼로리 걱정 없이 맛있는 한끼 비타할로 가볍게 한끼 다이어트 쉐이크로 균형잡힌 다이어트 하세요!!','image/item_img07.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'칼로리발란스 치즈 10개입', 10650, 0, '당신을 위한 맞춤영양 밸런스! 굶지말고 간단하게 식사대용으로 드세요~','image/item_img08.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'밥이곤약 곤약 즉석밥 10개입', 18340, 0, '흰쌀은 한 톨도 넣지 않았어요 현미 3: 귀리 3: 곤약 4의 황금비율로 밥을 지어 잡곡밥 특유의 거칠함 없이 기분좋은 식감을 느껴보세요!','image/item_img09.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'이훈 현미밥식단 4종 12팩', 41900, 0, '더욱 다양해진 현미밥 식단으로 건강관리 하세요! 각기 다른 4종의 도시락으로 질리지않습니다!','image/item_img10.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'에스앤씨 닭가슴살 샐러드 6팩', 16900, 0, '단백질이 풍부한 닭가슴살과 식이섬유가 풍부한 각종 채소를 넣은 건강한 혼닭 닭가슴살 샐러드예요.','image/item_img11.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'허닭 닭가슴살 스테이크 5팩', 18900, 0, '삼시세끼 먹고 탄탄하고 빛나는 바디라인을 만들고 싶다면! 허닭 스테이크 도시락 5종!!','image/item_img12.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'칼로바이 파워쉐이크 14개입', 32400, 0, '간편하고 맛있고 건강한 재료를 사용한 단백질 쉐이크! 황금비율 배합비가 적용된 프리미엄 단백질로 선택하세요!!','image/item_img13.png', DEFAULT, 'Y');
INSERT INTO OPT_ITEM VALUES(ITEM_NUM_SEQ.NEXTVAL,'땡스귀리 도시락 6개입', 24000, 0, '포만감이 풍부한 삶은 귀리, 식이섬유가 풍부한 4색 콩과 각종 야채의 만남으로 채소의 영양을 그대로 섭취하실수 있는 다이어트 도시락입니다','image/item_img14.png', DEFAULT, 'Y');

SELECT * FROM OPT_ITEM;
-------------상품댓글-------------------
DROP SEQUENCE ITEMCOMMENTSEQ;
DROP TABLE OPT_ITEM_COMMENT CASCADE CONSTRAINTS PURGE;
CREATE SEQUENCE ITEMCOMMENTSEQ;
CREATE TABLE OPT_ITEM_COMMENT(
	OPT_NO_SEQ NUMBER REFERENCES OPT_MEMBER,		-- 회원번호 참조키
	ITEM_NUM_SEQ NUMBER REFERENCES OPT_ITEM,		-- 상품번호 참조키
	ITEM_COMMENT_NO_SEQ NUMBER PRIMARY KEY,			-- 댓글번호
	ITEM_COMMENT_CONTENT VARCHAR2(1000) NOT NULL,	-- 댓글내용
	ITEM_COMMENT_DATE VARCHAR2(1000) NOT NULL		-- 댓글작성시간
)
SELECT * FROM OPT_ITEM_COMMENT;

INSERT INTO OPT_ITEM_COMMENT
VALUES(3, 1, ITEMCOMMENTSEQ.NEXTVAL, '굿굿', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI'));

SELECT OPT_ID, OPT_NO_SEQ, ITEM_NUM_SEQ, ITEM_COMMENT_NO_SEQ, ITEM_COMMENT_CONTENT, ITEM_COMMENT_DATE
FROM (SELECT M.OPT_ID, I.OPT_NO_SEQ, I.ITEM_NUM_SEQ, I.ITEM_COMMENT_NO_SEQ, I.ITEM_COMMENT_CONTENT, I.ITEM_COMMENT_DATE
FROM OPT_ITEM_COMMENT I, OPT_MEMBER M
WHERE I.OPT_NO_SEQ = M.OPT_NO_SEQ
AND ITEM_NUM_SEQ = 1);

-------------결제-----------------------
DROP SEQUENCE PAYSEQ;
DROP TABLE OPT_PAYMENT CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE PAYSEQ;
CREATE TABLE OPT_PAYMENT(
    OPT_NO_SEQ NUMBER REFERENCES OPT_MEMBER,            --회원번호FK
    ITEM_NUM_SEQ NUMBER REFERENCES OPT_ITEM (ITEM_NUM_SEQ), --상품번호FK
    PAY_SEQ NUMBER PRIMARY KEY,        					--결제번호PK
    PAY_RECIPIENT_NAME VARCHAR2(100) NOT NULL,          --수령인
    PAY_PLACE VARCHAR2(1000) NOT NULL,                  --배송주소
    PAY_PHONE VARCHAR2(100) NOT NULL,                   --배송지 전화번호
    PAY_MEMO VARCHAR2(3000),                            --배송 요청사항
    PAY_COUNT NUMBER NOT NULL,                          --상품수량
    PAY_DATE DATE NOT NULL,								--결제일
    PAY_TOTAL NUMBER NOT NULL								--총 결제금액
);

INSERT INTO OPT_PAYMENT VALUES(3,1,PAYSEQ.NEXTVAL,'홍길동','경기도 고양시 덕양구','010-1234-4567','경비실에 놔주세요',1,SYSDATE, 1500);
INSERT INTO OPT_PAYMENT VALUES(3,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,SYSDATE, 35000);
INSERT INTO OPT_PAYMENT VALUES(4,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-08-13', 10500);
INSERT INTO OPT_PAYMENT VALUES(5,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-08-13', 12700);
INSERT INTO OPT_PAYMENT VALUES(4,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-08-13', 42000);
INSERT INTO OPT_PAYMENT VALUES(3,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-08-12', 10000);
INSERT INTO OPT_PAYMENT VALUES(4,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-08-12', 5000);
INSERT INTO OPT_PAYMENT VALUES(5,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-07-28', 7500);
INSERT INTO OPT_PAYMENT VALUES(5,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-07-28', 15000);
INSERT INTO OPT_PAYMENT VALUES(5,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-07-28', 21000);
INSERT INTO OPT_PAYMENT VALUES(6,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-07-28', 46000);
INSERT INTO OPT_PAYMENT VALUES(6,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-06-28', 30000);
INSERT INTO OPT_PAYMENT VALUES(6,2,PAYSEQ.NEXTVAL,'강호동','서울특별시 마포구','010-1423-4467','3시에 와주세요',1,'2019-06-28', 37000);

-----------------배송조회--------------
DROP TABLE PURCHASE_DELIVERY;

CREATE TABLE PURCHASE_DELIVERY(
    PAY_SEQ NUMBER REFERENCES OPT_PAYMENT (PAY_SEQ),    --결제번호FK
    DELIVERY_CODE VARCHAR2(100) NOT NULL,               --택배사코드
    DELIVERY_NUMBER VARCHAR2(100)                       --운송장번호
);

INSERT INTO PURCHASE_DELIVERY VALUES(1,17,1234567);

SELECT * FROM PURCHASE_DELIVERY;

---------------쪽지함-----------------------

DROP SEQUENCE POSTSEQ;
DROP TABLE OPT_POSTBOX CASCADE CONSTRAINTS PURGE;

CREATE SEQUENCE POSTSEQ;

CREATE TABLE OPT_POSTBOX(
     OPT_NO_SEQ 		NUMBER 			REFERENCES	OPT_MEMBER,           	--회원번호FK (보낸사람)
     POST_NO_SEQ 		NUMBER 			PRIMARY KEY,        	            --쪽지번호PK
     POST_RECIVE_ID 	VARCHAR2(100) 	NOT NULL,   		    		    --받는사람ID
     POST_TITLE			VARCHAR2(200)	NOT NULL,							--쪽지제목
     POST_CONTENT 		VARCHAR2(2000)	NOT NULL,							--쪽지내용
     POST_SEND_DATE 	VARCHAR2(200)	NOT NULL,							--보낸시간
     POST_RECIVE_READ 	VARCHAR2(2)		CONSTRAINT read_ck CHECK (POST_RECIVE_READ IN('Y','N')),	--쪽지확인여부
     POST_READ_DATE		VARCHAR2(200)	NOT NULL,							--쪽지확인시간
     POST_SEND_DEL 		VARCHAR2(2)		CONSTRAINT sendDel_ck CHECK (POST_SEND_DEL IN('Y','N')),	--보낸쪽지 삭제여부
     POST_READ_DEL 		VARCHAR2(2)		CONSTRAINT reciveDel_ck CHECK (POST_READ_DEL IN('Y','N'))	--받은쪽지 삭제여부						--받은쪽지 삭제여부
);

INSERT INTO OPT_POSTBOX VALUES(
	1, POSTSEQ.NEXTVAL, 'user1', '환영합니다', '사이트 이용가이드를 참고하세요', 
	TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI'), 'N', TO_CHAR(SYSDATE, 'YYYY-MM-DD-HH24-MI'), 'N', 'N'
);

INSERT INTO OPT_POSTBOX VALUES(
	2, POSTSEQ.NEXTVAL, 'admin', '감사합니다', '가입인사 드립니다~', 
	TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI'), 'N', TO_CHAR(SYSDATE, 'YYYY-MM-DD-HH24-MI'), 'N', 'N'
);

SELECT * FROM OPT_POSTBOX;