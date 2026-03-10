Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD5366062;
	Tue, 10 Mar 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129241; cv=fail; b=uwdioo5gOVCmMDhnshrSvFrfLU2gOS6GHr/fvr32GK3O+C1fS+Lj58KwxbxBYR2QjfT5q/eLL8zr6HJopeolNErGv06qzA8pcAe3BaalXy/hAMfC5Ryv0ZOSNs8CMxnzYi7ofeFV4TP62nImEll+B/Vg7pA8qqKuWpHyBX/HypU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129241; c=relaxed/simple;
	bh=53ND76F2+FyIwnYjddIguQxc13m0yBqhgZIg1IREQQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRVZWNA29J2xww/K55V8UJkzGpagOoHGHmjWkDgHijuTfuq4Pj1yfTxgyTa5wbPBWNcBVZ8JbhpVkyrYXjR00CFeia5PsFOjgIAuumb6fQvRo0XYPsAmaLYD66Z7KSCrUyI0azoZNdh+HV/jURbakbI4ULS4kBTlEnvobsnT4L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHUpHwdS; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHUpHwdS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYjPYHNF3GiR/TaJAjid29Xl30PTGTO28hTrbqrBZsOz4ZbysmH09S8LUOtXjXHdjE5ieeqzaBqXLxXM9hjH0hvJWixg+Hh/J63EkmKMpFQ/3eVggrj+yqpKYHBHlX9o+qMr04nzJyvY+4bmYl8b40FNgncZy7dQcg4ZnK2TRbBNYZ13fI3M2u+5QwicuIoNvQ0PilU6OcV/CpQhzfZxzApfG+ifyWYqJqMv3UX6rLA0HR0wAOukNyv/0Vu4QQXaXvzUfT+kc2qU3hdAhFqhTSyAcrwiXsQ89HBUlZz47dPoGyvWEm9cjhVcwWRmf2EGXsBRpQLk2/71aWoacjgNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgXaRu62bDI4lXUtVBUlTRrU1dHNeQaOCBImwJzLquc=;
 b=mdZf3AwCdHofiVJsH5oEu8ZjUrqBjOuPtEqWeodkzF7D8x3ylUzlVatkABPIHvwDmVOd+P3l3qHdV/qFfmedNBGRtZWqtdh1EE6r5bj4XO8R3muMfBUqApLOwmWzEHSx0ObenjQyCjj9VpvjnkmUgNg9diC8AJZ+0Swbj62zYT/vAs5Qmj6TSumv3584VL+L3L+3zmUHa6oaU4tT1qRUKldJ3lvXkMyrNdE7BHCicpDBMkeeWedVgDzDy2UpaHmry+9vYkzR+4v38yVrqTw7EllRikTyUnnAfKll2G/FNTKZr6ZNm/Km4KBll9/ColsOjP7jCH3QLAI1ahe7GjcXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgXaRu62bDI4lXUtVBUlTRrU1dHNeQaOCBImwJzLquc=;
 b=eHUpHwdSdm7KFXoz6W/zepiBECXqG5QfJwLZ2vV8KBpjw+CVSmRSfwVNZOfPra+4PETjmlTzXyZ2Q4J0SwsYSh+xh7/Z5AyvPcpXSQJDTbjsrG++avwaq4oasoIXZ9FlNpIzVGCxDXS9Fls/sNldLQHSILXQTDcFcUDfC6D5+lZLBDE1BviqcHRkpA0gK5kFPeAPS8HUBRZJn3r9ialuPJU/XNkXltXjpI7HAesJ4BXUxYyDqhBQqGzyh86V9R19r1rAUowjMX+Zv1dQOnv645W/M+XfCOLw73jKGJYwcgkhKusAEAVAkc5C9/tO2VBanulzanhvgR7b9pIy5dMomg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:53:50 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:53:56 +0000
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
Subject: [PATCH v4 3/4] arm64: dts: imx943: add pcie1 and pcie1-ep supports
Date: Tue, 10 Mar 2026 15:54:58 +0800
Message-Id: <20260310075459.726495-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310075459.726495-1-hongxing.zhu@nxp.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b16a7-4cab-47b0-4637-08de7e7a2e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Y59vvw2qaiyeblWvO1NBwCA1oNIdXYc71jkdB01FBzZw7lQtIBG1VY2LRVPzhagRt/KbofRzjs6g49wNzCbuUmJy9wM6Yi0YY+lTcOLXtqtIESh/MH+BHsuUhQVnsXUDwW5hYn+nXYarXKyKz4xfgGLxTgP9KY7mtKUpnDJiVYTu3KmAfgdau4KrsX38lcS9NDEpaWZ369Uygj6dSils8K3ogEn61pB8U5a9xgO5IlBHimauiBP0fAbL/QYwC8SvWNtua7aFnI1GcEi10H/sksFSfRMuzlgmE+r5CTxhi/zhU8nWqLSFxVy+l+a+TTgX38IVBm8T02FBsObIgmQXwXUHPT+2guO7gUUOXRm+OvBXvr5T3YS3yzmIXzMIsWPhk8cXhXIZhjgfIO65/AbTervQPNruwtNQvAq7kvxXFAE3R7R3htQ8EtIPqIRdfvxG6+sYLHijs61LknnLPl4Q5pe/m0iO2+dVRV+Hl/d9tmwxEMN4kiGHHihgP2RYDf9iK1+z5dI6LJnRR4xVgJbF9sb1kD2HmDFV9//1ziZnQqOV5qhJGBvmx952UZzwfVX9aU/hBkgfjE7qrdvCe6XvosKtVuYXlb51f2CM7qIGcb1+GJ6XmET2iKgwPxYAE1l6Kspt25bMm+UC1hbiLxiKG79BYCwICuxdyyN7E8dlUZcV6ZzPanU0P8XcrZ6uUo7QJkIS84sGBU1dLFNQWqyqPEMpl8orwwZstGVeYFrShtBOusSJ4iI8f3jnp9RurJJFMiYO1SrKYjk1goDklNPkO/gr+ZSxjeEc4XwutytSjVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KcZoMNTmDEfJCNui8e20csjAtnAgYueIXmA3SfV6jWBbxtXNERV67iBcT//?=
 =?us-ascii?Q?XTFjoKCpOLrUVzzgHgBMS7Q4QODrWRusK4HQeiTjddalMWKn0Rs9zWl6NWm4?=
 =?us-ascii?Q?nuEJKFLyCJ8uxUfdJpnqmn4L7IhWbRFeBE1lhru0NXklWLLFcSfP/Z49ugsq?=
 =?us-ascii?Q?/Afc+xE+tvcIYrHwOpVgZJ/0xefMy2k0zmBdjCAT+dU/FKodpc1baUlEKbYl?=
 =?us-ascii?Q?lb9y/hCCsQfmlevSr41svoxUREHyyLzIGO0zeG1pPwTlQMRSLy7wl3TcQmZs?=
 =?us-ascii?Q?2bMYb1rlqmPCc0m4loOqHEjAf5jC7jBnUMroK6CDTC4LFxtXalzssZTDrAk8?=
 =?us-ascii?Q?PE77uBbftFBbNggIDX0mLt/5HEny2jkS1FIVBgLFBbpOhgnEdW08Vn2dRtwc?=
 =?us-ascii?Q?m14lelVFN7a3jJ8CXwESlmReRojW/uPBFNqnWi+Ok5bAAnNSvL1+hVxa9Ft9?=
 =?us-ascii?Q?xkxz/FnS7P6x66lxLuomInbtjhBHg8Wft0eQnA4FWBFBs4WDJxA8fxU341+Z?=
 =?us-ascii?Q?ILiLTxJQpzJBckbl2rXuCP/8KGTRBWr98CqVNL2L532JgKXlz2ELaTkTXru7?=
 =?us-ascii?Q?vcXzIKc4785KuSZiIRKtXXjn9tnSTgUl3gdIvl/nHiFOOfEw9YTsu/LhVrgP?=
 =?us-ascii?Q?gKzYMpkjXxzwuQlgo6+7a9g0ZZWLutIUxNpb2DviUsN8LjpSjWlULgS2dC28?=
 =?us-ascii?Q?CJOY6VCi/6upujsYSzWINdedzapIakqcEJQIvtBFD2HCa1OToGlHGPOMGdWz?=
 =?us-ascii?Q?2UQG8oYr/vyXs/anGu3AJeSKwmja5tf7sw3QjPwJ6t1/gSJSe+G9BEvo9i3+?=
 =?us-ascii?Q?Dn0UQIXuKd488+NX2KeSNxquC6WhT0OYZikEIWIJN/B5mAo9rBNeNAKk3XQ8?=
 =?us-ascii?Q?9+UPMjXQb/Tmge90ZeAD1A7wvFE3/oqyX1n/R1pCsWYy+29eREAtw/sl9aPE?=
 =?us-ascii?Q?mpU3XGTiMfaNqQrmVrUgHGEXDInNcsbcX6DB46Kw9FP4Sl8dBw0b6eYQq6Jq?=
 =?us-ascii?Q?56P88Uqf9jBwPm/aJRYEqZdyqep3GbUe9UuAJsZOTz/yzKffpS+isx9acoYh?=
 =?us-ascii?Q?p+XHK1uIdbo4eiJoBNf/ts7D+sIIvxi2n7FlPqSJ3xWHH0DN3PigASKSspn2?=
 =?us-ascii?Q?WmfniFtinSUuk9guwInVdlbajrARSdLhio1klHF5AK1jKPA2Sl7d1ipolUjb?=
 =?us-ascii?Q?hs7dYAxzduFMVtWvfiv4yWTOWiWKOM8ZodfxSZkU42onVjgKJgILupRWJeDk?=
 =?us-ascii?Q?KQZA5Ro2l2pb84En1iZ9YIDYn1Ix3T2vBC8Sojyw/yrLRF1V1biQ3x9etFgw?=
 =?us-ascii?Q?Yoqvp+Kfxd9wxXGccgi6NHUe09Qi7HoB3fBrJA0MxGCe/AKneVYGtJsar3zz?=
 =?us-ascii?Q?Yy4xzbNPd2U1KaTdtLdoaIwFfX8b9kqyW3aJiJWjex9D/cKRFY836hxKoXJk?=
 =?us-ascii?Q?rM9X1WADJhoSpRkWOKloTWEiv08wvhg0a7mX/ce6z3BziDSb3SX1C2fEMZYq?=
 =?us-ascii?Q?1CFIjKOHiS1tBdjg73VF6BfGtEOOS47qWrv3NVwmBcJDnRvtzNEadTLekQz0?=
 =?us-ascii?Q?5keHaQovsFWXtJ3wswSWInaKjqAqQ87hrQyAzi3hYxwXPS94kU0Ro15p1Mvr?=
 =?us-ascii?Q?Fw8UXi8maKEji3AmvwMwc0wvTvtGVwInvtZV4UVfU11e98n4Cw626tRMPtYy?=
 =?us-ascii?Q?Av9gFjStVBkHE0CdU6ucJ9CjZjLoY+wT8ykTVm2dHb1HYTHHoJKVvyQCEa9x?=
 =?us-ascii?Q?hbJFEiehCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b16a7-4cab-47b0-4637-08de7e7a2e5a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:53:56.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoZqGIhHsdw+wYjvpRvGd3yiMyuUFA3iBlFV/eovciBuKwQJtQl0hoFZtscdyzkKRco1JagnLiTPhPGydmjFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Add pcie1 and pcie1-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943.dtsi | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
index 45b8da758e87..908bdac59139 100644
--- a/arch/arm64/boot/dts/freescale/imx943.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
@@ -145,4 +145,77 @@ l3_cache: l3-cache {
 			cache-unified;
 		};
 	};
+
+	soc {
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <8 0x80100000 0 0xfe00000>,
+			      <0 0x4c3e0000 0 0x10000>,
+			      <0 0x4c3c0000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
+				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			msi-map = <0x0 &its 0x98 0x1>,
+				  <0x100 &its 0x99 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <0 0x4c3e0000 0 0x1000>,
+			      <0 0x4c3a0000 0 0x1000>,
+			      <0 0x4c3c0000 0 0x4000>,
+			      <0 0x4c3f0000 0 0x10000>,
+			      <0xa 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.37.1

