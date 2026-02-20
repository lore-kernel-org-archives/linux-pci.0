Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021084.outbound.protection.outlook.com [40.107.74.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05461BCA1C;
	Fri, 20 Feb 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558960; cv=fail; b=Eto9FANnNBB5OZCpQxONOtu1quS6u0Ka1SdGfrs2hlEwHJtkeVD/UxaxkCgnAVywzEuCKMGEICgd1ha66G8TTgFqsivwvNvzwzfMSgRA4wiN7Y1e952wv3XbNajJRgU6/fG4/nPzfOLkhdqsqxy9LqAKyFn7Vo73gvnENpHiNrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558960; c=relaxed/simple;
	bh=9cqa826ij3disLs8BGohn90E+ilPt170SoHzX4zblYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNt0OWKFTh8Ug4K7r8G5SGL3thVPE3R8TLDD8pV46aibKSdsdQUjxzHAu0d187VsLOtOxe35UMaIKIbdnDs1KMMv5mg/wB7ef5dq5ZCaUsGbis3CBBCZlDBbwCQDrBCtE/ou0BG3CZtJ1/6rhK2liYE3hpxvy8sCIaSSSgBiuMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aA/6wkqG; arc=fail smtp.client-ip=40.107.74.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aA/6wkqG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfgCxXanMYxh7HmTUaGPIjQ4JiAJCslyp8cSlcMPhMH7dBgrji2XlWmaTReww5A+LjqrVWYUkyFYB+KyGVKr/SCr+UKFsRVcSqj5L4dwqs2ZnHupduoOG3Y7c2b0fsXi4Wap1u9BuS7yniCd/6208LjCp71y1Kgcb/1ZJkjYudpvBKenZPYQCOlXa4tftxLnKhYoQ/BeKiHZWv2JDBlj7cyld72SBrUzC0cNFsiO3KjQ+5Il7h7QSmMMtimFpQeeVGjitpdBx2ZAaxxaUdfaGMr/+04BkO6pQWl342CE7MGuyCs9WfW6N4EevBza8xjxXAssltCPKuOM4DaIhThoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76CTKRrLYYl+U03M0zlxwN332ABUZm5xVxX3CEwfuG4=;
 b=OoRyfX/S/DEq4DLkEpAR68iime4ZKoFvna1ne+77gA9/Q25KmwMli9b2eQVzGIVGzfri/j51rYZU9w0lah6EWfH3nRAQ3vV0eOS2d/r7yG72824k3M8PNvCf4Uhmz2blDi6xUY5O6GTIbzOy+yh7t9xwvQ9Cf6DuzE4NMkA8dDd8RqwugYRJjYWGFEYR4XUUf7K64QdOXti/EsDSMDiJvMEJdkPraAxpTc1+Kg8bKDmHvBJKy1g9H+8ehjO4/067D40kF/mXFMvjSj4zdnWC+QDAjRLCN+ymyM/ejJzDQEaStoEolNjYAUwW6bd+KlE7bIEIL0djLb2YfLJ/LhFEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76CTKRrLYYl+U03M0zlxwN332ABUZm5xVxX3CEwfuG4=;
 b=aA/6wkqGxD5KWm4aSWlnIY5IFlcdPD8ZQYVmM/TOLq0ySiauJyoupU7Y9DzfmN1Sl2zzPcvnFGTvaXdWn/5PT0lnWTcJl18lDvWcM0biCfqacsR+MFMocyV+lXttHhUW+ZQmjQCniyBuMdi9xzPLe5LOSQ6NmYdLKd/KaiiKx7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6303.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 03:42:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 03:42:36 +0000
Date: Fri, 20 Feb 2026 12:42:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mani@kernel.org, cassel@kernel.org, kwilczynski@kernel.org, 
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <qqrkf3myjmag36xsdwucqirlglxyqvf45xkmekaegy5quqmy4i@mur56m23impb>
References: <20260202145407.503348-1-den@valinux.co.jp>
 <20260219194356.GA3493507@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219194356.GA3493507@bhelgaas>
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b49c557-0b92-4566-448e-08de70321668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zcqpm9JbpZRrTQPytrO/WYK+o/JJx1Vqpwkzlxy3uuIBDpdH6KrIRZvDG97A?=
 =?us-ascii?Q?A24JJ2peCKAHKcLd97aaDVxGdAniJZLfyRBrz+dXBBuFkZN3RU1XgHrH22K+?=
 =?us-ascii?Q?KqBE7c2Ebn4mYFjRfTYfyOSIwWg6z7xPFpJMl11U3rWEu0sQEuPB4C/9+fH6?=
 =?us-ascii?Q?Kkhtdh/dWuEiakSjSLHWI2JTCyFWODNoft38XfcfHWr88RqVW/qL9/uBk6bq?=
 =?us-ascii?Q?CWiNGEtLKlpVnjvxZjckAreaZZH7BH9hvsBgxCUrQzPzrLIzp/NL8tm2e8/3?=
 =?us-ascii?Q?koXTBPO45nN2l/mDuIrqCQzzv84UUaMcSjcMDeU5ONdTIoUbfOhwTrO8BUDF?=
 =?us-ascii?Q?FjbHudNLDv0TcWYIaG7kkT6rcSrA8J5m0nFepo5b7enYYspSWG/escUiVuLq?=
 =?us-ascii?Q?a4RXW7oZKWG1DHNrLeq9HTq0SNl1SOo9mfKCgkI/JXK3ylSRjOyaG1mfg15u?=
 =?us-ascii?Q?o/uYhVfZ0zGRlLn02ikXDrtkUTkUCieoA0ZXh9NClGwwD/jq3GQ5pG6M81Zc?=
 =?us-ascii?Q?OLctBYl18hd5e4GwVigGCYFLvcSxlqTePCDy8+Xxmng5bu4UpuNuYZZDGCGI?=
 =?us-ascii?Q?HeuRUWVUgCbdmLBEJZZ0pOh4LCvKotbjbQEmQ3nsmbS7I9Hyfj385+jl7RT6?=
 =?us-ascii?Q?Sya9NtGc9L1/cV4YJ5nqn1WW6v5U0WI8KKi7bNJVCgWrM3f9NlQQ9yO3VhsQ?=
 =?us-ascii?Q?/IAISVLmDGtPrF3Hw/o1TaZO68+NDlsPtjU0PM0q7Bb6t1GWf6YWfU4fftKq?=
 =?us-ascii?Q?UtavqXlYW2+umwTvoc4n2U/aRgMA0GCXtQDqsqUXbZUako4/GvHqUPuQQZT5?=
 =?us-ascii?Q?KK/Nuo4qOPq1sQZdOsO4hrQoamiIv0y/TyU2vPAq4LprhfJq3iPx7YxEiMry?=
 =?us-ascii?Q?HgZXOKfFVCArwhlbD+tc45DloD1ghFDolwDNzgm6nnCfv1m4aWunA6vjXMmB?=
 =?us-ascii?Q?U6OXkQjkwBw87EfKX3jwEnXbiR87+4of03A5joBhvtNMgIhvAyBk5EsLHaQU?=
 =?us-ascii?Q?FLd/oxQ/rUd+hZiuCAClv3QmQyG6cB5c9EgjemFxW8twm6zfEQT/ofJJTi5a?=
 =?us-ascii?Q?FQOM/J7eMmY+g8vJGODNtopNMh4ndIsTeJZCW8mRVsMFEl9n34nFB/XvSml2?=
 =?us-ascii?Q?iTPRLqflZ4IKgLbR3b1OJmC0/gwjVWF3QuKtVy1BHRLqIIZlUFTB1boNVzsM?=
 =?us-ascii?Q?5oiuqjlF0XqBe+rGhKyyMsdNRHIrCJ15bwwDWcMUOZ2Fa32GaKm8EjQEeSh/?=
 =?us-ascii?Q?WmRq7l5Zs/KvRQZ7SMrH/2uMZr3Y9/hFRdJfWbIiPNXwaG7jrzmQygCkNXOR?=
 =?us-ascii?Q?oNLVWfRuXxLfGk7c+cSxAKAAcPWsEz2/W02JHmI5DZvxY2NoEcwMX1/oDGHX?=
 =?us-ascii?Q?rduPg6hPT2Dyz5Zgy6c6i2TF5KulLQ6CYJ1BFTbKFQKtvvwvwzH+LUBPwePr?=
 =?us-ascii?Q?RpTrYS6wPntKuUQ9ki93N+gAvK9vrCeXDaxun67ynb/KP8z0vGPcKdUlvv40?=
 =?us-ascii?Q?NrLaZd3vbIakMszvS6UViZd83nY8wYStdPoEMue2mkZ1SppefYO/DM9YjOu3?=
 =?us-ascii?Q?RyInpbIpQME05UqF6VU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyjoS0sDyMHVSlVnINBKZ+ks6FOSZrbFD3lRcj1WZz8fCA9i/URrgcmiEYOj?=
 =?us-ascii?Q?EksxotwvN366BUXqdECiSoLr5kdQX89HWFgaSNOdIYeggpoDE+lM43TJJ7lE?=
 =?us-ascii?Q?4+6UKsqst7NOsIs+e8/GotaVOWhU2yxk6NGXRSRfG2PRLYx3ok82HuO9TOck?=
 =?us-ascii?Q?taogAjoF2ZsPantDuC/WXaF01BjzD0TedcwnvcQiai1n1FmUwew12rFnYayR?=
 =?us-ascii?Q?5EF71KTjaDccHh6Ce/azVwi3XA8V2KFxBn8UW50Az+/LvaMyxcoRFgPii1fQ?=
 =?us-ascii?Q?RPW5ffqBdb/og8o6BG+NSMK1mnT6D6WeqzrBT589dpquzwoIJUd4o/PVOBCr?=
 =?us-ascii?Q?FOzH3XW+Vl0keS3koDweDgaD/2eT4qoPAchKZ3qfeqTI3Ufm8guIhHUl+h5q?=
 =?us-ascii?Q?dQbtFbz2QuTuysVolsPGoIMIabedTgZC/lHHtoR29IXwJs9z2sY40G2qvsM2?=
 =?us-ascii?Q?24QvblTHGuVltMH74Wrp+BlQ9CXSowqqp4OUJ8h9/9dyKlh03X+Swy5vuMsm?=
 =?us-ascii?Q?eUbQ3/YhM0FyLkOWRnVbsjhUz9MUTflMz09j509ITn1JGl+QCn0F74SvLh/v?=
 =?us-ascii?Q?oaNOKS3WKt0N1SEGAFNtj0tAkvNKhZxdM5MPfStEydANW0eKLK2fJIWLfo/7?=
 =?us-ascii?Q?BdytvGauW/0Drd2UalSKu7nq5+2Fr3+vOtN1sfls+q8rsjlvm2BNaLOZJMYa?=
 =?us-ascii?Q?t/kJDG3YqezCqoKP7oWhcqbVW7jkh7cuRlsV7IWtT81KMC939aY9Bqjwvwjj?=
 =?us-ascii?Q?7ud6W4QGX/EgiAqSUCH/98yHb4uEO2udwLpd+eNYOlOf1U9MpgVpsMmdz0GV?=
 =?us-ascii?Q?y9Tfw63t2FMA5pO6T61W1HtOUTkvmF9zA2YCkDoitwlYoQHqyJ7UhzILRgAH?=
 =?us-ascii?Q?DZ455LgWFtXr3pKkM+PhH7THEcoT0jiVXN4HEWhgPKqxCjv0lN23meLpMFJZ?=
 =?us-ascii?Q?8GjoADP8RQOim7JaRSuMJyVTVTfG9lOxtFeMiSyGu+QK94keCmCGI6WS2CL9?=
 =?us-ascii?Q?mlrus6kyUHkOP3Nk0GJqK6weFUbcSvU+6ebbryJ82xKIamMBTOT2trh+/cyQ?=
 =?us-ascii?Q?JDDYKokVu931pKn4HtSSL7dn7s5omwBAqsBPUXjuqdavpH/UWLoA7ZjgElm2?=
 =?us-ascii?Q?TWR3olkMYxfbI6sQY56HYIBkXoOTsZNL7I6LBRubjhYOuQGcJt6hARtmWqyF?=
 =?us-ascii?Q?5Z7BVrzkwWveI/eLm4NRiwLLAOdVDR7U21ed+zhGwmC6tecIwQGANcCQAa9B?=
 =?us-ascii?Q?wzrtrydUfQ94WfGIMjv1XBzFsJGV+PhrbGnaDKQE0ql4D9FvBk0CFJbSaT8I?=
 =?us-ascii?Q?oszd/VGPzJPk0U/32Yry8fIG9dIQdCsoSr3Sno4ZrOnxZXcnVNs3YJAg/idL?=
 =?us-ascii?Q?EA4ijLE7ZPuQik3G6BC5htx4U7ms9yQokzfNFk/AHyclutCicSJ1oLhJy02J?=
 =?us-ascii?Q?jvfxHiAhbtNlqi8TqhkBDPaalich9FTW2v5ibyCsJj0d+4nztSJdpOFTLAXx?=
 =?us-ascii?Q?FnY8Jcd3+0Nf3xWR5RU/HVjsdVgJ7C5KulMtYoiRfVlXuiYx1hSkvlZiGivd?=
 =?us-ascii?Q?UoRbdofGaNrLyIlvWddi0/6aG//ijZLAMExAOkNzlZHJVCYMaoEt9jkNxIU/?=
 =?us-ascii?Q?74EnSo+2vRClVRxwIm7d4r46uWf1NoOZsq8SiGVzOfRl3BxPJVg7vi6XS/Jm?=
 =?us-ascii?Q?L1TQEhMHyqU4+Vb44CvVcPKu+pl51X/2tU3ksvvMiB5/F4qDUbX1QasiR3bO?=
 =?us-ascii?Q?rK+ZnvZcNDucDMwEmICLZlbtg+iWmv0UfHQfs2/SnfGtB3/J8jdm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b49c557-0b92-4566-448e-08de70321668
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 03:42:36.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1Ev4+SKJI4YsLtgp3K6F76k6QmVTYn/xQzyJbdmnbafYp+cO+L/7wquxNzLea4+V+36bS3W8KfgPbB0UOtb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6303

On Thu, Feb 19, 2026 at 01:43:56PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 02, 2026 at 11:54:05PM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > This patch series is a follow-up to a side discussion that started from
> > Niklas' comment at:
> > https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> > 
> > This series:
> >   1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
> >      by returning right after clearing a BAR-match inbound mapping.
> >   2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
> >      dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
> >      reliably distinguish BAR Match -> BAR Match from Address Match ->
> >      BAR Match transitions when the same epf_bar instance is updated in
> >      place and passed in again.
> > 
> > Base: controller/dwc branch, latest:
> > commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
> >                       PTM access in multi PF setup")
> > 
> > Changes since v1:
> >   - Switched from the v1 approach (Y) to the alternative approach (X)
> >     that was proposed earlier in the discussion.
> >     Details of the v1 (Y) vs v2 (X) are described at:
> >     https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
> >   - Changed the subject.
> > 
> > v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/
> > 
> > Thanks,
> > 
> > 
> > Koichiro Den (2):
> >   PCI: dwc: ep: Return after clearing BAR-match inbound mapping
> >   PCI: dwc: ep: Always clear IB maps on BAR update
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Since this fixes an issue with the new inbound submapping feature
> we merged for v7.0, I put both of these on pci/for-linus for v7.0.
> 
> Thanks!

Thanks for picking this up, Bjorn.

Best regards,
Koichiro
