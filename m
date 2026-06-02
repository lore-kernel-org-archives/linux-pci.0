Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F52370D5D;
	Tue,  2 Jun 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432462; cv=fail; b=bQ7n2QiExvR3d1VfMThqE04c3y/5dkfnCaC4fJ8YnoPIXQqKTPQq5K7B0NH8TLwSrfwidrR0hDv5g0asmlLfQVQeHJFKH3WAP3U6LkTU5YwpcCKJBBrHsl71G1jzAPBWRlwxJ25o2aL0j1L+Ev8L4xSkUBRCg/R9SuoHxf1sXaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432462; c=relaxed/simple;
	bh=za6puG3u/PqVlQRnGsMIlXrOvH2jgsLvjHASlsypZEE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=cbAGVVn+bCSlgnWpszZewD5PCzFuw/WxbqH/t4qM/pYpgRDhPKIu2sSpReuqeAOIOGPOXyYtahiFM+kwG+188nkuf33hWwPG8SNYyuc8fsMCM84RtlRI0k1TYhiQVCv1mOZ5IqTgqZ5fdeJEKonxnyHT9zQMmD6k17KB+LlJe5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgY7mUzj; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgY7mUzj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzNisYq0v75ZAlLl165wCThZVEUUrUa4IiQn9a7DDZVIgvQSZBQqHMHh0LE1NFZDb4gX8S5ws5bDlbQswG/+3/fmvh9njDDOd+T105JfjIQvH9XUbe2uGfs+IPvCqchBeJe45zdXca01bInc4CX384CmRjZUnRBCMMlOp2EVqCVD/ziQieUD1LJzC2Hw39qhIqRziQ6YfTxeTHJFnbyEGXJt/h1TKBaxc5fbdCm6lhvx3A/zKKPTJssGSEpmHHHUHARyRiLOOjdAVvnnp0QAk48Q+ngXhebIc0RHvoG1AsxJ83oR5z2TqFE4KV8zPBcSWHseA3iOL6AyzogmsE+Ing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77yHXNdW+GX3H8inYPcUYTLqH4ZpeldOs9kkJpwuWbI=;
 b=i/5knsTUcZncxsbyczBz6W6LD0PAzVTuaSAq2xMH48958aSEvMjrhJ3Qhv3JWVD/qZ92mJjRyDIPB/qI3wSdP6th6Gv/8eBexOg5uf0LEslcYn0lEDjZxrquNFahkX0XFClIpCLRuEyB+oBNXJMXfu7pMItKkyeLHAkgENDABB28yJvWfc+b25IpvkKLxeiKBFYYtg1HRv6QJYaJXJw1vQ033r6Oh9zPN8RdFQ/pY11jKQYgJr7fnHaX2v5pFdU5gwGYcKgF1HC0AjJIJaHy+z+HQhp/9LQIoxSKaVJt5mLN0OfOzsuJGFVyp83DsdQ0DmhQJotldurjS0vFYzjTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77yHXNdW+GX3H8inYPcUYTLqH4ZpeldOs9kkJpwuWbI=;
 b=EgY7mUzjrw2vrwlVcw4bnKrqfbCPNRjF1MChwEGCme/sZgzb9HoWdtfqXrCIXgD4PgoaWsNhuOuTUKNVyVw2ZdEdEX/2d+CQ3CFD07Bh4i8dxM6j0W2KewhG7hpY23dTEYwG9aETY/rmjMHkh7hYTSAmvxGYeib7+IdpS2x72K8=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 20:34:13 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::3f) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:13 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:12 -0500
