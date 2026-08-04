Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82435B63F;
	Tue,  4 Aug 2026 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809874; cv=fail; b=i7oN2bgSTrZHBQ6WHQTNPYp3T6N9CQN4ywg70oKk2GvKEerkZnO+dnKfRziBoosKhQwbog0waN59lDPIknM+pQtiJPtF0RWsIyPuTQ4Rm88wkgVYVjovH469sl4nc6mz/1Pc0ng/NXDfh1DwEKnh6uVLiuA40lNZ/5Fx/x98hco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809874; c=relaxed/simple;
	bh=aehhbwLC26U3rI2edoMtpp+vBq2NQYPGMr3y0Mbxrgs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iiFJQkriPwLDIlyzZvIJpkpkoV2xcGwZqxCDJEW2qntltlFS1aYu/JuP85YtPDZ/Cv1dA4f7D7ZOQ+IkWl4xvI3VHsoxwf2F3C5pDVRbct6WtenU/hI7gw/jeeMLJkghbObsxXRrp+zYaoJ2suV106O63d915MDorMKHvu4VGRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxKII5XA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxKII5XA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809873; x=1817345873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aehhbwLC26U3rI2edoMtpp+vBq2NQYPGMr3y0Mbxrgs=;
  b=PxKII5XA1WVvSDAiC2YxQIUdCQgzxZs/fME9v/ooV6jAeyY9HjpCw2E1
   t1bNcu2k42FNv4b3wcNjNVy8W6Fa9vXEBPHvmiZLbBKN8OVZVW3VYjRAB
   57YQwO2KVpYgtzUMTzZxtdFe8z4lXnDhmm/ORcJZvO+raPSa8yRE7U+Qn
   jIc8ACKH1K8auaBvycwMXZikKXaUjOxOaMgnpesVF4LJqhyOzTp5l6589
   T+TJSpVnmRHifVFFqIrdW3tSEVAkqTd3PzdsEteEZGeqvksR0TRWKyNDV
   cfMpmIsp4WunpElV4fAQgTU5Tt1+1BCCAZAW1dUlHwfbuX4pNcf6Sd4/l
   g==;
X-CSE-ConnectionGUID: OmwWa9WhTTihGyBlyG750Q==
X-CSE-MsgGUID: Us61rR/CRvaDvC1f6Ql5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86551946"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86551946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:17:52 -0700
X-CSE-ConnectionGUID: WzFpvXFxQTGjnOmEHdPx+A==
X-CSE-MsgGUID: Laf9Sxu9Rs+r5Nfy28qmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299603199"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:17:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:17:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:17:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy6mj8TPQulPvSkscQKHxvyoKgGZ3vKiiP6WS1IlKkJtL9gNO6tQqq8jE3pjegnEiGG/ca4mCHSzcqc44/DHXC8PTmD+MzMJ+Y/cNXJpgd2wC9XmchMwWsIQnkZSlC10tXHSAuFeGtmNHtNSUj/laCGYpgE6o3dEKWW3/c+35HQzhpryadX0Q/CgoOJN+QHKng35lmiVnmMNDVgb0Rj5Nn4pwE4/sCo4aSQKJTinUnevTuc/xBedRCWSUKr/moZfwHaIrzXJ8gplNenhtJBcW1UMqnp4Qv62sWAE16xmR2r2vlSv6hAucyQmP4D7gynuwvu3ONot2UTiEnan8D8S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oFzejVglGrvyIeE/DpKkku+PPXWtlZ9AjTJDfEjZdo=;
 b=c5IblRHCWJj6aKDfg1CUtcWmNrJwH6dXXUzn3LjeQlXtWjGN5nidmAGkZEgrEGFfVDBgLVzuXQCzByzCWWdkrMBnvlqS3gfAUiNo3y0fnPG5GYIsCVza0ezSEOBXXWfto8cRoJIYOilZX2BHTcyc3gUmSUlo874Lx70Ea+ZOOzoJNf6/LvECSWsYuWRLC88FgKaOQTBZ0txY6Wquf+NIKJDG+fnJomVusNVjQF+uskbPCOMDD7oSlNe2Vk2KjZByzS4XZ3btKWmyLN8v9erKAy6mVWrkMQrJkDpssJzLJQkuh02pn6g/7i0LN5crEPoV2ag3eZrBU7IuiGi6OHZJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 02:17:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:17:44 +0000
