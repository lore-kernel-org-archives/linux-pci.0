Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5825365A0A;
	Tue, 10 Mar 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129248; cv=fail; b=TWMFa7+wlqjiyvZ8Ui/+PsgjyABBQlbKmXSW0rwiMHumn/WtWvpjXUKdNIgXZQ8fBo9z5ftDHJwbwHARVLMnWzxTZPXp94exgzxGSbcjYAdxLTbt4tEAJdIwRuqRihex5ZykqzuqjZQDXS3yAaV6jjg8mcQ9ZuS1Ksr5QHygp1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129248; c=relaxed/simple;
	bh=pab6LjgpqnWAsNvJSny4XoepuB4Ej0xFXBcypkm2LuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvslfQV7G27orRB5pUjIhNbmmEY62aiwp8+U/s2Ox4Knvj2CMHBdTQx3WNjTqzCX5Anoc31nz4Ev24F9dKgM0I/K4OByOD/gHPs5tJKTMiwA3r/FJ39FDjyitMdCFS9+aIw9kYnOiowSZs/YhUGw5GxLHC9g9WkYp1rXDmLcdM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JuRVh1Fr; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JuRVh1Fr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN1e/8q9IaJNJZ7rkHWrHFRv5n1Jep6pOP2rcPH3UJaNWbXg9HqEu1h1xLhGOW9CMCvwIgEXwgp26S8OZciGDsD+lIBL8TEL1HklCBJns/X3DidA5LlipalqJl+OjvT0+GvCKMaIMhfGKFJb7TmHqWDteI1XA4RWkaIFQmhp72veepQsoE4gnb0yJwbVT1Wlfqzf+9D1Q1tRNik2m+z0+UkPbem0iLwSJWKYn4puRV7S0SMEQ7EcbE7z0b9xH4W0+he0KYUZKqUt/3PWJb2EBxMDLvDw47YO2A9y1ldQa+soB7CfZfPM1cUeTLh8RYB23vRJ/bsyFMKab3Dd1W+kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=Y0mZQ6tJ3Drg+f1VWugcXxogW+hjTfjmjc7bykyRUMrypvAtCt7PLEkmlDtfAMEJ9UAZ9evUTgtzD1O7VXshF/41l/v+HWAb+LWknjdD3JjnlLzqiJX94UQXJDSXvaJFYTp99xUZGMrsT7b37UWoWRzO6qqV8Yc0ZJVHPiTg6h+WzVPTHjEmXaoQhQfdhH2I0mKV08y45cabjF+bRkW1k1aouZ5N9BTvVBG4y+Pa0a/vpg1dMriMYceXSiuwjDVOzMczpLgy87s4/Sfa5pyLPJn+jhdh4uqS9StugKZr6NAG8rwbDRjzY5t/i4GfcDSeOGw6/G7/TS7nv7yJDNcfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=JuRVh1FrcJpMCblpaLDMoAtLqSJlWyG+oyA1NnwUE8u9e5jHMxdUgp/P0EYMHP/ZN/sCx9LVrNWGQJJNz8kE4Mw2GbRNK/kZRWeek+xVNBkn38j6GR96TCaEynyJlS18kmU91x7hZG+Go2HpjqlIuYaQA0KMMk7OJoN6tWRE+oXfszprgdC3hmgC61F5calINAKmP2PWidKcpWHsOXA0zAl3HYFAN+deb/v7YO9UX4LTD8VLcb6W4TUkPN8wGfyfVg1L1ZOqw5vH465FYO6NZygJ2bmrPA23TBhSjJUZdYGeuTnbuFpvGbzuzlZ41wT4ZWNEpUyoXQdG9vBzD0Iz+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:53:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:54:01 +0000
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
Subject: [PATCH v4 4/4] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1] support
Date: Tue, 10 Mar 2026 15:54:59 +0800
Message-Id: <20260310075459.726495-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310075459.726495-1-hongxing.zhu@nxp.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b31a4f-c4b2-4b1a-620d-08de7e7a3183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	uQ2kdn/nNKvUBNmJBCRc1JXbL6Eiz/qrtqxo8CIsNQs815P7ma5aWsI5hFK8MuMDIpmC3xZTtD+33XSi3SBshHk7nIWtES5t3zJzVi9rxsTTbWl0heLAFrODKTufIp2EUCboTSm4zYoWnJiDoWjaGkaqlDdWr4IOQnBV8BImoSG7OdbWGLKIyU+XXJDmFKn0om8BTC9EQZjKiNVu3gIgiWN8pCzB/+mC1nyjxKO164R3fAoIlOmIORx27unypMSrNQUEDdzjMhECL1UJV5ppnAI/oVl+9h07iNfos7K4p0a3JCu3ioIdubItQa1eRFYZdakH4pvXn8/30uf7CtMcHhXKbm2uCUYWD6U2IiMGgp5+4Dl13OucSxTNArSR/dHN1+cOXfJHMRbLMpxz20TZUeC8XEoWzIX56ml0yT/YXKoad2Gem0n8sbMKUs3lglaBi5456u9t/jVuUFVpSQObxNnsG6CYh5rHKVvrZhbra56/Bvc2Hi4i6LnwqwrnclFwZjaN+MYRqBoULrKQZ1cT2e5nZ1R9jzpCu1LanIHU2VsZ0gX4/KiE24vHToUc77mVlITPDVR39Vc/2y3ORBIK8e218EMCW2/yTetijF+oRefJc0y5FhKKuMj4bZA15w1PLXz3MBUwhfsy6JbDU4pF7GPETy3sRSx3QuH34IgGDapie+45YjgUyMteGYrb+12TM9jbUsEzYH0zQ+5bdJFWLbjqTpnLueikg7rXfRrizJrLP4g2DzSmWwXH5uRQVkC0lg3IdSRYmtg3MP8WZzYzpD+bn7uzRzDhCVR22zWQoVnMB4nxETjIKR1ZTEs+/O3f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4R/FKiwWWLdumqxpJWL/2gtt/TQ6xtA6Y/F+XrXIZ86SPntnS2X8hrlfkA3V?=
 =?us-ascii?Q?jed2NFBYNWhPyMOby26CZ5r6LIImT1D5HgvOxyOR36+0yWipbHIFBuZj/GN0?=
 =?us-ascii?Q?mDlsX48YFYNijg/RiUfPQlYM0sOpvhDw1ROIO6nBb3gGAC+AffuinHA2GAKR?=
 =?us-ascii?Q?Hg9TEixtOLRH7ESYtrrSDxstm32M1oH1RBjzP8ZUeuk00JMv5VOipwRSdoMV?=
 =?us-ascii?Q?5/UYPu0Uwh15yOVhIk9hQGB/A6LbxfLY29r4IMONz43EYb4299ofd+x4wfVA?=
 =?us-ascii?Q?MfuGNlObCGFJDq9w3r9mLFRk5zuNRLmCo72F5e1sQNCcC4TXVgO1OhI9KO3C?=
 =?us-ascii?Q?oVG3a/RXVdkm63iKoHyyWis3e3KZU4ihqS1bW+yhoHZDqzkv3Hd067zzooB0?=
 =?us-ascii?Q?5+KYqZ9kg5XVv1lyKH8APxKJ+kILNZHq8mG2fNxQ+VS1OMaL9kgxvo9FanwN?=
 =?us-ascii?Q?sC6yBDODaZrEkt8XY18B7AKCOffBzAqN3sEKbdOdjpOsD8B4Q+b1QxBJGSOo?=
 =?us-ascii?Q?D2pz1oJ2Kckc7MywbpsccLbThAQwu7k9d2QWrRAqfyaCuwbtLIZhNXMTlQ09?=
 =?us-ascii?Q?DL4rrmYqTgtuYukhkEM52NBOOyLWfzTskrSnD9g7yaTxEPwfNmXa1KFrjCkM?=
 =?us-ascii?Q?MHjMVoGbqarqD0vtnGk12WjVL8fpKR+ipJoO6txVpjp/ZMJDnx+6BHO4rh7z?=
 =?us-ascii?Q?/yCFIgbdOe26ZWR+h3X0GL2fTpKMZiC9p8H3wzaQ0OXqM5rriQF+rQitlUmB?=
 =?us-ascii?Q?YCTkZLxF9bt9x71mMsRBC8BrXXA4MunGDmPv+3c4/EXjhux6Mo5Dtowy2Wv2?=
 =?us-ascii?Q?eAyxhcKc7iVsLKOKIXMJ6+6iOr/lws7HPUVc8YMFjEpz/VIFTIQ+duPaEEec?=
 =?us-ascii?Q?gqnLSMFhRtPFrHoTuWz+0oGruWoa8khc5ge0OhFm/WWYqYGlm1hoI7K6a3wq?=
 =?us-ascii?Q?8OQ2QHFgJ4TY4VYcfUzNyPpXNZXX8VTPWAw37MKdapkT2sg2WTkUd7KIyTZM?=
 =?us-ascii?Q?huecYsPthOWj6/fazeenJ4a/POUoSfxHR9JY3ArhMCqqpSAlSQOiISIqt2UD?=
 =?us-ascii?Q?fjBpjd8lAp60R/epNibG5+mDJpPk/Ce3ZlPkA0sArYTIxGBHAWRK/JDXc+Rf?=
 =?us-ascii?Q?D0E8a8IAYbeuApEM2yXDzcbJ7+Koyhrn6WQNpFZOsiqVFx1FFTmgNRjCH4A4?=
 =?us-ascii?Q?5wGma8Oqw5qW2vwfjqd4Fcn1vP9lVou2y+qLJRSs1uUz40FQYdi+bSdTzIBh?=
 =?us-ascii?Q?bwQNCOYu2nhBAGJdUko3jn+HABwuVMzeijVAOJJbW03tb28RYFHbnRcU/Y2Q?=
 =?us-ascii?Q?4rVN2yh8SjZnCfYtQiQBhl9taLGDATZLyRQLoteFxVOgO+4ARtVmbC8fAyWJ?=
 =?us-ascii?Q?06wURyXT94/BlyS2hj9BZwdHUTZ8amUo+zqajGSdGvIbt0RP0kqjAwTvKYTR?=
 =?us-ascii?Q?624vnj8vtRQKUySKkEJXX0UYUS37J1aQv1Nb8cA8r2Tux6UuV9xRoRHOPjrd?=
 =?us-ascii?Q?EXiOTASeCrUCc8b+CtoyE4Je2ypTj9WkUgv5S3ZH7TGnDoBYTpLY6d7NsrNT?=
 =?us-ascii?Q?6Vs3YjUb0vsbqWPUw/C7LtNaocgHzevfrqfuo+d13czEu44cHUSUi6hfmHEx?=
 =?us-ascii?Q?jYlShEGIdOY6ENNnBeOJ07OdMlw8f3ck0VW/ji6J1foHLxA+F6juMIx05PJS?=
 =?us-ascii?Q?1rCKnTQzZEOKSUwQcMsO7bR6CnsvMajVRw/0j+U6dvxxHYnbohHn7OGQqcEW?=
 =?us-ascii?Q?Q0NMsXDQKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b31a4f-c4b2-4b1a-620d-08de7e7a3183
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:54:01.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFnaBd10DjA1rXLSJXfOs2NzwpEWVwgKMt1s4INzj24otISZheA+5Gwaf/BmA/eVyNn+1uN6MDgVfPQunzLJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

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

