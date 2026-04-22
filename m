Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE5265CD9;
	Wed, 22 Apr 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850479; cv=fail; b=R9tQt02DhTK6+tefmK446hTmeYAwpQSvmGGOrIz9qypXAOFWoL387kzATeSeRC5QoPSWIs9OjrAay2+etT/s4y4gA7b33xROvTCtThpE+ICqtc3Z3hrE3cjuhPX3NS63Bt53iaZlBPY07RrlEOg/V0+6nB7T9U/kxvpLZOIyqqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850479; c=relaxed/simple;
	bh=Wezvh6A5KkIFNDoTAlD/chkTW63dL+BUpBTeily3cSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMzYwQm7krXYedJ/f4cbK1qisqpZpNUp25mYWGswBa9VPBR0DXO5F0iCeR0ZwXHUPuuMz7E4/Ik9Om0cDavm5AuQk6yxX7AY2/xCcQHdLXTfpRRNbBFDqYTgddQLYbu9QjJodlh1fUCiZls6KJ888F8nLtpCRghkAFlAUh4sqzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VXwow4bK; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VXwow4bK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu32+Pg4O0wxWuU+MlOoWkupUi1ymJmKH30gL4dHPVUQizsh52LFj1G2BOpz4ZvwvRXMAG4qb6z/4ZzwimvEfYfQid0pCsOUgZ2sEXBv3oPPyZlmxUueNQ6tIWEdmT+iLHhcQae4WXbcieLU+1wue1jWD1RA76iXkBuqe3r8n2EqSMzc4yrlrHS2nEfRfZkx434L3TO8p+va7NUD3I62d93omKEyE78Perb5BMMDV3zbCQzq0rO9uWewS8oh/XYUuY+f3i0xCLUJG/dDb6rIgbTyGrDx2OMQbmMbH9HS/w7sgfpJE2QgsMnKBR4auFR2fRh1vqYq6jRe/f6RjTCYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZVi4L8PvAXbEdK+ENZyyvTMsx60JdnaMIThCIlreDo=;
 b=svNgFSYYDxiYv93ZcY4w6Fjy0/W6cpcjpb7B8SRPIEs7TxtM3WZEKB8QLcf7k1+kU35ryLtHFgNDD9dTHblO24IMI+3+/O5kjUc2R4I9QgtU607dE8Hj//Nk6tlG3xqrZi3iYBpxASVpjCF447dwIyfolb/epxle7xRW5GxUBtBsi/f6Mh9Ja03t/rM1Kfr5I2I8mtWu/508hFAMQNLIvQE/2rzJYE9DcS5y1Pk4oX6zBsSkc1Nc/zup/Sj2a3HeWW9wxZO9Jnlxm+sJCE3DnPcGx90u4iBdaAVljEO5Rajb/sHka84KzHrbGP8BeVc6dzqecRlp84Lc2hHmDqUSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZVi4L8PvAXbEdK+ENZyyvTMsx60JdnaMIThCIlreDo=;
 b=VXwow4bKJvnQdICm6G5Kgx8N5U7ZIj8qgBrbKigOIOMxXsWsO/4qW/Uv0LLwoyut+sYKMu34c9+vK3eoLE3ImV5uvepArEWdGjXF9kB2hCLksjOp12LLva5iaREE/lUFYaCOFiJQPdLgLSj4jNCBkIlemmOUiFukZJzNg4aXyz5GtgXzG2AHOJngEeOSLx8EzP7Jg1svC/3BiYTv/E9I888Y4oggNCt0gPRPX8b9Gd0phy8ipB4+qm9FnO67qbj9rMJz4yRdSjuxntEdyor36SO2476kAm5fCa/6crfRSJzGLto770LjBBlJPg0iMJNnVoVBMZllThvGaEpz8tLcPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:34 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:34 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V14 04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Wed, 22 Apr 2026 17:35:41 +0800
