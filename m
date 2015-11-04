Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:44747 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965369AbbKDNNc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:13:32 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 18:43:30 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
Date: Thu,  5 Nov 2015 00:12:39 +1100
Message-Id: <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pnv_pci_reset_secondary_bus(), we should issue fundamental
reset if any one subordinate device of the specified is requesting
that. Otherwise, the device might not come up after the reset.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index c69b6a1..ab8b93e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -878,9 +878,28 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
+{
+	int *freset = data;
+
+	/*
+	 * Stop the iteration immediately if there has any one
+	 * PCI device requesting fundamental reset.
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
+	int option, freset = 0;
+
+	if (dev->subordinate)
+		pci_walk_bus(dev->subordinate,
+			     pnv_pci_dev_reset_type, &freset);
+
+	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
+	pnv_eeh_bridge_reset(dev, option);
 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
 
-- 
2.1.0

