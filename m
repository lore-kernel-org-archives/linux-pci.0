Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844673A6F03;
	Thu, 16 Apr 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338061; cv=fail; b=nAlz6aingQwLzSBXWRgpZYpkgCMcxa6LIDKFFFjx6IDHdI1ui3D6VmhOumgvKZKtalGxBm8Uc5rLx+bSKabJARgYFJ+6a3QI4TtONjun0nIXXgOTD+fIYWvZep4n1rF9JwXq/6oIMK1QL9HKwtp+6fFmk3DQAiFJwdS7skDjHro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338061; c=relaxed/simple;
	bh=qenzXLklhHlqYAtsHgiZ91iUxT0DbrT62hGAnMX5908=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmjZD5omuhSYpRo8RIoIb3L9Tpsu/mED216hdCQ7Ho53RwylZaulZ6lpC/hbEqIlbUvPP3nBSFv3JKmQlXHSozecF2+R7UnR0XIOV3uBqzBfjrFfFE4bCjOyCZO8dIwovxgTc90DLD/dTv50MceD/NAiG6mdhJ0OIFcPHD5yHIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GoZaCD0e; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoZaCD0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Z0HOBnp2tgAaZR+W7b5kfRT97DzdN2MTRxy3n60y04cj3s6SX1LK91Fiw+enkkzhu8TwlSqMkmMVCE5SWzSKxU/6mG8HHz/LcxGlDyLT1Wg2Z8Y9Kr52pP3caYC/6iiahdIpd+1Z0n+zeffUhw4AzKP25ue/7b38Zb8IiwE3Ryte0vsyw+1H4yLFAtXHMQSNp7k7gVlosJDowm7YY/yat63Q8E0W7YRM/sWVFqGI+wCzWGoZ+hql3gYWYwDi5gyST9Vayum4ECHlcWsiO7SLpeQLb1c8KF1nhNYIVKv4EzWEIJHEslNRvHbZ16nOembzwix0rtHqj5MKwr9YdSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=hUD12WBJ2FNB7hifIf7IQbHu+YhyJQH17k+q6Fd/qpJeemh6I9N+qndMu87GxL0PYPL7a+QLrYPsaH+yekH0hQiSiWEUuVIUvajD2HrHLnL+58JZ33Ol/Ei24iGJndWufHURSJVBL7Sh6ONl9P2+oHyrps2wwwruJl7jCnjgFX04q5tbOPBDHrZsOexXU1kCfNhfSzexFCO9VoovRFm7WX5Kk14tEOVevLDFrUg22UVBQadpq2Wfnl4pY+J0DVFsejS1MDc4rixIvvAtaOpgKQyneSVGgBtihncC2sFRxvThNoz5NUWZm0uaQX//fycRx6TC9Uqz7PdRzCQBZygQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=GoZaCD0eBkDdU+TRKaJLtXNq3ogIL3Iw1BHnN+b22gslZnlpEPPPz2zdpcJS3a0p6PtdAzHnW1kBtqyeJZQVOdnP5YKUHms9PQ3ZJYULKc4UMRqdoTU5BDBimzZJDm4gxtei3THwdFDtgeWIKPDjRqYb4ucu5rg1TK6t36LC9qS5zOwyl7rPBHDeOZncLMWmBg/c0/SdqJ/34NxqIKVdxMMzhG4M7sNrKWK58/HINDWgY7bi7P49aT0RxTxh5ZfZE3kOVreJhSd8+wC6SYtFEJpum43Hn5dKXwGGGkOdyLkqogC4oXEg7g/8ELLhfyppjblXzdqdCRdZn7cbcqPSeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7897.eurprd04.prod.outlook.com
 (2603:10a6:10:1e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 11:14:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:14:16 +0000
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
Subject: [PATCH V13 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:22 +0800
Message-Id: <20260416111422.183860-13-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5b1914-e842-4e16-db8d-08de9ba94c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vocvrg9c8X4HEgMIk3EX8Udt9x9RNyvvm67lMBcQMqdacqiy7iJDPEs5yaoK4LTHCumJzQrKVT5SwsB9VD+DXdMEMZmEugInHqzlsx+yV2eSYDde2l/O0DS4N024tRzH83EnqV5mAV+mO3m9WbWhVTZcPEa19Tt0e0JUq0GVG9WQYNG8WOGV9ol7B1yPPGKPj2SqJ0lpIkZrtRUdndQCh5ZnetzeExwjYV379ZBImGBY+TdgAMp+8QEgR23UkMFME7x0xj61mSeJvO5rrloZjjjYfaa2OoMes+obDsMtlpIif+1llnQSY+laUsKIFObNoPfTn0nidP2W2xoJYiCcv2VLQta/azGzjjV58caOzStvK+ISZHdoGDzwmVqlkcTifPLUfBCNo1xt/f4L8KGqfkis5EhhmypCy/esdGSTJpHybjm10wtc3kF2HE6w8iEI1YlJfXlYRywMnWpSzcz3VLniV2P+Fek5MK6IJbmLrozzq38GkZV95JjihN9plc9rOM95m6HyUmsCGdtsJJT2GlNtTpmUCBjT9g5EZflH3v1ynJxHU93qiO/wzEYP0Ni3hwEY6ImLI1iBEOB7e8D2CR7njt9CV+lYsyvL+DVooNdP1fxCL8igmUYcVE1jXISAUlkQm5nLOxSrgCa1qyt5fDiSa+7RaQ+Hh5xBsjIhRohKLNlhOOnasjJ/gpPvIaJaCPhZAXVPnOwscHgEXZIp0f0XKJFQgM9wRU/gY8o53ho7Hgucw0PAcmC+clxVPJ+bOy5LxKtnSQskrLCmSuCGqKBDf/3YT0UUeu2ycgGCIgDITWQSKgOx/KYz2v2hT4Kk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kj3i2I2MABiY9Y3q/YTbJZSzVZav+eyjxjT1G1FsjTnilxCm6/jCHkoquBWF?=
 =?us-ascii?Q?zeC5n5vbzKqrdVDXHjJI7yraMkILishua4i4fGtLdlY7i647pLCXzD4MM2mA?=
 =?us-ascii?Q?NMJPlv+qO3Yv1HtmiItAZ1x7aGJFKd41vdTcjcFdQKpRQMh9e4+iDnV0c8BN?=
 =?us-ascii?Q?XJlQs0F+8h2Z47ChSYz8RmDquBat/bfDkKfFsBPZBALENOPDNX8RE9G2AgE4?=
 =?us-ascii?Q?mz40d0YT1jEDmgkNUXRzt9IAzPxDso0cnX6mzAK7AoqMTEylhYZ6p/SAtj4Q?=
 =?us-ascii?Q?TiYeTbB5zaSFVWyWNHGCIWGjBrGTcx8ANEqiqFoyE5qqjEudFleaTNmIUDe9?=
 =?us-ascii?Q?jDGNuok2Pjcimy4ilAIcZ8YZus5A1mawBveH3EKfaccdPjcKMw9S2dc9I3jI?=
 =?us-ascii?Q?D/xPYsIGZMf21HcKfQdwgjArx4cCjslvokY3YqJYujx0c/cG1s+OwO17ilZ/?=
 =?us-ascii?Q?9sCH2uQzi4neLE34uMJhGyRGSlEbe3sFOBF58sCgCJp3WHLAFZB2Yk6+r+wV?=
 =?us-ascii?Q?DY4PgzjEK/BG5FdA/uSmXCN5Lu3bqChVAAkVOrGHZPINvsXeAKFnJIVRpClO?=
 =?us-ascii?Q?U2fZLIFiHGFUNz/C0Cni5mSkj3v+U/tQemLigELyQ4k1k8ZF3Ll535/5+MbO?=
 =?us-ascii?Q?JPGrCh2rtfQlTAZ24qf/kenHntUXAclnrzEgNDhL43Q1x4gkzhD0e0g7tayz?=
 =?us-ascii?Q?x/UNiKBAnoenSHfaPIMfDo9wOCKiKmD0/xM5wAFusM9xO8i4aWXxipDKYQiz?=
 =?us-ascii?Q?EBsUpW6wCwBPV5VoD2Xl8oSx0hgXvF1DoEC0YA7WTxpLNQrLukQoyqlWIY01?=
 =?us-ascii?Q?KWBfsGcGbQFxDJgwYJRoftHqNqAtanWY8EecbbKo0jHwGbFHyJveCvrr0DH0?=
 =?us-ascii?Q?98wePcWvhrwq9wGQ3lKBN9MwIDk6gjGuzeABuImPD94eT9U02OFRYLRza+73?=
 =?us-ascii?Q?c1tPfJBsnjFyRpQxZmQRKmVleIcGTxNw2r6K94gH35TXN6S4eNJ/cJ/lK1W6?=
 =?us-ascii?Q?OLmJLRbNaniQDWeQpBxFQLqXXVGSPurg853DntD2MTzxiGqA6JeSAO7JdnRC?=
 =?us-ascii?Q?hspw+l5mlNiOMMRhXm1/ktKsCvUg9LZKb2sdZyUZ7VnVry0C6i579Dtzhcpq?=
 =?us-ascii?Q?7GHv8P3a5J5lqrc4cGL0F0YjDP7liB3QvWBavG6nVI4euhDQgl37FuqTa2Il?=
 =?us-ascii?Q?fKJpX7ROZSbww0gQcrluZrrN2iP5U4MV0aw6lTaugf+q8otdoul3orjKQvKO?=
 =?us-ascii?Q?TWg8o8deIa97MQDMtaBX0fg7sJpSOLnWDWz3qCF6yvr9CUCHN5AKMvOMif4M?=
 =?us-ascii?Q?QfjiLLI1v1EOM/VQ5YyW5+btmIY0KCYLy+/9By/ATMzMArbQ+TQR09SX8nUp?=
 =?us-ascii?Q?+xhMVcgKsI0ksdMChQdZumloUdF3VkwZAdcgZkYtgmWq3XinqVXh0Rbx0eOw?=
 =?us-ascii?Q?AaPPALX2MD6o9ptD+bBJs16FhV6y5+DUILn16TlXyoJ0oIOWWyNZV/YeRLz9?=
 =?us-ascii?Q?AIljRTtEdpnONgevmLl5zVkqX15oNAwizpoZlsmL9lq8N/lg3yRoegEMOZA9?=
 =?us-ascii?Q?Ld3XLKXat9ZcVVG2PqDzeAWip/sopbRt3j3wGBwGBISMbi+6KPPiZsLgrCmI?=
 =?us-ascii?Q?8/37BCDGwm1IhK1zLRn/SMfEtpWJlJMANL4YR4Ei32XCfhUg7qKZCKUSUU22?=
 =?us-ascii?Q?505fFBzOxjlc2vFVgi10xBBWSt+AniIc82Po7v0qKrFMGhgRRiNTilzpBRnC?=
 =?us-ascii?Q?S7aub5PLTA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5b1914-e842-4e16-db8d-08de9ba94c01
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:14:16.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulrgQbKktvyPZx7E/WwZmStSqqswhsdvfvbMqRSYTNeYkO3dz9OnjAPONg/k043KrLjvU/liGIfxVIsItkX0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index e4649d7f9122..7d820a0f80b2 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -553,6 +553,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -567,6 +568,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 71394871d8dd..0cc6644f98bb 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1890,6 +1890,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1967,6 +1978,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

