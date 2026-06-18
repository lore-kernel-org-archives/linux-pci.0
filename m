Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E903C345F;
	Thu, 18 Jun 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774298; cv=fail; b=R0ZKWlJXOHjzQDblL4KV6qrTrd809DZA93QCfr794hkt4fSWstiurcYdGXhcXWM8Ys1DnmrllHOlRZ0p6+8TgiGPEiA40RS3Ey3iOoHdCjm0XbnsJzAT5yWRSZUmV+R9HQZMF8C1zh4Xv3Tb2TNWcsualN3Ilr/ljL3d9cohPbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774298; c=relaxed/simple;
	bh=Z41YEeYgxvdsJ4qUCUHkfClna9+QTTqDk0hYFk9dQjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLWBAuSQt99elDLzWCCv3B38zPZHd9apCSJZBtOMWXT+LmV0m0zRbpKbhHVzXOHRxFsKtdHWzU7GwhqjyjyuKO4rCxWMdg/5aoKkOGoFpJeKZ4qowe19v0RsAXjyYvzBEd4DBtBhsQUBm/O9Tg+MlQqnU4AELxsz+RsjNYa0BOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fKoygZNk; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fKoygZNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsWPkqMMkBHttENup2tInwKs/rfro2I6o6Q9Y+UDa0paOcIGjwVV0jlWKy4D79B+97rrrm3+8F3BbzHwc3m2fDZNrabHmmGvxJD2jDv9otJKCmOXmDM6h3ynZ8Hze6fWtr+5JBjJK83zk+4ZdgpEgWtch0vbeQ8nm6kNy6u3gE9rBN3jYDHu6M3UPJbtW+yRUt01i4Ig2SQk0Es7Wbw2Lsuvp42TZgOSDgtTIn4nBS7Z2Wtzu+/GSKQmcrhTqpgZUyBipF+53IyvdzA2j0xhafizl9jEmbB16er3chwzkuYb3Vtjoq7s05ohdeTbffBoVFIXq7+AEOsyC/AZDG9F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3BOHwMje8d6qO6u+PWZ2O0yuk+d3b5olDVoVK/FTwg=;
 b=wIxkMMG4+8GGH/gaZBFwa8wM/XlbEAzHKSuX79qq3uhOurq0ckuQTZXeZjxaziZC+TM2dREODUCyBwegdo+64mdwZ3x1WIML83Hyy88bS8V3th8ST0MKwlvoEcSiDDluPuDExJvQFnTEWMxRioEPp0ASOcMy62LfM04SgV6qI7KxK55k7A28Q9VzJbimCKNDukxNo9KMXhbkx4r50alJdQXyCXU9WWqAGVDuUkjvXah/H9hbPdNdTT8/KFf4Qf/w8/23glmRYCtNBGoOZi3VqKMAtfW1+WCoorvdyvXCgIte3cOuCdu4Ga1EU59ebkZo13WnwQnrxvJ3UXTBH6hArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3BOHwMje8d6qO6u+PWZ2O0yuk+d3b5olDVoVK/FTwg=;
 b=fKoygZNkL9AULjlwS7IhERwzkVEQsrTjg44zeV66QptOKBgO3MwTldpX4q1+7MKgwiY8GbjwxLVYBS2bi5TjVFgqMSmfYQ5ABORcr+hS39elQ/655rJ3NcNZNtGgbX6UpRLjikbNbkGn46bHKKXr4wL3qZAMJOY4Y8MkGnqP8CjzydYzzkgxTNOwd4RlPG3vs/N0X8L3U0+rsScXqhhFoWm59UCVjjd4eui1R9tg6HlN3FIfarBufqo1My/9Xp/LTOlpPwznVYni3BO8gpbZHw1cOCnZZ5h2RWRYiJKWxSE/YGMvviuwouNNakO8BYDOB/lc1a8lc2LkIrt9hC8iWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:18:12 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 09:18:12 +0000
