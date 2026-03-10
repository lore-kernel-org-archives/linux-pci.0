Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73A30E856;
	Tue, 10 Mar 2026 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107661; cv=fail; b=SQnLl5RMsKUCg+33v4CnSsDnv8w+i4Lfv8l3nqPcK8giLfFvAmR4jXJxrG30+mO7VJxJOO6pbls+jt2eFaBKdnIf4ouMPV9cNhLoePZSOrzkqyYXZKQcoxMKzIRsUMIA8/PYqJG6yrDHKHoVFDG4U+4QZ3eD5xxapKYLZxPLdX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107661; c=relaxed/simple;
	bh=g/mzX4X1VcTg/9UXn1FE9QtXpTv3LYjabJPq1eqvhqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjuhPQFm8IECD5BVbspx9ZfiaM1nS0b9yYdMIA5Ig+lfBiqn7YkOem7r3GPY+BSWds6gNSPoxudHnbE+YDK7ifXDLhRuzTKVS78/MtFhhkOozNSKFnY+srS6TM0N9zjy0kOML0PGuHopnwkwoHDGfKwKTnhthqKS3Mj0BVSSk4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LHZwG7GK; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LHZwG7GK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/L+hKIpaB1XHuCqnD6cfh8hD69JHOPwdn/4t+YZZ6hkivag0SAgPR7KSWZe6bGwSY1ZJamPt2r2ybIBDEIM7pDjboUV199s44+4XOepx5UXwskettX1Fmnr9JsUTXqrmAa8oa0ocS4xls9ZZn6BSYYXQLp5AfB1jqhon4gVu8QRAWr9xgF/T4QFLe/ZGLRG2K0d1hjqb40o+xeg+AI9VjtdRYSJ+S+sYRfs+TXq75e47ZnHjvywSFuKwN88BvquFG9pwjkSRIhxb0e2vvvOa2CTmqWlRXnr6ZqxXNC6Na175ddsImenaR5nGtaHO8VI9hfUC4tboIEUkVm2obtXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIIaGc3NQm5K2GQaqJlfdAuQ3HYw6MiTjImMeGcKclU=;
 b=pwvqUtnBkMleF6UtdjXxLNewag055Bqpp0QEftojQQ3aIrDF0oAHt+YsP7PwNYjsiIAFCSYMd0AL/HMxbg0XVeeznnW9hqj2G2hnpJc3OYU4D/W/0srvI3TPg+2yC/lkkULvJSZXMRI/jpQnWnyfwIrqhY3D/95faxnhEN/xSVkdcJJaPlsxJTKCu30DdH8xoDdyM8jSqp+Bpvq4OSMUym/5U4FQOicZCP+hsXN359tKr23qfm2CSlnvR8fTbAf1bUDTgmRc05BcqLNo/5RQWSDRXlPRUVHg6bquwLab5JWqtzdSe8GBDeDTdLtbuLBMVCbLaLsloDjrOqHHe9BSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIIaGc3NQm5K2GQaqJlfdAuQ3HYw6MiTjImMeGcKclU=;
 b=LHZwG7GK3pUkb91Hvyh3qfgM9gCE+2C4TISuds1BTqvXct65xyFg5llwKX7blgd7HBT974rTYVQNT4v3WnZp/Sss2WZpo2al8DMf2wlgD81/f7JcCsUO2lqxCw2NE8+ryLS3Ua6EInKv1hPxa5q6c7bxubSvWtWlKIVY7Oo3KwV7+J5jVpDyDaEDiJ1sTbiP3j2OHVd5otpDa2AtkN8lPdXslBTXm0uC6gSTTV6Wax13Vovfceb6Bg/7iZ2aePYG6T49MIWUv756kNG02rqkwSHEfH1S9PTKMb2R4MUnIrsOGLS/6+fOx2CLO1t6KFuxnDiIECmq+kJyWu2wj7S1CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8434.eurprd04.prod.outlook.com
 (2603:10a6:20b:406::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:54:08 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:54:08 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 10/13] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:23 +0800
