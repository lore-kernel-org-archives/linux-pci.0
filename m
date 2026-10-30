Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793331924;
	b=pdaLTe5GCdOTJealFLG6jPW5zAwWgR5pwzw6+B0mL0EK5bSCwxSxUeaWOQ6SUO2C6pMI
	 CKPQtvUTwWBlodFee2gNaJ70D9JJ/KUuMafuHKVTfagSwMEbMakrscD8wDndmbvh7PzEW
	 xdZmP2G5MRSsZL/BFbvgoCMhN7bQnuFzk083pkdJOcp9eckUVI9dhm62VmGOQlUr4TRRR
	 /KpcR4fGZ70qxA7HGjjhJmSW3BQWgKBvQbA2u4XpqG6piwTlTx/7koJKTJgitoH0ZgaVv
	 QFFPBz8IC6aM7MUrkI4tnFqpymiPvjz7UnC0vI6vex4uI1q0wBEbGW4VLLW6fhbNIBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331924;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9iO97Oi7QWwwJoY7UsU0jpzfq7hMJk5B5JFmVeswpa4=;
	b=WumoEU7UoxJVBqfuzbUMK0uDYHH4TULaGnm/you7Kt37fNi2UfPu/5x6s7UcpH3huOzx
	 zrhmtCrV+UAyD0H3dNxANjTA4LgLDkgbVWilMhM0+enIhHf48/XiZ3LqSZyU1N9ttHLpg
	 lfXCijYSMDOcuxI3VkI+pKEKdFoVWKNBhsw6jlXlPcBBBKTUHhZJBZYBBZuxcQkeZY03e
	 DiU3Uy7GatsccOsPLts9aNytv+J7+TsCO5N5J9cRZnZzbTgHDsoadmtMMOeebxiG/SLqk
	 ird3+/8DLbO/0G9dpuybm+wwomZ+DDqRTgdjzW7mc4wQdNurjilhZcc1ET9di5hIj7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FBwvZrBj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.35
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37098606A31A;
	Fri, 30 Oct 2026 03:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37098606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FBwvZrBj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPbNC78ZjpvwS1hecVvGbpkj9ig6gSwy9iqnVjKpE2CF09if7PC2D55qx4hcNh5fMGu/HE3N7/RShHgaWdBLNyDD7YDOu35fW0iQfe2onT82Si21N/ajrF1OsDb/kTxCpB05NejtA3PqLjf5kYabYtaQ4rC2U6L/GjUEVXrRqnPKp5vVOsHGPGNlT0lihRW9V2NQ9RFSoYMtq5VybcyOL6mktkLBGgoIuJ8E8EFci+3gRJmBresQysSgYjFGY5J65LTEdjkkYMDzpjE1keXQJPJVCO42HsTLdmDtpzqgky10YGMFPGTPdXxHgudFO0+PkuB5sbUjvxaI/4cC3Vg30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iO97Oi7QWwwJoY7UsU0jpzfq7hMJk5B5JFmVeswpa4=;
 b=Fj+Lp6LHXImyA0ZDVaAv/rCf6fKQ3I7bFi8Xa0W+EDlCEpo5tULHSulBjHDdJzJ4aCwH1FssO5UPVOoOj9ZAYYl+GwzXkJFc8/PmPpzhsNKCHhHJbS6ix2aUhg4BxP69DpXoqXHK450iiwvXUuSjqsQTgNL1Gp9nQh+kAG5tnVClWo1ud3Fk5WhCJGCF6DxL+5QL6+ox8Btwj8jQvQH7YHROjBmCXE7rI99w+xDRkhxSwMbu2YAUS5ESHl3MqvwE6SGnKV15Iw7OoH2qInFaojue4k6voKubt5/qOPS9q4QMX1FQfcabINSgsJYB9LNUylaF817Hvyb7ji2wQTZfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iO97Oi7QWwwJoY7UsU0jpzfq7hMJk5B5JFmVeswpa4=;
 b=FBwvZrBjPDTJY4HplBoLF9iPogzpSz/ypLtlrPf1R3tcP+FDiU9PAbWoTJYmY5s8Fvrmuykcvt0Y+ostdUg+Y1XTNCOlZY2E507b58TZ1R5cGkabJ27cwG5LGIH0/a6ssRuMNliRljKjB/lTawHEmHAFPfKNoRJu009LK5ebdOs1gWNxOmjc0z/2aG1Z8UGS0cqEHR/6uBKr9kBBX2Pem3NJqv47jawG3PmVefMM67PeBA32JZcS04TVMYic0A4U4T3pEgV+Zogxk9ychoDbUVukMv9OyqON3I7ZsE0jMpluTZafqLKQD69uR4K1AWk6fz7eDIa6MVK84gP8HniUOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 03:45:15 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 03:45:15 +0000