From: hongxing.zhu@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v7 3/3] PCI: imx6: Add root port reset to support link recovery
Date: Thu, 18 Jun 2026 17:21:00 +0800
Message-Id: <20260618092100.3669556-4-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccaeaa7-1fca-4bde-081c-08decd1a856e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|19092799006|7416014|11063799006|5023799004|921020|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HVTuWiBjvwK9xdYEaDSCHhXdW4QsBirgh3SFgzkijvVeTn4Hzo5koThvDz7uuStvx+6EQyws5z2dlB/rBPD2mWuyC0Bm4qXonrr/FK5M1tpxWevN5QjHQQBpi/zuX454+qyJ/thTHyP3lScV5Tr81I/z1IT9wSigRozj1mR0bU0VqYudEAAG6JDj+bvwu57kO90gzj2iSSPKMP4H2RGkr0KzAo9EYhDs9wg+35vf6hUzpCd186FAWnqkTe01OnuXpA5wj0JB+SvaxxcXY9V/wVgM5v939VBqVK0tUxkqSCxAVESE6fhIAVJ1iPVXjtEi8f2ld9MR9K7Y+9WZwtkUC3CbWX65n86UeGXXuXnqdDNQC4kv7BS+0F2DcZ6P1nCx+Va1WnDaV81ad3ip7Hy+yhg98NfcBbO4UblmM9rYAoASH0ahusae5yhV6EDKOKsPszLBHj3ENbmjn8CrN5nyiJU6ooZ9fDiM5juA8R8cArn7e4I3xvcKoDlowtygePNkDt2Bg2zVV8e+WBo60jo7aS/MTRWOujQ8Mc9SauVe3JYeTCYvXi8eVtTg/QEk50Ky4XCQCryX1CH+1lJHs9Apeob2gCbtS3QcsxTFBovyac44/fCtlq5XQhP/OdKeMBCs9KgwpY+hzJAw/ibN3FXf+QlV6n7QTttxJYeUdMWDUyIZS0DNkjcVtJTlcM5NEQPSKT9fbRvWZPvcsM8yA7va+8jiCgA0LMtddZI3UAd3vVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(7416014)(11063799006)(5023799004)(921020)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfBqJVlHwGr6LABelTz1c9nlhF0SrlKYJlhqDi1jeQiKy18PeGTNubrD3E/r?=
 =?us-ascii?Q?Qho71QxOP7dfE8CSA7q7GLPhXLLSIxELUQeU5O2JIILCbgbFY1n07QG9bHQE?=
 =?us-ascii?Q?0oJ1mApCSogs/IDC5Xf5koRp490uMD8zZDt6tQrKJ4m88zGXwzxmWYXGEWIf?=
 =?us-ascii?Q?UGz1ArVSAHXPiC8t7c4rpFJNXrkOEQBWaUUBISEtT7qVR0s+Pf8XYcaWc9kF?=
 =?us-ascii?Q?G4p/mu1cGbQYWDDssm0Ic4bXuhmle4h4GDyOB1XpGz2yVSCeWXFaKwsJ1neO?=
 =?us-ascii?Q?Xt/BDC7x82rNhyXSbmZh8R26irvmDisgaaQPNjGBEkhDJSa3dcOlxgH6CTbO?=
 =?us-ascii?Q?x8t+JPoQtZmqpDpg7M3X+dEGisNykj++wbkWri8Ypf1/VBC6CDSCCzsGIjEp?=
 =?us-ascii?Q?mTBf0usfNBBtc+oHznMu6UIDWGZJjGMPmSbhe6QtntZx5Nhhar7ZJaqoW2eF?=
 =?us-ascii?Q?VCYsZqUf1vBewdF4feBYLUoVQmnh1CXOQVe4fQ2VZWh1LsILtLLdmDwbBikg?=
 =?us-ascii?Q?aBLQv0H5SlI9rnWac4ba4kmpCzPt3vcgHfzwUiJULwHFIy+/LjrfLauoO+ir?=
 =?us-ascii?Q?bBN8/U2EvdiDVTbG4vU1vx9uPngJXkDxPU+f9v9wOGqs5VGuhJgKlja8tvXT?=
 =?us-ascii?Q?Ycm6b5uVpUfvSGkEg4jR6Z71pWnILCb6flvKn1e6w0pW9pGL1HOOFwzPWAad?=
 =?us-ascii?Q?8qSjhwUWB26wr6QWKiDhww/o9z7U37k5xCEShDXUAFxzxuJcMBw95HlTUHuN?=
 =?us-ascii?Q?6qCrMM6X74Ehi90gPkYuoSJscb706cpuB+lCrbTRctKGytcK8SIOZMcCln65?=
 =?us-ascii?Q?tE4rJIE9vj1e+m45VPIiZ53Zne6a7B+I+DFB6quezCmlaqjsiUQOEM9vlBqh?=
 =?us-ascii?Q?nBWTyWa73lrKjwy1/AUaGBAV9aMdFm2Gcn8qByIQnIHmezZ06alREZUAaCHY?=
 =?us-ascii?Q?NZj7ywLAV67ewQn0suIptvjt5isKs1hUnkmWZJIcvFHMJojy9RR1FR4MwbBV?=
 =?us-ascii?Q?Kz7WGtl7QNJGPvEYLtcub1qk35CszA9XBIvCp363v/81YFPOGO8rdKYn+4rH?=
 =?us-ascii?Q?kaUKIL4p/n3Zh/NTP6tp5p3IkaXKnAVtdyI8eU0LZdyfQSVUHj5oZ9+jwZ8k?=
 =?us-ascii?Q?MCxHkFH/950mbqHPmuSB1fL9VjZTbnBcf7UMHfLV1rq8xjgRRdixlGVFAyA/?=
 =?us-ascii?Q?eA//VPOQruVImpyMdSXnR8+BnKql4WY2U3WgIJtR4uvotdjnNlP/3cKA7xg9?=
 =?us-ascii?Q?u9PV/238MDf3KGlSU+HxxH1OUym0RTEHuPX3qUBTW/g4JI+vCoPOwPzrZE5P?=
 =?us-ascii?Q?+UVKhTewluYJwPPGtHFCzww2nwY/YPLTLUsWf1sx7jRIKO4/Sa3WxXNjiuZv?=
 =?us-ascii?Q?A8LpoQ92n0DJ55rEsY7eA4BeJjB4aD3Q9/aHyzYvqlmMAX/b0WHd0nv1nnJq?=
 =?us-ascii?Q?2Ijarn5X5KvH2oKrLiKBWepLnQTFkMvUMmGQga4x0wgb8bAv9GrdSa7rERU+?=
 =?us-ascii?Q?k9KnVJHo4qvSM7ghWOpVSZR1hl3vGyEAbOzbzTD1kegbd2f++oMrbfj+pmYP?=
 =?us-ascii?Q?TCFi5SlHqtqeEZhthtWFSVEVbxup3GHVFebxCVxiJBNgc58BN87eURbxg6qD?=
 =?us-ascii?Q?7dtR5LrD9cuFvL4S13S1NzY8+9vGc79E+5W9vH7H8mZU90xdl1yySAkN/U8F?=
 =?us-ascii?Q?IOlVEvrfyftct6++8bujomoqXjl4e0JtPj5rajfvh8GTv1NeFEn6r74N3iD0?=
 =?us-ascii?Q?1kmuq7WJh0YzSbOASm9Q1YJaBENwbOfjSp0oQ0lnIYdusB3fIDUE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccaeaa7-1fca-4bde-081c-08decd1a856e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:18:12.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUpU0XKlKsNzJbnw3FyHgpjZr46tcZEbhYNdyxThnx/MURg8GEL5KZX454CLYhNkGYPxcHWVBE1l4RG17kYR46b8IFi6RV1unlpj/SRbBO+mkCnsUJECAzoFT9NZD6oO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

