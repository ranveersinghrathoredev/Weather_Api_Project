public with sharing class WeatherDetailsClass {
    @AuraEnabled
    public static WeatherDetailsWrapper getWeatherDetails(String cityName){
        // Frame the Endpoint URL
     String apiKey = 'fddf9293fc4d887078735a1813b8da8b' ;
     String endPoint = 'https://api.openweathermap.org/data/2.5/weather' ;
     endPoint += '?q='+cityName;
     endPoint += '&units=metric';
     endPoint += '&APPID='+apiKey;
      // Callout to Weather API
     Http http = new http();
     HttpRequest req = new HttpRequest();
     req.setEndpoint(endPoint);
     req.setMethod('GET');
     HttpResponse res = http.send(req);
     System.debug('res' +res+' body ' +JSON.deserializeUntyped(res.getBody()));
     // return the weather details in wrapper form 
     WeatherDetailsWrapper weatherDet = new WeatherDetailsWrapper();
      if(res.getStatusCode() ==200) {
        Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        weatherDet.city = String.valueOf (result.get('name'));
        Map<String,Object> mainResult = (Map<String,Object>)(result.get('main')); 
        weatherDet.temperature = String.valueOf (mainResult.get('temp'));
        weatherDet.pressure = String.valueOf (mainResult.get('pressure'));
        weatherDet.humidity = String.valueOf (mainResult.get('humidity'));
      }
      return weatherDet;
    }
    // wrapper class to store weatherdetails in serial manner 
      public class WeatherDetailsWrapper{
           @AuraEnabled public String city { get; set;}
           @AuraEnabled public String temperature { get; set;}
           @AuraEnabled public String pressure { get; set;}
           @AuraEnabled public String humidity { get; set;}
      }
}

