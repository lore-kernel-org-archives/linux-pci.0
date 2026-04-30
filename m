Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C343369224;
	Thu, 30 Apr 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525690; cv=fail; b=MGg6j8ak+LSgnQb1eziBhPt3hSxT7NDlQwpwqT4ZqMUv+502n+ADZe5GHr9TEjG0KQs/nr+bhwPjNmVXbfGWcQtZ0NGerwapuLa9tfEDyu5TSgayV/tpEAFANk7ymT7eK9MsWBwe/Jx7sypjfgI6yqthqxlk7k+GE90v5w5HgOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525690; c=relaxed/simple;
	bh=O7LFK+BKr4t/orZi5sMS5shIINOzgdVUzSp7IfRunpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+SCXgG1cqfCv3YjiytYdCSGsKjh+JjmH8Ywzt/YXggoJ+SpxGApi/460QcLtNDVK115FhPy01JPRhEgCUZDXG0f2pgH4kwFgUTnYLr0NXyVQQSzZQMs/rbt746zhkltlkwwP3fbGwg9ZUHjpsoa0st/f+IAgucRfbCh/wB2C6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cvLD9DCX; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvLD9DCX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTQW++1WDOUK0vtYtoQHSZQID67nyJxC6dXPBhkbs95GVIBgKbHFLTDwMvtiebEwX+5MSTaGmZtekan9JbJaKnQuiiuY/vox8M09+Vh7h3OWjVAz3RE7+BjnYGdy8RSWZs3+Z6rpEZJsb0t++DpgLabP1JLChqviPkxhzfhE6y/ixIaUm1owp/g51iKCowN9y8Y5P1gpLSGrhHwDwGlBGhi+23SYiGfW1tvLmvd3LCjUXJF2iPsd1rXvg4cCJK7GbP/b7pFKVFpdzI2eM+JSHeOx8tnw/NSoO1Lkm0r1IQlurc62RNVjE3Ix9/S21rgbSisw+gQPRdYaPkPtdy/pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WwsmxDqHp3X70CxbWq7rq/H2AVd/J7nCgKyzFOVg/0=;
 b=HyBvMRwD4U9IgbKaQVCtreZzqsKs8UZOxpcmy0EbeQLFiEHcIIBXrvUkAk3Xs+UYIgwdPObzVVCv9tjGjj2BF4QtFMZ0ErDo/yzvpeJM1alUZNkht+6jYW2VTWEUgpVItd5DsBc187aopjKQuCQyj2sD6r51fMDcabaaEuU/+AjUFCpqtsZYzZnBXCmGJTDz4+rQlxUTB3hlVB0VbmPsV7W9RVl6eoMQAoWFdROB+9mT/nWcInUravuH39FkH3DZNZaiogfFx6dmJ0QGMW5AKxx7k9a7HTMsRxyLJvTXDmpBp+o4OA4WM7nnwC8CwpH1E5rfkCIzNLRD0fA6ditvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WwsmxDqHp3X70CxbWq7rq/H2AVd/J7nCgKyzFOVg/0=;
 b=cvLD9DCXIdH27++eYvkrHR/mOhpg2fUdcgnSFrLrUyQXo9Uv6z6GK/G+v5cdLZWENGYtZy2ugXqlw9Eiv/dKgYNLGmkcnblYRxSwgXCnGw+KVV0cVm+a8suwvmWFQ2f2uWWMRT+pxnx2Qk/s6NMTldRH2w4yz4vj7s1qfFdBHrNm7h6dy94DViV1Np1fphesHx8azZqMEwuyoJLviNgmLNZrrJs51OVmyxfmDkM0doDHSE8x8RSo2dcyYCf4G1ov/R3oXAKOJeJqDmtzer0nnWUaomUuGjU1/NG6P5sFy3D5HJASEOqq1X4+9iZzTieIArCjsrOOJdim/5r1Mmz3aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 05:08:05 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 05:08:05 +0000
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
Subject: [PATCH v3 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupters for pcie{0,1}
Date: Thu, 30 Apr 2026 13:09:53 +0800
Message-Id: <20260430050954.3467984-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|GV1PR04MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e695ca-b092-4b87-56f5-08dea6767634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	itt0uC0pdJtFLAzSpxhyLWg0O95O5mq2sGi+XT+cJEuSry2mKDdBeUVuvuIpPXkf8TTIWHHqVy/IxLTp13VQA3nj/kQcRbdrGMQnbct7t6ecSZRBywF6B7WfrMsJp6A5nblWoZ9l5yEXTwhw816QxL47PUlA6N8ANx5fhDDyrtRxUO2HCWKGeOm8vWPhcZWwW9M020BdcyZ8MP1z0tYhZqb/aKR2n/SsOQmnXmF11/jB31/HBd8Mm02Nm8G3eFTdwaec4Y6xRbN5aF1dWF0KhbTioyAIKjm71st46h8w3NpvJsJloaqD/fKWZMRJcUtVCXfjqGBwe+F4m6kRXUeMIUKnjW34QrEek7b0n04G7BbikEKXKtsbK5oxnXVlLtPxHlXjNiUMRpudgzL8hnaERuBWc8JmMQjNB/gyJ0dSSH3QAUlka5pueG8CmqDruuYJfnQ+z3jOZZ6WZHUW6kO8r3e81ULdkoVYpwRb7OnI5UdMDd1JqWh+e5J7SmoFq1C5fNWEgtVU66IWXVCcY3uisqvnX4sdEKDCFpdKDGTrK+OpK//ymASAvVE/q+LtUZaIzCnVwMLJ0WB6+lZAIgyPTKJd/ihZ0eM8M9j564b8b3mRYK6Q9ilYDoG8H73QTC3e9/cx7Isrv5aHWYqiAk5kBl0uL0/P54bpPoxfA7PVLF8Xn01Srs/fnYfknIhgMj/qois+SKl+wtIDNZXaDJbgIFErKXXvbjusVJIF2R+ylw51cRLqKnXIy9pO+SoF+KX74/stG2tjb/ecEu97twAsvVQVcLYUrqTKEs/KaDt8xER9di8P6A3I2Gaa5LCrbn1C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19wbnk1L7Zay1dRw+yBz3ulX7yai3YaGkmm+MC+OvYsGVZodQYp1jaZ4ocwo?=
 =?us-ascii?Q?9jLUoRJhsOd4tqU7dwWBlDk7JcsXNoxkWCzAP8SnQAz8mCx25PKX+VflQsc0?=
 =?us-ascii?Q?pCTMoZ9iChMHghkquMItp+b1fRlGBJzuwfoPJM0wp+xBRbgisIGn6ThHQsFs?=
 =?us-ascii?Q?enn+4NxQojlTpEFp63VGFsqNy/hGVBowPuoAlFnAtOD2rTw7+O9t53qAu0hh?=
 =?us-ascii?Q?vytfx+6fD4LnOwCrqXRdiv+EcFVztSFOQRwJ0UNPZDt/xuujR7ok9fUJmXJ9?=
 =?us-ascii?Q?Xy8lP3bn3vinCVsmOITuLzFXln2fxcv0O/xcmkpp3vc9WMxnWPwzqfORC21U?=
 =?us-ascii?Q?yYT7Z5Bl/X3aXA5e8NgB0/5jdbEVpW7Fgp5+U7lSPJ/S73UUW36/oMtHpDfJ?=
 =?us-ascii?Q?XEZwgMy172AFazLADb32MTWzZ1+6XhB39wWa6Hv8B74IIzseWuZAAZePhole?=
 =?us-ascii?Q?3tJVnWp6sPWZK2PdNwoSm5YsAcMiwH63IpDWD3Sa3//qSgQMePKMlW+PAfuT?=
 =?us-ascii?Q?2UP4okBezMMaYabpkW5wVw56fiSYOoQEToAwNvWSmLStG1VlcuC8m9Gd3ZQ9?=
 =?us-ascii?Q?b6Y1ttN3J89LNg218Y5hHXH6WPlVRpGr9BJQrYxzpTDTYg8WmhTIy3FDnL1c?=
 =?us-ascii?Q?sWB82yMNbmh9gltht9B48irhJo1LARGD3STWVoe3LyC9YvFiwYwYlIxVnn3L?=
 =?us-ascii?Q?FIz72C8U+hk9VfTppUhHl4Po8JWi8udzMMIUnH+apTlNdonsy4warJF5fs/R?=
 =?us-ascii?Q?aJ9QOz/MR8fMuF34CzgfnsmDE/Jn36dGICKIuccljMjdkWUIPmsgrvRT2KSP?=
 =?us-ascii?Q?vUq/UE/WU0CJBv+GIcTWlPf+K2YDnIy4xwSY+meI9XJui+L3+DZGGYVhx2ki?=
 =?us-ascii?Q?mdZpRNg3SMAxKZlp2N/AbRlrts4Pdoa7zrYve8COb4eirvbAAAGpsV6fW38b?=
 =?us-ascii?Q?1kUZUQ2WAoXnI3RcPICEwl3VZGLcEgTEhqw8n/if6RRP1IxvO3sQ36zFIfC5?=
 =?us-ascii?Q?jZhiz9goc8sSDtBpUo3wQioyu7v7hptL+FI/DN56IpCydO0y+GjOX5MfFIut?=
 =?us-ascii?Q?rztqvO5WudUdE83xU1H2iWLtQWd4/hOnVsm1CWtBXd4UO7DWQ0U8wJ/kD2Wq?=
 =?us-ascii?Q?Fjx6Ybb88XWzCqdfoE1tbislCsl8OyOjGHtrIhC34bdCWn6eBuVfyaDfHfrD?=
 =?us-ascii?Q?1DDibvj4S86LXQctagcfnJAErIgEBpBtn9Uw2LeTXkBOgPlq/qHQEBsbtCn9?=
 =?us-ascii?Q?EiuNN8Pr8FX1S8ZCe1KHMjxjx09GFFua40DZzVsHu35AWWtCDQ5yEKbwUWtT?=
 =?us-ascii?Q?2de1C9iScsjVsIwCbIUXlR26kzdWPaWL/11hSkQF0QaGEDam0cQ9JFfY5Csj?=
 =?us-ascii?Q?sbfOaKUYDOs46BiOViNe58J0eKY5VUEzS9NZP2H8BiT3om3ImgFen82LuLFR?=
 =?us-ascii?Q?nzNLMiqn4OJb6hzENZAR+NDXq6xPIk/mGy4fx6lxckLmW0UcrbMX6wFexe2L?=
 =?us-ascii?Q?RlLzffiS3nwawpoDu11uUCec8Osev78FuwrNpgrLVKK5qGJRar6p+z3vXDB4?=
 =?us-ascii?Q?tgK2fg+7z57X/UH8hG9yjQoJ4Xf9Z8H+QQu5URI0BG9VDca8nqpWg8sLOSmz?=
 =?us-ascii?Q?03ldeZKxFWPglcFPIAkntOG+nSRKt3Kndy0GZ++ERmCOIU1kgsMNbZHMOLlm?=
 =?us-ascii?Q?h+MOv9KX5V2u32BtESL6Cp9NC+qhwtOi/CfeUGLorAaEK1Lfo8KbxP8YrCF4?=
 =?us-ascii?Q?el41+MQisw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e695ca-b092-4b87-56f5-08dea6767634
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:08:05.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnRljiTdYgH5B6MTcs7+zLevykeXmU6eDBa8uaQAYAY6WG9yeJCdWJsKLRteKLx5Ra2hJXjQu4rd6QEmCyOuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

Add dma, intr, aer and pme interrupters for pcie{0,1}.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 71394871d8dd0..6896d9c15bf53 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1861,8 +1861,12 @@ pcie0: pcie@4c300000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
@@ -1936,8 +1940,12 @@ pcie1: pcie@4c380000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.37.1

