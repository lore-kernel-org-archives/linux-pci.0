Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51751 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbaHWBPR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 21:15:17 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: add back missing MEM_64 mask check for hotplug path
Date: Fri, 22 Aug 2014 18:15:07 -0700
Message-Id: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We missed that in
|  commit 5b28541552ef5eeffc41d6936105f38c2508e566
|    PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
for pci hotplug path.

We have MEM_64 in type_mask from pci_assign_unassigned_root_bus_resources()
for boot path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1652,7 +1652,7 @@ void pci_assign_unassigned_bridge_resour
 	struct pci_dev_resource *fail_res;
 	int retval;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH;
+				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
 
 again:
 	__pci_bus_size_bridges(parent, &add_list);
