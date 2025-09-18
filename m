Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27095246BB7
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197080; cv=fail; b=L1RrrxC00zoyRa+suNqmnZYT+emq2b6SwOM/VwQMJVXgYeZ9Sh6DuPc4FsYxSsE53ckxWHHzhimaQXxN1KPkIRJiCQv7FRNNBqjT8aRvvib1LU0D76qgCvcWjSMshLsiB12V5DUgREwi688+ES1ASlm2im1PFKbjPQc6YSrmKNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197080; c=relaxed/simple;
	bh=csZjE9XYS2bgHrBEcW1wSERWL/Ng+4GBzIk5ZrdWh50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AV6f3ZtcF2bu9Dzt5lYChibrpyw5FoEXYZX/oIYdXdabHe3tycXGMwlUxqWrZA2SdbPnis5jqpBsazNxYzoXxzV+Wli6mYytT5eV1GFWBFjB5HGnAzlfm25uT5lBPuV/S8mDQ0QSvb5+XRfIWjpn9oPnY+TcyQlA89mYt02264U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXCjg9eO; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXCjg9eO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmq3OX6fJsIOAWWt5K7mS/EVYbQ6MIWppWJcNs7gr6izZDZwR+/SiHTJpaS5awud650ALlmFYcdisbB5JGwX3UsfcMwj3yQNN+tcbm2JNaB9Cb90zw9yFFsVIAWSJk+ejEDJHuhldP94wGO3QRqCCW4g2nQYV1hSgaNTBHyvfS1OSqQfBIFw30Qmqdehb4VMA39ZUtgFixyffygl74MEI2KMDHZjYvaFApD/N3C+Orn0hEIucIav80gpiY/vczGVFS0n9j1ruV1kMMBdcyHRrxbre5A+OyxCx+znfA2vZzOmq7sXCeboRorOojU3SUZxzWiqppCI8pFNmSGAtudqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csZjE9XYS2bgHrBEcW1wSERWL/Ng+4GBzIk5ZrdWh50=;
 b=Msr3PnNuVtmjti38JgZUgIyWdLQHZkViSIatEUY6jF0PvR/oviaxquym2bFm8znn5pL4iAeRAJOLU0KFl/sUj3oBdGYbpwv7igTGHQtduO96bWmzk3Bkxx6oml/YmbHrBbSh+A986BHIA+oQZ/xzKTr92J45xtmKLBwYLe7RGR3bkZeLWL0GuTpnMYmLKTL0mdAgzQ/FkxOGn1iYVFk9Zf4zLEih5poDk4QVIBshVoQadLuGjyzduAbCvH0mpwCKijYqor2ALtv9oXMlErF4KcVT40/7HMyJkzyaTdw7Adj/U5XX+4UW6yxwYeoeiOk7ak3fA/mSDAfSzwPBfBdwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csZjE9XYS2bgHrBEcW1wSERWL/Ng+4GBzIk5ZrdWh50=;
 b=oXCjg9eO3RyLLfm4Ijg8G4wUSeywgoxSC+0cMbJ/zK/g02n3+/v6PerSNoGSRTOfBKyOV8QHflo6wvuzDeT4yb2a4Y+VDVaWOCIHXs+jP5G70CibsWfCO77PNPxP6chhJ6g9lyZ2Uc68t8rqdNvnZQHGktzHt0iC2HmhjPxdQjRqfXdsA/dzVINtzJEueJTAPSWlAziIswJkFywqqI/+P4tN5+SHAIMFiYCAUqK2RRloz1ZooruwkYVoM/r8TJM2xTTCBTfkcUNpM6VKnpTfDQNl6YBVdjypBQ9ZQGqEOa9GCy+jdzraW85ulDx++cjLr+i/WqfeUDZGOE/T2nGcKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 12:04:34 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:04:34 +0000
