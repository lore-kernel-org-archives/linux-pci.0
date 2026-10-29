Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793243970;
	b=c2mC3WH/ukgHObne4F88+4niBuCsjaifnqwvS1x3fBojkPx5dI6Rh5u58aFKS8XaFSFh
	 xCHkcWiL28kJKbXILoitjgcDc23AEcS2Pfsmdpe0iWexSCtKlAVppze8uO2FjDwHkDbiD
	 T4aibAOO9I5AolDt8OgvTl/2PxcOCJwM0+QW7sqA98bLGTP9F6FdOPfN7MoAOaWG6ZBHF
	 QfhxHpWpqfuP0uMiWuwWEMh5/yImzxWiSOAoH3d7YVfgQAzfOM7VkhA/zM8dCs3ohjcYo
	 tMYSiNUyITB3ucZR+UWtW8PV8Awd4C7qfsyi7Az9cN+mj8Yw+pELuMf0x0lzryum/jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243970;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=AkF8sP0R7CQuLme4Dkb4yMeDqdqm8kS/IVwvqgKRTHI=;
	b=RAUdYoc3dCnvqcvhrKs7c/vfR1YOkhdAbIEe5zKbuGx1vdiux+3sYf5aI3xOQKXUr1w5
	 uP3D96wjcI9Qagx3xrlwj7MwrLM3+Wq+CgC5KpHiwt6ZWqVyClyGvetzi7qGZoiEhcjQd
	 R1VM3PJ0UFIP1raY883y5v1o3N/nHBttRMbyIbsyoXZiPaYXZeF0CynlYrt8rQhKbsllK
	 e9PqCbAYwWRPILo/Vw7k6aBBm/F99kIiKHYrKiQHip4dnlBCVzTHtkekKbTy+blFqQt7H
	 bwVdERdDEiAyq+eTMxbZNnKbu9OhV4PjLVzWHg7/SgvKHraHvBJjfZ+NlvTtD3HIBcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1SL+uYQ;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A3606A31A;
	Thu, 29 Oct 2026 03:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j1SL+uYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793243969; x=1824779969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=telInCOM0bmWzb2lrIydmAJXTR2WhBtFwwqdsaHNF1g=;
  b=j1SL+uYQnAkAwn0Lhz1XBRiIpToy1Hn5FjGvu74ktmZEXbr5DnSLFmV0
   DgnmXR1d/gcGakp1uGf04wPkQ7Ru5PNeNwu3bI1IzqDn17JBoFrWwShXu
   o+EnfPeKiDEXpaM0LqCmJ3nCScqMfpCTwjhse4reN/H53lAsFfJE0eHmz
   cmTS0UzIF2aKjXGkjOLhwz3QupcL70djOGw2Q9TpJp54gSbkPdcrh5F1v
   VYqWgAxwvnSR89uHkqtkRNQi6ZKXJHB3pcW4J6Q4jJdGvbmftToU9IMfa
   HWpjx4c9u98DYl3a96MSTl/9ku9xVgwP8pu+zkjae4xbSwwEb+yS7ACXj
   w==;
