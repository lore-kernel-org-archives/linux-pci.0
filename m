Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE23093BA;
	Mon,  9 Feb 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625457; cv=fail; b=OGLYp2T8CDrn2fdpPhynpO5/pjWH5Qd/GIEI4vhjhSCV/6xHh2Y8UKx0UZbCWEaW1sTM9vGbGQhE7l8JRakMqJJkgU1n697uVrKC3K/MJQBIA7mRbWXAt1aKlJit8i4nR8JGMh6B8lCiC4wiE7BXEAqVzSrAdgpGToSrwY40IH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625457; c=relaxed/simple;
	bh=bsCqGmkv2u1Exe8rVk/RPtpssCoCE9tOWWvSplVk7Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbgNWx0E6mWcsz/T9+wqtFCY7wTBxXzqDwhEpPGj/psKEUcBySbiBH1xKCdX5R16tTACGhIfxvb7n75DsYN6ZiU/VxmTQHmJfWfY+WyVnSSyiiBlY+S+grr+u3QZIryeZLOvHHSR6jko4Mqsuuy3mIzMM+PWvi9jgvbwYXX3kUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eTw98sJy; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eTw98sJy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTiZg1xccxx6/1eq1krGIwL+XCC5z+5o8Owg7rDbsVNeF5IONknWPFZ+omfyd2rrZF40pmc4fqi8cA64/Z2EyT43lQ6hVTKMo5/+qzFkhhiWcspdSuraJfmcuR9RCIb/Dce8panqcy09HvwEpjZDtvSaWNA3O2KE5L2X7ymP371C+942cmQR38kz59GV7Z7eCCx8PuzJj54C0sJC35cFQKmpPdpc+9ElhRMWScwuw9pKtPtqLW4hrbnZXLmGylOx1jlZLPxsFUJwP8YNmWhlQsKR0/0D6kReR1uF8reyGdrY36A8RUGYf7MMhxxtgdyfV1Id5Rt+NpTgNaO0OauWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=JpZnKw6Uwc9BxqcT3ecHUpzC6MutjaIbIGAa3wCD62BH50pU3ICx+Jm7vqd7m6PjO/ZBat5QU/sGGk5+2dfTNwvJ/kuwHAnBxkQxgrEQyLJ4xUgwfzS1M7/PAXZmFHoJ12Mh3DRwJKmMl4xUIgF2Hy8c+ZYNU2ASYOnYSGRgIakO6+mp1Gi/oh+29W6fQ2LENHBBv259se2KMjcOjhLitn3b0HYC20aOQY59T/VghXxLQX8m8svEBbpe6ixB2MxlqeWHpxP55QyI6ulMNuqmpkbQYdnTtCTrXX5ChxmuVpOcesjZBqybpfdGkQcS8c38hZL8pV+MBdjDFklqm0F4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=eTw98sJy4VS2KDPDaG+AId8is6MY/ckZv2TouTuWEdUj40b3LUpQMRIAjK9EjfGrZs1ZKEotc9d91JXb3HC6TOQrFh/puTRC7IGsqojvDoaSF7u52cVEZU4TSEyXmiiBOyD08ZPvt4cZ5Gj76CPNyCDwLnZ+fuHb93R+E0WED/w4b/XkpP/Kyv8ioqs3uKxpmlQFNIql2IULyfKY+e5yffXIs4JWcUDfo+wLFjOyow4y3S2SvCJEjJ9IVE8oSNxBxOkop2O12V/ChxUMPt7S87uMvk9JXBWytay5ZOjOecl3OLCc40zRJHQjkuFy+ulGgBZWsoRXOufLYYeU2iEQTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11834.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:14 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:14 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 04/11] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:47 +0800
