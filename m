Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B144457BD;
	Mon, 17 Aug 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981854; cv=fail; b=r5QX3/k50VRKd3uj5OdFDewkU22nWgDjb5upEcdi7oHKvfBZZsKnHSpYaai1XZ6fCDQVS+SfWgFbowtMQQIL1quoSnBIuk2T60DCR85mvcwsW1YMbSDkHRaLk57ijQBPoYNCJKlE5oVWtZYZk2LZ6XPu0CLZxYccMu+r7BtNUUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981854; c=relaxed/simple;
	bh=2vthp6ix8G2nBoKnLVjTcRgfO2CskM6HTG30mv7vDUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RSlt86SNAn0jA41KaQOQKLk/2E87gVN29a261n3FQtIZmmK03pAl76JDAydFc0zUOkHRiMdD4fDhPQqOa1kMfitEEsfzarWUjN5YI9wKZ+0kicTgOcaWJS4Qbn1bcCRevUukT9JauvlGYoPys537PL4nN+UfCKBDP9DhPqftUNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mzaNijYK; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mzaNijYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsL2Ygy4XSuXnruGmk5zej6kVGmMuUedQNTJnX79gx1ZJG3hFSoanoTQMW2qNejTvkW7Sn3G9qLTlUzAr0P6RgIJUsPhaaujYXlAIJB0Ito4sb/iBdM7UbRTrwzy5zbQjxPrCVnPffu/miXnYkP/FA6TBIKA0qH7Yr4riq7PtxWwefbUGpC76l/Oo2MgY0kPdyuRcYtqNkD5esBUTaROrsmfylqLryKsztxro5G5rYDlLILC4eYWio7ARdPwwKb3xFEpLWqDOFRdQOW+I9UIbV+iVWuhb28CwnGnMghib2/kDnG1N33u8EFkPuKe3ifVvie8mq9LwJjIq9dFxz8Xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wqVEfteLMKajygi52nbt4aj/En+QexsenWfIpwcMeY=;
 b=cFSPD5KQKqqmBZ7QQCCAsb3rTJzjAYV6HbpIW8qwklsQ7MHwa1bA6tofbYsQj2kncMcCy5qM23IcALHDA+jM3hbw0ugZUN/I2lC8/jgyDfd36ev/rUaCU3njFc8Oa/Uod3ICR538eDQDNHi6dFcPx8I42yI00zUQrwq0XZmYX9osnW6fT3M3j+wvT6ornd/H1XnOHWgJ+B65XvlkF+HTuGF84YiV+LG5wINR1bYefer28ot6g3C2zr8YeaGS8ihix/FEwyXN6elFjjn/Au+pXRRf5m8Bmz5ppQNhMha66ossu+Pr0yzlL6vjSPIfenafD5XVV8U3Q8Nei9SCJFJsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wqVEfteLMKajygi52nbt4aj/En+QexsenWfIpwcMeY=;
 b=mzaNijYKKmLyUiwQhFlPcRLSirPpykaCBZav0P915dQ0ILqE49GMFRLR+O+S0aCuQ7mnJFPc6+Ewf7GzD1qsnNp33mAsKs/1xK3F/SQRbqcC7G95/q9SAqXYSFuAMH8KTM/rcgzmqzeQ7p2ddQ0azdcT02aFAbh3WlVm2LP6T7IbLn8nh0uoPv5o1D/FguCuX6bIRj0zXDx0EiioDdZ8zyxmtUYzAthz1ZWRM6eVwKXrml//dKeinFG9PGWQE/8VqZ+IgDekO9vYtst/2uMapohnaoJW/j9HiJlwWwCOxeXbW8YMAlEqaqR7/HOVVBt0uXIlUnX178C+ap1uavsqxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB6954.eurprd04.prod.outlook.com (2603:10a6:10:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:50:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:50:47 +0000
Date: Mon, 17 Aug 2026 10:50:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: frank.li@nxp.com, corbet@lwn.net, dmaengine@vger.kernel.org,
	hch@infradead.org, imx@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lizhijian@fujitsu.com, mst@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Message-ID: <aoMty9Dvt2bnWm74@SMW015318>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
 <20260816071044.331a2c51.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816071044.331a2c51.michal.pecio@gmail.com>
