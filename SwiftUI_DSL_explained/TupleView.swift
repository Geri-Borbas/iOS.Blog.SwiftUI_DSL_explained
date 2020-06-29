//
//  ContentView.swift
//  SwiftUI_DSL
//
//  Created by Geri Borbás on 2020. 06. 26..
//

import SwiftUI


// Nothing to do with bindings, or view updates, this is all compile time stuff.
// Function builders are great indeed, but `TupleView` seems more central to the design.
// Function builders are actually a way to assemble tuples from function arguments.
// See `ModifiedContent_explicit_tuples` for more.


struct TupleView_standard: View
{
        
    
    var body: some View
    {
        VStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


struct TupleView_without_omitted_return_keyword: View
{
        
    
    var body: some View
    {
        return VStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


struct TupleView_inspect_type: View
{
        
    
    var body: some View
    {
        let vStack = VStack
        {
            Text("Hello")
            Text("world!")
        }
        
        // Log.
        print(Mirror(reflecting: vStack))
        
        return vStack
    }
}


struct TupleView_without_Opaque_return_types: View
{
        
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        return VStack
        {
            Text("Hello")
            Text("world!")
        }
    }
}


struct TupleView_explicit_Function_Builders_1: View
{
        
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        return VStack(content:
        {
            Text("Hello")
            Text("world!")
        })
    }
}


struct TupleView_explicit_Function_Builders_2: View
{
    
        
    var body: VStack<TupleView<(Text, Text)>>
    {
        return VStack(content:
        {
            return ViewBuilder.buildBlock(
                Text("Hello"),
                Text("world!")
            )
        })
    }
}


struct TupleView_explicit_Function_Builders_3: View
{
    
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        return VStack(content:
        {
            let tupleView: TupleView<(Text, Text)> =
                ViewBuilder.buildBlock(
                    Text("Hello"),
                    Text("world!")
                )
            
            return tupleView
        })
    }
}


struct TupleView_explicit_Function_Builders_4: View
{
    
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        let contentClosure: () -> TupleView<(Text, Text)> =
        {
            let tupleView: TupleView<(Text, Text)> =
                ViewBuilder.buildBlock(
                    Text("Hello"),
                    Text("world!")
                )
            
            return tupleView
        }
        
        return VStack(content: contentClosure)
    }
}


struct TupleView_without_Function_Builders: View
{
    
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        return VStack
        {
            return TupleView(
                (
                    Text("Hello"),
                    Text("world!")
                )
            )
        }
    }
}


struct TupleView_dissected: View
{
    
    
    var body: VStack<TupleView<(Text, Text)>>
    {
        // Views.
        let helloText: Text = Text("Hello")
        let worldText: Text = Text("world!")
        
        // Tuple and tuple view.
        let tuple: (Text, Text) = (helloText, worldText)
        let tupleView: TupleView<(Text, Text)> = TupleView(tuple)
        
        // Vertical stack and its content closure.
        let closure: () -> TupleView<(Text, Text)> = { return tupleView }
        let verticalStack: VStack<TupleView<(Text, Text)>> = VStack(content: closure)
        
        return verticalStack
    }
}


struct ModifiedContent_standard: View
{
        
    
    var body: some View
    {
        HStack
        {
            Text("Hello")
            Text("world!").bold().padding(-5)
        }
    }
}


struct ModifiedContent_dissected: View
{
    
    
    var body: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>>
    {
        // Text (with modifiers).
        let helloText: Text = Text("Hello")
        let worldText: Text = Text("world!")
        let boldWorldText: Text = worldText.bold()
        let modifiedBoldWorldText: ModifiedContent<Text, _PaddingLayout> =
            boldWorldText.padding(-5) as! ModifiedContent<Text, _PaddingLayout>
        
        // Tuple and tuple view.
        let tuple: (Text, ModifiedContent<Text, _PaddingLayout>) = (helloText, modifiedBoldWorldText)
        let tupleView: TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)> = TupleView(tuple)
                
        // Horizontal stack and its content closure.
        let closure: () -> TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)> = { return tupleView }
        let horizontalStack: HStack<TupleView<(Text, ModifiedContent<Text, _PaddingLayout>)>> = HStack(content: closure)
        
        return horizontalStack
    }
}


struct ModifiedContent_explicit_tuples: View
{
    
    
    var body: some View
    {
        return HStack(content:
        {
            return TupleView((
                Text("Hello"),
                Text("world!").bold().padding(-5)
            ))
        })
    }
}




struct ContentView_Previews: PreviewProvider
{
    
    
    static var previews: some View
    { return ModifiedContent_dissected() }
}
