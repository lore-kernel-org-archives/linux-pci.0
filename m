Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeABRAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 12:00:38 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 6/6] PCI: Add device wait after slot and bus reset
Date: Tue,  2 Jan 2018 12:00:23 -0500
Message-Id: <1514912423-13341-7-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
References: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules indicates that a device can issue
CRS following secondary bus reset. Handle device presence gracefully.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eae04aa..2c9e9a9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4161,7 +4161,7 @@ int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return 0;
+	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
-- 
1.9.1
