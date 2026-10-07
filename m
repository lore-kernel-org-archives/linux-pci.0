Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C74D5969;
	Wed,  7 Oct 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402264; cv=fail; b=WV91ygiWYWIh2tGlpJPO91YnoN1yg/WBTUnZ1rWDNj8kJGivEI8on+wcppHZU+pLFtYV0Q1Cxyv7/5j+HJSN2sLj2xcCIZaoucXBahtECcY0QGlX9vHMN/d5oQTD98XwcsSGolBidboW5rMWutZgtA950dkLjrS31k0wACkHBEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402264; c=relaxed/simple;
	bh=Cyc+l2k8G5voLzKzer5eRC3grK9RqbNlHTAC/kUc9YU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pKDj2Qr5jZfRna0J2nnv/YcSs5tGq5O4t5k6J3EY/1FP80gATwlmQYHI4kLd+X8cQs1GkUJz/qsFPJMlJp79Shxs646vOFfDLlS3tSB0aGAWj5v35aQxhwxEfTWk0wTaangwTlb4pgdT6P6Lyxs27ipnuFuYmhghsXiDg8T3y+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJLOEiBA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJLOEiBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791402262; x=1822938262;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cyc+l2k8G5voLzKzer5eRC3grK9RqbNlHTAC/kUc9YU=;
  b=hJLOEiBANUzgcWolwmptdTIvChZhQq3l5eqeusx9ZEj7LNkYgUBBvsvI
   5tkVTeYOsabRctQeZUKhxJQtnQNvcmxIa8kQkPAN+DI+bkfx+5gAHsirK
   HEH1ndErw4GQSn+dl8Qyhb6KEeNby5yHaNj/+2aYzclmAq1va3bNpfwMa
   H1VXrNGSQ8673MorL+1BnjKgqBvHblqetelxirTP4c1Y0Ed01ei0sOwJa
   QysEsiHdEBrJ2x9YocJtrBkdPl8Zt5kEs1lH4ty0nYapqQDKROaKk4jKu
   Z/k9bv+BnqkzT8eZvRTwNMtJANi2O/6MRiaZ9i876lme5XAKtmjgL0x/U
   Q==;
X-CSE-ConnectionGUID: omaJpwH2QZO+ai8EfDe6AQ==
X-CSE-MsgGUID: Xn7NkMmvSjKlSAqgnnZENw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="76230"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="76230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:44:21 -0700
X-CSE-ConnectionGUID: 7KiaScl3QuyQSdgE5Vvsfg==
X-CSE-MsgGUID: cFZsQbl1Qlmsx3v5gXPuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="315562153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:44:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:44:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 12:44:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s95m2sDGV697wZW7cHJS395xit62e1cxTuCxHp2jlMjeYGPm0p014ea8ZtUsypd3ZOiVaEcrnCA0lSsSIJcMxsdszQxxoDZBaFhlPCu5qlqzYEu77qEC/pVStHNmlEYpr8+H/ANWUFUEVS/DBbQ7/KOpf+uN5MqoztP9q6btjbHXRxjUQoH1Xrtki4L8T1RT93eWUZ6cdaNCJoMQvyk1urIZ/fIS17MXYqGmX9f6LSZ8KMrPo7mZVgOfqk2aloG3kIrYLB3Ig5MyT88qPtS0S9AbTMd3oXSZBRtZLwCL0z/pZj4vgS63NzdVVetQ7kipmZKRaMSBLbRl7toPHQ9MJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BGqMZNa6EB5hcHg4aBxn26pjq5tcW1n5DtNk9qYtYc=;
 b=uXOsPPtMI2P6Jc1E1QQXWjqVGipmV0JJvVGT3QKIodGvGafUXTAFHCwdmyZXm/BHkCqutDIeQXF/BwjL/dLn1n1UITPkQxGd0mu1I3UmfaSd4zVrjNJq/rDN3EFgJ+kBJKjsowDJXpENtjBBQ91KUkPPS4XIgJVnfrS1j9vicFEL4bD/ajv6TSBy3tduYkRC9rk/NhulD10A+8Ypcuc56NZSRNepHSLTfG4OYhCgFEsV9OkMd5jrrXlNXYMznhg87+6ei9aH9zNLYfNtFXI1pqJcn6+suiU5E9BmGNrZ/H2DGaqLqWcr9cFhnFV/mNNMtzsAliYuottJm5i6Nfco+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 19:44:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:44:10 +0000
