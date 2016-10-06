Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941885AbcJFNnM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Oct 2016 09:43:12 -0400
Subject: [PATCH] PCI: tegra: Fix argument order in tegra_pcie_phy_disable()
To: Thierry Reding <thierry.reding@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-pci@vger.kernel.org
Date: Thu, 06 Oct 2016 08:43:03 -0500
Message-ID: <20161006134303.5595.9298.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The tegra_pcie_phy_disable() path called pads_writel() with arguments in
the wrong order.  Swap them to be the "value, offset" order expected by
pads_writel().

Fixes: 6fe7c187e026 ("PCI: tegra: Support per-lane PHYs")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.7+
---
 drivers/pci/host/pci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index e2a8e4c..6df5ed0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -859,7 +859,7 @@ static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
 	/* override IDDQ */
 	value = pads_readl(pcie, PADS_CTL);
 	value |= PADS_CTL_IDDQ_1L;
-	pads_writel(pcie, PADS_CTL, value);
+	pads_writel(pcie, value, PADS_CTL);
 
 	/* reset PLL */
 	value = pads_readl(pcie, soc->pads_pll_ctl);

