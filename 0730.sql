-- 列出帳單
select tel, sum(fee) as sum_fee
from bill
group by tel

-- 大於1000帳單(巢狀查詢)
select *
from (
    select tel, sum(fee) as sum_fee
    from bill
    group by tel
) as a
where sum_fee >=1000

-- 找出最多的一筆帳單 **電話錯誤(BUG)
select tel, max(sum_fee)
from (
    select tel, sum(fee) as sum_fee
    from bill
    group by tel
) as a

-- 極端值(MAX)
-- 先找出極端值(MAX)，再從總表裡找出相同值
select tel, max_sum_fee
from (
    select max(sum_fee) as max_sum_fee
    from (
        select tel, sum(fee) as sum_fee
        from bill
        group by tel
    ) as a
) as aa, (
    select tel, sum(fee) as sum_fee
    from bill
    group by tel
) as bb
where aa.max_sum_fee = bb.sum_fee


-- 列出哪個人擁有最多支電話
select uid, max_n
from( 
    select max(n) as max_n
    from (
        select userinfo.uid, count(tel) as n
        from userinfo left join live on userinfo.uid = live.uid
            left join phone on live.hid = phone.hid
        group by userinfo.uid
    ) as a
) as aa, (
    select userinfo.uid, count(tel) as n
    from userinfo left join live on userinfo.uid= live.uid
        left join phone on live.hid = phone.hid
    group by userinfo.uid
) as bb
where aa.max_n = bb.n

-- 列出哪個人擁有最多支電話(簡化寫法)
create view vw_惠我良多 as  --建立view

select tel, aa.sum_fee
from (
    select sum(fee) as sum_fee
    from bill
    group by tel
    order by sum_fee desc
    limit 1
) as aa, (
    select tel, sum(fee) as sum_fee
    from bill
    group by tel
) as bb
where aa.sum_fee = bb.sum_fee

--時間
select concat(date_format(now(), '西元%Y年%m月%d日 %W'), '第', quarter(now()),'季');

--利用「date_format」撈出2019年4月資料
SELECT *
from bill
where date_format(dd,'%Y%m') = '201904'

--查詢六個月前的資料
SELECT *
from bill
where dd not between adddate(now(), interval - 6 month)and now();

--作業01
建立資料庫表
1. 客戶資料表，含頭像資料
2. 商品資料表，含有八個影像資料  /*base64*/
3. 交易資料表，含有交易時間紀錄


各表自行建立資料
1. 客戶資料表: 1000+組不同的客戶資料
2. 商品資料表: 100+組不同的商品資料
3. 交易資料表: 3000+組

查詢/統計資料
1. 特定時間區間內的熱門商品
2. 特定時間區間內的客戶交易排行榜

資料備份移轉