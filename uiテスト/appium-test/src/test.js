const webdriverio = require('webdriverio');
const assert = require('assert');
const fs = require('fs');

const APP_PATH_RELEASE_ANDROID = "/Users/systena123/WorkSpace/appium-test/app/android/app-release.apk"
const APP_PATH_DEBUG_ANDROID = "/Users/systena123/WorkSpace/appium-test/app/android/debug/app-debug.apk"

const optionsAndroid = {
    "path": "/wd/hub",
    "port": 4723,
    "capabilities": {
        "platformName": "Android",
        "appium:platformVersion": "14",
        "appium:deviceName": "emulator-5554",
        "appium:app": APP_PATH_RELEASE_ANDROID,
        "appium:appPackage": "com.example.magazinedemo",
        "appium:appActivity": "com.example.magazinedemo.MainActivity",
        "appium:automationName": "UiAutomator2",
    },
}

const optionsIos = {
    path: '/wd/hub/',
    port: 4723,
    capabilities: {
        platformName: "ios",
        "appium:app": "/my/correct/path",
        "appium:automationName": "XCUITest",
        'appium:autoAcceptAlerts': 'true',
        "appium:xcodeOrgId": "myteamid",
        "appium:xcodeSigningId": "iPhone Developer",
        "appium:udid":"auto",
        "appium:showXcodeLog": true
    }
};

const delay = ms => new Promise(res => setTimeout(res, ms));

// UIテストを行う。
async function runTest() {
    let testSuccessCount = 0;
    let testFailedCount = 0;
    let result = {};
    let testResult = {};
    let testResults = [];
    let client;
    let windowSize;
    
    console.log('\u001b[30m' + "test start")
    try {
        result.start = Date(Date.now());
        client = await lunchApp()
        windowSize = await getDeviceSize(client)
        console.log('\u001b[32m' + "✔️" + '\u001b[37m' + "アプリ起動成功")
    } catch (error) {
        result.error = error.toString()
        console.log("error", error)
        console.log("✖︎" + '\u001b[37m' + "アプリ起動失敗")
        result.end = Date(Date.now());
        await saveJsonFile(result)
        return
    }
    console.log('\u001b[37m'+ "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー" + '\u001b[30m')
    testResult = {};
    try {
        testResult.testName = "ニュースタブをタップ"
        await tapNextTab(client, windowSize)
        testSuccessCount += 1
        testResult.isSuccess = true
        console.log('\u001b[32m' + "✔️　" + '\u001b[37m' + "ニュースタブをタップ")
    } catch (error) {
        console.log("error", error)
        testFailedCount += 1
        testResult.isSuccess = false
        testResult.error = error.toString()
        console.log("✖︎" + '\u001b[37m' + "ニュースタブをタップ")
    }
    testResults.push(testResult)
    console.log('\u001b[37m'+ "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー" + '\u001b[30m')
    testResult = {};
    try {
        testResult.testName = "右フリック"
        await swipeRight(client, windowSize)
        testSuccessCount += 1
        testResult.isSuccess = true
        console.log('\u001b[32m' + "✔️　" + '\u001b[37m' + "右フリック")
    } catch (error) {
        console.log("error", error)
        testFailedCount += 1
        testResult.isSuccess = false
        testResult.error = error.toString()
        console.log("✖︎" + '\u001b[37m' + "右フリック")
    }
    testResults.push(testResult)
    console.log('\u001b[37m'+ "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー" + '\u001b[30m')
    testResult = {};
    try {
        testResult.testName = "左フリック"
        await swipeLeft(client, windowSize)
        testSuccessCount += 1
        testResult.isSuccess = true
        console.log('\u001b[32m' + "✔️　" + '\u001b[37m' + "左フリック")
    } catch (error) {
        console.log("error", error)
        testFailedCount += 1
        testResult.isSuccess = false
        testResult.error = error.toString()
        console.log("✖︎" + '\u001b[37m' + "左フリック")
    }
    testResults.push(testResult)
    console.log('\u001b[37m'+ "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー" + '\u001b[30m')
    testResult = {};
    try {
        testResult.testName = "アップバーをスクロール"
        await scrollAppbar(client, windowSize)
        testSuccessCount += 1
        testResult.isSuccess = true
        console.log('\u001b[32m' + "✔️　" + '\u001b[37m' + "アップバーをスクロール")
    } catch (error) {
        console.log("error", error)
        testFailedCount += 1
        testResult.isSuccess = false
        testResult.error = error.toString()
        console.log("✖︎" + '\u001b[37m' + "アップバーをスクロール")
    }
    testResults.push(testResult)
    console.log('\u001b[37m'+ "ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー" + '\u001b[30m')
    try {
        quitApp(client, 5000)
    } catch (error) {
        result.error = error.toString()
        console.log("error", error)
    } finally {
        result.tests = testResults
        result.testCount = testSuccessCount+testFailedCount
        result.testSuccessCount = testSuccessCount
        result.testFailedCount = testFailedCount
        result.end = Date(Date.now());
        console.log('\u001b[34m' + "総合テスト数：", result.testCount)
        console.log('\u001b[32m' + "テスト成功数：", result.testSuccessCount)
        console.log('\u001b[31m' + "テスト失敗数：", result.testFailedCount)
        saveJsonFile(result)
    }
}

