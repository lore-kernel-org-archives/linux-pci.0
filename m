Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759C225390;
	Wed, 28 Jan 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618376; cv=fail; b=lJKlhEhAYUiaextX+Nk4ecgOOMBt5hi9rynmf0IwvLfTy1+plJedOw4BzOpuSYkjW/eGxGIQQifawYFy7hlM/hebBMMWHkhb3Qnw3yEo6xS3f02Tld6Y0K1o7pvZgyUkwAVQhCj74Wcpy4Nwq1PV5+w/ryZTrZV/zf9yM2fkDP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618376; c=relaxed/simple;
	bh=spvmgU6Ln2PefGyha/VKYbO8W0XdMTWUb1QAYBEJHu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fKZFB8Ebl616IUkjR53qutmkTuCVaxuJuxIy1fnk8oUYDOq0QZCcqfz8mjSObAbmE+7beVR9nUTa3yWntaqHQYClztO4csBt9tl315XcUPQPssIXZwrYTz2/ygi43j9ZLTblNXMXgTIh29lgLmPgPq3OFDgyUOIhgD3+2MkcgCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lowitXtX; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lowitXtX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFeHpOAiB03x5BKosffWvR03+1Hz2L8Zo/dz/wosMZc/JE4Ng3K3ygaWnSHhN83ussskMx1+dEbByki70JCWF0UFxxk9PEVr7bNaej+enNH82/EiJcXM72qkfBFP8d3kF8J+cggvrIKuVVle24czNVQzhxAk7Ai1VicNCS6spYW9Y8iADvC7T66j/A7VBp+YaO+x5h7+dGKwQ5Wa9YlVNjGSdl/Hvj251vnG6XDDx1qoOR/zSuPXJKM5YWR/ZtTHU5574jjNNNsx9har3IO7xM4vFU01CqhzLaywwruS8rIrsd3OTmaBdxAwni26YHixkK9kZn0ltVVkkK3qxlfTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAx2sVcim9hzyuR0VSDkwPbeo6+7nqVgiLmj82nMljw=;
 b=Iptr6UeZSmxoFT8nAQdt/Hs4v25P9RiUHJpXeSL1PnLTVUW9Llpt5PAGr5aT8RcJGa4R5V6UOE86co7flufMLTuhOUycw/0vV1MzLBb50ciULGSlmkn/LWcYOSWJXYa37zBUhNftwkpO9tc+527DGL2uMW9zZt2NxoaV3897/V8FrdEjY6VYM6RXBLNHAKN4XaBhAr/VV+nPt9kJqH/Lfb9YYpZGfMn9pWKnhyL38pfCeEEzJt3Agv3TXl4yh4uKY49fDL9/8ibBvDzsXm0Jw+/9KdAWvTBDtQwwiZNJqsKCSvD7vZ6CEac/OWQsnWrW/4czR/2wrdNgmNAwrcWBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAx2sVcim9hzyuR0VSDkwPbeo6+7nqVgiLmj82nMljw=;
 b=lowitXtXBVoWqoSfnzoURMUQBm2xBqtoya2TfhbibCBqu2za5sZeHaQqdW0aQTA1S5ykQe70AruolVoDCSLOSO2420fnH6yc8Mx7okhP+AmvkI27kOhBCgk9ulZA834d5GPutUpvlCfc2UkpRP2MkHKwIOSATeQXX1TZVPLRLBWOcTkNsZpf7X8ZC2z3a34pPUJEBZaQX91KxJ2bi1pwvJvKGt9PmnExpTTw7EK/ryU/QvBFcJvLN+p1yk26B/tM0fZq5AwqYoU2LGg8L+SlWS5FnKumTeK51tZGnZSnQ8jL9joB5u4FjK2FIvsgH6XR4xQr6bhkgt//2o7mA0+96Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:39:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 16:39:28 +0000
Date: Wed, 28 Jan 2026 12:39:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com, zhiwang@kernel.org,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128163927.GD1134360@nvidia.com>
References: <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
 <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
 <20260128155646.GB1134360@nvidia.com>
 <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
