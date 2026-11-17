Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936605;
	b=PiJwx2sTRulERU2pgUmGhjvug+zvvZvfsgXc1PRqLZSbJe1lY+ZO8cNu1/9ZBaOnqGz1
	 npvpI/ElRcCK1dqdBKJDBmq5Weq6SgJ3tUGxhBCh6+LmP43skCIoyRwP1R1RUAPh1H+OU
	 pB2vl7Sc+m6vJj4Cvx3yR0wDPGuZvDvuj+kC5KTTWT+8Iw8RRL4xl4ufSFZL3osqtEN2f
	 m5uB+soGVrS1LdcqcB1voqvrLPgZmhtE1L+PttzW5G8y8n8T4vyoWpvkLG3SR4twkbkji
	 z2gJcodk2OdO4a37Jeu2JszM0ng/rC0NUqXyXEtzKEm13371xYXAXcZJkVwuY4ycodg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936605;
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
	bh=VeUKSrZX/smDulB9WnH2sgOLMyOyhc4+nNAOnpQd3nk=;
	b=QpH9hOwewbjDYy/RrTQmzeleWm8odkxoPjZJzTW1Wmg+/VYi+DZ+tf51XVcx0UriPkq+
	 OORJwZimQGwK237AFUIc9oep+uKuYQlSwfqidssEnf6pb/PsiRSNF1+laXWEemj7x/f1m
	 jygeAQxlzwePP1XJ6mUyrjM5qc80GXe6OvQKAmzf26xa8hEjAZSxd96wgMXHc4GnZnTTu
	 OHegnV+WMpe/xpSaoOuwdBO3NPM6AGx2uJITcEj+r+RFWS7rBCzd0M3bBD/p/XfxdujrM
	 lGKRD539Ane03VshqRDcc6OfKjciDSJsoVVyORNqcjaVwXujmzaq4k6okZvCNhNw6zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aOG3FXhF;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=A6obcs81;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F58606A32C;
	Tue, 17 Nov 2026 17:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F58606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aOG3FXhF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=A6obcs81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794936604; x=1826472604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nP/Hi3Kn7m5yTWxPwBzR8Ik09nGN5PY14Dd6bEJj5XA=;
  b=aOG3FXhFDDJSkgycyW5SWje0YCMZAt0WTHyL2/wg1f0Y3V3iYRyNfwhK
   d61dOfloYMhbowKT4RkwmAdQNWVsqXkUePl96dD2MT8fOvXZlJJTrUNNo
   DnLgwH+bMgpJCJ3P2vlw8HFzFoNyTjxeCgEKb8sUDpvdas9j23grgYSKf
   eTSsZ4FZWksKNFAjblYxXK2JjwA19gPFQGdp+CMZdIXlnTirXhkmudu9S
   tleYqFas2iA1fvep+BvCy+R2obPyiwXfChaN50iwqIIhSvhqWX8KNRDAO
   icDRbrj2XarIc5W+X1N0443DMXtB9DPRFRXO52xh5aI9zDAqEXgFBPm5+
   Q==;
