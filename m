Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32F311C11;
	Wed, 27 May 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844510; cv=fail; b=lmWPmUJ42+INY0f59oU7Z/25mBN9fDsKcyUSm08lYkLpp+OmpX7Y9rwRyQcKXvJCrt29e5X7wrIMsvHJNEBv0rW3B+eRpvawBYuZG3GlcjYw3Cg+OGcJFD7ph4cH29N8fG3l2MkPd73XbPDMTbWZ4JBVeLT3FEb7zY8Trm46egI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844510; c=relaxed/simple;
	bh=wXUHe1zogGis8nZeCmKXWqTZRj5U5eDIriPCR7EexJQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+fVwNAJE0Of23WZtI7ck+SOXrCQFJ81XLxpxui3F0rJJa/ibJTEbUXlQoetc81cPKAM4IXoqaoeajlmMvghVZYVZooX8RfkCNuyrvxQP5ibpuJQpIFECJrrXCj2Y9sagSberCJBA2TgRKxWnxbO9k9RXOBE0bRYVwjnONW5uxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BM9ELwC8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BM9ELwC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779844508; x=1811380508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wXUHe1zogGis8nZeCmKXWqTZRj5U5eDIriPCR7EexJQ=;
  b=BM9ELwC8z9ttkQ8mZgOZVB6XTiOQx7yZYkMgwWkgMGhyyFHKLfHnKgKt
   5ZDorSZG8/byoS8UbhPTW5YvoOnkmQrpLUsQAz+EOsRHTvN9N0GdJtsd4
   THLQ67sVB5Bw9WEY4WE54uDuobc4JXfjm8r2fVlag4556bzySqgcpNBji
   mwBL4p43znSNsv8JODFtP67vWmaEAo9voduqxcpGKaozqVA42icX5R8s9
   ez3OnQwXYItS7dqAVq881SDZM65hyz/5Y7lKlX1NZ6EKQBOXPImVIvD5A
   BYDrsyeHwFtc0iveRxcDwYOqv8mxOc/xsdnoTEdvwF1WyYxrBwVCaWrrl
   w==;
X-CSE-ConnectionGUID: OiECs/HlQHyOacGGHRQ3qQ==
X-CSE-MsgGUID: fP/GNBaeR+ir31px6yIegA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="79817767"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="79817767"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:15:07 -0700
X-CSE-ConnectionGUID: 6Ty0wFJ7SaaOiRV8rSKI7w==
X-CSE-MsgGUID: qPavn10VQDGoDQ0CtJVUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="235725323"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 18:15:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 18:15:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 18:15:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 18:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtvYFTDrT5ucwg83YGNgPrJdkp3L27DeV3FaQjk9eR8fISeU6KAP+Q29YG5ZqYQMqwejrcHOw5p98rCAV0qRJ/vFYXz/u+AjwCA6Eq4+0sbf2btPJ2YK2uLJRJVtn7MyUcThYqaumFyVRlIRj/xmmQ5uhJsv3rzDQn5CwTIdzZBVNWPIAQoxsnSxItDgXwJ73Bc1V6pljfM+0Y+4hmF0Pv4VZID3c4iJkNtlC4WCsTt8Z46eefWzbzVXi1LccvwzqApua9Me3kbQkjKLVhfbM2whJ80G6NEX20bzseYHi7AwA9Na1Oq5xz45sFUzCLpcjk8z7WEW3YvBLACZAAib0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aVfjIE0CoXFFy7mvs9g6d42vDZu3CzcI8iZOFBAwM8=;
 b=LxSYR6jmS9averwARwCik8Dh7vieTppfiPmeYbscVi2jNvPg8Br1IAn4alnqMN84rVQrKF385+iX5YryfVRUx2+3slS/58n9Bub+Zb8+ioIKGOZ76Gd4+a53rDd/Ki97VG7wFrUXGkxwCnRAQXLQkhjsFUsKbheNCGg6NBCNrDRvrDLQR/srqhOjkt2WIebiGMUDrbGznQM2nb9gOIcGwzsvsruPF8eLUpIjrBg7oJ0nnse8RFzLbx1PYRugAKMlCbortQoRE4Md1MQCAb/VKlDs62G3OlAKMU2UxzEufDHrMCbaeh0sBJpXtPzbxlomxfhie4uHa9l1Sla8zPVTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 01:15:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 01:15:03 +0000
Date: Tue, 26 May 2026 18:14:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
CC: <dave.jiang@intel.com>, <djbw@kernel.org>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<guoren@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ACPI/PCI/CXL: Enforce _DEP ordering between ACPI0016
 and ACPI0017
