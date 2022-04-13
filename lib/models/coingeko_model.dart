class CoingekoModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  num? marketCap;
  num? marketCapRank;
  num? totalVolume;
  num? high24h;
  num? low24h;
  num? priceChange24h;
  num? priceChangePercentage24h;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? circulatingSupply;
  num? ath;
  num? atl;
  String? lastUpdated;
  bool isFavorite= false;

  CoingekoModel(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.totalVolume,
      required this.high24h,
      required this.low24h,
      required this.priceChange24h,
      required this.priceChangePercentage24h,
      required this.marketCapChange24h,
      required this.marketCapChangePercentage24h,
      required this.circulatingSupply,
      required this.ath,
      required this.atl,
      required this.lastUpdated});

  factory CoingekoModel.fromJson(Map<String, dynamic> map) {
    return CoingekoModel(
        id: map['id'],
        symbol: map['symbol'],
        name: map['name'],
        image: map['image'],
        currentPrice: map['current_price'],
        marketCap: map['market_cap'],
        marketCapRank: map['market_cap_rank'],
        totalVolume: map['total_volume'],
        high24h: map['high_24h'],
        low24h: map['low_24h'],
        priceChange24h: map['price_change_24h'],
        priceChangePercentage24h: map['price_change_percentage_24h'],
        marketCapChange24h: map['market_cap_change_24h'],
        marketCapChangePercentage24h: map['market_cap_change_percentage_24h'],
        circulatingSupply: map['circulating_supply'],
        ath: map['ath'],
        atl: map['atl'],
        lastUpdated: map['last_updated']);
  }
}
