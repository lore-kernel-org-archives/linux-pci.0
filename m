Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D072236E0;
	Thu,  9 Jul 2026 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567820; cv=fail; b=GoWFvMgcSPq4L6JzQiHq/VJKoTdhUoYwFWrNi8pvgY/t2eya3ZORDohSwwviVziAbN2hRupObRGU44HAUs6/iecSZhpLjdp/UcTA6OVLQ96xL37ol8xL5+/ZukF29ze3DGfFrwlMD36nHOXe9LiQyFjFYX+QUMVXaDx02exOmNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567820; c=relaxed/simple;
	bh=SdXmtwq/K46d/SM2/2Cd3sTYwQ1iiLQoR9MxnWFe/Go=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mz6VLi7aa8xiU1oYQBH5XLuZmBFNFjkOLE33ZhoiSR2y7D31RH0WffhzFe0BwD6+T9u7abTTM+iFEQS4GGY5Rx52hF8fvXxMYUVHkwIw1TGzhEyovcR4FV4WHHrMacidK5bsgXGRxsRmNpu9ITd/IqCW7U84P2auKmp5WikF8x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llBcDXlA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llBcDXlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783567819; x=1815103819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SdXmtwq/K46d/SM2/2Cd3sTYwQ1iiLQoR9MxnWFe/Go=;
  b=llBcDXlANEtGXiIxlGbx1kDEz6mzltz7uwUZJJ96pkAmzVF0LzN7FYia
   dzLOvkRXdsHKf2iZQNlXZyi7BAUObxjm3QQ11Sl1n9Ouu9tY/J+GWcon0
   eyu8YbTOADfrH0PFMJ88iLK+cXBFaVxIQD5QJkNyRDeJg8SBT3xX+Y/gr
   cD4RUhs3XtpTWH00aIomWYaVKHpv1eH8RrCDV+oFmLAd/CG2UtZf6UTD7
   RTeshaw5Uv7O86s4MH+YfDcIe83QCFZkiBmEqVfmTGCVG5EdrXYtHlheE
   drheiVTlobgKNhOK9gFuSfoYCkfRrMDXqWVAqU2o20VIIBmTi92eFp79v
   w==;
X-CSE-ConnectionGUID: Rjzr0Cp8QCyhdaoolXj5hQ==
X-CSE-MsgGUID: oIRFbexOTzKMhhrkJ9Td0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94847820"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94847820"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 20:30:18 -0700
X-CSE-ConnectionGUID: nAB9fxnCTdaAm0Z4O2NJvw==
X-CSE-MsgGUID: 9+v6flO2QiOKZySUqfIsKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256375261"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 20:30:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 20:30:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 20:30:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 20:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5p5p7lA6oacs8KtCuLfHMFFPDZhX4FxsOgcuTQ6v9n5XBICaQmq6HfBPUWs4+93E4VABL68NMB+/gGU4QKRL12/PCBjtV18IuIcKPKRG85MPG3VZv61J0OV5hzCmnrXD8Z9HVyFykItrfKQZUY8HKXfIkNDOzAU+0It+IgvniPmCRiSUIvhCj+LG5YyktZBAPTGAyJXEPiixGtkCfvVi6q8lDMcFKV1gOgrb8hBPmh5bhMYUSOHQDcjug/oX3F7eE5otagjwNRGPoOX185SSeUUdLdD8MAIt+HZ3fHbranv3aEiycuJesH0u/oIfCvns58ZtC4BZORIanhkD/dBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNIkbIPk7iKVItw8ZkeqteDumGem/EhVFkPpOopXTB0=;
 b=BPddNhAZeh0OcAHEGEOd0RbB7gfCb2g/zyQSZmZbK+Wzw+KuEghx71AypJvhlEF2jft79rE93DUVpsix3Mp4B9glXVWM7CuhOfzpzWER4g5fo70jJ7RJ4EmA5CR/7dcJahP5odTiJSadIjK3GWU1eV31sFuDuXJeK16i1q+J2+ysMHFb0uFFjAojulGMOeRA3aNt617tgBRzKvT04dKRRp1rzlZ1Qvseg0K8r1hBj8Ri9JFS18iPqQoGqcLhRsZ+fkctPHpFip5N4OU03NxRLlAIjuc/xIm6UA9+WuXOF+HLvPOcrLkXZfDjgylls2RdD3z0/dv6RfG1MCmzvkTHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 9 Jul
 2026 03:30:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:30:15 +0000
Date: Wed, 8 Jul 2026 20:30:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 04/11] cxl: Cache endpoint decoder settings during PCI
 enumeration
