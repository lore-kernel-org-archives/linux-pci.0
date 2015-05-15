Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59520 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbEOFu3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 01:50:29 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 15 May 2015 15:50:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id C02C4357804F
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:50:26 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F5oIUu33357872
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:50:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F5nrEk001852
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:49:54 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V4 03/11] powerpc/pci: remove PCI devices in reverse order
Date: Fri, 15 May 2015 13:46:18 +0800
Message-Id: <1431668786-30371-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

