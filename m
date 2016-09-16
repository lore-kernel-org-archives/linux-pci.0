Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46675 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965244AbcIPUGp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 16:06:45 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] PCI/AER: replace pci_reset_bridge_secondary_bus with pci_reset_bus
Date: Fri, 16 Sep 2016 16:06:30 -0400
Message-Id: <1474056395-21843-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The error handling path is not saving and restoring the settings on
other devices getting impacted by a secondary bus reset. Using a better
API to take care of this.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv.c      | 2 +-
 drivers/pci/pcie/aer/aerdrv_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0..7880cd1 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -350,7 +350,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	pci_reset_bridge_secondary_bus(dev);
+	pci_reset_bus(dev->subordinate);
 	dev_printk(KERN_DEBUG, &dev->dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 521e39c..0339cc3 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -403,7 +403,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
-	pci_reset_bridge_secondary_bus(dev);
+	pci_reset_bus(dev->subordinate);
 	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
-- 
1.9.1