X-ClientProxiedBy: PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: deff2741-0760-482c-a886-08defc774dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u4a9mqZnhSDEkdEJFadkZDLSjQrUR1bCrFASYi/HM4TQSEOMD7FfIEM6Ekq0VUCIv8MghArFiFbgAtkhBX3NFbmKinzy79NBP/qq40gt6BvTx0+/Evoyn/IcYowsLEpPZxFFgAUNlfyerUSFGb50CNFuLQasZP9o/T4krN9ThdqefW99a4oV30eWqip72Kih1wX3ICmlvEimqrGMdtTOJEiVST7ZCdDtBXNJ0ZI0jmLofb34S36iUF2keuEyFhIJuVhE3G4Yc1POGsfDEcl+lDletbwX5g3QHS0FRbrrE6rYBzjciJnd2zoLoBU4Bfl767aRPmscM/8gBJg7zDglQeaTZL7w7WKtmCH7KtLOFhNIb5NAS5RbyljUGOplPEK9yQ4DK9A8+bbD1Dmc798dXtvgRZ8QYiQCROIQs8O4TgqPAnAD4wamqd5wCrmqWjHhv7Hqd9iVy11k1IWrQa/XrM8FySN5S9ZzezERO4QQT65aRx3DohZf/yzPHil7UZQJ62bqNYyVc1mo0OqnY9IOekFjrjJJLe8Gq+TuLGPCW9vYk1JZnIPByTMvakyS7Ce5QW04NbfFGbko9FnPneh61dC5X1/Ay+2HFE0ORfoLgyl+HAs9dUdJ7bxCB0mbv+sO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I49mM4nxl4GUxJU5VYfx4LDPwQM5QaoBWDdJX253xV+0EBsRnt85r+is2Qkp?=
 =?us-ascii?Q?K2Nq4s32b8KF9IR+ZPo506vRhJE9lLl3NR9Dbvxjd4uQb4MDOLptw7jF5qCd?=
 =?us-ascii?Q?eVL4lJWf/2Cca0oUBmoMzGpYFAOWEWWEzayTIbNOuV/RAttjg2YKTMdiJL01?=
 =?us-ascii?Q?ctF7ZZI1sXe0WkfS22sa436doi1H2MZiCkcn/8Q5SpCRiCeGN0mlJnFHX4R9?=
 =?us-ascii?Q?C8p3T9VOfzG3z388VUUlV2GMb8otxlj5uOyy4w31oID9bqRZ5Gebio8SY9Oh?=
 =?us-ascii?Q?hl8LvWcyKIDeObtZ6u88xdgKpCns0FmGgBi5K1GYcfN492qtSapJUYaghubV?=
 =?us-ascii?Q?ObSskQKTwkKFRmSld7Yy+8ZEQ08GJeuvYyAxFuzPVR5z3Zv53i6IySLku2kR?=
 =?us-ascii?Q?8J5N/5zAG0VsKKQRI+6gYwuRhRWx0oWo2twxUPVBqLRuWd0aAl91kSjLNeKE?=
 =?us-ascii?Q?iRy0W1xPd/xbYgZcgwO/8A88mlRi0Dc6Sx4Wi+ljaj01k0bUxk8TVS1kCP+Y?=
 =?us-ascii?Q?xrRivdQtqEsBiS49dqZKl9n0OgFI0QWSBtyfbKdx0WqguXd1zFmGTiki86Zp?=
 =?us-ascii?Q?Mbtned8wLHXycvzjfdUXZF506ajy19BmSOKcfNRx522zyJhn51vha7GT2sTZ?=
 =?us-ascii?Q?XV51I4Ptf2AqU+ZZvf1xtiUeEUQn1T8NIOreebbcq5Q2aYlZ0H4VR1hobUNY?=
 =?us-ascii?Q?WBBfRzyf3ZYwaQqS9UwI1/tjRIKEMuQ4Kgd2MfvN//8GpDBZhchBR9LVehKf?=
 =?us-ascii?Q?79UKun2umw1beBoEDVSw3vK2VM27WD42TLjQe6+cHKtkb5QMhtxAdX8C+iyt?=
 =?us-ascii?Q?uqMCvti1HSVwi8RRA3+05ntYrqjxXSG5zabLBjf5heTiJst/LUq+9xZk/jOy?=
 =?us-ascii?Q?uUQG4Kay47/cHce6t8+vW/6CotJBbSj38W8gVIy0sd9bHl3f47A9k5lQWBAL?=
 =?us-ascii?Q?5rWUKiaOI0Z0bsO82AUiYGOXRbaIb+uHFBzv8MWUFjBuaDsfeyd0MvSRRjSB?=
 =?us-ascii?Q?NVOX2r7Ig/HKef2FnH83XTR0Qi/tf8oc3nQlMN/p4IbtALHr1BulgONA2if1?=
 =?us-ascii?Q?zSRC24tJ19LEPB+wN8RKl1HHRMB6NYxiJt8scN9BStPdgcEzEp1jbwulgOoj?=
 =?us-ascii?Q?dj3kVLuIvmRkgJqg9ATNOoPaWBlO12YYhO+MoaLg22QfSUgaLyG7NnCtb4pB?=
 =?us-ascii?Q?9qmnMOhd8JKAJuPZsFm79WZ8l51EuZG9GsxDl1FhF7BfXjTaGHG8grye1Zxc?=
 =?us-ascii?Q?Q1FAcm+WwG5hNU5Y4k7c9InO8hr7U3upc9S6t1vKw3tjbvkuHqe63zpAxlgq?=
 =?us-ascii?Q?YUOTCUIUsdk8E8676zeeR5oW8Q9L5Y0F8wb7+/wlGBsknCaYXg/k1SZFhox7?=
 =?us-ascii?Q?t69N/nGWulkqqKsynQYSjKTJvgxXwIhMtnh9makL9EuMtfyXamgDQqLegSg4?=
 =?us-ascii?Q?0A1DQ67EKQWvr1rQt+Txkac4tSoPABa31DbmjHJYS/EQS2e8fXIo389Y0Yyg?=
 =?us-ascii?Q?NXqz9LUYPB7U928fns8d2Qz5h+BwgYlxhZYRACvN9G/bRC7aSUcWL2QuJmjz?=
 =?us-ascii?Q?BLrGz/8wEBxR0HwCTUegRB4DalKp1ipMsZOTV34Ryw7XIUdeNYdMXiiHUT7I?=
 =?us-ascii?Q?V1RAoY6aDYYoOYFlsDhGnn2tqKceztegD6/MAIG+1HQe9tP4Ni1oQC+ZJTgn?=
 =?us-ascii?Q?K/O2XYEEdD+eUJvws6Qu3kU0U9ZbRFgOH8aK8A1DA2Q9sHPfFGFRt06ge9qv?=
 =?us-ascii?Q?SQGr1tIPhzsuoOj2db7Q1AdFAWYfYS5PwQCjwdEYltzdzNzrwdrz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deff2741-0760-482c-a886-08defc774dc7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:50:47.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJIvoNLU8TZEnZPICY3kMf9L968qqCwdcKeUBX5CvX47z5hdjLGWimHH2j1xmtYumDt9hgNEPD/cKa3dmdoJSQzjeTJejjBJsUoo1fcAt9jhhV3pmoH9SWX9I47tGp8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6954