Date: Fri, 30 Oct 2026 11:45:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 13/18] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <auQRSOGWEDzB_qjF@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-14-smadhavan@nvidia.com>
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db36299-7a27-4f6c-cdff-08df3638356a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004|261022105027099003|261022075727099003|10067099003|261022113327099003|261021123027099003|261021121427099003|4143699003|261009223027099003|261026121527099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	SQg1Q3rqwQ9781fP+97y8Jr9g4aC28LcRzBTU/Mr406uOKcMyjYQ7p4hhnx7t4g6rHlG07xnlBx2yTdTk2Uno4jB4FCUb84fzwYFCn+d7/5Ot0HbdvFio8r97AeOW9iAD4AcC0Si6cegj+Nimsk4nRx92azY6NdU9dstMvWRQU9Kib2XY0mCw7QF2lWlMM+K+8VTJDWd2bLzcFm+8w/OYDlsaTB+dMnw/q7o3k72S22CCKgpKuaJGDxdWBvIocZySkgearQievV27MAs5bwSTykeFT3dGNkzQzyQlSQAxQajQzqVxew+e/xwLMYHksq+RpyMVBelxQGs8OIRBkfY2KU304Ht374u73W9PVBkhPkJGAFymQTUIz8l/2XJmasA8VEI4EeWkF848dnAjqDRIa2V3FsV1scfb3RNlcq4mok7eYrxqu+IswRLK8u8yeCg3wjmcm7LGIRk8yWPsoG+SXVugQX/6KhMaWC9VCM5kEIFTsE02PNOwWSc+rTvVSv7AS/Jfd4hVugd0UJ/kHBywVMqbDm5TFCEiuvmgjYAj0cagFiGw5sBelOcueTdk3iKylWscQolQqXCuO6ABGDg4eCF2qw9mWVYQLVO63eKNT6yzUevKPFVdfuzlD4TDT95rYb/Nh/1Dy9Aa76FBHWv74cl5bNmtJ7e2Zu2/87a9Wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261022105027099003)(261022075727099003)(10067099003)(261022113327099003)(261021123027099003)(261021121427099003)(4143699003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6oD7kpmXokMLQeJ1o4FZWFc4y8MYr1qlzZzqp9So1x0xInVyHgMLXQTndmy3?=
 =?us-ascii?Q?CleJ3hIaqsP+RAfM7de+8EH9OKL/hxvGkaVJC9L0vBLVSrN2Tm9h9v9W1ePi?=
 =?us-ascii?Q?mv3jfoQIpGv6oA5yUTZZJUnqE8LyALrFhlSA7erJOSrzMkyTUB+OblQMv0e/?=
 =?us-ascii?Q?BCdUFRMYE4JPRoZzTGCEaIXtAzsPLuVZMfxFmnXNLOuCIsnZQlJBrbTb68+q?=
 =?us-ascii?Q?HwPYKX8yOdUn0rtq2pFIWZ1TF1rU1gRoqyRPnUPEthVKlmROM5Q0d6oCi5Vn?=
 =?us-ascii?Q?DCsc3xwxTZEUoe0dhfWjXC43vmXWy4BY05nbB/JRDrBDxrkZHhNqEGxdLKDB?=
 =?us-ascii?Q?CXGcgbW+v13i/1g1ZBG+VQdy8BH/02AxVu8Ah384BWXbJJ8pwEuCcKU0G5ho?=
 =?us-ascii?Q?V6j4AOEK2I/rqwgb+VRO0PTyA36kbHkZevG3gVEzhmthg4hTLG6AfqrJEQPJ?=
 =?us-ascii?Q?/P7cyM06aZHWxo09k4u/6XW18JsjeCmrHse7kNMEB6FOaEpmdHVbDQaR8kBZ?=
 =?us-ascii?Q?IbW5fywcVRjECk/Rqg71F7/352QebzuckrH594hUgBuTUj1xs9NG0VkUMKvL?=
 =?us-ascii?Q?BGsZdDeB102KV8Dey+eAJwPlpvvzEuKxpN3pBH0jEPqixi2cnLqyiy4LTLU1?=
 =?us-ascii?Q?M9Hway/EMrAVLaee3zrgAZQBKp29AwjMjaGzDIf4atLgeK5wT9Kv8CRpPlIc?=
 =?us-ascii?Q?Ka1GweCiPE3vscneglasjKFFaLPvu8UkULoegrxue8RaxdAt/atGVt8l/cGa?=
 =?us-ascii?Q?t6UTcv4OGecW4C+KAc7y5/R5glyYAL1FZNFJuZzPgI0HJQnqImCn3mQKFizc?=
 =?us-ascii?Q?0l3aqUG+3I/TtHbBIXH8uwCsklIfnEKanq8xzaN9pjtUTe9oiv5hSxOPxuVa?=
 =?us-ascii?Q?8+FP2fOCNuiVGzAvBqcBVzMoIhLS3ybIcg2bKUwkBHqeaNDVWWHVhbPzBL7s?=
 =?us-ascii?Q?95nyAizS7cI+OTpuOvS3NwwPe/0GwIFC5vkVhoB968BNhA1t/C2aEzf68DAF?=
 =?us-ascii?Q?iIW00R2tEOQazc/zW1Ncs3TsXqoBYazEucQPE4nN5uUakgoXnRKT6NE6IOs4?=
 =?us-ascii?Q?Z3i+TL9bBxhnjMyWp2QoYARgK/Hm1kPzaje8FCYz3ThfD2XecjLRo3iKqpRS?=
 =?us-ascii?Q?RljBXsivV3OWGCpNtuULlO/ZMSGbDCFE5JCG/ZQCpO9XYd2JwTBghjYSb0nH?=
 =?us-ascii?Q?cB3YKCWIDRFI0zZCTr4XizGx0z9xNBAcpRAd9BCWJCbiEmln2TVrdN3tA1Bb?=
 =?us-ascii?Q?T0IOWGJqTR1Nr46GlssmPSIILqIwZ4k47Ui/lE8yzQtTQ/EmSgMSv9DqZ1R3?=
 =?us-ascii?Q?uN7ZBFDt4seQi6fArhm1LLtbVSy5lRPWAvoRSOvbsGzl/+g1QzbvZF51mjRR?=
 =?us-ascii?Q?79FMXMai99DdIr+sA3/Vwp8C22p1XqmYrdrAG1R+rsEfXGjiPIr2sfXmvpYL?=
 =?us-ascii?Q?APAoROJom/mKi6UNvrQuf/uyrcPgaDAeJ0xDhUUXonKBf0YeJx4xoOTN5CkM?=
 =?us-ascii?Q?Eks+nmJHLGnXyEl2NYeIOAWH3yAnABUT7mTsFLtIAz8A+euLw7Vak+O9fTyV?=
 =?us-ascii?Q?CkzQrdMcQL1RONjXk4E6C+3+hsWhIEwBG6/19W/FQbBIUNWo5Bm8Ny2TnCvU?=
 =?us-ascii?Q?HALLr+B94//nYc9J+yEop6G0H91eW3kmcIC4W4ObgstxaIqrJD1OSg0pJN3X?=
 =?us-ascii?Q?xc6jq//ZllaYSJpPOfM5tziRsErhnMZWzi6Wf7sGmwcSvkMYhwqCgNWfLVTW?=
 =?us-ascii?Q?nX7ZOh0Ddw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db36299-7a27-4f6c-cdff-08df3638356a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:45:15.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY1/kG/SpeXL/YEisdpc4DDbUnYVL2fuhBh5nLUCjLaW12H9ni3wvYs2w9Uup9xjrywPnEzxRitoEFgqXenHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

On Thu, Oct 29, 2026 at 02:56:58PM +0800, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range. Refuse reset when the device decodes memory through its
> DVSEC ranges instead of HDM decoders, since the cache holds no range to
> reserve for that memory.
> 
> Hold the global cxl_rwsem.region write lock across snapshot, reset and
> restoration to keep the decoder state and reserved ranges stable. This also
> blocks region and decoder sysfs, region probe, poison operations, sanitize
> and region-aware event tracing across CXL devices. The Memory Clear wait is
> capped at 20 seconds; cache flushes and other reset work extend the hold.
> 
> Allow the existing CXL_REGION_INVALIDATION_TEST option to bypass missing
> CPU cache invalidation for test environments without a provider.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
> ---
>  drivers/cxl/Kconfig          |   3 +-
>  drivers/cxl/core/hdm_state.c | 245 ++++++++++++++++++++++++++++++++++-
>  drivers/pci/cxl.c            |  86 ++++++++++--
>  include/cxl/hdm.h            |  44 ++++++-
>  4 files changed, 367 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8b08bfdc4982..e927e69a3f7b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -226,7 +226,8 @@ config CXL_REGION_INVALIDATION_TEST
>  	  invalidation mechanism. For example usage of wbinvd is restricted to
>  	  bare metal x86. However, for testing purposes toggling this option
>  	  can disable that data integrity safety and proceed with enabling
> -	  regions when there might be conflicting contents in the CPU cache.
> +	  regions or performing CXL reset when there might be conflicting
> +	  contents in the CPU cache.
>  
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 1140006de50d..cb7ec0f86ab1 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,8 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
> @@ -13,7 +19,8 @@
>  
>  /*
>   * CXL state that must stay available while no CXL driver is bound: the CXL
> - * locks and the per-device HDM cache filled during PCI enumeration.
> + * locks, the per-device HDM cache filled during PCI enumeration, and the
> + * region quiesce used around a reset.
>   */
>  struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> @@ -132,3 +139,239 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
>  	}
>  	kfree(info);
>  }
> +
> +/**
> + * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
> + * @slot: cache pointer owned by the device
> + *
> + * Return: true if the published state shows CXL.mem enabled while HDM
> + * decoders are globally disabled, so that the device decodes memory through
> + * its DVSEC ranges, which the cache does not describe.
> + */
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
> +	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
> +}
> +
> +/**
> + * cxl_hdm_cache_snapshot() - copy the published HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
> + * is published, or another ERR_PTR() on failure.
> + */
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info, *copy;
> +	size_t size;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	if (!info)
> +		return ERR_PTR(-ENXIO);
> +	if (info->decoder_count <= 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	size = struct_size(info, settings, info->decoder_count);
> +	if (size == SIZE_MAX)
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	copy = kmemdup(info, size, GFP_KERNEL);
> +	if (!copy)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return copy;
> +}
> +
> +void cxl_region_quiesce_lock(void)
> +	__acquires(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	down_write(&cxl_rwsem.region);
> +	__acquire(cxl_region_quiesce);
> +}
> +
> +void cxl_region_quiesce_unlock(void)
> +	__releases(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	__release(cxl_region_quiesce);
> +	up_write(&cxl_rwsem.region);
> +}
> +
> +/*
> + * Bound the range twice: request_mem_region() takes resource_size_t while
> + * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
> + * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
> + * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
> + * resource_size_t is 64-bit, which the !len test catches.
> + */
> +static int cxl_hdm_range_validate(const struct range *hpa_range)
> +{
> +	u64 len = range_len(hpa_range);
> +
> +	if (!len)
> +		return -EINVAL;
> +	if (hpa_range->end > RESOURCE_SIZE_MAX || len > RESOURCE_SIZE_MAX ||
> +	    len > SIZE_MAX)
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q,
> +			     const struct range *hpa_range)
> +{
> +	struct cxl_hdm_range *range, *next, *new_range;
> +	int rc;
> +
> +	rc = cxl_hdm_range_validate(hpa_range);
> +	if (rc)
> +		return rc;
> +
> +	list_for_each_entry(range, &q->ranges, list)
> +		if (range_contains(&range->hpa_range, hpa_range))
> +			return 0;
> +
> +	new_range = kzalloc_obj(*new_range);
> +	if (!new_range)
> +		return -ENOMEM;
> +
> +	new_range->hpa_range = *hpa_range;
> +	new_range->len = range_len(hpa_range);
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		if (range_contains(hpa_range, &range->hpa_range)) {
> +			list_del(&range->list);
> +			kfree(range);
> +		}
> +	}
> +	list_add_tail(&new_range->list, &q->ranges);
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q,
> +				  const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	for (int i = 0; i < snapshot->decoder_count; i++) {
> +		const struct cxl_decoder_config *config =
> +			&snapshot->settings[i].config;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
> +		    !range_len(&config->hpa_range))
> +			continue;
> +
> +		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
> +			return -EOPNOTSUPP;
> +
> +		rc = cxl_hdm_range_add(q, &config->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +
> +		range->res = request_mem_region(hpa_range->start, range->len,
> +						"cxl_reset");
> +		if (!range->res)
> +			return -EBUSY;
> +	}
> +

