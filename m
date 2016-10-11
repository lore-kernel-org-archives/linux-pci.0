Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48358 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbcJKM6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Oct 2016 08:58:50 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 1/4] PCI: designware: Fix compiler warning
Date: Tue, 11 Oct 2016 18:28:32 +0530
Message-ID: <1476190715-16884-2-git-send-email-kishon@ti.com>
In-Reply-To: <1476190715-16884-1-git-send-email-kishon@ti.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the following compilation warning in dw_pcie_readl_unroll()
and dw_pcie_writel_unroll() by just invoking dw_pcie_readl_rc() and
dw_pcie_writel_rc() respectively instead of adding redundant code.

pcie-designware.c: In function 'dw_pcie_readl_unroll':
pcie-designware.c:165:32: warning: passing argument 2 of
 'pp->ops->readl_rc' makes integer from pointer without a cast
 [-Wint-conversion]
   return pp->ops->readl_rc(pp, pp->dbi_base + offset + reg);
                                ^
pcie-designware.c:165:32: note: expected 'u32 {aka unsigned int}' but
 argument is of type 'void *'
pcie-designware.c: In function 'dw_pcie_writel_unroll':
pcie-designware.c:176:31: warning: passing argument 3 of
 'pp->ops->writel_rc' makes integer from pointer without a cast
 [-Wint-conversion]
   pp->ops->writel_rc(pp, val, pp->dbi_base + offset + reg);
                               ^
drivers/pci/host/pcie-designware.c:176:31: note: expected 'u32
 {aka unsigned int}' but argument is of type 'void *'

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host/pcie-designware.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 5ee8772..b8feea4 100644
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
+	dw_pcie_writel_rc(pp, offset + reg, val);
 }
 
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-- 
1.7.9.5

