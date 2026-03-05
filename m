Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9C39FD4;
	Thu,  5 Mar 2026 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684256; cv=fail; b=JhhOE+VKp5nI0Jg5CrTSr0EvwKPwZPUf8/8j1jUK4FKZyAmCHzDah3PavKFEe54Kmb5bPiiojb+TRS6XpuCokf6ai43Xghz3+jzoklvqkKOkkJIjya3cUHu+69M6Ci6VSd9wBNXDU9zlVuRAR2BtP1VYuluxc7dzYwftKrBpP7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684256; c=relaxed/simple;
	bh=60OEqH64Qdr5jZ2+2UOnI3+SccegOENo7QrfP1punCc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FF5ErI3utaPOihBABloNOE4OXxU7LVgcAvY+tT0PcdWbmg9D+Psz0npCVewXTmzxYuKxPgqobPNt5JbRfjWVUSJ7zk+C1Ndf+NaJRJnT718bCu71vIMFxvcUm0logdJ6gEamYuZsX5eJkKtW6Dl9R6Z1JGZYCx9THEhWop11h1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGDMfZCD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGDMfZCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772684254; x=1804220254;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=60OEqH64Qdr5jZ2+2UOnI3+SccegOENo7QrfP1punCc=;
  b=AGDMfZCDbMMuDul9A/ni0SEguY2qdDM5rD1bEYBWrw51gsV/mZNCRTAe
   BZ00wk/WoBrFBSPNiL2mb4e69nlKSxYGj7TLNUIkrizKCNAKNv3ge+QoR
   gq+/fc6IsV5dfXAweGtD+FsvvkTjJWuqH6ZYfhl1XASoOZN5cU/aQEIi7
   X00kTlU32k7d6E1KOXDax+1scoWVnXMfvCG8qYjHP4KPEN1H2+b2lj6Ta
   4WTGGW3/dO3jOGk7YKJ2UdcsSdgM8gwDb6LaadQETXzYfV6JfyDXoseI1
   nt0aVwkMQCl9bEicnDjDs0r7iLf6nOCLZ8XdtT7dRjfYvcHBN/R/ls3ye
   A==;
X-CSE-ConnectionGUID: Id3eyh52QKCUrisODVUNyA==
X-CSE-MsgGUID: m7OopfdQTP6yZmoYDjB9uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61333883"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="61333883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 20:17:32 -0800
X-CSE-ConnectionGUID: O8A6w8wLQh6ThGPruD50Yg==
X-CSE-MsgGUID: ZlqeZfiEQzW0KLqFdgiWtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="249025962"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 20:17:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 20:17:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 20:17:31 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 20:17:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8gTuWoqzpjuKeh5zIlqHRFNpqqeDjGibY30A/N+e9xuShx5h9ZCnVuklSpV3Et4GPhLY/QIwpK2uGAIe8YZ7H4lx3fc0NPwuyAQyXd0U9sfeRetdq86h1nkyjQ1hj7gIXaWEC4uMlohpBo5ndscohmv3Kc+Tp/QdERPjH6whOSlMKj5QH/Rgk3ICMN3vYY0ZJk34xafTX7bUx7dC0u9h2zMIFMjxt/iIilAPursi9zdRcCxg3CbVPKisQ7zuWe2y0BB45Wovt8jK4K+TP5nxk0z8/1JMzUV1sJfzxeuLlhN46ER+sQGGTp9fKogoQv4+60g7hURggw9ZgC5jeKwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnZB8+x989Pz7ct8Vm/BNDW1Xc/6Uwi//5x3ZIvABF8=;
 b=cQx9xMGFMdSkzYnal3LYWzZKbKkhp8qTwyhAjqsDUN4opm2r0zGnSrWAsTKpyYEs/XHYpZi87nystPGK6Xi11kdGZ/8LufY+cRC90NkxBkmce3E63e5v3XM0xx13vr89F2DWTd08OlxaixTaR3hlAz68rQsP0mvKTy4AL1kwip+GNqnmjrdxKEffKVYuLqem9WaAJ6JQvn8L/4fUORX9iAwwco0kNQ95nZ/X+PrZWmn6JV52xqEvd/YGwWwwdKWc9vapMH/2JdgQB9RWFWIL3mPC3BWWyK7eU1gmtWb4ApTqeQIaVCDaH6VBC2q7YF4EACIFe7wv4WFiiomXW4caRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 04:17:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 04:17:25 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Mar 2026 20:17:24 -0800
To: <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>,
	"Alistair Francis" <alistair23@gmail.com>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Thomas Fossati <thomas.fossati@linaro.org>
