Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF430F52A;
	Fri, 10 Apr 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788203; cv=fail; b=YVWD9Q2q2+oxhRqzb/If0Tc+ijkNKK+0oJbqPsQedklh8aeF8HrEq4smzrLWdrzHLCJ4uEVbHKf3Yr8ZGGM3GUNWaqLdXMbNcJpGYyz4FYXHcyO/aNmWtg9K15Q11zWznLgTv6hlHlm9L88kcFVSA3aauvN62PsEFc+9Qm33haw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788203; c=relaxed/simple;
	bh=TSZPx9Rlxs9RzNQ58CtdMU27Q3xG4/tL+W4dNCx6Rok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QTYiLHcqVO8dLPsZNFOKSuUKy3xyQNJFYGmepbHFnEpRzKV4gWYEvOKG0vPyM4zjcF1pagP8iS3o25CSBtaLGVxJmVyH1ONeSq8QHLWm+9zkZqyv4mkv73k21bbL8LB7gCKBl+1sS2FEimRLPvUmfyjvqsfaGNr3bFegOYZ2QE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PU+s70jk; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PU+s70jk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed/CitOrU/w0C5pw6m3pUsQKETzRJtBKESc1+OnVA2PGqWUE1zDXPeXYtDPbqCwcjTvKiRoCkRcwJmzk4GBp+4AEEYnXGLThVOewLA/wVPqXKNdtqBsGD7ZO6m3qlLOQeNyv2tK59FNkZeKu6iyU7UB7lEhYZSKKpGjuE6CgZTckzexUhneNneJ/xifQpOGsr+flLILFRMdIVBm9/cNncBbAxoNLBXNsIzpkoTqT4aE9JYrB5YlScfkQ/JOMzN8kkgT++A8PyVt9DM29UxC750E7oOvmTnAvNGiuEdDrjHYxOuRL8+YgsqE3gcvAiljsGgjR+PH/67Y1JgfhtmwGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eDEJjjvdauZ5NyK5r4UZU6erm3hSEAntgPB2/0oFIw=;
 b=beB9WSkMlqFIAZrT3l/OGc7GDmRF20q82WWVVcVEX1RW0rM9T7pc2xR26Hc5GI77uWgWQZD0cBNvdqCinouNcv6n0YROH4fHkFGKkGpiAa290hrqkVpgu67Zb17mKIXWR/Pm/8OljEyPt0AaGct3Xj+AAUPKdfJrD/axG4FYyeLE+cZs0fGvtym3WzoOx1D131rKLzfJgdqeVWD2qiL50RcgVEsp8BT68aypmdnDjN9tQCLOLUDbU+djPMRO/UldWywi7UC+MdmU/UTIFVwiQ7LUYWjaN+qlWdre24SHJh9/dv1tZUS+dVtcVtA+SuHT9k6B0Y4Sb7V9wBGIez4fVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eDEJjjvdauZ5NyK5r4UZU6erm3hSEAntgPB2/0oFIw=;
 b=PU+s70jk0Qo6/F51azCK0bNQhXVIpJ/H5rGrKWZgK0FSBcYhn4PdwRyjnLpxESS0/IbEX1TflEDzvT/eKdulaLZAl+h9vc1q9WCjjKz2ATTa5zqarjGd4gjJJpjd9/HPpNLHgCN8bdgjpvedryH1DFJ8LXmuIsdVG/IVsfb8EiBypeTBqjJW4AJVbWhFSTvWqJyeBexuuHRLgNStz+Q+EdwZaBvgy3etbabCNFKkyWeYsBxN7VIadB4MHHsUD1F6kDTRLaN5RFRKS8p4VjV63q3vj1AGeM+j1/wpYTY0qMfLwnTL0YeHj/5yclOPRUcplMiZ5feUjXHxiji2oB5jPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:29:58 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:29:58 +0000
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
Subject: [PATCH V12 04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 10 Apr 2026 10:30:47 +0800
Message-Id: <20260410023055.2439146-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 27aef8b2-a32f-4a5e-a879-08de96a90f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FLSrfJqSz6y1AnvHW3DvWCtC+ZRTe6gMSglGv3e1AKclQ8xjE2WXb2A+bMXERHiCxx3nq3w7iQ/mk2J44khF8L/axmz4GPBp6APX7yqoG1gclcX6gkpjYD06+9rRyRuLrftXLebNA1tyaSzIGJPx0/JHFzQ7z/NBJGdlN2FpVw+RxfRCY5yC4MGOnH4eZQZpFJ0OHZWnjemWgIX90k0qxAgZZNt4BW7rADQLenrVkjs4+YB840cGbW77av0uahEFV16cReGO20HqW3IQONNQpMUakNSLqkSfemNyOdTqqDdANGUZt2r4vs7yfP61L5LKhmRw/V5ixmQIwwnY1zktjGxOl/tFJRH2TJuzSpLHOeFFEroZ8vRYDON/L6E8Il4pt4j0LfcTaiiOUNNC/YGKoJU6nIb6Dm2yC4GZwSOPbZaCkW93yWWwNLFYGEJejv9dcqxylQmkSK6V1yDbTOgPRrZD4lNeMoBjeMj57XTOOX8uvlYNfDeq9WE810FHs+eLSe+piytNc2XL6gN17oWNzx/EOhX4ifmrdzQAlrt2VzqGXtIqh0EayDirGjeIqRYmasFRVwc1Qbl3SQqysp5cBSyY/Mk3hUakKZOqg1T+ID2QlsAdRUcBgzUFGwpKmyGR3c4LXVj0fQ85PNg84pUP3kEIsiRiRERbm+5Fqrvk/yyk+tb2RXBqltyxHCIo292k8k700ycT3VVuLrP8UsqcpHAXs2IlprZT2t7QxymwTudqhgyFi3pUW2JeErjbCYEy0/TaCwST0Ey11WyAMm7R2AQNWfuK+hkYLtufjGMlvS1NfCN8p9ZgeMEdFla+zqGX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jj4NhMsIUGrjXR32sdHnFrRb9qHqaL1+ZEs8Rtkvse3yTy4A9ibW6jK2um0R?=
 =?us-ascii?Q?ECBJzmQ2ctb2scfbacsI/4ZirdQRdGkOROz9tmYIJvjYzh/3h5NgJS2aZj3c?=
 =?us-ascii?Q?2yHZnC7vFLtrBokyKGSqcapxWkNC8SB2v+sBSKLzdLZ40cF/R86LVU+wCwnv?=
 =?us-ascii?Q?K+7BGg8ACZKnMEASYwMSdYQhVmCnhKQpt3PNcCV0gilBObEhM7Wva10/LIyf?=
 =?us-ascii?Q?BHZ5XwmhREc8T/wi4fWUVOmNvOmcqrf68sxOA/FvPuxtHuLCcEXBiFN5vqQp?=
 =?us-ascii?Q?RGc9ntyxiAVyFbjVll3ABc4ih4VV+jjJkv02nJWgQSdfKvGksS3XMpI0FHLq?=
 =?us-ascii?Q?24lcu03GCxAiAdLj8Q2Yg0okdRsAJ0nwBn4OmPyjJ6qBRAJDHKxNHwoqFdm+?=
 =?us-ascii?Q?zI8VsnBhqLVi5qTiwellYFRWw5u4fJRoGuYAOn7h/ClQgDKvUegePzLutaZa?=
 =?us-ascii?Q?twIvTYsCYQv6/2x59tHY1TbL8l5e8NiCxTX5RNqyfjJ51UhlNdntSh1QrOji?=
 =?us-ascii?Q?kTJJUyv0GxL+9lfinVgoA7GGpZuffUDVbD8AB0B2964vH28I8v67qn4NrFyD?=
 =?us-ascii?Q?hrxezOApqtRemdn2KmPQfl7rxeMbzSCnyXsdiaeSRsH1EO3dU4GKBE95+gne?=
 =?us-ascii?Q?NaSf9ceLfthWFHfrWECsEbe8OayOiJtb2d/YVvz3zxpbI5qsWSczvNv7LFwl?=
 =?us-ascii?Q?YI4QYICXXXZliKiMEIAVvvZJ5ahTVfu9PnHYDE2HbEMFK9T+UR6cJXVEuixU?=
 =?us-ascii?Q?Mo2XEhyJ6plHfD8viclz8/mnZSPPryEesahVpxIOR0Tvuy6wOOrP0XIuvarY?=
 =?us-ascii?Q?MNpeV8z+2JCaDJEh0so0HUxIzWu4dw3I6DM+yxDPdodiP5kjHOX4T9z9rO/o?=
 =?us-ascii?Q?6KYa6IOrRYNtbFYG2fR4aQ7OdPYhFnOQiSehYzhzwwKw412+14fPTwSRjSlm?=
 =?us-ascii?Q?6laeDZ/vKEa0Ntewx29WLKjJAqhKfPcMkvkL6LxytVfs3C3d8rXdz6d45QQJ?=
 =?us-ascii?Q?yvOAD/EJxwQPiwRAKGHAktjmJxX/sXQ8w1ZCIYgd57Zg4brD+NAHNDGSZTB3?=
 =?us-ascii?Q?lkoaUk1tt+e5zKcOziD1egqmGC547TDCgPfXp5Lq2/+S77M9ADvMKkhMt1ry?=
 =?us-ascii?Q?/MRFa0vALj/HFO4xj8EKzxEQXz83gaInqGlAzi3q9jJYbnBfCsVe8DlUD4X2?=
 =?us-ascii?Q?0FrWE/lrXl6I2u4btCQ4rsRcRXP3E4zDZgFfa1pEQ05KfXTIiU6Ef56GMba/?=
 =?us-ascii?Q?KgZ7ZXy24tQ3b6TdkxWSbYtjdF9Z/14dEdj5gz7bcCiwBd/NsgqKlJto2qW3?=
 =?us-ascii?Q?jveq27xkPKVMbijkyjEZorL1e4nQDzp8l52bNeZOt81vR4rTg/UDtyZuGI4b?=
 =?us-ascii?Q?fzhZLPmiKFnwG1dcSli+T0BcXwdkzclDhpWkJHcnQZ8DI0XxV7moJN9EylR5?=
 =?us-ascii?Q?FF2RScjSXXT7XWvQOp9xCUFjEZtREzIdTSd4YXk0kSFMrC98I862Qg1rF9mr?=
 =?us-ascii?Q?0bGOdbB+ebtOGa/PW+BkXYzFz9nk5swaBQFrbOPLnyreDHoAn8CICCF+c+9n?=
 =?us-ascii?Q?n4INbglycLxt3w5q/f1IBJeNQ1Xc+ifLUks0y09n5ki3mVxw9qLSGSXKY7Ot?=
 =?us-ascii?Q?4+i/kUAFfcgBvg0Kl5b8t29L+kVsCzTd2VDDxi2q/p91ztj4pWEhQdZ3OrdH?=
 =?us-ascii?Q?+SgAbGOStALm0kk9bWzjTOBaOKH3HuUnAgLd1yRUPz0bESPEDf4yVYIhSAc5?=
 =?us-ascii?Q?XcpvvoxH5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aef8b2-a32f-4a5e-a879-08de96a90f90
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:29:58.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPlzdyFxjTXBY/DkmUt0tVjKJuT53U+DkZvlYXEdCrG8zDFhY3TsyaFbhys1MEH1Xl1bt/RVDZ0rQoaCurYN9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

Add support for parsing 'reset-gpios' from Root Port child nodes using
the common helper pci_host_common_parse_ports(), and update the reset
GPIO handling to use the parsed port list from bridge->ports. To
maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be in
input mode, using gpiod_direction_output() instead of
gpiod_set_value_cansleep() to ensure the reset GPIO is properly
configured as output before setting its value.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 68 +++++++++++++++++++++------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d99da7e42590..fadaf2a582dc 100644
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
@@ -1224,6 +1224,29 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
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
@@ -1233,14 +1256,21 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
+	if (!bridge || list_empty(&bridge->ports))
+		return;
+
 	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+		list_for_each_entry(port, &bridge->ports, list)
+			gpiod_direction_output(port->reset, 1);
 	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
-		}
+		mdelay(PCIE_T_PVPERL_MS);
+		list_for_each_entry(port, &bridge->ports, list)
+			gpiod_direction_output(port->reset, 0);
+		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
 	}
 }
 
@@ -1249,8 +1279,25 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	struct pci_host_bridge *bridge = pp->bridge;
 	int ret;
 
+	if (bridge && list_empty(&bridge->ports)) {
+		/* Parse Root Port nodes if present */
+		ret = pci_host_common_parse_ports(dev, bridge);
+		if (ret) {
+			if (ret != -ENOENT) {
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
@@ -1704,13 +1751,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

