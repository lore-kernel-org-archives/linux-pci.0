Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A842F0C78;
	Tue,  3 Feb 2026 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083780; cv=fail; b=fmNsx/Pi+hnKljIn0cQbfRyb8QEYMSJ+XZ8hZ+2xkiLyShRqCcEJOrOHru2ahwCbepVeqEn4tMzqueFUhOx4OQYKJI0ezhn3pP4XVYw0UufEqAWw6uWzXv2eiHfhxoodxZtuVOK6yLW0fnKn97iRWuEQBVcTGQK3FJIAR61aBb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083780; c=relaxed/simple;
	bh=AAkUszj6SPnK2uMoevOU62XdwWErsKVAqBVjYvH/RUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7gyUmrDUrpEvEKbfIwgGWmAMoBkUH3lWr/y5JOkqzPBYFaQQm81InKsQkS6VSyfyFG+FyFllddqqpkAkch0ALWSoQt7SgY6wtwRe50voA1bn17DnypGFoq4xXVtPNQPD0UqwyE4cRXBhiVImaD8NYsKMCffITNRI4hLa4z2wrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FOnOyxX+; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOnOyxX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kju2JnXquzHyrT4pRPoxPlI5dwJpSsUGztQGXY0muILi+RghOGllFwnEMPEpxhyaKTi5vJhZ+5RP/kf6mVFZPL6aCYnzoFAMao4rfG5iuaJxY+yUeLwofCcxLuub7FS2RDMuW8qmiZRZM7g+pd0jVHpHrKuILqFYJNnKDgVOCKqqUnXLLMqykcK4YNa072y9YU5keqYBvOdYkERGwd0QEoqnlIA18Bhy5gKdpvzaeLf/KUakJ03GtHAe1FQoGdFVrKYfM8WlCnnbf4NIM1rAmItOkgU3IWKb9+9ZxspoCbPv+rBSZnXnfzqQGDANDEfi0li9wKrPc+tB6+H69YP03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=THIbtCkhBHiAT6U1ttwz13jnIuuUbBURtUtkDqpzDS39oyHgJ6IE2g3UrSX0c1SknpvJaIIwV9Y/04x7sKSwNgbJav3MY19NjNofsLCgaPdAEBYpJ+jayIp8clB9gQpXBPDrmnHesmmaieWEf/Lyr0sBc9nkxyoKZMudbzvv4EqjfemswUZX0rmyjRbziTEBtP3vx5hvvSmHrFjhAVXHhl38+B9IBStfT/CHfswFExqikmUB0v3gQKMR5cSEF+AqbDyiWraVFGYbjI7IZJej8+lORcPI55eBg9f2jbfY7WVQIAgXXOONOC47vSfM/FAwGCpBERaf31UIsR0oMi6NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA6HH3oT7NxLhdanoXDLc8ORR9yhZ3AIV2S3H1AIpj0=;
 b=FOnOyxX+DYRBTDWmt3xw8Q+yxQBHPoG/Fua3pwCOjEFHe9HqeSkIyq8lgRrPnMtqWAu6JeCoMe0KI5zQ1Zl0zjeZpSI5/CFtF6nZFs4BtiEEOqgEPEcTzQjSKNSeLTF7OF08pQRTO78YByfgtmygdy9lwGOe1GQAVkC+wnhx0udTrx/rjaB5od0fK6bQ42qvNySIemccyqxs+HgVOU+3LXMZ8SegVmIOmDyHsYVIjNd4cP7c+RI1kU4CjFY7ssRl311K6AZccRwfESR55q+QDv7YrGJQrN9WtSkRpe9wZHv7VShRrPv8Q+RFB17C3XUWHA7mVTeRoD9ADdmup4CgQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:56:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:56:16 +0000
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
Subject: [PATCH V3 10/10] arm64: dts: imx95: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:14 +0800
Message-Id: <20260203015614.2957479-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3096ab-4f54-4eea-8524-08de62c76a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxIo/HIH/D+ODraQTd5mKmcuhLU57EkCQPjE5YFk7F4SDnEIM/mLM7xDpSMN?=
 =?us-ascii?Q?LZuyB8xTtrVufwvqC+I+kYrYTzIf6wASoBYbW/rmPiBe5TbxplH4ZaAk5q1N?=
 =?us-ascii?Q?5mVvLyQzdmC6vATBl/q/ourbn4sVLuOD/0uukY++D7WDabBIDEd+PmlkYFr6?=
 =?us-ascii?Q?SIAm21amPc6fIflBqWCzTpjw771mG9lDHUUwFsOW2r8AsD+o7/1XYmvneWKN?=
 =?us-ascii?Q?AIVQzfImeGg/urESzU8fx5AuivYmHgXegaD5d+9PkDXzXCfGffrsmmifdnSE?=
 =?us-ascii?Q?D0/CLYIdsSIW2Pfb5M81oBNdv2CIKllUbp+VpjjGlIDRvmwzG+qeJ2p2YOZI?=
 =?us-ascii?Q?eKuupAdK8e+RMFtMrRaLwH8gkxzZgWRatkzYdsiGDh37eLGaxMaBt6NX9OuC?=
 =?us-ascii?Q?y+MdLy9fKeqosYGuWvy00BNepkg4kGDAWfm9kwKq/Pwlj5WIuM64/exa1pSN?=
 =?us-ascii?Q?KtExUM+khAh/fbleoeDJa0D0yuJq6OnVUDsT+jYLAzqCw1bmUcWWVggNs2DN?=
 =?us-ascii?Q?36rKunZ1t0gvc1TGi16nBz++F645JV9GeMH1SafeUVODujh2fKpbxOgpOe5l?=
 =?us-ascii?Q?NU/K5FajadzDgDUC9fFn9cknBGhKT7uvnC0Lhr5ofuRN61pNDZBpycRNKKAl?=
 =?us-ascii?Q?R2RM6HzWudCSx5musTcm1JHOAblq2QzkXn7ntDyH/kqrQWJnfzweGZ8QXalU?=
 =?us-ascii?Q?EkI9lvp2oglTUbsyqpJ/QvHgCE4S9Dxk+WgXKBU5zfYB5TGHSsp8AO/WoVYB?=
 =?us-ascii?Q?dcwuYpyeSevoEXo6fFKuGWYHXBwi/zYcDNIdO7vWqmHpgPnZgaLkXMBA0TLJ?=
 =?us-ascii?Q?ckAbHxdSHMBHdiZb0cHWmCXgopvnrS8U2oSG+DhhTCp+KPF0ssAUxEeh/XLs?=
 =?us-ascii?Q?4t8OMNrgoYxI36/ZhNHH/s3NA2eXu9Pk+cuczzAmsLwEd9VA+hNf4ByY04mL?=
 =?us-ascii?Q?5rzeMQxJmmKqMOliq/1ZnMCcRSz8nxPKN+Q2fU/PV9AgqCKhi2Gz6fUvOx4s?=
 =?us-ascii?Q?OUGvuQNDIZssmxUMQ3/ta8F9gWvZ0GVpFeSlGQBUNi8JXaRrT13+1ndEJsP2?=
 =?us-ascii?Q?2xK0Pd7O0rlLcOy0lAZnGbbtM1Lbdx58wm97tuiRRX4O2FenmETs3u75OoxL?=
 =?us-ascii?Q?gfQeQOlty5qUQIfvIXtXr9TbakYe2tDWXO254FC+tE3NBVlJnzOjRK01OZO4?=
 =?us-ascii?Q?XlKw5qXZIOkRQmSbOXIb6xyN+PcJ6lcAG8j6nk76cQ8vlfQ89axyPVyOSslD?=
 =?us-ascii?Q?zwNzHm0/e818QcuHHoeH7LFMFxcbk6TugY02fQEkWrm1V/Arogk9Q+QUjkSu?=
 =?us-ascii?Q?LV0KHjf3NFXu5QmLVvnfw0lwWcFKpEOhqVp7ulzI7YZLiiNJd8nLxgHlpR4f?=
 =?us-ascii?Q?AVg3y6jQtt/odd1A6cd80V5GZ1FY3a1KN41QGz/MSTQAAk4hSBGGvPJP/eNr?=
 =?us-ascii?Q?Dv/rPttbp7wbusxXQfW38lO6TdJVCiDLM9E9aXKxk7vyQ9Hbt7Ihr7D9dBZ9?=
 =?us-ascii?Q?mAKYeSXN8IAUg2reoVbXuV+lp5GIUI8KoOSJNukHvBXCLYgoD2gEchK55iLd?=
 =?us-ascii?Q?GRfv+dIVLiw8QgT2YiRg6NYa004fDro0RYvfeCwBwpKOyVTMvF1NTcsFl9Hx?=
 =?us-ascii?Q?MkDTldgPosS++zaMkk8UA9h6n1vegrVe52uJytvDAWSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7W17zBbDEJ90Gdl9XSBxmeIJh0LqGJKAoa6IPQBTdyyNdlt7Kn9QgScmn9kx?=
 =?us-ascii?Q?VHb3xnRPXoHHs7ijjG8i0OHcqn0TU9gtYYWDILc+QQPlgtcJziEAw0ym1Hdr?=
 =?us-ascii?Q?IxesSZkfb87G1iexnZUgEHBxHRN6PWSwnbd1E0rEkE8aEtWT1rDQH0mElqS8?=
 =?us-ascii?Q?NepIQucQkESBTf7mGz8syexDh5p0g96NAiY06Vt4NaA07+aiQBbjT+1VdSzc?=
 =?us-ascii?Q?S4sYyLi/YPWUJCVmW51ouTq8ln7dDGAH0bvyRKs6KZ+r7Pjj64VEkvdg7NTm?=
 =?us-ascii?Q?80dofCZR3be9Ss2DH9TMEUKiM+lksgQcyDSMwEmRtPbbhxk0M5sbgonryTfD?=
 =?us-ascii?Q?8eCv952n9+wLR8QYv2EhQ2v0vZFR0cOeiw79jMrvQ5+uybOYah0bDvyvptt3?=
 =?us-ascii?Q?0odL7/1vs2T05YVELpg4R31mLurzgILb4g9mN9By2BfimQ7iTCZx3LQzYzls?=
 =?us-ascii?Q?sx0b8P5LWsSmDLB27mYaR7LtH8bPSnq05IDdh7ZbC66Xgu0tFP+JZArR69Bo?=
 =?us-ascii?Q?7AQm0w5v95sJobNrUOcWFhQv7Ph92opw2cKa9Kt49usZooha0HlOjbc+NROa?=
 =?us-ascii?Q?flDv2qnC6dzuvYJqD0WPYLL+OQOwybSAoCSBh2ILNgDNVA1vpABRTadqIlBQ?=
 =?us-ascii?Q?kR8lMILvJn7ydmkZ5ojJj4YMUcwwEOv6Pbmn1qMLLBrdcLKiM1+wVzgSM7q0?=
 =?us-ascii?Q?REl2G7bYh4uBpg+9n0upAH1HKUoKaHD3Uh79uamDgQ0fqWTnVU3ZcrbkkLG6?=
 =?us-ascii?Q?mpvkQGDeobNrKZx8s6hO90hUrMpgZGD14crgtqAsm7gWyGZjCQEx0AzCcDkc?=
 =?us-ascii?Q?snnD4kGJWH7yYBC/MRGupwc4H2BLPMT1nUfyHnUBaSLubEaYnG+rLIPvwZTi?=
 =?us-ascii?Q?F1rYNWJiSRd3GZYukPUgH/uZ7/t/XTW0g4f1y2vYwKGTcYrtblswqNJrc8tz?=
 =?us-ascii?Q?lNyy6PAu6Em2EEJRd4xMdJ4ShEDO2PNr8SpDnL2H1T8VCw0cWr6vbb2SO0lJ?=
 =?us-ascii?Q?bYYSVEMJFWse3zvhAOnGHfsEqhT0j3Uny1DrPfMmjH+mLOJ0z/Gvc10u5vNh?=
 =?us-ascii?Q?mci7FjYjDmzXG/AgFo5JnxZavXbfRjr70XY26QsX5l01G/Hyw5dvHbm4walg?=
 =?us-ascii?Q?+5bGYwHlWl15rV4tcZK4IWR0JKzV8bUbruXznEEkw50GrmGNifzdb8EAtZ7o?=
 =?us-ascii?Q?WXozCJm9hOpOnibI2qRYOhEG5Bf9lJhfh3r8oGXOociLooMKnHjEylwHN5UU?=
 =?us-ascii?Q?LgddK+5du6cnAyAZZRbw2rfBXIMB01d72cRxvi3hZw0pgQhyuMvbMhQBNLQJ?=
 =?us-ascii?Q?Vuz2jNJy087ijXcljgODE/Zk7bj+zDO8p52sMPh++YUeDB1uc4P3hCRv4RmC?=
 =?us-ascii?Q?XeU1mrFItFSdPrQrQL6Jzg9l3pocFjovqsBr/nLO6cxo3B+2OcoLsKgzl6tt?=
 =?us-ascii?Q?J0YQysqfk58IcG0w3W6Ra3haeM14vH6e9FO6K/udIr6jkSTaVHkh2UXtiq7g?=
 =?us-ascii?Q?Pc7/7ulRFjXc3hgmAxNvq2qUYigGE6S5Nm0DAf2eqEOzmNI2fjcNlWIxKQms?=
 =?us-ascii?Q?nA2zxoBQ/ITaamXuU90iVUQ6RQ7L4X8xPqqW3JwkdjOdpVgwOnV7UFRCApXj?=
 =?us-ascii?Q?MkZTaOjuqStGX3VAx0oF+W2maQAiU6orhuzw1ZEi6SCxDz1mMsZx/kelDMng?=
 =?us-ascii?Q?kjVdvZFrXlGjs9l3q37yyEhCGUMgaiT0WbwJrsUgBM/0tgQEHim1FNCJoEq0?=
 =?us-ascii?Q?1NeskvSMjQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3096ab-4f54-4eea-8524-08de62c76a95
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:56:16.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8251iaWcGwlBoCJTZvcz59gpx8wgMvFDD2gjbYjKsMtIm3bv9FzcGtB6uylWNbGyApKMD/yH2bImeAAaJ5GK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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