Message-ID: <ak8Vwi2W2vVM0n0D@aschofie-mobl2.lan>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709010304.680422-5-smadhavan@nvidia.com>
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1549f1-034f-48ef-9206-08dedd6a6404
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FtdSeMN6WI/XG++aMQBBZlZosn4Xi9/vPwBIPm3NM62l5eryDFVSVl7GvSM3pZkmpPotIZc1p+Tz67+qimWveDNtr1AmaRh800Ebpqskbltg/afRx7VzbbAwoRl0ks1WIT5XbpvNxvpru0BWt935IRF3hN8gJZ19+8l7xKtW7sJUrG4PBNTlcagsvH5LRCIQ81hDRPJyCo2bK4s6WEnxW0R7MhiIDcftfdznkcSMM/mGE2h4inpfhH3yOxtJ9AC+lKde86FhBQufkp5J3ldYC87cBnxLn9LoNn+iLYIMCZtelH84/w5u91JhZh21zLPVfoCQ69T8B1RiH8f5LSBKrkScbYIX8vzHl+0AzvHAACkn3J6iqvuJzhfG9fU2O5kPuQt9quxHop6eLy3p4hMSKxsxMhSCWyVWzbgFpIZLvKH5Q3XFoqZ+uOxpqF5B9tgwAOgfzuN5+P+84twNIcKZ5lp9kIOp7li9JWfHP1MDwGnD+gaJBciArzMbg5gehGW1FVH643/IdnOtaPLyipTDtJu+A/QDiJSQvv2FNrgIqYV0Lsh3s5SeA5EiIZm58jNA6C/dNAMXdDOa2SVYS08IvqYp1cjsd7+5sVHRvwCZfxo44hgHy3XhkxO0bc3RkM63D+XS+L62iYI9wMBX5BdLugZI94s73YiPOpMMArQjaQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTIBs2czGjDCl4LALW9h7b4QhggjbkgHnRLFEprQFPgNCBkem4z4Fk9IU3PE?=
 =?us-ascii?Q?tpMZXlROWDVnp/QZcMdp2lU+rLPSkuRtn6WvrF7rfKuGsVvUmPhRjv62JKrJ?=
 =?us-ascii?Q?q+VWuiKklvBkPndZJ4qLyHJdTto5jLK7JvEL5BO05ROvjyVrViw2k5qW3WkY?=
 =?us-ascii?Q?bIGwxiOGGsoWymIU8FKC0ly4n/QDNWLmkzKkUziXWrxVBivlDDxNa0ILvTVu?=
 =?us-ascii?Q?gG0YYy2RYmSA06MfMgXRAMbIvS4DmNqaIiQ8PwdMdLvhTG654smmlgMm17g1?=
 =?us-ascii?Q?DTB2wlsg03Jen45Of54coK179+vfA2LjPylGnRIUxBAe9x+K1aohHxEVDd9K?=
 =?us-ascii?Q?gaCmWQObJaIIhUkdMNDJJx379L0pTXATFWuqAYWESlN2bzc1RcyxSKNKb3TQ?=
 =?us-ascii?Q?3v2eVQ6BKDBG72SwVw0paERUpD60cCcBYe5fkewKzpdPjWdDNp/C2pEBIzvX?=
 =?us-ascii?Q?zERt9UOlph5ovhd2NYA20EikyDnf/+6fa6xVOORVaBeIiYYPYvA5rk5vJztG?=
 =?us-ascii?Q?3GaV6zAH+5GxV2VQNNeBVF2B/0pLK4+VQpg/u/gjo0T+8/201FULjbohC1pb?=
 =?us-ascii?Q?aR1aX3SLRwz11mqzwmKxzi71pXeTNyfGO3rm3jWyfdSIZ++sO+FjRMFe6alO?=
 =?us-ascii?Q?9GIsNfk0PtBpzaOcAUD/KB8XKuJYUgOvrDnA2EOtsME/KvFaknER39WyWr2c?=
 =?us-ascii?Q?LkGX7rN076Ci64yeezOlcvq+J6CKR08JVYGzXBPQdOEZwAw5B3nYMGori2q7?=
 =?us-ascii?Q?zcOmhFJSe7QMZlASn1OF/z8sAczufhrGYdvfSAOLX3boM4pcSeU0xcJ+lQUK?=
 =?us-ascii?Q?K5EDABXMZmn4ELyV0IDFOsKtqSb3vQ73PMnip5KbP4W5C5BkOroqurcmkVqS?=
 =?us-ascii?Q?rZsyi7dHUxu5kH/GUeQbvrUf3xJOeqJu8Wx+tbQCrzh5y1QV3hMw4pet8H3P?=
 =?us-ascii?Q?Q8Kw6V+rYiRB7fX5/Kgsquros6nto1wZL/1HdqdIj3AUUfkf3BZwF6nzR3Ps?=
 =?us-ascii?Q?e93acPlDd+HpsuJ0TKjZNTx34lAtRaHTUpWQTEZm1jM7638znaJhhPHeD7OQ?=
 =?us-ascii?Q?r5tL54Rte3oyLy4WBoS8hlrC4QzyiwhTPp2SVqWNGXNL93ebMaXJb4tnFxj/?=
 =?us-ascii?Q?LYxwQAOGXFK0hPJnrmqCFqbduLRqDKtI1FsKSl2N6tRKCB+XAKE64hBp6qi0?=
 =?us-ascii?Q?Ict2KabLyrAVTK9S6fslEtxLrJnv2OF3kSJHVNYy2Hmak4vTFtSdWIiQD5Ta?=
 =?us-ascii?Q?/KG0XCNP1lxpngIKtIaLAsuPmDfqRGYlxVxDv6B6M4yiSQ5aPRrQzThOmd82?=
 =?us-ascii?Q?fbW8pm2yDUnd9ThsO01A9w4HqxVyt+yrbbzMJph/3Dn8XmOyQzB0pKdzEZTi?=
 =?us-ascii?Q?6iSRdI31UkQYAKls9EOmaTot9Czw8AhEx3KZTI0YstyyOgUumy+bT00kIC4C?=
 =?us-ascii?Q?PxUmKvvGSAUU1nH0KYmap57G/lGXx6eYfnGg+KylMVSoibT0T7xVn8Kb/qlb?=
 =?us-ascii?Q?FSpvY3jFuQFjSNGwBHeuZc/o/lVNkW/PK7OQToRHEF6/370w78Ny4E/o6xLO?=
 =?us-ascii?Q?l3WTgbOWdkLo2YEXYpjvwauZrdEYd+MoEagKvDEMHLgk2du3eJcS/IrLCm26?=
 =?us-ascii?Q?uhS614BfOeJZ1WnEo+mMI1ZYj5J0DyCFAirPT/00hf2U3CrLSfEGxrpxP8Q2?=
 =?us-ascii?Q?LnVTvJSpMBT8Z+0U5tA2CetWad9T77EV/iq9eJyaRPoL300k2pS2THmUPZTY?=
 =?us-ascii?Q?/y18/RWiG4m5PlP3Lw4sTLhsVylccKo=3D?=
