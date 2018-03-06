using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace AccessControl
{
    public class MyClass
    {
        public async Task<object> Invoke(string txtIP, string txtPort)
        {
            zkemkeeper.CZKEMClass axCZKEM1 = new zkemkeeper.CZKEMClass();
            int idwErrorCode = 0;
            string mseeage = "";

            bool bIsConnected = false;//the boolean value identifies whether the device is connected
            int iMachineNumber = 1;//the serial number of the device.After connecting the device ,this value will be changed.

            bIsConnected = axCZKEM1.Connect_Net(txtIP, Convert.ToInt32(txtPort));

            if (bIsConnected == true)
            {
                iMachineNumber = 1;//In fact,when you are using the tcp/ip communication,this parameter will be ignored,that is any integer will all right.Here we use 1.
                axCZKEM1.RegEvent(iMachineNumber, 65535);//Here you can register the realtime events that you want to be triggered(the parameters 65535 means registering all)
                mseeage = "1";
            }
            else
            {
                axCZKEM1.GetLastError(ref idwErrorCode);
                mseeage = "Unable to connect the device,ErrorCode=" + idwErrorCode.ToString();
            }


            // 方法体
            return mseeage;
        }
    }
}
