Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31221379C43;
	Tue,  2 Jun 2026 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432488; cv=fail; b=St4a1gpIlRMYx4w5uEHTm/WQGdxoQpWm49sv2G0w0ke/T9jkSH1q1XT3X1RwKLn/cmH2vH/w4KgHc+JOv5onLJp3NUbP2AhlDeyW/8J+/ZEtNdohA2O+P1lYt9oU9gTCwkmMysLk4zv/M0JYJthUGJ1Qr7+612Ly+NZXq36H0sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432488; c=relaxed/simple;
	bh=c43n96BJ3NSwaBs635ODCtHr9YnySqkQoMoLlbzizGM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=V22LFirZcxD2gVRkCnjxZxZWkol/ti9nXZCgHQdTjjeIsuTTEFBEaN8g86cLQxtQSC784gLrS8lT9s9OvniOrlt/QgAHaBmd9owWXsPsLvL9dobbNg47Xm4R47qiqC4xZCa4SdwrZR7SseJUl2sbA5FiGIftXUhK4ApDgQ7hh9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6e2xOqE; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6e2xOqE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gljMjt8j8wvb2AQhY27Aj8fiDyjUqCI/4EJcTk89LHTzwTPZrAM+avUMPCRnrfme70l6SVw3qfkIToPqr5rsXabW7jY+N1k8CzbDS4avr1emk6et03vXjc3cOxwukGscFae1981D38TVypm6JKUWbx/Hu5y9wyb/iM0Vufe57+S/vsB8HEnIvhzPCw+vBu+YZ/Wh81AwV87QeWZfyDf+UO3YQrHRg29NCp+kCFwp5MyRcVEFrMKYrTIUbnack7/Ot0AKefk9pnoQJ8DEn7zRoXG9iL84HeezwM467t63rf3rFRLQVHsxdzSqpMMxFbdPGC47k8CiDc1sJwbDrecfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snZuOkr3qDSG4f3/u+MwdmeLDc70r/8uumxsnjs4d5o=;
 b=s1KDLDS04U8hnT3Quu1xcy0xCx3dhctYvZkd1vmaZw79nID6ttSr3Mx2TeFQRwXsjKxLShOl5FGp2CQwXvJtiC0wJ5sfeAArUDHUQ93eEjcTjQBxv8eJcrF/4AcQ1OJvMy2uP/E/7yTvDV45Iz1S4fHy7Enh9296yHpX2Jj7aWiRc7zr/Si+b+ONfE56OTznXGdeqkB97DoQtat2QJN5mHW/yR6LmeJBUSVDg9lwxFl8ZFyIhe2Wt+FjKC4V10MBb9PyGzPQEHT7NloDSFSO6dlTjus5OGeJKojRG4jhHr/U3sTNKpniP0ofFe0aXTVhBqJJqJOgjEbH8pZwtOsRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snZuOkr3qDSG4f3/u+MwdmeLDc70r/8uumxsnjs4d5o=;
 b=F6e2xOqE7UNc9dB2UL8VjmP4/gt9uDvkXQBgzSwmugvTuPArGhn/b2zwrkveWrOGkORHmvOtvPDAaBHweG0ZgDqCj6sCeJ5cawlDS+KdTxCdEqQR9ICedoIucb47VoSVQstZqZKaxc82gE3bMqO+llJJ31CSZ/iQuMLzPGKwZBM=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by LVUPR12MB999184.namprd12.prod.outlook.com (2603:10b6:408:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 2 Jun
 2026 20:34:26 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 20:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:26 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:25 -0500
Message-ID: <4b0bf44b-0bc5-48f0-a218-f78c6d26aa0e@amd.com>
Date: Tue, 2 Jun 2026 15:34:25 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 7/9] cxl/pci: Orchestrate CXL reset for affected
 memdevs
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-8-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|LVUPR12MB999184:EE_
X-MS-Office365-Filtering-Correlation-Id: 004f1362-5c37-43d6-2d4c-08dec0e656ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|56012099006|4143699003|6133799003|5023799004|18002099003|11063799006|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Tyf0TRwG59AslGfdxopcSeYO0FDf3U0mqxTjaczzFWNL+Y5fOKUHhDxtChEOoMTw3DZrunk934Iy42tWd8EX/ElsBVp4Zd/JpEzXjjTJ/F43QJ4tTZTP2YdsgwXUykOxF6KOiM6CcsYBPZeUHAHUQvYKHSs/cZXdskqF2RfUpLV/idKYa8UbRIKZPlrAFBsmXkYcZEmPhqNzcpOQp2IT+ibTOiTsXBvunFNBKx3j6AmhFDBCpCpzJqbz7DU3fA4v2jmbGa6owlkzPXzl/OwzQ8hnrEOGckrL/Vwo+2SgjWoy3iUTeCWloAynoUd6KkPTfHclV/AViKHc+2HJ6Vo4Q4HB8OGou0IomT/dM9s6zqJ/E+ayEICI89SjoV/Ft1ATgb9iyd9AoQLV+7bR7uyJmQDKat19MobvvTLsKGmlsUdtXqvEviqFWpvyI0Z6dLQXtRsIh+MlRDSQmwSHzbWOo627ogHvti+KOph4QfE6iN8u6i+hJaKAy1KxAghfgrTZBCnIL1HYg2Mp48UqXGAwB9AlrXN7eGVE9YwyO+aqprrcj8sw6AnytWU646ZTWMTBi/8UoIitZEnpifHOa1TXL0vLdkaRAlGikyg7P6RU0jlI5Mntqih8SsdjKpVaXWm1b9c2YX4ZbQuzFOZBdGMgoV4PvOJpE645Y5YpsX8TCO43hhSn/pAyZzkhDF7aLFVG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(56012099006)(4143699003)(6133799003)(5023799004)(18002099003)(11063799006)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IddkKD8TlcEWR8CRm1rLGxpB3fO5wmS4ztc5IN2YL4//HENa+xjtcyJ/wMrWLkbJq2U/xtSlrkzgTb9pJ5Y9gBJznUXyjgfjwKwm8FT8XB4PKF6esHuKTG7DED3ITuXK122Q8gGRbdB2ryuq+1zeCFQ/BWFaXQ48aligo4q1x/c2aClxb5WU+z89sDlEoibrF/uT3KiGpubt5WnAAWY0Z6bbN9sky8dfviv/H6Oby4Ltd1630jXaG1Jc+5Qi37ID3hEbYADXgEv43XaycYsIKuYlUiT5TDCQSsm2afwLDKFdA5RNbDcSgGiUw+pw9NgAimmcolrqsNtbmgS61ukrtjDgdRLkZyl+UCkDrZS4Yy4zgpTOgYsD7WBGQBK/M/d6028rjo82tO202hWxuHgi4Ql6Lv3rHo8Vn9WpDuO8aRp4EqVMDL1d3aUQEC+K/xVO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:26.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004f1362-5c37-43d6-2d4c-08dec0e656ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999184

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Add the reset flow that coordinates the target function, affected CXL
> sibling functions, and any active memdevs in the CXL.cache/mem reset
> scope.
> 
> The flow collects regions for the affected memdevs under
> cxl_rwsem.region, verifies that those regions are idle, flushes CPU
> caches for the affected ranges, saves and disables the target and sibling
> PCI functions, and locks active memdevs to revalidate that their
> endpoints are still present before reset.
> 
> After the CXL DVSEC reset completes, restore PCI config space so CXL
> MMIO is accessible, restore decoder programming for all active affected
> memdevs, commit their restored decoders, and only then re-enable CXL.mem
> for the affected set.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 414 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 358 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c755c18c8d84..486c447e98f3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -947,14 +947,12 @@ struct cxl_reset_region_context {
>  	struct xarray regions;
>  };
>  
> -static void __maybe_unused
> -cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
> +static void cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
>  {
>  	xa_init(&ctx->regions);
>  }
>  
> -static void __maybe_unused
> -cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
> +static void cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
>  {
>  	xa_destroy(&ctx->regions);
>  }
> @@ -985,9 +983,8 @@ static int cxl_reset_collect_region(struct device *dev, void *data)
>  	return cxl_reset_add_region(ctx, cxled->cxld.region);
>  }
>  
> -static int __maybe_unused
> -cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
> -				 struct cxl_memdev *cxlmd)
> +static int cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
> +					    struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_port *endpoint;
>  
> @@ -1045,8 +1042,7 @@ static int cxl_reset_validate_region_idle(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int __maybe_unused
> -cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
> +static int cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
>  {
>  	struct cxl_region *cxlr;
>  	unsigned long index;
> @@ -1077,26 +1073,41 @@ static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
>  	return rc;
>  }

Move the helpers from patch 3/9 to this patch; having to remove a bunch of __maybe_unused
annotations creates a lot of needless churn.
>  
> -static int __maybe_unused
> -cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
> +static int cxl_reset_cpu_cache_flush_preflight(struct cxl_reset_region_context *ctx,
> +					       bool *skip)
>  {
> -	struct cxl_region *cxlr;
> -	unsigned long index;
> -	int rc;
> +	if (skip)
> +		*skip = false;
>  
>  	if (xa_empty(&ctx->regions))
>  		return 0;
>  
> -	if (!cpu_cache_has_invalidate_memregion()) {
> -		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			pr_info_once(
> -				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> -			return 0;
> -		}
> -		pr_warn("Failed to synchronize CPU cache state\n");
> -		return -ENXIO;
> +	if (cpu_cache_has_invalidate_memregion())
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +		pr_info_once(
> +			"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> +		if (skip)
> +			*skip = true;
> +		return 0;
>  	}
>  
> +	pr_warn("Failed to synchronize CPU cache state\n");
> +	return -ENXIO;
> +}

And I'd remove the cxl_reset_flush_cpu_caches() definition from 3/9 and just replace it
with this to begin with. It doesn't really make sense to add a bunch of code that isn't
used just to replace it later.

I'll stop commenting on it now, but I'd take another look at how to get the helper
functions into the same patch that uses them.
> +
> +static int cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
> +{
> +	struct cxl_region *cxlr;
> +	unsigned long index;
> +	bool skip;
> +	int rc;
> +
> +	rc = cxl_reset_cpu_cache_flush_preflight(ctx, &skip);
> +	if (rc || skip)
> +		return rc;
> +
>  	xa_for_each(&ctx->regions, index, cxlr) {
>  		rc = cxl_reset_flush_region_cache(cxlr);
>  		if (rc)
> @@ -1120,7 +1131,11 @@ struct cxl_reset_context {
>  	struct pci_dev **siblings;
>  	int nr_siblings;
>  	int sibling_capacity;
> +	int nr_siblings_locked;
>  	int nr_siblings_prepared;
> +	bool target_locked;
> +	bool target_saved;
> +	bool target_iommu_prepared;
>  };
>  
>  struct cxl_reset_walk_ctx {
> @@ -1306,7 +1321,7 @@ static int cxl_reset_collect_pci_memdev(struct cxl_reset_context *ctx,
>   * function set to find memdevs whose regions and endpoint decoder state must
>   * be handled around the reset.
>   */
> -static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
> +static int cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
>  {
>  	int rc, i;
>  
> @@ -1323,7 +1338,7 @@ static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ct
>  	return 0;
>  }
>  
> -static int __maybe_unused
> +static int
>  cxl_reset_collect_regions(struct cxl_reset_context *ctx,
>  			  struct cxl_reset_region_context *region_ctx)
>  {
> @@ -1370,7 +1385,7 @@ static void cxl_reset_unlock_memdevs(struct cxl_reset_context *ctx)
>  	}
>  }
>  
> -static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
> +static int cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
>  {
>  	int i;
>  
> @@ -1400,7 +1415,7 @@ static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
>  	return -EAGAIN;
>  }
>  
> -static void __maybe_unused cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
> +static void cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
>  {
>  	int i;
>  
> @@ -1417,14 +1432,20 @@ static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
>  {
>  	int i;
>  
> +	/*
> +	 * Config state was restored early for CXL MMIO access. Complete PCI
> +	 * reset recovery here by unblocking IOMMU and running reset_done().
> +	 */
>  	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--) {
>  		struct pci_dev *sibling = ctx->siblings[i];
>  
>  		pci_dev_reset_iommu_done(sibling);
>  		pci_dev_restore(sibling);
> -		pci_dev_unlock(sibling);
>  	}
>  
> +	for (i = ctx->nr_siblings_locked - 1; i >= 0; i--)
> +		pci_dev_unlock(ctx->siblings[i]);
> +
>  	for (i = 0; i < ctx->nr_siblings; i++)
>  		pci_dev_put(ctx->siblings[i]);
>  
> @@ -1432,31 +1453,39 @@ static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
>  	ctx->siblings = NULL;
>  	ctx->nr_siblings = 0;
>  	ctx->sibling_capacity = 0;
> +	ctx->nr_siblings_locked = 0;
>  	ctx->nr_siblings_prepared = 0;
>  }
>  
> -static int __maybe_unused
> -cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +static int cxl_pci_functions_lock(struct cxl_reset_context *ctx)
>  {
> -	int rc, i;
> -
> -	ctx->siblings = NULL;
> -	ctx->nr_siblings = 0;
> -	ctx->sibling_capacity = 0;
> -	ctx->nr_siblings_prepared = 0;
> +	int i;
>  
> -	rc = cxl_reset_collect_siblings(ctx);
> -	if (rc)
> -		goto err;
> +	ctx->nr_siblings_locked = 0;
>  
>  	for (i = 0; i < ctx->nr_siblings; i++) {
>  		struct pci_dev *sibling = ctx->siblings[i];
>  
>  		if (!pci_dev_trylock(sibling)) {
> -			rc = -EAGAIN;
> -			goto err;
> +			cxl_pci_functions_reset_done(ctx);
> +			return -EAGAIN;
>  		}
>  
> +		ctx->nr_siblings_locked++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	ctx->nr_siblings_prepared = 0;
> +
> +	for (i = 0; i < ctx->nr_siblings_locked; i++) {
> +		struct pci_dev *sibling = ctx->siblings[i];
> +
>  		pci_dev_save_and_disable(sibling);
>  		rc = pci_dev_reset_iommu_prepare(sibling);
>  		if (rc) {
> @@ -1469,7 +1498,6 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  			 * nr_siblings_prepared and must not get iommu_done().
>  			 */
>  			pci_dev_restore(sibling);
> -			pci_dev_unlock(sibling);
>  			goto err;
>  		}
>  
> @@ -1483,6 +1511,79 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  	return rc;
>  }
>  
> +/*
> + * Restore PCI config space after reset so CXL MMIO is accessible for memdev
> + * restore. Driver reset_done callbacks remain deferred to final cleanup.
> + */
> +static void cxl_pci_functions_restore_state(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--)
> +		pci_restore_state(ctx->siblings[i]);
> +}
> +
> +static int cxl_pci_target_lock(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +
> +	if (!pci_dev_trylock(pdev))
> +		return -EAGAIN;
> +
> +	ctx->target_locked = true;
> +	return 0;
> +}
> +
> +static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +	int rc;
> +
> +	/* Disable first to stop new transactions, then drain in-flight ones. */
> +	pci_dev_save_and_disable(pdev);
> +	ctx->target_saved = true;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	ctx->target_iommu_prepared = true;
> +	return 0;
> +}
> +
> +static void cxl_pci_target_restore_state(struct cxl_reset_context *ctx)
> +{
> +	if (ctx->target_saved)
> +		pci_restore_state(ctx->target);
> +}
> +
> +static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
> +{
> +	if (ctx->target_iommu_prepared) {
> +		pci_dev_reset_iommu_done(ctx->target);
> +		ctx->target_iommu_prepared = false;
> +	}
> +
> +	/*
> +	 * cxl_pci_target_restore_state() restores config space before memdev
> +	 * restore. Complete PCI reset recovery here with reset_done().
> +	 */
> +	if (ctx->target_saved) {
> +		pci_dev_restore(ctx->target);
> +		ctx->target_saved = false;
> +	}
> +
> +	if (ctx->target_locked) {
> +		pci_dev_unlock(ctx->target);
> +		ctx->target_locked = false;
> +	}
> +}
> +
>  static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
>  				  u16 clear)
>  {
> @@ -1599,7 +1700,7 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  	return 0;
>  }
>  
> -static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
> +static int cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
>  {
>  	int dvsec, rc;
>  	u16 ctrl2_clear = 0;
> @@ -1620,19 +1721,9 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
>  	if (mem_clear && !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>  		return -EOPNOTSUPP;
>  
> -	if (!pci_wait_for_pending_transaction(pdev))
> -		pci_err(pdev, "timed out waiting for pending transactions\n");
> -
> -	rc = pci_dev_reset_iommu_prepare(pdev);
> -	if (rc) {
> -		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n",
> -			rc);
> -		return rc;
> -	}
> -
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
> -		goto out_iommu;
> +		return rc;
>  	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
>  		ctrl2_clear |= PCI_DVSEC_CXL_DISABLE_CACHING;
>  
> @@ -1651,7 +1742,7 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
>  
>  	rc = cxl_reset_wait_done(pdev, dvsec, cap);
>  	if (rc)
> -		goto out_iommu;
> +		return rc;
>  
>  	rc = cxl_reset_update_ctrl2(pdev, dvsec, 0,
>  				    PCI_DVSEC_CXL_DISABLE_CACHING);
> @@ -1660,7 +1751,218 @@ static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
>  	if (rc && ctrl2_clear)
>  		cxl_reset_update_ctrl2(pdev, dvsec, 0, ctrl2_clear);
>  
> -out_iommu:
> -	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +static int cxl_reset_restore_memdev(struct cxl_reset_memdev *rmd)
> +{
> +	struct cxl_memdev *cxlmd = rmd->cxlmd;
> +	int rc;
> +
> +	if (!rmd->active)
> +		return 0;
> +
> +	rc = cxl_restore_memdev_decoders(cxlmd);
> +	if (rc)
> +		dev_err(&cxlmd->dev,
> +			"Failed to restore CXL.mem decoders after reset: %d\n",
> +			rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_commit_memdev(struct cxl_reset_memdev *rmd)
> +{
> +	struct cxl_memdev *cxlmd = rmd->cxlmd;
> +	int rc;
> +
> +	if (!rmd->active)
> +		return 0;
> +
> +	rc = cxl_commit_memdev_decoders(cxlmd);
> +	if (rc)
> +		dev_err(&cxlmd->dev,
> +			"Failed to commit CXL.mem decoders after reset: %d\n",
> +			rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_enable_memdev(struct cxl_reset_memdev *rmd)
> +{
> +	struct cxl_memdev *cxlmd = rmd->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	int rc;
> +
> +	if (!rmd->active)
> +		return 0;
> +
> +	cxlds->media_ready = false;
> +
> +	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
> +	if (rc < 0) {
> +		dev_err(&cxlmd->dev,
> +			"Failed to enable CXL.mem after reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_await_media_ready(cxlds);
> +	if (rc) {
> +		dev_err(&cxlmd->dev,
> +			"Media not active after CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +	cxlds->media_ready = true;


You need to verify the memdev has mailbox support before messing around with media_ready, type 2 devices
aren't required to have mailbox support.

> +
> +	return 0;
> +}
> +
> +static void cxl_reset_disable_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	for (i = ctx->nr_memdevs - 1; i >= 0; i--) {
> +		struct cxl_memdev *cxlmd = ctx->memdevs[i].cxlmd;
> +
> +		if (!ctx->memdevs[i].active)
> +			continue;
> +
> +		rc = cxl_set_mem_enable(cxlmd->cxlds, 0);
> +		if (rc < 0)
> +			dev_err(&cxlmd->dev,
> +				"Failed to disable CXL.mem after reset restore failure; device state may be inconsistent: %d\n",
> +				rc);
> +	}
> +}
> +
> +static int cxl_reset_restore_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int rc;
> +	int i;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		rc = cxl_reset_restore_memdev(&ctx->memdevs[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		rc = cxl_reset_commit_memdev(&ctx->memdevs[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		rc = cxl_reset_enable_memdev(&ctx->memdevs[i]);
> +		if (rc) {
> +			cxl_reset_disable_memdevs(ctx);
> +			return rc;
> +		}
> +	}

Do you need to walk back the committed memdevs if you fail to enable them?
I don't think it's an issue if any of them fail to commit, but I'm more
wary when it comes to enabling them.
> +
> +	return 0;
> +}
> +
> +static void cxl_reset_context_destroy(struct cxl_reset_context *ctx)
> +{
> +	/*
> +	 * LIFO unwind for regular completion and partial initialization:
> +	 * memdevs, sibling functions, target function, then references.
> +	 * Each cleanup helper tolerates being called after its state was
> +	 * already released on an earlier error path.
> +	 */
> +	cxl_reset_unlock_memdevs(ctx);
> +	cxl_pci_functions_reset_done(ctx);
> +	cxl_pci_target_reset_done(ctx);
> +	cxl_reset_put_memdevs(ctx);
> +}
> +
> +static int cxl_do_reset_locked(struct cxl_reset_context *ctx, bool mem_clear)
> +{
> +	struct cxl_reset_region_context region_ctx;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	cxl_reset_region_context_init(&region_ctx);
> +
> +	rc = cxl_reset_collect_regions(ctx, &region_ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_pci_target_lock(ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_pci_functions_lock(ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_lock_memdevs(ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_cpu_cache_flush_preflight(&region_ctx, NULL);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_validate_regions_idle(&region_ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_flush_cpu_caches(&region_ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_pci_target_reset_prepare(ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_pci_functions_reset_prepare(ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_dev_reset(ctx->target, mem_clear);
> +
> +	cxl_pci_target_restore_state(ctx);
> +	cxl_pci_functions_restore_state(ctx);
> +
> +	if (!rc)
> +		rc = cxl_reset_restore_memdevs(ctx);
> +
> +	cxl_reset_unlock_memdevs(ctx);
> +
> +out:
> +	cxl_reset_region_context_destroy(&region_ctx);
> +	return rc;
> +}
> +
> +static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
> +{
> +	struct cxl_reset_context ctx = {
> +		.target = pdev,
> +	};
> +	int rc;
> +
> +	/*
> +	 * Snapshot the CXL r3.2 9.7 device reset scope before taking

Update to latest revision. I think I mentioned 4.0 earlier, it may be at 4.1 at this point...

> +	 * cxl_rwsem.region. Hot-added functions after this point are not
> +	 * coordinated by this reset operation.
> +	 */
> +	rc = cxl_reset_collect_siblings(&ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_collect_memdevs(&ctx);
> +	if (rc)
> +		goto out;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		rc = cxl_do_reset_locked(&ctx, mem_clear);
> +
> +out:
> +	cxl_reset_context_destroy(&ctx);
>  	return rc;
>  }

