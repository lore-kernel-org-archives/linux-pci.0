Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA03C3458;
	Wed,  5 Aug 2026 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896932; cv=fail; b=Ys39pSGs0OIltCKbs9fJWsOTcDNcM7NU9fdl6trJgetstuZyCDitaFPsoigp6zsdRDoHYvgp1UgSSGIwfZjGM5LsqQwmashIUK2O7G2z7u43CMuAQkdKzEUaX8c/RCp8Sis4HlF4FdHBe+H50pG6I7MAOFWkRB0yHzD6lSVAwNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896932; c=relaxed/simple;
	bh=Y0gBsCA735lUarWo8OqHUhRFL8jEhQpRA5B3DcnUBSA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AfPAJuiklm8q1p7FTqwjfc0HtsjMNSTWuJGs3CMGSZmtsqE0Wtml1GxFetuJUXIDp8A7/fyEcKnqvXlmYouH0FooJ8nVidM8IZ1hHV9CFTYEE0oE6qa1AM/ekYUMimIMPmwPYx5+crvoL/OEHzbOCKLhbGl3hldbjIED9GGQQX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2craPsx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2craPsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785896930; x=1817432930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y0gBsCA735lUarWo8OqHUhRFL8jEhQpRA5B3DcnUBSA=;
  b=a2craPsxtn2e0L0k/c0TTldoVggxsM3bHWP5EFTd7pjX0dQe+rwuNG6f
   JnyKzGRbEGvMyLBfZ53WLr//cWEpza2JOSJ8+JjIZh+Zz36QLC/GeGH7z
   y4Wc1isDJ/3b9T61GYPQupRIX/B3YbKyjie4jk2OBN5842X8t3+y76mv8
   DfVX0npL+JhmitGyA7FPPJlIa2Q2Qk2Ih0DbEVL6KCALYx/7H3lzNaNCw
   EdP9e9pH/Khxb4L8Iqn4xFB2S8Ebo78wpVRR2YPZbxYuRZ5EWNV1rE/fE
   MBY3ifbxyM7FjMTeSs5g4j5H+9KeRAxKiH4bOtWrl1R4SHkBjK/oQT+tS
   Q==;
X-CSE-ConnectionGUID: jIB+dpUBTVONgzq6vZSbQg==
X-CSE-MsgGUID: 2j3YedPyQQC8Sc5GFVLrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97620437"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97620437"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:28:49 -0700
X-CSE-ConnectionGUID: 7OEAU500T5ugUFeOfhfR+A==
X-CSE-MsgGUID: FusbazyPRliObXelJPlomw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="266793809"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:28:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:28:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 19:28:49 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 19:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx6RzsCKghpqBu2oV5mXkgp3Ov2qGFRm5OFARw9v5Wjg0HvTBUBenlLzhBrHf1WwBXIuN8+ZrPER5yPmiXvTeHEiLAx6BoPKkwAUDVRNU3uzTKIomG2/90RPratySlF6+jnklZGPgbzh9v/FLZ79vS3RtE0Fvchwl/3nU4MmIdjF7Tc8ba02vC4Gn5BAkUH9lecEi72DNZ4K7R56e4nvtRenQGqLaW3gVezrXB0LSW5Uwp5PyVGjh5o+mE0Uj0M57b2wJvn+NBInVfOPqz22Xw8V4AXRt5NM/YcurEzczYYfCvXJc2dh+zTL+PpE9exJaw5A66By/Cq/nWjeoWN+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNuiyZudOp3Vp8uvZR9QsvPXqcoxDQ564WOY1dfSeKo=;
 b=f4xd1u55EtaS2HF4b9W4pE8hb8WQ6Q+k9Lv/YKrGz9K9qeR2mr0fZgL+OIZ54cp+WOI+NUOmsjV2dvFH+u9AGga7u/JhdL+rXnUOCWilz0Ef0o6r6MMfhOPz7IHrT+Xvy+VMFpPiAQPi6Gk2e+/i2Jd7Usd9a3VJy7T28HZkjfO6wHTyLspLxSTwL32XKtivU4LGRrVdkYLSPCJCe3Ny+tPtauWpIDqrJfSb/1ODd02NEFcyo2+hYWxC+lECHtKh8CP/lGmHiDF2Kgs0EMphX48Vtkayq2IvRnQ5A+2sDNBe1Pp3emui0+77FsG7MgdqUy2GewRbXlVe9QyuAZNUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 02:28:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:28:40 +0000
