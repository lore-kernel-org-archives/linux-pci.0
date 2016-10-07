Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941142AbcJGQjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:35 -0400
Subject: [PATCH 07/10] PCI: imx6: Remove unused return values
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:39:31 -0500
Message-ID: <20161007163931.25776.92712.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 1a89165..9971b73 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -251,7 +251,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 0;
 }
 
-static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
+static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
 {
 	u32 val, gpr1, gpr12;
 
@@ -304,8 +304,6 @@ static int imx6_pcie_assert_core_reset(struct imx6_pcie *imx6)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	}
-
-	return 0;
 }
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6)
@@ -344,7 +342,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6)
 	return ret;
 }
 
-static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6)
+static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6)
 {
 	struct pcie_port *pp = &imx6->pp;
 	int ret;
@@ -352,7 +350,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6)
 	ret = clk_prepare_enable(imx6->pcie_phy);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+		return;
 	}
 
 	ret = clk_prepare_enable(imx6->pcie_bus);
@@ -400,7 +398,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6)
 		break;
 	}
 
-	return 0;
+	return;
 
 err_ref_clk:
 	clk_disable_unprepare(imx6->pcie);
@@ -408,8 +406,6 @@ err_pcie:
 	clk_disable_unprepare(imx6->pcie_bus);
 err_pcie_bus:
 	clk_disable_unprepare(imx6->pcie_phy);
-err_pcie_phy:
-	return ret;
 }
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6)

