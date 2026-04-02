Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089D390992;
	Thu,  2 Apr 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123433; cv=fail; b=TmNk4xpb/8hAPRp4YXqPYSHWBx8jMAmjPJoJD73aIFaznlLiqsJMj6rgdDrw2Vcj9qA7HFXN0O6YLf/8+aApC9FCP1CkOIK/wNYpcgxHmYFi/aTtDSmcgqMdGBbv3VMbuJSPI8svlpLjHEfxq1wkndtGj2bORohDeuLKccjU+E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123433; c=relaxed/simple;
	bh=1MrPZy0Yw8bQt6IIoXAm1ESaSJh46qNoPxNYdOESLoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryOL6hIhAGrGlR6HhmrPUlfyb2MRlsVR3tnq0/rfaupVXfNWDiZVnzi73o3Mue6zOLTTnhYzvzGNcUa9Id6YsezqJQtKVH5dTXyl4VLy+zldQ7sWCsm5KWF+VkjCaAI9LiMLwjG1RWaufKH0VkReUDVIECvtpGhLR8te8qIFJ0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lZ2NHj8J; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lZ2NHj8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m77lpsuMBPC+f2DMLnkgQZxW6+sIDJt2GSun5SESnHQo0UlBEiu1Gdjn6SwPD2FYApRs3WMo2hcf3aTy60+aR65MYZrR6+78G3JYn1gbzscRnkBHCj1XwftbnWzCqVQjOZ2vhN9XeE9EiL3yuJioRWT432X6MxvZlJlNHYGGgp3GJQM1L6cVO2feT2jbE6wtxSqbG0mnC0Tx7b/SKR0NVGwl23J1v54om9pPa/Iw4ZXT7KZE+iF37I4ZiInF35NU3iO936aYO0s0e3s87KZ2ZEUR/i5Ebbv/xnxWXmSwtv+R5uXTRQNoPxZZcw9ngNuXcVdpQ+BnzlF8R1jnWtx1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us2i9/XZYQBXzF0fg4ZZNTrZNnRkfoACTnSN+q/XuQ8=;
 b=Fi2+3mZGiNBZRuiQ+h04bk5ROUMxzU40nZod+jLaAqjxTOll+Et6lRU8FNeSY10KzfR7cj6YwOa+f3ZWLEuE70IQzWDlqFT8FvlEUtQbd5hnCjJyl5ke+cTi8FShtu8GRwjuvd1MjeL6tpiF98pgYplDj6/VnOh/OFHV3KJEPo7inuWypdgc8AiGQvaHICoDwoybLPQKgA4J+lAdLWiZb9Tv1ga7Pk8OhSfeQomeeeuGyyWNRgVtMZWy7R2hEl8riHJkPPCkbgLGdl0xDM53YsDYW6DOUDGkyj4QLklQ04odMcm3ou7QMuhb+J/0EELyvo2cGuEDOoTMhkavHeN9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us2i9/XZYQBXzF0fg4ZZNTrZNnRkfoACTnSN+q/XuQ8=;
 b=lZ2NHj8JYlnRpSkKSvl5kzSdfF/gqLSAvgVqA+Tmh2Ar2Muptkb8KtX+WsanHlN8+mWDUlnv5qBOYe4CzEZ071VsYspL9Jz07VXDX8QqjWPZCd6pHlGb74pOkA/p/0HBCv7ezkZdvf7N4SELGrRmFAoWH1zy5mgrnG1mZzPSm42PhBor55hupNYDLGo8GTh/YBsfumZTwBoHiMtDjuU/BnT4GKde/ijk5rZvzf+juUuov8y/go6v+OpBVaD6xLGgiwBpxqNIYojjuPvhRJyLA77K72FAQPdjvsQ0hTh/W0PF1I8RcVeJN16Ibsk4iYARrDR/UsSv4qYMv90SDkMgsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 2 Apr
 2026 09:50:26 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:26 +0000
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
Subject: [PATCH V10 04/13] PCI: imx6: Assert PERST# before enabling regulators
Date: Thu,  2 Apr 2026 17:50:58 +0800
Message-Id: <20260402095107.205439-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cf5e8a-8ebe-4eb0-bfd0-08de909d443b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|56012099003|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	GgFj3+6sweJqP+KUH2uxuCmlwz8eQeaFRckKfOtYhA/j1dw/6rNx2y7ayc+y2TLaiQ67enIMKCKuyqMD0VoionDCIOOXI7LOtF6x1RYNB7zXCUnHWyTwQBxGA3/64MvPh5KhK+lHzIW+J5XLN/x034Q2AZOiZOuRKrCXNz/hzPjPmbu0XorcdzTeUSS26U7TVDiex3MO0svHu70HOKNJNwfNlDXq/fYFUZ50Nhefp2dxg+0EPFNPa0ZiXO4NexCSIpoNTMy5zOi/KirKrLZeE0qkmuFv1sSQVB86fjTnaUHNiHaNvYNkT7NWFhvW6bHwzLakuq1ODtI1CF/XIxHw9PJqCUfD22XaUqesIuBUn8m81WrSLseBIiJ0w+bfY4kaYNkOQOaR/HtdyTlra82ydoyMH07e+UyfD5aIVH/t2pdgTrEDhUbBn+cofLufClUYgFzbVVeNyFK2dpzR5xGPCBqv9/2xnkxXqMbJ4/tmyZds/MRTcM51MlvnGGmWEj7e/R4YhXH/nBe3AyNN6bm+zwYnIELomK8023261hsipaEMShptz6zEvU27neKzicKv2OxeCz8uKVYRB2BmlGgZvIDu8vNPh7YhR74rg/n+B/PtqPF1hzEjLcQ40e7IxP4iiygrn3nl8seMM0816rLXdmFQbFuGryWglbX+bQn0WFwErkKOaOs59J34RFyqN5gPlzHxPlEndkJ9I2NYf+WMek3pbgjluydOHhqwlkTkLQjoKgzdMiXzK8dFhKbxLMVLg/ZzpI3ZLgYUMeg1OoWCzii4Kuao427x6WIXykCKnw+nD28CuC63gcz9kVVGhkKx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuaZ8FMGFsTmXb65XOIqsxygeNG2YfCismdC8bbVHTzQcYTr7Db/RW9rh9Ia?=
 =?us-ascii?Q?k/+y9R0ChWLvciWfVNq2ZJqcDlqZ90Lwj89eISgxcmyT2mvyLIRBerTy/lEv?=
 =?us-ascii?Q?YBl3JhCD98y1L9jRQFScbwGqHXw7m2xALGrolWG8LSw+wzP76XnvjOQC9Pbu?=
 =?us-ascii?Q?Rp76E7rZv1ITDq6JjMcth1GMRHLx2mDvWUOjz4ZJx3eHPuHJO7A5rFPv5Mvq?=
 =?us-ascii?Q?h2yHfeNJk6Y0QMHQnViixQXz2bUiEFyKuhoIZPMOoW8NlR/yO9kM4OEu63+p?=
 =?us-ascii?Q?O7e/mfTodIjJ6pyYouaLK9v5qrIsqqsA1/JXP0UrpKdDeQDjKYG4K0aglq71?=
 =?us-ascii?Q?JkDKesOHLLGcTPdvvSbz5z20myKucKMozLjRhqmdw8BM5lJW1NFrqg/IsoLs?=
 =?us-ascii?Q?E1bukzFPBc9vWYNVtOMcCgPAb9t3pQJDNs2+X0nTZMAmF8ySFAAziWSGsSeG?=
 =?us-ascii?Q?gnIkW3H0c4eKMG0WA16ENGZjRSXoRVXW8kbZ4c3NrWRBwlA21WQ8A2ed1C6d?=
 =?us-ascii?Q?YIMcr7wbKNsJSojzh5z5ECI+yvkLRWGFaxIK6IourNXsZae1c99U//IBSD24?=
 =?us-ascii?Q?zQAE8gip5u1FWgQ2KAbtWZRrHqYy8Oda9twim7PN7X7BemMCjNxRNh22RTo5?=
 =?us-ascii?Q?5wZpRlmzC6uqY2vMnZ+TEI8Yejgup+Rxp4Uc5UBlbWCd/cPjKU9S6EtafFnx?=
 =?us-ascii?Q?MkhfOvJsAoAbVgy0nt6NK2sA513ai722b+3PZcHBr4FK0QFs0AtFh7LTy0fr?=
 =?us-ascii?Q?2TanAOwX3ie9blWHoPYqoVmKyx4iyCJJDST/m6hCd+yCC4kcmQedAR0x2XOZ?=
 =?us-ascii?Q?vIGbFyfcU6hKii9KLdIlyLtsrgEXftYue+hHGI0NCOpiz7LokbdXUfefQirH?=
 =?us-ascii?Q?wYW0ZsJ9qOov8se2P5g8dETJM1Cn5eUkT3siCv1Fo6v5stCDc942zZsTTVsk?=
 =?us-ascii?Q?xuw330O6q7NV0xMhMCIPIuWLk+sHmSEj5ll3PFVPfM4ETtC/qLOR9XKb+MoE?=
 =?us-ascii?Q?C3daJi698OXQCB0ySXLb1ROYD+fFLkc23JRIJusGlzKNSvBRa3fyAJnApPh1?=
 =?us-ascii?Q?5s+c+Oj3FuHnmOknyKz/sXXtGf44VLMB6gy0ukEt8WHaBHZId1l0+VyCljWS?=
 =?us-ascii?Q?UybJ1YdzsuqMHqEx9HgOXrdHEn2Dc6yriu8eGILs52YLEfvl2r9dOMbLEI58?=
 =?us-ascii?Q?B3Ov7wbhih6u+YjPK+qgSUsnHF8vNUpBUhqOa8sgcjnxZkKyPcDzyMv0ZWV9?=
 =?us-ascii?Q?TOJ0FC6u21lEW96CIWhU/zd2F8JdvCK9QxlxtL+05ML2nSDjprYBfu7lWEHh?=
 =?us-ascii?Q?w6v20MzfmO/LYxlJ7ApeCrGNQGQIesUc+xH+V2ip8SmAx8T7fefBs0os1tcT?=
 =?us-ascii?Q?vP/jPCWX3uAYiIz3PZkcn6OfpZSD7wVqQ5+eio3t7j/cFnUCJlmGEJ3+humb?=
 =?us-ascii?Q?GgNPN5IVXjUigTh/9XiAMxYuBNYOpok8CpJxlSf3xaVVe5kRolrOXbXy1WMf?=
 =?us-ascii?Q?M43/R/Zj81ggf7uUL+7hnST+nZWIXeLmibK9GJWsCfUEnxv21Cse3i/JuF6y?=
 =?us-ascii?Q?BB3rmqX8+NKt5Z/o8+zcRpfCc9cg9ofJKLfo0F49Bch3V/H5ODJrQd+z/9Q4?=
 =?us-ascii?Q?6llR84qRvVPX0dKMYVL56avJEeuPON5AxR5YjHljsNJ0o9H5CBQHyQjC+ajK?=
 =?us-ascii?Q?G9WsLskc3yZxEYxYz0czOm20sLnoeteO1ns2gVjOXy3DiqiXk4np0J35LsBp?=
 =?us-ascii?Q?jZdP41YTJQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cf5e8a-8ebe-4eb0-bfd0-08de909d443b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:26.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae9/P6rK3rhnn6WEezZ9jhZtN/wCcalg5Yeagwvc3HJN8b2lzDvh817b7Yrifz2sIEtjeD4FL9nVYURS4K9Z3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

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
index 45d70ae7e04f..948ffb75d122 100644
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
@@ -1780,9 +1806,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