Date: Tue, 4 Aug 2026 19:28:31 -0700
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
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Message-ID: <anKfz_QxEaTVNm1R@aschofie-mobl2.lan>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804192958.1823952-6-smadhavan@nvidia.com>
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d9207b-93b6-4912-456a-08def29942fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: ZFNvH9RSPZ4oRXS5eOJNF0MY/LDckJ3di+fb4LFtARRT5ZNOOZxP4Q09YWzTgE9AdrtS3qSONoRSSsl3XK/SigkooQu4rFMJcM32S0zJGLAxZbEJFp6yODsPXaVshzWEcM5No7XedYxudwrFfD+sa8OKMYXmLD9lQIMUAccNPxg5vCtjsB7ZMWVnm6q0Ts3jFyl7FbpJUksHQ0az4R4bKKRxHHXgn2YSHCOE6r4QiaqUhYzm/AZmjCSH4uZvL0Yym8+3+JMu++qrS5I694LaEwFHxK6yyazs3Z+1Ph9kZ742Ok4sG0hWR+QUOUMDROdnleeQv4uQv0bBZSRPg5DQvQXdsFXJ1UMn9X9+bAYJcVWiL1ZbuPwOJtAssgudssAsN/sXhf1nlWUteHhdf33PNpUg/L0OL4d+PNZB26wC2vK++nVyEgPs3NUrnfixko3bPyzyrTWUSADu9Mjf1UPTGnPHw5Gbyp3wE1YSEC4kr3gwMjtACY+lPWdxx4Gmv2ycfOgaHQZbS7me4Mf9oNkIi8MvfCyM9pd78Wc2/wyDQjH/xEg3qHNs19OOQ4Sj3Q5l55j6k4X60gfMEnxGZoTa/c3zAlmV7TP8je7uG+iF2dn+nfNBzPWQJNcWQJvKRpdQ9v6M7oIa9mSXaHffrznCOvKZuqPK2BENh+jEv0D7Fyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrAL8++u9NoU+q0YHgoIbZi9D0EQukEwPnRZRYChuGH7F3lefQItmb36kjr3?=
 =?us-ascii?Q?JSOUbIdP2gVHtnitGKglmRvU6vHbqgB3IhaVkYr0e4Vo0yNMFzVw9nW2M/ku?=
 =?us-ascii?Q?vxYElCDitPGcg+hJWSvwljuQ5d/sJtPYEsRo+Bz433xgtJfvUk9Ro2IzSg0f?=
 =?us-ascii?Q?ZLD8mPWyQw/R5PmjnFSjWGhakh+6CtXEUcw4qIRSNBLaje+hUTrB0o+oOTiU?=
 =?us-ascii?Q?tEaUe13Zu8p+BRVP5u9rU/WmiG/waD7IzXLj+KUjR8H0X7l446wh8IloTOte?=
 =?us-ascii?Q?C3C0tVns/uTTQGdD62WAUms57A1vq7MXQsR9cdHdUKgKZ4pRVk8tA4H1oJRN?=
 =?us-ascii?Q?bdw56dSFbLGK4EoPcEEkxymdAwxjNjSO1h+4a/Ui/TdrGDbCY3cMOWdJrMZa?=
 =?us-ascii?Q?hU3y2bMZvFGmf7iLUNxztUkpRKiWvUxMUtBEfam03WjyyTbJintRRaFphZXD?=
 =?us-ascii?Q?YpAQjqetvSjdRnr3Z05ENvERRpCqgcyF5/TU8k9am7NyE6w/GbLd+g6KaV1T?=
 =?us-ascii?Q?5LRM33gsxDTaosqAQ1G+4Pkj4Ncq+qWQCBmPdsGVo8gdfTWYb3bfC2MhKyr1?=
 =?us-ascii?Q?0kuJGZvPT8MRak20j2G7gO8vWEVW/hG10wWrWxsitZo0Vq8TAjwhU1cwJKtC?=
 =?us-ascii?Q?BQ0kN88Efh2na6pV0bVxHghuYoBNH9+WAO/fVWCf6faBEu74V/E3SeMtXvh6?=
 =?us-ascii?Q?OSE8ZUob7G4GGSODn7wF+Bmm9XP1d6EW2p2SyB8tjJ/yzi3nY79bqbe3H4fY?=
 =?us-ascii?Q?tOOJQWKV4Af6JC2vVfBpsUTTntg2SYTGXv54tV7+mUbw4bOrqPw2inEM1dhO?=
 =?us-ascii?Q?qfnU1JSe3y6h4TXsZsi2HmXCeCsMWdry1c5B90YZBu9eJLh8rOKhIEj8ZesR?=
 =?us-ascii?Q?ZIGMymdLempXPuy+sJNJcx/BH3WaAXpf0K+/JRoo94JWcTwBPCqBKKO9F255?=
 =?us-ascii?Q?/QkHtMhfJgzihY/S7TkVXw9X3yFbYGsNr0M5S++bGzUy2M2wDGBMZthdy6Rq?=
 =?us-ascii?Q?HG/GgOBI/P++N1czChM2QJy4sBZw3Vzu7AISjQjWNS69Ats7w0g3brJDJkod?=
 =?us-ascii?Q?mKEbQiMNRcDWomhbK8ZfkYY79oPcqjfsqRIo2pjJwpF8D3ZCCHW34IR8K20n?=
 =?us-ascii?Q?CkRyL4lSup1NtjVrwNeryBboMJ8ZWtqBDzOKQCDLCVAIoq75jyADRnU59NIW?=
 =?us-ascii?Q?OfO7IGgilxNMEj94ILFN7ATNQg56i+fSkaVLq3MpoykvVj3mlPGTFcl3AdNv?=
 =?us-ascii?Q?ZFNN2+B5gsBrlSdbQncP/D+69wk+aQlU9zAlLkf5SYkhzbIuamRVNYg3O1/s?=
 =?us-ascii?Q?rXHccv6Zch1ShOgLvnUaO30H9LzOgELBLXQsVXRi4EeIpHfisnZR3bBrUf1h?=
 =?us-ascii?Q?7iEIUBdTWIETwxbNju7l+ASgU5gLeVBzxovY+KMd4msTBgH0M95l+7VAdpu8?=
 =?us-ascii?Q?021XqxuYI9oYLmP05Z95T+BGQuLGVakxN9kJgVTEW7p12wAors8DHtmryjvV?=
 =?us-ascii?Q?FUX16roI1BGDJ78DoSslo71oXXd+ANLSwkQVSbTwgERX6GMTDBWlPgjE6NQG?=
 =?us-ascii?Q?35ycAxBAYnIy0f0YRbLCOYXbCLMrNqmUaltpwEI2ay/bRFjfdc1xZV7h8yvd?=
 =?us-ascii?Q?lEajIu7fHOOH4qNnq+oWdFGpjOg4Eyg941Ai1Kp9DdK7yp7KAVFSYo3ZH3tZ?=
 =?us-ascii?Q?3KeJXJCaWMcrwKDNQRQ6ZD/kzvsZx3fMFvQCmZhpRrEuTSqC1k1DWE3FbXyO?=
 =?us-ascii?Q?7WlZ1zI5NUQ0p4nZ1Grl4zKfIgF/fsE=3D?=