X-ClientProxiedBy: BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: b81331cb-8e1c-4ca6-e2a3-08de5e8bce1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o61WMowYf53ZVBdUVHjNatXJKTurcrWJDqZKoYddYakbVoVx2gQ9RxL5gTy+?=
 =?us-ascii?Q?YVM+KRrOG2BwUI4td52hIKALWdt6OVuc5pHAp2H/fsnDy1+5Hf9T0RvxfiHm?=
 =?us-ascii?Q?RyBwYj7lgsi3EcXA7OLNN2PodVv7lPbwK3AoHt2KEa9EGSxOONOc8fHLw07f?=
 =?us-ascii?Q?S3VJc8MunfF7Amk573n1MJ+GeVAjqwCVRmT5fLzwIjxmDSxw70GTAMMZAANA?=
 =?us-ascii?Q?31PX7QMaPrTSsV0U8BZ4U5sLVuWIpJVT71o6Cw3pv4dU+fogIFygb7ZNoeKv?=
 =?us-ascii?Q?853G68FqhPtMQQliLu0dcHHWQCl4M8/ZkihF4HNAEXYVydzy57hcqOa7YGLI?=
 =?us-ascii?Q?GMjQ28kP6BiksR4/O8kj172gk4R092QwankyL59UM3Q4OcZIS38cmnNIp6t7?=
 =?us-ascii?Q?XxzMtyfX/tTdzrnxaPMSKmT0+JfPkPXyePFiEIaGJY+0dhPC1KN6EE4worzD?=
 =?us-ascii?Q?NRUH38C7icwltExKJVCnuUmgEsYJzYQDIM6PFqcjkJw7dWlNUUSSZNElPPYO?=
 =?us-ascii?Q?6QtmzhE8flOeDXZxZrA2AfgKtuBSGdfIZ2zNsT8aSZfI2kWKlAe0N+Pw+pF1?=
 =?us-ascii?Q?XhqvBfZo+Nx1OlptSn19kq3SbpDyiL9APhAItZLIn9qYU/zWt/RneS8A6uMv?=
 =?us-ascii?Q?YMtDywfggJ1JsJBUBPO7ELdtINSqrhnm9YU6ld147i+3wpL4ojyNntel+jLd?=
 =?us-ascii?Q?GA+ZEj7ASGHtvfibKCoWJ9UZchHgdkM4yx8BfaBmNz7BCgV6wGhK4ny2h+AK?=
 =?us-ascii?Q?EaoKHkdLve/O5+dyVm7w7aX9eeuKynLBJgAhDbE6Mp/c2l8Ow0fllajCKdB4?=
 =?us-ascii?Q?XkvIJyKC8VDiPrCKiRLcQ+rLRJvAi0TmYLs2jPs2smpt4NNChznOJzMp2o4h?=
 =?us-ascii?Q?gS3NzBhLhv9UCPKvTes2MYUQVdfu+L3JwAja1BgClRb3qNIN7WpSiFEC761q?=
 =?us-ascii?Q?2ERlRQl2tdOB9I7g85+mgI95vzIVCebIapMOtcVfa2n5zhrm9Pc0cKv/gKiG?=
 =?us-ascii?Q?d5k2mqyyaV6pv3y5lwAhTMxvdwG3LnSwbapk9Nx5nK8q4DKdC0qtFb9ntNgG?=
 =?us-ascii?Q?OJbajMfHKgPCrdG2JiQWZkt00QNzw4JtnZp7oQMPnu+3vVIy+noB8c2kHLSE?=
 =?us-ascii?Q?prp3z9ilA7KFEBr1JuOL0WY/mlnUz/JKyFYnpJI9FTx4ZfbUwsyq8cPB2w4R?=
 =?us-ascii?Q?g4GF55wxSyLVRObyIlSFdvGOEhZOLBP4obl0qLHxmwfbrF45mdMWOISsIXE5?=
 =?us-ascii?Q?bWlv+77lsLXozyJxJTI4eNjrzIBpBVg9VIr8JlnPjmoAN/ilfqzQgoAdDI0V?=
 =?us-ascii?Q?6XKlFYMuu4FPqzgqqcu802FClkwRE9Fnc77NXfAM4zLwbS//qv9pBheWvDk8?=
 =?us-ascii?Q?ICi3Fe7ZA7IJmug0XpFw7En96Q1xF9TDfGeRf4Z0IH/Q9RFY/I3qEEBTIOq+?=
 =?us-ascii?Q?b2TAAwEFWPj5/YIOdw8aMPI4Z0TE69aQiOrPHJry42PuBpCtuECAAsShaOv2?=
 =?us-ascii?Q?Wtc5vhuX1DgmEdgxr/5Ud0g9BJmkxvkN8T8TmwFWf55bof9hCxw8htZulKtM?=
 =?us-ascii?Q?KVPl11C16JIqs6Re88o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vNtBpOEYJSrGkEPlbwWANMrDQwB0iKcgO3fizayQXxDUXElvNRgURHEgw9uF?=
 =?us-ascii?Q?ndzwikrSmPyq24wdDXgTIsRou3C5jrxfskd1nUsmExtFdyck+m3aTWE432cG?=
 =?us-ascii?Q?azJkuyZymktDQH21k+IidQJJ8IzpmagMb8ldeQijClefkm/ij1bqO6LN7GUi?=
 =?us-ascii?Q?74fiKlzBZuTWZIa/WYNog4Xf/EKVoGPGUl4fAJ9hGc5l8OT7EHm7GkgKOFhr?=
 =?us-ascii?Q?NLg3UwIs9Cl6FAvxR8EGE86TcZhq9Higk3D8Kcpcn0gKCn3CmGCr3wYd/WZs?=
 =?us-ascii?Q?ODUfYWjDPTYALwxySoIoRkKygCdIstv+1bLbS/Q5Qe3jCmWQrb/Uy2WTNvpG?=
 =?us-ascii?Q?Vgu9DYHHyRIZ07RzbiI5ZIsYQTEzZujsdf4qkTdu3NLWet1PfgVR55NUc3aE?=
 =?us-ascii?Q?gQwI0mZQr/8ddx1INx3aYLE4MOG6RTkqSUxNQEPqcy1QWOO8b66i36Aj4gp4?=
 =?us-ascii?Q?qyEVdCzchfkvC3BR+clteU+7Kprv9DlNMcnTQ5ExiqZ0L5JRzr4v/1kTa9Sg?=
 =?us-ascii?Q?BQyERvozxCg/+BqGMmadN8JXSM4LfU4b0oelEMRCR/zezOYzOKzyKkYwRl+S?=
 =?us-ascii?Q?1C5uwVv2o0jYrg4sprSl5und66R3VmqcmWJMHiTVZco+YBoRQ3NOWNDuITnt?=
 =?us-ascii?Q?85MzOul+6VR+iB7K9dPDunQdR3VWDiKjfUzsLc1Zev5WFIVCZopvxMGDdBMA?=
 =?us-ascii?Q?Dj4O2jWXOL8IzNPhSCnOMQ8s0aeIzLr6qYbfnl+Q+AOx4h54sIHIW1+6/woz?=
 =?us-ascii?Q?vbvHECQQ0YXX2HNa4crHK8vXQiVL56y5T6Y7wQedYYmTXRrcUsCJaeKyS4Eb?=
 =?us-ascii?Q?hsvEL65jXppiR17SqLGQ6OLDdalD6xPSEAr9YZ9u1HjKUd1cEqZzzHzNeDTk?=
 =?us-ascii?Q?ayATHVm3KA2NxfIeuj1BAa7Ln8y68ispjHEzAJC2FvhTwvar4beJqx1hwFWf?=
 =?us-ascii?Q?+jgEqyyPRk6SsdrZTp1Hc3WAws3U+Vy3sRR5ZHa7yrPHnqS7s6uchCn8Q6Eg?=
 =?us-ascii?Q?oL/KxbnAnVH+HVSnIcqrcR8pVaxfmmO1YeSP94kPRkYLByLH6v3DPBT+4prE?=
 =?us-ascii?Q?s8JafRXGlEvZyQ7rR2t9VfzW4Va2d+qQyQ9KuwmIbuNC6zX2X8AMce/2+QZL?=
 =?us-ascii?Q?tRkZYzr+6BLFmNCLr+ErwQTPdweVlCCTg7EF22Ntl4aoP41/kEcfX40C9Gmy?=
 =?us-ascii?Q?H3uHifLxO7/lmcmWvYQl6durcz1kd7Ydd9CPSb2iB3z9y8jVOp+HTJsB+6Ef?=
 =?us-ascii?Q?4epzopGDUHMpucQoB5rZqjIdw+/nvURTQItqnuv/IEdyfX/pCErSCiQbxG3T?=
 =?us-ascii?Q?rIyzPvM4VsCfn0tW6H2jY6LmZ90K9QePvPYFLwkS9shTVtBol94UTYatSaeY?=
 =?us-ascii?Q?F/ffUKKfeZNMzmTPPfziX5yRyyMil3pRRKC4Thr6pR3iI2oYJF2fBpSuafdN?=
 =?us-ascii?Q?vcQZ2mkn+156+RzLQGYf/xPU6T1yze6ko7PCogUltgYge2tT/g5GN/UZrc7X?=
 =?us-ascii?Q?2HhFfVT+Pem6WVMwIYLoqwR3WlQG6V/gN4p9GLStLwyJATAQ0j7dGp9h9cmU?=
 =?us-ascii?Q?uDM8anvpF0JGuarabGAR9fQjbr2hNa9T7/m0Tc9BrnLaICbVQwUsCy+4EeOl?=
 =?us-ascii?Q?kcc4EBZvCVqPvu8cuC4Il4e6I24qlb40M9RmnlXDvjazfSId71GYndOmcMiT?=
 =?us-ascii?Q?CoVdyGo8ER3p9m94+ZGoc4fUYWAimGwmzen1MBrR74xHI0d7pnPrsafqPftw?=
 =?us-ascii?Q?72tJml4rAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81331cb-8e1c-4ca6-e2a3-08de5e8bce1e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:39:28.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ArsyeaADM0qVPD5P6tgWjR/ljUEPXjTxoEJYW9eofAdCh1tiL1RN1dueejDVFku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583

