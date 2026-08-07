Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540F477295;
	Fri,  7 Aug 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106156; cv=fail; b=YExIXuXrc2zsMJY9+c2xKlMoZ/qoIejjVTAVXUQYJFuyVJp1/u4CGRUjUgCAVwoqf4yznxlGMsXcKGP4whGTaFu94mL8RfCdCX0+hPKClD++A+ivZVhuzvF7YNSanDXl7j/K3R5rCf+JAuVu9jG859CoKv2AqTl2oVYOzap+hZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106156; c=relaxed/simple;
	bh=vQ2Y8/k236CDnfd27LSSOuYB1pLttUsSBWN7iSa51eE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+yGiTw/4tKBxvtjA5W0bBGqldqgAgDOOJRPaEmXrQH6fdSXLvDepCBuZuFcsznjMVZ/b0/YiogvH6ggpm1CFJ7FzpHO3JOUCzYfowbvppfNU7kORFX9QYiZAsZE3hBGaUzxRnOlUrNq+9jXPw62eU6jxKYXJORl3onAJWRBpwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3IExzHxz; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3IExzHxz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB3OuGb0bUVSbRFhG9i6M1YeAQkW4E4EqA/hoel5YWkHCQE2jltWRe7ftdgr3dEvZWPsAKw9ronvie6/VVCI1VrGPztVUyE0D8xezgnC4CPWT1ATOmERPESOAmVqQa8fZkeuYXUYaibQ30QieyHX0hJJ5sj/rpdojPIUsAhdoIxuXQgLZknGGcHiZ3eT+RJUkvLNpQaO76fQN/U/KTt2zENvY23t141zOg7Ot3Yst1y3jj7CxhBO5akkVOPoJPHUmJqzP1saLKj6XCVN3XwZxi6qLC+muCg6mbqcnZAssM+01fTAk+dsnovhfaNRbVyLONdTVhL0pSQrSdtgiyE4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBPVi/kucQp+jHO2NoVbFmlDqBtPxI54G/sLz3Ht0rc=;
 b=eByiwoszQ4QoY1eM91d04xfwmmBELGWNahJxc6bBYVw4/FjqKgxSUsiC43rb6jLWAR9K6kc65d4BSsQvcvfU/XBbVZ7Wyh2lWPk53T8/5o2MHOXFDWwpDUaEfqLyGTvKBJO+x/0jbSgT37ow4OZIU6Us5th2Zt5PoF9GRM1OMucUIm+QnO2HGn+KiPrcqgIBQhB0C39WmjCX0p5mY7VCAxphqBLb83ZuWdGRklfYTHwAOfUrILv8kNzQ5PfLiWeXnnUHrzzbZvpPK5+sGnSB4M3qNpV9vNcXoz56IyJG+f4d6lZ43JEBV+dKMF6A/R9Vdw4gXD9yOQRvjWbVr0RtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBPVi/kucQp+jHO2NoVbFmlDqBtPxI54G/sLz3Ht0rc=;
 b=3IExzHxz70i2qjOsSNMfejZAPmwPh2aeVKZbgLRBLyafSQQnI2qjHdsJrFhO7mHbG4I0tOWOZc2/639zkKIADmkHZPIbLyUb6YhyptN3sl6uVPxv9DiErabbWvIMvnFoW+YKJFUMq04vGkiWZocmXCUUlCho+5zF7nOhm4ok1Gc=
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 12:35:31 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::38) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 12:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:35:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:35:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:35:27 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 07:35:23 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v8 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Fri, 7 Aug 2026 18:05:07 +0530
Message-ID: <20260807123507.3418671-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
References: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8adbad-8b34-4ef6-1186-08def4805eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xPgtpU+yuYFMRr0LbV0XBAMYRnDaXzZr5NjW50dqV2rBgvVHsAYr8xcL11PSOJ3cureN8no6oQ6wfKx/Gj9Vuw7jJCrJpctlgPLmk07R9/Mqhss0xnlQQ74GwE2yyAaSnRFd+ohXKRETJRd4DoljyiKVbLWWCtY0cB5jeo127gBX3GeqMzqN/k83GiYdv8wBPLAW/8aOlV4AwIXfRESfOHH37LxxCCbphZ4iK+LarYmigQ+rFTDLTuJYQ4H3J2gcaRwzYKLerHHDsLrsBHBsGzZZjp0LjiO4DoQHBoU6H4HhPylDODZbJ0QOByoYEY1zRC4sQnDd0tFWvhILr4DXzr//92GMSgcxsv6MqV1CnOiO/hXRybtJK1nWWrmD6AZx1uCilsfufmZjHxFpVU6aEzmSSCGNksh0Z/rIUtWmijYkC5s0HEmFcriSxgQWknW6QKQPZ1JskJDbiL4vfHxUB7fg7rzgl8qmy3vbTck3APzu3U31MvwRAZvMJukJRr2K3TGVRduayanY+Hd+m7E482lm72FCjCOEpQFZx0q8wGw5dRwIJgQ90Y08R/Ks8TPSS8p8W/+AqteV/jPv9vsXp6hBhTDSwuGcXh2YvvkU0HKG5j6fQ/Fw23j1gJaTrYFuq/DFOtLtbbeQmbH6o5ju5WlY4LTGcAktBB3I51+RMKgqwl+UUJ+QX2N1iq4GETGXxqWNAUIuMSG8ZugN3KBtzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OdSVS4Fa+rMfnGFfzvGf/fztpkSLQpRZm0ACAXwmuDLICb4HooASiUvHXy2eQ8cvKZ359LIsmVs8ykr5/oTPGmb7VMcxdmPJwWE9IHmRkDe46hQRsJeefi/Bhgv/xjNJjEbQ6c32XEP+hdB9w8tS/fQJ/qtlmwbJoL8rb3t7JqR6OEB8eX/cHbEa89vIxCiowQ9wxIiKd9rxI2of7H+B7MSQcYJURwPC9NIkaUvJ+eSERqpgMHt21P/A3nMxEXDOpoNwndP3IxexdqoNWAjKVEfAJ8EEMIk2YeuCqbU4XXSMGTC0CO//jvXWk3UILcGJCaziKP1hCXrkFbaBkk/VNEPJY5zHGg4rhBVdLn+M5Uyr7qb01CRztRd4WM0WzuGtebx2bax+pKQFQgLtKguC7adJ920ZeCgncJfABR5Zx4cKGzKrkfNzX0FOm44ML566
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:35:31.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8adbad-8b34-4ef6-1186-08def4805eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Add support for the PCIe Root Port PERST# signal using the GPIO
framework, along with the PCIe IP reset. This reset is managed
by the driver and occurs after the Initial Power Up sequence
(PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's
probe function is called.

This is useful in warm reset scenarios where the power rails stay stable
and only PERST# is toggled. Applying both the IP reset and PERST# resets
the Root Port controller and Endpoint synchronously, improving
reliability and avoiding lane errors.

Both the reset GPIO and the reset controller are optional to keep
backward compatibility with existing DTBs. Also add a PCIE_T_PERST_US
(100 us) macro in pci.h for the PERST# active time (PCIe CEM r6.0,
sec 2.11.2, "T_PERST").

