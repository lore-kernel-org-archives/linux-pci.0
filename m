Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7232C375A;
	Wed, 18 Mar 2026 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815322; cv=fail; b=JGYknM+EsqYU0YI2mNJMFA0DwuiWbBeqWq/2dXIGOYI3pgrmQGU39sZvf+ySGZTmaEEmow0rD2wrKHOqqqEqAvlXsWwAvgnRAkh6g1Yd8TUzxCQ7+dyK1YMCPAHNU4Acofb/pQA8+bG5ZbeIYe9T2ZLBSDGuw740G60JzKTbrXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815322; c=relaxed/simple;
	bh=VIxfKygiEpP43bf0JaJwwFnEcHf2uj8p0i/PvLIeplg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeF+16s5DXhppiBLH7EZmNqCcCyIF50YbMZLxk/fAPvjaq72JD6DzgH6x0vMi1GXtfelMKzUKyoPksfTq9Dm3SNDeCcrkIjTGBHZgcIH1pUDVN9Hpc08jV/seCBJ84V7ce/ZyUI1MnTbYtvoD9ikL5w8iGzo7T4eyaDp8RNYMo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z9JWUoIY; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9JWUoIY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLu0BG7+pGcJQ+ooPp74EXDMAxWHgGf7wny7zuKOHh8k9V5phmomZuvga9+f19PbZWEAr1HhGmlU+QMQnrEEDtz0+lFycKC5Vz+fLdgCT8W5XAKNLsGU4e7LYv1qd3780x2oW/4m71OmOihkmIJNSvo3ccFzi27HvcMD+fhCD8499ICKhaJSEf9draQJCgg1Dn83sBL7GZliufUasrk6Pinbh+pC50JWJPv6bCdPfy6LREh2OPtmqXiqBQ9/X+0G7rA0qJmz8LCteS3bjY5WZUocK5TRa8C55Ud59sJ+IaSiuLsJu2clLcOjMGKS3heCvOA5UWc0qc2F94hmN7uEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6i1MpSg6e/dngRzKh0JehvKqzkHtmHPoR8skcfEkMA=;
 b=bEX0kKs3YfKJDOYAnnuXpWJm+2KRWp0fH9bNx2guJs9GPdWNgsxKo5NNY4B7TakTfPiV1pJ2ZFqUqfm/8NaTC+UOCi8XA1lLn8bBV0ewtT8cpuFGRHnKGqIW7vY313JZJ9MBPOFZW0bXFNIZKngIkRvEKwVhk68fiYaCm/NtPh7dA0WnAunP5xnAYohTi0FUeuEGJY7ddLeGocq5H2FmR/nC7hE/SxxF/gjWqjp3khW3WQJjsTghzChs6237JcdHHZGoUNva23PycCGPT7pMk50P9gKlrlLQRc8dNxeSUD5zM+skt+BZ+5ko1gxf6SyqrBSFCVeSq9GDCUvywrnJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6i1MpSg6e/dngRzKh0JehvKqzkHtmHPoR8skcfEkMA=;
 b=Z9JWUoIYF/KkQ6pvoyE+Uvuwlz+bCLTdd2csZv95BAFWWqSWZbL3TBBqJLEU4ydlJgZftNVn1Acry/LMZ8mZSNxFcYLQioidXH3N+vMYQvSIZqw2LgUKycrAezGJlarlHmGuHbfZk3CqBgmwrMq81M6dNcbXRtdla1yBOq9zm+oIdHpBWpGV+zjKRbOTrB9bkplLPY28Nme/fbLb8bBCk/9bensUCN/PlGSExg+kGYWaPGcHtT+Ln0lUyRlOwKQbHDP7r2MjrfItfiOZRY7NCS4ervmhY0nYs4wi2jqcizJx6FkmIdR4GyRe8UAAFZLXb5VdNc4uZZ29ujT1EknicA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:36 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 05/13] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Wed, 18 Mar 2026 14:29:08 +0800
