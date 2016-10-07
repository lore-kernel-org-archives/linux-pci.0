Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:50 -0400
Subject: [PATCH 4/8] PCI: armada: Pass device-specific struct to internal
 functions
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:46 -0500
Message-ID: <20161007163146.24582.28368.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/host/pcie-armada8k.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index ed96857..16fcb43 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -93,9 +93,9 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void armada8k_pcie_establish_link(struct pcie_port *pp)
+static void armada8k_pcie_establish_link(struct armada8k_pcie *armada8k)
 {
-	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
+	struct pcie_port *pp = &armada8k->pp;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pp)) {
@@ -146,14 +146,15 @@ static void armada8k_pcie_establish_link(struct pcie_port *pp)
 
 static void armada8k_pcie_host_init(struct pcie_port *pp)
 {
+	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
+
 	dw_pcie_setup_rc(pp);
-	armada8k_pcie_establish_link(pp);
+	armada8k_pcie_establish_link(armada8k);
 }
 
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
-	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
+	struct armada8k_pcie *armada8k = arg;
 	u32 val;
 
 	/*
@@ -172,9 +173,10 @@ static struct pcie_host_ops armada8k_pcie_host_ops = {
 	.host_init = armada8k_pcie_host_init,
 };
 
-static int armada8k_add_pcie_port(struct pcie_port *pp,
+static int armada8k_add_pcie_port(struct armada8k_pcie *armada8k,
 				  struct platform_device *pdev)
 {
+	struct pcie_port *pp = &armada8k->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -188,7 +190,7 @@ static int armada8k_add_pcie_port(struct pcie_port *pp,
 	}
 
 	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
-			       IRQF_SHARED, "armada8k-pcie", pp);
+			       IRQF_SHARED, "armada8k-pcie", armada8k);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
@@ -234,7 +236,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = armada8k_add_pcie_port(pp, pdev);
+	ret = armada8k_add_pcie_port(armada8k, pdev);
 	if (ret)
 		goto fail;
 

