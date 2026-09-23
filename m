Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88B39D3FC;
	Wed, 23 Sep 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199612; cv=fail; b=SV8d0k3u8AYPFUiXqmBFpAU1fjV3tjtfowPR6wiRieR3sahW9X3ZkVf7wU5RDLptmL4PHVFb8McnvzYMbv2H8Ibi6JyQG0YOU6FT5l/0JhKtwtWTC7J8e5p4GRQVYttOaOy3ItINyvo6HAnGBXqXg1/8HjnabLmzVN5smIdt+XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199612; c=relaxed/simple;
	bh=ddNf8PCeqhrPsH88lOlnGd4RFF2oRUGvEKsW1/2v0GM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=c3x/GfWJYebfNjezHKaIGfuLptlhJP9B45tKQEICUu9x3cjXUGDjLiLcqtaQNp44uZ27Bo9RJXtvHMuQtXmDW7DnZd2G8QTl2w4wlwTSs8ARZJ2hFZawuiWaLkZr8P5i0ddzvVMFSMefDYgECOUeT2aioQOgOsZqEOcuy/SvinI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T0ouoWmr; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T0ouoWmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8Qxsv8/0QmMkil7J9AUicPHQCOsJx54Uhx1BqPn9A6MKyu9N9zfYMDTwoER6jjLrQtFLX34LRqU0lfS/lLMs03V7Lb9m2ycGuTg1VNb+DuMR6+yKs7/QcFmNH+d3AneYCuHp8a2OKY31F2d6dtGoY3f25x4B3nyXglM5yIGyYRI9DkD8R3uZ8r0WgErzGvqqy9LDMPpVpVgw9Zas8aSHURyZyyedXl5lHpAjRSdV/Gx1xb4Lj5Pv4FUBGZV+gMS2WdS+KoqX/HBupO2QA/Sx2ffv6e9SsNiDBO/zpIJ88vf+M+8pOrDRi7Dw/CzwOoNQHxWOpx+XOgkscwZCNIOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CldYZ9/cFvpXAZ4rbPU4tTIiTtv0Ay8mmibCR3I9vDM=;
 b=UVnEKHcwACjkXjmbW0zI1Txw6vBsfhs30l5/J///taHCbtRSCdNC8CTZ8GFkSCFjTt8B2lpAOQ9GN8UZzoGY69wJCfp0Mc2Wq+B8JLw7h75w1X/SdfnWMR2bFp05NTaPA61RG5GvhDHqN03KdXLxNTakCpnLXQmxRyCKg4A6y5Il+yp5WnyBCpxXnjEK6kMrzwVJxJ1Fxwzqjce1vSpuCnYbLaxKJueQ1hs3ziLXvHSzA5GNYDg3Nrc5vGWszCZR+h9KRubvxj1jI+2DTIwvk0ppzd9WePTF+vT8kgjFTe10S6dIZ8a1szOtvUq1YCS2oq+4itIarW9yUNr/OcqUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CldYZ9/cFvpXAZ4rbPU4tTIiTtv0Ay8mmibCR3I9vDM=;
 b=T0ouoWmr+iOWll96P/8PzuokE3RS4Fi8lnbq9KIYx8JJ2MfB6M0tgvYr/v5k5ct3HlIa0Q/aju+ZR0B+HR3zSIlnb5P3neuIhvlKt6+DhB/nO90pUCnRBOHigYV+uDF9uDk8sVHzJGgeY8AhFBppQwsK0M9lWuo6ob/8vXZIPNU=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:39:59 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::ae) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:39:58 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:39:57 -0500
