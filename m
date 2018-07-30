Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:30496
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeG3S7M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 14:59:12 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 3/5] PCI: cadence: Check whether MSI is masked before sending it
Date: Mon, 30 Jul 2018 18:22:53 +0100
Message-ID: <1532971373-8591-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The EP driver did not check the mask bit for each MSI before
sending it in raise_irq.  This is now checked, and EINVAL is
returned if masked.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index c3a0889..db75280 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -332,6 +332,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	if (!interrupt_num || interrupt_num > msi_count)
 		return -EINVAL;
 
+	/* Check whether MSI is masked */
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_MASK_64);
+	if (data & (1<<(interrupt_num-1)))
+		return -EINVAL;
+
 	/* Compute the data value to be written. */
 	data_mask = msi_count - 1;
 	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
-- 
1.7.1
