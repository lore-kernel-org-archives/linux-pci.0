Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098A2C3749;
	Fri, 20 Feb 2026 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558537; cv=fail; b=uwqY+hC7tEL9DSYf9GW+CJiHx9wVdGpj4xa1Ii7ROdhurhO14/+ScWcAj+aQCI2BTTo44rhkBl3cGQnwE0re57wjfkkr/CXdlvItd8NDJBI/M0w6tL6JwgsFQ62HM4Wse/j3/cJgLlv/wuhKD/t6SpFEVcWS6AFKjVaCdgwoTyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558537; c=relaxed/simple;
	bh=7bYDLDx3uqESQVE2uQJF2+aafsrMUgI/MZFoz52Q00A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V3KrcyhFc2rNA9ZT1naQHvByZJCoYfzOLC/zgW2pYDDIupZl1VR59ZyZJkhAqUhOtvl7GPQuZnWRGIkzu/u2wO7j36+b7uGcY6tPArMUVD7UYpR4kVqwszfwaIayI0YUGV9ejKImWBd0vwOJ8SYFtrBQcAgUpqrfMZOAKaMCNnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b5Mo9Jya; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b5Mo9Jya"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSK31X2WRxB+DZA/4Ehi9c4EzoZ1wUBt25hMcFU67PDRxzRAp6iEmV0bIGbNawuSA1YQPp1D8LW0M4nzr2VZLJZGv4IaUG4JWWQ/tC9ZoQtM1pw1VF7xIklEu1VwsE5rJMfwcTxsbpSw0UvJoMQu3XMJU6RgyA8Ml/EF1hdKNPEkUrdOTlM2fPZEwTvueYUduUOka30Ex59hj48KdI89nBsvTMPlfGiH9QRAnudzbHR8hiCVmE8mfkTv3TXpgtCBwH05Ltlym8UdWBE0yLP9bjvNeRjIE5Dt5J3JFqMyJ80LLajdpNNk+S1ZEjChrD2gLDkIYPYmFci/IP7+PQkLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu27zaF7kCYpAie7V01DLHYI8kYbVkPI/BeHL0ubFeA=;
 b=mgVNrT+ZVGvR7mXClRD3Ml72lWu2vqOMwU1ueP0MtUo7w5NiXIF0KqL7pk9mdSppdIYq0wM8WektwnBf6BL4KwJ9JifElvGd/kT1vdKjfaYZqg2Yzucto6AMz0lcCaohSDvgpwj6ljPxeoNGkkztM4styZ+4qiVd8RA3o4C6Myamoy5jtbV6Mn4PgyhZEElHKEZAIAxCphItKhCYHKEZGbakpyyDLKIdvDbNZ7GOmxZq5NYvM7F8AeoQ8guCCwBt/9DdzDrVCvwdHOTrbpKN2apYJkLXOwabh1SJ9l+DUc51bnsNGpRplE9zrny8iUVqOMkn+jLPJrKJsm4+8+jATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu27zaF7kCYpAie7V01DLHYI8kYbVkPI/BeHL0ubFeA=;
 b=b5Mo9Jyaa5EqGp0Nh8tYApNmvfKcelx6HyCM5er1l6THuP1rNtkmCJasLwMq0u6YrswaoE+9zN7Mx6Z2MBt6MPqRQz6NJL4jr7ILPnQ9AZn8aRV/R6nXesAF9OVuPEjVrMDj6/9Didgkrpfc4GxpaYEA9zU35hshK8N9zwpLNAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4174.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 03:35:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 03:35:32 +0000
