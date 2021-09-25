bgetwd()
library(rvest)
url<-"https://www.picknbuy24.com/usedcar/?location=korea"
html<-read_html(url)
price<-html_nodes(html,"div.fob")
price<-html_nodes(price,"b")
price<-html_text(price)
price<-gsub("[^[:alnum:]]","", price)
price<-gsub("US","",price)
price<-as.numeric(price)



car_name<-html_nodes(html,"div.carName")
car_refno<-html_nodes(car_name,"div.refno")
car_refno<-html_text(car_refno)



car_name<-html_nodes(car_name,"a")
car_name<-html_text(car_name)

car_info<-data.frame(country="korea",Ref_No=car_refno,Car_Name=car_name,Price_in_USD=price)


car_in_kore<-function(page_no){
                                url<-paste("https://www.picknbuy24.com/usedcar/?location=korea&page=",page_no,sep="")
                                html<-read_html(url)
                                price<-html_nodes(html,"div.fob")
                                price<-html_nodes(price,"b")
                                price<-html_text(price)
                                price<-gsub("[^[:alnum:]]","", price)
                                price<-gsub("US","",price)
                                price<-as.numeric(price)
                                
                                
                                
                                car_name<-html_nodes(html,"div.carName")
                                car_refno<-html_nodes(car_name,"div.refno")
                                car_refno<-html_text(car_refno)
                                
                                
                                
                                car_name<-html_nodes(car_name,"a")
                                car_name<-html_text(car_name)
                                
                                car_info<-data.frame(country="korea",Ref_No=car_refno,Car_Name=car_name,Price_in_USD=price)
                                
}
car_infor<-car_in_kore(2)
car_info<-sapply(1:33, car_in_kore,simplify = F,USE.NAMES = F)
car_info<-do.call(rbind,car_info)


car_in_japan<-function(page_no){
  url<-paste("https://www.picknbuy24.com/usedcar/?location=japan&page=",page_no,sep="")
  html<-read_html(url)
  price<-html_nodes(html,"div.fob")
  price<-html_nodes(price,"b")
  price<-html_text(price)
  price<-gsub("[^[:alnum:]]","", price)
  price<-gsub("US","",price)
  price<-as.numeric(price)
  
  
  
  car_name<-html_nodes(html,"div.carName")
  car_refno<-html_nodes(car_name,"div.refno")
  car_refno<-html_text(car_refno)
  
  
  
  car_name<-html_nodes(car_name,"a")
  car_name<-html_text(car_name)
  
  car_info2<-data.frame(country="japan",Ref_No=car_refno,Car_Name=car_name,Price_in_USD=price)
  
}

cars_in_jap<-sapply(1:599, car_in_japan,simplify = F,USE.NAMES = F)
cars_in_jap<-do.call(rbind,cars_in_jap)

car_for_sale<-rbind(car_info,cars_in_jap)
