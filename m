Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E63E638D;
	Thu,  6 Aug 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049624; cv=fail; b=Dhl9kVdFPzIk75y4JhOBv7tMKqxIQDQayKqQFDtOUE6PQTPRHFKqtKB4IjUSiFJOZ/gbvpIYyyrqZalaakzdW5pvKsXewNyQZwp/Xd2m6+fb+5rXhhh2ZIxK8CtZc4UUGhlF7EQEzrZMTEYB0XtFTvzTx1qxaK09bQfEYMYXLn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049624; c=relaxed/simple;
	bh=Hh/jNTJs5Y14tUKgnaZf40RS73Vp5aWhx0aheZ9VZ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0vqc+I1zdflpFAfSCCNOJlWgeTvFHJzqxZHjQTOQQ5qE7dF0pM+vy1RRO6D4K0cS4L2NISIft+lSsbvo54d5d8okNWn1ADT7zb7rExi3K7nurfZHnN13kMKp0NE2jBHrrSUmmYbfZN6U6X1n0UVJAwe7bPRcIdwX57oPzWYYQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AmOwIls2 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AmOwIls2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+WvWo5nnqBMDJe5SkDSZec2p6FRdu7okAZsIUkN5afsnHGiqYV1tIzCAHgdrIwlaQISQ5lcST+ofqeT4w0oMwykZtXEe9aoZqBw6v+7b3maZMEeLXunnncNsRs1Ad5+pCVtFuQCni/mXGW8DkUNg/dyjvfU+U0k6wZKndkwswCzjt4BthIKIh5XI5ClD7rQ7VMhfx5US2I/C3c3qrMerzMuVcevyUrM+LRDGfxBZip2E197eZtzbxUuhXZONKcd0bN6i5+iyhIXbLngjAyAKQl/dtov/fRmCnHs13iFnqK1ZJ5xKe1iKia724TWt/8W6wl8IdddIt7Qa19FjdcoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oqGQxruKgtWAbMw+0xxTYcFu3vIYIhvu/ZztQaOTUQ=;
 b=Zza6u6r8FbUhHCk6Jf6ToOtrEo/dbZeByJ2IPedPnRAFZ3vPteAWMCxRfQziD9o1bF8Ca+LA8FRcDsp2hJJB7e1QKFnnc7jWIHmoITqvggf/zFUDSp2Gx5+rz/tGSCGD7HR0XgqwJ1po/+7G1pLYgpe3os2yVVsF+aowzZ7JYKhtRs+R+Sdh0B+mpjnIkhyj5ebHkqeFPLmPvqFej2Xk5pBAce1oFzzHSa98D/Fdv4ta+exBbDFplTpqmLrhM4Iybq1+QATNokHtCy1QyjDtQ8zHrIsPQD0v1hGq+nLMCofJ/Suyyb3+fd3V9I64z8hh+ayjB44ER7xshGsh0+6eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oqGQxruKgtWAbMw+0xxTYcFu3vIYIhvu/ZztQaOTUQ=;
 b=AmOwIls2qIkB1NOfmtr2zuUVIzyDQq7wjQ4l5wtkVPmSdbIyb0e0b2VjxCbHw59TlHLAdVOyLWDCAiwm+YXTyM9++fZ1R62ZicAmrDZ0ZqTRYd2RUTorRa3N9nU0gq3CWYlv627+oFjMsh25EgDrQhHa41YvIxusrHzhMVuTTxw8qPoiYqsvuQ4SUxA2N7uQfEUBMs3iKbEUaRrWVF/zp+c2Xr3pcQ7BnwC5L2/zoF29UHfPXjKYoA63yyiCl0DIDrIeEQCKYzalIjc7OLHI5Z+eW7w6U8VPkL6/vqiDe2TVjc/1po1sf2TPrmH0TmN7SASmZm+ubZWYaLR2ue8Gag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.22; Thu, 6 Aug
 2026 20:53:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 20:53:38 +0000
