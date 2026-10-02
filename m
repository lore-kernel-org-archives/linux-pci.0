Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540002EEE7B;
	Fri,  2 Oct 2026 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928416; cv=fail; b=Szk0Kjdx8fqwH+mCjx8+XP574qcmbVqqLFYqgXE2FBoeMDgqxeoyjdtNykmNcUYF6ZvdTxS+LSCVFUW9NfuGgzK4Y4xZZ9YI/PFWo6/oD4L+XRn0wYwRTuCMRsQAd1nFUX5+ttdvh6nD/lVF6N8EAL6FLBN9khda/gYfnk2W8T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928416; c=relaxed/simple;
	bh=NzsLIcFLMh5XhJitiB3SsuYuaqAs5Dnn/p/4JCpUZzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FseO1WZZ6pnuaQcejX3GsHF7SA4kAXFG14mwQ2wEY/ZijAB4Hk46JCIPI7hubRxpTUVoA/0bUzkkMltLBX9nEplSXzg2hMUbjCp4FeCMATTiHEzG6+qP4sjlCtP18ep/93uJjWEVZT4X8+OPOiSYFtz6rgdbwcyfA9zIwCnP+mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2BlOlpW; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2BlOlpW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCigzyIj5Ka/M5nDPShbJEx9qmIS3CjkAQJL8Z0PoUdwMmygrdq/g+w1/VC1372JPaM+cy+kNxVkXHktXmRsDu/0IAqwxA2GH03RhLxGcO4L6eQC6otxrf49zcm9+7vFYFhSDWqPZqRG9R+tt/OCY/Q2xDauut36GKv6w41acrdBSl6LvtRx6m9tuvKeARGUVYv/JSjeFwrgsqpag+AQTl94xjg7vIjVFbsDmv3+3v1UMrcm8cm1Z5lGTCu7os5vuDCNKWc87lVVUsgF1hCJTcOD8+imSvvoC9Od03L2SoNjqCm7JDn5QGIdc7DPMEHEkJJNX6usp5+EbIZ9tKDB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhptzemyJr3S8raxTVmNefkpw4842QvshWRcZ1pQNjI=;
 b=iFop9VPCOJuNR0Ch6ErJYOud3YzgeYsfnSmwLahaNvE3MwYOvnLC7X0YDTvB74amI7ES7nVU9MCtKEA0S/42EQkpsfK5A5Oao6ddgZ6r9U3be0pBIDKFxOSYunuusTd0IdKTqPtxUuHUEoQixW13SMPyIHzPx6/iIlhWZSJPgoox5HfUfcO5qzGdvNPZeEPCQPcqyna2lsilmfIjJLjYFfDmV8xYLeGeqydIUkijqy4j0iJruApjGzfhl19gKVy63HxK3i36I4aoKhsaVcWE5+u8/fzRunnZs2kBeQL6l2QFSZIBRaK9JU5P1eTgAITyROKrz0P6a87kySb7G8gFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhptzemyJr3S8raxTVmNefkpw4842QvshWRcZ1pQNjI=;
 b=C2BlOlpWir677wYd2UBDxG+usyIe0a2fy2/vokHsnhaA561r/v8yebBtgYkLbLFijbRSrR1sMidQpB33C5Qi37aGusI89+xSPREyXXikyPFvTaVjssdtkcn7fVsBCt4y8QIabNDf3nFM6F1+Vx6uo6m6V4TR3I10PaXWI2XacM2jxp2gIfkXx7tYTzYG1hJeQvZK1/dt0qgLwW77vBDacj2N3sj5g/aMh7Xph9SKB2Hyf1kXtw9RBsUI/qtwAas8mkXFBqEGoJ6t8qLfUhuZvD7WM+pbUhoPwjIJTugdAIrbFR/7wxPXrdSn2+omhIfwlqScpZoPr5UiIvADtdQ9Bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Fri, 2 Oct
 2026 08:06:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 08:06:50 +0000
