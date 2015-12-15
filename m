Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <kishon@ti.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <tony@atomide.com>, <t-kristo@ti.com>
Subject: [PATCH v3 9/9] phy: omap-usb2: use *syscon* framework API to power on/off the PHY
Date: Tue, 15 Dec 2015 14:46:08 +0530
Message-ID: <1450170968-11282-10-git-send-email-kishon@ti.com>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate using phy-omap-control driver to power on/off the PHY,
and use *syscon* framework to do the same. This handles
powering on/off the PHY for the USB2 PHYs used in various TI SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt |    8 +-
 drivers/phy/phy-omap-usb2.c                      |   94 ++++++++++++++++++----
 include/linux/phy/omap_usb.h                     |   23 ++++++
 3 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 49e5b0c..a3b3945 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -31,6 +31,8 @@ OMAP USB2 PHY
 
 Required properties:
  - compatible: Should be "ti,omap-usb2"
+	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
+	       in DRA7x
  - reg : Address and length of the register set for the device.
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
@@ -40,10 +42,14 @@ Required properties:
    * "wkupclk" - wakeup clock.
    * "refclk" - reference clock (optional).
 
-Optional properties:
+Deprecated properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
    the PHY.
 
+Recommended properies:
+- syscon-phy-power : phandle/offset pair. Phandle to the system control
+  module and the register offset to power on/off the PHY.
+
 This is usually a subnode of ocp2scp to which it is connected.
 
 usb2phy@4a0ad080 {
diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index c79633e..c9c04ff 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -29,6 +29,8 @@
 #include <linux/delay.h>
 #include <linux/phy/omap_control_phy.h>
 #include <linux/phy/phy.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/of_platform.h>
 
 #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
@@ -97,22 +99,40 @@ static int omap_usb_set_peripheral(struct usb_otg *otg,
 	return 0;
 }
 
-static int omap_usb_power_off(struct phy *x)
+static int omap_usb_phy_power(struct omap_usb *phy, int on)
 {
-	struct omap_usb *phy = phy_get_drvdata(x);
+	u32 val;
+	int ret;
 
-	omap_control_phy_power(phy->control_dev, 0);
+	if (phy->syscon_phy_power) {
+		if (on)
+			val = phy->power_on;
+		else
+			val = phy->power_off;
+
+		ret = regmap_update_bits(phy->syscon_phy_power, phy->power_reg,
+					 phy->mask, val);
+		if (ret < 0)
+			return ret;
+	} else {
+		omap_control_phy_power(phy->control_dev, on);
+	}
 
 	return 0;
 }
 
-static int omap_usb_power_on(struct phy *x)
+static int omap_usb_power_off(struct phy *x)
 {
 	struct omap_usb *phy = phy_get_drvdata(x);
 
-	omap_control_phy_power(phy->control_dev, 1);
+	return omap_usb_phy_power(phy, false);
+}
 
-	return 0;
+static int omap_usb_power_on(struct phy *x)
+{
+	struct omap_usb *phy = phy_get_drvdata(x);
+
+	return omap_usb_phy_power(phy, true);
 }
 
 static int omap_usb_init(struct phy *x)
@@ -147,21 +167,38 @@ static const struct phy_ops ops = {
 static const struct usb_phy_data omap_usb2_data = {
 	.label = "omap_usb2",
 	.flags = OMAP_USB2_HAS_START_SRP | OMAP_USB2_HAS_SET_VBUS,
+	.mask = OMAP_DEV_PHY_PD,
+	.power_off = OMAP_DEV_PHY_PD,
 };
 
 static const struct usb_phy_data omap5_usb2_data = {
 	.label = "omap5_usb2",
 	.flags = 0,
+	.mask = OMAP_DEV_PHY_PD,
+	.power_off = OMAP_DEV_PHY_PD,
 };
 
 static const struct usb_phy_data dra7x_usb2_data = {
 	.label = "dra7x_usb2",
 	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
+	.mask = OMAP_DEV_PHY_PD,
+	.power_off = OMAP_DEV_PHY_PD,
+};
+
+static const struct usb_phy_data dra7x_usb2_phy2_data = {
+	.label = "dra7x_usb2_phy2",
+	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
+	.mask = OMAP_USB2_PHY_PD,
+	.power_off = OMAP_USB2_PHY_PD,
 };
 
 static const struct usb_phy_data am437x_usb2_data = {
 	.label = "am437x_usb2",
 	.flags =  0,
+	.mask = AM437X_USB2_PHY_PD | AM437X_USB2_OTG_PD |
+		AM437X_USB2_OTGVDET_EN | AM437X_USB2_OTGSESSEND_EN,
+	.power_on = AM437X_USB2_OTGVDET_EN | AM437X_USB2_OTGSESSEND_EN,
+	.power_off = AM437X_USB2_PHY_PD | AM437X_USB2_OTG_PD,
 };
 
 static const struct of_device_id omap_usb2_id_table[] = {
@@ -178,6 +215,10 @@ static const struct of_device_id omap_usb2_id_table[] = {
 		.data = &dra7x_usb2_data,
 	},
 	{
+		.compatible = "ti,dra7x-usb2-phy2",
+		.data = &dra7x_usb2_phy2_data,
+	},
+	{
 		.compatible = "ti,am437x-usb2",
 		.data = &am437x_usb2_data,
 	},
@@ -219,6 +260,9 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy->phy.label		= phy_data->label;
 	phy->phy.otg		= otg;
 	phy->phy.type		= USB_PHY_TYPE_USB2;
+	phy->mask		= phy_data->mask;
+	phy->power_on		= phy_data->power_on;
+	phy->power_off		= phy_data->power_off;
 
 	if (phy_data->flags & OMAP_USB2_CALIBRATE_FALSE_DISCONNECT) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -228,20 +272,36 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		phy->flags |= OMAP_USB2_CALIBRATE_FALSE_DISCONNECT;
 	}
 
-	control_node = of_parse_phandle(node, "ctrl-module", 0);
-	if (!control_node) {
-		dev_err(&pdev->dev, "Failed to get control device phandle\n");
-		return -EINVAL;
-	}
+	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
+							"syscon-phy-power");
+	if (IS_ERR(phy->syscon_phy_power)) {
+		dev_dbg(&pdev->dev,
+			"can't get syscon-phy-power, using control device\n");
+		phy->syscon_phy_power = NULL;
+
+		control_node = of_parse_phandle(node, "ctrl-module", 0);
+		if (!control_node) {
+			dev_err(&pdev->dev,
+				"Failed to get control device phandle\n");
+			return -EINVAL;
+		}
 
-	control_pdev = of_find_device_by_node(control_node);
-	if (!control_pdev) {
-		dev_err(&pdev->dev, "Failed to get control device\n");
-		return -EINVAL;
+		control_pdev = of_find_device_by_node(control_node);
+		if (!control_pdev) {
+			dev_err(&pdev->dev, "Failed to get control device\n");
+			return -EINVAL;
+		}
+		phy->control_dev = &control_pdev->dev;
+	} else {
+		if (of_property_read_u32_index(node,
+					       "syscon-phy-power", 1,
+					       &phy->power_reg)) {
+			dev_err(&pdev->dev,
+				"couldn't get power reg. offset\n");
+			return -EINVAL;
+		}
 	}
 
-	phy->control_dev = &control_pdev->dev;
-
 	otg->set_host		= omap_usb_set_host;
 	otg->set_peripheral	= omap_usb_set_peripheral;
 	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
diff --git a/include/linux/phy/omap_usb.h b/include/linux/phy/omap_usb.h
index dc2c541..2e5fb87 100644
--- a/include/linux/phy/omap_usb.h
+++ b/include/linux/phy/omap_usb.h
@@ -30,6 +30,12 @@ struct usb_dpll_params {
 	u32	mf;
 };
 
+enum omap_usb_phy_type {
+	TYPE_USB2,    /* USB2_PHY, power down in CONTROL_DEV_CONF */
+	TYPE_DRA7USB2, /* USB2 PHY, power and power_aux e.g. DRA7 */
+	TYPE_AM437USB2, /* USB2 PHY, power e.g. AM437x */
+};
+
 struct omap_usb {
 	struct usb_phy		phy;
 	struct phy_companion	*comparator;
@@ -40,11 +46,20 @@ struct omap_usb {
 	struct clk		*wkupclk;
 	struct clk		*optclk;
 	u8			flags;
+	enum omap_usb_phy_type	type;
+	struct regmap		*syscon_phy_power; /* ctrl. reg. acces */
+	unsigned int		power_reg; /* power reg. index within syscon */
+	u32			mask;
+	u32			power_on;
+	u32			power_off;
 };
 
 struct usb_phy_data {
 	const char *label;
 	u8 flags;
+	u32 mask;
+	u32 power_on;
+	u32 power_off;
 };
 
 /* Driver Flags */
@@ -52,6 +67,14 @@ struct usb_phy_data {
 #define OMAP_USB2_HAS_SET_VBUS (1 << 1)
 #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT (1 << 2)
 
+#define OMAP_DEV_PHY_PD		BIT(0)
+#define OMAP_USB2_PHY_PD	BIT(28)
+
+#define AM437X_USB2_PHY_PD		BIT(0)
+#define AM437X_USB2_OTG_PD		BIT(1)
+#define AM437X_USB2_OTGVDET_EN		BIT(19)
+#define AM437X_USB2_OTGSESSEND_EN	BIT(20)
+
 #define	phy_to_omapusb(x)	container_of((x), struct omap_usb, phy)
 
 #if defined(CONFIG_OMAP_USB2) || defined(CONFIG_OMAP_USB2_MODULE)
-- 
1.7.9.5