Date: Fri, 20 Feb 2026 12:35:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, kishon@kernel.org, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org, 
	Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com, 
	mmaddireddy@nvidia.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-6-den@valinux.co.jp>
 <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2644f5a8-c512-4be9-dcb1-08de7031199d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8egziGhG0v2OYGZEgEN5ZsF+6b1Ta2aWzsEwwSHo80yJrvIMS0K7k7NaljK6?=
 =?us-ascii?Q?oLKf+l7ycw2FuchLnpi2H/FUfe2Y4paS7j60kkWLvv9G6c+fcGf0rbtSVlpQ?=
 =?us-ascii?Q?VDJ/lH6VoCSyMoJAHCNVgk+wiaobcE0T59cO18yZdPL4RquE30PvgCPyAxKi?=
 =?us-ascii?Q?vS5ePb/UBQeRfjueDGMbYugCBH5+G4/fB2/YXf2jRc+R3+Xtxoc9pvDL/fnq?=
 =?us-ascii?Q?a9zlyslxR3BtTEWbeawhpesXz7MiiFvK9ziqcfkYXNo62fuLbdUWBCwJfMlY?=
 =?us-ascii?Q?nxaAEmcnuGcrYrVUrfK4Fvw8k0LB/3HS2gcXFF2Q762ZjfDNsNa8hv6K6b9c?=
 =?us-ascii?Q?+tycvBx62vLMXEy+anm2WFUCiVQfV/OF+LEHoUCyrrjQm3gxPWoBHdpHt65m?=
 =?us-ascii?Q?nUdKiKbYmODc9NUTOfkHHXGWCpsgmOMlGm5do9Qx5CJtSHf+pep8yZdggrvT?=
 =?us-ascii?Q?H9BPeXEybOROQdF4C8glEbT9160sv2TuVqmdzwGHx1AQ7FZMoidTk8ol6ZS2?=
 =?us-ascii?Q?xKLHAjuJH6hAnHKSLJ8GUdUbJ7zCsyTsoimGqaMdNg5JCl5gfUK7BpnwtEq8?=
 =?us-ascii?Q?OaRqh9JliSSbC0l6tmFOrFtJqLHfHf4I/ETi0dIoUyxF3mhlkBWfeGeOXrfj?=
 =?us-ascii?Q?vzzrTN1Mn4caCesTH/9MPzz7S1ch3TWfYjGBZpd733wZxi3C2jTffwX/CYXy?=
 =?us-ascii?Q?we+ex9xuEKeqwNWF0GiJ3I/IDEEcEkvz3Z5Tv1aqxYyD+NN7dJFJ+OdNRuyV?=
 =?us-ascii?Q?eEJouns4f5nbL+/LRRhexH8LlKuLGhYG9R1CqYzckY1z7ISUM/S45M8yNb7Y?=
 =?us-ascii?Q?E4+FI/JdfA9QMqmdmlCE6eGf5t9AyEe0ZOSJLyRt6PZV0+s4EDJ+UrsOxUkg?=
 =?us-ascii?Q?jlds/K4dHoQMj7PxmHAt6tP+dMHkPXA3naj8Y4uT3/x9g2rQVok+v4w9M4wX?=
 =?us-ascii?Q?8iPoTJn5BoJ5j+rc3FdgJGeVY6MBnamA9ze6zJS8kDBmhAaiY30v55kjCpkF?=
 =?us-ascii?Q?evQTAhXuhf3S2Vsg+cz488KmAMhLWO7EZgvW8rGR38QBFLQv4sc8UlJYnlNQ?=
 =?us-ascii?Q?gGnwuuImFka8jGsTSd9/LvwYWwjZsnqTE/g7pn+6J0tlU5AY8tw8ImytbRlx?=
 =?us-ascii?Q?4/K/SZ8oByZSHZXzm3PMlbKeAXI6Hivx1q9cZl1rfr5bnyyZvjrocdMO/d+P?=
 =?us-ascii?Q?A2DzsrhEvbGVMYXltC2GPYW5SeawkgzCXJykThfUs+qV+ABZMkN3O1TanSHX?=
 =?us-ascii?Q?QRmqVgpgUzsj5zWCsnkhCOdZbXMDIgqOKomuUJoYN6L0M4O2qrxwlj5b/2d+?=
 =?us-ascii?Q?zJBNV3u8qEN+qgTKxFOMUMJJ0adSXRFhhx94ls19smdlSzm9W/8uBhSyEVZ6?=
 =?us-ascii?Q?jcVWKjfaMFSziyGDs4QBjp/e51KvkbdRvD5XlaIW0gTsokHLU42O8awgQ1vw?=
 =?us-ascii?Q?egnlbESKWuFv7yUeBc0mD0+2qW/BhoVKWC2rqS0CV7JsYrggDmtHwPXwsGTa?=
 =?us-ascii?Q?KccUgM2mpO+4tRDJCvmz6DD7c5TrnJiMDPO01owu6Zh5qbgzCjcK5dkHp9BC?=
 =?us-ascii?Q?p/TV03+qthdS3j9ZNQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hkxq2j5kw4KgzzxEvQE4uhGeCxZUhl8qA607GNmltotXvHNqH/clb1xLscJh?=
 =?us-ascii?Q?LDU6pBBJvQ7x1slA+QOnOYH2zjt4DITWS3VSlKvXSt8MaCVHuoSqK0mfbWYS?=
 =?us-ascii?Q?1JZ9U8isqiWmTYM1D0O+s90bhBmtH1rk30DRtkJxqbDC7UnXEvKRxz1/XyLx?=
 =?us-ascii?Q?eLyKpbzEo/o60N35tFFyZBRrI0wQt4rwN8Vf4lxtDM9ZEMaktkBmJQDyL5aA?=
 =?us-ascii?Q?ADL6LtOr0eg4jPsZOtG06vYmlQlyAlQbEIytPIy2uO2OemvF49toVpG13qJs?=
 =?us-ascii?Q?rCM8d3f5f5aXDr8tYybswEOk2jofCDPNs199HRTCsiLt4AG5uDRzq1rRaI02?=
 =?us-ascii?Q?9dH8xRhB+yJeSTvU9n4ZZVYZk1ZGOQ+B7gY5DMeTy93JMmqKjo+UQwJ0xs3N?=
 =?us-ascii?Q?lcCmiijw2sTTwdFomJXj5vTTUfidyO3y828J369IMTuxGIDoj5a4VbdZ1YY5?=
 =?us-ascii?Q?fQNeHc0Txsm7fKgzVYygOSXoKyR01rRut4uQyo6mXU9hlHdD1vb7wN2ugY40?=
 =?us-ascii?Q?XtzvhuuCsM91Xu3rzWqSYU32j0TgDwl9+e5bI4Cm6LLQSpxL4/CTANE+zN3k?=
 =?us-ascii?Q?xoVl35e28gyDZbnmDDXRyex5dgrZ/p8MtBParj/IPzV3FWCAqVrPNHyLbso1?=
 =?us-ascii?Q?sCD5+ph84x0fpnfWZSJ5RdaNcxSeKeGZNjNUrhKEYsR+lgy2o3CgKXAzUpcI?=
 =?us-ascii?Q?TSUIcSVkOFmiaQub1dBFyHohLbk5Q6T902LNXxvZcK7QuobYzf9MH0+29/Bt?=
 =?us-ascii?Q?R7AhTEFUU9x5ADGbgo+aVTvMzegVpqJ65T0kWcM1LpDCr5elnpU2b8+aO8nO?=
 =?us-ascii?Q?xJwTbPPuwwKk9c3Kidn09RLLj8EFD5NrqLwcWz88lZzLmI3KlBIHFIEJ8hXe?=
 =?us-ascii?Q?6XpewTz/Zd/9FpBjMUW5QXh66b0g3WAl+FlFa9DnHFyXPAHCiwB2r6T3RrL3?=
 =?us-ascii?Q?rLIwFu/cMxutAbHiQiYzynpTdwYXcQPHB0JQLR07RqdJzXSwAnqhIHi3L/at?=
 =?us-ascii?Q?OlFTyMKLGH0mwIIGNlwyV+PLE2PH5fETusidWg86W+1/astp8N73hcuM1wlz?=
 =?us-ascii?Q?OEW1wxGm9i/ZxrypTc0p9ONGpWHrpOkvIA3WgQem5DdlvvytM0Uef3+kzBgC?=
 =?us-ascii?Q?OPs5m547czIzlx4UmjbfflhugHu6ymVf7v22r+00s66vTymEi5UkGoZFICpD?=
 =?us-ascii?Q?US4CIIRX9whgZXhh+VHWqCUON4h79Hbesf4naIj1qe9/fTMMZkkaAA7qAceV?=
 =?us-ascii?Q?8B1Q2lcFKkjQ/copW4Tkj9tfeszg93kPJvbWXdNrz95h0WeT8KZAXsPmrPyi?=
 =?us-ascii?Q?ZJN3xbZKDdDXRqh6CwSo1ZZLtULtt2Pahx6CcahPpzSDbpOGjAw/B4uD3Bil?=
 =?us-ascii?Q?1TvNt5ttUciCDB1lUmgEDKCEGc785qtXHaeMMRt2vcPnOP1fckSvn2S81XYf?=
 =?us-ascii?Q?PvNvIDXzmiXGVeXWDqe+9fLSvm86cz5mTJytNKSnmLBj4Vf22smigjTUQXpO?=
 =?us-ascii?Q?eKGdv4iWdZWBbl3KZdb+zjktMJXRnbJK9VfV9qHwQm/X3RIBmaDYBQ9tDyHW?=
 =?us-ascii?Q?iZp3Sx5QygCXCKMHG2RBWMhHVy8w1PkB7UeoHwdo8BGPlv8zrQm01fAx3hTE?=
 =?us-ascii?Q?Pb2tU0EgWRhDmu9xKzqvApazk1MdfqxXT2pHFDB3AI0jiCAwhDr8p4jTysrW?=
 =?us-ascii?Q?ypKLXH8RNiWqmjPD2bvJBhmQSewAfLs2gYySEJlcjXteBPD1jWOzTkGZwL/D?=
 =?us-ascii?Q?pFPvQITTQpEwwHP8uhXLuJi0E0JaOq6Qs7S0kjm2qeDTglpg1Yvm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2644f5a8-c512-4be9-dcb1-08de7031199d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 03:35:31.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+yDdi7PWcX9yuZBQmsoP9cJ6NHtJ/ay94rERoFz7lDbYbv3asNvTlBup29bAfMuso2O3hZKKnFN3Iar0TKkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4174

