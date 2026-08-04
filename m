Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650881D9A5F;
	Tue,  4 Aug 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810376; cv=fail; b=QRsNVJpUdfZHphjiZf6ncjlTRabzKEuHhk3qSOfakLDRzgQZdgFijARzaRA6rcsWXACxf4DlPFIR3b33v0r0gq4mDQ7kQ1JBUJ3AaTCU0KZ7OAXp+l9CQ2Ren75CTiFtvdaHJ1RpIly0D4d6H81OEC4xAEB1A02lLq8XZA5hCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810376; c=relaxed/simple;
	bh=LRzvTx8SbDYNLb/vcQbZAaZ9Ss8d2dYRwzQP4Jn6dOY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jbn65OJB0FoIgXCiQXfPi/DugR18iRv39E3JuaMeuywDjBWIFF/VEwuZOc2RLZQNa7aH7SCyPgY9J2jUlsjt9po+k2fSt7v5C+hd9X9l9QT3gm4EOB0/kEWwC4unJNl/hmznCoxzIfA56H313A2gLdY8qPJ+xpMA5tU0kC7YrSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmhqkAkW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmhqkAkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810374; x=1817346374;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LRzvTx8SbDYNLb/vcQbZAaZ9Ss8d2dYRwzQP4Jn6dOY=;
  b=EmhqkAkWk2hpE9gHG0vOeO7p0rzwD9TBp78hBabiVJrFhNzikIAV/eI1
   bA6MZwCwaWauvR+eueg1co98Gu/5oFTamSuJdKvOmFG0EIBioJzZboHVG
   1hvTMu4+02+YX49+aNfKBvb4QMvxmdV0kFjtI2hp4fabMlW4ibz8gKB5w
   h5s+BduUZXqEaQi6qUvha5JqBvulhh4BHuctYqXjyO8F/G0ekyRWNdGcG
   T8w0zX2mN/3FD0qvmQ4ofXLNdXk7KR5VFUBIVUdclUb3UncsaTW89W5Wl
   nxCHa8KxJPg2bDSiIHfbfO2ctyGCgeFBNmlagWUHEHe4WTDP85bcwl1M3
   g==;
X-CSE-ConnectionGUID: hgYG3C0nQZ6Ulqo5PiG7xA==
X-CSE-MsgGUID: ip4HgZuZQtqUGrdgnIUiEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86207266"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86207266"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:26:14 -0700
X-CSE-ConnectionGUID: R6GmbFBET4K3MqQTMt5Nsw==
X-CSE-MsgGUID: AKvrQm1FQq+GA7gePU/dow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261446992"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:26:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:26:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:26:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:26:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER1ZUuCFFmdecNq/N8VnolaGieY5T6w+vPsA97UINtBUWJ62UCDHNVMyevf7ffYgs2d9XM2XE9Z4LckcNo/Mi4CveRcLGdYUoXmkzYdHX6SIdp3kp8D9HLDvB7qSpSRVB0yScHUHUFcgagh2JNc3oOBEIilbKMXxpF7uVnGVi728e3LMb+DpGpW6S2PXGCxh60yc6GixBjOShn0BKGS0t+/ORPzBmRx9td5+W9Lb+8KsolK6GdSTcEb2gdn8U5WYudgEw2+RoBLlpX3AQoplTlJVvF6jPIB79wzjXGMe/ZLjMznAfEAU/in3A0NQ9zGN/9G19js1OSmHpZ8yB1/YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QESUhTRQYQvR9u91Chpj/TIy+E6Kj39U5J0peidCAac=;
 b=jTEmxsnNkD2j9rKW0yuXHAhWwn/GTQGQpX6lOAMspCRghv3dCJoqTlNouyWNUiu4078iHSz1NRkLIekJsqOVvfmaYh+uNFppfndaMjAOH504OyFbzjKIzxbnqGHFzh9GrMazSpfnuhup1TF/5y3GNGb7n2DRDU9C6JOZJQaV6FTW0ELefpbMvLEBJoW/cREOqAz6159iRGcnC6v3Wl7gavzx9KUDJb1PCkYYWWMgu90V6UoDi0I3OP+J+Iue5wDY87ffoJoJcX9XYZ1L4StN4nuksFbRp/Ueo4oqvaS+7qqwWZDVQ5JhVg6ECG3F4uj0oppl8V80YM5k8OpvsNiVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 02:26:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:26:09 +0000