Date: Wed, 7 Oct 2026 12:44:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v14 12/16] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <asahBXXTexAWCMvC@aschofie-mobl2.lan>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-13-smadhavan@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 0892215d-edd2-4b14-4000-08df24ab5b38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: GKTPnSrftLAK2vJFD8JWOHA8E3bH+l9p+oYexRStDCuaQd9WUQnIztZ9hxfnBG0gun79JUqeWRNzmaXeq4myD27D/yX/gk0ScM/ti8vCA0DIb5TPjynj1oSjQIPR4BK4XgD4JW7lboQKJYvJeyO/uVIQEtccgpDe73QXijKDyL3ETSmHJI0/XE9jytHe9BRa0pwOPXglROw+CaeL5vx3Kf7RWILpDQUDx5HHXOL2wUpsy2zhuoILSkEfdp6ime8bohJsphRnnolnD7AcRKoWdc8J+/yxp1bghtxyyELQnbuzLkLPd/zmeVnaxDxHW4yiCihrSF6uVDg0fsd2yL18FxsDvrkkKweflFs9GxBrlRIiK+ou9F5UqbGWquycsxzQ6Q5PR+FvTMsViCbNYp6oAo7qWofgOv5YOxD/YAMAEAiifmv1ed87PtgKUt98kgrlduU0NN91v7KlLhQp0i8cREruE2e9WoJLc4lkZnaeQdrt9yzU78mGQI6NUxj+4BkGCui4i1wDkt9GkJJytM97B56S+uPTm+aW/oj/5oZAn863R5HIqDXn0qkRy9ICBF9gz5d0Aa2FJf6OtAIIkRjRFwx+eJ3jNMDDKoex6zaPeaWJsmSAAx7RmsC43VVox5fkasSJCO7sUrR1Ph/vVzBUBt8jOXGBJefRmlvx73Ua2OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Do+6rRHjJqYGe7YyiV9XPq+iDkFBs8vnqFX98AeTOWJCeO7R1EO+Gq0JBObr?=
 =?us-ascii?Q?SusbEmvcUPSGzDU7tZgSrdk/rQeZDlb+16RMkdPs26r8QWmL11S7jmv7Quol?=
 =?us-ascii?Q?WSRf6nPLFaMAJ9owOnlAf5O7cGrX56GaUCAkIs+ZbEEjA9ePjRDNEs5uOOLT?=
 =?us-ascii?Q?+6yhITaiZlki0IDMOAwLPNTyeMXcOgpTboElHd/J2LEL74LlNRBrt0nU4Rux?=
 =?us-ascii?Q?avKrGHuUKkvJCRVJbLJMHAykrVwgDysXjaFaa9Wi6hZ6McthjBAIPl3L5hpX?=
 =?us-ascii?Q?3MWgZJ1oqEq7h/VX1aQwv6QXLBH6d9TMg4E5yZQRtImVymae7eG9dHohL75u?=
 =?us-ascii?Q?Ff4Q3s+WGFgyFpzsNA66nzwl6v/MhnLou8wnQBAg1+yO+O7TeW/+M9vijM3W?=
 =?us-ascii?Q?I5G8VP6FpIGjkF1AMOCeO2SxtYMTpNFVuTuuFdaYr594SFZXjrYDzJvocv/D?=
 =?us-ascii?Q?IEpnJbHP0TF50EQLb7TpNn33tLNQEM1ZwUo1u/G4evDQB8xeAg6UKl7T2kdP?=
 =?us-ascii?Q?lR65+ykJun37KTEhJcpBCZtOo+g4FdUKEJ9jf0EKmfDogXbHYR8wh2pIvja/?=
 =?us-ascii?Q?XrnnSN4y/9p3ECuk4aiZPBeKUEJ2L3L8EBAX8Mg6M9VNMtQPNsW47tYAk2R+?=
 =?us-ascii?Q?TLJuBm+FjV4cHbJLBd5EmhY6ZtnS8QBBqxAT9Cg80VzqJjkaXjRkxk3Sv7rV?=
 =?us-ascii?Q?87tSD3EKWoFp8dyiGYlcKfcawUtsjwFAv7jK+bn3rB5BYN1DxPhCl1yV0WR0?=
 =?us-ascii?Q?pbpFOmjMSk1QisK4MDu7My9n1ImXH4Edwk3RqY54aCvsAucpPoPVX13bCath?=
 =?us-ascii?Q?ulbsxlY4saol7bFLlLGVUyWpnG8MVi7mGXlSH+OfqgWoH1zV6W5rlbDo37Kt?=
 =?us-ascii?Q?y6Wnb8ysiDcSKRUzU3fpm7hgIwCeRV6/5jMPU8lQBXXLO9D8zyZQE1rK5x9x?=
 =?us-ascii?Q?/c8O+l4i+23hNT2jlx19AgZq/ez20Y/ySjAln83Nid0VKVXIsMUgx9GCJ06q?=
 =?us-ascii?Q?Ug91yvTj2zz0jB7pfzfpNMq9jDyT3/aX+ucVFTXknXyVm49W+SefSCr06Jll?=
 =?us-ascii?Q?kAQF7dihKzr7CpJrvlWEA9jD1duuejC5v2CNvEiakTFRAc6iD4p+V/GLR3f9?=
 =?us-ascii?Q?8BkvYS3YblWp/UyhmFMeOvQT6FjPb75boiIuLqrzCpw69mNMKwvaSEBtTWXV?=
 =?us-ascii?Q?e9S9eAj90t/qxRZfSBzcWWfm+a+dYqlugva+buCgl1tSeoviA9BYixKvCWLC?=
 =?us-ascii?Q?FoqmF8AeJNs+KLbTwkmci8/V16flWwXX+7BqWv+7H57TahAzAaxxUBXFc7r6?=
 =?us-ascii?Q?B7UfPEP3ivZD8JqX7ZNVKMn/78bS9+5/yCtfn8pZqjWtAx5DlBAaTbUPpAJh?=
 =?us-ascii?Q?7hrKnWii/SIdEwYipBodm4+/7Ow87ZEiipxl2WvM/GHonAY7RsVNzuCjoo4I?=
 =?us-ascii?Q?BAsjomRwb1f02L2qrgPyFC8a/MHiRpbfhCXbntvX6CcuDwnD0SAsnjVzyXN3?=
 =?us-ascii?Q?1Uv7ne0gZez/MCPuY3wAIbS5ksM8ujFHrIBqg8QUJR+f7iUpQ+gDXGRnDQFl?=
 =?us-ascii?Q?NkD4Vmc8gIJorMpXlHpKl6A0HKP25MD9HMK+XW6uqIlEfvWMaR8fCPPiNG+x?=
 =?us-ascii?Q?wLC7zbURmCJqI/IermWg1zrBf5pYcW/zfzC3UOjnK2ZMNArMGa4aHmKHGIlV?=
 =?us-ascii?Q?2MLQr+w+7oCpd3WOWL4UzwyC1KUdercYQNMXzZ+BN+RUuL4TbPv80cIOWmR6?=
 =?us-ascii?Q?ygW61TBJMmIt7A/SfDfMfyxjZ/GXqMQ=3D?=
