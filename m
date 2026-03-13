Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C712857F6;
	Fri, 13 Mar 2026 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379001; cv=fail; b=nQTHb80kIolCi5/gJK0VSH/ZbFse/3xrJ333lCZdvViaZUuhC6nOgMGukFipJvJkO1Xp9IBqajZYb37u+pnfaklM3jKiiL/ON9STHATIuy08lFNDbxcz1q/0R2vFsFicQbkggtteKk24qXT2YXqQRawPmaOgMspVWhZwNZ5V/SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379001; c=relaxed/simple;
	bh=4VlcICWHeIqfUxndlRanrhrYHgvU1g76T7hCZkW6Tvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gcd9zBhf+CJ26YpXdbYG45VUK/uHYHhx2PAU/ebCuV1ibwn1D045kNBdnRuyANkZLMLgtfnXrMVavg1WGA1hbiG8Shlgwg+JIleL+mehAQt4YyOfeqSEid4ZCjsK0UY3G2FJVb354t/TAXMidR3D1GGWsCe5NFtfBG2L7z1ABXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QhmhppiK; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QhmhppiK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXi2PXJSyfaebeAqCXR3NXDmv1PbC8krqffivxvUkPxZESM9R1B1aGwmHmI5+9J8Mf1Oina8wFRodqnTmDytGzxP1ts8krvJ8ECjJLebHdMWlmqo7q6oGgx4UkD3mvQEMO67v8qy/zGOiJPbKq/7dnl9A9DRIoFHN0fQrH0N7iJFzJfnUH2LFriTkRtgWpWVwsgJK0OIMgfQGEedIV/AtR9WYJC0/4bCHAdGod+NiXsGPwDT6mpLpkpJcrO2HSbtkxXd3rLYNYLY5WCduGwfgAY1zNP1pa4TW4UKMRm0ZWGIkNCe9xe7b6fwB48TuADOuUL2olmL+TKxAr+rWgruNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzh0iZQ++jUq/PBrkBIYd48unoUA7BZzzG2j9ywxxjQ=;
 b=dnr2bZpsIJsoX8f6slP3zN54s1/pJp8w1YSJWQj3orKzowOGrlvRJRvVcwQ0m9hQagkUYWASzDHJ42gNcI15opxr+Ij3lia2VIi7x1SPcmoNaf+GPzEwkSD3K2cTFRrYOFyuTaP/x/3JNLh6HsPIf9iYe9qV1NNGXoTWs85uG9FQUJzP1Y1OoVzCRmhdw7lux7PsJZlI9UrpCGuVgKeVB/yBI/g10riU6M2PV8uwdRKyOT9bo7sMVkUbUmXXy8OTVhp345FGBZkK5qgZqHelblLq91/1I9SGJND0aHN0OjvClaWjtILISWtdz1YrG0ql3cdixW/KFzPJi5HT5GPIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzh0iZQ++jUq/PBrkBIYd48unoUA7BZzzG2j9ywxxjQ=;
 b=QhmhppiKkJXBTIMPBhKP4rfUCM6T9kop/hSrA00odIgoDNAFaZrVZcqh5UX83QyntXk/F6N0YZ/Rx/j/+VOvGSMurxpGZSZGAJovLeor//jMRFFx1WUwXmp9nm320abSH6cKpg18EnWQ5yGizFpfuDjiyxQ+02ZHZZDQzidO1Wx0MyLqbBAlDmKJhnn2rEMLqt5OMBTTxd8nIYoqJ7hGyb8I4YnWMaLkNT8lU2UdoUdmfhPI6Kwhts2nsI+46EDAJJCB/7eTGWkAL0Ux180IxYuK+xtTR0C8xct1dPiZPzW5zxjIchW8h7L+5RcYY0nh34Tv2a8bQcrzRl5qI+6EYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:16:30 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:16:26 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
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
Subject: [PATCH v6 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1] support
Date: Fri, 13 Mar 2026 13:17:18 +0800
Message-Id: <20260313051718.1931375-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
References: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed35577-9613-4532-c7c7-08de80bfaeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	9XOZ3Fc6Bjv5wKucDWN4dnrGmVeIa96EJ6h1S8yDP83XANtWEE9TTAwCfMkvx4VxznNZGtHguMWxUBpVzuTjtQ74/oK3IizjoRUp4APL3EdgvPemKxLO1ctvvWbzrLrq0OyFXcRBnhqwGsrCsnq4e9g+X8VnS+ePuIyxnic1UETSB/fYS3SGVE3rv9dEadi7BtCC2ePF8HhoQLCFJKFna8HPUQO6MLnp0sh8used95aHViU14Y4fUjXQRu8NAkrkZ12HcvctsphiPNspUusJ/g2/2OZgc4spc1Dcio28qZfi2P3AsLj6Xs2/hC/sJQPxKMzKiuU5nIuRG0ope4htpmrfeN+HiHuCbitOTVdAFFfnQhZ2tB8xyP4gOLcIH5qMkhZtScukaEnR/ZyIKNUbuEo28aHVPm8GVXw9ivZdWPw968956u3eHc1g/7DiSL0H/ew5TjDh6dohPaCQ2CT+zhDrUPcfwE7ziHdK5/I9fqAunHaAUHe3xiW/qFqyI/CIsGi+ee82eLH2oC+rChTYCHO0K7BxlbK+VKnJ4eVgqpEITtR70uc97Bjjv9OfnU5eiOTniDMSDCKMtyrsErUGyb4Nw5kAtHvSV3GdZA3l+GDAtUNdTmUT7d1hIPYaRaf0jbFAy+cnMO2xyPbd5H5CeTH/2xGabam8G58PY3mk2PGwxFhua0O3uygy/e9AWkP2sB00BndtszxHZDG3xrIDSJMiBWh6HPwG+g8Qbm2v5QI4y4vZKh+YDgLTqQAY5zUguWoKpiyAF+52Sa/ykO+vyh7fV41h7cPvMFLCot54rDj0cY/bGxFnRBdoW1OLIo/2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c93Z2Ul77iL84u+mU3IvuDJN7e/UHjiuV+G9E2WBOUJYD9r7IaCvsKhz+ozc?=
 =?us-ascii?Q?VMA00ffG8aikLrYPuWJYveKM/RXrTn14XuEmXlpdeTlh+RXU9X5xSuVHupbp?=
 =?us-ascii?Q?qEWtgE4kRYxml5qLvTfBPjfgOgFeFpWUH8zhQnxug0nxumImjowJVymz545W?=
 =?us-ascii?Q?5NMFmXYKbfWbZGnJO5B1hYUzUhqhxMFqHr7H29LedZZjjoc3sPixcZ7LKXFT?=
 =?us-ascii?Q?mOj27uSkfi1LKULa/AehCQnAu4lRDSG7k+9l8+eKI+1gkUbTaY+Gg49KIQ0K?=
 =?us-ascii?Q?tHJAVWNrJffC20SfplIquALOintmgT2Xfzbgjri6DeRUwvqQ3W8JXUazy1gT?=
 =?us-ascii?Q?EIBl2jLlUahgzV6JjsXvcctx+xywJcRQaaVSKal4H8eFYGjvha4zK/dlmjJ6?=
 =?us-ascii?Q?EBjdDLMykIrK92d/MK9sETdJgtixC+bGFyFV/dRj5Ytf5e6L0IhU6uRsDTzd?=
 =?us-ascii?Q?sI54Jt8N9gYw0CR4zPEB1mcXrwZvqQDbvQtoHLrPguwQGkJpLHiOIWMDkExP?=
 =?us-ascii?Q?deCDIV1xZTrnt0eYyeqR0A6Spcn5UPTHdQ1xTGZeg57O0Y7tKmrq/PtFVmqR?=
 =?us-ascii?Q?8WyMecrn5baRVikOy3WY6xx3irHgACMW7zhSSxQpYYjOMWs5CvG6yzHJd1pw?=
 =?us-ascii?Q?UwcdULidj20wj4BbmhVASyPr24ZzemEoyL5bossqM7oF651SIF5xNtyFGQ0X?=
 =?us-ascii?Q?mP4Qi8pTgHZMWp0UYmOZmlEdyy0QyqWW7WeoSxOR+Dpz/tHOlaxM894BOFZZ?=
 =?us-ascii?Q?32LOzOjuY0ayS1cQHVsArS/VWut04X+DRdrWvxFLQ3xlNa94btmwnwcxAJxh?=
 =?us-ascii?Q?tL5yoiF/L4oDUM7bhrO/h32GJArIvDyIjd8kAKyHy+91cnM61kDpksBCrq/z?=
 =?us-ascii?Q?BReb8yxOuRPouHJVGF+JPH4NJEKpbKLPA5hUOK57N1JmbaS1q1IOVNvBhNzp?=
 =?us-ascii?Q?winpYDgnntBWU0ZvxL+gzgHcgLGDKqxZC2ljdP/SLybyZOuuZ8p3C1Zspew3?=
 =?us-ascii?Q?gY8pFiSa75SIDbl4qJgibmWC4PzpUiDW8hljECc+IGYbY8h+JZs2UK4i/36H?=
 =?us-ascii?Q?gbi5kb9HwIThZXPnyiSMbUJLpvFYzdXxPHIZhwCqyT/Epzs6j7sgpMcjx5Xq?=
 =?us-ascii?Q?KC01EyoJ5OZDK2MRUV2n6Y66KTeDR/fn0x6UaKegynPzv9ac3WR+naB9rOXj?=
 =?us-ascii?Q?B6CyEEScbfnIsfp/7XSuCsJr30Vj4mdXQ36X/M2p6dMHCftc8C/b+9fpaLDM?=
 =?us-ascii?Q?kUVALadu90O9W42Rm1W74GlWaoSNlZp5oNwo9JaZ6zn+bss8CJIMyOiikw9k?=
 =?us-ascii?Q?+m4OpEYpgS2JCRs3VSMXZPcNt0f5y6dxJHS3LvSKvrc92W8bMFqdQT6Q/AHm?=
 =?us-ascii?Q?Ted0L3lcIURNfK6ITRs2Wo7Ms+hhlWGTxURg3KKAaciY2rsFEJiZCw3Xm+SH?=
 =?us-ascii?Q?Yb7MCWP/csD0fgvUklNutr+XkDxDoCs5yBWEhUeW3wVI44OP4cAb5fG5snWz?=
 =?us-ascii?Q?4kKOOiU6TvMF+ehRkxeHWAYJ0qGxhpJFh7OYA9Dwc1bYyTG0WyzO9iNOm/7C?=
 =?us-ascii?Q?xrCetfTenXxrXmKuR+22Cu6cfksajaPATPYnO60wvI4RaCU7joawP7U5YJZr?=
 =?us-ascii?Q?EaIM3NWS7wZZ9Ysb5YdqW16UP5ta43+VkvXW4BoC116bac/Z2NpSbGVeIP/6?=
 =?us-ascii?Q?MW2LJePjBydYV0RWVQ/gPi08JcLF3Sj1euAU/Ga2kJ3desTio/kjX8A2K1Oo?=
 =?us-ascii?Q?aBny2TwfcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed35577-9613-4532-c7c7-08de80bfaeb3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:16:26.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: op8oAYyKLfsx9HxtswNfcYMurQtcgp5o2/iK3sVJxJcJGZwtG+sLzsm39Mq0DL+X63w0WLHxCeyVeAqom70fIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

