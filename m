Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:40463 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165096AbdEAMKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:10:43 -0400
Message-Id: <f8ddb6ebb9a5d78b5cbbadc12a25b359052c7d03.1493631639.git.lukas@wunner.de>
In-Reply-To: <cover.1493631639.git.lukas@wunner.de>
References: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 5/5] PCI: Whitelist native hotplug ports for runtime PM
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>, Wei Zhang <wzhang@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we blacklisted PCIe hotplug ports for runtime PM because:

(a) Ports handled by the firmware must not be transitioned to D3hot by
    OSPM behind the firmware's back:
    https://bugzilla.kernel.org/show_bug.cgi?id=53811

(b) For ports handled natively by OSPM we lacked proper runtime PM
    support in the pciehp driver.

We've just rectified the latter, so stop blacklisting those.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Erik Veijola <erik.veijola@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Krishna Dhulipala <krishnad@fb.com>
Cc: Wei Zhang <wzhang@fb.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5bba8e6..7567e575d536 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2244,13 +2244,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
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
-- 
2.11.0
