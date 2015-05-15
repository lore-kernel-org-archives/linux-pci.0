Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:47745 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934359AbbEONjS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 09:39:18 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 15 May 2015 23:39:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A5BB42CE804E
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:39:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4FDd6as28442868
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:39:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4FDcfZ2010857
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:38:41 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 03/10] powerpc/pci: remove PCI devices in reverse order
Date: Fri, 15 May 2015 21:36:57 +0800
Message-Id: <1431697024-5710-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431697024-5710-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431697024-5710-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
when removing PCI devices on a bus which has VFs, we need to remove them
in the reverse order.

This patch applies this pattern to the hotplug removal code for the powerpc
arch.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 7ed85a6..98f84ed 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -50,7 +50,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
 		 pci_domain_nr(bus),  bus->number);
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
 		pr_debug("   Removing %s...\n", pci_name(dev));
 		pci_stop_and_remove_bus_device(dev);
 	}
-- 
1.7.9.5