Message-ID: <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
In-Reply-To: <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 97096c32-33f1-48bd-8f73-08de7a6e1b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|3122999024;
X-Microsoft-Antispam-Message-Info: imFx0LuuU+zgRpFygHtGzKhk8yR1ktHBaGMCj/vqwEyjAdBIpJ+7GL/eniN4DE/ABj9WcADZHc2on7ImzGCj9QL8kKzloOuaQKCclav+PtS9C12l3FhO+8WjoZzXD19NYdBaOqCBfjmFdALKJHiUMiA191o0/nhGw8noPSTC2XfM5ZYYp6alpN8nBiNfkgU7PcAhzJOpEkyBQodlAQxbUvpPFS0IYrGIkUbIb/SSIn7MwAgW3a4LsVQ21zxhXJtSq8ZiYMbRwlIBRV1KK2iKsZqy9Tzl6FtfyCz+LFh2C7gyECGlr7DSjlQoiEEP6ofQr6n0c4JtC0k/JZ+0K2rJAT/CZ+YdNtjeAbazvsBGkVAWKgOkcezCgsj6K7m6dY3klu6M2fLoJeeLqYXJl8H3Fq5DBnW7rNboxaO4W6cac1UqFvhj6d66s/qTWVZsI0HuPdOGUozolzriM/y+rGpwNw60BTierAGZe59kKcTTmnBldLpbcCLtA9d4/fYVTWesEI94jk/JoXFPVjHFSCa52WdB6JaCaekk/CtxxDln7OuLCOuBA9H3QuwqLSYqOQpEztUVkER/bQAPXOeUF5WjT2tpNoh91JGDr9fYCo/5m6i14cuiA7XskFkULqUnqtM8KTKUw5EbI22VCgfniC1TocViuQS6dSfWXhsb3uu3ROh60bIbmz4CPTr8NXkcI3Poj14/uxaa4dhQxWrdpzs49G9FwC+tCHFdmFvIDE93nwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkEvYlAyOHM2NVFFYjNWUUNHbzZXSjEzbDZ4TWtGS0d1VkdrajR6SjRNc05l?=
 =?utf-8?B?R2tkbmlHRGZPUlQ2UG9OSGhMYjUxd3Z2alQrVlR2Mjkxd3duMExKTXhWRGxB?=
 =?utf-8?B?dmNHSDdYYTFINXZ3bmtSRTRFNzFpbFJxalVNa29IZmUvZzZWbHBmOXZlYTlq?=
 =?utf-8?B?dFp5SnBKZlRFTXFqRnRkY3FuczNaWlFIMzlPN1pGbjR0Y3BNMWEvc1lyYnlD?=
 =?utf-8?B?VW5ydU1hSmFmSisyb1JHZG9JRWpVV0pXalJFdGx4SFJFaTc5NkRZZ2VtbmJ0?=
 =?utf-8?B?amxnU25tTjcxVThnVFNVOXBoazR5cEMvT2MxNEdsL0s1NENYRWxqVzRXZG1m?=
 =?utf-8?B?TEM1WVRBdjZGODA1cEVQL0twdTlNMUJzYWRSWWlQSmF1UjRCOEZqeWJQdU1x?=
 =?utf-8?B?UUl0ejJrUzdBTmQwK2lWa3hYSTk3a2NaQmNueXNBS1NzUUFPWXhuS3Q0Z251?=
 =?utf-8?B?SHhvZ2hhSExjUFVDRmlkSDQ2cVJVMVp0SmRuVk9kNkp3dzJRMk1JajFWdmxh?=
 =?utf-8?B?YktVQkdwbWQ5S1pjU2d0bHArRFo2V1Q5eUlOWjNJOVZPVHptOEVKNEVrYnZL?=
 =?utf-8?B?V25QUGtHSFpmYnhsbEpzMVI3ckt5cTIzeThyZVlMRGtOcjVoNEVjbDJLMWRv?=
 =?utf-8?B?MnJHYzVuVXRhWmZQTjRLaWlZZWZXOW94M1BGSEo2MndQWHdkek9BNXc5cE5J?=
 =?utf-8?B?YnVHb0EzZ0hValZ6eUphY0NjWC9UU3E4LzNxdlY3bi9qK29lbTAvZGtjL2F4?=
 =?utf-8?B?c0xPZExNSExIYXZrQXFJN1pMOTRYUmtuVWh3SXZVRllrY3BML1B4c2VnMW5P?=
 =?utf-8?B?b2FWYVJBZzUzZTkvdjdsQmorWEN4N0hJSTQ0NTJiQUFhZnhrT28wZ24xbUlI?=
 =?utf-8?B?ZTNPMlZacU5ycnZQOS93bDM3bVExN1RvNGNXRXk0ZVg0azUxdVFRUEZwRWZ6?=
 =?utf-8?B?OXM0RjZsUStGbXFsR1QxVDdDZTFkVC9Rbk9NVmF5QzZROWFIU2dFNWExd1dt?=
 =?utf-8?B?YmwxZmdZa0RjekdFd2FnK1Z6Tk56OGE3U0RJbkRtNlFUY0RLNXUrMGNQTjRv?=
 =?utf-8?B?djVPRk1EMURiclFrMlcrS09Id2JsQ2FlV1VNbDJxT0szbTl2YmVEU3NxWTdi?=
 =?utf-8?B?MUdLdjl0QVpkMWl5bUhDMmxrd0xpbThNamdLbmsrUjZNditWbTlweDZQM3Rz?=
 =?utf-8?B?V0tFd1NyK3FETHcyYXdBclp3dzF2VTFRMy9IcnZLb1hHVGluaVVpVm5OQlIv?=
 =?utf-8?B?QTh2dUhyQ1JVQk9Ea0t2clJxSEk3SlpHbW5OMnZYTEtjLzkwQkNJNGZ0R05G?=
 =?utf-8?B?bHhqMVAweHhRVHRKVnVJa3NTUUNBOUo5eW1NWGxxWTZCVU0yZ3ZVdnFoNGoy?=
 =?utf-8?B?aUhWZ04yeGo3bWhQdFg5ZGVYeG1GWjNFbmZSUnB1SlJGd0dEemNOT24wYjNo?=
 =?utf-8?B?cWttRDJSYjRFR3liS1pXV0svT3V5QmJWNmFmeFJsZWM0SlNYZlI5NTVWOTRu?=
 =?utf-8?B?V3V0NFR2cU52RHJzUVd4dlFpclRkSGFTTlk2ZFRDZ2U0QmxwVUVvZUtsa3Ra?=
 =?utf-8?B?OHU1d2FEMWY1QUh5VTl6Nlc5cTdUa3d6MCs2MDlZZytlM2RpUXluTUhSSTdP?=
 =?utf-8?B?KzhIUGFveWNabllvVmhDT3ZsUmRjOWtMY2pZWW1UYW8rME8rMHZyTkRzd1ov?=
 =?utf-8?B?SkhmSW12cWNYUGtueDdtT3RUY09ZaTlKamVEbmdsWTFvcE91Sk91Nk8xYTFH?=
 =?utf-8?B?dmc1cXB0ZnhGcjhiRzZNRXBYYXcrakdRRm4zUVpCQlpEWmF0N2tnM0dwemUr?=
 =?utf-8?B?TTRmTzdlOUl1ejI0VDFJN3ZYbW1WU3hqbjcwNTZyczFHRDBRMDhkaFh6Q3FG?=
 =?utf-8?B?QS9DdDJLbmlDN0V6VzA5WnBnMmlHTjRUNTJBUlE5MkZMNXZzRVBZRWxjQlBr?=
 =?utf-8?B?aDdpaytrRDZWS2FUMlNMRGNSRXNwMml3V0JaVk51QVJaKzY0bktYZlFGdm5O?=
 =?utf-8?B?ay9Ic2drTDBabGExNVhWa2lqcVBmOGdHclJlYVM1Z1EwRFduNHpVbi82b3RV?=
 =?utf-8?B?Y3NtaGQwelhrczlRL1F2ek9zd0Q1eFRJZ1JnYlQ1aTh0M2szcFZkc0RMN1BB?=
 =?utf-8?B?emhkL0orbTdKT3M2YldUTDZpVXpEU21yQ29wUDdXODgrcmhDU2dKSHVWZTVY?=
 =?utf-8?B?akp3TzhwTXMrOUpXMWl5bXVDTFh0R2lGSHdRWFRoakNVdXliZ2pmUnlIRXVy?=
 =?utf-8?B?b2FyUVZ3bFl6QWp1U1NqL1BDVnplK0Z6eDRldVMyeWJXZnNBTDIzUEtpM0ly?=
 =?utf-8?B?TEtVYStHRk0zV2U2QjlaS2lQenhLaUdwNVF0U0dMd1pSNjJheERvT01KVXhI?=
 =?utf-8?Q?Tu5M8FV6MEhEHdM8=3D?=
