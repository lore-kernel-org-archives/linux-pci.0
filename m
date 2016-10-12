Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754043AbcJLNga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:36:30 -0400
Subject: [PATCH v2 4/7] PCI: artpec6: Use generic DesignWare accessors
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:29:28 -0500
Message-ID: <20161012132928.27228.81029.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the armada8k
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/host/pcie-artpec6.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index d9121c3..b3829d0 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -139,7 +139,7 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	 * Enable writing to config regs. This is required as the Synopsys
 	 * driver changes the class code. That register needs DBI write enable.
 	 */
-	writel(DBI_RO_WR_EN, pp->dbi_base + MISC_CONTROL_1_OFF);
+	dw_pcie_writel_rc(pp, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
 	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
 	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
@@ -159,8 +159,8 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 		return 0;
 
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
 
 	return -ETIMEDOUT;
 }

