Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021094.outbound.protection.outlook.com [52.101.125.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA02F0680;
	Mon,  5 Oct 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220325; cv=fail; b=HCQ7kirawsFhFaxgmWyaRRtrvSzB3RdH6aPx0k3NLllgvQCZNwJU71U0uSlEmUZiZmMS8OryV5ojgtUCTGt0IZqALP2TspEleD4H0MxCjk+o038t2xhGPpz91ikeNiTMrF1wBItTcchzJrpSe0FV54YSwR5W35q23cYPmCoDXsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220325; c=relaxed/simple;
	bh=15VkQGjMj6NHwCkjlaJE6dxrmiXexWS40y4nYxgDqi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O37macIQL+tMiWZOuq3TwOqCbMOJUpzvz6x3DUp7VmFjkH/1N+GoaarT93Jd4qYWuwgYD6QqfAJ7boCh4bSIsmdVufzftWE4bJzcK0UyTzMb/OMr+A0EjxObTkWCIzBLWXmKRLORZj0tskWE+NEGNbymdQZlYSredUFVMndeu5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MStQCown; arc=fail smtp.client-ip=52.101.125.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MStQCown"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9HVYbfkdmyDISacQ858AOd2rOcDt2QXQmsFLOs4z16mpvcI2yQ1lO1AoWHIpRT2sS/uHBXx9F1iN/osEIwUZhKgh4yBL97xNFBzODkcq+lS7FLCohqvG/uJRCgtBMZcA9Qg+qqKqnLNWzYXJ/iO6iliNrDcb+NGhbJxBglZafuUtZlXh9iO54EjB2vhntcr1u1Kp8Eo0PIy4u37VH7LFydxJHP2zDBzHHijZ+PgiXNFTxtoJOwMhFjW6ijzGcQJIniWYXDiorBtW1VYl2GnEfbnvAyKAm1BKP/G99WZRDrJ12ujPAg4l7IZgM/dBMJA0VWCODn9+woqzQLSMsck9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ishS5DoktF1HyTvJ4eQawrmeWZ2n0FFi8SyESmBm7wA=;
 b=Uy5jxXBvr8muX1yCo77/pB7AOIbcIlygR+Zgnae+5jpIGgXkNEJOpiLv8GLcoL28gU97whAiNdnbVs1QRLQNngNFyYYXJwtR2CTY0/UwuFHxgEuZvBXEeKRXa8yHZiA+bRvkQWlARYtbgMsM3aR8i2NBLaBBCQNsATwjfOSU3gqcEBXmOAPB8TWf5Sq2S+bNlJ2qwtfvFG4Bw46H5VKfxPS9bo64wEyuJIrtN33nMrT/axhGg+Z6iokGno7iGtKCvU+H/npLQYLaQNbvJma4kS2hwNBm4iCFTljMdlblPiMNyNh9UQ4uIXFcJeuMJOVVnICNXvVtFIBQLyhGgrIy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ishS5DoktF1HyTvJ4eQawrmeWZ2n0FFi8SyESmBm7wA=;
 b=MStQCownvC5DsbqYTFGPfpwaE1K6LkO22b+udO76hTMqGTUrMSmqfVkuX2CIh++K+47pSpP9eJnqUgG+Mh3hZDLEtjzJTw2qFlZGnr1sTZzTv+1UGKS1pNB77xV1LSc/CcVPaxmrEKA338kGCJ6T5OI/L9KhxvvNTiNoaV/ZwBg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5578.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:18a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:12:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:12:00 +0000
Date: Tue, 6 Oct 2026 02:11:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] arm64: dts: renesas: r8a779f0: Describe the
 PCIe AER interrupts
Message-ID: <mtczl7e3tlwt26gj56wmvfeotuvd63dfpsmazo3yg4sqstyuhn@omeidmdgauzz>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-16-den@valinux.co.jp>
 <d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org>
