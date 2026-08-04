Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60D3A4510;
	Tue,  4 Aug 2026 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810475; cv=fail; b=ELcpj7pxAZMNhqcGEEsBQSGC/WJIs5Kk0fVOtsG3qxlcctJnTXFCEtay/zYL8uD2HgWXXA2vcxFD4hEo+2FQkEexTdj1IA4OdTZMlvcXL6qqUkoF3EYEAQbXFYln7ecAN1ec7+SZPA6y1MyJTYPzLo8NlbEjMhmOR6bdwe+bgvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810475; c=relaxed/simple;
	bh=PK2LY92L5H/fMWr6D22s/u+KGzNnY7zAD1fZMuH3gxw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SG/WdJd9c9Y4mb3prtk1cBosOC2M3TSOQC89cFMV4Xng0fye+A5FqWHwpdL8zfRjn3+kJ1D+Nv1jfSyWgGFRVCO34rHsrKxCHgAQTcsV1k7n6tebpnTZmaAj4r8kviZ/MwOjH8HocGc2Xb3bIn7iUrE17g+oqwgn/mpA/trk5pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXFdhqSQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXFdhqSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810474; x=1817346474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PK2LY92L5H/fMWr6D22s/u+KGzNnY7zAD1fZMuH3gxw=;
  b=fXFdhqSQb3d+ppFQXYwgHZX4rdgvBwY6dN9bpasgkvftvBiEdjWfx3HU
   IF2c9+pSr24J13YpN6qkHDIeXYvtrItNnyvf4lvzxL9xF/050DfQ4ubX7
   wRYEzCosmq2AN0cyI6chEJtiBTjORnL5mLin8ZNe5TEy42EjkndkM8mK9
   TYjCTLgg3lVgy576pV3gSpLt5eNCAAg7Gx3D2CObPpBxIPkExTiJ4yffl
   Vpwv7ooz6NGoYJFqx5cm+f0yncVw++Rj4GOqNmjWdT2LItx/YG4dQMXp2
   A/2/WWxbTm7/JI40FthURD4vHXnS1EQcmXEOpUKEXBjY8jDw3lK6zRxtz
   g==;
X-CSE-ConnectionGUID: owiuVFpCTBKbaee9lYajrg==
X-CSE-MsgGUID: 51AZ52P4SNKtAh/7OKFJwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73891008"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="73891008"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:27:53 -0700
X-CSE-ConnectionGUID: AWrnVZ77SmW36s+jEdR2bw==
X-CSE-MsgGUID: v5eunD1YSyeaHr4dIRLmog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="257493877"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:27:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:27:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:27:52 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW0CZTHYXx+zmrK3mmmp/IWx+kl1ThdaAz8TWXbmArRx6EW7qvepORm1/c55LFrKmaRtdnTYerGKG+EdUFbHLkn8ZjnQTEMmtMIYO/okIa87bvZhSs3VSyWVqgYZKpviF9AMKpCz8UPJ1LeoeDXY8ZOlUOimb2tmsoX1pKuu6p1wgfI3f+OJJSNHNt9lofViUdh4tjDPmyXzVKBdNJjPLzXnXP9ZpPmM7G0dKTm16umy8mdUCbRVUSZ2U9+tDnFtoD1XT2hnSfZbsQbJFB7QxDn+eAwbNb/wK6zxE8JVzwJuEZuKAfh8e+ZnWGr4jYsxiyaC9HeCGLSa5S0MGGBlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLSt0RSWXvos2w59Z0CcjdYTfVQTFQ7+jLSb4i+UOj0=;
 b=dUyiLvOi7FmnI1sRbVWPUhwPnFiMRVQORyPwHrzxXhrLcQq+9uivaYlfZUuJIWOHMGVem3cuprNzV9l0OskRvrnMRRkCmqiNp6HCZn4tCZWcZvdTYBsUkYRiJ/4pGIp6noI/VRKVhqQCVClAQmIW7C1ePsK4nVocdqavoFMK2aadT83/mfn1lWuBeuKxs7POauwI9AglMXGPAwwFmzt/78qw8gCTmT8ALkkfszth2LKcXXMTL01rUZzeFhhFN10h/wqMzu1jNNVy7F1JIiRWytrUpq1aMVCTqsfyZQmq34vwz73tjXVdiD+zNFPJC0ajLacURos+wkow/+fx6Mmy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFA0B9CD929.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:27:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:27:49 +0000
Date: Mon, 3 Aug 2026 19:27:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 12/14] cxl: Add port and dport identifiers to CXL AER
 trace events
