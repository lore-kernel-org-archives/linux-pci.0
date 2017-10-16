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
Subject: [PATCH 09/12] PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
Date: Mon, 16 Oct 2017 03:30:16 +0200
Message-ID: <5094729.JAaD38WncM@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the intel-lpss driver set DPM_FLAG_SMART_SUSPEND for its
devices which will allow them to stay in runtime suspend during
system suspend unless they need to be reconfigured for some reason.

Also make it avoid resuming its child devices if they have
DPM_FLAG_SMART_SUSPEND set to allow them to remain in runtime
suspend during system suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/mfd/intel-lpss.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/mfd/intel-lpss.c
===================================================================
--- linux-pm.orig/drivers/mfd/intel-lpss.c
+++ linux-pm/drivers/mfd/intel-lpss.c
@@ -450,6 +450,8 @@ int intel_lpss_probe(struct device *dev,
 	if (ret)
 		goto err_remove_ltr;
 
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+
 	return 0;
 
 err_remove_ltr:
@@ -478,7 +480,9 @@ EXPORT_SYMBOL_GPL(intel_lpss_remove);
 
 static int resume_lpss_device(struct device *dev, void *data)
 {
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		pm_runtime_resume(dev);
+
 	return 0;
 }
 


