Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DD291C10;
	Tue, 30 Jun 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799536; cv=fail; b=nth1oB52oo7TszZ6RC8b8ILte7oLJeynm9wewfrqZY53zAuOh9WSxGwg+/HEQuN5VIvMR6GY7yBcK1KySk5nFiJ62YFTRj3iMQn3n4vcreZYDF2m977pMooze4jdaKbG2vY2IhvZXJqA92HRQj1DincX5GvHsTBceQSJyuevqWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799536; c=relaxed/simple;
	bh=7sy5uM/+tq1tUCf8BUbE05yWOjIkHaHiDJJH+xyQghY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfB1HAgJK3tJuhHW9IXlNBlLNJkJihpNr260xBFc/iFGQFp5SOaWD/2IAR69SZE0snmZoefbyAQZwSSb7DUF2iI4OAHfNmgMXC2cTYhoyWc1de9J8TP/IN2vF3TaXvx+CVYSUQBFO6qZYjbuDFqN5VVrkKnIVN9mTIEheWQp5Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EHg4ZkfO; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EHg4ZkfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e91vZ9xamFHK9grcGnN5pHkyq0Qu17FL/pERm0cWTW2NwnPEiMyjFoFccrWTmV5fyVNJnFFYbcqI7ATMUHnq9kILVenZy2DqwnileZiEBDPjWnhNp0MupyDyIVV75poidK1iOW/z9L4+qJXIp8edATAnSpEiH5GhwvVwh9fnevMQfBys6l3JFvEmd01VZk8KnkkR3rctFOBL/fc0eJzNXY6y8GbPaGBV1T3odrrfZ+LSTCOKn7LR5PTZJLPqxd/isDDw96lcjVbz79BMLYOKUdLUZEJD4j1gHbPVDZTHZwfTh6AuLnfaBZPhg9Kt1F0PtBzIIsMz12kNzjoyp7zVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oajobPAKGD/EcmSRi8KrTcEI4344HCEOy2jQTmOX+OQ=;
 b=P3tz5D4inzCtxfhNwDnnvpz3M21X+1HqreDQacHU4s3xIHhp4/DlgoPQzwwsbmvmiUKNGW9pQDtFRRNH+hrfgnCIx3As+mDDysTx1e2KySIHMkNOuk6u/Ea2uPZZe0Tiw49WZLfOVT9igW82xhSJkVcm4B6aDwmlpdWAMtW9ih/xJaW9G2Kbrqt9xKLyJhtW3Y66GD3jaeRPOO17nLlEFLTcD0Lgee4mW9RrSvU6NMpxDc9MiLbkkSazkADoj80HjtyX4nsvWX6YkXURjGf/T6EDgp1et+z9EEr11z27EOk74O+P2fpfd5PYf3VMdeRkzgrZ8Emg46fmGA8WfWIhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oajobPAKGD/EcmSRi8KrTcEI4344HCEOy2jQTmOX+OQ=;
 b=EHg4ZkfOdE2FB47kdsNbDEOW6AIk6LJNNUC6F8hd1RUc4xnN0Z6cN7YrO4xX59TW8agjyGQ72yBYVuvfYeskk/W+8C2obTbAG3wuTX7H8XxB42+eJUbG+RTI321C0INMjXk8AL5vQjL6FzNYD0aRybo3y+k5uTlftzYEz7SCmZGAZjpNwg8lEvlBc5tiK9FNRxziCqq554bFz4n0mOtZJo0rSV2O1etjaG8ODFNpV3ABjbWCQm8X2a3yPzJTZVNrc2J3juPWooEQ2XaBn0lgUcGyxVkSsXvcQ8J8PwFxhMU7jZj+RQnOIEyBj62tjmUZ8mYi7GxaIlz2nPLVhIRIAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:05:31 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:05:31 +0000
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
Subject: [PATCH V4 6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
Date: Tue, 30 Jun 2026 14:07:09 +0800
Message-ID: <20260630060710.3294811-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::15) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: aedb1b54-5d27-4ccd-b3ed-08ded66d9747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	NeWbWLc6zwaszqiA9BzDAt37GLpuzn6u6mPezBn9u2EMBY1aV0WgNWsdQHFhXM1/gkBBOXfs4qyQT+v/MSLV8wRkL2UWR5l0lhPTjaH7+ikXbsah/wbm+hhM4D+NkKB0SinD4BiKl7aHkGNxJ/ct22/PStmBpgw03qXzWr8V5CHTohAEUW4XHMSs04ugJa1dU4Te1rHsAlJ6uk32bn/b6Gt+k0VaUSuTScigxQgA7HRYOPUZ3imFykYWabbVCPTRcp1qDp8h+DDVwoGY2amqSrA1BNhM7uuMcv3SBxzfVGPE/592eb4+3crR//PRLmjc5QovLGCYeqDGsQvZm/eQdZ4Y9JzZdq5H5RM29kQflnFtBdvjjhZIWGh6l3mRmZYpA0y875KxcDeRHpWq8hXVqugKbTa1ExS6+s7W1P4O/1T51g8epsGjbvi2e62My1bGTPgEcEt2LA61ZUKqSrT6h6i0vB/vQNXHIUnnhOHxXSV4/zP5/TjdBMNfZUW+chDKXIZKmckBG+mVT/NX5OTl47NK8+OgKdq/TssoFAnsZxghZoihUlO+Nwzvgl8VNV8Fp4Akr6NFB/zzYVFAJiAmBIo+c6sHZdEeXKc0jMe8g84Q/8wMbJDTPqCmtzAwqkzpOe3i+UgluYLejQoUPsFB5zTw6ubnUPm0jaWyOvxk3xRDI4yku2iVo8CSDnRBG4CexkwzEK2w85JnpNXV9jltfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z63035vMDQGB6y1+aVDqH5GKD2te4djI+3B0yUzTFIG+5ZaBfihuyfHDT9Ty?=
 =?us-ascii?Q?f8+x9cv+67xHlV4i8kXA3ymcLoEQ6H6R1oyoUec3Q6oq/BeJDilEjGAc3JuT?=
 =?us-ascii?Q?RYe5v6snxZJSwQx00HRjQGGRgt+fOfyOgJZyC6PCnGDrBXcnr1ySZEDCw4eE?=
 =?us-ascii?Q?tLNLSkKwt3HTxlMMrUfvTccsXoHCBbj8lqYzaOb+DHp0ZvtVUTs1ZzYzOGmt?=
 =?us-ascii?Q?kR15YkUbOdYryb/lQ6LQPCT8fUJ60DoY1R8CFJufZWtYzcUvjJCCYesBcowS?=
 =?us-ascii?Q?nvMbI9evEj0qm3Bk7quoIG2d+wO/HWDhUcdnT4a1HUjkawgYTxsqfjRq/z7W?=
 =?us-ascii?Q?sngLHjuxXXjqR14y4QWLp97ryldhwAx94690Pb2xEzCtSBRJ2Q6Wo2ATrVY7?=
 =?us-ascii?Q?xGWEII3iAMHWSEVW2otrzorHjbWomc/dcR4L/IhP4SP/hhDIHYXntBe1oAn9?=
 =?us-ascii?Q?j3sE+dKl8lpypcMijHai5GoF/KzuPcKqlwc4rIZSe0Nu4+n0rXJLWkgSPK4/?=
 =?us-ascii?Q?3KZqk88fUagzwM8NHelh+brYJijY0Tgxh2nUbeIXb8oqiG4H/5jgPcPf/Oyf?=
 =?us-ascii?Q?zJYIs8lCPjAK6+U73OjCEvOmAk8geq+MyymwhmkH7KXYdj251lN6wGW2gADE?=
 =?us-ascii?Q?zdk6lUCXr1u++bhXag/5N9kFWmi8hkzFXR/jvQTcqEBWAeGzJ1p31FCvaX1a?=
 =?us-ascii?Q?u7uW375N5whWnmAckpYCNkaVB8A1iPGu/YnqTTZCgFPBST32beLESWpQFsGL?=
 =?us-ascii?Q?1ZUIt9A3IV0yMtZr8UJg7XdL2Z+yozsstP4XQYFaL8nhuzMCAsxhUJT+56zu?=
 =?us-ascii?Q?d+f/mOoau9ztQShe4nMQJJeCOQPMUK5UvCpF1/aXMeACiFL4yVmKMh/WR4dp?=
 =?us-ascii?Q?WggR1OFMRksDQgbSXexN2wF5FwPmEWN2uYAz882VHIuUftH1VPf6zklDmRPH?=
 =?us-ascii?Q?IvkHE9vSHwHxbPigf33EEBxwnpcy7BpROySp6zq50+QstLMMwmNVDMlnLX+O?=
 =?us-ascii?Q?S2wgCV1ag6kTr6wMADiQfTWJ6OjkHLuUzT+/SsuNv9/BvAPqv0EeKgJmwFx5?=
 =?us-ascii?Q?5WeZrpqbkRZtTlZBCNpfrcnEA5nt60eeqEiA+Y986OEVZ3uNWqAwkbMvdRuL?=
 =?us-ascii?Q?C1T0iu/lHNh3CMIWJ4QJos4wx6QugERAYwPq5QImtj7ijFiPiRoHcINah9ph?=
 =?us-ascii?Q?/FOoHZ/h8dAyWD8PxXfR6OImon10JL1Cw2SpdkHqVp91DKAsLFoU0l/+JTOn?=
 =?us-ascii?Q?0TdiaxeknCIX8GOMjAFVuL4CmP8LDBEUOqIeQVpCKnqQzCmEBUqzkjcp2pbt?=
 =?us-ascii?Q?DjzWyP6gYRN9uzPfKjb43n5St/6En5c+T2GlQMncONIAzBwfbzhWDHxnuUbP?=
 =?us-ascii?Q?gepk88hqhFQSzFXdcAqwLuE0xP22M5ZmQDVu13knc9tnHIJBISiC8EHTY0fd?=
 =?us-ascii?Q?fOPS3xIsRBVw5Mv3SHpqw5BHZDSLGutYb6uoXolAX50fwXBAmFXT5Qo8bZ0A?=
 =?us-ascii?Q?ofgOwXiEqo8SkUYimIakJHteTsru/5ANjyfFlCJypyazYgBnxn+q0ThjyKjZ?=
 =?us-ascii?Q?cC/1z4P4uGD6w1Wx6Ru+uKtSJ47m/qMM9L1n6cz773Fkdjwcs14WJumm7LIM?=
 =?us-ascii?Q?3CWxE7JovlWgR2BIn/NIWhT15HVdO+ic1aqUJL5dkgRjOdmqsFBifWcf09NK?=
 =?us-ascii?Q?iLN5YpGLcUlqxoYxZOyLwrhO3yjIRwHcZDoqM1/sxyxf8gcUsF71SZpsKmmd?=
 =?us-ascii?Q?AjPqNwPq9OJxbFHDi/1vzhDnW2QzQyauVYkrKS5UTZ5/4VxgvLNY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedb1b54-5d27-4ccd-b3ed-08ded66d9747
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:05:31.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yijT1g/1tKngbVG8xTFQL6fkhO8Ok3hd0s0xH4ki7IP6QsFA65ikCkL2wrkEGQMNCMF9mpdhpAgKeabygUPFBtzyENxiknudEukuXZLYYnOK0YGjW5TbtWXq2B6h971Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply properties from the PCIe controller nodes to the
Root Port child nodes to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 78e8d41e6791..59d9fe687aaf 100644
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
+	vpcie3v3-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &sai0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index f706c86137c0..d23313bd547c 100644
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
+	vpcie3v3-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 };
 
 &pcieb {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 2af32eca612a..5ec4082bd43e 100644
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
+	vpcie3v3-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &scu_key {
-- 
2.50.1

