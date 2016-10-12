Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933272AbcJLNSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:18:43 -0400
Subject: [PATCH v2 07/10] PCI: designware: Swap order of
 dw_pcie_writel_unroll() reg/val arguments
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:18:39 -0500
Message-ID: <20161012131839.26443.16651.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of dw_pcie_readl_unroll() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 7a3458d..035f50c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -164,8 +164,8 @@ static u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
 	return dw_pcie_readl_rc(pp, offset + reg);
 }
 
-static void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
-					 u32 val, u32 reg)
+static void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index, u32 reg,
+				  u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
@@ -196,20 +196,20 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	u32 retries, val;
 
 	if (pp->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pp, index,
-			lower_32_bits(cpu_addr), PCIE_ATU_UNR_LOWER_BASE);
-		dw_pcie_writel_unroll(pp, index,
-			upper_32_bits(cpu_addr), PCIE_ATU_UNR_UPPER_BASE);
-		dw_pcie_writel_unroll(pp, index,
-			lower_32_bits(cpu_addr + size - 1), PCIE_ATU_UNR_LIMIT);
-		dw_pcie_writel_unroll(pp, index,
-			lower_32_bits(pci_addr), PCIE_ATU_UNR_LOWER_TARGET);
-		dw_pcie_writel_unroll(pp, index,
-			upper_32_bits(pci_addr), PCIE_ATU_UNR_UPPER_TARGET);
-		dw_pcie_writel_unroll(pp, index,
-			type, PCIE_ATU_UNR_REGION_CTRL1);
-		dw_pcie_writel_unroll(pp, index,
-			PCIE_ATU_ENABLE, PCIE_ATU_UNR_REGION_CTRL2);
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
+			lower_32_bits(cpu_addr));
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_BASE,
+			upper_32_bits(cpu_addr));
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LIMIT,
+			lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_TARGET,
+			lower_32_bits(pci_addr));
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_TARGET,
+			upper_32_bits(pci_addr));
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL1,
+			type);
+		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL2,
+			PCIE_ATU_ENABLE);
 	} else {
 		dw_pcie_writel_rc(pp, PCIE_ATU_VIEWPORT,
 				  PCIE_ATU_REGION_OUTBOUND | index);

