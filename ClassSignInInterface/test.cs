using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using System.Threading;

namespace RockyNamespace
{
  public class Study
  {
    // C#中，方法必须用async异步修饰，且返回值必须为Task<object>，其中，input即为方法的参数，上文的s => input
    public zkemkeeper.CZKEMClass axCZKEM1 = new zkemkeeper.CZKEMClass();
    public async Task<object> StudyMath(object input)
    {
      // 方法体
      bIsConnected = axCZKEM1.Connect_Net("127.0.0.1", "8080");
      return bIsConnected;
    }
  }
}