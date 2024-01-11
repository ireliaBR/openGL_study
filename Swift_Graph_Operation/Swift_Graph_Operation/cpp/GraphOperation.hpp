//
//  GraphOperation.hpp
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/10.
//

#ifndef GraphOperation_hpp
#define GraphOperation_hpp

#include <stdio.h>
#include "Matrix.hpp"
#include "ConvertElement.hpp"

class GraphOperation {
private:
    unsigned int program;
    unsigned int VAO;
    unsigned int VBO;
    unsigned int EBO;
    
    float screenWidth;
    float screenHeight;
    
    void createProgram();
    void createVAO();
    void destroy();
public:
    GraphOperation();
    ~GraphOperation();
    void setup();
    void draw(float screenWidth, float screenHeight, ConvertElement element);
};

#endif /* GraphOperation_hpp */