Message-Id: <20260422093549.407022-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: 508904dd-4a38-43bb-4fb5-08dea0525cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	x+JoQz+HQijkJLrQIAKs8vFB1muC+E/ZfeCK68uYu1gZb9pXwKRFjChE4DEOD57v6S51S3W7oKN8ySZpcR5Ouu0AEdd6KKiYGzdh6WR4MkYhm3+kxoStA8/41xUVBEzs8kuh/SiDKiKmt1+JvFvanyGgRu4FFb5FL/mn3iA37nyz7JLqR3jvcJfi2mtUzn0HFm5EJCDjqkthiIzsUKd8BMpsao7/9ApNG8mcQeExtAm/DAzgczmI/ndMbmIlgmHpHt6p12JsnymoHZsUyc5E+U8i7VqCbFuKdr4irzxf2ZM+rTTYu1ZaCQwpgkWdtj2DgxlSvjwj/KCALUoMHoJTxLPDMbR9jHLixd+NHNmuf2vbtgU1tbr6a0xnylJjJca/+4uj0WqhbkWJcNTpAK2RPzwXOeCaNYXt7w/4PZYiPdFB8/FAdttiK5ufmw2OWknQiDpfWdEAC6qLJ1T0nZtL1D/PceYwybKE9p1x8smVTgLPC6GlHA/5WdvEyFrFyLoZHWGpOIu+0RXTrQScvMleykv0zdsBIK/4hhtfCa3Rl/cdErCQyaNbyFnqxndiRsm3C+aDALNJ4pE3LjtKQGkNNMRXG+aG4yR90zzO0W7jfGn1MnNDbcsWgfL7We946s7o0LlTGchaaqbe5+19Tr7urvTtlHEamdFgpxWyyWntYqi67csQqaBkARbcmByOj8yBNuOJjK8yJ8cwFdSOYU+OV7xqU9XVRYAlPJPteHzEQcOV1xuVmQQApgBvhdWcznzafIKyf95rx7JHSS+fAJtLDf+Vx6ICrLHcWBKZRIkWON1Djj7x3zwOMy2yiHSxwQ9r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txLfvVBTkEG8qwIkwybwKKqKMYfx425TpyL9HFtgD8a+u5JUSYu+zilVhYtS?=
 =?us-ascii?Q?THsmzDYHWmS5B6uEJ3SqZtaaIJV1zlAcQFCmdf18dQN0EoN5B1GeEucCz00M?=
 =?us-ascii?Q?2PWwTaqQCB69CSz1gLJCr9C2L/5tSBPxmC1mfIwa3kZVAx10AY+vSomh2AXL?=
 =?us-ascii?Q?WiqbF0dj2xURdJu+QvuYnxUvXYyXT+6L+Z/kGZVyvwOmy52jyRyBlC1nupHu?=
 =?us-ascii?Q?5Cs35H9l7P1TUH+4I7T1T/jDKy7vkKGmeZt6h3RwJSyCrGiidZfHccTjjWwF?=
 =?us-ascii?Q?OCG8GGIYLlanuTjLC0mfXWUdZdbi1J2P1nDZ9yq05fmJo0HyY+8u2sSe/jIk?=
 =?us-ascii?Q?SKRlyOWcACV55LWZsurP9lAoCKfGMc/HJ1dhuEskMH1LsX2z61kB2axt62Yw?=
 =?us-ascii?Q?iWLEMS2YrzG1VrwQswez9Owv0AaE/BBNaSRDSdQtthvf2BymjbiJOxws4jIs?=
 =?us-ascii?Q?8aA9REUNohRCzXvWiY1OOYcB7QeZpysEWKaDpT/wl6KIHu1iNWnEm7DvySTj?=
 =?us-ascii?Q?LhY0Bs8fE22N+RLvHjjyiX7ACPhjTC59fcTXGCWdNC5WVrDzmAKFssUr16ia?=
 =?us-ascii?Q?Uis64jQDj4frRpA4sARlnVMHH5h4qQYIAflFDf62LLsl1l2tezlQHJf0H4ia?=
 =?us-ascii?Q?Maw5GQpWjH8Tk+mqjAqxc+e8UWTSFnP+7JZrdzw3HTO3SSb4QvvrFpqBaPph?=
 =?us-ascii?Q?m5vD7kawCp2b48pWWMxQCH04i6isHoHrPr470N7rsYXkpqEXTz91b9/8WsVg?=
 =?us-ascii?Q?bwYiRERZ6++fIxB/5TsXvq7XR/aUyV2xSlyABknv5fdNg2zmnPUQOACF6Z+6?=
 =?us-ascii?Q?IpNbpg/Jhs7AjA6cnktzzVLjc7ZwiYvIXZWcS3TRVPpodKJ4aIEOincLemBv?=
 =?us-ascii?Q?8Q0XE1Ujy28JGOggk73b69Xr0GYxfzSKbACOkAVofAANUOBMt1A7G2JzQc7c?=
 =?us-ascii?Q?AoN2uvdkGIaNUb9f18iZbIjv8e2W3fOZqeT4slmX+Lgr8X2M13nr0mkKhJIv?=
 =?us-ascii?Q?s76R7yPcUijRo9xT181lWompCzmuF6uu5G8HrRMJz3UTbH0glTnwggjT/7JV?=
 =?us-ascii?Q?n2oeCZx/P7+WAy612REocNmmh+DgtTwR4DGXRHCwFGtnishNuiRpoyqVxucH?=
 =?us-ascii?Q?rO3DsSEgt7HjHCzmgWUK6dEYGv2rg6v68/VF5Z6TcTUQOzh9lm+KJEBhCDAK?=
 =?us-ascii?Q?mmT3oHPeLfmm8ZDB8M2tYTvOc0Rt4D2LafS1n8SQQ+e7umO+PRkzyF7uzul1?=
 =?us-ascii?Q?lCQKK7LMdPFndd+XTEWV8xgq+hfOLXtuAJlm9BFWEdB4OKXlN6yRv+LHxIUa?=
 =?us-ascii?Q?kNrP00h4InIwBqaZWEcyEt1OuMgD4BNim2YRBtXNsdKED3ICYAD44p2x3XXv?=
 =?us-ascii?Q?q9GknetBVExwKtjB1koG/WuEbMpZs9aGy+ALNavPkTjn8BlxNacTyebSSiLX?=
 =?us-ascii?Q?E1zhnnSp5fvCzcWVX1FzS4p7a3RI6kkGeINPHfO2TN0FaCVh6CZyJovnwvxU?=
 =?us-ascii?Q?EH//NB25jRBV7VU3sQcTox9O8ZrgcMYHXHSUo/upyCQ8p6Jl2lCJHymomQS6?=
 =?us-ascii?Q?i6l+lffvZjRoqJ5F9C2rmnT4qMdG98QBWDN2NzTTUqiNfjr0ebjtgPzV1zN6?=
 =?us-ascii?Q?H6hdY6UlBBVtVgMUEXBM4n2LQj3kKH25GVTft0caSlxRzdWnYLtPZ0YdYMRK?=
 =?us-ascii?Q?ZzzxwfCfnGr/2ZWAh2KKngmMKTe4Px1W6F9w5To8HEZ4JhkQFkuYdYhvWisK?=
 =?us-ascii?Q?4xA4TxZwig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508904dd-4a38-43bb-4fb5-08dea0525cf9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:34.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoBoFTvEK1xDqUVIBYP2XAertD412FNPNy7HrtH+rz5IBIjj8tLr/pERogNo08ihEkFQ5gIQ1ZXP1ttovGB7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

