Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CE3090FF;
	Mon,  9 Feb 2026 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625501; cv=fail; b=eLEiZosz66kWHrG+tnG5Rxvm0Mr1JwlU4ljtz7w4lgPI6rpHT00t7n+AgZhA83aSLmsGNc9kSqTuwwxNrInNF8YRBoD+SB7x5zH5eIHOOe5Ww0TnXQEd76E4EZQdKD/k5q7hX3hDwR4LO4Rh051/MM3d0gx8GdiCsxxi9c3U72I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625501; c=relaxed/simple;
	bh=AAkUszj6SPnK2uMoevOU62XdwWErsKVAqBVjYvH/RUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekZ8nRCLQ3BTBiI+JxgupTuMNcBh43TZHLupreAGNsd/OdyDPOr1mXEY/jDnc0RPyZ+kXcECNOvwxvJgWnNuKVapPIXivKN2ySk8H6qqfrgAL95dHsGJKI032HsEnG0E73jLzYgj24oWHjZYsOygdh6kWbzIgA/W/II9uhGR5z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RbTAKKo0; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbTAKKo0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT6sautUwkPZfr6fHd5/hZgn3O+lBhHON+0qdPuFao17sJRFUzcrL5uNCMFGZdTkqdiDKz4yEadNqTCYRDnx5WB6QMWN4JYgSi1bTV3iN4tliRUiV9oqPjfHXBk2s4lvFo9Dd7v6bAVqN1mSkfehX9ydDoiHBgnxa4FpOjuZqak8WwY9N56ZeXyuWdikCblz4KCZdvfErUFXzfSv1vnu7/mSmzKeuj7BaSCAY1+jOSJ2Yrz9NmgkOgWX5HePrIVRQYSM5jP8f8TWORmcOja66cjksct1pS7OK2dLEQOyvTcvyaAgGlrPDvUNabkCKzYavAhH7oFLGSsPopuRWfri+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=myx5Wpbn/vHYdTk3VMps5ZAOX/DP+1yXZexBFXZCHMg+6UzW9soT9/56YxXnfUFlkFN+LYxhysG9Vhrg2kvUnjHL99jM85XyiYU/+f42Ahme2Y/XP3SoU2c0ANtK//SX7Bl+qQQ0PFGpWRGLnqomZ5jTt5VyuZqGR0zsDlOHgsgltZB0kQ8wvrSdVpMDZ7G+vj0YbhruoLwE934aN2d15z3sRn3K48w4gBOO1qZIuRRNP8AOAyojR1JrVoIAozZWZg9x2gjjWuyNFq/6Ycfc3/vDdSk3+WT8uA+tis8R0rZVk8rS9+NLjlVtR2dMfTUEeBixE5hCRIG6Sm/VXLPGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=RbTAKKo0KawHk2bK+8IO+dV+EiROEZNnHS2n+o++Qqi4Nw61+uO2drmesIzkrTOM8KgTMSO+gvJObjhdPaLBJ4+BFmVAuuYBxlcg/4lfEjvXN3cXEWajz2Z3g5LNocnMLevOeZPK6N9a7pa2eweTIt743m3sG/a2fkuYaXv1/+jnSNlsO0mdmq7p1M4HKbzzmTlmgcxMfRNK9E4g+BVqA559jNVbH+Hwvy6RTo3iJcjeFsgGKXLlYbKzCBJPcd3/On3jnXl6a/++FmrbIu11FwXwpbmTLiXJJaO6zS6q6ZWYSD0jb9ENUl9MrIret9dElxnlyqPRina0A1K4RG2Xjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7180.eurprd04.prod.outlook.com
 (2603:10a6:10:12c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:58 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:58 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 11/11] arm64: dts: imx95: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:54 +0800