Message-Id: <20260318062916.2747472-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: c65b7f21-9377-4467-30de-08de84b79714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	ZjRnptabSiM46hxH46kU79OUbrv7sXi3wfWtidl9p8fnCOEyR/dUPhvumBCEQcv2jOpztyIMkl2AVILtYb6XXkjsJhGjPnNjIM53jz6Hkt00ozOAsCkSyZzc5ap2qVuRpiv0v1bL3A1SHV5GiiTt+aqfWeP1WmOQc6iODKTdbQJKexuEFmzwsNzvSuzXIcX4TkVCAraIh30/i9GF+NVE58mKYc8k02NxeHhSkvcGn8M9/6e1cBPyoOMr7pktlPLn1PYEc+gyXqeGqDICynuQh/9xlqAIO57LbI7wMUBFO/b+1W9dDdr3WwjNukejELYlpw0+kxnhgD7pHuIEtDBycI/Gb0mSUKgJ518WQt9VdU3TuBstR8JzCZtKh7avostH+QiWptuYjWpAB0AJz3cvjx1RdbEVqPie435mnSpT6jhRaPlbi1NDOkGFQPBr+3waN2ETf2T1XQMNdlf6vriZPpIlGOhYSZHzxTTCfqkB1l/vCVqAJVLYXiinsFK3452sKFDaIjYGdUYnOl/SGaPZHdj3ZHP60shcI9RgysBn9DKznvw58JZFJR4fsZQg/uR7XVh5ttT4UbZb5iI12yt11ptGV8FVYRehcuOX3rgdnRxj+z/SCFdX2anp8df3nCP+yGT0DGbZND/ojQMXdMgnN2C7xMfOT5UY2DEDSpQ5d1oilO/ZAZuBxMp7HTv1HRjXTpOnZ/nSeVpdeUOGcyey+KOFk5xkFPI/9hoO3PBDHoP8sP4p8sHfzd9tsGFXU7X7ByBJnAaO4NXHD0iqVSZLZAAUBwDQFNJmkaJGTe7mrEJ1rsojRX4RGavY/QaDNyw5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01M5/Y1K56Y68+LWdFtk/DAM9iBqDf6GvPef/O8Vc4BvO06Yifw9kCHkJ/s+?=
 =?us-ascii?Q?NBv8ZPbw8hC15HikPjh0J+qHamqZNydi/i5RqiPKvzubPOEQvvXrzYDdkzgN?=
 =?us-ascii?Q?fIl9V0yqsLeqH0bpcMePqefOgmRh9S/J6abXVB+ZLXvmLiaDl3Yv6bNIJ7sN?=
 =?us-ascii?Q?+LA+ayM5arCa6ndXNfgkBhJ4kFpnw+ArJ8Zb6IUUDTclvMHxODKBt2KX/VJQ?=
 =?us-ascii?Q?YunSDXiTFwYRDukEMB3Ky/blzKGJPgJk9k3ut8VEsp2WdQJvYIPRombK4/+B?=
 =?us-ascii?Q?iiyvH5116PlEFULNKRoNc5q33DrPyAveSv5TcWLyw87pgqILLaGpLWwKONmQ?=
 =?us-ascii?Q?wOJRaVVLNfjgnt9327LP+FM8Y9H30FLBUuXigppHNiPUY7NR6Ly9NnnwzxPJ?=
 =?us-ascii?Q?69Tj81N7p1PJ3JFbqQu5Qfm5nDRWufC6EZPcP6DkYejSyDot2hMdlAI030Ay?=
 =?us-ascii?Q?c/mvXQjGDkgpzS+1I1wjVUimWAoVWx+UvSQkUjdnhBgxYu5U8tS5L/upIj30?=
 =?us-ascii?Q?cxm0rQKv5c2pmzNNyo93qegZZduRR7Uz6sGo10zgbhPMb/djhcM4hXxu7Ij9?=
 =?us-ascii?Q?vYhljoRwY7ecDIVEVeqHjnx+wqr0Uf4azU9yV2MjVPYmmypBL+x7985yen1f?=
 =?us-ascii?Q?LQ3gspBI0rYLG/lxH1goX7+FQ/qbeZ/0zSpl17sMaDbRKIdL6PaCggGOwYC1?=
 =?us-ascii?Q?7jU96vffbPPFs8XytDQdug1oNyfqYyG9r4b2ipHD/0BBxQNkMD97hBLUPSV6?=
 =?us-ascii?Q?ePsUg0OlR+4p1tyWreBZd8BdgmcrYy7qRAMAZcdwKOgwrR0aNdNMkqi0vwo1?=
 =?us-ascii?Q?q1LhFuouo2HdXoIOSeaFpt7Rfs1Kezg3vRVs4meETh8YE56WE13VFjDyWp2c?=
 =?us-ascii?Q?Au4Wa95DM7KG9tvI0WsnnwOwU6rKd3k1Qv9chZb1wBBA3pL9gxZeUYAt6cRR?=
 =?us-ascii?Q?QgxUHqFcI3F9j7+Aa61kTRgslkDW1SohG7H7gHiF6IHdpO3o4ZdO23WNuNB9?=
 =?us-ascii?Q?A7nWbg+pnxZLNqZVO0UJqRArzVKbisyjTJp4mYSft1xseGK1uSVG5j9qGWp7?=
 =?us-ascii?Q?UZuOmJgA3tnRlkCkFMcS/AlNcYbhlS6fWpNf5uHew6AZgLv6nzXTYqGGDzyo?=
 =?us-ascii?Q?dzKELB48+OkQq7V9Sqm1E0DhS1ZaE1eBgqCmUyygXMWi1vmKBgeYUG452WY4?=
 =?us-ascii?Q?VQYwbqr5f7p+X1YQoyoP1sJZqZF8f0PjpgjU2fNA2QkHq0q+/M3IjUL2GHGn?=
 =?us-ascii?Q?+CaomoDoq6D8bUIuePlCeSstnGhTSOv4iW2WWLXVAHBZJ7VZhlLRw1YwLOJ8?=
 =?us-ascii?Q?/e77ZgNxnYrkG5ATysoq36mNHVCxoKrR3+o4GZCyEsIqUrwexEQSVUZJopYx?=
 =?us-ascii?Q?i9NBzq3+PmJGkASE/8Ej5JhLY4yAHpbtKmUuBzHvrXgZIr6tlnDN7eqhOvLK?=
 =?us-ascii?Q?MDS9mcoFZL+xv5FhQ3xOEoIsnEd91CuDQWb/1sAFL/AfthgDQil2uI6QtOk7?=
 =?us-ascii?Q?mLee5JWcqHVmx2TTM0E+zKvi3j3viHSUBQnsT0daLHDpuS2ZknSgvFGxq/5U?=
 =?us-ascii?Q?XhySdeXae+hKRRHN0Mc+xKZGQuv662Y/xTmpTe61q0IS1Bey+5uOJEeBe1Vx?=
 =?us-ascii?Q?AgfZSAb4x5+/+ImvhWsyVZpoZXaFlLcVbsvc+XcExygi62q43LSnxDtIatKy?=
 =?us-ascii?Q?vsQKFgDYFcaFAjh37XuzAl6G7TgqAUOb/JKnJYeEm1qh6VwPkz6RCirJxztV?=
 =?us-ascii?Q?n2YvITnJDg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65b7f21-9377-4467-30de-08de84b79714
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:38.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbpQhVXTUhD5NCFxrOqBo5sQ/mmcmHfvIdHJ7ZbiglYnrK1DreXKXMY0u5lMovwymYKZWIpKdO9Un+bpUTT/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

