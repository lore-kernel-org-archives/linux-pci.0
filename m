Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315043A6B9E;
	Thu, 16 Apr 2026 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337992; cv=fail; b=sU2AwVJ1bKtUJU3E1Shljx6WjHlihGhu2YzSlFfBTGkb2UpdtFM26sDE/uScTWcde8UgxgHDzPmUQMBk7PK6TKsZ27HShJiS9rTBdJIIQXR0sVVreDL0ZNROt8/56ssAhnMevIX0raOMHHeTO1F+6PYsgzMwJTUbF4uPp01FoXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337992; c=relaxed/simple;
	bh=B+IUcdsIJ2cNFPRVaG+xcPg4bNSXo9vHqnC7VOsbhpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxfHZNkzHnXke4hp/oVyBQlQ3Z0SBwHcXo20zWpPsmFAjY3KE3hxUl0f8HOvFSaX5RjXjveRjsGNTdl1FhIiyf17lAFGhj/Y8MO9HAPPmmZ4/mS8/Hsuw4skWmZYNZ29Gw3sd1d5l9r3C77JABE42CSZUj2IyXupRoT+jLD4s1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nTiCyp4s; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nTiCyp4s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2DdRnPfjAmOoCR9fPmv3GgwWcCn67ol1rdLgkImDsadPMJrcgQtFNd+rYBmuyTL2PVhB1rb+ysAycBvQXbZNlnhijKeGoCNyIc8Mni52etVOSEQMgIugJrgWXc4sqxPtJg8abW1mX9zQd9fzKdplIPQ7UazK9Ot8LWOlrYzdUTEKjcDY9JkdASYPuOkz/i016qlgrrDQnKW0buXTDwRbGmaebhkUfPmxYaH5GmgPRVqkngKMY1ACsBv8TaNHEbAHS4+aYk+PtMbPN0O9DWiZrIF2DGPPe6t90YIHHZinyx3ZK4F19NQ+gkE5VbHy7r2mPosgUMCc32i6LIghOT0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGVHqOPs/4jMGkcftvgjRX5BCFrejfz9iGaZzDJBg8s=;
 b=FMSTzmPdqfz/fy8l9vfrqUbSaIJ2G67odFLr6zVKU5SCmNHGUyiu1qhi9BnGyYx0X6HwGysYp8IBd0M8rl4GtO2uBtqIkrxfQDkiCtDcPBViIXGrbk7+CNfCo0WmRWpkvmsQBdhYaWj9L9Szxmm107eLkaBBUm3jQoEud6VRrDMbz6ABW/iWEixhtvMgtuIq2AUVy4NzeJ11BEeM5m23YmqKuOjZaxCoqLBNOkA+wuL2k+OgE6NEqID7zAVPz7pj95MMwNlol0bIMBYes6nHd2O37aAaSrwmRCxRkAgEnWJXkbsIzwLDma8Q8mfH9qNkeyfxx1ad1/4bobk074/DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGVHqOPs/4jMGkcftvgjRX5BCFrejfz9iGaZzDJBg8s=;
 b=nTiCyp4st81yTX7ACgopFjVtUd5tYEVE0oSYuubPscjDF4TwornARmmsGmKjAc68ubGm01o+c1ycXtvTFsLgcOA1znMphBXvRXXDa2SPzeBADwww9L03cKRwcT+EpJfC3MaubBE+jYzevOKVA2c3GwqOW24o5a9kPWbkXnAdCMHDYQFWof2HnEuIl+b96SWMRzVl5r0I6xz7366b/3n5X6/6/1qFnys6f227KeqWX+bxq7PHYnk5KNTa+Ps9R9jSNzkDysXrOKgcDX4Vm2FoJeGU6Nuf83uAKe4tj70c7avIJsgBuMd31DOYDkOoTXTnjD1xL0F/729HefG4FxOARg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8804.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:13:07 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:07 +0000
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
Subject: [PATCH V13 03/12] PCI: imx6: Assert PERST# before enabling regulators
Date: Thu, 16 Apr 2026 19:14:13 +0800
Message-Id: <20260416111422.183860-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: df8c594e-962a-428c-4506-08de9ba92360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|19092799006|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	BvXq88dyeqYlPSt2gUuJ3CJ3Yl4XjQJgDd9bb86+bM5mPQsuQ1r4B8wc3wiEid6aszkDGNWP8kjvzJ3jkPBQd1NKF4DzeVFTKrow4aUFiRZ+9l+jIx9LppP/Qjwo6BAfM7ao3g/jWJ2Zdu+RjoNH6f6vnccB8yf3CSv5zURKnkoVmw6J5qJFb33Kh5QGhrElbRMmDGDrKkeIASZLQqdl55Nvujbi53xmfGSzhJG6qSjydLlknzsa5Y2UeCpHjm3PQ7FNciy9kRUhzc6cgSUhsazkZLtlqReLjiSaAfHlkKUkAz36ip4pvv1BqpcXg49Vq2UJTBzahSC7Az0YukFSevr/P36R6gu7FrAdrU503AwabFhFQyqpPwwSHUTJIp9P3avqUmc0tyEMFhenzoLpOv0XuhHWhuthpRnOVNZp2kH8OgdxjP1lYnmecYOUgoGwu+nIn6Ix1LSXsS33jOOev79PPbwMh8hb7LO+eyzhjbXG9Rhf+DhwG16SV4N/6cStyY/Bz8cuHSY+EKhEIojStPNbtSezHFYKUfZY1Y+dHuo8yCQ6BKl05MFBCDgJzfmcU8ZnOz5w5qywJ3nqm8rTL/9oBzQ9Jp0Rf8F5UiyAoaOTNPZQiP+dSJ0s1QoYP8cHAdD2SXWkbSvWhCMGynLyy0T/0qhKLlcFVyhhz4VCNzYt8LRI8HclQB243KPntbPnojN3YChoYfL2nxEtTYJWMRRDHGWNINQ2WXkGI2Mt6/Hv+KW0tmQ82dJ359Ht3q0StHCufml4D9v0QH0gjh3kJfjXT2B9p7JHRnx1du15ziBTfNnxcTsgGY3Xe4Fdfxrd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(19092799006)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pvjZxRQ4W+wL95iu+5oZnw6hK2m1Ofp0pziWQkxdK1sJgoIDZa+UIOq1O0I?=
 =?us-ascii?Q?6pkUnuX1gZZtjNvw6tJp7pIdZKpe/zMbKwYvHmCNHpVcrjvOsaD7KNLnVyBz?=
 =?us-ascii?Q?urRhiOqpirDzUKC16Mv0QSr52Aqn3zazo1+Cd8TxDrjoy8lwqVOGwYYHEOSr?=
 =?us-ascii?Q?hKTwdD+QaLIAL5UNp6mG12ZJju80GKd5tutCoxcfTUp7/Jml7qHy9645FVTH?=
 =?us-ascii?Q?fXIEM/nliMGYfvbBdpTX18Kv7J2NZVsTUY2xyo6aguBDacntx+wVX+ikyHoV?=
 =?us-ascii?Q?sfcE2siNFMiWkeXmpOW7evax/Zs19e/a3TLgX+GwMmDRWRvCVDDZROlSOByN?=
 =?us-ascii?Q?1x0EgJbbrmPuZHCDRmyC/XwxFV74abaxn69D4F9HjiKr6VlBB7HThmGolAu8?=
 =?us-ascii?Q?KgOKX6YnMsUdHOCp2JZE7nV18uOPzqi5T4bLMQHiX7jE4kL/LSkN2zsyvmux?=
 =?us-ascii?Q?/iAlKW73VQc5+zds2TWkt93bCEML5MqxmVIF3I+bggRWoWnVYNlXyU+Cr2/4?=
 =?us-ascii?Q?voB3FUcZYZRy7+EQeUfP/+TRhrM8rPTwoF2aU/mm35/zSTkOAS0YeAzmiVGV?=
 =?us-ascii?Q?+XrvmVJUwyMCT88wp6MYU4gXdGMjQ04hJk0m4piFcXfbyBFVJI5V8U9R+JYu?=
 =?us-ascii?Q?ok5lvqiq3rf0mceMZP06qbY+w7BiTd/c7TF4X4Y3GPxLaCyZoRlg/z1CyDKh?=
 =?us-ascii?Q?9z0wFrln1qHFLYe7NWuNX2pnRGgBpCTesd3y4L61heRfUt3lDZcIFEmOK+WS?=
 =?us-ascii?Q?raajIaMb+Yc31nvJ4QANMjWfFgZ0YxK55+cQbO9JVGo1mA+WVPCkK1e1uKJj?=
 =?us-ascii?Q?zc5xv5tc4lbV/nM+47vvTOo0Yv6dVnIz8hFouippnqzstiJFE2YxdbkldDex?=
 =?us-ascii?Q?ec+GmN4M2j9zWOy84tyXvNmnPTQsfZ625lFCDWrFAf37Oj3kvZlxQnD6q8iI?=
 =?us-ascii?Q?txGKkviRuGA+i+LKYE76K4ocVeNiunVqkJJ9YZ0gBTJu6DGVqmgs3j1wqYPY?=
 =?us-ascii?Q?+fBfVop7jSkmvjkel56AAjFTj977xzcrMen0yIPjYk+MvNTjZc46v7fbdQsz?=
 =?us-ascii?Q?XzErdSKrD6QuoxPwlaQZLvTf6QyvQb8kH1bqGJzriVmKZMTYbDlVHMsBEwRQ?=
 =?us-ascii?Q?G+09QARJmYPYhy+wlWYv/Kp5ZzdaxKaD9CJxPKQyMfARlCvMl/kb+U9TxIyR?=
 =?us-ascii?Q?85NhRRs9adxCv84KFjZeFJGKLIXAhRQf6K8T5/Ny5+yGAs9C6q12W7mpfuZN?=
 =?us-ascii?Q?veEdfS7rGFZjhZBS/5vgUQhrb16v6BPWNHF/6iMusYP69/3Ud0fThqnxIVHy?=
 =?us-ascii?Q?V1j5FUVZBPcJfVOpm4ASd5dF9E+F/e9jKguMobQLmFkABGqSTWEExujKB8GB?=
 =?us-ascii?Q?P73nAg1+eRvD691SfRAw5X9svIV+ApQP399oEVn2Oi3s5tiqwQVinzD8kQyD?=
 =?us-ascii?Q?rGQ884WEi3bohJK0TaCeMdOXZTjLcbAr4nibIgllJwJ9gL+zWujEca1co1x8?=
 =?us-ascii?Q?FENfqRLR+hsn+V1PHEo1uveKG/CdnhQq6tLn7P+yo0LRKy6I2omJVes9haYx?=
 =?us-ascii?Q?l4NG1Dm80raFvIekLAtMslqu9OqIsc7fq34uSQ9jYRQU717JdT4kNBim4qTA?=
 =?us-ascii?Q?B26/WQeAOgTZpY+TbP1FKqjBkjsmi94CY5erXEJDmfHQ6lYW2zSvcOFapTAD?=
 =?us-ascii?Q?F8gWNe73hXQPu/0QlIMtwpKtIavkoSWmQYrZCZX3HN7fCIAD0FP4/vATva+s?=
 =?us-ascii?Q?iXO59HSlEw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c594e-962a-428c-4506-08de9ba92360
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:07.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/1N35lPVHHduUoTj5pJi1xDAXgeS5jeSDjk+un6/vayCTJU6stbklaHXq++IjnPa5MgIB6fU88npZ5sdlWKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