X-Exchange-RoutingPolicyChecked: q8kQjeLP5JFKnavWKM6oInN3R++YCcavkROfGA/tdc4HZklq+ISkXf/eDHg0WxTfBdLPXuG5KFI+HDSFgJ/BUjnu+5ifUvZlLx8w+Iflkwwl0xjVl8wCJmNUVU4XG0ONjMBKHSlvnmtuvgqibLpcHvLnoNXEjodIWEWU/9U5w0doWjl0VEMDIbB8f5xL5FCnqkGPCgtrlixaIQG6nkJPOBstdZp1+x2ZMjr6qv326kPWxaPbUXZRe/vt95kBB++qbcHNuGWVsISsEj6sdJEmlGUpl2CgTi9ByVhSuq/7DXAMmhcy6qBqSh1ay8mIvw4KPc0cED/5x2xstNwuKgeuMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d9207b-93b6-4912-456a-08def29942fb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:28:40.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZavlBlCLhUwugwNQybdVRh6SR59ZSWr0Edn25qgbDIH9uH8rvYSVoZwUeHuGHYFp9vZjBpYGL12ZvFSxZPRljB0sulrJSaFtHqAM4SlPtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 07:29:51PM +0000, Srirangan Madhavan wrote:
> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
> 
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning.
> 
> CXL core reuses and refreshes the same cache as decoders are committed or
> reset, and retries cache setup during CXL HDM enumeration if the PCI
> bus-add attempt did not publish a cache. Move the register helpers into
> the built-in CONFIG_CXL_HDM set so the early cache path is available
> without cxl_core, and keep the cxl-test mock core from building a
> duplicate regs.o.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   3 +-
>  drivers/cxl/core/hdm.c      |  13 +-
>  drivers/cxl/core/regs.c     |   4 +
>  drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/probe.c         |   2 +
>  include/cxl/cxl.h           |  26 +++
>  tools/testing/cxl/Kbuild    |   1 -
>  8 files changed, 360 insertions(+), 4 deletions(-)
> 

snip
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
snip
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}

Needs: EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_init, "cxl_core");

Without that the modular build fails, CONFIG_CXL_BUS=m
	ERROR: modpost: "pci_cxl_hdm_init" [drivers/cxl/core/cxl_core.ko] undefined!

To catch this: build with CONFIG_CXL_BUS=m, not =y.
With =y, hdm.o and resource.o both land in vmlinux so the reference
resolves at link time and the missing export is invisible.

This failure masked the first one because modpost aborts before
Module.symvers is written, reads a stale Module.symvers and
make some erroneous complaints.

And, FWIW, with this and the mock Kbuild fixup in Patch 1, the
series passes the CXL unit tests.

-- Alison

