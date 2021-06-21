// pageextension 50130 "Show Entries_ " extends "G/L Posting Preview"
// {
//     layout
//     {
//         modify("No. of Records")
//         {
//             trigger OnDrillDown()
//             var
//                 code_unit: Codeunit "PI Codeunit";
//             begin

//                 code_unit.displayRecords(Rec."Table ID");
//             end;
//         }
//     }

//     actions
//     {
//     }
// }