Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:57474 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKXWtd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Nov 2014 17:49:33 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 08:49:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 678DB2BB005C
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 09:49:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOMnSdA33226870
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 09:49:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOMnRX5008707
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 09:49:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/8] powerpc/pci: Don't scan empty slot
Date: Tue, 25 Nov 2014 09:49:19 +1100
Message-Id: <1416869365-7671-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In hotplug case, function pcibios_add_pci_devices() is called to
rescan the specified PCI bus, which possibly doesn't have any child
devices. Access to the PCI bus's child device node will cause kernel
crash without exception. The patch adds two more conditions to avoid
the kernel crash.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 6e2b4e3..ea5513b 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
  * is how this routine differs from other, similar pcibios
  * routines.)
  */
-void pcibios_add_pci_devices(struct pci_bus * bus)
+void pcibios_add_pci_devices(struct pci_bus *bus)
 {
 	int slotno, mode, pass, max;
 	struct pci_dev *dev;
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

