Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303D382F1E;
	Wed,  7 Oct 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402573; cv=fail; b=rYympbY1HzdvX0dTrsynz2yXZFVDAxIWiUSAotTcl1B4SfdlE1qjRq3ebsS3GqhzL5UZGWb9gMyI3BnsxnSKd73652SF4jXeoyfsw6DJabOsL2WXUUbmBiHTRK2LdUjJDTiQoNV+NqpbSffACErcqeUZiWgZBfCaknqJ0+EtQDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402573; c=relaxed/simple;
	bh=1Y+iJTyDh5cSrq1BG0Ewfn6q+NSykBsPurdaLtDXqLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LHvJthlXPS72xV1C7bOSfpYveeMlFNz1q+V1YQv46e1D1nxruGjT2mCk0/KLDub6FpTW8jls2GIuYf4bKZtdcHbyUDCuHPgF+d/W5zLt/uwTSoUMXLV7MKaQQKai1rrI6VO0ajlkLYuR4RhJPnA7jaLemtsHd52R/wbkSXbVXN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEiK9eSS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEiK9eSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791402571; x=1822938571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1Y+iJTyDh5cSrq1BG0Ewfn6q+NSykBsPurdaLtDXqLk=;
  b=XEiK9eSSm+ciUswPcOIPXSpKtMLUWn+/N9+VXeN7klzxoCG/eOgc+T6K
   /TB4O6KD4+VyFGZ4F/dyPgxI3WXTd0RryL5qBRJ8g5QfrQVvceA/sYLRt
   Z98yZrzhg9+PHd+ST2n8WxlyZhFyjtCPbb5qt/8nrlm9uehOBn65R6mtw
   teERz/vsKFaaRIqR3bIaAemGttjsv1yYQ/wu6lDfp++2u+uGAjy7HYMQP
   eImCsFi6NZzHAT/bP3gRZLWfuSjrmC0T/pdcM8vlrcD7ZhozW5g4O8v0m
   7H8EPIZz3l3x6n/YD5hVUS8Zx2KD9YfndaJNhTxcDMcrQR1vg4R8GBfz0
   w==;
X-CSE-ConnectionGUID: tkNQlH0xRcGYnuxlcrzHpw==
X-CSE-MsgGUID: zhhz9kadQpWKLraE2vJAgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="62086"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="62086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:49:30 -0700
X-CSE-ConnectionGUID: mBcSoIfPR/SBxhmzLt2jgw==
X-CSE-MsgGUID: /HMv3PksRNaQfoCCIlMhbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="306991048"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:49:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:49:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 12:49:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcGdbIbwzudQiZgCnlYTljHW3s0o+TiW1KXlEYJBpHpnNyTiq+NKg16DXLrr+usDLPhl78HS1N0rULP98bQmSfMTrHJsLNyBJCdJHitQvl/MWF/pfbs9qOED0jdCxo8//DBlMazdOsrAq8nRqnO8xREN1jK/mH4jZi9Zcae8h9kZh48Gs5oojtjK69/jPHjeUq1F700OlMmS8Ot0l3IffS58xZRNvTPxnrfByjM/xX82GIP0BH7d3PoF/oy86mKTURDvtqgmjaLRkIqvTavoy5cQld3dIFMlH7Xj6l96STn65yRZxT9Hs3Nir5CXvXOZrSVDX62hCU12j4Ol08mwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emH/x2Dp4I7uQSzDTwd9kK0bd93QDJ2FnTbRkmiWFjw=;
 b=gKZdXWqAZuA9EBqkcGuD6igY5DP7HOswS1GL++JFDqebZ2CmFUGAsKlJT63qrQzEjAaTuAFrVwq1ANPbNex5RoEtVcaHtvp1gnjFu+exR8YiNeUe2TzftAOoGdgFzpJvdWJ/lDNAK5wWZDAAs9kzJMSrzD+tbgUA+goQuH3iVGY0fAw32PNsSW7KZq1I8RrPTllfIlF6zsxR/FZhZyPZY8gHy9OMndnOMzZA26kOgWewiQiKMhff7J7sJqWWTZFlTP0wjQRO9imZg8k0N3YX9OWd+Xe0GZJyltBaUfq58GUzRQvhcJT1ShEa7i14Dk3GPaP0lQAJTjzLFM3Yo9JDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 19:49:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:49:25 +0000
