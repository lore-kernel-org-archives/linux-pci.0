Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932731AbcJLOEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 10:04:40 -0400
Subject: [PATCH v2 2/4] PCI: spear: Pass device-specific struct to internal
 functions
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 09:04:35 -0500
Message-ID: <20161012140435.30368.91314.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012140058.30368.94283.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/host/pcie-spear13xx.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 73f17da..26e905d 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -72,11 +72,11 @@ struct pcie_app_reg {
 
 #define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
 
-static int spear13xx_pcie_establish_link(struct pcie_port *pp)
+static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 {
-	u32 val;
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_port *pp = &spear13xx_pcie->pp;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	u32 val;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
 	if (dw_pcie_link_up(pp)) {
@@ -133,9 +133,9 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct spear13xx_pcie *spear13xx_pcie = arg;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	struct pcie_port *pp = &spear13xx_pcie->pp;
 	unsigned int status;
 
 	status = readl(&app_reg->int_sts);
@@ -150,9 +150,9 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void spear13xx_pcie_enable_interrupts(struct pcie_port *pp)
+static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pcie)
 {
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_port *pp = &spear13xx_pcie->pp;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 
 	/* Enable MSI interrupt */
@@ -176,8 +176,10 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
 
 static void spear13xx_pcie_host_init(struct pcie_port *pp)
 {
-	spear13xx_pcie_establish_link(pp);
-	spear13xx_pcie_enable_interrupts(pp);
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+
+	spear13xx_pcie_establish_link(spear13xx_pcie);
+	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
 }
 
 static struct pcie_host_ops spear13xx_pcie_host_ops = {
@@ -185,9 +187,10 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
 	.host_init = spear13xx_pcie_host_init,
 };
 
-static int spear13xx_add_pcie_port(struct pcie_port *pp,
-					 struct platform_device *pdev)
+static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
+				   struct platform_device *pdev)
 {
+	struct pcie_port *pp = &spear13xx_pcie->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -198,7 +201,7 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
 	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "spear1340-pcie", pp);
+			       "spear1340-pcie", spear13xx_pcie);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
@@ -268,7 +271,7 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
 		spear13xx_pcie->is_gen1 = true;
 
-	ret = spear13xx_add_pcie_port(pp, pdev);
+	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
 

