Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186018E02A;
	Wed,  5 Aug 2026 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896024; cv=fail; b=GcI4KAM0lahk+YcVC86JdNgvRjuYyyZoo3Bzgl8lNQ+2Wp0wY2o5CY6UOu3/bYH35dPrFjzvF3aJ3dwehjxtUwqWNCsq87+1pqsqzBZMXjyoHp3uEYlnFqnHXxkQbqxUq47V3e/3t3/YMJBYPorTjlc54Mw61yguBXdFHeduuD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896024; c=relaxed/simple;
	bh=zQ1s7oFPX7q5O45MfL+syO0QmzzOj9SbXM9NTdb0UaY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TATj6+cBCDR20r5muGYeeCE4+Itfr6USxY6bDUCpOi6/NWtTUeTokvjZHpAb/l6WeAzPhYtu8w291of/FlVMaHZTkGZklrexhmerN0WPGlifOjPk4eqoGxvWxmfNMpNMgTelbiuQrn+Jdntn0O7577hxz94zPVKegkBoMR99JdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcCfIVSt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcCfIVSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785896021; x=1817432021;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zQ1s7oFPX7q5O45MfL+syO0QmzzOj9SbXM9NTdb0UaY=;
  b=LcCfIVStSPwf4pEZt+9Tsj7MpewUbHj/lyPLD+IfPcRaPyr00wlWnt90
   4Lh0eDuO/cA+BVLmsXTUD5cgMYExMAZKcdTKsYPRSa6wccQAVapUyHVgz
   dTBIswA/Pv50yCCWBpPbq0OCI+aGTw4/tAoFVgJi/N28el+4/liLuEDSa
   9Zelq61XUs6V4HEf/00n4dOmY4y1SdjV6qHI6Iwf0kHuUmGvyY1BNcula
   CJvyqiC9TQFyrYjdkHJwLOkb24gS5bpYIJp8CYAtXxScZIh2cwALtNx/w
   RMPSdyQu0L3v2ujFhyVIfCie7mKOTSZ+zVxhtL+UNAQSyUuAG8gyXHtt7
   A==;
X-CSE-ConnectionGUID: +meDkdoEQyyOwUb04pOjlA==
X-CSE-MsgGUID: nAg6+w0/TFqOOouZPI/qmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90271608"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90271608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:13:39 -0700
X-CSE-ConnectionGUID: 2mBC9VCRSe6cirUs7oeI7w==
X-CSE-MsgGUID: +3t/OL3CR52elWVcJt5/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259904413"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:13:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:13:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 19:13:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2Mp3G9528YTUcWCh6pjvDXrMg0VGntfP9iOGxGq/pdKVkENtJdiLz9xoE7+uo6XusCFZPGcmezlJWy1w6cmt54hhPoQAZ6Sbf1QdoWED6UlshBax+8q+CwObZ4ZGicHnhLmuas4RsLDMKyitsuzUt+YmLzKB3ko4qB08cwh9rH3jbwQJ+eOo2q2Yspv3OMmohZbgiVG7ZedBZMZjmA1Ft28Ww6qPT0eLTeHxvhE0iDVhYKUezjcRQQl8AzwGHWxqB9QqJXGDvTLhEXotpCyibbhSuWJOFqtWwOLwr9nRfa0b8fobKMVfiyUbOaGPNOxuaPhABt5MvNL8N0cytTkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEfyIiM2UEdwETRX2+gllQR+kpA40ekW7aFK1fpGXA0=;
 b=jxNBFZpg7pBDG3ekwIH+jtQ8f+MiGRsIjri6yC/eiSNVV22LysvRZXT3KWS0WqI63QBTwv+K5k4W/bd8hiQRLMOB8Ejr3cBrZPqplOHnPuPIfQRqsTHIFLLY5QKWky0vjnV6X8sMP8FLOiT0pQUe+PgyqklJuXAEsQuO+OoBPV0CvyCkwGsD+Gn262vF+GNWuWS6LI+J6PfPsPw+BJMA9diazfluVfhUcVfZ/tU12DdU1X25WkWfaspgh+T+vWfj3XeGGDQkvc8Kq7x1yZyl23WXxCVYNbnpmwLCSWjcVgFeiKCnmPrnN4lZFkFI5pWd3JCVHhmoZPf/5qikDra99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 02:13:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:13:35 +0000
