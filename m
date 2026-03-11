Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808231A3164;
	Wed, 11 Mar 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193534; cv=fail; b=YcDopAgpCYPULTpuDIr2IDdVvJw1u2wkbEBTeIMNDYeCteukk7xUSakGiDUVfsPJOfngxJLqcOKGi+TPrXC2+IJ9L5NCpRhOZk7NPdWAmEwcryFjUdqBm0nEuhrBOXUEO5EOmC2rx3IHLKvPIM42NurteL7u4v2Gwf/NIJ31yAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193534; c=relaxed/simple;
	bh=aIYCACYDUNwzy8yGICR02fJl6dyhq/djtGJ9H+kOQww=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OMHs3JkpOckC7+T6ZGwan+5NEc/zw+FCL1XD4jrzZqDPqFJvRyVCuW9Hb8hkEXFowOVVGRjjGTy3vv6QdkBNiSl3Hjc4HBsBm3QknWoNUZXETmwLs3YcfSI6JppbPU6hl04P/F1VJ7m1scglsY1ghXj9TFAGOxfsCQRouRkDKTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnvKWVJJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnvKWVJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773193533; x=1804729533;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=aIYCACYDUNwzy8yGICR02fJl6dyhq/djtGJ9H+kOQww=;
  b=dnvKWVJJ/+LTbgjNdkQ0azlpthPbAk+y8wP+g8B6ChWEssb9xPWE1gBM
   B7n4atEA5H8H0TUW6QQ0db9IWJFI0OMsi4IzeuJdKD51iiwaDgzULiVAq
   yjMtPyRe1I8SVPpDDdIF8yxMQOjhczcYLt/+GDqtG0ZlX9BvGFpf9CvQc
   +pJtshs1rfQ3TCThzLwtQKwIFl+OB3uUk8OtBpKt3A/AqGGqnsguTEuUG
   qlF4HW3zeMS7AEf9GbBCG99MKbg1xWiPgCCgnSZOZcbHgE96G+PBbB9Wi
   +hQ25l2lU5rDyWSilTZZBjxMrbmX9GcCSmr8L9uFJhZ+C5BggLI/5chmj
   w==;
X-CSE-ConnectionGUID: J/9yZtO4Qk6zFmQTcFvOLw==
X-CSE-MsgGUID: un2hbB0GS4KKel+VoXCfMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74227666"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74227666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:45:32 -0700
X-CSE-ConnectionGUID: D6x46MlER4KX8phGyLx4nw==
X-CSE-MsgGUID: Dkp6+lXQR7CwYQlFG5pLeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="222857851"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:45:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 18:45:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 18:45:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 18:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laKy+xGdoXblV6tPr6CMWEmpNvnJCK0rqvK5iwEsS5iQ6tvguTXMY8c1YotLSGb6KjWbCjsQKwMvHZ02dQCL14StA92dznDSCI19by1CGIBKZ7B23JXm0x6UbWEFVu1IiGe/hn1wlfteUntoa5RXwEGf0zsWmUSxCFi0BlujM03E3X+s2QqysqbOEnvDY/fUU5cmOVlM+B4pDuW5r0hXlhk3214lt9vEfZNy7Tgf98tZv8WaOTzoPHVO1TqJnIBuckwq63QTfl54TIh3DWVuPGF/8c5cd2KhXhcifw4Zui3Xt2PK1ocB9xDNsqvqiK8uH4Y66bx+5ChAArLkCwGR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlbt8JsOjXPGKSCLdjMUf8HuVgHUWFzEN7/ivfnILqc=;
 b=RCWEIlfhk0uf66inhqI+2ltBGH9Qs7UahFIuUh2sKpYWQv0QmNMOJHlmtBXXZfHPvNQzR+rn/BG8tpEvCDKdqCmk30m4h3YpFP5GrT/wyhpZH7frRp/PnooNp7tFHLsvfjiYOT8AVFi7uTFZ/p4xP/+K7v4r2JMXkwevFGzPAr/osOcraG8w/b71O3vO95WvF6WFX3/e3UcBBs37Hiy2IeVAy2cVOkz8l4DqtDMjlIm18U5z20G4z4qI0cHdu1X+6Sph8CpZXHArT9DkR79L9B5Vho1RPsDwT9qqjWglAQm1g0/1ZY4OnRs5/8k+py15wJ5eqLtOrDHGlxwKMqyCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 01:45:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 01:45:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 18:45:24 -0700
