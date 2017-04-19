Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966889AbdDSQtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 12:49:52 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v4 18/21] PCI: hisi: update PCI config space remap function
Date: Wed, 19 Apr 2017 17:49:07 +0100
Message-Id: <20170419164913.19674-19-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/dwc/pcie-hisi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index fd66a31..1606de5 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -99,7 +99,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
@@ -296,10 +296,9 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, reg);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, reg);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
-
 	platform_set_drvdata(pdev, hisi_pcie);
 
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
@@ -360,7 +359,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 		return -EINVAL;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
-- 
2.10.0
