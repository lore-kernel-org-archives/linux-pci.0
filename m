Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQhW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:22 -0400
Subject: [PATCH 04/11] PCI: hisi: Remove redundant struct hisi_pcie.reg_base
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:18 -0500
Message-ID: <20161007163718.25540.70173.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the struct hisi_pcie.reg_base member, which is a duplicate of the
generic pp.dbi_base member.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index c2bdcd1..64f668c 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -38,7 +38,6 @@ struct pcie_soc_ops {
 
 struct hisi_pcie {
 	struct regmap *subctrl;
-	void __iomem *reg_base;
 	u32 port_id;
 	struct pcie_port pp;
 	struct pcie_soc_ops *soc_ops;
@@ -46,12 +45,12 @@ struct hisi_pcie {
 
 static u32 hisi_apb_readl(struct hisi_pcie *hisi, u32 reg)
 {
-	return readl(hisi->reg_base + reg);
+	return readl(hisi->pp.dbi_base + reg);
 }
 
 static void hisi_apb_writel(struct hisi_pcie *hisi, u32 val, u32 reg)
 {
-	writel(val, hisi->reg_base + reg);
+	writel(val, hisi->pp.dbi_base + reg);
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -192,14 +191,12 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	hisi->reg_base = devm_ioremap_resource(&pdev->dev, reg);
-	if (IS_ERR(hisi->reg_base)) {
+	pp->dbi_base = devm_ioremap_resource(&pdev->dev, reg);
+	if (IS_ERR(pp->dbi_base)) {
 		dev_err(pp->dev, "cannot get rc_dbi base\n");
-		return PTR_ERR(hisi->reg_base);
+		return PTR_ERR(pp->dbi_base);
 	}
 
-	hisi->pp.dbi_base = hisi->reg_base;
-
 	ret = hisi_add_pcie_port(pp, pdev);
 	if (ret)
 		return ret;