Message-ID: <9aef1ffb-3273-456e-a59b-70939edfefb1@amd.com>
Date: Tue, 2 Jun 2026 15:34:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 3/9] cxl: Add reset-idle and cache flush helpers
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-4-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3549a1-d940-45ef-b676-08dec0e64f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|6133799003|3023799007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	03gAU3kAMYGoM5Gwfk9Y94Swkdpex8y3GtYPSFtZGmNDSEC5QD3oj53Pi9nDr3ujvyTZ8R1gYk39TzpMIC8h7J9aHnSPGSOV+qVqVSViM8d+Ug41XqjViVEpIm+6QehvRsDi7aUlyMG64NRLKTUN4sA26MlFLPTgSYcy8EKIaZT+tAGQrgr0ifeQJQwxcU71enGNUgqI22vwNA55IfVCwR5uqc6Uazv9PGAJFesRRBDZKnO44hLLMDWP9ErHcfC0El+US0mGsnEhLuWb34nSqJRJNKYqluyP1Y2qKEWat1TRmnoLK/Nd6V4s46Ai1QhI3/ssBD0VjxMzuGaXr+7+S0Hut7pCowFiIl1jvW+X/TRrmXlMYJUwhUSrr+yVlFkZUfPZQdya93Cw/ItrX5Fl7tD+tIFyhzp9eRUcYuD77qOu+0hfgNHrVuLfNueJuNT/5X1PIKrmH/PTAq+KdbBYptnJkA3xijkkr2Vect1PMgERZk4NNFQoEEIIBAmBzjy6jmWignMOs7UcfvncY21Fmv8bdNV50Ky1j0XTErVlyG29Kv1U6n+cBPjYD1TnE9PaoBa/TcjaUwOEL57n+D3LnWWPFKDePjU8X+NZOCL/H56ghvTEp9IaHeJxhsYQwouBj+5hWeIF3JRM6BB3MSyxtUwkaFdlKfC4Z1/F5hRxHHFmh21Cn7YKZmPuuKlSJeTUxvJh3EnJdc411viEGC7TJ4RTPXQp8NDLR9RmmT/UlGM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CrA1PREwegIx7F5BNEZpNozgxnPkYkz4m90WrWR+deZeInCMNTHg+JulItXJrVgvahQVr2YhqJK62b6WluvP1EpOwtdaQ9hWGzXipbrUMFAVuSAg8An9jmMXWzOsDrKfNJCRXhwJvJWBeLlz4CFURtLp99TK+c6oe+EO7b2M7HGjUKLgJVd0H2bSgtLo598LhGH8i430W+ggHdZaERcRT4gZA8cTz+RCSbjLsYzJ16omugqury17kgADzugTqamJYTKCQZmxflwly/AhRFu3x4ekye+iV0lXY429S42EmnVuxvaTIwEaEgRGbHouvY3/qWPC8WtUGPaeobHDXvq+p5TYuy5EqIpzulUXi+wr55oQEo00x532dVvkFZ+OLlnwK6+iHMQePAU13PDtOqSl3jTcp6j2hWTx+NjWhDZ/ENMtj3cnSpxgRekbRH1yL65T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:13.3410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3549a1-d940-45ef-b676-08dec0e64f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Add helpers to collect the CXL regions affected by a memdev reset,
> verify that those regions are idle, and invalidate CPU caches for the
> affected address ranges before reset.
> 
> A memdev can participate in an interleaved region through multiple
> endpoint decoders. Track affected regions in a temporary xarray so each
> region is checked and cache-invalidated once per reset operation.
> 
> These helpers prepare the CXL.mem data path for reset. The actual reset
> orchestration and decoder restore flow are added separately.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)

These changes should probably go into cxl/core/region.c. cxl/core/pci.c is more
for actually touching PCI registers/config as I understand it.
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..318744695f62 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,9 +4,11 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/xarray.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +928,171 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static int cxl_reset_system_ram_found(struct resource *res, void *data)
> +{
> +	return 1;
> +}

There's already a helper in cxl/core/region.c called is_system_ram() that does
this. I'd use that instead when you move these functions over.