// アプリを起動する。
async function lunchApp() {
    console.log('\u001b[30m' + "lunching")
    return await webdriverio.remote(optionsAndroid)
}

// アプリを終了する。
async function quitApp(client, miliSecond) {
    const second = miliSecond/1000
    console.log('\u001b[30m' + `waiting.....${second}seconds`)
    await delay(miliSecond)
    console.log('\u001b[30m' + "quit")
    await client.deleteSession()
}

// デバイスサイズの情報を取得する。
async function getDeviceSize(client) {
    console.log('\u001b[30m' + `get devie size`)
    return await client.getWindowSize();
}

// アイテムをタップする機能
async function tapElement(element) {
    await element.touchAction([
                          { action: 'tap' }
                      ])
}

// アイテムをスーワイプする機能
async function swipeElement(client, startPoint, endPoint, anchor, miliSecond) {
    await client.touchPerform([
                         {
                             action: 'press',
                             options: {
                               x: startPoint,
                               y: anchor,
                             },
                           },
                         {
                             action: 'wait',
                             options: {
                               ms: miliSecond,
                             },
                           },
                         {
                             action: 'moveTo',
                             options: {
                               x: endPoint,
                               y: anchor,
                             },
                           },
                         {
                             action: 'release',
                             options: {},
                           },
                         ])
}

// エレメントのvalueを取得する
async function getElementValue(xpath, client) {
    const element = await client.findElement("xpath", xpath)
    const value = await client.$(element).getAttribute("content-desc")
    return value
}

// ニュースタブをタップする。
async function tapNextTab(client, windowSize) {
    console.log('\u001b[30m' + `tap the news`)
    const newsTab = await client.$('//android.widget.Button[@content-desc="ニュース"]');
    await delay(1000)
    await tapElement(newsTab)
    await delay(1000)
    const value = await getElementValue(`//android.view.View[@content-desc="ニュースタブです。"]`, client)
    assert.equal(value, "ニュースタブです。");
}

// 右フリックする。
async function swipeRight(client, windowSize) {
    console.log('\u001b[30m' + `swipe right`)
    await delay(3000)
    const startPoint = windowSize.width * 0.1
    const endPoint = windowSize.width * 0.9
    const anchor = windowSize.height * 0.6
    await swipeElement(client, startPoint, endPoint, anchor, 100)
}

// 左フリックする。
async function swipeLeft(client, windowSize) {
    console.log('\u001b[30m' + `swipe left`)
    await delay(3000)
    const startPoint = windowSize.width * 0.9
    const endPoint = windowSize.width * 0.1
    const anchor = windowSize.height * 0.6
    await swipeElement(client, startPoint, endPoint, anchor, 100)
}

// アップバーをスクロールする。
async function scrollAppbar(client, windowSize) {
    console.log('\u001b[30m' + `scroll appbar`)
    const endPoint = windowSize.width * 0.5
    const anchor = windowSize.height * 0.2
    const scrollTime = 1500
    await delay(3000)
    await client.touchPerform([
                         {
                             action: 'longPress',
                             options: {
                                x: windowSize.width * 0.1,
                                y: anchor,
                             },
                           },
                         {
                             action: 'moveTo',
                             options: {
                                x: endPoint,
                                y: anchor,
                                ms: scrollTime,
                             },
                           },
                         {
                             action: 'release',
                             options: {},
                           },
                         ])
    await delay(1000)
    await client.touchPerform([
                         {
                             action: 'longPress',
                             options: {
                                x: windowSize.width * 0.9,
                                y: anchor,
                             },
                           },
                         {
                             action: 'moveTo',
                             options: {
                                x: endPoint,
                                y: anchor,
                                ms: scrollTime,
                             },
                           },
                         {
                             action: 'release',
                             options: {},
                           },
                         ])
}

// ファイルの確認の関数
function isExistFile(path) {
    try {
        fs.statSync(path);
        return true
    } catch(err) {
        if(err.code === 'ENOENT') return false
            }
}

async function saveJsonFile(result) {
    const filePath = "./log/" + new Date().toJSON().slice(0,10).split('-').join('')
    console.log('\u001b[30m' + "filePath：", filePath)
    const jsonExist = isExistFile(filePath + "/result.json");
    if (jsonExist) {
        console.log('\u001b[30m' + "there is the file")
        const resultData = JSON.parse(fs.readFileSync(filePath + "/result.json", 'utf8'));
        resultData.updatedAt = result.end
        resultData.results.push(result)
        console.log('\u001b[30m' + "jsonObject", resultData)
        fs.writeFileSync(filePath + "/result.json", JSON.stringify(resultData))
    } else {
        console.log('\u001b[30m' + "there is no file")
        const resultData = {
                                createdAt: result.end,
                                updatedAt: result.end,
                                results: [result]
                            }
        console.log('\u001b[30m' + "jsonObject", resultData)
        try {
            const dirExist = isExistFile(filePath);
            if (!dirExist) {
                console.log('\u001b[30m' + "create dir")
                await fs.mkdir(filePath, { recursive: true }, function(err) {
                  if (err) {
                    console.log(err);
                    return 1;
                  }
                });
            }
            await delay(1000)
            console.log('\u001b[30m' + "save json file")
            await fs.writeFileSync(filePath + "/result.json", JSON.stringify(resultData))
        } catch(e) {
            console.log('\u001b[31m' + "error：", e)
        }
    }
}

runTest()
