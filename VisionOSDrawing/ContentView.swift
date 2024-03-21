//
//  ContentView.swift
//  VisionOSDrawing
//
//  Created by Santiago Quihui on 20/03/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import PencilKit

struct ContentView: View {
    @Environment(\.undoManager) private var undoManager
    
    @State private var canvas = PKCanvasView()
    @State private var isDrawing = true
    @State private var color: Color = .black
    @State private var pencilType: PKInkingTool.InkType = .pencil
    @State private var colorPicker = false
    
    
    
    var body: some View {
        NavigationStack {
            DrawingView(canvas: $canvas, isDrawing: $isDrawing, pencilType: $pencilType, color: $color)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomOrnament) {
                        HStack {
                            Button {
                                isDrawing = true
                                pencilType = .pencil
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "pencil.and.scribble")
                                    Text("Pencil")
                                        .foregroundStyle(.white)
                                }
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                isDrawing = true
                                pencilType = .pen
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "applepencil.tip")
                                    Text("Pen")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                isDrawing = true
                                pencilType = .monoline
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "pencil.line")
                                    Text("Monoline")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                isDrawing = true
                                pencilType = .fountainPen
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "scribble.variable")
                                    Text("Fountain")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                isDrawing = true
                                pencilType = .marker
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "paintbrush.pointed")
                                    Text("Marker")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                isDrawing = true
                                pencilType = .crayon
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "paintbrush")
                                    Text("Crayon")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                isDrawing = true
                                pencilType = .watercolor
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "eyedropper.halffull")
                                    Text("Watercolor")
                                        .foregroundStyle(.white)
                                }
                            }
                            
                            Button {
                                colorPicker.toggle()
                            } label: {
                                VStack(spacing: 8) {
                                    Image(systemName: "paintpalette")
                                    Text("Colorpicker")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .bottom)
                        )
                    }
                }
                .ornament(attachmentAnchor: .scene(.leading)) {
                    VStack(spacing: 32) {
                        Button {
                            canvas.drawing = PKDrawing()
                        } label: {
                            Image(systemName: "scissors")
                        }
                        
                        Button {
                            undoManager?.undo()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        
                        Button {
                            undoManager?.redo()
                        } label: {
                            Image(systemName: "arrow.uturn.forward")
                        }
                        
                        Button {
                            isDrawing = false
                        } label: {
                            Image(systemName: "eraser.line.dashed")
                        }
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.white, .red]), startPoint: .leading, endPoint: .top)
                        )
                        
                    }
                    .padding(12)
                    .buttonStyle(.plain)
                    .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 32))
                }
                .ornament(attachmentAnchor: .scene(.trailing)) {
                    Menu {
                        Button {
                            colorPicker.toggle()
                        } label: {
                            Label("Color", systemImage: "paintpalette")
                        }
                        
                        Button {
                            isDrawing = true
                            pencilType = .pencil
                        } label: {
                            Label("Pencil", systemImage: "pencil")
                        }
                        
                        Button {
                            // Menu: pen
                            isDrawing = true
                            pencilType = .pen
                        } label: {
                            Label("Pen", systemImage: "pencil.tip")
                        }
                        
                        Button {
                            // Menu: Marker
                            isDrawing = true
                            pencilType = .marker
                        } label: {
                            Label("Marker", systemImage: "paintbrush.pointed")
                        }
                        
                        Button {
                            // Menu: Monoline
                            isDrawing = true
                            pencilType = .monoline
                        } label: {
                            Label("Monoline", systemImage: "pencil.line")
                        }
                        
                        Button {
                            // Menu: pen
                            isDrawing = true
                            pencilType = .fountainPen
                        } label: {
                            Label("Fountain", systemImage: "paintbrush.pointed.fill")
                        }
                        
                        Button {
                            // Menu: Watercolor
                            isDrawing = true
                            pencilType = .watercolor
                        } label: {
                            Label("Watercolor", systemImage: "eyedropper.halffull")
                        }
                        
                        Button {
                            // Menu: Crayon
                            isDrawing = true
                            pencilType = .crayon
                        } label: {
                            Label("Crayon", systemImage: "pencil.tip")
                        }
                    } label: {
                        Image(systemName: "hand.draw")
                    }
                    .sheet(isPresented: $colorPicker, content: {
                        HStack {
                            ColorPicker("Pick color", selection: $color)
                                .padding()
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    colorPicker.toggle()
                                }
                                .padding()
                        }
                    })
                    .padding(12)
                    .buttonStyle(.plain)
                    .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 32))
                }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
