Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661C3EB0FA;
	Tue,  4 Aug 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809474; cv=fail; b=FnuGqbC9JquDtDuurwFDtud12A2gMp4JriA3T6QuHaHDaM2WY4+wwJRyYADxUhfm0rBJrqgDLrSj0czuTWBVakuo+EKRTx39S8G0tRznatKeGZh48kmPQ8fD+pEA7i+pAeFvfEhWM5SK2D1JLWgo0phoP1geYKe0JFcfTtO/1Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809474; c=relaxed/simple;
	bh=tk4LDKW6e6vbvxV8r4ny/autXT7TXiwEKAefCBwIqoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Et7zQ3ZHZma1fI+Dt4ArnSv6F3H5qS5FOB1q3z3K356BLs1E0/7IdGfZIJnE2dKBI3RA4wSavSKXDpjbMKQQEIsIX55pG7K5zpQavGyGKtd3sYuKMsBuQ6LKnmhlT8711WfOciS2Waw3FLd5X6pADlBTTNx5K7dxkHkF2ufBsUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqoUsPTv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqoUsPTv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809471; x=1817345471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tk4LDKW6e6vbvxV8r4ny/autXT7TXiwEKAefCBwIqoM=;
  b=OqoUsPTvC+EO2oc+f5eUGqpdAOdxEvWmjLjuvEZPs2wIQgxlSH4NxZnY
   c+sNxGNf1/29dcTJdKWgZLP7VtmpXuttObF7xnRm05QpfYU0eDB2VynvK
   elXlafNJ8f1bs8YJxDeklGAAv8oPOzcaNj5al0VKppLKxK2mfKlBzSfe3
   s9TLLjsL08DkUCL3C6oE3z8mf1+jwEe78+VHaXZjgDdBTDqUgj1RpBsrT
   Hrvu6ewtJTzjb5j2Ql65ykUS+CK1UUD4XEVZjaklvSCrOIbT67p6u+lHH
   nPoq2Uk5QnXelR9VGFVDzm48POVtRWhYJLF1o8CEHMU5H6Vupn6RM6lhD
   g==;
X-CSE-ConnectionGUID: 6fXxuKhNT96kAp0CRVd0sQ==
X-CSE-MsgGUID: 3D0Ceab0TgmbUy5e73rPSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86551354"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86551354"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:11:09 -0700
X-CSE-ConnectionGUID: TzO8+wyaTYSe1SljhyjINg==
X-CSE-MsgGUID: cIaDqxifSSG7sFxENKHzVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299601869"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:11:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:11:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:11:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfgWB+u7EHl+KyAcDh62kZ94WMLSyA/b4IodKWX+sVzKc5o5fbCsAQhaGmR5h5OCD0d0uoW0UwghEfVSnUfV8mH+DKNo5nN1c6NHPjSeWRQRFaISooIEDEp6wKH5o02sduslCeYUawEn9rZXA3Px2lwolxMDkzt6yqkmybIbqm4bP/NpViWR5nNwhE1UyqngiFsKJ84JRamndInHAu6FludLLb+NT7N+tSFXS80oNfG+kbcx/uDdIOgvmsBcESFXHH0yrwfeXwg3Wrus9AGhBWzxqel9drpkkJtVKT9dMGS6QpvTYYW5lyGykoCvmVinAoftQCFTg8PNSd+VdrOrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yeub50LLkGB/whE+Z5xnYYULnpNGyBYscjnKqa2b0GQ=;
 b=KOTDf8uEkfOI212yuOoCH90NTcyiTiGWUmY1iPAUNznaQ12UJ5fNvSKX6u75VLWqdpiDQZIpTCocX6DPW5jS14dih8fHWpiCBVm9xHwxTO7ZU+0mRNtOqIJaT3C65qh6XhtDtoNJ+tzVHkrRr6be3bMG1v8BAwokfPIxgDM9UkKQDpkyN8N4ardQrii14zQje6etirH3JOg25XAccOd1OQT545AxAhM2vjFFvnzA8TB5n+Q4LkWZnlWGDh0YPvRaAAc5f0OxG6dse/BuYZ+O1T5FFQHcjiasflwrGsuaavGskYC4lBgsalEx/RSQ8P6zkASbYSVDxILG0zSZtCs8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:11:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:11:01 +0000
Date: Mon, 3 Aug 2026 19:10:55 -0700
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
Subject: Re: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info()
 out-of-bounds AER register read
