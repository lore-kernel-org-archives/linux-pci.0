Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1073E5561;
	Thu,  2 Apr 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123465; cv=fail; b=jL0yWk9ijcmbRFOp7Se5EPdlTUyDUsHrf17IeZzHhZKnIO4bY7y1zio6FbsAskAmiLFwlAnAWIZR40ANfiqr6AfvLvSxLOOc2ByL9LSX5Ikr6v+2p+8Dj/USRGP3bRFj+BndIspicy34rTPHM2jJjgn/8nuzqc4CeKadeQ+Wdj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123465; c=relaxed/simple;
	bh=p3VWd4Zk987X87jiTogJXJ5Nf/4FV/Sb9DSkzZu+rrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxBrutLsAX1c6jAlPAPEgMU7lxoDPIjDg5awrguUfqtMTZm2bcEVvjCW+hUVARppP+aVasGNE1VNq2WXL1pnpbzGrbBTb9ZXtTq1lAE5dC6p/cZpgeqVLKLRefors+EFqOXqMtBmccM9I8rESI4hyDJRfEETzU8zFDjtl4NPUiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=miYBKoyg; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="miYBKoyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa6LO3EKhRcbpjzog5Wq5RZDgOlzfh1mTgyYUcjydWSVm83lgzBaamjNXcN4JajeJrW+zSZTNoaDM8Ho+ovbxIshca8+Ol3nfTHRU9Cwf//Uh5iR5AKcD6TmEZXWkXHK0f4XRZzj5EAk3w2DOxvNPPaTaRLor2tbnMVcBfHHOJ2EuMieMIHAQw1rn8aT3LSJISLZ6ks723eACcvICq8/QaZ/KtlX18swOEjB0KkHIST8CtOJEe5Z36t64mrJLTRALuVtIt7r6xr9A+M60avjnqHcnsx8FH436bCMcXyv/dANq3lijnAUCPI5G1tGdW+hMHGbTPckzMtr+IfpNR7qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=PZGysV0i492SVRPEtp6i4uI3oEYnfe3E/1xror9H6clhJJQfp9oVl8Ny2bELTS4J1ycd8Ba1deoespqvR+nZDN56JGeVeiqdYH7R10lYi3NGcz0wf4cZwLVREd5YxsqDv3skR36qGvYzxI7oMFKeLsTPpwYJ19EvSRRaW6oFh7+XbKXdITBMPcs0cilMoJk0owB/qIC7cg1dtVTSND2AlTbDthsSOiDObSU3HTJR1MZKR/8u8qNYB1pNEsknoDtYMLCfdz+r3lTtiSIsZtRyojtxfgIDzWKNdu0jy9zaqc2fCGU14eT2zbkSkMAgwcC0WYOnOt8jKUIuNxb01hdPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=miYBKoygjPelqYVRRIkEIzouRPE7UxEGrf8gMImRphMh6TBacsp7qrILPSH2VLo0gcGhVtxFTd0UYkX9EX9TTdJMFRQuLapFuBqwTHPnXN6yJcM3++nhrcTFlLdXbghgcuiwydw9bOL8/+Lq72Xok+gvBUz/4pK268fAA9FcMGUSf0kRMD/MpsW+a+6Yr71kq1iDbzN4adc+ybOBQetFJNuk8NGVV5jVR3Pm8GtSV58IybZC1NlkJ65XBMquHytKtC5Q9gWTtPJh9Ol69P2x7rhGiOIF6KgDvQhp75gWW/kxVIWqUVx3TdcrIVgIEMSZjTJgb47sxHbimkePNyBhYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9865.eurprd04.prod.outlook.com
 (2603:10a6:10:4f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:50:58 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:57 +0000
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
Subject: [PATCH V10 09/13] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:03 +0800
Message-Id: <20260402095107.205439-10-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f026fdb-fc20-4b09-18e5-08de909d570c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OvGsWe4olJE1MSRHm6bDzSS8WLHeLD0Hu17TLq483ABKIQJMW9TohwgTCyaJvfKcr3xhJqjxKGquIGPSUWkCir7925rno7kkLGlXxddUfwUs4lsHv32xqxuqWdx7mi5P8TZ32LYVqfL2firCTqhJeElfXB1dYrFsGny3UgAIz61wyGW/L5PdsXUJv2Z0vGpKAQVcahyXosNozQylfH8mTH9sidnYBk/Cz1ejDz7BxqaSZm7BM8yjVvt3StqCnBEjIQv5T3CkOZtD5Shra1qQZB0wv9FWTW0ilaJXYXE29O4pVzm4Hfl0LD3daewZ4scM4Ytf9X4qqdD/lS/aYCWjtetj2g59kfoQROw9sBZMee1QWiMfLiceIe4pbGcRM0le80SM7BZiI2gnxRpZuQ08gHn+A9Z5hbW29ILiVs35yDFD1+Etamlg0OtV1NILf4OD5fZWG12N01S2mx10HAs1/vlhMCWyk5ND6Te1073nYNoA0yEcj4rlnLwqWE07sTysQBhb+Ut4sp2d4UF5e+3w15llVUpM9T6XeaTeKgufR6wGAyL1JYKAKin2wX8x5VflihtA9DAEjyvqCGqVrOCmm5ylWKN9BGcTyPvMY2akKas8rcAKEt5UiR3LD+SuKTBgXv1BibUGbT9cUs6Br1fXIwtTM0wIveoIKRzUBWgxx3uRBzw3TzP+EQ5awUoUA7on2uwquQA4iQNapktP/+n1AQ2/TnQ4nlOSiJHcaR7qKS3/QjwhruOu2OaADo10+H9nuI/mh7j0/0DBaWDTqjJBiCWMIVzyz0HNme5AMJsctnFzyq7VKoQazH/CTIJGUBKv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/LMepYUZbuWicVylhfCCJ2qS+V19mGL50F6M2yr0rn6Y1YuoVDyiScrJG7Gq?=
 =?us-ascii?Q?3PS9wBFUi+GfzZZGUGWnfP4hQsZguaoKPdo5L2X6iI2rSLOC5fEOsngE27i1?=
 =?us-ascii?Q?HuncbK9giteJ6WVYsle/fULxIitBnd7xDXTzEyvVCSNhszex2O3fI24j+pav?=
 =?us-ascii?Q?WWeviFvIN142RMzhF9n1KnHyh9MrKQIhi/r9rTNGyqcN9iw24PNpKFMQTzDO?=
 =?us-ascii?Q?ekCRlmARF888gJ6Ai5Zgy86E7NJxAY0I9fUuOZdyCVHaH+UmOopUOw/eJ9p6?=
 =?us-ascii?Q?zflaOruupJM1zDTp5YdUioUtjTvRMNWuGw/Hfe00a22Jz5by6IkPu0dxilgj?=
 =?us-ascii?Q?uOP+E8Z2dYzn2xO8z5aOgdYNqCXRFT8siTNgXdOuIbgDOggimavOXJNzYlfb?=
 =?us-ascii?Q?y+8eVghlXLdd2mqlnqj5iFkkDrLOpStdECmlVnOCbnHllAMP9KZFzka9vZ6L?=
 =?us-ascii?Q?Of30LTkJgb+lGBYgiSTwR1RJMIOpvnsc8pEtf6qeLFDY4dy+fA5y5KdIC6Hy?=
 =?us-ascii?Q?22tvgbLhdam7gwNAsqSawX//Uwk79x6akdSzH+RNfTfr3ckofRsbaI6VWAto?=
 =?us-ascii?Q?FB64k3yfIZAEDT0B+oJIayvyWM6lFj51WuSyfPrMlEYWihu6DTwaF8LabpqL?=
 =?us-ascii?Q?uGLFG3oraUSf6LRB3yfQusFPkjhYgBAc94wFyJOH4uhknHQMXQduJNV7WLPO?=
 =?us-ascii?Q?Z68w1Tlrgy6AsV9Lt4ylV+bTeKr00ulUA2ZUW+z2RX3QLnb1VIh10ocYCzK1?=
 =?us-ascii?Q?CK0KVcArw/OFJe88/K/gUiv8TBSzXmDF6tCYjeuvZeofrsLKnDJT3R+1CWOu?=
 =?us-ascii?Q?RCDOCYDe369t4Q95GgMQ0Cyr5DkY6pjogrip9iyFV1RX+iRRb+J6tcnZGW1M?=
 =?us-ascii?Q?7h3MhXjiiYorNOs4FlPb6/ma/Eg6mzt4XOjhpf4icuomctSwdvAvaOgTBZoI?=
 =?us-ascii?Q?VXR0xXBmImPEjAS8aR8JTtJaEYmH+Mbccoaev/HQv2ftIimS172BokZfaG6m?=
 =?us-ascii?Q?clI2sQi86qqtHza8XwXovgpb2O2vgU9knFi/asm2XZdVNB/3PNBuF09s4Fby?=
 =?us-ascii?Q?0HMgWFCEtQey38t2ZGgH55D2AdnbXrFu89O5iltrpwEqr44IbXEb1Yy5d04A?=
 =?us-ascii?Q?bGkFQ6HS2a2E5hwsI/lVeIndP+mfgmXhJDd0GTARWxCwgWs57tvOpO53jtEq?=
 =?us-ascii?Q?v5gQZ3HDI14CLC2BGot5aqQyS5cEYwvDw97fecqfgYW/JzBO6zILGVeXxUla?=
 =?us-ascii?Q?JR0CPS7/alC5RBVlGbzSSoydvlczuvDprD/gUxvZujSPbdkMY7xZd+gwztCO?=
 =?us-ascii?Q?A9hROl47vZ6yndKPcVaPpRxKXJat6FBmPJiQXSDm9+thSl2yStk8tRhYeZR/?=
 =?us-ascii?Q?c0CbbQYOjG54v3Z8+KbX5bDvYAiMbrZbtIyQU8c2Ko+nOYV0DfjyaOm4CDTv?=
 =?us-ascii?Q?Gp6148kpJofjJh7lnn5PH63US2opZrkfn9WxWJRKlIGpbe7Hw0QFWV/ejLrO?=
 =?us-ascii?Q?r0AAh07YcWzadFpDupAeoZjl9fORZeU466qmGRsajDsvMpmLtTNZUSxuN98T?=
 =?us-ascii?Q?PrhTXsBr7ayE2+rGGY1eJ1Hk6B5mXi6yNFVxOKJ1GW1U4b8FhngUQbTj5XVO?=
 =?us-ascii?Q?ICZEc79fLk37NhZ28xld0wD164r9tIiZgepX63r0NcvtKadG7LCnZUMpaASe?=
 =?us-ascii?Q?qHxpeZebr+ppQFzsvxu55MzPuPaBPb39RJwuCM2YjOvs55e/10zrWu6j0HBe?=
 =?us-ascii?Q?lmHEXLqBmA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f026fdb-fc20-4b09-18e5-08de909d570c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:57.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyHSTejW9X6QyUY+P5PHnD4wm18ecGolTisqv41G1fywilFFV+80deVvbBV8BCXzb3FDPhXKlzL+EanjNCrW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4cc5ad01d0e2..5cf2998d396d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1370,6 +1370,17 @@ pcie0: pcie@33800000 {
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
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1