From: Richard Zhu <hongxing.zhu@nxp.com>

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

When a link down event occurs, reset the root port by: uninitializing the
PCIe controller, re-initializing it, and restarting the link.

On i.MX95 platforms, link events and PME share the same interrupt line.
The link event interrupt cannot use a threaded-only IRQ handler because
the PME driver uses request_irq() with only the IRQF_SHARED flag set,
which requires a primary handler.

To handle this shared interrupt scenario, register a primary interrupt
handler with IRQF_SHARED for link events and manipulate the link event
enable bits to ensure the shared interrupt source triggers only one
handler at a time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 773ab65b2afac..3de70f41b0b85 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,6 +79,11 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_LINK_INT_CTRL_STS			0x1040
+#define IMX95_PE0_INT_STS			0x10e8
+#define IMX95_LINK_DOWN_INT_STS			BIT(11)
+#define IMX95_LINK_DOWN_INT_EN			BIT(10)
+
 #define IMX95_PCIE_RST_CTRL			0x3010
 #define IMX95_PCIE_COLD_RST			BIT(0)
 
@@ -126,6 +131,8 @@ enum imx_pcie_variants {
 #define IMX_PCIE_MAX_INSTANCES	2
 
 struct imx_pcie;
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev);
 
 struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
@@ -158,6 +165,7 @@ struct imx_pcie {
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
+	int			lnk_intr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -1394,6 +1402,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	/*
+	 * Callback invoked by PCI core when link down is detected and
+	 * recovery is needed.
+	 */
+	if (pp->bridge)
+		pp->bridge->reset_root_port = imx_pcie_reset_root_port;
+
 	return 0;
 
 err_phy_off:
@@ -1661,6 +1676,9 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	if (imx_pcie->lnk_intr > 0)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	imx_pcie_msi_save_restore(imx_pcie, true);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_save(imx_pcie);
@@ -1711,6 +1729,9 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
 		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
+	if (imx_pcie->lnk_intr > 0)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_EN);
 
 	return 0;
 }
