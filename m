Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C23ACEE1;
	Tue,  4 Aug 2026 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809662; cv=fail; b=Y6H/vGrbdZqoAfbhnGErHm6lR49yELrFWoM7NmqtFjsEBcv/Sg3hhhehbPFWg5xt+xTD17SOpwGgqAXY9wE/DFXtOo9eRAWSpCEfDJWS6vekU8NhG/G1lhJ4iEpVbNGdX15imZCUkjSXUwuWDuP53R/SgJ+3GYZJJ7UvpDlQdpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809662; c=relaxed/simple;
	bh=YI+0xEyXrxNNhYZOzIkxgW2sfziiku1uzCeiIsTR7IE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V5knUs+Y/NrnUOBxHQ/BzjMcPFvQZ0OrND3R+OAbNLnU4MtQtCygnS+ANVGUkBTJEVROxce8Gth6UAun1RYTeR0DOjXEu4Vk3s7cWyGV+5UV0DcdRqZOsVe2rvgEBDn/aOc4RNgxp+yxGeiey/dozOETrc/ngwhKP3SRTpSrw/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Stn8O4+o; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Stn8O4+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809659; x=1817345659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YI+0xEyXrxNNhYZOzIkxgW2sfziiku1uzCeiIsTR7IE=;
  b=Stn8O4+o5fSrhszZCLClt/aLoo1OpYux6spa6upkfSAxPs8TKf9ok6a6
   x5zNtYWUvt64ziW0bNrxgJ9cewYQmCAsjUTa+nUMwBhNfnVusS7aZ0ByW
   GyFHXz/FJX/jiGbkE8rDnuzWccP5y396zKtO5M36MA6DQzXChWGsigxUB
   yPqHGroMEkfrWPDNKIsgyoGZv8NBX0iQktLPcvxMfMzWHfuF4yX3UMKgw
   0owIzpa313pIYL6nQ0PbLd3qtOZl99bSHx6nIcf1SkSAy6ON2PTwx0VQ3
   wsL6CY4v2KOCKN/gkXqMXzvp93ohlfYSk6WhzsVf4HeWh7dwfjZO5nLbP
   w==;
X-CSE-ConnectionGUID: 8Qr4SBohTQ66Tbvx7fBDYA==
X-CSE-MsgGUID: GG9DLOvbSOGeN5gzZG88cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97006090"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97006090"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:14:16 -0700
X-CSE-ConnectionGUID: x+8B1gbcTgazXm9Q12pMgw==
X-CSE-MsgGUID: 2WFlqhNORXOpHhiOqHP9Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260775387"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:14:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:14:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:14:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VI8B1aF7gYGBVIulOmons/UVFZ2tULWsgO2v6vraH42nCdsGK36lJabsiylJCS9ZDXFJvOf7JHZipiz860f6Fs+efYAHTOmJbcrtPbP7PKcIge+UTmAVNPM63C4bgkCJ0NUwUmVu5KUeYZGt9p02AA0wPUdWLaDXBVToTmkeGrfDffUB/+YupXnLLBXD+oVeWf1VMBcAKhgYh78gPN6W/tqjkJAEJEoJ7A/6zp2t6M7FsU1Fwi8FNhbUe4kZLWG/Z4YXe/6eHltyfENRErU7DKZkXaaLYZO7pNiefZw8IjoumVOpZ0a1LbZ28xqySzSLg2SiGh760soHm/KyT6qalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miTYkoh+I7LKie0vFokOIdE1p+s9W079zMsdpBCPAog=;
 b=Prxgw3/9U8knM5eNOKZ385t3x9r85d3q1McI9eSUrYcamgU6wQnZLNtu75/L/6otxOgrPa9dGfOxxvZhREgtuyIu0kbxYOaCjkp8+ZJHy6acRgznaK1yr1JL/eFk4uWjaGKLayJJ6XM8hL1QySkrbkWp7f+S3VGVgiBs4cV9f5O6Gbp5VIzFedkASN0n+lapFxiFC4dLcPDObVisEojCcoCgqK2dpTNQPrsLkbJ+jd/uI2oJxCT/s8v6slniMUy+Elx+4ImeIz/u3QSQKpB2SJITvdz8PSd/117V34ifXi0nEm3imQQtHN3GR/RA7nyR58yJFzM4258O3Y9gbuUiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:14:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:14:08 +0000
