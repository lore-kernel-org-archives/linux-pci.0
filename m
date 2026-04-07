Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD673A785D;
	Tue,  7 Apr 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558528; cv=fail; b=SHFvEbXqjEvMuczFr5yw/7YM/P0Yy1v/7MsBvTqLi6lghZAXms8E+iRTrUoTVy+0aBKShwcNEk+8Bz+M3nZ5WoqsgTNwVgwKXyV7dgGRJ3Uakf/FsYbq7z1u4lTm6RpnEEr8UQwnXc3jEauY5nchpV0oXNiU+QUdx21XrGDBmWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558528; c=relaxed/simple;
	bh=CH30cpcEUTakAp7SrhLSxpXnoJIFazC4NhE+xLWZfWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRi23u7Nwct5QWaayU6bsHRrEB5t20akvY08djY2r53cXcz8MrYXek9tzmTziak4etepGjnm6lo5HywojR0ms+njv7V0Ould449MCaMajkTljIwITWs1gkr4rESBNi2XXDQhaHspgRjIR4oQAxzr7xvkgySJZLuloNY7XwD61FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nLmeO7Cw; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nLmeO7Cw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDvIS1hXg5PU2LyWoSW679jcP1a0NOcYZxEgI3XZJgmg5cNP/cPGpaON6eJcumZL/URzAHp3SLjnUkbVWroWGxvmiM14JEya9p0y95oNzYWBI8MSeJthqbOOwHOvlURFPHC7xhQI1KgrvPnuOMe8gG5JA57tFzlg7jlG4kqr2W/o3GXTZOEX522k/VZmx9ZlhRVXl3B/Fr9n1Gr9clykmak14n5mXhANz6bTlapK3Qex6mVvmYA2kCJp13nVDXwkzlvlqn8LWI8oPjl+5cARuFxq6bheP6IToq982dgN2dstALu9aEqb5fYe9nFymU7hjDPi1rZOz8T9gxW34yFB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oetyax/zJKsWLe34r4BV8nO3nP8kzMsqayC38SLS5ZQ=;
 b=jF7f2c0qKV0v53Ov+E3d5sE/yYH7YZhqaKH825C4Ag8D1TG4xkMQVVmLL3JB3tgeyHtSzDe40OOuxzeiRhVyw4y3ne8m/4NN47qbCju9s4XpusD/9g0m3znHpMIyokp3jTjuyxvT0pTyav8eSV2ajhqDnwSP3TH7yVCqnExoDrl0WBaq3Q/rxwMmOnnAQo9ATAUrhxRRJD+jcVGrtDKngidtOlfGfbLDWFJbGt69+N5TluzWhII3Lzgd7hMQswjDqPn50TFahIsHPEsjXne9IJvaP61B632xA+aH4mxbj4uI4boSjJCBGBwt+eYSHNEYXMkZhQAMvg+PZUHU+uo8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oetyax/zJKsWLe34r4BV8nO3nP8kzMsqayC38SLS5ZQ=;
 b=nLmeO7CwO5IGfmFp7u2YU+clx+3eOQSa17f0UIqz+Ii5780ZIUUZ5MpK5AeR6eLsFdyG5meTiOcZUoloJKfMM6G0F2A+DI07i+RSy8/Ana0PJ8/brNf8LXiyBUa4EelZjWH5ir+1Eqa5/MNBDoIJXpzXKIrqSartTm5aKnVxSmOl41W/t0NmbhqSaoT14usrsHQABl9mJhPo2oACMjmMkamaohUdqvRKjsZaSV6DSniiMJjWkCSFdnlhmev8fMHMgpb+5YeJQCtK5u3TGA7jW7tjBRkreqjDDOuE0k/zavbLlwYAajV8uE+vM/iLwgnQ2ZKhFrJlYwUwB101TL56Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PAXPR04MB8831.eurprd04.prod.outlook.com
 (2603:10a6:102:20e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:03 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:02 +0000
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
Subject: [PATCH V11 03/12] PCI: imx6: Assert PERST# before enabling regulators
Date: Tue,  7 Apr 2026 18:41:45 +0800
Message-Id: <20260407104154.2842132-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: d5188ae5-931a-461a-c197-08de94924e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sYtC7vKc2XiifvSABT9t6a0Xrpuryn2LsyCOOFCugI74YmoTTt2EUu2CkmDjydxFpIPweSUNae4vlRYR2iDMvrirBxGKyp5ysYTn0eA3w3lUwb+Va+U179ISJFA1bh5IFBFzDrJg4wFHwo3xbdXsVmlIFPqUA8kj1jr2qNFuQbkbCuci2dFo9vbhn1miYx1LOMIPyNXPhG08Z3/Z5QQguKeAL81ZaVZ3ztL+ugY4U4trMByxob4c9tVZlJ6h80qpo/ijj557TTuNWYatFK4meYxeODfpiC8LhKEJ7HLBHd3u1fcqUL/3LzEIdmlrIa2WPsoCO6LzrsRGKD0p71d0VG/aycxJ1wV+bKS7ms/guZPnC3Ls4PUivP1UdC3+2vKVrm6xxvqwN+paapgdhhDWxY4xbsebMydhs4YnPQv4ny5HWEn2Upt5rnqVyI8XcTUsWoKIno3lfpgcTWKFNc/zJLZhvyzQybKbvkmjKZM0I50CkyE6FaRcL09IBmSL/HJ8FhhoqC6O8PWqtZUGPEp10RR6/o7XfXLEBcYCmDFhn6viZKfE28A8HXSWTcYbX41SFfq3HsrXN7+xNxMyKQQ10IFPbAggISHymZbkzJBmv17eE7ZemYcPY6QOjDGwBHCfBtRWyqb49e/Ej4ejgifDbjt8eejRmHKkoiMIaQtzxTahaa40ZdaQNsUw5K4E+sRudp5M5Vchvcr6JU23ca8kQQXHHFY/ZivWTKRA67zSNKJ2ASh5fPX3GjMSYsRrI4vIzpDFb+8U53ZshUuuXXTLN092fkwStNntQ0/Wtt+/+/Red8t+lAVZPTt9Bly34c/3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAfSe6EgueGG0gOHpkS2JmN6fq7kgldF1IEmxVHSzq9IOye1968w/27/x9j3?=
 =?us-ascii?Q?xPogdT+1O6qzVHFbyI6DkPqHoiZLPD2p5/nXTae0VlEI277UZQ/FEPKSTy6t?=
 =?us-ascii?Q?8vijlfr65A2aysM+yTx93xh3C36mNzYtYGDiUkq9evLJYlSelK/xyJlAAl17?=
 =?us-ascii?Q?NsQTbXD4Omg0JXsB1gECHUZsrjY6MFSKibLtKqhwLN9Ellw1M7/0/dkEzU4n?=
 =?us-ascii?Q?Goi+ykDtI7BCqSObOupsZIp1YPUlMl13CE3jjkpT6RI/8eexvkTQmGJ5Pmye?=
 =?us-ascii?Q?AlyBW51fa3gUcjp2BfyZJnSaezzGLRqn8vAC6Oro3iVZB5AmjcUQIuXD/q6j?=
 =?us-ascii?Q?uIKVAiXfaox/M4w++Va63hJwanoEJ3+3fm03yCl3On8/VBx0c6rVcV1/MAmR?=
 =?us-ascii?Q?A613wq/dZD+KGm05P5i2fYo9ITWrUdLdG449VOaqRRJOhieJHskWboWjIcvm?=
 =?us-ascii?Q?IhQPsaHZoTqE8oU0t7WO+B6pUNubJb+6fiZ5qlkQ4s5rLCVLDa4raHCzNXA7?=
 =?us-ascii?Q?uaxJTK7ehnK92pLGJXL3FNbdKKeVIAqH9ROXJFfe8ZlqanYCXcjjJj2x0Ebl?=
 =?us-ascii?Q?KexW1PTgN+DPb0LcR0aAxS6aDqYkgVwCK5+mUIHOaBciN1tpDJNlyyuPCytI?=
 =?us-ascii?Q?J8gqqmI4XxPgVcKZNzKzLEMITnawo7OoE05DUDdPtOlkvgpc+kwGarGHTzGf?=
 =?us-ascii?Q?rdb7RQi7SUdUOKkf1DCi/jN8IH4D0HZgsV2kwvMLtYfKVFGIF2EjVwFFils6?=
 =?us-ascii?Q?g2CGhP7p4VgHD7u+Sl1y9taru9cJeJykP8nNjTDR48VtUYbEc5q6R7eCML++?=
 =?us-ascii?Q?XjYVxr2O9RM86wWEt4kOgapB6HCuOLN+iWfLEfbR1Sji09NGJRPS6ypX5B/H?=
 =?us-ascii?Q?YS5eNLRn0ov0bpD3nGpxzDae3GW1G0Sg0fK6/3xWFzxNDPkIG0Tvam48rbBT?=
 =?us-ascii?Q?5/TLb0dOIeF3goSotMhwaIctByBYuc7AE++QZ6dx+AUic0Qq/hEPlktY+lC5?=
 =?us-ascii?Q?M7blX+EM838KB7w+DgteXiOnfJbDUU6uv/KECrNbH9omxXEGXRptq+V2LEnP?=
 =?us-ascii?Q?3DrE7cJYW9gYrXYBafo003xjlMXfElrPy5/Oj0gU6SSLi98N3izTPO0y0oX3?=
 =?us-ascii?Q?SKnttJknOfh1BXNjXLOonxeboPSJgPF4k/ajP9VxYjHab/U7BoVM/CDYMF1M?=
 =?us-ascii?Q?f3RmXE4Xd0WWuiDOsMyAJ0qmftvurZ4hgU6iqRHzaprTCfyX1dAOe/uP0rG8?=
 =?us-ascii?Q?pSV5U8R6KGzP2V91RqFCJNGoTw/akAskz9Wqp7HBpTcJyUwWQWBtqF66VRCt?=
 =?us-ascii?Q?QwZmpspal73c4Y39HT1ONXoPixRiIG7zuaY+b5wVIqTkGlIpwPWAR/YEbVuu?=
 =?us-ascii?Q?s3nH1wFQzU+8QzlyMc+KfG/cbt/n6uwBJ4v2KdC6g7bNsom0DLsrgAxwqDrn?=
 =?us-ascii?Q?B5HD7DjZuR7rPBXGNwWruP0Kq2/JeWgYVEYBYiVoHfwFZCou6LVNOmZTXmds?=
 =?us-ascii?Q?FJr8UDZ/avkNIiLEcKMrB4M1w68ot3e9HoQJ4TubWsZN6dM/Xxfh2bx0UwXt?=
 =?us-ascii?Q?vdlSvkNgpzA83zTMhW59hpu8p9L3F8SJXMF2fR2qFm0dldKP+3ZsceYsqOUW?=
 =?us-ascii?Q?o87I3n5fNeIfrj7jOPSi9TWp8o9XhUGjvdzV3JXRxSYXHFuBZcUna078qkPM?=
 =?us-ascii?Q?dVktJxTs/rIi6JxgHeRSjPKUmQ6tQrvSjSHzUI/dbWgwDYP5sFdZLYi+ylzH?=
 =?us-ascii?Q?jfV2wYMw4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5188ae5-931a-461a-c197-08de94924e07
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:02.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buJ8allCc2YWbK+IqxA1XoBAkzEtrZHOYtt/2riRIW14KuiDKhvG36WOeursN8fro6Vpbr5xwOjemK7G1G1unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

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
index 915061ea75b9..d99da7e42590 100644
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

