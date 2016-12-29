Return-Path: <SRS0=QeBQ=YM=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=QeBQ=YM=wunner.de=lukas@kernel.org>
Date: Fri, 30 Dec 2016 00:48:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20161229234800.GA18700@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20161228112954.GA17925@wunner.de>
 <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
 <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
 <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
 <20161229175028.GA18510@wunner.de>
 <2083249365.479.1483051950725.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <2083249365.479.1483051950725.JavaMail.zimbra@quantumtechnology.info>
List-ID: <linux-pci.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 29, 2016 at 11:52:30PM +0100, Kilian Singer wrote:
> Just to be sure I am currently using this repository:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> using
> commit 2d706e790f0508dff4fb72eca9b4892b79757feb

That's the tip of Linus' master branch (of 45 hours ago),
quite adventurous. :-)


> The provided patch fails I can locate the positions by hand though.

The context changed a bit, but you can work around that by increasing
the fuzz, i.e. "patch -p1 -F3".  The context of the patch is just 3 lines,
so the risk is that the patch is applied in the wrong place, but it's not
in this particular case.  I'm also attaching the same patch rebased on the
commit you mentioned above.


> Shall I use another repository or commit?

Linus' master branch is currently at rc1, i.e. bleeding edge,
you may experience lots of (other) breakage there and e.g. v4.9
can be expected to be more stable.  You can switch to the v4.9 tag
with "git checkout v4.9".


To provide some background information, the tiny patch I've attached
does nothing more but log when a device runtime suspends/resumes.
So after locking the screen you should theoretically get a message
in dmesg showing which PCIe root port runtime suspended and somehow
interfered with the keyboard/mouse.

There are five root ports in your machine:
0000:00:01.0	bus 01, Nvidia GPU
0000:00:1c.0	bus 02, SD/MMC Card Reader
0000:00:1c.1	bus 03, Wireless Card
0000:00:1c.2	bus 04, Unused Hotplug Port
0000:00:1c.4	bus 06, Unused Hotplug Port

Runtime suspending these ports was newly added in v4.8 and is supposed
to save energy.  How that can interfere with a keyboard/mouse is a bit
mysterious, the only thing I can imagine is inaccessibility of their
I/O ports due to bad routing or usage by another device.

Best regards,

Lukas

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="runpm_debug_v4.10-rc1.patch"

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 872eac4..c563eaf 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -422,9 +422,10 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_idle);
 
-	if (callback)
+	if (callback) {
+		dev_info(dev, "rpm_idle\n");
 		retval = __rpm_callback(callback, dev);
-
+	}
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
 
@@ -593,6 +594,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
 	dev_pm_enable_wake_irq_check(dev, true);
+	dev_info(dev, "rpm_suspend\n");
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
@@ -815,6 +817,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev);
+	dev_info(dev, "rpm_resume\n");
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);

--Nq2Wo0NMKNjxTN9z--