Date: Mon, 3 Aug 2026 19:17:39 -0700
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
Subject: Re: [PATCH v19 10/14] cxl: Update CXL Endpoint AER handler
Message-ID: <anFLw8s0aqBwavSb@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-11-terry.bowman@amd.com>
X-ClientProxiedBy: SJ2P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beb5cf6-02de-4eb3-643e-08def1ce9177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xhAgnl7nrnf2y2O1qzyYowYKDSKyIKCHC/ge75ZjerzGFVUl0MnrxGpTt3erZ7sN2vS44uw/Q/1OpNXpYb+87SVpzkUPSyqeeaU7EGgRn7IDJ2fqgwnto1ghwZLq60wK9F/MahOGCiXh8R3N7wZs532CFvR/AlpJKz8zU1caZ3DN+7mwqDk2fxM0vh+ru0ieor/vr5wiDN+r+IgAWiIQtHeq4O33H8P/bw/Z5LiWJL4OljCmEoBTRugn7Zk7VrGmXVg5SslaVNvNoa3g0Q6SlZRyf7zuP5SLKIShUZW141ImaLTTdRjPxhONsljE97dKyEVLs6uHT8EkncIF1yX2qSJQ+B285tPbeCmW9hCXN3U6uv+OC2upBJRHGhtEuTXWuIN7/OGt1aRn5gD36ywaWNwSM+VPHxXy9/rH875zJxZWkZ0N5LqnuqZIjlpyHlMILNZLAVLlg8TJyZiVzHQGQvnb2/eYBl71D+yvjaXIfcFU8p5tQ3rwjlz5uN3t80iaw5lK9jIM3BJMiOU3sLRsrH24K8eYpePaSeL0YTnCV+MWx1Ea+RVQvVH9KQ0ZbQ3ro7u8hgGZVwKS+zuEqePLQEv30jPifz7YPEczx0CNfJXAdojt6zAHyCWvvxBuxdJ5oU2CX14m7oPbWq4E2avxTo1TUsUv5j70Clj4kFEYDLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFh0cmIqa9giwfR0X6laI+jgLuGKyJYmfZgb1UdqnC44/3SzTuBHWitKxKrL?=
 =?us-ascii?Q?JxIS+X0YuA5YSw/PDRjTwACE0v+h+3x9kAG0+C7MhFXgO09oNm0eC6nwu5EL?=
 =?us-ascii?Q?RcxekCfSI/3bCPSHvsKit0iNi/HGBWqnWzGys/wkpsyYWan6FFjra8q5dBiY?=
 =?us-ascii?Q?kbiR+ntSKz1ZVff/oLGpmhvFCIcZR8MiPRW0NC80S9Ams8sGK6lqsBDLD1+y?=
 =?us-ascii?Q?CxM0ZWZRWjh+IGiJbCbbEUVVjS/Do0dyvlA8L6iOg7848oyjsxseoo8wGdqg?=
 =?us-ascii?Q?HW04R6pm0UQNbDyjFm0kWfoZRvmcrC9I35VuPIW+jsKzZdjHiwMpmFqtG4kf?=
 =?us-ascii?Q?iGxO3M6ytSaV3dPB1g/ndNL+/MsN7otC7n4qF1Jm++RpmjB9WJk4T+Lu0xKu?=
 =?us-ascii?Q?1Nmdd4z+922gGN6y0m3twPq9KKezvAEByS6JCXeZLCh1RN3VhIX7fi6eegIx?=
 =?us-ascii?Q?le0vxc/JPek61nNJ+EZHz2amcLym13n2Dw9E1b7oRf764afneFVVrBzTaTaD?=
 =?us-ascii?Q?VFMAuASephDnKfm4c+Rkc7cjqx95RG+i4p1S7KggxDU9Z4Ij9vv3AWRgDUUo?=
 =?us-ascii?Q?M9cvfFiAdGYk0wbgPgmVwWs3CL8HXUgqzMXjlYT+HsnjTng6LXcquuWb1/AS?=
 =?us-ascii?Q?QD3e4jMztcw9AXHC+cmwfhvuQhg1TkAz1VkGy9XnZBxHNQca4xHMvlRsg/Qm?=
 =?us-ascii?Q?PPSwTE9AI0SYuWUOvwprQLkCUl1wHFdDgP1zWg7Y+iTYOuFgoznv8cW7Zr2C?=
 =?us-ascii?Q?4/CniUZTNAEHL8LxnXDO76BbQLUY7ySt1smicRTB9jAuq6eCbSIgp8ElRwh1?=
 =?us-ascii?Q?wJGZF8YE5zdAWglM0qttOgzfLDLoyvk+dUl9ZQ+PujxEOEbDNzIZ6U6yFlks?=
 =?us-ascii?Q?a0houbPP/y7RC1HmAhomhEDMYae4szqER9eFR/FOHX/QINn6bZ6PTNkyeyZP?=
 =?us-ascii?Q?xA6IkHJo1EA3C9ZGVL4dQtC/WIFXZpcKSdNjkexjx1XJDA3NNWLL/RcvhUnQ?=
 =?us-ascii?Q?rnhIK7HSz90IGPFew4WG6K0uc7gJcYePM7FDnkUirQrvvQ73lJyw/358Jpb/?=
 =?us-ascii?Q?rdYrv2l4M0BRtLSuBfokMt01Gmbb5APrCBEBgevq+iw0Wmxrpi5QBKpCN0oW?=
 =?us-ascii?Q?gx0J2vE2pEvK5HIyuDu8p9XrZeQcnptFxNbqD9zEdvONXN4i8ObgkGhNp9dI?=
 =?us-ascii?Q?4NGgiD/npxfmQ7kTjeCFBzt9fnF0p4GOzA//1rY71tiDjEudoWquv8je1X1w?=
 =?us-ascii?Q?tQRc3rSTzAWadLmKLhsoKd11pijI7/beasyptYvRxwKMXW325d6MvsJlZNE4?=
 =?us-ascii?Q?p6syMBvGnf3SiKM/XMnyDYtrK3+svoZBA0+VGUpsD8HpygBrx04KC/4zdnKq?=
 =?us-ascii?Q?bgVXzy0yGWm4OaslwAdGM64Su6PO2BrivTeVm/6hWNlAHPcmI3dDwyTnQSYP?=
 =?us-ascii?Q?7y9XifbLxC5tcCqZJDxRYfoZZdaf0nGTPf2wow1s11LkmOtmudT8nMlqxEHK?=
 =?us-ascii?Q?T1yde0qS0ht8pAGSleQCs+UmqSoneQFXA6nTHcjivwVsyujic0PibzvjpvxF?=
 =?us-ascii?Q?iTyS3dNQGiCjoCT1WMSqgzW8WeOGCCIAT2I/N9vyboxFmhXH4lgPEvx+w+Xr?=
 =?us-ascii?Q?5SR0vLf/ozW/MUioVkAaZIERlLfi7kmCQey5HNnpPHd96jxuEiaHeaFy816q?=
 =?us-ascii?Q?mP7q5zwOY5sCRnqXkPEzm28I0L1aBVZBBJChOMbjBRbP+IDiGRHIoxA6fAts?=
 =?us-ascii?Q?DXPZlzaih/4o76Q2OU2WhL+KHedPxdw=3D?=
