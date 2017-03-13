Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:64705 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbdCMNpY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2017 09:45:24 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <kishon@ti.com>, <nsekhar@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 7/7] PCI: dwc: dra7xx: Push request_irq call to the bottom of probe
Date: Mon, 13 Mar 2017 19:13:28 +0530
Message-ID: <20170313134328.1588-8-kishon@ti.com>
In-Reply-To: <20170313134328.1588-1-kishon@ti.com>
References: <20170313134328.1588-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Keerthy <j-keerthy@ti.com>

Currently devm_request_irq is being called before base, pci fields
of dra7xx_pcie structure are populated. It is called even before
pm_runtime_enable and pm_runtime_get_sync are called. This will
lead to exceptions if in case an interrupt is triggered before
the all of the above are done. Hence push the devm_request_irq
call to the end of the probe.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 07c45ec07662..7c9ed6a6675c 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -410,13 +410,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
-			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
-		return ret;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
 	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
 	if (!base)
@@ -478,6 +471,13 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_gpio;
 
+	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_gpio;
+	}
+
 	return 0;
 
 err_gpio:
-- 
2.11.0
