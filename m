Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936501;
	b=AKcrmHVlrIYt1LqjbGdozp7MpuGYkkjcQ4Jt5XDWgd9k9cPN+LIj7gyK0bmbVtCfd4My
	 M8MPNY4l+Vg6F/Q0GA3tRlwQrIUQJifbOa1XrY+fNsSYeMdvaNqokrnIBviXzmNHEygkv
	 ZqfdVQ1vxrcOj00Gg+p5eb2nJEj5AVdkpEZD0k+fjWTC03W89gzHWFPYl/5QhLrIbJmm8
	 JIBMWPZGb9zaM/BZiOZ193J1WJMpWEpQwvtXaw+ASVXrmndPzi03Ywb186DUHjm5wROaN
	 m6AWA2x85pPByy64cZztv/x1kazrSMVuk+570//6uOFg1igX+jgCFrUY9UZdGSHJr9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936501;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=NIi8B4QQXbsGQkVN7izrYBAyoMUOONd9JfG9j/rg4OE=;
	b=bVDIIo4sm6Gmx1VEBgiqm75zQJb0fMVZsrDjfc+4i46kEaCZTMu1lQn2T9kPTiZUNZyb
	 TXJ9Xod/GENpjRjz7X+oz9mK7357qGmjd15E6bCAnec3/9V1NUrcvIpAaBT4ioZEXIZ28
	 RA+nSwux6KPyvg40iKttQx9rcWXIlQkxTwDc2rzcmbMcz8bAMRJCYV/3EMxBoeXAdqpD8
	 aEfV2/Wzx1vTxgCwELC6zSpkaqlc0ncZJBuRJpcIrZ996XF3UdFezLy+3yD1opxop/yGf
	 ZLme6SYgIup4GBdnuIUOKmrK+gjGe91vxzWSatX2UMy8XwaDoP69ktOXYK+Oq4mP/BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g+PpWeSL;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DvHIYFuT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C782606A31C;
	Tue, 17 Nov 2026 17:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C782606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g+PpWeSL;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DvHIYFuT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794936500; x=1826472500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jONksNioDGInMBqauK5PjgET3cxsC5p1ikeha+XmSaM=;
  b=g+PpWeSLfleKsMflhByVMldub2gDL0459S9FEKBsgSWyZImgZS/kTDaT
   A/WRPrRM3z0lR6PiRKI/NhD2Ex2Gm54usnBbQZJqgxM99HjBqsvSFCNNP
   /8XFTwusaBhFMj/j06nZTnCmtTo40iJn/hvyX5uJlw9nah8uad7sglfWz
   UpAEblqCSeZEtYtPusvYX8uilt8ONxrUvZcZ+CDiFuLmE7UDQr+NDR8Ny
   04PnXB4/kccXIPRYu7R53K9NsBbmb0q4i6cYZbIWnCs9WOzrCPsFZiEBi
   teOW+dWdsFmC7SaaPy6RLdaiUiZpagC2f/HanHmbw6Ro04Yi+XZhqIIjZ
   Q==;
