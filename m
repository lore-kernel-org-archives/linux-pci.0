Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0612E7395;
	Tue, 30 Jun 2026 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799507; cv=fail; b=IMLQ6w6/d7xzvjVDoWH5SRjV+o6fb+qnbyp+Q6llqqWN+tPJfxj1obb0drtT81XZhhBhdBtxWU3M0Ci+JrK6IY0JcU+bF3keZni+mQaJrE2gSs8UY+V2EpogCpJL5tviORZ0eoS3OZKqqNNE/zZmJiCPBz5CFZryiw1ANDia40s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799507; c=relaxed/simple;
	bh=Eyr12DF5hlvbujqFg8vhZsbB3xWyTa3ty+0n8TrB040=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trma8dENGqslLv8I+PqGHO/rEHofc6JrEwTrnzviqWXXzUlfcsfwE3itLfWkTTCNS2QvPQXthqTE3gfhnrfmlufZvRq9HT2GMa0qPjybpV8Pj/Pu8t7mT4KmRkRGZW0VHelCp6bqaOfO3tgT9MLYWaltnXPY9zqbLKsROA/Yo8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dRBOPIfJ; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dRBOPIfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPwG0gm/YWAjg+Tf3CAo5iYWZFOmkRf1I4WLMfi+RZUdbhP3Mil5aHnBZbv9HFw+FI9IVNwtNxNRN11yBCtTu+ckauQ+HM1g5EpQjJrRQHW/n9vDdn0KuxfBBisbDsJ/MTCVJ1IMhduj8OGSgf90tGziHvi2EDkUrI3kmeFENp9A0xpo7951f0uFioFcVJjHAPKahWj0yU1ex1pv9JnVbvFBpZHwPdUoeoXlIY4cfTH9132zpD/H6tTEIMm4wXMpou4QxgFnFJy0EaoAUACfrjN8qJxrYvhpUw4On4QahChav9OnnMiCeJLQoAIVnXnhKendoitNuDYKZcKPm184nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9fxrDpTLTr/hagmb7oxsWHzHYdOUOTFq6J4MP0FMcI=;
 b=lIsLPDIHgFcqYgfWMG+TZEaf+slzMCt36z10J3O7eToNFHiBJPvrmJPH49OjB6lEbzjkY0hGmK8PYbC3comQiLan3PdTguIuEq/a53HgN7+T/YLixjS5IVRV6VHmWm8r0CR5CTzUcZydD3aPxOr4Afm989mrO13U71pPTJpaS9F6eiGiNrDPRf6gFWtAzJorA0zW5MTCtAqyRP8LKVDgSAouiz9pM2RMReewkhFOqIJMpeziOH0zL79KPfHx7QegycpMNbaD2R/iFa7rioUQUhQcN4cIxOFcvETQusm/rBEqGxAZ9ua7wpjtpply4n+HiOQ4TWne032Ip9tlOCwjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9fxrDpTLTr/hagmb7oxsWHzHYdOUOTFq6J4MP0FMcI=;
 b=dRBOPIfJOeW/Vx+PrZ+DcuQscaxiagc5V2YBczrofEzzOhoAeCGIIjj0NgC27zbGmYBZrOtoDMcA90rydm3pc6Kr/SKs8HK66Mgz8qb8issmG8jzK7UnZSl0CYoOY3u0GCQjX3WwFaf6jS4Cz3Sr1EinBGLMoSkHVyMIER5REoCVD35wRkCMirlGuRHZAQr31ffnRIhgfmRAoNF0xEjd5F7CSLmECshj4mFnCoMNEhXrZjjOs4HF7ZCJp93LeNgdVl6vdWwClG92853muVUdzZv5u1HhEXU89kIaDTQrOrRp4iCQJLdfnUYROkpaN7pAkunFE1yNyQbQ4GF4bQyizw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:05:04 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:05:04 +0000
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
Subject: [PATCH V4 2/7] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
Date: Tue, 30 Jun 2026 14:07:05 +0800
Message-ID: <20260630060710.3294811-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adc737c-c213-4a44-102e-08ded66d86f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	8KkD/9R2uqc/Nh+bZObwDdxeHdmIy4L7kjw55KCjI4dCMt1rJm7WwBr39PsdjApXrrZ9S4mgnZFITFkWFettEh/17wvE4GoWVat2NjHkd8B88F5JA3CNUZwVT8WixaGC6vQW5XJOc5aFv4x5dMgebRgAdsfc7sbA4OA6y3wMgkWMxquPOFoMoLoAwmDMAqsFeyAL8WX/1OfMLsH/qomDxJLEOwobAtmSup5cAetTFYfWZ0Yg03cEEFCxOpfB1DLYBhVTDtf0ri8M6C3+zt+iV1FZX/GJOyCyWoPaeq/lU9B4V1e7ZPZUcjuWXvBhJZJqohL1WH1ajTPHQNkdXJsUq+uiO2cErCrdqO41gqDy5ZVwl1M08+ENLPwKL7yDpVFjA0i4EzDsEGDHbi5ibQoSaZJfA8zMYN62cFiVWjbzZW7BxYJhichFUFrY7q8tuWxJ6AEWLAlpKkXsvhEVhfiwYkYY5GNlsqPdsAI8LD06LH+PtrQ0UOx8siG4VkVHSMSQl03nQRnu/X5pH4rP28ia+UO0yDOIzlbRjmAG0MrSL2+ehQTdeW4UwAGvAwQs/SQQtidpanxNxzoOnjbIRMgPcOCuom4AZgxgOzxB+Jor9wbhxxlE0tlR4Z3WchQt2LU+FA4bmQl89nvh/aMH1WQEcK3kSBCF7eKJJtntpKTsq1311zms8hoLCnPWsa89jh0IcjqLYOsUCkaDveKGEg2u8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6cXuped23irDrUbuYTgySWIlCjvRF/FAHNpX5NclUy1LuZNRhGjKL6DZ1IqE?=
 =?us-ascii?Q?48VSetEqjGVxMgftmlZ41vMPhoVXsmjwsvRS6VEEo2DcsHeTx/+K07NSWyaB?=
 =?us-ascii?Q?kfksEWm+nuJu1N+eWxtIuPaEv93v9pmLjawJ5kEBAXRsXFigM+Nc3vMdmv9i?=
 =?us-ascii?Q?71ZExqE9BA4gw84ENQ1cKm1DvzPF4+NXByGru9EHeiYveBpz8/ez5QAxDb1m?=
 =?us-ascii?Q?SToRWVgwIZ+L3IMYbadLWBJ3JGrIuG/4iAINT3i/WIQ3EZ4hLIzVGkF/LlUo?=
 =?us-ascii?Q?nBZxyflpIr23tVcl2H9jJ41W5hAlmCjvk2Ou8V+Gqcp+eUgz1Bg66DVTFDoJ?=
 =?us-ascii?Q?Vp39lB2800inrCFOr5iZ0l4h3qp0JpNng+MgmGlE8E5f44tsYy1IGoJjl7q/?=
 =?us-ascii?Q?B+x9xxQ/XMCQLsap85dB2Kdq9tDmIjn1IszLg6kmNKiHXofrOyeYNvgh2xYe?=
 =?us-ascii?Q?ADCmM0UrDMKorl/9U14B2YAaoJYsZDmqPyGHWVpOfcC5CQ5Hwq7jp0yG//Lb?=
 =?us-ascii?Q?X5UBqUinNQqQWQaCY8tbMYt4lqjlaUSkq7zM1Ubw5xlvJfH9Tk1SxhoEDB/Q?=
 =?us-ascii?Q?CE4mWeg0miuuqRgiISVq2NVbiF+3qd2udcW++DrVd0AjQyFHV5uOscFWvAIt?=
 =?us-ascii?Q?DyXVbHKxT81+vARxSSHqckqfzjgNzXVEdpj6GlBnD+k4inVNKm08M7ye9we1?=
 =?us-ascii?Q?T6pL6RtgVkL4jdCDJOYOikCIndFO8fft1s+OCVNsj4tSW6qL/YB2dqadiyXg?=
 =?us-ascii?Q?8EUFGEjn+Itd8eiTHGZYTlLj+dV05unKqwgC3KhO8u/FXQaqdxY5+uEFitJx?=
 =?us-ascii?Q?ReQ8oTM13vQhejyzPHYOr/baTJf70/NaUyG4VKfz3jJ42illSSvSPUYGQ8J0?=
 =?us-ascii?Q?WJ5iFmXpSBAw+q3lMR4aVkh+E3nZhy43JbJlsVtQjytLXXZ2W878g9hf36TE?=
 =?us-ascii?Q?IK+dH4GcJP+0c26ZxDcAq6IQ8Ae2OTy82g6bstjFQq+2vBfr8r62Fe4VH6Wx?=
 =?us-ascii?Q?EvNNnYlrezdBvvGyvenQj8bT2iJ0AkdwPsvPxTN5KPsKZ4M5vIVMxTXBtbiP?=
 =?us-ascii?Q?rPY94ggx08G4r37b8VhfdPml2qA2fZRY+hNwBOWuWDrtAGOdSFcUlT98lM+B?=
 =?us-ascii?Q?xkZM/CdC6XWI7vPUI1nzs8gtyEjbi40vA+PyzpUCG1vzCsdQfre/wUxnXIL9?=
 =?us-ascii?Q?nvlnSBz/F3RaaluvNmiuGnDZHdAQUiubLYdjFzflFg6OyaEADxhHNZwWEpH2?=
 =?us-ascii?Q?c6Fr47GIB4hXIFOBRYdE4SOfvSVtcneQuI/roeBauPoMD1MLlRXu6EMJOFVC?=
 =?us-ascii?Q?jb8s7NlvaJnFgcurZU/00FB/6rWOnkYf8rNd/q1Gd/4M1TP0TuVbea1H5aP2?=
 =?us-ascii?Q?EX2B/EqrH02YKRcq0LN/hQUNPKpHYGgY7qJqw5sf/Vz2ErbmV+c2IxSc6cR3?=
 =?us-ascii?Q?ybvxlyeVBCH69zDVlZCfNDp/EN7tEcuLGMHG53MBpIl030jfq4GbluiFFkg0?=
 =?us-ascii?Q?mAYdtauq/uIWmhzRElI50G+hp2EG7mihQ4JlnRECXdGr+2Tpl40gnMEVgaih?=
 =?us-ascii?Q?udtdFwLh8bj5n7yYgoOFheJWNnurxNLTmJ8LB6zzLcFMVD3RcrmnJaABtzF9?=
 =?us-ascii?Q?SOaaTJQYYkd2n1ZQGTPRihUeVmUYYus4PmdLpQi6l0L+O1mq8P9fWFT7m+Yu?=
 =?us-ascii?Q?WhWEpJYa8EBOStkL91GLh+IbMG1wQsWxEcLiH9exkmfp/lerrnjv1LpCC29x?=
 =?us-ascii?Q?K6s0UA+xg1F75gA56ZCaBjZ63sZps20SNMC7pxeciutK1TVj4Qlu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adc737c-c213-4a44-102e-08ded66d86f4
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:05:04.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SqOuVtBljMkSGY3ngHomK3Delxth80DrDm6uUu1DRk6KAVNyOvb2FQWqXEZsOCI53pWxECI2PDIfAG80YSl1o6iwXbBjglZB0/vp18mcS48kU8heEy9ujbg8z9eFp7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 338de4d144b2..41a69fe83be8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -284,12 +284,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie_gpio>;
 };
 
 &lcdif1 {
-- 
2.50.1

