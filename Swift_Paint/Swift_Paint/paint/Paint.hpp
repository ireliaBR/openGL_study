//
//  Paint.hpp
//  Swift_Paint
//
//  Created by fdd on 2024/1/15.
//

#ifndef Paint_hpp
#define Paint_hpp

#include <stdio.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <iostream>

class Paint {
public:
    unsigned int program;
    unsigned int FBO;
    unsigned int RBO;
    unsigned int VBO;
    
    unsigned int positionLoc;
    unsigned int pointSizeUniformLoc;
    unsigned int colorUniformLoc;
    unsigned int brushTextureUniformLoc;
    
    
    // Texture Buffer Index
    unsigned int brushTextureBufferIndex;
    // Texture Id
    unsigned int brushTextureId0;
    unsigned int brushTextureId1;
    unsigned int currentBrushTextureId;
    
    std::string workPath;
    
    float screenWidth;
    float screenHeight;
    
    float pointSize;
    
    void createProgram(const char *vsSource, const char *fsSource);
    void loadTexture();
    void clean();
    void createBuffers1();
    void createBuffers2();
    void destroy();
    unsigned int loadTexture(std::string path);
    Paint(const char *workPath);
    ~Paint();
    void setup(const char *vsSource, const char *fsSource, float pointSize);
    unsigned int draw(float *vertices, int num);
};

#endif /* Paint_hpp */
