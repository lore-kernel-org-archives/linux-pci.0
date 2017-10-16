Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/12] PM: i2c-designware-platdrv: Optimize power management
Date: Mon, 16 Oct 2017 03:31:17 +0200
Message-ID: <2298462.BTY6P2Oy1l@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Optimize the power management in i2c-designware-platdrv by making it
set the DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED which
allows some code to be dropped from its PM callbacks.

First, setting DPM_FLAG_SMART_SUSPEND causes the intel-lpss driver
to avoid resuming i2c-designware-platdrv devices in its ->prepare
callback, so they can stay in runtime suspend after that point even
if the direct-complete feature is not used for them.

It also causes the PM core to avoid invoking "late" and "noirq"
suspend callbacks for these devices if they are in runtime suspend
at the beginning of the "late" phase of device suspend during
system suspend.  That guarantees dw_i2c_plat_suspend() to be
called for a device only if it is not in runtime suspend.
Moreover, it also causes the PM core to set the device's runtime
PM status to "active" after calling dw_i2c_plat_resume() for
it, so the driver doesn't need internal flags to avoid invoking
either dw_i2c_plat_suspend() or dw_i2c_plat_resume() twice in
a row.

Second, setting DPM_FLAG_LEAVE_SUSPENDED enables the optimization
allowing the device to stay suspended after system resume under
suitable conditions, so again the driver doesn't need to take
care of that by itself.

Accordingly, the internal "suspended" and "skip_resume" flags
used by the driver are not necessary any more, so drop them and
simplify the driver's PM callbacks.

Additionally, notice that dw_i2c_plat_complete() only needs
to schedule runtime PM for the device if platform firmware
has been involved in resuming the system, so make it call
pm_resume_via_firmware() to check that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    |    2 --
 drivers/i2c/busses/i2c-designware-platdrv.c |   25 ++++++-------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-core.h
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-core.h
+++ linux-pm/drivers/i2c/busses/i2c-designware-core.h
@@ -280,8 +280,6 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_disabled;
-	bool			suspended;
-	bool			skip_resume;
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -42,6 +42,7 @@
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 
 #include "i2c-designware-core.h"
 
@@ -370,7 +371,10 @@ static int dw_i2c_plat_probe(struct plat
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
+	dev_pm_set_driver_flags(&pdev->dev,
+				DPM_FLAG_SMART_PREPARE |
+				DPM_FLAG_SMART_SUSPEND |
+				DPM_FLAG_LEAVE_SUSPENDED);
 
 	/* The code below assumes runtime PM to be disabled. */
 	WARN_ON(pm_runtime_enabled(&pdev->dev));
@@ -446,7 +450,7 @@ static int dw_i2c_plat_prepare(struct de
 
 static void dw_i2c_plat_complete(struct device *dev)
 {
-	if (dev->power.direct_complete)
+	if (dev->power.direct_complete && pm_resume_via_firmware())
 		pm_request_resume(dev);
 }
 #else
@@ -459,16 +463,9 @@ static int dw_i2c_plat_suspend(struct de
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
-	if (i_dev->suspended) {
-		i_dev->skip_resume = true;
-		return 0;
-	}
-
 	i_dev->disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
-	i_dev->suspended = true;
-
 	return 0;
 }
 
@@ -476,19 +473,9 @@ static int dw_i2c_plat_resume(struct dev
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
-	if (!i_dev->suspended)
-		return 0;
-
-	if (i_dev->skip_resume) {
-		i_dev->skip_resume = false;
-		return 0;
-	}
-
 	i2c_dw_plat_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
 
-	i_dev->suspended = false;
-
 	return 0;
 }
 

