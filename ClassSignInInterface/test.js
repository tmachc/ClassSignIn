/**
 * Created by ccwonline on 2018/3/2.
 */

var edge = require('edge-js');

// var helloWorld = edge.func(function () {/*
//  async (input) => {
//  return ".NET Welcomes " + input.ToString();
//  }
//  */});
//
// helloWorld('JavaScript', function (error, result) {
//     if (error) throw error;
//     console.log(result);
// });

// 定义方法
// var StudyMath = edge.func(function () {/*
//  using System.Collections.Generic;
//  using System.Threading.Tasks;
//
//  namespace RockyNamespace
//  {
//  public class Startup
//  {
//  // C#中，方法必须用async异步修饰，且返回值必须为Task<object>，其中，input即为方法的参数，上文的s => input
//  public async Task<object> Invoke(object input)
//  {
//  // 方法体
//  return 0;
//  }
//  }
//  }
//  */});

// var StudyMath = edge.func({
//     assemblyFile: 'test.dll',             // assemblyFile为dll路径
//     atypeName: 'RockyNamespace.Study',   // RockyNamespace为命名空间，Study为类名
//     methodName: 'StudyMath'                     // StudyMath为方法名
// });


// var StudyMath = edge.func(function () {/*
//  //using System.Reflection;
//  using System;
//  using System.Collections.Generic;
//  using System.ComponentModel;
//
//  async (input) => {
//  // 方法体
//  zkemkeeper.CZKEMClass axCZKEM1 = new zkemkeeper.CZKEMClass();
//  bIsConnected = axCZKEM1.Connect_Net("127.0.0.1", "8080");
//  return 0;
//  }
//  */});


// s为传递方法传递的参数，result为方法返回的结果
StudyMath ({"IPAdd":"127.0.0.1","Port":"8080"}, function (error, result) {
    if (error) throw error;
    if (0 == result)
        console.log("aaaaaaaaaaaaaaa"); // Success
    else
        console.log("bbbbbbbbbbbbbbb"); // Failure
});