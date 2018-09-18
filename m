Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeISFaa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:30 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 02/10] PCI/portdrv: Restore pci state on slot reset
Date: Tue, 18 Sep 2018 17:56:54 -0600
Message-Id: <20180918235702.26573-3-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The port's config space may be cleared after a link reset. We need
to restore the config space that was saved during probe in order to
successfully access downstream devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..7336e3abb7c9 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -146,6 +146,13 @@ static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+	pci_save_state(dev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 {
 	return PCI_ERS_RESULT_RECOVERED;
@@ -185,6 +192,7 @@ static const struct pci_device_id port_pci_ids[] = { {
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
+	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 	.resume = pcie_portdrv_err_resume,
 };
-- 
2.14.4