On Thu, Feb 19, 2026 at 10:00:19PM +0530, ALOK TIWARI wrote:
> 
> 
> On 2/19/2026 1:43 PM, Koichiro Den wrote:
> >   static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >   					    struct pci_epf_bar *db_bar,
> >   					    const struct pci_epc_features *epc_features,
> 
> The return value of pci_epc_get_features() seems to be used here
> without checking for NULL.
> 
> Since this function can return NULL, and other EPF drivers
> (pci-epf-test.c, pci-epf-ntb.c) handle that case,
> is VNTB assuming that epc_features is always non-NULL,
> or should a defensive NULL check be added for pci_epc_get_features()?

Thanks for the comment, good catch.

AFAICT, this is a pre-existing issue (at least since the initial vNTB merge,
commit e35f56bb0330), and the same pattern can be found in a few other paths in
epf-vntb, such as:

  - epf_ntb_config_spad_bar_alloc()
  - epf_ntb_configure_interrupt()
  - epf_ntb_db_bar_init() (the one you pointed out)

From the current mainline state, all in-tree pci_epc_ops implementations provide
a .get_features callback and return a non-NULL pointer, and the same holds for
the in-tree dw_pcie_ep_ops implementations. So in practice this does not appear
to be triggering a NULL-dereference issue today.