Message-Id: <20260209082454.2097628-12-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9565de1a-cb99-40f7-f9ed-08de67b4b611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uuA7zKeYmIFa6Hu6Z0h/njsohAgZAe7TLopxUHEiwgbuZqBN8EEhLl81j9Rk?=
 =?us-ascii?Q?+6uBwp3m5e8lsS3SZRMftxW7xB4ARGDY4u/Oo7dCigLj2VQ3qkwqm87YU/15?=
 =?us-ascii?Q?+WIVjqednJpMikaK9JZnHHHYFl6doEJxVxwz+QZCAUnkIGuAchBWSWa8cyKT?=
 =?us-ascii?Q?KXOV6z+E4iHFqcbJtkIBMdaDPlt088HWF7SaLisDpD05fSRYTrhNV9T2Zksd?=
 =?us-ascii?Q?nvVXpUai9wt3vsS+P5dKboYaea9wpp6+JMP+J6sQorM04Czb5QZOfmXGKFKs?=
 =?us-ascii?Q?ddFO3hegtipCB6SdoD2UvypSbJKxcQPK7kIjDbROjmCGSYy23RaCY9skuXbP?=
 =?us-ascii?Q?1RICjQhBi5zrMJPokFXqN273fbIQvOUBFua7WLuT5By4Pio01PJxtln0ARcV?=
 =?us-ascii?Q?//gpyKFTksoWTQLi974pIzUu64yFjSBVTOjkYftEsXfh24Nb/qCDGjo9w6Bw?=
 =?us-ascii?Q?CBAC9odMo16cml80j/m6lqiI37ZbATfi8yS1/09Jnb+vg7fIhaCbH+rjr42M?=
 =?us-ascii?Q?6NNGRnS08+Yv22uksp2k1qlwkyKuCVYHxvjBevjK/z2zK/Q2BOk0D9d8UM9+?=
 =?us-ascii?Q?9ig+6iVmO0umoNrtVKNIvxZ8aMy04TotBSme1whtvcgDFEmUxXMJ1t15aOcC?=
 =?us-ascii?Q?Tus0eSj9qGG4XjcsDBrxpiyHRJIfFIhmOA6iFPyYkpUPNA035icnJdtibyZg?=
 =?us-ascii?Q?0pXpwBC4xy2C3Bu0qrSo5UjcLHUw0cRa+TIr1JhqPRIkPGAx0H/RqagHmINb?=
 =?us-ascii?Q?afIs1Xy+qARWcm4kUeyeONjjgD8JeaeOQE7BW+N8hCNpYNZ+D3+TBqwBVDYB?=
 =?us-ascii?Q?anjaerACli0dRv3PK7LOa2oEPOyStxIFgCGVTNmqdF8rLFC8/UEC1xU7vJYq?=
 =?us-ascii?Q?zQz6wnZvjFWxYF17IBZ6y8ENyGBl136fBbY1wAI6SGOeks/hqRU+YtfxAN+Y?=
 =?us-ascii?Q?epy+Z/2XGrj89tgj9Ub43wN8uJhuds+YbqzM3h3vDc/r2fJVzAXUPSHfrz6b?=
 =?us-ascii?Q?UdLwTqq5uSl4NE8IwQ2ZgDvwJQQp20PSXBfqWcc/jCEhXuZi+EUpeImiKZq/?=
 =?us-ascii?Q?pbigQBqN0XHRyuvdOjT/nJzrS0WgwlyI51rWK5J8HWWiBlREriJZ5U6mZxoJ?=
 =?us-ascii?Q?rW9tZd2q7zzSVA0NGbF/qrRfkS61x2XGZ1gQRoclRJVU19xjye5GSpeNh2Ra?=
 =?us-ascii?Q?PwnIWgz0Ji6K7W2YAafhxZNqdfdT9Q7G5PGEvq9H77yl09vy8S/uVzl6/oog?=
 =?us-ascii?Q?WS+LZp8xmGxljEyeMCqPqNFuZRON0isg6EUMFvk6tORvvUqNQNk163QgdivV?=
 =?us-ascii?Q?fHUFHPH2BNxU07JT9ZfAENHPBGDMxVX0VtoHz6QgCgVhuY3k9OSy00fKBKkt?=
 =?us-ascii?Q?8ch7uSq0howYWVU+TERDdKFSd/s6OYJdbHpAAOQI4ded8hp9y3qtNs8O4pPd?=
 =?us-ascii?Q?S7Q6RgokemND3CncRka9EOKBdlsMLMOrcafRwhI5gVBz7YGtQUgreJq2dn3P?=
 =?us-ascii?Q?8AGS2huae7uC4VtmJY+CBfa5aH8DN12KtzKSZqdQyw3PjRffMclQdVFoTnv0?=
 =?us-ascii?Q?y4tGdldyDHx/XExlxTi3CIr8xhmUFA7Ie+jVQErlonpiaBCB5cxKCT9oFOfo?=
 =?us-ascii?Q?vLVgQn/N1xTs9epuNkwsiW/L2hWs+eM+r5S6nJYCNyc/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GXMR8ZMxgPR8LnPrllWLg7wCVSfjJdeDEjWAPaXeb2AcOjy3bueYsd7tB+az?=
 =?us-ascii?Q?G+8uONdRNyA9RLc+44E8pCE1bNpYLZ2u0QPyNGXURcdlZKwG+hlYmoYg6hAv?=
 =?us-ascii?Q?RKFYnJGBPxhojr28W7Yyqdf3q1DklLJmq1OHtm1eBOMYUHFfnqPszzbb+p3c?=
 =?us-ascii?Q?XqG96+j0EhcTsZwBcEDGB8de49pT77v4rOjG3eVLQ/epRRjn8KqJmIh5+ujC?=
 =?us-ascii?Q?M2yMBtsD/zB7bN7P+uU7oa34mY/3xGfYT1lgv6SRMQdEI90HTe1X3yurfS6C?=
 =?us-ascii?Q?C9ZjaLjekUSfaAucZ40qSSJujHvbuhfXX1wI+M7+09816C5nLfmuwvY1dSuO?=
 =?us-ascii?Q?D272Gh4D5jOuTSXihiPjks+dScHUt4YPU4DOgFQphykTkl8TWZDtys6Gt+sf?=
 =?us-ascii?Q?gYDid+u5A/AZGCl5o1AzHlNA5fY6a3MwzEIqsVw/DMfEz/emxi8yvAsvFH4+?=
 =?us-ascii?Q?oWsiTfM3RoOfHGgvEtANYxrIH70OommL5I5I3PsPFg4gHX0ZXtGG1k86NAGp?=
 =?us-ascii?Q?KUSH/g0J8uDEen8Gs/ejDQ6UQ8YoR+vojC4sqwvu28wlkgH2lta7fYu6XWu7?=
 =?us-ascii?Q?IZuSKLpV494xMa32VyEcA36MeR7v5Oj6RFp7cv95AhaWiLpSjOUcqGY0TkAU?=
 =?us-ascii?Q?5uAO2tBjb+wtxjJnPhozSLUyNVsvws9i8NJppLF4A7ryht373s/HSfo12wq4?=
 =?us-ascii?Q?C6Gd1UQDGWrKZIORPmMBImKoAZtoQW/WEJanlwXROJigvuqkqj33ddWfj6je?=
 =?us-ascii?Q?N3DIqW5GvErKvE/HXKWZF6mHv9ePT6W6/Epu3IjNJEmOKqqPcgRWlkin+NZQ?=
 =?us-ascii?Q?gE2w5aOYp6WPRrvAfwzDg439JkImf33mFl0JtAFXz4pdU5C1f7QsvKHebRih?=
 =?us-ascii?Q?p4Ac+A9VN+KI6R1HtUy+2QBFp7I+Nmz/vE132fiZcWm4IrVdwG+fUc8FZI1O?=
 =?us-ascii?Q?OXBQsLyt02qxBKJrLivsrmQv8GKSCp9mY8/buRO31Auj+9IdSOqbJtUzUEBd?=
 =?us-ascii?Q?nqHDYnPoriCkWvOSLj5JWUm9lF0kFTrSSWnrAL+gt/NoYbyiCK99lXl9i2x2?=
 =?us-ascii?Q?bp47WEFYFFNrXI6PTKnYIUFhYzfL+BuOCwlcohbY65TBySZ1jIIkU3Qy3x+X?=
 =?us-ascii?Q?UI35xrrNTKsO2YA8sdT4OhX6pWW7EGMriHRutgqH/7rzPjKQ2IfN52aOI1DT?=
 =?us-ascii?Q?z9SZJEnA1RoVeX7BgNdZihWoDvdeggEMgmkZSBe27snPbYfciTwKc9KlVIFo?=
 =?us-ascii?Q?OXjkK0LNG80o7CORTUuoS/W/xp30uOrqlWiBMv08HHqkdHFkxwEtlYZ/7mm9?=
 =?us-ascii?Q?ENEdxsPFqYBZY5ClsFdXcnfsyc6m7ONToLoQKqQKbqipUB4cEbVMpCTzjMIQ?=
 =?us-ascii?Q?MhIPtl+2jFDEszVHl3M0HSmt6TCrHCmWdzEOiWOivQG+/X9SF+0PI0R/F9xG?=
 =?us-ascii?Q?aqEXuRbdfboMV/L+jV5C7yrAZWTADTsbANMBV+QGev+NkPo7200tPv9vk4BV?=
 =?us-ascii?Q?be6HF4z7CBxv/h+4HooBsJwhxEPkIUuX5u8gwB7PaaeL1ew5RdvTiCH4Kjyk?=
 =?us-ascii?Q?zi5R6XLrRgCGPYOFL8oZ+anYpHRfGGEgU9KGplit7+Xlr36W+a9siqS/on5p?=
 =?us-ascii?Q?6F0JFDIu1qPguq90w/eZpMi2WH1DpZJI1/gQnnlorrnmn+BMMvNlDhYPx9Gv?=
 =?us-ascii?Q?PECrSNeeAH1/d+toH+VLXQukWfXU4WRS2ivsV7J/PeDgbq+4lD7mLzuRllur?=
 =?us-ascii?Q?1iMxlxNTpQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9565de1a-cb99-40f7-f9ed-08de67b4b611
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:58.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpL4S/Wx09jQhudeiCqzMv1ahAQOajRn1AP8rwAlor+4RSTT0+kNnmWhVfAz46TnMCIAojYNg7cQ4w7F/EZouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index d4184fb8b28c..42bc09e48b80 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,6 +554,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -568,6 +569,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 55e2da094c88..7c5f350fe3a4 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1883,6 +1883,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1960,6 +1971,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