As part of this, update the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child(), since the PCIe
host bridge node now has multiple children. This ensures the correct
node is selected during initialization.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v8:
- Use resets framework for handling PCIe IP reset.
- Update source to parse reset-gpios from child node.
- Update PCIE_T_PERST_US macro in pci.h
- Remove PERST# support for CPM5NC.

v1: https://lore.kernel.org/all/20250224063046.1438006-3-sai.krishna.musham@amd.com/
v2: https://lore.kernel.org/all/20250226124358.88227-3-sai.krishna.musham@amd.com/
v3: https://lore.kernel.org/all/20250227042454.907182-3-sai.krishna.musham@amd.com/
v4: https://lore.kernel.org/all/20250318092648.2298280-3-sai.krishna.musham@amd.com/
v5: https://lore.kernel.org/all/20250321114211.2185782-3-sai.krishna.musham@amd.com/
v6: https://lore.kernel.org/all/20250326022811.3090688-3-sai.krishna.musham@amd.com/
v7: https://lore.kernel.org/all/20250414032304.862779-3-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 78 +++++++++++++++++++++++-
 drivers/pci/pci.h                        |  9 +++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d38f27e20761..040d37643991 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -16,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/reset.h>
 
 #include "../pci.h"
 #include "pcie-xilinx-common.h"
