Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754995AbcJLNnE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:43:04 -0400
Subject: [PATCH v2 4/8] PCI: hisi: Remove redundant struct hisi_pcie.reg_base
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:42:59 -0500
Message-ID: <20161012134259.28562.94100.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 28c95b8..f2bb206 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -38,7 +38,6 @@ struct pcie_soc_ops {
 
 struct hisi_pcie {
 	struct regmap *subctrl;
-	void __iomem *reg_base;
 	u32 port_id;
 	struct pcie_port pp;
 	struct pcie_soc_ops *soc_ops;
@@ -47,12 +46,12 @@ struct hisi_pcie {
 static inline void hisi_pcie_apb_writel(struct hisi_pcie *hisi_pcie,
 					u32 val, u32 reg)
 {
-	writel(val, hisi_pcie->reg_base + reg);
+	writel(val, hisi_pcie->pp.dbi_base + reg);
 }
 
 static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *hisi_pcie, u32 reg)
 {
-	return readl(hisi_pcie->reg_base + reg);
+	return readl(hisi_pcie->pp.dbi_base + reg);
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -198,14 +197,12 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	hisi_pcie->reg_base = devm_ioremap_resource(dev, reg);
-	if (IS_ERR(hisi_pcie->reg_base)) {
+	pp->dbi_base = devm_ioremap_resource(dev, reg);
+	if (IS_ERR(pp->dbi_base)) {
 		dev_err(dev, "cannot get rc_dbi base\n");
-		return PTR_ERR(hisi_pcie->reg_base);
+		return PTR_ERR(pp->dbi_base);
 	}
 
-	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
-
 	ret = hisi_add_pcie_port(pp, pdev);
 	if (ret)
 		return ret;

