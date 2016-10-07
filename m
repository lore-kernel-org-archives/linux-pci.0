Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:42 -0400
Subject: [PATCH 3/8] PCI: armada: Remove redundant struct armada8k_pcie.base
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:38 -0500
Message-ID: <20161007163138.24582.87306.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct armada8k_pcie.base pointer is always a constant offset from
struct pcie_port.dbi_base.  Encode that offset in the register macros so we
don't need to maintain the armada8k_pcie.base pointer.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index d0a3ab4..ed96857 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -29,34 +29,33 @@
 #include "pcie-designware.h"
 
 struct armada8k_pcie {
-	void __iomem *base;
 	struct clk *clk;
 	struct pcie_port pp;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
 
-#define PCIE_GLOBAL_CONTROL_REG		0x0
+#define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
 #define PCIE_DEVICE_TYPE_SHIFT		4
 #define PCIE_DEVICE_TYPE_MASK		0xF
 #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
 
-#define PCIE_GLOBAL_STATUS_REG		0x8
+#define PCIE_GLOBAL_STATUS_REG		(PCIE_VENDOR_REGS_OFFSET + 0x8)
 #define PCIE_GLB_STS_RDLH_LINK_UP	BIT(1)
 #define PCIE_GLB_STS_PHY_LINK_UP	BIT(9)
 
-#define PCIE_GLOBAL_INT_CAUSE1_REG	0x1C
-#define PCIE_GLOBAL_INT_MASK1_REG	0x20
+#define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
+#define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
 #define PCIE_INT_A_ASSERT_MASK		BIT(9)
 #define PCIE_INT_B_ASSERT_MASK		BIT(10)
 #define PCIE_INT_C_ASSERT_MASK		BIT(11)
 #define PCIE_INT_D_ASSERT_MASK		BIT(12)
 
-#define PCIE_ARCACHE_TRC_REG		0x50
-#define PCIE_AWCACHE_TRC_REG		0x54
-#define PCIE_ARUSER_REG			0x5C
-#define PCIE_AWUSER_REG			0x60
+#define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
+#define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
+#define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
+#define PCIE_AWUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x60)
 /*
  * AR/AW Cache defauls: Normal memory, Write-Back, Read / Write
  * allocate
@@ -72,12 +71,12 @@ struct armada8k_pcie {
 
 static u32 armada8k_readl(struct armada8k_pcie *armada8k, u32 offset)
 {
-	return readl(armada8k->base + offset);
+	return readl(armada8k->pp.dbi_base + offset);
 }
 
 static void armada8k_writel(struct armada8k_pcie *armada8k, u32 offset, u32 val)
 {
-	writel(val, armada8k->base + offset);
+	writel(val, armada8k->pp.dbi_base + offset);
 }
 
 static int armada8k_pcie_link_up(struct pcie_port *pp)
@@ -235,8 +234,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	armada8k->base = pp->dbi_base + PCIE_VENDOR_REGS_OFFSET;
-
 	ret = armada8k_add_pcie_port(pp, pdev);
 	if (ret)
 		goto fail;

