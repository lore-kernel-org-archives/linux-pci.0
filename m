Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:52114 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbeC0OJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 10:09:24 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Evan Wang <xswang@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 6/6] PCI: aardvark: remove PCIe outbound window configuration
Date: Tue, 27 Mar 2018 16:08:12 +0200
Message-Id: <20180327140819.23501-7-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Evan Wang <xswang@marvell.com>

Outbound window is used to translate CPU space addresses to PCIe space
addresses when the CPU initiates PCIe transactions.

According to the suggestion of the HW designers, the recommended
solution is to use the default outbound parameters, even though the
current outbound window setting does not cause any known functional
issue.

This patch doesn't address any known functional issue, but aligns to
HW design guidelines, and removes code that isn't needed.

Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 55 -----------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index d0688dc6b6d9..d0559152b8e1 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -109,24 +109,6 @@
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
 
-/* PCIe window configuration */
-#define OB_WIN_BASE_ADDR			0x4c00
-#define OB_WIN_BLOCK_SIZE			0x20
-#define OB_WIN_REG_ADDR(win, offset)		(OB_WIN_BASE_ADDR + \
-						 OB_WIN_BLOCK_SIZE * (win) + \
-						 (offset))
-#define OB_WIN_MATCH_LS(win)			OB_WIN_REG_ADDR(win, 0x00)
-#define OB_WIN_MATCH_MS(win)			OB_WIN_REG_ADDR(win, 0x04)
-#define OB_WIN_REMAP_LS(win)			OB_WIN_REG_ADDR(win, 0x08)
-#define OB_WIN_REMAP_MS(win)			OB_WIN_REG_ADDR(win, 0x0c)
-#define OB_WIN_MASK_LS(win)			OB_WIN_REG_ADDR(win, 0x10)
-#define OB_WIN_MASK_MS(win)			OB_WIN_REG_ADDR(win, 0x14)
-#define OB_WIN_ACTIONS(win)			OB_WIN_REG_ADDR(win, 0x18)
-
-/* PCIe window types */
-#define OB_PCIE_MEM				0x0
-#define OB_PCIE_IO				0x4
-
 /* LMI registers base address and register offsets */
 #define LMI_BASE_ADDR				0x6000
 #define CFG_REG					(LMI_BASE_ADDR + 0x0)
@@ -245,34 +227,9 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
-/*
- * Set PCIe address window register which could be used for memory
- * mapping.
- */
-static void advk_pcie_set_ob_win(struct advk_pcie *pcie,
-				 u32 win_num, u32 match_ms,
-				 u32 match_ls, u32 mask_ms,
-				 u32 mask_ls, u32 remap_ms,
-				 u32 remap_ls, u32 action)
-{
-	advk_writel(pcie, match_ls, OB_WIN_MATCH_LS(win_num));
-	advk_writel(pcie, match_ms, OB_WIN_MATCH_MS(win_num));
-	advk_writel(pcie, mask_ms, OB_WIN_MASK_MS(win_num));
-	advk_writel(pcie, mask_ls, OB_WIN_MASK_LS(win_num));
-	advk_writel(pcie, remap_ms, OB_WIN_REMAP_MS(win_num));
-	advk_writel(pcie, remap_ls, OB_WIN_REMAP_LS(win_num));
-	advk_writel(pcie, action, OB_WIN_ACTIONS(win_num));
-	advk_writel(pcie, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
-}
-
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
-	int i;
-
-	/* Point PCIe unit MBUS decode windows to DRAM space */
-	for (i = 0; i < 8; i++)
-		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);
 
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
@@ -851,12 +808,6 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
-			advk_pcie_set_ob_win(pcie, 1,
-					     upper_32_bits(res->start),
-					     lower_32_bits(res->start),
-					     0,	0xF8000000, 0,
-					     lower_32_bits(res->start),
-					     OB_PCIE_IO);
 			err = pci_remap_iospace(res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
@@ -865,12 +816,6 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 			}
 			break;
 		case IORESOURCE_MEM:
-			advk_pcie_set_ob_win(pcie, 0,
-					     upper_32_bits(res->start),
-					     lower_32_bits(res->start),
-					     0x0, 0xF8000000, 0,
-					     lower_32_bits(res->start),
-					     (2 << 20) | OB_PCIE_MEM);
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 			break;
 		case IORESOURCE_BUS:
-- 
2.14.3
