//
//  AnVM.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation
import Alamofire

class AnVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm) {
        self.nav = nav
    }
    
    @Published var find = ""
    
    //  Список новостей
    @Published var newsArr: [NewsOutputUnit] = []{
        didSet{
            //  Если значение появляется, то можно показать список на view
            if !newsArr.isEmpty{
                isNewsLoaded = true
            }
            else{
                isNewsLoaded = false
            }
        }
    }
    
    //  Каталог всех анализов
    var catalogArr: [CatalogOutputUnit] = []{
        didSet{
            if !catalogArr.isEmpty{
                isCatalogLoaded = true
                getCategory()
                
                //  При загрузке экрана первая категоря должна быть активна
                categoryClick(current: 0)
            }
            else{
                isCatalogLoaded = false
            }
        }
    }
    
    //  Отфильтрованый каталог
    @Published var filtredCatalogArr: [CatalogOutputUnit]  = []
    
    //  Имеются ли значения(для отображения)
    @Published var isNewsLoaded = false
    @Published var isCatalogLoaded = false
    
    //  Список всех категорий
    @Published var categories: [Category] = []
    
    //  Извлечение данных при загрузке view
    func getAll(){
        getNews()
        getCatalog()
    }
    
    
    func getNews(){
        
        AF
            //  Апи возвращает не объект с массивом, а массив с объектами
            .request("https://medic.madskill.ru/api/news", method: .get)
            .responseDecodable(of: [NewsOutputUnit].self){responce in
                
                if responce.value != nil{
                    self.newsArr = responce.value!
                }
            }
    }
    
    func getCatalog(){
        
        AF
            .request("https://medic.madskill.ru/api/catalog")
            .responseDecodable(of: [CatalogOutputUnit].self){responce in
                
                if responce.value != nil{
                    self.catalogArr = responce.value!
                }
                else{
                    print("Error")
                }
            }
    }
    
    
    //  Показывает имеющиеся категории анализов без повторений
    func getCategory(){
        
        for category in catalogArr {
            
            var new = true
            
            if categories.isEmpty{
                categories.append(Category(id: categories.count, name: category.category))
                continue
            }
            
            for yet in categories{
                
                if category.category == yet.name{
                    new = false
                }
            }
            
            if new{
                categories.append(Category(id: categories.count, name: category.category))
            }
        }
        
    }
    
    //  Действие по нажатию на категорию
    func categoryClick(current: Int){
        
        //  Очистка выделения кнопок и списка фильтрованых результатов
        refreshSelection()
        
        //  Выделение соответствующей кнопки
        categories[current].isActive = true
        
        //  Фильтрация
        filter(category: categories[current].name)
    }
    
    //  Расчет ширины кнопки
    func calcButtonWidth(word: String) -> CGFloat{
        //Длина буквы примерно 8 пикселей, отступы по краям по 20
        return CGFloat((word.count * 8) + 20 + 20)
    }
    
    func refreshSelection(){
        //  Снятие выделения кнопки
        for i in 0...categories.count - 1{
            categories[i].isActive = false
        }
        
        filtredCatalogArr = []
    }
    
    func filter(category: String){
        for item in catalogArr{
            if item.category == category{
                filtredCatalogArr.append(item)
            }
        }
    }
    
    
    @Published var isShow = false
    
    @Published var selectedItem = CatalogOutputUnit(id: 0, name: "Нет такого объекта", description: "Совсем нету", price: "0", category: "Ошибка", time_result: "Никогда", preparation: "Нет", bio: "Нет")
    
    func catalogItemClick(id: Int){
        
        selectedItem = findObjectById(id: id)
        isShow = true
    }
    
    func findObjectById(id: Int) -> CatalogOutputUnit{
        for item in filtredCatalogArr{
            if item.id == id{
                return item
            }
        }
        
        //  Если нет совпадения
        return voidCatalogObject()
    }
    
    func closeSheet(){
        selectedItem = voidCatalogObject()
    }
    
    //  Возврат объекта-заглушки, если нет настоящего
    func voidCatalogObject() -> CatalogOutputUnit{
        return CatalogOutputUnit(id: 0, name: "Нет такого объекта", description: "Совсем нету", price: "0", category: "Ошибка", time_result: "Никогда", preparation: "Нет", bio: "Нет")
    }
    
    
    
    @Published var isShowCart = false
    @Published var summ = 0
    
    func addToCart(){
        
    }
    
    func removeFromCart(){
        
    }
    
}