Message-ID: <389514f1-6e6c-42d7-a4a8-7bbb9032473f@amd.com>
Date: Wed, 23 Sep 2026 16:39:56 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
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
 <20260922083924.2451158-6-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 225bc2ff-5bdb-42f9-b9ec-08df19bb377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|921020|6133799003|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BVWJFql5dN9THBF2YBh0bEmHFnCxU1g1mtj02xsPzRt9X1KRupMxXzDSleeZVgTJI6REr9vI0oNwM4kCo8JCY8HsOg1h0e/A3yShKAOPmXJOIJYwQdW5PNjaINOyGC2aqk42vNqVHzKm25vhftPgFiv1JzMe/CUHqlm/MuqdWKt8f9sd9Ns+HNSvQmspFfZ5fRYWp8gRrWoD2trbEFl0NmFMGt814WujpBtmzqTWbE6NuB1VtsoD9PcYeUNPPJJRx9VKFVT9pevotyNTmbB0iwOxu+f2k/0bu08IUICEs0stfzQt+1wPBn2pvUK5QAH8NRWJX+iVKaZ9tBDmnMAbxLQnM4xTDqjvax48lGRIxE9N9KzPVeCs9nMRdYGEwZAuSBVvmCnaue96WwHUSOlLQiDs0q/fR8gAp3al1ftG1naVjaWnqvdqbGLZwhLI0kYfbjqIyFSZrngdedGLA6pzpb2ncCZVSRxwrz7VwktEgtt/V1eRYOclXXPyDO53zZRMZzGEQuYOOLKyAxOTQeZlVpSqnLW1cV3lO/BxP3zE9M2DOATQdI8q+4VFJwsKeuVSd5xqtvWdWBZymg9HdqLSqFRNe5T2/zRMq455YgCTO54fdYIy/PMUZl93s9wsuWp12fsDKut96QNNJddjvue0BjZFs/k3oiYx/IMQe51ESmjsfahlUVmxisinvL6q2n+5a4ggOFAum4L61JU0N1ra5xBy5KBflOk78d4W2aHJfdXzI4Spu1WINsear09Sm0O/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(921020)(6133799003)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Om3jhV0aSWcr9/dwjktXkgBB16Yl0afqjZjuMmemlzzJHbDWVMR7NPa8WEE9ttBWwHS8Hchwe/Q4H1Wjf+94JJ87/znvPnE3vlZXNcKB1aJAA9GUopgPiXPVTKOkBfuYDaBmrCYg37N0XetCTknYB5vq2MLOZO3P/MeDGy1dFkB8W8dNpKAcTCp2HQ2g9AyqhhLRSIm9EgPKe3/DwRDiLn977EAEMCOSKTWNeWIqHPydoFMBipMTNk8lqxkHdtJ9V9HCiPMGeA9krEjf9/PtOEoNzoUJl7yr4j6prCsNhipUNCkoVcCG73Q18yyyJmmTXEApvuXwQqgCog8ccyyrOBGHMcyC6Eoc6XBtbzm64EEY1g8GWfrLBfVXY6XqFtLSUa+s5bxwdkf11LvlmSGWtDLsr0xhmlAnFvlUPCDXad2+Ee8L6Slz5/ybx4tb2cu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:39:58.9267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225bc2ff-5bdb-42f9-b9ec-08df19bb377f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> Represent HDM programming state with struct cxl_decoder_settings and pass
