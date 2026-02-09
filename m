Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D672FB630;
	Mon,  9 Feb 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625489; cv=fail; b=kAXifVGbMYXIrFLI1H8ZeZXZkGEOZWrU+RnKXRADfvecx7gUA2cZoCKfQXqc/NeTr2mU02+ToWRv4X1bMfwocnNi6mpRjbGT8KQVNTVdmZWyd4qKZWnVZm7f2lZgyw8SRRomK+FVSMOh/wImwuKnrdkqHMpVYnvX7UT2Op3uwCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625489; c=relaxed/simple;
	bh=c/gn1HlkPHMkjtsuvTDG57XBRjv8qGy/sdk4nwL5qho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7zw+Mpp92YVO9Ip6seNVJY3Rg8DiAApc4nTr0+uDI2BC7p6NDegkGqnv/V/1ULc/v5d7VgDr2fyAXcKcauxXWuYJliHxlZxd1lIGshyFKGMiOkvBstoKDd8zwLSe8vALCJ8BIND+SrR6DS9zptQTNfV/9nedRbGlD1q4V3LS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mj8lsyBb; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mj8lsyBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN20lowcKcLiyaWbL5fNu4qO33IcBdl7YJ3w1acvIHb/SQu3Sg+b9QU4OSkGYHFhvPCQJ4rAgGHUxPvq2th3R+qrkD5oe3lYkNq6hDAKaPHbccaffz9YLRXd7leK4j+gnKBRhkxe0wRVDGTf9c6BLxaEitfiDvMPjNtoS+R2206d62OsD7vFWx0KSoPo1YipVa6f87/pO4fIiTuJJSh3XH8bmh25D2RtnPVwt+N0YGdV5sgCGPfiGlHq3aV8+hws86tM6eezG7fjVm/a0aVtDeMzgHfraT61X+p8E1ym/KPmmcssGVth+L+BHdXfh48MyXC8BZvZOYxuyk660xl3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=BagCf8aFI/QlEt4PGaIpREiUpg8iv/awOiRug0d20IyE4UY1IIIa7x0EiT7hH7YenYS5XH1urP6pFYidkY5fJSiPNTi+hGHZSgdLOCGav5Z0+sfcgeUrZHi4Hvb0tXYkNBEJu5hwtxx0UyU3jipdPgsMNLPiUbQP6aS5yk2qPQgjNzBdhp3fDf+wT4sodN3d6NwawwoOGOz5PB/GFIIQ8LnSju/xvG4fAujaL2Oy/+SHHZ4tXcsnz/uu6qhR6y6jpUG4b9jABGHgh0A/9ZobnY1B2rFGFCm7oppc0g1gvoj3MAeaA3rXxciMj6uNaRdyBLnsdIvlAIGErP6fiHUxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=mj8lsyBb/T9zmor6f0XPlc5DboO4lK2XsHrc3KHieMicOcmQHmXgP98TyMjOEhJ9Nljq6ueNlyzdyYGW7TPYjOYKcL/oyVJH0SZbu4iFyliNWr4JVTblaIAo17EN+emY3YxFJXpsdegu8xqDERnl7wx30PauwzpUXFGBDAhwPwBAVW7aThYRuF+0e39vmyMpaGlma6maie7RLo60RQpctzJu1MYBW2Mrf73xOe2CnNBshUhs+xM94ClXOYhu7XEpnl3TrLT52oSOG6SdvQlb9rV9XhhBZACzhdELd6nIptQ68rNIWlyyzzV/cqONuA0YrmKoW65EEiynzlWVuE4FDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7180.eurprd04.prod.outlook.com
 (2603:10a6:10:12c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:46 +0000
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
Subject: [PATCH V4 09/11] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:52 +0800
Message-Id: <20260209082454.2097628-10-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c869250f-e2d8-42a1-4d68-08de67b4aeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Wcm6DEScOQ2VTxnzoCWz5QN6QMDjyxcBQY+sTHrD+TAuVs8qdBLZAIb/32U?=
 =?us-ascii?Q?QUsNBk/F+VFbjjcYIuqdPgIjAKxrAbi5ca+mc+sjaUSFd8vd65bXBkyECDQJ?=
 =?us-ascii?Q?ogq41QRZnZ6KCb4+RF4J9Xz5TJdZ94fOOM0W7RcH1m0XXq9GYO3LgP6Y6qf9?=
 =?us-ascii?Q?jNlfHfXZEZf2r50FK0bucD6nmIXpNStxpvo74Kp6TXE1fNAmmMhgmNxFBKIo?=
 =?us-ascii?Q?3p+M2Sw7pmhfDlgb8fWzsMz0+ylx1OsASjc5NSc/sogIEDdnphODW0rvzIoY?=
 =?us-ascii?Q?Mp8ISGarHnzTYRE9x/HHmFuq3TxCGOX/GV1riaSi/olpqHZYSnOqJdM8XV8c?=
 =?us-ascii?Q?ary0v6YmJu36w1ftVuYMnsbV6/7/RqEKjhe3lSwXcW9QHxjM/YsMnvq0Eg3H?=
 =?us-ascii?Q?0skKS1uPD/3jtgnj2L87gwGciqFpFBDww7SrGz3nIQKQ89t/aDetcwJREreB?=
 =?us-ascii?Q?4iBZxX6xaUeOLPozJoU6M1lW0ZR0ltoZCIugkIGtd1pcFmVPYSV5fbDcs/OK?=
 =?us-ascii?Q?z4soNGtXMPGREyRx4MM6kc+miYcpaIYN0EvlaTxmIiV4NIMbC6zK2WRdWPEW?=
 =?us-ascii?Q?yrquCuwxK87w5ZRqW7hpi77/yBJk6RGfedTjUNl6sgYO2V+4jYsf48IMq7/0?=
 =?us-ascii?Q?mh3fVMU6VU0nqlXroSjPp+NVrR7v+L8lvwekYoTgJijxV3u7n6p7cIfjv8X4?=
 =?us-ascii?Q?aO0Hzo0781lgOD2cSEYe896TJIYWewbCc33KYnfCNvk7bgZeeInvDInZhIYF?=
 =?us-ascii?Q?/9PDCEPPOCF+YQlOEWKdnok5LMPbC9pMlOdJyKeaR4rmN+lWKdH/dq9cF/g6?=
 =?us-ascii?Q?ms3G2pkmOh5sXflXuzNOE7Fch7BZ2/iDWLpZqQuf402YThlnieSHDGpMshYa?=
 =?us-ascii?Q?sr6OnDbU41GIlmER1jloC0bQVmMfT26QHJupWEXWmH4/t7Ukmf7896DRNE5/?=
 =?us-ascii?Q?0JxI8QFaCjUqT0g5tOhDpXOTWE2ceXQtoRyt6OTOjiw21hZWraRR9g7+AUWD?=
 =?us-ascii?Q?0Abvm3zOk87PhHCm9Xu4Uu9F3SmpSnyS+dulwRBghPz3yZr6RjHkqXLfG6qY?=
 =?us-ascii?Q?wVE824+KKHntj5Zixiuid/mnpg5CzeGcls8NaBphNncVnqadSCy2AMcM+cNo?=
 =?us-ascii?Q?yR0Iyq8BIGDb4wLZytsR0H9DkxwyBnSt6EWFn6zv28IPACmuchQsopDwqpyi?=
 =?us-ascii?Q?jJkRWBEOJnRqJ4w6g8hPGudmgGTV4jSDi0MsqwBTOV3vSSARmnqcpiEvrE8j?=
 =?us-ascii?Q?/arWY+C+yuvyz4OLrfku5TuGb6zbFjKq/GBfh6FzRe8N4w9B3K+0zYveeVRg?=
 =?us-ascii?Q?BZ/RUTqbjZzD02HuO1mPjWMApkuU/UWu34SaGTYMEL75w7t0u36TMFC361GF?=
 =?us-ascii?Q?w47+ZfpS2FMm5wBudRmLjBepSKimChoXw7mQ5OKreglmI9uik8I9S/3UJsxi?=
 =?us-ascii?Q?ljA/dEX7a9G/aZvJnu7YhXpAnuCFEcIZDuYS3bnq/tR7P4h2c+uacfggXx5o?=
 =?us-ascii?Q?/gN6ps5ZMqMaCy+8XPeqMi5HemYCvKvNvG9SAtAdGxA9uiIxWS0ZBnTbSjnN?=
 =?us-ascii?Q?uaOw+Om7ly9wmx8KUDEbKJfh1kg6e3NpqsWjtO7V6RMCqZ15CV7yozX0e+lB?=
 =?us-ascii?Q?BWhSESumcgOjq86y9pLIxFiIMB5lKSER5E0ybt9ul9hM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?By9NDZMKAVUJsf7BRNm/Tv34s9qOXZ+KgWRTorjoXKcLjCsQbpjyMnikvVlZ?=
 =?us-ascii?Q?jLtDZXZ4ECaj5hBwLzRphRbdsArt2FCBdVEmJSvE2h76VmXjjxX/6bEosqq1?=
 =?us-ascii?Q?JueQWHqGzgPB1INeKqCl3PUEd9zOiwjpUpSTmYEHZEL+4jn/UL0qObHTpGfr?=
 =?us-ascii?Q?Mnk6kMaBtofciftkq/J+2CGznCcSs7vR3kWq+7QrIWSrVLSzXe1j8/2zyYTT?=
 =?us-ascii?Q?XxEdyOH3X/MGBBsg76SyQkiveJzz05BIYraHxIKYycTuDTsmijlaRDI6UjOo?=
 =?us-ascii?Q?22zetM2Sq+j+VEIoHTDCKQsD3cX831YoSnDdY7RTH7Vh4CbJC+lDCRZmpLc3?=
 =?us-ascii?Q?VzZz6y0q3Gt7K4PjFGsKH7oCIjPCZZOJwNqu2UZ0kQf5uJQCc8qyPWP/re+V?=
 =?us-ascii?Q?WbD67W4Xb6ciHenG/HxqwLh0wlxu+YmptNiJWDByVTJ94oHeGfRh4Bnz+Lqk?=
 =?us-ascii?Q?fWcIgMAUlFrwLeKDqdnWEUJDE8FF7cKXnw1J+1/chesRI9syNPGWOvIUH0QP?=
 =?us-ascii?Q?yQwwssKHnTiM3NFdEGvJQxFZXxWV1cGoFGVxRBu/RnnDgoRsJ+Tksn6Kav8q?=
 =?us-ascii?Q?XdE9tSde98brUEor5/zyOc8vyYId8m6yQobrcitearIlcPk0OJRubCwGt3+c?=
 =?us-ascii?Q?bjh7oFmfE4Iz5JbBeuSn30UzMLSMSNgpJOXRdHmqdvFHvpKCKlJd9pEaAyNp?=
 =?us-ascii?Q?M/YFfXeh+4CUrK/JhBFay29a2mIEH7jf0ZIzbn8joGalzWrSFic1vNqZjnlT?=
 =?us-ascii?Q?Lg2a1a0Gslz1ngiAW7gswHn+ul3amUWPrIiUy/cH3ObSOt1qjsMsuFvsqSIE?=
 =?us-ascii?Q?5b7bVEUMUlZlPzeEMsUjUhf+g2Z0eTfnzOynSHJNz4J+NHJGfA7oJAFgC5pn?=
 =?us-ascii?Q?Yyz/EhlttC5YyBS5DLjeYdAQWU4wm6sKkMsSd30yP0dqO90G4fVU0uVsXQIZ?=
 =?us-ascii?Q?oUkm4zA5wSHDKX6qSYCyxBg3xwp9Gy8iX3eckTxOJp99ZjPknZI4iMbZv/YF?=
 =?us-ascii?Q?JOiJuqOskRRvLH+vp1OlHbNLJ//Z+/mxx9ayifXcSk5KYWv4v4Pn4eSJ8Gtg?=
 =?us-ascii?Q?hiSQlDLrgAuyNdPBcXOONbQmZBELeb2nc9mAf7xid4OG3TgkpXwsSos0iQAq?=
 =?us-ascii?Q?/Ed8YmcMXQgdthOFiv4qknHLk07Mh+luO53hI8X1Dft1MTdbG6kmr8ZhRJLt?=
 =?us-ascii?Q?IdZm8T9uTKVso8oSDrzALi8YBaOc7A+VqZcoTAcpSclFbxCyXbSYTm/EiXM4?=
 =?us-ascii?Q?QAlgl8121HimVCzP0c815lWkoSlm3RxEftnP40Aya0lqdraIe9h0ze1bCHd6?=
 =?us-ascii?Q?sHKoFXTKHSPmygAp/aJKYs3iID21f4U4o9vGi2Wba6HYbvcqJGIiwwEsYZ3o?=
 =?us-ascii?Q?hIx5ve+KSzk4KfFEhMsZ48A1OA8wVN7RwBMqPEUrS2tLjScoBZ9ka/W+wTEN?=
 =?us-ascii?Q?Ev4Z9Hi3xYQdT00cvoasQk3OLYIYrtj6sbAtSVjTPys3mF/LuprQZ4BURDBW?=
 =?us-ascii?Q?eMqArOM3nD+nZCzScIWKskNhoZoIx+CXlwdGQ8p2AzhEgLJJdnWkYcVXfND0?=
 =?us-ascii?Q?7XFj11wRn68kO4qNtOad0BZRGeUQQR0IexEtyebr9zaVWDxgvna2UScbN4+v?=
 =?us-ascii?Q?JiWfjvQ02PAGjVSElJHeQaSayrgmLzAVA9wrZfNOOwjHLwv8YmU31T8zeHzE?=
 =?us-ascii?Q?qyk8+8ZBACbrei2MTxoGXGWgzvyUbVemV03EKslEE2GuSwpiPfPXtE8BKgoE?=
 =?us-ascii?Q?ktdHZUP3OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c869250f-e2d8-42a1-4d68-08de67b4aeb3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:45.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM9DmHyOINUXiNMZ/1i0DaApT7tn1BoLaICR9j2cfnNm2BF4pvmsGib990ltvEbI2G9S5rXhf8gwwavqgOQnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..de2ba4ee9da6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
 
 		pcie0_ep: pcie-ep@33800000 {
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

