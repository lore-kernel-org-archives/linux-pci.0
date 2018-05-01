Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:40784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeEAHXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 May 2018 03:23:15 -0400
Date: Tue, 1 May 2018 10:22:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        John Crispin <john@phrozen.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: qcom: fix a bitwise vs logical NOT typo
Message-ID: <20180501072250.GA4269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a typo here so we accidentally set "val" to zero when we
intended just to clear BIT(0).

Fixes: 90d52d57ccac ("PCI: qcom: Add support for IPQ4019 PCIe controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5897af7d3355..b65bbf7c284e 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -869,7 +869,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= !BIT(0);
+	val &= ~BIT(0);
 	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
 
 	/* change DBI base address */
