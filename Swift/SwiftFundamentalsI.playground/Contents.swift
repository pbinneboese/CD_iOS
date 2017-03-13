let type: String = "Rectangle"
let description: String = "A quadrilateral with four right angles"

var width: Double = 5
var height: Double = 10.5
var area: Double = width * height

height += 1
width += 1

area = width * height
// Note how you can "interpolate" variables into Strings using the following syntax
print("The shape is a \(type) or \(description) with an area of \(area)")

// loop from 1 to 5 including 5
for i in 1...5 {
    print(i)
}
// loop from 1 to 5 excluding 5
for i in 1..<5 {
    print(i)
}