Date: Mon, 3 Aug 2026 19:14:03 -0700
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
Subject: Re: [PATCH v19 05/14] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
Message-ID: <anFK63OIe6-Kp9mw@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-6-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cc7933-c161-4a8a-f01c-08def1ce111f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: XPJ/oBvcUwGyYCDSlr0PIjESNzwOrwrTGU/F6vKhVREQaFTmsiOU/9BYhREkBZKG0HHe7Cb3FD+nvE89RZmQfqeuglRlI1lmj9ENvPBvL+NPu8OHwfkcEmOGdS8keTGR0pfxeYw/qBJh+/ZU1YY1WLkCnctc06+GO8/ux1ylSeyqz48Q2GLlEeQYRuYfv/YhaVlvEqrwr3RpSlkSa8lhWnu+STSV1otY2A7ijmZTgiCkyTInIQfZAN9qa1Oy7oVGuJXG7GBt0VvhnaiEVJbCyB0GHCACVtBMjkIdsuyt2QUItJxgZ/g3cPIBojHbjp2xImCCvpDsyNg71cU+l8OVqTQGCeEviX8tX+/ntnI1zLLset3jPejs3OIHEK+p30ZIx6zeKNha0uuTLTtGVkLBNuxFdphB4QAgqjR9Qgx7I0h9kuiEzHxWNDeFVAbAAPr2BzCdAgBOzcvzvcdpY1RuSGXjoeZUG2136Q1cNisIwDQEr1hxFFzsLqVb3rmvnwRW8iwNg2XMKAw63lOc9s8t79RVyUGyCxo4C/QMh139ugEFbq2wawycpLQMfM6qLSONoAivFCGxwj8uTG3C965EaN40vzBtQEelC3uDta6n7QBDAo0QT6GoUJy5I9fdBNWRlsO5mq5PH1HYLU2fDGN68FP7j8GxPpG6kelorsDEaGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNe1+8zzvrQSbpEiVXAiTay39iJa4BDuSHkKWo5hLcvXA2qxYrVrMab+aoPq?=
 =?us-ascii?Q?gsgpHgQS/fuYeO7vJqBCut0SWHHEpxAK7U/6ow4QE48Jc7lLQQBAxKRJNcbf?=
 =?us-ascii?Q?KV5LQAmqagFjDOvw6K78MxlzN4jTRNDWz6IyhN0doigP7iu76uJwwJEhhGHT?=
 =?us-ascii?Q?DFS7sNGu1Wv+ByzF0Fy4AUmTw8PoV8tT+KIM9ah/hakGObcPpiBd2XwyMG7c?=
 =?us-ascii?Q?2rh4gIOr8eyjzFbK0FN8v6olkY2PLbqTHz5SbaVvK0GI8j/s8qhNRivAH/xt?=
 =?us-ascii?Q?4sAY+zKv29uW9rOU1kUAi28dy3eBGWrCQWi0f1OsySEJUPksgYnQomOmPwJO?=
 =?us-ascii?Q?+U7gG39HLfV7DNOQaoFgywZLNGG01Q1c8rUtG1nFphON88EosL3y7xMsdVKJ?=
 =?us-ascii?Q?Afl5/pdDQiipkk+DQXnaawKTdIESbQtqfw3fh0dDV5P+R3CR8hBmPwEBKDmH?=
 =?us-ascii?Q?WTuvbxXDDoxJz2N9+NgDai/7TT0RDBA7hJJq/zhVSSNMAY69r1ZBwy17eD6T?=
 =?us-ascii?Q?cK4kmk/wFPV7khtz6ZMRqn7I7vbzpPoFvUgzGKHldGDyvxwrB/Z9H4j78lq2?=
 =?us-ascii?Q?zE4SFUsiGCRoL/+nIqfprGmroVPVfD3pJVH0SBlpPROYp81bOTtyLHW9/6O6?=
 =?us-ascii?Q?FGOQnLTNyPAZ0T0JCtj7nYaIBa16sPd5YTkNtTHGUw3XxjWxqsLlzWDSH4Lo?=
 =?us-ascii?Q?jjNJkOJSVqVNtZWfSEwGX2jrDF05GdO0BVpqlUINhIT1e+rMQgPd4BZRXIZ0?=
 =?us-ascii?Q?d3RYiY3YZWLqAj2uz9mCw1xT5zx25uv/fuwsxUcszoNTtWirpVZTItn/3yzH?=
 =?us-ascii?Q?D4Pot+g7mFdfSxe4l/v1QjZIyy7ZiqpgJ3q/Tf5OtM1RxHo3Ih/PzP3Fc55r?=
 =?us-ascii?Q?S7CiYoQa6xOUoTNU6J+/sYqw4N71EwoLzliNchspHoA2Em1XfYUFqyXpvVKq?=
 =?us-ascii?Q?DOxdmmMvKPROjOq6qolC974ux2s93zqoFgg16JfGZnfgthrk6YqwnIwj/lD2?=
 =?us-ascii?Q?VEkVQz4tD0YXjqQm0aFjQBzyNHqT9b8exXFidHMXqWTlFT9xtZ/+O7nWCDpQ?=
 =?us-ascii?Q?HwVf8ocOxjxIjVozGyULZY0nxPzNz1sq59Y56txMjvmHPAzvmnDpebibtVF7?=
 =?us-ascii?Q?UWOg+ay+E9flLTZ2qpwnWsR/aoLwrnxMRJhsHbyUqtdgCrAc9CdTHE9Xcf1v?=
 =?us-ascii?Q?WT6Ir5jXPrP7Q6t/CI0BRQyzVMDFmqsbPlCwZ2cqqYCvqiEUKCBa/lONXFgn?=
 =?us-ascii?Q?7X8nvRMnKilCKlQYeDAb/9o/r4FSFEoUL53SoYSc1sOPNgPMfnTK49z55K8P?=
 =?us-ascii?Q?a4W6RJeCaIarQA0+Kywpt0qhg1Sf8zaqsLP20Kj9gFaKAy1NukFNeF6PdNNU?=
 =?us-ascii?Q?yQcuZXvxwSf0x0Ic7bbI96rEddIM0Oi3ZC7X4vj4njXwzFr1Z/o03svVAplH?=
 =?us-ascii?Q?2utxFcHPYzxzTDwaZoIhUU890pzCKBtAKDJbvZGXr9OQWcoZEZLuhqVltaPX?=
 =?us-ascii?Q?QL/8kVuNY+iRYsV+EJ77ovVcw7RiZHeZOIEVSLTt3CGq37OsSyEngkH3/GhZ?=
 =?us-ascii?Q?S7Omx4xyO7RfX7nKVFJYjgvlhUvhE7onxqv+3XT24oJvTcNRVgdw9bjAbLvQ?=
 =?us-ascii?Q?95Rq+3rOMZr48S/QPe+tMzNr5srzDqbb5gqy7qnAwch0GX4wlWMDvQSwiMgX?=
 =?us-ascii?Q?f1NhXSo3U0CRygJ5ZSvClH1LczJt4AFrbOoGGqQ6gxuQ7+tGkGrsu+R7/I9O?=
 =?us-ascii?Q?tIa6nboNOvbJhWPGRCuxjtbXlAo0zgs=3D?=
