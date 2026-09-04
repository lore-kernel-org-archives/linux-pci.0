Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20033ADAF;
	Fri,  4 Sep 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513589; cv=fail; b=u1vLLaLGPSrr4fFPKjtl22JH8yDHelpRzJB25ueV4M3VVWKdvdfd2ZQf4xrLIbvrh2TPw0de/SXeLtxlFwkEqTCDme90AiHRPPMdUDv5poFUfO8eMOqdnnrEqAXQRE6GSclPx7WAexd4kF11Ld6OXmuhFc3Q/3UdRWT+og/HNKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513589; c=relaxed/simple;
	bh=xomUBTncTAzdq2KBbK8pXM9ybNPz6bWVfD9YEwmgU8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TiMo3xDbbGbKQrUsBcrhtMpSa71vLHptYCEr3MZNWopyE7G5CyEUE9Wh1g42CTKUx7oeVwh0JT58Q/5Ul5ts4j1dl1pkP07g3g+l0NPWMliAJldgAJhsMlmMHKhSTakOQHAb0U9GBpLdlavILG9rkOlw0ynbP+i87cro5OFlCes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P7o2gAeh; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P7o2gAeh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEirjOg5US8V2d+pjSHN/mx3YfA2m0GNfl/ItzjWYdictMHeuRJQWOuCkZkiD9IQ4r7WrAlSmC4zr6yKh32J2Shscsfs2c8aNOLWLf+XH67zdo3cAv0BJn3KJyIXRkCvJA6PUkVq/4+lqPrLdovuOECp4vxnvqEsj02vIkWQGogRNH6TffS3m5yfbezeix337TJCId1mz2KAEJJ9oNRgL5FE8YJaY9jMimIEcG2pUqFZ066gjtDknRv5T/EBD3aQPChxPk1aEznD2XpWHM5GB4wg4FVjx2xjni43QwqZbWYZbOkycH8aBS41Huz/XFAcvMmlBR3RDdA5mqXCCFrxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI/zWbCD4QGW/W6vn7FVIfMbaocdFWH0efqAQ/vsgwE=;
 b=WOHShaqHfGn2Ph3IPRZrt26hQJCAvKnwJ6Z+tGB5HaYpbMDdoRqy9zcbsqAxdLsDfQbe/BWDLm8ILPDrHYEVXTO8CWTnz5Vbals/x1rhGuFzakA+yth6kZJ9RDhr9aFRJeZ7f5tsOVVLK3dVABN9wHlPYslcWXYxGcaEVhcOgiK752z0Q+5K1Q5KMFKcv1eLU15psCOw59R0VaWIvaXpLUU0JuPZPak4ItfL54NL/GHrnPGRkCkQLEAbyCd/CMSJghPt8tI9sG4QlsyFMVzBB3vTgjD8qCDjfRK6Y5ub9iWRzMj57HUdNzSbaF6iGlEKvK/OmuQxozzsW0vHVrKRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI/zWbCD4QGW/W6vn7FVIfMbaocdFWH0efqAQ/vsgwE=;
 b=P7o2gAehERyR3nAFMWyv3TVn77XttR93l+4FOwti4TPfWqht7IiahrqqyakFup1xjgmaXH68BKNTIxP+gncZYvrYDOrkijrTleAFLfvWuqPXB4tzGPxh6lhgyGYV6HnlyXlu4HR2E3ss5xjMWwvpujIKBkU9+s92z0G/vEF4CI5KoWosGyN3n+qB08Y5qeMeGX5OvMmNKqJvOrudvAugl9lDV3D6l4KmiaNf2muL2QTMJwkKefIflLPVHiW6fr+/nwo0xX5+ljH7WKilJeDVoMh1j9HqPUZX7U/WWyzGSe+qb0k7ZTDax30z2igPfUWYUUTV1DM9ookNgPj384y1Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:19:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:19:44 +0000