On Wed, Jan 28, 2026 at 05:35:04PM +0100, Danilo Krummrich wrote:
> On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
> > On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:
> >
> >> 	        // Initialize the `data` initializer within the memory pointed
> >> 	        // to by `raw_data`.
> >> 	        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
> >
> >> So, essentially the driver passes an initializer of its private data and we
> >> "write" this initializer into the extra memory allocated with
> >> _fwctl_alloc_device().
> >
> > This all seems like the right way to do it!
> >
> > My only remark it that it still doesn't give an opportunity to call a
> > function between init and register.
> 
> You would, from a driver side it would look like this:
> 
> 	#[pin_data]
> 	struct MyDriver {
> 	    #[pin]
> 	    _reg: Devres<fwctl::Registration>,
> 	    fwctl: ARef<fwctl::Device>,
> 	}
> 
> 	#[pin_data]
> 	struct FwctlData {
> 	    #[pin]
> 	    foo: Mutex<Foo>,
> 	    ...,
> 	}
> 
> 	impl pci::Driver for MyDriver {
> 	    fn probe(
> 	        pdev: &pci::Device<Core>,
> 	        _info: &Self::IdInfo,
> 	    ) -> impl PinInit<Self, Error> {
> 	        let fwctl = fwctl::Device::new(
> 	            pdev.as_ref(),
> 	            try_pin_init!(FwctlData {
> 	                foo <- mutex_new!(Foo::new()),
> 	                ...,
> 	            }),
> 	        )?;
> 
> 	        // Let's do something with the `fwctl::Device` before we
> 	        // register it.
> 	        fwctl.do_stuff();
> 
> 	        try_pin_init!(Self {
> 	            // We could omit this and instead provide
> 	            // `fwctl::Registration::register()`, which does only return
> 	            // a `Result` and keeps the `fwct::Device` registered until
> 	            // driver unbind.
> 	            _reg <- fwctl::Registration::new(pdev.as_ref(), fwctl);
> 	            fwctl,
> 	        })
> 	    }
> 	}

Okay it is fine by me, Zi did you get all this?

Jason
