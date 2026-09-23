Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020101.outbound.protection.outlook.com [52.101.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF723549390;
	Wed, 23 Sep 2026 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177076; cv=fail; b=kp0/JXVhvVvnSE+PgKx19GOXh2JU3uwrSAim7urU0S8qcIAYdI1910/XlflhwtmMhpeEiq1Ql9+luz6uYHTaZ71gpC/P3RZhHaLQSMPx5lINJtHfDWFutp5AckKbvy2DiLB9O5qfa+1JLZm6l1BxK+N6WWn+1noAt61W3YHwgNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177076; c=relaxed/simple;
	bh=xKBpkQyYjrp6kKUtr6GhzO08eLLRyUwEIWfmFqYZkEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GopbYvTsyfWocaPuQEc6NPUT4DCxDb2UwVfRj8ijVEHTRshxNHjcSGOK1Jzx+c5rbY4hEJivwutPUcCL9ifEKfPf+L8Q9dMBVYRLrpNWxYbPUny01e2YCDxLMoWFYKaTdHSw9A8s+qB49gxWNsUaQfIMuJoMGgDljwAlQGy1+8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DYFtoP8D; arc=fail smtp.client-ip=52.101.228.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DYFtoP8D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td4awdRxs97loO/30WXC2KiYL/0JAu43lT/WsrKMaqu1qxYho1aT/r8KrOvUY4i3wZ/Ybm/z68MSZcS16SBkEI7+9JAikd8tOyvZxeNxDFSV9X+tB1rLZ4KW/pK/OFwQBVC0qbVQ5LcmkA6igFd97kQB/vSHfu8Iwqh28vQIdwG2i2aoC7KHXOLmZ3xDdxb/mNM95VVg/uTGtGRxt4LJneFrqGck9SiCk7Pr5w/YysmqjgzAlQbGMKwfm96AqF1q74MNo0VPbbeOcVRAB7gnyAYz104sS0kmv2KM4suSGdAGTLTdiOOecv9Z0LbiMn70ZOs+ThlfarzWbc6iwSICPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f7GADm8E2E+JY/GkM8vPWMQwRXvJf55AW0cTrJnaYk=;
 b=ANYq1Kz6UmboafdtTepcIctm9iFcfhfY7kq7918UAfpM/dKqZU2A3SYOtHhY3gNTObVYLJE2tBRF7xUl668l0oDI+kcpbVxC0/u/9a+1SbG1Qk/TagB4PSr62b/DDOEc7mrNWSSTytHmncYYGcxTQsfW8eTYh6rn3ItwwBUT81i/tc1bn1Cw9ks5jbZLvpDFnB2h21GTdQdMuyRH+oyICOG9tv452o1mkUp0RFzC2kWj0dWZ41KxWJ+x+8mUC5DcLA8S93LGt3Nmp8iOZRl9HGo/iQg+zgvSxOZt4x2UYH/6hqlPiwPHFF9Av6eZKN+g/lT9mFFuAv3vlQrB+BeYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f7GADm8E2E+JY/GkM8vPWMQwRXvJf55AW0cTrJnaYk=;
 b=DYFtoP8Dgdzq2k0NvEi3/3ZfAo8tl5LgDXxp/MeQFvIoKMI8KNhFinQtt62r1k+XGDPLM23Sqs3HzxO+q9TQTwef4JqIYxISzTdkSDQch+SptjPb3L8CmzI/EUQq1NHWZt43oX/7TTkubQUVaVGbz0/pqk0NJtiqX+F41MpEppM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4523.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:24:30 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:24:30 +0000
Date: Thu, 24 Sep 2026 00:24:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] PCI: rcar-gen4: Split reusable hardware
 initialization