Date: Fri, 4 Sep 2026 17:19:38 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 07/12] cxl: Validate HDM ranges before CXL reset
Message-ID: <apqMXYyHnu_jD4EK@MWDK4CY14F>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902072804.665639-8-smadhavan@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: d81ecade-ac3b-4ef9-2d04-08df0a65a805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|10067099003|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wqBWOUe108/Ab1YCzVrVYluMeZ0xMaGfbj69QBTY4CXlHy2hSBcXmFNNgmvscHhuQV7r1JKeoKE8dK57DmtWO5yXrnH7Z+F4Zb2tjK9ruXOakMwrWj6oRe9jDAt4NCO1355Rw+PyY8U1TJOHo1NzkBV3Dp7EO2VprwfiRyqvvSCnnw9hgEFWlcY9u5NKgCIe4LM/Q683kJTlaBjmXYNMXBPuXvXPO2PN/uk8dZpG0/IFY5xunL0ytQxjNKHc/RQ2u9TViWqZi1REb9bsFo/yP2hIE2ldxsOtbqj8uCpcPnS9gApGtmnX/ioCfuZjPJeNnNeeILl5zd7dc3HOoq9AcQuCIckscw+Sh1cyoRmEoHQqJ8Ne5SpYNlTgTkSWWi0fZoY0QV4W8Hg1NvxzXkjH5g1T7lS+qQm+5Sv/oxxtR6JSvlqYCI7AkQbU5QVbyPpegi/eKWAEQe+mIuTstgOc9lbkqSb3mQQZAOXgCS441p700GHNcY95s6/vTjbHah1fqT8KbPUspUMC6jDmTgzunaCQ1Jkg2CQoxLoxQvAUp09CR/7kLb2boe2V23cYfyVeKKZzakglMCfKO8XXh3IgQ2aHn6RI+Cz/w2Zw+kadsahDPxxy7/RAq28NgROXNTcUXlbmqA61JwsLPefexKhzyFMZeGlFWR9DfzmbAVB6Otg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phohKuV4ntQT3ftZJT9x/zwopejQmY4PThMyGjXJg/bBXJuTnRTbZK2AA8NW?=
 =?us-ascii?Q?0doTAryEespG652STHunZ6hwMJ4srCp6c4cSHXovpyD4Tcb74Tod4ensU1ob?=
 =?us-ascii?Q?jcUCLrfEe26BWdGy03OFJ+8qsvY7bGzE1OmwM34wj2R1TR8CCli39J7frZ+d?=
 =?us-ascii?Q?1CYu3MiQ/jdsHnCaMKDwlfUMVsRlImcKRL6yYf2nAMyoHUMACalVB7GRiHo/?=
 =?us-ascii?Q?76qY6pOIrI+H7YRSuwOrGWIkg17pPuxdLVxyCKBXEStBnliSV3URVANZx1oW?=
 =?us-ascii?Q?lTOVdvJ/7BMwXraRwskltMRvoNli7RaSpsIYZayd3soSzfwrhx0psNgFxuuQ?=
 =?us-ascii?Q?c/63eRCoBHlnBEncqOce0SACVu0nq6wEeQKjSMSn2Wv7g6YQzWX3JH1ss8VC?=
 =?us-ascii?Q?nW6UwC7NNXEgpCBOBf8xa+ssB2n0+cGSoXhw7/3/2SNKOlE5IMZvrbTHrQgP?=
 =?us-ascii?Q?IfAE2QvyR1+SS6pDFrgUz1tddm6YnAafVd4PfEnY5u46pGJqzYc3N7me21vd?=
 =?us-ascii?Q?5uIfjfAjeiiuJdOZacj8FCjeNfoq3+kKd8jmcRLuSbNd24PW71oHxSrHKPG2?=
 =?us-ascii?Q?EunN/mPRib/+w53J7GX0AmHSamoleJEvmPnumgsaG4bNMYBthLOxmK2p/A56?=
 =?us-ascii?Q?VpFNsBMJBEm/nAWX5Anhbn3oSVL4bWbWZyXrD/KTK8nkMthAWZ8zS97jobWH?=
 =?us-ascii?Q?RzUdzV5yAmYtPZlstvZH1Fwo7LRrBlE8l9maEnbLC3T58jtceHSksU6hhYsX?=
 =?us-ascii?Q?z7IEJyC7lZFqjMGAmImXxksfGLusQ7ztx4TZBYdt7mHNcLDnPDRfDGln5srg?=
 =?us-ascii?Q?nrZ0+0YBv0bf4ETBFsGb9g0rJ9PEMmPckve5W5oLZ+IJJYbRiSSljBlTQhfL?=
 =?us-ascii?Q?vEC8NjIGjlTUoaqJn9MxjuuFg1lbN7AboJ8FJsCRaY2nWgYhQbO8S2DcBLsC?=
 =?us-ascii?Q?Z9wicK+Sq150X7AT0Ct81oNPFcX9TU+bnL1HykhZIcqG+yoVIb9V0HmM91gL?=
 =?us-ascii?Q?C1Rs67CHeiubVIwJAxfqHEEH3THwGDiqvmSesGSXi15lN/r4PE2ahDtZjPxP?=
 =?us-ascii?Q?WgwKXgYB0tsiQInO5w4n2fZuARAJShskDCIKRtoseBe+lcr+erMkMMet8zdo?=
 =?us-ascii?Q?3fzvbu3r/Eob+VoeMMsXTz7qzN1pkqZBtd/EaB5k1JjfM3wR0py8WhOiCkZB?=
 =?us-ascii?Q?VdSELLywNgUQT6on85g541nA3c/XS+UQwmjfrn8cKHunMquEkY0fW7H+gMNa?=
 =?us-ascii?Q?3xRmOv+dTa/xdyix60InDPZDwkkbjQU/s1SC/wmVqXKSMaSa5lJwdEHHr4Gx?=
 =?us-ascii?Q?8s9EjcN/FYRpo+3NBgJNugFOmWQOohREk81C9puPQlB3wfWJWi4Og2R1gK/k?=
 =?us-ascii?Q?fBUCzJGoe3l9fsLViRAwXFBg5Pi2ZvEz+3NaRJSQuzEVBLuUeArUxvV4kPVZ?=
 =?us-ascii?Q?mBAtFZIQKviWjs3LH/io5hcc60J/pFkqg4679NDptg01knsT19vk/ndL3JR3?=
 =?us-ascii?Q?YGMh/wTJSqJRwjgWpS85GexRjzP4Hwf1jinrSURtY5hjGDhnA4x/yU/eqn7Y?=
 =?us-ascii?Q?aLmJhVjn1UnMs4AGQR/x1kn8QKOvA4njJCGNjbJS/ynfVfCsNduUjpgqCHK+?=
 =?us-ascii?Q?W/tz6UrSWel4I03d8eAPiZdKAiJLrlawg2ja+cHiVbbKMehzE6QrYRrjDmP6?=
 =?us-ascii?Q?dOt450SNauswBPBKLLNFHnZqXMyCztB8bOJbIcROWD/G+Xa69K/mpHDxoFds?=
 =?us-ascii?Q?S1fX0h+n0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ecade-ac3b-4ef9-2d04-08df0a65a805
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:19:44.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trNUR2Q7yryfCtrrPcQAIf0cbIlzAiYNSiCis4LqMAr2aRJjH2gplp5RQY1tWHaruKKnWU06PYcPQsnnIoZRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

