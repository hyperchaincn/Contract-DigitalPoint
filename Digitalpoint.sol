contract Digitalpoint {
    enum Actor{ Aviation, Bank, Market, Petroleum, Client }
    
    struct Aviation{
        bytes32 ID;
        bytes32 Name;
        uint pointbalance;
    }
    
    struct Bank{
        bytes32 ID;
        bytes32 Name;
        uint pointbalance;
    }
    
    struct Market{
        bytes32 ID;
        bytes32 Name;
        uint pointbalance;
    }
    
    struct Petroleum{
        bytes32 ID;
        bytes32 Name;
        uint pointbalance;
    }
    
    struct Client{
        bytes32 ID;
        bytes32 Name;
        uint[] pointbalances;
        uint unionpaybalance;
    }
    
    struct Commodity{
        bytes32 ID;
        bytes32 Name;
        uint value;
    }
    
    mapping(bytes32 => Aviation) aviationMap;
    mapping(bytes32 => Bank) bankMap;
    mapping(bytes32 => Market) marketMap;
    mapping(bytes32 => Petroleum) petroleumMap;
    mapping(bytes32 => Client) clientMap;
    mapping(bytes32 => Commodity) commodityMap;
    
    function newAviation(bytes32 ID, bytes32 Name, uint pointbalance) returns (bool, bytes32){
        Aviation aviation = aviationMap[ID];
        if(aviation.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        aviation.ID = ID;
        aviation.Name = Name;
        aviation.pointbalance = pointbalance;
        return (true,"success");
    }
    
    function newBank(bytes32 ID, bytes32 Name, uint pointbalance) returns (bool, bytes32){
        Bank bank = bankMap[ID];
        if(bank.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        bank.ID = ID;
        bank.Name = Name;
        bank.pointbalance = pointbalance;
        return (true,"success");
    }
    
    function newMarket(bytes32 ID, bytes32 Name, uint pointbalance) returns (bool, bytes32){
        Market market = marketMap[ID];
        if(market.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        market.ID = ID;
        market.Name = Name;
        market.pointbalance = pointbalance;
        return (true,"success");
    }
    
    function newPetroleum(bytes32 ID, bytes32 Name, uint pointbalance) returns (bool, bytes32){
        Petroleum petroleum = petroleumMap[ID];
        if(petroleum.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        petroleum.ID = ID;
        petroleum.Name = Name;
        petroleum.pointbalance = pointbalance;
        return (true,"success");
    }
    
    function newCommodity(bytes32 ID, bytes32 Name, uint value) returns (bool, bytes32){
        Commodity commodity = commodityMap[ID];
        if(commodity.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        commodity.ID = ID;
        commodity.Name = Name;
        commodity.value = value;
        return (true,"success");
    }
    
    function newClient(bytes32 ID, bytes32 Name, uint[] pointbalances, uint unionpaybalance) returns (bool, bytes32){
        Client client = clientMap[ID];
        if(client.ID != 0x0){
            return (false,"this ID has been occupied!");
        }
        client.ID = ID;
        client.Name = Name;
        client.pointbalances = pointbalances;
        client.unionpaybalance = unionpaybalance;
        return (true,"success");
    }
    
    function Queryclientbalance(bytes32 ID) returns(bool,bytes32,bytes32,uint[],uint){
        Client client = clientMap[ID];
        return (true,"Success",client.Name,client.pointbalances,client.unionpaybalance);
    }
    
    function exchangeMoneyToPoints(bytes32 ID,uint amount,uint n) returns(bool,bytes32){
        Client client = clientMap[ID];
        client.unionpaybalance -= amount;
        client.pointbalances[n-1] += amount;
        return (true,"success");
    }
    
    function exchangepoints(bytes32 ID1, uint amount1, uint n, bytes32 ID2, uint amount2, uint m) returns(bool, bytes32){
        Client client1 = clientMap[ID1];
        Client client2 = clientMap[ID2];
        client1.pointbalances[n-1] -= amount1;
        client2.pointbalances[n-1] += amount1;
        client1.pointbalances[m-1] += amount2;
        client2.pointbalances[m-1] -= amount2;
        return (true,"success");
    }

    function pointstransaction(bytes32 ID1, uint n, bytes32 ID2) returns(bool, bytes32){
        Client client1 = clientMap[ID1];
        Commodity commodity = commodityMap[ID2];
        client1.pointbalances[n-1] -= commodity.value;
        return (true,"Purchase succeeded");
    }
}