Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: imx6: Allow probe deferal by reset GPIO
Date: Wed,  1 Feb 2017 08:55:58 -0800
Message-Id: <20170201165559.22436-3-andrew.smirnov@gmail.com>
In-Reply-To: <20170201165559.22436-1-andrew.smirnov@gmail.com>
References: <20170201165559.22436-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some designs implement reset GPIO via a GPIO expander connected to a
peripheral bus. One such example would be i.MX7 Sabre board where said
GPIO is provided by SPI shift register connected to a bitbanged SPI
bus. In order to support such designs allow reset GPIO request to defer
probing of the driver.

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 50a1291..3ef8093 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -611,7 +611,7 @@ static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
-static int __init imx6_pcie_probe(struct platform_device *pdev)
+static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct imx6_pcie *imx6_pcie;
@@ -653,6 +653,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to get reset gpio\n");
 			return ret;
 		}
+	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
+		return imx6_pcie->reset_gpio;
 	}
 
 	/* Fetch clocks */
@@ -746,11 +748,12 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
 	},
+	.probe    = imx6_pcie_probe,
 	.shutdown = imx6_pcie_shutdown,
 };
 
 static int __init imx6_pcie_init(void)
 {
-	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
+	return platform_driver_register(&imx6_pcie_driver);
 }
 device_initcall(imx6_pcie_init);
-- 
2.9.3
