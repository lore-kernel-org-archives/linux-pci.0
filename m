Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932866AbcJLNsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:41 -0400
Subject: [PATCH v2 8/8] PCI: imx6: Remove unused return values
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:48:37 -0500
Message-ID: <20161012134837.28919.54666.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unused return values.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 79becd7..c8cefb0 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -245,7 +245,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 0;
 }
 
-static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
+static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct pcie_port *pp = &imx6_pcie->pp;
 	u32 val, gpr1, gpr12;
@@ -299,8 +299,6 @@ static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	}
-
-	return 0;
 }
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
@@ -340,7 +338,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
@@ -349,7 +347,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+		return;
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
@@ -397,7 +395,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	return 0;
+	return;
 
 err_ref_clk:
 	clk_disable_unprepare(imx6_pcie->pcie);
@@ -405,8 +403,6 @@ err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
-err_pcie_phy:
-	return ret;
 }
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)