Add support for parsing 'reset-gpios' from Root Port nodes and the PCIe
bridge nodes under the Root Port using the common helper
pci_host_common_parse_ports(), and update the reset GPIO handling to use
the parsed port list from bridge->ports. To maintain DT backwards
compatibility, fallback to the legacy method of parsing the host bridge
node if the reset property is not present in the Root Port nodes.

Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be in
input mode, using gpiod_direction_output() instead of
gpiod_set_value_cansleep() to ensure the reset GPIO is properly
configured as output before setting its value.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 83 ++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 735127ed1455..a2742620279a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -152,7 +153,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -1224,6 +1224,41 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
+	struct pci_host_perst *perst;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	if (!reset)
+		return 0;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&port->perst);
+	perst->desc = reset;
+	INIT_LIST_HEAD(&perst->list);
+	list_add_tail(&perst->list, &port->perst);
+
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &bridge->ports);
+
+	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+					&bridge->ports);
+}
+
 static void imx_pcie_vpcie_aux_disable(void *data)
 {
 	struct regulator *vpcie_aux = data;
@@ -1233,14 +1268,26 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_perst *perst;
+	struct pci_host_port *port;
+
+	if (!bridge || list_empty(&bridge->ports))
+		return;
+
 	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+		list_for_each_entry(port, &bridge->ports, list) {
+			list_for_each_entry(perst, &port->perst, list)
+				gpiod_direction_output(perst->desc, 1);
+		}
 	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+		mdelay(PCIE_T_PVPERL_MS);
+		list_for_each_entry(port, &bridge->ports, list) {
+			list_for_each_entry(perst, &port->perst, list)
+				gpiod_direction_output(perst->desc, 0);
 		}
+		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
 	}
 }
 
@@ -1249,8 +1296,25 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	struct pci_host_bridge *bridge = pp->bridge;
 	int ret;
 
+	if (bridge && list_empty(&bridge->ports)) {
+		/* Parse Root Port nodes if present */
+		ret = pci_host_common_parse_ports(dev, bridge);
+		if (ret) {
+			if (ret != -ENODEV) {
+				dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+				return ret;
+			}
+
+			/* Fallback to legacy binding for DT backwards compatibility */
+			ret = imx_pcie_parse_legacy_binding(imx_pcie);
+			if (ret)
+				return ret;
+		}
+	}
+
 	imx_pcie_assert_perst(imx_pcie, true);
 
 	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
@@ -1704,13 +1768,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
-
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
 	if (imx_pcie->num_clks < 0)
-- 
2.37.1

