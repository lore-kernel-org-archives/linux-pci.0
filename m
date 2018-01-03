Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:56772 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeACAkl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:41 -0500
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
Subject: [PATCH 7/7] PCI / PM: Use SMART_SUSPEND and LEAVE_SUSPENDED flags for PCIe ports
Date: Wed, 03 Jan 2018 01:38:27 +0100
Message-ID: <33674270.0PFIgc82r6@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PCIe port driver set DPM_FLAG_SMART_SUSPEND and
DPM_FLAG_LEAVE_SUSPENDED for the devices handled by it to benefit
from the opportunistic optimizations in the PCI layer enabled by
these flags.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-pm/drivers/pci/pcie/portdrv_pci.c
@@ -150,6 +150,9 @@ static int pcie_portdrv_probe(struct pci
 
 	pci_save_state(dev);
 
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
+					   DPM_FLAG_LEAVE_SUSPENDED);
+
 	if (pci_bridge_d3_possible(dev)) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