X-CSE-ConnectionGUID: AlpWmrDyR3CsQTHtddVw8Q==
X-CSE-MsgGUID: vx4AKhnRS9+cxMmXRGLBsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1976024"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1976024"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:19:28 -0700
X-CSE-ConnectionGUID: lMgXnD5tTVqvBldPJNkIvg==
X-CSE-MsgGUID: Rbk7TC+ISWS/jM0iA3baeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6845273"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 20:19:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 20:19:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 20:19:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 20:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MORxOUa2TEqkVBuuFEIsKaxJX86DGyhpYNJl9Fi7JPcPm3HBTzpc/eRySxhKghgseYTrnecfM2HvsMcN5BFsJ1f8DnEYSfP8bKTyRcet6yKSNUazlMIEiUJm+UaiNgyzNozMsLSV7HLZirgidvPv4AUPu63wjmeUCybIKLEvm+3u2u+2wLKuztJxFHcZDL4J5IWT4a+Z6YvhXXIJHCjG9WT6aP0Mw+cWh026jEcN+HlYr7hHynvfAZpXjHxhDEG1HZmnzmrxfRiqzgaagW7o0zDa76vJaXMj/JA8SqveE4Nm2ioMkC8hwp5aMd49rLCu7PsvxLjdKk1nOruecHmIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkF8sP0R7CQuLme4Dkb4yMeDqdqm8kS/IVwvqgKRTHI=;
 b=teF/X2jphdGk6DuP0ijjXxGleMApjT4AAhz8Ojndb4xNj3QuPeT7zeAfZyXCxqUIloa/IdhyijLKgekNfDJyUXOMli7wASuBrAGdje6arsMShDhGZkoc29XC9JJ3lHQiH4bWlExsJ+XzBpWiRQh5FvbT0kndvpv332BfszrBzciq8j3O7FP4DiGX7kPgkv+gn54jTzFQCtWLKtdKwNtGJCNOr75/YkPZQWh/hMNVTocuio11L51NbmEn3x2Hei9sYSlBr+V3L93xjzSenp9uCBhKoN56e/fFthmj94ltpqwjOXpKMBhoVdHgCoLPFnPLIi11UxeqH39CRUGQZ0kTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PPF849DF23EC.namprd11.prod.outlook.com (2603:10b6:20f:fc04::cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 03:19:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:19:25 +0000
Date: Wed, 28 Oct 2026 20:19:15 -0700
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
Subject: Re: [PATCH v15 09/16] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Message-ID: <auK7MxeCI2fsUNZC@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-10-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PPF849DF23EC:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbdb39e-2ffe-4c25-5494-08df356b6f1f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261009223027099003|261026140227099003|260925022911599003|260925021911599003|260925021311599003|5023799004|4143699003|56012099006|11063799006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|18002099003|261026121527099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: ucG9l264FFeIVGM0IHoc3S6yKSPBQ55f8a7GoSTVjk81xrKuXEkqJCuEzX64p20S7tBgjX3iWq2HYP9QXyYUyKSaHiMFqLsuscmqXgro2ELkIayksnqLc1YsHKSCg7jEp9Ab+/s1R9eBUOi7o52VNvPVTQ0s4rIjY4mKBYEuGSFUPEH/G5vbKAv8srnTdcHNOo3Xwg1nyOkFYOxlUHGitZEmOeV8+KHS683p7fI3oAUCsryWX+5HqbcSHvCPo/cw5R8pi/cjOm6NSNwmVuT+AAZprziU9PKMEw5JPZADKTvScNo9dskt9adcCmy9kiTyfvNfu9IsQXDoZdSVa/zcLvRmc2KBlQ1tKYfg08ZX8U4ygTqQ+UXwabqzjXeofNJvW+Z1IKDWmwt5a+0bwgRn7rwHy0D5XT3NsJ+143hdj0x/j4AwgeYHNRHlRpXmezGa1oWQXmcX0gMyNZvEtwcE9flyXVx5PtjPbpkZr8l/AiaK6u6F4CC58Q2QEICiXO//NKUEyEABKarmtHw4Nu4k3aY6lwJi8OIfQMIRkFOG007IEBRShSlvOz1RDbE97x6B+L5dupc1yEy7CzeGIztVD+G2u5QIsw7njV0uzjGbKVmtdPB0EJo5bngIZBfk9249JOx9Edk+pFbpW3xBvaUKD/dZjluZQYJ74Cpl8sLYQyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261009223027099003)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(4143699003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(18002099003)(261026121527099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+Mj7oXMRulfy+7uRjWnGCPfLCY1wvXei/bmvjLceshg4mXkItoKGgpHek6m?=
 =?us-ascii?Q?g1wsesie1FzJeKoL19m2KqVbh0NfCoEk0UMgt516mMgY0LBgYYylfpxpnuoD?=
 =?us-ascii?Q?I6sSy8h9x0kWRD5HdDMwCaw9397MM51tmd5a2NmSka/qsAQpYOTz/Bf7WXy5?=
 =?us-ascii?Q?c4uAau8XyvcE7Vsmyw8dRmdpECBTJrAar7UhvnrtuQWyK6O5gmQwHswiV+kL?=
 =?us-ascii?Q?IJ1u8iKQT6SG1wkOWJTGZHNy3zheg1PJ923KL79ElHig605u2qcidbuEGP+W?=
 =?us-ascii?Q?egvE+alAHQoUeWEcREbcHXAT2up/wxN07m15sP8vhME/6tY+6PniTJDxr2jN?=
 =?us-ascii?Q?xCfVZRGqm0wXxLgANKZJIWLpQD05QvA/kalZPB+55dHxxu9N5wGTYAA6BNsD?=
 =?us-ascii?Q?4x0ryjVj5K1S+rYsyZnX6RbJTPwHvirP+kwYn+J8C3OXb3en9ZvyXB3p5G/T?=
 =?us-ascii?Q?yiepZGWSIKnRDVNhN/qUzVhRmuv4EWFiWXtgJW7h9uAGvC3gQPIwMSsYrQIr?=
 =?us-ascii?Q?VlA++zLOLCEPjVNWt+j87Ktc88FE6pBEvLcm3giA2EltE4LyGpTH/tBdXli2?=
 =?us-ascii?Q?UbzzgEsp99qdA9jez21oFE0XqcF4q0Gs+zftIwSsGf2KQNkXrEt7/my0FHm6?=
 =?us-ascii?Q?rOH7NszKQ/n85/E4yr99QZVUrLg7M4eq+xBKLTxJXXeZaz4tIliFaSqTNv2U?=
 =?us-ascii?Q?TOWS94fgzkvnUvGlQwnxwys1XfLltGgQ0VCPZYZRhNcOjG56FQXLIeiM5rIb?=
 =?us-ascii?Q?uK30Px0cgkuM4+9TA+LNEvjNqtEAIYGPyGpzjZ099iF1PBeTm1lmG6EIWhLI?=
 =?us-ascii?Q?VqYijyQ3dQuQY59XA7iaOxBoMC6akFjjiqiyI8RrW+KJjooRKvCWd4g0DZrF?=
 =?us-ascii?Q?tfwKjOjHEvKpTxIQg0eCor1ovPNTu3PSQ6LZSOMx/e4yeOr7wTW8cYh07jj4?=
 =?us-ascii?Q?ulhEsjJP6VDwcsEBMnBScqx1g1weycGP7imXXEaT3fwtWMMgkAyIaL64SAmq?=
 =?us-ascii?Q?D8P5ant7saA17XzL8IpcsgfmHG+7MctKprUSl3H+1WYu/8DjpzUIuV+9U7JZ?=
 =?us-ascii?Q?matjE7c0eXBiopw4RuOfdtc9iTAf+oz1UsR5vjFpXS9WFhrM230SsuyxDH0g?=
 =?us-ascii?Q?MzoN0DTtPlZ+tyuYP4X8g3ARjDltvGYvE9HCTbMPiKxnEu56W6F08sluD3la?=
 =?us-ascii?Q?dzjgeWPVjRSiLMNEZ1bN1IU+hKYcQq9QYMwuAqoeqGw09R+sphVQLvrCZ3wA?=
 =?us-ascii?Q?6cNvwQMkSJ/mnci70Dx8RChzzp3haqnfNVjLYSuYhHKatDIdXdIcpIe/93mK?=
 =?us-ascii?Q?Bw5lJ77v8A3rBhwhfbwnZG+wijME6vaHS63mfaRFaBCUWRHdRHWu3vb/UvW7?=
 =?us-ascii?Q?1ojJ6Xt1YbGH7FbU5wPyOchu5t4t2XcMnIqiHfAhdVUJejx557psuFHVEfwd?=
 =?us-ascii?Q?uclp4gb2ABIOZ+Kz0xmyeqs9N7pqfp3LaUXdkIDFfxMnFqtPv1n1iAKTk487?=
 =?us-ascii?Q?EOngZ858nJtzcwWBJfruYuWAwsunYxqAiMFug6iriUPkUhuPrvBMAe9kUcbK?=
 =?us-ascii?Q?zj7xdqRaA5gx3CF4zdAp6aKFikIlfmNnJAweTLBq4XTfPep4WEBOWDk5DyR7?=
 =?us-ascii?Q?5n7mVmKSLC0Vj6GOaouyn/txA/YYaTGbkA6m9ldJRe/eAzixQrzSpo0KeGpv?=
 =?us-ascii?Q?OkCB5MJUkHU5qqckZv+PGMIUW6qq/Qh1/6ZCwnPiuZoOLKPxHYJeHNZwDIPn?=
 =?us-ascii?Q?Tok7EW9duXtue3q6sLuUkdwALi2DDK0=3D?=
X-Exchange-RoutingPolicyChecked: UbZ+V82CNNXPpa05egLtlCXvZs6I5PZN9H/6jrmDRCQLGHsmdULHgfHNrHK1nbD2LqGGroC+IY0YQ5ZiRz1Afv6aOU0yFhRgHKylraSLv1Ma8/iKL5GPCMtHAvmkttU8QjvCJuOurHZ3p5dfy4AAUdWmRBtmdLRHI/3VvSO15TevOYUee6WeoX0Gi83GxV+V21LlLhxEf2cIu2WqDUyJn40wt+G4JrGQ0Fi05JDJsOUNyIyQ8D3qT5oGfqCccceGXiSN0l9Ib7pJYvJtBzyElsS1QmoiI/AwiGpziFqNFOXjL6KKVJUlKYi16fNsYII+WqFBbdK1eqSOKuB64CvNFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbdb39e-2ffe-4c25-5494-08df356b6f1f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:19:25.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PaR6RaFeFAWnU5Qpz8zWbOOhSKTXaEHnfGTfMJrJZJftl9RTOD2w5e4SVGA7lke54MKIEfW+NCR2JN140mjBzLsRMTOHEkT4C7RUv1/tdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PPF849DF23EC
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:15AM +0000, Srirangan Madhavan wrote:
> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
> binding, so reset can restore it without a bound CXL driver.
> 
> Save the HDM register location, decoder settings, and Device DVSEC state.
> Validate capability reads and decoder counts, and restore PCI_COMMAND
> after temporary MMIO access, reporting restoration failures.
> 
> Keep PCI discovery separate from shared HDM helpers. Move cxl_rwsem into
> built-in state code and protect cache publication with its DPA lock, so
> the cache remains usable when cxl_core is modular.

Hi Srirangan,

I felt the large-ness of this patch, so I'm coming back to the top
here to add this comment after doing the inline review below.

The commit message doesn't mention much of the preparation work that's
included. Could that prep be presented first in prep patches, and then
add the new code?  Something like:

cxl: Build register block helpers into the kernel
- regs.o moves from cxl_core into the built-in objects
- devm_cxl_iomap_block(), cxl_rcrb_to_aer(), __rcrb_to_component()
  and cxl_rcd_component_reg_phys() gain exports
- cxl_find_regblock() and cxl_setup_regs() move to include/cxl/pci.h
- struct cxl_register_map gains bar and bar_offset

cxl: Move cxl_rwsem into built-in code
- a new hdm_state.c holds cxl_rwsem and its export, and hdm.c drops it


More feedback inline below -

> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> ---
>  MAINTAINERS                  |   1 +
>  drivers/cxl/core/Makefile    |   3 +-
>  drivers/cxl/core/hdm.c       |   5 -
>  drivers/cxl/core/hdm_regs.c  |  99 ++++++++++++++++
>  drivers/cxl/core/hdm_state.c |  64 ++++++++++
>  drivers/cxl/core/pci.c       |  17 ++-
>  drivers/cxl/core/regs.c      |   9 ++
>  drivers/cxl/cxl.h            |   3 -
>  drivers/pci/Makefile         |   1 +
>  drivers/pci/bus.c            |   1 +
>  drivers/pci/cxl.c            | 223 +++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h            |   8 ++
>  drivers/pci/probe.c          |   1 +
>  include/cxl/cxl.h            |   6 +
>  include/cxl/hdm.h            |  12 ++
>  include/cxl/pci.h            |  13 ++
>  tools/testing/cxl/Kbuild     |   1 -
>  17 files changed, 454 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm_state.c
>  create mode 100644 drivers/pci/cxl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2414447892c..b874340b0265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6572,6 +6572,7 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/cxl.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 6703c1729396..9a77e68d44ce 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o

Does all of reg.c need to be built in? I'm implying that that you'd
only build in the part that PCI core needs and leave the rest in
cxl_core. Maybe moving more code around is not worth it. Just noticing.


snip


> +static int cxl_hdm_read_decoder_settings(struct device *dev,
> +					 struct cxl_endpoint_decoder_settings *settings,
> +					 void __iomem *hdm, int id)
> +{
> +	u64 base, size;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	rc = cxl_hdm_unpack_decoder(&settings->config, id, ctrl, base, size);


This duplicates work of init_hdm_decoder().
Could the new shared helper _unpack_decoder() grow to do the register
reads also, so the code is shared. Also, then you could do the reads
in low then high order, like init_hdm_decoder() does and like the
rest of the CXL code reads its Low/High register pairs.

snip

> +/* A published cache is usable only if its HDM register block was mapped. */
> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	return *slot && (*slot)->hdm_size;
> +}

Add a blank line before the final return please. (subsystem style)

snip

>  
> +static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;



Could hdm_state.c add accessors for this, like the existing
cxl_hdm_cache_present() and cxl_hdm_cache_publish()? That way cxl_core
doesn't write pdev->hdm directly and the dpa locking stays in one place.
The same could be done for cxl_hdm_get_cached_info() and
cxl_hdm_check_decoder_count() added in Patch 8/16.


> +}
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -261,8 +271,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
> +		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  		return 1;
> +	}
>  	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>  	ctrl |= val;
>  
> @@ -270,6 +282,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> +	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  	return 0;