Date: Wed, 7 Oct 2026 12:49:21 -0700
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
Subject: Re: [PATCH v14 14/16] cxl: Restore CXL state after PCI reset
Message-ID: <asaiQT6AwQ4Oaca5@aschofie-mobl2.lan>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-15-smadhavan@nvidia.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a11157-0a6b-470e-e7ed-08df24ac1746
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: fYLGl77yxDDT0rN00L5OH1bQOEKbE4Z3uN7/Nmms/DEacpB6IJCYcm8zqpF4t1Ed2XV0RwCJU2pCI2ayndH5MPeXXYgW5DN4jIjnu3yBwHQkGZm5aNWSvkZQQVL/GSPoBlfTOn+OQt6XTrtYWyIjslt2HF9IlW2FDALgTSk5zq0nwxbtdNR8zgj8dsZwCP6/s60siqa5yJxUtqF+oGvkqFE1kfW0jft0RvUD464qYPVkywFccITlv1P6C9/BjmvPpRig3VLrt+jHC5wac6w22DKBNtEBBODg3n+2UiBid4um+BUlHrXuEuSJyhCUUvjVLFy6bq98nAglmYErpgVHXHFq1Yt6F/wa/CL769CHGqnx0kJg17uJtZMfTYiOGOG1n32PeBYmHStjZ6XASmu+REJEjZcr7NedZLKVaCAT4yN2xd+hm6yGtHAYKO3hdoTi7HTE6ETyILbH1E90ZWRSt3KbTKlRD3MRN9RkymCU8hC5MLYbtLyVWuP5nV2Acw7v/KPx3KNiv42A4M/akhR+mM+T6Yl5h8mjDBZn7hiZgj914Noeob5gatPgTXnh63DEwolRQSkPP7GFP0w9WcuPQfHCT5VTvA04f6xsu/NKPriBKctKRDaY8cm8XUFZe3TsNikJcVpJ3Hecpiy10gbpQJBVsPojeNIVlzr4RGujE7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGpmB5h0aR1aQ4uL9BPjMyaXz/3GpriSH0aJEzTwgSv2yyLAVd7GexNHD7jt?=
 =?us-ascii?Q?4YXs2qbkUIXS7/Ilpjs1Onoax2s0iwBx0DbW7/0axXRWyY6Bk2OJQVdFrYhH?=
 =?us-ascii?Q?9lARAcVMjqd6JZEa24Is7J6jZmSnK/xYAorLKgdtniHupRdf5NBjnsfzzkM9?=
 =?us-ascii?Q?rm17XxxPh0sau5HJwZvWxo5V+U4wuKLQRmjF4OyhVKtBQo/BYQlQQg42jkVM?=
 =?us-ascii?Q?GJ7A2e3+Qupi2NOFFY1Be7gC9mYPGTMduDDFCa1K7178gAn6ndARJ4vuTjMi?=
 =?us-ascii?Q?8ytWj0g5mg+bDu+1Py6HtbdZV017+3GGIoeV8Q6TYosrgdiN3gpdt1aXgb6p?=
 =?us-ascii?Q?kI5gd1quoLRntLH6QBaLpI0SEM0HpvLh8hIvQ9lR9kOOqoOa/YTL7BSMdSxk?=
 =?us-ascii?Q?nN8JRWz7zUgY8mZwO5FkoOaUFZsv5gwlzFFIXOCju609gMfYxTOziW4eCNHz?=
 =?us-ascii?Q?+AKoAha/oo1ETXcWDcwhnjta1pq2RYfAf2FOcSzoRr4UV7hJ78FaSuZleOEk?=
 =?us-ascii?Q?qUG4wfnMJU1hLYzOUflcKNSDjCtKoXXngXnBGVgpgbG1fi0xEnduExZ6hKmV?=
 =?us-ascii?Q?OiK/wP+0dbCqzXaLc9kdoSpWTiAy0Ug4NbkLrb5tQmsGpzOo0MoAd1wEqsjF?=
 =?us-ascii?Q?y/LiFp6nPZDQALB3I5SKlwP1QNIAcEpSdjWBZnQJ0n8XJkhmWpvH59ZPMHD2?=
 =?us-ascii?Q?GKjIzHwUb6F4s3irfRFQquB+OarnE5od8kOZehudCBBd8rIneAkzhKeH9EMp?=
 =?us-ascii?Q?Cjxqb1dGAxox0k+lOBMgHJQWl2osyxiGsqVNKCLRB1DqQQd7s/29JKBzhfsJ?=
 =?us-ascii?Q?ZjVC2/5aEgcOdzGco6JBfMRC8LsQpVatVX/Vv/zwAWoaAxRmqBI1nNiYdBDT?=
 =?us-ascii?Q?FgLXGBLGiwkn2ykW35/P7ReIsDNSzZkjlI0Gdi1Fg5tYXgwgbsnP7uh4+oke?=
 =?us-ascii?Q?OcerNNOVinv7xi3lus0uDJFHipk+E1h4waet1ZpFmc9FEfHedm2ash8atgq4?=
 =?us-ascii?Q?ZnT4UWOdJtzzgz/8leewNB9LbuNc4hBN9yBUheH6cqdp8RdDr6d78JOd4VGl?=
 =?us-ascii?Q?kPXSBRDOAuJ066/FmnVGH/AmtAt721ixe4EyD/OG/YiT3tNJFMhSiQw1EDMc?=
 =?us-ascii?Q?I96luTWrlYEHcNGOTysjeqtwvAJBQMBpYIhNRLfL4IzkmdMwtHBBP+3lWPqf?=
 =?us-ascii?Q?w3QuyZP8UXVMvF20yn+YjQGsCe6pMikk5VEp17Y/6rsKLuSQT4bKa4Gy5Z3p?=
 =?us-ascii?Q?gpRS/j8dnGXmcqBwpDocZI/SpIZbmtX1sOOkHVUyclXnfbjN1sapIRKDgiI/?=
 =?us-ascii?Q?1a7Au7LV8g/J7TqAHo7y7aEFQ3li66bzRFSzr45Dn4WX2F6DPyzAfzaPiqer?=
 =?us-ascii?Q?YnO1xvQTH+Ry+UKzvMjNspWLu45LET1h7ewDzHEBIRgoYeOR9AXFFDYDpq/i?=
 =?us-ascii?Q?/JkieuZe6KWpGD7ZvNVs4Iqsv2gcdmKoAeKCOYg2rIKPkCVyFcyrnTDXCa5I?=
 =?us-ascii?Q?ORy7xDnBoHuyuBKcIX/WNO8Ck2y19LWQTvZOUWXZh87BbsYi39/rufTusiQN?=
 =?us-ascii?Q?R+qfS3c84Phs/J+c21gS/G6/mQYaOHJ8IlXvhsfzip0+f8m+4ld+tUhq//H6?=
 =?us-ascii?Q?MjrJ5s6sWRKUJfspdDzIBJ4IPiMs8hRlVknE5Lof1ML1NtTMGTwoUsqGj+s7?=
 =?us-ascii?Q?U2rgTWkdTOWhTf/GyUsBHkVCMBKho0IeqeLpXDDjcq+I2yvXTVoXq7zvJVso?=
 =?us-ascii?Q?AYhcBKg/vBA2BxmI4o7Q/HgNPu+/3XY=3D?=
