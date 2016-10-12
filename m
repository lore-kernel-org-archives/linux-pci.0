Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755039AbcJLNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:14 -0400
Subject: [PATCH v2 3/8] PCI: imx6: Removed unused struct imx6_pcie.mem_base
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:47:56 -0500
Message-ID: <20161012134756.28919.52613.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removed the unused struct imx6_pcie.mem_base member.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index e20e9e8..7af64b2 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -48,7 +48,6 @@ struct imx6_pcie {
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	enum imx6_pcie_variants variant;
-	void __iomem		*mem_base;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;

