//: Playground - noun: a place where people can play
//This playground is for Neural network Design p.2-17

import Cocoa
import Foundation
import Accelerate
import XCPlayground

var str = "Hello, playground"

func plotArrayInPlayground<T>(arrayToPlot:Array<T>, title:String) {
    for currentValue in arrayToPlot {
        XCPCaptureValue(title, value: currentValue)
    }
}

public func ramp (start: Double, step: Double, length: Int) -> [Double] {
    //assert(a.count == b.count, "Expected arrays of the same length, instead got arrays of two different lengths")
    var aa = start
    var bb=step
    
    var result = [Double](count:length, repeatedValue:0.0)
    vDSP_vrampD(&aa, &bb, &result, 1, UInt(result.count))
    return result
}



public func mult (a: [Double], b: [Double]) -> [Double] {
    assert(a.count == b.count, "Expected arrays of the same length, instead got arrays of two different lengths")
    var result = [Double](count:a.count, repeatedValue:0.0)
    vDSP_vmulD(a, 1, b, 1, &result, 1, UInt(a.count))
    return result
}


func hardLimit (input: [Double]) -> [Double] {
    
    var output = [Double](count: input.count, repeatedValue:0.0)
    
    for (index,currentValue) in input.enumerate()
    {
    if currentValue < 0.0 {output[index]=0.0}
    else { output[index] = 1 }
    }
    return output
}

let ramp1 = ramp(-10.0, step: 1.0, length:21 )

plotArrayInPlayground(ramp1, title: "ramp")

let out = hardLimit(ramp1)

plotArrayInPlayground(out, title: "hard limit output")


func symmetricalHardLimit (input: [Double]) -> [Double] {
    
    var output = [Double](count: input.count, repeatedValue:0.0)
    
    for (index,currentValue) in input.enumerate()
    {
    if currentValue < 0.0 {output[index] = -1.0}
    else { output[index] = 1 }
    }
    return output
}

let out1 = symmetricalHardLimit(ramp1)

plotArrayInPlayground(out1, title: "symmetrical hard limit output")

func logSigmoid (input: [Double]) -> [Double] {
    
    var output = [Double](count: input.count, repeatedValue:0.0)
    
    for (index,currentValue) in input.enumerate()
    {
    let n = Double(currentValue)
    output[index] = 1/(1+exp(-n))

    }
    return output
}

let out2 = logSigmoid (ramp1)

plotArrayInPlayground(out2, title: "logSigmoid")


func hyperbolicTangentSigmoid (input: [Double]) -> [Double] {
    
    var output = [Double](count: input.count, repeatedValue:0.0)
    
    for (index,currentValue) in input.enumerate()
    {
     let n = Double(currentValue)
    output[index] = (exp(n)-exp(-n))/(exp(n)+exp(-n))
    }
    return output
}

let out3 = hyperbolicTangentSigmoid (ramp1)

plotArrayInPlayground(out3, title: "hyperbolicTangentSigmoid")

