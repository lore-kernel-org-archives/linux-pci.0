Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD137883D;
	Tue,  2 Jun 2026 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432472; cv=fail; b=q90JvDuwJXXWOUIxAPC4s7JhjzbZ4XI+dJVNrYOZkS4+bEssHO0K2kw+yc7mQ7VgTMwTwMDcjfob6FAh3JoI66Xgm4UtiF9zjkZEJRkb4HPL37olXlT+PeHKydKQSuM9vEUmZzywWB6r6t1GWuqHWDv2lZLZtNpULOiTLFKkugo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432472; c=relaxed/simple;
	bh=ciuh4i4+IY/0LDarvBnB9kRjcrTDumG6GuVCbYIstNQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tMU89jlMnDM/eHwXusruMZ8t3mNjZ3lIbjWSrk9ZZtmf9Pqg25ICXoVju+ZRddzsE2jCRks1o2LcdTiCg/N4Fm9Nha+cJMv0mcMDGnAqe//liF4asECJBeCK1Wmo+/r7ogtX61xz4e0EVZNY4/eVrdpJaWby2Gy8tgYE9/rJ0e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NhEbIB8I; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NhEbIB8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd9RC8YwsqzxcPiXk26RwNX2O4BgxSKcCx3zpEtQz0NaTHcR403w31xo1/4Q0hdKRnsEOM56BtloSzIW9gyqOKerk/HaH//kcMPM6olgCL4dH3aqLAf1e+BWeWiQ4GvnOeXL8YWGbuiIAv+ctWGdouBD6e+DBTf02fzSmD0+mhCfKOsYhjx6JvtlVIxkasQPiQG/0FtVxO0SvZS9y/6FiIuci8Wi4T5co8z1ql8HDqhUMIggOVqhy9ub/OpLZjStjdi/NktL4neISZES2lC5xD2R1qNg5gBAZ/l4bv4enQIe8Hy9qZ6qtKrAZ+0A6uOvgD6H73FLbDrzUO/+hJ7hbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkkrUY0vpugaUWERsOEH2cMAFP0juY/q2d3IKDWY5eU=;
 b=Hr05qlOYlAOUgFycoWFsjV7ioOsgK7nSAm3bBUfv2M/xCv0uMrNTfyzPAPDPQUPOl/4HyGnOCEZQmU/i+InT2WjGm/718/w7GQbGnVuj9wiaG/fYHtXkBxfRSl7aBtSGDxUvH5hdbUQY9X80CX/ddoZfSbIc+29Mxv7Y81kYnbSQQVeCwMHN1oKoQm8+YN+pzzAvZbqSRRUzNUX7oyMko0JMo8nq5rX7BraMtGY+oRH/eHS8VaC/d6jS3BjGEZhVti993e0Tq6MDwHSD2w84j43MrH3wZvVNdf7XKOQzj8Ew/UYn3QgAUEbyPX07+Ih3KoxnBXvAmh+p9VXi73KP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkkrUY0vpugaUWERsOEH2cMAFP0juY/q2d3IKDWY5eU=;
 b=NhEbIB8IO1urDhbFaS5tc+KBoyDFEwQDPKjGtbVoN9d2Y3jg1BxzMlhSACsFLn0CH8JMO57pwZzBBqDyhChQC0FRAU409XeereXc4chBlp7dT552ALD4P092awaSBdI9cZJnDvmdYAKUZE8zhts/5lVxRb3/3yEYkT0bPIn1y6U=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 20:34:23 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a8) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:22 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:21 -0500
