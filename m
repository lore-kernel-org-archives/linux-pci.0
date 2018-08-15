Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:12480
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729312AbeHOQnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Aug 2018 12:43:09 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2 3/5] PCI: cadence: Check whether MSI is masked before sending it
Date: Wed, 15 Aug 2018 14:47:47 +0100
Message-ID: <1534340867-21491-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The EP driver did not check the mask bit for each MSI before
sending it in raise_irq.  This is now checked, and -EINVAL is
returned if masked.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 970d934..56f6b87 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -333,6 +333,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	if (!interrupt_num || interrupt_num > msi_count)
 		return -EINVAL;
 
+	/* Check whether MSI is masked */
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_MASK_64);
+	if (data & (1 << (interrupt_num - 1)))
+		return -EINVAL;
+
 	/* Compute the data value to be written. */
 	data_mask = msi_count - 1;
 	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
-- 
1.9.0
