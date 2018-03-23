/*Flightları fact olarak yazdım*/
flight(istanbul,ankara,5).
flight(ankara,istanbul,5).
flight(istanbul,izmir,3).
flight(izmir,istanbul,3).
flight(istanbul,trabzon,3).
flight(trabzon,istanbul,3).
flight(edirne,edremit,5).
flight(edremit,edirne,5).
flight(edremit,erzincan,7).
flight(erzincan,edremit,7).
flight(izmir,antalya,1).
flight(antalya,izmir,1).
flight(izmir,ankara,6).
flight(ankara,izmir,6).
flight(antalya,diyarbakir,5).
flight(diyarbakir,antalya,5).
flight(diyarbakir,konya,1).
flight(konya,diyarbakir,1).
flight(ankara,konya,8).
flight(konya,ankara,8).
flight(konya,kars,5).
flight(kars,konya,5).
flight(kars,gaziantep,3).
flight(gaziantep,kars,3).
flight(ankara,trabzon,2).
flight(trabzon,ankara,2).
/*1 ->Bu fonksiyon X noktasından Y noktasına giden bütün yolları C cost'uyla hesaplar ve ekrana verir */
route(X,Y,C):-
    flight(X,D,C1),
    flight(D,Y,C2),
    C is (C1+C2),
	X\==Y;
	flight(X,Y,C).
/*2 ->Bu fonksiyon X noktasından Y noktasına giden bütün yolları C cost'uyla hesaplar ve ekrana minimum C'yi verir */
croute(X,Y,C):-
    findall(C,route(X,Y,C),L),
    min_list(L,A),
    C is A.

/*Burada zamanla ilgili fact'leri yazdım*/
when(a,10).
when(b,12).
when(c,11).
when(d,16).
when(e,17).
when(f,14).
when(g,9).

/*Burada yer ile ilgili fact'leri yazdım*/

where(a,101).
where(b,104).
where(c,102).
where(d,103).
where(e,103).
where(f,102).
where(g,101).

/*Burada enroll ile ilgili fact'leri yazdım*/
enroll(1,a).
enroll(1,b).
enroll(2,a).
enroll(3,b).
enroll(4,c).
enroll(5,d).
enroll(6,d).
enroll(6,a).

/*Burada 3.0 için gerekli enrollment'ları yaptım*/
enroll(7,a).
enroll(7,c).
enroll(8,b).
enroll(8,d).
enroll(9,f).
enroll(9,e).
enroll(10,g).
enroll(10,a).
enroll(11,d).
enroll(11,g).

/*3.1 ->Bu fonksiyon verilen enroll değerine göre o enrollment'a ait ders saatlerini ve sınıflarını gösterir*/
schedule(S,P,T):-
	enroll(S,X),
	where(X,P),
	when(X,T).

/*3.2 ->Bu fonksiyon verilen place değerine göre o sınıfta ki derslerin saatini gösterir.*/
usage(P,T):-
    where(X,P),
    when(X,T).

    
/*3.3 ->Bu fonksiyon verile 2 session'ın çakışmasını kontrol eder çakışıyorsa true çakışmıyorsa false döndürür.*/
conflict(X,Y):- 
	where(X,P1),
	where(Y,P2),
    when(X,T1),
    when(Y,T2),
     (P1 == P2 ->true;   (T1==T2 ->true;   (T1-T2 =:= 1 -> true;(T2-T1 =:= 1->  true;false)))).
/*3.4 ->Bu fonksiyon 2 enrollment'ın çakışmasını kontrol eder çakışıyorsa true çakışmıyorsa false döndürür.*/
meet(X,Y):-
    enroll(X,Z),
    enroll(Y,K),
    where(Z,A),
    where(K,B),
    when(Z,C),
    when(K,D),
    A=:=B,
    C=:=D.

/*4.2 ->Bu fonksiyon verilen 2 listenin kesişimini döndürür.*/
intersect(L1,L2,I):-
    intersection(L1,L2,I).
/*4.1 ->Bu fonksiyon verilen 2 listenin bileşimini döndürür.*/
union([ ], L, L).

union([Head|Tail], S, U):- member(Head, S), !, union(Tail, S, U).

union([Head|Tail], S, [Head|Tail2]):- union(Tail, S, Tail2).
/*4.3 ->Bu fonksiyon iç içe olan liste elemanlarını düz olarak bastırır.*/
flatten([], []).
flatten([Head|Tail], F):- 
    flatten(Head, List1),!,
	flatten(Tail, List2),!,
    append(List1, List2, F).
flatten(Head, [Head]).