The PCIe endpoint may start responding or driving signals as soon as
its supply is enabled, even before the reference clock is stable.
Asserting PERST# before enabling the regulator ensures that the
endpoint remains in reset throughout the entire power-up sequence,
until both power and refclk are known to be stable and link
initialization can safely begin.

Currently, the driver enables the vpcie3v3aux regulator in
imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(),
which may cause PCIe endpoint undefined behavior during early
power-up. However, there is no issue so far because PERST# is
requested as GPIOD_OUT_HIGH in imx_pcie_probe(), which guarantees
that PERST# is asserted before enabling the vpcie3v3aux regulator.

This is prepare for the upcoming changes that will parse the reset
property using the new Root Port binding, which will use GPIOD_ASIS
when requesting the reset GPIO. With GPIOD_ASIS, the GPIO state is not
guaranteed, so explicit sequencing is required.

Fix the power sequencing by:
1. Moving vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init(), where it can be properly sequenced with PERST#.
2. Moving imx_pcie_assert_perst() before regulator and clock enable to
   ensure correct ordering.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 49 +++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e35044cc5218..735127ed1455 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -168,6 +168,8 @@ struct imx_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	struct regulator	*vpcie;
+	struct regulator	*vpcie_aux;
+	bool			vpcie_aux_enabled;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
@@ -1222,6 +1224,13 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
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
@@ -1242,6 +1251,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1251,25 +1278,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1782,9 +1808,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