Message-ID: <anFOIFebBtNJ_s9h@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-13-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFA0B9CD929:EE_
X-MS-Office365-Filtering-Correlation-Id: 8347bd29-1b0a-41ee-1f2d-08def1cffa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|10067099003|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qdd3sE0fiTOhobdNBHbacl+qKBzfbYS5zWj1mDq8s6srL4O3masSun3UPogXty7UFrPC0MOD+uiC8tfjM2wisZ8dZIp7K15ghWQ+M8uLWPKmuw38Ytl7NMge+3k3TTg7R8iA6dmvcSo+8Vg4Uyc9/SPMxd9uDQOMiyxHU4KSDnDadhZc1CKCDqfg7vvR5fTChwvaEkaKQ7RO9KE79GfsEb8wVcJJ53pb/7AxF0U3AkYhW6AgMz+I5VmA5xtSMqjYkW/kYXX6EfeyicKJcrJv+2N3b9muMbXTRKyaY2La+3GwVCgUjxwh1egNtlWugfobiWynD8huZMWFii8oMWfrZydMWRPtPxDkiPpFmdbfwlIxZYfnUQCXzaSXkHVCNpWv+a5Qv+hbriRQYwcQ91zfnL+iz0ogL8T+c4IC6ulcVhrHzck3nIJoLBsnd9jVhp2bIxUcWKdW/caWqP2iFVi6aM6vcd1UTEZuvqJKIatwDpB0bMj0/XHx+n/3+jrDdI4J4ZP+lizdPyyTjJQbFatFqITuKkcgMP97zSbX1Bz8zyuvy7oUv+WcWYcqbYiwBZdY3d0GfvsRv32edQS3rNFYN6tLLk/K6+LE6eQaLm1fTtZB8aI7Itl1QeJUPpMKE/jxCmmKi9aq+xAu1yaCgxaE6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uw6twI5RM2MtvUIEeF23HOiDszpTSYpk7+AJD8swjzylQnNC4uKjYrceD8E?=
 =?us-ascii?Q?P3soZPvBg07Ef1ucRr3ic4kRz1B8fDYI9W7/YtDkBWSobNEAXmIyORlDlvag?=
 =?us-ascii?Q?ejoVHl9jVgHnVcAnCavoH6QgSBij327gsAfS/qgNd8vWx8HGnRt2gUNCdgDq?=
 =?us-ascii?Q?aCcW8tXgZjdBEljUOvZalj8IcME0Aepw2QCmY3YdIM6IZyrjSpLSJ/5r+1/i?=
 =?us-ascii?Q?kHVIfwktDsbhITHgifpffOfTGy3v9Ay6noee04bPPnEBXQxlkWjLbYeUqsk6?=
 =?us-ascii?Q?zcJGgRCahCcRYHFm8FfSJfUlEw93wfph0Lz5dINB7vs76BTqlAbuwpBK1D9c?=
 =?us-ascii?Q?GYJ4Te0iWOXlKhJTmewfdZK+hkSgzLUUaqdkCOEPAoPQf0A0DOmR6yvHKyLv?=
 =?us-ascii?Q?IxYC4crk2bmSoMeh5/OLW2MnLxxCkHMsrXNZGmfbVgj4/5c0kBWl1I2VD5KK?=
 =?us-ascii?Q?r3xGTXfur6QJjkqZTK/EHxsk16DY/xPmGq1bd8AE0MeOXY1ockSt0oo9bLfM?=
 =?us-ascii?Q?b1YvwzP64l50o7xbwZ+PDw9DOl+HuGy1nOuXmpXnFcpVLPYwbN4Wj7KT6cD+?=
 =?us-ascii?Q?LxfeU2BcPDq+AIHl76z1OvzkNFJT+kUELSXtypUSB5uIVgMhxmJYecMRUyIJ?=
 =?us-ascii?Q?Q7VoZVAjmMQpMYR1mXidH/9MSozvXqX0pHhG0pDvic7liPHVivMxw+LhH+kh?=
 =?us-ascii?Q?ybas+dzkgvKdakU4jLuHdE7g/gqLKx9oCFQo74wZGynWELBtRfv3BoYoLFx0?=
 =?us-ascii?Q?uNe5QgLpBmCM/lFKwqFEOnCKUiYIr4Y1vVz4iTe/tbhslyfLMy1MSDG30ksd?=
 =?us-ascii?Q?Ve0SuP8NXrRRLeJfdNpeAmADrSOyZfapwoug0PC9OUnBwZ82gM7+nrmmhrC5?=
 =?us-ascii?Q?qA1dmmLGrLvrgVIICGlFWNVxAM5Q9OeM+Ev+gjQ5f+5TWuUH30OA6cUuZDNX?=
 =?us-ascii?Q?34dILQHqQ40ssCPQ0MlsYac1Ffs89/iQCJqPJ5LpOqOR2PSsFPRs2DUpJSLV?=
 =?us-ascii?Q?bRbR/Kw/0HI8eU6Qrnk6RP3OyQL69rO4+SUZJtXrA8hEdm5vaEjheIst93we?=
 =?us-ascii?Q?qNzyVf+/xzWuldVvSPv5pKX8A4rNRPL7pxDAfen2Ho73YWfk1ZeKpy+6DwHl?=
 =?us-ascii?Q?U1MnNS9KKgaLVhMWTXN8ZhW3X7T8Re/gVgN12WIFpTjSrsimHc/YP2Bs4WfI?=
 =?us-ascii?Q?xjh0/w1trvDHiS1aP+e6rQ7YQJnc7MY87xuH6sOEI/DZjf1nT8/aMlHyzqPR?=
 =?us-ascii?Q?PJ9LKa9XThl43XviSSrUDuOkCW7jAobAXDAP9R5mYl6jPodwZI0e1L1OVFOX?=
 =?us-ascii?Q?Gl0xIOFunflCKrqIl32cdcdM7PzN/O5pVd+TGb1piGg7N8yW21Gx9sVDCzib?=
 =?us-ascii?Q?fvmLd8qH8mHxSevcgxKVUPDQGSmYoxheAq5EGxYfCR3gCIiWRrd2RygCY9S2?=
 =?us-ascii?Q?cAtp4FL/RPFo5dM7PqQB1x1bjDS3D2jeVWau1ypcIaUPbV/sfsBNlW2+nRqH?=
 =?us-ascii?Q?Lfv1aJC4ItsCDyDhT01O7Wt18e1UNQgNezR94oltC4ZiWZNbY2aNaBP0taja?=
 =?us-ascii?Q?8Msq4Ur3VRxj0yaYccFMmIYnqhSYgB346ULdAoxDBmDmgy9p/2yC2szJXpJc?=
 =?us-ascii?Q?+Fr24rnk/RVdwgOSg11rzp0seorz8d5u191+gmybQhzk33bpzxEZXnx/LFCJ?=
 =?us-ascii?Q?WX7BZcIQo+p4Ph1QdvWbcQkR2QiEzVF5K+iWuzZTwgrkPWQG9+cEEKVSBsbF?=
 =?us-ascii?Q?RSrkw4DmgX81XRL1SnjQMp5QRwLK8n4=3D?=