X-CSE-ConnectionGUID: yhTb6oORQZOxyllFGZFACw==
X-CSE-MsgGUID: PC0Q0ZllSZKR+308SjFWMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3640029"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3640029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:29:59 -0800
X-CSE-ConnectionGUID: F0U9+yYLRBuNWA9jycRTBw==
X-CSE-MsgGUID: ekB14WhIR02viEqXa09F/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9833263"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:29:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:29:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:29:58 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:29:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs1IuZCjNQ1qoYeYlZwZOtG0q8x6QKYuIbA2KHLsDkSIr8MVbUXZRchomANnFdb8yOWTh782Tjr45Q7iFRPM+iLVPXS7R9RxZpYRgaziWzv9Zq7EEJetSUeMJ74WOapvdjFcBp17JOC/nYgGcm2WvWHqDWktC9nLCJFTjCKrIN+/S9Zw2DXlwFlABjVjE0gNU7wPR8CjfPXKDjJeMYpZxYU3GIgHDsOVy2EAOBfMAs41Pn4FOxOV89hnohpD3w2lntAj5kbtWkY6XqnnJnkUYCjEVQOWWfsXp2excLd3i1pFEgQJ+w8XfNviV5KF1bcZd9yCi+MpYWrbMi4lnAbWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeUKSrZX/smDulB9WnH2sgOLMyOyhc4+nNAOnpQd3nk=;
 b=rMm3o+C14rbHy/xzDO7AZb7f9uH7ewaOTmTC2pAfPNB46Nzj/CtNGLBE888BD7eDwNO5kv+eprrq79j/w8VkZY9Uf+rbGkGmSHDzdsczU2UvssNpfiS/f3XhYqmfNo1fnGLDTOfkEzQpo2m5zeQZJnmb07krjFY6H0VtqRG8HLN4lcaPKh76ZcfPMaEQGbp9l2Dq9PcrYLPx5AsYSi+zvZjogYHJwGt1/JSLKTfQbQHFtNTdCu15NOKFyDAfiF2SvhbXwOuwoJgTEQWN16sx1A8LdBK+AkIzCMxRsaKPkmr0aOz8Ue00nj/PBGPVIL5LB15vZpSlMAUnpQCjUcbuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeUKSrZX/smDulB9WnH2sgOLMyOyhc4+nNAOnpQd3nk=;
 b=A6obcs81mKMvTDmQSFcW6KQD13sj47KXoahbVoAy3/rZCGlb2AA2wedrwO53M4ni4rmDoAH9puDkIILfJQ6GzV5o9+pYeEAG/Vw101wskXdo5K9qyvJAp1SAIS5Mprl+4Z9JmFA+YMcKezZFOD8dHY3N8+/hzjobDcjbHOtYlAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:29:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:29:48 +0000
