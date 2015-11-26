//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

var status: String?
status = getHaterStatus("raining")

//var status = getHaterStatus("raining")

status = getHaterStatus("sunny")

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

print("status is: \(status)")

if let unwrappedStatus = status {
    takeHaterAction(unwrappedStatus)
} else {
    print("Must be nill")
}