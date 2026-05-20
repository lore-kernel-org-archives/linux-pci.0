Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182313AF641;
	Wed, 20 May 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266896; cv=fail; b=SzpbWITLA8Soe7XEQaJ9YY36HaYXHEX7W/OawMv71Ykse0O4068qJLxmBHXxmVRP/XRqeLkRUKU6ATlDPpX0mLs+rU5+hy83B9t6IXOl97INkCxwoA5/UwQmZWnyNdWnEpS4ijb8CJh2SloVICoZs5mGSRDWgok5RBzHqMQ2Ju4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266896; c=relaxed/simple;
	bh=rdwQgBO1kanD6F9mZh9wNAeYjoS09ieKWQiB/MtDP8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qL3aDCpwVIE1vIT4aMkU/XCJChLA4G5xx/Hv+V27J4aitqRAXr5i6uqh5EySLDxZrYa3zQEA8GaoC+SncY8MTkCcNS+K5IJeXTfXKi1ME6j6Uab8IPS6d3O1cCmH33XnqQ0XVk08Y0cGqAw/sH8WyW2OULmmK721m6Zt+HQRBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rbe8bCsX; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rbe8bCsX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8RlNVTeGySRoYCBELQhnuzUz7HTCDqRDRhqEe9v6BvAZAeUYEJ78SxVnT/mkTB9ItzNreII6lNb4Mpjq0ynk+adVT+RMUnWA8SzQLv+FRun437pX9GClLlfV7isGGk7sVG5+KZcXmQO7nF+3sNV9bDrFwDLGV4P7c3oJabfEwYpQf3oMpVXzyhwHPdkGshogfwdQPyI7osFrQIwcWqZZJpiuArFULW3xtbf7unxFUXo6eKc5ns7FFBvHECfrS3aTMFfRdEOAu/BZCS+yFPvQQ2rf6EyWyN78fqpAyjingbxst0ULZZQuT8PWlerRfp+o5hVp+Nl5/ykH6s28Z8JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul8HJIMyVHejUSne/mvOdxmOG2vJJR1DNqAu/KCiD38=;
 b=fN91Tw9WtLxn5TlW4RP+qgzpCbiiKsBmw4oSzgvZAfquyz+7ZrAfiht95QaVXBSt9kslhhRznRyAJBknO2+oxCYeiAl13lAIQ3hh5Hrus7LoCINosoRLVP/6Uz/G123wyyylQJIzkQEtykFY0hIYtpDQFYCTKeKSloEFlxlnCTQ3bnZOy/Puvz65Z3UThWXTjNXG9HV7H8NTf2K2qpO6b1fXXVJxhvLzcqE1U1lrcKZrVbvgGOqSIApW9x+Kx6Htd22DarSZQEw5/8IJ72Q2rfAECu2u53C8U34e9di0Iat/Q7kBaDaRYyrFpsbUdOE/yXclzaB14qDklw7euRrDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul8HJIMyVHejUSne/mvOdxmOG2vJJR1DNqAu/KCiD38=;
 b=rbe8bCsX0cYkZbgPGXHvkfUMZYGL7GEGn9/CkkKDNjZMg/pBQzBmrn1dvNWjqvv9kkD6CywzWUFgXzsUNlQZP+TuLnT/Vcb94WgVBW5v+FPt9N++EBgEUC8g0D+i3InJI/JbJGCgfDWLxUcWyI8zPajpbr7VbHsyKw0GCxYPvw8w4OGuhtunLa1uaLbBvxEEmS7H9vzUM7UktLjSdwaabfl6SXeJggnwv/lVK/32GxAAhyg+Bn/WB3NLXiCdAW5N/TUcJfEFD3VHTbtRU80P/Sno5qFo8rr9blVISWMpCDgvdy0uAbJVUEq4HiEQk2WE9nwQSU7WlXjwoqTzOjcVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:48:11 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:48:11 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 7/8] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
