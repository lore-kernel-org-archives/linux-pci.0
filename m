Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:27778 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeIFBJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:09:01 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 12/20] PCI/portdrv: Restore pci state on slot reset
Date: Wed,  5 Sep 2018 14:35:38 -0600
Message-Id: <20180905203546.21921-13-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The port's config space may be reset after a link reset. We need
to restore the config space that was saved during probe in order to
successfully access downstream devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 93ab8be21a64..8c5f44807f33 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -178,7 +178,9 @@ static int slot_reset_iter(struct device *device, void *data)
 
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
+	pci_restore_state(dev);
 	device_for_each_child(&dev->dev, dev, slot_reset_iter);
+	pci_save_state(dev);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.14.4