That said, pci_epc_get_features() is documented to return NULL on failure, so
adding defensive checks would certainly imnprove robustness and align vNTB with
other EPF drivers.

Since this is independent of the doorbell rework in this series, I think it
would probably cleaner to address it in a separate patch.

If you are planning to send such a patch, I would be happy to test and/or review
it. Otherwise, I can prepare a small follow-up patch (with a Reported-by tag)
when I have a spare cycle. Given that this is pre-existing and does not seem to
cause observable issues today, I do not think it requires a Fixes: tag or stable
backporting.

Best regards,
Koichiro

> 
> > @@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >   	if (ret)
> >   		return ret;
> > +	/*
> > +	 * The doorbell target may already be exposed by a platform-owned fixed
> > +	 * BAR. In that case, we must reuse it and the requested db_bar must
> > +	 * match.
> > +	 */
> > +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> > +		ret = -EINVAL;
> > +		goto err_free_doorbell;
> > +	}
> > +
> >   	for (req = 0; req < ntb->db_count; req++) {
> > +		/* Avoid requesting duplicate handlers */
> > +		if (epf_ntb_db_irq_is_duplicated(epf, req))
> > +			continue;
> > +
> >   		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> > -				  0, "pci_epf_vntb_db", ntb);
> > +		
> 
> 
> Thanks,
> Alok
