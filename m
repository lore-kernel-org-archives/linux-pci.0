Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:40577 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbcETGnP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2016 02:43:15 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 20 May 2016 16:43:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 184263578058
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:43:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u4K6gwc566650266
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:43:06 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u4K6gXkH032133
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 16:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, alistair@popple.id.au, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 15/18] powerpc/powernv: Use PCI slot reset infrastructure
Date: Fri, 20 May 2016 16:41:39 +1000
Message-Id: <1463726502-14679-16-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The (OPAL) firmware might provide the PCI slot reset capability
which is identified by property "ibm,reset-by-firmware" on the
PCI slot associated device node.

This routes the reset request to firmware if "ibm,reset-by-firmware"
exists in the PCI slot device node. Otherwise, the reset is done
inside kernel as before.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 26bb60b..86544ea 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -36,6 +36,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
 #include <asm/ppc-pci.h>
+#include <asm/pnv-pci.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -815,7 +816,7 @@ out:
 	return 0;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -866,6 +867,44 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct device_node *dn = pci_device_to_OF_node(pdev);
+	uint64_t id = PCI_SLOT_ID(phb->opal_id,
+				  (pdev->bus->number << 8) | pdev->devfn);
+	uint8_t scope;
+	int64_t rc;
+
+	/* Hot reset to the bus if firmware cannot handle */
+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __pnv_eeh_bridge_reset(pdev, option);
+
+	switch (option) {
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		dev_dbg(&pdev->dev, "%s: Unsupported reset %d\n",
+			__func__, option);
+		return -EINVAL;
+	}
+
+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
+	if (rc <= OPAL_SUCCESS)
+		goto out;
+
+	rc = pnv_eeh_poll(id);
+out:
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
-- 
2.1.0

