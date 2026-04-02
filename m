Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53603C873C;
	Thu,  2 Apr 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124588; cv=fail; b=pVauKR6Lfx95sLQesPqmmmCjE/QoCyio+WeS/LNNCYc8vrNBz7LqH3OB6QJ/XXO1jBTOS39Vmx2kaYwJSAsm+vxwjxizgrrDOLmXLrNweY8JftJqvNSuiCdMCYFselcYg6ODYmLHeTnf5fEXlXL8BkXW0cTPBGQ0AA6UCxaDlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124588; c=relaxed/simple;
	bh=l1+lF7phMLsmuXb6+thzu+v1gKazkuTTF/INQMYoqVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4ngaL6MWn5H9ZBCaxL2z2GijzSzVGLEiq92moPoFrwGWX5K/8G5TpzcfxYp/ubzgTeCymd64J5xtz7q+vJbrYGnsW7Q2aDb4MZWWBmrTMnBFapUaiIdw70+1gmBZOHOU/d0j+oNvos0ivb8HRnoh8jHlp+0MgKuBDqpNyxos1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PPRc0b0f; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPRc0b0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2FvGg++UUvCl4S957hGLVHChr3gr/ETJDL7ye0zyu0ZZcZxWYbb0PVqGe4SCVsHUejHlXeDeemu8toYMEkCCWW+b7ZdI/bsfVv88XPZUevZnL05cWWNEq8toYs7Ma4UFk6YDCxTYOVlVvJVVVI7XZlsBVpBK/X99GlZKYcgre8mRrkY5rF3QLsHW+vcCWkJC3NSHtq7H95ubL8DP1R4Ja7CN+45nX9qVwmmatZtx3Dt5Bd7ABlaiLx6Ob6plpc0rGkNKQjai07vK7B06WLEhuEFp7lx7wUtU0qV1M1QmukLF2dlmJtVU4v9aZtmbXmsOB73dIfZhVo5IA60opWVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjYY3j5+JrZZ8ryZAy2n7rdlCqQ5n1qooJxAKTwjLgA=;
 b=CSCnHBaAr9cqNk/fBIanmVQG6syIyojYezuOZAl30NSSlFxbeJ/Ub2IJCDzgYaB6SRssRqlWO5gty8wfQq1lcpPMJEVg9ItsrFaw2ylR68P4urxuCyjFv+yt1RAoJNIzB88hv/q2iyMdWWwSHOvlwX1UMJxrzCzFepgJVyRl1cuZYnEjDv+jppsYnzoiewvzm3vRJOOaEpc/dITKzKsy7irS1ppl9emRRcx5nNJM5giEww1vDAd9hTx049XVtmaZGg8HLEbGxMhZ6gSg0W0a6Jq6GwbSQ7tXtTmGddjRLLfrHm9QLZbGj+owkYK9ApgXxG+N0dtIOVtVwAC0YkDxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjYY3j5+JrZZ8ryZAy2n7rdlCqQ5n1qooJxAKTwjLgA=;
 b=PPRc0b0foyBNsypgM+k2FdCk1d89oVGiRJ2cixac8EDPVwvt8pXkXHatb5tRDhTpW1ECn4c2aeKclgTalvy3VsXBMHbb8SRe3MbJEihW3PeBPSXyz4UvLd4nGebs4n0YO2xVBCGLGjKNXAUgaSl5UVzEbN6eLfTNj84z8hbGl9BWttiu9y+aIari+6Zn3axPkKJv9CYd1NatF2DfmyF0WTtdflZkH5pIJDin97BA/Zlbseo8H5Wm0ESCTJHbQJfeVregLov4/6gdKKumV00IMiRYOlj7x9dmUjXkMd0GkRTqVN9S5DAUV0kkKsC66dfUkSrATxH5LS/NcA/Zv5UbmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11944.eurprd04.prod.outlook.com
 (2603:10a6:150:2ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:09:42 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:09:42 +0000
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
Subject: [PATCH V2 4/8] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
Date: Thu,  2 Apr 2026 18:10:03 +0800
Message-Id: <20260402101007.208419-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402101007.208419-1-sherry.sun@nxp.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cab084-10fd-46fa-5207-08de909ff515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7j/UGhp+1eRoblrQfnVR7yGxpDy9846KcM78fmj4llLNY6ip/ufu3WNQTR7LQNm5OjN23kovR6a+obxamuHetXlulGbzqX3JFMdRouCLFl7bzmaJ2uEZoY21u7mseHBFelLR6DlInMjK1yZsqUO15Vj7p24l5SsEyd3pl8WlivE6D6k0WfVK6iXvZEZCsXgYeDB0Rd5VMSjuKR82f/+XWAFNeKssmf87bO1r2+K9SUVNobaUvGlt3YqrEE0tgVk9fzv/dHbwFZ+3WthHIBQc9wCr/3fwcphoeXGRSOHMm9XjFJB63Nw7FojQZLDA3KIj+xNliEY0BNVXMd/zCyFaROBu36lidI4dm3JTW4o9/UixdDZCaQ2MQi1Jfe7Rv4NbhvXaVp5sM/Oukm0no8yGZFpGNvg7Md+9hiC6UE/IwXzciG95lAgKz9QNUavsL/SiHhYiGVq6L+tjH+gS8pcVP8gp7UUk3DyDiPtapa/Iy8/OuQ0+Mlv7132tcf0rM8XXLjsVuH6ASw8RIXIkf403u289m1HMc/zcY1bw/D5CqFZO6XoyIlqIyp/3V+FCfYA0v5uBgGSKV1prkq8wh912dg1vsKTjFX0wiY0khDBHlYj+HI6VcluvbbWOyzhakzc0qTKXgvElLTjSfUei3XNI4bXaeG5yjkPQjmiSXNmWoLgbBtDByFwt4ZVdIBh/n7Da9D8dICIDtJn3fOT8XsD84DMwsgKwvDkzwezGYcQ/fj3nEoBU7pM/pbTO4ls8u0FB27PsE57KM6oqGFK/LWoJbusGo71F3VjBW3DtBlqrO0ABdlPXjcSJYzHrDGBxuRS3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6wiBdWv/IHtFFJb7ufAI6mBtO6stqeWrZrEidFTp3QbS8IXCw3haGbQr6tkk?=
 =?us-ascii?Q?o+nwSv67Z52N6bxeGJnTALfRrBuvjkmH5elq9b+9UQXec6z0A8Bv2rZco6eo?=
 =?us-ascii?Q?pFO7DFBhV1r6gj3vu93s/7ud/Dp5MZ76/BKvmGxVLgD91Mjt61DCc99tVQdf?=
 =?us-ascii?Q?SVpb2epZdvPaFPJIZ8+lLws50iAeXpxjgyAfpVy2VppSgL7pXgNg9KFnguRr?=
 =?us-ascii?Q?LzloRs6KLo/unRGy0Wwt6aClBiSDiv9dfcp71RJkosDKbUFyU3wYejde4mzB?=
 =?us-ascii?Q?8SS0L5hkKBmjCLCICu2q5rvuG1lYJAnBQrqpoBaGwvyecFraaMISdtFbv9Sk?=
 =?us-ascii?Q?IzTpFkH5iQMsF4YOhs33aGZKZlNqd2IXUOwwtIuooA9VMslq18Il7IXPfLSw?=
 =?us-ascii?Q?XeNL8Wh39XaaxkDEXEeJQ8Krivnj4zWoFIxqHWJI10zakr8jQzZYTSdZWb41?=
 =?us-ascii?Q?JUCLTgg/Nw8a0TBEUDNXWnhX139llAv7nPoJEsTZJcsoSU31ZTvP4wN6l9vz?=
 =?us-ascii?Q?0ihcDa9R4v/oYm4UDNl9Q0VKzW0KQC63eMBXF0P+RbPcbRAeaiiR2L9cUJ3t?=
 =?us-ascii?Q?1SWCi3gAREh353o4dRnR0QZm0xRPSGmmRfKBhOw9zQBK28gijom2JXo4EYBf?=
 =?us-ascii?Q?RcWNhHmyIz8YO5kCPJgU2LfNYPAaAGBkzp/VNN8vrMEDgF6YJB4imWJoY/oG?=
 =?us-ascii?Q?u6Ttp1k+/VT4dV6CRyiJMm50QN8DjZA8di0rZ2ldJBSEXAI9u0py4QHCLaos?=
 =?us-ascii?Q?66TrJUQg/PF/AtbMb44lB85at2TfNeTb2XnBd3+7RTt1f/V7tdBIsw7/iyp5?=
 =?us-ascii?Q?bR8G4aoY4zLPFc0dFVCMBY8T4h8/+fbo7rzoyB1w/DZ3y61neNRTCfRv4X5z?=
 =?us-ascii?Q?hAHDgM3onrlePc5J9WI2IK09qn7/IhtZQNnNa+WMxya0focD615Jm/iooGdd?=
 =?us-ascii?Q?+M27iXd377GXk+OCQSBTnCPOvHirmu2HrImK1iQTDhi/GAWdpyCQxGiJv0ea?=
 =?us-ascii?Q?DvtQFaUFmp71TvSXZAj+gQeOR64aZ/TDEyPAPpxmTz2LHpzIG7L+9GNgajth?=
 =?us-ascii?Q?gOAf8GBoGkKIs5hb1+aGSOkFzU1qVfKkd0Fmx3kEM2pnxYthrM5N3Cx5soOT?=
 =?us-ascii?Q?Tf5PCqglLyml50CKt5DnlceQBTHwIFAALhqWtA4Dt1B2LSwC8SsHEjjpZIum?=
 =?us-ascii?Q?vrTDZT+VLAB0QGYuSwmO2/Bcld0ZZUaI3Wpbrz3SJFSVtAOWjfnc13oNocmi?=
 =?us-ascii?Q?gmXJoqEUC86DTZU1oo3IDpyn8IqYXJUsKyBw+ETZ37/5hlfqLNSV9oujTZ5j?=
 =?us-ascii?Q?HxLUNHFjD5ayl1x4CKIwfn6tjrlsS/8GxN2FlrNLZytnnxuQAf6hiy+OPhLM?=
 =?us-ascii?Q?Foq9LAqFvxoB1iBafjWC57odDu5RzBniwMBlOsouaz594btlh3aHw3aifsJ+?=
 =?us-ascii?Q?NnARzq156pxGZ5WUpHdnniKQio+G1b8NYy4na6b/bQw/fgnQxi5QcDEqpkn5?=
 =?us-ascii?Q?gGQ9lY/3s3+koS8Om68qQzeTb6K5btjE5EZxzmCVt9onCD6rLEkjkXlb5cyJ?=
 =?us-ascii?Q?hNrCra/tpOTvu7rKT/BnbYHvAU8B3UWXOHQ2okzLNeYb0j4ssCJap71VT6qQ?=
 =?us-ascii?Q?Rl46Btu9KflPi9OX3V3jU98dkI63RCO+Dfiz6GofxFhw6+YznXU1alYuEhTc?=
 =?us-ascii?Q?hyEYOiGE67Nz4ZOR6vZ5Qt+xVQSapcP4ebGMlGvFQq0VKE9syYniurtTzO/Z?=
 =?us-ascii?Q?4nLR2qIvgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cab084-10fd-46fa-5207-08de909ff515
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:09:41.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jdZEFyD/dDJ1leHK66hrLQ1Z1XKcj1mY2YEUQufb66B9vQUel7UHnW1E6KTtIFonORdiBkhZmF2u8RaGGzMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e03aba825c18..ba7fa0815d13 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -542,7 +542,6 @@ &pcie0 {
 	assigned-clock-rates = <10000000>, <250000000>;
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -562,6 +561,7 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
 };
 
 &sai2 {
-- 
2.37.1

