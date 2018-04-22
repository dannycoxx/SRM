<?php
// https://phpspreadsheet.readthedocs.io/en/develop/topics/reading-and-writing-to-file/
require 'PHPSpreadsheet/vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
// use \PhpOffice\PhpSpreadsheet\Reader\IReader;

$data = array();
$allStudentData = array();
$assessIdArray = array();
$dataStuff  = ['Student ID', 'Programme'];

//array of columns 
$dataHeadingRowFound = false;
$assessHeadingRowFound = false;


if ( 0 < $_FILES['file']['error'] ) {
    $data['success'] = false;
    $data['message'] = $_FILES['file']['error'];
} else {
    $fileName = $_FILES['file']['name'];
    //Get filepath extention from filename and convert first letter to capital (necessary for creating reader)
    $fileExt = ucfirst(pathinfo($fileName, PATHINFO_EXTENSION));
    $filePath = $_FILES['file']['tmp_name'];

    // $data['fileExt'] = $fileExt;

    //validate correct filetype
    if ($fileExt == 'Xlsx' || $fileExt == 'Xls') {
        // $spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($filePath);
        // if ($spreadsheet -> getSheetCount() == 2) {
            // $sheetName = 'Assessment results';
            $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader($fileExt);
            $reader->setReadDataOnly(TRUE);
            $reader->setLoadSheetsOnly('Assessment results'); 
            $spreadsheet = $reader->load($filePath);

            $sheet = $spreadsheet->getActiveSheet();

            // https://phpspreadsheet.readthedocs.io/en/develop/topics/accessing-cells/#retrieving-a-range-of-cell-values-to-an-array
            $searchTerm = 'Student ID';
  
            $highestRow = $sheet->getHighestRow(); // e.g. 10
            $highestColumn = $sheet->getHighestColumn(); // e.g 'F'
            // Increment the highest column letter
            $highestColumn++;
            $numStudents = 0;
            $examFound = false;
            for ($row = 1; $row <= $highestRow; ++$row) {
                for ($col = 'A'; $col != $highestColumn; ++$col) {
                    $val = $sheet->getCell($col . $row)->getValue();
                    $val = trim($val);
                    // if ($val === 'Exam') {
                    if ($val === 'Exam' && $assessHeadingRowFound == false) {
                        $assessHeadingRowFound = true;
                        $assessIdRow = $row;
                        $assessIdRow ++;
                    }
                    if (isset($assessIdRow) && $row == $assessIdRow && $col >= 'M' && $col <= 'S' && !is_null($val) && $val != '') {
                        array_push($assessIdArray, $val);
                        array_push($dataStuff, $val);
                    }

                    if ($val === 'Student ID') {
                        $dataHeadingRowFound = true;
                        $studentIdCol = $col;
                        $studentIdRow = $row;
                    }
                    //if ID found, row must be student info
                    if (is_numeric($val) && $dataHeadingRowFound == true && $col == 'A') {
                        $numStudents++;
                        $studentId = $val;
                        array_push($dataStuff, $studentId);
                        $prog = $sheet->getCell('D' . $row)->getValue();
                        $allStudentData[$studentId]['prog'] = $prog;
                        array_push($dataStuff, $prog);
                        $j = 'M';
                        foreach ($assessIdArray as $value) {
                            $assessMark = $sheet->getCell($j . $row)->getValue();
                            $allStudentData[$studentId][$value] = $assessMark;
                            array_push($dataStuff, $assessMark);
                            $j++;
                        }
                }   
            }
            $data['dataStuff'] = $dataStuff;
            $data['moduleCode'] = $sheet->getCell('A' . 1)->getValue();
            // $data['allStudentData'] = $allStudentData;
            $data['numStudents'] = $numStudents;
            $data['numColumns'] = (count($assessIdArray) + 2);
            $data['assessIdArray'] = $assessIdArray;
        }
        // addToDb($allStudentData);
        $data['success'] = true;
        $data['message'] = "Module marks added to database";
    } else {
        $data['success'] = false;
        $data['message'] = "Invalid file type, please use '.xls' or '.xlsx'";
    }
}

function addToDb($allStudentData) {
    //Check whether attempt already there for student
    include ('../php/db_config.php');
    $stmt = $db_con->prepare("INSERT INTO marks VALUES (?, ?, ?, ?)");
    foreach ($allStudentData as $key => $value) {
        $stmt->bind_param("idid", $studentNo, $assessId, $attempt, $mark);
        $stmt->execute();
    }

    mysqli_free_result($result);
    mysqli_close($db_con);
    exit(); 
}


echo json_encode($data);

?>