X-Exchange-RoutingPolicyChecked: VleXfPoibTGjcNIWBSCIknfA39OZai+HAt4344eOi8e7UWd3MM77gs38RLGTB0OsX+rl4BnjCzHPZ2KC1I4scFBA4314Imfq8fHcyGwy4Xo9rBzSK1DJ8QOLIAcnhINMTXe3xDmco0j5/lcd0meaT/sI48bnkZabXxyfScBWcUPEMQhcprR/bZs/v5SAGMyy5xuu1k8C8ZzNRPTWAz5R7Wgtd5S3Vs+mtYQzj/GTRkFC2jACLdGdyWRwc2oLbvC3wh3VARZL0eTYQc0ZhSgEOroxQFg0o0mambxO2lAL9beMOoamK9kocbXuotJGZzz6DUQ0P06vimzMcurnnUPGWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a11157-0a6b-470e-e7ed-08df24ac1746
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:49:25.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0R0q5x55/msfjCnvd1ITvN7MPMAiX8jVO9UDPwiImj5Tz1/QYNXYoDPw0qTVN++fnj6Tk9Hqoo9eVzBO2ybQcfi3f2Wgl+IsBnjYA2an8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 09:22:25AM +0000, Srirangan Madhavan wrote:
> Restore the PCI configuration needed for HDM access, followed by cached
> HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
> before restoring its lock, but leave surviving locked state unchanged.
> 
> Stop at the first restoration failure and preserve a disabled PCI command
> snapshot. Keep IOMMU exclusion active through restoration and post-reset
> cache invalidation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 418 +++++++++++++++++++++++++++++++++---
>  1 file changed, 392 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 679a605da24c..0acc471d0d7e 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/memregion.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -83,6 +84,26 @@ int cxld_await_commit(void __iomem *hdm, int id)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
>  
> +static int cxld_await_uncommit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static void setup_hw_decoder(void __iomem *hdm,
>  			     struct cxl_decoder_settings *settings)
>  {
> @@ -448,6 +469,335 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  	kfree(info);
>  }
>  
> +static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
> +						 int bar,
> +						 resource_size_t offset,
> +						 resource_size_t size)
> +{
> +	struct resource *res;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
> +		return ERR_PTR(-EINVAL);
> +
> +	res = &pdev->resource[bar];
> +	if (!pci_resource_len(pdev, bar) ||
> +	    (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
> +	    resource_type(res) != IORESOURCE_MEM || !res->start || !res->end)
> +		return ERR_PTR(-ENODEV);
> +	if (offset > resource_size(res) || size > resource_size(res) - offset)
> +		return ERR_PTR(-ENODEV);
> +	if (check_add_overflow(res->start, offset, &hdm_start))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm = ioremap(hdm_start, size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
> +static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
> +				    int id, bool *retained)
> +{

Srirangan,

Same concern here about threading struct pci_dev through the HDM machinery.
This helper is an HDM-register operation. The PCI device is only needed for
the error messages. Could the register/state helpers stay independent of
struct pci_dev, with the PCI-facing caller responsible for reporting the failure?

Otherwise pdev starts propagating through the entire restore stack even
though most of that stack is not inherently PCI-specific.
- ie cxl_restore_hdm_state() and cxl_restore_hdm_decoder()

-- Alison




> +	u32 ctrl;
> +	int rc;
> +
> +	*retained = false;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -EIO;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) {
> +		pci_err(pdev, "CXL HDM decoder %d has commit error set\n", id);
> +		return -EIO;
> +	}
> +
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +			*retained = true;
> +			return 0;
> +		}
> +
> +		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
> +			id);
> +		return -EIO;
> +	}
> +
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		return 0;
> +
> +	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	rc = cxld_await_uncommit(hdm, id);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n", id,
> +			rc);
> +
> +	return rc;
> +}
> +
> +static bool cxl_hdm_decoder_settings_match(
> +	const struct cxl_decoder_settings *saved,
> +	const struct cxl_decoder_settings *active)
> +{
> +	const struct cxl_decoder_config *a = &saved->config;
> +	const struct cxl_decoder_config *b = &active->config;
> +
> +	return a->id == b->id &&
> +	       a->hpa_range.start == b->hpa_range.start &&
> +	       a->hpa_range.end == b->hpa_range.end &&
> +	       a->interleave_ways == b->interleave_ways &&
> +	       a->interleave_granularity == b->interleave_granularity &&
> +	       a->target_type == b->target_type &&
> +	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
> +		(b->flags & CXL_DECODER_F_RESET_MASK) &&
> +	       saved->target_or_skip_reg_val == active->target_or_skip_reg_val;
> +}
> +
> +static int cxl_restore_hdm_decoder_commit(
> +	void __iomem *hdm, struct cxl_decoder_settings *settings)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	cxl_commit_start(hdm, settings);
> +	return cxld_await_commit(hdm, settings->config.id);
> +}
> +
> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
> +				   struct cxl_decoder_settings *settings)
> +{
> +	struct cxl_decoder_config *config = &settings->config;
> +	bool retained;
> +	u32 ctrl;
> +	int rc;
> +
> +	rc = cxl_hdm_decoder_uncommit(pdev, hdm, config->id, &retained);
> +	if (rc)
> +		return rc;
> +
> +	if (retained) {
> +		struct cxl_decoder_settings active;
> +
> +		rc = cxl_pci_hdm_read_decoder(pdev, &active, hdm,
> +					      config->id);
> +		if (rc)
> +			return rc;
> +		if (!cxl_hdm_decoder_settings_match(settings, &active)) {
> +			pci_err(pdev,
> +				"CXL HDM decoder %d retained unexpected locked state\n",
> +				config->id);
> +			return -EIO;
> +		}
> +		return 0;
> +	}
> +
> +	if (!(config->flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +
> +	rc = cxl_restore_hdm_decoder_commit(hdm, settings);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> +			config->id, rc);
> +		return rc;
> +	}
> +
> +	if (!(config->flags & CXL_DECODER_F_LOCK))
> +		return 0;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -EIO;
> +	ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> +	if (PCI_POSSIBLE_ERROR(ctrl) ||
> +	    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
> +		pci_err(pdev, "CXL HDM decoder %d failed to restore lock\n",
> +			config->id);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_snapshot_hdm(struct pci_dev *pdev,
> +			    struct cxl_hdm_info **snapshot)
> +{
> +	struct cxl_hdm_info *info;
> +	size_t size;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info)
> +		return -ENXIO;
> +	if (info->decoder_count <= 0)
> +		return -EINVAL;
> +
> +	size = struct_size(info, settings, info->decoder_count);
> +	if (size == SIZE_MAX)
> +		return -EOVERFLOW;
> +	*snapshot = kmemdup(info, size, GFP_KERNEL);
> +	if (!*snapshot)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
> +						  u16 *command)
> +{
> +	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
> +	u32 restore_config;
> +
> +	device_lock_assert(&pdev->dev);
> +	*command = saved_config & 0xffff;
> +
> +	/*
> +	 * pci_restore_state() is the available interface for restoring BARs and
> +	 * related PCI state needed to reach HDM MMIO. Temporarily alter its saved
> +	 * command value so that it enables MSE but cannot enable BME or INTx
> +	 * before CXL state restoration completes. Preserve the original saved
> +	 * value for the outer PCI reset path.
> +	 */
> +	restore_config = saved_config | PCI_COMMAND_MEMORY |
> +			 PCI_COMMAND_INTX_DISABLE;
> +	restore_config &= ~PCI_COMMAND_MASTER;
> +
> +	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
> +	pci_restore_state(pdev);
> +	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
> +}
> +
> +static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev, u16 saved_ctrl)
> +{
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				   saved_ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_restore_hdm_state(struct pci_dev *pdev, void __iomem *hdm,
> +				 struct cxl_hdm_info *snapshot)
> +{
> +	int count;
> +	int rc;
> +
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count != snapshot->decoder_count) {
> +		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
> +			snapshot->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	/* Restore global HDM control before committing individual decoders. */
> +	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (int i = 0; i < snapshot->decoder_count; i++) {
> +		rc = cxl_restore_hdm_decoder(pdev, hdm,
> +					     &snapshot->settings[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/* Flush posted HDM writes before restoring protocol enables. */
> +	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	return 0;
> +}
> +
> +static int cxl_restore_state(struct pci_dev *pdev,
> +			     struct cxl_hdm_info *snapshot)
> +{
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
> +					  snapshot->hdm_offset,
> +					  snapshot->hdm_size);
> +	if (IS_ERR(hdm)) {
> +		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
> +			PTR_ERR(hdm));
> +		return PTR_ERR(hdm);
> +	}
> +
> +	rc = cxl_restore_hdm_state(pdev, hdm, snapshot);
> +	iounmap(hdm);
> +	if (rc)
> +		return rc;
> +
> +	if (!snapshot->dvsec_ctrl_valid) {
> +		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
> +		return -ENXIO;
> +	}
> +	rc = cxl_restore_dvsec_ctrl(pdev, snapshot->dvsec_ctrl);
> +	if (rc)
> +		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
> +{
> +	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
> +	if (rc)
> +		pci_err(pdev,
> +			"failed to disable device after CXL reset failure: %d\n",
> +			pcibios_err_to_errno(rc));
> +
> +	/* Preserve the pre-reset snapshot if PCI state has not been restored. */
> +	if (!pdev->state_saved) {
> +		rc = pci_save_state(pdev);
> +		if (rc)
> +			pci_err(pdev,
> +				"failed to save disabled state after CXL reset failure: %d\n",
> +				rc);
> +	}
> +
> +	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
> +	*saved_command &= GENMASK(31, 16);
> +	*saved_command |= PCI_COMMAND_INTX_DISABLE;
> +}
> +
> +static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
> +		cxl_reset_save_disabled_state(pdev);
> +		return rc;
> +	}
> +
> +	rc = pci_save_state(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
> +			rc);
> +		cxl_reset_save_disabled_state(pdev);
> +	}
> +
> +	return rc;
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> @@ -814,7 +1164,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
>  }
>  
>  static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> -			      struct cxl_hdm_range_context *range_ctx)
> +			      struct cxl_hdm_info *snapshot,
> +			      struct cxl_hdm_range_context *range_ctx,
> +			      u16 *command)
>  {
>  	int rc, rc2;
>  
> @@ -839,42 +1191,69 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc = rc ?: rc2;
>  
> +	if (!rc) {
> +		cxl_restore_pci_state_for_hdm_restore(pdev, command);
> +		rc = cxl_restore_state(pdev, snapshot);
> +	}
> +
>  	/* Evict lines fetched during reset before ending DMA exclusion. */
>  	rc2 = cxl_hdm_ranges_invalidate(range_ctx);
>  	rc = rc ?: rc2;
> +	if (rc)
> +		cxl_reset_save_disabled_state(pdev);
>  
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> -			     struct cxl_hdm_range_context *range_ctx)
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  {
> -	u16 saved_ctrl2;
> +	struct cxl_hdm_info *snapshot = NULL;
> +	struct cxl_hdm_range_context range_ctx;
> +	u16 command, saved_ctrl2;
>  	int rc, rc2;
>  
> +	guard(rwsem_write)(&cxl_rwsem.region);
>  	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
>  	if (rc)
> -		rc = pcibios_err_to_errno(rc);
> -	else if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> -		rc = -ENODEV;
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +		return -ENODEV;
> +
> +	INIT_LIST_HEAD(&range_ctx.ranges);
> +
> +	rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +	if (rc) {
> +		cxl_hdm_range_context_destroy(&range_ctx);
> +		return rc;
> +	}
> +
> +	rc = cxl_snapshot_hdm(pdev, &snapshot);
>  	if (rc) {
> -		cxl_hdm_range_context_destroy(range_ctx);
> +		cxl_hdm_range_context_destroy(&range_ctx);
>  		return rc;
>  	}
>  
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (!rc)
> -		rc = __cxl_reset_execute(pdev, dvsec, cap, range_ctx);
> +		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &range_ctx,
> +					 &command);
>  	/* Restore cache policy after any attempt to disable caching. */
>  	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> -	cxl_hdm_range_context_destroy(range_ctx);
> -	return rc ?: rc2;
> +	kfree(snapshot);
> +	cxl_hdm_range_context_destroy(&range_ctx);
> +	if (rc)
> +		return rc;
> +	if (rc2) {
> +		cxl_reset_save_disabled_state(pdev);
> +		return rc2;
> +	}
> +
> +	return cxl_reset_save_restored_state(pdev, command);
>  }
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
> -	struct cxl_hdm_range_context range_ctx;
>  	int dvsec, rc;
>  	u16 cap, ctrl;
>  
> @@ -917,18 +1296,5 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (!cpu_cache_has_invalidate_memregion())
>  		return -ENOTTY;
>  
> -	INIT_LIST_HEAD(&range_ctx.ranges);
> -
> -	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> -		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> -		if (rc) {
> -			cxl_hdm_range_context_destroy(&range_ctx);
> -			return rc;
> -		}
> -
> -		/* cxl_reset_execute() releases the ranges on success and failure. */
> -		rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
> -	}
> -
> -	return rc;
> +	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> -- 
> 2.43.0
> 
