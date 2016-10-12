Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932731AbcJLNZ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:25:56 -0400
Subject: [PATCH v2 5/6] PCI: armada: Pass device-specific struct to internal
 functions
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:25:52 -0500
Message-ID: <20161012132552.26736.47021.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pcie-armada8k.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index a5faa02..63297ed 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -83,8 +83,9 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void armada8k_pcie_establish_link(struct pcie_port *pp)
+static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 {
+	struct pcie_port *pp = &pcie->pp;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pp)) {
@@ -135,13 +136,16 @@ static void armada8k_pcie_establish_link(struct pcie_port *pp)
 
 static void armada8k_pcie_host_init(struct pcie_port *pp)
 {
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+
 	dw_pcie_setup_rc(pp);
-	armada8k_pcie_establish_link(pp);
+	armada8k_pcie_establish_link(pcie);
 }
 
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct armada8k_pcie *pcie = arg;
+	struct pcie_port *pp = &pcie->pp;
 	u32 val;
 
 	/*
@@ -160,9 +164,10 @@ static struct pcie_host_ops armada8k_pcie_host_ops = {
 	.host_init = armada8k_pcie_host_init,
 };
 
-static int armada8k_add_pcie_port(struct pcie_port *pp,
+static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 				  struct platform_device *pdev)
 {
+	struct pcie_port *pp = &pcie->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -176,7 +181,7 @@ static int armada8k_add_pcie_port(struct pcie_port *pp,
 	}
 
 	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
-			       IRQF_SHARED, "armada8k-pcie", pp);
+			       IRQF_SHARED, "armada8k-pcie", pcie);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
@@ -221,7 +226,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = armada8k_add_pcie_port(pp, pdev);
+	ret = armada8k_add_pcie_port(pcie, pdev);
 	if (ret)
 		goto fail;
 