Message-ID: <76sb4yufhu7erlpt5ndlas4aegasxeqpiz6l7vvdwxyjzbgb2m@rgabcdixifw4>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-6-den@valinux.co.jp>
 <e99b8b02-861e-4980-b7a0-f0075640589d@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99b8b02-861e-4980-b7a0-f0075640589d@mailbox.org>
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d32f1-706e-4aed-5b4d-08df1986c35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|7416014|376014|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dvug2RcYfn6DvS2e4ByJ2M5pMq9U3rsRtlXMvyyz7YxUc2bSoJmtZ2k9x1Yj77ZJ5O0ABhFd04dD5x61hpyGfAxWFfRvLGS6XlVAv0xZZqBub81rIa1dNNVCXmZoOSrz31BB1CsLmwMVhZk5tm8LHRL3+/u6blZ/iBhtn9aDWi/D7wssr0XOkUPPHzT57Do7yheFcrKraSBqGmwfvHLAtyUcaY9ESZJhq7MKREjqezvukXklz0bg9ara2HQw85g3XodclFbxL1lymz9AJ8dA9F5c0PfuQylXlg2fyR6SweUZK45Lz6ZiLmGdpxAzl58qB882a++6CH6kariui0iU3b1SPu2B+faEQD2mmp7G+yhPUKRIK/IPXlNaS2ZnYWBG/G6nHTY+Tp370dhmP5SpynS+axCM5xiyEn386hoYtm13S9lGAeVe6gE3a7P5une6472uHYGnlh/HVUer4Q+1u2iiOuZHIbaIy9E4xYlU5/f79YaxQqmjpEjZEktLbyPXVVdhOADZOBGidxZM4dvph+vLLQzlVqHFIXai2ukMiasD5yN8+81rvS7iZ77v+RT8DQHFVUBharpkdZR9r6eORk4lRU4I5Oixd0iRxCc4SZPDbwpjOXYROUKuquCiu4P2cRJidQAV4aMTfTKdjSdZSBmQ66AUOmXdKRAwWP6XbXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yo0BSKACmtnTXrwhWCSaeaRAc5GdgyIiRDmug6fkRTyXNJS1hbsGnxnpM4Pu?=
 =?us-ascii?Q?HiOzxloVZShG5yV9swBgz4onEUHVgZ1aPKlfiFnMgvd7wsHcBbKzn7FLeDmO?=
 =?us-ascii?Q?z/N9OPcBjZPTkNAFan/+pcKoknrp6fe3nuvbIwtBvB7Z5zWnCmYU/hG3Z2fx?=
 =?us-ascii?Q?AzuASq6rMtD1c/6P4yJ+847kTQ+6wJWwBpcb1gEtz29Z1yW7Fbf7Sllllb0b?=
 =?us-ascii?Q?CpsDo72Wi1Jvbaj6TlyRSPE8Olw82Nhc0qmM7kDNjA6E04v5gfI8zL9E4C9Y?=
 =?us-ascii?Q?goDgenZN9vmAnZvtM34lSiepTtW/kGfTieDugXCWiU2Krz9Fpr3Qr+GCleed?=
 =?us-ascii?Q?o8Gf/LAI69mMVWmVj9OdWQa+eDoccyZVXcppPFDCn8dOS5YpDLGDvFlf3I84?=
 =?us-ascii?Q?2wDx4AnB2yvPn0+ms9gYou2utSpwtq/4sHLo6mhTJrnqlQkfVV51Ils9e+JP?=
 =?us-ascii?Q?OK7pcLRTqDZbKVHw6ExFxwWDGsyaWttEU/FG3fuKsbVTgY5Vq+TcvVIWKa/Y?=
 =?us-ascii?Q?a63red82vRb9Y4yd9iZ223BnigoLxM2wTTZmvrC2akODIkEPgoHhAcZfK/c7?=
 =?us-ascii?Q?t0xJIyEQxaJ6zvg/bz9KyPGBUHMS6bQB/MueLRW4HgXmNSgRPfn7hilaHN4A?=
 =?us-ascii?Q?LfXH5pO+/yL4qfSbO2unw/vlV6ND7uCQ7GzLieVNMsjiZ/5C3k0g23vGnxKq?=
 =?us-ascii?Q?ukZi7x+U4Vy0Kk/cYYGkzkw7v33GNybVm1Rk546f6cGgJFU5jUMdEEOBrszS?=
 =?us-ascii?Q?u2d8VDi6EgA4CWPZW2nQ0PL0kKOj9yuIOf7uM1PckBTfnR1D0nvu02Co8kM3?=
 =?us-ascii?Q?q5ntaM3osVDutNWpvy8gaoTvsDB+7FPQsTLmyOHlXm515UdBEjSUpY43m1sh?=
 =?us-ascii?Q?TOW++A02SrFgqzfMsnfoPuB3U4ciFmX15ILB6kjFdZXuUO4/aDYvpJNaVsL2?=
 =?us-ascii?Q?wNpqMp0GRZjB2sFsidgyRtbJwVNmVfZaamAElnC6YREZlrC0Xmcg6KOhHIdy?=
 =?us-ascii?Q?X+K8+UkXGFOD83taXv/uxh536tPC+/H3hcBXH5klWaG3SyHABrgztRJZ16mi?=
 =?us-ascii?Q?P44znG6a/ad0fa1QHdTATUZnW8OpR6Rxgto0yhDGdTf4vS2mwh9BxG1Sf91M?=
 =?us-ascii?Q?JZz1ETG26ujx+Hfg4hpOP33Zfb3Iw2YGDzQop635Ab9qGbbKfKCxAn8axr5P?=
 =?us-ascii?Q?3UgzNcsjFm5R+v/Uw0zkTflb7VZuboCd8b/Xx9e/wgyas8pv0uiD6zYPK6ok?=
 =?us-ascii?Q?db3oIBvDUWCVYCh5UqlEySKLV4Y1E6RbU3oCAXGvLTRWYYkTBz1G6JL44aAM?=
 =?us-ascii?Q?nsSHIsRuDbNfd/lOLbAoloFCfBmCBgKIkBMgo447O5KRigH2gzGYRfhXwOEi?=
 =?us-ascii?Q?02C8mOSUFHzykyen0L2gUQLHu4ckhaQ+j7SsMmGAD5NscIBD64gtsTs53YS7?=
 =?us-ascii?Q?nw86/7HccGAGmf7LbrsyUvjoN5qI4BrbP46VPfFIysVz3azndd1mMGWaKSVH?=
 =?us-ascii?Q?f86EZ/8R/PK8QNW8/z2P6X6rUrrhUzEo3A2FHJAl3VSHPWRzQJke+GgoG4pv?=
 =?us-ascii?Q?u79GqtOvO0H3GABHupjBerEtJx9WisKy583dezvL29ebeLWlLS4tvP06eLyi?=
 =?us-ascii?Q?QB8YIq9QxhHFMYTWT4OrhY6tpwS4hur0qctFrr8i5uwPy6rMSvkJRGf9Jxke?=
 =?us-ascii?Q?mr6f4pzbyKbTOcBYlIMrL++r6twZavVhuO/EXsmLMXxMqVdLyib5YvIAfnhL?=
 =?us-ascii?Q?W998/sYtRpQfjb36dZA6Gm+QGKdutR8MbkzToaajEfM+42zuKr8l?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d32f1-706e-4aed-5b4d-08df1986c35c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:24:30.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBjKjAw32bRT2gyflmz99vKZerLAHmWQ8GFao7A5pdB7EBsxsY74COnkKDYIc9AGNiJTyqN23UEaWDmUxhRjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4523

