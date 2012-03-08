Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65338 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab2CHOvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:49 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 05/11] tps6586x: Add device-tree support
Date: Thu,  8 Mar 2012 15:51:25 +0100
Message-Id: <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 .../devicetree/bindings/regulator/tps6586x.txt     |   98 ++++++++++++++++++++
 drivers/mfd/tps6586x.c                             |   66 +++++++++++++
 drivers/regulator/tps6586x-regulator.c             |    2 +-
 include/linux/mfd/tps6586x.h                       |    1 +
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt

diff --git a/Documentation/devicetree/bindings/regulator/tps6586x.txt b/Documentation/devicetree/bindings/regulator/tps6586x.txt
new file mode 100644
index 0000000..e8d2888
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/tps6586x.txt
@@ -0,0 +1,98 @@
+TPS6586x family of regulators
+
+Required properties:
+- compatible: "ti,tps6586x"
+- reg: I2C slave address
+- interrupts: the interrupt outputs of the controller
+- #gpio-cells: number of cells to describe a GPIO
+- gpio-controller: mark the device as a GPIO controller
+- regulators: list of regulators provided by this controller, must be in the
+  following order:
+    SM0, SM1, SM2, LDO0, LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8, LDO9
+
+Each regulator is defined using the standard binding for regulators.
+
+Example:
+
+	pmu: tps6586x@34 {
+		compatible = "ti,tps6586x";
+		reg = <0x34>;
+		interrupts = <0 88 0x4>;
+
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		regulators {
+			sm0_reg: sm0 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sm1_reg: sm1 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sm2_reg: sm2 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <4550000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo0_reg: ldo0 {
+				regulator-name = "PCIE CLK";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-min-microvolt = < 725000>;
+				regulator-max-microvolt = <1500000>;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <2475000>;
+			};
+
+			ldo5_reg: ldo5 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo6_reg: ldo6 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo7_reg: ldo7 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo8_reg: ldo8 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index a5ddf31..71997d2 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/regulator/of_regulator.h>
 
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6586x.h>
@@ -460,6 +461,7 @@ static int __devinit tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
+		pdev->dev.of_node = subdev->of_node;
 
 		ret = platform_device_add(pdev);
 		if (ret) {
@@ -474,6 +476,66 @@ failed:
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct tps6586x_platform_data *pdata;
+	struct tps6586x_subdev_info *devs;
+	struct device_node *regulators;
+	struct device_node *child;
+	unsigned int num = 0;
+
+	regulators = of_find_node_by_name(np, "regulators");
+
+	for_each_child_of_node(regulators, child)
+		num++;
+
+	devs = devm_kzalloc(&client->dev, num * sizeof(*devs), GFP_KERNEL);
+	if (!devs)
+		return NULL;
+
+	num = 0;
+
+	for_each_child_of_node(regulators, child) {
+		struct regulator_init_data *init_data;
+
+		init_data = of_get_regulator_init_data(&client->dev, child);
+		if (!init_data)
+			dev_err(&client->dev,
+				"failed to parse DT for regulator %s\n",
+				child->name);
+
+		devs[num].name = "tps6586x-regulator";
+		devs[num].platform_data = init_data;
+		devs[num].of_node = child;
+		devs[num].id = num;
+		num++;
+	}
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->num_subdevs = num;
+	pdata->subdevs = devs;
+	pdata->gpio_base = -1;
+	pdata->irq_base = -1;
+
+	return pdata;
+}
+
+static struct of_device_id tps6586x_of_match[] = {
+	{ .compatible = "ti,tps6586x", },
+	{ },
+};
+#else
+static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *client)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit tps6586x_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
@@ -481,6 +543,9 @@ static int __devinit tps6586x_i2c_probe(struct i2c_client *client,
 	struct tps6586x *tps6586x;
 	int ret;
 
+	if (!pdata && client->dev.of_node)
+		pdata = tps6586x_parse_dt(client);
+
 	if (!pdata) {
 		dev_err(&client->dev, "tps6586x requires platform data\n");
 		return -ENOTSUPP;
@@ -573,6 +638,7 @@ static struct i2c_driver tps6586x_driver = {
 	.driver	= {
 		.name	= "tps6586x",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(tps6586x_of_match),
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= __devexit_p(tps6586x_i2c_remove),
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 29b615c..f10a735 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -396,7 +396,7 @@ static int __devinit tps6586x_regulator_probe(struct platform_device *pdev)
 		return err;
 
 	rdev = regulator_register(&ri->desc, &pdev->dev,
-				  pdev->dev.platform_data, ri, NULL);
+				  pdev->dev.platform_data, ri, pdev->dev.of_node);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register regulator %s\n",
 				ri->desc.name);
diff --git a/include/linux/mfd/tps6586x.h b/include/linux/mfd/tps6586x.h
index b19176e..f350fd0 100644
--- a/include/linux/mfd/tps6586x.h
+++ b/include/linux/mfd/tps6586x.h
@@ -68,6 +68,7 @@ struct tps6586x_subdev_info {
 	int		id;
 	const char	*name;
 	void		*platform_data;
+	struct device_node *of_node;
 };
 
 struct tps6586x_platform_data {
-- 
1.7.9.3