Message-ID: <anFKLwmHtWQK_pHK@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-2-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 714d72e9-c39f-4d19-1f96-08def1cda12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: BtAK+OsfKAYLNnQ/k4P4OsH9mSGg6/Q4tLbuvB1/ZydOL/jXsZnt+KMd8j6IkjXL0vVF9gQrH1giyN22B+OxaeRa/5syY5gOhPaIJOT7pvI1A1Ca28a4J9QFWRMXGeT3paHZR4XJqyvZo2BdlAikaBAktp2OieqthkDMraPVWUFfyHyXlnpxEGZlLetBkZfZDr8wOY2qAcLCYSLkohUMdJfw6xE38iGNEjV1SlOXDXZU3b63j+DCm6KqKn6O+p066+aasVWlIoTWdCMY73jY9ZC+StlE/tUTj1PD3wg4GaIb31NUhXOxNmPSSHmDQHhGpICWvHF6nsy3UMydsnHlLsUVPzCUwgh/VYEYBZD+bRIx8PMX+dDt0UZXpJs3oFDTSQHIlUjnuHQYZF872YJ56wXyViKDRJrklb+gbaf6Ugod/YXr59+o0jxnVUyzza7aSVs2ZLgj1ZLYNM3JxkfD/USq3sfvdvnmuuEB3hHfj3iu4B1pytydNmm3q6yIse3+cduA7k2xjQ2CUJxWmxvZ6D/WWwOCSec5bFiyX3ElDwmaNM9Ts+R6q/0QV+VWbgj9Y00oqFZM2IatIbs9l6RIapcWEH0bD0UHFgtkA0WCWsoC+dr9f66oyIe2hfkDxCQ+LuZLzUkNW5wvVS33ATh38aSivb8+O2AVdsU9ue4Va2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXcnNpAPlifYPx8xOuSE7nnf3jSlkSz3M7QGyPtHfuu9dEdHQVhhYIAVxzzu?=
 =?us-ascii?Q?cQXgcjo1Obju0F+ZtbXVEKwkxep0q1b50nD3DpjfRH7iZK0cat7WwrfR+XAW?=
 =?us-ascii?Q?/WAqu07ukGZQRLATnSWNyRg88GU3B9s9g7xS2/z1DfYGBsLY/R1WtnwE7gM2?=
 =?us-ascii?Q?sur6h3ymOvy21sEB9Xioqzc+V9LzpsXbTvG2W04IU+PIoHkHZXLSlyVfPA7u?=
 =?us-ascii?Q?FmblzqSX8X8qNAL3Il2/slDCOpq5wkijXyWOpaSXb5x4jEe4w4FIDxa4uqE0?=
 =?us-ascii?Q?Xiw+UlhZeyOyJe37mAXr8k6qdm5HcVyuOjCqV4KtO8LigNTWq3ElU1GY1sB3?=
 =?us-ascii?Q?NCbvM8GQc3JUCrAdDRkGrpWHQ8Ni6Jb1xtgwdG6BDjfn4DzusJdiF/CQTJz4?=
 =?us-ascii?Q?rOhoO5ZaiKeYjz6I+PS6ws9fft5JzcSe7ywpl/mM7t66lI7SY1eQEUm7704/?=
 =?us-ascii?Q?MGYS6kVS0IjAwgUpocdYaDFph91di/7Qmw7Yr47pphf6ts/N+ljJ9OAEaX62?=
 =?us-ascii?Q?DwzI+LWelXeENE6Vrs9ANkWmzyyw8fkmuOBOypgd7u7DuBJtJbUQn0bSb0Ki?=
 =?us-ascii?Q?DsZvkdhnSrBho50fdcJYqtsmmIRQFrWadmWK+A78N6tUW2ikHDfLI+VOWpGd?=
 =?us-ascii?Q?7Nhi2EtuBY5D8GwtVRqcmWBvSZIziybtcnkoJFB0CK+2bUDJ46QAoCA1Zd32?=
 =?us-ascii?Q?6WvydiGjznyb8UY/9scBsdZAfUmrGO7+/HfLHsIrH9sPZRXitxTDjsnwEfNb?=
 =?us-ascii?Q?teWePVpUFI3KlrH2ALcUG95Rz2CEqJ5+q2izlUYLjH6rAic1MbNirNvZAbhN?=
 =?us-ascii?Q?SmVI5MVinUyRGvCmmSApMbvaNenM3BJlgxV+sVykx8j+eoCTehZftZpju0og?=
 =?us-ascii?Q?GWCAjXZFbuqznkMWs5l+f/J+Onzl4oXmnDOh/r/gL4ytnek1qnUaWeCE5FlT?=
 =?us-ascii?Q?j+4siZyfjJ6stygs2VpyjVsa0WoKhju5AVJ3JxdPYsFSw+p2aOJWu7N9S61q?=
 =?us-ascii?Q?8xcvOOCKeEZt4myrA8pZp8Y/reL+5S1uYceuTqcYlVGiXnvHRMAuEGlkW0cY?=
 =?us-ascii?Q?GRzpXtwrOQRqz79liYwsOxKlv4j9T2ZnV4LgY6p8zvtCut7SidPfKrKJI4W2?=
 =?us-ascii?Q?k3wc9r72sdOOg+5yb84VeLY6hZcmQpsEILYpQ1Ki9fhHHZFh96RmkU/e4UQn?=
 =?us-ascii?Q?g29i+/am32esknObaQxYa4QajTvzYm6kaRd4w+/AsP0Zy/h/xLwxZpJd7NZP?=
 =?us-ascii?Q?k8Juo8IkB9RRNVZWveeay2SPtIn1k+6CcxEWg+qvAXnmsBXRwdUuPqkwPC9T?=
 =?us-ascii?Q?u5/ks1a9dky9zYOdrrhKfLhaAQ8qY+LiJIPgXtxnuBX0wwIFk6xRIA2sLVnA?=
 =?us-ascii?Q?QhC525KUgjzX+tKAEttxd/ujshU+MYiQPiHWH5sdV33WT5tMK5cq4cVsQNXc?=
 =?us-ascii?Q?07ZITEhHRsyx4YZPOrGFcfxh/jqIYnR7buNmvMbdf70fr5MGglDFmFEInlUz?=
 =?us-ascii?Q?+Zfi6k89Gqv6RW4OkASYZwgTFrKu4UXpF1oSqcqkD1+ywMjni/1+A2d7gomk?=
 =?us-ascii?Q?AD8yXv/TWGrSuS8T0/74+LsMYU4byHLpvpGZDSX4juFEv9voNA7FIC43iWfK?=
 =?us-ascii?Q?F88LexGW2IHuH70jNebXKDuguDiH8X6Ze75CPOxXGFSMSSiipZgjPOTOMX/l?=
 =?us-ascii?Q?oKlHSQy9Ng6oq2hOMj6Z+DryRFO3gyZRgwFvv8Qwz3P6Inhkozv9a4WFKs3W?=
 =?us-ascii?Q?8i/tYDn3WqTFc2QgciOzZVdHQzBBprs=3D?=
