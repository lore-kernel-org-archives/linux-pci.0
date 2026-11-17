Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937065;
	b=VZwruDbC86UaUkVZF4JYe2X1z09nbTN351ZMX7zP6qXUWktRgbkbP4urd3xQxDMLEYke
	 Mivon54xQqgzfQ1Ww22/PYE9dk7dfugTtwqCoAnbha45oPw4anQYrWs8XGdCEPhtI+OjA
	 7YZPXmV/7/c02Fc6ov2154scnc5L9Y3tlS/XfCMTzbPrEPlpP5FE67IwXHz2ZKAsMFiH7
	 rA0dst3dHaY3W8upMwSo1KZGu599W2+4R7dayOh55hdQuPYYrIedRqIiaqgbMt7fRXZ1m
	 QfKWp9150mvCiFMTWFvhw1GL9QZwUmH9gSnxVZrx129Ea9ffHxEc9f1bvvrlU4qTtjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937065;
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
	bh=WFJ6E64+gL37X5XKzP6NjcJG9MB41eVlmDQG8ElUt2E=;
	b=CD/zvRjxUZJBcazgsIJNG3BpAfoBw+5kDUxh9wpww0ht0pFt1my3cCxR7JhbHrb2gYrK
	 vgUF4TBDWZIIz1G+ukXX+gy5HbUhsAxUAUV6GzrKk4S8o3gwwTkuYlhBxc9fBbDsHA8sC
	 EzrgjoOAcFvLzR26whyb1s6z2ubVr0PS/yi/Th1t5NGwM2sv+XLjjGywyrsEVwhspVfoT
	 LwrPf68SnLnSjuA8Ty2uZFlihJeSn5D4CfRTKDoZ8/JD7Qv+ynoS9glpRPjS75huBKGmg
	 Kp18X2L2g4Ft51c18IkiyYC1eOPHloOgHuYmtW3aIFUxEO+tw5IlAWXiTUny/fojtxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbjMTFiq;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BfnuI2qI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22551606A332;
	Tue, 17 Nov 2026 17:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22551606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbjMTFiq;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BfnuI2qI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794937064; x=1826473064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dbjwH4kKbuWkl1ryCKO4ly8zNpWKscfSMdI6+fEmoUY=;
  b=AbjMTFiqeM7vkVW4IA8ywBKQ7SsxtMEkILsmZkPL51I59OUljEXM7YUd
   QLwieTkpFdiMfC44B9O60WaS+bVvDgJiw+HrjLw2HBKvBuqlVzTjJchQO
   r8TaKZYk4R4L+jV+4B4a7PCqa6NVbMBwxhEdFLC9JKvpLe5jT5E5d7OCl
   JXzMXwpMNuKA+4zv4lAGd9f15dCy6ko1YsBZZm2C8ZZ1zkoZXtEMzxzsD
   2GeJhd5iWowcfNBPQ/PB+sFxybaZPvxUDJyCVrK9p6E+L5E+zgLNcXvXo
   9WXuPuM7Sijg8E2X0OGomQibnKt0ZCMaynsYAtNIwdzI2rEGwYy6ytJ1B
   Q==;