@@ -1720,6 +1741,86 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+
+	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
+	if (val & IMX95_LINK_DOWN_INT_STS) {
+		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
+		/* Clear link down interrupt status by writing 1b'1 to it */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				IMX95_LINK_DOWN_INT_STS);
+		if (!(val & IMX95_LINK_DOWN_INT_EN))
+			return IRQ_NONE;
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
+
+		return IRQ_WAKE_THREAD;
+	}
+
+	regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, &val);
+	if (unlikely(val))
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, val);
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
+{
+	struct imx_pcie *imx_pcie = priv;
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct pci_dev *port;
+
+	for_each_pci_bridge(port, pp->bridge->bus)
+		if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+			IMX95_LINK_DOWN_INT_EN);
+
+	return IRQ_HANDLED;
+}
+
+static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
+				    struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	int ret;
+
+	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
+	imx_pcie_stop_link(pci);
+	imx_pcie_host_exit(pp);
+
+	ret = imx_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pci->dev, "Failed to re-init PCIe\n");
+		return ret;
+	}
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		return ret;
+
+	imx_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
+	imx_pcie_msi_save_restore(imx_pcie, false);
+
+	dev_dbg(pci->dev, "Root port reset completed\n");
+	return 0;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1919,15 +2020,46 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			val |= PCI_MSI_FLAGS_ENABLE;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 		}
+
+		/* Get link event irq if it is present */
+		imx_pcie->lnk_intr = platform_get_irq_byname_optional(pdev, "intr");
+		if (imx_pcie->lnk_intr == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_host_deinit;
+		}
+		if (imx_pcie->lnk_intr > 0) {
+			ret = devm_request_threaded_irq(dev, imx_pcie->lnk_intr,
+							imx_pcie_lnk_irq_isr,
+							imx_pcie_lnk_irq_thread,
+							IRQF_SHARED,
+							"lnk", imx_pcie);
+			if (ret) {
+				dev_err_probe(dev, ret,
+					      "unable to request LNK IRQ\n");
+				goto err_host_deinit;
+			}
+
+			regmap_set_bits(imx_pcie->iomuxc_gpr,
+					IMX95_LINK_INT_CTRL_STS,
+					IMX95_LINK_DOWN_INT_EN);
+		}
 	}
 
 	return 0;
+
+err_host_deinit:
+	dw_pcie_host_deinit(&pci->pp);
+
+	return ret;
 }
 
 static void imx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
 
+	if (imx_pcie->lnk_intr > 0)
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
+				  IMX95_LINK_DOWN_INT_EN);
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
-- 
2.34.1

