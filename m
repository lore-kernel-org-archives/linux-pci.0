Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A940BCA1;
	Wed,  1 Jul 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903070; cv=fail; b=OEmWEIhmZ384NzVO4MheUmvXryyY38l38ZDUwjEvavbCMr9qxFT7GdFRpm+YFVzwC6mVYVdjE/7wYcn+bVG+4p3xCnsenPzMo2JmB3ifsxD9SnZvHGtoGSfeXITb4PtdE8n3FKaQS8lRvBYHNaATEXrQ6a8grq/5HzOB41nbVHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903070; c=relaxed/simple;
	bh=p+L9xnH/7AhTs2clm0hFOFJ5wa9A/GzHBJhssCNJpzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkgZ5hcrn9RHAJ36gzG6VOFBUQTAHMEuB2nDjBcK5pDv2EBWW8f6LegfnSmsmp1o9XUD9WWKyuJY3SrVDbHJJbkIU03Lm1eSozFUK3iVGbytxrO5DE1hhaLglSotqLJO2zLsbGPGuBIJenK1lpReWMzCyQRSBKSn3+oLohZydxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PiNdpouf; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PiNdpouf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erbxqvbj8UzMSP236NAtudKDBxHw1vrvrEBpqFc/8IepcJtWNvK5f/P+sAsYXzGXHuJ529XaaukWn3NkCRD4ZOjsMh/l8HVK5oIIGKltg7i1BxZNNg63QXpKRKXctUOADqXpVHYGfzZkm0aPo7e4eV83JE2HhbquY6NB/FHCKBctjhxRR8y8CoxrTifR3njYpOJRT96nRnLbVq42BEwgcVwcPlKO2X9qGCh7P0kXj05IVi4SRM82ult6/pi5r7mjXodc6CI1avAWBi0LjlUA06jcbeFmTSEt1abQsZCZUJgM+aXrlQN2CzOh3rjrYdRF96XykbiFjbapSZtm9j2ySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcwX+uRQu7WwRif+b7aZ+Kwy8TlCCa3VJct36Aj18BE=;
 b=ms9AE6z3ShI6VKEdrj7DrvUPN2gCKKNRtMOOMryWxI3VlQE0HjLE1cBboFBZvtBwFemiU4uqIzrM4PpzcOm/2OQoXFxDPWYqOUx6sM8XXKmYSNGWFt3JNM0Yu5EiGC/hL4paAVHiOi8XZKxIg9SsTIi/NJanLpw/IwOkmlSTs6KPuF/dJqQ32AKBMtkGy34Es9XdV2prBQZoJaz/XvRbBeh01zT4srgxPDumIqoe5aM6hKZZWoo1yb63hldfc2hvMZRLIuOzdCwTKB8fYS3zlibJSRwRXPxhxxQKeI6V0H7sbRVR83chBy+EsLcG4HSP3Wf0Jdrh3g9Km2PRYENb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcwX+uRQu7WwRif+b7aZ+Kwy8TlCCa3VJct36Aj18BE=;
 b=PiNdpoufXbv1fLmhJam3akKxjlHKMaoz/DKcq3JD2426SdRxD0I0kbZNMkwpyUHhuQGyhW2kQ0kZSuS7okcttG/1xxhxwr5enP4OGkFuLTHf3wmmiNaog9Nbclr6gI5SNOOPSrp2R/knlPPxjpYWESLINdmUnI30MUShuJfOuK7mAP16D87cUUT6kEgnAhTSpwC+JGsFnhZE8HL46fs/POe1YSfVJL6QLx2j9W/5rRpZarLt/LNn4GpwssDnUK09cxyxbFBB3Sk4Fm72KA80cZHNX7sWyfxz1ZKXiCcQ2ek7douT6OSHIW/YhtXO/HlYfQxaVOR8uPyjPrZD8fxITg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:51:03 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:51:03 +0000
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
Subject: [PATCH V5 4/7] arm64: dts: imx8mp-evk: Add power supply properties to Root Port node
Date: Wed,  1 Jul 2026 18:52:31 +0800
Message-ID: <20260701105234.198987-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:295::15) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: a9954560-e5dd-4bfc-a91c-08ded75ea534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a8BRNRlIcHk0vHikPm5rMQqQ5rP41Mtp8ZEElPUJA7jHBMjMp0DEaFKL6Tm3CNx3a0nIEBKs3Sx+MHrRL5yFrbNEQemkHEIFY2EjBiuwFMqUVPZNszSzZKG2dDvH139MJwnX6gfIwqC20Ei+Z6dBw+TNtIGH0xrRBxQJqBaY4knMk1X5NYLco+gOaKkra/ipHkEB46MbpOmwQvMwEMWb/7OEAJI8XnjTIo+q5g8SQI2oKyBsfm385R4Pa9mJEG2gwt/ttoEczBBNrmh4QWeMeooO/0LYFXLleqb/QLklK7rhf2Hk35UKjHEthCS3VHnvrjXnVaBBGpF7CEngVOzaS9u5+v7wuSBZGmv/yd+NiwsPRWn+W2sjesiCqvBJ4FFlknYEwjvX0cz7woaHDiYiVGx53g2wHEFVcNFbnCF6AK/JFq3CaKALMV6G0o4CBa49OWSHYugXlV1+yue8uSJREHNGY4zU2KjWsYXa9rV+B+bfvVa8hZ1kbyyKo71SMx1n1EE/e3UuijJoHniaX1nUT11vOabM80vw5UdIBihaNcQ3XIga7I/EyElhtYRxUmS6CncN+y2uj4mzeU5U/8Y+0dDtGsKvevngpd6YwkT6e5NTEimoOtFnpH52KqKaXnF3BDlIux7Yyp6BNFb+C3hHT20d6lAMukM5bbH1y6ZKm+kXpV6eLLkw9/25AnN/KDOxA0rP1Eb9Ku4khXtzDFL6ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lZIH79UoC0mzRi7taT7HvvwZbWcZwUujSB7ea6to98axEP0KsMeXPPiMgVH?=
 =?us-ascii?Q?r2ZoWDL1FNURFhmBqAO8vLo5MtTBwzVR1nPdDNGI63UJQhkmV2ZW+Ava7JU0?=
 =?us-ascii?Q?09bSVAbkKN7cQjUUsbCkdiCFfBSAy9OjUCaZ1sTUohON030pbwCrx8v8hhJN?=
 =?us-ascii?Q?QJrRabefQvdo0dsX0ZT9JhI9Il/7dwX4KH0jss5ASNZ0mIs4+J2rsPNgUNaT?=
 =?us-ascii?Q?ACE4Z41YzBO3w3FDAYIx9mcncSxLj03YfjlWqcU+kiUtj9pONBYG08ObbKJj?=
 =?us-ascii?Q?pmDN0EUkvKJo2uIgnvOEJKOLa11d2QA3uMfwKPmp0wIOO/BMUH7ZuJxZYLQE?=
 =?us-ascii?Q?P2+ZmERpYRV2x/BQFQWTk9mCXrWAolkYSu8s4cybIHEIOAQtLA9As6RdRKqq?=
 =?us-ascii?Q?JTqR8rxlLglhGgFZkQ0pHA5FAsE5Vl7EWO99JIiRP50FtL4waM4VyGAGaW8/?=
 =?us-ascii?Q?9NIL/XNHHPjCBfuMCjvag39ZVumvUp6iSgmDgpZoPvqR4iqzn4oduLj8dAba?=
 =?us-ascii?Q?LcUWFEzRLTf3r4vof5yP0Yv85sAs7V0Go6RRqy3/2FU2Iu9nUVLXp58xRuLI?=
 =?us-ascii?Q?a7DN8sEJPZnHapJX3WAvOOS/45R7V8J9LigVnOs7LW8B4WlrKPwdiSoGJaJh?=
 =?us-ascii?Q?HsKLdzU4BLZm6fBJCi5V9x3T0xl3WHY9QVYyYjSjH6wAktxw9d4C41AqKDQ2?=
 =?us-ascii?Q?peJii0tibD29L/6bC/LJSn3D6l7vYAkGoIvrQhOE5/Q9Ri9YnxSP+7cphkr4?=
 =?us-ascii?Q?xPnER9BTwwQK3imiAZ8v+2uETeTOH8W4oV74sT5YgdVirFY/rLUa2AHAMBh5?=
 =?us-ascii?Q?8iX7H/FSH2uUkE9H7PSqCrTC8f1ObWpFVT+lLXtOeirYf1iqHlAgPUmy2Yr5?=
 =?us-ascii?Q?7u31tgjONYzKr1lvE17TQOfpuYVdKs+GPt6zd9G8hWg/xowf/YECmhITmUjC?=
 =?us-ascii?Q?oUKcKJINQGR5LzKsyPwbYJzAtKZ8gCi86b/Y9/36aHesJiTgG6J0KOCTWG6q?=
 =?us-ascii?Q?pCz9kVjf/VaYnK72Y43CKJEWsqlKRMWvMkzDesv0nWNjz7Wfy4HzQIJugHzc?=
 =?us-ascii?Q?vAHt9N1ceT9/7LinzWyjFuUPsTbq3Nx7p1kbn6igHpSKdltDwc2aXEpBDdvf?=
 =?us-ascii?Q?fQpz5cMn4MMaEdhn+Y4kjUAc7vdWCetlpCWq4ExKzGnWCTwAAULlMpVia2PD?=
 =?us-ascii?Q?XEFcZ4xiAhnOSE5zXLPMLFDeEbVH5mdku7BoqPF5/k8UCaVBUJE4Ws6CLZcC?=
 =?us-ascii?Q?x3NM+ayKzfV2OT19X9psQ1Pp2KMTgYv8tSnyAkiuT5S+qbQv7UzkWJRtAw0V?=
 =?us-ascii?Q?W8MT20u0SQjDtsaog3T6YTbcIYd+6e/Zlk3tLPFrNyx0onI0kBErj2K1rchQ?=
 =?us-ascii?Q?CLNtl2MtipNc3TPmcjubWgkjPb/7nDHQ2+S//4+w4UJcGyAKlzDe5+/VIsCs?=
 =?us-ascii?Q?6/1xB/T9axfoLio7ICZuYHf7rFYKkPE5hOTqgYCUkfZAtJw5GLZTdGqL5HPh?=
 =?us-ascii?Q?eAjq3j2Nv8MTsbBLeOfl99E5WqzrDhC2nV4bPQ82meGf2yRfaTjQTr2puB7K?=
 =?us-ascii?Q?mRtOepLCLr2tuX/vC70DEa9yA5AcTWc1tZ97CYaFMsY8j/ctsa/Sbefn7lIq?=
 =?us-ascii?Q?aYMEYHJl4tIXSRY67BeHOYQNbq423zttjoClb6EVr6mV+AkLxDTicL0pwn2J?=
 =?us-ascii?Q?I4Stg9A53uIJf2Q6oX0/OZ41XXoegOTXU2B/lbfuk8Fmv9kGh258dIFL1JLg?=
 =?us-ascii?Q?vT1D/hjE2H4QJmgb3wTPRQO3DCRzPp44NMyyZf+Pr+CwAoSlSvQt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9954560-e5dd-4bfc-a91c-08ded75ea534
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:51:03.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brKn2OWCLGZzytQlLvatY3KSGyTiF10Pk5Wa5/zfxNqIUHask6V3sP9osdQuysdT5Hfinldy1NgxUFHKfCUhylHgumOJmMb+Dh1vXMxuOiNVS621hlpxn47Cfzdigfnl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

From: Sherry Sun <sherry.sun@nxp.com>

Add the power supply properties to the Root Port child nodes to support
the new PCI pwrctrl framework.

Legacy power supply properties are retained for backward compatibility
with existing kernels. New device trees should specify power supplies at
the Root Port level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a7f3acdc36d1..ca09a929ba0a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -772,6 +772,7 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
@@ -786,6 +787,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pwm1 {
-- 
2.50.1

