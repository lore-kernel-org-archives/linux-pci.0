Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C87228CA9;
	Fri, 10 Apr 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788234; cv=fail; b=EG0zo3hcX3iPGsFRpMe+1tbSMcbFQMa3/88ofwfrWl+bkMeJDh9VD+0Byd3/578VN4xwzDh5o6T0Kdy669MxxqcC6HRpFfgIOi2qqPBOvGZ76MSREpL9z9Xxgj+aSKk012h1HUzB/bxJ01czGrd9aI60PzrGwbuJ+3Wt2SNB9bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788234; c=relaxed/simple;
	bh=xzPgWC3CfkAwVk6V3+XedDsGclq2F+T1PYkPZp8gzu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1A/jyMqv69dygy8R0Mki0GoKC9+3qJo5zCTkMFn4RU6+EJLWI4XGzw7AxwYOBx8bj3SLvOr6E/RBP4TVerC2JJc5V2G1lLPi964YFHBINacFVj0EgJE1mO5Iu4ndagbB3Wv//lGRRgWsl3OoxnWw/BM/s7W68xp1LzcXjMaQmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iu6TTkBW; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iu6TTkBW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFHvE1r7rabrx7WZ/SqQ71O/TmBo6hSZL/do1Se5VCjbixKEHur7CcIhC/KZUg51b/YFhUuN6DyNLD2u1gbuLy0WMyV347xWuNSRuU5Jy/JWULlSHxokx0BNtLMlXXE1pv2OrKXgc5Fd9j7PBaUL7x+hhay9a0VOHtCQYKS2pU4nYt10dsuJ6j2mYMkUudXN1Qtt1hUEcB1n/yX6LT1mrctDIBCUq4E0wXYJc9CpdwGKg3E8GtmUreLIwtJ0gXqOfDG66jop5PLb/0uH9JwFSLdZiETneCp4nejnDrwxwzDhx2scgPHznmP8+VvLH0btYcgSUkDubnFwJeqeeijJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=cABZC+ENgT/jh75GmrzbJ726mvjyoO1lXCrH3NKeVsYe8uvJGGR6m/52WPXQh8kO9emfI/IIuk54+ReFJaIJR1zUcNJ+650gM5iLo/YT1weWGfkIyVACVjjVZXE+IsrIxlI5TE7wywEy5TTu8HzdZTDeqt6hDibfLXSA7Hjz24FYqtIuH1zgPWa2e57zmg9qHSOBN4OPGwVizGap/NOXrt3nP7SUF/3RHJIEhkMIH7o4icULhT6K6dxcfWP12iTNb2ljLPaOa6xyCDMPLIhkfsPA0Xw4N+IbSuPc+2iNBxrV4G20aEdEcPFLjacCVBW67MfyQ/ewiDp2qy2SlqOScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=Iu6TTkBWGXdxWu2Az21BazTlGDdF/eHIttMWPUdxv/M9Pl1L6fmSbdSd1fLmAZxeizzmKBbaix5cYzv/n78T0pYPIwAc/VlTvIPlnGLkkdcEtp5y9w2kL4e5zY29hWLBksviu4Cw2le5SnvovBdzOAgxlJE5h/+37g98uxgE4vDDo3/vkgt9w5oGFRZFCWbv9VZUvPVu1MXniEdmWDuRkz0EP0/7XvztWZg29kEkGNdb+pp6YVObL2DTLsQfx5ZLDEQun3Qb0gHdfsTSyM3AhyCABkoiYDfmmM/9w2oRfQ5RuNoYNt5NTFKaNQPrTHmt7jZQ080ORS4OyzGNZo1CFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:29 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:29 +0000
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
Subject: [PATCH V12 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:52 +0800
Message-Id: <20260410023055.2439146-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 797a701f-ea8a-478b-bf28-08de96a921d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0Pi/0xw9i3yGC159AK6qPw9pndXyT2dw1DLx9TLvtMsnkdA6NiPSsHyzK6y0Jm+TcGdgDZk4OGufIOcJjkN0LZppZUe8PI2vV3H8RWiRnbHeuITH4DqdVdG4vqdrjUI9yGjm5TNm3kNUDOhN6LjMA7H2RdPzhQt0+tLPbStVpd1krk3vc5IV1njoFhFvtXc17O89rsuA+oezATEI/A2F3B0iOJGnQAVhNc6YFhHaRdbckEUp6x5smfzCBbvgC5zm+PAEv7A03UL1B9U+btm1pndtyMx6wMkbSgBMmLSUWXHAUPvqHymkIGOW8/g2jbujdMJwk9fu/P5LreXTvTKWX0rpoMKSITog9Rd4kMd7Nknq3pT/NJ8oq7m/qTiOVRI4NVqHK+Ysjj1Aal140DEBPTlKXDdoAIH6SmX2Mje8jG00JZoqUOaoDE8G1g/MLdD4Bt0vvfA3Z36pA5K/dCXjTBbDYwJ+9AL6nkArDvmxuzNhH//nvyCAi6AiYcw55lqLL7x4jXfD7vEvWjiBIsjf6R6HoSXWBG5JipoJuujbz1gp5VW1XuC66QCpdCxz00ZX0L1rdJYcoMaKZj65DjXr5mf7WVU7plErJ0IoOLLEfEvAPkq4lRTjrM2fU6TXYTKeSDBJhpcJne69bZvH7OoD1J1zToc3Jz6xqXppEjpqVkjbDmtGYwwHJClxZB5pEkEskYT8H50z7UUl5eDlWnDLRs1fWOprrcDYDHbR8C6qoXGlMDwaWQTvY1k1rN0zZ3GG4relaRkh1VQTgtK+E9+mWDadzAqgOBC4yWjIapf/o0E4tTgeNfIqiW5RTPKo3Tck
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7r7xvPRdlof1SKjVHK3xKBqzSUC/dYWu0OzsVeAlpRK/JgiDw52dhw8ze5gz?=
 =?us-ascii?Q?QXhW75NgtpyJyPqY8RAnfnelaSNLl/gtV4IQt2hSXkJFKsWES/RGu5kd5YqC?=
 =?us-ascii?Q?+nyb48PtJBlasJmFt26MuozcIjBfmFEy9NBwNpBZ+ccoEL/z1zitHFo4H+OH?=
 =?us-ascii?Q?uBXyU4nhKIOR7bM+q6jfup68WipUBS/Hg+a6f/9Is2x3FgR/cvP3sPzACz3v?=
 =?us-ascii?Q?jGgJfEaJtXHICtT3bpqdFDXiKHZcZYC61gEOj6w5uWSR4iAXzMUl0wl52rmJ?=
 =?us-ascii?Q?miBadSYUWJ8swlD4XHhOJrdMA2ANkfslMbJSXuhOeZvB+Lp43JUsKT/PiKbD?=
 =?us-ascii?Q?e4g4z9c/NY2X82mKolhWnZmBrbYw31IM9KsbMqSoojcY6gmr4XUxD3PkmOU3?=
 =?us-ascii?Q?H3jtcTNUowDHfPyFXRBqMCbRTU4WLtdZkvDX4o8mRv+ycspRTm/zQ64NWWkz?=
 =?us-ascii?Q?WchUo4tQ7COQfLmVuK8Wox/IrrdT1+FiPPE812OFK6EzaFPX47OhNSVL5mIk?=
 =?us-ascii?Q?qYAdpFKLixZeLSv5OoDYCe05sCnVHIc5/xmvj0O8A7Odn+HyVpoUh/0Vv54D?=
 =?us-ascii?Q?UUwSP0NiE2WcmJF3Gzcac+E2dtYhs/7PS72dIj0j0l7oy6Q0Cnvs9UvDIl5r?=
 =?us-ascii?Q?kL6k5gYBonvGzdFMCmUk7Ld0rYsNluF8iq24xJq27KU2AdkPhV4mTy8++xGh?=
 =?us-ascii?Q?lte3J53tAnNLVmQOKFhmI4SQ54+JLYFy44y8uzHf4vZ0CrY6luoYdYvYIJkt?=
 =?us-ascii?Q?ZYrIHn2QXulGMIosENgWIYYqyzAMTTo7z1SlNb7iMMlArwb4iNXzD2ZAa26l?=
 =?us-ascii?Q?Po5HnA6rroQmujURKmw/oMaMkZHAJ5vdrOB8S4VqljoAUSBoQpGXGcgotfga?=
 =?us-ascii?Q?59/sbsSLCX32rNYfDsQM9h5OIm3dFZR35h/rL0Bg9EdA7WUFcpOj8gsZulX5?=
 =?us-ascii?Q?c61nF9jmWiNRaS/Jn/9OOb48jIM8J1J2BmxJJ6O2ArR9IkzIYeozN1d2BzS6?=
 =?us-ascii?Q?SWwX+BwdDuPNgH0dsINbrU1dbBWQ0vDShoFzICe3Us6xzw15gjhvb/s7z3GU?=
 =?us-ascii?Q?L+F2lIJGVX4cB6Up47T5lrBQyC7HGwSUY7P6d06mfYclWgbm+xwQ5rSGhbup?=
 =?us-ascii?Q?YakUMD4ViaGHNEQSs0LCw7BgPig8LzMTfmFg12EhiK/ZJzFOhsJIrkNJak09?=
 =?us-ascii?Q?w1S/modU6wjAkkb/huBnE4aakGOzJ5kBjxDXt2YC1xqzqmt+lD7YGedgZxEJ?=
 =?us-ascii?Q?sDeN1746dyUXAKTbnlgmdqDvE3KnD8NXUY2bEuMuT1OoOVdTnBsE18+290TM?=
 =?us-ascii?Q?1ZW920EfhXGUMyhF+sgXIFMKPx8htXKXSMvHa5iBZvxWn1iAmzxZl7ZsdD8p?=
 =?us-ascii?Q?sAlvudjxYFkP/AX0iK93/+pTMzENtL4r7Ass3re2yhCs2cPk16Vxt9xzh0C1?=
 =?us-ascii?Q?Qmtrc+lVKlFa5Xs5Ub61qWzGKI0+EAuqbld/mMGQYdFRjaNlYB89KfuvpoyH?=
 =?us-ascii?Q?h7TBQlyoEHW/znxs2CSYYZZWED4hcsCAoZvB8zlAI7z5EPGhisrPKYs7qrtO?=
 =?us-ascii?Q?eScY9V3IZ77u3zJcJfY/xAV5XYcXTKS2dnd6SxmIs2Tp6CshMurY1hbc6uyl?=
 =?us-ascii?Q?UTMuLCKCsUhLipOUKe3M1HKsElT24eW/9YcDQFp0esEAIemrWC0Hy9dwQ1+2?=
 =?us-ascii?Q?21BUi/dBWl954VXR10aS/V07cXWjy2x5jfkYBz1j0EH4CFQpjNay6J6mLZ9K?=
 =?us-ascii?Q?ps75O8x2fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797a701f-ea8a-478b-bf28-08de96a921d1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:29.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxe7igsOB6Pfux0kLeveo1gNbGwxdtmDpYl0JwliviI5FPfzhQS58cUBx6B4RuJ8DTZyDzSDwrkjWm4sJjABuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 2feb5b18645c..a7f3acdc36d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -770,6 +770,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -783,6 +784,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 90d7bb8f5619..5ce2825182fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2265,6 +2265,17 @@ pcie0: pcie: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
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
 
 		pcie0_ep: pcie_ep: pcie-ep@33800000 {
-- 
2.37.1

