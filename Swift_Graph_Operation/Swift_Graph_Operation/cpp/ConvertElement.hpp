//
//  ConvertElement.hpp
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/11.
//

#ifndef ConvertElement_hpp
#define ConvertElement_hpp

#include <stdio.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

class ConvertElement {
    
public:
    float x;
    float y;
    float width;
    float height;
    
    glm::mat4 transform;
    
    ConvertElement();
};

#endif /* ConvertElement_hpp */
