Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50539 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab2EGU3l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:41 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 5/7] PCI, ibmhp: Using pci_hp_add_bridge
Date: Mon,  7 May 2012 13:29:14 -0700
Message-Id: <1336422556-4124-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

instead of open code with pci_add_new_bus()/do_scan_bus...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/ibmphp_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 4fda7e6..7dccad5 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -775,7 +775,6 @@ static u8 bus_structure_fixup(u8 busno)
 
 static int ibm_configure_device(struct pci_func *func)
 {
-	unsigned char bus;
 	struct pci_bus *child;
 	int num;
 	int flag = 0;	/* this is to make sure we don't double scan the bus,
@@ -805,9 +804,10 @@ static int ibm_configure_device(struct pci_func *func)
 		}
 	}
 	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
-		pci_read_config_byte(func->dev, PCI_SECONDARY_BUS, &bus);
-		child = pci_add_new_bus(func->dev->bus, func->dev, bus);
-		pci_do_scan_bus(child);
+		pci_hp_add_bridge(func->dev);
+		child = func->dev->subordinate;
+		if (child)
+			pci_bus_add_devices(child);
 	}
 
 	return 0;
-- 
1.7.7

