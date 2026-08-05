Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B536A352;
	Wed,  5 Aug 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955295; cv=fail; b=kAX6QrUOnKmuW6+OrQcZpMeKZVD/HCAmyzefWFPj0fdoMkdeepk2uevwg7wA2mFGQ+ZXmWJZc3KcSFMSHb7BMV9ICvNfgCXZeQlnkIGTSWpNmLLvlM8eUGiTXIGBbYo6xyBM/cO6xwQ1sMhMjxIGjQyaYM/KT94BOWT8bA+2p1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955295; c=relaxed/simple;
	bh=+oSYk0E/LqG2qPMygOsnD1bepdh/E7eLXRy+OOSW8jQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSp7y0swHmsLe0Jm/8Tcmoq/nq84s27wXDGpeKc2yP8oAC/j9SYd1zoG861THpiBYVNGN+XtTAgkmtuZ+yvurv9v/Cn/8bpqNg/t5adBY8GduTB2PvNEgTxIJGMQLzLyLrL9ukQbKvc+zS0mOdX2e+2CC/00cmYHv9SRKyZ8kGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIul3C/E; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIul3C/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785955294; x=1817491294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+oSYk0E/LqG2qPMygOsnD1bepdh/E7eLXRy+OOSW8jQ=;
  b=cIul3C/EoUcLwGHs6tjcSJybKyg4udSSB17KyJuyT6LqJZNXnyxV56UF
   /0ODSQBtzNqkPpZ36+jThAVfmd9YzQsMx+ybmffXtLYrQsi9DJX4FKCwh
   xs7wo4qgLEpQGDdYcxRI2i7pd1V71b/Udpzb9EzAYoktgrUnW5ksrNjKm
   rpc624OC+VHQYbEsGw20W4UKXkUp5BWzMHhmsMECTFueJeUtxs6TyP9/W
   9yccEHQN/78cgbv2s9N+JmTI0X5pv6GqrR/7D4SWzVOrrdOGX8qD9CFFm
   5xYSQOcCpQIDwpDft6913eaWY8z8zL2f1krcaPy/L1ZN4jBf0//qLci0s
   A==;
X-CSE-ConnectionGUID: 3XgOTm4JQ0WAHl1k/gqQEw==
X-CSE-MsgGUID: qgHXxsszRO+4UeS2DsTD5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104074056"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="104074056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 11:41:33 -0700
X-CSE-ConnectionGUID: +ps0bDl2QwSYH8VwG0w+rQ==
X-CSE-MsgGUID: zjidR7U3Sp2TgZ89Y+r69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="286542769"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 11:41:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 11:41:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 11:41:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 11:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obd9VD5p1VClJwgVaU7Dol2jD4WWikuedIMOQYSeWb24TCj5HW382n6qrK9ytVHwrTncp52vi5csuqg+NAgVMYtBJwdr6anADjIIOVQkbrN/T9pFYBSUi+evGslaMHpirBTzq5UDRQlZ2dZMMq4Dc7ASRPNBwBmB33ezlTMHbObvloaaRSQJxKE2gd5jOH3p1x7RFLMZO9OpodFpx+us/7sD/NhxwdfCevZ/jX/+AiPNJxEKZowypWZJWGWK7TntSNfwSIwBOM5Re/E4JSFnP7+hy8spPLy45LbrNAvZB+mJl0E4fXnB8a3xsNBdZsR2pah2T+qMe13RsBjKRWSH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/AZt+3xXgttd340dD0PuHT/vYWzr7kp47Zlj6Bj268=;
 b=WpyDTMMhCOq1RvV91ANcqgmBQJz8PffOfC8ocT06oO07jGNwGHwZjxafSpRfATtsQzmRY+/kMVYb+9HiYBSateI+p9hnAudjWHXXWdlpZPms3KBH8FRjRw/O/NX0QmQik2psgIv93MKUQC4xa0GdmrMnt6nJ55Zu91UvbmUS4MDHkHhmrJzmrxXssC/Yz4mnxOKV1oNETZphmMXR0f+pVdB3xQhS6iAQ2JLKonhrX9p7Dn/qdNQY+KteNQvCPZHtYi3zxD0v8glYh9j76u2pwPO8wf+hqLo+YxINaF34E07SMv2xrw+J83CW5wh3+OZwmFGFX+w3ZqygkbgWY32Q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 18:41:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 18:41:27 +0000
Date: Wed, 5 Aug 2026 11:41:25 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, "Len
 Brown" <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 03/14] acpi/apei/ghes: Use raw_spinlock_t for CXL
 CPER work locks
