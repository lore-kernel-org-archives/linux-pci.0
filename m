Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C6426693;
	Wed,  5 Aug 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948059; cv=fail; b=E3aDKY6aUU6yKqY0x1FVYvAx++X+TUzlLh77FResF83mnyOlk3bwV58iG3mC51dqBPO37I7dvpFS8BYp9LOKMGII1Vwi67xGWH0vScfDb6zFFl0HeuQi/Pna93JL0z4eJAIj/g9ywUchU++VzycrbJocm9i2H3kAI6DjkH/mnOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948059; c=relaxed/simple;
	bh=yno6riQOzKXAxfWy5Mkk6d5kfatkgxdhSN3uQIcbyew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2oRKc7E9ct/nLoZ9S1wUYmqJnnaUpVmS7PfGIa2AmNOb8UyzdxpdIACtI8fAueXZKlaG18dKp/MxVeCK/lmgzT4NIEVzMINWo2FhncsxFEgxUWw8AXKnbRsacY2y3SYXOIJRyxqe//Z+vVKl4xBvMPt4/xNj5KdytiMkunXTxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZUKmQDi; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZUKmQDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj/6qfJniBbTaLsoHHYEZRm5J+mDtnCP5QjJ2FqehPSXXDT1qlJbqLdUvubOtksD61ABS9XVE5YlAqYQXZW+lM/xax8KV9fBXblCpAOBymhbkQ5DqCtdlG9uEZ+wHKvpoat8dz9g2QNJEe73LqevcIbm4FfQsXc5j6rO/YW/eAh264FwehsHdQ49Sr/KONHJmcgv+7OLFT1HZLPqEthxWnr5qyJvM5QPtsHfKd6STq9kKtDpf9d39VIuo0l+enSAXBwiTa9RYV1C0ddnufAs5tW/gEciEcq/j2sosWRYSRR8t3jzcrkWenBbG6G1W9VaknBKYsPP4K7TA5vzJR4bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq+J8t70kKksA6vRPSIE54FYCctJeHZcYEmgML694s8=;
 b=U8nk7ZX415xY42FVI0RlC/ed78vpe9OBc74xVch0zDB3z4q8s8zNOMzTlQvZIhm+k3a3ktFykUiP52cWUt+c1t8NeyDSRTpl0buYPoSblo/LBCkexepcW4tqs4Czaf8+wOGvBGFJbrMOnAWj/9VMn9aX+XNRAI9dnKS74v7/Rgt5keX7R+d5+d1ha8vb4h2gMDrmiwm1YGvyMcELfmveh+a00Uz8HVfkrZc8szs1rwjM0uw0w+wXspQ62TkQbtouvXzr8bjjjvOlq7j5+AL4+iZKaNjB5tRwLBktqbq3Zcu9edVzzJP+UWrE2MfeSAYUSb64FFLFQT42W8WlV+gTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq+J8t70kKksA6vRPSIE54FYCctJeHZcYEmgML694s8=;
 b=CZUKmQDi7iImRkZLP5MRL0EVO5asID8/12QznlGveIW9rSjhH2SYRyn8jbC/W6KsHnIDCwAl4p2PHC5CguqkxZ8OvLFji/917kbfqoX5VDqYhEwyvAhujBOrXgGOffEQ4PJouEwjNNm3B2vq7NJsebg1JYG7IhmEch6iKumvzN3hETq1DAgAz75ZJnFacFQF9oKrxh2OyL9zjrioj32nUu2Af/A0ZCuchgZ11W1nhImcPcqB6Nmo2U8GNLCGRmgNHRKH6hYDQtZaeTpKXi4I6BmWKOoikbgszcwZM/rZKmlZZ+OGQFHKyoksVK98SVEdRVVf4eapPM+4mf50svELgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:40:54 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:40:54 +0000
Date: Wed, 5 Aug 2026 13:40:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <20260805164052.GQ27883@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
 <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
 <20260805003914.GK27883@nvidia.com>
 <554c73c8-bc17-4336-8e38-f4cfe8d8b3fe@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554c73c8-bc17-4336-8e38-f4cfe8d8b3fe@ozlabs.org>
