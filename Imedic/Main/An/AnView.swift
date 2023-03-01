//
//  AnView.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnView: View {
    
    @ObservedObject var anVM: AnVM
    init(nav: NavVm){
        anVM = AnVM(nav: nav)
    }
    
    var body: some View {
        VStack{
            tf(text: $anVM.find, placeHolder: "Искать анализы")
                
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("Акции и новости")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.trailing, 180)
                    
                    //  Блок новостей
                    ScrollView(.horizontal, showsIndicators: false){
                        if anVM.isNewsLoaded{
                            HStack(spacing: 16){
                                ForEach(anVM.newsArr){news in
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
                            ForEach(anVM.categories){category in
                                Button(action: {anVM.categoryClick(current: category.id)}, label: {
                                    
                                    ZStack{
                                        Color(category.isActive ? "active" : "tf")
                                            .frame(width: anVM.calcButtonWidth(word: category.name), height: 48)
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
                            ForEach(anVM.filtredCatalogArr){item in
                                CatalogBlock(title: item.name, duration: item.time_result, price: item.price)
                            }
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
        .onAppear{
            anVM.getAll()
        }
    }
}


//struct NewsBlock: View{
//
//    var title: String
//    var descript: String
//    var price: String
//    var imageURL: String
//
//    var body: some View{
//        ZStack{
//            Color("news")
//                .frame(width: 270, height: 152)
//                .cornerRadius(12)
//
//           WebImage(url: URL(string: imageURL))
//                .resizable()
//                .frame(width: 170, height: 140)
//                .padding(.leading, 100)
//                .padding(.top, 10)
//
//            Text(title)
//                .foregroundColor(Color.white)
//                .frame(width: 200)
//                .font(.system(size: 20, weight: .bold))
//                .padding(.trailing, 50)
//                .padding(.bottom, 80)
//
//            Text(descript)
//                .foregroundColor(Color.white)
//                .frame(width: 200)
//                .font(.system(size: 12))
//                .multilineTextAlignment(.leading)
//                .padding(.trailing, 130)
//                .padding(.top, 40)
//
//            Text(price)
//                .foregroundColor(Color.white)
//                .font(.system(size: 20, weight: .bold))
//                .padding(.top, 100)
//                .padding(.trailing, 190)
//        }
//    }
//}

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
                
                Text("\(price)₽")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 230,height: 10, alignment: .leading)
            }
        }
    }
}


struct CatalogBlock: View{
    
    var title: String
    var duration: String
    var price: String
    
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
                        
                        Text("\(price)₽")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: 120, alignment: .leading)
                            
                    }
                    .padding(.trailing, 80)
                    
                    
                    Button(action: {}, label: {
                        ZStack{
                            Color("active")
                                .frame(width: 96, height: 40)
                                .cornerRadius(10)
                            
                            Text("Добавить")
                                .foregroundColor(Color.white)
                                .font(.system(size: 14))
                                
                        }
                    })
                }
            }
            
        }
    }
}


//struct CatalogBlock: View{
//
//    var title: String
//    var duration: String
//    var price: String
//
//    var body: some View{
//
//        ZStack{
//            Color("tf")
//                .frame(width: 335, height: 136)
//                .cornerRadius(10)
//
//            Text(title)
//                .frame(width: 303)
//                .font(.system(size: 16))
//                .padding(.bottom, 60)
//                .padding(.trailing, 60)
//
//            Text(duration)
//                .foregroundColor(Color.gray)
//                .font(.system(size: 14))
//                .padding(.top, 50)
//                .padding(.trailing, 260)
//
//            Text(price)
//                .font(.system(size: 17, weight: .semibold))
//                .padding(.top, 90)
//                .padding(.trailing, 260)
//
//            Button(action: {}, label: {
//                ZStack{
//                    Color("active")
//                        .frame(width: 96, height: 40)
//                        .cornerRadius(10)
//
//                    Text("Добавить")
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 14))
//
//                }
//            })
//            .padding(.top, 70)
//            .padding(.leading, 220)
//        }
//    }
//}

struct AnView_Previews: PreviewProvider {
    static var previews: some View {
        //AnView(nav: NavVm())
        //CatalogBlock(title: "Клинический анализ крови с лейкоцитарной формулировкой", duration: "7 рабочих дней", price: "1800")
        
        NewsBlock(title: "Результаты ПЦР-теста на COVID-19 за 3 часа", descript: "Теперь результат ПЦР-теста на COVID-19 можно получить уже через 3 часа!", price: "1400", imageURL: "https://medic.madskill.ru/filemanager/uploads/pngwing.com (4).png")
    }
}
