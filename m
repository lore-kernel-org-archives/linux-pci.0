Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:56041 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753304AbaCFSBk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 13:01:40 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk,
	sergei.shtylyov@cogentembedded.com, magnus.damn@opensource.se,
	horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/9] pci-rcar-gen2: add devicetree support
Date: Thu,  6 Mar 2014 18:01:19 +0000
Message-Id: <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add OF match table for pci-rcar-gen2 driver for device tree support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Updates since v1:
	- moved documentation into patch
	- moved to using bus-range parsing
	- ensured usb phy can be linked to usb devices

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 .../bindings/pci/renessas,pci-rcar-gen2.txt        | 52 ++++++++++++++++++++++
 drivers/pci/host/pci-rcar-gen2.c                   | 33 +++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt

diff --git a/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt
new file mode 100644
index 0000000..bd6d291
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renessas,pci-rcar-gen2.txt
@@ -0,0 +1,52 @@
+Renesas AHB to PCI bridge
+-------------------------
+
+This is the bridge used internally to connect the USB controllers to the
+AHB. There is one bridge instance per USB port consiting of an internal
+OHCI and EHCI controller.
+
+Required properties:
+ - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC
+ - reg : A list of physical regions to access the device. The first is
+         the operational registers for the OHCI/EHCI controller and the
+	 second region is for the bridge configuration and control registers.
+ - interrupts : interrupt for the device
+ - clocks : The reference to the device clock
+ - bus-range: The PCI bus number ranges. As this is a single bus, the range
+		should be specified as the same value twice.
+
+
+Example SoC configuration:
+
+	pci0: pci@ee090000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee090000 0x0 0xc00>,
+		      <0x0 0xee080000 0x0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+Example board setup:
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+
+	pci@0,1 {
+		reg = <0x800 0 0 0 0>;
+		device_type = "pci";
+		usb-phy = <&usbphy>;
+	};
+
+	pci@0,2 {
+		reg = <0x1000 0 0 0 0>;
+		device_type = "pci";
+		usb-phy = <&usbphy>;
+	};
+};
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index fd3e3ab..1216784 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -98,6 +99,7 @@ struct rcar_pci_priv {
 	struct resource io_res;
 	struct resource mem_res;
 	struct resource *cfg_res;
+	unsigned busnr;
 	int irq;
 	unsigned long window_size;
 };
@@ -312,8 +314,8 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
 
-	/* Setup bus number based on platform device id */
-	sys->busnr = to_platform_device(priv->dev)->id;
+	/* Setup bus number based on platform device id / of bus-range */
+	sys->busnr = priv->busnr;
 	return 1;
 }
 
@@ -366,6 +368,23 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	priv->window_size = SZ_1G;
 
+	if (pdev->dev.of_node) {
+		struct resource busnr;
+		int ret;
+
+		ret = of_pci_parse_bus_range(pdev->dev.of_node, &busnr);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to parse bus-range\n");
+			return ret;
+		}
+		
+		priv->busnr = busnr.start;
+		if (busnr.end != busnr.start)
+			dev_warn(&pdev->dev, "only one bus number supported\n");
+	} else {
+		priv->busnr = pdev->id;
+	}
+
 	hw_private[0] = priv;
 	memset(&hw, 0, sizeof(hw));
 	hw.nr_controllers = ARRAY_SIZE(hw_private);
@@ -377,11 +396,21 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rcar_pci_of_match[] = {
+	{ .compatible = "renesas,pci-r8a7790", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
+#endif
+
 static struct platform_driver rcar_pci_driver = {
 	.driver = {
 		.name = "pci-rcar-gen2",
 		.owner = THIS_MODULE,
 		.suppress_bind_attrs = true,
+		.of_match_table = of_match_ptr(rcar_pci_of_match),
 	},
 	.probe = rcar_pci_probe,
 };
-- 
1.9.0

