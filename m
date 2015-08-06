Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:44560 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbHFENk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 00:13:40 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 6 Aug 2015 14:13:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 28/42] powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
Date: Thu,  6 Aug 2015 14:11:33 +1000
Message-Id: <1438834307-26960-29-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some subordinate PCI devices of one particular PCI bus might ask
for fundamental reset because the default (hot) reset isn't enough
for those PCI devices to be up successfully after reset.

This iterates all PCI devices behind the specified PCI bus and issues
fundamental reset if any one PCI device is asking for that. Otherwise,
hot reset is still issued.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 19cb947..4ae48ff 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1057,8 +1057,31 @@ static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
 	return 0;
 }
 
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
+{
+	int *freset = data;
+
+	/*
+	 * Stop the iteration immediately if there is any
+	 * one PCI device requesting fundamental reset
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
+	int option = EEH_RESET_HOT;
+
+	if (dev->subordinate) {
+		int freset = 0;
+
+		pci_walk_bus(dev->subordinate,
+			     pnv_pci_dev_reset_type,
+			     &freset);
+		option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
+	}
+
 	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
-- 
2.1.0

