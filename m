Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44325 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938895AbcJSORa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:17:30 -0400
Message-Id: <ba2f9f322b4aeea1aeb01f98a2eda8efe055494f.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 6/9] PCI: Unfold conditions to block runtime PM on PCIe ports
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The conditions to block D3 on parent ports are currently condensed into
a single expression in pci_dev_check_d3cold().  Upcoming commits will
add further conditions for hotplug ports, making this expression fairly
large and impenetrable.  Unfold the conditions to maintain readability
when they are amended.

No functional change intended.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a19056e..f1ddb6b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2270,19 +2270,20 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 {
 	bool *d3cold_ok = data;
-	bool no_d3cold;
 
-	/*
-	 * The device needs to be allowed to go D3cold and if it is wake
-	 * capable to do so from D3cold.
-	 */
-	no_d3cold = dev->no_d3cold || !dev->d3cold_allowed ||
-		(device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold)) ||
-		!pci_power_manageable(dev);
+	/* The device needs to be allowed to go D3cold. */
+	if (dev->no_d3cold || !dev->d3cold_allowed)
+		*d3cold_ok = false;
+
+	/* If it is wakeup capable it must be able to do so from D3cold. */
+	if (device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold))
+		*d3cold_ok = false;
 
-	*d3cold_ok = !no_d3cold;
+	/* If it is a bridge it must be allowed to go to D3. */
+	if (!pci_power_manageable(dev))
+		*d3cold_ok = false;
 
-	return no_d3cold;
+	return !*d3cold_ok;
 }
 
 /*
-- 
2.9.3