X-Exchange-RoutingPolicyChecked: CQpoKCEFKne5Eo761S5Nu3VZ65NeBCU2+xstLlWjFzk2jr34gmjNlNCb0alMKItmhxVMq/wavY3qcevhDrGzF9WsbCIAb0K5xLtfuIZzhz9mBAm72OQ3XH6X9s+YHsjIxJoydKK14enp9+X7Wae/ISE9EX96/OgfBlDK5QIEntcTS7zknx4bK5pjKXe+LB8EYx8EyVsrCSiRuocpZxhyNSlvhwgcvV1GRgI388toUXDriMHbvwvYhkVF9k5CGTsEMdDHwH3SgclvGOMigBEvdQRXNmCWEV4QtqGTph1b5yJ/YIIRz9c94G/4cjxqY7dno3SJEqgKj1nhBOKILVA0ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cc7933-c161-4a8a-f01c-08def1ce111f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:14:08.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV7HyD5juFpEh68bKz+ljcZWb0Qs8Ck2T+5S3XOmLkiAkyGDJrAyt9T0odPSRk5yYGvKdEc8oZTMgSbUoK2FCnBz7+JZbSs4Dbs46uxwMVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:01PM -0500, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
> 
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.
> 
> Make the same naming change to static helper __find_cxl_port_by_dport().
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