Hi Srirangan,

The spec explicitly requires no outstanding or new CXL.mem transaction after
the affected HDM ranges are offlined.

For this part, I don't see any guarantee that a successful request_mem_region()
means all outstanding memory access have stopped and no new access can occur.

I see you refuse to reset when resource reservation conflict, but nothing
offline memory or directly stop CXL.mem traffic.

I wonder if the implementation provide enough evidence that when request_mem_region()
success means no new mem access or CXL.mem traffic will pop up ?

Best regards,
Richard Cheng.

> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +		pr_info_once("CXL reset: bypassing CPU cache invalidation for testing\n");
> +		return 0;
> +	}
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +		int rc2;
> +
> +		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +		rc = rc ?: rc2;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
> + * @q: quiesce state to initialize
> + * @snapshot: HDM state from cxl_hdm_cache_snapshot()
> + *
> + * Reserve every enabled system-physical range in @snapshot exclusively, then
> + * write back and invalidate CPU caches for them. Call
> + * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	INIT_LIST_HEAD(&q->ranges);
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
> +		return -ENXIO;
> +
> +	rc = cxl_hdm_ranges_collect(q, snapshot);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(q);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +/* Evict lines fetched during reset before DMA exclusion ends. */
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +{
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range, *next;
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		list_del(&range->list);
> +		if (range->res)
> +			release_mem_region(range->hpa_range.start,
> +					   resource_size(range->res));
> +		kfree(range);
> +	}
> +}
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index bfc31f821d01..4a8969145f8b 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -15,6 +15,7 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -23,6 +24,13 @@
>  
>  #include "pci.h"
>  
> +struct cxl_pci_cache {
> +	struct cxl_hdm_quiesce quiesce;
> +	u16 saved_ctrl2;
> +	/* A cache-policy write was attempted and may need undoing. */
> +	bool cache_disabled;
> +};
> +
>  /* Find the CXL Device DVSEC and read its capability register. */
>  static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
>  {
> @@ -331,6 +339,23 @@ static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
>  	return rc;
>  }
>  
> +/* Shared range reservation, host invalidation, and device cache writeback. */
> +static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
> +				   const struct cxl_hdm_info *snapshot,
> +				   struct cxl_pci_cache *cache)
> +	__must_hold(cxl_region_quiesce)
> +{
> +	int rc;
> +
> +	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
> +	if (rc)
> +		return rc;
> +
> +	/* Track an attempted change so partial failures still restore policy. */
> +	cache->cache_disabled = true;
> +	return cxl_reset_disable_cache(pdev, dvsec, cap);
> +}
> +
>  static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  {
>  	unsigned long deadline;
> @@ -386,7 +411,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
>  				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>  }
>  
> -static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			      struct cxl_hdm_quiesce *q)
>  {
>  	int rc, rc2;
>  
> @@ -411,29 +437,61 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc = rc ?: rc2;
>  
> +	rc2 = cxl_hdm_quiesce_flush(q);
> +	if (rc2)
> +		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
> +	rc = rc ?: rc2;
> +
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
> +	__must_hold(cxl_region_quiesce)
>  {
> -	u16 saved_ctrl2;
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
> +	struct cxl_pci_cache cache = {};
>  	int rc, rc2;
>  
> -	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +				  &cache.saved_ctrl2);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> -	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +	if (PCI_POSSIBLE_ERROR(cache.saved_ctrl2))
>  		return -ENODEV;
>  
> -	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot)) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
> +			PTR_ERR(snapshot));
> +		return PTR_ERR(snapshot);
> +	}
> +
> +	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, &cache);
> +	if (rc && !cache.cache_disabled) {
> +		pci_err(pdev, "failed to prepare CXL reset ranges: %d\n", rc);
> +		cxl_hdm_quiesce_destroy(&cache.quiesce);
> +		return rc;
> +	}
>  	if (!rc)
> -		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
>  	/* Restore cache policy after any attempt to disable caching. */
> -	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
> +	cxl_hdm_quiesce_destroy(&cache.quiesce);
>  	return rc ?: rc2;
>  }
>  
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	cxl_region_quiesce_lock();
> +	rc = cxl_reset_quiesced(pdev, dvsec, cap);
> +	cxl_region_quiesce_unlock();
> +
> +	return rc;
> +}
> +
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	u16 dvsec, cap, ctrl;
> @@ -460,5 +518,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> +	/* The cache is owned by @pdev and does not require a bound CXL driver. */
> +	if (!cxl_hdm_cache_present(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
> +		return -ENOTTY;
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index cfb55b10f8ac..7919d872a34d 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -3,10 +3,14 @@
>  #ifndef __CXL_HDM_H__
>  #define __CXL_HDM_H__
>  
> +#include <linux/list.h>
>  #include <linux/types.h>
> +
>  #include <cxl/cxl.h>
>  
> +struct device;
>  struct pci_dev;
> +struct resource;
>  struct cxl_endpoint_decoder;
>  
>  /**
> @@ -45,7 +49,6 @@ struct cxl_hdm_info {
>  	bool dvsec_ctrl_valid;
>  	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>  };
> -struct device;
>  
>  int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
>  				 resource_size_t size);
> @@ -59,5 +62,44 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
>  void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
>  			   struct cxl_hdm_info *info);
>  void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
> +
> +/*
> + * Region quiesce blocks CXL region commit and teardown, and with them decoder
> + * reprogramming, while reset handling captures or restores HDM decoder state.
> + */
> +token_context_lock(cxl_region_quiesce);
> +
> +/**
> + * struct cxl_hdm_range - HPA range held exclusively across a reset
> + * @list: entry in &cxl_hdm_quiesce.ranges
> + * @hpa_range: system physical address range decoded by the device
> + * @len: length of @hpa_range
> + * @res: reservation of @hpa_range, once requested
> + */
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct range hpa_range;
> +	u64 len;
> +	struct resource *res;
> +};
> +
> +/**
> + * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
> + * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
> + */
> +struct cxl_hdm_quiesce {
> +	struct list_head ranges;
> +};
> +
> +void cxl_region_quiesce_lock(void);
> +void cxl_region_quiesce_unlock(void);
> +int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +	__must_hold(cxl_region_quiesce);
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +	__must_hold(cxl_region_quiesce);
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
>  
>  #endif /* __CXL_HDM_H__ */
> -- 
> 2.43.0
> 
