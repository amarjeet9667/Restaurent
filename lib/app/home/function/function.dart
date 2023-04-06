// String indentCost(int input) {
//   String output = "";
//   while (input > 0) {
//     output = "${input % 10}$output";
//     input ~/= 10;
//   }
//   if (output.length > 3) {
//     output =
//         "${output.substring(0, output.length - 3)},${output.substring(output.length - 3)}";
//   }
//   if (output.length > 6) {
//     output =
//         "${output.substring(0, output.length - 6)},${output.substring(output.length - 6)}";
//   }
//   if (output.length > 9) {
//     output =
//         "${output.substring(0, output.length - 9)},${output.substring(output.length - 9)}";
//   }

//   return "₹ $output";
// }