Message-ID: <anOD1casyoxFOgG7@agluck-desk3>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-4-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba7a93-0009-462b-7c5d-08def32128af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: KQAmjv6jYi0E1ETLJLI96waFpeoEcprEee7wUgQ96zYhkVEaaW9WffpwAR9D8rl1zciyTA8qRtXst9IwUbTAR9wRbv2gHnhwcQGm77mYOsXOKsRaNn1WIqS9NI8N6d9ikH53QHvBuxBjo3753+GLjWVEStq+SvMwCCl82gqFDrWpp7TuhfmkFdUPDdG3d1hdDJdrup5PQeulF913XJR8obdj/Xb/Wiv84GXkrid5zQxrR/oee+fGmGJnHXXn3huJd8+WXjaMDbC44+B7p/pTm6pP2Wzlc0FZ6bjRsIus/ZQP/1BbxJFjBSBnXsDrxMb0Tgq2y4JpIo1ZfMUV0l4XtNo3dwm8NXyYAiaJo1T+wMOkk9ay4Rz6pCH/Ep+jnd4htfYFYWnstrY/1iv1zf19F7Ex/yqeYyIKKY/OgSSmLKjdDMZzp7WccsDGjT+VnKBnWIwF/IAk9Z53OK3HRNPbWtLo0UbOnI1RDis+XRdHFvsJtnkqg27/A0OcfrcX0EUK9PlSsFa0lGvjj3oHzcw4jdpthJ23IQmDUvYThVKHzEeV6VzOtHlmhislE96Xz+YhPQEoU2TbVwib4VLzVim4+70tEBSiGVyK3wiQzCKjq4CS6dXTQkDlmXGQV/YCibqqE/eP0Yk5R16qo2lXUe4R7bu1/r5lTnSElsdYDw/vPXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJV5jY7jSsU77sScjljQFQaivP9tWzehzqt77ttbIZKUdst9P9zRvIotp63f?=
 =?us-ascii?Q?c10V8A+u7UJuAwjGaAii3wyKtJ15mw+APDJkIiyy8Fbfpryp8DRyrq1N0Khh?=
 =?us-ascii?Q?lS1om+RfC95OvPsebw1BotXjL7FPM0wmAK1OjA+2Zke/goyyvCOY/NVZZ6IG?=
 =?us-ascii?Q?CVW875HhKW6LRKAr3mQdvKHzeU5hZCyBEVURjCGapqMe9XYgauBcew7xCPWL?=
 =?us-ascii?Q?mojahxMZcIds70TkVW1Dp2fWxC4SYhBjqvWPPaNC3cZYWxrTu7t0Zb8+dhW+?=
 =?us-ascii?Q?twkLJY9GgphIWFAy/aPrc5gmKvM9hpgK1jzwJmbhlO2ubhZZwE1zstJ2pnY8?=
 =?us-ascii?Q?2o+nuL+jywNP7WkqeBL85ZTrhuHwt5qh8MYQcIEYTMrHVSx3YQvxdhdZgcvs?=
 =?us-ascii?Q?brgCL9PwvJR7jJ7PomB9mxmOz6WnifPup2LzBh1Dd+Opz3Vk3euVud6gFsS5?=
 =?us-ascii?Q?8iNk5pw1DNTxUjENVUAuVEDXkkguu7dXnHH8xkX6NpkJAHfszWhdC0fw7JTH?=
 =?us-ascii?Q?cvAJ9o1825+nAS1PHkZh4nIcWJO0pqvtRKGcjKQOJrgOqJ1mn+x+GjEo2j55?=
 =?us-ascii?Q?8F8PGRJAkHD4PTCyddF6cbwU8l/GqV2lvNmy4eB4m0BIevSj459fHpzTSWM3?=
 =?us-ascii?Q?gWaVprkqWEfwF7XcjIN1R3xw+gTzxi2Fjp64QWSf91PjLZ3LkDKGFbLNfhbO?=
 =?us-ascii?Q?0Fgyv3J3unl/FNHN8paUsh5zLRvMBoSX9PSUfQdc2f46vKLNYeGu+f+EsfRV?=
 =?us-ascii?Q?GVmZkwYAdS+jWhhtyC7cYGKLa7i/fAsQmQpog0BXTJKqJOChVlh49nEmx3dG?=
 =?us-ascii?Q?BM1/Sp/bLl9zQSk/k7uZawSTuXBmAUNqDD4mMKX5MzH4LTfgA+eXkOnuJWe1?=
 =?us-ascii?Q?IjLoFI9Zxi4JI5kr/qg2rImf+5FfGLTLAPdqsg0groBKGpIeLw2IHQUhrUZk?=
 =?us-ascii?Q?G/vVL7ZDMYGffgiEjD5Ti8ppeui0w5mzmEYJjpKh3DGZ/gKaQexnKA9UVmec?=
 =?us-ascii?Q?IZpXeBVu78ZUCwT8fff35jpB+Rk7YfIE2ZOsjTwEX5YcXuv2be2zyujqBZt+?=
 =?us-ascii?Q?d9AvcewO+x4atUBKXtx09j3dNbnjfYpUkq6Zr/0/d5MDf0W17aleOS33j+Zz?=
 =?us-ascii?Q?0JRvFS4Qq/RMdXl8TjhiQ/cJF1Ds/qGAGRjpKrmcP1NAPZprvSjxCMx3EPCZ?=
 =?us-ascii?Q?W9QIPN9I4/GzhC6ny23wqmMfIxsGSetYzoO6YgHwQ+bTFGrljcQD/584fxdU?=
 =?us-ascii?Q?PlXVvTLzYjMr7JVGSafIN16D7SxzZkW/zrYsxigx9vTu6N+Z1LaWl00C5Pi5?=
 =?us-ascii?Q?B4KjuQnf/vvdl14PzJ+ovVsgH5HtVjIkVasE69x7Kr7IvWCnD1ZVjvVsNIkK?=
 =?us-ascii?Q?gvpjDb0d5X6sUBtbP2cOIhCy6oFTkjXkvMWWBtc2kXTQNIKjQkMmN32r5Rzm?=
 =?us-ascii?Q?77g7NW+DOzbEiJQE9GKvi6BqJiIVQJ1i1v+xUHNsltW7LznkeWOSo6wp+FxQ?=
 =?us-ascii?Q?4IT+OzeWBpYGFQcTCo2MXI5DmcL2g6EhptqUnMkRSZUPhDs8Nhal5NNA0tZ+?=
 =?us-ascii?Q?6wed7UGoNQjM1oXBIes8PRtjMWTnrnKWdxGtHprudV3f3MI9vK7adP0/ewdz?=
 =?us-ascii?Q?XJLXM0LMpLmroVVsJXjTsTQDcDuKnsgg70RFdE8lP9yVJkXODmL/T4PkEGL3?=
 =?us-ascii?Q?z5nX2gEv0DPKhp5OhOhD7lnDHzQjLyJrP1yyODQveKJappEEE4903ESlke0+?=
 =?us-ascii?Q?Vmp1DWtnyA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QpSot/Rtwds1qB4iCKEV/JWI20V0wkmByBZfJGxm2ue7g5yGGgIMFDQ4fVHq/6pspXla4ilndg1Xq0p8PAw1V3aftVVS18a6VTGEGHYe2X60UK4rqaJbzgTJUEWmK/+KCivrjz6FiEEDgTpm/suGRWrTqR2mhO7Fp6730wsANTApMyDIcUfGVhRG4EJIxtTZeWSr5Plnn+8AXqgqzr9NpsK1Xt68Btbceca11aE2ZkojiCwe+QZAJJPuIRUpaNFzTiLhbSUOSvWigaaUf3MGyU6R5ARKZUQwsLaTTi41hvfLuIc/EWXYVO97gEDXH0N/UlDgrLuParjr1xbcQoGpGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba7a93-0009-462b-7c5d-08def32128af
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:41:27.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdYM0VhpT6YDIBXVt2fsc4DoMGDn/M5m2DowmCKG2CoZB0kIl1m/ow4WLRARtkhXFNZPwKnkIRfkrqCo1gvJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:17:59PM -0500, Terry Bowman wrote:
> The CXL CPER work registration and unregistration helpers acquire
> cxl_cper_work_lock and cxl_cper_prot_err_work_lock with a spinlock
> guard(), which leaves local interrupts enabled. The corresponding post
> paths (cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard
> IRQ context (they are called from the GHES error notification path) and
> acquire the same locks with an irqsave guard().
> 
> If a CPU is holding one of these locks via a spinlock guard() when a GHES
> interrupt arrives on the same CPU, the IRQ handler spins on the held lock
> waiting for it to release, while the lock holder is preempted by the IRQ.
> The result is a deadlock.
> 
> Convert both locks from spinlock_t to raw_spinlock_t and use guard() at
> all call sites. On PREEMPT_RT kernels spinlock_t is backed by rt_mutex and
> sleeping from hard IRQ context is not permitted; raw_spinlock_t is safe in
> both contexts.
> 
> Add WARN_ONCE to both register functions to surface double-registration
> bugs at runtime.
> 
> Restructure both unregister functions to clear the global work pointer
> under the lock before calling cancel_work_sync(), closing the window
> where a CPER interrupt could schedule work on a pointer about to be
> freed. Add kfifo_reset() after cancel_work_sync() so stale entries
> are not replayed on next module load.
> 
> Both kfifos are single-consumer: only one work_struct is registered at
> a time, enforced by the WARN_ONCE guard in the register functions.
> kfifo_reset() is safe outside the lock because cancel_work_sync() has
> already quiesced the consumer, and no new consumer can register until
> the current module exit completes and a fresh module init runs.
> 
> Remove the redundant cancel_work_sync() call from cxl_ras_exit() and
> cxl_pci_driver_exit(). The CPER unregister functions now quiesce
> the work internally.
> 
> Reported-by: Sashiko <sashiko@linuxfoundation.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

[But could this be split ... the commit message feels like a list
of three changes. No strong feelings about this]

-Tony
