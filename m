Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938859AbcJGQj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:27 -0400
Subject: [PATCH 06/10] PCI: imx6: Reorder struct imx6_pcie
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:39:23 -0500
Message-ID: <20161007163923.25776.89146.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct imx6_pcie to put generic fields first.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3b2fb41..1a89165 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -39,13 +39,13 @@ enum imx6_pcie_variants {
 };
 
 struct imx6_pcie {
+	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
 	int			reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
-	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;