Date: Wed, 20 May 2026 16:49:03 +0800
Message-Id: <20260520084904.2424253-8-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 243d7970-7e3d-4887-5af7-08deb64c8575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	CPhhnAbYJz0QzfYmRA1FwZxum8m9FqkN1Ny73XsyoopVVgCL9EsfQD/nvB8nbqt96qBj/1JC8EdZE/gBxXxphBT62J4wr//sUYn0pnylPpLjEsxOwRd884KWzULo+CFlW3/oUMwcQA59OZQKjeKwFiQd4ZJMMJ1YGRgseqU3dp2DmOgW18jn/R/CQm3bWFIIZbesxBs3WUL9RMfIti8IrqpGizu4smot+djne5yygrGYyFh4LffuJ8p4/Q2RaEyVNgxf7hVeywvBMuPlicGm6MsP0VD7zmS9rDhElurpYgH/p9OQc/QnGKLMFYzl/0pOsciRynk/clMchjCNTpTCzkiHA93v6Bz5mqc1yVqepV2+HQeXz/1FmDGISVVeWa40WB8x/5+GZg9fwm367UbbSMnaRucSFhdbIIlVw3OGhpgABybbw/EAaCwFiKS+FaxGAd0sNtp0SX3xcADH3BrE/0Kn0y443LzZlTkc/fsAch/84FFHVtCWqumpJI9tQHHFOHgvau73F2ar4xX+LKFI4V+U2eB80dZA2M3voTLj9m2KoNmwEzPG9U/mZ4STdz5ft8K+QYLP0mPpitD8OXyHse+azXE3UOS1IAUC+4zyJL+4wJ/6YSWvTXWXY2AD6bBm6E3bVyBkEajydgE5ITjr2+wPy4+uWcYBhkwdki73bAdKP6ERNlghx3kzuYWWEEKxjEDsrGg5vg04PcVmdy2Ae0xWvVTOpSHm0dFWM+ukkyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFXnWSBHlESZLhyr73SRHOFfsDe/vTtRj8xSDXVW7YB+9GqC03tj6xLCQsrU?=
 =?us-ascii?Q?n0vyqsYsuBRCdK9zcUVDUM3umg7heMVeBpUtf4rRomcD+aBOLh9VIn/V4S2U?=
 =?us-ascii?Q?ggc/eBLSCMgtFG3RTwN+hxA+WYv0+uCwcwSEoxekxhxy9/Qer8G9aRR0ABYS?=
 =?us-ascii?Q?XMW54Ow4XjCpvQqvcDzzXbRCi93Bbvcgj/Tj7R5k2dw00DR2JE3UYcWVYphZ?=
 =?us-ascii?Q?XfAuhzbMSdcU4GCYurD3CDmdpqdm0Sywx/AlKWI7ZBxwXXw6qXtXtEVz4ptF?=
 =?us-ascii?Q?JrEO6FRIHy66bYwT0An5NIA1aF4IVZG1zpJKVzP17MIO2/kU/s694X5y2tfk?=
 =?us-ascii?Q?KzgodxTZ9Btk8vSxOqRb3NAL3VmYP3DRpFhHAPsgzsXC2/GFsV/7ONAthHdV?=
 =?us-ascii?Q?vrRyiQdKiRR9AzA1NMCo1X7S5hJjZsxCV0DhCXKoIQJmbLv5Ybu6Xpy4iW5Z?=
 =?us-ascii?Q?UoXZ8kxXDgOVRr81fkX35wnCbXvX0of8UKjO4Fla8TrEf5sHbzoFOU/ItNmo?=
 =?us-ascii?Q?N/avDapb+Aylvu4yRlrY56c7NfottCHNZ7QlRlpXwRK4KmWtYogY0RekwZO2?=
 =?us-ascii?Q?fUY1LELpYqOpAcNXDNhcleBIPVVdvmTN/oqgTQimchckMHX2zCERA7ouRD/G?=
 =?us-ascii?Q?ZSwWmiR3us8cWzetjqRw8ZDnJ5Nnqny7BR2r2n1OJyckgdB0uuHInJEHOIbX?=
 =?us-ascii?Q?UEbWYD5aK17w3Rk3x2wuiIRN7McAximwHDgC3I1fdZHqWbZbUErqSxw+8tbT?=
 =?us-ascii?Q?N/bGAL1eTN8tdcr6Rx+l0s4Hs0NsrfmxdaD0cohVqUY4UotoGbGyjz9SXHkl?=
 =?us-ascii?Q?bRtWFjMS9XqfRnO7/cAFLOKxFGolFJUtUhx8HXJp2BdyCTWIGY0HivBpoD5t?=
 =?us-ascii?Q?LaclZFMVXL/hjUjJx3g+w0VYBpSqmcVt3KGfDoBTbTBnskEhoWyOtuhvqNJJ?=
 =?us-ascii?Q?SxOpDTbu7fYZbXjPK+QzOWBXarneXKNJhi9u3VFN/NRyVvUs7cSR+WkY3scS?=
 =?us-ascii?Q?b9HuyHeJ7P1zuFNEkI7K0jfDvgP0Wzc9Z8MYlAKVt3eqQPAIrwaMU7rIktoo?=
 =?us-ascii?Q?8HlqQegxHsSdUtectLJBZYCoj1/jrhYXQCbXuhnaAA36FLKYYQAWyG2p36d4?=
 =?us-ascii?Q?h1Tw5Qx4KRN21TgT834Prt0rkjZCIzL7YBRNqEH9tGdzVTF1TS59hNFnrtKw?=
 =?us-ascii?Q?9uFvUphRRe3x1SF/B8dRcvgEjnBXOH9d2wXzPBLLb6s22d1FgseHop3RyMri?=
 =?us-ascii?Q?D3pt9ZC7/gLx45XtUl2JtF51B7DSQi7Y0pbV/9xOc3IOOUSrIbSe1bCOtZAm?=
 =?us-ascii?Q?ha/ipDFiojWUoZPBkjem8DdVeKko1OblapPFdUnf1+hCw/bLD5ly8pb1/46U?=
 =?us-ascii?Q?04y+ncI8WL197bLeITplBNvJTdn6LTOeKWA32KXBoEqY0F93NqxkTjFUwbg1?=
 =?us-ascii?Q?EpX/s2m69P+EfFH3DCoB931BWD8hEVIb9rY3q2n056OqsSZm/WhUAFOu87V+?=
 =?us-ascii?Q?G+AbZjt2mh7T+4iHl+H7b5nTxlbYJT9uIvRk/9OD8ZtUaFRzxMhZi+PT17jF?=
 =?us-ascii?Q?A6Tr6aZoQjr/GF1ct8G/MGQnPTRTFUwC5fMgMuHspIgLSNmJx+Tg+FM6IhJP?=
 =?us-ascii?Q?GXBpiDJsuJc5rYETVdQmjqPfCRtsKiCoW6F7b1KrKTB73h6yo+KnhdrMMS2U?=
 =?us-ascii?Q?DZdqxIhv9qozHE+7VWJ78q/qN2LzzRUkna8fwLrTvui5xcl0duFZ2yzWtSlU?=
 =?us-ascii?Q?tcC37FxpnKAkrhmB424lXQywlC1F81fi4H94+Ggfs9Sd6ADGCVpx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d7970-7e3d-4887-5af7-08deb64c8575
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:48:10.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh+d+wwbhNjK8QMavFIyC30D91fC5L960TOm15UKwzneSvRn/xxL7hnYuviGJGwO++xDfDpsefh/Zgt0+GemsdYU6ykEtJ7d7YTOTQAsna0VIpO/9drqsuYBJVqUvr2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796

From: Sherry Sun <sherry.sun@nxp.com>

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller nodes to the Root Port child nodes to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 78e8d41e6791..1084164d1381 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -677,8 +677,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
 };
 
@@ -692,6 +690,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &sai0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index f706c86137c0..5e725ad8aef9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -812,14 +812,14 @@ &pciea {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pciea>;
-	vpcie3v3aux-supply = <&reg_pciea>;
 	supports-clkreq;
 	status = "okay";
 };
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 };
 
 &pcieb {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 2af32eca612a..a9b967d0a9be 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -732,8 +732,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -748,6 +746,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &scu_key {
-- 
2.37.1

