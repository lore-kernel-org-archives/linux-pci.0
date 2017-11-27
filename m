Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdK0GUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 01:20:43 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 6/7] PCI: add device wait after slot and bus reset
Date: Mon, 27 Nov 2017 01:20:27 -0500
Message-Id: <1511763628-11856-7-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules indicates that a device can issue
CRS following secondary bus reset. Handle device presence gracefully.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0a9a696..8472c24 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4035,7 +4035,7 @@ int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return 0;
+	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
-- 
1.9.1
