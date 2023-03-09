//
//  AnView.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnView: View {
    
    @ObservedObject var anCartVM: AnCartVM
    
    var body: some View {
        ZStack{
            VStack{
                tf(text: $anCartVM.find, placeHolder: "Искать анализы")
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        Text("Акции и новости")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.trailing, 180)
                        
                        //  Блок новостей
                        ScrollView(.horizontal, showsIndicators: false){
                            if anCartVM.isNewsLoaded{
                                HStack(spacing: 16){
                                    ForEach(anCartVM.newsArr){news in
                                        NewsBlock(title: news.name, descript: news.description, price: news.price, imageURL: news.image)
                                    }
                                }
                                .padding(.leading, 30)
                            }
                        }
                        
                        Text("Каталог анализов")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.trailing, 180)
                        
                        //  Фильтры по категориям
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 16){
                                ForEach(anCartVM.categories){category in
                                    Button(action: {anCartVM.categoryClick(current: category.id)}, label: {
                                        
                                        ZStack{
                                            Color(category.isActive ? "active" : "tf")
                                                .frame(width: anCartVM.calcButtonWidth(word: category.name), height: 48)
                                                .cornerRadius(10)
                                            
                                            Text(category.name)
                                                .foregroundColor(category.isActive ? .white : .gray)
                                                .font(.system(size: 15))
                                        }
                                    })
                                }
                            }
                            .padding(.leading, 30)
                        }

                        .padding(.bottom, 20)
                        
                        //  Каталог
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 16){
                                ForEach(anCartVM.filtredCatalogArr){item in
                                    CatalogBlock(anVM: anCartVM, id: item.id, title: item.name, duration: item.time_result, price: item.price, isInCart: item.isInCart)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                
                if anCartVM.isShowCart{
                    Button(action: {
                        anCartVM.goToCart()
                    }, label: {
                        ZStack{
                            Color("active")
                                .frame(width: 335, height: 56)
                                .cornerRadius(10)
                            
                            Text("В корзину \(anCartVM.summ) ₽")
                                .foregroundColor(Color.white)
                                .font(.system(size: 17, weight: .semibold))
                        }
                    })
                }
            }
            .alert(isPresented: $anCartVM.isErr){
                Alert(title: Text("Проблемы c cетью"))
            }
            
            
            
            
            if anCartVM.isShow{
                
                ZStack{
                    Color.black
                        .opacity(0.8)
                        .ignoresSafeArea(.all)
                        .padding(.bottom, 300)
                    
                    ItemSheet(anVM: anCartVM)
                    .padding(.top, 235)
                }
            }
        }
        .onAppear{
            anCartVM.getAll()
        }
    }
}


struct NewsBlock: View{
    
    var title: String
    var descript: String
    var price: String
    var imageURL: String
    
    var body: some View{
        ZStack{
            Color("news")
                .frame(width: 270, height: 152)
                .cornerRadius(12)
            
           WebImage(url: URL(string: imageURL))
                .resizable()
                .frame(width: 170, height: 140)
                .padding(.leading, 100)
                .padding(.top, 10)
            
            VStack{
                Text(title)
                    .foregroundColor(Color.white)
                    .frame(width: 230, height: 50, alignment: .leading)
                    .font(.system(size: 20, weight: .bold))
                
                Text(descript)
                    .foregroundColor(Color.white)
                    .frame(width: 230,height: 45, alignment: .leading)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                
                Text("\(price) ₽")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 230,height: 10, alignment: .leading)
            }
        }
    }
}


struct CatalogBlock: View{
    
    @ObservedObject var anVM: AnCartVM
    
    var id: Int
    var title: String
    var duration: String
    var price: String
    var isInCart: Bool
    