Message-ID: <ahZFk-nWSQr18OHk@aschofie-mobl2.lan>
References: <20260526025118.38935-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526025118.38935-1-cp0613@linux.alibaba.com>
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: f88ff4d0-5d5c-44b2-7274-08debb8d6165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Ajn2OwWc5kl9Ig0ha8BzcbSsx87uVGJo/4KQMC0dKz7TDbOeBnsmCYIbz4VEDbKx8O6NmawX4SS3bNTKeS7NKWIU2xX4kU+SLLgNAQEcPAqfEtMDYg7z059KlGGktS0IHvv0z/Ag9emnNATViFoY7NjYGqsvsnE3MIaamqTs5FNqth7szIi4gW2QPqt2nyTN8Cem3UIBG3kTk/i9tWm2Oc/P3+cddw1yB4H+8ahAFbxqzhkX9KQGVL87RcXhyu6gvFfwiodVF+QMwQOrzKkqMnLz1D2DOLg+oYDi+9bNrb/D+5HTzzMRPnwlliZ1JozHBN8w6Oo/yA+Xs+YuXwT3q9hdC9fQB2F54jdyBxfPlBE0A41t+GU8ZCjlZ9nb2QsqDM91P24/wxnx63deTGsuGK5xFf4DH9DJDVLpCHsEn+UnsJ/8IypIuANCXmnpiNLoqObAM2f8QZIgTbcAFtYKnvm62CDU0kU/ByvzN2SFC2LPmVQFHt1LAbgMLzgg432SOb+/mhPqqNKmZp2g601cdt58BJ6Klx9bdoGcRnTYfNNIUJUqqijs5Sc1s6bVsmJhVmZCSRuu2sHZeSe+je8PKoYhZK7F3JaouXuEghuExaJQrZLMU3/Inht/ZL6oBkFQm3myzQgmcQn/Uurai19ck3qNasUpcGb/ndVoCyPXeje0m8KUzgptAfoE7agx6A0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P92FuL0Np92KEbUCRZ9u/BwGJn7zbTosXtSvZ9r3eDAko+bfsb03l/vvPDFM?=
 =?us-ascii?Q?3z79FWipdTMY30z38h17jn4iY6gUfkMDEh/Kfio6JL2rW8DMGG9cdZkJ03Sc?=
 =?us-ascii?Q?0UXPpGqdxdqQxQSObajqGQZRTVwh12Fn1JZeYCwLFH/jqHptUP552QgxWX1S?=
 =?us-ascii?Q?rbcPAoZluyjxl5lYnlkTwlbz3Mbc54macv1hQQMYi04W1sGUCcanfKsoWlfM?=
 =?us-ascii?Q?i0ZQZvz1IltX3x6Z0VhWzjazaNSBoBiMorsfzPHWyd4T0YPRvIop08Qg/KJg?=
 =?us-ascii?Q?cIzGayIwIg/cAroU4GC8RJrYqnDbTP1K6iPrc1Y/qS+9lRMT39aYeR0gLsKl?=
 =?us-ascii?Q?Lwj2kYFRBTvL30AVc6m4L2kcWippb2Im/duyGDxNa8QpGU9fRUSpgEYpyjgF?=
 =?us-ascii?Q?AqvpLm6Yl3Nl/ZfYTdbOCgFVPn1Q1ztKBKcMXm94ifQc7R+mduHZVv/vF3ow?=
 =?us-ascii?Q?da5ilYr3pXVuVSRO34T4x26KvB2rd9AhdsuxrdbNP6t6ZM4Juo3TYlSnvc3Q?=
 =?us-ascii?Q?D3AsOIDtJS3opHV0Wp3GmCg4UX1SjQxA1zMEDLliY/w277GP+rFIae5OV42u?=
 =?us-ascii?Q?QqLwHXQwkIeO5f5uLd179WqSINmWsjnXvpiLV96Lm9jemaICAC7mnVgDJmOB?=
 =?us-ascii?Q?TvTaYm6b5HvZEgw9R4b4hKfpLTsFlcfgXFLJyGdfjywluPCP3LojwwCZxprG?=
 =?us-ascii?Q?E8ljOozzJ6vyIKjFbq75x1mtY9LOadaljkr54mhvdADPaOTZ0GrLvOxDrXOG?=
 =?us-ascii?Q?5WkfQpNJMnWMfkbptNaZETZ7kjb+/4cN8sH991LpnWmM6V4H6pM1hf6U8Kag?=
 =?us-ascii?Q?e2tPso0YLLwJi11N5HBxGZZEMTaqgznNkc0ZVsA6KuOIPCC7g+jB4sBAc/sV?=
 =?us-ascii?Q?S9k80lqYnD/x45gJm85E9VeczODtR6CfVrc5GsHOfgIdLshLNSzU9dtuJsDx?=
 =?us-ascii?Q?7SMuYqAihuM1AuwoYjOwTNX72bMXJY8SWbvvqOXHHYpUjleqqnXmKLeMAclq?=
 =?us-ascii?Q?aM1sXOt02veoozT0pgdy6rhID+9h2DyljEBs+1BWlDk8W1Vxvmr2VfCDFVIs?=
 =?us-ascii?Q?cSLbtVKodbUQk5QNjLI8tPF4+zzRkZMYNcXH+eDneON25X3SumJG+pZcv2yl?=
 =?us-ascii?Q?doaNXpKQieTFmLFvhopKQzsBiIskLraddoenrSU+eK7lzDP5G7rJHUhB5YIy?=
 =?us-ascii?Q?ihCnuqAjyDdC7qUIyoxKKCGc2CdG4DVJkCoirrpR2YlZUqLguDEAQVxtbJAp?=
 =?us-ascii?Q?DubJP6bhH3/2SfeWe1nRub3zFN/WHn+x0aJLUrErnMb9auv2XXqQlnVlX8vP?=
 =?us-ascii?Q?5Xs7YPBL87/aEzHNRCuoLdjgMudlEam4smjKY4CecNcQx9dakw4b7stqenw2?=
 =?us-ascii?Q?mUuAeg9cgXdWgSo3es5i9NbQd4crxPZcFO7QOfKweaZEAy850altDJd+5crJ?=
 =?us-ascii?Q?XnzzdepAnZeKN+kOhpSpEGvKRG/diL3jUGDWtF6WBvbCQqXZcEvzo8rFv5ol?=
 =?us-ascii?Q?HcD2qiRuhJiMPrXzFZA4TZHMqV3muAJXfG2zPhgdcKfUDlJZNqCstfF9px1J?=
 =?us-ascii?Q?YKXxMQCemKtYGckGEE2zKTh+NU8PkuIDlhr2rmgscYu/ALZZv8etB/94ccmr?=
 =?us-ascii?Q?cDsdgnWqAd/FLKKxvGtvsJdmy5z39VVqFhj4aQNUYpTsKT+vcIVfVhd7JAuv?=
 =?us-ascii?Q?/MMOQxUftTH5ZYmvnv4N/ToYo4fAYln2dacNslS5x4F6t/wtUdcLg4pRvKoH?=
 =?us-ascii?Q?S+TK0qh3mps8wiheRT3P+I63Vf6ro8A=3D?=