X-CSE-ConnectionGUID: JRgEtaUaSJmm2P02rRZGqQ==
X-CSE-MsgGUID: GyWzsAl7QtWRbaETNeBN1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3619710"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3619710"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:37:44 -0800
X-CSE-ConnectionGUID: 77tLHGacTKaMLeW6BXcLOQ==
X-CSE-MsgGUID: 8vmAPk8kQ7WNLQW5dl3z/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9795413"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:37:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:37:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:37:43 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:37:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAyX/ei07c13yDU8C8Ab0ImmG3snx+mUIz3jbkwF/DlWZGJ7UK2t63RNAEqUldf+1UYDbfAGbx9U8g3akjZpEbS29C6Kn4UtNhcRKU6ua3AeSvZXLhD5b0mcRQmwJGjrRJkCQ7kb+scdyoP2gBknhtPONNGJ6F65fImg4FL2f9FR/d7TiHZXbL6CT+dOhgUEjsXUo+Y16ek9J76NZtNy34u1b2MBTFj0DbSCD5Dyf9jaouCp/GwUBzM68K58dNaLWRmvXJr9XDf3or6QgHZAQRqgFEtl8WAas7SmE+VPDFAjSfMpL2qJ6E9Y/YBfUdOitHU/lSDXL+G7ltEsQvRqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFJ6E64+gL37X5XKzP6NjcJG9MB41eVlmDQG8ElUt2E=;
 b=YqKsfuaOlYeemvK8WuaCYB29aNkpMD5/NetlaHws6lcITkVR897ZXoJkLPsjzDTSlDQqie8eFKywxzkHcTX4nSFw2WxYoZtvZuKNjGaXg9eAMPpPuJsAxnF/lbNLYnxEvITdfGV0HKLn1oIeIwFzduX7nMnYGC8E9u/HErpAUBUT7WykMCc/Zarhlc5504sqlI/+HVKzAqz8eifzBqI3bG7i+zXS3Vilf30THT4ShoWj6XvIgY2VkwrOa+IjvoWNC4GzNm2n3G3v42DmsnRXWZFlr39D00IanNedi4qur5xm0JMH4ortCWU8FawZ3uBFntlMJ0M1zxFTyWeycAqiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFJ6E64+gL37X5XKzP6NjcJG9MB41eVlmDQG8ElUt2E=;
 b=BfnuI2qImQ0t9zzj14/clJFTH4Tqd3KUMnrLCaQ2stx6DO2otC9JzxP2AOiQgmbv2o29GZ+igxiMARZtlleaLMZFn8HaXhYpBAufPZEUf/I9k1B+2zOd52rOmA4rkKz2KkXdBz1HVFdEAt5bgoeLlkuvSMdbQGCiwEhOeZrNzx0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:37:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:37:35 +0000
