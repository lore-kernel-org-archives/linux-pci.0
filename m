Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86B3EE1D5;
	Thu,  2 Apr 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123472; cv=fail; b=uF6hA+ZC7zP7HMCMrTRGN63+Wr07FHnDjSy94d2tKO2o4D+PxOtisKlzRLP5u0LLJERk5SU4bkru6KmizCpa7mICHiRZbjYw/QUKgnDAozGa3Ym3pY0wjKG9UmJ1z7Fy2fUNP5J5EhWPJHw1oLvw031VucPTawPi2C3J8jmeWFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123472; c=relaxed/simple;
	bh=xzPgWC3CfkAwVk6V3+XedDsGclq2F+T1PYkPZp8gzu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXKGwhVhVmQGbMK8Qcb1Wt79krjvy8If/qNUKG3c29nwcUZH+CoM+7A5TWdH0a0NVcFdAKrZ0XbN8KFcgDR77IGSVsV3/Xknw18XT2NIgsLIGlMAJ582a0HwwM4IMqyheI1pNFhueC5iz9WHbaZVZO2PZgrOp+dAXqqmFmdIBO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ki1CFp6X; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ki1CFp6X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZJBiDJ94+RyP57rtgDQeOQdhYaJ8+3XE+k2U9LgUhDkIzbil03+h5QfsuHEelDElB38I5X+0mHUXTia+UWDaNNONQFDoBRjQkENai7OiwNS47k1H/eawmiHZxyu009zCYrN+Dvy5wyOlH+4sYc7zkDtGGZVKrRDj/jODgc89adD/Kq877bw94frrD81JArGOcMSFt3viDVrvQlGjT69IaOEUhqynAXVpSc/qF/Myq+JnEsS25f6RWUcU5UFlpcG6OYaH/tdEKfpXP4X+Nv8VBSkulJV1KtS/HD3qRWMTqJkVb7oLu7aTxv1wEqSQD4GfrFfoJJXwhmhybOJRd6I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=mNtpQ7276360ftui1uMIWEL9PqcL05BpMnkcNzI3TQLazCHbXTJjVt8d3hkNfUkxzeyWOGqknnUUPG2Ox6IACK2P6rKzShBttSR35ockZpi4yG4ZhowRRK17lv2/jO5wmV8RBhhvaACCG8tDYZC3nkJsgb3/fZIgih5XfaI51BNg89PSnwXb+RLZVhK8w0yGGtKuaDyNQGIxVyCuJ098tYQXZfd7tASlTLepQmGUHKSmv9EA5eYVN4OahaAtSVf04pE7+eTuFX+mF/8/3Zc8xBqiqjHPEzJJirgs29U7exFhLIgigesyDLSuPehKDSxW0oG8x1E6xMsySuJQmZgp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=ki1CFp6XPeNYLN7MC1thsnHG1Ioj4S3itjWsZk/AV9ApURF6SLqBtYWEE2OlC5VqBprIT58j2G7xDhLrfH34AOKrjt1VE55xoDJGc3b0sp+dSTAAjQKw+BbwDbK4EOVGjhk6rJLGTXvnnIz7Qzji+hRVS0l3ed8nqzCjp0AVhPGUF569vKLDNYYBJy3ziRsJ4zMVVbKUvdSdpSrMux4g+yDm2zP7kigaf9kHGOnmGP9FYYkcR3E9GCI8NQLWEmtu2epBSjGruOGk0Gpfmtpz1axDkVpLg8LbxTIz9oSXlbrD0qzkjSpo1LGwL/Pc3spQJ/KeBOVy3ZDmGYRAsLMwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9865.eurprd04.prod.outlook.com
 (2603:10a6:10:4f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:51:04 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:51:04 +0000
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
Subject: [PATCH V10 10/13] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:04 +0800
Message-Id: <20260402095107.205439-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ce65c6-6a01-4efe-0534-08de909d5ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RlmBua4C8sDNhZjQb+4SRNqmiWwcYDQQwS/Z2p3C3DSWFobrGY5oYDfxdx2LAyzIOJhxB35e1cj8vFvizqzzeZaFsK5y/iLwl5VFv20isXGABWMnGzW3Cg098a80AQ9iX8Uk2m2gRoQCUY6UojBtSbF1pMs62Wee/L6oyx4eWMs/5AulRyzcbz7+68mWeGOAnwGsbLK8S3hc4nMk1XQfbhKlimGiTfT5JLw+Ab22mNLaI4lMFQqTuU7ajZoC6P9e8TGRyJozdYvxH3pNJoFksqteealClYm1pd3fxQM4KR4XbQUiooStnfafQa2CjaUinkEuyRUg63XDrsVZO2bHqPGO6nkyg/Qy24TfqJcKZhnkU6i9Oy8rrD/2s4b42KGRX4lCYI+g0LxVxZcMw3BxGuL2EmhPPpB/tE3rjkIhhpLyC3hXW3TzOVq6sKkFlTldW86zujWT80FZnQWCJ7otwOt8CIuP21QjzvU1jXJuLyfPJfUtC4PIc9egAiV8Z51QtU8ATKwF4PF3aQLCi2eDVTIFVClKQgQTIfngxNwgg83fAz7L4eXjpBeOuX/5DD5dz9DP6wEn9yvh9iTytxhYpP9OVQGGd6W9Gfg/yIljhx3nt0c/Z6um9/x5QobwqKJn8+F1BaTUI505ojX3qUGm+o4HLnbQDUGJYfdn8KKSjqe0uZ34EvfPj9eFZUlUnDIlKCYhcBaTq683pW5bJa60LTZhj1kQFAePWzDLmLeoRZM6dNMD2rrDe4YoLWMRLwnVjYlJKSDcjmK9/K2wgkBnNK4x5ZGzWfUUJU3pHK8fAI9mjSGInhc5G1nAvTBgHqm3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwkRKiwn6NzpV2alMWPrBQcH7cgC8Tex9GySmLuhxukwD2bz3d99/L82U7lH?=
 =?us-ascii?Q?lklrMs7hbwBxF+q5ilIeMESNr5V0dKxGlQfTb0jh5FSf+BlRTb0qEFYvsdmp?=
 =?us-ascii?Q?cdNInZtvJ8SurfSarmHHrT3JLH1yh4SKguql2Gc/l5PNJ5ebEZZU0LCi0Ke1?=
 =?us-ascii?Q?1JhqsxVXPXaRrhyyxoXe+7BQS+xEbaoXqGEwxFlEMR/pGgnZXxeqi241BqbV?=
 =?us-ascii?Q?QYpjKiyPC52ZHJ9BOd0g2c8MRWTpvVuX5eDdwNsc79SFz7voWRIfUNsCJWh0?=
 =?us-ascii?Q?PVoveBFN7P6pInR2iUD6wFXHLHKjcssgIxvbUiio6IxHqjBvzwQYbQw7l+1T?=
 =?us-ascii?Q?MRL45AJ+SDEci+73xNRdDZmxJEkaK6PyoaKJZ1bfF7Gr/NVa+qwFvh+3Ensm?=
 =?us-ascii?Q?Sf0NRlZCYGXYgAuVIB30FtpkDeQshQhoWSU/dAVC7LJt0VCHTaJKBswq097Z?=
 =?us-ascii?Q?o/QdgCCSSJORjlc4OcafH6SI7p8txK93A+IDP41giKvMLlNQHsmsifNkV7jL?=
 =?us-ascii?Q?SUj54ccKQaFM0jBs0VLQGKP1K452f8V6vLUhFbqzd0po/Thjde2mdTR9Qk19?=
 =?us-ascii?Q?QvCsYzJMTn7iQhAyW2n5uv9+NVT1ZQw5ewqrIbrDXJqe3qsGjOh3JLOpRQoU?=
 =?us-ascii?Q?uuj4M9URDU/b0oiysWE3wiObwgNNo+QwROiuLvBIcAxJ6u5NxJo2ACkjFsDe?=
 =?us-ascii?Q?lsE4EPsF0ficor2JUSmPry22Z8GuX6JfLVzv6svKxFHMDbO8q3F2sBOuLmTe?=
 =?us-ascii?Q?lLUqW+uxJcEE0KaXLlTYe5W8IXL1FMNtWKh1V8tx88wa7Tkp8AuqHMH0eoMZ?=
 =?us-ascii?Q?G2wHkop1Fd/6KLrtTOPstNBSYkEGjRY7Pg+xGulNC3IwP3mOQ/hJNZnKv6Vn?=
 =?us-ascii?Q?MSncVLX15Ek0IQ43q0xuIZ2cGW3PRH2zbpglk6ztZqNJvnoLyY+rYyRXJFVB?=
 =?us-ascii?Q?nkdfouH1hCQ0iajPxhQwPL7jsyJ3lOyYyq1sMra3Z0Zf9oVIupsqeLqC7OQ2?=
 =?us-ascii?Q?dL07Whx043i4M0q9RQpaRAZbufhetMIhEeNQeQC7C1fn/Ugg+Zwgq7aOTNUU?=
 =?us-ascii?Q?g70SZIanjFOCoa+SuyQ6LzU7AbOBtt7HRQB4HqD4kz6PlOf41/ZZGoOLK7Uc?=
 =?us-ascii?Q?6Ii6IZReSX8+eypC17sIBB7atv6JczicAwsVU3j7lVoJ5e6Oe9GitVRWCXC9?=
 =?us-ascii?Q?7dADHOLRyvEWA8Y0Faikn0q9R8ct3yHaMKk+BaaRaOmHdTFwxdGUht9bs4d1?=
 =?us-ascii?Q?LB9TsA72dq+vq3K1ulZFw9cJv8OTwLKYRXRToSvafW1Xv698S4NUfvwye3t2?=
 =?us-ascii?Q?gdeT9R1P22Wd1UWIRgB7f3sefRRQAV6qRd4jAjCDsBYDpPSNCl4ZPWzUVN2d?=
 =?us-ascii?Q?G7m8M8SmlyH1ye/a9GLfGRWYfARn6mmufRPh/3LpbSvXFg2nHfvSSzgq+DDI?=
 =?us-ascii?Q?xcZotlrbVqhvOA/uqSxuPexRUBWLnbeBuY9c/RNJju4QIi8mXuULitqw4WDO?=
 =?us-ascii?Q?vUNB3hRRDCoxtQgyxOl1DGK465e42kBNNJHAM0L/uVML0OE3BBGDHti9Y/UH?=
 =?us-ascii?Q?kUXEWJx/pnBbFApZTqJoHlWMUbydyrelxENbLbvs/2NFAO9C7522C/vov0bo?=
 =?us-ascii?Q?OvLSVrwPX9BEgFGMLQQwjK46Y3DNSg/+K4QUsmRqkvI9SJ2SRmtX9CBizX8U?=
 =?us-ascii?Q?ljJu2QGwcVKHlGv+AB5lEfAxRdY4lJMb31YDDBNL+IdpmTgQGzXJX0gwasDU?=
 =?us-ascii?Q?uWrQkpPS/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ce65c6-6a01-4efe-0534-08de909d5ab7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:51:04.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuEw4QsMKPgjeumTMRodfeWqw7YQNzQFQTF3vFEcrI6YCJ6NxLiydHPjDV0Zvb/C53ryQn4BSzYqtrQLXCidMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

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

