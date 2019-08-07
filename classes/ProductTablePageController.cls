public class ProductTablePageController{ 
    public String keyword;
    public List<Product__c> results;
    public boolean displayPopup {get;set;} 
    Product__c prod = new Product__c();
    public String soqlsort {get;set;}
    public String soql {get;set;}
    public List <Product__c> products1 = new List <Product__c>();
    public List <Product__c> products2 = new List <Product__c>();
 
    public Integer methodB(){
        return 10;
    public Integer methodA(){
        return 20;
    }

    public List<Product__c> getProducts() {
        return con.getRecords();
	}
    public void setProd(Product__c pr){
        prod = pr;
    }
      public Product__c getprod(){
          return prod;
      }   
    public String getKeyword(){
        return keyword;
    }
    public List<Product__c> getResults(){
        return results;
    }
    public void setkeyword(String input){
        keyword = input;
    } 
    public PageReference search_now(){
        String RE_date = '(0?[1-9]|1[012])/(0?[1-9]|[12][0-9]|3[01])/((19|20)\\d\\d)'; 
        Pattern MyPattern = Pattern.compile (RE_date);
        Matcher MyMatcher = MyPattern.matcher (keyword); 
		if (! MyMatcher.matches ()) { 
			results = [FIND :keyword IN ALL FIELDS RETURNING PRODUCT__C(Name,Price__c,Amount__c,Type__c,Available__c,ReleaseDate__c,AddedDate__c)][0];
 		}
        else{        
           Date  dateRes = Date.parse(keyword);
           results = [SELECT Name,Price__c,Amount__c,Type__c,Available__c,ReleaseDate__c,AddedDate__c FROM Product__c WHERE AddedDate__c=:dateRes];
       }   
      return null;
    }
    public void closePopup(){
        displayPopup = false;
    } 
    public void showPopup() {
         displayPopup = true; 
    } 
    public PageReference save(){
        try{ 
               insert prod;
               PageReference parentPage = new PageReference('/apex/ProductTablePage');
               parentPage.setRedirect(true);
               displayPopup = false;
               return parentPage;
           }catch(DmlException ex){
      			ApexPages.addMessages(ex);
    	}
           return null;
    }
    public ApexPages.StandardSetController con {
		get {
			if(con == null) {
                soql='SELECT Name,Price__c,Amount__c,Type__c,Available__c,ReleaseDate__c,AddedDate__c FROM Product__c';
                products1 = Database.query(soql + ' order by ' + sortField + ' ' + sortDir ); 
				con = new ApexPages.StandardSetController(products1);
				con.setPageSize(5);
			}
			return con;
		}
		set;
	}
    public Boolean hasNext {
		get {
			return con.getHasNext();
		}
		set;
	}
    public Boolean hasPrevious {
		get {
			return con.getHasPrevious();
		}
		set;
	}
    public Integer pageNumber {
		get {
			return con.getPageNumber();
		}
		set;
	}
    public void previous() {
 		con.previous();
 	}
    public void next() {
 		con.next();
 	}
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;}
        set;
    }
     public String sortField {
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;  }
        set;
    } 
    public void toggleSort() {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        soqlsort = 'SELECT Name,Price__c,Amount__c,Type__c,Available__c,ReleaseDate__c,AddedDate__c FROM Product__c';
        products2 = Database.query(soqlsort + ' order by ' + sortField + ' ' + sortDir ); 
        con = new ApexPages.StandardSetController(products2);
        con.setPageSize(5);
 }
}