X-Exchange-RoutingPolicyChecked: M6Blsy8bZzqQwaKQXro+/GlxVoMESL9KjWIiqlg0nNAkRJLycev8Civgleyyr7Gdgg3MLmFBuBs8ZfE1uvXzYu/sI9rB+aAnjSQ/bKe1Gj1CumpBrfFxEnyGHYtIvwrLnnNxnz7nWLtF3QzE0N1nk6F4QWikGCf0udl7r8GdozZFpzqAbiooZ/oOU/XeqbVeFynl7Y/Z1051Pg7RU/2TZRaBlcJJiDslwbrmYqeWq0dXuHzw344Ka8SFbZMXnds5kSlzhHSIpBBMQ4uj71WCyUXHIRaKG8zlOiW25QB8JUYzI2Wtod3kcWW3EK+AcQUXELrXuCBqjJgASAp0Gs2atw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ff4d0-5d5c-44b2-7274-08debb8d6165
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:15:03.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncq2dYYKC9nQIeqoYkJYP4y11zmDBw2aYEjtLsGIc9gQGG+9xwgM5bAQQ/rFzIgxoYXlmIRzNdjW6H9X2IujXBLPh406j6+UpInJ+GFre+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com

On Tue, May 26, 2026 at 10:51:16AM +0800, Chen Pei wrote:
> On platforms whose ACPI namespace exposes a CXL host bridge (ACPI0016)
> with an ACPI0017 CXL root device declaring _DEP on the host bridge,
> cxl_acpi can probe before acpi_pci_root has attached the PCI root.
> acpi_pci_find_root() then returns NULL, decoder targets read as 0,
> and no port/endpoint device shows up under /sys/bus/cxl/devices/.
> 
> The root cause is twofold:
> 
>   1. acpi_pci_root_add() never calls acpi_dev_clear_dependencies(),
>      so _DEP suppliers downstream of a PCI root are never released.
> 
>   2. ACPI0016 is not on acpi_honor_dep_ids[], so even when ACPI0017
>      declares _DEP on it, acpi_dev_ready_for_enumeration() bypasses
>      the dep_unmet check and lets cxl_acpi probe early.
> 
> On x86 the bug is usually masked by link order (acpi_pci_root is
> built in and probed before cxl_acpi). On architectures like RISC-V
> that ordering is not guaranteed, so the standard ACPI _DEP mechanism
> must actually work.
> 
> This series fixes both sides and the two patches must be applied
> together; applying only patch 2 would prevent cxl_acpi from ever
> probing on ACPI0016 systems, because the supplier would never clear
> the dependency.
> 
>   Patch 1 makes acpi_pci_root_add() clear _DEP on the supplier once
>           the PCI root bus has been added.
>   Patch 2 adds ACPI0016 to acpi_honor_dep_ids[] so the dependency
>           declared by ACPI0017 is enforced.
> 
> The approach in this series follows the discussion of an earlier
> posting:
> https://lore.kernel.org/linux-cxl/20260514023238.49984-1-cp0613@linux.alibaba.com/
> 
> Chen Pei (2):
>   ACPI: PCI: clear _DEP dependencies after PCI root bridge attach
>   ACPI: scan: honor _DEP for ACPI0016 PCI/CXL host bridge

For the set:
	Tested-by: Alison Schofield <alison.schofield@intel.com>
	Reviewed-by: Alison Schofield <alison.schofield@intel.com>


