Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26855 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIFBK7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:10:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 18/20] PCI/DPC: Wait for link active after reset
Date: Wed,  5 Sep 2018 14:35:44 -0600
Message-Id: <20180905203546.21921-19-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DPC service only provides error handling now, so we don't get to
rely on the PCIe hotplug driver to handling the timing requirements for
when it is okay access the downstream devices. This patch adds the check
for the active link before returning control to the pcie error handler
after the slot reset completes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 70cb1e65a311..0aa0d01562bf 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -92,6 +92,10 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
+
+	if (!pcie_wait_for_link(pdev, true))
+		return PCI_ERS_RESULT_DISCONNECT;
+
 	if (pdev->subordinate)
 		pdev->subordinate->error_state = pci_channel_io_normal;
 	return PCI_ERS_RESULT_RECOVERED;
-- 
2.14.4
