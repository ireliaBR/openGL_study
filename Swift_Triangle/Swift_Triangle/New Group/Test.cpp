//
//  Test.cpp
//  Swift_Triangle
//
//  Created by fdd on 2024/1/3.
//

/// hpp
#include <stdio.h>
#include <string>

struct Person {
    std::string name;
    int age;
};
std::vector<Person> allPerson();

/// cpp

Person createPerson(std::string name, int age) {
    Person person;
    person.name = name;
    person.age = age;
    return person;
}

std::vector<Person> allPerson() {
    std::vector<Person> people;
    Person person1 = createPerson("zhangsan", 20);
    Person person2 = createPerson("lisi", 21);
    Person person3 = createPerson("wangwu", 22);
    people.push_back(person1);
    people.push_back(person2);
    people.push_back(person3);
    return people;
}
