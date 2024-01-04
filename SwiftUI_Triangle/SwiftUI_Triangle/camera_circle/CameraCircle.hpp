//
//  CameraCircle.hpp
//  SwiftUI_Triangle
//
//  Created by fdd on 2024/1/4.
//

#ifndef CameraCircle_hpp
#define CameraCircle_hpp

#include <stdio.h>
#include <string>

class CameraCircle {
private:
    unsigned int program;
    std::string workPath;
    unsigned int VAO;
    unsigned int VBO;
    unsigned int texture1;
    unsigned int texture2;
    
    void createVAO();
    void createProgram();
    void createTexture();
    void checkCompileErrors(uint32_t shader, std::string type);
public:
    CameraCircle(const char *workPath);
    ~CameraCircle();
    void setup();
    void draw(float width, float height, double time);
};

#endif /* CameraCircle_hpp */
