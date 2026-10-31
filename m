Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.125.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793463046;
	b=aLTT8UnGcPFqrK/Y3Atr4d13dqcNcybpaD1DshJAhLR/RA1lAAWtcsDZq1DStFivaSBI
	 iHgzC7SuEdB+zNGfuLXG6xRILLp/th9dhTS5KbuBA6cvse7nA3Xk4VTOEHp2a9c96Ynly
	 Wyvew5pPO0M1MU+OSwPdljJS2nS2j3vyAdcLQbimVvnHJOC+tg/Qq9Ukgzk2Tj9i+Pmf4
	 0Pwwor0TGlyXt3JDrBfSI399T/D6EmIZXP86Gbqq8R6oxKAlBVjW1ddc7da4QNXdtK//V
	 fO4wnvLuSqjPsuvi8aQCj88vK+68xtX16dYdjmCf0aZtMOP8ekTGJ2qXYtLPc/tas+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463046;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=i0OqqQ3frUT6bxMLXdTJU8JzulQODa1+/KxHObngpNQ=;
	b=IezeyVO7n0i6JlrFpBliXOWgTA1hr3/rb7I15MsyLibcwO0YoPhv6sQMq/RSOoB775I9
	 lcov1fCWmEU0TGAtDTxI1Io/yDEnvH7e6qLpre7PBT+/RPOIQGnWlSWeE7ILzno/yhoDD
	 pvrwascQpMziKeGqGw0NmalSdLs29IvAWs6ItjUrlGaPnlOBmTKyQhyZkZNRrAbZ4uorO
	 RIKsdynPVfUIooRVH1Jc3F7vzzrKuHOGSJQ7zLH/b7i7rLUMQnAG0Z72mAJabtoH4ip1P
	 1U+48pWPRgNmstA/xoHpWWFWr39RjOalOUxjxMCaBF2vJ/CZFZ8IyBRj65cpDb4Kd6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ej6uS10I;
	arc=fail smtp.remote-ip=52.101.125.73
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021073.outbound.protection.outlook.com [52.101.125.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB10606A31C;
	Sat, 31 Oct 2026 16:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ej6uS10I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSDbJtS69n7Z4AxMw4GZfLd/3dGqeF2g+sfzf2NKMsYloGQSXqt6xsQTSRb3H8bfF5OYBl88Kc8ymItTowsGTT71YJPOR/bvvJDiQgMGK9B3gq91WCx/548TOl/pJ1FQer/CV77YmuGsHWjI5/9uTM0nRqKr1TK3OsqqE8XEsgFpwCEeU95CKs5EHKMVnw3QHp+6LF6FUt4SOBA2+V9rdNhNH8ZsxZJb/tjj9hJV5betby+4knL9M5omgh3zBIObr77UKuLcuyEey6djq9TmEkRJhqhvmm8kDY3LD9EP+ESEdU7xax4HkRU60t1rccbV7BU0jt14e2jPI9JUJrP88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JgJzbwiFd90BVTk/XEdyv+13afpS+kAltE1ZEGdddg=;
 b=PattkcNWMuB3675CvTKIWp4lU655kztJV5HBng+KVJK2Lc6A2A8mTGmp8ZPpUhPQ2C90/dwZCBvmPqaGkUnuI8FYcG5ZC+HaKkDJNxnt6ZJ5iR5RRvZWUWpPX0gf7xpCuz8rSdmBuTU+BIIX+zJG9kMSWS3d77QGS+Rtwr3eWP6OEvoDV3p7SHdImGC7Lh13U8QMYZ0Xl0WgtLhfbW7t7uSdx07zBPiSMs9WnGQJzsgVcP4y3kqf7hoT0qXX8GfTlCYYeK4buA4cAQnLtYrJ+0BVjXUJDJ0pM8Up5o+eAR2HGq+pmDVIBbxt5X/gyz5GcuP7eUPvPwP2oXm2hosfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JgJzbwiFd90BVTk/XEdyv+13afpS+kAltE1ZEGdddg=;
 b=ej6uS10IYxE+Ssz2p7JukT+rD1T96Nkxb2lcPk4v8FzZTVtMqRVrusFOBvN7e7jlGpW2bLIA+bgVNsMvmTqQBZ221o7XlForH+1S3VRWlchCiP0XYc2RzsHUawVkhM/fL+Wa0ySh0XmAUqFvMlEqGU1WSs51EMgMXcApN0kT77E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5108.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 16:10:42 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 16:10:42 +0000
Date: Sun, 1 Nov 2026 01:10:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org
Subject: Re: [PATCH v6 3/5] dmaengine: dw-edma: Use HDMA watermark interrupts
 as LL progress
Message-ID: <2sizqevkig4kj2exlv73xnsic67t3qyqgscwjni4o4sluwdozh@xgjjh6wpsp5i>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-4-den@valinux.co.jp>
 <sashiko-outbox-191157@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-191157@kernel.org>
X-ClientProxiedBy: TY4P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c6a37c-ba2c-4f28-58b1-08df3769831a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|261021121427099003|261021123027099003|261026121527099003|261026135527099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	igrku2ZsJbyA7/sQHNQ1JkY56UeGkYjdQoEPCLL9V2O+9inJzfH0nphHMsuhF4AIpJrw+53DSGGLIvpLFJK5HadQlUtpzd4UklygcqssQQatnHdENPgGbTtkUWh+vqye7jJuQTPOgXadZyd+X1Lk3Ujfp4TxXMRDqup2haAWs6SAVtcXUyn9b/g+McEDIP/UJn/ClExK0vf7ec8rZclMZ7GNA9zIRje7/bmWwXUcUCZgwO7seBDg1289mV/KDXXDty2znmlcsW8H/RULN7yhvrFyD7c9NnhV8O1uGjQtnWQ1DviFqgK9X82VN6ytLGEuAqBTuZbrY63vl0PrQrwygeTZIUFMxpeDWoaucODnFQuLfwtxM3pj28jl9OFaXYoQkIaWPOrnISPV+mzItwDWmZybp3F54eLn59U9u3oghdZuY0T4IxDiXzQ4u4bI29NQ2ZDGasiWH4X1eIyGxknACX5wgVV+GoRkGWmp+usEOXG+xe5YQZtIEGD1xTmzUsKKlTyIshRraUzPlZf9oGLXyaNBL8FoNajNnLxPGQvc01rOjbH3VCKsaAzRi9E0RQ4z1h8ED8Z3Yu6HiIYeiIYN/RMeLqCHPh8sXdYpNK5askk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261021121427099003)(261021123027099003)(261026121527099003)(261026135527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dQnGb7W6eJ2CK98WfQgK3lnwFkByXnaPBNpavAHiLepOWFRgDWfMf4Lhaj?=
 =?iso-8859-1?Q?4EFOtTCAWIh0NTcW44wxrmHVD4CY/OypJOuTAQNmM3RNTKmP89NpxtcBNS?=
 =?iso-8859-1?Q?/v/oE7ePQ3i0FTl/KgAx0SLgENehllOVOY9MbyMaNpGnVk6BBOSZkmnKyL?=
 =?iso-8859-1?Q?EgnT7dxf8oiD9nfioQPG5eKgLecYPHta1ZQyjHwqeW6o41wLJucLrU+k3h?=
 =?iso-8859-1?Q?X278466uRwZN8GmRKUN7pHkWHtXeaLHcTUOkO/+Vn9nkEjd6Ob6KYxfBTN?=
 =?iso-8859-1?Q?iFvDcV0hZoYZRDScFu8CUdsvBpiH4bJA87QQ4st+yaU5ChX9rKoBKiYqZJ?=
 =?iso-8859-1?Q?Vf5IPkCOaauIaeV55ZuIYf5Yz9F+vNpCmllgYIyJrQSeo/c88iJmf1n7pK?=
 =?iso-8859-1?Q?36CuFCcswX2AV9A3CO/AsNadCKUd+x37Ed4akFtRScjv/NUpbSFYO6WHyU?=
 =?iso-8859-1?Q?QbG9U6tgnPxGwjDCOedbyFePguYQ+5jZdjIl6QJo7Z0iU7rRSK6YNcoWum?=
 =?iso-8859-1?Q?CRGyij3AghiiyTM1h2nBbHAmbsBO/Ql4hrzMuKnqasHa+6MBtMfcFdlnGJ?=
 =?iso-8859-1?Q?vwbonRezHnlZ5/a49RgLFkDL+6dbCcwYmjm89PSOCvpRequGQnG3auqyrN?=
 =?iso-8859-1?Q?U6QxzZdY60W6J1AdDrFQ1ah/dm0n8BtAoFJWsA41QVUcP7TIOkdbErcuua?=
 =?iso-8859-1?Q?L5P/LJ3/hYe+aBOuAYqlUX3QZfBVE5yiNpCdovJ20I7Q0OMHDYSwJRZDFE?=
 =?iso-8859-1?Q?56CdH9ZIa1ll2r7BAoaHf3wUJ6se148pWXqYmf5uAdhvB4VsOFm3nxOxkk?=
 =?iso-8859-1?Q?0ic/C1ZpR/sp7WVizdSwKD0HHnsLLbEvogefu5vpfe9EC1j1T/xd66trdm?=
 =?iso-8859-1?Q?Sd5k4h4DFxAXrZT0kJu6/X5C6tJq2j2Qs4gwMxQB7/RemODyQ4R+Y1skN/?=
 =?iso-8859-1?Q?G23FgpHL9Poa69We7JBkEZbC3KYJVsi2+d7wnX7ulkFTr03VXaaFn7MF1+?=
 =?iso-8859-1?Q?mFtqOEY28DJ6Uk+aNJELeozKK94JspkJJnwfHmNLNAocLLpgRxy/ddW2fu?=
 =?iso-8859-1?Q?vGDA/Zs+KOw9Wpgf30xzcrT3l863qsH5XBP8qycU20iQKQ2swFaFxvXKs+?=
 =?iso-8859-1?Q?whl8XVFgNfLDqrWU+5FkIAALVks1gC3zSVX7S0Mt+JhEMuN4sz/93DLNyk?=
 =?iso-8859-1?Q?IWwp5r1ga/fsAnDnTAuESzi43no63+7vs8dgxhrkYZxIjNnHaNT7wyfDl3?=
 =?iso-8859-1?Q?dy2G+VcR+3uLZlOX0Dcy0/HUzs9pxJ3jR0XRp2tpAfpdWLYWTBRzRlc7uZ?=
 =?iso-8859-1?Q?v92p8u6OAKqbw16k8NbcweGnx8dC8QvDNM9OWzLwgs377wz131uRuLObYK?=
 =?iso-8859-1?Q?a3gDgmsxBry4jZ5t5zz3G1SD5fa29gVsD9jVEinHdBKNPJSjhBRyfjeBLs?=
 =?iso-8859-1?Q?xDh6N4DxQVf1dGGj0ZmwoQIamrRps/r5QoCEolxYtXj15/IdmGsM3Hc8aK?=
 =?iso-8859-1?Q?aL4dCtDLyB3pW7FTFOYN4GoSkqsab59z6n4sMmxAMz/mpM71KPaD+gKX5N?=
 =?iso-8859-1?Q?nrg3LO+4TB8LB2B9njbyw3l1R8QZ+rxn8RN9bv5RiKmFIkq6dLEv900HcZ?=
 =?iso-8859-1?Q?Q8/Z/iCE4GPO8+RKMdGb092sgkfmtZamaFTvOrNmjksrQweR5SVukLswzz?=
 =?iso-8859-1?Q?7QE2fc+gaiBGV+rxEJQapOlaE0T9V/26JKY4CWxQdIBbAO8aURGSyBlMeb?=
 =?iso-8859-1?Q?5ngZERKu8nJvhCmkJ6iyA+rBlpreVoN00dUjVt7qEcvhbNuBqvyt8uWalf?=
 =?iso-8859-1?Q?YMcRrClT8/WDuk16IyYzXJyj1Z0iTOVlzly7ekerHSx0JcNNHkil?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c6a37c-ba2c-4f28-58b1-08df3769831a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 16:10:42.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uos7R1yxrOpZZXQqG9sm2OUV7X9fFdAZc1VmQSN72cGU/6pQ9x8E4RpXG95cmY2InZqkX/ZtMVt+PkBVjRf2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5108

On Fri, Oct 30, 2026 at 03:21:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] dmaengine: dw-edma: non-LL watermark unmasked in dw_hdma_v0_core_int_setup()
> --
> 
> commit 5e1e3ed55b7d4e9a83bc0d3c9ec3bbccd4a0395c
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress
> 
> This commit enables HDMA watermark interrupts on linked-list entries that
> request an interrupt, configures local or remote interrupt delivery, and
> routes watermark events to the linked-list progress handler.
> 
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index aa430219d0af2..7ca5afa181fe5 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -58,7 +58,8 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
> >  {
> >  	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
> >  		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
> > -		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
> > +		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
> > +		 HDMA_V0_STOP_INT_MASK);
> >  
> >  	/*
> >  	 * HDMA_INT_STATUS.STOP and .ABORT are latched only when LSIE and
> > @@ -68,10 +69,14 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
> >  	 */
> >  	val |= HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> >  
> > -	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
> > +	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > +		if (!chan->non_ll)
> > +			val |= HDMA_V0_WATERMARK_INT_MASK;
> > +
> >  		val |= HDMA_V0_REMOTE_ABORT_INT_EN |
> >  		       HDMA_V0_REMOTE_STOP_INT_EN |
> >  		       HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK;
> > +	}
> >  
> >  	return val;
> >  }
> 
> [Severity: Medium]
> In dw_hdma_v0_core_int_setup(), HDMA_V0_WATERMARK_INT_MASK is unconditionally
> cleared at the start of the function, unmasking the local watermark interrupt
> pin. Later, it is only set back to 1 (masked) when chan->irq_mode is
> DW_EDMA_CH_IRQ_REMOTE and !chan->non_ll.
> 
> When a channel is started in non-LL mode via:
> 
>   dw_edma_device_issue_pending()
>     -> dw_edma_start_transfer()
>       -> dw_edma_core_start()
>         -> dw_hdma_v0_core_non_ll_start()
>           -> dw_hdma_v0_core_int_setup()
> 
> chan->non_ll is true, which leaves HDMA_V0_WATERMARK_INT_MASK cleared (0,
> unmasked) in both DW_EDMA_CH_IRQ_LOCAL and DW_EDMA_CH_IRQ_REMOTE modes.
> 
> In remote IRQ mode, all local interrupt pins are expected to be masked. In
> addition, if a watermark interrupt fires on a non-LL channel (for instance, if
> the hardware watermark_en register is non-zero), dw_hdma_v0_core_handle_int()
> will report DW_EDMA_IRQ_PROGRESS, causing dw_edma_done_interrupt() to
> prematurely complete the active non-LL burst while the channel is still
> running.
> 
> Should HDMA_V0_WATERMARK_INT_MASK be set whenever chan->non_ll is true or
> chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE, so that local watermark interrupts
> are only unmasked for LL channels in local IRQ mode?

I don't think this causes a functional problem in non-LL mode because:

  - The driver does not write watermark_en (0x0030). The controller updates it
    from LL elements, so this update does not occur in non-LL mode.
  - Even if watermark_en were non-zero for some reason, watermark interrupts
    should not fire during non-LL transfers, according to the 6.10a databook
    7.2.2.2 Non-Linked List Mode Interrupt Handling:
    > Non-linked list mode has the same type of interrupts as the linked list
    > mode, except for LL related errors and watermark interrupts.

With that being said, it still reasonable to keep the watermark interrupt masked
for non-LL as well. Unmasking it for non-LL in LOCAL irq_mode is unnecessary,
and it's just simpler and cleaner to mask all local interrupts when irq_mode is
REMOTE.

I'll update it in the next revision.

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261030150742.2586776-1-den@valinux.co.jp?part=3