Message-ID: <0e295798-7e48-4235-b6bc-870634e74347@amd.com>
Date: Tue, 2 Jun 2026 15:34:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 6/9] cxl/pci: Track memdevs affected by CXL reset
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-7-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b19cfb9-0cd5-4308-5580-08dec0e65490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|1800799024|376014|13003099007|3023799007|6133799003|22082099003|11063799006|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	sS7GgMG7HYeL+sIDe27oGNh/7NXyKIKEpVF3kq3CxPkBVYNOolmhMOYf13EUNRy24TfO2TxPGABbsbIRj8S7Mg5tjEsn0JO+iRxtTxxBj9lUY7U5P3eu7egM0LU0rDHRw/oCMdukVNVtT3TGq3EQu0H51uoQr227Gngulg/dsL3+7V62v173ySFup4rQfJzST69eVABird04hg15HTjAomxZBUvB0abrPdOtgn9pEHM4YXSAhbIxAc5RvUTmHwiXYOt4kje9fJSQ9fOO0AiR73tvbIhUmVBGCTcCgt2An1GtM/uvDFyNH3bHiJH2E5jJjq+9voUkD2LuMLTLobyNW0bY1nwo2JkDD1LyJfskIWvKPNDOcsXTjbCteXj3KXJ1xAntoEgr4oNZ/BJiQ7s2V6lcNfHi1JUA4ahXpFdei5C+KgvnKnCJ3Ks8o7ZhpJ8FkObMCPK4pp4MtJLcPsw6YAz5YEHaKECPvrAKBO53cMSmG2mp5lHtsrNvIqYOc6VDZrOddudXn01nrngrJE6qf8ed16Sb7078Qp/8U0B+pFuB22uwfEBrmLOVeP/x12hev0njLLeOUX3O3sX17NR2EoVPzc8EQaiTSUEkHCDRae2aQGnf0N7t6mB4GCOUHvCb0PK5x8/OJvwqN88qy+RrJHeLkFMwj0/NORiYrW7WaXg+wNTC9Y8UPH1w4sUZ6Fnp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(1800799024)(376014)(13003099007)(3023799007)(6133799003)(22082099003)(11063799006)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DNCb6G/zN2P5JV7aTjTfPyu2jtfaQgLyiBesrEyjYk+BqCwAfroxsIwSaXYPUv4naM5U4XAoiM2Li8+7+/u5n/etZKXIa6DsXtioMKOcDCpVOCmG/ZXz9z435S3VyTp0zYapM2RhRRgajK3wEgLzYhWWH6VFp4/RNZgMvjYkszQa9pm/nbwSrsDm2WsA8Xtye2v7soXvRdlJHN6mcNSo8gRlhA3hkwRUNjS7JWU6AzBIoOJEgadJZztpIRCTxK2NOEnbijqrmp5xNPZB02qlyO/5zySk8cvN+FE8yZN7EQa3wfSgYAUHlOO0XuElEx8eLJHIGTY6T0otZPXS5LnLEl58f+hzSaeBzDU4/ET4TzDmRbB01+xPfCpRF/iKVmNMNrV/VmsXZCI+2zVjgfOjdUpMurTpclUG3C77sijTwNljz1prNGlTHvfQnCxscvh/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:22.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b19cfb9-0cd5-4308-5580-08dec0e65490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> CXL reset is scoped to the CXL.cache/mem function set, so reset
> orchestration needs to account for the target memdev and any affected
> sibling-function memdevs.

I would move this patch to be right after 4/9 since it's doing the back
half of finding the devices affected by reset.
> 
> Add reset context tracking for affected memdevs. Collect the memdevs
> associated with the target and sibling PCI functions, track which ones
> are active, collect their regions, and provide helpers to lock and
> revalidate the active memdevs before reset proceeds.
> 
> The reset orchestration and CXL.mem restore flow are added separately.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 176 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1dd880f5a333..c755c18c8d84 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1106,8 +1106,17 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
>  	return 0;
>  }
>  
> +struct cxl_reset_memdev {
> +	struct cxl_memdev *cxlmd;
> +	bool active;
> +	bool locked;
> +};
> +
>  struct cxl_reset_context {
>  	struct pci_dev *target;
> +	struct cxl_reset_memdev *memdevs;
> +	int nr_memdevs;
> +	int memdev_capacity;
>  	struct pci_dev **siblings;
>  	int nr_siblings;
>  	int sibling_capacity;
> @@ -1237,6 +1246,173 @@ static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
>  	return wctx.rc;
>  }
>  
> +static int cxl_reset_match_memdev_by_parent(struct device *dev,
> +					    const void *parent)
> +{
> +	return is_cxl_memdev(dev) && dev->parent == parent;
> +}
> +
> +static bool cxl_reset_memdev_active(struct cxl_memdev *cxlmd)
> +{
> +	return cxlmd->dev.driver && cxlmd->endpoint &&
> +	       !IS_ERR(cxlmd->endpoint);

You can replace the last two checks with !IS_ERR_OR_NULL(cxlmd->endpoint).
> +}
> +
> +static int cxl_reset_collect_pci_memdev(struct cxl_reset_context *ctx,
> +					struct pci_dev *pdev)
> +{
> +	struct cxl_reset_memdev *memdevs;
> +	struct cxl_memdev *cxlmd;
> +	struct device *dev;
> +	int capacity, i;
> +
> +	dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +			      cxl_reset_match_memdev_by_parent);
> +	if (!dev)
> +		return 0;
> +
> +	cxlmd = to_cxl_memdev(dev);
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		if (ctx->memdevs[i].cxlmd == cxlmd) {
> +			put_device(dev);
> +			return 0;
> +		}
> +	}
> +
> +	if (ctx->nr_memdevs < ctx->memdev_capacity)
> +		goto add;