Date: Fri, 2 Oct 2026 16:06:42 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v14 12/16] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <ar9k21TsVTXmW5I3@MWDK4CY14F>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-13-smadhavan@nvidia.com>
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: e889f1f7-c8c7-4dbc-7127-08df205c1c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10067099003|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I3jm7rddNlC2/IQHfrAwmgi869miJ4fjmoxE5XhZqLA5ud5Tpw1HMHCE2gFvSeplVBEnbYWzMBovk+oGPNwCB5vdU63ovUqz8gE6TGnQjHP6GKuwJOvUhS12Wra9Lznckpg7WhxzaI6AITbZ1QhNDe8cSlMIEwOXOHBYQOp9Pgjb72lWD4I/7rCqMAi69SvqC6XqPmz6qbBrlnJl6NhKl5YJU7IAFYt08aXpb5qdyEnAc6grzCwd0O4UrsomzJUWBbWeltsBM3g8iRyW7L8/F5lIrEZOhrav64koVKtJ6lD8NxePcA9hN3a7RKrdksvLMdPrYeQjcKnmeHhw0ck5wkhlH3Tv9y1GflkxptDITO1X8+yWhHhPCRYUJKrwXhEDL+l/KIgYGXbebLGYl3dAD7xD5Cb4xVMo+O/Eha1OWYoW+a+2wNEm8dK3Wt2vija9RrteCZsYC5xQGnPpQCkB7XhCUv8FwEhA1EJgFcfErz+VCOsJZpRUsz/B3IjHbt37Nl4L3O4Vkq5JVFCcHrNyM43/pZnzkzLTZnq//XrVBplhlaiDkZi6Fpt5CmUj9Chj2OdlmrF7U4a9DeAprr4vG1ZPpaoFR1fAqyh6NzO9WDDhVedgzUo2JC18WR7yChFxbp1+6WApEedlmd92msTwH7a8ObFWw5rQmsRQ7pY1Hf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RnEDXsEx2QsMdfCfNLltWkYDi5cNkqfJEV+UMD++rlgSsU/kM6BSGeqUGPmJ?=
 =?us-ascii?Q?MRp14YZy6VbDUPF3dxw+LcGfWTpSrcM4mGih0OMGzZKgMtkM9XidWZ+N7tEr?=
 =?us-ascii?Q?+lI+roe4LiY2kJP3/RJMHU81t3wMZc4ScVtUCknjc0U1Y/d2XE+FakbdmQ+T?=
 =?us-ascii?Q?XXcGk+8pNO1r/sqKeaxq3HAKt+YDo+V/3iYZHmMJe+v0PQ6xLIxhXRQ8K8Ar?=
 =?us-ascii?Q?roEkJnQbsrQfla/QsMxGeMD2QX+A09LsITm6o1UghkOdie9VUxN942FK2cAG?=
 =?us-ascii?Q?DNXZz85ZbyydTheHyI7d5ZEflHfnaFdMcp3dPhirrZpgf3YPr+8LDYrr3Nmo?=
 =?us-ascii?Q?ZsdF5BeDmIR8RmDafy306lsEUlS5zd4wcXhC1rwsGPkhMI7lgjBpp79czYi0?=
 =?us-ascii?Q?zq2bKwDghK1xDykT1TvxnvIVjkExX7j9jS5jhEQaA2cnuLXa/kWLdmzg5fGL?=
 =?us-ascii?Q?MoA84S5I71yt/oYoE00dEo9cX64NkQhp/7fmoAtoLK0G9Pd8c4336ozIoNYS?=
 =?us-ascii?Q?OuCAAkwAGv87EyiW+T2jxK6N2zZeuXGXrEYez8W2aOr0cWXC5Z25+Ter8zmc?=
 =?us-ascii?Q?U2YyVMOPz84BE4N3m7+iWF2ChltyYBGToyl0MaIf2eLNNRD0cZAFJurfSUoU?=
 =?us-ascii?Q?+fY77ht2B3i1b9ET7GDQlAOPEsMLekbfUR1p18/guPq6YH2AwViZp/ARWc3z?=
 =?us-ascii?Q?CJ84JxsYUauoE/cA1KUiNGHIGvG1PeTAJaI+T5WvgiouHIL0P9cIKpluKgyd?=
 =?us-ascii?Q?8JB5icbeaVe8Kit4k55LTREAiiIldJVUx9oMqNQ5sT+qMW4o5H6ii4iwK35I?=
 =?us-ascii?Q?+nVqLVrvYohlUDH0eUzPPsLv9ZnjNAgNt3BdyRwQO6Vzb9/wHLCpDcNehBl/?=
 =?us-ascii?Q?c8UMo7r8NpZBBmS+IzBLtTPMaZi8m0yhdY9pykfgBWxG0dsgZyxbj9ceNVny?=
 =?us-ascii?Q?SFkluWdEylxJpdQ8q15ALH0kBQeCr8oVbqWLs7ai7ZEYTHvFnk9LrtVQYZHT?=
 =?us-ascii?Q?sEGdyaIqdgtUEjLLzSdGnobYWk1OaUu3qRrNBIrj4nYysjq+BU1lCBp/TTZr?=
 =?us-ascii?Q?0tMR1/gXsk1gPgklvDky+/cuc539oNgBrG/WSnjRu/YAtAP7MjiZHB8jKw8F?=
 =?us-ascii?Q?39M2ZhMkk3Raeu5PiRSiTCHy/M1goWZ8jYTMcU+W5PXWL5HAJfCtWknwKpEI?=
 =?us-ascii?Q?mhFg6ELXCuj6FybCE3zA7pOpWB7GZ02hCj6u3DyYQU4KNCCnE+1hwiq7WPcK?=
 =?us-ascii?Q?0Gwz2As4xw9/Np6FJEMoaaOTKUu5WjNJyCrT43pGH0USBAQxPMzl30A7icAn?=
 =?us-ascii?Q?HAQ+YteiQ7SzCV9R3tAgp0JP1nhtGpJs0MU88Yz+I0p8n1M9WSXOvegF1S0Q?=
 =?us-ascii?Q?sauiVScwSgXpaiB/0l4RtjujiPchs0sty06qWOw52SVQf7iApeLSacydG1Cq?=
 =?us-ascii?Q?Ni7ZSOvOrIjWGTyFhZ0FRbdd9YVex1G0UcVLYfIE/B0KMZHE+5c7vm4AlvSR?=
 =?us-ascii?Q?5V88bDMhWpGgWO09a/HttXaTyAapcEiUcVpfWBXlLPI2Ed/TFGIJZPfEyeX3?=
 =?us-ascii?Q?K7Tvkf/Tg2mZQ4P0iuk4RxmvLgDngTwXzY+1LL6RDKV0FbDc2WO2+0mYcu99?=
 =?us-ascii?Q?Tkgt3Y3fjIN2UgQNTdkh9K5fONvKjC24gDAueR+tn/SAhNQ0pQdNX1CT7lnb?=
 =?us-ascii?Q?z0JT03trxurZvVqRftlyoByFhI2YGOqndTXWrKiS2I0zy546LEnga/Tz0IJy?=
 =?us-ascii?Q?4vK1Wtjd/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e889f1f7-c8c7-4dbc-7127-08df205c1c85
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 08:06:50.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT/hor4G2BFvzTjKOINnsVciBHc6EAwmGT7o4Zv8sodDlP5CUbFC9qrCVE/Dn65gzlsh+S9TTNBKezG/Kt2pWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

