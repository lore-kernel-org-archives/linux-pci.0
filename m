Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966838AbdDSQts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 12:49:48 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tanmay Inamdar <tinamdar@apm.com>
Subject: [PATCH v4 16/21] PCI: xgene: update PCI config space remap function
Date: Wed, 19 Apr 2017 17:49:05 +0100
Message-Id: <20170419164913.19674-17-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 1a61087..de19898 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -248,7 +248,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 		dev_err(dev, "can't get CSR resource\n");
 		return ret;
 	}
-	port->csr_base = devm_ioremap_resource(dev, &csr);
+	port->csr_base = devm_pci_remap_cfg_resource(dev, &csr);
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
@@ -359,7 +359,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	port->csr_base = devm_ioremap_resource(dev, res);
+	port->csr_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
-- 
2.10.0
