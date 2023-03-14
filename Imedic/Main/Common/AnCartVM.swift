//
//  AnVM.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation
import Alamofire
import CoreData

class AnCartVM: ObservableObject{
    
    @Published var nav: NavVm
    
    init(nav: NavVm) {
        self.nav = nav
    }
    
    @Published var anCartNav = "list"
    
    //  Поле для поиска
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
    
    
    @Published var isErr = false
    
    
    //  Основной массив с элементами каталога.
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
        
        //  Для предотвращения повторной загрузки
        if !isCatalogLoaded{
            
            getNews()
            getCatalog()
            
            print("done")
        }
        
        //  Вызовется, только если на момент обновления
        //  данные уже были загружены
        if isCatalogLoaded{
            filter(category: currentCategory)
        }
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
                    self.isErr = true
                }
            }
    }
    
    
    //  Заполнение сновного массива данными из массива, пришедшего из api
    func fillCatalogItems(){
        
        for item in catalogArr{
            catalogItemArr.append(CatalogItem(id: item.id, name: item.name, description: item.description, price: item.price, category: item.category, time_result: item.time_result, preparation: item.preparation, bio: item.bio))
        }
        
        //  Извлечение данных из хранилища и заполнение корзины
        fillStoredDataAtStart()
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
        
        //  Очистка выделения кнопок
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
    
    
    //  Снятие выделения кнопки
    func refreshSelection(){
        
        for i in 0...categories.count - 1{
            categories[i].isActive = false
        }
    }
    
    //  Для перерисовки и перезаполнения фильтрованного массива
    //  актуальными данными из основного, над которым происходит
    //  вся работа.
    var currentCategory = ""
    
    //  Заполнение отдельного массива с элементами, соответствующими
    //  выбраной категории
    //
    //  Вызывается в onAppear для обновления данных при
    //  выходе из корзины
    func filter(category: String){
        
        currentCategory = category
        
        filtredCatalogArr = []
        
        for item in catalogItemArr{
            if item.category == category{
                filtredCatalogArr.append(CatalogItem(id: item.id, name: item.name, description: item.description, price: item.price, category: item.category, time_result: item.time_result, preparation: item.preparation, bio: item.bio, isInCart: item.isInCart, count: item.count))
                
            }
        }
    }
    
    //  Отображение карточки с описанием
    @Published var isShowDescriptionCard = false
    
    //  Нажатый объект, используется при отображении
    //  карточки с описанием
    @Published var selectedItemIndex = 0
    
    func catalogItemButtonClick(id: Int){
        
        selectedItemIndex = findObjectIndexById(id: id)
        
        if catalogItemArr[selectedItemIndex].isInCart{
            removeFromCartByCartId(id: id)
        }
        else{
            addToCart()
        }
    }
    
    func catalogItemFreeClick(id: Int){
        
        selectedItemIndex = findObjectIndexById(id: id)
        
        isShowDescriptionCard = true
    }
    
    //  Поиск элемента в массиве по его id
    //  необходимо для любого взаимодействия с каталогом
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
    
    //  Корзина
    @Published var cart: [CatalogItem] = [] {
        didSet{
            
            //  Перерасчёт суммы при изменении
            getSumm()
            
            if !cart.isEmpty{
                isShowCart = true
            }
            else{
                isShowCart = false
            }
        }
    }
    
    //  Показана ли кнопка корзины
    @Published var isShowCart = false
    
    //  Сумма корзины
    @Published var summ = 0
    
    
    func addToCart(){
        
        catalogItemArr[selectedItemIndex].isInCart = true
        catalogItemArr[selectedItemIndex].count = 1
        
        cart.append(catalogItemArr[selectedItemIndex])
        
        //  Перерисовка
        filter(category: currentCategory)
        
        //  После добавления экран с описанием более не нужен
        isShowDescriptionCard = false
        
        addItemInCartStorage(item: catalogItemArr[selectedItemIndex])
    }
    
    //  Удаление из корзины
    //  Метод только для anView
    func removeFromCartByCartId(id: Int){
        
        //  Изменение состояния объекта в главном массиве непосредственно
        catalogItemArr[selectedItemIndex].isInCart = false
        catalogItemArr[selectedItemIndex].count = 0
    
        cart.remove(at: findObjectIndexInCart(id: id))
        delete(id: id)
        
        filter(category: currentCategory)
    }
    
    //  Удаление из корзины
    //  Метод для CartView
    //  Метода два, ввиду использования разных механизмов отображения
    func removeFromCartByCatalogId(id: Int){
        
        catalogItemArr[findObjectIndexById(id: id)].isInCart = false
        catalogItemArr[findObjectIndexById(id: id)].count = 0
        
        
        delete(id: id)
        refreshCart()
    }
    
    func increaseItemInCart(id: Int){
        
        catalogItemArr[findObjectIndexById(id: id)].count += 1
        
        let countForSet = catalogItemArr[findObjectIndexById(id: id)].count
        
        let thisElementInStorage = findElementInStorage(id: id)
        thisElementInStorage?.setValue(countForSet, forKey: "count")
        save()
        refreshCart()
    }
    
    func decreaseItemInCart(id: Int){
        
        let index = findObjectIndexById(id: id)
        
        if catalogItemArr[index].count == 1{
            removeFromCartByCartId(id: id)
        }
        else{
            catalogItemArr[index].count -= 1
            
            let countForSet = catalogItemArr[findObjectIndexById(id: id)].count
            
            let thisElementInStorage = findElementInStorage(id: id)
            thisElementInStorage?.setValue(countForSet, forKey: "count")
            save()
        }
        
        refreshCart()
    }
    
    func deleteAllItem(){
        
        for i in 0...catalogItemArr.count - 1{
            catalogItemArr[i].isInCart = false
            catalogItemArr[i].count = 0
        }
        
        //  Хранилище тоже очищается
        deleteAll()
        
        refreshCart()
    }
    
    func refreshCart(){
        
        cart = []
        
        for item in catalogItemArr{
            
            if item.isInCart{
                cart.append(item)
            }
        }
    }
    
    //  Перерасчёт суммы
    //  Вызывается при любых изменениях корзины
    func getSumm(){
        
        summ = 0
        
        for item in catalogItemArr{
            
            if item.isInCart{
                summ += (item.count * Int(item.price)!)
            }
        }
    }
    
    
    func goToCart(){
        anCartNav = "cart"
    }
    
    
    //  Функция расчитывает правильную форму слова "пациент"
    //  по количеству пациентов
    func wordWithCorrectEnding(count: Int) -> String{
        
        //  И это всё ради одного символа..
        //
        //  Ладно, двух
        let countStr = String(count)
        var countStrArr: Array<Character> = []
        
        for char in countStr{
            countStrArr.append(char)
        }
        
        var preLastChar: Character{
            if countStrArr.count > 1{
                return countStrArr[countStrArr.count - 2]
            }
            else{
                return "0"
            }
        }
        
        
        let lastChar = countStrArr[countStrArr.count - 1]
        
        if lastChar == "1" && count != 11{
            return "пациент"
        }
        else if preLastChar == "1" && lastChar == "2" || preLastChar == "1" && lastChar == "3" || preLastChar == "1" && lastChar == "4" {
            return "пациентов"
        }
        else if lastChar == "2" || lastChar == "3" || lastChar == "4"{
            return "пациента"
        }
        else{
            return "пациентов"
        }
    }
    
    
    func goToOrder(){
        anCartNav = "preloader"
    }
    
    
    
    
    
    func getCartFromStorage() -> [CartItem]{
        
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        
        do{
            return try CartPersistenceController.shared.viewContext.fetch(request)
        }
        catch{
            print("Проблема с извлечением данных")
            return []
        }
    }
    
    
    func fillStoredDataAtStart(){
        let dataFromStorage = getCartFromStorage()
        
        if !dataFromStorage.isEmpty{
            for i in 0...catalogItemArr.count - 1{
                for j in 0...dataFromStorage.count - 1{
                    if catalogItemArr[i].id == dataFromStorage[j].id_item{
                        catalogItemArr[i].isInCart = dataFromStorage[j].is_in_cart
                        catalogItemArr[i].count = Int(dataFromStorage[j].count)
                    }
                }
            }
        }
        
        refreshCart()
    }
    
    func addItemInCartStorage(item: CatalogItem){
        
        let newCartItem = CartItem(context: CartPersistenceController.shared.viewContext)
        newCartItem.id = UUID()
        newCartItem.count = 1
        newCartItem.name = item.name
        newCartItem.descr = item.description
        newCartItem.category = item.category
        newCartItem.price = item.price
        newCartItem.id_item = Int32(item.id)
        newCartItem.bio = item.bio
        newCartItem.is_in_cart = true
        newCartItem.prep = item.preparation
        newCartItem.time = item.time_result
        
        save()
    }
    
    func save(){
        do{
            try CartPersistenceController.shared.viewContext.save()
        }
        catch{
            print("Сохранение не удалось")
        }
    }
    
    func delete(id: Int){
        
        if let elementId = findElementInStorage(id: id){
            CartPersistenceController.shared.viewContext.delete(elementId)
            save()
        }
        else{
            print("Элемент не найден")
        }
    }
    
    func findElementInStorage(id: Int) -> CartItem?{
        
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "id_item = '\(Int32(id))'")
        
        var items: [CartItem] = []
        
        do{
            try items = CartPersistenceController.shared.viewContext.fetch(request)
            return items[0]
        }
        catch{
            print("(")
            return nil
        }
        
    }
    
    func deleteAll(){
        
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        
        do{
            let items = try CartPersistenceController.shared.viewContext.fetch(request)
            for item in items{
                CartPersistenceController.shared.viewContext.delete(item)
            }
            
            save()
        }
        catch{
            print("(")
        }
    }
}