Date: Mon, 3 Aug 2026 19:26:04 -0700
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
Subject: Re: [PATCH v19 11/14] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Message-ID: <anFNvMQEuG24ycuY@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-12-terry.bowman@amd.com>
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d9bd1-f61b-4ebd-b97a-08def1cfbed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UAmW/CPtJmxsd1sHqPAeycvrvo70GG37+0TeBBwvNot7f+vtgCJ6/nhcLnskZCrahPzghpUU579OnznYs/bZtPhWsmrrX7H6lm5r+9zZwJ9Tj1Mt/z4K2OA8fqVyQICisDzYj/yL0eLUx2mCLb5cMvlPnJOcwd2nPtBPrJHhhFeID0rBV2HOA8Gny691PqEDZWLBVlFZtkuK4R1Sdmqu6qrR2IIjL8Ak3ygns/sJdr5G41QD02BId2vApbiIeHcvyU790ylYJUvQ32C0gpN0Mq/rN/spIoncuXAb5lque+b2XSOdp2sPbodlNSimsEEUSVBy4ab4+kQ9/obXhmhyFkGJoFsVvUGD3inqooZAe0E1zLJrgPnw6WdoVRekBmNxNdkd+a6iMmZTwErvuzRlnSWoJ0TYGK03HuS9TkiW4PoHWAa9TyPkZd3HlDCY7EMTKCX7pH9t3ez8RAlzF8crhbpHZ00aAf2X3pjG1HtLrlBdU7otoxhLnsXftGVxjbzaRS8nLvMlWUlqW/XF0hgoUp4J2svYrhMSW64As0wjk7i/tooffn/nhvWrBopQqRy3skaAc1dTsf5imqc/6PJtT8Sf8QqHumFH00iV2+vyjqVPHz1WLE7RI371VcxvmzAzBltzW0EVkzgYMZHtF0Oq6mC2pOoMCxCZqm9HW6w2B54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s7Q5W/Veohz6w8xGIYA3Qhhov7iP01BGWvw+gmnvw3HaKstLxwsNk/HylXiT?=
 =?us-ascii?Q?PrWmtXZrzEy3bDBHJOEoF863rJNUyPI/FoZiPFrCpAWi0E+E5Q1c74oTrzJU?=
 =?us-ascii?Q?3Mrlksips69I7GXwQmu1o0NHv+wqF80OvXnX+GFvS+ne1KXdLkAsEQlCggIU?=
 =?us-ascii?Q?ATpaX0kVzxH8w1irT0WD/L47PfnRAg8KPLHjdJ6MHMfZp2a66UzB9nxy00d2?=
 =?us-ascii?Q?iQ3HJUFCfz/Rf3zYW43P9mArqHxXjaUeBnpRUELSyaiCZ6Pk0p8tLWTxzCZz?=
 =?us-ascii?Q?Ij7otDcdA9qs/GqlmwBF/AZdFAuhdWt96mT9P568lrtWK0jQXnL26Q8PBb45?=
 =?us-ascii?Q?d7G5V+zRoComNszjPxqzVfcYDdy9OC8jpydbGaUEn3CZMZV8TrYlFeyZX0B0?=
 =?us-ascii?Q?jL640CrmOBPWkMb0VE347WFVlJEvflst+Zx42EzAphdCQT0Smfk5g7ef/XP5?=
 =?us-ascii?Q?7GGhmiBF3vZtPSkrJvTvjooL5belnBFhVd20/xhJHSc4t9f7iGfp6ECTxBSm?=
 =?us-ascii?Q?w5/qllPflee4ecYCABQK63P6xQ/weSneZbfyurshePmlQx2lMxl9Yb4VsQbT?=
 =?us-ascii?Q?FB9RfdrQgA7FZE1jVYm5KfrLs+FlIO6vX24IP4Eb5hRBRfDGrfRqonjPk+bQ?=
 =?us-ascii?Q?sKQRpg7X/oIW1MHwwJcapjQIcNYviBA6H19mH4NMkVJQK4ODp7e3lZMghWUX?=
 =?us-ascii?Q?vRGk6FY8wwm+T6SrbTU1QbKsbTYiz2deO5/KWjKgjfkn+5OkRiZf4xMQspyy?=
 =?us-ascii?Q?uZgmbeRPHuMcH8xmj9PY2gcoq4UsjxVRC/tsiCQlCfoM/MordEdtrXR51zoK?=
 =?us-ascii?Q?FVwiY+RRujoPoKicmGw8QyM7mTc0rrpZviSmbPpwACXiYm0o8gNOO72wC2cC?=
 =?us-ascii?Q?WNPIoKHWkQ89U0BAxhcma09Fcgqhg1vecQzDZRMEoHZXPn2sX+id6KB6GCle?=
 =?us-ascii?Q?REk6+qsGL5beNK7fmOhLFNRgZCwfN3I4WbiHDLIGo0ITM7StCzPNdOd/u0aK?=
 =?us-ascii?Q?Lzyu3hNJkNz5EKJN1SgJP6zcGJ9Nu4/JFS/2bKqdREs4kw9eII9KZ9HLrANS?=
 =?us-ascii?Q?Z05DY8CDRS8ta1e+IjXdKuixY/rE/hzbt2R0HIc3TU/cEpL2VwmAJNqE4ntT?=
 =?us-ascii?Q?iFbB5LfwaDTb6nhOZYpTauZpSksVxc66Q5IRzIXkUXSvkYRI0qx4Eq3owzwI?=
 =?us-ascii?Q?hWkd+ngkvECKewxBKu3DcDsrwyGWDYOiAvr9xk2bU45EhAkusgsxuO1y/ElJ?=
 =?us-ascii?Q?rso4wkfkF/QireOKMPqzZQKjYWD5tgFVFz6dHRzlKeuAt74aoEr1ORkCxUz+?=
 =?us-ascii?Q?z6HiO1t69Vp+x2C/sxbkpNTyvin38j3onQ4XTkSq1dzlWKvNXgU33KvHbSoQ?=
 =?us-ascii?Q?O5piX7Y8rzz1GEmn1l7LfNiOPUz9bmGPxLWwRi5+4GemKftitHTKh9JF/ORz?=
 =?us-ascii?Q?wBy2F2xxIiOXV+teu0WigZ8LmK/BWW+Qwic4EsS0sRtdUXmGWtIDS6LJ0ZjI?=
 =?us-ascii?Q?vhvF5ZGpJEa9LbiiHpGYsNMMEb2OWKY/OGxKliSP76UVgLVopjqZyhV7TqgN?=
 =?us-ascii?Q?38sFRTMakQOB/28TyjRPP7s62A6VLo4Ivpu3auWOaN24BOmN5Z6ZIXyVlzP9?=
 =?us-ascii?Q?cXYH7EDrKD7cUj0drS8VakedF8XFV3elIQggQUh1evI2W7FV7m9A3Yek6EAk?=
 =?us-ascii?Q?o1FC/uZjgCeYUU0IqVSMg0Zcc6+B4EMVSyF6rROpGiwUu8+7o0Njq6w/c9VY?=
 =?us-ascii?Q?j1bVm8lJfrj5bo2JC/6fKBCS7qAg9PU=3D?=
