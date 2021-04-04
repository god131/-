pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract PersonDID {
    struct Person {
        uint8 id;
        uint8 age;
        string name;
        // string info;
    }
    
    event AddPerson(uint8 id, uint8 age, string name, uint timestamp);
    
    Person admin;
    Person[] persons;
    mapping(address => Person) public PersonInfo;
    mapping(address=> bool) public isPersonExsist;
    
    constructor (address ip, uint8 id, string memory name, uint8 age) public {
        admin = Person(id, age, name);
        Person memory p = Person(id, age, name);
        persons.push(p);
        PersonInfo[msg.sender] = p;
        isPersonExsist[msg.sender] = true;
    }
    
    function getNumberOfPersons() view public returns (uint256) {
        return persons.length;
    }
    
    function addPerson(uint8 id, uint8 age, string memory name) public returns (bool) {
        require(!((id == 0) || age == 0), "persons info can not be empty!!");
        require(!isPersonExsist[msg.sender], "person can not exsist !!");
        Person memory person = Person(id, age, name);
        persons.push(person);
        PersonInfo[msg.sender] = Person(id, age, name);
        isPersonExsist[msg.sender] = true;
        emit AddPerson(id, age, name, now);
    }
        function getPersonId(string memory identity) view public {

        if(identity==admin){
            return persons;
        }else{
            return persons[id];
        } 
    }
    //思路：新建一个string类型的identity，分为admin和others两类，如果identity==admin就展示整个persons数组，如果identity！=admin就展示当前id和name的数组
    
    function setPersonAgeSto(address ip, uint8 age) public {
        Person storage p = PersonInfo[ip];
        p.age = age;
    }
    
    function setPersonAgeMem(address ip, uint8 age) public {
        Person memory p = PersonInfo[ip];
        p.age = age;
    }
    
    function getPersonAge(address ip) public view returns (uint8) {
        return PersonInfo[ip].age;
    }
    
}