Date: Tue, 17 Nov 2026 09:29:43 -0800
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
Subject: Re: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Message-ID: <avyPB4YCEKUDtT19@aschofie-mobl2.lan>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105185917.2667656-12-smadhavan@nvidia.com>
X-ClientProxiedBy: DSSP222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:3d4::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 88860e82-bd52-4005-1106-08df44d0611c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|5023799004|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261022113327099003|261028144727099003|261009223327099003|261009221227099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009221727099003|261009223027099003|261102130727099003|261009220027099003|261102123227099003|260925022911599003|260925021311599003|261022105027099003|260925021911599003;
X-Microsoft-Antispam-Message-Info: dGjzRg8hGImUsHL6aGiVLUUNNNUtOnQHUKK2aKMI6NPxuUiqyqthPFtS0mYCQ2kVn5V5lPYM1gWJXKBqr/aP1gSG8h5aDhxMGUAdhp+mCPbkMI7EkbcHoaISWMFMl3PM37KZcE5w9b8q67kxpagphvIQgn5vMNbjKC2vX4FR+ygQVnaJZ8Qcqq3usFtuwQy7P8n1o59uLu0/rzDHTtOoXLHEEFGuI+8Nrrx4IkBm4bC0NWsLqVOMjV5F8ngJz6ky82SHtzFsFUzqs0s4M5hsD1Hyy9xc+zUky10HBU+fCo8kD6CpsMajt0HFI12myFXqW071shP08rjYOTZ/YIDlLikl/g2p0h/nAxk5VINmTjKiZenMfFUy7VXu7b0TIwlXXDgiTuwZVGREs2tBn3OabQqj6hyaKJHPXKs3GBamN9HSfAelU6QBTM9pl5BvurNZdEWLWxkYuZYPc523WyqCJ7Kd50VzlsjeMfZGCfn0+5Dq0ga1EzEhsMFcXmIyGr2QxvQjnjzhvwzZuHzHyCSptwI2kH9khJWW6ifAvoHFEOgdBkIHRxk58i6qrTYVwsyzpLU/Lh8CrIXkhi+XUvJv+CPUUl/VDqCyZKXuORFrA3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261022113327099003)(261028144727099003)(261009223327099003)(261009221227099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009221727099003)(261009223027099003)(261102130727099003)(261009220027099003)(261102123227099003)(260925022911599003)(260925021311599003)(261022105027099003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgNOzLc0WxAUWDfUutkInAcNRnhcZT12wSOftoaJi+wRsbE/mB8p4fSJ/X6Y?=
 =?us-ascii?Q?6rb24DUKc+0FLS6JZEHWQ34GEhOe9WlH5QoVJFH2ltbUg+5uhutu+7b6hxZf?=
 =?us-ascii?Q?9qyI5vb3YyJnlfjKJQS2NjMzIH6auLgiZJem2OdXZf6FDBc1rIJ2zVFGjtV7?=
 =?us-ascii?Q?1SGLHBlE59egb2Rd3NhUAVbmWZMgoIdbovKqgllpTk0+VP+CZ/2ObyWpwHCo?=
 =?us-ascii?Q?HVcl9Y7oeXopZUcUbNmFQCQWc6npubnMDssJ0feMy4qg7HxDDEpP53h8UqNU?=
 =?us-ascii?Q?0s8BgrUo5vH7kTSSoyeN5yC5fEiBP5t+KxsSTntdBw3QYUbYOpx8owDYAwzW?=
 =?us-ascii?Q?AVThs6MwRV+mw7eIlCp8To6xNYurm8AsFr4RNkttcYmPvq1HSSGSP6pgj+T4?=
 =?us-ascii?Q?BJHAE/0koabXVKWd7/D68xdoLSXyaijm5DIIYxacGcH1e76rO5fvXZfDX6/7?=
 =?us-ascii?Q?+DEl1q5KJjpxKcObhvNGmwN+yKMXfqpkGnqRB8liCpmzb8hH0bu4j5Z8UDWl?=
 =?us-ascii?Q?2qVD6WNh9B26CWIb3c0FbrttcpjMVvJIDRK6cjy0Jr42ja53k+Oo/JPptDxv?=
 =?us-ascii?Q?baaV8wzkN71UEtWTKCaui2srNTsidAiwOW3tW4Z7cL2EBS5+DbhAKC8o/e8G?=
 =?us-ascii?Q?yhrvTdsI91ji5fJUML3VNN+6QJuqIMpdkvest0+YuJwt2EmnNa+ox4WO3pH1?=
 =?us-ascii?Q?LOUs+NgFrA54SMBkEwaLEhwa5VBeaFW2xO6vYJsWsRworIExAvUhBU3iTcQ8?=
 =?us-ascii?Q?g2+7nr/CyzL4Oiq7R6xVQZ5ipsaJdG6DNuehyMVJcxPEPtIrQK9+c+1WSovR?=
 =?us-ascii?Q?paXYbqrhWLMZaqn96o2iSTpPNcKy4FLGUXKsPjOW+vjxLL2oEKSm6x0xHXQZ?=
 =?us-ascii?Q?hwH1QzZtYXwtfSDa3SFPGTqQu25T7q6sKJpcRdiUkVwSR5rkHMfpXQuFxhIa?=
 =?us-ascii?Q?JEt93CPASzOGLrVJodEazux2zyJJA9p5JtYJcweMD3kRC4ewxTifNqVD10Ce?=
 =?us-ascii?Q?aCLmEk5YiH+8A47Il6iXfP8wGZcN3skBo4KwislhNjTsmRjOG5mr0v99xBXj?=
 =?us-ascii?Q?tnl5ENiI0kpjv3VLrouUJPDEFLnspbdGeDJis/SQfwI3ZDm1Uw7xzA4tDKAy?=
 =?us-ascii?Q?b3ofeWirCAvFhPzwFZFSqhrqn37RfDM+9kEoPiWw3NN43Egqlors3rlFSvjz?=
 =?us-ascii?Q?PUVXpyFh+wYnnbudC+rM9r0wuB2Q83tXbPn4AKkYtXH/YD4g1OVgYpA1+Svc?=
 =?us-ascii?Q?tEIv3s+6bekOQ4h2M9UK0acu67L0SewQ5pvLH+R72M140twSiVemVXcFTOIW?=
 =?us-ascii?Q?r2J8U+HoJpzCAP80w9BmfTUtwpFujA8gZSjwb/KjkIQHNyLGHZ+r3gKDFc9y?=
 =?us-ascii?Q?OR8D/xt7ogzSw3BZvDEIn1ban/OfsF9LxsfnP/h/8+y6t5bjhuSVao5fizj3?=
 =?us-ascii?Q?zQ0sano8wjIuyxn+F9W2zus2Sm8ctiETwYD0PJYikGSnzTFge1I1AHX9QCZw?=
 =?us-ascii?Q?1aSkUmkz61VQPPPCiT0TKo+rteYorg03plOoL4otES7fyLriotLKNIBk/3C6?=
 =?us-ascii?Q?QIWSvJOubuPg4fzRRepIzTsiOLU3MWUgVOH9hzwvIJoGVeNQ77jTJfKsk+P0?=
 =?us-ascii?Q?rk6CRxzO5h/O+pOfAijmIyVX2UlOBfahHbWghmrvJEYC1Fzb7QWmnWdv/NjL?=
 =?us-ascii?Q?RG0w7b9Dm5mIiLg/5xP9OLNq3pgJtShILbqAH18umRtk7ExF7cMn0DwxwptA?=
 =?us-ascii?Q?2ZM6JNPnXcSE4rbFeUz0NJPJPldO/uc=3D?=
X-Exchange-RoutingPolicyChecked: CnB9JI2CZYmSn6zaz5k1SUpcYs0bPIO+eui05IQgJW1gGEvSVasx6Wao2Q0CT/kDcOHxNmbFMRaznJ1A4sRQPQZg9Mn2nTcA+3hkiHQzLeZTLDZsxQvqZoFvPm4fuCTd7+VygtnukWEBS+vRAWCNvNS8j2jLt57vOkoOLNInZEj2T2p2AzFqr8y5ByURD/ZPyFgcBSobXFGpBAsMJAXcnqV4pV8zMse/xktf4MmLcZJ2/PkegdJiRUEAdyO2Zs4Xy2/KkkvrFxQCddy2/oLZcQqQNyIhtzVhx0INv5P+exf82hcxtJOde7Zo5OBhiu3dJ0HzRrC9wycqNfraBy7ifg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88860e82-bd52-4005-1106-08df44d0611c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:29:48.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhNkwWhUM2nMD38Z4Hom7bGFFo8UEVU34uDdy1UrUWE4ZmyJlskAPt3Q89k+V6YjxZ2rYY3lLzfqAWbDjMnvLgkm4I5VRkFP/IFw5sGAor4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 06:59:09PM +0000, Srirangan Madhavan wrote:
> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
> binding, so reset can restore it without a bound CXL driver.

Does having this cache make the device ready for reset before its CXL
endpoint and region discovery have run?

I understand why restoration needs to work without a bound CXL driver,
but what establishes that the cached state is sufficiently complete
for reset at this point? Some information, such as normalized
addressing in patch 13, is only recorded later during discovery.

-- Alison


> 
> Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
> and Reset Memory Clear. Save their HDM register location, decoder
> settings, and Device DVSEC state.
> 
> Validate capability reads and decoder counts, and restore PCI_COMMAND
> after temporary MMIO access, reporting restoration failures. Publish the
> cache under the PCI device lock and protect later updates with the DPA
> lock.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 
> ---
> Changes in v17:
> - Publish the cache under the PCI device lock without taking
>   cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
>   cxl_hdm_cache_publish() helpers (Li Ming)
>   https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
> - Reject an all-ones DVSEC Control read in cxl_set_mem_enable() before
>   it is written back or cached (Sashiko)
>   https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=11
> - Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control
>   when MEM_ENABLE already matches (Richard)
>   https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/
> 
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
> ---
>  MAINTAINERS                   |   1 +
>  drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
>  drivers/cxl/core/hdm_state.c  |  37 +++++-
>  drivers/cxl/core/pci.c        |  29 +++--
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/bus.c             |   1 +
>  drivers/pci/cxl.c             | 225 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   8 ++
>  drivers/pci/probe.c           |   1 +
>  include/cxl/hdm.h             |   9 ++
>  include/uapi/linux/pci_regs.h |   2 +
>  11 files changed, 399 insertions(+), 11 deletions(-)
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
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index cc5d77c4abf5..c92dbb017162 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> @@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
>  	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
> +
> +/**
> + * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
> + * @dev: device for error reporting
> + * @hdm: mapped HDM decoder capability
> + * @size: size of the mapping
> + *
> + * Return: the decoder count, or a negative errno if the count is reserved or
> + * the mapping cannot hold every decoder.
> + */
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size)
> +{
> +	int count;
> +
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count < 0)
> +		return count;
> +
> +	/* The last decoder's target-list high register must fit in the mapping. */
> +	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
> +		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
> +		return -ENXIO;
> +	}
> +
> +	return count;
> +}
> +
> +/* Read one endpoint decoder; a disabled decoder keeps only its id. */
> +static int cxl_hdm_read_decoder_settings(struct device *dev,
> +					 struct cxl_endpoint_decoder_settings *settings,
> +					 void __iomem *hdm, int id)
> +{
> +	u64 lo, hi;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
> +	if (rc) {
> +		dev_err(dev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE)) {
> +		*settings = (struct cxl_endpoint_decoder_settings) {
> +			.config.id = id,
> +		};
> +	} else {
> +		lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +		hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +		settings->skip = (hi << 32) | lo;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_hdm_read_state() - read endpoint HDM decoder state
> + * @dev: device for error messages
> + * @hdm: mapped HDM decoder capability
> + * @info: state to fill; @info->decoder_count must be set
> + *
> + * Return: 0 on success, or a negative errno if a decoder holds an invalid
> + * configuration or the decoder count changed while reading.
> + */
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info)
> +{
> +	int count;
> +	int rc;
> +
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
> +						   hdm, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count != info->decoder_count) {
> +		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
> +			info->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index d4c2be1ef833..9def4a7439c9 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,21 +1,37 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/cleanup.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/pci.h>
>  #include <linux/rwsem.h>
> +#include <linux/slab.h>
>  
>  #include <cxl/hdm.h>
> -
>  #include "cxl.h"
>  #include "core.h"
>  
> +/*
> + * CXL state that must stay available while no CXL driver is bound: the CXL
> + * locks and the per-device HDM cache filled during PCI enumeration.
> + */
>  struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>  
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_dvsec_ctrl, "cxl_core");
> +
>  void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  				   struct cxl_endpoint_decoder *cxled)
>  {
> @@ -70,3 +86,22 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
> +
> +/**
> + * cxl_hdm_cache_release() - unpublish and free cached HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Take the DPA write lock to exclude readers while clearing @slot, then
> + * free the unpublished cache after releasing the lock.
> + */
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = *slot;
> +		/* Unpublish before freeing so readers cannot see stale state. */
> +		*slot = NULL;
> +	}
> +	kfree(info);
> +}
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5272013548c7..ea5327cd627f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -209,22 +209,31 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	u16 ctrl;
> -	int rc;
> +	int rc, ret = 1;
>  
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> +	/* An all-ones read must not be written back or cached. */
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -ENODEV;
>  
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> -		return 1;
> -	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> -	ctrl |= val;
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) != val) {
> +		ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> +		ctrl |= val;
>  
> -	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> -	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		ret = 0;
> +	}
>  
> -	return 0;
> +	/*
> +	 * Refresh the PCI-core cache from the live register even when
> +	 * MEM_ENABLE already matched: a reset restores the cached value.
> +	 */
> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
> +	return ret;
>  }
>  
>  static void clear_mem_enable(void *cxlds)
> @@ -314,7 +323,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * capable, there is no point in continuing to enable CXL.mem.
>  	 */
>  	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
> -	if (!hdm_count || hdm_count > 2)
> +	if (!cxl_dvsec_hdm_count_valid(hdm_count))
>  		return -EINVAL;
>  
>  	/*
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..7a5d9f7297e9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_CXL_RESET)		+= cxl.o
>  obj-$(CONFIG_PCI_IDE)		+= ide.o
>  obj-$(CONFIG_PCI_TSM)		+= tsm.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..aad567fb7c56 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_cache_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 000000000000..a0d20f4210a5
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +/*
> + * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
> + * memory device at enumeration, so it can be restored after a reset without
> + * a CXL driver. HDM register formats and programming live in drivers/cxl.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/hdm.h>
> +#include <cxl/pci.h>
> +
> +#include "pci.h"
> +
> +/* Find the CXL Device DVSEC and read its capability register. */
> +static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
> +{
> +	int rc;
> +
> +	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!*dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(*cap))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	return pci_resource_len(pdev, bar) &&
> +	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
> +	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return ERR_PTR(-ENXIO);
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, hdm_offset))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
> +						      hdm_map->size);
> +	if (*decoder_count < 0) {
> +		iounmap(hdm);
> +		return ERR_PTR(*decoder_count);
> +	}
> +
> +	return hdm;
> +}
> +
> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	struct cxl_hdm_info *info;
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
> +	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
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
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return ERR_PTR(pcibios_err_to_errno(rc));
> +	}
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				pcibios_err_to_errno(rc));
> +	}
> +	return info;
> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	struct cxl_hdm_info *read_info;
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	if (pdev->hdm)
> +		return 0;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) ||
> +	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
> +	    !cxl_pci_bar_assigned(pdev, map.bar))
> +		return -ENODEV;
> +
> +	read_info = cxl_pci_hdm_read_info(pdev, &map, dvsec);
> +	if (IS_ERR(read_info))
> +		return PTR_ERR(read_info);
> +
> +	/*
> +	 * The PCI device lock held since the cache check excludes other
> +	 * initializers. CXL drivers bind only after enumeration, so no cache
> +	 * mutator can run yet and cxl_rwsem.dpa is not needed to publish.
> +	 */
> +	pdev->hdm = read_info;
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_cache_init(pdev);
> +	if (rc)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	cxl_hdm_cache_release(&pdev->hdm);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..9e218f236e66 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
> +static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> +#endif
> +
>  #ifdef CONFIG_PCI_NPEM
>  void pci_npem_create(struct pci_dev *dev);
>  void pci_npem_remove(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..cb52357344ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_cache_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 06e9aa4479c2..0604dcc439c9 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -26,6 +26,7 @@ struct cxl_endpoint_decoder_settings {
>   * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
>   * @hdm_size: size of the HDM decoder register block
>   * @global_ctrl: HDM decoder global control register
> + * @dvsec: config space offset of the CXL Device DVSEC
>   * @dvsec_ctrl: CXL DVSEC control register
>   * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>   * @settings: per-endpoint-decoder programming state
> @@ -39,13 +40,21 @@ struct cxl_hdm_info {
>  	resource_size_t hdm_offset;
>  	resource_size_t hdm_size;
>  	u32 global_ctrl;
> +	u16 dvsec;
>  	u16 dvsec_ctrl;
>  	bool dvsec_ctrl_valid;
>  	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>  };
> +struct device;
>  
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size);
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info);
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
>  void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  				   struct cxl_endpoint_decoder *cxled);
>  int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>  
>  #endif /* __CXL_HDM_H__ */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..ca3e77b72d87 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,6 +1352,8 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
> -- 
> 2.43.0
> 
