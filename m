Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Aug 2017 11:16:03 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: dwc: dra7xx: fix error return code in
 dra7xx_pcie_probe()
Message-ID: <20170809161603.GA31297@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns an error code, but the pci-dra7xx driver
ignores it and always returns -EINVAL. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f4..f58e1b4 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -616,8 +616,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource\n");
-		return -EINVAL;
+		dev_err(dev, "missing IRQ resource: %d\n", irq);
+		return irq;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
-- 
2.5.0
