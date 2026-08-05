Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1021A459;
	Wed,  5 Aug 2026 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890366; cv=fail; b=ThUg2+hvlirDf3WC3JsaUQHmyMfpFX7qpDzh8VOtO5k0bMkIvb3DjY5p9SZzhxsrxCZhLWX7O49+5az0sugHCkWxJKTJgGxMdHbPBNoMV8wQgRyyLLFbOZyfqffPZ/toZcZsfc73aF4fe2KRDYmjmL5dMv/3XUVTZ3DqYUoHFBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890366; c=relaxed/simple;
	bh=pwesibZs5BCFB1UoLqWnhOxSwoFkizvY060Tuaix6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFEOrNjWBZKfF1CfuIKy4wJuu4P4I6L9v6i2ZiCSg6ylGTx/uGIxaLIM/ossgt9SZ6VLKzkqbgioX5FPkZwOyOpfgrIhr6dhzBv1m6tFlqc3WJhNydZBorEWJEyDc0o0zpBFz6ef2DJGiTk3euk2mDQ8jTzxv6b18F1xsS6fRrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SB0CmsLe; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SB0CmsLe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQz1BWv5Emonh8sItH+8kzU+4Cv6NtSs0wm/QuohxcyBeAPWubkJ/hozo4a+LNKdZI8SdlWoRDyl4zKzWgDa7oOpX1bQqdARcmNHWtuokhxMhOfJjwoDUfYUj6ajzrDFSsDmyj3Bc0oqJ7EmlTfeAVn4zjyPnrzM1BlaEJOicuh2FhEQEW0ViuJQDoDinN8jDWO2eYB/ts+njsliLUupkvhncPcB9VfT7+RMRnKsC56UcfZ8EL1b1lgV2609vQTFY/hJmR0x951k+WSgsZsVmsPLzrxtozOvP88H1B4qTwRjX+hiCudJOIecePJgZvhGIDVCq5dZa3Pzn6/I5p4AVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwesibZs5BCFB1UoLqWnhOxSwoFkizvY060Tuaix6xc=;
 b=Pz8tYJiO6sh/9M4/RwmHtG66hjvIU4wR9oFeaCznJeu3Gh+a1AZFdhbJMzlKgd0jvMrXKUnpi+tPl0PbhusYgxRxTluHn8bBNX6W8k6B2A7U43iRRfRT6rv3tQgcek8CapfsLX7mMLIh43s4H5V41gpRK+JbVKVH3AdIaUQ4tqyweJbpf1FjdAIx65MS8qF7IRoHgiWgcMMAMq6FbiXhf5LTUQOfuAXq6Tzze2Vp55MHyfdGZogAKlp9OR4dA482EYBICosLsVO+jAZmz1a3IxBUWSsqIgm/bXnzr8tOps0WSGehpGGU3G6wHE/kM/hQ++FD/o7W0fym90h0Gh28Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwesibZs5BCFB1UoLqWnhOxSwoFkizvY060Tuaix6xc=;
 b=SB0CmsLek0jpfWXveDR2siIULm8H7y9D5km5CH3rjnPvsRe7CU4WSoiZ+4Tq2MZdyGBKkvDe4N/im9A8ZdeAPlWQTTnNtnySU+q2ExfkUtBSJ4/w/P1alx5+4o79aeqLCSOCT1+pfUCtAT7qHhcXLP38ZrzwnN4bK7jhhLEYINskhBMtbvYyuDRNENtR7g5esCynUCYlK8W7X8JivRnbVWUGApuTusGsOGiBTYvoQHlNsD/v8aD15lzVQU+wR+5/sIvg1uWLIOD3ysgiReQ6Zyo/7UrbvH3Hsl4lmkJqoxjXvozXoourm8LZFteu/CatL4s+amxS1zF+xFSGqHjx4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:39:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 00:39:15 +0000
Date: Tue, 4 Aug 2026 21:39:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20260805003914.GK27883@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
 <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