X-Exchange-RoutingPolicyChecked: R53qdPM1R0pyfvlxaxG1QW2Vn79Zdi6u2sZQ5QaUaZcnk0Y2jKqsnJVryw2VtyCchwqxycknqy0vj4TbzHVj8VjMtVW1u8ZI8Wiz+G82OmCAQQOaGkpbfefbM9dkjeHnoB8c6YisQGYNRWztJG/AoEfPRRWPie9kDQEH6BY0DaRC+/BWcSu93tJuJTc4NXq/sjHePpoXQ1X3HjiWDHhHS8x1Cihx59XTevCa32cZC28KBrQuECpFZc0B2RoHV6x0lzH6+53tcEt4HvVMO6PfENdf6cbb96TdfX2NbEdn2aXtQ5HMrzXgv54QZwcGr+g2GALWVNGeeq32RjoFxzHK2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97096c32-33f1-48bd-8f73-08de7a6e1b35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:17:25.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lisXL+vEgrTnL0gQRMfqF8No+IugmEhmq6RxcGX0N2cSoc4B+5S5YsFinRqxEKVowg8pzKceAAMX6IzRBsK04fK5ga5Uyayl3r/j5+RRRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> > For that caching the public key bit, I'm not clear on whether you intend
> > to do that from kernel side (which I think I'd prefer) or have user space
> > squirt that key back in again?  If we are doing it in kernel we can
> > at least always verify the transcript is self consistent and refuse to
> > give anything to user space if it's not consistent (other than debug material).
> > By self consistent I mean we verify the signature against the device provided
> > cert (might as well verify whole chain as that's trivial given we have to partly
> > parse them anyway to find the cert).  I don't think it maters hugely if
> > we do this in kernel beyond advantage of removing a few foot guns and
> > simplifying the userpace interface to "I'm fine with the provided transcript
> > for use when I'm not here next time" write. Disadvantage is we use the
> > cert parsing code (which is there anyway) and parse it all twice - once
> > in kernel and probably again in userspace or at some remote verifier.
> 
> Right, the proposal is cache the public-key from pci_tsm_ops::connect()
> and at least require that the resulting transcript from that session
> establishment is properly self-signed. No point in continuing with a TSM
> implementation that is not self-consistent.

So I ended up dropping this bit of the proposal because there is no need
for the kernel to be involved in any decision about the validity and
sufficiency of device evidence. Userspace has everything it needs to
make that initial determination. "Authenticated" simply means "evidence
ready".

Automatic device recovery into the TCB is a separate concern that needs
to be prepared to handle more than just "is this device able to generate
a fresh signature with the same cert chain that userspace saw before".
Yes, that is a minimal requirement but not sufficient for many cases.
For example cases that want to validate measurements, interface reports,
or opt-out of recovery because SPDM session loss is fatal.

I had a chat with Lukas about what I think that looks like this morning
and offered to summarize that in this thread. Note, this description is
assuming the drivers/pci/tsm/evidence.c implementation started here [1].

[1]: http://lore.kernel.org/20260303000207.1836586-9-dan.j.williams@intel.com

Authenticate a device
=====================
Look in /sys/class/tsm to find a tsmN device which will be either an
instance associated with native kernel PCI CMA/SPDM or a platform tsm
like the one provided by AMD SEV-TIO, ARM CCA, Intel TDX, etc...

echo tsmN > /sys/bus/pci/devices/$device/tsm/connect

Once that succeeds the PCI/TSM evidence netlink interface is available
to dump any signatures created during that session establishment.

After userspace is happy with that evidence it can bind a driver.

If running in a confidential VM where the TSM driver is capable of
securing more than just an SPDM session the interface is:

echo tsmN > /sys/bus/pci/devices/$device/tsm/lock

Similar evidence can be collected, and when userspace is happy with it
it can accept the device:

echo 1 > /sys/bus/pci/devices/$device/tsm/accept

...and bind a driver.

Auto-recover device (future work)
=================================
By default, devices fall out of the TCB on recovery events for the TDISP
case and need userspace to rerun the lock and accept flow. For the
native SPDM CMA case the default is that the kernel continues to operate
the device post recovery and only userspace polling could detect device
replacement.

To go beyond those defaults the kernel needs userpsace to tell it how to
re-validate the device. I think that can be as simple as a netlink
message to store hashes of cert chains or measurements and then use
those in a new challenge / response with the device with a kernel
decided nonce. It can also be more sophisiticated than that. The
point is that it will be use case dependendent, policy driven, and
separate from the "connect" or "lock" flow.

The equivalent behavior to what is present in this SPDM proposal is
extend drivers/pci/tsm/evidence.c to add a netlink operation that tells
the kernel to cache the public-key and challenge the device regenerate a
valid signature. Then plumb all the recovery paths to call a new
'struct pci_tsm_ops::revalidate()' operation in all the same places
where this patch set wants to reauthenticate. Later when something more
sophisticated than "challenge the device to create a signature" comes
along it can reuse those revalidate() hooks.

Auto-authenticate devices (future work)
=======================================
One of the nice aspects of the .cma keyring proposal is that it would be
amenable to CONFIG_SYSTEM_EXTRA_CERTIFICATE. Give the kernel the
certificate to validate device signatures without needing to ask
userspace. That still comes with the caveat that it is not sufficient
for the cases that care about more than mere signature verification. I
am not opposed to that being built just that it is not a policy that is
implied by the device "authenticated" state. It is policy that is
incremental to the base which makes no assumptions about kernel
verification.
