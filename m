Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:61715 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeACAkn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:43 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/7] PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
Date: Wed, 03 Jan 2018 01:34:53 +0100
Message-ID: <3548517.xcdEzff6pU@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the intel-lpss driver set DPM_FLAG_SMART_SUSPEND for its
devices which will allow them to stay in runtime suspend during
system suspend unless they need to be reconfigured for some reason.

Also make it avoid resuming its child devices if they have
DPM_FLAG_SMART_SUSPEND set to allow them to remain in runtime
suspend during system suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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
 
