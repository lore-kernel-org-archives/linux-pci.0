Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106637F8D3;
	Fri, 23 Jan 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134639; cv=fail; b=KykYIzpifGYTA6ho625J7wd8YLXQvUeI40kAmTrIm2Vk6SQDN/P2e8kxd+3ShGvrB3lvSUgG9HWivIwtFZHlU7rcrj4i08LKRC+irUt3vClwpcvcnnDoD8UfcGWzF/8YYYaIfOTNQJMIneY3Xyfy/DFeTOP4fuj+cNXGNvAztEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134639; c=relaxed/simple;
	bh=iGJJyXhovlq3j+xdD81xg56XCvV4Tcq+Ew7sYcauJJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rozeJa5yPswxeFFsXeOooSOiTiRE/1t0OnCDsNFXjC7MMXcYmVo9VSIPbEsuW2GuJizBK2T6T8BH7+r0KM16Gkc9KVnpVBHwPaaxrXZ0HpkHt3M3lSbMud5G5xLvVI0eq9vPqHH7J0dnu+Jvxofr44Zh0DwfnrbkipZEqAj8V6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GwqkBr7z; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GwqkBr7z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuserkQBQ2NjvEVDS+L1S0fz5AVFXtIolJsiKFqiHlPBHp3zQy3Dhs0apso8jLDLR14mTVQwBismvmPLnnfGA1MVeB+4rLnotvoFJ4YZs96RS83DTVKvrA/mr9Bzh4r9sF02DuNjrFnHqpXxQD3AXTWPrxoBuM3eiEeGfql9zMlKjNKlQjTwrIMJR4Sn3FejuEetup8Nbf5FuoP2S1+Jy32TUA3ogh1guxnRe3Rv4YgIglzrH9n5wDa+Wp8NMooLn6Ll1F65uhrUJHjUsascI6x2m3pACHQvgt9WdVnejMVi2rI9IVnqGlkdP0SMpesKtEdK38NWmmfUHq4wpsYMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkenT3LhfDIBCAPJRkwElwxYCz/hdaK4NATOlRlu974=;
 b=I2vfIG4mx94iH+noyvbb3MviSjxtNTL+lPjdA+lUK52N3eTra3n9mr/paBfVbet+i35FMl/wXCfnB7r03Y1u71vfOZcgNgqjoo77scFUmo7ms/x3wuthaeU2SHc9yrkwuh7ykF2Soo4svwuJwCeCvCyd6MRbv3jEr2mtPRyazejABUbyrEKMP5+0fW7lHrDegVhOvYNx8XfrE9/SyUzQ8vep8o6+kovAHLuDspLjwjLCTZ54JXT3kpZeEXQQYYRqWUSPMa/SkE3f/K6vlf/zr+jxmm6ejhh89bHafxl77qZqK1aZyy4l9rGQcZoATpmqqJobLLea80DCEGDrgm4n7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkenT3LhfDIBCAPJRkwElwxYCz/hdaK4NATOlRlu974=;
 b=GwqkBr7zqDmokCl7k8vLrzt7iAXxFka5Se7e2ux6MWUNHjaOI+T8G6ojyEYs/gIHIUY6olJR0mnq9vs4urdxYzbJxtVZaJ4zEelnn41JOoKMZf4QKqXE7VyFOqFr5jXfPRG16/kNM+lr+/IV5XQezt+SBtR96V51PqBEScUT8edaVMTx5UzXWOGE0jmyAnk8AhuMjoHL5QXWz9GGmiuhOW0sDDffplZ5SDGbG+U+18B3EsbXIj7MYCZkwViTfzGOykdG3k7jo5hmjHHVDReT+ETJD8nfXL0cysNic5SPugbMFUlFqULNcvKNYOv/V1T1vIX4sV7UjpLfYzl/M892Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI2PR04MB10716.eurprd04.prod.outlook.com
 (2603:10a6:800:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:16:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:16:00 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/10] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:42 +0800
