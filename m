Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbcLEXZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:25:46 -0500
Subject: [PATCH v11 03/15] arm64: PCI: Add local struct device pointers
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:25:42 -0600
Message-ID: <20161205232542.3957.55360.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use a local "struct device *dev" for brevity.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index acf3872..8183c98 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -121,6 +121,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 static struct pci_config_window *
 pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 {
+	struct device *dev = &root->device->dev;
 	struct resource *bus_res = &root->secondary;
 	u16 seg = root->segment;
 	struct pci_config_window *cfg;
@@ -132,8 +133,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 		root->mcfg_addr = pci_mcfg_lookup(seg, bus_res);
 
 	if (!root->mcfg_addr) {
-		dev_err(&root->device->dev, "%04x:%pR ECAM region not found\n",
-			seg, bus_res);
+		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
 		return NULL;
 	}
 
@@ -141,11 +141,10 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
 	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
 	cfgres.flags = IORESOURCE_MEM;
-	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
-			      &pci_generic_ecam_ops);
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, &pci_generic_ecam_ops);
 	if (IS_ERR(cfg)) {
-		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
-			seg, bus_res, PTR_ERR(cfg));
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
+			PTR_ERR(cfg));
 		return NULL;
 	}
 

