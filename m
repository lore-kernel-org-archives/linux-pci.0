Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2A2E2EEE;
	Tue,  4 Aug 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810566; cv=fail; b=BuYdEx29TkUyL2xd8Lh6DFQF3Q/ofGU6oOGzO6knz5pbKMJk9oBODbTFmCuVaWMzPn2l/xRCGRxSS47NSkjuTuNnL/wLaJuy3PoIn45RsI+GRiB7sETrv4IovHThnonJdwk911Tda7aAKjHM5lA53h6k1uxPn8YIaee4tIZqgRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810566; c=relaxed/simple;
	bh=hsqBWU63/pbEM4ahwfpgfLyVyYeAMQNZsbzV8sg0uhg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pdz/FHMbPeK3g/bRL4P6YaeSC9H6+Fxqdb0QpeGozGjvEUpdW0XSQr+9GIsQS38BfQchjrSl/3I/TZD1jS+jZ5nUsljE0dJRI6Jmo7Mj+RlSWR9eYrP0MvlIHka0tfdWgZB4HYbOCnwleNHzcXtoBilRhlkFLlb3Ov/0OaaGmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRHWnOuT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRHWnOuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810565; x=1817346565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hsqBWU63/pbEM4ahwfpgfLyVyYeAMQNZsbzV8sg0uhg=;
  b=SRHWnOuTH4i6gBP6FIVr1KiJ9m0DUNkfe/AqYLpNF8LiGb8SYWE1qqzP
   BluBaw+qfXd3BzxgQbsg1xT9WCLwkKmCkYJR6mqc9GPpwGPJFijntzxcR
   Av8Uj9hEbEhTLyAkc3c7jgPfmdX0QLa4kQYsycPgWweiOUa94WFLAW4F9
   G48zCqHBh4IIXxyvGRwThABxN4ilDVqtVdLivUMvssqAPKc1CTJAKvvLm
   bnvcX0TZhIDzCWkwOafbenfxZVVeWHKbvb33NR5P/vEALHNiYyvFC64qD
   lNmu6xJAE2oFm2s5YMRUJpt+ZH4fFGk7RG92yoQP7+5KV/1J+vQsQww2t
   Q==;
X-CSE-ConnectionGUID: aQ/SYBPRQfun4m7wHOib9A==
X-CSE-MsgGUID: 6W3rWxQXTtCXIADuB8UPSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86386781"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86386781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:29:24 -0700
X-CSE-ConnectionGUID: OLEdzoLVQZKWJqT7Yo3BBA==
X-CSE-MsgGUID: W8W5u+VhR+y73GHJwt5DQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299604424"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:29:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:29:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:29:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se8vyJNeMnqWetjBrA5ucuCURLSWNyiqv9aisPubtNZSPaGTfiVpvwaWH3wCGI+FyuV6SZFw0hVLAZ4xwgo+6rtJPMV4lxdJybpobaCxKkYMP7a2JZeaZZZplu7Wjof6s23r411RtVlOpMav6KKK0JyVTiwLNInJFTrUdA1/AvAoHgHMTokgrCpL3uZvq6R2wPg6M+qC18oke+pGvwotAn9GHoPF8Ry1AtVJ0U13c3MOBRg0SpewCb7H9DVDBF1wWWUpTioIa+UkE/E/Gu/YGE5S9HD5vzkXuJtfF29SqsOerm0zJhezOB84KRwD6C6S+lRXS4WFTGY+1mv/UUxdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+a6I2RINtwbQAmwiToj1b9dTTub0HDrv/egsHwfgvs=;
 b=o5Gbz/qaMB5988WIPcbWSQ8EQl+/NcX/Lt7s1im+olfktomeu9OYLcUwut3npfT/i1WkNDVdpWPUf4T2CbQSQGrpvnCRmnttc0D89N/nuEg9dYhY90An/GoFn7Xy8Y3w1kDtf4U26LB5s4+MEpYYRYL9Jt2GhB2GyYgD/ahI3/IMp1IxRQ87x8140b79yslbJkpWfjtnaPAM5+3daeblqbnJeV261bchwRmcNJCbpFT6GQ4JTv+oee8uUYp3CvgZfD56K005vEOyQ0+AiMn0C1illop4QfUKRm2GCFUpyaKapamySSurbd80b5pQw1xNqYpIbSQ9Ma+4iC7gpu7PfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFA0B9CD929.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:29:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:29:21 +0000