Message-Id: <20260310015426.365675-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d7f703-450f-48a9-e528-08de7e47eae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Gt2q/PVSkBd+YrogwFPGAHp8I3cJeahDcRpg+y+rkRVsNhxcRMT/8P+GcND4OKTrbB17NE2uyqLYE7cVYF9FDNc6nQbigUB+JW/fYutPjG114de7hn4pvNtQTPfZRcCAYB2RG53RYk8yuuW76MaD8BScyWQXuE5XHmlhw5RYDyBrSxiTmZdWKaNTVZFoq9fIM17g0dgHvqK+4EDAPA+JmbGmUkd2hguyomhEObrnMBLw4cabh1AOquifSVorC2yPk5/n0TQry7nregCWwJW2BJcf/vnqXHff7+MkxDjIN3r2Mqz8Qq2qZ1CkvYNYiIDsqaPG4LcZJjED0yucQt+4jg/811URC92DpvJUb9cyZ3gFqZz6IIxOIn2tWJX4PPtYctbOr5jNtf+a3WywiSph3CBk1w2j8vODz7fxApqUiEnrj97jC21Pg2nwPBxcGLg3sUuOCqRYSOrk1xDZufNOywa8w1L+CTu1deHIfQxIiQpT4ny+/2a+pK8+ZknI5FViFA1egFCv2GRiZH3mwh3r3xGC8kXgzn0P1opPpct1cISsDr/5WwR/i0yyR1vAPYdWH2mpX1D2+hkI9XhBHhifsWBJFbhPPs7A4q+QchAxs1Y3sSxJnQr3/TafiYui9SROVMkKs8SwA3QJxgYJaFlDQA1DgEp7bvL+il0Cy6351U+wJWq2tdn+6Sq/s89IsvreDud7mBHcNtFqdAqWnjMgXovxFgltGador4pbxLL4coQF9JUjnCp0+R/OWCBnvNy84B1dkLuD+pCBf4t+dnB791etFIkekxkiXTdy2fvSb+/YAqTJfKsKEM+8h3eGDUtq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6rvBnUYrAQ/VPNWzeVcnLDkg6O/1slK1LcdePQ+vL8Ko3BrEshpbqQ0WKQb?=
 =?us-ascii?Q?xXx4vM+hJkwK0YunVyVSOHdijIdBCOrgDsJzVjrPZS82NFOY9Oj80gn32Opp?=
 =?us-ascii?Q?6K0IbJ2iPgJo22dxWGqZCdmqG1lecFAg0YHx1kZ8pGvgDslwe3lZPv8B7SWT?=
 =?us-ascii?Q?ewMiHMGvfBbyEuDSQmjSWz6hT+cp3WBwv4W6obF703gIDSdSVP8fd/JvNCQ/?=
 =?us-ascii?Q?yith78eUtS9lOQSR8uOXECkVNy7KgfScZBgtkbmDm51opWERjubCGfeO2NWd?=
 =?us-ascii?Q?h7J/M0QwKKiqrIfVnQJC4LubeIJldEN/8HP42AehyocYzymhXX583HczR42G?=
 =?us-ascii?Q?Go8InZM0Q+ratAOTsWy3Z2Xzr/lpDndee8jfBCt6mKdRYB3+r4IwFG1VD5Z3?=
 =?us-ascii?Q?xk2zyQ2bnNIPyJa1mvZeYpBAbV457qoKCnGR4HFcHJjnXEEx/2oknWlAgV4O?=
 =?us-ascii?Q?ANUQt5oD58N7XhFchZleWC23U9Dnlf/mGEBsVU9xezl8hpja9TgtJMKGw8Yz?=
 =?us-ascii?Q?3lds/BeLZJ226qg7Lw/A+20BlHaDhwLnxmJBBs2U5t4xaIoylHTPOCJPWno8?=
 =?us-ascii?Q?Dm3zZbhLTNqEJMRHlN92/I2YdopDwLVVbDGtbiIMqDZmYA4CS9InAd/moTc1?=
 =?us-ascii?Q?RyH2asi135pW+uToUEVXtglKkbYMDk6FO6u8n3DJuWUXO/+TrvUP5uQnnQk6?=
 =?us-ascii?Q?Phocpmw4leaaAsyKVd7SC9V97KAJG3VbTbxttPVXzyGfasWZpoJefqYyTQaG?=
 =?us-ascii?Q?JFb4PgHTVgbIgZFF/bQ0YAzlioqy3f4OfcutsL+TgWdTQA1rmsdnldSfKH6R?=
 =?us-ascii?Q?xC6XeCCiOr70jdp0qyyGh7ZvOvsRJtQAqY8WHP9KzduYAFjlkQZfEfQ4r0E4?=
 =?us-ascii?Q?C0t5zuztofDkzMAmSDsQno7x4EIWN09QkFdOjWl1OSMJnKvn8TAbRRrHty4l?=
 =?us-ascii?Q?YyA5S5bx56PanZWFMvh6Q8OjsdJ7nXcY12o0Cm6mmJFxV8lo+qbtGwjlQUWp?=
 =?us-ascii?Q?uKiQ8JfCEnlJf1SDz5lDwxvD1Hx2aRPqKWY4jtXk4GxNuCwZlny/qHOkbsSs?=
 =?us-ascii?Q?YDUT8Jvm1msvQPbrQhce6tcux3H8E5UhhkfJSxp/r2crEQFulbKsIpezuXNF?=
 =?us-ascii?Q?YKsIted/3bolO0dTMdlZuOjFa9fYmYxZLClNkeONxCaBq470wX1KDibxi1Bk?=
 =?us-ascii?Q?ZDrR0Jh8qFWBJJfsr0IcGv3IWrb6flKFxJWAC41Ham3uemYW5r14FUmoggwr?=
 =?us-ascii?Q?+otEfl/yj4I1pt/Vo1DL/wn8gRBWiuZqyT6CdA4BsJphwl4XWOgg2nmomGgr?=
 =?us-ascii?Q?0XkTTtHF3XD3FRweuGVgJO/cvFGwMcXiIXrdZhJbcsOXqCpfi2AHpYFz8UL+?=
 =?us-ascii?Q?7KFX8tAw4O17wMeZHdjZHkE3irqzeqUZqrxYiipHIKveK707vysvhrv6Rplb?=
 =?us-ascii?Q?4V9+se8g+RRLPnAkCuO5tG2vQ/QkcuqCggQLL8mNrr1eykE5zp96MW+wnOBN?=
 =?us-ascii?Q?IykmV+vNy2X1bmbaFnv9N6kOXVNzVgyrZgqNrA8PeFoN2lr7sdaaEs3/FKiS?=
 =?us-ascii?Q?3u6sNCIWfU9YXnAu1WKtN7khiT8RtgtPZrXNjSxRQxy0I3qTPOZ1cB3qFn78?=
 =?us-ascii?Q?bSIhGZHqoqEiWPFb4cMQwu75w0wsgvEEmYfWHDkpejtu5Cgsnax7fefuJHuR?=
 =?us-ascii?Q?KYBDlfIcEtushFfjZShuUj2SSgF2Ro8mjgCJK6CQg6wJMtK3wbMeu/pW3TVk?=
 =?us-ascii?Q?9Ay2e16bdw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d7f703-450f-48a9-e528-08de7e47eae3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:54:08.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncTpDQTzCDbTf9TjTdKlTDtsoMudVQyPMzLq9zu14JRj7gBeSs1kkHa3osQaFtN6FOb6v/Xhejg7KPqEXKK9lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

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
index aedc09937716..9bdc8d000d2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -769,6 +769,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -782,6 +783,10 @@ &pcie0_ep {
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