X-Exchange-RoutingPolicyChecked: puIl5ViuBh356d1O8kGg8VUeMQ2rZJLYjs85b4Pzu3fehhry0ZAZvpVTePVSF7Gs9UoKxK8dWXgJkrm9BMxBKJzkmOWxIOv7i1bwtPgJeWj7tyId8d/QR0N5TunFBd0syJNXcdHEU7QFenofdx+eZOPpHsDAVJXMxTwZ0hFpC3h7jK3mMCvpN3c6FKZK8iASNsN54kYU6soEOE/EBhP2aCRy3H3lz77LcG/yj0B9K0svG/dccdGDFpA/qLokdOnam0U9E4a4wmgIfg/rsEfS1QGPXPVlL+xPGQ41k4KIQMG6H7yzrF3o5hN/5w4eeBHAG62MDLJ+XSeS4z5FCju5qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0892215d-edd2-4b14-4000-08df24ab5b38
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:44:10.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFpktL2fAxJPsHVT6I7xIY96L2LHqcUrBWAu9O7bq3h0qtAa0H0uRKOEZEAHgFcBsDjMGov+ZfelMTA5vqu/ctRE7GpFQch36X0FtgBOhTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 09:22:23AM +0000, Srirangan Madhavan wrote:
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

Srirangan,

This is probably redundant w what DaveJ included in that suggestion table of Patch 10.

FWIW: Can we avoid carrying struct pci_dev into these HDM range helpers?
The range validation itself has no PCI dependency since pdev is only being used
for error reporting. Can you keep this layer operating on the range and
HDM state and leave the PCI device at the outer reset layer?

The same applies to storing pdev in struct cxl_hdm_range just to make
pci_err() available later.

-- Alison



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
