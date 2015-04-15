Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0113.outbound.protection.outlook.com ([157.56.111.113]:57436
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752210AbbDOJrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 05:47:39 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH 2/2] pci/layerscape: Add LS2085A MSI support
Date: Wed, 15 Apr 2015 17:49:24 +0800
Message-ID: <1429091364-31939-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Freescale LS2085A uses GICv3 ITS to provide MSI functionality,
but it only supports 64 isolation context identifiers. So, all
the PCIe devices inserted to the same PCIe controller will share
the fixed ICID.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Depend on pci-layerscape-Add-LS2085A-PCIe-support.patch

 drivers/pci/host/pci-layerscape.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 15c5e47..1f317ca 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -30,20 +30,38 @@
 
 /* PEX LUT registers */
 #define PCIE_LUT_BASE		0x80000
+#define PCIE_LUT_PEXLCR		0x024 /* PEX LUT Control Register */
+#define PCIE_LUT_UDR(n)		(0x800 + (n) * 8)
+#define PCIE_LUT_LDR(n)		(0x804 + (n) * 8)
+#define PCIE_LUT_MASK_ALL	0xffff
+#define PCIE_LUT_DR_NUM		32
+#define PCIE_LUT_ENABLE		(0x1 << 31)
 #define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug register */
 
 #define PCIE_ATU_NUM		6
 
+#define PCIE_MSI_MAX_NUM	64
+#define PCIE_ICID_BASE		1
+
 struct ls_pcie {
 	struct dw_pcie_port	pp;
 	void __iomem		*regs;
 	void __iomem		*lut;
 	struct regmap		*scfg;
 	int			index;
+	int			icid;
 };
 
 #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
 
+void arch_msi_share_devid_update(struct pci_dev *pdev, u32 *dev_id, u32 *nvesc)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pdev->bus->sysdata);
+
+	*dev_id = pcie->icid;
+	*nvesc = PCIE_MSI_MAX_NUM;
+}
+
 static int ls1_pcie_link_up(struct dw_pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
@@ -136,6 +154,12 @@ static int ls2_pcie_host_init(struct dw_pcie_port *pp)
 	dw_pcie_dbi_write(pp, val, PCI_HEADER_TYPE & ~0x3);
 	dw_pcie_dbi_write(pp, 0, PCIE_DBI_RO_WR_EN);
 
+	/* Set LUT. All request ID will map to a static ICID */
+	iowrite32(pcie->icid, pcie->lut + PCIE_LUT_PEXLCR);
+	iowrite32(PCIE_LUT_MASK_ALL, pcie->lut + PCIE_LUT_UDR(0));
+	iowrite32(PCIE_LUT_ENABLE | pcie->icid,
+		  pcie->lut + PCIE_LUT_LDR(0));
+
 	if (!ls2_pcie_link_up(pp))
 		dev_err(pp->dev, "phy link never came up\n");
 
@@ -159,6 +183,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct ls_pcie *pcie;
 	struct resource *res;
+	static int ls_pcie_num;
 	int ret;
 
 	match = of_match_device(ls_pcie_of_match, &pdev->dev);
@@ -177,6 +202,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	}
 
 	pcie->lut = pcie->regs + PCIE_LUT_BASE;
+	pcie->index = ls_pcie_num++;
+	pcie->icid = PCIE_ICID_BASE + pcie->index;
 	pcie->pp.dev = &pdev->dev;
 	pcie->pp.dbi = pcie->regs;
 	pcie->pp.dw_ops = (struct dw_host_ops *)match->data;
-- 
1.9.1

