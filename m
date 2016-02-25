Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0097.outbound.protection.outlook.com ([207.46.100.97]:2752
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754819AbcBYHSw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 02:18:52 -0500
From: Minghuan Lian <Minghuan.Lian@nxp.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Minghuan Lian <Minghuan.Lian@nxp.com>
Subject: [PATCH] pci/layerscape: fix MSG TLP drop setting
Date: Thu, 25 Feb 2016 15:04:30 +0800
Message-ID: <1456383870-23302-1-git-send-email-Minghuan.Lian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some kinds of Layerscape PCIe controllers will forward the received
message TLPs to system application address space, which could corrupt
system memory or lead to a system hang. The patch enables the MSG_DROP
to fix this issue.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
 drivers/pci/host/pci-layerscape.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 3923bed..f39961b 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -77,6 +77,16 @@ static void ls_pcie_fix_class(struct ls_pcie *pcie)
 	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->dbi + PCI_CLASS_DEVICE);
 }
 
+/* Drop MSG TLP except for Vendor MSG */
+static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	val = ioread32(pcie->dbi + PCIE_STRFMR1);
+	val &= 0xDFFFFFFF;
+	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+}
+
 static int ls1021_pcie_link_up(struct pcie_port *pp)
 {
 	u32 state;
@@ -97,7 +107,7 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
-	u32 val, index[2];
+	u32 index[2];
 
 	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
 						     "fsl,pcie-scfg");
@@ -116,13 +126,7 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	/*
-	 * LS1021A Workaround for internal TKT228622
-	 * to fix the INTx hang issue
-	 */
-	val = ioread32(pcie->dbi + PCIE_STRFMR1);
-	val &= 0xffff;
-	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+	ls_pcie_drop_msg_tlp(pcie);
 }
 
 static int ls_pcie_link_up(struct pcie_port *pp)
@@ -147,6 +151,7 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(1, pcie->dbi + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
+	ls_pcie_drop_msg_tlp(pcie);
 	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
 }
 
-- 
1.9.1