Date: Thu, 6 Aug 2026 16:53:31 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Rudi Heitbaum <rudi@heitbaum.com>, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Message-ID: <anT0S51eVwBKPdnM@lizhi-Precision-Tower-5810>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
 <20260802114928.4CEEB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802114928.4CEEB1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SN7PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:806:126::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: ad17bff2-2bed-41af-adfb-08def3fcc9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	3ssVVfywG0XWnfcFjJaMNYTKEFr7fMlJucPm/YpDvMZpvslbK9ckirZ2SWYyy/iktiuiQLiT7mUKlKik3iVuOh22QWy7HQ2q/l3rq+UJ/CcsibH9sbQfESe/omPPMU539vlFxsrpcG9jlGcVopnC7YiamydTq52B2T8Yp2Wvp5IiY5ivotRUIc/+oDmEvyqs4a4dYbm1mBtsldDlXKc27v9Fo7g03zRczaCVKzTG61YpZyydPf+rAiI8FD9TFExcfy8BX0SnOjAFOUkqB216qIGpPySKF4glzt2QjVLSv43lyGcADnQGj6d4CM+Dds9Hjgj9VO9JlLKzCUxBGdAwVl5hM4uTScAylyqZNroU4WugxQI3PhUqv0WL/x+4qMnfG7zWylbN7GNDDcKuTeKs806dom+msWmxZ9e3JZwciwEOiAEdDlGCuHkVOCra93u6mV5iTwUE4KALWSW6W/RDH1meoLjI6qFRpwgc6MJmvQRfYBymEv9Ab7Pk+HU/mFa6jk6EUw0VOejwfj9B85tEyMvGmGBKioMZ0Sp/FkttLvoQXilIhX8BIocsIopgM+5o3GV5Y44t/6gqd0PhDSJLiNJiQJKI2aso8vBRqzko4lM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uDpvT+fz7ijr7AprEqs0QNBDo3qcdDXNEBewM4tEhyKslhbZA2+Wc+KJpK?=
 =?iso-8859-1?Q?DQCfBXryo6Mxvz+Ow8mhzMimV795Pgkrk67foknyvGZP7DIdr84WCKPAII?=
 =?iso-8859-1?Q?Y/iYwr3wOHdMKCe9n27TmxpXFNVjZucKuIymGkmP/ssINm9uMdcxLD6w+Y?=
 =?iso-8859-1?Q?ForfPB1X3+peoxb75cR5yXdNZKx7MHK130a+2cBmvblQjH8cMwbQ9nOrXR?=
 =?iso-8859-1?Q?F4HHH4QZG3WFCUI3hAMBXY7TXHRwAmAn5UX8rZDQhhgPcjY/1uRnWtk8ey?=
 =?iso-8859-1?Q?e6Q0llqwN4bdiEBsNsOfgmLg4iKnosmQprHMCRjOezJ5eFQLHESPx3le4/?=
 =?iso-8859-1?Q?9PPKS7fcV+HxGvSMH0+am0l55k2fYrpnH/+ouTy5Vs4ntdDjGDBnngMITE?=
 =?iso-8859-1?Q?IT+UCZ3B/RzKb9jO8mLQKLP0aYMMr2RCh6bJ7R2aoe4xdAnODIAPk489kU?=
 =?iso-8859-1?Q?l+OxzGNYXR6z+KaiofPLkt6aM1N6SubwuG1YkKYgZlpofxuC21/mu2E1er?=
 =?iso-8859-1?Q?PF1ItDNFs1x3A/Ho0oNlLYWR2BiUz/HSIHrpE6BqmIu71OpUKXe9Zbn1xE?=
 =?iso-8859-1?Q?bgVZNzgWzuP4tgEdKUtvS12kVO4ikDgq1lOUZNtDtc9X+KGmwc2vALlkZa?=
 =?iso-8859-1?Q?HNZqx1JoZ8lWUH5eolRBYd5awmpJrZKNj4Wc3cD3l35XcfsG38+xZPRJzS?=
 =?iso-8859-1?Q?SPua2nxLaXvr3prDeDvTKFU9gVg75ll1MKHn0Pf8doGqdEHsIPzqYUBPUl?=
 =?iso-8859-1?Q?qZnbvdtF1rbqtIIO5ruDbPyesH4VonpI0Ym2NA05nek0wln9iSzQuknD3+?=
 =?iso-8859-1?Q?2Yj7Ys14FuDrgdNxcweMAV3AmqwpT+Bb45h+B3/Aj2FZU1GQurQTe3rhNC?=
 =?iso-8859-1?Q?1xjTItef7ZtS3ae5Bt4EcmxbY6V5mqVSclPxbedsVxM3HGgGcp4ZfktOSg?=
 =?iso-8859-1?Q?LmXAEYgpHweXrSE+3vJAF/N41/YmjJ3Z4FPSTdqqtJ/dp3VnvMDPwyfpja?=
 =?iso-8859-1?Q?4ZJv3hzp+f4+VMyO4gss8yPiHLOAfofQ5XEAdsowBT0P6/t/vrKOtmGsPT?=
 =?iso-8859-1?Q?qz5zjCXWfKVK6h0r3S/bZdRK722O9zDU/nnXmavNYkKAXjhDSZT460BB0y?=
 =?iso-8859-1?Q?WdRiiGEtaFIQRM71s+bf4FeZffBJ2gHT4wIzC7Ps4+thxWs6duF5Xec3wD?=
 =?iso-8859-1?Q?3GY6FdI+f+zr456GZg2nA30ao3tq6wGmcDG+NbVm2dJuEx48Gy/7MUX/HK?=
 =?iso-8859-1?Q?nj0ZRf9kzjj/l9iw5zD8d7A5x8K1WKikaRzSb6nhG+npgJ2z/9DMNDGmZ9?=
 =?iso-8859-1?Q?Q76mim3/fcMY/Jl3TBb3A50DHDGysCmeZDNnbb7KjfkHlc5Rq0gmBm32F2?=
 =?iso-8859-1?Q?Mxb2vR3+CSlXcjNxGwRa9vYeEF/LbQdgBrOKfhORh8LjrF+Vefc2yXm2eU?=
 =?iso-8859-1?Q?C1zqZERaAjgopDXOQFzoYEXSAWxVpwE/ltPMnMEQKNoNf1FZSt5t2ZiqOI?=
 =?iso-8859-1?Q?nyb1YJ3eAnGlUoT9xeDSebn0vVI2D/xWfcHMdJEzLJQlAC3jYHReYVXL5v?=
 =?iso-8859-1?Q?Dq2HFqgz2LKFCVPT/etZvFH3zoWE47my1AxX023XsuKicP158jku3AOz4Z?=
 =?iso-8859-1?Q?XIo3TdY43C2OB4q1hPKuUPZjyBoZDvbZpX/L/owlDdqq8M1JDPoxqBduOz?=
 =?iso-8859-1?Q?3fDpwnuJc4UeWmhnzSYh4WTA06D9El2O4QVfVgQP7X1ZGis6U7SVHb4/28?=
 =?iso-8859-1?Q?NUR9lqgVK/f8LkzEROfiEMigYWXWIN4wn/cyQKXK49voEPZp7A1K4751wF?=
 =?iso-8859-1?Q?y1ZktFQyeukd4SSDB+G3XeU5s92Md5zgjIacJkor0bEOytpbDKSN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad17bff2-2bed-41af-adfb-08def3fcc9ff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:53:38.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG4D8CPfVajWlWn5Pxt/eOcTv4jLnYgTQ58jZ6jSVP0VE5HAFFDP3vcYmesxW0WTT+WC42dpD88PJCUMTPDuswAkqq0iOc4Pw6MQYJevx4Acysjq81OMzK2BLlS+Lt5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8205

