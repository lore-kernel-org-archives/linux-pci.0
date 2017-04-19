Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966830AbdDSQtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 12:49:36 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH v4 12/21] PCI: qcom: update PCI config space remap function
Date: Wed, 19 Apr 2017 17:49:01 +0100
Message-Id: <20170419164913.19674-13-lorenzo.pieralisi@arm.com>
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
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 drivers/pci/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 67eb7f5..5bf23d4 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -700,7 +700,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->parf);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, res);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-- 
2.10.0
