Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcJLNSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:18:03 -0400
Subject: [PATCH v2 02/10] PCI: designware: Simplify dw_pcie_readl_unroll(),
 dw_pcie_writel_unroll()
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:17:59 -0500
Message-ID: <20161012131758.26443.96419.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

dw_pcie_readl_unroll() and dw_pcie_writel_unroll() duplicate what
dw_pcie_readl_rc() and dw_pcie_writel_rc() already do, so call them
directly.

[bhelgaas: reworked into patch series]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index b58f078..7ce4f75 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -161,10 +161,7 @@ static inline u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	if (pp->ops->readl_rc)
-		return pp->ops->readl_rc(pp, pp->dbi_base + offset + reg);
-
-	return readl(pp->dbi_base + offset + reg);
+	return dw_pcie_readl_rc(pp, offset + reg);
 }
 
 static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
@@ -172,10 +169,7 @@ static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, pp->dbi_base + offset + reg);
-	else
-		writel(val, pp->dbi_base + offset + reg);
+	dw_pcie_writel_rc(pp, val, offset + reg);
 }
 
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,