On Sun, Aug 02, 2026 at 11:49:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch breaks backward compatibility with existing i.MX8MQ device trees by changing the default reference clock source, causing PCIe initialization to fail.
> --
>
> --- Patch [2]: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when needed for i.MX8MQ ---
> commit 6f37370c304d3692e11e97087dc50e68e2389b9e
> Author: Rudi Heitbaum <rudi@heitbaum.com>
>
> PCI: imx6: Use the external clock as REF_CLK when needed for i.MX8MQ
>
> This commit updates the i.MX8MQ PCIe PHY initialization to conditionally
> select the external oscillator as the reference clock based on the
> enable_ext_refclk flag. It falls back to the internal PLL if an "extref"
> clock is not supplied.
>
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132a..9e3b64fecb451 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -445,11 +445,16 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
> >
> >  static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  {
> > -	/* TODO: This code assumes external oscillator is being used */
> > +	bool ext = imx_pcie->enable_ext_refclk;
> > +
> > +	/*
> > +	 * Select the off-chip oscillator as REF_CLK when an "extref" clock is
> > +	 * supplied, otherwise fall back to the internal PLL.
> > +	 */
> >  	regmap_update_bits(imx_pcie->iomuxc_gpr,
> >  			   imx_pcie_grp_offset(imx_pcie),
> >  			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> > -			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> > +			   ext ? IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);
>
> [Severity: High]
> Will this change break backward compatibility with existing i.MX8MQ device
> trees?

This is problem.  enable_ext_refclk is good direction to align imx95. but
need find way to avoid break backward compatibility.

Frank
>
> Looking at imx8mq_pcie_init_phy() in drivers/pci/controller/dwc/pci-imx6.c,
> if a legacy device tree does not provide a clock named "extref",
> imx_pcie->enable_ext_refclk evaluates to false.
>
> This causes the driver to clear IMX8MQ_GPR_PCIE_REF_USE_PAD and fall back to
> the internal PLL. On boards that previously relied on the unconditional
> external oscillator selection, this regression will cause PCIe initialization
> to fail.
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1785669457.git.rudi@heitbaum.com?part=2