Date: Mon, 3 Aug 2026 19:29:16 -0700
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
Subject: Re: [PATCH v19 13/14] PCI/CXL: Mask/Unmask CXL protocol errors
Message-ID: <anFOfAKCMM7UZV2M@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-14-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-14-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFA0B9CD929:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fb0b09-821f-484a-18d9-08def1d0311e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|10067099003|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wnMwxzJpDr2K7fJ6bzNPa59k+MhyAQj4N6OBbTQFa0ETi8p2vUHhxP0tJcrfddym62osHBWSCQH0yedTXA6vpAutuRKB2I/rncSorXjMrNXH/+jrfmrGuyBk7P6PhO55/AxUTyy1qRqTdjCPNjln6YeRJ7e3021ZGefyc0d+vcv2SuQmUMOaGRJ4EPhVHsyvxRT49nTUU+TBvmRCadIL0YlopMs2o8WvLgxAoZqXth1jcG+OUMh9IbwVKiQcv2T5YXFFUP3kxK2yrJw+kEnq9yBppS43gqd95ME85WBj91Qv0vTtzQm81KpsIavUCxMMYSxaSAvl9m6ofhO5V+r4GzQIJOdDk+S6fh1U9nIPpWwNjyIIIM/wLdPmfcmHAvMIWdXzx4scERX4FaGjMAprz2Zm8l7M2+TTz/k7EFvE84Yyn0F7/+BOZfJLofB0JMzmBQdqYqZi85I2NMKs5sr2yFsOCziPWrbxsXFl2VgT01ND7mhAXXlrd1pE1Pp+B/L5VNVoAbzXikSb39TB+DVuU/CSsyYHKC16m8P7VzWtqWfn7OMLoD6qPmuZRpTOBNLbnQbneVZePeCXTPPDyw1MAzUzSaaOgQ0QkvJY68lRzo7COwAsJgoqJAfvu7RFA3ynh0s7YJXhUd4wXHZ1t1ZZmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35tl1U3NDTK8bU5fkp9X+ojjWRG/6gNLnWc6KkeN5FYCJxaCzmzCSwX/yUGI?=
 =?us-ascii?Q?MtbEmq7PQGfxkvm2/YeDeSpghqV7B/DnIXmI0kdeRMYKVczCWxy/hZmnP23I?=
 =?us-ascii?Q?LUymhPGqQ+VmrTdlTDynFB+KfNi9wmLXJe4svzqKXn9nw44EqDPsNneMC6kZ?=
 =?us-ascii?Q?FTMESC/A7D5fsMgVAHfCA4P/bVLSJqcaxlYZjkkEHkYNqystcfPNODm+EiX6?=
 =?us-ascii?Q?p4Ze8VkN1UpM1zjBukKHE086KB/M4vv/8D8F53lAowee022+3CMFM/jEFz60?=
 =?us-ascii?Q?sFKslQRsNYYXAGtGnf9ffnweAeQk6LTp3nqlATL0XoncRl30ozw09gnXpHK5?=
 =?us-ascii?Q?2qh+Os/N5DkT3Q8oVcxPJERMuSKcq2bcqR1Rn1vLcqGGjWZeQQXT2MgT2sDK?=
 =?us-ascii?Q?IIsMYK3w3hSdwjrk549DRV92TcBOzK3AXcWrdXQuy0cR+YKOhCNXOjuOLjLB?=
 =?us-ascii?Q?z2Sp3NqegmmqiBCZ6yNZ5Yi8RTCP85MUX5r2BNsjzMUpmNsZpG8pQaJSyg/7?=
 =?us-ascii?Q?/DRrdP2PE0Udh1I2rrMC6GbmOcHTooVUiALxzGn88bJHAKYjF8iB/Xm9stWZ?=
 =?us-ascii?Q?AOKz90EiYs9MRl6CKKwsYSoZbAKGgaDlLAs8jxQoP8CLq28dcedu5mJGQQUz?=
 =?us-ascii?Q?3ZzzazuNA/HuJqbz1z4RqPplh2gZFzLnn69rdXqJEj7cenG+NVGsZTdO0fl/?=
 =?us-ascii?Q?IAX/Gmu+dAjPm0CY8BeFrmehFdk3awmirw140EmSOOIMc/PoXUduJ4/F1Phl?=
 =?us-ascii?Q?jzwSiVZjPjXIW7JUmAfNWsGUf6qz5lepm5PRop4XyfvAKEWlyFnRSzyg4Axy?=
 =?us-ascii?Q?K/ou4GGr433vmTthO/aPWJyTKVmCNgAPisLRM79kaqAbnO/19Rx185EvgeSV?=
 =?us-ascii?Q?Pmodp7QaPJlZNAKN0553p0v+Z5p/3y8kzfGgKJQ7LgmDVTm58MsTWrjvXAYz?=
 =?us-ascii?Q?ef9qIEkiNBdqwlOQtHGr8FLCf7hlfO0yxUnG1morq7muyQBFGnrR0jPGX/2a?=
 =?us-ascii?Q?2boi9F2mNOpsXYlaHt0glfnP7AXN4kKPja5jpCRCZCVngDPYi4LgUs7e6YzB?=
 =?us-ascii?Q?ipqQzsbNC4Lsffg0bjmmMOGDRgQ3L9Tex/R3XqcgsbGULgh+aaWtvVZ0NREb?=
 =?us-ascii?Q?L/2a7c8Uznd+5CWH5LhI4p+0I5YgNEEdOSvphqax8zWiwC6SLIrpVnhygV86?=
 =?us-ascii?Q?59Y2AAZcu0o2VLiS3OUgsZwApjjfqbzJm83ZosbV5a7SF50hqmxiRZeZFf7t?=
 =?us-ascii?Q?kF65UDycI04kS3xW/2Ekq2pOwS/mPOBbTnkWWZU0D118ICbsOHd4wX2AIFMv?=
 =?us-ascii?Q?zMxEJzGRjadso1QiasSHdo7CQmr0MQ1aDhuQ02hiH6zdpF8/1HQWE/bXvdfd?=
 =?us-ascii?Q?DwSmWN4fs32b6Glo9OSzUTaIWT6hb5gPU+ZKhyTDmRRcMlHkWZRKUkfVc8sP?=
 =?us-ascii?Q?JBET3P1IMWYPLRXtyBeoTmEi2Hbt2mIGYKFq0WzkpM1dIatLXt5Em7814tlz?=
 =?us-ascii?Q?pvh6AyBST8MwoWUNLCV6NS8LE29vF7+149kns3fnH8+H6hi3cD7NwaNWrmv+?=
 =?us-ascii?Q?jZfP7VMDnAjJRDQcwIW9z+HJtlA4cDz58RMnoqaIwEma6UDgUL3/j19JLx+j?=
 =?us-ascii?Q?ImbckZwMTnzXwOOkWOWaSCGWYylxys4c79wI4Vj7YS4hseyggzl1UUWyyuvS?=
 =?us-ascii?Q?MACiY2ZEfWZEAjjg7Ot8+r02m24ldSOds4xJ0v1+aSw4BYdj4Raeyd7S/Ng0?=
 =?us-ascii?Q?dQVeTocOLbsD4P0oqVHfx+ykHisEhX4=3D?=