    var body: some View{
        
        ZStack{
            Color("tf")
                .frame(width: 335, height: 136)
                .cornerRadius(10)
            
            VStack{
                Text(title)
                    .frame(width: 250, height: 50, alignment: .leading)
                    .frame(width: 303)
                    .font(.system(size: 16))
                    .padding(.trailing, 50)
                
                HStack{
                    VStack{
                        Text(duration)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 14))
                            .frame(width: 120, alignment: .leading)
                        
                        Text("\(price) ₽")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: 120, alignment: .leading)
                            
                    }
                    .padding(.trailing, 80)
                    
                    
                    Button(action: {
                        anVM.catalogItemClick(id: id)
                    }, label: {
                        if !isInCart{
                            ZStack{
                                Color("active")
                                    .frame(width: 96, height: 40)
                                    .cornerRadius(10)
                                
                                Text("Добавить")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14))
                                    
                            }
                        }
                        else{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("active"), lineWidth: 1)
                                    .frame(width: 96, height: 40)
                                Text("Убрать")
                                    .foregroundColor(Color("active"))
                            }
                        }
                    })
                }
            }
            
        }
    }
}


//  Решение с применением Scrollview сомнительное и не соответствует
//  заданию, но иначе текст физически не умещается на экране
struct ItemSheet: View{
    
    @ObservedObject var anVM: AnCartVM

    var body: some View{
        ZStack{
            
            Color.white
                .frame(width: 390, height: 636)
                .cornerRadius(10)
            
            VStack{
                
                HStack{
                    
                    Text(anVM.catalogArr[anVM.selectedItemIndex].name)
                        .font(.system(size: 20, weight: .semibold))
                        //.frame(width: 310, height: 80 ,alignment: .topLeading)
                        .frame(minWidth: 310, maxWidth: 310, minHeight: 0, maxHeight: 80, alignment: .topLeading)
                        .padding(.top, 10)
                    
                    Button(action: {anVM.isShow = false}, label: {
                        ZStack{
                            Color("tf")
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                            Image("X")
                        }
                    })
                    .padding(.bottom, 20)
                }
                //.padding(.bottom, 20)
                
                ScrollView(.vertical, showsIndicators: false){
                    Text("Описание")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                        .padding(.trailing, 270)

                    Text(anVM.catalogArr[anVM.selectedItemIndex].description)
                        .frame(width: 345, alignment: .topLeading)
                        .font(.system(size: 15))
                        .padding(.bottom, 16)
                    
                    Text("Подготовка")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                        .padding(.trailing, 255)

                    Text(anVM.catalogArr[anVM.selectedItemIndex].preparation)
                        .font(.system(size: 15))
                        .frame(width: 345, alignment: .topLeading)
                        .padding(.bottom, 44)

                    HStack{
                        VStack{
                            Text("Результаты через:")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.bottom, 4)
                                .padding(.trailing, 40)

                            Text(anVM.catalogArr[anVM.selectedItemIndex].time_result)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 170, height: 70, alignment: .topLeading)
                        }
                        //.padding(.trailing, 100)

                        VStack{
                            Text("Биоматериал:")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.bottom, 4)
                                .padding(.trailing, 70)

                            Text(anVM.catalogArr[anVM.selectedItemIndex].bio)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 170, height: 70, alignment: .topLeading)
                                
                        }
                    }
                    .padding(.bottom, 19)
                }
                .frame(height: 450)
                
                Button(action: {anVM.addToCart()}, label: {
                    ZStack{
                        Color("active")
                            .frame(width: 335, height: 56)
                            .cornerRadius(10)
                        
                        Text("Добавить за \(anVM.catalogArr[anVM.selectedItemIndex].price) ₽")
                            .foregroundColor(Color.white)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                })
                .padding(.bottom, 20)
            }
        }
    }
}






struct AnView_Previews: PreviewProvider {
    static var previews: some View {
        //AnView(nav: NavVm())
        //CatalogBlock(title: "Клинический анализ крови с лейкоцитарной формулировкой", duration: "7 рабочих дней", price: "1800")
        
        //NewsBlock(title: "Результаты ПЦР-теста на COVID-19 за 3 часа", descript: "Теперь результат ПЦР-теста на COVID-19 можно получить уже через 3 часа!", price: "1400", imageURL: "https://medic.madskill.ru/filemanager/uploads/pngwing.com (4).png")
        
        ItemSheet(anVM: AnCartVM(nav: NavVm()))
    }
}
