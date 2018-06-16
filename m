Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:37871 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeFPTfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:41 -0400
Message-Id: <21a663fc0115601b89dd14a93f7edaf1c841f0df.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 31/32] PCI: Whitelist native hotplug ports for runtime D3
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we blacklisted PCIe hotplug ports for runtime D3 because:

(a) Ports handled by the firmware must not be transitioned to D3 by the
    OS behind the firmware's back:
    https://bugzilla.kernel.org/show_bug.cgi?id=53811

(b) Ports handled natively by the OS lacked runtime D3 support in the
    pciehp driver.

We've just rectified the latter, so allow users to manually enable and
test it by passing pcie_port_pm=force on the command line.  Vendors are
thus put in a position to validate hotplug ports for runtime D3 and
perhaps we can someday enable it by default, but with a BIOS cutoff date.

Ashok Raj tested runtime D3 on hotplug ports of a SkyLake Xeon-SP in
2017 and encountered Hardware Error NMIs, so this feature clearly cannot
be enabled for everyone yet:
https://lkml.org/lkml/2017/5/3/480

While at it, remove an erroneous code comment I added with 97a90aee5dab
("PCI: Consolidate conditions to allow runtime PM on PCIe ports") which
claims that parents of a hotplug port must stay awake lest interrupts
cannot be delivered.  That has turned out to be wrong at least for
Thunderbolt hotplug ports.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba712e4e..4099a6c14b6d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2305,18 +2305,23 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * Hotplug interrupts cannot be delivered if the link is down,
-		 * so parents of a hotplug port must stay awake. In addition,
-		 * hotplug ports handled by firmware in System Management Mode
+		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
-		 * For simplicity, disallow in general for now.
 		 */
-		if (bridge->is_hotplug_bridge)
+		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
 			return false;
 
 		if (pci_bridge_d3_force)
 			return true;
 
+		/*
+		 * Hotplug ports handled natively by the OS were not validated
+		 * by vendors for runtime D3 at least until 2018 because there
+		 * was no OS support.
+		 */
+		if (bridge->is_hotplug_bridge)
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
-- 
2.17.1
