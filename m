Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:35890 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbFDGpS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:45:18 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:45:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 29/42] powerpc/powernv: Issue fundamental reset in pnv_pci_reset_secondary_bus()
Date: Thu,  4 Jun 2015 16:41:58 +1000
Message-Id: <1433400131-18429-30-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There might have PCI devices, under the specified PCI bus, asking
for fundamental reset. The patch iterates all PCI devices under
the specified PCI bus and issue fundamental reset to the PCI bus
if any PCI device is asking for that. Otherwise, hot reset is
issued to the PCI bus.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 10/21]
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 18167c5..4eb53ed 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1055,9 +1055,32 @@ static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
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
-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
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
+	pnv_eeh_bridge_reset(dev, option);
 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
 
-- 
2.1.0

