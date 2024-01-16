//
//  Text.hpp
//  Swift_Text
//
//  Created by fdd on 2024/1/16.
//

#ifndef Text_hpp
#define Text_hpp

#include <stdio.h>
#include <string>
#include <map>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <OpenGLES/ES3/gl.h>

#include <ft2build.h>
#include FT_FREETYPE_H

struct Character {
    unsigned int TextureID; // ID handle of the glyph texture
    glm::ivec2   Size;      // Size of glyph
    glm::ivec2   Bearing;   // Offset from baseline to left/top of glyph
    unsigned int Advance;   // Horizontal offset to advance to next glyph
};

class Text {
private:
    unsigned int program;
    std::string workPath;
    unsigned int VAO;
    unsigned int VBO;
    std::map<GLchar, Character> Characters;
    
    void renderText(std::string text, float x, float y, float scale, glm::vec3 color);
    void createBuffers();
    void createProgram();
    void createCharacters();
    void checkCompileErrors(uint32_t shader, std::string type);
public:
    void setup(const char *workPath);
    void draw(float screenWidth, float screenHeight);
    
};

#endif /* Text_hpp */
