Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:50070 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbaFSHWx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 03:22:53 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 19 Jun 2014 17:22:51 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 294142CE8052
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 17:22:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5J76WON31719594
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 17:06:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5J7MkjE002182
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 17:22:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pci: Remove duplicate logic
Date: Thu, 19 Jun 2014 17:22:45 +1000
Message-Id: <1403162565-26835-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since the logic to reset PCI secondary bus by PCI config register
PCI_BRIDGE_CTL_BUS_RESET is included in pci_reset_secondary_bus(),
we needn't implement another one of ourself. The patch removes the
duplicate implementation and calls pci_reset_secondary_bus().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b49c72f..b2814e2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -123,21 +123,12 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
-	u16 ctrl;
-
 	if (ppc_md.pcibios_reset_secondary_bus) {
 		ppc_md.pcibios_reset_secondary_bus(dev);
 		return;
 	}
 
-	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
-	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
-	msleep(2);
-
-	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
-	ssleep(1);
+	pci_reset_secondary_bus(dev);
 }
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
-- 
1.8.3.2

