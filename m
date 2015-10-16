Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:45669
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752370AbbJPHSs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 03:18:48 -0400
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
Subject: [PATCH v4 4/6] PCI: layerscape: update ls_add_pcie_port()
Date: Fri, 16 Oct 2015 15:19:18 +0800
Message-ID: <1444979960-24100-4-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To keep consistent with the other DesignWare-based host drivers,
The patch updates ls_add_pcie_port().

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 89b7eb8..891e504 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -125,15 +125,14 @@ static const struct of_device_id ls_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
 
-static int ls_add_pcie_port(struct ls_pcie *pcie)
+static int __init
+ls_add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
 {
-	struct pcie_port *pp;
 	int ret;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
 
-	pp = &pcie->pp;
-	pp->dev = pcie->dev;
+	pp->dev = &pdev->dev;
 	pp->dbi_base = pcie->dbi;
-	pp->root_bus_nr = -1;
 	pp->ops = pcie->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
@@ -160,8 +159,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
-
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
 	if (IS_ERR(pcie->dbi)) {
@@ -174,7 +171,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-	ret = ls_add_pcie_port(pcie);
+	ret = ls_add_pcie_port(&pcie->pp, pdev);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1

