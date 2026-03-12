Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5A3B3895;
	Thu, 12 Mar 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307611; cv=fail; b=ZpLEnq0APbRVFRpP4AQmSLl/vZkQ3eqXjzeJ2RPy+dybS/6giZ9cqdpAC3BCRu5Rc8443fsmHx0YPex6HjqgdXe8uGg4pm0lJl+Pt6WT2CjKCgi0hTvhJL79RVO39LfGe5Q1BHhLpV4Tn2wrjP53VIkqy0tRwSwBTXaBZavm3Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307611; c=relaxed/simple;
	bh=6YaGO66SM5UqcpEEOh8b/zmg8GKpIGHvnB9Q7a1YirA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBJWtNuw+LBPChHWviFkXGF072jEzjLqSer3TGEqRrbXEbWfwQlFKtq5VInUzeRYi0MbdkpxoIPa77BK0OKd3WOPWogkri78wG6BDhiYd4dF9I0CLDFcjrw72cdciJPyNadwsdlg0QMOdFg3cMOCiJb16x5zKePEPPNac8VUgwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YyaQmoht; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YyaQmoht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olAfcqfltdEorWp9yrXaFou0UKYV8xFloxhCCpRUQC589JWAV/iXErLEVMOpDK1DKrCj1X1cCcOuS8PMnqxAU8fKphEs8ElR0ELMJr+Z9mSCqw0gNYp32k8ejsIse2pVBAmrFAGt2K/eemaqQq6CsMKXM1BI2Hbo0EGM2yOuJ/xeqTdeo+Z56/g7xbe3h/ZatVyLC2S8AzRFqAmpgo46xa3bG5H7two4r+oDIz/VDYFj/J7pgNHGXBiAELruiiTYGUKqX36v8734vcUUaBZBvbo7O/OVMkBh73S6gWBRuvSHbi7X41QAkOlkTRrIMWxS/e0oc+wyht8NcGhP8Yc11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIawIhb0AxseLO7g6LBU84JLdxgA4a7ZEWtwwZHhkIQ=;
 b=QNRQuPiDYtwMdIYfLuZ95E1E/5fvTtfj+ZDQ5UymNe/VoNPl9sfReRszT55172vZdT8eJgrzUClhTWotutJbUxBWY1nbsBHOxT8jvROoS7hnp5kZqt00sHgb9E6iFj4Gn8n5N0NaVx56A293KeH4VHlZpPYAwMDYu29cGyONTf+qaGX43v9/UMkjmNgFGp+slXdV0k1l0ljaSYGJHIuWN2QPcgDtFupniaMtMJkr5/KpTSFUW+2zdOOHpNJyi4xR2TkPFgUGgwT6WWxDjTPGF3hMpWJmtvFkVvaPdv1V/iP0oT9tmILefBw+j56k6icfSSfIPoRD1KmWQGUXhph8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIawIhb0AxseLO7g6LBU84JLdxgA4a7ZEWtwwZHhkIQ=;
 b=YyaQmohtZeX3of2M3qjyfvjvlTS8MHyiSQoC+q7fPa6KN6nVXSOFWqG6o12SFQsTZhb2GoFqZjdtG0FWyY35wu0EONEE/KglYRlHKvXgzF5J2sNU1BDc4f1OdIxn8icqdffqBVlwrIszd4bmkf/VCLPYLl25vNYpQknM2J6wrti5CpKHwNyi4r/7EspGZmTE2Zn/AgJvK9WxtOyzPSFl7FdcA0t4Pftnq2F+lgwdcfZ8jOx9oLq4ZykyWiG1uTJU81aD0Q8hDWeJhCjHpI9jorutlPomnqDSoA+gpW3diZ801D76ce3/Qn24Yr+cZpMrBQakyraL7sFJXmQYSrU2Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:26:45 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:26:44 +0000
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
Subject: [PATCH v5 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Thu, 12 Mar 2026 17:27:43 +0800
Message-Id: <20260312092745.295578-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260312092745.295578-1-hongxing.zhu@nxp.com>
References: <20260312092745.295578-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: d2da04cb-fbf9-4fda-7a95-08de8019799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QqD0OYf+L/p+2YouU/yZ6Tjvuv36QCpGAcScr74SJ5MUCrXAGpOaBK/U5n11LAwq9asl5qbdC5gUs6Z62Bc9J9TFLRD/KHgnoJiR+KJ7eATeFZFQmnST4BqVDtIqfHS7Eol2v9QDBMzHvqQmdWUxJQgiJVJcDvRc1Wsyy+RQPXK6tpZQpsOuunZhjiNEV1RuROOXwFWS4vQVBk8kDbn1ix1u8o4qB2Nlce90wlWweSWuzKIUupZPaw9i/BEQSBwj9mWmEi7WYE6qYbwXluFpr2wZkC5q1eYUhUf2uC7pInVFgunhk0ETcWNIK39i3nHkABSASSJmDb06SlIqnbcQza6513rN5eTIw72gP5Tys5PQreij1zulZaDvQCnYFAN21sPZvROjSpRxSsYdO7382KtxHJtNMb0uHvtQdUKwBIXsg6g4sxrZiVAdizz4IznbDsgAP4bAN2LwS6THjG9RTzBT9q6nWUtIypkTnWAdxVrCwt0pAiOLt9sVrdd2vrI3zZpHA5t8uLbIaS5ZyBwAH3oopV2hA1HDjYhIK6V+LWWmc4BEbg3iLfQuHefyzN1x+OnAfB/6J73wDCnqEQgRkIvgUqk4b0UAobWK6jW6BLZBvhOAdYY8F/EqoRSULG1g1UAWkBIS0y5K0uWaFCOh/NqAE+QICjUR1/1Ehzv2n/uuHAoxqm02JKpq5uBupg6PnLGsry/f5oVBANXZJtl4sty08Pm0n9QBG/wmj0/Su+GQsTsavtGGEHABn6KLCGHHO/5yJE9dIQ3R6yFr66lr+UI/RscJFXiYxHIgjnXWyu3uR1UALtFhYjRYl34lKofr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gkyq+oBs1oXekiZInnB6wrfAo0DEhHGYGWAugceu1Fd+09SMvs9oXTccCFkZ?=
 =?us-ascii?Q?3/EHyQLC20b4RRWdwE2Gt52x+2BWqhaIo/z9kOjaqa1HBi39bmTm5JqImd18?=
 =?us-ascii?Q?YzD3Yd5SUYDwjTqz1/QakLdAwU9/wduEzkbYRDm9OGdtm0YtH3kjVNrzzWVQ?=
 =?us-ascii?Q?guJmxCjtxNCPmx0/R0UgbmLyL/Ohj/O+b+g8i0RUiOJKWbfBH37DHSof1cpH?=
 =?us-ascii?Q?3neHojTywo9RNp5FUWHgPGk6KySuoAvbRDa0tmJs6SXJ58fiT0xp/NIxMngI?=
 =?us-ascii?Q?0/L12ykogI66cakBKF2xphdNA9yVo30Btn3SVJNTPgDhKq9EIkwWktVM/OId?=
 =?us-ascii?Q?2RF/oNUYYj6JfaDw3WizMIMp2+wtt0MmpjcKlHxmCFcje8gL7nlMTzeshaWa?=
 =?us-ascii?Q?R3Hfi39XSdoMK9iVph1NZCtrI23IkkHrIlb5m92K00vujmJEhGlKPVaF7vZs?=
 =?us-ascii?Q?2gMQJAZC7ZdtIh75Sg8+MzYWp9gNLyNeXNVdLqO6DyDJIcvYV/NrjAbvYLlp?=
 =?us-ascii?Q?CgkWxGKF4DfaOiMKLDqtcYt+fEfz83YX2LSs0kYI73NbP5a/YsAtlUAOHCoJ?=
 =?us-ascii?Q?noj3xxXRYgELoyENckJzLIwm2EIEcNvYWWUEV8CVjwiaOR52enQALRd4WHUk?=
 =?us-ascii?Q?mUTATIg1th1shuUq+jnaAZhOjxpiNuaHToHphpEnaOwD366Hx/HoBtj5x9fM?=
 =?us-ascii?Q?Tc+2Hu3Wwrt7M5PoqxGXegS5h+NyKbRJP/qhKDCa7/1ecci4RVpGfA6KjRyE?=
 =?us-ascii?Q?VFrcyWJrWuapQIa6/180FxQxfYxeK7HNZLOC2OHT9oLuNfMAmsTTyiCgZKym?=
 =?us-ascii?Q?vOLeYPhFdFKpxMxvHMEZjqEus8wSvAD01BaAoM7gP3pRnafuSbtw6dhp3Z0W?=
 =?us-ascii?Q?7uYxh9x4FvrvQ7TYCfNSVe41DEuwtHB1acMwa2iPe3+tlqMp6+MQ+b+mMCrn?=
 =?us-ascii?Q?DcenNn/FaQTlV5IsX1oXPv2VfDrsXa5Fh/iOuj/YLLjH+CVk4gpuvpTj4YEP?=
 =?us-ascii?Q?ailtLgcpfFL+Vz2uvwXMXxEPRWZY+sQeOUn3mGssD6YbX81Zasxiz0S510Zb?=
 =?us-ascii?Q?gdrnay4pOGxt2lsfqYpzQ6la3mU7e2db+MhgPFcV6cDmbGYbtNs2wOGivrvy?=
 =?us-ascii?Q?ee2TEBgX0S9NcMdJ/nF2sPz2RaR8ulzXf6KpR8/jsYBNo0AUGp5tGsEceVqN?=
 =?us-ascii?Q?/dIuaKPvHDjvecMJhHli4ru24n30Z72cAUOhAp7nEgtfMgB4FWq0yY/AYkaj?=
 =?us-ascii?Q?NTRXjaLGHlk9PMz06w0a8U/ORlRqUJbdHmElLzH3XuDcIQ7A9Mu8ltA/opg+?=
 =?us-ascii?Q?dFGdOxmWP2gYqvFpKqENmekApPKt4c6Fimt6omVWx9y/wdDF0dySB2pT43pK?=
 =?us-ascii?Q?VHdtz9Fv2v+s1DxVplykJ4d9VdkvBImg08bucEqiC/4hRn3+dsFjZB9B5Cyf?=
 =?us-ascii?Q?H/BSLwFmd3AR9JoWehRAfXhvrH+hxHL9IjQNh3/h50DUX/eF5JEeloC8+wsM?=
 =?us-ascii?Q?v4ILUzdM6P4dMXEGp3fQiJaZ1YN5zeWmGZY7Vu2ivwJe31DxY0eRr6zitXij?=
 =?us-ascii?Q?kXHGC/hiMZT6SQPiAJiR2JxWqFB8pl9S9fl0H9SmTqB1aAy7QYOCi4Mj/A6p?=
 =?us-ascii?Q?kenmQ16yj1ywa8Sp43vS3R67ewd/lDHgvoptbVZofKiIffMHjVTM9yiJ+3jW?=
 =?us-ascii?Q?ncHe2mByHXwo/fs/eqzfexvcxPpM4XxXc2womuXq+MR/mr+AIuoIWadJQgMp?=
 =?us-ascii?Q?H7efciGBAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2da04cb-fbf9-4fda-7a95-08de8019799c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:26:43.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz8Xiw6tqFat1ST9zW2vATMfDqCtkZlKPr2ahwCMFW6m7ZxOfbf0SlLo6GBvmW33718uhhxHdSBUKIefcZoRFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d2f31c8caf6e..70eedd98e89c 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -66,6 +66,13 @@ sai4_mclk: clock-sai4-mclk1 {
 		clock-output-names = "sai4_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	firmware {
 		scmi {
 			compatible = "arm,scmi";
@@ -1223,6 +1230,87 @@ wdog3: watchdog@49220000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		};
+
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx94-pcie", "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			msi-map = <0x0 &its 0x10 0x1>,
+				  <0x100 &its 0x11 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx94-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x4000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX94_CLK_HSIOPLL>,
+					 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x10 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
 		netc_blk_ctrl: system-controller@4ceb0000 {
 			compatible = "nxp,imx94-netc-blk-ctrl";
 			reg = <0x0 0x4ceb0000 0x0 0x10000>,
-- 
2.37.1

