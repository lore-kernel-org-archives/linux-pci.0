Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020073.outbound.protection.outlook.com [52.101.229.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F92D595D;
	Fri, 20 Mar 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015558; cv=fail; b=ftLDeVtP0XGILAzRD/O1aolAom6rAK1d0AcNCMUpQxxZYFqG7M3SrMzlXVfg8vcUEpgMrrDwwUxa0SiVCZVj5dksrs7VQm4Xax/XTrc+rljkEEGil91v7tcATUo7Bk22CvjNABlZmhDTA0jELkuBM/XAk1asZNZ9SKfS7pdJ0qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015558; c=relaxed/simple;
	bh=6Q/6wkUDyHhR46KfU1vTF/OzEaxUgz4UTktBZS3IshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/71oZtPaUaS0+p3oqIE6E1L0tp0EWfiDHVv/NIIYgz6UHAM/wMWcdyy1fVamZK5ucr5reQpalOctnX/Oyf0Q0eZ6wRpn/mp931atuPz1fGAQgH4epR359OvLSSVjWvJZgdFNkvu8s0kdV+TDM+yTIt/xA1K9JP8pcxly9E7lSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Q2enuc7K; arc=fail smtp.client-ip=52.101.229.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Q2enuc7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrtqxztLpjAVCPtvKz8UilQ0bhkzDGG5wSibAxFHpZgB+V+EToOo0jSNMfQs6S/EGLYvFYK/Oko8xUYFcSCgdIyrLjVwWh5jGsUrdZUGSrGRSBaCXTgoGCpqjUb5vucH5W716SahnLDK4epoBdOGDif6R/qF7sOBJs5ue2LOg0EPaLCtWJ3++eee7SyZoWQ9Tc60pMbWplACVxr00L/GV4JoPhR+YiEppR3ENeD+z15jWVgqgxJTR8eq/VSp1rSbkDRx4cNCxIwaH9g8FcT7mgIZmUv9IO6kCI3LVTXmVYXq6IHlLacfmTn9E2kG5FELB+7PI3/KLu2Ji147ZPLRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ6D6fq2Jx0RD21yesreq++MliJxomYjPmAHeQ9Y0p0=;
 b=RjUia9+sF6alKatxUEMbOF/DI3mLEhK7H3aVmd7P3lN1+JPSqHR/iq0dWps9bGtyXMdKvzC1t3AZQNx5hErym7u6KFR9RE3BdB868nmvG8ne+gELm4hVnCWWaK5bNdHRB5aaKWpUWhI3yeulAHaDkukAaQ1U9Zee18AUKR79vIzvanC3qebxk2ibwqbzpMP+3z8JFxGWT1gZ+pG5Mn0hmougFZXI7L8mIG/eldc22EL43Qcuk9xusMzF+UT6l0mWSeJ5GD1O/r4SCSWcge5TY+L4VFiKKyP9I+Wz2L2Qjk2LQt5w6RhvYzN0ZPJilp6hVUf/HTjioLy+LmBzGlijNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ6D6fq2Jx0RD21yesreq++MliJxomYjPmAHeQ9Y0p0=;
 b=Q2enuc7K2jR0BiO2cz5FsVV+KHbkRGKoSAnr0mGUGZ1pkyg4UvPmdsbJb3rKejXh3yENae1MYpfRNhL5+GuU0X5XJu8RLR/byX2P/78jqUShC9alDAw3RRmSWlHPkDZ7Sknj0ZE47SVwbZVBgpBGJuaYAq0LKVuDivgsrkt34d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5562.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:190::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 14:05:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 14:05:55 +0000
Date: Fri, 20 Mar 2026 23:05:54 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Message-ID: <nk2cc2ikag2ofpskmnnc7mqzsvtizwcjm6rlkrkuqesq673h3l@mamriu2gshit>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
 <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
 <d3e8d869-1a10-4a50-a9ed-3c6bc10a6178@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3e8d869-1a10-4a50-a9ed-3c6bc10a6178@foss.st.com>
X-ClientProxiedBy: TY4P286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eade25-055a-4713-3f92-08de8689cd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IoF2ko1Ozr6IzdwclARwFYyatmfTl8wWa3o3ieZjxczKzyf+5IsImYRafXgm4MAsaIXomtyAEtCdIMESMuXR2UFIK0RyzAvPbuB6BDMx2DuDnnfJK5my6eb89UDki5qhHEIalH+uuNn2dFByi4XM0Zje4SEO6sm4y5FsF2TjW6j82/D1dTJ9YGNVmAvrmrIZUJ5bMG+C2Y7XOSRd7gg5vXX8I52nIzC8bXLVAt0uVBok58HDhVG4Rya8P3pDGgh693VlPG6tLlyY5df8QW9T6F36mwF8dsfVxKvWOYyxLi0SkIHNRnHjkx8yvTzk+ThUUMbNtcuBEEGYf1l7qxTeO+blF7BOD8Q0LQ0UvpShqp14ckNdTMw73dtBcRxsQytR4vapPeP6s6mZWuY8TP8VRwnUrHoyec/fURkyqFVkUvhQAFebd+3So/dHj+D4G95zEjLTdCBdM2qeUgK/vIER4WPxEgiI7zSTuZ+uVZC/Qv6/HrjMoS+FO/v0xRcYANQ1kwmTDdnMzDtgZ/yl5WJDgelW92Fr8WGycDFQCDQ3lSIaV24ipan5SOFgg7JgmSPkPpA7MUezosqlGpct9zJtsxknvdawJ5MOhm0Jgxbr9pUDnuRe2pORgKVDh15m3c9EwP472hPjhFKBea8cwm8oDoz5eBJM0plU5kQ+m9gYmu50FacnSb3xNotJq9f0ePlS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APw9rnsx+9iQjC0fwfnVLkabi9JuyGeYJZwWFmn5CIz1QbviO893HyeMkpz7?=
 =?us-ascii?Q?iMGjciXIWNywjYou7HtfouMfLUFxCQlcM6/TXwaV91dkVzzcGqhh4R8V8Ukc?=
 =?us-ascii?Q?qsSWO2wAsSsieLpJflBX1wpR0ZvrsA1kiBmc9pARm3ZsmDIXzgAormQ03orE?=
 =?us-ascii?Q?eO5CrBY6YoWbeeV1zwKgaoeF6QlTTf0R/AYY67AVVA+9M7nnYkHpQjkVGeNV?=
 =?us-ascii?Q?MPi75zslj7aIjSTgYTcR2TW6/JUQwxdUQ0JxFM2QEZkCSBDa2cT2cYy2g/ux?=
 =?us-ascii?Q?tn8iIGYksl/LmDVTz3gQi9aQZ0RQWokUKqjbMQMuEz3vdwXYJelwvaEZju/I?=
 =?us-ascii?Q?qqoVIx67z9UlTngJ6frpOympk2C9App3J6clDniISo1/I105WwDj/msjMRyT?=
 =?us-ascii?Q?fp1KeILVDe362jDsExWibxE1fPRltoTzizShvZxvzaK7QDhoLzVyM+v1bD43?=
 =?us-ascii?Q?byIVWUhKvmJaR8svEdBkOg846FWJyGOSVAFDLplEzdZXqYYD/y9UM1OTV5hC?=
 =?us-ascii?Q?h/n06HaQ9MG04bGXpx77V/3gx6LRrrIid742kWUDDAhRFNg+VHd0BrzZtUXi?=
 =?us-ascii?Q?RngG/QTxWcnglfdVvX9apSTfnMZiD1/rUk5dj/ssNwAdUq2GWkIcRG9EoeXs?=
 =?us-ascii?Q?IH6BlGBNAD6ygvc1qvXOQiUEhZH2OnhuwnfzMmacipYEHZ3gOOHo3vz/vV0p?=
 =?us-ascii?Q?jnJAy5JBPTByo+TYXdx9qnMh8UFiyF5yIaVKJDSvKHJ6HhRs2ArqVckFmTnb?=
 =?us-ascii?Q?Xw7W7lIJWqFfoXMpOusrSS/6/pRdpOv1qDFypcEwffEwyuzuHd4eYFlduRJV?=
 =?us-ascii?Q?XJJ/w8tvJBpOTpe5qqbmiqwbLPcZ7m2y5DJorCg4yLVQvg5QvWGaRnYe5H4u?=
 =?us-ascii?Q?B/I11UKBw3y10chSNVfGWNhd1tKuallBGkg848MKRtemvrMK23+k8oGdbGMV?=
 =?us-ascii?Q?n3sbkLIgxX/dt9yGErk+w41w9aa675ONVbtypKlTnmF06F39WTaMN49isamc?=
 =?us-ascii?Q?VzV33SPnRDZNZ2f+wGuYF5FVOfdcHcnXdqUYL5sM0TKzcnbxct0eSwWOJ6KQ?=
 =?us-ascii?Q?c0yDGwtHJFh8nIkHho3e4+AghfOx0aKv8f3KVilYvOPdcgcNnJW38DOu7Qi6?=
 =?us-ascii?Q?qpNIIy25/gqJDfg/FhFPElIAKjpCkCWVeKUlcMd9uh4tIGNfhq+NeAAmbwgK?=
 =?us-ascii?Q?QEY6xqe9PHnI5+HfAc59xR/t4W4LbdQfQz+Ap8kerDoBFGMvGI8geVH/0aDb?=
 =?us-ascii?Q?/FIUxzPS2PYArWylbPYHdmp46zABsHb9U5hNfhhsgmQDXXQZQyo36y+2mC9f?=
 =?us-ascii?Q?CMfrajSEbkyJsnZhjTLUYIrHChodSo/QPm7++80xB/hUvOl6hKxaQ29urIrX?=
 =?us-ascii?Q?Dp2vfAM8yDWHATkHfOxpaIA89kTWtDExILXEwDPHr3uqRPBtL8K2tDmUki6e?=
 =?us-ascii?Q?BsmUXu6RsEHNpaDGbhPh4yTxU3JOPfEOO92DWscDZrlmFZPSS91k18kc+iNu?=
 =?us-ascii?Q?38pxTEQLiCrqDquhwkQ+Jf9QNPMZXF0wiBFRJ4escipvsey45ixOGuKxuWEm?=
 =?us-ascii?Q?48q5r+FDih6EeF4iqiQUe4suGKzVUlSd1S+gd8babSI0+VTKbpyKGkcE4kaB?=
 =?us-ascii?Q?MqD3kbWTiabDqmy4Sdvr5hIGJD0lH2JCfSC847FY5rAF9o+ChMTL8j6MZKpb?=
 =?us-ascii?Q?b51g0ubTQzQFJxwTWepGCxuAwid8chMtmmt8zkZUZtnnqnBB5AkuuQOVvLJP?=
 =?us-ascii?Q?E63Ph2Z3vXYdwPdy5LqaN1jeinj7s3jSfJ/sQ5c4psrwXXwPKqig?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eade25-055a-4713-3f92-08de8689cd9a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:05:55.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA17axSasCgNppMe5bT/1t0Hok6MCjsFHlRgjQM27OYLKYuaCbybcXEgdMCgNj3VCWjBgfJGQGTKw4x38KjGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5562

On Fri, Mar 20, 2026 at 11:04:28AM +0100, Christian Bruel wrote:
> Hello Koichiro, thank you for your comment
> 
> On 3/19/26 02:28, Koichiro Den wrote:
> > On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> > > Handle -ENOSPC error. If the number of available inbound ATU entries is
> > > insufficient to map the subrange, skip the test instead of failing.
> > > 
> > > Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
> > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > ---
> > >   tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> > > --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
> > >   		SKIP(return, "Subrange map is not supported");
> > >   	if (ret == -ENOBUFS)
> > >   		SKIP(return, "BAR is reserved");
> > > +	if (ret == -ENOSPC)
> > > +		SKIP(return, "Not enough ATU entries to allocate subrange");
> > 
> > Thank you for handling this!
> > 
> > pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
> > https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
> > While that is a different resource limit case, I think it would still be
> > reasonable to treat it as SKIP as well.
> 
> Regarding Niklas's feedback to use the local EINVAL instead of ENOSPC in
> pci_endpoint_test_bar_subrange(), I prefer to leave this for you to handle.
> That will cover this case.

So could you consider the following tiny patch as a prerequisite for your
series?
https://lore.kernel.org/linux-pci/20260320140139.2415480-1-den@valinux.co.jp/

> 
> > 
> > If you agree and keep your current approach, then I think the SKIP message
> > might be better phrased more generically, e.g. "Insufficient resources".
> 
> OK I agree, the error message should be less specific to DWC terminology,
> even though this case can currently only occur on it.

Yes, I agree. As mentioned in my reply to Niklas, the other -ENOSPC is better
replaced with -EINVAL, so I just submitted a tiny patch. That concern should be
resolved.

> 
> > 
> > If you prefer to keep that local case as FAIL (or at least distinguish it
> > with a different SKIP message), that would likely require a bit more
> > changes overall. Note: Niklas' earlier feedback on the SKIP message would
> > still apply.
> 
> OK, as Niklas also suggested, I will not set an additional local bit besides
> the fail bit. The question is whether we should name it SKIP or NOSPC. I
> slightly prefer NOSPC, as this is what is used in the selftest to indicate
> skipping.

Personally, Niklas' "errno in struct pci_epf_test_reg" idea sounds the best
among the options discussed so far.

Best regards,
Koichiro

> 
> thank you
> 
> Christian
> 
> > 
> > Best regards,
> > Koichiro
> > 
> > >   	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
> > >   }
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