Date: Thu, 18 Sep 2025 09:04:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
Message-ID: <20250918120431.GL1391379@nvidia.com>
References: <20250915072428.1712837-1-vivek.kasireddy@intel.com>
 <20250915072428.1712837-2-vivek.kasireddy@intel.com>
 <20250916175709.GA1324871@nvidia.com>
 <IA0PR11MB7185186F6AB160AA7F8F0FF3F816A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB7185186F6AB160AA7F8F0FF3F816A@IA0PR11MB7185.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 99382704-6800-408f-1475-08ddf6ab87c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73o6nhKG1SfQjv3SC6KH9ZsDINYXNbKv6EqFr2zcA33ax5+BUMUq5s5XSshr?=
 =?us-ascii?Q?UtWxMhySo+5v6/m6awj/4A6yYTLGIuGoR2XUHKE0F8yBh34ZkGhZuzlRV55U?=
 =?us-ascii?Q?GqVsn/T7Tp8LMmFJmjCN624RRUxSY116sXhgH9EW5EtpoIByw3dtALwMFjsG?=
 =?us-ascii?Q?zzVAv0/vVVN3DPMcxLKI4G2qaN/lLvMVb4j/uk2ivC6R78+tjnh7Eh8gEB3N?=
 =?us-ascii?Q?Gdhr+MBAeQCNR29Zp9p8tKLa9QLJHDLkbyZWZ+XklgGK6kc/GIgle14we6Ez?=
 =?us-ascii?Q?YKE4wCQZdxPrSac5mev7APvgoZo93h66EnpLPu2ENSJO4jLe+8u849faRB1w?=
 =?us-ascii?Q?oGJqtE3UPQe3ZBfjNgrksNXm+PO05DUWPXsd12D39gDF0D9keyqXn614GDrB?=
 =?us-ascii?Q?7ZEVhlRvQ7bc8Q0qIW0y6DGFTHOzFa+w2ZuSkkXe+tNUWSqNw15ozdk8smlc?=
 =?us-ascii?Q?gqmte3DquY/kHYiiKHxyBGbD0dMZ1lhQxrFQ+RaxktYFiji8ar8kFT4zXZOF?=
 =?us-ascii?Q?zlkT1ZS/jJomdBjEvuNeRMmUmpNcfDb7TE6P6TL8ejKhpSBNmZfeZA0Nud/l?=
 =?us-ascii?Q?lFMEYgK5Ve5bBd0jQBaWBgKdWCYABMmUqP77N6OMqnuRWwg1CzatxrB0hf5G?=
 =?us-ascii?Q?AMLKuGHVovJsmJoI6oLuIBawzaI+lkvtS4e1yYeZQ2QZxRBLX+T2RjILLRHq?=
 =?us-ascii?Q?Awilp6tJ4h+1wnLhl4Wd7rw/CFjXvskg15eUtz1ERWxZb8m5yanv9n0ydV56?=
 =?us-ascii?Q?BdMDnC9A88cEsfPuvn0wcHLOM1mR7/xgxqfbV2A3b1HiNOXVgdnJPa5WherS?=
 =?us-ascii?Q?wV0o1V2+UaV2z590fDKr9X5yExOltL5Lwo64lW1ijOZpn6UhPxXbSdY8R9Sa?=
 =?us-ascii?Q?WS2WEJ9WaUmdJtgv3jJjjna+DePV5iOgThQPdE6neB7q7GzNdwPwAHzVh05p?=
 =?us-ascii?Q?cUXqn/X9MDJDqD5Q+CiwiYFl6aKL9RNQZW3GdtE0cohrTtcds07Pg3ek9mGK?=
 =?us-ascii?Q?7p4x7G0qhgscRPgdzHqzYXFDRFnZ5IxvG/185AKL6HCnA+bBZcZuSdpGPR8y?=
 =?us-ascii?Q?ms78L4HHtjkFo85KtT5Ml3BfRTCnqWUlOsnCVr8WKdR+RrBJ7tOF8HqK4O3r?=
 =?us-ascii?Q?eRfvnogxkv9TYxsz7Qf5yzfLqB4x6In+KAqYnABFAF5Xkmczas1dTuMxK7Kr?=
 =?us-ascii?Q?NhzxE0it/oAxayteq83irCnnbcUCe1gz1ncL74BmBQlalHR49OsTRPVpCJHC?=
 =?us-ascii?Q?xWhLhjAeOfrRCZox48LClC/TwXIl8jCbkwVai4GS9g/EMMycecBLNEldnrBY?=
 =?us-ascii?Q?T+/cbTSKvyDi0hQFHBenGoLc5prwAanktbvws6m2/700q/9WoBAJqKIV69Kf?=
 =?us-ascii?Q?Hy9N+a1VMojS8MGom5QaWiigHiTgZdq5yA4bcvlUlitpB87ukVMJXeFdQ3Zm?=
 =?us-ascii?Q?fFDJH6b4xEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6YcfXtq8gV4ASazt2jDqRMrhTyWI58wzC0DYpZWJoeE2QvJxzZVeyP4FDcrO?=
 =?us-ascii?Q?phVIXdEfB0HlZVtn8kJHOZxf/qPI5fCowAm38Wl/NhkBJwFF97Z0RR6zOOZW?=
 =?us-ascii?Q?kJGrWZaBUsdwstaXBwUhY1bUbYPhpJ5OkGtlJvMAjuYoXPJ4f/17pCi/f6Rl?=
 =?us-ascii?Q?F4cvePo91jCPTftth4KexQbhTLqVoGiK3PlObcMsKNNqmujyuX6FtCHfykLC?=
 =?us-ascii?Q?meifrCKPAr97T/TmuJvbaIIXS2nnXglk5zLVFek5YaV1cxZjGsi2Aj+TauBA?=
 =?us-ascii?Q?vJDC0+um/gAe7qG4D6Ir4Ab1JcmaKcqQsREDIGpATJU8UHnrv7No/6EEvtWa?=
 =?us-ascii?Q?bCxR6syWDyalRLN4603vicREpxIWrlOXdbxIafRfbt9oFye41rlhHU3Yn1FU?=
 =?us-ascii?Q?fzPCq0cW4YnjZRxPpdes2kwfSyvWfZq2RHEGsvqLO30Ubf7dYEIDCC6QyLMD?=
 =?us-ascii?Q?ldq0ixtO4HtrW4vtd0VfGk6phth6UJ9e6y+Pu1U8thXPI3znNlRWae9GAQnH?=
 =?us-ascii?Q?egEEzd6pA//AKKVEQNgIueY6tB9sHbTpm15yLJ4AqBALwgSGoLoCMXka8k80?=
 =?us-ascii?Q?OKiTiLfGQ2nh1R9OjyPVK89Rk/kcxhYMXw5TpYzbTeAcvh4gLxX/YL/QXy82?=
 =?us-ascii?Q?UG0Z7WLyvxgE9odBkilnnKT2+fcd+5Y+tixl1gjxbgSdpO+OBvJf6zniTHcs?=
 =?us-ascii?Q?mqMxuEz9efGfxy7AMNQdKBPRBd9Cy9XXNEzU8XzgikjCLhe4m0W43YzSM+Zb?=
 =?us-ascii?Q?7Pw3kZWYrrly76EVteXSg3LYiilhtFvaEomjwzYkupPajm9KwWmmX/6iw5M1?=
 =?us-ascii?Q?eVL1NjhcAbNJXYCztM5kbxHwnkeqBRfet9Sj9T7Nb1P1pZEgfpp8IOop/SWb?=
 =?us-ascii?Q?ovyok7NjWnFwM/FRAUCRbyrMVRu/1ei7RQcVMGI/UJEXf+38gE15IvAYJtef?=
 =?us-ascii?Q?ZAGrMMFPDgIOwGC/JZ5ukxVlVYnuUTY9WgOEm4x/+x8hfzSppSBuyZEw/JDa?=
 =?us-ascii?Q?EZ0IHWhpW+yUw71wVFuNrkJXxCr076nAAYoKtt/6Yy+EYOHoxDTxE5FTYsyx?=
 =?us-ascii?Q?frECA3CHGT1jD3wU/1VpchCTqfWLItIKFcw55jSfWOqmVPX7TYZ885IYxApX?=
 =?us-ascii?Q?9i6Unu0+qPJ+O8UbppQklIC9T/OCDh1KItvVPBrmo6N7kKJWYb66qdyXZYYD?=
 =?us-ascii?Q?YsCZCChNzNNsbWfqUjPqmawrMqSi361pnKNSluTImFSY+owirFFKhwpEHHrK?=
 =?us-ascii?Q?3WspZIyLd77SFpqVi85LZxNRfGynSUwyo1MYTIuDtO9hmbkjoAELYFNIIp6R?=
 =?us-ascii?Q?3Zb+0frSmnT9hKX3R3jFZUMpZBPrIGBFyHiYLvGmVVXPS/lWcsj8sGTUHr/5?=
 =?us-ascii?Q?2eG310NDfFZH6TYdR9WdY4ziVU0C8112y7+xuCd3XD1tNSy3TMwAP7fEfWrx?=
 =?us-ascii?Q?sz9lli42uVexgH3cmQDYYN+cPhzvzQks00fbLnWYXf60ClpjYoZMVjiefNpZ?=
 =?us-ascii?Q?/WvFq4unkZT+iZWNBfzWLQDxefhsWlnIxi/0mBxkWPb6Dw8r3PW2IrKN1+S9?=
 =?us-ascii?Q?HnXTNJdfKuOHb8MqxrjFubnNAL0NGBbAoGzP9Q7j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99382704-6800-408f-1475-08ddf6ab87c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:04:33.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3ykBfesZseg6SBF+IYbLLJsT6oGA7zn4LSE7boDV14cJRO1h0A2AuYfu7N9Auki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624

On Thu, Sep 18, 2025 at 06:16:38AM +0000, Kasireddy, Vivek wrote:

> However, assuming that pci_p2pdma_map_type() did not fail, based on my
> experiments, the GPU PF is still unable to access the buffer located in VF's
> VRAM portion directly because it is represented using PCI BAR addresses.

In this case messing with ACS is completely wrong. If the intention is
to convay a some kind of "private" address representing the physical
VRAM then you need to use a DMABUF mechanism to do that, not deliver a
P2P address that the other side cannot access.

Christian told me dmabuf has such a private address mechanism, so
please figure out a way to use it..

> > Do not open code quirks like this in random places, if this device
> > supports some weird ACS behavior and does not include it in the ACS
> > Caps the right place is to supply an ACS quirk in quirks.c so all the
> > code knows about the device behavior, including the iommu grouping.
> Ok, I'll move it to quirks.c.

No, don't, it is completely wrong to mess with ACS flags for the
problem you are trying to solve.

> On my test system, it looks like the VFs and the PF are put into different
> iommu groups. I am checking with our hardware folks to understand how this
> is expected to work but does it mean that P2P between PF and VF is not
> supported in my case?

A special internal path through VRAM is outside the scope of iommu
grouping.

Jason