X-CSE-ConnectionGUID: MsztZbMIQjGLsWvVylLr5g==
X-CSE-MsgGUID: pEIjOaT0RJqYa3pASQWlQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3642020"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3642020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:28:19 -0800
X-CSE-ConnectionGUID: 6Aj7WOobTXuQGGkBo+IHcA==
X-CSE-MsgGUID: gDvFqS8IQjWa505ffSUexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10039949"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:28:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:28:17 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:28:17 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:28:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2nmzODdjgJqDPQmj8oWYGoDnVDb9RGgdS09lXjsOo7l32j75I/+bNy9Z4LtexGtKPalSPUgYKdUSPAAVI6Lh49OkmT4l0Lj121MfE3j2zmQJYxklz+a32uj1zvPpn0RUnIQ9eqLJvRUuLJzslGPCZrlXJog/t+YeN0+lMGDeOPCaWoAYctuNsMgB1GR1/ObAfUJEV+epAejtb0MTuJWRgGj0iYciYQGOfEVLKHWI46eJoLa14zxl2r2q5B0C2VMfN1fq+WSHGTqGklEngT2n/e9HRXGwlcWKKeR/IaSigLA8qcnZUNEv/nO66LgbW9+FTKD/4tUXntiSOBbAWrIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIi8B4QQXbsGQkVN7izrYBAyoMUOONd9JfG9j/rg4OE=;
 b=b3SD+vXeMl9tVq/vr3c9rHJNA+fPhMTToPOnzXon6eK0EWzSP+28d8pY3Or5emefgcgtFoGRA5iACqvFxZtMcJtKVpVvT2m/J9wS9PLGC1baWiMM1bZuucjGosGcCQa5RnGAvAytspFTGjb2FNLeDqE7VvCiKHsYgMkDs32AoRfsi3yAxuTDTEksGjIk6FM8LAk7mZNAk4riPnEqVRVDmwMMzQUuLuUVRQw1FZ5Lo8pUnCy9Ug+Gfs+VFfMpwPqap9PiG/lRSNwdeQsjep3MV5X0CPGryg0bmsDcknSq0vi1tN7372SRtIL6E8WuATCLmJ7XRS7bZfaud/QmH/t1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIi8B4QQXbsGQkVN7izrYBAyoMUOONd9JfG9j/rg4OE=;
 b=DvHIYFuTz+Hp+OzBinXov0dC7YKcrpBYBuwC6NzIq0IcfifjO0NnXVJFVDuoWJ0tVIq5Rn+b1vCiy02VF3Ec8XZuscAnd6Wg/cqRj/HBrtDeCbdKnl8sgX1dSPohEmDxENOhC2R7wk0Hz8RzrPEHwpCGe4dHJaJLmjrxsyX8WVo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:28:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:28:13 +0000