On Sun, Aug 16, 2026 at 07:10:44AM +0200, Michal Pecio wrote:
> [You don't often get email from michal.pecio@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi,
>
> > There are bunch of codes in driver like
> >
> >        if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> >                dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> >
> > Actually it is wrong because if dma_set_mask_and_coherent(64) fails,
> > dma_set_mask_and_coherent(32) will fail for the same reason.
>
> I encountered similar driver code and found it similarly suspicious.
> I arrived here searching for reasons to convince myself (and relevant
> maintainers) that removing this is indeed the right thing to do.
>
> But I have a few remaining questions and remarks.
>
> > And dma_set_mask_and_coherent(64) never returns failure.
>
> No realistic chance of the dev->dma_mask check (below) giving -EIO?

dma_mask is pointer, which already initilized by bus driver before call to
probe.

For example

https://elixir.bootlin.com/linux/v7.1.8/source/drivers/base/platform.c#L634

If you find one, which bus driver have not init it, please high light it.

So far safe check !dev->dma_mask is reduntant.

>
> > According to the definition of dma_set_mask(), it indicates the width
> > of address that device DMA can access. If it can access 64-bit
> > address, it must access 32-bit address inherently. So only need set
> > biggest address width.
> >
> > See below code fragment:
> >
> > dma_set_mask(mask)
> > {
> >       mask = (dma_addr_t)mask;
> >
> >       if (!dev->dma_mask || !dma_supported(dev, mask))
> >               return -EIO;
> >
> >       arch_dma_set_mask(dev, mask);
> >       *dev->dma_mask = mask;
> >       return 0;
> > }
> >
> > dma_supported() will call dma_direct_supported or iommux's
> > dma_supported call back function.
>
> Aapparently, it may also use some 'dma_map_ops' and there is a bunch
> of those spread over drivers/ and arch/. But I gather they are expected
> to behave similarly as the functions named above?

I grep it and checked at that time, all return 1 when >= 32. Now more
powerfull check tools avaible, you can double check it.

>
> > --- a/Documentation/core-api/dma-api-howto.rst
> > +++ b/Documentation/core-api/dma-api-howto.rst
> >
> > +The standard 64-bit addressing device would do something like this::
> > +
> > +     dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))
> > +
> > +dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64). Typical
> > +error code like::
> > +
> > +     /* Wrong code */
> > +     if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> > +             dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> > +
> > +dma_set_mask_and_coherent() will never return failure when bigger then 32.
> > +So typical code like::
> > +
> > +     /* Recommended code */
> > +     if (support_64bit)
> > +             dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +     else
> > +             dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +
>
> This text is unclear. Two sentences begin with "Typical error code",
> then some code is quoted, and the sentences are cut abruptly without
> actually making any statement about the code in question.

Sorry, I still not understand what your means.

Anyways, now dt's "dma-ranges" is more userful now.

Frank

>
> Thanks,
> Michal
>
