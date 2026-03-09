Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3D3101CE;
	Mon,  9 Mar 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045824; cv=fail; b=PKpEO1ocZZXWwrkAnYQOhjrlhdsA6yc67a9CcYTGmMGcqD4hMgs9Y+wY4FvsOQWuHTJLMy713x5FsSV6wQGRCXBpcOpQ3W0lzzlq8HSOhogrUo7VIKfH7jy08agpZB2ZfCvjLq9aBAnB9DGaHP3WFU4Pqt8MSEvcT5RDYSzNRsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045824; c=relaxed/simple;
	bh=pab6LjgpqnWAsNvJSny4XoepuB4Ej0xFXBcypkm2LuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufI48q1MQV0mMgk6+XXj/Ha95BoOw5rU6K1WQNo7sAvcxqkVmJYZc4hfcUj2CZ2q9QEJwpOnBaERq0bgPl0Xn1IiWi+TqmfNZ/2tp1HPTlzMcEMx3yAGnYJ89DEr4JyJt7K8F6cynMlaWR2lZr8f9J270ExzMGK4LVQlAf+ZijQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V6TkBLiB; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V6TkBLiB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq8lefpJ9fKNpcacPmc9iaQpX4Nhn5oz6HZMNFgzs50hNuwaEEfqUN/1rSwOuIxUvVVBAQa9q1+Uk5QeqnDKXFtzCss7Vg8mM909+bMQJxIYgCLZ6J6+4sPjOVmUX+ipBIUc12EZM8abxvgqmzb1dtf0Xzge2J9FGx+wwsYzPfU4tr3F+jCKEuoGqvMf98mtJiWYquL7do4TRVjphS7bu6ysmi+HKgb6We3VThaHzcKdQV2stWnfF9Pa3t4S1fPaEzqhbNtu2s/GShCsxE9fXjUJhQOU8UUD0doDxJbXKyXELXx5si1/HUhL7uQVEQAW/q237X8yHftpzvxAw2It0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=YEZp5LwsbwUdBNaF292sKahNym6z+zfkFr+gHwwqON4ouWFZsQlGRwqdqrJOwB20I6P6Hi8eHZDHSYz6tMH9bMVz9f60eo+UsO0s4uxcMyxvkUUh8MPYHF+SLMlzWrgD0Ta8NIXSgAN4iRiwoHdt5e/RRBeOrLdLtTntNDgwYEb3kp6ACdYL84nFvGh8DeUtSFq7hAPJvXJCXusopgqzF1YajY8POieg97t9JUcA0uxQ36adDNVyfLoixCWBfrmlvU8dnCJU31TwRArICXUgF+3DjiK8B2WrVCuExNRpyVdCSZcXfTo+bpZcvw2gsSIYHbNus1fS6w4xrpMpjJRvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=V6TkBLiBfBqymahMS14ArsTURSjD+HQehM2gD1hK/PQXQl9voL5HTTskWUI+xGeSpYqDQ8VhwRuUaOesvZIJWyOS1wpKn2F4pN+6OJEF7K8Q5sG2Ou8/P38aJVwXDMEEoBQfs+ji4P7CirRTGxDo0z1CvIhWJFwfiVwnMWN5q4d5RMUGBj7bRdg3C+4E5dySgSf2yx5Wp1wmF2XHSe9jNKA2UswZupvIRsjyQR4S1DIrlgRn78x1dfQfyJahNOroho6TdD4iVZvyAB7FbQ5gKyrssVPuxsECHtwUNseGjMxsM+I1z5d+WigZtcEHXwbsTfMXbs9WN7cggSiOjncsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Mon, 9 Mar
 2026 08:43:39 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:43:39 +0000
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
Subject: [PATCH v3 4/4] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1] support
Date: Mon,  9 Mar 2026 16:44:31 +0800
Message-Id: <20260309084431.3015463-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
References: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e63f69-5a45-4dd6-acc1-08de7db7f5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	z1LgAmOqC7fNi8J3b9s9z9lZ7uatOAaFhB0TLRlT/M70JZdjrzZrgqDF3YkbQqt5LMgCzHMkKHlc3elU8ONkLITHBerA+pTa2TZGCneWxdTczkazPW/+aeyIWNlrRSQY0e0I5FfbZ3FGSezYJNCJLkL5W7XNbSB89myLj4bB+0QNztEJjYlQMGWFDL/sWpjhbFmEm6Q8YzzUfTHeqIOy9LPLs6PpsiJ/oDLCLTPtk7d9wkDWf4h4JV9gUkIPxm2aG5rTN0l2VW1lkHe6hqSbDScRczZSJs9VygQqCt4nhJK3y+TJ6sThG+Q+KoXP2DskKXaHZ0MECKO+IpiVu5y62zCa9doy+AqDhygccBxBgPy+oDSdfCBINH1EqbijnOPcTZaksXyep15KV/xvV2g27NaZWnI0LZzCMOJZ5a9hUkmKU7HHEJLVEy/NKUe436uc5a4MuLP6Fm7jM0omU3TAsHSrqdIpoVHlhE6of1jg/WPm0+aODd2slbwhsOKG04gKGDty0OSRpcLtyXcwfpli6FMGuw5EgVnRgqsZq46uvVvpoulhLI3HhvrP0RwjepxmXxsek8iBI0Qo+UsHUkSMXV01Va/CM3N504PXzK1/x9/BzxwsXubpGpBywZBHBAgHY1dIzptejYJ/2+DWreG5BZzDDWr+jmoFexsYPMQWEEz+SrOdQFcfNXdYkKpPUuJIt1e+PT/gT+DHUQnrQV2PQusPNAtzYgxWaNVHwayYC8rKiyi65v3dQysD3657P8KPvkakGfCF4/MvyGdCb2FgerZpjY3asuMgDglF5n/jyD9kF0SsHNKNLbXRAILCH78T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFhhXsExFGb1pAempeLYcvPwiMyHETcN9jEOwVE8hVl0zcFaUodGl/9a1sAy?=
 =?us-ascii?Q?nt/YmQ1uQHrmRiSgzq7oOVwOAMcxDFZNg/P4h/Ikq8xQ7PUTHVSpnC0qF45i?=
 =?us-ascii?Q?sE6LfO4/S5t0mFcmrPlXnzZBbkAFsNODphuUkpL2elq2rQgBES/fBPIAb7xK?=
 =?us-ascii?Q?YdFaKjJWWsIMQoVExeaVYQTcb6v+RCkVrr7cRjBPeYEGfg2XdUEsTtN+eKye?=
 =?us-ascii?Q?KXJK3JiCo3SmdXzNvYuFpquq3URnsaOt7r/GA5R7SARDPVPQ8feSDV/9WDcE?=
 =?us-ascii?Q?9XJR6nPp5mHHDw5ulrln39pkTlm7+unzE7tJvFoxCDo1zIQL6hnw53NGsN5l?=
 =?us-ascii?Q?IE59GrPQebNF32+sNjkBaqvWA3+wfBxkBDsJdjd/dk+vyeZxWpUVpx4qRPto?=
 =?us-ascii?Q?t+YAIky8rF65virDuDGw+y+PoK8Xb9Hqvu/OKjgjXnO5A/eSE/J3nJ/Rza/L?=
 =?us-ascii?Q?UiMRC1NLQForYW0eW0j2OsFJwO20y2CB1LyyUS9uavXCB/pLXhtWVNePPxqn?=
 =?us-ascii?Q?BAUhfIm3XfRDP8kuQrWlITLepGqkL2m3X0Rkg8JrWTyFddubAFwVdWKmbnlR?=
 =?us-ascii?Q?s5QcfpJo1DrAkeu2eg2eScw3ATKi4yAGQGlKiP51fitqrarjTFRuVB4A9Q77?=
 =?us-ascii?Q?0n7aeP84IUS8cebvk0yuUsK8HYrcokFFvrWvWk7WtMVlu267W+pv2QB4Jgfa?=
 =?us-ascii?Q?rv8OUTc3bFwlsTcCSgS5T+XkicsqZLVlkPIIdocAYxeD5TzQWjUY6aYTwVhx?=
 =?us-ascii?Q?q4FNfQHX++IClC+RgmjtCTRpGr7AV3iA86PX42Q0CKcUS+mxp87s28nd0zhN?=
 =?us-ascii?Q?iOQ0jz5al7MOcDMBDJw1T30B7E+5iYazfprkzurpiieZDKt4vVcMpotZ6l+K?=
 =?us-ascii?Q?rJHfwLQ1pFSpQOpcQQgfzDPZoWIMdRcM0Lgu37BZXjg+BzgcxZjDS4KaabxE?=
 =?us-ascii?Q?kh4+Dkqh+HGmI+gzc7H0bJbJal2vP2ZJqJYmBu9yztmCF++cDtpEDfiqrou1?=
 =?us-ascii?Q?nOgD1Sq24WRShM1RHjZ5jmVX7HnQ0eyOR/FC1L+RTbTxEHBiGkVj0HpK6Xke?=
 =?us-ascii?Q?76wQ8xJNLDoWUKNkVxVWCFJLqHCrgXjFp8C5mIqf2MWR7C8c43TXhxkiR8Mw?=
 =?us-ascii?Q?aopVZYfnrnMF/1+vRpnBBWhtcvjmv/26SM75B1frOUTGeSRemC9+oGNfvsTq?=
 =?us-ascii?Q?tdRjXTACWdW9fJ9ZPyhGOMhhOOEzBpwDA0VkBJXLbcQ+VQhIYty10ljyHkGU?=
 =?us-ascii?Q?lYw3/c7GW/rp6cUTIQ5sl6N5fhvY6SHbROjZCvWkPfXNvxM7nRzjjxckSdGI?=
 =?us-ascii?Q?uO/O1s6oqH7Fjq0GxIvYDTjZwtwcnhnL/pS+H7vjrRtweu3uzLFif3LwYg9g?=
 =?us-ascii?Q?bsQjo45qjD54tci0vsT3JdJjlhgyv54DsanfuMPq/Cge2R/6B3jTFeEPf+1g?=
 =?us-ascii?Q?xlxSyC1c9HgpS+azsiRhhZpX6wVibmefATZYQqsTLWHwJ7AksvCFneyjug7/?=
 =?us-ascii?Q?pxDjPeWN6WHuHc9t5Vj+3x9GVPjIQAcXMxHjqpo2pMgFtf+FJFGHuReGDwJE?=
 =?us-ascii?Q?jRetWgZVQRQn9PEcBLYNllsbv2cWkEvUEYONL5ORPFhr12OFdJ3CJr94S4d0?=
 =?us-ascii?Q?uB99m+qnIOnG2U44RW0Lgnn2sBwmxFXNVOVBBqfk0VbteaDN+t6FSsS4vhHm?=
 =?us-ascii?Q?GzUtgLxs16bJ84ckgAN2y9cebm3p2rNkJaVaZiWKu6QiMzJV122PeJAZUdOK?=
 =?us-ascii?Q?wJRAX7Uo6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e63f69-5a45-4dd6-acc1-08de7db7f5f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:43:39.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLN1brf4a7WLVcf0ROARoXX4F+tjM1kdmykHcCVHlGmPMmz7oynjTEkx6gzgebDzttobB67PgSBLhHHPoOjjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264

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
index c8ceabe3d923..adcb3fa3c9de 100644
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
+	vpcie3v3aux-supply = <&reg_m2_wlan>;
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
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-- 
2.37.1