> it to the commit helpers. Keep endpoint skip and switch targets at their
> call sites, place flags with the programming state, and leave runtime
> region ownership outside the snapshot.
> 
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/core.h     |  5 ++-
>  drivers/cxl/core/hdm.c      | 40 +++++++++++++++++++---
>  drivers/cxl/core/resource.c | 67 ++++++++++++++++++-------------------
>  include/cxl/cxl.h           | 27 +++++++++++----
>  4 files changed, 90 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 9c6d4b99f787..3444479cbade 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -139,9 +139,8 @@ struct cxl_rwsem {
>  
>  extern struct cxl_rwsem cxl_rwsem;
>  
> -int cxld_await_commit(void __iomem *hdm, int id);
> -void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt);
> -void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
> +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
> +int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
>  
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 008f04f0ca25..b3ddc02df65e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -702,7 +702,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> +static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
>  	int ways = cxlsd->cxld.interleave_ways;
> @@ -724,11 +724,41 @@ void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> +/*
> + * Endpoint skip and switch targets have different owners. Keep that state with
> + * its owning type and flatten it only into a transient register-programming
> + * snapshot.
> + */
> +static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
> +				 struct cxl_decoder_settings *settings)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	*settings = (struct cxl_decoder_settings) {
> +		.config = cxld->config,
> +	};
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +		u64 targets;
> +
> +		cxlsd_set_targets(cxlsd, &targets);
> +		settings->target_or_skip_reg_val = targets;
> +	} else {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		settings->target_or_skip_reg_val = cxled->skip;
> +	}
> +}
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_decoder_settings settings;
>  	int id = cxld->id, rc;
>  
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
> @@ -761,10 +791,12 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		}
>  	}
>  
> -	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -		setup_hw_decoder(cxld, hdm);
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		cxl_decoder_snapshot(cxld, &settings);
> +		cxl_commit_start(hdm, &settings);
> +	}
>  
> -	rc = cxld_await_commit(hdm, cxld->id);
> +	rc = cxl_commit_wait(hdm, &settings);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 68d40f745acc..ea0d855e5549 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -13,7 +13,7 @@ struct cxl_rwsem cxl_rwsem = {
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
> @@ -22,12 +22,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 * Input validation ensures these warns never fire, but otherwise
>  	 * suppress unititalized variable usage warnings.
>  	 */
> -	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
> -		      cxld->interleave_granularity))
> +		      config->interleave_granularity))
>  		return;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> @@ -35,10 +35,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }
>  
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> +static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
>  {
>  	u32p_replace_bits(ctrl,
> -			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>  }
>  
> @@ -48,7 +48,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>   * clock skew and other marginal behavior
>   */
>  #define COMMIT_TIMEOUT_MS 20
> -int cxld_await_commit(void __iomem *hdm, int id)
> +static int cxld_await_commit(void __iomem *hdm, int id)
>  {
>  	u32 ctrl;
>  	int i;
> @@ -68,43 +68,40 @@ int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> -void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +static void setup_hw_decoder(void __iomem *hdm,
> +			     struct cxl_decoder_settings *settings)
>  {
> -	int id = cxld->id;
> +	struct cxl_decoder_config *config = &settings->config;
> +	int id = config->id;
> +	u64 target_or_skip_reg_val;
>  	u64 base, size;
>  	u32 ctrl;
>  
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
> +	base = config->hpa_range.start;
> +	size = range_len(&config->hpa_range);
> +	target_or_skip_reg_val = settings->target_or_skip_reg_val;
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	/* Target-list and endpoint-skip registers alias the same slot. */
> +	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
>  
> -	if (is_switch_decoder(&cxld->dev)) {
> -		struct cxl_switch_decoder *cxlsd =
> -			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
> -
> -		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
>  
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> -	}
> +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
> +{
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	setup_hw_decoder(hdm, settings);
> +}
>  
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)

No reason to rename this. Either just use cxld_await_commit() directly, or just
change the signature of cxld_await_commit().

> +{
> +	return cxld_await_commit(hdm, settings->config.id);
>  }
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 69941f7fdb76..1acdf537e4e9 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,8 +42,8 @@ enum cxl_decoder_type {
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
>   * @flags: memory type capabilities and locking
> + * @region: currently assigned region for this decoder
>   * @target_map: cached copy of hardware port-id list, available at init
>   *              before all @dport objects have been instantiated. While
>   *              dport id is 8bit, CFMWS interleave targets are 32bits.
> @@ -52,18 +52,31 @@ enum cxl_decoder_type {
>  */
>  struct cxl_decoder {
>  	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> +
> +	struct_group_tagged(cxl_decoder_config, config,
> +		int id;
> +		struct range hpa_range;
> +		int interleave_ways;
> +		int interleave_granularity;
> +		enum cxl_decoder_type target_type;
> +		unsigned long flags;
> +	);
>  	struct cxl_region *region;
> -	unsigned long flags;
>  	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	int (*commit)(struct cxl_decoder *cxld);
>  	void (*reset)(struct cxl_decoder *cxld);
>  };
>  
> +/**
> + * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
> + * @config: common decoder configuration
> + * @target_or_skip_reg_val: switch target list or endpoint skip register value
> + */
> +struct cxl_decoder_settings {
> +	struct cxl_decoder_config config;
> +	u64 target_or_skip_reg_val;
> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.

