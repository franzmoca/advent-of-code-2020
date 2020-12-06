const fs = require('fs');
let tickets = fs.readFileSync('input').toString().split("\n");

const findRow = (rowString) => {
    let range = { start: 0, end: 127 }
    for (const c of rowString) {
        if (c === "F") {
            range.end = Math.floor((range.start + range.end) / 2)
        } else if (c === "B") {
            range.start = Math.floor((range.start + range.end) / 2)
        }
    }
    return range.end
}
const findCol = (colString) => {
    let range = { start: 0, end: 7 }
    for (const c of colString) {
        //console.log(c)
        if (c === "L") {
            range.end = Math.floor((range.start + range.end) / 2)
        } else if (c === "R") {
            range.start = Math.floor((range.start + range.end) / 2)
        }
    }
    return range.end
}
let maxSeatId = 0
let seatIdArray = []
for (let ticket of tickets) {
    let rowString = ticket.slice(0, 7)
    let colString = ticket.slice(7, 10)
    let row = findRow(rowString)
    let col = findCol(colString)
    let seatId = (row * 8) + col
    seatIdArray.push(seatId)
    if (seatId > maxSeatId) {
        maxSeatId = seatId
    }
}
console.log("Solution part 1:", maxSeatId)

seatIdArray.sort(function (a, b) {
    return a - b;
});

for (let i = 1; i < seatIdArray.length; i++) {
    if (seatIdArray[i] - seatIdArray[i - 1] != 1) {
        console.log("Solution part 2:", seatIdArray[i] - 1)
    }
}
