//
//  Matrix.cpp
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/11.
//

#include "Matrix.hpp"

Matrix::Matrix() {
    
}

glm::mat4 Matrix::convert(float screenWidth, float screenHeight) {
    return glm::mat4(this->m11,  this->m12,  this->m13,  this->m14,
                     this->m21,  this->m22,  this->m23,  this->m24,
                     this->m31, this->m32,  this->m33,  this->m34,
                     this->m41 * 2 / screenWidth,  this->m42 * 2 / screenHeight,  this->m43,  this->m44);
}