@@ -113,6 +116,8 @@ struct xilinx_cpm_variant {
  * @irq: Error interrupt number
  * @lock: lock protecting shared register access
  * @variant: CPM version check pointer
+ * @perst_gpio: GPIO descriptor for PERST# signal handling
+ * @rstc: Pointer to the PCIe controller reset
  */
 struct xilinx_cpm_pcie {
 	struct device			*dev;
@@ -125,6 +130,8 @@ struct xilinx_cpm_pcie {
 	int				irq;
 	raw_spinlock_t			lock;
 	const struct xilinx_cpm_variant   *variant;
+	struct gpio_desc		*perst_gpio;
+	struct reset_control		*rstc;
 };
 
 static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg)
@@ -389,7 +396,7 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
 	struct device_node *pcie_intc_node;
 
 	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -EINVAL;
@@ -469,6 +476,22 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
 	return 0;
 }
 
+/**
+ * xilinx_cpm_pcie_reset - Reset the PCIe controller and deassert PERST#
+ * @port: PCIe port information
+ *
+ * Reset the PCIe controller and then release the PERST# signal so that the
+ * link can train once the bridge is enabled.
+ */
+static void xilinx_cpm_pcie_reset(struct xilinx_cpm_pcie *port)
+{
+	reset_control_assert(port->rstc);
+	udelay(PCIE_T_PERST_US);
+	reset_control_deassert(port->rstc);
+	gpiod_set_value_cansleep(port->perst_gpio, 0);
+	mdelay(PCIE_RESET_CONFIG_WAIT_MS);
+}
+
 /**
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
@@ -480,6 +503,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	if (variant->version == CPM5NC_HOST)
 		return;
 
+	if (port->perst_gpio && port->rstc)
+		xilinx_cpm_pcie_reset(port);
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -512,6 +538,43 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 		   XILINX_CPM_PCIE_REG_RPSC);
 }
 
+/**
+ * xilinx_cpm_pcie_parse_port - Parse the PCIe Root Port child node
+ * @port: PCIe port information
+ *
+ * Read the PERST# GPIO from the Root Port child node.
+ *
+ * Return: '0' on success and error value on failure
+ */
+static int xilinx_cpm_pcie_parse_port(struct xilinx_cpm_pcie *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *pcie_port_node __maybe_unused;
+
+	/*
+	 * This platform currently supports only one Root Port, so the loop
+	 * will execute only once.
+	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
+	 */
+	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie") {
+		port->perst_gpio = devm_fwnode_gpiod_get(dev,
+							 of_fwnode_handle(pcie_port_node),
+							 "reset", GPIOD_OUT_HIGH,
+							 NULL);
+		if (IS_ERR(port->perst_gpio)) {
+			if (PTR_ERR(port->perst_gpio) == -ENOENT) {
+				port->perst_gpio = NULL;
+				return 0;
+			}
+			return dev_err_probe(dev, PTR_ERR(port->perst_gpio),
+					     "Failed to request reset GPIO\n");
+		}
+		return 0;
+	}
+
+	return 0;
+}
+
 /**
  * xilinx_cpm_pcie_parse_dt - Parse Device tree
  * @port: PCIe port information
@@ -525,6 +588,19 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
+	int ret;
+
+	/* CPM5NC does not support PERST# handling yet */
+	if (port->variant->version != CPM5NC_HOST) {
+		port->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+		if (IS_ERR(port->rstc))
+			return dev_err_probe(dev, PTR_ERR(port->rstc),
+					     "Failed to request reset\n");
+
+		ret = xilinx_cpm_pcie_parse_port(port);
+		if (ret)
+			return ret;
+	}
 
 	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
 							       "cpm_slcr");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..bf53354dc5a9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,6 +39,15 @@ struct pcie_tlp_log;
  */
 #define PCIE_T_PERST_CLK_US		100
 
+/*
+ * PERST# active time.
+ *
+ * See the "Power Sequencing and Reset Signal Timings" table of the PCI Express
+ * Card Electromechanical Specification, Revision 6.0, Section 2.11.2, Symbol
+ * "T_PERST".
+ */
+#define PCIE_T_PERST_US			100
+
 /*
  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
  * Recommends 1ms to 10ms timeout to check L2 ready.
-- 
2.44.4

