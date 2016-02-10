Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:52972 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcBJGEa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 01:04:30 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 10 Feb 2016 16:04:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id D11E82CE8057
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:04:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1A64IJ644695652
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:04:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1A63r6g012928
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru, ruscur@russell.cc,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v14 3/9] powerpc/pci: Remove VFs prior to PF
Date: Wed, 10 Feb 2016 17:02:51 +1100
Message-Id: <1455084177-15525-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

As commit ac205b7bb72f ("PCI: make sriov work with hotplug remove")
indicates, VFs which is on the same PCI bus as their PF, should be
removed before the PF. Otherwise, we might run into kernel crash
at PCI unplugging time.

This applies the above pattern to powerpc PCI hotplug path.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 7f9ed0c..59c4361 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -55,7 +55,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
 		 pci_domain_nr(bus),  bus->number);
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
 		pr_debug("   Removing %s...\n", pci_name(dev));
 		pci_stop_and_remove_bus_device(dev);
 	}
-- 
2.1.0

