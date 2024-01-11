//
//  Matrix.hpp
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/11.
//

#ifndef Matrix_hpp
#define Matrix_hpp

#include <stdio.h>
#include <glm/gtc/matrix_transform.hpp>

class Matrix {
public:
    float m11, m12, m13, m14;
    float m21, m22, m23, m24;
    float m31, m32, m33, m34;
    float m41, m42, m43, m44;
    Matrix();
    glm::mat4 convert(float screenWidth, float screenHeight);
};

#endif /* Matrix_hpp */
