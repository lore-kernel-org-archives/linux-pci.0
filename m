Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED03043D2;
	Tue, 10 Mar 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107621; cv=fail; b=NpaEMz8oFwrRirZm1KclPrQINIeGDwSYGQVqLnODUoUtS4AYdUUPLwImTVQMjxUNKWZjoZarFQZf0FyiEkFYtGKKT9q3jmrRlwb9EV+Rgq91CC39K0+71a1m7um2aL6gJU0xAXTJrurBWBS0Ms+SnKE8Vrwu+dmhSWibHP5wntY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107621; c=relaxed/simple;
	bh=w+VjJyYGvfEM67xl7MN0dToB8X245y9IKFQzsjHlDPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHth6lV4UFDf0EdQP8U0BySy5DOpS2gzEt0RGI/wIc4cpNpZSeO7SG/3/wdu7JMkrr/+vqBsDxwnsWsWXn/fYB2AogXN3GJudE+XJ4ysOGOBETWWZ1JyQyjG+BNMVZUYEVVFTCTYCtpSsbjULOrmnt9t2ANGp6eP2EvUJeQ725U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cFx3X5+N; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cFx3X5+N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+O4WZXc0u3y97rz6PnnB6ShT19SL+PwAZDAd0smfmiPeCmrahiELm9OBlEt5z/328MJNS41AuZzI878ZC+9spG4kAK/Pvg600YElqKmvDAW8p+IwEQKSxmQCHGn+xy0tcvZ41MmZHWzFZuifosLTrsfjnVIuYjYMgMWtYFLyY+scD0emYcAMce7ToYAzVZpqnWiuKBHBn/EXEhJ8qh/e/yocAPaoPCx6p7fhduy1ixfYpDRHpVvb2h3RD+CFok5GRFHOkQYnfruuagbYFep+C07HHY0lctsPhpBQI/sJTNXewWS57HdsuXxkyEoHIS9pzebTozvAWTC90uHNlHsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjKAUIiC1l6d3KLtT9qWjcnOKwOGkxDInv0g92bRMUo=;
 b=d0fzpZqBq8b2TfvfP6Nq/YLPzoh8T7uzprvOUt1BoAzM0483FHlHGHKOuxA+dbhSPJe1ni1fFnkL+OVsRy0mXacLBoOkhOfazyJ3XpGRQQOulMDdBBCZlN3VUUaDjj/mCEZ3XIJJ8bPADj0wS/5E02opnonCr4G4xzhiUItkwGosKrjKgaelQR0bqfFwwaPzZHdrZpGfY3v1pj75fLNvWpMIkZpygKMHWQWUIDbu9Z59C34bnBpzAabFCPFgHZPgrvG0i2edxNBeLC4+qrKFbNfHB55wZUz0ufsW2Znd1aO5Mk5yvZJlpF/UpkVqM8qd5x2lKV1lT/JRSlWczXTgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjKAUIiC1l6d3KLtT9qWjcnOKwOGkxDInv0g92bRMUo=;
 b=cFx3X5+N5LjEeGHjh9B5FJTqKNqW5GPYAyg52IdFoJtg5Mwfr5OxNS+YL68lwo6v5DQ9lYEFFntLwNMUc4QGGp3yq1QxuBW3DsSnqEiu+yyhMElFqYiDyKHomST0U2FGah8+exSDj/SxP1dH695Fhd8T2FFRXRjWu1jArBksPsYaxeJp1kn/p3Q1a9GAAzGBncGjpMXOzFd/k7EBWtL9n0YuQ+i2Ehdzv0YYNco4P1j1lOs0hx9nCAvX2IkDDWG4sihwlABZSrVOT1DgnWLl0w2VFy26/idRzWu+qg0+ICXJB6r08cU34wJOc9qPBk2Ml5q6KAh0HXM0UNwJ5gi//Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:31 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:31 +0000
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
Subject: [PATCH V7 04/13] PCI: imx6: Assert PERST# before enabling regulators
Date: Tue, 10 Mar 2026 09:54:17 +0800
Message-Id: <20260310015426.365675-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: a8009c11-da5c-4690-8bca-08de7e47d4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	s2bCl3lBF7saRKh5oautWizLy3jjMt3GJTVDY/ZJxP1xlWVDuq+acpPa15ulYui4WUeI13FwBjxMXDzuUTmiwdmKlHXAFL0iwRssQnneJMlmX2YcTPCtDNfDFQL+xAqTAfhDXbWUCI/eCi8zf3FWJ1UihuU64EQoOR5WiE2rA5yyRF+wxmbn3LFf45MVTbjpbY/mMfWF1tp/rXc012G09mNEJ7uKLm7ih9QFLXInWStu6B5cz+CQkNSIsFxgSJL9LwaF2KLyRjfJgWmYNX9UOloIDY4zsg1wEEbBsKUD9CZf9SEdfANozfGUv4baqrgsJWCI5qBJOqZpiCr8un0LAGy7T4Hcs3LWkfL1AqN6jzgqA4V1JYDh+kLWnKITDjGPvOKRAG3JCqyNqRiCluzzindDo0x0zBTw4B1m+BxNoAV+dIlQCZU7tHJKYYDCtTOdl4ko0SmFYwGZi7ygOt38+7vqO/ipEtJdi0b5en6k1wuI2Jy5Ow5T55bWIksyg0keQpbW7Q7DeBUh/I0iZJZWQlFLY8MzyNVOIqT1kwwRKPs73Zqa8WKTKYmsZ11k/vDJJ+l+qbYE9IC3osWvN1zPEvTCDpXWXpAgyZJsBszgzZq+b5RQdjZdXg/4/FNrwoj2KrFdNdKKuzdvPqgOsR6T2h5RS1r2N9Brv0viBQomjfOHjtFLFJD7VSuGE9aQBXw8ShPrVCCYC+1EcSCsb/OEzAMwbLyfj8WLukpfQVuJ8Vnl4nnYnOWpHRBIYG0zyT6jU0T0ArXpMHcSMCvO0ytAmhZg53nxaPfkpkx31w0/+Xxm+quzDLjU8+D1TGxG4Ot5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yyVp1sCDRPm5ZTD0eRkQDXBHfA6er1Qsq+wl135RIMj+O45mgd9s4ZCTVDA?=
 =?us-ascii?Q?8vNwEwLAYHCrteuLNjlnzHPixMUnAkO4eTK+o+CGxnyi9WN/Fyguqq8j0Aip?=
 =?us-ascii?Q?pYeIdqrqWyInS6LKj+0gnLPq8ljKr8B+SZ3WEW4lkpgFjdOVXKj/iZMVIo+M?=
 =?us-ascii?Q?OBzI3+HFsKU+EB1T1Swv7W0lY6c17d9VH3HHEQoVs4MROzrQXCy1nkyHIpNY?=
 =?us-ascii?Q?lBWXb/prGbBkHv933YE18k2aLqPPdZpvaoAoWvUH2DuajuO8pSDMWmAbNY3/?=
 =?us-ascii?Q?D+Eqo0XiTxxpkYJh7txlv23VcBwbLlpQ4SiNeczz6KbxcstwwUOnuU/HT8rv?=
 =?us-ascii?Q?bk7ENK1QGWODUFdp2S8LJ6VASBSSrgnR1LIixyamTnS+14uosdydbTwfhEvn?=
 =?us-ascii?Q?1VdhyCZVgG4JjTzVpH6OIkhlBU1iR4WIJBCWcVs2zHGw5p90tyu5Yg34mjDi?=
 =?us-ascii?Q?RKF8CG/7lKraZahUPB3pTK2cy3jYkbOHLq9BS1uk/OVc4ea0YMTFHHaVQ3Ij?=
 =?us-ascii?Q?dfLLJq73UhPnXszn3nvwJzkbkKDAstU72IwrLZ6k7DXK++Co2/iaWOKhp1TK?=
 =?us-ascii?Q?blslQ9t3z44LEU9fVyAGAbs3MwL/OUrtk6VllLDouny5XV83illqM7/UwkSM?=
 =?us-ascii?Q?E/gjaIy7ZH2xUNhKzu9Ct+DKs7GtZac2XBRejISoPdkoFWGggo+9SlaNUHHs?=
 =?us-ascii?Q?40ZE4x3DDsOW//DrRQqb31V0dWemDS2luQq7zS31rMTlex2xsn0D5AGfO6Sp?=
 =?us-ascii?Q?3vKBGJlvcdnJaH6xuxLBMy5G65aTTMdeKlQMXeUvzzYtwY4TnDzQ3l4r0313?=
 =?us-ascii?Q?xZkhyOYRAe4TdA0h2InjbDB/AJYjDuSnYcur+bxrloFqVRg+cDiX/Uy87CmE?=
 =?us-ascii?Q?vRWjMoTw+bselwOEg1ng2qxef99XwvUBfp9hEW87gUXojqsKD3H9SlYmIJEw?=
 =?us-ascii?Q?25/4KTb7++WWkS7pouunXy/g1rYqQmzBq61aTilUNMiCoAA/h7Qz52NQdnDY?=
 =?us-ascii?Q?jZaq+Z4RqlbghICNoIU8AtFwwyxwSwoHHC+FMp+y1AOQTDV/8aN3tJ0nZG5x?=
 =?us-ascii?Q?qLe/bmt/w4w1XingppKU+7kuU1Y86GjEJsQYCEHi5swzJ5TOTQIeM8MCN1yl?=
 =?us-ascii?Q?JHUF0FuMTdQpZVo+eNptzN7fNLFTy4pbn6e26q5vHw/Xm9HSlYnd5nF9c1gD?=
 =?us-ascii?Q?NZBOdtUC1x8CwV5jHEUL2sRHUF8hHqYtaQ0l0bXifBY6ZcKe2X1ARowQtCT6?=
 =?us-ascii?Q?jrjJNDvZemgREPrRnKJfJj04JuAFEXECSsNJKCHbhQZOQB2OI2ARR0aw1yWI?=
 =?us-ascii?Q?wL/xU5QNgDqNsbNY44YNRZGr3obSSNFid+Bc3cdQCfBgRcRIpwQQeeEaL4Z8?=
 =?us-ascii?Q?OF326SljWR/2xX5adFxBcxS46Y9KkAXJ3TqotyZ4kPOSIXiHYDKoU1/zq5Dx?=
 =?us-ascii?Q?muLk1vT4mAjW6K3wcVLaTz83HmSq18bnqKgvgTEf4DcJtSCn4EWE9tcIYcoG?=
 =?us-ascii?Q?CkI0QTLO/D1Lo8BKVOvQIf8JVWKqSlywbD4I2KmEq74Xtc7/9K4IeczaYVYm?=
 =?us-ascii?Q?u7RvIeixwBBNm+fnMu52CjKb0kHyi7RV9YNvfvTVVg7Qj+fGw18+nmmiUOYN?=
 =?us-ascii?Q?qUcPRzmRxgOElHVTztBNUz5znpSFryKNFKclzw/HUBubcQzBXqvlabfClpnb?=
 =?us-ascii?Q?k5IcV5Wm4YHcgJzV2rNpfd8wCGJkZUwRgGSA1CeoSzCeQbHkNglnDVjx+xvP?=
 =?us-ascii?Q?BZKbXVHEPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8009c11-da5c-4690-8bca-08de7e47d4ea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:31.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngZR3TB3x957byifHBmQzJ/Od2AoaVU1uyOgNRXdro4jp5Hfe87Dvw6PvdMmJAqGFlZvsbZGdi5r5cs5I8E+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

