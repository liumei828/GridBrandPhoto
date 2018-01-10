//
//  ColorUtils.swift
//  SwiftHSVColorPicker
//
//  Created by XXX
//
import UIKit

// Typealias for RGBA color values
typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

// Typealias for HSV color values
typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

func hsb2rgb(_ hsb: HSBA) -> RGBA {
    // Converts HSV to a RGB color
    var rgb: RGBA = (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    
    let i = Int(hsb.hue * 6)
    let f = hsb.hue * 6 - CGFloat(i)
    let p = hsb.brightness * (1 - hsb.saturation)
    let q = hsb.brightness * (1 - f * hsb.saturation)
    let t = hsb.brightness * (1 - (1 - f) * hsb.saturation)
    switch (i % 6) {
    case 0: r = hsb.brightness; g = t; b = p; break;
        
    case 1: r = q; g = hsb.brightness; b = p; break;
        
    case 2: r = p; g = hsb.brightness; b = t; break;
        
    case 3: r = p; g = q; b = hsb.brightness; break;
        
    case 4: r = t; g = p; b = hsb.brightness; break;
        
    case 5: r = hsb.brightness; g = p; b = q; break;
        
    default: r = hsb.brightness; g = t; b = p;
    }
    
    rgb.red = r
    rgb.green = g
    rgb.blue = b
    rgb.alpha = hsb.alpha
    return rgb
}

func rgb2hsb(_ rgb: RGBA) -> HSBA {
    // Converts RGBA to a HSV color
    var hsb: HSBA = (hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.0)
    
    let rd: CGFloat = rgb.red
    let gd: CGFloat = rgb.green
    let bd: CGFloat = rgb.blue
    
    let maxV: CGFloat = max(rd, max(gd, bd))
    let minV: CGFloat = min(rd, min(gd, bd))
    var h: CGFloat = 0
    var s: CGFloat = 0
    let b: CGFloat = maxV
    
    let d: CGFloat = maxV - minV
    
    s = maxV == 0 ? 0 : d / minV;
    
    if (maxV == minV) {
        h = 0
    } else {
        if (maxV == rd) {
            h = (gd - bd) / d + (gd < bd ? 6 : 0)
        } else if (maxV == gd) {
            h = (bd - rd) / d + 2
        } else if (maxV == bd) {
            h = (rd - gd) / d + 4
        }
        
        h /= 6;
    }
    
    hsb.hue = h
    hsb.saturation = s
    hsb.brightness = b
    hsb.alpha = rgb.alpha
    return hsb
}
