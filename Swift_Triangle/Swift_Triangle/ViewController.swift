//
//  ViewController.swift
//  Swift_Triangle
//
//  Created by fdd on 2024/1/3.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    let context = EAGLContext(api: .openGLES3)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let glkView = self.view as! GLKView
        glkView.context = context
        glkView.drawableDepthFormat = .format24
        EAGLContext.setCurrent(glkView.context)

        setupOpenGL()
    }

    func setupOpenGL() {
        // Set up your OpenGL configurations here
        // 初始化OpenGL配置
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glViewport(0, 0, GLsizei(view.drawableWidth), GLsizei(view.drawableHeight))
        glClearColor(0.0, 0.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        glUseProgram(shader.program)
            let vertices: [GLfloat] = [
                0.0,  0.5, 0.0,
               -0.5, -0.5, 0.0,
                0.5, -0.5, 0.0
            ]

            glEnableVertexAttribArray(0)
            glVertexAttribPointer(0, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, vertices)
            glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
            glDisableVertexAttribArray(0)
    }
}

let vShaderStr = """
    #version 300 es
    layout(location = 0) in vec4 vPosition;
    void main()
    {
       gl_Position = vPosition;
    }
    """

let fShaderStr = """
    #version 300 es
    precision mediump float;
    out vec4 fragColor;
    void main()
    {
       fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    }
    """

class ShaderProgram {
    var program: GLuint = 0

    init(vertexShader: String, fragmentShader: String) {
        program = compileShaders(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }

    private func compileShaders(vertexShader: String, fragmentShader: String) -> GLuint {
        let vertexShaderID = compileShader(shaderType: GLenum(GL_VERTEX_SHADER), shaderSource: vertexShader)
        let fragmentShaderID = compileShader(shaderType: GLenum(GL_FRAGMENT_SHADER), shaderSource: fragmentShader)

        let programID = glCreateProgram()
        glAttachShader(programID, vertexShaderID)
        glAttachShader(programID, fragmentShaderID)

        glLinkProgram(programID)

        var linkStatus: GLint = 0
        glGetProgramiv(programID, GLenum(GL_LINK_STATUS), &linkStatus)

        if linkStatus == GL_FALSE {
            var infoLog = [GLchar](repeating: 0, count: 1024)
            glGetProgramInfoLog(programID, GLsizei(infoLog.count), nil, &infoLog)
            let log = String(cString: infoLog)
            NSLog("Error linking program: \(log)")
            glDeleteProgram(programID)
            return 0
        }

        glDeleteShader(vertexShaderID)
        glDeleteShader(fragmentShaderID)

        return programID
    }
    
    private func compileShader(shaderType: GLenum, shaderSource: String) -> GLuint {
        let shaderID = glCreateShader(shaderType)
        var source = (shaderSource as NSString).utf8String
        glShaderSource(shaderID, 1, &source, nil)
        glCompileShader(shaderID)

        var compileStatus: GLint = 0
        glGetShaderiv(shaderID, GLenum(GL_COMPILE_STATUS), &compileStatus)

        if compileStatus == GL_FALSE {
            var infoLog = [GLchar](repeating: 0, count: 1024)
            glGetShaderInfoLog(shaderID, GLsizei(infoLog.count), nil, &infoLog)
            let log = String(cString: infoLog)
            NSLog("Error compiling shader: \(log)")
            glDeleteShader(shaderID)
            return 0
        }

        return shaderID
    }
}

// Usage example:
let shader = ShaderProgram(vertexShader: vShaderStr, fragmentShader: fShaderStr)