X-Exchange-RoutingPolicyChecked: Czfuy29stIfA6UeWA7hSSJPGUthzJ6/5wG4omkEIs9AyPg9JOT5cWfTiQaQkRBkGVmvPPO1/YLtPAEizQkeSawnSfxWwv6VkTEdXuUnwfbq0LzOYfOIqYFVMS+igyVF++VzCaG2rBUXf7yHPw69pW/wSlK0K/6w67rSH6qRoxb7DwGVjIJsVCQ1jRSJ8dJLwk/lWrZId9ZyNov5aDvf2xVPThue6SUdKUfOJtown48jt1rav3bBTfrq/yphuVgwOnYsn8LQWyZvMj4JBdKxjrHtZdbPlfBSXWDPwHFqBX/oML8SoffLLU9J8kTIfcLLVoNjjd7pxmNyDPsfpBlXaBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8347bd29-1b0a-41ee-1f2d-08def1cffa75
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:27:49.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkmUI4ePsjK3FbkKRptgfWQFuDcf0F4tuDqZBx1AQDcmHi5wOg0mjKqlT4UW7uZd8Be0HdvEuOSGoCPpQQt2VsJ4flbV0it1znTYTy14Egk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA0B9CD929
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:08PM -0500, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
> trace events instead of a plain struct device * derived at the
> caller. The trace event helpers then derive the right strings for
> Endpoints, Switch Ports, Root Ports, and RCH Downstream Ports
> consistently across the CPER and native AER paths.
> 
> The unified cxl_aer_* events keep "memdev" as the legacy field
> (endpoint events populate it with the memdev name; non-endpoint
> events emit memdev="") and add new "port" and "dport" string fields
> populated for all CXL device classes. Updated userspace can key
> off "port" and "dport" without a parallel set of events.
> 
> Remove the separate cxl_port_aer_uncorrectable_error and
> cxl_port_aer_correctable_error trace events. All CXL AER events now
> use the unified cxl_aer_* events with port and dport fields.
> 
> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
> the unified trace helpers, replacing the per-port-type branching and
> bus_find_device() memdev lookup.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>
