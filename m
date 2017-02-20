Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v5 4/4] PCI: imx6: Allow probe deferal by reset GPIO
Date: Mon, 20 Feb 2017 07:30:25 -0800
Message-Id: <20170220153025.32096-5-andrew.smirnov@gmail.com>
In-Reply-To: <20170220153025.32096-1-andrew.smirnov@gmail.com>
References: <20170220153025.32096-1-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 yurovsky@gmail.com, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Some designs implement reset GPIO via a GPIO expander connected to a
peripheral bus. One such example would be i.MX7 Sabre board where said
GPIO is provided by SPI shift register connected to a bitbanged SPI
bus. In order to support such designs allow reset GPIO request to defer
probing of the driver.

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 071251f3..fe832e7f 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -638,8 +638,8 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
 
-static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
-				     struct platform_device *pdev)
+static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
+			      struct platform_device *pdev)
 {
 	struct pcie_port *pp = &imx6_pcie->pp;
 	struct device *dev = pp->dev;
@@ -674,7 +674,7 @@ static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
-static int __init imx6_pcie_probe(struct platform_device *pdev)
+static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct imx6_pcie *imx6_pcie;
@@ -693,10 +693,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
 
-	/* Added for PCI abort handling */
-	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
-		"imprecise external abort");
-
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pp->dbi_base))
@@ -716,6 +712,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to get reset gpio\n");
 			return ret;
 		}
+	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
+		return imx6_pcie->reset_gpio;
 	}
 
 	/* Fetch clocks */
@@ -828,11 +826,22 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
 	},
+	.probe    = imx6_pcie_probe,
 	.shutdown = imx6_pcie_shutdown,
 };
 
 static int __init imx6_pcie_init(void)
 {
-	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
+	/*
+	 * Since probe() can be deferred we need to make sure that
+	 * hook_fault_code is not called after __init memory is freed
+	 * by kernel and since imx6q_pcie_abort_handler() is a no-op
+	 * we can install the handler here without risking it
+	 * accessing some unitialized driver state
+	 */
+	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+
+	return platform_driver_register(&imx6_pcie_driver);
 }
 device_initcall(imx6_pcie_init);
-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
