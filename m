Return-Path: <SRS0=QeBQ=YM=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=QeBQ=YM=wunner.de=lukas@kernel.org>
Date: Thu, 29 Dec 2016 18:50:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20161229175028.GA18510@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20161228112954.GA17925@wunner.de>
 <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
 <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
 <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
List-ID: <linux-pci.vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 29, 2016 at 05:20:22PM +0100, Kilian Singer wrote:
> One thing that was always weird in my debian system is, 
> that even with working lock screen on the 4.7.0-1 version.
> The lock screen is not a black screen but instead seems to
> be a static screenshot of the desktop.

This sounds like an issue with the i915 driver.  When the static
screenshot is shown, i915 may have turned on panel self-refresh
(PSR).  There were numerous PSR issues.


> I know it is a repetition of what I have written above but this behaviour
> (comment 19) should be contrasted to the behaviour on the 4.8 and 4.9
> kernel which make my system unresponsive:
> Here the desktop is non static. I can see xclock ticking. The mouse
> moves. But any keyboard interaction or mouse click is not possible anymore.

It's very odd that this should be related to a root port suspending.
If mouse movements are still visible, the I/O ports of the keyboard
and mouse must still be accessible.

Perhaps you could apply the attached small debug patch, this will
log a message whenever a device runtime suspends/resumes, so it
should log when the root port that's causing trouble goes to D3.
Then we would at least know which one it is.

My money is on the root port above the Nvidia card, you can also
try to keep that one awake with
echo on > /sys/bus/pci/devices/0000:00:01.0/power/control

Thanks,

Lukas

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="runpm_debug.patch"

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4c7055009bd6..9eba9686e302 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -345,9 +345,10 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_idle);
 
-	if (callback)
+	if (callback) {
+		dev_info(dev, "rpm_idle\n");
 		retval = __rpm_callback(callback, dev);
-
+	}
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
 
@@ -516,6 +517,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
 	dev_pm_enable_wake_irq(dev);
+	dev_info(dev, "rpm_suspend\n");
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
@@ -738,6 +740,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq(dev);
+	dev_info(dev, "rpm_resume\n");
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);

--cNdxnHkX5QqsyA0e--
