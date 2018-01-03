Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:63263 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeACAkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:42 -0500
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
Subject: [PATCH 5/7] PM: i2c-designware-platdrv: Use DPM_FLAG_SMART_PREPARE
Date: Wed, 03 Jan 2018 01:35:54 +0100
Message-ID: <1780798.HpLBO7aPyI@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify i2c-designware-platdrv to set DPM_FLAG_SMART_PREPARE for its
devices and return 0 from the system suspend ->prepare callback
if the device has an ACPI companion object in order to tell the PM
core and middle layers to avoid skipping system suspend/resume
callbacks for the device in that case (which may be problematic,
because the device may be accessed during suspend and resume of
other devices via I2C operation regions then).

Also the pm_runtime_suspended() check in dw_i2c_plat_prepare()
is not necessary any more, because the core does it when setting
power.direct_complete for the device, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -372,6 +372,8 @@ static int dw_i2c_plat_probe(struct plat
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
+
 	/* The code below assumes runtime PM to be disabled. */
 	WARN_ON(pm_runtime_enabled(&pdev->dev));
 
@@ -435,7 +437,13 @@ MODULE_DEVICE_TABLE(of, dw_i2c_of_match)
 #ifdef CONFIG_PM_SLEEP
 static int dw_i2c_plat_prepare(struct device *dev)
 {
-	return pm_runtime_suspended(dev);
+	/*
+	 * If the ACPI companion device object is present for this device, it
+	 * may be accessed during suspend and resume of other devices via I2C
+	 * operation regions, so tell the PM core and middle layers to avoid
+	 * skipping system suspend/resume callbacks for it in that case.
+	 */
+	return !has_acpi_companion(dev);
 }
 
 static void dw_i2c_plat_complete(struct device *dev)
