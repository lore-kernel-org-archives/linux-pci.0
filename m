Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C73E0229;
	Thu,  2 Apr 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124607; cv=fail; b=oB4qzGNYtO0+nJFVRwbG+qjOwoR3wEqTOloKjEouby5L1dnq4dRiZp143BLJpn38RpU6FVCmiwCpCB4EQlqvw7EQV2W08s+/PIIbfIpWseKyPY8eidg4ouzYOKcbN2LLuKFF57a+xYK7otgMwpSt9ETfSOpiaYdj5EChGLRgDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124607; c=relaxed/simple;
	bh=xLSENEVicLF1Gtr6SkZodybppTHOJBVy1rfkVtPjVW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXOSZe/ek6xismKa3EjHLSnqHRFQ53A6lUcTb7hzZLb0dKFTH2AW98hFE9lDt1XYO3VXItnQqvIlWm0WNiUZjJWoXFpGfBeFalRO5ZZ6vUa/9i95t/HcnTm4xYg/OybMt+uzplhVYywMs1cMwmFTcFrvPnAeahl1z5r+TpTD73U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XHe7jgWo; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XHe7jgWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am+L+r4cX+j/BKxYWz6ItAsX2PhP8qYvxTPX4UsHKeqK9SnEPFgBmZRpfm+an2m+SVUJr2Yj3/gC2NWLM0Gv/PTamqBElQ7zUNKcYgyRpGGTkRwt8Be/E/l8/0zxEuFm11+RbGG3D5NP5XHP+1SkqidJwSinIFaox+lKqWmZT5v3xiyWT/7+Iw0rNAcQDxsjybu1/ioXvB9KypkmvRoOTigUfdPHkaPuanmP61eV/QKIIe+e5LanFzNdwAigqCziw5ana/HrliyI+40FXp9RfJDtxzqnlYEFfiLVSxUWrNFIO2Qx2crEHlfKOi0i9u9+NAfjcezgek6ukZXvPWC+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy50luG8D3FpeSd9fZfxxHj8HD2DbcZj1WAf63uAEBc=;
 b=xgxd22+aOw91QHzOCOyIeeriaI9ISQYqgIORK4g8IwRRLFzO/0eePyI0oAG4WAKlcIQkgpdR+Ub7hywMOXGxd1X3nLnChC57m1maYUn49Z7WVA/vlhc25U/BEa9TeccCcTPoF530LY4RsO7JMDvy/jaAfDHW+he9pp2EnaILqwyGx8Gx+LAfevUQJ1PC2GP9S6XaJhfN3sOXgH8iMgqXQG/5+AQTw+LCf1EFvjZHpOcJ8gpi+05AWuku1xpO/BOrPe8qlMePjE1i6k2R2NndqLz6ohQ21wMLxiN0/Khq+BrVrhzVDlwBpqKW65aabh9pgXCv7ol9+rlOlDZMmgpiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy50luG8D3FpeSd9fZfxxHj8HD2DbcZj1WAf63uAEBc=;
 b=XHe7jgWoL1LxnFuZJ55XMdgII3gC3UqtMApm84wojK8Fb8GuJ5P+fswtVKHy+zHMOEAU+NWTA22TGkSyTj8Y3tUx8JZjPYM+njYxG4o669U0+ZR2jBVZ8TR7wMUcWBPkCkWSimSSPDcRyDWYik/MxQyv+fF0xFD+Sb6VUbhgWfBiTdTPRA5kEQYq+m3aONGHAuGSxntyp75NH2Jz3o+unxpT4YSebTRKAyZipOiEgicWu68Di02Y2xvamhGtaiq0qtPhljbsEJoiU6KZmMSUGUkMA1JbbPFYTtZVzMZv0xcoR9ia7ww2oBqAaOQZy6Am9fi1wRCU3kZ+NiLI/dDSTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11944.eurprd04.prod.outlook.com
 (2603:10a6:150:2ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:10:01 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:10:01 +0000
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
Subject: [PATCH V2 7/8] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
Date: Thu,  2 Apr 2026 18:10:06 +0800
Message-Id: <20260402101007.208419-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402101007.208419-1-sherry.sun@nxp.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dfcfb0-c0de-4ec5-6df8-08de90a00097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IHPEquT8jqjUjHpN+AAeMh9xoTCfulXpuE08vdBz7+1wDZqJ9J9sXpZWbSS8Sy3sx1NWcXVthhxFchbAGcvHOxLBlDyu+0GxsFye7Uxti+RcLshecQjGfbecN5ZhEoxjvRqMDZLIpaB9G/WDPxEO/z3ghDYKCNMsyHsx4R5/YU3Js61EUQNhOYR+a9v2eqqlL1GOL/f37doFUK1M9jeLInr2S8yagkAtlws9HkGn7Xw0cF+KoW5UEzfgB5jBi7jRs1llHThjndN5l+gwSuAAXJYi3u6klYEfjzf9x+chQlPt+ZI6I7Nj+11S0/9GcrlPp+YuQU7ktWnwUkc5P6rAK8jKnx+Si9BgSWndWOUkuFryiLGNbAkwClQmabeI4tgfERsOucxIJlQbweO5CLzIhe4dafLRXHAdmlpv7sP3UKNA3OgNAT7a/04ZfcppM6IjzFhkD0MtDCpOr87JlBnd3pao0YT/npbUQs+oV4rB8BZyzz2H6XZFfkTqBlubbh1Vb/+GRIoGcDC5Q8AvEqRqDiAWKZNPCC5EPzuZN3oSt9lCmKuMZHpK3HhrO86mZFvvM6qvyqdR5/p8UIS1Bw/oYXUtIfbkIEUKpXFnN7ypQID69mUy6aSBMGXo2br918lV3qcktxoAhqjksoXWuFYbIr7ctkf/FJkX/Ki4IjNISRqIEdsSE9hGbT80QVxJ4LnfBa2+EIDQcvsC/dLu+WXeEjMOzpMgLbSuh6txwgU99i7D21bT3c9BAWNOlME6Q2u6rDdhPVfuzCjnOfpWQG9bW0vmXUZWtxyop2iP/M0JIykmL9WJaouTdZU5TARzd1e3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMEriiSNWOMiioHG/E4dbZ5lJ1qFY537Og5kgjbxmTXd5qcwYxCEIdAzgq0P?=
 =?us-ascii?Q?nC4gUjleBelctLxHRKxeyF2jYe4l1sES4+hv/8AoQOlkyjbwynTEpwvPbG7J?=
 =?us-ascii?Q?1YHEctNB2h7SZHD5A8wbbXhvjTxIFHqYSkKhB5ut3Iwz4PgyRNN3OWzhTFHD?=
 =?us-ascii?Q?/eeTW1MaKfEFYx8OV3vzkQDthJR+yG9CtNsoPGDu2myw9ruumDutzqC6oA2O?=
 =?us-ascii?Q?Nt/0foyHgW82wFG+KS1aM8ycmnJIjruOsDv9qu7KDLM5nAFPSU3/RsSTAA/r?=
 =?us-ascii?Q?nnCZCFY1DOeZAjchy6cxdyDa/LqfDWG2qUOKQZ8XUJgKTYob2Tc84ExVen2Z?=
 =?us-ascii?Q?NKxapq/N/uOO4mj5HcRlhntPS+7sINwgsp+glEVIFqMO4dSr3CWFvigJm1i5?=
 =?us-ascii?Q?n3dgE150tBcbP6awM1DegUC23emT9ESYIwb0Rg2vCoYomqW2IINE8IblYsRy?=
 =?us-ascii?Q?h6N8ZFLMrp+gtKQVn/Qlk+TaYiCUsdofeLio9R6RnEz1CjIVKDv6PdumrI7J?=
 =?us-ascii?Q?R+EHyAzG+P83RgqAbKH1T7qn/oEcRMYSVJVO9ZZTaTjRk3Kd9i8ywklLCEsN?=
 =?us-ascii?Q?uQ3Qa5EnJWA0+jfYN5gnuz7J02F23iL9HXfQMHrye1uiYZ502/6If72b3sPN?=
 =?us-ascii?Q?WL1rpoSQgB0WlGRJkM0ejxDgeQoWROw5qkDCNiVCG3BGfMEvGso0J8rgApKr?=
 =?us-ascii?Q?X232ONokqi2t7OR+FvEZZnctEhjBX3Ekkzy8//jxtZ6PdWxrxsiFiy4HTZ8s?=
 =?us-ascii?Q?gXD09rfdRxd+LFRtOtwJTokCyAfZjRH7NjZVR89xHjDrE+mcOc1Z/YIi8ZTx?=
 =?us-ascii?Q?lIKbyufoC9Ql6/G1Qf4MBtK8BVRjg6mnIC7MTR0BmMlCUxyTWWvvLnVszJ0u?=
 =?us-ascii?Q?Cp2nwx9RjxBEeLl/WCuDnCrlibkciB+3HB1gtm0J9LBPa+ELgiUoniIQICYp?=
 =?us-ascii?Q?0MXKOkbc8oPeHdw9yh/lHIjd6YdHQwZ/WzAV+U6wNpbCOUGgZMu5H3b/Z2dr?=
 =?us-ascii?Q?Ay1XobaG9NECYMQggC7AKFuVFPqCQ1GIxZGw1w+QpqDczbfmq4Y9DS2XAWKU?=
 =?us-ascii?Q?2zN6cQt+gkE8mwM7/JtSnQ7QnBjegcID2+k7yU1BEki1wQunmxLj6Stt2dIj?=
 =?us-ascii?Q?zoZ4tivTfj+yUGciQ4CJHIkvq5cdOnpXlWkCnU4c0gEVLI0YKCh6LD3gG+yb?=
 =?us-ascii?Q?6KJJ82lcCYrlVPvwQJzvFpmA+yQKNgHX83TEBbLiiPUIzn0/fLQrhb3JIq6n?=
 =?us-ascii?Q?R1FP/0+Vq0BhjciejUTXZklDkP74KNHOD4+mS8Gm2GIFEcNrCBezrbaG5BJZ?=
 =?us-ascii?Q?utc1SUudtBleh+8vaLxUGPI7rZVPh17EdGMLeZKJc0FqLrFkTx+GMZxfCeZG?=
 =?us-ascii?Q?46aPL/33LG6nxxxM5FyYRTkKPVtxKfA9LaG+F352wMAVlgDZf7MpFLd7ORoC?=
 =?us-ascii?Q?xQUK1SeKhV6EpH1RRTeXAVWnP7PF+MK+WP9f/fKWnqmOnKSqfGBQpeqLw3tp?=
 =?us-ascii?Q?eklYA9gWqlRxCsHuXNSsvzRgOv7tT32Gc+5pbCDjwShWK7HX8kfKAIliWEgt?=
 =?us-ascii?Q?LLEXFff98A7qFPi8OMkRas0HLZiA43dybU7lPLoiPkiuiLZC8hXoShucSCgd?=
 =?us-ascii?Q?Au4865qg4pMWqUIvMEOsJF6PMzlle1cfr++s9E4sZgzvrkjhtxBSVPAvquX+?=
 =?us-ascii?Q?7yYeANyz61DX8VpUzyiu11yy9sKAJ/hHrfQjpOg68PR0wRd/MHlXELP6PNxx?=
 =?us-ascii?Q?6l9SAESc5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dfcfb0-c0de-4ec5-6df8-08de90a00097
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:10:01.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5L5vWoiLRYgtLAhYYkoxTYgdrNbFUrtFr/btAEysW4vjUAUlPtbiG1GLPwtP9dt05ZbJ9d8kpoOGP9LaRkzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller nodes to the Root Port child nodes to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 39108a915f96..66b2d496b73f 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -677,8 +677,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
 };
 
@@ -694,6 +692,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &sai0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index f706c86137c0..5e725ad8aef9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -812,14 +812,14 @@ &pciea {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pciea>;
-	vpcie3v3aux-supply = <&reg_pciea>;
 	supports-clkreq;
 	status = "okay";
 };
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 };
 
 &pcieb {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 489e174df4c4..4a4e9bcca9d0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -732,8 +732,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -749,6 +747,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &scu_key {
-- 
2.37.1

