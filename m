Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:57207 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaLDFy5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 00:54:57 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 11:24:54 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id B90FDE0056
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2014 11:25:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB45tTXK2490828
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:25:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB45spa5004683
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:24:52 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powerpc/pci: Don't scan empty slot
Date: Thu,  4 Dec 2014 16:54:45 +1100
Message-Id: <1417672488-27341-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In hotplug case, function pcibios_add_pci_devices() is called to
rescan the specified PCI bus, which possibly doesn't have any child
devices. Access to the PCI bus's child device node will cause kernel
crash without exception. The patch adds conditions to skip scanning
the PCI bus, which doesn't have any child devices, to avoid the kernel
crash.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 6e2b4e3..270a26d 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -120,7 +120,8 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
 		of_rescan_bus(dn, bus);
-	} else if (mode == PCI_PROBE_NORMAL) {
+	} else if (mode == PCI_PROBE_NORMAL &&
+		   dn->child && PCI_DN(dn->child)) {
 		/*
 		 * Use legacy probe. In the partial hotplug case, we
 		 * probably have grandchildren devices unplugged. So
-- 
1.8.3.2