X-Exchange-RoutingPolicyChecked: i6/sSppRm4mjVePOnhDEMyUjjzh5N44QuJXSi+hIWaipDPWAXMja4qlbmVsA6eGmoKFaPg4DO+P4l33UYASsZ3f9o1UwXLf3L6dsdQ5ARfZBHfsMKk2wsFrHfDgdRN6iQAY8YA75ASxGA1ORwxBPCHC/PlMEyPIynnHI+BjoLHNQSaD+YIqHRqSA6gmFS2bKe7EG7UgUEVb5nCtyuBgHC0aAatnRImdIpXm8OpSmaADRoDXOxk8l3GRu+WS6UIUwWVzFlojH6iWIr3Hbp4RDZg4B0dEQYiJA/92gJuGQJ6qBkZ348BDJoAuAFb1edfBz15KP3v4gauTmJKQTkj9RmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fb0b09-821f-484a-18d9-08def1d0311e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:29:21.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to0v2j9wdrxev4EWoV5aJwkbyllS6E77OhOr9dqOLeyd7z/ZDQlZNRXVwwJrJV9KCxCP5OeiDJUB/6AYVjt9CaBccr6RljsqY7umupG0IoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA0B9CD929
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:09PM -0500, Terry Bowman wrote:
> CXL protocol errors must be unmasked to be reported. Add
> pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for cxl_core.
> 
> Unmask CXL internal errors in cxl_dport_map_ras() and
> devm_cxl_port_ras_setup() after the RAS register block is
> successfully mapped. Register a devm action to restore the mask
> on teardown. The unmask/mask helpers gate on dev_is_pci() and
> pcie_aer_is_native() internally so callers need no special-casing.
> 
> Remove the dev_is_pci(dport->dport_dev) guard in
> devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev
> is the pci_host_bridge device which is not on pci_bus_type, so
> this guard blocked real hardware. The caller already gates on
> dport->rch.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
