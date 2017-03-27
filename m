Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbdC0KB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 06:01:56 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 11/22] PCI: spear13xx: update PCI config space remap function
Date: Mon, 27 Mar 2017 10:49:39 +0100
Message-Id: <20170327094954.7162-12-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generate on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index eaa4ea8..0fe2b2b 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -273,7 +273,7 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	pci->dbi_base = devm_ioremap_nopost_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
 		ret = PTR_ERR(pci->dbi_base);
-- 
2.10.0