To: Alex Williamson <alex@shazbot.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <alex@shazbot.org>, <smadhavan@nvidia.com>, <bhelgaas@google.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310164630.7abeed30@shazbot.org>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
 <20260310164630.7abeed30@shazbot.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 300b42be-44f3-4197-e565-08de7f0fde3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vo+1HKJ6gpjirdGVzSpGN1L4h26KGr9hdAXgjgFpAImDIkpbs3oMjFPO2p+Ou/Dd+0LLZ+TTr7aBdjiGareYBudDqlBqht23AjLsqhmMODjMI6t7nc1G38L6MtDh/rj3hvE1Ju9/YYgC6xl3xKGucoPUGUI6vifnXb4ULuZQUEFqZ2Cfteu0vTj+LAmpPdMMUtkjDqiijremATxQFQOgJH7+x6ll4zbSN8oMoJPduXQ7trl61poKZKsDLkSKlrfyBKY9TZr+aN1OQyr+Yr247h/bx7FC7VpHpTZF/JIMl/ECxTKEEDvDAOZsDzFkV7EqD9oXKxX4wMslslu1sN4tCUdn+QFlhhzqVGYH3jSNActvGjSZJUudp9T+0a95b/cVpY7xu71F3RhgNdupmR+3BEqeMGRuvgdwiA8LvrRXV3o/wElLi2yW2/Y8is5JeuE0TXnsnKEl4iYCTvnO4rS+tvQKoOBwRuUvaTkYwAZ6ahRmD1UTVhUt/NTKDRWvUBNvFlLfrVjwZGCXjN0bnp1JEhylfpVf20pXLOQgwvsxmzmWxxj3gS1Ckq8/01JZLKesP4bKRWXI1xj8bwWAblxD2PheM7NLLU/rdb6PUAMxnkm6DMUfY0h6gW6CclknOUGiJJ2pzhYwsTgQW1FlHnXVjYfmFX3d5N9dblJBSL6ZMotNUKiWIjOaQGBWABI5VzSLM56QVlXr6PZJRxL2GNk/d9N82+bPHS5NOtTca6TeRhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVXZjhBNHJWaTdUTkIvT1UraUM4cEM0TUFiN29Ia0ZVLzJkS051RVNvRTlV?=
 =?utf-8?B?NmZTQkVqOHllbWFKbGFBWFlhR2ZpTGwrcHIxbktFNWxkQ0pUZkhvekNLY2lM?=
 =?utf-8?B?QnN4NmFOeWhJZFM3RU5FbHBpOFhRUmZqeXVLR3RLaVZHS0hwNHZyUTFEaTls?=
 =?utf-8?B?MThMeWxzNG1QRFlWT2JIeDJSZzdSQURYTTJrOWQ4ZHg5b0pVOEtUQ1FVWXZl?=
 =?utf-8?B?aVYzYVhJSm9sK1BQQzlxajFOTlNIVDREa3Q0Y3p6M25LaFRyeWozczFYb0JW?=
 =?utf-8?B?SVNvRS9NbG9zUmp5cGJsU1d5b2JPeWpzbllTUDQ5YnN6TlRSWFNGdzFUekZs?=
 =?utf-8?B?WUJvQ3g4N0V4cVpOWEdtZzZrQm5mcW9DdDNQdHY1SkRUQ2JQSmF2OXFKclBV?=
 =?utf-8?B?dzRVajdTbGx3bytGa3pmTDNNVzF0MEl3SXdiUnlqdENNL25DRCtOeUt5d1cw?=
 =?utf-8?B?SkFmZXBLY3RITld1aEl2TzVGdVRWVlNwVVFZclNQSG9TdFI4bWVJbldGSFpt?=
 =?utf-8?B?UndIZ2F1bHNiN2NaeUNtR1FGcGZQb3ZPSkVTMDZOK280N1QzQkptWFVBS2hG?=
 =?utf-8?B?WW5YbTJTMXJLNnlLVnhNZlh5ODBtUW1EOEZwdnJDelBDM2ZiRE1ORTJHd3h3?=
 =?utf-8?B?VTNBS0poeVRYcmkwN0ZUVDZQNDR5Nk1KaDBxcWw2STVpdTBOaGgzN1c5S2VM?=
 =?utf-8?B?cjM1YlZ4VE5GOXp1RVZ3ckhISENGTWFTWnFiR3VUanZHdVBuSEVHVnZKMjMy?=
 =?utf-8?B?WGxuNWRxeXp3aE93cXFiZDF6V3RYME5ZMWRTNjk5UjN1Zjd4OW9FdFFrQVhG?=
 =?utf-8?B?RmQrY2pwZGNiblZiazM4MTJZcTJsUGNWYlVGbmVnSHNPdG0rTjVWTFJvVE1L?=
 =?utf-8?B?M2lWdGlvRGMwd2c4bktIak54clBJZFVaVFg5R0l6SGh6TnJwN25NbXJ2SlEx?=
 =?utf-8?B?US9RY0Y0VitVSXI5WDBWbFRBRjAwNmxoOVZDWXBGQjh3OVJnUStGQlN4QUhU?=
 =?utf-8?B?QlliT3hMdHJiS1VUZHY0SG1pWk1MekMzc3ZBaXkwaFlGMnB1MjhqYWsvSEdK?=
 =?utf-8?B?Rkp6aituR0V2K0IvdGNPcUJFczlOVUxOWWtHMkhJc2RiTjMxY3ZjazRHaDh4?=
 =?utf-8?B?L1I0bHV3LzlzMXkrNUN4NEwwVS8vbzZEd0VablExejI3WTJaeXVBNXM3TVBG?=
 =?utf-8?B?VWdoeHZiK3o2dEdTbFAxSUNVS21WNVQ0OWVjSXFCS0lKaTFmZEFlWkt2TTlG?=
 =?utf-8?B?cERwcWYyV3NSVVpNWXpVYkVrWElHRURBSlA1Q0loclFaMkRqQnlxVWpXM0Rp?=
 =?utf-8?B?YXlZL2RJYmFnei96ZjIyUW1JQTg2eVRvbnhwUURMYVpSZXVqK1dxcUYvUkVM?=
 =?utf-8?B?dWd2NFNtYzV5QVZnL1hCWWdrTUdnZE1nQ1JjSlRmOUlwQ1dYZllsZWtDQ1hB?=
 =?utf-8?B?NWxick8zMCtBWXNYQ3ZHSlVBakR0L1BGS0g1ZklDWkdZR3FaVENPZmt2KzJF?=
 =?utf-8?B?ZVUrWVdYREowOE83WmNLOGtuYVlQaGowSGpJTzZ3dGpzcmJyTTlwM1E4d2pV?=
 =?utf-8?B?Zm43YjFwbHViM3VGL2tnSG4rUmZZSFo4bTBYbWFnRVRNMm9iUERZaEhiZCtk?=
 =?utf-8?B?RkE5eloyL3FQbjIxblBKSnZNZ1FBVVJCRjczYitYdWVzTjhwRmhjNmJiTFF5?=
 =?utf-8?B?VnVRK09KV0MwcTZ6dEVXeUZ5emdQaTVuM3A3UTVoVkRiQTgrT01QL2xKSHJy?=
 =?utf-8?B?Q1o5WnNTT2ExMklGZ1NGOUpkYjBwT1dZY3hNTWVNbEZyckh4MzBiYTRmK2Fk?=
 =?utf-8?B?YmV0RTFPMmplNlREdmcxbmt2VzNNVkNicTV4SzFiWUp1OWFkZ3ZtNkVUUy9v?=
 =?utf-8?B?aDJMSHpQMEJFaWdnUUJnNEJNRkNYODlkU2QrOTNreEx1R2FmNUEvQlIrUUtj?=
 =?utf-8?B?bmEyL3JDZllwMlFic2J4TUdvaFNQUUlSWHhlVmFaSjFsZjE4U3RWYTNTdTRZ?=
 =?utf-8?B?SS93Z0FmMzR0OXdOVXJnQzh0WjRsZGRQQ0NTR2trTGpKRmh2UlF0TkhhaU9I?=
 =?utf-8?B?YzNWMnJ1Q1NuRG5UNkZPa1Y5MWRLZXFWQldBWU9lOWpXSkJJWjg2cFhCdzVW?=
 =?utf-8?B?T3Z2ZVZQcit6LzN4b0loejV0OGFJYlIrR1ZPUWIwSnpETjhIaHU3QzUwZEUz?=
 =?utf-8?B?bzJGOFh1eW1IMTJpK1h4Q2sxL2s5dFJheVBkaEN6Z0cyQ0liak5nSkRKSkRL?=
 =?utf-8?B?bzJoZjZvUVpqNGl1MllPRVNwMU92YkVqQisrSFJtY0tUT0tvcFdOaTcrWW1o?=
 =?utf-8?B?QWZ3MnEwMWtoRk0vcDB6ejNKTWlyTW8yeklMSHZYU2dqajA2OWtVa3htdGlp?=
 =?utf-8?Q?agQjfBDaosqAyokA=3D?=