X-ClientProxiedBy: TY6P301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 22572714-0335-4469-bfbe-08df2303c488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	ux2o1c1O/JEICYw9pjHVpGxZqvlFdZ8WXCDBXjjsDZ658Gbx93FreMYGuNXYuHPO/WFSE5SJOkDX0PUqs7JgNqjmIq1raeA5pLjXgCdqCyOjbIcsX06JPVtekjDd5Md7myCbgCbdo3H3N3LYmUDe/inSoRUNzbrhrbikBe5j2bi1G3M642CXDT3/2Jsy6VJQ8lK/N8qygnilx/pIoX4eUWSI1Dy5BV7Wt768mknSHeIMASZn53K2C5enKfB4ABhYFsnHikDXolMw/wSxT61Vzjlu3ck1NyNE52zVW+Orne1JZKmDtT/nCjhkPsfRK6xPZFhYWJhmzTFmjaDkY/P5PWLD8GvJ0n9iJnDhTMfb9SSIrtA+PM1TGSa8dbdGsJ3O1uaLLXQHrax3wOaHKlSrSwhpYeT+Qguif95M//YuYAOROQOmOmsKX8w7PLi4gzqCH/eOca4/1HBhrq83KC8PRgsYqvHtlQ83V8PznZBuUho/GBd8gvz7/qFZEjiZWzLV2lXspPmxoxvDJ/VrnknNR5ainT3ZwhgU11RihyqgZ57OX83q5ayck6XYKZW3B8nm5yjZHJuDa2Bri5PPbUw3PMWg8Sh9ybO9rEjN486qibWog7HXxESnsC1x3ZBpABkEK2uc1UNqQLtka7v1B8U/QoaxcLeHW78r+63+r6xWGwGVBptUlYgKxp0jispJM/8xN+Owg9Wd7cTHPmtANoYiZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7U8On8SiyOO5EZ0bBfJu3yE/yu7m4gLL3SK1nebuGL5wvBO5XAy6batHTjA?=
 =?us-ascii?Q?Ay/QF+CU/hR1t4Jp/xLgRjWcaA1ToABYuwiODqozH6JnjLjavdWIF42dqP1f?=
 =?us-ascii?Q?ftzXQTOpHjBooLKcB9nDWd4QKcpUvBSNHhPu6WBzPOlSLLq7Rpd5BkYxxCnm?=
 =?us-ascii?Q?z/tA9kp2nYsBV0TruGfXaOZe2/JksPu6X1flXMKG3YWsFba0+16r8A1uXmLe?=
 =?us-ascii?Q?anKTbX4uWb1c/ZzA/7k/dJbIwKDJm9nYYa5KplMb9H14+f2OParkvsCwyQHP?=
 =?us-ascii?Q?vddJkfSx7Xy6Zvg2yTxBSF7WdoZoDkgc8uq5LrHGCaPZnmvcJ8Ya2QB5Pkc3?=
 =?us-ascii?Q?HucCBIDvIbZ4CbAjL4W0Ac1a20tpbFZ1R2n+5cOW3efTuwNouvr6Wj79zkus?=
 =?us-ascii?Q?DkerC+dnC3g/fnyNyzZEij64cTxWPr9rd8K44qtgqUggw1T8VJ0mWM9x7VrN?=
 =?us-ascii?Q?O2cDBiKmzwYN1XZNADoy+2/LfFwEoCGfF2wgBXXBXDhalU+D+FGWxqOeA4Rv?=
 =?us-ascii?Q?nyRzxyVFjZkawsufzBvpp+4SIZjMdC2giGvcc0d22/73pURSN9zm68xrY/Gk?=
 =?us-ascii?Q?23YMxZgAKdzmPsDBR3J3SgnfdPyAPYSePkuUS1LOT9Z4UPlf6tACc8QKeR8Y?=
 =?us-ascii?Q?naREJyh7gC0QE03lS6JUAIqZYe+lTG/6rb+FGRTgW+9yjAmEeMm9rJDlSGqr?=
 =?us-ascii?Q?pOZSXpxRHGsvjj4vxv+aH+duUairFEzQrnVTlaHj7VFb7uoAhpdmUmZ/VbtH?=
 =?us-ascii?Q?KLKFCSfymV2dt6cvbmob2b097zFHBxhAMG2vqMosjOnkXcpZ3QwadeVDz9LZ?=
 =?us-ascii?Q?ubNhFFLsrrRLzgdWm3YLqXzFE0FRXEv9ACRV1p/zJ3dtCV2DLHwcHzlzkZc7?=
 =?us-ascii?Q?jji7amxcqRyxWR3WWeoUaFxTwEhisrdIkzfR6/dAUE7cGMpcAwqAHI/QJbFZ?=
 =?us-ascii?Q?ZrSyl0YoR7CpCT1xrq9N6EYCUB1VrANFRUFkVfVeTbG3PnlnT84S7WtWK8TB?=
 =?us-ascii?Q?FC+41aI/V0TK6DKmvVmbqn20Vh3m7jsjCRpZU1CGyL605im4k8uVb4ceANhi?=
 =?us-ascii?Q?f2YLak+Ma4Ev6xyzYqkQazkiIuUj3dRDGHvhAozgoFi6b1ERvXBcX5P09/jZ?=
 =?us-ascii?Q?reltNmK4PB5nVbE39MArzI1rngCBRwnq/PooBBIp/J5I+t7Qj0by9jmuKRlj?=
 =?us-ascii?Q?0YZ8a5QoCiqkzPlAOMb1TLa4QAIvAI7EcXMD3W0UbTMppSFnLXfjj1ZdFIuJ?=
 =?us-ascii?Q?Myz9rnaUD9WFEgvbzPzjsGmp3scDoW2ojUh6X6n7ghsn7zRq6XpubQlYlCb7?=
 =?us-ascii?Q?47adBkpSd2CRWG8qIxFvBYytrqt1BLBLhlP8sA7JrkRlCAlFdV3B3PpwN9fK?=
 =?us-ascii?Q?OszPA0rqX0XtsuKqcG+7lMWjYJ1qOp5Ca+RQwk1OnBhruJdHmYl4FiIAVVtk?=
 =?us-ascii?Q?cUuDZs7KFrEOOrxzku2o0byeDCJPnEH0qO8m607OI8swzeb2PVPBjGLFac2d?=
 =?us-ascii?Q?uBIA56SMTt5YookRXRTt1Gs1voWFZsfe6iqSNEwifJlKhlGIfryUKCCM/CiM?=
 =?us-ascii?Q?cIT+HluW8pssrCxmLC8Aolk6TXxhWPRNFnt4XtwT17EJfjTw7VmmZ6X4U9LW?=
 =?us-ascii?Q?skrEpwSZHbWs/8/imvsdZH+kItzbMefK28jKKSzp4qxgRzjXV5BaFSmRibhw?=
 =?us-ascii?Q?UZUYpN3BBdZcK4+VLEZKPhbbk+jCJ97ibMSfpcVC8lFOxDqX5W+UJeh+ycdS?=
 =?us-ascii?Q?383ZIHKV6o8+EqUqC/ZM4XYAD3G3LCEQUydu6VIXDBPVCw6lPUq4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 22572714-0335-4469-bfbe-08df2303c488
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 17:11:59.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gREsjXKrUmaoIECiq+VGfMHu7cJrMpnl/Z5gaYyrAFtU/jq2eEXcnxgUpIS5snko8Uk060CYWjX3vPg+dnebcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5578

