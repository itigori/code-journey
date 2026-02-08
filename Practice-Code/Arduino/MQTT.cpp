#include <WiFi.h>
#include <PubSubClient.h>


#define deviceId         "deviceId"
#define deviceSecret     "deviceSecret"


/* 连接WIFI SSID和密码 */
#define WIFI_SSID         "wifi name"
#define WIFI_PASSWD       "wifi passwd"


/* 线上环境域名和端口号，不需要改 */

//华为云地址
#define MQTT_SERVER       "cbd1b71b46.st1.iotda-device.cn-south-1.myhuaweicloud.com"
#define MQTT_PORT         1883
#define MQTT_USERNAME      "MQTT_USERNAME"


//硬件的ID和密码
#define CLIENT_ID         "CLIENT_ID"
#define MQTT_PASSWD       "MQTT_PASSWD"


//硬件发送消息的格式
#define ALINK_BODY_FORMAT         "{\"services\":[{\"service_id\":\"TEST\",\"properties\":%s}]}"
#define ALINK_TOPIC_PROP_POST     "$oc/devices/{" deviceId"/sys/properties/report"


#define sensor_Pin   0  //获取数据的引脚
#define LED_Pin 2
bool ledState = false;

unsigned long lastMs = 0;

//用于连接WiFi
WiFiClient espClient;
//用于连接华为的mqtt服务器
PubSubClient  client(espClient);


//储存数据
float data = 0;


//连接wifi
void wifiInit()
{
    WiFiClass::mode(WIFI_STA);
    WiFi.begin(WIFI_SSID, WIFI_PASSWD);
    while (WiFiClass::status() != WL_CONNECTED)
    {
        delay(1000);
        Serial.println("WiFi not Connect");
    }
    Serial.println("WiFi is Connected");
    client.setServer(MQTT_SERVER, MQTT_PORT);   /* 连接WiFi之后，连接MQTT服务器 */
}

//保持mqtt连接
void mqttCheckConnect()
{
    while (!client.connected())
    {
        client.connect(CLIENT_ID, MQTT_USERNAME, MQTT_PASSWD);
    }
}


//上报数据到华为云
void mqttIntervalPost()
{
  // 生成0~1024之间步长为0.01的随机值
  long randomInt = random(0, 102401);  // 生成0~102400的整数
  float data = randomInt / 100.0;      // 转换为步长0.01的浮点值（0.00~1024.00）

  // 随机切换LED状态，同步更新硬件
  if (random(0, 10) > 7) {
    ledState = !ledState;
    digitalWrite(LED_Pin, ledState);
  }

  char properties[64];  // 扩容以容纳新增的LED属性
  char jsonBuf[128];

  // 上报数据：拼接包含number和ledStatus的合规JSON
  sprintf(properties, "{\"Number\":%.2f,\"LED_Power\":%s}", data, ledState ? "true" : "false");
  sprintf(jsonBuf, ALINK_BODY_FORMAT, properties);

  // 启用MQTT实际上报，获取上报结果
  boolean publishResult = client.publish(ALINK_TOPIC_PROP_POST, jsonBuf);

  // 串口打印调试信息
  Serial.println("------------------------");
  Serial.print("number = ");
  Serial.println(data);
  Serial.print("LED状态 = ");
  Serial.println(ledState ? "开启(true)" : "关闭(false)");
  Serial.print("MQTT上报结果：");
  Serial.println(publishResult ? "成功" : "失败");
}



void setup()
{
    Serial.begin(115200);
    pinMode(LED_Pin, OUTPUT);  
    digitalWrite(LED_Pin, ledState);  
    wifiInit();
}

void loop()
{
    //保持设备在线
    if (millis() - lastMs >= 5000)
    {
        lastMs = millis();
       mqttCheckConnect();
    }


    // 上报
    mqttIntervalPost();

    client.loop();
    delay(2000);
}