X-Exchange-RoutingPolicyChecked: KdfPl4lHV05/kZ67x46mrqWLa9+mBzbFWx1sUKR1tetyoLzzRUCqfmPBIKwP2uaDUdpN9cHq8D4avY7/GPKGE+NT5LsUEBfMrfwhO5f/whcX0AJ8aPvK1vfMgYe+GXs/zFo4hYA2UpvWX+L6G1bWOdC05LfQI7gQYurX4oSsyD9yMvPBlCVP7ipQhIyDV1AAzER4Pn9cccYvsNcdyNpsEXmsg/sMBcnGpD42MHiuTttr6N7+NVesZ3MNTKDBeUhNPD02h6LrhMUQn7kErxjMBz9Bul8BhZuxTJR5eVCl4axuJtcHOBqD50eugdsWiIshItoFN6ibj+ODpUcQt7dBww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beb5cf6-02de-4eb3-643e-08def1ce9177
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:17:44.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DnNI4/245hBdYX0ml+6VSHqr3bRlKYl/+HEyREFf4dx8i32SHrXPhEKVZNl+Gv2rU44ceGTrwleOzVM4v8z4f9xK0kT0EVEt6m7N+grUDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:06PM -0500, Terry Bowman wrote:
> Rename cxl_error_detected() to cxl_pci_error_detected() and rename
> the struct pci_error_handlers instance to cxl_pci_error_handlers to
> avoid shadowing the struct type tag.
> 
> Document the unconditional CXL RAS read policy: on a dead link,
> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
> triggers a panic. If RAS registers are not mapped the read is
> skipped and the frozen/perm_failure switch cases defer to AER
> recovery for devices without active CXL.mem traffic.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