On Tue, Sep 22, 2026 at 11:15:48PM +0200, Marek Vasut wrote:
> On 9/18/26 5:20 AM, Koichiro Den wrote:
> 
> [...]
> 
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -178,23 +178,18 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> >   	u32 val;
> >   	int ret;
> > -	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> > -	if (ret) {
> > -		dev_err(dw->dev, "Enabling core clocks failed\n");
> > +	ret = reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +	if (ret)
> >   		return ret;
> > -	}
> > -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
> > -		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > -		/*
> > -		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
> > -		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
> > -		 * indicates that for peripherals in HSC domain, after
> > -		 * reset has been asserted by writing a matching reset bit
> > -		 * into register SRCR, it is mandatory to wait 1ms.
> > -		 */
> > -		fsleep(1000);
> > -	}
> > +	/*
> > +	 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
> > +	 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
> > +	 * indicates that for peripherals in HSC domain, after
> > +	 * reset has been asserted by writing a matching reset bit
> > +	 * into register SRCR, it is mandatory to wait 1ms.
> > +	 */
> > +	fsleep(1000);
> 
> This fsleep here should only happen if the reset wasn't asserted before.
> Is removal of reset_control_status() correct ?

You're right. Looking at the code again, adding the recovery path doesn't at all
justify removing the reset_control_status() check. I'll fix it and restore that
condition.

Thanks for the review!

Best regards,
Koichiro

> 
> >   	val = readl(rcar->base + PCIEMSR0);
> >   	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
> [...]
