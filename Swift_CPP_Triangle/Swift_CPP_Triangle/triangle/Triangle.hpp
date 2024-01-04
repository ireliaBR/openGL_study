//
//  Triangle.hpp
//  Swift_CPP_Triangle
//
//  Created by fdd on 2024/1/4.
//

#ifndef Triangle_hpp
#define Triangle_hpp

#include <stdio.h>

class Triangle {
private:
    float *vertices;
    int size;
    unsigned int VBO;
    unsigned int VAO;
    unsigned int shaderProgram;
    
    void createShaderProgram();
    void createVAO();
    
public:
    Triangle(float *vertices, int size);
    ~Triangle();
    void setup();
    void draw(float width, float height);
};

#endif /* Triangle_hpp */