Message-Id: <20260123021445.3782170-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a03e09f-cc79-4f5c-c187-08de5a2559f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1HcLFjUcfECwfIjQpJGn7rRzf9CcQWZMtQC1dF3jSR1h8bWREIWqAaYkCem?=
 =?us-ascii?Q?z0TgHYg9XzF10lc1vJj0fNtz66aM1syO5kk4Oj58j5ETVHyFTc3JTULSi72o?=
 =?us-ascii?Q?UgNLPCqv3+qEQ/Ib3j2fQyXyLtFpRwPbOUG4nQ/bJ9f+PsmGSNnO+z3SaPyt?=
 =?us-ascii?Q?3yV0SQP4VQT8iMCd2zsZgNc6mfXt/lfubBP3mbciRGaQo3epuJg3crxpJ2EJ?=
 =?us-ascii?Q?PC5z4z1B0jyeF6EkwloGxGynn3IpGadOTVIu2FET/UztbKXHL2G8lwhgxQG3?=
 =?us-ascii?Q?09kVm85zzaQiE1ppJh6xn5EZEPSde6M1ZWftII0JgF/ZNGQZo1L4PDTxeAou?=
 =?us-ascii?Q?Pt6c1urO3EL5hgV1eDffNHp8zDefAiSd6KjuqDQgZIqZwqRK9JOv6qXUrtPQ?=
 =?us-ascii?Q?vy7wis2IpC6nQsQ/n54suiAxRP+zuRJLE6hiJzySN9oI7vVh75ca93+g5kWt?=
 =?us-ascii?Q?agHVm7cAJepu2m3qVegPKOHtpw1n06xIVk23g9+Vs8MSe2CkvGs//zHN24oy?=
 =?us-ascii?Q?0gTtXfl7WDdYUzCiioX9u6IE6Bxn41DDIXMcq97nhzL7/RSnJrkqgYcRSRne?=
 =?us-ascii?Q?yJH2WWLGcYSIM7D7pWkwMaCfJHJfFEcPYlDE5T5ha8hOyRagqM45d5kjunvp?=
 =?us-ascii?Q?qWoYn2q8tISVTuUg2NAHVonsnQ336sH1IE6RiEyGMqlfpmeCvvt7yGmyP3R2?=
 =?us-ascii?Q?nXEUCls7se0FEWzDL8hghGfVEV6tURm3s+0YOaZdC94eE1HT4svlmlol5X5W?=
 =?us-ascii?Q?4rng5OZS0q3ZEpsG1xx/RQoXLEKGBifWKCxTqP3krCCTjFNsdib3no050m3X?=
 =?us-ascii?Q?9DmBPz9aWQhkUGzczzzHv336iGdfa45ffYYLUbsmafzeXgVGekQw02INQssJ?=
 =?us-ascii?Q?qTgB8kZ+CH2GmQ9KAifIKieR10KB65AvbXvZZQDmZXW9iaZb1J5U9y1NmXTD?=
 =?us-ascii?Q?HcR9KCWRDczBJBab7iGeuoKaZOdVbQCG9aPxAAnq0szHLtK8uJccB5ex8RkD?=
 =?us-ascii?Q?W9kPlrLSsAjPV3UkawWFUHA9mjNH+XmMTeDZLnvZGBssb9xVBt5Vt3LzpCTT?=
 =?us-ascii?Q?maCY8ijKD24IupYAwa2sODOqcF3qi2qmuLN0GIVIJ892jQ+ISkQiHrL8gVxD?=
 =?us-ascii?Q?BuLv7Yl2FPqFbjonefDB3A5T0nVJmtdx7teCNmaEnqOVVuTc7+JwqfuF0HWt?=
 =?us-ascii?Q?MgDDq563d2ZjLT3eo89LuBxliLW7QmaVC0YBsRLsu9DYb5LV4UgG3P/YqFIe?=
 =?us-ascii?Q?P6B4kXAsZ1HAksmTLo1AZwx3iGp21wc96P6oQA2rIOQqgLHCnnjF2/TGDUPr?=
 =?us-ascii?Q?HeHAREnypGaz46zEL6xAZ+LgKISat42OBPyp2KOe7pKFNFnNJTnheJSvAv20?=
 =?us-ascii?Q?pqcUdVFigqwBKTZIq2tPYqKJZd8mebFompR8lcgcDIkMfln6nBBCSKZ4REFl?=
 =?us-ascii?Q?6QU+vJG+smVH64kfVfxXeyiRafCY3UUwfQ7M4cOuEkSKvO1Tl+JzmdJd7bgj?=
 =?us-ascii?Q?XLvSWul0ZV+MlvApU06to40NZFZLkAwtPPvZdg96LiWg1V6ehTe9TdySFo9A?=
 =?us-ascii?Q?rsOSOm6X1qUjbG0QaVVn76PEk1VqkLLmhtwk0dtsxlEdMURxD/kYfxpP5BBD?=
 =?us-ascii?Q?W19MF13NvwMENJcxiJXNE9P3L+39t4hN3KnKeHMIwfLv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqJKecGwXvJZiW7ElzBxenQNBvtjSyQJFFdsBEJyEi+z2nZu6+2Ivr+FK0PB?=
 =?us-ascii?Q?VE5FwbubpSuijXZ7ljUlAQzN7gM/4pAQEdaMAFrkUtidg62NjcM85XkrXR+s?=
 =?us-ascii?Q?OGG+UEKedLavgPCXorFffb/xbCp/DdWCwx2StqbmlmK9/p4N4R1Zh5EQ9le1?=
 =?us-ascii?Q?auQ4uWPLuKB5AVfo/LNAIUFYzSfGTuzFJpyOjYKgLfjf9+MEFVnerJFcc3Ut?=
 =?us-ascii?Q?TyIxWunNwQhYZDNO3Nz46mHhvuGsu1JvJ4FaPM0ggRHElp2tsnI3KCjr4U8R?=
 =?us-ascii?Q?jl10lgAwitFGrRVZ4aETcf0Znp7FZFVmlM36XqI1LgegstUe0LP3dEbet8Qb?=
 =?us-ascii?Q?17uh9CgE057cdziUhDbd4oxRjPN1mbQWx7IGBKOpyFwd6IQXh6LOG68wZKjM?=
 =?us-ascii?Q?2R5UCCvSwPVYCnMm0Ztcnv3fFYSuioDET4MCHw7E1RWtLw+3pyM8p5LcMj7k?=
 =?us-ascii?Q?s1j2bweSxNeN7EMLW4oo/6vEz5uaJNVt/fkSbl0RJNcedjK++4TcvsVDnvlA?=
 =?us-ascii?Q?cok2L/jCroCKYtIcWngCVi4g3/sPGjbIeICwq1vNtUvXyKjjOnxuGKKrHM7b?=
 =?us-ascii?Q?Szgdx3RZN5LNO+6sZqz3oPC7t8zD+Xo7dTs8ukPjBNfYmbYjyHhXCZZVgZmN?=
 =?us-ascii?Q?GqfNtFNcICxZGzCOnx/Re5lls3biH3qCTptmSOpWQ7xrKm0L5MGUTVGYwNJO?=
 =?us-ascii?Q?psZNUK2a+p9yFCirtYZgn2PHIvBUxr6VcVVH9CDOybvYOp7C/i3fJ/09eL/x?=
 =?us-ascii?Q?sU/dbBQdIbXpjpq0EBy96pJrss1ucO4CaBHyG4iYLkwLRIMDd2RYKVuVaOpD?=
 =?us-ascii?Q?Bq1ekJ4i+570MWioG4/9ujcn7TOwZsKasVSIXx/MwAyVMBENlbkvC0LhDOel?=
 =?us-ascii?Q?xDT/egnXdbgUk5lm4xydOrB0ZxSXRjQrvz3v6EZdhh1ONlDngQtNhKQJUIKc?=
 =?us-ascii?Q?K3L8jo6JsSVXGWJ6kJisw/07ULEqVl/qHnkh43/CIdQXwv0RtbQ2WBIVhFtH?=
 =?us-ascii?Q?4Jj+OlvixuzLofMwYetEgwg54RMWnbQwMcOkOvCTsnrazKpT5rvvXdcXOwlM?=
 =?us-ascii?Q?5uBp2npAlnVIoMFVInv7CYxmHTDFzXbXyczNFEtbxMhab6pGVF09I2Uyi17M?=
 =?us-ascii?Q?CLmAs1Z6RQQRzVu17TYDMNWB5zAdH1nvklBaZIjlNcnmynXeMNs0jnkloUUm?=
 =?us-ascii?Q?SvxH5dy7Ys/CaKm8RjbkiugvdybvVk0YjAd0vJEbDpuaozSiTpKOqXPPEBS7?=
 =?us-ascii?Q?kywHhhRtuBDiRPB18SCzBubIeoCVHbJp5oztJn9rqEQADAmes+F0n2DdykFB?=
 =?us-ascii?Q?uQ9mLJY+AEe5Rpv53cW18q0+wCP72JGtJE1AeNhhtND+3M9yeOwsNDWrhSzo?=
 =?us-ascii?Q?7zaw5BZbud0Y/L+IGMMMML9CHUR1C6JKklWlqLBr/xqminXCl4l5m+0JIWJj?=
 =?us-ascii?Q?VEsyojRscCGaxqNcRVcW2e+uHCGUEz5JTrTGmmoP0xmT01Ft9dZDXE4pYzkM?=
 =?us-ascii?Q?r9zfmOFSBPUcgrJWnD0+UV6BbZ6K+BDClnrPKNTcw/LybI/ZIt5mx/1vT6Op?=
 =?us-ascii?Q?/cqK2NbBwSOSvy5eL3G3WeXYvE+Eu8zVYn+E2f/T3KPMvwSNEXdDlRb4y1o3?=
 =?us-ascii?Q?pakGe/caK61cFialeLh7HqHve+1Z/EuA2t1JNkMRp1YxRUWBsps8LqQBwSwa?=
 =?us-ascii?Q?FxFfOmsFsvMOirOJ75htAvZBOERCSScMxTIxB4fqJI2FXwEv0lO4otQVQJv7?=
 =?us-ascii?Q?ACpqRbC2PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a03e09f-cc79-4f5c-c187-08de5a2559f5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:16:00.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdxiXGo2X/jPuKnPBV9s9KgdEawPknc1SdBHymbowHulPT0JlErxzSP6NzeVMBfNM/V6SbWsne/tXJrdhhHFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

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
index b256be710ea1..3f9b3fab8ac3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -762,6 +762,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -775,6 +776,10 @@ &pcie0_ep {
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
index 9b2b3a9bf9e8..f66667735a02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2266,6 +2266,17 @@ pcie0: pcie: pcie@33800000 {
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

