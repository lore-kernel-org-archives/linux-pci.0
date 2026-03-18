Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30995364E9F;
	Wed, 18 Mar 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815311; cv=fail; b=WSnx7rdMt9axw+DsSb/JwML7zqo0M7oypIR8X5ORlmGXdqXZWoCg9/JgPK5EGc3zN4pvAZYsMg1fd3DCK4pkh5Cu89UuD3/jUOvPHpXWO3YD/GLcdhtOikDbA86N9FxOhs1sS1J2sWzC+3fIQJzGkeDgnKMYcJF7eb/OMoYPeb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815311; c=relaxed/simple;
	bh=i7vjj1DTZtwWewEdA8eni0IxRGUoV8QEyeFqF72cBRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyOAIy6fPnWkUIAD2n0EfPXhJ9Ocwj+YSTD4Ex6M2idDXlTVt64A9PM6BCUK6zdSjeTVF8xkaBZ9ZnONG9iaBweo6eLEPMn9yj0UsZtk5CU9pFLrhqL7i7cNImD6Edv302lA0ReRrMLAahgwHR25wNdFdBm46nv171BOMS98O7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A6w6WMw6; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6w6WMw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL3IEe/t8A8fck/p7cQJXApFklUEKFUhv1JPJLIUjgVTS+xRRwuELSVDvJiDxCT+Kvq/UCj2zq8mIswOpyc61rreA1Lt18+LCUyT211aH8ADMiA/tDs/mum4yIeeoyD5v7oCGvC4uOpKy81enDwvIFJg7LRhgcc2FCoIrvR531y5gXnfEs7EtTv83M0+5+wCeoh3p9fNuHNlj7LtQaj/KrczJmP4Eya7v1AGGiXTMikF8IGD623nkKFh1CNezD4+G5yp5GulDI6qc1JcuGA5WZRf02ES+iEYfZRN5vmZY66ysExPHpteS9JBmkzHu7aD3JKEf9iMTAHsMwGuVm2SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9/yjHQbOkKQ+YV6pt9Qpi1TBkWd5KYojUQF7NtY0aw=;
 b=mZbxR3O3jZn1NX8HJPxbaih9S/Uxh/wtlC+Yippt/7i6lJ1og7HPWA5fSO7lQ2ofV9Z3GzQ/rEV9yI3P+0IuxBbziglgfsl0y7G5JctbvR5g/tezaXC551gxPwE/uY0pvETHrACn7ZTl2Kr9fvWTKQKZnl/BmKAtxFo8wppt66psp7BOA5BmpTUWma8jKBa0ulADCLcaXALWaRbwOU6VO42ZVK/lEyfKEqbeucU4o5L4KSGP7qNiJ/TsMw14DTi7N3mmSYFTBXjPk8KGlW/hBauukyNBzVezhh0bwkZYRdN0UMqDS1415DnmJDptNoDBNXF++/sXnkiw739YosWpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9/yjHQbOkKQ+YV6pt9Qpi1TBkWd5KYojUQF7NtY0aw=;
 b=A6w6WMw6i+SkhvFB/jGXPBLiLoahEDdwOsELe/6IPpjszBUbMKFFqhKUBooxIb1gwC12X2ItNYP6YEDT4zQ2hhTRqSVgtFu2/CtRzAOOY5an4pL25Gj+ILBFiJ2GRierq9DdHTzjDgqfkxen1x449uMHa151+PiBRc5r0NnI4usX/vXIl1ePrpU79mjjaPVvzlwNzmyGHb+HgCDf1l3zkR17op/w71LfuWehTubTZzSnrQreg39Q+gc5ivnE8ufR/KVy2vIqoMDlNrDj3jIWDvKK/Owmnva8Yjvyumloe+2cF9wnEHqFbiE/V4hXn139HDEkdfKkbRRzh5WkCq4psA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:25 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:27 +0000
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
Subject: [PATCH V9 04/13] PCI: imx6: Assert PERST# before enabling regulators
Date: Wed, 18 Mar 2026 14:29:07 +0800
Message-Id: <20260318062916.2747472-5-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85f5337c-a28c-42a3-3992-08de84b7908b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	3xlUz3v923y557wlgNMZRNnw7xHNJrQWautu4jeeIvlfbD+MCXVkt5x8jVV2Vakp+NNQbNrnW/IeGterTMCump8IvKfbIaMmV/0xVqMKGY/cUIMNNmkG5QdxLGZSAJAHQFIaqsX44kts9JyZaaLVM0u6Ok/ra7HOiLJ7Lk6kNaqxzLpjuP92XlzyoYwJaGq971ux3GS24gxfs0veIlRQN6bDmc0GJ82ETATJotWWHS0pw7CEUWgncuQ+tffKatv7EXq35/d8ardzHh6IQHV5p1oBAbRg2F/Wog0WjCjZtUkfFIx17fqeJGhqXGsdZRARF4GS0ItplguAT31TH+DG9CzRn0AXhN8aQIHFK2fJrO7MWE/O9KOMz15OAq/thG6AZVoQq41DY2pOF3KF+SyPOlbEcSFYFGHFz9XGUWTK9WQdCzzYMUWrEXDuNVqS6MeE6+AOhO3Hj9wkoyVV0ZRTZIg8SLGMpRH4tSJSPCThwgXpJXzehnsznr9tWoZyo3MIPHQSyeTqNUw3LTo7vWmvK0Mm2FRpXofaV+D52GxKe6CR8zK7bvR6bzQNEx7igSFz5cz5UqQNQ/sD4tS4mBubZukah0iEPhWeAtgCVnetVnzb/BvjtWQQvQdih+91sJen0FTjvz+RCJPbcDGXmZ2x6xXt1Vh8cd5Mwo9ZTnzt7LEPyfVuR5uwSbUXnPGbhFhyWHG/2cHJgKtZoGWuB2ZfCuMQlVucpdr9mamWUC0uhIGbKvUabi/L/ykre9/w1HsggnaksKGfXyMrPQcTXRPjlNPg353nWlX+TZkXZQJ9uYLSkDkVKYi29s0eeGE0koUg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lvq5VYLe8ydVZ6MYrXo2JnBhXNYBgWt7iFrNiambZHJ8vGlXF5/4lIO6SiX3?=
 =?us-ascii?Q?Uk19Tm8WqhqQhKXMQo9qaey3yDxCiNlHm6Fn/U5guqKEFKsSb216YGIScGFJ?=
 =?us-ascii?Q?nE/e0AvEUe4RgAMLUS1mVHVTmKf7DTPXNGXNM0bcgNQZBStoPDw5t7oHjMKg?=
 =?us-ascii?Q?QcJzS1e5y5ZunSJ89MeJ+zQkzz6yDMtA5rSkOIraPDqoJUhZ+797CxKMVe5L?=
 =?us-ascii?Q?h1uKXtdT6olHaWR1pbfaPehfkzIUScjl/2CzWV12TAcHfBq/q6bho8uzt833?=
 =?us-ascii?Q?uCCiXr/bwlygGrolkcXdB6pPo3VkBg2XusRRrzIpy2s+dLKZG2t1U+i8euJm?=
 =?us-ascii?Q?HvlLvg8jiFi9ZOYzrS/gTH3ZVMagRSdTjq3xBOKQ/3sJQ1WB+I8WdhZuLueb?=
 =?us-ascii?Q?P1LipKqxYV27w1N3iw0K2AYG7Ye+dWKs4kKdxCQCV6vhzWANXlzFAg9zoPAU?=
 =?us-ascii?Q?3wedvbB7/iYcebd4ypaBvROUEps0ck5PqJQ3qH++fAk5N5ztwBzl+koOrr7e?=
 =?us-ascii?Q?zLD2dJmgJV1n9jKB9zOU3NbOA5tcayPEnOln67QvgEUFI3loRRy4OCDTW9I/?=
 =?us-ascii?Q?eU8m8aCS0zmDxpj9U3DP+yTkn2ptktQquimCYPx3jRG3nRAGIidrU9WiNdSO?=
 =?us-ascii?Q?+n4+9XKnGOQkF6sIXD+p4FkAJO9cquK4EWhHho5G2+8wIWreczN46nLaxo2C?=
 =?us-ascii?Q?dwyqONyxO7KTURjRcuPdwi9tliOatdm8HJ3ucKdyDbOIDhPgF82N7eQJKram?=
 =?us-ascii?Q?i/v39tHIS5nDhh1OebNXeETw6bAEeFXrQB8BtD+u1KianB79D1bcZttIj/Rg?=
 =?us-ascii?Q?7coEKRdc0hNtnLWR/A0K8ji390ODHeKN8St3teMs46TFgW/ktwxJ7hT6QFya?=
 =?us-ascii?Q?c9PDoWFdGXVIZMS3jzDmm4W6UWXjWpaiGKNv28qruzWjeD40JX8n3BZOzZ7E?=
 =?us-ascii?Q?Z4AfdPMDMiZEcKnRj88kxileZ5Li6fkB81D7GlnG4Yp6092AYuIbClIm5mjJ?=
 =?us-ascii?Q?Svr0HD7n1RrTbFkvq29/FX0K6A3attQNegD5KuLKq2ptqwb3vxlxgfStjIj/?=
 =?us-ascii?Q?yUkanOjCOvXxZh1VLRHSLJI4Xt2KXlvAz8moyCRztOAsVZHCdkKEKTbuDeBe?=
 =?us-ascii?Q?etTE0ipNbMuWzxsQ078weUtBvXKTUAjLCZH0KfJOLjUwkvUD/E4exJq8NJuZ?=
 =?us-ascii?Q?usiI2A9DR6oJPUFBHJkn7BZmRuzDH1FmiKgZqIuxoNDsvdEqVyQ+xePWFfSJ?=
 =?us-ascii?Q?+YEqtDOovE58ynqLSWokGiooWKLUs81T1qCVz9A9oxAbMu8jd6aadtdZCLU5?=
 =?us-ascii?Q?xm8naaYlNIp3FEBkOL0mk4bkhBcVH5uuLlfudbPl8Jpu+aErxa/jXduTtPPA?=
 =?us-ascii?Q?bFVAL728625k0fEugu8cwXFr/HGTExXvFAuyvDh6Y+zGGjcU17MtrpJEetHp?=
 =?us-ascii?Q?waT56tFj9eL3lSc3HF99oAw+EK58p3EZj2R+uixBcntnc0UQLBfBpZBafxwl?=
 =?us-ascii?Q?R6IDjK5AobVSZ6DfuzcA7xl6XTrXx1u9Zt3AE9mBYHiFsYTqK6Jv8I1Pll4e?=
 =?us-ascii?Q?r6WYcx5TPdDdyFXE9aVSQ71OJ0VV8yx0Dbbh/kNxhxzcO7oYQ5BGWeBxkSsN?=
 =?us-ascii?Q?HSf4ql8iKDYn7/PuZUDEb8wg58LtuHTmyUUMssXHs5BFxJqbGLLj+H0ul9C8?=
 =?us-ascii?Q?S8gILkb3ClZBdnRp0eEdOcFxYkSnmyD6H8j2yH/G2O6PV6v9OttPHKYm699g?=
 =?us-ascii?Q?dUkq7GUUgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f5337c-a28c-42a3-3992-08de84b7908b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:27.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJeCq1kmxa8iHgLhi/8TOCgqpJKkbJDOdigiSfr1zjnOb5IpuqWWSFffG5TD4AAx8tJYLZKjmO01VURXLwyZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

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