On Thu, Oct 01, 2026 at 09:22:23AM +0800, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 248 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 241 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 94f854520a1c..584b51cd9e28 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -11,6 +11,8 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -462,6 +464,205 @@ static const u32 cxl_reset_timeout_ms[] = {
>  #define CXL_CACHE_WBI_TIMEOUT_US 100000
>  #define CXL_CACHE_WBI_POLL_US 100
>  
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +	struct range hpa_range;
> +	u64 len;
> +	struct resource *res;
> +};
> +
> +struct cxl_hdm_range_context {
> +	struct list_head ranges;
> +};
> +
> +static void cxl_hdm_range_context_destroy(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range, *next;
> +
> +	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
> +		list_del(&range->list);
> +		if (range->res)
> +			release_mem_region(range->hpa_range.start,
> +					   resource_size(range->res));
> +		kfree(range);
> +	}
> +}
> +
> +/*
> + * Bound the range twice: request_mem_region() takes resource_size_t while
> + * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
> + * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
> + * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
> + * resource_size_t is 64-bit, which the !len test catches.
> + */
> +static int cxl_hdm_range_validate(struct pci_dev *pdev,
> +				  const struct range *hpa_range)
> +{
> +	u64 len = range_len(hpa_range);
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	if (hpa_range->end > RESOURCE_SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (len > RESOURCE_SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (len > SIZE_MAX) {
> +		pci_err(pdev,
> +			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
> +			     struct pci_dev *pdev, const struct range *hpa_range)
> +{
> +	struct cxl_hdm_range *range, *next, *new_range;
> +	int rc;
> +
> +	rc = cxl_hdm_range_validate(pdev, hpa_range);
> +	if (rc)
> +		return rc;
> +
> +	list_for_each_entry(range, &ctx->ranges, list)
> +		if (range_contains(&range->hpa_range, hpa_range))
> +			return 0;
> +
> +	new_range = kzalloc_obj(*new_range);
> +	if (!new_range)
> +		return -ENOMEM;
> +
> +	new_range->pdev = pdev;
> +	new_range->hpa_range = *hpa_range;
> +	new_range->len = range_len(hpa_range);
> +
> +	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
> +		if (range_contains(hpa_range, &range->hpa_range)) {
> +			list_del(&range->list);
> +			kfree(range);
> +		}
> +	}
> +	list_add_tail(&new_range->list, &ctx->ranges);
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +	int rc;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		struct cxl_decoder_config *config = &info->settings[i].config;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
> +		    !range_len(&config->hpa_range))
> +			continue;
> +
> +		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +			pci_err(pdev,
> +				"CXL reset does not support normalized address decoders\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		rc = cxl_hdm_range_add(ctx, pdev, &config->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +
> +		range->res = request_mem_region(hpa_range->start, range->len,
> +						"cxl_reset");
> +		if (!range->res) {
> +			pci_err(range->pdev,
> +				"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
> +				hpa_range->start, hpa_range->end);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_invalidate(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +		int rc2;
> +
> +		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +		if (rc2)
> +			pci_err(range->pdev,
> +				"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
> +				hpa_range->start, hpa_range->end, rc2);
> +		rc = rc ?: rc2;
> +	}
> +
> +	return rc;
> +}
> +
> +static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		pci_err(pdev, "CPU cache invalidation unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = cxl_hdm_ranges_collect(ctx, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(ctx);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_invalidate(ctx);
> +}
> +
>  #define CXL_RESET_CTRL2_CMD_MASK \
>  	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>  
> @@ -612,7 +813,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
>  					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>  }
>  
> -static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			      struct cxl_hdm_range_context *range_ctx)
>  {
>  	int rc, rc2;
>  
> @@ -637,31 +839,42 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc = rc ?: rc2;
>  
> +	/* Evict lines fetched during reset before ending DMA exclusion. */
> +	rc2 = cxl_hdm_ranges_invalidate(range_ctx);
> +	rc = rc ?: rc2;
> +
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			     struct cxl_hdm_range_context *range_ctx)
>  {
>  	u16 saved_ctrl2;
>  	int rc, rc2;
>  
>  	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
>  	if (rc)
> -		return pcibios_err_to_errno(rc);
> -	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> -		return -ENODEV;
> +		rc = pcibios_err_to_errno(rc);
> +	else if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +		rc = -ENODEV;
> +	if (rc) {
> +		cxl_hdm_range_context_destroy(range_ctx);
> +		return rc;
> +	}
>  
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (!rc)
> -		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +		rc = __cxl_reset_execute(pdev, dvsec, cap, range_ctx);
>  	/* Restore cache policy after any attempt to disable caching. */
>  	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	cxl_hdm_range_context_destroy(range_ctx);
>  	return rc ?: rc2;
>  }
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec, rc;
>  	u16 cap, ctrl;
>  
> @@ -693,5 +906,26 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	return cxl_reset_execute(pdev, dvsec, cap);
> +	/* The cache is owned by @pdev and does not require a bound CXL driver. */
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		if (!pdev->hdm || !pdev->hdm->hdm_size)
> +			return -ENOTTY;
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -ENOTTY;
> +

Hi Sririangan,

I tested your series on some machine with CXL type 2 device, those device were
unbound and no VFs enabled.

After executing cxl_reset, all type 2 device error out with
"""
[Errno 25] Inappropriate ioctl for device
"""

Execution stops at the above CPU cache-invalidation check. Since the registered
cache-maintenance provider list is empty. The earlier check
"if (probe) return 0" succeeds before checking this one, which explains why
the method is advertised.

Is CPU cache-invalidation provider expected to be on standalone driver or
something else ?


Best regards,
Richard Cheng.

> +	INIT_LIST_HEAD(&range_ctx.ranges);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (rc) {
> +			cxl_hdm_range_context_destroy(&range_ctx);
> +			return rc;
> +		}
> +
> +		/* cxl_reset_execute() releases the ranges on success and failure. */
> +		rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
> +	}
> +
> +	return rc;
>  }
> -- 
> 2.43.0
> 