The goto here isn't great, I'd just add the memdev inside the if statement
and return here.
> +
> +	capacity = ctx->memdev_capacity ? ctx->memdev_capacity * 2 :
> +		   CXL_RESET_SIBLINGS_INIT;
> +	memdevs = krealloc(ctx->memdevs, capacity * sizeof(*memdevs),
> +			   GFP_KERNEL);
> +	if (!memdevs) {
> +		put_device(dev);

Should you null out ctx->memdevs here? Is it possible it would have a stale value at this
point?
> +		return -ENOMEM;
> +	}
> +
> +	ctx->memdevs = memdevs;
> +	ctx->memdev_capacity = capacity;
> +
> +add:
> +	ctx->memdevs[ctx->nr_memdevs++] = (struct cxl_reset_memdev) {
> +		.cxlmd = cxlmd,
> +	};
> +	return 0;
> +}
> +
> +/*
> + * CXL Reset is device scoped for CXL.cache/mem. Use the affected PCI
> + * function set to find memdevs whose regions and endpoint decoder state must
> + * be handled around the reset.
> + */
> +static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	rc = cxl_reset_collect_pci_memdev(ctx, ctx->target);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ctx->nr_siblings; i++) {
> +		rc = cxl_reset_collect_pci_memdev(ctx, ctx->siblings[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused
> +cxl_reset_collect_regions(struct cxl_reset_context *ctx,
> +			  struct cxl_reset_region_context *region_ctx)
> +{
> +	int rc, i;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
> +		struct cxl_memdev *cxlmd = rmd->cxlmd;
> +
> +		if (!device_trylock(&cxlmd->dev))
> +			return -EAGAIN;

Use ACQUIRE() here.

> +
> +		if (cxl_reset_memdev_active(cxlmd)) {
> +			rc = cxl_reset_collect_memdev_regions(region_ctx,
> +							      cxlmd);
> +			if (!rc)
> +				rmd->active = true;
> +		} else {
> +			rc = 0;
> +		}
> +
> +		device_unlock(&cxlmd->dev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_reset_unlock_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = ctx->nr_memdevs - 1; i >= 0; i--) {
> +		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
> +
> +		if (!rmd->locked)
> +			continue;
> +
> +		device_unlock(&rmd->cxlmd->dev);
> +		rmd->locked = false;
> +	}
> +}
> +
> +static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++) {
> +		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
> +		struct cxl_memdev *cxlmd = rmd->cxlmd;
> +
> +		if (!rmd->active)
> +			continue;
> +
> +		if (!device_trylock(&cxlmd->dev))
> +			goto err;
> +
> +		rmd->locked = true;
> +		if (!cxl_reset_memdev_active(cxlmd)) {
> +			cxl_reset_unlock_memdevs(ctx);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	cxl_reset_unlock_memdevs(ctx);
> +	return -EAGAIN;
> +}
> +
> +static void __maybe_unused cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < ctx->nr_memdevs; i++)
> +		put_device(&ctx->memdevs[i].cxlmd->dev);
> +
> +	kfree(ctx->memdevs);
> +	ctx->memdevs = NULL;
> +	ctx->nr_memdevs = 0;
> +	ctx->memdev_capacity = 0;
> +}
> +
>  static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
>  {
>  	int i;

