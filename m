Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbcJGQdW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:33:22 -0400
Subject: [PATCH 6/8] PCI: artpec6: Use dw_pcie_readl_rc() and
 dw_pcie_pcie_writel_rc()
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:33:16 -0500
Message-ID: <20161007163316.24751.16470.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the DesignWare-generic register accessors instead of doing readl() and
writel() directly.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 8840e30..c3dd571 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -139,7 +139,7 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6)
 	 * Enable writing to config regs. This is required as the Synopsys
 	 * driver changes the class code. That register needs DBI write enable.
 	 */
-	writel(DBI_RO_WR_EN, pp->dbi_base + MISC_CONTROL_1_OFF);
+	dw_pcie_writel_rc(pp, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
 	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
 	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
@@ -159,8 +159,8 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6)
 		return 0;
 
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
 
 	return -ETIMEDOUT;
 }

