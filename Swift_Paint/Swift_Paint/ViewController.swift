//
//  ViewController.swift
//  Swift_Paint
//
//  Created by fdd on 2024/1/15.
//

import UIKit
import GLKit
import OpenGLES

class ViewController: UIViewController, PaintBoardTouchManagerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let event else { return }
        touchManager.onTouchBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let event else { return }
        touchManager.onTouchMovedOrEnded(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let event else { return }
        touchManager.onTouchMovedOrEnded(touches, with: event)
    }
    
    func onPointsOut(_ points: [NSValue]?) {
        guard let points else { return }
        var floatArray: [Float] = []
        for i in 0..<points.count {
            let point = points[i].cgPointValue
            floatArray.append(Float(point.x))
            floatArray.append(Float(point.y))
        }
        
        // 创建一个大小与 floatArray 相等的 UnsafeMutablePointer<Float> 对象
        let pointer = UnsafeMutablePointer<Float>.allocate(capacity: floatArray.count)

        // 使用 withUnsafeMutablePointer(to:) 方法将 floatArray 转换为 pointer
        floatArray.withUnsafeMutableBufferPointer { bufferPointer in
            pointer.initialize(from: bufferPointer.baseAddress!, count: bufferPointer.count)
        }
        let rbo = paint.draw(pointer, Int32(floatArray.count))
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), rbo);
        ctx.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }
    
    func currentPointSize() -> CGFloat {
        return pointSize
    }
    
    func screenScale() -> CGFloat {
        return UIScreen.main.scale
    }
    
    
    var ctx: EAGLContext!
    var glLayer: CAEAGLLayer!
    var paint = Paint(((Bundle.main.bundlePath + "/") as NSString).utf8String)
    
    var pointSize: CGFloat = 80
    var brushColor = UIColor.white
    
    var brushTextureBufferIndex: GLuint = 5
    
    var touchManager: PaintBoardTouchManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
        setupLayer()
        
        let vsPath = Bundle.main.path(forResource: "PaintBoard", ofType: "vsh")!
        let fsPath = Bundle.main.path(forResource: "PaintBoard", ofType: "fsh")!
        let vsSource = try! String(contentsOfFile: vsPath, encoding: .utf8).utf8CString
        let fsSource = try! String(contentsOfFile: fsPath, encoding: .utf8).utf8CString
        let vsPointer = vsSource.withUnsafeBufferPointer { UnsafePointer<CChar>($0.baseAddress) }
        let fsPointer = fsSource.withUnsafeBufferPointer { UnsafePointer<CChar>($0.baseAddress) }
        paint.setup(vsPointer, fsPointer, Float(pointSize))
        paint.createBuffers1()
        ctx.renderbufferStorage(Int(GLint(GL_RENDERBUFFER)), from: glLayer)
        paint.createBuffers2()
        paint.loadTexture()
        paint.clean()
        
        var floatArray: [Float] = []
        // 创建一个大小与 floatArray 相等的 UnsafeMutablePointer<Float> 对象
        let pointer = UnsafeMutablePointer<Float>.allocate(capacity: floatArray.count)

        // 使用 withUnsafeMutablePointer(to:) 方法将 floatArray 转换为 pointer
        floatArray.withUnsafeMutableBufferPointer { bufferPointer in
            pointer.initialize(from: bufferPointer.baseAddress!, count: bufferPointer.count)
        }
        let rbo = paint.draw(pointer, Int32(floatArray.count))
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), rbo);
        ctx.presentRenderbuffer(Int(GL_RENDERBUFFER))
        
        touchManager = PaintBoardTouchManager(view: view)
        touchManager.delegate = self
    }
    
    func setupContext() {
        ctx = EAGLContext(api: .openGLES3)
        EAGLContext.setCurrent(ctx)
    }
    
    func setupLayer() {
        glLayer = CAEAGLLayer()
        glLayer.isOpaque = true
        glLayer.drawableProperties = [
            kEAGLDrawablePropertyRetainedBacking: true,
            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
        ]
        glLayer.frame = view.bounds
        glLayer.contentsScale = UIScreen.main.scale
        view.layer.insertSublayer(glLayer, at: 0)
    }
}

