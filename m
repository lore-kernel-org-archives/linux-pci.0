Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:18078 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757668Ab2EGU3l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:41 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/7] PCI, cpqhp: Using pci_hp_add_bridge
Date: Mon,  7 May 2012 13:29:13 -0700
Message-Id: <1336422556-4124-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

instead of open code with pci_add_new_bus()/do_scan_bus...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/cpqphp_pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 1c84940..09801c6 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -83,7 +83,6 @@ static void __iomem *detect_HRT_floating_pointer(void __iomem *begin, void __iom
 
 int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)
 {
-	unsigned char bus;
 	struct pci_bus *child;
 	int num;
 
@@ -106,9 +105,10 @@ int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)
 	}
 
 	if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_read_config_byte(func->pci_dev, PCI_SECONDARY_BUS, &bus);
-		child = (struct pci_bus*) pci_add_new_bus(func->pci_dev->bus, (func->pci_dev), bus);
-		pci_do_scan_bus(child);
+		pci_hp_add_bridge(func->pci_dev);
+		child = func->pci_dev->subordinate;
+		if (child)
+			pci_bus_add_devices(child);
 	}
 
 	pci_dev_put(func->pci_dev);
-- 
1.7.7