Can this function end in a single return, with the 0 or 1 result
in a variable, so that the cache is updated in one place?

snip

> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");


Why not EXPORT_SYMBOL_FOR_MODULES(..., "cxl_core") here, like the hdm_regs.c
helpers?

snip

> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	struct cxl_hdm_info *info =
> +		kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);

Move declaration to top of func.
checkpatch should be complaining about mixing statement & declarations.


> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->dvsec = dvsec;
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
> +	if (rc)
> +		goto out_free;
> +
> +	iounmap(hdm);
> +	return info;
> +
> +out_free:
> +	kfree(info);
> +out_unmap:
> +	iounmap(hdm);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (command & PCI_COMMAND_MEMORY)
> +		return __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (!rc)
> +		return info;
> +
> +	pci_err(pdev,
> +		"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +		pcibios_err_to_errno(rc));
> +	if (IS_ERR(info))
> +		return info;
> +
> +	kfree(info);
> +	return ERR_PTR(pcibios_err_to_errno(rc));


This returns the __cxl_pci_hdm_read_info() result from two places, and then
has three more returns after a failed PCI_COMMAND restore. Try to end in a
single return. Li Ming's suggestion to warn and keep the info on a failed
restore would also reduce the tail to one return info


> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	if (cxl_hdm_cache_present(&pdev->hdm))
> +		return 0;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
> +		return 0;
> +

This cache is built for every function w CXL.mem, not just type2.
So I believe we are needlessly reading Type decoders at PCI enumeration.

Can this check the capability bits like cxl_reset_function() does 
and limit this work to type2 devices that can use it?

snip to end...

-- Alison
