Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:6784
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753568AbbJPHSz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 03:18:55 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Yoder Stuart-B08248" <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH v4 6/6] PCI: layerscape: add ls_pcie_msi_host_init
Date: Fri, 16 Oct 2015 15:19:20 +0800
Message-ID: <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Layerscape PCIe has its own MSI implementation. The patch registers
ls_pcie_msi_host_init() to avoid using Designware's MSI.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index c53692a..8fac6c8 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -150,14 +150,31 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
 }
 
+static int ls_pcie_msi_host_init(struct pcie_port *pp,
+				 struct msi_controller *chip)
+{
+	struct device_node *msi_node;
+	struct device_node *np = pp->dev->of_node;
+
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(pp->dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pcie_host_ops ls1021_pcie_host_ops = {
 	.link_up = ls1021_pcie_link_up,
 	.host_init = ls1021_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct pcie_host_ops ls_pcie_host_ops = {
 	.link_up = ls_pcie_link_up,
 	.host_init = ls_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct ls_pcie_drvdata ls1021_drvdata = {
-- 
1.9.1

