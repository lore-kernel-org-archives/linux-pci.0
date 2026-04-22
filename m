Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A326AE5;
	Wed, 22 Apr 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850516; cv=fail; b=VMA/GQ3Zo+BRhrxY5bU3X43Mi1AGwcdKWi9QYy9UKV7WHgsKG22CjPZTXHnO+zjXpe7emWiV1hg4OXvBARaBDpbUqSI1KYr6ZZ8+FjFmRL6xzpvM8mMxyV81JoFiExFcYyYdeNldQtapyDjArUreoY/JpxSjujtCF9D/v2dppFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850516; c=relaxed/simple;
	bh=xzPgWC3CfkAwVk6V3+XedDsGclq2F+T1PYkPZp8gzu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCFN1upMyx5Q7RPTM4DBS+vHbmGeun7PYdrD12hwvhfsSwBvSQnUjI3hafV0Qg46CF9skFOEXMQbyIABPyRxhp57//CK2xOrvLJq0lqxry2ZS8s3566B7m4lf1JYqdBrNKLeg4LTicJqXRo+CqS3zSFCIIiv/SlBZr62FA79cd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SjbttSwu; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SjbttSwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNH9GdXqyycGo6JfHk0FljAUJmbTtue9Rec/IUV+4Y4mwW5EC3MM00ZCYAiulcdqK+uHf9w0pdNHkk3KmUIMUJmwQbRWHiS+V+ooFlicpALW0QK9/mT2LLpnZvlwf5EJaxmYJFuK7P/vGNbGcaf5OohZJsNs3bXTYpKfICY91FUGVmRa1B0EcVdKE25DyZW0TEcixHJH6c+xCATJ5JCUMehpX9BpTJJUqenM0jDh2Fttp/i98vM0IIVYMpXXgD6dEVEdcaX+zCoMhH/uUYk1HW1K7Mwvf61FyUEYOYH0krcDy8gigWEdgaVEHZGuNfYq0GDzr5xaxzR2K824aoKjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=tLWVLKQhO0/bxZUQsg9qtjzb0khmKvJDpDKG79JYhsY1sHNzPmyovTMXxXjllZ5u/uVkgj8l4buaL69q6xN48hWu+m2EJ4O3GgG0Y9wwZwLYlKqQ8HWe+ZdzkyB4ANT1MssNg+bU+w6vTOBoNI/3IaFM9siBkkJN+gmqHF8P6TOaHThEgC8MoBeeL4KTHx+QFe5Ji5thRdBx2Rz2PQ+ICpE0BcneFtqbuPfqGFOSQu8AudJ4QGqpKaLvRXefyitXmwz8wjWGHQCIU2jKZJegMTWZK5VUk0F0/Qe1ZhBjRaiQj6+1+LYwG5Eb4rd6UR+QdSFZldSBoylzkZwWc+vNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=SjbttSwuw5K0pKcjhLuKm1k9u+X/vuA9bzCZayHTzgUJST1z0qPu69cyqtCDIVRLBnnZux7clyYHTf7p6uxArr4mU8WN4HIyidoXWJRDbVHk6zSQwD85C6kLa9uHqBPKv/vrbn95MLNEaFZ80WzmYJnqSWc3ouxojBU+7ZvtWVrYhlzoEKN9NSAHZeoN7D1ZJpe+agIMY1lUOhQIjGmU+sCmw/KcJtrHxKh7pKDdqKETR0FXdXp/A3zBCmr2r2YWRHwFP3IEEi7dmgb5nNpwrC768BDW2IeMobAU7+mu3d2ZkRpOleKyvPTMln0Bf8mCGgZLTbnd4v7H7aNj26RL4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:35:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:35:10 +0000
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
Subject: [PATCH V14 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:46 +0800
Message-Id: <20260422093549.407022-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: 6688c66d-f948-4f72-b6f0-08dea0527254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	wcR/bfuzsYbIpQBichPBuNVevxjgJXFMOX+n+htBn6Qr+eY5B1sweH3/A6VMmsOzxMXY9/fHJRbWH34BmcW6eIntCMIRD82clQNZ4mt9jGoUA5dVV66o2zTaFBU1/Sbep38nRABgdpoyHR7sNBUR+Lpam1YoYK+SN7iGPXnNT5WwoEYs4lcHrQmyNI0GQKVKTFGlj5Bbus3uEQsaGuil+QCFwJysmKpCcOEDzpg2YB++Mgud4+BUNDcriMXc4isO0nItZgu1o0cS8GXj+JxXbYZwQzIDazKYDMEWw+ErWvxVy66rYnSBTCRiye/wjL0Zdm2divTb3ksLSxZAkXOgFqH03LOxR5hiV9OqeGeZh3U1CkQ8ryx7reEy/CZyamdYkLrbRe0ca+1ItTQZj3/cJP75lvvECaOxoTjAR2pEAPYlDMOrJm+yscBJn3iqkh6mV5MLVtbHg1ecoJRMeqo7QQzEcTsvv05V/8kECLOmUtacVU92kBGaBIdO6gL94RD+ADfLqTdNOhIcACC8APuxIi2G7YdK7A5LPBOAfx8QFTGFE9DQXs+oJJ0Czx0Vel+nbRokHpLaTpZ6FqRI1qENATsS51+lpShZqk8XGKBsqpbRdohVqHlRdEhXJOO0LIeF2rJR4aUxfFO1U2pqPPzbGHQ59B/PM3i9XMxtxYRW4jogSL/qaDKpkr4skCz4Xi1948rEj+bHrJ9hejTyMXMzhaEjwQQBeT/vqro+LXo54t9rrgSCb9u2BA3pMrjEqUYhtyvILKX5zjp6TPqTWFT1VhvLqHjV4qXWGQAApROC9/quPOSE+CdN08B1q+2UY1Fl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/m5lt0Shqdu21NhNgW0GxB4aNJmrxFwNcBOqBcdf0ZG0MPa60E3ECjDAYJD?=
 =?us-ascii?Q?5mIlev7PYIpngWzy3dIcTuDbtR8qu6ggXZ7rJEfRmd1/fgC0hRDQgYypcr6P?=
 =?us-ascii?Q?1g0Uw1ii2Noej856Dj+9IUJKjqOl5AOTbOP+TzDx+REGEKTaNUVXUt8aY9qA?=
 =?us-ascii?Q?E+E6BmYpQrJQjMXiQfL7GSoDXjWOq+SYTJXu2xC8K/l+JQvytlpl42gGiGxW?=
 =?us-ascii?Q?/dkUOWUka1a4HZEozxeJJBxD1kVpVOXszcy3bdWxb+TalXGEJlvF0Cxp7RdE?=
 =?us-ascii?Q?3Lb+jbTxAf1nSg642DSnQaZ3N+3c4jlicW/51WuatF9bCOi8myY1OfS0mErO?=
 =?us-ascii?Q?ExsJulExBWMe7nrpBbBKhN2woLBzridBN+oyckqHxLxxs2mgaeCpsLZKN6G4?=
 =?us-ascii?Q?pa+gM+9gUouS/63mHM7VZAkGyUofTmfj/39j+AFMy05ewVCngtHu0syCmlHN?=
 =?us-ascii?Q?OPiEuOH31Er+U4M/dh3aselzqRF2PvbdAc0txtAucv9Mda5JWrWZXsgaph5O?=
 =?us-ascii?Q?dMUva2v3GQpvyg9ALeuijM8G0bKL53hzs9kU1O0lN2MinwoeQRhkG184s4H6?=
 =?us-ascii?Q?JwEmT63ccQJQXfRPbiY8JQzFeJI8IN3vqS/lxPe89V5365JM4qfn8Xfqj5Ol?=
 =?us-ascii?Q?wcskCe+bBrxPd/V0cEoY8J5Le5jhoJrcN6aik8QOwYqXLs3mieFm6NrfQLvw?=
 =?us-ascii?Q?UOSKu4x9hNSzLAtXp4rNfH96jPA6r21tWXdeSOr3m/8X511YS3XhC4eAEvra?=
 =?us-ascii?Q?cXKsKabGjuGzYEmTCqY1Gt5BX04RAIAyn9eVPKritO9vhfP375HgwUNmpfdZ?=
 =?us-ascii?Q?4Xy73+dv4SFTXs4vQJnhSRieTUPBxXIm+0hCl9AoodgA9+by4OUlgYnf9eYf?=
 =?us-ascii?Q?zerVrZtI1qoyVxdJSOAkSQezjmmJmTTCS68ohHk9YlEfHTHfgfpFNcpooSAw?=
 =?us-ascii?Q?u21ZHN9za3pzDpq8hyR7oJjRtzeyQ6Bbw3uh/USalsbeq1SAeM6K1mm1dZJy?=
 =?us-ascii?Q?CnDUyMnU0KElrI/OrON2BGwKlamE9ssXPAA9nr6QwT9zCf8VSSdQWaGRZbWh?=
 =?us-ascii?Q?aL3Pp1RShxhelf5U0Uuhiz8HBJoUFQf7mBVbn95FP9ugJ7TSQa3DSOcspdqR?=
 =?us-ascii?Q?crHM3/gGXDFSDf26778KsgZI6ZcKfYmTtI5qt9drHiuSWRSZFJ417EUfgJN8?=
 =?us-ascii?Q?xhUHPKpKY3ptbbmACFcP98yxxOaWPJYF8A6+ohcvz8xAf3QZvseKwr9X1VMg?=
 =?us-ascii?Q?X5Xp2g3g7BreBj0FlJ7h6h7NQmsHQZAfrfG0iBoeDe3Azi0QE77xspFNMvoT?=
 =?us-ascii?Q?HyrwVrYLdskHbwgyEDwQqLv4hm7kwl7ZL0mTiZi8GVNZ/Wg0mZOtuxKd91nf?=
 =?us-ascii?Q?FinRcoxql5t38JCtrSOXhrsjFoJtwyOj635AqreMzWE9hmRXQK8ymkvbIDEL?=
 =?us-ascii?Q?RLQphj7FFpIKG6UDZMVR5hoLUZkHvtw5uokeJUSdwlx/VOR0o5ymNbiY8bm7?=
 =?us-ascii?Q?oZPhZsYHm8KDfl0dh35aSrADM42ycGRMn5raMWlbFmKRNKPdtejFKt+FMyKb?=
 =?us-ascii?Q?E79QqqF+7MuvWFhYpwWHpEY6O8v6vCzxPa6zWsEUtKmsYDAUu8hFQTNgQ4vb?=
 =?us-ascii?Q?w4M4b6wWQ81uYbZsBlN/4rjcgbs5N5tU+kpRToRFC4XDEFDygFdcuOSi6hDJ?=
 =?us-ascii?Q?yfLNbxED0OU9LeHsbWvY+4Wh0zrQdARBgKg/rfSQ3zbzIO+/XSgzym2IV3F3?=
 =?us-ascii?Q?hHwnQbw+4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6688c66d-f948-4f72-b6f0-08dea0527254
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:35:09.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJd6tl875KE/ygAZxy34H/Cfye1KSa3gptzzy3vbrC6qwh1mE4GkMzsHu8lJ6X7dCrKJi3VM1nOAMsDCGqfhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

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
index 2feb5b18645c..a7f3acdc36d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -770,6 +770,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -783,6 +784,10 @@ &pcie0_ep {
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
index 90d7bb8f5619..5ce2825182fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2265,6 +2265,17 @@ pcie0: pcie: pcie@33800000 {
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