X-Exchange-RoutingPolicyChecked: UHwD4VdWFfrBADzFertPcFvY5SRv6tiCCs8VgFbSwBxlr8pFKcPk6vYnq7cws2n95o2fHAmmEkzrj6rkqDMJhKlpD4+jU4zak41vSo2ZWmZB/fWMa5BMCeAGmoX1NgRZ+DC8jatKcTxSX/rDztPmL9yPhelWpsUGqhcjGK8G+DicAUD5oC8E2V9kxMsJTAVkeT+ZIBvSLv20rQXwNPLlEW81pMdIhxZmEImcg1RfPdJeV4Yljlcd7yN75Z1Q9bswukGRrqgdpAPd3E937Q7IJaF0PdcAdcARr8JtWMyEML/WVV5oJA+pvm2gssAu360D5jwf6Pd+GQxws3OwPr5Kww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 300b42be-44f3-4197-e565-08de7f0fde3d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 01:45:26.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwjep7dJrvXLXjiATcEvnPyjPtWHr800d/pnblHMF/yR3sIknvq04Uh1YTmXEYOWtPJ0oYD9iqgUDcAgeeXN3WLut1AMbJ63ISyPHL05RCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
X-OriginatorOrg: intel.com

Alex Williamson wrote:
[..]
> A constraint here is that CXL_BUS can be modular while PCI is builtin,
> but reset is initiated through PCI and drivers like vfio-pci already
> manage an opaque blob of PCI device state that can be pushed back into
> the device to restore it between use cases.  If PCI is not enlightened
> about CXL state to some extent, how does this work?

My expectation is that "vfio-cxl" is responsible. Similar to vfio-pci
that builds on PCI core functionality for assigning a device, a vfio-cxl
driver would build on CXL.

Specficially, register generic 'struct cxl_memdev' and/or, 'struct
cxl_cachdev' objects with the CXL core, like any other accelerator
driver, and coordinate various levels of reset on those objects, not the
'struct pci_dev'.

> PCI core has already been enlightened about things like virtual-channel
> that it doesn't otherwise touch in order to be able to save and restore
> firmware initiated configurations.  I think there are aspects of that
> sort of thing here as well.  Thanks,

I am willing to hear more and admit I am not familiar with the details
of virtual-channel that make it both amenable to vfio-pci management and
similar to CXL. CXL needs to consider MM, cross-device dependencies, and
decoder topology management that is more dynamic than what happens for
PCI resources.

The CXL accelerator series is currently contending with being able to
restore device configuration after reset. I expect vfio-cxl to build on
that, not push CXL flows into the PCI core.
