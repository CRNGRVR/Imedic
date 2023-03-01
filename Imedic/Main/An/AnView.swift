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
            
            ScrollView(.vertical){
                VStack{
                    Text("Акции и новости")
                    
                    //  Блок новостей
                    ScrollView(.horizontal){
                        if anVM.isNewsLoaded{
                            HStack(spacing: 16){
                                ForEach(anVM.newsArr){news in
                                    NewsBlock(title: news.name, descript: news.description, price: news.price, imageURL: news.image)
                                }
                            }
                        }
                    }
                    
                    Text("Каталог анализов")
                    
                    //  Фильтры по категориям
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
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
                    }
                    
                    //  Каталог
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            ForEach(anVM.filtredCatalogArr){item in
                                Text(item.name)
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            anVM.getAll()
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
            
            Text(title)
                .foregroundColor(Color.white)
                .frame(width: 200)
                .font(.system(size: 20, weight: .bold))
                .padding(.trailing, 50)
                .padding(.bottom, 80)
            
            Text(descript)
                .foregroundColor(Color.white)
                .frame(width: 200)
                .font(.system(size: 12))
                .multilineTextAlignment(.leading)
                .padding(.trailing, 130)
                .padding(.top, 40)
            
            Text(price)
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 100)
                .padding(.trailing, 190)
        }
    }
}

struct AnView_Previews: PreviewProvider {
    static var previews: some View {
        AnView(nav: NavVm())
    }
}
