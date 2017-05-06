Return-Path: <SRS0=TfGW=4M=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=TfGW=4M=wunner.de=lukas@kernel.org>
Date: Sat, 6 May 2017 11:04:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170506090408.GA19740@wunner.de>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03>
 <20170209184613.GA78375@otc-nc-03>
 <20170502015405.GA13918@wunner.de>
 <20170503180426.GA4058@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503180426.GA4058@otc-nc-03>
List-ID: <linux-pci.vger.kernel.org>

Hi Ashok,

On Wed, May 03, 2017 at 11:04:28AM -0700, Raj, Ashok wrote:
> attached is recent set of experiments with your patch series applied
> on 4.11 kernel.
> 
> Right after a reboot, poweroff causes an NMI. You can see the message on 
> 1.dmesg. 1.lspci is after reboot, and 2.lspci is after a poweroff/poweron
> sequence.
> 
> You can see there are other differences, like Corrected error enables, 
> and several others.. 

Thanks a lot for carrying out the tests!

It looks like powering the slot off and back on did work - so far so good.

The NMI seems to occur when powering off the slot.  The lspci output shows
that the Ethernet card in the slot signaled an Unsupported Request Error
which it handled as an Advisory Non-Fatal Error.  However the CPER is sent
by the hotplug port, not by the card in the slot.  It's unclear if the root
port is forwarding the error on behalf of the card in the slot or if it
experienced an error itself.  Please also send lspci output for the hotplug
port (0000:5d:00.0) to clarify this.  It would be ideal to also have lspci
output after the slot has been powered off and before it's powered on.

Unfortunately our CPER parser doesn't log the contents of the "AER info"
field.  It would contain the TLP that triggered the error.

Some ideas to understand what's going on:
- Could you test if the NMI also occurs without my pciehp runtime PM series,
  i.e. with a stock v4.11 kernel?
- Could you apply the small debug patch included below and re-test powering
  off/on?  It will log when the root port goes to D3hot or back to D0.
- If you test with a different card in the slot, do you also get an NMI?

There are a few oddities that caught my eye:
- The class code is logged with incorrect byte order.  I've sent out a
  patch yesterday, could you test if it fixes this?
- After calling pciehp_green_led_off(), there are *two* Command Complete
  interrupts from the slot?!
- The Ethernet card's Parity Error Response bit (#6 in Command Register)
  is unset after boot, but set after powering the slot off and back on?!

Thanks,

Lukas

-- >8 --
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5b638c6..65f3b07 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -421,9 +421,10 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_idle);
 
-	if (callback)
+	if (callback) {
+		dev_info(dev, "rpm_idle\n");
 		retval = __rpm_callback(callback, dev);
-
+	}
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
 
@@ -592,6 +593,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
 	dev_pm_enable_wake_irq_check(dev, true);
+	dev_info(dev, "rpm_suspend\n");
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
@@ -814,6 +816,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev);
+	dev_info(dev, "rpm_resume\n");
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