On Sat, Oct 03, 2026 at 10:00:13PM +0200, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
> > The PCIe controllers report Root Port AER notifications through
> > intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> > respectively, separately from the integrated MSI receiver interrupts.
> > Describe these interrupts with the "aer" name so the controller driver
> > can use them for Root Port error reporting.
> > 
> > Append the new interrupts to preserve the existing interrupt indices.
> > 
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>

Hi Marek,

> Please also feel free to add this patch for R-Car V4H (performed cover
> letter tests 2 and 3 on Retronix Sparrow Hawk)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> index 5284923b6cef7..8342d3c6f9881 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -801,8 +801,9 @@ pciec0: pcie@e65d0000 {
>                         interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
> +                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
> "aer";
>                         clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>                         clock-names = "core", "ref";
>                         power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> @@ -850,8 +851,9 @@ pciec1: pcie@e65d8000 {
>                         interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
> +                                    <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
> "aer";
>                         clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
>                         clock-names = "core", "ref";
>                         power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> 
> And a matching patch for R-Car V4M (boot tested, but the board has no PCIe
> device plugged into the slot)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
> b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
> index 5f9223a0f4468..a377aab3c8be0 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
> @@ -683,8 +683,9 @@ pciec0: pcie@e65d0000 {
>                         interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "msi", "dma", "sft_ce", "app";
> +                                    <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi", "dma", "sft_ce", "app",
> "aer";
>                         clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>                         clock-names = "core", "ref";
>                         power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;

Thanks! I'll add them as two separate patches in v3, with your Suggested-by.

Best regards
Koichiro Den