X-Exchange-RoutingPolicyChecked: IvzPnixU8TFtmX0o5WL5xIQzqSuJJXunuFmXiYVf25DGubAQMGhHq5Q9m2p3Wqt8kXacBDTY/Z+mJ8BuDSjnFFkNoHb7IK4dQBFiL0xJT0g+FTOeITM37K3Rs/RK3C8fn0KLN2cd/GkOt4n0YmLhiT+k75Jx8y3sA8ZLGJt4BvcMKeVikFZ628j+owMLzMaxqOWNG4RcZ4Ib+e/0GyhMjGTkR8e/j1xbQ/9boKX/I66Dgwn3fCJVVXDZi3+O01duJJ0OfandK9QzCqya7iA/qDb/uA7vYnVp8rXyADY65v+gsbwykGi1NwdoZ/IPAx6dY3sdzb7LcxAg9mG4Ye8G5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1549f1-034f-48ef-9206-08dedd6a6404
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:30:14.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sysyf6XNYbuLPlKAnvqMr1zGRfLkpAyTMQZCsS0unXoCat2LnUBUKdpb8iVXyJ4btRdzkb59/joKRi6SJhbCPzTheBcrFb6WZyu3QD7PvsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 01:02:57AM +0000, Srirangan Madhavan wrote:
> Populate pci_dev->hdm from PCI capability initialization for CXL.mem
> functions. If Memory Space Enable is clear, temporarily set it while
> reading HDM MMIO and restore the original PCI_COMMAND value before
> returning. This gives driver-free reset paths an early HDM snapshot.
> 
> CXL core later reuses and refreshes the same cache. Move the register
> helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
> available without cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile |   3 +-
>  drivers/cxl/core/hdm.c    |  59 ++++----
>  drivers/cxl/core/regs.c   |   4 +
>  drivers/cxl/core/reset.c  | 288 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |   3 +
>  include/cxl/cxl.h         |  31 +++-
>  6 files changed, 349 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index dc075cee0450..69cf2ea7ee74 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += reset.o
> +obj-$(CONFIG_CXL_HDM) += regs.o reset.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o

Hi Srirangan,

This breaks cxl-test module builds with an 'exported twice' error,
14 symbols are both built-in and in cxl_core.ko.
All from drivers/cxl/core/regs.c

With that fixed up, this set passes the cxl unit test suite :)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e80500f457a9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o

 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o

-- Alison

