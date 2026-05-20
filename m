Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E8319601;
	Wed, 20 May 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266903; cv=fail; b=I77snJ/HorQrQP0ZF6wZTb0ThJDUlboyLvN9O6MNoPlAc6v3vq8ooTG1a/ZQGmtIzyHMcuJ0+St7ZR+zqZtaQNXqcGlQsyjEhuO02h1mroUkd/p1gi2nvRwdF0HaLiO9rqVZcGFGF/bB8NOLAIvJhHEVAapALPb3ydmefiyhnQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266903; c=relaxed/simple;
	bh=7pHl+XcetNatRIEG3PlU2leAhriXFRyXDCc0oSGOvYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZWOMxG+Gg/l40Tgtmt/nzt/BynVFZENmR0/ubEysn+HQ3YUVmK89E/iby0d4y0AU/fYbYps1i6pA6b0DxSSr6S6Z+v14immq86VNZkRr90MOJPgo6dRqT+quLAZyTT6eIo01wKX7+irS5doZMHD1jfusawrz9jlVY1Szl9307c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BFmbhUYj; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BFmbhUYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiFV2Zg5/YDVNiDMBn2VIwQviFYS2U3dOs4iWxN5GumWT6KXBwwdBqSC8JKLQAamqlsk3OSW547yuQPSgrEMfNW7bwZPzPUlDEoVLSSj6RSF48xzOZs0NHuKM0a/kLIk75mXtQrVPdQX+cAmX8nLK2SJLjt3DtdqnXbjKLNyW7v1tlajrYRAZn9BX6ZhOSRPPKMzsx5nQKTcIuUe1gbqU41eGeNrXP6yA1Y8RlMB6/RCDdgWaIGei8X6eFp6RBkLPTk9+nkA5Eq1KT4pcmQNseztLSqVrUBuHLUVGzpEvHoZES608MzmNpvyQBVoNmDyBFM4F2JI1tPu75FvrseeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfd+t/VDfW0CTViOEI8E6HH1Ron2HFKCeV05pH+LYvA=;
 b=g55hIR3ZRheHckVwVdraBQYEghjeehlZt8pEkQcy9T8L87mr4M7td6RyUGgTSGmFxQD9VOFaJJjsmekeNsWEODK1uan9DyzV+PVSRPt6BGkXsgvr72xctjW3HpzF+oFIYBDMRfkQPkUqPVE0DsSNasTM7TjGas8jBUCLzgbRFnocvG4qgBZlwOvW7iObtTEBPqS6Y1gAmb+c24e5w4+W+QRm66RhY7I619nYiO0FQb8xXqohvu5S30m4PvRnItzXPwblBqi92e0DOZacfFXl5Oe9dgMT/vKYjmLA0Esxc9exzrFPAS3k/coF3w/Mn1qwjGLpZCsIkksGn0c3//CH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfd+t/VDfW0CTViOEI8E6HH1Ron2HFKCeV05pH+LYvA=;
 b=BFmbhUYjCo447FPSeSLojgaN5gthSZpJynn41ESj6az13iJBRjIsNo0e61fenaZnIk8srTqUHsn16qa5meYBURave7fcWzK8NiwxOSReQrDehNFC00Bk79dwBW6OUWkvulX2ytxZm+YjGaElCgXpYNumhINLz6S5anhfIj8++qFddIiMIVUMkBam0HphcntEYhtyG65+/TOYKwzGmHW0SlojOBAzDvOisZp0gBLWexwjtl4iog4M1eQHHnXvpRv2t+1MIehAEuQS465QcQJExDW+g8YDI1vfLqopxbYtBx5ScKhBX2n5Tu06ZvskOE+K7gM5iakGBOaIf4alU4gOuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by BESPR04MB12564.eurprd04.prod.outlook.com (2603:10a6:b10:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:48:19 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:48:19 +0000
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
Subject: [PATCH V3 8/8] arm64: dts: imx95: Move power supply properties to Root Port node
Date: Wed, 20 May 2026 16:49:04 +0800
Message-Id: <20260520084904.2424253-9-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|BESPR04MB12564:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0cfb23-a472-4f9d-8ed5-08deb64c8a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	3XUHzfVHgFfNW2Vrkdida8KbHnYkC9d/Ts6SH8wSnOQc2KU3p108Ok8etP38hGawEkxAkHWzM7xIbkFc8q+H8amTiAchsSHL5Y39Nnon8C6I++i8DeG2amtH7rGlPOjK9UsnOFRttoLRXkFk1uLZllPVgmpKHlWW++YSiUXIgqN9qvA/G4foiZ4XsEmrpHbPiKSC8yiXegeroPxyDzfiUzSunqnQ2Gh2tJcwoPMXN086Z9g5H7YRb39jIz2UU0QMEy1UDEnD97NUUedRx8HXGlPGKuEQ0VZ/hXeUnDlzB3QkRbu4+B7YbrHg+jSpNb/x3/aChWr/JpXaoDT93FRLTXQT36FN/EKMMVP7jB/PtB60SfBNi7iwhFkIavFPhT25ZBr3LNDrmG6mRroNjFCb0QU7wOVJgFAUGEBQBTPfpQERYF2QzxQAYiybi7cev0aHItu2/txrPyVTgTMX+IdPh8jVeVVxTbHuNGLP2CL03BhMkFE0H7x1FF1fYxzAc1oqL0t63FCkTnS72fNm3KjP2Z4fkZp55uVWBjh+Eh/dQJQs414PGMamL2Nd9j8wjr+I71uXVVx77a9ECvmFEsxpOCmMssOlxsbooOdmGxAG2/cIbpFzeLsHeUQv26K0L7GzlnNKTa8uOX076UrJSb5wAu03R6DUXZO690OZqqN9WOz1z0Gg/Rr1GUxLetk3jwFxs18Yqv+nNnOfSdAkTyeLG+HFIt/iDFMX4JNm3djOPn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zdgQ/2sUXh6e+ZlLOPrqAJtukV2Gzvlvaq73+r7tKrkagJs4KrOstyOUtoYj?=
 =?us-ascii?Q?i3yXRT0X9ePyhpHGyTJd4ABDVuHMyQ3wXeb8r262LTZZcS+UgdSawZbR7IJF?=
 =?us-ascii?Q?jhHw4aFgD2Nkp5ZfhJdW3F9xanbBmnISWMUGVow2cuVg7tucLN21UlWoZN3L?=
 =?us-ascii?Q?91PLEH4wXEC+jzW1h7AhevTnclYYL8lhQOkj2kw109v7cxKKEVxlfKY72rBZ?=
 =?us-ascii?Q?5JqDBDXQX2Bbp//clk3CtPoOBgQz3aspECmcfIR1tqdNi6y61vTx+l0FJjbD?=
 =?us-ascii?Q?oZwOQoxJNbMriVQElZCmZSpyJoDRtTLl8bZyVXuEAV6zxSRBHsOikh7+yMnY?=
 =?us-ascii?Q?0ridQeWyKnQfZCsxzuZsekaK4blxDUydpqdCHBztQoFcvScZ7GG5Qr4+ek+u?=
 =?us-ascii?Q?s3MDiUioFd3KF9b8Jug6DR2b2F9OxmyVCd+yfFkgsZTEJjTIY0DJULmcV+8T?=
 =?us-ascii?Q?eUunQMX4LwehhhMQ+i2ue0oxj5mYAA2MwEnAA4g3LZBzLxFRAWxD0ojMFQ/d?=
 =?us-ascii?Q?GSW27iPKZt6xtbU/2OrTJ1rk6c56l9eLhE3uB42vlEvUMKiRmt2wXBQfrEui?=
 =?us-ascii?Q?5GZS0EvW4atlbAqEUkEX99WIzcVPN2yVeJQGtYwHOiLVfOT3SUUqAPXYpQEX?=
 =?us-ascii?Q?2RSqOj9eIpn4kTlyJ3mS+Tk22Zd7FLXGamZS89LlQAkEinKVFnJJwjfMvj+2?=
 =?us-ascii?Q?eWD8sPH1fdBB3/gbicajKsJCcJHO054Wunhhui3iwrvlJyIJbmd2ydAfkqYr?=
 =?us-ascii?Q?bWN3iP6igvAvV/gmrep4D8YCT7lDQwO7KXdA/MCkqk93SJ/Cut3FmbQHERok?=
 =?us-ascii?Q?Z9eRnu+wigIxhBGCsZpEDYPCuUPCJUKjK0yzFJeJD2BrywWmGft8IdQcfSS9?=
 =?us-ascii?Q?wI8Zh+IJyzg4kk7YuGeWjrRrO3KTmtNmptlDle1mrD48OjR4kIJeocWso2a6?=
 =?us-ascii?Q?ljjugWgth2juofxXZ+fK61K1XjTnO3o7AFHNapPNjVPUbSPkFg3EPnlpF2zK?=
 =?us-ascii?Q?M6o4//xZkL0sU2UDODzXYAUIbEnl2lrt1bB1ktrE0sA2EoBmtjWSC9HctKT+?=
 =?us-ascii?Q?Xv3g4xAAsp9v4bKl+uezQ2Ly+lpCMhSmdr83k91qRGV//wNIDj5A16uW3fAm?=
 =?us-ascii?Q?WFpJkmeg19Azaw3e5ZB+g0Xnogy4AelPjLSnf8ZmQjD3itFZdkIMC1G1Wc0n?=
 =?us-ascii?Q?DBuTr+6xuta7qIrGAXqyXFXpRNQ5NBwKnYmEWf4bwmKXaaD8HRrWerdCvGc4?=
 =?us-ascii?Q?tZ7ZHRhfkIOojBM4YkpGo27uNxbbmxrl7qpWtwQy/9fDbMPxGpLg5akY3U3J?=
 =?us-ascii?Q?kSzXXhrvrlvAR/yk+gU/GLc6H8e0PRcxySLrs6MxW5c30JS3U5cbHHTaSN8V?=
 =?us-ascii?Q?bo5WYJ82NAmBmb3LxVdvHHOKaoiAgIr4O91+r0dmfaBGtJU5nmXsN34K1Z9/?=
 =?us-ascii?Q?7yRH05KlgnJ+0KCuiEXzgqsQw5tKlQQQZQoMD6BBiymL0fZqZgv+Qg8Z6KVT?=
 =?us-ascii?Q?f1A5qmM+rZ+8tY8dHey62z6WFFWGiJle7mpNNujVq6nN3J6S5jJjiu/Hl9lU?=
 =?us-ascii?Q?lq0kD4AbezZeDpKYn5T9OSfEmkmyczleTicrSSQwC5ZeAR0fc2IlkUTW6eKK?=
 =?us-ascii?Q?qFrkSbxVBaJDkpZZvsxQQW64rftfaZIRIMxUrwWOCJvZm7JkPYNandjkNQn7?=
 =?us-ascii?Q?Zm38JGW2WU4/a93HFpSb8uWC928+Bls1k7mdjIlBlCXW7N8jdBNLeU52XQp4?=
 =?us-ascii?Q?bHbvLzob+V0cwpbJe6tfbaXAwPle10KtzBIcR3DJSRFppexx3W9H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0cfb23-a472-4f9d-8ed5-08deb64c8a6e
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:48:19.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3w2FFd8bgCdk+lC/QX18jarQH6vQOK9L/lPGB24t8oyLrCbpm7SVSuKqG1rv9OivvX9Gk2AkF+61Pz91x4rqNO4vRqIOFwfVkxlJzj/wa+bbJTHVl30WpLOA2RyZBbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12564

From: Sherry Sun <sherry.sun@nxp.com>

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller nodes to the Root Port child nodes to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 7d820a0f80b2..0d1cdfd54cce 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -555,8 +555,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_m2_pwr>;
-	vpcie3v3aux-supply = <&reg_m2_pwr>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -570,6 +568,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_m2_pwr>;
+	vpcie3v3aux-supply = <&reg_m2_pwr>;
 };
 
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2e463bc7c601..c08731dfb1ee 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -542,8 +542,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -557,6 +555,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pcie1 {
@@ -564,8 +564,6 @@ &pcie1 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_slot_pwr>;
-	vpcie3v3aux-supply = <&reg_slot_pwr>;
 	status = "okay";
 };
 
@@ -578,6 +576,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
 };
 
 &sai1 {
-- 
2.37.1