X-ClientProxiedBy: BN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:408:ee::12) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac4e453-b920-48de-78bc-08def310512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LWpNQVDO4bPm3rTd6cuQSLwvwi+Xsm3EKEycMz2aGOMGBcXuLSyQCdKHwWYm0iv7LT4VonA9eDHImjRkIqKhB1vyLTlocVzudWYbVqkMhlWao7F/gKt2GtUqHerguYHC+NYZBQD0yhsbX6HeNacNK5hQpJF8901BN8vBPFP9tqiHCCyR8450U0PITJ1orhFrzlFFIvuQgjyVheKN1W9KHkfRSOSIZK5xC6giASGuPntShINj8NUhbThWorXGkBNS2a3Do03UTEyclIXveAb7mP3/y1y9lNnRC0zii+RewA0pNlzsYpcwVAutRovMUu/fZfWSet1m2geWRm5WTjFEpVYofccDecB+ich2QgA4TnD6oZOSiDF8VKNjehou6d1NNh7J+yJjVwYy+OGfXAgm+JSi7nIDgNUyKy5fZhy4jPb5sPFMjaLi1UaAhVGNVQbhyJEKsDuncfd0akXEbET+Ue8WBdma6vMl4eMAGLAqPubRXGAEsjnlV0yY6yN7A1Ug4FK+RrGneW+3SIwpK5qE0eN6i1F4YSRoQdH1wTzNBOsb9yZpEufn4yEkXEpuMEAgWZILLBxlZDIArQ98cabh9rqZtHtpPiV5yM55yIq1HS3TKruSxaWYxJ5LH6wR5sKmQkyduXqvyGGWgSj6xjdC29F6ZNU0aDGTAqsCkC28U4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6T6xkN5EHecFi1Wqf3sBKjMxD0TgN+yfUMgYLu1urU53Q83KprrfOYji6Qp?=
 =?us-ascii?Q?wSuSHuETVPazIbsAj55hwyhkKCxsDPZ0JFSHm47/zXUFQqTGsdBLJFq1IpMF?=
 =?us-ascii?Q?xvmI08VW48xVqRucEE1GaEHN8EppQQYjbWX9MctBP1wXLnVgiL4M7rdfZ6Ak?=
 =?us-ascii?Q?7kMp1SsypuZP1qSChxjrxmbRSSxid+I7x/S8oIWnLgBM04OgCp+4BFP8WW4Z?=
 =?us-ascii?Q?A9N1TIJxFA1dHT2rA8D4zQbysQecvjeNtqKdJUJQOeggpShXiIW/Uu8fCE5n?=
 =?us-ascii?Q?dLK7uEgkvhK5jZ7cXEUPrrjsFDkpUNVgYQnczNtdTdw40WvkFe4iJhF/4IAz?=
 =?us-ascii?Q?NxCAMsk8An71i/NywNWKfziqXaXBNYRUCGoO18ACPTZFnqYA1L2ymQJKeuv8?=
 =?us-ascii?Q?ov239JFetIoSLAwvbNiLxJYucLb3QbkR/iu9o9KEBauHw9xu9FPHseI0jNTW?=
 =?us-ascii?Q?XSFjN4rw1Vg/edJh98lB7ueXe+F28rrbldenFjLQ9JI1k7mevyYUCRTv7xp6?=
 =?us-ascii?Q?n4mXtZg7DvBRxttOQNsSKWRtsLx4+AfUlohs5AoM9VgHEyTXoQPKtAetQUX2?=
 =?us-ascii?Q?p8Awm07+x4aJelXOdbYeoJrk2xyi1PKfMBTp5qgQ3GWK8i6Hhsblzw9NPclr?=
 =?us-ascii?Q?bokrwEH7cCVulMVF3GGY9R/648zw6+BmlOoTEQG86mdXghE3c69/pwLZlEj6?=
 =?us-ascii?Q?VkCyjVqDUu6Fj+qJyGm3TURdzXMIBoOuEv31zg+tShQTs1UgIxzsh/snxtG2?=
 =?us-ascii?Q?EZsowRobn6mJSwZHQlgxsJe5d7Lq/U5nDXJneX1DNqp7jrGGNVELFsd66SKM?=
 =?us-ascii?Q?xDg+B/d46fkQsJquiNsszeOgnT/p33uHUNCbG4pK2pV/a78hbZ/OVzGrq1Yi?=
 =?us-ascii?Q?UgIFF4I8gPCr3eUm3Eu85O+oeTdizDRibBvOMpuVSVFh3haQSvfUxAapazpE?=
 =?us-ascii?Q?H0g24hJzNyFCfFSfHc4UVn6fGibM6mIffgFMbLuaJr8y9FANXJS56tmRH+H3?=
 =?us-ascii?Q?+ZOqf8rL7ZmShJuFGbBiCtsbBlFxkBRbeRkYSsLQ5roLoKRiHNK6S+TAiJsR?=
 =?us-ascii?Q?MqjncjeMMyvcVIvq+fFnZphL6sChCew4f8PjjZMRMJhQVvs+WHbfbyIqRYBK?=
 =?us-ascii?Q?+RY1u5tyyFVVu/UBTbiHfcTw2F3u6D/IWR+40RbtN0gml7vHvLIiRXjYQIwv?=
 =?us-ascii?Q?3HFxsd0OLVsKhq5SIVS99tdgCIngaz0Yzdlcwf5oq5h2yEsDwHiEexhbOgUi?=
 =?us-ascii?Q?P/Fb7+E/wos3TqKWmGDq36MOSZvj3LUBFifuTxM5cTF+fgDJOzbMjNVEEa1W?=
 =?us-ascii?Q?1cf2HfKRaxA2JOUqQqDH5rtoNKheY8n0AEWoYXNWA6DhttqwxCHfnRET37bO?=
 =?us-ascii?Q?ZrHVajm9LRx9s+3AuuM/zv8f4iNbpAC3dTfHDsgjgJCX5TpPf+GS0WXuWGLC?=
 =?us-ascii?Q?IAbyOFrNW8ehHhbSRPWr4xfP02bzqShZR6UmpZQTIuGIx1LJ0pLAb+/R/d8O?=
 =?us-ascii?Q?1w5YD8CQy1Nk0pUFRO1ABz2rIaVHSVAgk375jaa2hpjLuUB0abBG5vFzGHRH?=
 =?us-ascii?Q?wiBMzTA8aGD5y5DiJITeGWTOvgIMADqEi/zIjkT+sox05RPgFjUmBBFZsxNk?=
 =?us-ascii?Q?Vs+b/5nZ3xoRvWb0vZ5rp8EgbxuLpoU+gnGPtbyx8xEhV1sqzCl1gseogT4W?=
 =?us-ascii?Q?3XIt9o+kGV02orIOxPhw3xBiy93oCD0HBcusTMjO4ksFzy+BUVdnwqGGhRNf?=
 =?us-ascii?Q?Tkz23Z9Rcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac4e453-b920-48de-78bc-08def310512d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:40:54.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVKqpxSKCOXFDN+OEcNy+NrL7sAkO8rFhv3xK/YU1opJ5sIuBJ3ZQbI+74xcjXP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

