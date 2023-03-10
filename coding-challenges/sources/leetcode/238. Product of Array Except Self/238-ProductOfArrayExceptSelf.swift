

fileprivate func productExceptSelf(_ nums: [Int]) -> [Int] {
    let prefixProducts = nums
        .reduce(into: [Int]()) { array, value in
            if let last = array.last {
                array.append(last * value)
            } else {
                array.append(value)
            }
        }

    let suffixProducts = Array(nums
        .reversed()
        .reduce(into: [Int]()) { array, value in
            if let last = array.last {
                array.append(last * value)
            } else {
                array.append(value)
            }
        }
        .reversed())

    let result = nums
        .indices
        .reduce(into: [Int]()) { array, index in
            if index == 0 {
                array.append(suffixProducts[index + 1])
            } else if index == nums.count - 1 {
                array.append(prefixProducts[index - 1])
            } else {
                array.append(prefixProducts[index - 1] * suffixProducts[index + 1])
            }
        }

    return result
}

import XCTest

final class ProductOfArrayExceptSelfTests: XCTestCase {
    func test() {
        XCTAssertEqual(productExceptSelf([1,2,3,4]), [24,12,8,6])
        XCTAssertEqual(productExceptSelf([-1,1,0,-3,3]), [0,0,9,0,0])
    }
}
