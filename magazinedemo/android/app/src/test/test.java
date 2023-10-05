import org.junit.jupiter.api.*;

public class AndroidTest {
    private AndroidDriver driver;

    @BeforeEach
    public void setUp() throws MalformedURLException {
        String apkFilePath = "binary/android/app-release.apk";
        String packageName = "com.example.webviewlinksample";
        String launchActivityName = ".MainActivity";

        DesiredCapabilities desiredCapabilities = new DesiredCapabilities();
        desiredCapabilities.setCapability(MobileCapabilityType.AUTOMATION_NAME, "UiAutomator2");
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_NAME, MobilePlatform.ANDROID);
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_VERSION, "14");
        desiredCapabilities.setCapability(MobileCapabilityType.DEVICE_NAME, "Android Emulator");
        desiredCapabilities.setCapability(MobileCapabilityType.APP, "binary/android/app-release.apk");
        desiredCapabilities.setCapability(AndroidMobileCapabilityType.APP_PACKAGE, "com.example.webviewlinksample");
        desiredCapabilities.setCapability(AndroidMobileCapabilityType.APP_ACTIVITY, launchActivityName);
        driver = new AndroidDriver(new URL("http://0.0.0.0:4723/wd/hub"), desiredCapabilities);
    }

    @AfterEach
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}