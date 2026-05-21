Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2F377ED2;
	Thu, 21 May 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355862; cv=fail; b=k2E2z7nlbdGqEreykyXturJYVTsttMolVmtVzSvITDj3EcWyha5S9nZFOFaB2gV2+7Hbw9fcvaGELf/V1GdFmkIY1qWlutFEnt5g/kICOmEqofwJ4txEjtnpzipbqI19igp0ThYXu9m0tFXD9pzw5FwUDImL2qFNfgCrvb51Jpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355862; c=relaxed/simple;
	bh=TiWOzau0DnXGtg1pC4F4XF2OrEEDihQ9hEE54aAC47M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXAQ/uS+RGNNf/ojbPQzhnsM6pJFEMRKC6yVx7aqJ3uOFNt88QGljrQkAuJI9Z4jGU87cy3fbZvKcizTE1QuCUXwJm2CHN4izaeBx9vrdGXSSaCTGr6BU2dKNE/kp6B7dtXoW4pCkLuooEIxZlFPjSJHn+jhRfsvRlOVh0VwiPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z92vEBIl; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z92vEBIl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bskWbZu+Omvh9++k7QSORwUs/WWiyGWDGP2ieQbbz76OZKYhI///DqnNdiFdMwS4sYROHUdC1MqnYLFv0/4Zl+m9XS6Isrb2WRb18xVVWtWEwiV5R1yAlQWmNl6IjTwMLOS5/SvnTGOVm8CWeCHXNFAMC5jNmeAxVyf/7wSNyRnSMyIZ/yVQokh2hAzF4z3HXQAirbCyrYLeYDI7RV3dUsaXrnNhngzZTIgg281gym9idWBNx/dTPyuFAWe/7JguRESg9R3Pj2zhyv2vm35O3zcqse1EylMGdKA/cl8eBmoHm3KGuuoeHbQMU7S4v+YdS0QJrLZN97826XwnaZZ79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ZqdlIWCZepXS8hLXYQBXQFxDzvtu1BP2gYZh7vmiw=;
 b=WHnJHQfqs6G++KOpMEaboUSN+2O24a+SMhdX0rxgKoUizX6/Rw+/JmQLNu6zn7myGMxeQQUnz3VgFBm8mI2NHAEnjK8OuIVU3HjAnD8hGMOP44LxN1GxfGUOGJKBaj8iy7uhNGe8QtgPUqzxd5puxb+LhG6rMEqO9UM7kXtot3FVCIYprnW9g+ZkCOc1hryaU901ds/ZtiOThnMMfhw9hdOXu3awqxqAe3AzQKYFTbYHRJLESM3c+P9WFW/MlvR18nSIgasygLQsu9hAV5cEQwGQg++YcFhP84vUYi3ZSrt54CMzypIIdWlzFp84DuytSvyal4mvCleT6xtpeVz5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZqdlIWCZepXS8hLXYQBXQFxDzvtu1BP2gYZh7vmiw=;
 b=Z92vEBIlu8vBddLeUY8FZPQU7W/KifmurQ81Zf4xmYGwq/KphWv2UHezrwb2j23geWcno2yhg07VmHzF3wvo7+g6yhZbEhlXIrq8Hb33zh1ZcxYUr2jyOfRjnih0tTahd3DPW1QBSBJVRXZNZP6WoFlars+Ml97/0QgtdGQ1aMkPjRT1c8LZt4lT0f1Njg+3KwOvtCdSnwixv1KnEEGpa1FykJFNGkw657CEzuNrLDkPLDe+sHScGkPf1Ty7iHoltOV0GWqjU2kmKNPGeRe+cSU5/RgH7WcMqgJ3WnyxFpvsZ65GGxsBMXuue/eDM4HEspDCbewbC69ke2nF/vIInA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by AM9PR04MB7507.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:30:57 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:30:57 +0000
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
Subject: [PATCH v5 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe
Date: Thu, 21 May 2026 17:32:54 +0800
Message-Id: <20260521093255.61585-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260521093255.61585-1-hongxing.zhu@nxp.com>
References: <20260521093255.61585-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To VI0PR04MB12008.eurprd04.prod.outlook.com (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|AM9PR04MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6522f8-e353-4082-81f8-08deb71ba97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|921020|38350700014|22082099003|56012099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pOTG8FRXE8U/ZKI8RpQjJ0uRfxFexKq/qdBHwXt6NZlEqj7cf8jS17dhgr008znJjhmO/uK2Hrh8q5RD0wHO6bOzBw7DW4PlKiAVeeEZhK0sG/dj7zrQIS/TYc2vFUdkQECMLID0xbX7A33dAVzbexSsjNSSr2fGKgZGq058TNCa1w4xtJ+5VpO3e/iuw5BU15Gl2HssXV1u0/tzd32yi2POtMSM2Pejiq3x34TFCuairR7Buf0plzGLZJjwo2jqkCe3UyXc3xvHLNXQc1/XN4HQIj4z5wUjVJYhJWjv+bC8e/x0ZLDoIBd2vhceAFSIb/A1/sdSjW7H+2Aq1hcH4HpyJKxNiveVxbzwhJ17C3z26T0KPM382zQWurSbW0h7hfcHJzPeWZQQrfFhhVLaY1wOpq0rtckDpVyH85xHx+Hv94elXO+RerD4UVL7kKPMUQG2P6T6iG6b8C2PETD9uFOSXSwooXb4BjtkQk6yNHLsIvIoPI3vboAW2SZmxJ7NRfxrPe42q2NsfbDqVqVfWeiT44gKsqlBrKYrwXBxRR/uEhHsLvvP5Wg5pNEO/t2PbqouxqimLYwa2TP5ozSoCJV8EH7V4h3f0jSHL3R8FT6VLBMMBVLQoQePXx3o95oZgGzOXk36JuudwdXymemyZXdDz393hkqF6p34ePPkcTHcKjD0MXaDLBU4IItzVXZ4ih+gPDeOjx0FMfgLR6h7cfnhCQXw+quxie+RSyibN2cdtqhSeTZ2l3UJKVq8w5q1NToTJ1M8xT3LdtpDgYBhOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEuJs7KpbE9zNgIZIf0Wc7J75CS9QBU0VEtC9Q9J0VGZhCLwcqe8Yn2HNay0?=
 =?us-ascii?Q?6EyTLY8sJw8ksxWwkwxyC6GF5sXoDIq75VSUxVc9JCIpPlTRT78gAk2agL/r?=
 =?us-ascii?Q?h01cLDcTY6kFA4gPEQJ/LXPeLIDrRvE0WUwOF1vMjw2dzn3l1WFLL3AVhwb5?=
 =?us-ascii?Q?NTuoR9EcWtS66gSd+ve/uR18JRCYkbDyJe8Bo8hPZ7arKBesMMJxbKbBUjD0?=
 =?us-ascii?Q?KnyWrTfZ11cy5pse1lpH6tlookD5qEKBwXtUK4+UQ9OmTbRf+PfUxktiSvgB?=
 =?us-ascii?Q?AGzF86OknU8/ZrQe5GLSss7A8Vpf3TzlResr8tlLbJo5gKi8i0CkvINbz3NT?=
 =?us-ascii?Q?TpgKR/fm4ISAc7tn4TgRpS8uf1ymIt65RPOpH5otnxwE4m0smllbq72oGrWX?=
 =?us-ascii?Q?SlIpdrqe+JQgQGQ5cqymWilVtrUI22VhtgHxvDEzW/1/v0HmWKSh3FWC3HVi?=
 =?us-ascii?Q?Y5b0buqHgBQf3SoLWoQPk8tNuOrA9ved/yBayS56RTuVe5TL3NIZWaG96h/8?=
 =?us-ascii?Q?Dk19PVPNQTx3B14931fBja3mAZTCS8YyPPzYD4cDJgTUmRuodyJeCDlh5ush?=
 =?us-ascii?Q?sXQUfTehiB5+kNMHGnzgfKaFGR0fojl5QlldCBufzuJaVrfVJVq+SiTsK3rD?=
 =?us-ascii?Q?2lMzwkGtmKJUCC5XEa5mi1B91UHk0s/ZRaU3zQNF4JYNB1goZ7mgVkl1VBnY?=
 =?us-ascii?Q?5yy2WAgscEAc/v6LCvQiat0NRYCoD/sa3pm/SEeRveDAWc9XJ42GOfHhcTqd?=
 =?us-ascii?Q?poJeJWSWBe+QIXmxhQIx0n3k1be8ahOsSidmrIr+2gQi22uLn8cga0l4a3qA?=
 =?us-ascii?Q?uVsCay9m2i2Idl7f7vKMYF8GuTfMRS40ZABtHuYg150UwoerjdthsDXNzFEQ?=
 =?us-ascii?Q?w7nRyfJa5HABRc3Lohvr8Ksgk1t38Bhe5DZ6J7WLQBtKrQIL7BD6c7mGWzgC?=
 =?us-ascii?Q?logeOeHhtbjaGAeDr9gwNrbemIT5Tw9fxFijZEWkZElYuUn7CGvpWTZiD1Ym?=
 =?us-ascii?Q?QOddfAzCrHKaH1Knfibhh+IkghsEoPcgYqlZ5DcqwxG/29W/LamkKVoBt1+7?=
 =?us-ascii?Q?4+vbdijRS62SMWQruk0s3sHBlpt5zR/PDALdmimk2N7ekTXqyJ+Ap2EjQb2D?=
 =?us-ascii?Q?NyPMghgwJWNryVTcAf17BBXdw6Sa0RaPBMo40UTI/V4IRJN/KIm/fe97IyRS?=
 =?us-ascii?Q?IEN8mImFKrHcWR497OBxsbMnHZKRYfFdjZB7MfC/cyIAgKlW6HVW+SAxoyyD?=
 =?us-ascii?Q?4LHRJZpJAtsP7hs9FjU/v4Y7JNJCBnWQkPGDHpaMeA1PGZ2IlW+I/cblNyEq?=
 =?us-ascii?Q?ArjDkxCS7pj7IqD+2NE0lbqWWr7lD4jZRY2NZjoXirX47/uNjtd73zL4cSgT?=
 =?us-ascii?Q?/0NLrCDvPLWbrKW3nbHocVBKaK7cpFd1yIrUbHBx8oARlL3KIjRg0B28uIfr?=
 =?us-ascii?Q?AvC1cXAS08LFuDGJvsjkd8ce7UvW4jNk7U3n8K40JC5a83QYjNkvcbGXLMtc?=
 =?us-ascii?Q?zyODocsskq57bpQCuxIf5qhccM0VDdzm3KLySOxsInrXpOHknzUx0q3N5+JQ?=
 =?us-ascii?Q?QFAaxj1xXjSd1u+yMEe4+l4xiwfpBJp3TMM8VoL8dexk7JAgmhUCVvK4R8PC?=
 =?us-ascii?Q?XjDiaQ4EesBfU237Vlwd+9ZlOs7y7XWH33nxGVGQwJvwvF5Pc23fXgngXdbh?=
 =?us-ascii?Q?czkh+7vmMEEGDI1EwTao3PQJ2+r/eC+g/zi5DlJHwEgdMrOfpfr4dqnXdjwy?=
 =?us-ascii?Q?Nah1V1IghA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6522f8-e353-4082-81f8-08deb71ba97d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:30:56.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOivoJ4sljDau34qEFz2INKUMsVSs07BMjebvPqeH2sKfd7KKpxzuK8SSQC4/r6s1Wu6lehgtNe2Nzze0TgnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507

The current PCIe device tree configuration only defines the MSI
interrupt, which is sufficient for basic PCIe operation but limits
advanced functionality.

Add the following interrupt lines to pcie0 and pcie1 nodes:
- dma: DMA interrupt for PCIe DMA operations
- intr: General controller events and link state changes
- aer: Advanced Error Reporting interrupt
- pme: Power Management Event interrupt

This enables enhanced PCIe features and capabilities that were
previously unavailable due to missing interrupt definitions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index adcc0e1d3696..f40388958717 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,8 +1948,12 @@ pcie0: pcie@4c300000 {
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
@@ -2023,8 +2027,12 @@ pcie1: pcie@4c380000 {
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

