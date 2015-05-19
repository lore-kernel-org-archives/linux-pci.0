Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:47072 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbESKxn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 06:53:43 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 19 May 2015 20:53:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 430862BB004D
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:53:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4JArTiA20119788
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:53:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4JAr5lC032557
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 20:53:05 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 03/10] powerpc/pci: Remove VFs prior to PF
Date: Tue, 19 May 2015 18:50:05 +0800
Message-Id: <1432032612-21701-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
VFs, which might be hooked to same PCI bus as their PF should be removed
before the PF. Otherwise, the PCI hot unplugging on the PCI bus would
cause kernel crash.

The patch applies the above pattern to PowerPC PCI hotplug path.

[gwshan: changelog]
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