According to the PCIe initialization requirements, PERST# signal should
be asserted before applying power to the PCIe device, and deasserted
after power and reference clock are stable.

Currently, the driver enables the vpcie3v3aux regulator in
imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(),
which violates the PCIe power sequencing requirements. However, there
is no issue so far because PERST# is requested as GPIOD_OUT_HIGH in
imx_pcie_probe(), which guarantees that PERST# is asserted before
enabling the vpcie3v3aux regulator.

This is a preparation patch for the upcoming changes that will parse the
reset property using the new Root Port binding, which will use
GPIOD_ASIS when requesting the reset GPIO. With GPIOD_ASIS, the GPIO
state is not guaranteed, so explicit sequencing is required.

Fix the power sequencing by:
1. Moving vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init(), where it can be properly sequenced with PERST#.
2. Moving imx_pcie_assert_perst() before regulator and clock enable to
   ensure correct ordering.

The vpcie3v3aux regulator is kept enabled for the entire PCIe controller
lifecycle and automatically disabled on device removal via devm cleanup.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 55 ++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d80d3be28ee5..fbaad35e43a9 100644
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
@@ -1240,6 +1249,29 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
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
@@ -1249,25 +1281,19 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
-		pp->bridge->enable_device = imx_pcie_enable_device;
-		pp->bridge->disable_device = imx_pcie_disable_device;
+	ret = imx_pcie_clk_enable(imx_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_reg_disable;
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

