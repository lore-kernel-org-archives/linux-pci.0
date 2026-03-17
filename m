Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020094.outbound.protection.outlook.com [52.101.229.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1E221DB5;
	Tue, 17 Mar 2026 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716234; cv=fail; b=lDOwiWkTl3Dmf/g1ePcGIErWau37clg7ARvve0z68K6Ar5LuwoOQ1Kv+UdFvAnW0AosoiBZQPrTvWkKDCYq6b8s+7PL47kfcObn/VQZG3srvICRjbx6weeayeKo2mxOmkMLsUwrcfRY3vnnl088IFEMblAENqcpeljQ/20Zu+p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716234; c=relaxed/simple;
	bh=/0LFaiZQGAyyWI0mgCTlUSRpAAcHBXDusuqwG4yA8LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CU2dFY62q2LH8i76iWw48vr054wIVcEdq/4SDpS2wmTBWp+ooPqDOSFbEo0s+YMsIJUilPkKey1+krx2Ay4nsF//JyglsgpZ2hMVNofTXcRpYoJVmtmN09TcsLg0lVRKd9YZcfqqrhT+12X3AYGjXdS3X92jQ6w6UrbDLcGi1NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QR8E6OhP; arc=fail smtp.client-ip=52.101.229.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QR8E6OhP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5JAKVNtMzoyTl9wxywFGqxNMiNyimIoR3Ztnlxj/0r8I2OPa2BPeUcMbxuD0uzLuf7ohhQtGPk1W2O0/gUcgVead+cb/rXTC2iHTZLH0sBk+7jsXrW/4oMJj0RQCvqLAhpFu2k+dNvA55qub5IfLAQyuG1TWR2pV8ZQN/lXHCVgqspAvrVuf2dxGR/vl3XjwSmK+qM2KQOYZUsZVEeH0DC+WNGGBDxyeBWGGCTzKmbOeqoSnLPmjes2qCBOfb0Agms+cg+pFYO4HbUCeBdHdCQLs7q3q3ia6hvfwfImBIQydUro5mAr902GYTPNU4voqxfwRYfdyPdm3PC72qj1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyszJHtQyUPvoTjPjfdSud1OaPIE62YUHK70lISMnS0=;
 b=nOnginClG+DY2wlUyV7RTJPzFUxidKyeVsJZhGPnZowvP/faufcyYYWJajNzww/Vif4/fvwmxyfm88RPX+zCaDi2zpYac0NpJjFAUJ9fNchbim2SYprfjcdCsyIUwj20QbFOb16rSDdjQcTWrOOiedos50xk+KlQqoWG1Pc2o/jF8VucRCe9eLLuzryp1md6m5YUtbxZICBFvB4Kn2GB+wp8Ns4itTaKhNzFHo0zux08Hc7//drTiq6QPKVWoWsV6xTKzl2euY0Oc/aQVC572yNQ1lsWSqBcXIONdynJ4Pwc78CFhDiqIUaR1yktgRYSAWgjHUQMzlyJU/IF6gsHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyszJHtQyUPvoTjPjfdSud1OaPIE62YUHK70lISMnS0=;
 b=QR8E6OhP5wIbpSg/P7ro7CIO3hxpOcPL37ct0b8IWemGwSID0RGdzbpXXidhkVJEzIQWq+IQRNYo3JCfGblflvAYSV6xu0pV2XPjiacV0AricpdTPDEhFrmoNV2iYRd01LdV2o1s3puKOC6QF67d5a9PsWoikzvXViQF7dbYdcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2349.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:188::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 02:57:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 02:57:07 +0000
Date: Tue, 17 Mar 2026 11:57:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Christian Bruel <christian.bruel@foss.st.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abgtiT6aI9GMEADH@ryzen>
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2349:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c318064-77a2-4767-9739-08de83d0e07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	If46JQuON8LmF2oZ7D5MTcEzN1RowkXjLg1woDzYcV2ZyAuCn5FKvr9ocS/hAQrehCwEs85LEWbiu0vSpflxThOhHoDKbLtyvmCocXT4xChlGpdrb53TOtdH2SEkNCZX/lcLkQjJMRHwhQk99s/Qi1fG5LJAHVJKrWUcWH4aYCXrb3I1bc+YhA9c5J+aHLk8n4ycAoKsvhYaWDjpyw2FN4zKesqlO92Ao/HLKmlD4QneJB4nowoUtXW2rKdLDhss/nN1mmfNbIfzEiKnl3+feLmAuS28GosoIIJMvi8SEJ0kZbIfPEGK/Q4ZbyeOgnrrhPvjo8p1kH2Sf0BVxdKJIJsGP3kCSm5qSEXnTBdbzYUFRD47kRVfD/3q2MhV819KLCiI48LOTtn/JHkq+QaynpF6ujlJPD/pUtei0gSFpedx28bg9+GDJPO5R5I5HCp81LajhmGFrU18s/43UlsGE9n03EhShSOiWd2+FPVM8O5MEJ34on7PPwIyXl05dki7SgtmfqvFn0svmiBOJjaq7wb7tf8T4Ys3FcOuqSJXe1bztlsXi/zO7n4dr/pxGIXmoJ7IPYGSYKI6euSR8OAMTaQnjBYnwgwe9HiIj3JpSkWfng/pVvfgq0TK8xNAvjl99yxd8N6FYYEkQC0/RXKEQi7OlCXg+Ay4HaFduGquc87bzH6GVxyG4fh4XbrjgWAgSleXl5Upzm93igXq2YUUzBJynSveeAlWIzrIg0Zm3kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEmFu4reT9B4RHSALCaVgsGbE+cDYj6tRSwYHACOPwhKFBYUdx2NBqITr0Ge?=
 =?us-ascii?Q?qlHmyV2d4/n7KxLlJMvHyIerA0M4xZe7TBjOCFXNcXZOJzlxwbof8LHPJzXD?=
 =?us-ascii?Q?ZKAWiYUwxPPw1FKQqS272WK8voCvBWevqCxl6yJB3rH0FzW7eXooW5WWcr02?=
 =?us-ascii?Q?mTzaOO1OJcNHKnA0ynMuJO5ZE0swjFN3kv/JpUNdxdNBEZNcl6C/nL9YgFpI?=
 =?us-ascii?Q?4uTcVfN6KYZVNJeBPbYICMtoqqpHFE20xKG5XBNf4chMvhHcctSfOLA5dDji?=
 =?us-ascii?Q?SFX+fUKvii3g8qHHFq8s8fytNNF/Ttulvyr+w9fIVbP5MUVPpcBj8qqYNiR0?=
 =?us-ascii?Q?/WCU/oMEAZbbl4A0wncj9Pbh59bWgWngrJarJbQ1G97k+4qAD7Cmt7HIa2dV?=
 =?us-ascii?Q?R7/mBrA9fcNl0KBR7CYlYXFwEFfv1O81j5E31ATaEJ0WDEBdUEJr5iJSQ0aL?=
 =?us-ascii?Q?Yw6Pe1mIe/WmWuONrxXetRNLHGzICpqwByLM2LxNrrzYLY8THfXDbLqnG1Li?=
 =?us-ascii?Q?0IRpvv4LMtXEu2hhhr+8tqMQY3VpzeIzxpgAkUquZ5VmoXV+mIxc+WkxMGNr?=
 =?us-ascii?Q?p3LSCfnJgaQy1sF9mv2FtmP72ish74m8k3+OcIeAI80IBzHrY/VDZ1wq7LUc?=
 =?us-ascii?Q?eeWgm8/oEg+I2u0CZlXB5rOIuECMYQeXFwqpeVJ2m2xq7Btx1f2F+7m4IEvh?=
 =?us-ascii?Q?SHUom6bgho2bgBhkKYiyrSEl3WyI3dd9v+wvocIkYuReXmDdyJwOE8xPmL5S?=
 =?us-ascii?Q?wOcvrBTNbqbXswlOc8thi/WHzGWCBtjp6lP88XhSblesWSE+Jrc/ba+OV/Pc?=
 =?us-ascii?Q?Kzz8hQ+yWTU0iI6gN8ZEFZmgixawKN6qqRu2LBx+EiK3wgKqFn+ObeSbluon?=
 =?us-ascii?Q?qsrEOIf6MYNPYTjOHe2myFuZRlJjzxKsBx8YZfXAzjt3h/NMHccB+XVXeV1p?=
 =?us-ascii?Q?Cx+D58r+QruPQBEwZ+sGsGqTvBIpDzC25rR0BeudyY4w9e177wNK2LRlPd/k?=
 =?us-ascii?Q?UUE4zPDSIRFvKWpUBwLOO5CspFLMyxpX/v3houSRaJyEb8OtHiKoiNxw16on?=
 =?us-ascii?Q?Z6JMdbzpioe2X+xgfactqJ5KUAd81I0f4ICrmeUJ+kcp3gOXxQfSdGG5GSIf?=
 =?us-ascii?Q?ucQ6T205VXpWbit8dtchvAUp8jzTrzlENeW063rtAyA+mIKPE8mlwmr6AGGa?=
 =?us-ascii?Q?wdPvJrvPLws+w2R/ctf4rWwZqyBdfI3o1LB7t2YY6BqU1UdQaiz6udxUASJO?=
 =?us-ascii?Q?Q3qWTixvmI5c9UwRcp3T46veJZoyhCMIKrzsajkGgu7QUkb4sTkQCNWfpCDG?=
 =?us-ascii?Q?5SLHxTE2ZG5dqmAc4ElP+862XNg6DDodoY5JS6XVcfZzhcQMzVcPCkJCQzcv?=
 =?us-ascii?Q?qQZpnNI7ls8wkV8erOau9N5q+mj5fuPBTmB6f7CLSodbcesfd8Hr6WPjMaiY?=
 =?us-ascii?Q?jGcZXT9L1JqmhcabgFbpU5EomwTcJSSM+mFUTf+wjBR5eSr10Ii2Pe3Mic8h?=
 =?us-ascii?Q?6iO9KGBCAaAYUK3fSZ7EQwwuIVI78eKk2D3/+Imav9oNMhvvznKvbBGa6D0s?=
 =?us-ascii?Q?xWjN7JvJyU9NOZSrmsLUpxIxpsBsfp3msQEwaAdBj7d63x/R1YyHaZHWJ1XB?=
 =?us-ascii?Q?/xCpfwgH12y5t1TBMkf2LCfxe3EbF1Poett6yGa51cKC8Bus6VmpkP5PsgoO?=
 =?us-ascii?Q?5Zl3XxHOOFNjmBg2sSullr1yE3deWaAHDn8GGsAiCXru70tQmKksPUBuUfVQ?=
 =?us-ascii?Q?uwnILlNgcxcLKskjVhsMp9XVVushfvBkpmyWVnnwBRflOor2tEZd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c318064-77a2-4767-9739-08de83d0e07e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 02:57:07.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: se20TiZfqq9AyvWvw7gIjEnrEsJ42JHYQKHnlul+CgFA/d7imMm8Tp8tJmMtNLmt1kGhZphg8JHaI9cXQSMelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2349

On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
> On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> > When the BAR subrange mapping test on DWC-based platforms fails due to
> > insufficient free inbound iATU regions,
> > pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> > not restore the original BAR mapping. This causes subsequent test runs
> > to become confusing, since the failure may leave room for the next
> > subrange mapping test to pass.
> > 
> > Fix this by restoring the original BAR mapping when preparation of the
> > subrange mapping fails, so that no side effect remains regardless of the
> > test success or failure.
> > 
> > Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> > Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> > Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 14e61ebe1f11..f44c36f5cac5 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
> >  	bar->submap = submap;
> >  	bar->num_submap = nsub;
> >  
> >  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> >  	if (ret) {
> >  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> >  		bar->submap = old_submap;
> >  		bar->num_submap = old_nsub;
> > +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > +		if (ret)
> > +			dev_warn(&epf->dev,
> > +				 "failed to restore the original BAR mapping: %d\n",
> 
> Nit:
> I would use a capitalized F:
> "Failed to restore ..."
> 
> in order to match most other prints in this file.

Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
when applying, to avoid a respin for such a minor change.

> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks again for reviewing, Niklas.

Christian, if possible, it would be very helpful if you could take a look or
test this slightly polished version and add a Tested-by or Reviewed-by.

Best regards,
Koichiro