Add pcie[0,1] and pcie-ep[0,1] support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  4 +
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 82 ++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 25793aa7c0ab..0885e67e0cfa 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -451,6 +451,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
 
+imx943-evk-pcie0-ep-dtbs += imx943-evk.dtb imx-pcie0-ep.dtbo
+imx943-evk-pcie1-ep-dtbs += imx943-evk.dtb imx-pcie1-ep.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx943-evk-pcie0-ep.dtb imx943-evk-pcie1-ep.dtb
+
 imx95-15x15-evk-pcie0-ep-dtbs = imx95-15x15-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk-pcie0-ep.dtb
 imx95-19x19-evk-pcie0-ep-dtbs += imx95-19x19-evk.dtb imx-pcie0-ep.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index c8ceabe3d923..f69c0b60b039 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -50,6 +50,20 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	pcie_ref_clk: clock-pcie-ref {
+		compatible = "gpio-gate-clock";
+		clocks = <&xtal25m>;
+		#clock-cells = <0>;
+		enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
+	};
+
+	xtal25m: clock-xtal25m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "xtal_25MHz";
+	};
+
 	dmic: dmic {
 		compatible = "dmic-codec";
 		#sound-dai-cells = <0>;
@@ -71,6 +85,15 @@ reg_m2_pwr: regulator-m2-pwr {
 		startup-delay-us = <5000>;
 	};
 
+	reg_slot_pwr: regulator-slot-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIe slot-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u46 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_m2_wlan: regulator-wlan {
 		compatible = "regulator-fixed";
 		regulator-name = "WLAN_EN";
@@ -653,6 +676,18 @@ IMX94_PAD_GPIO_IO28__LPI2C6_SCL		0x40000b9e
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO20__PCIE1_CLKREQ_B	0x4000031e
+		>;
+	};
+
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO23__PCIE2_CLKREQ_B	0x4000031e
+		>;
+	};
+
 	pinctrl_pdm: pdmgrp {
 		fsl,pins = <
 			IMX94_PAD_PDM_CLK__PDM_CLK			0x31e
@@ -821,6 +856,53 @@ IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
 	};
 };
 
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX94_CLK_HSIO>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>,
+		 <&pcie_ref_clk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux",
+		      "ref", "extref";
+	reset-gpio = <&pcal6416_i2c3_u46 3 GPIO_ACTIVE_LOW>;
+	vpcie3v3aux-supply = <&reg_m2_wlan>;
+	supports-clkreq;
+	status = "okay";
+};
+
+&pcie0_ep {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	vpcie-supply = <&reg_m2_wlan>;
+	status = "disabled";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX94_CLK_HSIO>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>,
+		 <&pcie_ref_clk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux",
+		      "ref", "extref";
+	reset-gpio = <&pcal6416_i2c3_u46 1 GPIO_ACTIVE_LOW>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
+	status = "okay";
+};
+
+&pcie1_ep {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	vpcie-supply = <&reg_slot_pwr>;
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-- 
2.37.1

