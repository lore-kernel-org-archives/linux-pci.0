Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D033DA7DA;
	Thu,  2 Apr 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123448; cv=fail; b=arPICzI+v3bFBJg143Wh9Ry88OwWERU2DBLDckp6ncsFAD9S//g2vYqPv8eWwBdXGE6uhkk79xGT/LkXi/BIHZYeCb3DUNB65K/omFktCQdSE/3NGKPUMbojW5PLHhYOzz+qWGaREzWFfOLF4ZS1sxRUB8AynqNACVjIWFhmU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123448; c=relaxed/simple;
	bh=DcriXr+Z8ZbC7d00DxqdLzuiQjIj/ZT0nGz23NB1TZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaqU3nyUxhTdBfomlqvt/ge0YjcTRQWDUmDJUPDRx/tCqZ7c9LAtgSXqXEeMMgSU2WYJ2JEQHq2KC9/vbBtiV83b8oQvaKtOKeaL+LyvNwyVQUCGBrKMX2Tjx2Beidnw1lMP7WFesnuVD+iOWgwJMXwKf8H/PHWoR4mhlpraaLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6e5I4nR; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6e5I4nR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdfLo3ql0cQZeG4I97h+xq/VHI1ywXOPMeeFHKpmmuZsJ8uLs7gmS/iRu/+aYWQyj8YfdjCQGH5XY1jRNUtfNcKuN2w362xvEbM9FxO3LDlgDsAfEywkbQdmtgi1VzomX3CbcerlmBurIcTqwbqrt6CRfQkqXKKzRT2S2Mk6Lc6sQQNiWmmvrAvCyg+SnAW3d0RnqSb/JQbNyMrBq8GWs5dQaka1v1qgWRYkZu0I7/x/8O1hn+Ko0NxlK3zWu6wwZ0ELh+1q2J387GnBbj1uMweDO4mIygV5gwKJ1pZAj8a7gXO6MtgDCWvf35THJXuO875uKcELuAQhrv/rwpHq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=W773HKUIuwepdONpnmJRRPFjO4KVJsf/q4S6nFY1XyvJINt1szWfP5dwB2VeNNcxOnO8R5LGwfBaxqUTAGalL+BEA2Uo1cuVXlpyloNbkamrTbMgLeq9gz4YFuWK/Lx04hVPXzQhq8VKf3x/4X2oz/9a08xMhTtB4tqzpw2dGpSXDDuAF8FYCeS2Z2DtI6HghiKYXjMG7zmFfOcQ+lcDHW7Knj/FJrw9DSaefxYCuu0sRt5ixpQ+TuWBPKqoQi9AfvyxZfp+WIY0fWlxUOnR1it52QpUJYrT39CEumgRnZkuaxB2UtxCb4oXJ8IGrpDU4Mf8AAyViSk/QzywnSQTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AIat2mzwx+LfeZBwOS7XTYabRfThSe+oGSHSCqNG5Y=;
 b=a6e5I4nR8OSbo23C7ZuLE8rstFmGlTshmsMSbpKVJJUQYyS37ekhzmuEQe8CaebwX0ONmHUTvFYQB4B8gDHFqVik/aIQlC8sLdep1r5Zy6sFDdNyzt4TQiuzWUhg+iAhK7nax2D+H/GDAzXScy/1Y1ZzhkrKSekSQjPIegVwPTVJBcjWActkBI+ETY9O38LuUfPhu7TWiUV79WZRpbmUiw4165hPPXaQ+2ZL7OLoT1Cz052zxK6QwvsWUUHlNdM6emnSn8dsrnkPePavcYVX+VIKgn1INq0DTKexKfTV3DPx2kZ54NggSCx7idVynfQnqBfgHZZtmrNJIajZI7eNng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 2 Apr
 2026 09:50:39 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:39 +0000
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
Subject: [PATCH V10 06/13] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:00 +0800
Message-Id: <20260402095107.205439-7-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c36a04-dca8-4aa2-5f28-08de909d4bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|56012099003|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	wtc5R4pLZW6r4uA+pLx+0tmbVd/a6UadEXtXrPtYpE6VVbDUqnGnNsck/it+rA13eStiPW8nrlBGlzb4LR5gCf2oqotnB3FvPhE4chXFHr7nBEv0YvDzFqpy1vQvY7VvQ3Kn+TUv0R8HMMRD2oGVIXpW6t+aGJdmf5r9J26Nwdnl3Txk1GqQLkg2qAAOAdOFYxMrqnaOOQ0uXW4h93rkP2STh+6cGxc+LmfJ4bF2X/rvzI4kFqBNrPJwSTX3IxnDiSibXvN6Fs1wa1Ojmv6cQqUfdQyj0hfqcCd/Z7Jy6CswPc2sGkTgjOzDvGpw3LjYc+fd08s2Jdd0cPdOhP07IHe0qxq+aVye9dPoZDZp502cuC3O1q8O8UYLE1j13QHqfos7dd0wLvOJnH5vw9aGRWrDAPqIE9cvqDGSofu7ni+o6xfNCOQckkJXOLHL/H0Aq6w0eban1qfGAqGFQd9MlQYXkGHWcwZEnWHgfeXg6iOdzYdwPUHDiiTNuvhPLRx86GPQgj09eH3pip9Ftg6zUVvpqk8V5NunTkBszoPF4s8tTyrzsr5tV4sEZaQUTpXQnrICaGaDwMLO3BiSajgRf8APkBV4uoW5pBhdsLmmRtGIPcq1TsYUA/opH+jGnlVs0tlAFlPz9mezQtWbfu1161MqAF9XrnlSGeqo32ZE4GzOT7rPncdmfvGNqgH+wD9MQx/5Re+0C6qa7Pn+hApUf6T4MFPZ03z8kvyxjH+YFSB5j0FJh34/Vy4f1tzBYb2jxw7K5yItMC1XC/Zo4zzDz40vPtuOhZyN0BmEOxjLlLoEcYx2nQd4NmcVWiC5tOmS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bog20DJBPiHXcvrH/mA+UNQ0ZQkfy1RX29Z8jpJHlSpcgHh+/AKv7eUFGvCK?=
 =?us-ascii?Q?Q0gg8I5ofoflq6oqDeG/e2VF6hhLtnmhk/myND4JqYkTPG72U863d97ByAKs?=
 =?us-ascii?Q?b8Eei1HP7BEidAyRIch583I6BoMjp7aZY0TKr7tCJDD/d99gAFo1wM+N7AVZ?=
 =?us-ascii?Q?k26twSIabfjpmRfCKpO1Nnj5AnvwN5IcoIrG9tKmOv3aZ3ocro6Osejccer2?=
 =?us-ascii?Q?LwnJs233ycG2kEHf9PPlx1LRYY6jXZlrcVlsNGv9jAw3H4YJkoFgc+iDNyUk?=
 =?us-ascii?Q?FBAuH6EsTmZK2e5AAUtWHjycdk1WahwGwujbdy1d3DL6lkM10xDMvLVOsHzs?=
 =?us-ascii?Q?z1i34pkeNyTkaCxnnL5ER8B7u1r2YHgLavRgDN9A7PT90ByUH4gKkca/1GoX?=
 =?us-ascii?Q?gBTTQ1gLCzphAiqhTjJjDtl2qrgT/f/86JMOeZddC9pWttFeS9okYT+CMcmy?=
 =?us-ascii?Q?Bh2GoDrGuJmiJFR2GafD65dUJVPhmS+eoj0habBzY5mav3eRCVGPx4YOc97F?=
 =?us-ascii?Q?fjiVaf5/hjmcAFvR92Ttm7UludBoES/85f8maFO4cl1TQ/UTZIALYaUTYk3A?=
 =?us-ascii?Q?y8iQ++CNSOFUARID4mgveFGlmTFxNom7+b7zrDErMZoopMCIXxQjLdUhbIJw?=
 =?us-ascii?Q?6W+S6eBFpjXBTk5VnMgrhX3MThsF5BIVbaSrPitB8URK001cu9PcW6valu5d?=
 =?us-ascii?Q?3t5vPuFX9vrrYtnnXr76/weWilPbDt8OFgupR0LrZeim9Z9AqDTCcHzFK8B6?=
 =?us-ascii?Q?FjmLpR13euof0w+S3gahCCrqN08HytFdPIrJ60VxArbxdnzN8wRjCJ05L2Uz?=
 =?us-ascii?Q?2BMvk/F0+0qsYPRr79/O+koKpHA1WMFhYPvcoiWXD8YlQxpaIYxrBM6Y79ru?=
 =?us-ascii?Q?BSQmQGEX2TzkLIaHFO5yzFnDeOne+BBU7BiJz54xMVAfZbLq1jQhcFk1lYWd?=
 =?us-ascii?Q?7fFF1ik8lVyo8+Z4L/+fQo6CMOBydBJyayP5cE6MYL7kS83pXvrpVmUOU7FL?=
 =?us-ascii?Q?fZsk/c0TxVTJ3wg8WLoRljkrh74ypS/BuBSOqlmS/GUIx7GyAD4JUilt275h?=
 =?us-ascii?Q?oilOBgEkP83V0Uo+Z+fa6VXUezU/bbsjIg5xQcDMDWRxQiiUGJFEHpoLwHah?=
 =?us-ascii?Q?NZ5v5x9N+kJT8dKpC+96MLMxiO0p5R2KuuuhcCiCjxiPuIDsOHerg057s8RA?=
 =?us-ascii?Q?70dhUDy1yX/JfAi5KnHa0NqzNCivV5I4Jr5FAyOikfyDhQX6NEdRIIf7+yrM?=
 =?us-ascii?Q?3mUXi+erT7bg2mJS3PKaZZG60H17qywYL5s5Ao1F+DTjVcrvv3GT00euUlRh?=
 =?us-ascii?Q?RvK4cLnIH6LB2eSomhpoRy9+O5ThDSvnwAeuBnTCY4xMtN6bISNb1QVbQJuJ?=
 =?us-ascii?Q?Y8qHJhd6UFKgcokFGgX3ZehgRQHLE7DcPTO0fwAXhyE5Fo4kZWz+F2OkNm7v?=
 =?us-ascii?Q?lwOzVvIrVyjECUo1nTVQR1xRp+rORIKYD0bSYPq+SHWeuN64s+un28MOQ/zN?=
 =?us-ascii?Q?WU55DXAC3PCGbDSziRFlMQexateAWBCdV/Xv03cXXjF00Fno52GK5llO44b/?=
 =?us-ascii?Q?Q911htjQvcxARyIKz6OTqs4cxxCcGk2TjN0xxbKylAnzE38v4arF5jEXsOD/?=
 =?us-ascii?Q?na3xVQvlCn9G2yB1kCVIQgT5QtU2AY+3hchHodWzbBR/HlYO1Nf1eTpCOGNx?=
 =?us-ascii?Q?BhJW4UIjiRCqbjLtlFZxEJAEktI4HR1IXg1sudPYbAGOomBz3Xgn4p02B+WX?=
 =?us-ascii?Q?YiN9ENAWTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c36a04-dca8-4aa2-5f28-08de909d4bbb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:39.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riw0U7HbZKDMUX7Gu+cwfdpv4WF47ZcniqlMNkR5pz6fBJSVLP/FCoFhrBXi+N+8yg6AA8qpYN1fQvDMAmiY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 4dc2c410cf61..9438862b9927 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -302,6 +302,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1

