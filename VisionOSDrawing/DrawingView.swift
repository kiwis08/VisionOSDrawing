//
//  DrawingView.swift
//  VisionOSDrawing
//
//  Created by Santiago Quihui on 20/03/24.
//

import Foundation
import SwiftUI
import PencilKit
struct DrawingView: UIViewRepresentable {
  @Binding var canvas: PKCanvasView
  @Binding var isDrawing: Bool
  @Binding var pencilType: PKInkingTool.InkType
  @Binding var color: Color

  var ink: PKInkingTool {
    PKInkingTool(pencilType, color: UIColor(color))
  }

  let eraser = PKEraserTool(.bitmap)

  func makeUIView(context: Context) -> PKCanvasView {
    canvas.drawingPolicy = .anyInput
    canvas.tool = isDrawing ? ink : eraser
    canvas.isRulerActive = true
    canvas.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
    canvas.alwaysBounceVertical = true

    let toolPicker = PKToolPicker.init()
    toolPicker.setVisible(true, forFirstResponder: canvas)
    toolPicker.addObserver(canvas)
    canvas.becomeFirstResponder()

    return canvas
  }

  func updateUIView(_ uiView: PKCanvasView, context: Context) {
    uiView.tool = isDrawing ? ink : eraser
  }
}
