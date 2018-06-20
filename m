Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933459AbeFTVfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 7/7] PCI/DPC: Remove indirection waiting for inactive link
Date: Wed, 20 Jun 2018 15:38:33 -0600
Message-Id: <20180620213833.25072-7-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch just simplifies waiting for the contained link to become
inactive, removing the indirection to a unnecessary DPC specific handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 348b59954961..921e68c461bd 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -64,18 +64,12 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 	return 0;
 }
 
-static void dpc_wait_link_inactive(struct dpc_dev *dpc)
-{
-	struct pci_dev *pdev = dpc->dev->port;
-
-	pcie_wait_for_link(pdev, false);
-}
-
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
 	struct dpc_dev *dpc;
 	struct pcie_device *pciedev;
 	struct device *devdpc;
+
 	u16 cap;
 
 	/*
@@ -91,7 +85,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	 * Wait until the Link is inactive, then clear DPC Trigger Status
 	 * to allow the Port to leave DPC.
 	 */
-	dpc_wait_link_inactive(dpc);
+	pcie_wait_for_link(pdev, false);
 
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
-- 
2.14.3
