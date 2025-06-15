//
//  ContentView.swift
//  Beta26Demo
//
//  Created by Itsuki on 2025/06/12.
//

import SwiftUI

struct ContentView: View {
    
    @State private var offsetX: CGFloat = 0.0
    @State private var containerSpacing: CGFloat = 30.0
    @State private var show: Bool = true
    @Namespace private var namespace
    @Namespace private var namespace2
    
    var body: some View {
        let toggle: () -> Void = {
            withAnimation(.linear(duration: 0.5), {
                show.toggle()
            })
        }
        
        ScrollView {
            VStack(spacing: 24) {

                Text("Basic Usage")
                    .font(.headline)
                
                let text = Text("˚ʚ♡ɞ˚")
                    .padding(.all, 8)

                
                HStack(spacing: 16) {
                    VStack {
                        Text("Default")
                            .font(.subheadline)
                        text.glassEffect()
                    }
                    
                    VStack {
                        Text("Shape")
                            .font(.subheadline)
                        text.glassEffect(.regular, in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack {
                        Text("Tint")
                            .font(.subheadline)
                        text.glassEffect(.regular.tint(.green.opacity(0.4)))
                    }
                    
                    VStack {
                        Text("Interactive")
                            .font(.subheadline)
                        text.glassEffect(.regular.interactive())

                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Text("ButtonStyle")
                        .font(.subheadline)
                    Button(action: {}, label: {
                        text
                    })
                    .buttonStyle(.glass)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 24) {
                    Text("**NOTE**: \nWith `interactive`, when user interacting with the view, the shape used is the default capsule regardless of the parameters set. \nTherefore, if we have customized those parameters, there will be a discrepancy.")
                        .font(.caption)
                    
                    text.glassEffect(.regular.interactive().tint(.green.opacity(0.4)), in: RoundedRectangle(cornerRadius: 8))

                }
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 2)
                
               
                
                Text("Glass Effect Container")
                    .font(.headline)

                Text("Basic")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack {
                    Text("**Offset X**")
                        .font(.subheadline)
                    Slider(value: $offsetX, in: -60.0 ... 0.0, step: 5.0, label: {}, minimumValueLabel: {
                        Text("-60.0")
                    }, maximumValueLabel: {
                        Text("0.0")
                    })
                }

                HStack {
                    Text("**Glass Container \nSpacing**")
                        .font(.subheadline)
                    Slider(value: $containerSpacing, in: 0.0 ... 60.0, step: 5.0, label: {}, minimumValueLabel: {
                        Text("0.0")
                    }, maximumValueLabel: {
                        Text("60.0")
                    })

                }
                
                HStack(spacing: 24){
                    Button(action: {
                        toggle()
                    }, label: {
                        Text("Show/Hide")
                    })
                    .buttonStyle(.borderedProminent)

                    GlassEffectContainer(spacing: containerSpacing) {

                        HStack(spacing: 8) {
                            _image(systemName: "heart.fill")

                            if show {
                                _image(systemName: "leaf.fill")
                                    .offset(x: offsetX)

                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()

                Text("`glassEffectTransition`")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("When used with `GlassEffectContainer`, SwiftUI will use the provided transition to apply changes to the glass effect when you add or remove views with these effects from the view hierarchy. ")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)


                HStack(spacing: 24){
                    Button(action: {
                        toggle()
                    }, label: {
                        Text("Identity")
                    })
                    .buttonStyle(.borderedProminent)

                    GlassEffectContainer(spacing: 30) {

                        HStack(spacing: 8) {
                            _image(systemName: "heart.fill")

                            if show {
                                _image(systemName: "leaf.fill")
                                    .glassEffectTransition(.identity)

                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 24){
                    Button(action: {
                        toggle()
                    }, label: {
                        Text("Matched Geometry")
                    })
                    .buttonStyle(.borderedProminent)

                    GlassEffectContainer(spacing: 30) {

                        HStack(spacing: 8) {
                            _image(systemName: "heart.fill")

                            if show {
                                _image(systemName: "leaf.fill")
                                    .glassEffectTransition(.matchedGeometry(properties: [.position]))

                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                

                Divider()

                Text("`glassEffectID`")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("**NOTE**: Setting `glassEffectID` to *all* views we want to animate, or to *none* of the views will result in the same effect. ")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)



                GlassEffectContainer(spacing: 20.0) {
                    HStack(spacing: 16) {
                        
                        Button(action: {
                            toggle()
                        }, label: {
                            Text("Toggle (all with ID)")
                        })
                        .buttonStyle(.glass)
                        .glassEffectID("button", in: namespace)

                        
                        let image = _image(systemName: "heart.fill")
                        if show {
                            ForEach(0..<3, id: \.self) { index in
                                image
                                    .glassEffectID(index, in: namespace)
                            }
                        }
                    }
                    .frame(height: 64)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                GlassEffectContainer(spacing: 20.0) {
                    
                    
                    HStack(spacing: 16) {
                        
                        Button(action: {
                            toggle()
                        }, label: {
                            Text("Toggle (all w/o ID)")
                        })
                        .buttonStyle(.glass)

                        
                        let image = _image(systemName: "heart.fill")
                        if show {
                            ForEach(0..<3, id: \.self) { index in
                                image
                            }
                        }
                    }
                    .frame(height: 64)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Text("**NOTE**: \nIf *some* of the views within the `GlassEffectContainer` have `glassEffectID` set while other do not, the ones without will **NOT** participate in the animation.")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                GlassEffectContainer(spacing: 20.0) {
                    HStack(spacing: 16) {
                        
                        Button(action: {
                            toggle()
                        }, label: {
                            Text("Button w/o ID")
                        })
                        .buttonStyle(.glass)

                        
                        let image = _image(systemName: "heart.fill")
                        if show {
                            ForEach(0..<3, id: \.self) { index in
                                image
                                    .glassEffectID(index, in: namespace)
                            }
                        }
                    }
                    .frame(height: 64)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                
                Text("Use `glassEffectID` to control animation grouping behavior. \nSame `namespace` for views to be grouped together.")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                GlassEffectContainer(spacing: 20.0) {
                    HStack(spacing: 16) {
                        
                        Button(action: {
                            toggle()
                        }, label: {
                            Text("Default")
                        })
                        .buttonStyle(.glass)

                        
                        let image = _image(systemName: "heart.fill")

                        image
                        
                        if show {
                            image
                        }
                        
                        image

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                GlassEffectContainer(spacing: 20.0) {
                    HStack(spacing: 16) {
                        
                        Button(action: {
                            toggle()
                        }, label: {
                            Text("Namespace 1=2!=3")
                        })
                        .buttonStyle(.glass)

                        
                        let image = _image(systemName: "heart.fill")

                        image
                            .glassEffectID(1, in: namespace)

                        if show {
                            image
                                .glassEffectID(2, in: namespace)
                        }
                        
                        image
                            .glassEffectID(3, in: namespace2)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                
                Divider()

                
                Text("`glassEffectUnion`")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)


                Text("**NOTE**: \n1. The shape of the combined view is determined by the FIRST shape in the union. \n2. Setting `GlassEffectContainer` `spacing` will not effect how views are grouped together, but only the relationship between groups when threshold reached.")
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)

                let containerSpacings = [0.0, 20.0, 120.0]

                ForEach(containerSpacings, id: \.self) { spacing in
                    VStack {
                        Text("Container spacing: \(String(format: "%.1f", spacing))")
                            .font(.subheadline)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        GlassEffectContainer(spacing: spacing) {
                            
                            HStack(spacing: 16) {
                                
                                let capsule = Image(systemName: "heart.fill")
                                    .frame(width: 48, height: 48)
                                    .font(.system(size: 20))
                                    .glassEffect(.regular.tint(.green.opacity(0.2)))
                                
                                let rect = Image(systemName: "heart.fill")
                                    .frame(width: 48, height: 48)
                                    .font(.system(size: 20))
                                    .glassEffect(.regular.tint(.green.opacity(0.2)), in: Rectangle())
                                
                                
                                ForEach(0..<4, id:\.self) { index in
                                    Group {
                                        if index % 2 == 0 {
                                            rect
                                        } else {
                                            capsule
                                        }
                                        
                                    }.glassEffectUnion(id: index < 2 ? 0 : 1, namespace: namespace)
                                }
                            }
                            .frame(height: 64)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }

                    }
                    
                }

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)

        }
        .background(.yellow.opacity(0.1))

    }
    
    
    private func _image(systemName: String) -> some View {
        Image(systemName: systemName)
            .frame(width: 48, height: 48)
            .font(.system(size: 20))
            .glassEffect(.regular.tint(.green.opacity(0.2)))

    }
}

#Preview {
    ContentView()
}
