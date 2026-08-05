Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020126.outbound.protection.outlook.com [52.101.228.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621913B293
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896129; cv=fail; b=omoWg0nPjOTW+IZog2pDMyAa0GVYD8EddC//9LG5uoCsrF/QnfZqUhwi6NrIwJcUX0KjEwPTwQ40FZwG2sC7LixgQQbzilXvNzofLBdpLc/Dt/C7OQ290IK5ttY2co5Kleer3hGt1KCqBF71+u0roBnCgeMVy5HeCzswxhZElq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896129; c=relaxed/simple;
	bh=oGtbDbDN+qi0FKR5Aq3KCnDOijDzPPiViTsfXZCwFao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m26m57ysEX1sVJwRVR+K2xB38d+LN+TrWXN30LenES77Dn5GFXGS9Eh9YtDD6p6U6BWbw66HDYzZc7vstzlCq61vaohkgiW7f3Jwjv5qi7DtqfqV4omMYmb0CruiOORFp0CAYIGob4a+mHBmt+09IT2q5+5Ec+uuaJ58yXCebiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=c2B+ogon reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="c2B+ogon"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTWYlWbpuVg8v0dqJZMHbOcDE/dvc2P/khQ8lSwX3JePKb5fwEAOWSLvGhIjaah5m/yForQBvSJPb3484X8+hAu5+9dJ1vsBScDK6cbqeOsItmDN8YB0Buk1rqBttrjT8IEOSWZcRvb+m9ISQDIwdss8kXcxoG3nNyGPqPPzEa0G+7KIpUqkwxh7GdPW7ZZrHXOpEjYteh/RGui1gVg6ocJPF5H35tPmaYfAyy/KZbrlqfH3o/U7KdSCj2gw+fEhWo2g5/PZdFJR4pkR9tKze8G+tSkJ+PxIYCeD/dyZ4tDg9kAdVDhZUvEKgZxeMk6ucMBoHnTj26A/dJw06uN3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufnu1cyJ1PqdxaJ8xlROMTwtI0CkYUNpMFCJbar1TI8=;
 b=zFCcDWcS1jYEYomycJJpvZunfdeWlZZ6Xod3afY+KpmPCQ87iT3W/zENHNYD6lLmWTcfV3sGtbC4klee6Rl9iKnR1mOTpBUBvlcTFxeYlmkQCXt0AvG7HeOUg9g/5ekrr11iGJ+fpKA0ss7Tdi3j3l4qw8MZTSxKt3D4iQx9J8Dpi9DnTeulDU+IA7LMEj1VH0uS/N4gmLrcU6LnLX2Hg4nR6pVOCzR8ODlgDXVWAse8IV0w1XXHqLddyJsrvvGjBNRlWLhkGZmsIXH9QMEHZOcE8tOk6TdMWsQL9V2YbKPnX2565MHZHX4B9NtvZt7lb3s0byVT6HrCpCsfh0DPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufnu1cyJ1PqdxaJ8xlROMTwtI0CkYUNpMFCJbar1TI8=;
 b=c2B+ogon7sGuoKpVDqSF5IcKMWbhlAiUbIYuII+9L0WnWxiNN9X86Knw9TVFH11feoMF3Kb+2eJ3chT3RWVqHjbQdyTGzNGoSWhp4cL2Ardot9mXz/VoDt7hglIEPElTGQQOvUgVDFGIglVrltGszn3l1WodnyNb/+e5weazaco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5326.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 02:15:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 02:15:24 +0000
Date: Wed, 5 Aug 2026 11:15:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request
 helpers
Message-ID: <6squdujudud4uhgr72wzhnbiq6rg3b56vsazdxztgscbhpehsz@nz4njedhvcdy>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <20260804035230.538CD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804035230.538CD1F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYWPR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: f2025f98-22db-469d-06f7-08def29768b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eVo7n2orHCsoPDIziHMrp3wgsGr+9j/J5qEEg3j/zqcPEN+qF/hXIb0xEj08RFoRfPudM0QWtnCT5nCVFfCU1//4XAKbK5fE4NlHYvnHmB9T66je6uvxIYH1/DvtwMy1eJ41M8WSpfsUDODbpni8gan8Sgwkwox1WbrXzoXTT6HFMjBNgWfGExztcoj77HBVNT+VnpmpAXRePmJ9Uz/G1fIUE/CcokeK38hftydOleY3y9H7RULDuur9e6KnGsE+LHdZkezO3o3gsrGxe764l8Dtl2AVGdGql+zzEwzaIomZ7Szq9IU7Ty/IOIpti0WCWD+JkioLcSknViliF2w5qPayadDAX2sIRFw0D1zQwbw2k1qpo92wldadVMX45Q+skqi+YFK/BpunGBvudNK/GemhSRo0H71pY9xvjA4s+opqOoX03/AK20fmPAueU4M13fYjUiu7YoU0pES5hZockerkKEelNkga5YjgJAmpPV9AaXwSIB2smkFJ66jYmUO1ZPvxeJbu4PTujlAWyTGWgqhpF+UZgLqTX7Aot6xVS18BJSStnaXuaSTXoWzdx1r8CYx+3p8ejRAqm0LnrbcKtIN+E249Dhx2GBCQ4fUzgRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?MgE3zMqIcRmidrdkQxIfHgjQyOjxOTTgKNm+FBGQ14Hm6XEkiiOdweBuzd?=
 =?iso-8859-1?Q?ril9T2sth16GyzAK0PypVpXdu3UUq6hE3vJl7aPwaXb6xv3llLehk9XU0/?=
 =?iso-8859-1?Q?V2C0N8J47lR3Fyf5gPRPkZW6lKappjN7oGvN1plBFwu8zhoxmEiPE8jPia?=
 =?iso-8859-1?Q?trudSDekQLISNAK68ZZNuUEyhCrcauYPEIFdoeLyAME2XoH4yjhzlUAqeg?=
 =?iso-8859-1?Q?6WeHyeJ5Gg7o4ZlaGktrLgvJAvSgnu3qrwbcyFb3JuLcCVgmQEiEAh/Eel?=
 =?iso-8859-1?Q?j/t7Luq2+NGxl0GZKJKTjmZrF1m02lsgm7d6IcyAkaMc0ZZwkPBHhMv6zc?=
 =?iso-8859-1?Q?03PlwFpiKJ2nTXvn8leTDdQRk7oaQoGUinpc/gn6maNLX9iz3IU+XvY9ad?=
 =?iso-8859-1?Q?w8iHYQEuiqOEmUa2WRoa6hGsfJAFReziluns43NgHbyWR0zPsWSsPq8frF?=
 =?iso-8859-1?Q?7uOexzNagoQRCfeRzij+pqjfPeTceTVx+0+uk7KW1OwwYRQabWJIsbv+4H?=
 =?iso-8859-1?Q?+MqsxlMMiTk93jtWZFNGEfCAA1/zRhOSvdoXuWmCxKyYmoosm/cVNCPa2X?=
 =?iso-8859-1?Q?te8qWXFF0tTsJSKRWxUSWS9XxS92zhKlbHo3agSW9wcCp+o2/FjmTCYLmF?=
 =?iso-8859-1?Q?7MWCmaRSoUYx9TLHzp1IKYh8Ec/xFoJT7o4VDEshqL2KfbJV/x3cvmHSaE?=
 =?iso-8859-1?Q?uaDH0qX6EtHjZUdErQFs5y3ZQiNvxEMqOxuyNmWCtxB9PaEawy+dWr+vdt?=
 =?iso-8859-1?Q?YZbsD51H/2fWNhZQfvo30OONZVXuKdcRmQn7HjtZ+VhdJhazgoY4bWykUO?=
 =?iso-8859-1?Q?Oo7hwPBGOIo8nw/AmQM6/dOLJfXMnuka6Pub0rvilRLAp3D/9Aykx5Izl1?=
 =?iso-8859-1?Q?dIRu86bf40gPuwnvM/4lhfEDr5px0ITkuEdx9GOBJUtn9tI65LiQgOamcL?=
 =?iso-8859-1?Q?oGe0n2ljx1dIBkK6+ctL8Q8j/K+fBnj/WQmWeGII7952iY1bray9o0332F?=
 =?iso-8859-1?Q?4g9wY0E54GFQVCJJEt3nPTRxSQPJXToyiIYOj4DmBT9Y1fQgLNX7ODD6Rk?=
 =?iso-8859-1?Q?5WqlCFZvUTvV0ZzKAfbbDz9TB9F3VupFnnrBMmwptrsSKOAAXVGD8fpogU?=
 =?iso-8859-1?Q?GrYXnQAdwofGckRWely081T9ObeoPa3bx83yEyaKfBXkG/NbAw0QuJI19n?=
 =?iso-8859-1?Q?Q6uOYQGpXWogYb/k7+gM3iLBvcblR7J2iWmsoePxm4ZWJ8w6jnNQXNmgwr?=
 =?iso-8859-1?Q?xGnixoCbuvQQ4fYlrKLOEpQO56gWth79LJReIVGD72Whjzc8ZWgEaPIFkX?=
 =?iso-8859-1?Q?tYWXwGhr8O1r8uxXinikEzqXQggSPN0ucHbGGOlnrnElNwEsK4WNARNRZB?=
 =?iso-8859-1?Q?X2zdERRNWX9SRRg+wz7+dzXEi5fuDzU+ng+QDMt065KF7l0pi4HVE39nvP?=
 =?iso-8859-1?Q?gb17WKVPp9b37sNTymlvu2bHysUEyAnUrZTZu5+tm1oYHAMqegnY87wcbt?=
 =?iso-8859-1?Q?NzeCFd5R9AFQTIBjT0NLEHwBMVshzMiRgFW6NDEsPaEI/1GABYC+GdAGj4?=
 =?iso-8859-1?Q?JeAmga9saaY4qIKH5oXlqn0MrmmMRhp+dqEbhYoxuQKoENMR+6vsV2IttW?=
 =?iso-8859-1?Q?XiOYT7X0SRUYPS8mUIACL07UiG8jvGyDJktjEtdDTGY9l5FHQjw1OmzCOd?=
 =?iso-8859-1?Q?FojswevLKGFgO46n/BhDy+TiIZnQi3NvbUT/3wPoX+zigD7hUz58DtNWA0?=
 =?iso-8859-1?Q?qiHfg78W/MQYbGpECXbf2U+vt4P+Miv9yjH5lpmg5gOBxBTzuIjFo+83bz?=
 =?iso-8859-1?Q?1Cx89sheDmWSEoAF5+rF0NN7jw18rGqhkcjRPAti9chr9cYVXJMv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2025f98-22db-469d-06f7-08def29768b4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:15:24.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iMhq/R05A8W6OXGmzsikKVF50iINxg+XVJEbJdL7pfU35G+thwyVTBO10E8tWH2fa/TPLrXY67ta5Q7OOy0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5326

On Tue, Aug 04, 2026 at 03:52:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Releasing a single delegated channel with `quiesce=true` on eDMA v0 hardware causes a data race on `engine_en` and incorrectly shuts down the entire DMA direction, disrupting all other local channels.
> --
> 
> --- Patch [4]: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request helpers ---
> commit 0987248b986738e4870e25b1f36d8c9f2eb69d8b
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Add delegated channel request helpers
> 
> This commit adds DesignWare eDMA-specific helpers to request and release
> hardware channels for delegation to a remote host. The release helper
> supports quiescing the channel before restoring default routing and
> releasing the DMAengine reservation.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1f893dc54c793..4c0d2bba755b5 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!dchan)
> > +		return;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> 
> [Severity: High]
> Does releasing a delegated channel with quiesce set to true unintentionally
> disrupt all other active local channels in the same direction?
> 
> If an endpoint driver uses some channels locally while delegating others to a
> remote host, this call to dw_edma_core_ch_quiesce() appears to escalate to a
> direction-wide shutdown on eDMA v0 hardware:
> 
> drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_ch_quiesce() {
>     ...
>     return dw_edma_v0_core_dir_off(chan->dw, chan->dir);
> }
> 
> dw_edma_v0_core_dir_off() forcefully masks interrupts for all channels in the
> direction and locklessly clears the engine_en register via
> dw_edma_v0_core_engine_disable():
> 
> drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_engine_disable() {
>     ...
>     SET_RW_32(dw, dir, engine_en, 0);
> }
> 
> Since the per-channel delegation API does not enforce exclusive ownership of
> the direction, does this cause a data race and abort ongoing DMA transfers on
> unrelated active local channels?

That does not happen with the current consumer.

Patch 3 documents that the caller must own the whole provider sharing group and
stop peer programming before reclaim. pci_epf_dma follows it, ie. for eDMA
unroll and HDMA compatibility maps, it rejects partial delegation of a
direction. Native HDMA quiesce is per-channel.

A future consumer could miss this rule, yes. But adding group tracking to this
generic per-channel API feels too much. I think the documented caller
requirement is enough and keeps the design simple.

Best regards,
Koichiro

> 
> > +		dev_warn(chan->dw->chip->dev,
> > +			 "failed to quiesce delegated %s channel %u\n",
> > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > +			 chan->id);
> > +
> > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > +
> > +	dma_release_channel(dchan);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260804033855.2115817-1-den@valinux.co.jp?part=4
