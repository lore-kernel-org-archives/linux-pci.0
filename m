Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26907 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIFBLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:11:14 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 19/20] PCI/DPC: Link reset code cleanup
Date: Wed,  5 Sep 2018 14:35:45 -0600
Message-Id: <20180905203546.21921-20-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is just a code clean up patch reording declarations based on their
dependency. No functional change here.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 0aa0d01562bf..25d1b1445484 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -66,24 +66,15 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc;
-	struct pcie_device *pciedev;
-	struct device *devdpc;
-
-	u16 cap;
-
-	/*
-	 * DPC disables the Link automatically in hardware, so it has
-	 * already been reset by the time we get here.
-	 */
-	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
-	pciedev = to_pcie_device(devdpc);
-	dpc = get_service_data(pciedev);
-	cap = dpc->cap_pos;
+	struct device *devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
+	struct pcie_device *pciedev = to_pcie_device(devdpc);
+	struct dpc_dev *dpc = get_service_data(pciedev);
+	u16 cap = dpc->cap_pos;
 
 	/*
-	 * Wait until the Link is inactive, then clear DPC Trigger Status
-	 * to allow the Port to leave DPC.
+	 * DPC disables the Link automatically in hardware, so it has already
+	 * been reset by the time we get here. Wait until the Link is inactive,
+	 * then clear DPC Trigger Status to allow the Port to leave DPC.
 	 */
 	pcie_wait_for_link(pdev, false);
 
-- 
2.14.4
