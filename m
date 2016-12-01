Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbcLAIbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:31:33 -0500
Subject: [PATCH v10 10/12] PCI: thunder-pem: Factor out resource lookup
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:30:51 -0600
Message-ID: <20161201083051.12247.55989.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Pull the register resource lookup out of thunder_pem_init() so we can
easily add a corresponding lookup using ACPI.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-thunder-pem.c |   50 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 6abaf80..c3276ee 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -284,35 +284,16 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static int thunder_pem_init(struct pci_config_window *cfg)
+static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg,
+			    struct resource *res_pem)
 {
-	struct device *dev = cfg->parent;
-	resource_size_t bar4_start;
-	struct resource *res_pem;
 	struct thunder_pem_pci *pem_pci;
-	struct platform_device *pdev;
-
-	/* Only OF support for now */
-	if (!dev->of_node)
-		return -EINVAL;
+	resource_size_t bar4_start;
 
 	pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
 	if (!pem_pci)
 		return -ENOMEM;
 
-	pdev = to_platform_device(dev);
-
-	/*
-	 * The second register range is the PEM bridge to the PCIe
-	 * bus.  It has a different config access method than those
-	 * devices behind the bridge.
-	 */
-	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res_pem) {
-		dev_err(dev, "missing \"reg[1]\"property\n");
-		return -EINVAL;
-	}
-
 	pem_pci->pem_reg_base = devm_ioremap(dev, res_pem->start, 0x10000);
 	if (!pem_pci->pem_reg_base)
 		return -ENOMEM;
@@ -332,9 +313,32 @@ static int thunder_pem_init(struct pci_config_window *cfg)
 	return 0;
 }
 
+static int thunder_pem_platform_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res_pem;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	/*
+	 * The second register range is the PEM bridge to the PCIe
+	 * bus.  It has a different config access method than those
+	 * devices behind the bridge.
+	 */
+	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res_pem) {
+		dev_err(dev, "missing \"reg[1]\"property\n");
+		return -EINVAL;
+	}
+
+	return thunder_pem_init(dev, cfg, res_pem);
+}
+
 static struct pci_ecam_ops pci_thunder_pem_ops = {
 	.bus_shift	= 24,
-	.init		= thunder_pem_init,
+	.init		= thunder_pem_platform_init,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= thunder_pem_config_read,