Date: Tue, 17 Nov 2026 09:37:30 -0800
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
Subject: Re: [PATCH v17 16/19] PCI/CXL: Expose CXL Reset as a PCI reset method
Message-ID: <avyQ2sXKfvdz9SVs@aschofie-mobl2.lan>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105185917.2667656-17-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f7a0ac-d20a-41cc-0e32-08df44d17789
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|261009223027099003|3023799007|4143699003|11063799006|5023799004|56012099006|261022075727099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: wOVp3ytEeHIEgcA/lGB5NTYxAIgxdbaeNEgA5zVGNnktXMUPqpc+Yb86a4E1uFWq1PQu8qGFydcYNYKT0/KpybTmIXMXMkFuu56uHfntqWKT6beE+CfAaosocuTpkCTnpjBttobAaT3PufMvJ6untOKBvsXaxy8zm22ixhV5mW43rx+5jlEu7Ig5TIRYgFpr7NLKZEOS6f5yV8Lo9r1PsfQUSDbZG067zfbo2hdmTHe8/AaGiBELG+H8hIqBKfkpJuSGhgz4kRFE1jtEMcTbeKxnLwTwrkD3SY/fpEJGjAkAWiZxGSmi25oOfvXQ5gK5bywdgMlCTZGUxF7FvdKYcKuW/szgvUWjhqztmPjsR0CGVrKpSGa42gDIDgHiRRN1kRRwJHRkIKTd/Iqd77x9MUJh8Tsp9Y5EAr9v9zrCFye6HBVZwENOJVtGNAbmAodjPEM1F3EbE1C0hH3zjaJBrk/PQTWYwXquayvGLgT2KeFhjGeam7TMmNyCD5o/UnUl4xu6oSCGZqc5YOOst9vp7GXdv0xYinkYEOyiZcxIX+hUne0mInKtK2OTHae3Wkn+3fU/1oxA6LgA65PoP8223vnCIOtqdnHdJF5V3Gm34+yY3dWQz2UnhXjxmA56kI8aEXAlTdUp+5nyAUb2Ief0EnCQHNDwIrlA5TPZYmonMhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y9j6ehsNqL82rLeJwOXTt3b2avbrK4II+wq20WEvccLsTWAk8XCXDYVZLPRc?=
 =?us-ascii?Q?qrPhgG5j6ayVhVr5EKMJMVH+zzyd5Vt6esywWKaJbTb9hjV4xujHjR/2Cl52?=
 =?us-ascii?Q?k1xCWGs2W6OrUNpDL1FFBrMTa77FMb9GbWB8DglHQYk2fCLe9SSE+UBJUZJU?=
 =?us-ascii?Q?0ekI6YlWq37YfXwpY6/JG7rmltB+nROX8TkItQKiCfyOxjNoOfq95M5HA6Lc?=
 =?us-ascii?Q?AEv+AuU0XQS4IezDWRrY1BmIB34vhouj7JPrgcUlwjbvXf0wWq+6JEzJngmT?=
 =?us-ascii?Q?izMHN7LUDBfsRRrhXW0Qrjdetmdc25ICCvFKTVEq965qRMG5uaszKt22TXxE?=
 =?us-ascii?Q?yfTYzuiFiFuDDcy4KHaR5HQlaHLgbjvALtGzgU+kd8FoAl/E0Ph62YREwDE+?=
 =?us-ascii?Q?NYucnP1q1TBslPj0O+r6XOg1mmW5t4NBiq+StD9I2WyZd80HQ8FnjiSWZTv8?=
 =?us-ascii?Q?xCld9RaG9sC5AIAVRO/furww4RYbNTOsNEaNriyZUicptC2cIpq8KWAA0phx?=
 =?us-ascii?Q?Ql/zWqZIND5vwXkwXfwBnE1G/Vr0feiiYz9B02QrlrbaYmxA90AFhmP4WzAa?=
 =?us-ascii?Q?w4zaLyUxUdA4c7+2bs5qn+fuOeyGADlmtZbkBRAU/m/xlpNC0cezeiBS5Bb3?=
 =?us-ascii?Q?EcJiWRKp/UGutpRJUuxzt8VPiibqCxtAD+lJNh4A+QrYT4sEGuU+ISlCx4IN?=
 =?us-ascii?Q?mAg9a1HLqpkrGWptQ+cF+A0y+B3OfAlY+bRA/2zBGW2U5RCoqpzLGLSP89nc?=
 =?us-ascii?Q?6JMumQU9lTQxLcpfLQcwl8TW4nLz9yZ4MwxYW+EwfJgHt0GHySMaaa9qYMWQ?=
 =?us-ascii?Q?jFSySdEir/0ZNil55ESXEuWTd7tLc69c+b1STJtTVXESw5CcMcb6iNx/4vh2?=
 =?us-ascii?Q?9V+79wJ7eH+bx3rLs+zT09Lxx3toRrxt3nGJqsmB+ex1OthdkIUlbUT0bsrI?=
 =?us-ascii?Q?TKdOCilJlRaWZHoe2B793P9qiVTxQuUbt47lSwQsEjVzLHb8iiODDncC+XO2?=
 =?us-ascii?Q?M+a9Rqpozh3n2Ms8b0ZxB3x/sqH8oTV0DK/pEAY8VWgd/pb1nRregBEaZbmz?=
 =?us-ascii?Q?NI52KN72xMNJ3mwDKIBzsCjeCJzE0B3Ew/xxQJcREL7n6L3TTd3CaBLUnCne?=
 =?us-ascii?Q?uM0dEeICjUqLmN5N+Uc8R6c4ffz14zBwAexoo603E2LA70xscEb8xLzXOr2b?=
 =?us-ascii?Q?ihyQ5HwChP3lbjj85Ik8nXsgJCJdX6xLPDG5PDfnWR2l/uIHMqGioCEuehI/?=
 =?us-ascii?Q?StGvWo5Y7iW14y2g3cU0hjDd9bYE9MSBJbb9lbFI9qewT1GGYPR2BJb3hPv2?=
 =?us-ascii?Q?3i00x9iqvO/O9WC481GMw/9mzmaOsfFOY4ogMFUCnkbGqo/Mk+iW7TrZcN9B?=
 =?us-ascii?Q?WAMY2HNvvzS9AeDwafx0oVNvpZgrJ0Vgw34+OgQB7ke9qPzM79rXqt0lPP4R?=
 =?us-ascii?Q?/9ddbNlRWN3Gp4Ym8u6NjkFGD7l8uoyXQ5IBFWNwzkTV3YWHqgFr/xVHhvZV?=
 =?us-ascii?Q?zpaO5sZHXy4tgF+ze1eswaA8/15zEjBh6KB/RRWZGS4289pOj5aGPwLuaB/k?=
 =?us-ascii?Q?oQZQBICC3x0Swvi8RV8nRhPtnQY1R6aAPqadd5SF0wr5yfoRvFj3zQow70SC?=
 =?us-ascii?Q?kWpDSq9mo843AgtzVnOUDID6fYydyTUW4apMwEEKewjKCqO0e2rokfYYfjTO?=
 =?us-ascii?Q?q8vYE3eTUsolZYYGScRr45g0lXf8VFAdNVeinlDoQ42JtcBxIni0Y7p+xaN5?=
 =?us-ascii?Q?VSM/U91Rw3V6OEnWNIDi+bl4isqImEM=3D?=