Date: Tue, 4 Aug 2026 19:13:28 -0700
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
Subject: Re: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
Message-ID: <anKcSN63nh3CgtEQ@aschofie-mobl2.lan>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804192958.1823952-2-smadhavan@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd5b053-cef0-4ad2-d50c-08def29727dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x2sLPESzUilpcFsTykpjwI+iJ/gbr4omz+PtGPqwJx1KgUSt2SqFs4nK/SnmREf8clPKcUL3MLe5y6AfJyfhAHE6Kc/YKcnQjkwxhOk9VjFxiFsKkhoQLtgpuTT6+uymZIfC/icCysQBgjp++gwSdA6U893dLgmdqhmh1317PdGqVGLg5xSWlVO8l8EHNibEEyTFQZWLOXhhB8sGd10tBQf96eM7Q+F3Od9r8Oi14e/d/OsMwTxWL83wcMrBC89LEtKeMGFpx+wWQJvQc4CHxsxyVXZxKmdffRbqWTdNIf0FxsFQ3xIO0c0Vy9llCe+Y4u8wZDYTjztMOg67epqfp2UiNm+py+Q+5Td7CbKTAMa9UKR4v3BTlt1GAc7gGPKAt4UKZ+dcD6czYqs2tCr98DPQiL2l2CgkshPrLvwqPSTNnKJW9TMQz1mfRek6xmzR3zRQgdvKI/KjMQt+Ykh0E/6yYYgO8rR4npS10KaWSh9DRbOqNofou5N0Q98kRmwhuRlAI6zAVYDh0pBLCyg2DyNfF8Qkcyl1ymhxqz/kcSf/nNmBLDJLFOw2e0o0mIuaOXnM+3KwyK89w2dT+yFFfOO848g2wReUOXn63Ktvjxd66q9cyw3sOGPs3ewbEKW//xng0jVHjc38y4iS5oSNALM5vnwd3Jm1gvs8WCgmBW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+v3A7XRpmfrhb20IDdF43Itiviu0mx7eSFupWT4ihpqIIc3AJ+g8EPj3NaO?=
 =?us-ascii?Q?6wQOI3Ablqh3QceN5/H8UefWfRXWfjgauKmAPnvqKSIixRJsvB9RKVmz6Kcy?=
 =?us-ascii?Q?Qo+QXlJeDwjFwcr5EmT+9uwrnbB+Xx3PagzFuuS5j1HnOhsBEXBb11AMOAQn?=
 =?us-ascii?Q?076MsJ/2NgX1x9p8We63CMPMqOXvhvCix+5R/oMoy0sSnSeJ+4fgtq3pCJHS?=
 =?us-ascii?Q?XY/APHFXO0FEYd0oIFs9FM3W/yVb2xpoSEqHT6kynZ7Ncb+g09ZOy8hwoX/D?=
 =?us-ascii?Q?I7Zs41eALBqJTPIFFRhsecN/xc76bynn4aswYoEt1HE/mholHXZtF2bhFn3S?=
 =?us-ascii?Q?1OFUIFArVM8YP8Cr240SNVDOxDgym2GC59GZ3v/UyM+UPgBhanD/ZXKdXHFT?=
 =?us-ascii?Q?vXyBGc8rVcMjPj8mOMuqbbEgO53QUBzLAh5/Ivs46BS609+OERn+Be4aEeal?=
 =?us-ascii?Q?sMWWFElRfgsv/LR1UQGIJsZW9zRo/DTVFMSNbSqA1kFU6WPkFiTGMknPRROk?=
 =?us-ascii?Q?QovZmC4GUEj2ck9XB/lQMXe83ExquwokC9AwG9nEVLF1lUjtRpEggmzasCD6?=
 =?us-ascii?Q?dx4MPua2TTJpZL78snQh5tasygaSYus88G9xEUDWAAukR31doWKPAs3pHdpE?=
 =?us-ascii?Q?2SqLw0v/dJrVxaPTsCO3xXmE05jMyRt/RKva9GZSIPFKYHylmzVK6/MDfIN8?=
 =?us-ascii?Q?b+ctu9Kdc0Q/hWA7LzUabaDDI4AQNjsgRRmshdy92qRRwRP/zg+LJqzEUMXF?=
 =?us-ascii?Q?vCiE44KJJmc2PP2ZqW1Mjgo0umjovKQFmSljKdBh4qHBuHXFqZdvU2puy60j?=
 =?us-ascii?Q?ILWkClix8Z36XkjnzIyICLCTuI9T1lOVGLRNarPWfls9/uDHl+scrOzlvTpQ?=
 =?us-ascii?Q?d5AFzFKnHHWrl98+1WLboATNKGXaF2Sfz+ijsAsd4anXHKB3NxF8ArHs/yhm?=
 =?us-ascii?Q?MtrotfgpsUH/UyBUa9llxQrcJVQS/CZRwo3dan9j3R7T83LzBxUOJi7yAqC+?=
 =?us-ascii?Q?N+tzgekdpDguGuZl6W3U938ReHLnbual55ORiJUv40k3wK481Qnu0yw3Mdnd?=
 =?us-ascii?Q?b92EVbHwJHs9h5eNctZwIYtBFpM8esqP9fDdUViXVr7ZCimLwOCJ+EIR3CVB?=
 =?us-ascii?Q?G3N8WKRCHaI6vKxZKYbRmhhxPxovn0CnCvMSPKfuY2MlBR1jd+kd7qOcU790?=
 =?us-ascii?Q?Bb0mHedJwH8zhCv7SWlJ9jnek+fUvZ86Inl7OyWlStr0h9pb1hCMypxBWWfQ?=
 =?us-ascii?Q?yEk1ss/iH3w02S7QXDk6Ee4G84bW0g9Bm9FHCkTtyO3nc+KsWHqLAQzWe0IO?=
 =?us-ascii?Q?dqupY9TZd6jnwf8PT4iiI7xWe9NY9vezCFL2adgA0z7IupKHPV1QkuuTYe60?=
 =?us-ascii?Q?vZQWydvZjPKSUK3WJ2ftirALXOEWcHy0Z6f2h9Z4hNL0IsNnv6xMcER8MRLA?=
 =?us-ascii?Q?HLM5YX0tH1jnw3pRKI+fT0RWgisr96PDSz7g1NI4TOoS6YFPuiXGoBrem6jX?=
 =?us-ascii?Q?20EfWO6lh6TMbGa4hIYziramXW53oSFGFEGErduaR0whE8kqE+arxbVM9EqV?=
 =?us-ascii?Q?b8nbr4eXFKHbttogMI+FedyiurwSgVTAGq/E4tpF7He5Seb/rnnRBfs5XgfX?=
 =?us-ascii?Q?a59TYtr87gwMdGCiR3Dvhyxo4CcePUk0ez2HgL1hqBoQrisLHN/D5it8B9Fc?=
 =?us-ascii?Q?KcdUzFtgPl3Flr982hvKcanhiB48sdwsIOvv+xSuhvtHxn0jI129KhsL7IJ3?=
 =?us-ascii?Q?JOxYsrwq8KjNHLOhlTh7n68A7keDSkU=3D?=
