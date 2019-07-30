SELECT userinfo.uid, live.uid, cname, address, tel
from userinfo left join live on
    userinfo.uid = live.uid
    left join house on
    live.hid = house.hid
    left join phone on
    house.hid = phone.hid



/* ------------------------------------- */
SELECT live.uid, cname, address, tel
from userinfo, live, house, phone
where userinfo.uid = live.uid AND
	live.hid = house.hid AND
    house.hid = phone.hid AND
    cname = '王大明'


/*------------------別名------------------*/
SELECT a.uid, cname, address, tel
from userinfo as a, live as b, house as c, phone as d
where a.uid = b.uid AND
	b.hid = c.hid AND
    c.hid = d.hid

/*-----------------別名2------------------*/
SELECT a.uid as '帳號', cname as '姓名', address as '住址', tel as '電話'
from userinfo as a, live as b, house as c, phone as d
where a.uid = b.uid AND
	b.hid = c.hid AND
    c.hid = d.hid

/*--------別名3(自動把重複資料拿掉)--------*/
SELECT distinct a.uid as '帳號', cname as '姓名', address as '住址'
from userinfo as a, live as b, house as c, phone as d
where a.uid = b.uid AND
	b.hid = c.hid AND
    c.hid = d.hid

/*-------平均(四捨五入取小數點第一位)-------*/
select tel, round(avg(fee),0) as '平均金額' from bill
GROUP BY tel

/*-------三個表單皆為群組之後算出來了--------*/
select bill.tel, round(avg(fee),0) as '平均金額', address
from bill, phone, house
where bill.hid = phone.hid and phone.hid = house.hid
GROUP BY bill.tel, address



/*------列出所以屋子的住戶清單，限用右側外部連結------*/

