Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACF36EA97;
	Fri, 13 Mar 2026 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390840; cv=fail; b=KFklzy9/Va8uNUZtXY7pCakdIavPip3k6ppF5wqi3ysdzLtFtwic/LFOiOTdWWCXE3W/qVsugjPk8uYoElFsTlsN8JhePmTh51SIBccyrddtTe6+ohfxy7KAe7qsMOlaoPt/LdFfNODq0RqSvn0kdBSH9rhZ4IS0cVNosqee39M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390840; c=relaxed/simple;
	bh=Jgu2movgmbCmZp/h/GAJrKl7iUPeCxBp+gtOps/BNy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcKtsSY7wrjMOWONfDWKFIBV/8RZnUFgOLZTMy6dDxYS1O7CNEmXRzDHpdF1p0ELWeGDr8r0MV5F5+Hszrl72SppxMFFrVQ5k7BPczGhLKVl7IKFvyBjyJXd5r3FcwQQDP+I+tISlfRTOj2Y5UbOAEDV/iecaug4VEQLraeYmw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WHnxV99A; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WHnxV99A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUfXUc7Ziun2drgwjdJcq+BKFAN6x5Lyq0TpNyVMw9MdNUSsd3+8r0V2Br1+oYoPHdWG0sEQ7IQQrJR5E+4/kzytybAeBR/+uPeYJHVUafLIt3K7A7FahVRqWoo1shsy0V7LzTkwZi3EAz3lGG9+nNe6sCqW+XFeKPDAMtcMgfxCSA5RHh4OIBelHbOD4Bv2yeVGxVoQlgVu+ivhnutA4UaT+B7on6IBbC968eV/usiuKWeulV+wXEyw5Owb5WwqfszOyLJKzI+SnHxb2yyCkQRrJFXbXd473mx+cuESnzm9ewBgQrd7R9xgACqCVoFmXQnendHWivBH9NH/d2dEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFERlUCSwdrb+FxW2Jy0BU5CpNHjA8HKdEb2YbPpTMQ=;
 b=k0Rupv4R7SXhNVtRKHv25mIRPH+QjAUT02kxrCFrl0pi8tbAfUV05THr5x5dQ5kVHTcY8RJuvzqLgUP856EGWqq9bqSexHy9vf2DpC/JgoEwZMljsH+rtH62nmeFcaXhf4KZ+zWua+XBTLB7f+5oz8vWzBq9qQhwBD6dLSfatPz/cKyHUIUIUBVl1xEzXkFtUoXHb5vchYjyt3V4kvEdlhyr/C09N5bTPzXrcK5fQm4VI5X1yHOhrDerzCRy+NECf4Y70de/Q81S5ECe2usMsdF32Yxm14LdXuIiaJQksO1PcBR55M6MB7FfGpXcH7FzZ5XVNBPeJvkJTjSjN+i1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFERlUCSwdrb+FxW2Jy0BU5CpNHjA8HKdEb2YbPpTMQ=;
 b=WHnxV99AgDpiRUG60hnol3rtmxYHIrJ8tNRzJG1O9NNiZ6IExiqrDj/NRT5M3OMTwcC8HqwkOxheG83ECn1uVykCKdsELFLKzkE0G688ULoEMnMd1LQrX5+jhL/X0hMkv9ioxBEQMBaPBSEcPC5LD1SMXH+GBtfA8FuQH6uNTqP2oBHnHqypckqTRso7WcApBy3DVWIb1snnNsrhuZi+eHMi/mZF+GUT4mcAFuaFCXEi3VQPIRrK20avHIyktZrxgnVYH9DmiMER9uhPfks7GirVkrQrplL5N18uAu9ptXoqzC/IXaGV8/yxSMSE+3CwOGfDToMemyztETOhamXmTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:33:46 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:33:43 +0000
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
Subject: [PATCH v7 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1] support
Date: Fri, 13 Mar 2026 16:34:43 +0800
Message-Id: <20260313083443.2391254-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cbb34d-660f-4922-07b6-08de80db3c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uRTxCTaKVcup5HQUBmnSUh7br40J1T3z++hG4DU7PhupetwEcMr4lDpq/iEUeJ5OQGkFPw+ETFAgTw75NZHiTedwQaMgMPpCX0p6QkfssQi0N8WlPFyNbrJe1byLQItTl5ANsfdHPGSpJ/DCZN7oCewQ5Gv5Gt9XwQFJbqnHgJqQBYIldeMyQ5UEs3w02XDG4KssNGGr2tHJDZWlXnzLumKGDcKzWj/inwNt2+QeQQ2jj7RiaPxfnFhcVAdFX6H6/unFEP24A8HQvfsKCOr+AKzZnhgAlqVKHjFmuIR120tg4VtlrCIWPQk7JPE0/X+SjQqiFagy14bU4G2tdA4RF13AcdC2xpqoMWpy35Zu5V3jVgTZ0h67HFq+c7a8LH5Ez499mJuT3DzhVJiBo1B1q7fDSxbOyC7jejcms+p+1pFL8O/0M/HLlacidUs7BHf93eeDZTN2FG23lnLiwVl0dSWslLeDGRiThFest281xXJsnZ1GOkeaCWhh/dd8RKOCNZyOn7eoNxYFyLAJk5jMvhbZy5/QwhDNF0aLkT8kwXYKXhsVPS0Q91erFBK3dh08rUHy7dLmqUqoeYmH0WPzIRBFQ96vzOouNqlwWbkRDswyqbECoXh3FUp9m9fIocE+EX508v1RMq1Aiotp2WsJe8zO06Dj/QVS3yLKMcUGDJ1vQbugilFC0Dcyako0MzOLUvIdTQc+UaVfOyqeufD6qrh98H11wstfqhGxu6kh9oMixCB5T9aJMM270sJWCSctBb3+O2182F2dBlr7OKxBIM8YeKrH5Uz6VHczo2yTN8PVU8NWnjrvhSVkBk5Se89U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkqrwKnsvs5Ovk6TyOjnqvSirQR3APIXVy9H0ICwF3FOICTgyc06rfR9jhiq?=
 =?us-ascii?Q?rvC6R1TWIfp/x6DJ7tBexCu1pl236ehd8UoHqhiEBNc61RLEa1u2UQgGEU0D?=
 =?us-ascii?Q?JgEwfpXVkRTJ1aczpN4DkpqG0Y7x0RZmA8C+Mw1bLE8WMaM4Byixm8VPvreG?=
 =?us-ascii?Q?OHcpcOfQOYkZezUVnM2wRJ8M7zTrbhJ5G8fVUCSgfTQBMTtZuJCjWdTCMIzk?=
 =?us-ascii?Q?gpxbqkTtjGjIBeVR+xlzzNFW2UHIrQXn9JzbwMl8fs8a0ZbhD+r9Uj7PvL9r?=
 =?us-ascii?Q?g237v3zGbvhl1ymstHWKuOYZdGq2s6HDGUV/G32+qjvJPJyut0vWaGbImYnT?=
 =?us-ascii?Q?J2NmkSUxEijAjVHMw2wUCwiauGAXzF+e8hk7J2bm12Ri80j6Ngz/aTRup40G?=
 =?us-ascii?Q?JqNKdOo8uVfcdSKmj0saR2ZXZ4K5wXl1lFc086h4CXyCJyPgnzR0j/zDOgvb?=
 =?us-ascii?Q?jqiegfGOvDo7qCnLt/84eBwntmMpDfN20WlvN3mwkbucH2XKiol1F7w0OKcH?=
 =?us-ascii?Q?5sBYv76z+S86ctZ1502SNOZ5FcuwMyEQu39ztEao4igJDl/UcAus6Anyw+gy?=
 =?us-ascii?Q?J50LnH12G74DOAiZnB1xsWYG3mYzB13VLZEvft+lrFXlN6sUc9yGvZq0C4RR?=
 =?us-ascii?Q?NeV68F7yi495dlnCRfAQ0nT7v1aFOZItEpClpxGHjzJmCnlJDpGsEoq7Z4nk?=
 =?us-ascii?Q?EyNnPwXy2njJhwLUoNLa9pV9Rxjh01HoWvfb4DM3EwBwmvBeP2n0IB2xW/cW?=
 =?us-ascii?Q?+mSYfJ32y+UgmR20yqosi06fC/7TJjdb9VLxtST6X/Afa5fQXHwRrcYMdVVg?=
 =?us-ascii?Q?zCkZ2OxYrG4mMzuQBN9qF4PVn5esgDgDnV6H3+378K8D2odbqV9sk9hOtp9E?=
 =?us-ascii?Q?kOE8cfI2uEc2uA/7zMONY3TjaexX/WX2Q8DxHYdZ/oMsekI/l6HBakB/7+cN?=
 =?us-ascii?Q?6NNiOFjYOVxI+PaX74mgVkwW3QXXeodycrWJu+qnNFX7KclHvFivj9GpLMBU?=
 =?us-ascii?Q?U79VlD1GRdKpDqKNs4AsDWhcLql/wgkekv7ucsxdbkfrzRLqCmLYUE5NICjQ?=
 =?us-ascii?Q?Ku/KbQwjSjmtZj7GorEuSlmqCxYJj+p2vva9yJfvk99L//tM5cHWTkq9d9/4?=
 =?us-ascii?Q?4VOcsiK4bYPYB2eHLaybdNlA+mO4Jc55cr+U8QW/cLs31fUWhaorsI1JXcGe?=
 =?us-ascii?Q?747dY036JNttkkbLvgDRM8t/R3lEkOBQWr9aAlZFJyRhxcz2Km4T33J/zAfC?=
 =?us-ascii?Q?GRrScCP1XwxOKmj19FZZoqZlz4PIBmWom9zuSKBTlUWBxTlDvEoWLfVUWN83?=
 =?us-ascii?Q?RR+dnDBAYjCG734gNLTtyADYE9Ax49diprC/Z4DS3otWtD07cHzrPwFOpDXr?=
 =?us-ascii?Q?ckIrwzXcaYnFsaQ508tssUCfbQ+FP/bsoD5mj7GWCp8vA/ZwXdXMi+2GvgEH?=
 =?us-ascii?Q?gtEOrwwHMctx0F+SwfiArOArynwmhhbTpND9+Y+tM5GIjINlJA5cRBgRJfUe?=
 =?us-ascii?Q?olx8lHkALNJkK1it9qRnhdVvx68ppQ8nEK134/KZXTLz74kksSSFdUYDp8DF?=
 =?us-ascii?Q?gVwekdHVS04nIDO9jSMQVpYdJqkD9yiDA8Drd5gp4V6vcnutoLrZ9RMtsQ1O?=
 =?us-ascii?Q?HJwevtjz2GyeVagxAFCaRiHCnzPFPg6pr7UpMZvtwKy80yLaeHOMolMN41pT?=
 =?us-ascii?Q?/x8xWDc+lAxOM3jFdrvB8teB4bPRt1wqCHJvIIASaHSha2QhOhWUuSvWXAPo?=
 =?us-ascii?Q?bU2qOSh5/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cbb34d-660f-4922-07b6-08de80db3c0d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:33:42.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcHD8l2SWOgRMhG0uH+G71Gg/qXC15en50j1mEcwOMZ6am9sfypsrh7mLzLOb+Van8NT7SJtBkq2pfmlsTKa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Add pcie[0,1] and pcie-ep[0,1] support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  4 +
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 82 ++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a6fe56bb93aa..e0d5148441c6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -465,6 +465,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
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