X-Exchange-RoutingPolicyChecked: h7lxidu0+VXaSEwyxAHWsBdzmZsGTkec5AISe/++8E5GbVoDE1bIXzD2Jp7wVnXzLo0q25jXF4YyV5PWsIz6EFQnjOktt4aCi6+OmJBfGEQgMoJJqsQRRx7lSKwUZjtcxBqgeFGjRBNmdwnO1XTuktAE8tUDCG/8yiqa33xi34cHbxEkAAuFz2dUgx7cAz65ylYgoMg0Fa9abrAtO0C/OTIBPRoJszXk/eBpWA+A6xLMwceeI1NO7JKz8Xn7diztJQkM29hlQFHnYfoCkjp6A7e18Q+3tgmEcSCMNnITOeBoAUgOwGn9wv9IIzVG0dJ46lCsXdb45PP3It/7l/OUkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd5b053-cef0-4ad2-d50c-08def29727dd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:13:35.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50aiWmVh2sX+Dhp2kFUPibOONK3mAavGOYG8cj7c8SfDPAgE6MyfxM2Toj42HUBqgwTSzPbv1kF/jLJgcT+PAWeMiouIt5DOi0XxfCUDm2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 07:29:47PM +0000, Srirangan Madhavan wrote:
> Move the low-level HDM decoder programming helpers from hdm.c into
> resource.c so they can be shared by later reset restore code.
> 
> Keep the existing decoder commit flow and register programming sequence
> unchanged. This patch is intended to be a mechanical move. Follow-on
> patches update the helper interface for reset restore.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig         |   4 ++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/core.h     |   2 +
>  drivers/cxl/core/hdm.c      | 124 +-------------------------------
>  drivers/cxl/core/resource.c | 138 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h           |  41 -----------
>  include/cxl/cxl.h           |  45 +++++++++++-
>  tools/testing/cxl/Kbuild    |   1 +
>  8 files changed, 191 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 

Hi Srirangan,

A bit of deja-vu here but on a different file this time.


snip

> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..0df4178bbbaa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(CONFIG_CXL_HDM) += resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o

We can't add resource.o to both the built-in set above, and to
cxl_core-y below. The mock cxl_core.ko must not build an object
that is already in vmlinux. resource.o gets compiled twice and
modpost rejects the duplicate exports like this-

$ make M=tools/testing/cxl/
ERROR: modpost: cxl_core: 'cxl_rwsem' exported twice. Previous export was in vmlinux
ERROR: modpost: cxl_core: 'cxl_commit_start' exported twice. Previous export was in vmlinux
ERROR: modpost: cxl_core: 'cxl_commit_wait' exported twice. Previous export was in vmlinux
ERROR: modpost: cxl_core: 'cxl_hdm_decode_decoder' exported twice. Previous export was in vmlinux

So, remove from tools/testing/cxl/Kbuild below.

To catch this, run the mock build after any change to
drivers/cxl/core/Makefile or tools/testing/cxl/Kbuild:
  $ make vmlinux modules
  $ make M=tools/testing/cxl/

> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..6c09932587ce 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> +cxl_core-y += $(CXL_CORE_SRC)/resource.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> -- 
> 2.43.0
> 
