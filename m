Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeG3PS2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 11:18:28 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH 1/3] PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type
Date: Mon, 30 Jul 2018 14:43:14 +0100
Message-Id: <20180730134316.11719-2-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The field pcie_reg_base in struct mobiveil_pcie represents a physical
address so it should be of phys_addr_t type rather than void __iomem*;
this results in the following compilation  warnings:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_parse_dt':
drivers/pci/controller/pcie-mobiveil.c:326:22: warning: assignment makes
pointer from integer without a cast [-Wint-conversion]
  pcie->pcie_reg_base = res->start;
                      ^
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_enable_msi':
drivers/pci/controller/pcie-mobiveil.c:485:25: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t msg_addr = pcie->pcie_reg_base;
                         ^~~~
drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_compose_msi_msg':
drivers/pci/controller/pcie-mobiveil.c:640:21: warning: initialization
makes integer from pointer without a cast [-Wint-conversion]
  phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));

Fix the type and with it the compilation warnings.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index cf0aa7cee5b0..8b45f77d70f9 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -130,7 +130,7 @@ struct mobiveil_pcie {
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;	/* root port config base */
 	void __iomem *apb_csr_base;	/* MSI register base */
-	void __iomem *pcie_reg_base;	/* Physical PCIe Controller Base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	struct irq_domain *intx_domain;
 	raw_spinlock_t intx_mask_lock;
 	int irq;
-- 
2.15.0
