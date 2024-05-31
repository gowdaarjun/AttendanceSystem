// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttendanceSystem {
    address public teacher;
    mapping(address => mapping(uint256 => bool)) public attendance;

    event AttendanceMarked(address student, uint256 classId);

    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only teacher can call this function");
        _;
    }

    constructor() {
        teacher = msg.sender;
    }

    function markAttendance(uint256 classId) external {
        require(!attendance[msg.sender][classId], "Attendance already marked for this class");
        attendance[msg.sender][classId] = true;
        emit AttendanceMarked(msg.sender, classId);
    }

    function getAttendanceStatus(address student, uint256 classId) external view returns (bool) {
        return attendance[student][classId];
    }

    function changeTeacher(address newTeacher) external onlyTeacher {
        teacher = newTeacher;
    }
}
