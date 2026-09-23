Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509F4772B4;
	Wed, 23 Sep 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199685; cv=fail; b=IsjJFECJ3ptx3pmNElVPiWvcVjMt23oP99GDP/+5QhbmP5jPMxj+eCg6BFqBZX67VEJ2YJ0ip+RBEytZ8WZjSzBu8vBextU6/jMZaiM/mWwY6UEbdadvmXfrCf0QGqyTEQl+GzFQmzi9DwI1zht56OkCeQcvnKWUi1v3KVxLMRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199685; c=relaxed/simple;
	bh=+VCc1Bz6y558uM3MkcVmMg3FjT2raOHNq4R2u9b1RBs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GECC3duElXBjUZp/Q3c99WDmb7EKoLeToFbM+isFbRR/ktiXX3PkdRmIke6v/r/11vK57JeF2+/1Towt/eYPPKBAzEF1Z2WqOvaBKWdK1KxIFbI3TRVlxU0thryjDKySLAg1naxOA4vPfCAa7AJCf6gJOYQTKJ84enekEeqHQOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1gnD/eLW; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1gnD/eLW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOysFh3YAH4rfU/nEt7f9wtRk0rjppdyPlvczOIKSXyoqi2bUfRNWQln6yRE2y393j41n9m+aUmXslCqC4sOUvxyV08GKaUt1tnx5hvn6HyoZZoc1G7XBor6Aw3kSPm9w2UJ1h356dY9UH2+orJ8BedeF70ZjzmE8LHwRm0f+UIvfzl+m7lMEGC2x9Mk6iYU3Eo7NNzBQpP3U20yLesLiTAEYQLlwF3IIwOdU54qfpIpWeG/NEZyYccasAWHaQQpDFVL6cnsvpjSYQZZ+IUT23o6wmGzm2/S+/PWXyQZf3TC/YSKjQDIoJSsMuZaZflMYMnGF3tcoeHvjXHX27QXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fym86PMynqvfuf3/8+vlS+GxQaPU1kTo/4oryseXzhg=;
 b=BYBs1tAqRfHtGpcpXhgWZpU1L9EsWJQ3hGpDnEfjAYt8JCPLsSTe6Mm2N5bBiyHeCmIDETTqVrwgXycp51Ip5OPlaxSZ4elt+GZEfaHqul4Kjm9kyMhwJXqJjxdJjFhPn0Rx2ZWlyJF0tdM8Ceda0g3MCjfzdqN22mdhPZCEyVP+3qTz9jAGmDg2axNbbi8JeFwDefqHL9XffcSm2/q+1RKn9xhRH0jbClt4NGrRQ7Sg9Sy2oDSVmNTPRrRciVYm+IwbaNSpdw6YaVSiKne3U4F1MY4WeI4iwPFJvKpMNUdsqlkyEmOfKo9RzEX+ccZ1i6dYuJMGDpT4kiyxUF2RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fym86PMynqvfuf3/8+vlS+GxQaPU1kTo/4oryseXzhg=;
 b=1gnD/eLWeaPfQVlA7k77QVA4ZgzyHsVBanmFY/pgLspasXxALHTzI/lO66NeCAOldKloHN/eVgtvbw7osNgPSE4Bgq90M/Lx1XtAMgaYJAGj0qa4Ew7pLVL1vMcv1yYrBhPUztxlO8f8r/6tAobFv+LOu9Z9Yyo9Y1yqgyYuEVY=
Received: from BY5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:1e0::32)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:40:52 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a8) by BY5PR03CA0022.outlook.office365.com
 (2603:10b6:a03:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 21:40:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:40:52 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:40:50 -0500
Message-ID: <a434e275-a558-4053-a474-b747c93ee9bb@amd.com>
Date: Wed, 23 Sep 2026 16:40:50 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 11/15] cxl: Validate and synchronize HDM ranges around
 reset
