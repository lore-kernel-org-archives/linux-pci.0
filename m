Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933163AbcJGQc5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:32:57 -0400
Subject: [PATCH 3/8] PCI: artpec6: Pass device-specific struct to internal
 functions
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:32:52 -0500
Message-ID: <20161007163252.24751.99826.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 6cfd7a5..585aac21b 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -78,9 +78,9 @@ static void artpec6_writel(struct artpec6_pcie *artpec6, u32 offset, u32 val)
 	regmap_write(artpec6->regmap, offset, val);
 }
 
-static int artpec6_pcie_establish_link(struct pcie_port *pp)
+static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6)
 {
-	struct artpec6_pcie *artpec6 = to_artpec6_pcie(pp);
+	struct pcie_port *pp = &artpec6->pp;
 	u32 val;
 	unsigned int retries;
 
@@ -165,16 +165,20 @@ static int artpec6_pcie_establish_link(struct pcie_port *pp)
 	return -ETIMEDOUT;
 }
 
-static void artpec6_pcie_enable_interrupts(struct pcie_port *pp)
+static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6)
 {
+	struct pcie_port *pp = &artpec6->pp;
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 }
 
 static void artpec6_pcie_host_init(struct pcie_port *pp)
 {
-	artpec6_pcie_establish_link(pp);
-	artpec6_pcie_enable_interrupts(pp);
+	struct artpec6_pcie *artpec6 = to_artpec6_pcie(pp);
+
+	artpec6_pcie_establish_link(artpec6);
+	artpec6_pcie_enable_interrupts(artpec6);
 }
 
 static int artpec6_pcie_link_up(struct pcie_port *pp)
@@ -199,14 +203,16 @@ static struct pcie_host_ops artpec6_pcie_host_ops = {
 
 static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct artpec6_pcie *artpec6 = arg;
+	struct pcie_port *pp = &artpec6->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static int artpec6_add_pcie_port(struct pcie_port *pp,
+static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6,
 				 struct platform_device *pdev)
 {
+	struct pcie_port *pp = &artpec6->pp;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -219,7 +225,7 @@ static int artpec6_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 				       artpec6_pcie_msi_handler,
 				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "artpec6-pcie-msi", pp);
+				       "artpec6-pcie-msi", artpec6);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
 			return ret;
@@ -269,7 +275,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(artpec6->regmap))
 		return PTR_ERR(artpec6->regmap);
 
-	ret = artpec6_add_pcie_port(pp, pdev);
+	ret = artpec6_add_pcie_port(artpec6, pdev);
 	if (ret < 0)
 		return ret;
 

