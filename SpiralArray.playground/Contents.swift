
func getSpiralState(n: Int) -> [[Int]] {

    enum Direction {
        case right
        case down
        case left
        case up
    }

    func recalculateCoordinates(_ coordinates: (Int, Int),
                                for direction: Direction) -> (Int, Int) {
        let (x, y) = coordinates

        switch direction {
        case .right: return (x + 1, y)
        case .down: return (x, y + 1)
        case .left: return (x - 1, y)
        case .up: return (x, y - 1)
        }
    }

    var result: [[Int]] = Array(repeating: Array(repeating: 0, count: n),
                                count: n)
    var direction: Direction = .right
    var x = 0
    var y = 0
    var newX = 0
    var newY = 0

    guard n > 0 else { return [] }

    for i in 1...(n * n) {
        result[x][y] = i

        (newX, newY) = recalculateCoordinates((x, y), for: direction)

        if direction == .right && (newX == n || result[newX][newY] != 0) {
            direction = .down
            newX = x
            newY += 1
        } else if direction == .down && (newY == n || result[newX][newY] != 0) {
            direction = .left
            newX -= 1
            newY = y
        } else if direction == .left && (newX < 0 || result[newX][newY] != 0) {
            direction = .up
            newX = x
            newY -= 1
        } else if direction == .up && (newY == 0 || result[newX][newY] != 0) {
            direction = .right
            newX += 1
            newY = y
        }

        x = newX
        y = newY
    }

    return result
}

import XCTest

class SpiralArrayTests: XCTestCase {

    let zeroSpiral: [[Int]] = []
    let oneSpiral: [[Int]] = [[1]]
    let twoSpiral: [[Int]] = [[1, 4], [2, 3]]
    let threeSpiral: [[Int]] = [[1, 8, 7], [2, 9, 6], [3, 4, 5]]
    let fourSpiral: [[Int]] = [[1, 12, 11, 10], [2, 13, 16, 9], [3, 14, 15, 8], [4, 5, 6, 7]]
    let fiveSpiral: [[Int]] = [[1, 16, 15, 14, 13], [2, 17, 24, 23, 12], [3, 18, 25, 22, 11], [4, 19, 20, 21, 10], [5, 6, 7, 8, 9]]
    let tenSpiral: [[Int]] = [[1, 36, 35, 34, 33, 32, 31, 30, 29, 28], [2, 37, 64, 63, 62, 61, 60, 59, 58, 27], [3, 38, 65, 84, 83, 82, 81, 80, 57, 26], [4, 39, 66, 85, 96, 95, 94, 79, 56, 25], [5, 40, 67, 86, 97, 100, 93, 78, 55, 24], [6, 41, 68, 87, 98, 99, 92, 77, 54, 23], [7, 42, 69, 88, 89, 90, 91, 76, 53, 22], [8, 43, 70, 71, 72, 73, 74, 75, 52, 21], [9, 44, 45, 46, 47, 48, 49, 50, 51, 20], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]]

    func test0() {
        let res = getSpiralState(n: 0)
        XCTAssertEqual(res, zeroSpiral)
    }

    func test1State() {
        let res = getSpiralState(n: 1)
        XCTAssertEqual(res, oneSpiral)
    }

    func test2State() {
        let res = getSpiralState(n: 2)
        XCTAssertEqual(res, twoSpiral)
    }

    func test3State() {
        let res = getSpiralState(n: 3)
        XCTAssertEqual(res, threeSpiral)
    }

    func test4State() {
        let res = getSpiralState(n: 4)
        XCTAssertEqual(res, fourSpiral)
    }

    func test5State() {
        let res = getSpiralState(n: 5)
        XCTAssertEqual(res, fiveSpiral)
    }

    func test10State() {
        let res = getSpiralState(n: 10)
        XCTAssertEqual(res, tenSpiral)
    }

//    func testPerformanceState() {
//        self.measure {
//            _ = getSpiralState(n: 100)
//        }
//    }

}

SpiralArrayTests.defaultTestSuite.run()