Date: Tue, 17 Nov 2026 09:28:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>, "Joshua
 Machauer" <machaujo@amazon.de>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <avyOoQjiD7Uh_3rE@aschofie-mobl2.lan>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0333.namprd04.prod.outlook.com
 (2603:10b6:303:8a::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: dcab6507-aed8-4d28-1a40-08df44d027ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|260925022911599003|56012099006|5023799004|260925021911599003|260925021311599003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: 4T60fZXwihmMopwUSEgr6329KLYa289TzNF8Ki+pi2EziayWvEfY+PrS/7qEpI0Y1w8+W/IopPnaJnItY5n4VrWtitNLvnaEjJW5WD4nmflfEQ3P6+9V/u1m0dU/B+GFaBzex1G92MzBHKQhBdzxdGdeISeq9KkpncFRKlm4KnN30Ozh/OIU+w+gUAXGLyAa3JjjaFPaHO7KxSkNTZsYq/uql2nb8IR4g9CNwKCF69KzaGGxNN4870dE0zfFYxadgFCFSwKC/f83KwTypPmE6idZez3spEXww7ZhgJpwr29Za9ugFNcpZMz4ZDhamUP21XGhCsv4oEawdkqWxW0H9RhD1mdC+PBsNeL7a82fuVaJhXoJjvxpWese9zlvN4jx4bPLWO+d2V7q2HEA1wYkxN/zjwZF4UYI3jtSaZFhMvr95zteN1W8H3P5QC/RwNh2mm5gFeEY3K3TCrJ0jyZ3oT04klutLZxbYB3bjkThVShoDEvqaGFbIFBTxbUHYMrnOjRhYTDzHcMKqyzgkHbCWJFyOei26YqwfT+QXUQfTMuBx+So07gV11iB9MLv0CpiVipBwx7fPFTMTu0K4HM4p0wWX0gpbg9Y2TtJFi/vo2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(260925022911599003)(56012099006)(5023799004)(260925021911599003)(260925021311599003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uL3AI+74j3qSx3blX46AsjvdJu2MzIVef7W3yjXvOrdmgyY0nB7JDsy6eoH?=
 =?us-ascii?Q?+hvH/bLUJ8DPF5MDNV6wh67Jjcnppxpzv7yPIv6OMKbb66ZO5CKNondOBzfN?=
 =?us-ascii?Q?SEKwSgWlMRbP48l+Y1T2biRNV1NoKvUFIWNhRPZGOI5ayV4sqQjFMpNIvTQ/?=
 =?us-ascii?Q?r34s/EzFpU99INJzieWECYeJ7OQvlp13cKvHSIs29xF6p2/+yhawD3wNMvJq?=
 =?us-ascii?Q?wrLIFH36A1zcScAdFUXHvRwzlq3AaU9rSjMOmPSxbnDy8n8FaOyTF70QKp0W?=
 =?us-ascii?Q?ejfnKgNBJEkwEX2qe9wKkb4PVYA5U97lUoxtIqL7CldZYPOSHiaHceccfRvv?=
 =?us-ascii?Q?kgK5PUAe7zrz6G83mR17dm0UQLcgcaugl8F5jhe8K8OPP0UNV+F2SBTosWNI?=
 =?us-ascii?Q?/DkvpJs5jdyYF/0fgNvYYz/oBd7u10gDl5axE/w8Iu53nvkxJ1tglUemBL1q?=
 =?us-ascii?Q?wPjEosIx+Mg7hnt5UUxbDi4sRGP842ckQp6g0F5uk7Adwg0e8uH9s8oZAH4h?=
 =?us-ascii?Q?RnKXAFRLJsD53leW6RGY4kCeTH46emv5lmFFbgpZEguIbV1zw+SsEBg0K8ls?=
 =?us-ascii?Q?vtaqQcY0SxQQw0E/NGtnXdPmowyGyRDBcGd+F3laCmecGvx3P/efvG/giDx8?=
 =?us-ascii?Q?Uqm3HPVwwuSdby6tv9oRvR4ge0rKWLa60QEw1q9/qzjgExrOs+U7714yfHyb?=
 =?us-ascii?Q?4vrmSIwwd+lzEwqWa1cEOTdaZQFVzDIvr9Q6ERq+g02CqRVK5C2KBoacA5hV?=
 =?us-ascii?Q?bCEwuJpph4XASYQz9Yv6neDdZZT8pLQOQgGxnyIJwNnuQDpxroTrjCYfJK4d?=
 =?us-ascii?Q?ujVRENQGDvmTt2F1Itj/fez8YGdDssCB+aGMNNx7fZu0UgGOR94bWgV0gl+p?=
 =?us-ascii?Q?oVMDKB0tcxr62ybtpbveP+1JIZIUjjTE3c7mvTL2Q+EzksZo9pWbBagIm51Z?=
 =?us-ascii?Q?epatECsC6eu+d52jNSBdAoeXFn/YhCS5n0oPVPEKC4/480ZhLXl5f4o0NMRM?=
 =?us-ascii?Q?yEWkDmVUEi+JG0tb2ILhwdvLP9ME1J8JSiaNTgvwJcbVOuMcqPiIUhg6EO5W?=
 =?us-ascii?Q?ca4+g//IgVsl03VrRrfcQlJR3YwPY7bmwmasd0AnvM5FCbLecM9Bac+o5v8u?=
 =?us-ascii?Q?DqYJFGph1z0k8TqUsZELgqJsKxQ7gAQwXULoBPOGdvY4wjBZyohlVFv85CC3?=
 =?us-ascii?Q?OokfNapuvDA8hA8Ybq4N690m6kwyGnJ2nfskbHnwW9jU/SKgspGSiiDgEKL3?=
 =?us-ascii?Q?ANzTpIdTHIFydIZPVvXlK+6e/1ElF3zpsJejQS4wOLfQvIejB6LTZnyH+1nw?=
 =?us-ascii?Q?xdSsYkUyLizrmn/bcNexBYvff8VR8kE3K5SFrsIppEKA1KINqfSp2pZzQEk2?=
 =?us-ascii?Q?zHJ9PvhdYEc9tK5Gt0nwuRJgQ9opA/Cqs3E6+aw829vtK4Gg6whq8SWdXkV7?=
 =?us-ascii?Q?6MQcl8bLYg0FDTS/5eWcZg7juAfqLAvlAa8wOhuhOlTQvm2eYWVqDIVyrfab?=
 =?us-ascii?Q?+xCbSYgxBoV4W4W6whrd5aNdIegK6Dctc165ObRNnSFUZ9t8hIHBw1iScGes?=
 =?us-ascii?Q?Dukxjg0x1cro3jY7Po3nBJoyJwZi5c+KdQjlM318QZJktTnsaFegucRRjF25?=
 =?us-ascii?Q?nLl+cWQ02/BjZNGsCM17WTInb5wxZiD1rm/3IvBEGyKY4GwOz+xFvIIPCj2g?=
 =?us-ascii?Q?6u/7Fq0Qr4QHttMBMgNZq3Z5sSo08lu51U+LTYmUoTAmUpA0GzMLzHY0D52L?=
 =?us-ascii?Q?nwwm5E6q9ff9wDWE58bRU9Scua08v6Y=3D?=
X-Exchange-RoutingPolicyChecked: adAtm3cE2f9+H6DkPrlw3YXxX1kKi1TbxXuomrHVZoB3GworGjdKkLc8IaGRL1569A1Fb7kQt5IXeL3nnBiMaA7lCRPctjSeJbOxczJj2D3NbjSpJACWw2xWn9sF8gPWMxn1DoW5C78ONIy8BHi31L6GjGq7B9hVVVT3dpQcBjrJsOYamp1NVQACmH/9I2JoanPi6fkgeI4n1AVP6yjYLEayn5FyoSW6PusEl0NKBF2qgyMBZVwMU588dZnzAu+V8DM8tB7ztVDAss844oQjBEgx6JAHaK8vS5XFM8ZtLC0P7Q9od2XRzwmjjrS/PcKqh/r8cZ30ulFlW/GIG4NXbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcab6507-aed8-4d28-1a40-08df44d027ae
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:28:13.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVCnjobHWOY/WdUXebBWc/sIV9OcvzKP8hYLSuY/tec+wtokHd5K8H5YiFvHUHS1QO/7sShl6vfx8BdLhgvvRVCkb6iJ4tWgTWxK5PHWos4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 06:58:58PM +0000, Srirangan Madhavan wrote:
> Hi folks,
> 
> This series adds CXL Reset for Type 2 devices through the existing PCI
> reset_method and reset sysfs attributes. It disables CXL.cache, performs
> supported cache writeback, initiates CXL Reset with Memory Clear, and
> restores cached HDM decoder and CXL Device DVSEC state before PCI use
> resumes. Active HDM ranges are reserved and CPU caches invalidated before
> and after reset. The method remains limited to eligible single-function
> devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
> the same cached state and flushes the host and device caches around the
> reset.
> 
> The reset sequence follows the CXL 4.0 specification [4], including
> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
> define the completion timeout encodings and reset access restrictions.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace selects "cxl_reset" in reset_method and triggers the reset
> through reset. Following Dan's v6 feedback, this uses the PCI interface
> instead of adding a memdev-specific sysfs ABI.
> 
> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
> callback when provided and disables PCI I/O, memory decoding, and bus
> mastering. The CXL path reserves affected HDM ranges exclusively and
> blocks IOMMU translations where applicable. It does not offline memory
> or revoke mappings: userspace is expected to offline CXL.mem users before
> reset. The reservation enforces this for claimed ranges by failing the
> reset while a conflicting resource is claimed [9].
> 
> The global region lock is held from snapshot through restoration. Memory
> Clear completion is awaited for the timeout the device advertises, up to
> 100 seconds, so the lock can be held for that long plus cache flushes.

Hi Srirangan,

Thanks for all the followups on review feedback. I think you answer some
of my question above, 'For sysfs reset...' Could you explain the intended
use cases for this reset method? Like why and when would userspace issue
a CXL reset. In particular, is reset intended to be available before endpoint
and region discovery have completed?

I see how the series saves state for restoration after reset. I don't see
what ensures discovery has progressed far enough for reset to be safe.

I also see DaveJ's cxl_bus deadlock report. My concern is related but
separate. Even without a deadlock, a reset could hold the global region lock
for up to 100 seconds plus cache maintenance and restoration, blocking
discovery and region assembly on unrelated devices. Understanding the intended
usage would help assess whether that disruption is acceptable. Note that my
simple concern is a user issuing those cxl_reset's on repeat and blocking CXL
bringup. Yeah, that's a bad user, but is there any protection against that?

Adding specific questions on patches 11, 13, and 16

-- Alison



> 
> Changes from v16 [1]:
> - Publish the PCI HDM cache under the PCI device lock instead of
>   cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
>   cxl_hdm_cache_publish() helpers (Li Ming) [6][7]
> - Wait for the reset timeout the device advertises, up to 100 seconds,
>   instead of clamping it to 20 seconds, so Control2 is not accessed while
>   the device may still be resetting (Richard) [8]
> - State that userspace is expected to offline CXL.mem users before reset,
>   and what the HPA reservation does and does not cover (Richard) [9]
> - Enable bus mastering after the IOMMU is restored on CXL bus reset
>   (Richard) [10]
> - Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control when
>   MEM_ENABLE already matches (Richard) [11]
> - Initialize the zero-size HDM decoder end to base - 1 and document the
>   zero-size case (Richard) [12]
> - Set Lock On Commit after programming the decoder registers and before
>   Commit when recommitting a locked decoder (Alison) [13]
> - Record Normalized Addressing in the cached decoder when region discovery
>   sets it, and note the short window before that update (Sashiko) [15]
> - Reject an all-ones DVSEC Control read in cxl_set_mem_enable() (Sashiko)
>   [15]
> - Add the missing context-analysis annotations on the region quiesce
>   lock and unlock and on __cxl_reset_execute() (Sashiko) [15]
> - Use an explicit pci_dev_put() in read_cdat_data() instead of mixing
>   __free() with goto cleanup (Sashiko) [15]
> - Check for VFs and multifunction devices before the CXL DVSEC lookups in
>   the two reset methods, to avoid repeated capability walks while probing
>   VFs (Joshua) [18]
> - Fold the CXL bus reset cache flush patch into this series (Dave); the
>   series is now 19 patches
> - Added Richard's Reviewed-by tags to patches 6-10, 14 and 16
> - Specified the reviewer behind each change in the changelogs, per Alison [14]
> 
> Earlier revision history is in the v16 [1] and v15 [2] cover letters.
> 
> Attribution for Dave Jiang's reference branch is still open.
> Since I am unsure about [16] I have not yet added the right tags.
> The patches link to his branch below the separator for now.
> 
> The v15 discussion on the scope check is still pending [17].
> 
> HDM caching requires CXL.cache, CXL.mem, CXL Reset and Reset Memory
> Clear capabilities. CXL bus reset state restoration uses that cache.
> 
> CXL Reset requires a registered CPU cache clean/invalidate provider
> and matching firmware, such as the separate SMCCC provider series [3].
> Without that provider, cxl_reset can be advertised while execution returns
> -ENOTTY, unless the test-only CXL_REGION_INVALIDATION_TEST bypass is
> enabled.
> 
> The KUnit suite checks HDM range boundaries, zero-size and uncommitted
> state, lock and target-type decoding, and 12-way interleave.
> 
> Testing: v17 was tested on an ARM64 target with v5 of the SMCCC
> cache provider series [3] applied. Reset loops passed for both cxl_reset and
> cxl_bus after running bidirectional host-device traffic. The
> cxl_hdm_unpack_kunit suite passes.
> 
> [1] https://lore.kernel.org/linux-cxl/20261029145703.2185231-1-smadhavan@nvidia.com/
> [2] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-arm-kernel/20261021224557.1827361-1-smadhavan@nvidia.com/
> [4] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [5] https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/
> [6] https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
> [7] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m7f8d0e51d4cfe09fefcebd93d49dcb916be9198a
> [8] https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/
> [9] https://lore.kernel.org/linux-cxl/auQRSOGWEDzB_qjF@MWDK4CY14F/
> [10] https://lore.kernel.org/linux-cxl/auRhJa-nzR0CnKf3@MWDK4CY14F/
> [11] https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/
> [12] https://lore.kernel.org/linux-cxl/auQ27s1rSCcbdRJ3@MWDK4CY14F/
> [13] https://lore.kernel.org/linux-cxl/auAg6MFDGyVQvQxM@aschofie-mobl2.lan/
> [14] https://lore.kernel.org/linux-cxl/auOXW3BTb8CYIh4m@aschofie-mobl2.lan/
> [15] https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com
> [16] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m2f61467417f422316cb15b976773944dcdcb48c7
> [17] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m4f62ed0f038f2d136158c74c1c6c338129266131
> [18] https://lore.kernel.org/linux-cxl/20261105143611.31563-1-machaujo@amazon.de/
> 
> Srirangan Madhavan (19):
>   cxl: Clarify decoder interleave limit
>   cxl: Share CXL port upstream PCI device lookup
>   cxl: Move decoder declarations to shared header
>   cxl: Embed decoder configuration in a standalone structure
>   cxl: Introduce endpoint HDM decoder settings
>   cxl: Move HDM decoder helpers to built-in code
>   cxl: Share HDM decoder register unpacking
>   cxl: Move cxl_rwsem into built-in code
>   cxl: Refresh cached PCI HDM decoder settings
>   cxl: Build register block helpers into the kernel
>   PCI/CXL: Cache endpoint HDM state during PCI enumeration
>   PCI/CXL: Add CXL Device Reset sequencing
>   cxl: Validate and synchronize HDM ranges around reset
>   PCI/CXL: Reject reset with unsafe function scope
>   PCI/CXL: Restore CXL state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   PCI/CXL: Restore CXL state after CXL bus reset
>   PCI/CXL: Flush host and device caches for CXL bus reset
>   cxl: Add KUnit checks for HDM decoder unpacking
> 
>  MAINTAINERS                          |   1 +
>  drivers/cxl/.kunitconfig             |   4 +
>  drivers/cxl/Kconfig                  |  18 +-
>  drivers/cxl/Makefile                 |   1 +
>  drivers/cxl/acpi.c                   |  26 +-
>  drivers/cxl/core/Makefile            |   2 +-
>  drivers/cxl/core/atl.c               |   4 +-
>  drivers/cxl/core/core.h              |  15 +
>  drivers/cxl/core/hdm.c               | 273 +++-----
>  drivers/cxl/core/hdm_regs.c          | 437 +++++++++++++
>  drivers/cxl/core/hdm_state.c         | 402 ++++++++++++
>  drivers/cxl/core/pci.c               |  85 ++-
>  drivers/cxl/core/port.c              |  68 +-
>  drivers/cxl/core/region.c            | 116 ++--
>  drivers/cxl/core/regs.c              |   9 +
>  drivers/cxl/cxl.h                    |  46 +-
>  drivers/cxl/pci.c                    |   2 +-
>  drivers/cxl/port.c                   |   4 +-
>  drivers/cxl/tests/Makefile           |   5 +
>  drivers/cxl/tests/hdm_unpack_kunit.c |  91 +++
>  drivers/pci/Makefile                 |   1 +
>  drivers/pci/bus.c                    |   1 +
>  drivers/pci/cxl.c                    | 907 +++++++++++++++++++++++++++
>  drivers/pci/pci.c                    |  27 +-
>  drivers/pci/pci.h                    |  44 ++
>  drivers/pci/probe.c                  |   1 +
>  include/cxl/cxl.h                    |  59 +-
>  include/cxl/hdm.h                    | 109 ++++
>  include/cxl/pci.h                    |  13 +
>  include/linux/pci.h                  |   8 +-
>  include/uapi/linux/pci_regs.h        |  14 +
>  tools/testing/cxl/Kbuild             |   1 -
>  tools/testing/cxl/test/cxl.c         | 158 +++--
>  33 files changed, 2526 insertions(+), 426 deletions(-)
>  create mode 100644 drivers/cxl/.kunitconfig
>  create mode 100644 drivers/cxl/core/hdm_regs.c
>  create mode 100644 drivers/cxl/core/hdm_state.c
>  create mode 100644 drivers/cxl/tests/Makefile
>  create mode 100644 drivers/cxl/tests/hdm_unpack_kunit.c
>  create mode 100644 drivers/pci/cxl.c
>  create mode 100644 include/cxl/hdm.h
> 
> 
> base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
> -- 
> 2.43.0
> 