To: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-12-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0197c008-1827-47a1-4a1d-08df19bb5794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|6133799003|22082099003|18002099003|921020|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	5WuaJB7j57VyrEJ0HuPNYqjJSjPIoXS0cWS2L63u9UuYM8hdYljdNrgr4FxSkcXeOcPKhHvW/RA/Mdh2GhaEMbbKYk5AXCHn3k5/IIhTpQjgWc/rOmjgQSU7A6fA+et1dobjgCzN3CK7R7v3NZS6Y19eqJhfxlfJ8QiJB/yrzIMdFQx/vdjrRy9s47Dlhe5XAkLqpgkVWpDhlbq0GXAkEFqvVcLtKzL9MDzMuswv0F+8Bki9pidLOLFJnhmOly0XtjNj2loMOaJtWktyTFqU1v+R0rO6nSfO20tGWEQ6OxBY3HQ1VUgkuVZdhmJExYKBk41La7BblXsW4+JuwXojQrpPon+hR4UbhJlLjHzGMMFL14SVRcWzlEPVNuPj+PILS9c4Kv0IiEvHTrttUNnhLmQE8Y07ZvO1570gYn+fnsDrkgB7gP8AqodqVvbxHffNY4DSwovdRmFDG3BC20xfQhuqPhTPWM6rE0V25x1Yk3cucRAT6tuM8FIg8FIOUAcCBoR07NIodIYbne9/WBeRAilZmwbwthNZyZcB0vYom2LO3CZ3R/t6HO7VPHTTDst+tUeVcn8K33L4hksuQGJcyMccm50fI3YnTF45ZJls+YYIL024e4RHfEuRf6ij3IxLaH3OJS45wmL7onqBsrP5EMrYB4qIMUi91AKuw9aIVY+9tUceOUTJ5RfBjtW3UW7i11ByoekO108q5Y1hooaFiA2UH9CPpj+aY8Wtn2la9PACenQ85oiEIQAdjkNuJBZ5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m1XkVriABMnNznYjSJYHdWmJcPLOqGtGT1VMSQmQFBwt/GxP6wGqcfDoYUdRAov4Exa/dGsWqPA4tX5RvNwaZwdy2jUbEg6oN+iI78VVe7kPpypm4lnRn1znLh9+pfG2vcEpqSppie/2OoxFVY/bbiTccJKtfhoMz7TnZQKo5jTy8bAO9CLuTdw5jeD678h5AlaZKUB3lCNePu1hIfA8Uu/xIaoM4kF4oIn/8hY9G0DzF9FEumMdRoqCHX7Zb+792YhVx1NVsvSpYjdrlVteKAy5aTULECQ2SxVex67TXIBny+41hNPX6tCkfQVXM+qNAH6sPuY3aoEQItbbJAenD7ussaZXiOeazkLLGpYYpKIEVcvPP9md/W6LoEq7S/Mnd2/ilu1CIZ/thiUuI/Dozk6s2g2WNzbGFIuWvAiWhvVvM/JCs1QY4ZUwbSfns3Gq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:40:52.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0197c008-1827-47a1-4a1d-08df19bb5794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again after restoration, holding range reservations and IOMMU
> exclusion until the second invalidation completes.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 244 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 239 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 57eec77cbb21..85a554b6236c 100644
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
> @@ -437,6 +439,211 @@ static const u32 cxl_reset_timeout_ms[] = {
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

Maybe resource_contains() instead? I don't think there'll be any overlap, but no point in reserving
a fully contained resource. You'd have to add some extra logic to remove the smaller resource though.

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
> +		struct cxl_decoder_config *config = &info->settings[i].config;
> +
> +		if (!(config->flags & CXL_DECODER_F_ENABLE))
> +			continue;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!range_len(&config->hpa_range))
> +			continue;

Nit: these two if statements could be on a single line and just put the comment above it, it's pretty
obvious which condition the comment is talking about.

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
> +static int cxl_hdm_ranges_finish(struct cxl_hdm_range_context *ctx)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	rc = cxl_hdm_ranges_invalidate(ctx);
> +	cxl_hdm_range_context_destroy(ctx);
> +
> +	return rc;
> +}
> +
>  #define CXL_RESET_CTRL2_CMD_MASK \
>  	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>  
> @@ -560,24 +767,25 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  	}
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			     struct cxl_hdm_range_context *range_ctx)
>  {
>  	int rc, rc2;
>  
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
> -		goto out_enable_cache;
> +		goto out_destroy_ranges;
>  
>  	if (!pci_wait_for_pending_transaction(pdev)) {
>  		pci_err(pdev, "timed out waiting for pending transactions\n");
>  		rc = -ETIMEDOUT;
> -		goto out_enable_cache;
> +		goto out_destroy_ranges;
>  	}
>  
>  	rc = pci_dev_reset_iommu_prepare(pdev);
>  	if (rc) {
>  		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -		goto out_enable_cache;
> +		goto out_destroy_ranges;
>  	}
>  
>  	/* Clear Memory Clear again even if this command write reports failure. */
> @@ -597,7 +805,14 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  			rc2);
>  	rc = rc ?: rc2;
>  
> +	/* Evict lines fetched during reset before ending DMA exclusion. */
> +	rc2 = cxl_hdm_ranges_finish(range_ctx);
> +	rc = rc ?: rc2;
>  	pci_dev_reset_iommu_done(pdev);
> +	goto out_enable_cache;
> +
> +out_destroy_ranges:
> +	cxl_hdm_range_context_destroy(range_ctx);
>  

Same thing here as the last patch, but I'll let you do this one ;).

>  out_enable_cache:
>  	/*
> @@ -615,6 +830,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> +	struct cxl_hdm_range_context range_ctx;
>  	int dvsec, rc;
>  	u16 cap, ctrl;
>  
> @@ -646,5 +862,23 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
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
> +	INIT_LIST_HEAD(&range_ctx.ranges);
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		if (!rc)
> +			rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
> +		else
> +			cxl_hdm_range_context_destroy(&range_ctx);
> +	}

Probably better to just copy-paste the range context destroy call and re-order as:

		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
		if (rc) {
			cxl_hdm_range_context_destroy(&range_ctx);
			return rc;
		}


		rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
		cxl_hdm_range_context_destroy(&range_ctx);

instead.

> +
> +	return rc;
>  }