With the common Root Port parsing now handled in dw_pcie_host_init(),
update the reset GPIO handling to use the parsed port list from
bridge->ports. To maintain DT backwards compatibility, fallback to the
legacy method of parsing the host bridge node if the reset property is
not present in the Root Port node (indicated by an empty ports list).

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 70 +++++++++++++++++++++------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 83beca5a1fc2..703b22d06526 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -150,7 +151,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -1222,6 +1222,32 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
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
+	port->reset = reset;
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
@@ -1231,13 +1257,22 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
-	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
+	if (!bridge)
+		return;
+
+	list_for_each_entry(port, &bridge->ports, list) {
+		if (assert) {
+			gpiod_set_value_cansleep(port->reset, 1);
+		} else {
+			if (port->reset) {
+				msleep(PCIE_T_PVPERL_MS);
+				gpiod_set_value_cansleep(port->reset, 0);
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
+			}
 		}
 	}
 }
@@ -1247,8 +1282,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	struct pci_host_bridge *bridge = pp->bridge;
 	int ret;
 
+	/*
+	 * For DT backward compatibility: if no Root Port nodes were parsed
+	 * (indicated by empty ports list), parse reset-gpios from the host
+	 * bridge node.
+	 */
+	if (bridge && list_empty(&bridge->ports)) {
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return ret;
+	}
+
 	imx_pcie_assert_perst(imx_pcie, true);
 
 	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
@@ -1712,13 +1759,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

