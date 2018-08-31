Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14096 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbeIABes (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:48 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 11/16] PCI/portdrv: Restore pci state on slot reset
Date: Fri, 31 Aug 2018 15:26:34 -0600
Message-Id: <20180831212639.10196-12-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The port's config space may be reset after a link reset, which is often
implementated as a secondary bus reset. We need to restore the config
space in order for downstream devices to successfully use it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index b1deab941f68..7b5b3d7ded5b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -174,7 +174,9 @@ static int slot_reset_iter(struct device *device, void *data)
 
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
+	pci_restore_state(dev);
 	device_for_each_child(&dev->dev, dev, slot_reset_iter);
+	pci_save_state(dev);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.14.4