Message-Id: <20260209082454.2097628-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f0f568-d781-47ca-78d8-08de67b49bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJfHhLCS1VPUOeajMhfiZqYyJDL6dOoYa1F7twnWQ9WxBwWxBLyUPnVK0JB8?=
 =?us-ascii?Q?JwH6davWUuGcqgWKBXF0OnBSZ8VTH9WIW23odtif75LqIh18LFECN3p8C380?=
 =?us-ascii?Q?FtMAu2OvFVLyoLdSLHjpFg59u9SUHKM1ZqKLp+GZIa415km0Z+ahQyYWHmg7?=
 =?us-ascii?Q?d5+FFI5gRcX5yhnFVAAzYRu2Qz8lMNTevKafw8D/s12wZtK0Afa8cIK0RcSC?=
 =?us-ascii?Q?Dp1BzeWb6ycGkftI3fGpAiCZtYlohtKurD32PKSQVkGVnNugdmaznxtD1C/N?=
 =?us-ascii?Q?t/v+Cy7BbnQCrOZx5EguS6qB2x4M6rnVF47y6ZIb5VRMPLwEZ18md+kl5DgX?=
 =?us-ascii?Q?INmEj2Fw+2QxUlzcYsoe4htcWYazIxwaT8FT3nkR+nWz5/gqQK8TAgcowfCV?=
 =?us-ascii?Q?TbL9PiXFUbn67S6IOXTsPEGBVUKUGl485OQhU+9fQBgUa80ThvymC24jU+Mb?=
 =?us-ascii?Q?dNdPpNZoVGSHYUrhFeixD7fBQL50B1V9lz0Kf7cPS9VwzUzvisjjnU6lgiLC?=
 =?us-ascii?Q?RcH0aovFc/cCvjZN20Z5LFkKxQg0ROImdG/nBsPXtSClFUwVyYVOulNhIyZ9?=
 =?us-ascii?Q?2p/OE285EWn0jcBfdFw43Fg5veNTzW/2/ZnIi4rH3tbSlCDMpJoELdZt+mtC?=
 =?us-ascii?Q?wuJjPevt2Hmi05ppb7j3qk1s/cDlA+sy9q5alrdpQX3sUMOlmkZLnXxOKU3A?=
 =?us-ascii?Q?J+01w1xbF4AP2PVT3cEajk+FDVkvayrxombr9/Dp3gJJ2Ko8DEk2lC+1hH0e?=
 =?us-ascii?Q?86V9dz6YJQ2qjCfogYh+L94fFNVKUVhlq4TSc4yETS557TZOHynLK3cElW3F?=
 =?us-ascii?Q?W4Mj5V8pfDFodB843SsDb2KAm9q0ODZ0zoV3DzUvNcM1d4Mw0SphmTu6JkLc?=
 =?us-ascii?Q?ZT4I/a5hKHbWfIpQD3nYW5sg7N64cHIYE1NQ6BkhfBp3Ag1A2OxQ8WKMfEil?=
 =?us-ascii?Q?ANIQvJWNYwASaEXaw2z3l3X2QQYFbRwQFyTZe88+3TuPf6b5pBMHDhLbJzPB?=
 =?us-ascii?Q?IbsSELbIHep5keIu9VDJsfg5LDQdObmfAlxWghkdABfEi98AOOjA6qaz35C0?=
 =?us-ascii?Q?ThbrxWUGdb8QiZhFyU44g1Ai/T76Y01cf9KNblUpTR7b0lh7Os0fqnzekfrH?=
 =?us-ascii?Q?s3Uxk1ojsP4ylQpZFW0NrI+EdWQoWrKLg5ZylzzXPNGJtrKrOMXqSAu0PeEK?=
 =?us-ascii?Q?sr3I2RJDvimHgE/P0/9C7P6b7DmfEmKAtUdMxPDeT6Cxn10/3tIG01cGbPeI?=
 =?us-ascii?Q?gNFri6ueXtUyK+ioR2VvB/GOmz/r8AxkxTdVy6uYPhJ+UbVzfpXVxLdRwk1K?=
 =?us-ascii?Q?z3CkpasGA7c9svJGVkHmOm+e9EgmnozuURyoLqoV98uwVIngVyJ4H5PtUBU4?=
 =?us-ascii?Q?1b0tjbKdoCDKalkzswqKqpeWHLkAoUbR5GGiUsCNzvwkqpGNWTwITln8dUQa?=
 =?us-ascii?Q?oldZgh1oDBilg1sJceieHf7AkWcWbQt8FEQKxx2VFUiCGxoWd2PSpADp8Un5?=
 =?us-ascii?Q?dY85/iw/bZMBwexkJYsFGdaLwaye5Jtb7A5ICzLxV/xfnK5nQMF9jgPbMhdB?=
 =?us-ascii?Q?vOXAhSscAjcda6gk/878tlZb8eViaadggKyV7bVo8Y/oyCCcOSzOGGSXUgTt?=
 =?us-ascii?Q?9fZwIrfm9loZgXbgsaMbZ6ljXCxGXgN3g3GGWCTWk1sL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJknekXKMZgfeQtRS+Fcevy6ybCUgbQ9tOYEXeDMbBUg/xmBM9HaAhvb4aJR?=
 =?us-ascii?Q?dFbZ9BvntwgIksgMVa2VB21J+/zbF090RyKghoI0smFJ8gmX5jWcAAIR5/Cv?=
 =?us-ascii?Q?2zBzDwskmAEOeI1TIELKp7tJhYq2lHQsyUXhfH0vW+3PZXBXuaEbdHojiODS?=
 =?us-ascii?Q?lVEadMbwEU5nu0tG/i3WiXmjtrYyDOAhoHKRGooy+DbCTMNgIkd28HPp/wBa?=
 =?us-ascii?Q?8uMyI8OmGEzfmpwnUDU89nCF6O/1mXdgR5cHf3siQYu3iYjcXdSl3B4l6ypv?=
 =?us-ascii?Q?YeJpqL7FJhz/2CaNSNuEAe8ws6ES7OtDi/S+uT2vuUPCRQnJXvAzHG1/Io72?=
 =?us-ascii?Q?wpFK92qRyJQTgz70vMr6MWWwi09J//GJyiJtMm7F0ZlxW2FpQ75/gGB1C+f8?=
 =?us-ascii?Q?TxC9k3Ho2ttvlhCsTevYQfFX8CfzpPkdeOG2ulVSJ7Z0abIEi5kiX7XPRD3s?=
 =?us-ascii?Q?FjrMQD+EeMNO2pHNXXVLlCJg6ZWzZVsA5X5NnkbWS4VAZ+L0vMKRPD8IuPmQ?=
 =?us-ascii?Q?MdjQ3BIT9CL5hsZk5xhs1yZYVhS+nye1JICjjC2kjOZBbrBrTZ0tmqQW6W67?=
 =?us-ascii?Q?6P6XLkeCSI0pHXVdCNOE/oxyJla82c4P0v+EJyFUXbQ76IGiRFfhkHPdb9oY?=
 =?us-ascii?Q?tq2vpYCRz8ii1sk2XGaW9T/6FXHsDfLX4ingki8mRVkdUfqDJBVeBeAZ5WOZ?=
 =?us-ascii?Q?BdSbBlpxmS911HeIfR/z+0HmiL2dUYM9Ig/1HoO4XUmNWbb+1q3cCQclhkrt?=
 =?us-ascii?Q?yR623/Stv0WgIqSs0n9hS6swA25WcM198VSE7msGWGgCuNTKlD9OJIp3FgI+?=
 =?us-ascii?Q?ZmlHaXISaeRPkfxS9rgzEgSUOIJVHXCvkeNcgDY8d4Vxc/nWqYwyAx3JTKZa?=
 =?us-ascii?Q?chaQ5fvRdMfxD9t8dg0KExDgNInqeThl+hXvFi7HL+jL+PmqHBW92UFmz6Lj?=
 =?us-ascii?Q?DDGsAkOISj1KKt1sbrPiYmiMs2w2leEy1YHKphrctX15f03FEL6utAtAyFwx?=
 =?us-ascii?Q?iNWZQT6NZzEhPKo7u5r+LZ0rpQYgKXmNeg9rpodsuHPv2swKKjxFcRg+1APs?=
 =?us-ascii?Q?1R6CMtethA8iLQvAMV1oRHCf1+nOy7CoiA3MMS1WaBWw3GNaJ+OYKcIsRn0U?=
 =?us-ascii?Q?gh2ph5HftuFh+6vs8FNZoHT5C00nphj0AlQhCJU1iDHQo1faRLUbhK8Utx+W?=
 =?us-ascii?Q?6b0lZX+MMvStz/cE6fPx6T46Jtu2uR3G/JFBPqN1rwJiMw+fONX3Ku4tJcNE?=
 =?us-ascii?Q?Ap/aoQHg0r7w51IqN1IUoFD3/EBdydZ7fQ7GGVBaFDZ9FDzVkDhknt2fwsFl?=
 =?us-ascii?Q?S+X9ksm15Z7iNFuWT8ytZ1u3RRJT/nk9YR17e8lbZKtSWHOkZyYsM+6CTwWP?=
 =?us-ascii?Q?Sh5gL4F68M89AIe06qum+s5vGqY8GKTGDOyGAaZroEw62bNYk/3vMSOTdUBR?=
 =?us-ascii?Q?R7nGTgAYOIj0Z0hjT6PnTWLUtzAioo0+CTsxAj5U2sdgdlZC8RKfrL0HTlvZ?=
 =?us-ascii?Q?r/banMiD1zjr23vA5BdeW812F0LuvTIptZ91X7rvGTtH9D5dDCk718+ufXbp?=
 =?us-ascii?Q?YoM0hBNqSbJ/Gs2Q323Ni2ZXPxycG8yb+QTy3KF6kyDYLQEN0GS9znhwodt7?=
 =?us-ascii?Q?wbC5GSTNKejKSGlUd3ldWSGmeDJy9FMZV0iLycTTM7QjdruRJBiNQT1tcK77?=
 =?us-ascii?Q?pMQgj1Gb9PHhqBTxZOdfaWMZFY7EvvPVRE4qo2d1p51hLeLKM6qRATq4yWZk?=
 =?us-ascii?Q?NeO5R+PokA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f0f568-d781-47ca-78d8-08de67b49bf5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:14.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wj3GvHsWPeXN/4Lm4Arc0rPza+np05FZ7YvoLY/F9HlDHmRkhmOEgW/sSffVm3hcisf+JHPtYVPCG+HZoZz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 76e6043e1f91..eeb376193398 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1

