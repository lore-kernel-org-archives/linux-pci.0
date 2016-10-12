Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbcJLNcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:32:02 -0400
Subject: [PATCH v2 6/7] PCI: artpec6: Pass device-specific struct to
 internal functions
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:29:44 -0500
Message-ID: <20161012132944.27228.81619.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/host/pcie-artpec6.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index d3e7a40..bdfdea2 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -78,9 +78,9 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
-static int artpec6_pcie_establish_link(struct pcie_port *pp)
+static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 {
-	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
+	struct pcie_port *pp = &artpec6_pcie->pp;
 	u32 val;
 	unsigned int retries;
 
@@ -165,16 +165,20 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	return -ETIMEDOUT;
 }
 
-static void artpec6_pcie_enable_interrupts(struct pcie_port *pp)
+static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
 {
+	struct pcie_port *pp = &artpec6_pcie->pp;
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 }
 
 static void artpec6_pcie_host_init(struct pcie_port *pp)
 {
-	artpec6_pcie_establish_link(pp);
-	artpec6_pcie_enable_interrupts(pp);
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
+
+	artpec6_pcie_establish_link(artpec6_pcie);
+	artpec6_pcie_enable_interrupts(artpec6_pcie);
 }
 
 static struct pcie_host_ops artpec6_pcie_host_ops = {
@@ -183,14 +187,16 @@ static struct pcie_host_ops artpec6_pcie_host_ops = {
 
 static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct artpec6_pcie *artpec6_pcie = arg;
+	struct pcie_port *pp = &artpec6_pcie->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static int artpec6_add_pcie_port(struct pcie_port *pp,
+static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 				 struct platform_device *pdev)
 {
+	struct pcie_port *pp = &artpec6_pcie->pp;
 	struct device *dev = pp->dev;
 	int ret;
 
@@ -204,7 +210,7 @@ static int artpec6_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(dev, pp->msi_irq,
 				       artpec6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "artpec6-pcie-msi", pp);
+				       "artpec6-pcie-msi", artpec6_pcie);
 		if (ret) {
 			dev_err(dev, "failed to request MSI irq\n");
 			return ret;
@@ -255,7 +261,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(artpec6_pcie->regmap))
 		return PTR_ERR(artpec6_pcie->regmap);
 
-	ret = artpec6_add_pcie_port(pp, pdev);
+	ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 

