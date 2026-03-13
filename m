Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361BC2F6918;
	Fri, 13 Mar 2026 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367695; cv=fail; b=qeAu3tHFc/BUUrX2cCSgV4jWX71m7NU/Rn5N4NmqXZineN9Cg1nVx7LrBzmWaRQsT0fBEM0WSJPmfYATBRwSb4E/eIoc8YReSUCV2NuerLKfwOJQFXPF7m5+8M3hBlE2DajZzyJOfgDlDJd/PWyIcevnS7Igu8j3hYasiCIw7Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367695; c=relaxed/simple;
	bh=i7vjj1DTZtwWewEdA8eni0IxRGUoV8QEyeFqF72cBRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrgCVkHAx1CHH8FrjT9OJ7ySO0vxkeAWuhbnxX4VogEbuqURSUY1TbN6W7UFBFCP51B8d+uZj7YDl8DFEZLHXp/iiyfTkCRiQFLxQZYRy8FtjTXDi2QywmjKcBYajzG1xwPEooueVI6N3gHim3riVkdMwnSqQGXaWPMHxMOgGVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G6A0PCjU; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6A0PCjU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZabgWWEEt51nLQLxBTGqzd97ay/k8OpKxsm7etFstI1Q9PpCmcnRj5yijoGArmv0GZOVqxBGSC/OwHtSkXKB0zrdP9CYMC9wEJ803YWJXVUjnyLUt72wwxUp67K8V/zOOWQAnkEijXqgQz8JUqASGwucSZ1MRX8wYyodLbggEjMvhgLMzsWpyVay89ZWVwISatdOp0DTfBW1gqGiCIVDTGmM7tJxRGNUUigNxfi9w48SSXL+oc2tJ/r/Ep3229KiA/HZmnfocOvlzVYnKHONpDx3EO7x3HKWTwfcoPrwdItDQRP6QOD7XB+aWlLJblQv1szy2wKok/lrtqJji/Gggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9/yjHQbOkKQ+YV6pt9Qpi1TBkWd5KYojUQF7NtY0aw=;
 b=y/qsId4r052qb1pxf/uPv5mm25PefTDLI9Y1w66295vZv4MyTyBntveTe5grmTkB5sC3PbDv7uiyWFnPnSBF484jh1lz279k5blrLlRgfoSi7NJjGhRbANdsgW38IuBzNDhQlYUBUae7T3GcH2u0pNpVaJUk8WgddVZ/kKqZpu12BOktLc0WmLa71N6E9NeF3ixK9gP8682Xg0TQyCarZu2/Cwx0l6nJBfuxDhfc+tA8zbrVMIgpBDqS8LDuCN+t/ZOdXzw1+mxsqZn2lL1cG2qYxo2PLtUngmPN6muHlwtuSXtKqI5RqFp23+GeglNYAYy7YTFec4fvPxvPBfTK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9/yjHQbOkKQ+YV6pt9Qpi1TBkWd5KYojUQF7NtY0aw=;
 b=G6A0PCjUCVCg70eIzf2+b1kdqZhiaionO0jeROZ8tPeDfz/MIitu/YzVbqtpjdTvRDF0xt7uwYlVgi1iikwWcjFVEdILQB1KyiN5aW/QVme+VhZ6qRRE8n63XPSyGx1fOPf22lu5YzmN4KANHD/ZgUL2dfZFPmWeb90KfhNn0pWoQaW+0/TrCgFDBnkP3jCX4JuAFQDkjscOXtHP7R9gIahDVBAjMZvmKaHek506F3pzVP8b0LGFzB3AjKvPvCWkXeG3b0o1Hu2olxTn4mm7B5sap/fP4UI5rcRBs0KC6FtdVFddQe/jVjpA2fsBd0AC9Pq0ACYB46gOEmChxIxyZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:07:56 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:09 +0000
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
Subject: [PATCH V8 04/13] PCI: imx6: Assert PERST# before enabling regulators
Date: Fri, 13 Mar 2026 10:08:14 +0800
Message-Id: <20260313020823.1592389-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4ad4c9-e3d4-4111-47e5-08de80a55fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6VvutVO8XdA4bGpIq5xUQcyxVIEvMPOud5Ea8ZZFpD2EGwrumgpGz14SKxzsYQJ2tg2dzJcYoAPpFhq3RFk8aIX0/dCo19AEiUdNbz+DGUkrpm2TN6Alt3IyYlsJOF8ocS8fKm30Z5rLQGeHc1uHk5N+fzimXBSmXhXvkQvCUDiiTsLYb346PZJ1ACI/XPL8l5PqNqf+BcrsCnj6dVxc3KKCICZtbWiXdva9zpS36vypoWTTBqv4qXgXLCaNxRDs7TdZ6m7bXpauZO+KFAF1klhMMGZL9E5/ki+TH/0evaz50OA/kL2YrzA91pQfyDETkX/ny07wnaW/rV8aqk49K/2vlb8nbhw/+V3AmX7E+e06+Wj9UKkU0HamhytH4DUF8dp1p+tW7GvzBGYapP6QhxCkWf/fl0/W8xtfwdVpB/C9N9GbYAXiVn5ecH+BAMNdDikJe6FpCB+HfrHLDDPAaGW8zD6J8sZEe3EM6BkZrFucxBhf0J9wO3U6dD2giFfk5uFOJ28WHGbG4vBsLRtr1Qql4qMOpRFKpYxOjdc1OnZfR2JX+73aAMDQDosahYk3AEj3osR4iy8gCCi+AfStNJTGXzE1NxLQk20yGK3ybhcug4yWIaz1rh12lqLFk2m8FO91wNvNyAuChM+x6t+3/1RhePyQq0uetrFjX0DSf5zLpithT+uTUsVco+EBuABW5vaSGUgsXD1VRACGvrXJEWUd8Kh7L2QgPAFQuXGJS5GiJTDAl4gwcN3j5gYijH8Pds/PGYO0ou5/ExGPIAh/p6qIDY7aO96yTSomvXlVm4rP7oVhmsvzBfkIO6RIJXvQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UEmpsnFJsgKWewVgTqlfo+Rb8iGFh88L9Z8ONHF/2WLrhOOFeexrwTcZE+d?=
 =?us-ascii?Q?il1oSzMw0a20vhPensZyu3u/3n+1HzTbPCQl+71kcHIKR3zyAH9EG1Jr/ug1?=
 =?us-ascii?Q?AfGlg8pX6Jqn5bko1xQZ/YEXi/GkrglW6VixTbwHsEj322jI2vCPhHVSPaL5?=
 =?us-ascii?Q?7bwWUvuFuTxJhD6VZLgTkSIrNq60Ut9D6vTTlWUf1lqIYfATttP/MRCUDWD7?=
 =?us-ascii?Q?JLH0KKJELobkThQJJO7hEIfT9zQ7hEHIrVT2PIHR67F0ABtIp97V5UwKZuMk?=
 =?us-ascii?Q?/+tR32VRvuAUxedUtbRUUrStNLN5McNkwZV3DWCY7qAhZOOIM9vLCgD0Tikp?=
 =?us-ascii?Q?tdFuKNvGNnQwfnh0ow06rzxrMYMxZ4RinCV+Yjinh0Gi5bBhv1gnGQHg6K2e?=
 =?us-ascii?Q?jtP6oEoTW1ExkZDl4+H+n/507cXBWVLkrGIZNuzdoOjKXtkTOEMAz1Cz1fpW?=
 =?us-ascii?Q?wAyZ3Pyw2xtD132ba34roCwx+TN3NLvYGAsK1mjxw5xuPJvJER7W9n416xV2?=
 =?us-ascii?Q?+zb8L1+8oNqPFaqbgRJJDnjMGzpJtQlaNxePLMb7fic2RQNpNmrzyT7X9IFj?=
 =?us-ascii?Q?0+VQQ8R9DwaDD1jrEDlEBSz2s1KrW6fJ7BCqhgbGCy8plFMBQczuIFiScPv7?=
 =?us-ascii?Q?9JZk6qQbi8iTMuzVrNPxs7qOthlcfcqAX1H21siUhVl1oCoahahPxMDRGS9h?=
 =?us-ascii?Q?SoCCxqq1DswH4u/kJgcu4ccJdvqjnJar7PsgfxVkMumvDiLnCQZN+dc6Q6z3?=
 =?us-ascii?Q?Xv9eAJ23kaLaAYNNSsaHg738y+1qjmvtgmrvVzRfwl1iS+1aJepm3vGPh0NL?=
 =?us-ascii?Q?k94ERIRlqXN+mydExueMIVfPS9RxpqCBlpkLRTkSbYoioy/jMX5tdQ1OPkNb?=
 =?us-ascii?Q?8zlJfHSMVOTiUrecKcQDRBSLDVS0Wl6kSYSk/sPEwknuELH+HFI/cnk8wIrO?=
 =?us-ascii?Q?uTuSIWk21FTPEjQ5phRjYPfZHnWRdbLgvWdiQSabQ0i9cdxWE4ccx0zKwSQb?=
 =?us-ascii?Q?E+i20/mBDgds0yCL7Xrn0iccfkkHkGCrFqfznVdihS66KLEcoqMtuGpv/Dqg?=
 =?us-ascii?Q?m5Pa6yiiBTIpYw+Z4t4fpK3bZl6DPAqp6crajdlZlGC+O8ng69vFkH1NJ9G6?=
 =?us-ascii?Q?aFbn734aT7d18sP+uBuoiVsUGKEr2GxbYGr3wI8K0UJLNOsHeQJf8PUTgnBU?=
 =?us-ascii?Q?gkLwACqPJEuGYYf8R0d0Uf2i3mi4HK7Ddj5omRp2c9WFajuvfbMuqdKbG7w3?=
 =?us-ascii?Q?0OZzOff8Kca/m1ofkOBJul8aqhRGWmkyjC2/8VuhLN6qaQiwTfWNvta8Wrfp?=
 =?us-ascii?Q?FiMevRBqDFWHG6nxwpxcYC+e0KX/rUr7b781U3a+E2j5ntsXjAm4B9N5i/kj?=
 =?us-ascii?Q?dVcmEmPccN/JhRquSskOn49/KFKHzHhHE1mreY4Z/FWtWvEscxRQMIDW6fKc?=
 =?us-ascii?Q?sVPRiUrd897MZXFTlEepApGACPUGiz18Y5uS2aYa2iiuf/EZAXV35qaqp4wU?=
 =?us-ascii?Q?Bs2byHwFhaYC86ozmajMcfGNaMz1X9/dVjki434GPHkbNYnBj+DOenPR/roG?=
 =?us-ascii?Q?2xzfQtdmUGvyehmMfmIlFJkNLC7XEOFBCAiJne+6MaMrd+EBBWT2hqVIZGOa?=
 =?us-ascii?Q?hp9Jlg6VdqGwMei8HtRjgew9oIdnqlvS4KscBuh6jvz1SJhC1/TJXSzQg5LF?=
 =?us-ascii?Q?eOjBaDsg72KnJeWnEogWieOE30UPaAZDOxldFzdOm9/74G07lByxaJUs4p/A?=
 =?us-ascii?Q?aitDbDXcRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ad4c9-e3d4-4111-47e5-08de80a55fb9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:09.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYSfnL13Ra6HR4LnppVAEHX8Cg2RYhft+Qov9zRPlVONUwmWsHHSmoMOxl/3BYrKoSpkXm4DpMC6gjyMhd7MaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