On Wed, Sep 02, 2026 at 07:27:59AM +0800, Srirangan Madhavan wrote:
> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
> 
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue
> after the range reservation succeeds.
> 
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 255 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 254 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 439071a5c34d..13bd0c3faf7e 100644
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
> @@ -514,6 +516,229 @@ static const u32 cxl_reset_timeout_ms[] = {
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
> +static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
> +{
> +	INIT_LIST_HEAD(&ctx->ranges);
> +}
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
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	rc = cxl_hdm_range_validate(pdev, hpa_range);
> +	if (rc)
> +		return rc;
> +
> +	list_for_each_entry(range, &ctx->ranges, list)
> +		if (range->hpa_range.start == hpa_range->start &&
> +		    range->hpa_range.end == hpa_range->end)
> +			return 0;
> +
> +	range = kzalloc_obj(*range);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	range->pdev = pdev;
> +	range->hpa_range = *hpa_range;
> +	range->len = range_len(hpa_range);
> +	list_add_tail(&range->list, &ctx->ranges);
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
> +		struct cxl_decoder_settings *settings = &info->settings[i];
> +
> +		if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +			continue;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!range_len(&settings->hpa_range))
> +			continue;
> +
> +		if (settings->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +			pci_err(pdev,
> +				"CXL reset does not support normalized address decoders\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		rc = cxl_hdm_range_add(ctx, pdev, &settings->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_request(struct cxl_hdm_range *range)
> +{
> +	struct pci_dev *pdev = range->pdev;
> +	const struct range *hpa_range = &range->hpa_range;
> +
> +	range->res = request_mem_region(hpa_range->start, range->len,
> +					"cxl_reset");


How does this function provide us the required quiescing ?
I do not see it revoking existing PFN/VFIO mapping or preventing a driver
from issueing a new access after cpu_cache_invalidate_memregion()

Want to know what prevents new CXL.mem requests between cache invalidation
and reset completion ?
It does not require the range to be offline or unmapped first ?

Best regards,
Richard Cheng.

> +	if (!range->res) {
> +		pci_err(pdev,
> +			"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		rc = cxl_hdm_range_request(range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
> +{
> +	struct pci_dev *pdev = range->pdev;
> +	const struct range *hpa_range = &range->hpa_range;
> +	int rc;
> +
> +	rc = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +	if (rc)
> +		pci_err(pdev,
> +			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
> +			hpa_range->start, hpa_range->end, rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
> +					   struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc;
> +
> +	if (list_empty(&ctx->ranges))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		pci_warn(pdev,
> +			 "CPU cache synchronization unavailable; continuing without cache invalidation\n");
> +		return 0;
> +	}
> +
> +	list_for_each_entry(range, &ctx->ranges, list) {
> +		rc = cxl_hdm_range_flush_cache(range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
> +				  struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	rc = cxl_hdm_ranges_collect(ctx, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(ctx);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_flush_cpu_caches(ctx, pdev);
> +}
> +
>  static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
>  {
>  	int dvsec, rc;
> @@ -542,6 +767,20 @@ static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
>  	return dvsec;
>  }
>  
> +static bool cxl_reset_hdm_available(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	/*
> +	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
> +	 * reset-method probes and reset requests can test availability without
> +	 * a CXL driver bound to the device.
> +	 */
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	return info && info->hdm_size;
> +}
> +
>  #define CXL_RESET_CTRL2_CMD_MASK \
>  	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>  
> @@ -731,7 +970,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec;
> +	int rc;
>  	u16 cap;
>  
>  	dvsec = cxl_reset_get_dvsec(pdev, &cap);
> @@ -741,5 +982,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	return cxl_reset_execute(pdev, dvsec, cap);
> +	if (!cxl_reset_hdm_available(pdev))
> +		return -ENOTTY;
> +
> +	cxl_hdm_range_context_init(&range_ctx);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (!rc)
> +			rc = cxl_reset_execute(pdev, dvsec, cap);
> +		cxl_hdm_range_context_destroy(&range_ctx);
> +	}
> +
> +	return rc;
>  }
> -- 
> 2.43.0
> 
