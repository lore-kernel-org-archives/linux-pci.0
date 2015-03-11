Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:41565 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbCKFAF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 01:00:05 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 11 Mar 2015 15:00:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 393F92CE804E
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 16:00:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2B4xqwF52494572
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 16:00:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2B4xR0Y009272
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 15:59:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: cascardo@linux.vnet.ibm.com, bhelgaas@google.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] PCI: Apply warm reset to specific devices
Date: Wed, 11 Mar 2015 15:59:01 +1100
Message-Id: <1426049941-6727-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426049941-6727-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426049941-6727-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, VFIO infrastructure depends on pci_reset_function()
to ensure the PCI device in clean state when passing to guest,
or being returned back to host. However, the function doesn't
work (or well) on some PCI devices on PowerPC platforms, which
potentiallybrings pending traffic over the boundary between
host/guest and usually causes memory corruption.

The patch applies warm reset to those PCI devices, which is
implemented based on pci_set_pcie_reset_state() to get clean
state when passing device from host to guest, or returning it
back to host. The reset request is routed to platform specific
pcibios_set_pcie_reset_state() and processed there.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Reuse pci_set_pcie_reset_state()
---
 drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..9846d5e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3504,6 +3504,22 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+static int pci_dev_warm_reset(struct pci_dev *pdev, int probe)
+{
+	int ret;
+
+	/* Check the device can take the reset or not */
+	if (probe)
+		return pci_set_pcie_reset_state(pdev, pcie_warm_reset, probe);
+
+	/* Issue warm reset */
+	ret = pci_set_pcie_reset_state(pdev, pcie_warm_reset, 0);
+	if (!ret)
+		ret = pci_set_pcie_reset_state(pdev, pcie_deassert_reset, 0);
+
+	return ret;
+}
+
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
@@ -3519,6 +3535,18 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_intel_generic_dev },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+	{ PCI_VENDOR_ID_IBM, PCI_ANY_ID,
+		pci_dev_warm_reset },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_57800,
+		pci_dev_warm_reset },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_57840,
+		pci_dev_warm_reset },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_NX2_57810,
+		pci_dev_warm_reset },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+		pci_dev_warm_reset },
+	{ PCI_VENDOR_ID_TI, PCI_ANY_ID,
+		pci_dev_warm_reset },
 	{ 0 }
 };
 
-- 
1.8.3.2

