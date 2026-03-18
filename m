Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D551364938;
	Wed, 18 Mar 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815328; cv=fail; b=LwQlmX2RcvxdmMIPujUF+QI6au3fDEVIk2CWxUxc8JLMBsrnCOSP8svPCHMp+C+nxxlhTOB06ly3GPkwjTMzah+ZKqCX5S15k2SJ1R7WG0CWbIG5acci8iF5V5luo7AjVNgkckdrSiDro/5YSHioPfibocUH9MvgIVgfyK4IuIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815328; c=relaxed/simple;
	bh=DcriXr+Z8ZbC7d00DxqdLzuiQjIj/ZT0nGz23NB1TZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eloIS4u3P+pvZuTuKpmXHaBQT/9nRj2QjAQHJ+xQicAXTMSbmLYI2DBEJEa7nWIan1lReK/zns8r2P5FVtBGMQylHwxcLDfp8g8bxUEe0uld1G6CRLNLMpFV1+VMQcc3/4/cyND+ivtzjxbQWcYz9OtpiIpPImcETC8DSgnzBUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZOqh5A69; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOqh5A69"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDjbVy5Nak1Tjcr7Bb45Ye5m6+qrMzo9v3kK3zGTcUx4dZC3fzIiOFnQuy854ZjZAqGuA7gWgNascE5O5QQntV8P17Pbot02wmwihNOJqsgkvcpiyWzcIn36D9Vch6KYcpx8B/2KOPDIv9+cHg5spGp0rM1apsPuevdpoyJ9me4zjU9MvRL8O6NY46KjuT2aztJeeFsSeHGP2flGzASGDetPQWTk89NKVjVhXdX38bndIau4yAu+A5LOmUfEYIFk6bAFyD31a849Kcll2bvplAitnm34Z00pfEJqZhjBhltVwc6uQUHOlwNcFOKWHfgqtPAxvAlCC7zAMDWbvG0z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=R/Ox7H5I+SmEwwlYV3IJAWu7wWKuJZ4I9k/CsL/irYqcxFTyPZLQDEeIhw1B8mHTbgLpfY2zapXDaTYKcmroi85HlkPTZBleqNPASgc/tGQ62C1iuSoBb5fodgwn1IAb9aJUxJniHjPSiSEsIuM8reH7nIwHJyLTHO5qDgLJDzEOKNHUOB1jeieGEfRpGED6gQskoSVWL+6g53gkOy5K7jkAsOtNvBO2qlGU2TRLYuC+d3snIBO8Pxo8rg4mNDe2OGs1Vo6CPOtFDjSlkWlTTzRp0tweMxXz6pIvvBEEWcs8RKn9c7V68R/u7qKg70QyEUNyxc8tFgqOgeKYZwBcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=ZOqh5A69LDJu3IEfnonuPUQosjRKy4aT465g0bIbGuMsLbQ3dSoh3sTiDw7HAc4oTNKhYwKKfx4DCFQCRtYvSV4h0gjka+U5so6PeKbGu/IIYloTVeSs5Uj5bxrimkmBZI/iN3SF43pmCKjneMiesVsMXPK81oyotGi9vnRhAypm5Qk8OacWECaxAAGesk4dUj+EwfmnRoEVBXxCVQBScEHU1i03fjOW/Pb9gyYiwGKtvqXApxtf6iVvYGPcXIFhQKERQw06P0lhpUmR9uvkU2O3vk4rkr+Rl5tMFPFhrXSWsEI+7XsfcCszuEXoWEJUeyKz70N5zHPaGp1/0ehHyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:43 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:45 +0000
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
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 06/13] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:09 +0800
Message-Id: <20260318062916.2747472-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b21d3e6-f619-498d-2764-08de84b79add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	5S5J2BHDkKvlT+lJauuxsanpJ4+V2RzvC/Su20PH/Oc+AVU1Wnb3vj6MfoEDkpxw06x0ROOiJ42ZaK6725lmkDygsZzljvDO41tDPW5cQwdmAsby4SblFG52bg9arGzbpfjQJhSn8RTNJ45wXwP4Ahh05UusB7XdrP1l87cpZGq3wKQmGJGDfwFuP0dsOp/pOXMJH1thRq3KxsqB8lu2eFz34QapuyInsGCOasOB5g/WkRCTMJbm2+4IB4E2akdSLrIOZhYmEhJgXl8sKy8MHHETxt1SNqICwLtUOv5aaaSMsfPn9aHyXo1sSZIvFkLnz1PjcCUQYGEWNHOFsQgjSAYiVGnYXgC3JTcqBOoBP4z3zURuZ5c/5zg2isO93cZ1dgmc1Eo7UjMzmAiwOgDIcAKkyEqFAYUy4LhKr4toWGJCQXYEU9dzFody3Yj+H4QtNLBG5Lre+LXauZ2xwmSxDVdPCpWO0iU5VeNHLWqcpI/MrOy4a2sRHvRcJuPU15iSrRqpE8N9YyaIHyHPgEBuU5aNZ9oJ8DsOru3KpVOxbCvpVh9+rv9w9q1E6/5sxdM7JP36zIPiT5e0popuMq8HJgwd+3WU22DDPjlwPR/4U9HbhZCppje6rlGsc+ROtXPFJFnpmSUr/M96FDe8WxJTHvcRKYpW/qZ+hcF6BXnOnqM1IhRaoqWZ9Zun3Ga4T9zSRfRfFp/OTWmKemSBgCtNWcbdxoQSwMkgi465RP6nfqeYWm81d64+mdh7H4w/TngskmzmMzVULgcuISL15cQSg+XRG7/lEYfuFkd4VF3a+6XwPq2NGqIgv34MhGG7KnDX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kvHXgI0r2zecq9EjgShQZpbfM5y8zy9H6IVPFCBnsz2K0k3IgIsN7ftXW4iE?=
 =?us-ascii?Q?bvcsJlfxxAWwYPFkXdwWEqi0NBhH03LBO1DITqqfhwOSA3FyfDvfzbwZuaDj?=
 =?us-ascii?Q?HadNIdMBsnfozfIjuryRYOhKpKE9MQGjvy29KIWPwTNcDla4mNsjiVH+Wbvs?=
 =?us-ascii?Q?8JN6eNomWFruwd1DqDbhKs6QGKl1oyedvnUBLgtKVuz2HRimRpGN452QQNHu?=
 =?us-ascii?Q?EOp/Pay/mF554sJ9fqge++c6F2wP14MvlnRVBmKrg50ndUQcTH0kO5xJtTxd?=
 =?us-ascii?Q?XaCrKD42ZJ+TrtVShrKLbCAO8eLj0X8sCnTffs32OrNapab9fohJ098GKeU+?=
 =?us-ascii?Q?BvoMFsnE806s4v8OHbJUjnaoeezC0Ci8WZg2sAjNqVT0kbCEhVjmF3jLLtlW?=
 =?us-ascii?Q?tg8xPR2H05IVt3wXpnLMmo9v9e5aqvSQViJ9HeQWTrWegHh+cci7GfsWXgcz?=
 =?us-ascii?Q?34P2f7xoY9hWhsMcsG7LnVJ6kB7kYrjwS4Wd5rlayvcX1NlsMlr/SChNPK8n?=
 =?us-ascii?Q?VcA9ZsutDLSyjnKGTuzB3W41ls/vRtv0jvS/op3F5sQzwsEWGtbz/QXnFvvg?=
 =?us-ascii?Q?QR4mLJLiAO62iJlDTNCzjsfMGQjAVbPlNE2Aebm1I8Z7R7IvpjYvbs36XRp1?=
 =?us-ascii?Q?oTaWcUS3aibsKMAOw7/DQAY1IgCTLWOASUZe++63D4Ey/zDYsaNDcAXPnjV+?=
 =?us-ascii?Q?h29ov0U95Owy8zjXi7qXqRQNtbwEOi25o5KzOFt4qjDWttjqX2KKpM8ZdsrU?=
 =?us-ascii?Q?n3Iw+fwXcl9+k67IR4s5KHoTl+DpRPU7dYxUN0KGeojiVzq0LcfIAVzxPh6j?=
 =?us-ascii?Q?6jTnn+mghoEYghA0d/7kTCgtqFF1JoF+iq66HEBQIcsUwZxRce9ziDj/MGmm?=
 =?us-ascii?Q?SaltaPb0DhsuKjIcFnpnTvdtEsoh/vg28C2uvCFyglTbRgcdrk9uoq37YvMC?=
 =?us-ascii?Q?QR0i7JkooV5JdMG4wjgUz50feFRGBn3FCLk1vHKjPKClksep1vEtsMSMMTyK?=
 =?us-ascii?Q?Iyd6eNWAYYpAQJpsvMCWV7XAxRlyRnDFya9prPHJ1cPWlA2arwjMl9LWViXa?=
 =?us-ascii?Q?H2RZ4wiZf6j2OfYDn0voogPfKDbEpKcH4KbcoKvvJipmuHx0yreaITwz7VQT?=
 =?us-ascii?Q?i27RYdn4R7Mz+MY2VAxb4b73Q0gDRAn5uFEjwUsZYpBbQXSA7+Ps1zpWtAOx?=
 =?us-ascii?Q?C7nEoaOUTH6bwxPdN0ecYKKgr12ckfmx3PhqVZZq52GrBQ5/T9BRCaYWDXnU?=
 =?us-ascii?Q?te3mUnWxUY6AEw/IeSh0BBgnEmePshVQeZ9hcx4Baitdz27HNRpkd4MDe2Zu?=
 =?us-ascii?Q?bC+riDDwg6sDmMIQCA7RWoqIQ8AhZlBxrPBIjK/nm+awHjnvPOxcAW0XVO5l?=
 =?us-ascii?Q?GInt7A9MpaE7U2CjdNKetxHGGxBDnZLSxdrKRBBxoR7Yh4BUgI+XrtDvi/cT?=
 =?us-ascii?Q?Fl6S/TOG2yYEqFgn2YfeLn7khUSf84yVnVahBf0QTlyg2wcN0LIYG9rib9+s?=
 =?us-ascii?Q?T1opGdxkFpMlUQ54OPH1tB6wzhDt3npwu3S/LB9QcXUehbD13XRDUqVstcPV?=
 =?us-ascii?Q?fHtKBL2Dk/KjfxMaSRDwEqL8g9WLy2bGy5fUz84S8D375MVL8Z4mWM/3sG8N?=
 =?us-ascii?Q?m2Yt4dVHScnUhmmSnl3n1klXXRb+A8W9gzqXx0nsylD2BgKxnG/Aua6Otr21?=
 =?us-ascii?Q?bAZvq9s0gM5TOnTxrMycAMtHn7LUw7dpmKHKKwfyQURCVcgB1AoTVdi2nGlR?=
 =?us-ascii?Q?uBS4O23XBw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b21d3e6-f619-498d-2764-08de84b79add
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:44.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvz9uayf55W9vbkQWGRhfqFXeyJuJDOP1KHo8Lg3Q8oXrHOKEneqTADOMxT/3Dd9zYp9IcJTE60dk9GTB/5wUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

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
index 4dc2c410cf61..9438862b9927 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -302,6 +302,17 @@ pcie: pcie@1ffc000 {
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

