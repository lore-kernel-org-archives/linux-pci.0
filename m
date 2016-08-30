Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:61309
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757691AbcH3KkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Aug 2016 06:40:02 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <robh@kernel.org>, <bhelgaas@google.com>,
        <colin.king@canonical.com>, <soren.brinkmann@xilinx.com>,
        <marc.zyngier@arm.com>, <michal.simek@xilinx.com>, <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rgummal@xilinx.com>, Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function device for legacy interrupts.
Date: Tue, 30 Aug 2016 16:09:18 +0530
Message-ID: <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe legacy interrupts start at 1, not at 0.
When testing with multi function device "error: hwirq 0x4 is too large for
dummy" error comes.
So adding one addtional interrupt when creating irq domain.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index d8d43e6..9f04411 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -561,7 +561,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 	}
 
 	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
-							INTX_NUM,
+							INTX_NUM + 1,
 							&legacy_domain_ops,
 							pcie);
 
-- 
2.1.1

