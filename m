Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v2 7/7] PCI: dwc: dra7xx: Push request_irq call to the bottom
 of probe
Date: Tue, 7 Mar 2017 15:22:52 +0530
Message-ID: <1488880372-7390-8-git-send-email-kishon@ti.com>
In-Reply-To: <1488880372-7390-1-git-send-email-kishon@ti.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keerthy <j-keerthy@ti.com>, nsekhar@ti.com,
 Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
 drivers/pci/dwc/pci-dra7xx.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index c6fef0a..8c53233 100644
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
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