According to the PCIe initialization requirements, PERST# signal should
be asserted before applying power to the PCIe device, and deasserted
after power and reference clock are stable.

Currently, the driver enables the vpcie3v3aux regulator in
imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(),
which violates the PCIe power sequencing requirements. However, there
is no issue so far because PERST# is requested as GPIOD_OUT_HIGH in
imx_pcie_probe(), which guarantees that PERST# is asserted before
enabling the vpcie3v3aux regulator.

This is prepare for the upcoming changes that will parse the reset
property using the new Root Port binding, which will use GPIOD_ASIS
when requesting the reset GPIO. With GPIOD_ASIS, the GPIO state is not
guaranteed, so explicit sequencing is required.

Fix the power sequencing by:
1. Moving vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init(), where it can be properly sequenced with PERST#.
2. Moving imx_pcie_assert_perst() before regulator and clock enable to
   ensure correct ordering.

The vpcie3v3aux regulator is kept enabled for the entire PCIe controller
lifecycle and automatically disabled on device removal via devm cleanup.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 49 +++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d80d3be28ee5..83beca5a1fc2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -166,6 +166,8 @@ struct imx_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	struct regulator	*vpcie;
+	struct regulator	*vpcie_aux;
+	bool			vpcie_aux_enabled;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
@@ -1220,6 +1222,13 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static void imx_pcie_vpcie_aux_disable(void *data)
+{
+	struct regulator *vpcie_aux = data;
+
+	regulator_disable(vpcie_aux);
+}
+
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
 	if (assert) {
@@ -1240,6 +1249,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
+	imx_pcie_assert_perst(imx_pcie, true);
+
+	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
+	if (imx_pcie->vpcie_aux && !imx_pcie->vpcie_aux_enabled) {
+		ret = regulator_enable(imx_pcie->vpcie_aux);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie_aux regulator: %d\n",
+				ret);
+			return ret;
+		}
+		imx_pcie->vpcie_aux_enabled = true;
+
+		ret = devm_add_action_or_reset(dev, imx_pcie_vpcie_aux_disable,
+					       imx_pcie->vpcie_aux);
+		if (ret)
+			return ret;
+	}
+
 	if (imx_pcie->vpcie) {
 		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
@@ -1249,25 +1276,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	ret = imx_pcie_clk_enable(imx_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_reg_disable;
+	}
+
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
 		pp->bridge->enable_device = imx_pcie_enable_device;
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
 	imx_pcie_assert_core_reset(imx_pcie);
-	imx_pcie_assert_perst(imx_pcie, true);
 
 	if (imx_pcie->drvdata->init_phy)
 		imx_pcie->drvdata->init_phy(imx_pcie);
 
 	imx_pcie_configure_type(imx_pcie);
 
-	ret = imx_pcie_clk_enable(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
-	}
-
 	if (imx_pcie->phy) {
 		ret = phy_init(imx_pcie->phy);
 		if (ret) {
@@ -1790,9 +1816,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 	imx_pcie->supports_clkreq = of_property_read_bool(node, "supports-clkreq");
 
-	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret, "failed to enable Vaux supply\n");
+	imx_pcie->vpcie_aux = devm_regulator_get_optional(&pdev->dev, "vpcie3v3aux");
+	if (IS_ERR(imx_pcie->vpcie_aux)) {
+		if (PTR_ERR(imx_pcie->vpcie_aux) != -ENODEV)
+			return PTR_ERR(imx_pcie->vpcie_aux);
+		imx_pcie->vpcie_aux = NULL;
+	}
 
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
-- 
2.37.1