> +
> +struct cxl_reset_region_context {
> +	struct xarray regions;
> +};
> +
> +static void __maybe_unused
> +cxl_reset_region_context_init(struct cxl_reset_region_context *ctx)
> +{
> +	xa_init(&ctx->regions);
> +}
> +
> +static void __maybe_unused
> +cxl_reset_region_context_destroy(struct cxl_reset_region_context *ctx)
> +{
> +	xa_destroy(&ctx->regions);
> +}
> +
> +static int cxl_reset_add_region(struct cxl_reset_region_context *ctx,
> +				struct cxl_region *cxlr)
> +{
> +	int rc;
> +
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	rc = xa_insert(&ctx->regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);

It may be easier to have the id as cxlr->id instead of (unsigned long)cxlr, but that
depends on how you're iterating later on.

> +
> +	/* A region may be referenced by multiple affected endpoint decoders. */
> +	return rc == -EBUSY ? 0 : rc;
> +}
> +
> +static int cxl_reset_collect_region(struct device *dev, void *data)
> +{
> +	struct cxl_reset_region_context *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	return cxl_reset_add_region(ctx, cxled->cxld.region);

It looks like cxl_reset_add_region() is only used here. I'd just do the internals
of it here and remove the function.
> +}
> +
> +static int __maybe_unused
> +cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
> +				 struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd || !cxlmd->cxlds)
> +		return -ENODEV;

Why check for cxlmd->cxlds here? It doesn't look like it's used in this path,
are you checking if the driver is attached?
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		return 0;
> +
> +	return device_for_each_child(&endpoint->dev, ctx,
> +				     cxl_reset_collect_region);
> +}
> +
> +static bool cxl_reset_region_has_system_ram(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	if (!p->res)
> +		return false;
> +
> +	rc = walk_iomem_res_desc(IORES_DESC_NONE,
> +				 IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				 p->res->start, p->res->end, NULL,
> +				 cxl_reset_system_ram_found);
> +
> +	return rc > 0;
> +}

This helper could also be used in cxl_region_probe() for ram regions,
see the switch case statement in that function. I don't know if it's
worth the churn though...

> +
> +static int cxl_reset_validate_region_idle(struct cxl_region *cxlr)
> +{
> +	struct resource *res = cxlr->params.res;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (cxl_reset_region_has_system_ram(cxlr)) {
> +		dev_err(&cxlr->dev,
> +			"Cannot reset while CXL memory is online as System RAM [%pr]\n",
> +			res);
> +		return -EBUSY;
> +	}
> +
> +	if (!device_trylock(&cxlr->dev))
> +		return -EAGAIN;

I think you can use ACQUIRE() here? I'm pretty sure it was made for this case and gets
rid of the device_unlock() below.

> +
> +	if (cxlr->dev.driver) {
> +		dev_err(&cxlr->dev,
> +			"Cannot reset while CXL region has an active driver\n");
> +		rc = -EBUSY;
> +	}
> +
> +	device_unlock(&cxlr->dev);
> +	return rc;
> +}
> +
> +static int __maybe_unused
> +cxl_reset_validate_regions_idle(struct cxl_reset_region_context *ctx)
> +{
> +	struct cxl_region *cxlr;
> +	unsigned long index;
> +	int rc;
> +
> +	xa_for_each(&ctx->regions, index, cxlr) {
> +		rc = cxl_reset_validate_region_idle(cxlr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
> +{
> +	struct resource *res = cxlr->params.res;
> +	int rc;
> +
> +	if (!res)
> +		return 0;
> +
> +	rc = cpu_cache_invalidate_memregion(res->start, resource_size(res));
> +	if (rc)
> +		dev_err(&cxlr->dev, "Failed to invalidate CPU cache [%pr]: %d\n",
> +			res, rc);
> +
> +	return rc;
> +}

There's already a helper in cxl/core/region.c, see cxl_region_invalidate_memregion().
You'd have to modify the function below to use it here though.

> +
> +static int __maybe_unused
> +cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
> +{
> +	struct cxl_region *cxlr;
> +	unsigned long index;
> +	int rc;
> +
> +	if (xa_empty(&ctx->regions))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +			pr_info_once(
> +				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> +			return 0;
> +		}
> +		pr_warn("Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
> +	}
> +
> +	xa_for_each(&ctx->regions, index, cxlr) {
> +		rc = cxl_reset_flush_region_cache(cxlr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

I see you've marked most of these functions with __maybe_unused and remove them in later on
in the series. It would be much better to move these definitions into the patches where they're
used throughout the whole series. Fortunately, it seems most of these can just be moved to
patch 7/9.
