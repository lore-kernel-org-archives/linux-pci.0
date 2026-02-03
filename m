Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3E2ED858;
	Tue,  3 Feb 2026 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083740; cv=fail; b=dch3EujuNEnG/SEUXU//TICcbRJW2en7HscOf7emYjjKZHe0QE/4P5UTewu6Fq4c3LzKBnRkLKhovifNjtf4qCVFxn+SrftbmF3AG9aqbIMDqq7X4UqUO2eijsSnClo0LH3atr+dHsKPXdfYDFyGB0yxRcV1GDw4LGEnM8TuapE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083740; c=relaxed/simple;
	bh=bsCqGmkv2u1Exe8rVk/RPtpssCoCE9tOWWvSplVk7Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEGmxrNSR01xlK9et8FPGJJVcC+p8oQhY2eD8enBDG/8o72W49+PNlylakbRLO9w7Hkx/YEvVaq4WLsvnSKQe0gF4aDWz4eqS9bB0P+K1JFUQsCmADGJI8T+cf6AUDdQWSjxSILnFHmNvCI6TJOL3QhhzYFUmru86BinhYH/H0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=axpzYoVI; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="axpzYoVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIrvzwYg0ponClcVo5BvLLNer0XnFZTiZehQgCJeX3ZZROHeN/ftX7MWfv5NPRw9H/pocmA0qKJHmI9lCwNmj04sbUbdrwxCzmu5XLTPpKH1SdURsrB6Zyf7AGmCHS4aOUjF9FJ1zZQPqEn3P3O+UNZjN1P5g5Hk3QUatVs5jJadp1mvLFtFCPsBpvCXLf/WHEY5ATZbRt8X0escB4gSM+nnsACnNiQHxHAJ3ORItPNR6yEGi4Ftf2UTw/JEiC+1DGYG//WUVgNQ3IF3QVqfXYMy36o03sO6/JvlT9CSzP5xIVcw7lifXmvYRwZGfbGHosZD56H04LPGKMCMZ36wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=WhqBBNC9F+lrc1K5LBFBuf92+9wgAQBGHw4MYTB6pwyrbHvk2oUaZlT6vNMm8ZeFvKIlyjBrKtWkdf95ELQVj4+8GZjq6S+HiJEk3Kf957tUULPgJ0iRmEaHdmNV8ngDhinUxX2+uNKMDlUqZW/ctie0RmQAvGMeywDJhdJv7kvE52wRhf/H/8f1qdmOJRZSsbzZhbYPbwJEGp0PCEnSdYwOPKkpZiXTefllsS4s7DfbrQDi4Sq1ztuIUJ+DXV7dr7gLN8VS5WHtL5wHfHlJotjKxzuFjVfo1z1S4HcEm02CIRWBhuhSWYPr8oxZv7ZkByBL4vimqDQ436G1ikwZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=axpzYoVIoshQjNjBoT7nTlWjwMdHVQDQxCkg9oYm+yu4Pb1JkWAVy1YCfreIW5aDkJ3f6waz34BiZXcQ20B/RM6EdKsRPx2H4htseGj72N4BT2LfkwoQUq+sQy3GlpY+0rzv0DX71bSuAxOp8ECApvFJH3OkV/+GRaoh205SY/hNIRv3CPPXzdTPujREBmmsarfpIYotRiu4E6V6ybLLzQIuXKy50Jzh1GAA7F3jBA8fWAi+ygFfFor3ufZnk6WxzSyLtn6lNrCBizNKSvNxW/apeXafTgNvSt2UoYcfsfxaLSyIqoceZjV4QlFP/IHyE+b9jjen0+WkKHeQj3LX2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:35 +0000
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
Subject: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:07 +0800
Message-Id: <20260203015614.2957479-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a632f65-8b38-4369-a922-08de62c75260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXmWHUjlr3euGFzi/9XFobU96BwvIRI1sd7hYYJkfXPcjrHuIuRDdXnAOgtx?=
 =?us-ascii?Q?L4b1wMfhqHnpFKLtvGGAR44kdvUWgK0K3s8yzR3SH0NYHDP8PRiY+HpdDvZk?=
 =?us-ascii?Q?c0Qj2SkB05CReSJIfEwga18KGDfmt13duk4paM85whwiUnLZj1CEkFEtUZRV?=
 =?us-ascii?Q?5O2kZP8OMEipfCYKWKs7gzAG6+9O6zECr9dJzjDMFqECuKoPGxeruLVyZiCL?=
 =?us-ascii?Q?aAgiP7TvrMnUtNF62ax22cUujsVgWT6YoKfGioSzOD4Nsv9sygZkKG6dptiK?=
 =?us-ascii?Q?PRg2CYG3gi4Yb8YHGyi60lpfvRFqTEm9bInbJAhY7rmq/0+I74Dvb0k+pa15?=
 =?us-ascii?Q?IE7TWEbMwDytIlietQg01AAU3zlorsj0FDPhaIdyu0SVVqMVtwhlSRNLM8yK?=
 =?us-ascii?Q?XlMuLYEHnhyCOWiTb0icvd8bSprb7tSxQR41QZVyv5PCqoAVxo0eSwGAkaO3?=
 =?us-ascii?Q?AIk7J5SRjfEYUXSbPzcNfDNOtaHWqxtz3Kp1jz/HJbCEXldr+bktcra+GanK?=
 =?us-ascii?Q?Zi2gwsTvAi8jCiVlRdX4XT+3MInSE4A2Yh9xKdQ23F8WnTcck0pqQwvCCNB8?=
 =?us-ascii?Q?gRcwAE7DKeZ5M6ULyOdZlVf2nZD+t6GrDQdUMUPUE8JgawFJFp4ks8Q9zEYg?=
 =?us-ascii?Q?6srhoL+L+YSzQ+qiWjEw8k9mXxSEX0Z6x1/v9ErpTsocm3gUdJVou8JLvZFc?=
 =?us-ascii?Q?h6vmmaT2rDS48V5SVsfNrRdVIEWf9G7qkzzI0CskVqObcKBcsiBGKiyUiNcQ?=
 =?us-ascii?Q?HHfW0SsBCJeX6Udk57avdkDQ5b+0BugP+6ZYrx6u5xAjXQwS420NOFXdJEee?=
 =?us-ascii?Q?BpL2Q5d/HWpIZZnU2S7gx1vjx7Km32mMKBsrtRbzVTiu1epRuoubO6NSEriL?=
 =?us-ascii?Q?mWph6yM1L19S9AyfqKdJ2OINnt1Ajb2Lt2vMCqz9e0Bvu8wca9VTeNwY7s5i?=
 =?us-ascii?Q?0cACocPvzNjQhehjY0Rrg9RIvkN03jQ/aSEvpYDro/qsJiZ6DxpKXx5z5nGP?=
 =?us-ascii?Q?Uwa3Ad/JF+b4GKhZk0EaEPEuKCUIUVyH2CvTfrw9KmolLkAJN0wTLR9FD7/d?=
 =?us-ascii?Q?CrynE6JZQMWPakh+PDCNYqTSjpZpM9rHcudDbu5LpuKXETrO7fo1oxlNs+SQ?=
 =?us-ascii?Q?0nJih+Vz/2xg0e2T0l2AEbOh0DRkLvr+B62QGo/4OeVnkyGQT9bWm8C2IV9D?=
 =?us-ascii?Q?U4ToVPwE3uCZoosHeQ+gibpDI4IG/7oWtkWlEVFtHLVFTQ4EnvltjOKgldBz?=
 =?us-ascii?Q?KwHGbVyRR8S4pOS2DbtT3cMx8jCCnNPzByaUdQrhJbJ06vELK7tEDcQJrRBn?=
 =?us-ascii?Q?DXgA82USkUupdlWtfbm9DSZWzn1wuqm+W+P+cAlEKkQogRdGPwpJjgGz57li?=
 =?us-ascii?Q?uISearhGf1KugG+YSjWtRaGRH9D9QXcDhQ7X6rMm+sOydVAq70edAlAut0M1?=
 =?us-ascii?Q?MCt0KSVLwwzX/7+eBtmBXadRN6W0tPaPcL7Y1hqkXf7uY7XBOMjfCorLWJ93?=
 =?us-ascii?Q?eKu3T2D48Yre7BWsI6vqJDjvBSe6uS7GrY0pqfZmkyyfD7V6I1fmkSe6i9oR?=
 =?us-ascii?Q?xAJJ92ONbjKY15bNAgPpHRynsqWOJB7664CnELJQIFOCCBg3qBu6EVTek8Dl?=
 =?us-ascii?Q?8PH2043y3M/MPxxex+QMkUVvxQH0jjl1Wi23L8kfnzld?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15NNlHhvHUoPCFEyVgY5OcdkBWgdFmwYGfcSCmE0BHws7XjvAhanMlG90loI?=
 =?us-ascii?Q?Sogh+SegHBx6wVwmNfI2LwsgIWmotCqYXpvBfxFbm7hBrdH/EVfkjEktXiNE?=
 =?us-ascii?Q?wH+3lPYDr6zu6/dWloTsFpdQAvVTCkbVl0pBccpmH3bIBVNBAh+kShYB4NZv?=
 =?us-ascii?Q?2DypeHSEadtJOktw109J+hREwxFkBedU1xGccstLCB9bv4XIlINtEHw7iS6X?=
 =?us-ascii?Q?1p7VKts+tq8d42a34VxwRa7g86ryxZUg4AvZaJTcewpY/6GSVa9IYskHqd4S?=
 =?us-ascii?Q?KY6Dyq9CRcgW7QqvBQu9s4RkZFFX7XaWRIaUWEhwqTNpjjjSfSAWTWAr9LUY?=
 =?us-ascii?Q?op3C+hmFk/VVAzYx6j8dcJbkIm3LwjMk4r3sSugEmA6jbm7S9v+DLuBc7mIb?=
 =?us-ascii?Q?Jeo0TqZZoXBraz8yuBH2EZG941eB/k2ESP7WZ7Zeks4xlY7p+U5FaEAWR/ij?=
 =?us-ascii?Q?XGgLIPwzy9uLHwoApRB4Y3LkZVEXyUKrWyjiO91qnQFMl5QsjIIKvpZVFIGU?=
 =?us-ascii?Q?iekyAxWtmD8Zmef89SRUIQuKRUYWxZ6aBnJYT7j99zAhe7VcIO9RCSYSSmTg?=
 =?us-ascii?Q?VoCXFuVSbFFEZ1+F53/mwgu+bS9TosNwBOrsI9/wIhTKkAf+1SsiBUnt46SY?=
 =?us-ascii?Q?5UkamLBZQC/x4A9CLVe3qqcaccsqqbiTFDvWGsXfWiYrRUQ9jSps8cM0B+16?=
 =?us-ascii?Q?v9/Vo6lmNKHobkGJykaVrrivBm8jQpf05n1vXjjJsC800M5wASQKE6KxulsT?=
 =?us-ascii?Q?C6LVXeDpebsVevWDcdZ08oKZv1/nKkRFpquDvm92EPUndJ5+5tLeQDPNkBcz?=
 =?us-ascii?Q?DGNciU7E4L/6u1IMl15+LQuWrf4/cVlynDc0oLoTcf4qfUWKCjrRd9b27rPh?=
 =?us-ascii?Q?NyNarEjthXwE0RdGz3x6vnKPqwABmRfAfb80QgT6Fs26iKMwOE26k8I0dujr?=
 =?us-ascii?Q?p91TE6SCX81130NmmZJa7cVRSXybIw6DgZ7aPo8Lv2iT2x0bEJ2R4TGvTQqL?=
 =?us-ascii?Q?dSzUsURskef3CZ0pm0UtnrIqq9o7WN74pEbPNFv4mpld302l0pTr2QUPTFnI?=
 =?us-ascii?Q?/CaCGsorqvhlgrKbhx0Ao1HUjZhfnlO9yNQv55RREDv8rRETKSBP+MOVgZ04?=
 =?us-ascii?Q?MMINDFhlizpgkmEidHCDeufrMkTYxOFxJEjhgjiYZ3bP/vdUiSUcSi7/h64A?=
 =?us-ascii?Q?ZFZL2m0soCs14DvcOHjyoO7R9kLtsyoXaxyRgRnpTL8i4R27/G4z0x96w9QF?=
 =?us-ascii?Q?ex3BqjphYiUXZQsaqPLjk6buNVLkMe2Q7raG/E5S4y96uSeUfPK5GLmOiYDS?=
 =?us-ascii?Q?F54/bb58wUPzNgWqx/lZmXQxThBiNc/+qRXUl1mlhv3qeEl3tZsBb4rsGOvi?=
 =?us-ascii?Q?5FtVA0LL8j4P0AjPL6aRT1OCAS7kbCmxk+VZHWB26eKbZfyJeJgw9J66ml1C?=
 =?us-ascii?Q?maSSBC7ZOJXge49SJtkE0kjAGlk+rQJeSkM4ae+XHKODGCon4PxmDXuO6zqt?=
 =?us-ascii?Q?GBedxEgsXEoAoZifDOAvT9HAMpss65lTErfHPJPSR+iZikhKv4wgMMJXlmmE?=
 =?us-ascii?Q?luKwq8ngRZoS/jEodMhF9viWu/LB00ySDy8zwRGhAf2XPEoX1GVHsVwDKMgg?=
 =?us-ascii?Q?OrU6I9DIk1qiLN7yi2fPA4f6/9EimwaQj+qPQFSJiN8NX/rnTUH5o5/N3I5l?=
 =?us-ascii?Q?oqt+c8oUMO/kPMxoELzxPQsqemrqCP+Ut7uht5iIy8zlHPuRu8BSeAgGlOgb?=
 =?us-ascii?Q?a9kosIo4iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a632f65-8b38-4369-a922-08de62c75260
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:35.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eywRf1ZbjPRvLEpYBVsdbZXjd0DdoPeA0OAgQctJfHSLHhsiVeu1ER34fkL8R/TKiqLu48bwKv6E5s7hdI7wPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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