X-Exchange-RoutingPolicyChecked: BFJqhgpMMoqoW9oHflFmkEoIA7HOOevp17WplEIqB2DKdRXTiBMThFe1ew5FaCE2otwtXDP3HQR6HF25zW52lb5c7//8rPp/Y7kIQ30DP0n5ZR4LFBVfFxpoATIDWyunQkTfCGWN4o0BdGoDlvnWl3mC+vfM46NE3wdKcKl/zotCuawynSCDg99o/uVpTZrWEIx+Fvhi9syK3TgjBBGK1rKCcytI37GizqAUs79AAOKIsLcZ80YuSNwwwrnPTwbuT8OocRCfdPwmWSsHNXllflfNUP/eEed99itEKOd3ZCIDlwLzh0OJZtXEw+gOg0NKqnYyczxetgmMM2FCX9L50A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 714d72e9-c39f-4d19-1f96-08def1cda12b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:11:01.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMgzDesydPZrwrSriySKh9PsZtgVUmD1dVNvOjXsHK5+QsnF+X2kafsq154FpygrtTnFmEp8Rcb32qWRp2lXTdfxXz5uOxxvoCibcmwOiW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:17:57PM -0500, Terry Bowman wrote:
> cxl_rch_get_aer_info() copies the RCH Downstream Port AER capability from
> the RCRB MMIO block using a readl() loop bounded by sizeof(struct
> aer_capability_regs). This struct is a software layout and its embedded
> struct pcie_tlp_log is larger than the on-wire AER capability. As a
> result the loop reads past the mapped AER register block.
> 
> The over-read also populates the software-only tail fields including
> header_log.header_len. An out-of-range header_len passed to
> pcie_print_tlp_log() can then loop past the header log buffer and cause
> a second out-of-bounds read.
> 
> The read was correct when introduced, but struct pcie_tlp_log has since
> grown (Header Log and TLP Prefix Log sizes, header_len and flit fields),
> so sizeof(struct aer_capability_regs) no longer matches the physical AER
> capability.
> 
> Bound the read to the physical AER registers, header through the 16 byte
> Header Log. Zero the destination first so the software-only fields are
> deterministic.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
