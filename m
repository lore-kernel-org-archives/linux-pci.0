Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754689AbcJLOAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:00:15 -0400
Subject: [PATCH v2 2/4] PCI: qcom: Remove redundant struct qcom_pcie.dbi
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:00:10 -0500
Message-ID: <20161012140010.30144.97925.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the struct qcom_pcie.dbi member, which is a duplicate of the generic
pp.dbi_base member.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-qcom.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 51bb0a9..b8586e4 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -90,7 +90,6 @@ struct qcom_pcie {
 	struct device *dev;
 	union qcom_pcie_resources res;
 	void __iomem *parf;
-	void __iomem *dbi;
 	void __iomem *elbi;
 	struct phy *phy;
 	struct gpio_desc *reset;
@@ -426,7 +425,7 @@ err_res:
 static int qcom_pcie_link_up(struct pcie_port *pp)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
-	u16 val = readw(pcie->dbi + PCIE20_CAP + PCI_EXP_LNKSTA);
+	u16 val = readw(pcie->pp.dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
@@ -509,6 +508,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pp = &pcie->pp;
 	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
 	pcie->dev = dev;
 
@@ -522,9 +522,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->parf);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pcie->dbi = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->dbi))
-		return PTR_ERR(pcie->dbi);
+	pp->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pp->dbi_base))
+		return PTR_ERR(pp->dbi_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
 	pcie->elbi = devm_ioremap_resource(dev, res);
@@ -539,9 +539,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pp = &pcie->pp;
 	pp->dev = dev;
-	pp->dbi_base = pcie->dbi;
 	pp->root_bus_nr = -1;
 	pp->ops = &qcom_pcie_dw_ops;
 