X-Exchange-RoutingPolicyChecked: RO3CF+wddap1V/K7XS4jmzVYhG/CraMqTmcePtj8wXEJHMPTQnybxNW0SP44V/CKi+hvXkk+cxc130n40tIH92ZSXofkkuNQRSIt9Cxq6zCvrjZucrv57o0RdzUCgHNBswH7yRbSnC7LfQrAvBFbMsQ1/PukH9BXK6mj8hX97mHbo6/cF9YRBYSROXT2iOBovZ83hq1bX47YHBlIeP4pmvHoh08heeWYZhxaZ7MU2uxIRnqD0q69jEgGqyiXKsvTEwrFtib59d51RJ7YA4sWm9ZFKtpS1i8SYikfExuMzrG2EkNm01lkGiFKt8saP98gfLth3rNtOElH1zVQNN/NbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d9bd1-f61b-4ebd-b97a-08def1cfbed6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:26:09.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7GaP4OhHDz66/phGBaR47gXaE2ztufagnpoQw1ruuFfKixTBg4HS1nR9tVo+7goYzLKCLuhIQDhGUOTQSaPP1iLiVjuF5sbllsRVkS+lWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:07PM -0500, Terry Bowman wrote:
> Subsequent CXL error-reporting code paths need to log the PCI Device
> Serial Number (DSN) as part of trace events emitted from interrupt or
> panic context. Computing the DSN there via pci_get_dsn() requires PCI
> configuration space reads, which are slow, can fail when the link is
> down or frozen, and may not be safe in some contexts.
> 
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'
> 
> Remove the now-redundant dsn member from the pciehp struct controller
> along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
> in pciehp_configure_device() and pcie_init() that existed solely to
> read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
> for the device-replacement comparison.
> 
> pci_get_dsn() is not modified because it remains a pure config-space read
> with no side effects on pci_dev. The cache is written exclusively by
> pci_dsn_init() at probe time.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