On Wed, Aug 05, 2026 at 05:28:27PM +0100, Matt Evans wrote:
> Hi both (Logan thanks for your comments!),
> 
> On 05/08/2026 01:39, Jason Gunthorpe wrote:
> > On Tue, Aug 04, 2026 at 10:19:11AM -0600, Logan Gunthorpe wrote:
> > 
> >> There's a vague convention for this already: the term 'p2pmem' is often
> >> used for cases where the driver uses the allocator, etc. (I think I had
> >> this intention when I wrote the code and have since forgotten about
> >> it).
> > 
> > I've been calling it the genalloc layer and the core layer. p2pmem
> > would be OK to refer to the genalloc stuff. So if you want to have
> > CONFIG_PCI_P2PDMA and CONFIG_PCI_P2PMEM that seem sOk
> > 
> >> code into it's own file, potentially renaming some functions. Then, in
> >> the end, we would probably have a pcim_p2pdma_supported() function and a
> >> pcim_p2pmem_supported() function, the latter being used by existing use
> >> cases.
> > 
> > Not quite sure why we need this?
> 
> ( [1] )
> 
> > Matt, the mlx5 stuff is the same as VFIO, it just uses the "core"
> > layer and does not use the genalloc. So there shouldn't be an issue
> > here, if the genalloc is off then the mlx5 stuff should still
> > work. There shouldn't be a case where CONFIG_PCI_P2PDMA=y and mlx5 is
> > broken?
> 
> Oh, when CONFIG_PCI_P2PDMA=y it's all good.
> 
> The issue is when CONFIG_PCI_P2PDMA=n, as mlx5 still seems to permit a
> DMABUF export solely because pcim_p2pdma_provider() succeeds.  (This
> patch's CONFIG_PCI_P2PDMA_CORE enables that.)  mlx5 assumes that getting
> a provider means P2P DMA is also available.

That's my point, the mlx5 should work fine with CONFIG_PCI_P2PDMA_CORE
only or it is split wrong.

> Later, DMABUF attach would fail, but it'd be good to keep the original
> failure mode where UVERBS_METHOD_DMABUF_ALLOC fails early if no P2PDMA.

Why does it fail? It should not fail :)

> I was thinking something trivial like the following would let things
> like IB fail the DMABUF_ALLOC early still, instead of making the
> assupmtion that having a provider means having P2P DMA.  E.g. OK
> provider's available, but test for P2P DMA support too:
> 
>  bool pcim_p2pdma_supported(void)
>  {

it seems illogical, if you have a provider you have p2p dma, things
are split wrong if this is not true.

The split should be only around the genalloc and related
(sysfs,etc,etc) not anything mlx5 uses.

The only think that should stop working without genalloc (ie
CONFIG_PCI_P2PDMA=n) is nvme.

Jason