X-Exchange-RoutingPolicyChecked: 5ki9Pva6PoBmlZs8rVigXLRDFUwsJ4z+uVbMJxxaTJD9s/zW2ybcBia2FGsOvKLbB4bx9s0oCi16i1JrQTYPeiCyI9i3bcldZb/uxHG98WHsEbFtyE1kj19clWzYbcvaFUjjUVqiekRzZXpcquCvNO3IvG3ynSwJ4lgdQzheF17u7e3TVaDbFSRXrKFJo+siaCH6AEbxS1Qa6DlS5aiaeGeM2JWb8jBPmOzuQnSEmALHbfHpGqFeQTAnzfez+S+/7D4Lzu6xzDMnnNsDkr+5u6vXOiRMKjfevTZFAwfdSKorKk1UYzMJ5gQW3BtNI6HDkncGoq9cDMowji7Kid7teQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f7a0ac-d20a-41cc-0e32-08df44d17789
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:37:35.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAO1rXbqmidcIvUtU4Z2ULsQ2u6m4tTWEe0i5lQkkrDkDB8FSlYBNFTwYxzbvYk7nX7/L9xWiY6O9wyTdM/3s1xSD3u+oCsfMiy2U5vAcHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 06:59:14PM +0000, Srirangan Madhavan wrote:
> Register cxl_reset with the PCI reset-method interface and place it before
> FLR, which does not reset CXL.cache or CXL.mem protocol state.

Same theme, trying to understand -
Can you clarify when cxl_reset first becomes visible in reset_method
and when it can actually execute? Can userspace initiate reset before
endpoint and region discovery have completed, and is that intentional?

-- Alison


> 
> Return -ENOTTY when device capabilities, function scope, cached HDM state,
> or required cache synchronization do not permit a safe reset.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/pci/cxl.c   | 12 +++++++++---
>  drivers/pci/pci.c   |  1 +
>  include/linux/pci.h |  2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 77d0e30841d9..c68b08f7f95b 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -679,7 +679,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
>  	if (rc)
> -		return rc;
> +		return probe ? -ENOTTY : rc;
>  	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> @@ -688,9 +688,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
>  	if (PCI_POSSIBLE_ERROR(ctrl))
> -		return -ENODEV;
> +		return probe ? -ENOTTY : -ENODEV;
>  	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
> @@ -710,5 +710,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
>  		return -ENOTTY;
>  
> +	/* Raw reset callers may not have saved the PCI state needed for restore. */
> +	if (!pdev->state_saved) {
> +		pci_err(pdev, "CXL reset requires saved PCI state\n");
> +		return -EINVAL;
> +	}
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aef976d0c850..426b5ee38d04 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5152,6 +5152,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ },
>  	{ pci_dev_specific_reset, .name = "device_specific" },
>  	{ pci_dev_acpi_reset, .name = "acpi" },
> +	{ cxl_reset_function, .name = "cxl_reset" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7bb37fcb556d..743b57ff885a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -52,7 +52,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> -- 
> 2.43.0
> 
