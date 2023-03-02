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
                fillCatalogItems()
                
                //  При загрузке экрана первая категоря должна быть активна
                categoryClick(current: 0)
            }
            else{
                isCatalogLoaded = false
            }
        }
    }
    
    //  Массив с элементами каталога
    //  Объекты хранят информацию с сервера,
    //  а также данные для работы с корзиной
    @Published var catalogItemArr: [CatalogItem] = []
    
    
    //  Отфильтрованый каталог
    //  В новой концепции используется только для
    //  отображения в фильтрованом представлении
    @Published var filtredCatalogArr: [CatalogItem]  = []
    
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
    
    
    func fillCatalogItems(){
        
        for item in catalogArr{
            catalogItemArr.append(CatalogItem(id: item.id, name: item.name, description: item.description, price: item.price, category: item.category, time_result: item.time_result, preparation: item.preparation, bio: item.bio))
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
    
    //  Для перерисовки и перезаполнения фильтрованного массива
    //  актуальными данными из основного, над которым происходит
    //  вся работа.
    var currentCategory = ""
    
    func filter(category: String){
        
        currentCategory = category
        
        filtredCatalogArr = []
        
        for item in catalogItemArr{
            if item.category == category{
                filtredCatalogArr.append(CatalogItem(id: item.id, name: item.name, description: item.description, price: item.price, category: item.category, time_result: item.time_result, preparation: item.preparation, bio: item.bio, isInCart: item.isInCart, count: item.count))
                
            }
        }
    }
    
    
    @Published var isShow = false
    
    @Published var selectedItemIndex = 0
    
    func catalogItemClick(id: Int){
        
        selectedItemIndex = findObjectIndexById(id: id)
        
        if catalogItemArr[selectedItemIndex].isInCart{

            removeFromCart(id: id)
        }
        else{
            isShow = true
        }
    }
    
    func findObjectIndexById(id: Int) -> Int {
        
        var index = 0
        
        for item in catalogItemArr{
            if item.id == id{
                return index
            }
            
            index += 1
        }
        
        //  Если нет совпадения
        return 0
    }
    
    //  Функция для поиска элемента в корзине
    func findObjectIndexInCart(id: Int) -> Int {
        
        var index = 0
        
        for item in cart{
            if item.id == id{
                return index
            }
            
            index += 1
        }
        
        //  Если нет совпадения
        return 0
    }
    
    
    func closeSheet(){
        selectedItemIndex = 0
    }
    
    
    @Published var cart: [CatalogItem] = [] {
        didSet{
            
            getSumm()
            
            if !cart.isEmpty{
                isShowCart = true
            }
            else{
                isShowCart = false
            }
        }
    }
    
    @Published var isShowCart = false
    @Published var summ = 0
    
    func addToCart(){
        
        catalogItemArr[selectedItemIndex].isInCart = true
        catalogItemArr[selectedItemIndex].count = 1
        
        cart.append(catalogItemArr[selectedItemIndex])
        
        //  Перерисовка
        filter(category: currentCategory)
        getSumm()
        
        isShow = false
    }
    
    func removeFromCart(id: Int){
        
        catalogItemArr[selectedItemIndex].isInCart = false
        catalogItemArr[selectedItemIndex].count = 0
    
        cart.remove(at: findObjectIndexInCart(id: id))
        
        filter(category: currentCategory)
    }
    
    func getSumm(){
        
        summ = 0
        
        for item in catalogItemArr{
            
            if item.isInCart{
                summ += (item.count * Int(item.price)!)
            }
        }
    }
    
}