X-ClientProxiedBy: IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a374de5-94e3-40ff-1810-08def289fa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	D/e46M3kphgrigHDUTOCf+p3U0VEBRHdUAe4hYZtijx0a18tF3FZtJMvNPRBYT2YniBlPdwodLC7R9FVOSi6kKSQgNv6yjVQ9n8Sh/CeV9Zk7mowaI1b7FJgKcfvSxAXm+ZIlhPHlK2CRF+fcL4kFVr6nOqWZsDtT9Iabe38ApllplqcAf2kLwneM5WLR7OtEa0YmqdNa+4x9jtTbsIszG3BfAN/clxpIFIvAy1eMsrZjyoog3wDmY+vYNjgntbXhbM1qZDCV3UGky3hZu3iYKlXH26BiErsIQ7BihjowWvX0aUENfq2/ZRgA13Kzc2gQN+nqvWWES74k4dCyaqKOAdG1NypBZS2/8mCtktmrZgfFAN0SJg7ARLxqw5WlqQ0/2t4cPGaxp+rSjjY7QztFNvIAjDt7bImfUi37g0+Cn7twBZ4IJSLI0yEPkLhiHfPhcT94SJxNjxvu/cbSIyGQLCfV2CJRSmOmphbGi4H59BlOYx2FiGY1gQqlFweNyMV+Bn62iu3mzl0w9cXWinug8A96mT5eNR1Ffirc69b+R6hRW6msnll2XOvjk5X9cHg3ND++mp2gX06epFGMbEZf+ttxjPa2laR6vNXuamPtU9fbwaDT6X9/ppDTrbIsB8jMC/6zHi4bQG6pG/UQw7EnDnDuomHEp8vixD1catcn6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GC1UTCpcicUGWQqCWuBUnSesh/2mLeZJlxyi+pYpQ1isIQqjE3ANAWx8R2EF?=
 =?us-ascii?Q?KZ+x37xN7ekwHqHLceEYYe0c/cP4cdNH+7L61nZVIwfMosZrIiDF9z9WKfFR?=
 =?us-ascii?Q?cHnPxNj4jyQAwvIn8zCTE1bwEfR/IB+2lHAOB7pW5y7ZcjRPkZIV7GufIvkE?=
 =?us-ascii?Q?XQZxr1qHMvMiV+MgVT02HQe1fV5K/dic6otaJBnsmEWFXDSfiD/wxY4E0Qok?=
 =?us-ascii?Q?ypeOSY2vOh+faubavn/z27d1d63cJSMuHjLDszV6ZZwknNyXbxVB/nOx7Ihs?=
 =?us-ascii?Q?1t7M7k4udFapjzAW2PKd/FBvljJ5eQznI02jftybdSz1kFC/kFLUQBJQOr3j?=
 =?us-ascii?Q?gyB2mg8HZ4+MQlBm9HV/Rdjl/XKX6D2knHvn8j5WAgnsZmw3TQZs+e7YgY0a?=
 =?us-ascii?Q?Izboo+POpfRBAYPUDbUAbXAEdjPAvFmqYY2VmOWFQdwQmXdXmStLKeMH3bDV?=
 =?us-ascii?Q?WLAbURVCjKoNgsoA4DoKeabAB25WvhqALCdEUjiJQROVtLj4095O1GoEvmdm?=
 =?us-ascii?Q?JeMqrTwQhgXD3wJyfP7f6y1kKZBs24+dkF7HZyeBrQgn2uZfax763odpT9AS?=
 =?us-ascii?Q?rb6x50xQDLf5Ef4hk05dycQ0kU3rW6S9AApkrJ5QJ+MisHoj1qJ3kPWmPCUQ?=
 =?us-ascii?Q?K0Dz7VrkiiDytDGeAxj6wTgPQSIie6Gvm30RLut51VB92cQ2/Rt7lcamr3Sx?=
 =?us-ascii?Q?y2OgDrW/qImSYvP5n962tS+OPe7WxejN3YzLsA9f+oHU7+uMsobI60Ijovxe?=
 =?us-ascii?Q?FwrJd4HGKWrLdkQPm/P6LXSlQCA40HR8CwZsaoWsmlcpUPaMIWC3Sm6NAVMM?=
 =?us-ascii?Q?my4/2085GOcqoEQtA39qkYkUMgRpa/qRgg863tw9xAeU31sxdVzKPm4okaxh?=
 =?us-ascii?Q?bagy27q9aWqai+BUtNp+c/qQWXwrO4BCtMWr4wRFjy8HHNLNRoNEpjfaJIrX?=
 =?us-ascii?Q?dTs2PUS+FuA08+BRGimZv7bNWoAR210daaHRiaZSvqYamhOcQG50edrai50D?=
 =?us-ascii?Q?WfGh30WzcO+TMI0GczndCHNM6o8GaKsj4pyVt8Rh7HgUQKDjV8SxfhpIXduk?=
 =?us-ascii?Q?urngMO094OpGyPTG7dXsgnprFx7rtjGjTYkHCq5XpMjh5RoLw+7JRtbQ/zTH?=
 =?us-ascii?Q?QWLU35vl2GSSn0RAr6/B5ZM3WQY7r9pfEtg1HuZdREbcQvzjcC7cttDrwOFk?=
 =?us-ascii?Q?u0Oo7eodxfZN/Qd2hEb+nnDM/aLNZl4jp2IZPsdKYigfzsJbwtLZ2ZjbKq9A?=
 =?us-ascii?Q?OnhH86VtfyNWYzRf6Kh/vmG4oZKj4+pzeteesd7Q6HXHLJ4zgbj1qAfOEDKl?=
 =?us-ascii?Q?orOF623+m5/AB6TIY8StMVBfcsYKkcXbuv/WDhyyvg2EwWlr5lvQXeZNz/es?=
 =?us-ascii?Q?4kvLqdlweyWHMedR2aBenpwKvfEYvgNY1YHTeDZUo94ATogHE1sg7aAdQLTe?=
 =?us-ascii?Q?hhzRtZbNSMknTkrosdoUMr9/dBTtJLTRRlO5ZPN4bn1Y7shxkQHR5CcrG8hB?=
 =?us-ascii?Q?Hs4ed71Pbp+9VKq4mM8AQ2ZU4nxf2NU1LcGp/bcxH7q7gc79KkjXP2dtPXJq?=
 =?us-ascii?Q?l5BLg9n129BDyBu6cJCzaTmS+45LJ12xjAPGniwni3X/Fp5AlEV7rVUJOGKM?=
 =?us-ascii?Q?R4seZ/zXpyBFfqVerhj/zRmEUm1NdPnRg6S0xhUHsEXBEF5FLe8yVHe1a6Yj?=
 =?us-ascii?Q?Pdai+aVPuSP7KrkBLlzbhQ/VS7ljyJoLYdGKNFXGccciRBQI37VKE2THD9yq?=
 =?us-ascii?Q?iK7/qfjZww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a374de5-94e3-40ff-1810-08def289fa3d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:39:15.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFPrAOoOMOOoDhXzaeLWwGQKm0rA5azN+2YEmx3IQCiW1KYcf9YF5WvGAL7CKtqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

On Tue, Aug 04, 2026 at 10:19:11AM -0600, Logan Gunthorpe wrote:

> There's a vague convention for this already: the term 'p2pmem' is often
> used for cases where the driver uses the allocator, etc. (I think I had
> this intention when I wrote the code and have since forgotten about
> it).

I've been calling it the genalloc layer and the core layer. p2pmem
would be OK to refer to the genalloc stuff. So if you want to have
CONFIG_PCI_P2PDMA and CONFIG_PCI_P2PMEM that seem sOk

> code into it's own file, potentially renaming some functions. Then, in
> the end, we would probably have a pcim_p2pdma_supported() function and a
> pcim_p2pmem_supported() function, the latter being used by existing use
> cases.

Not quite sure why we need this?

Matt, the mlx5 stuff is the same as VFIO, it just uses the "core"
layer and does not use the genalloc. So there shouldn't be an issue
here, if the genalloc is off then the mlx5 stuff should still
work. There shouldn't be a case where CONFIG_PCI_P2PDMA=y and mlx5 is
broken?

Did some of APIs get mixed into the genalloc family that should not
have?

Jason
