Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:50404 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965414AbbKDNNz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:13:55 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 23:13:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 41/50] powerpc/powernv: Use firmware PCI slot reset infrastructure
Date: Thu,  5 Nov 2015 00:12:41 +1100
Message-Id: <1446642770-4681-42-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The skiboot firmware might provide the PCI slot reset capability
which is identified by property "ibm,reset-by-firmware" on the
PCI slot associated device node.

This checks the property. If it exists, the reset request is routed
to firmware. Otherwise, the reset is done by kernel as before.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e533535..086d153 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -801,7 +801,7 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 	return ret;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -852,6 +852,45 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct device_node *dn = pdev ? pci_device_to_OF_node(pdev) : NULL;
+	uint64_t id = (0x1ul << 60);
+	uint8_t scope;
+	int64_t rc;
+
+	/*
+	 * If the firmware can't handle it, we will issue hot reset
+	 * on the secondary bus despite the requested reset type.
+	 */
+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __pnv_eeh_bridge_reset(pdev, option);
+
+	/* The firmware can handle the request */
+	switch (option) {
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		dev_warn(&pdev->dev, "%s: Unsupported reset %d\n",
+			 __func__, option);
+		return -EINVAL;
+	}
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
+	return pnv_pci_poll(id, rc, NULL);
+}
+
 static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
 {
 	int *freset = data;
-- 
2.1.0

