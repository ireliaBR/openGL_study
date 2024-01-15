//
//  Paint.cpp
//  Swift_Paint
//
//  Created by fdd on 2024/1/15.
//

#include "Paint.hpp"
#include <iostream>
#include <OpenGLES/ES3/gl.h>

#include "stb_image.h"

Paint::Paint(const char *workPath) {
    this->workPath = std::string(workPath);
}

Paint::~Paint() {
    destroy();
}

void Paint::setup(const char *vsSource, const char *fsSource, float pointSize) {
    brushTextureBufferIndex = 5;
    this->pointSize = pointSize;
    createProgram(vsSource, fsSource);
}
void Paint::loadTexture() {
    brushTextureId0 = loadTexture(workPath + std::string("RoundBrush.png"));
    brushTextureId1 = loadTexture(workPath + std::string("GlowBrush.png"));
    currentBrushTextureId = brushTextureId0;
}
void Paint::clean() {
    // clearFBO
    glBindFramebuffer(GL_FRAMEBUFFER, FBO);
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, screenWidth, screenHeight);
}

unsigned int Paint::draw(float *vertices, int num) {
    glBindFramebuffer(GL_FRAMEBUFFER, FBO);
    
    glUseProgram(program);
    
    glUniform1f(pointSizeUniformLoc, pointSize);
    glUniform3f(colorUniformLoc, 1, 1, 1);
    
    glActiveTexture(GL_TEXTURE0 + brushTextureBufferIndex);
    glBindTexture(GL_TEXTURE_2D, currentBrushTextureId);
    glUniform1i(brushTextureUniformLoc, brushTextureBufferIndex);
    
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, num * 2 * sizeof(float), vertices, GL_DYNAMIC_DRAW);
    
    glEnableVertexAttribArray(positionLoc);
    glVertexAttribPointer(positionLoc, 2, GL_FLOAT, GL_FALSE, 0, 0);
    
    glDrawArrays(GL_POINTS, 0, (int)num);
    return RBO;
}

void Paint::createProgram(const char *vsSource, const char *fsSource) {
    
    // build and compile our shader program
    // ------------------------------------
    // vertex shader
    unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vsSource, NULL);
    glCompileShader(vertexShader);
    // check for shader compile errors
    int success;
    char infoLog[512];
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
        std::cout << "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n" << infoLog << std::endl;
    }
    // fragment shader
    unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fsSource, NULL);
    glCompileShader(fragmentShader);
    // check for shader compile errors
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
        std::cout << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n" << infoLog << std::endl;
    }
    // link shaders
    program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    // check for linking errors
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(program, 512, NULL, infoLog);
        std::cout << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n" << infoLog << std::endl;
    }
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    // attribute or uniform location
    positionLoc = glGetAttribLocation(program, "position");
    
    pointSizeUniformLoc = glGetUniformLocation(program, "pointSize");
    colorUniformLoc = glGetUniformLocation(program, "color");
    brushTextureUniformLoc = glGetUniformLocation(program, "brushTexture");
}

void Paint::createBuffers1() {
    glGenBuffers(1, &VBO);
    // 创建 RBO Render Buffer Object
    glGenRenderbuffers(1, &RBO);
    glBindRenderbuffer(GL_RENDERBUFFER, RBO);
    
}

void Paint::createBuffers2() {
    
    // Then, FBOs..
    
    // 创建 FBO Frame Buffer Object
    glGenFramebuffers(1, &FBO);
    
    // 配置 FBO - Render FrameBuffer：
    glBindFramebuffer(GL_FRAMEBUFFER, FBO); // 使用 FBO，下面的激活 & 绑定操作都会对应到这个 FrameBuffer
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, RBO); // 附着 渲染的颜色 RBO
    
    GLint w, h;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &w);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &h);
    screenWidth = w;
    screenHeight = h;
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
}

void Paint::destroy() {
    glDeleteBuffers(1, &VBO);
    glDeleteProgram(program);
}

unsigned int Paint::loadTexture(std::string path) {
    unsigned int textureID;
    glGenTextures(1, &textureID);

    int width, height, nrComponents;
    unsigned char *data = stbi_load(path.c_str(), &width, &height, &nrComponents, 0);
    if (data) {
        GLenum format;
        if (nrComponents == 1) {
            format = GL_RED;
        } else if (nrComponents == 3) {
            format = GL_RGB;
        } else if (nrComponents == 4) {
            format = GL_RGBA;
        }

        glBindTexture(GL_TEXTURE_2D, textureID);
        glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        stbi_image_free(data);
    } else {
        std::cout << "Texture failed to load at path: " << path << std::endl;
        stbi_image_free(data);
    }

    return textureID;
}
