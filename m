Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793169591;
	b=UgxUgv0ZHWBnztSW+MC0/p8IZN7Hpp9MKSyzjBnU7gOg3R78YT6YqEkNDMx8OusMj7uw
	 JDXG3E4EyL651zYRd7pQ4elztVzPZo1SfbUICOYUUNYyR45fxELO/DhDjPnM/vM/K5I7B
	 Feqq/dk2dBfhh1fDGkxKOuWbwXe8VNPZnC7Ry1FOIhtjyuro3YJfE0IMqUu4zB0F4kOWi
	 +dqfbBugDYk1uECEGCcgk9NOUCkbInBg0oG+eQ27tn7jf3EkXD1b4mWJmq3i+Jzgemek1
	 4LaNmgogSF1lH6TLmpQpLU97dIzGIe/ZXwkwgSLtYxD89hkw2WM0kwPmhaNfJi2hGzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169591;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=SQ5cJu47YAU59KbvYj6qDVsr6qtwgbvLLBm5WxjDu/k=;
	b=sA3h17gfHHfx52U2O7Q1onn7vykuq2Ct04MyZlQTAyDP477+6UVLJEWkMOigRsEAXDfb
	 UHVPlGPZqatJBJK7DSHv1umVF7maDNVWGJBit2HKuFvke05DuGMm47fs3XsaL59Qehl6Z
	 dYuaa3cvGBXfAlljruOHZI3nH0wUJLZTKEJTkXrPApgq1rxf6ZiLqko+jFfzmw+L0eA8K
	 jAVFlEDmU/gYV+3JnwMaJcniKedi3NPdd077pQbUZJGDaYveTe+L2/K1CAZDVCH0rAYIm
	 yJgPCivX+oFgWXdcKMc36O8T3OQgFBhwS45GjgicrZjQbpknucq8fLWBJRWbvhUwLhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lUK0kosQ;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877B606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B877B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lUK0kosQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793169588; x=1824705588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ouvwkYrOqCh7ORxkpxiD5Fuw2G6+X17gV/SiZ8atj1g=;
  b=lUK0kosQdAncLulX0illEi/7BEkGXncZltQ03llA+8rxvxzavOPZmKMF
   l8jIShsThl5+cHHhoaft3HA2NH7cxpzG/QyTwzm9khe4+H/TkIqnfGAyC
   zz2FGhECKvvnPVIan4Q/Ms9anV51QdwRsRk9HJaHQhS4FDDUUKrCxGuPT
   gsxCPiw1KqfYsIb7aw1aT0vtOXuDOuQ75RViEx3fL1rSgrHLCqCOJ7Z6S
   r9HtlgnFeg0dtY4hr/DZsayLozh5Ywq+1CXzHCG/c9oDym/flK/HyJ+AN
   Nnf8r8A9n5W5BDLtlD6tJpBtqyRKRcemkSktecq9kM2ZaB3batt7ynKHN
   g==;
X-CSE-ConnectionGUID: Edbv3Q2uRc2IHNGSl8qJ8g==
X-CSE-MsgGUID: oP2M9MgNTSugTS0RQJRhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1769451"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1769451"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 23:39:48 -0700
X-CSE-ConnectionGUID: jeob5GKCSGaXZOHOw4cPsw==
X-CSE-MsgGUID: G4bgPd3JQcqKx1xKUWttcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6583730"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 23:39:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 23:39:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 23:39:47 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 23:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyiywoWVt5pnlIGgpmUgMdOTPazVJU0gbuCzJR3oF52Tr+8R7cEuln//EvZnF0YFWtng0Vzz5hsFB2O1dVfUkJ5UtMyAL43y6qErP7CsVN+bIfhho6xSsFDabK2KeYGBFcU/7gQZEBwptydSZjtQH3GNaJMKWgfbVEaGaWAgjGfS/XbvOjAZKSE/wRAm0F8xsLrl7e4dyeFO+zxh25FV/3LlaVLl3bzn2zW6w5BvdsvBZ32CTnCFsyM1VZ3j3Ni73nSA97pVZ5pG31Igja7ovKvrub9ZkxOuMHHVM0edLooNn/9rtiG5sLPZ7GG7N6SNoRbhQuM5vFEk3utyCXqADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ5cJu47YAU59KbvYj6qDVsr6qtwgbvLLBm5WxjDu/k=;
 b=hRSKKjJOSUrqfvlMPlebiqNMIgxrzM1gz9Q8LcY6i6xYl7vU9D5W0OeLP4VzsABb8NPjmZqqqLMOBbnMpMIypMXM28tTyOv2UkRnIW3pqqFmoj6jbRpj4zT2qVMf52ghF4kDnDaYoD8uuSQGL++MFe2LZc7uJ1Z7xPq55jJkp7J8eF62JG/cVLnLZBiwgx0ViReAqWACpIYdaWGit7eloPJAh1OHsQOGNbj7yC3+1olBbblz6DRVGWJ9bHyTr9lvX3n8PE8pg7LOGqMcjvpv01WmSN/sQCKorzHoGyyiusAyeviQvubEDkTcZ0nouQjkghtME25tSxPTQgYKKzdQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by DSWPR11MB9845.namprd11.prod.outlook.com (2603:10b6:8:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 06:39:44 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:39:44 +0000
Message-ID: <506d94f9-637d-43c8-b16f-f11bbcc243df@intel.com>
Date: Wed, 28 Oct 2026 07:39:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<michal.winiarski@intel.com>, <djbw@kernel.org>, <brett.creeley@amd.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Vipin
 Sharma" <vipinsh@google.com>, David Matlack <dmatlack@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
References: <20261027200006.GA474913@bhelgaas>
Content-Language: en-US
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
In-Reply-To: <20261027200006.GA474913@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1PEPF00005B88.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::636) To IA1PR11MB6195.namprd11.prod.outlook.com
 (2603:10b6:208:3e9::8)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|DSWPR11MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: e06038c1-b2ed-46e0-8357-08df34be4075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|56012099006|261009223027099003|261022075727099003|261026121527099003|261021121427099003|261021135927099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QKOI2gJHzPlqgwiywgePHSZxMnbfLV5ZRP2Dz1gw+mDhb/H4zafaJIOof1L5E5Mz3eHLFBKjKmDwHKfsLpw30y5MGH5yAOah6/jwQyHYE+xCyuBSajEqN33tb4wREb+0PTMCCnnd/kmkbQc1JgT1XWZYGXycn5GGKdxUN2Pl/4S0KQP53OckLc+k8ro8JDuZiko8hPMvTm5M/Arp77ilaoQB2En+3m1B0vZdR7qnuAJwenVhptNFjegu6y6Z2z4NOXb4BIkVapMMpRlUNpNLCAamB0VqggHNXPWY+TTjezojFOfklJ2W1aXCFYmbVIDCrXz7UlHgfrufRPOCCJ2AHXxMgA0z2VN2OkbgnyhHXBUO7CwyYEtH6kgR5lUJp1ajdt8gp+WuRX5x9T+Mxl0HcBzmKPXbhfFKQJDzjHN1t4oHlpr7lUCdxJJUPboAniVfPUnXg1qzmSSG+bRIXBlG9GxXHQ76x0Pr88MbLwlPZkUcXhm/0B5qSTkbkjkK+2L6oKua2+xRHcGOCBlTmkACEJvKE/ulH3R0RFls9/8v4HmwqxPaddb7qmk5opx6EkJrEDGRZEd4EcyhMycl6fi7I5xhG5Vg5cxItWBoVz2zvi2P11emEp9t6izgD6AIy2pthLFGpQmY4ZqUyDdbzGsrvfIpAuUFHRwhBylfkWpsIq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVUeVFmN3NKVVlVcTRHM0RNUHhJblY1eTFZbjVTRjVSNCtyaDNPRFBnUzlv?=
 =?utf-8?B?N3NRVVYvSUh3V3dqeEw4U0N3WUUrTmZwbEEvQ2dBYWVuSjExT2c3cTVJb0J3?=
 =?utf-8?B?UFByZ29jWUIwUzFhbk1ESEJhYXlnLzNDNXpyVmVyME9qMktUeU9JWHcvT3pw?=
 =?utf-8?B?TGViT3J1a2MyU2xoVjJEQktqZlNRM2hnc2ZKbzNPbUpvRkg3V0trb1MybVJS?=
 =?utf-8?B?ZDJzL3M0Q2hTcTJtRGQyVmp6YzBGTFJQbmtDZjFEcjFZMkhqQm5WVGczc2hj?=
 =?utf-8?B?b1R6Y3pqMnVDY3dtZnJ2UkxzN2tVNmtZNjBkZzM0L0RMZGFpbzk3U2preE5F?=
 =?utf-8?B?akZyVTc1T2RBeVhSaFhXenhWeUU4T28vSTIranczZW43Y2xWNWpWVHV4b1Vh?=
 =?utf-8?B?MzV3d2dodE1PREVERENzdnc5R1lwRVZKUkFubGtpUE9uUEtTakR3S0NvWkFV?=
 =?utf-8?B?UGM3Wkh6WmNUWGNpd040aTFmTzlDUTV5aDFZaFdDOUtheEYzcFBCVDVLR1N4?=
 =?utf-8?B?VFhRQXR4cFNkWEdmVFhEQkF3Yng0SEw0NTl1TlBPM3NTTTM2SUlZWmxPQW9p?=
 =?utf-8?B?OXkyaWtkdjFRVGQ0VWlCUDZxSVhyRHZpMjZqODFRaFE3dldUeWE0dExJRUFJ?=
 =?utf-8?B?aEZUQ3ZyRWVIemxXaVFRY3U1R0dpYzFUSEJiTDNxNmlWWVJKVXQxYjlUUVJZ?=
 =?utf-8?B?VU5ncXVYRFRmUU9RVTJjNkFTNHU3YkZ1L1RJc2RONW5DMzFqK1pWd2kzcHlK?=
 =?utf-8?B?L2RZVWoyaVVhMFg1YWw2MHZzaTJZNmtqMWV4aTFDWmg0aDFmQUFRc1BKaFVM?=
 =?utf-8?B?SjlzclBobWJNcXdSUkxMdmxwUzlUdXdZdS9nOGJYYUNib3M3ZGw5NU0yOUJz?=
 =?utf-8?B?Q3AwTGVGdG5hRlhTSllrSVdaRGoyc2d6Z1BLOUlXY2cyN21CZGNBRzBaMWg5?=
 =?utf-8?B?RnhJUXpUVmlzaGVDY1crcVhSelUzdzdJRURYdkgrTjNtcVlmMmZENE5GcHJG?=
 =?utf-8?B?SlVxTnd1YWtBQ2JxcGZSWlAzVWNlN1dUQ1JMeEdQdkVuNFdYT1JmK25qTERW?=
 =?utf-8?B?VGdmczFTMFBsUGFYKytTRVk4dVdUTnBJTTJneno0Mm9aWmd0a1hGK0ljR3ow?=
 =?utf-8?B?SGVFVWpqV1NFU2NYVC9nWnlQZlc1aE9kVXpUeDAxc2huTSt3QnAxZEVtL2Z1?=
 =?utf-8?B?VkprWE9BeGIvSkFISVhpQ0N3b3lGa08vZUM5dEFnUDNBbjVPYjI4VUhzazVB?=
 =?utf-8?B?NVFZbHdZTlRuQ0VFS3lmbUtpd1RlYVRRU0RwTWlxWjRvVllkUVFOejFabFlI?=
 =?utf-8?B?QkN3OHA0bXd0THlycDArdmEvYUc2V3ZVOHBWeUJ1cXhDSVZlTzloTExXR0JX?=
 =?utf-8?B?ZkJZZ0xSQjBuU1ZqckNLbXZqL3dWSFJVeUVVQmdFc3VyRXlhVHFnUFdBYy8w?=
 =?utf-8?B?LzByeUNiN2VJSFNvRm1UUm54U2xDSnNiUXhyUWl2SUZuQWNqTjJJL3Jwa1VH?=
 =?utf-8?B?RGl1dkh4QlBVY3hYQXc0NXRGUzFYOUpZTm5Rcm41K1d4WmRzYmZhRXE3TTJu?=
 =?utf-8?B?ZHFoczZmdVVhaXd4UjRmYU53RU9OK00yTkNnK1lGNEVhVGM3cnBpR2ZVRkxo?=
 =?utf-8?B?bGNpTlNlVnZ3RVVycFN0RWh2RnJkVzVQTXJ1SFo4REhsVWVRcW9XQXhMTzF3?=
 =?utf-8?B?SC9La2pMdy9aM3dSUENzUjFjSXRYWVMrTGZHQWJLWU14bDlkTVFYZGFmTklz?=
 =?utf-8?B?WndsRHdiOFdzWHhWZCtzNW1vUXZHZUpZb0NhVVdIM2tjUU9hNCtCWk54cjJQ?=
 =?utf-8?B?Kys5eDBacXgwTm4xbVlxNVRUNW5Oa1dKRTV4RWRYVlV4d3IyMWx0dUtYZjFM?=
 =?utf-8?B?TlVjMlorTG50STQwUHpCbldONkpHL0JUYmZGbExYRkJxOXhMS1dNVGNPeWh2?=
 =?utf-8?B?VlU0ZU1FSUlBNWdlNm9iUW1EMU13K2NFbGpkN1BCYkltbmRyOWFyMkNoUGZM?=
 =?utf-8?B?TmRnVExDU2dncjc2c1VrWlZoaU1EZlNucVMrZ1FvTnl5ZEdIWkpqTzdHT21v?=
 =?utf-8?B?Rk5rcDJXdSsxQ3hRMlp4VGtTMDVRUTBsRDVkaFI1OEQzcGRyQUlTS2JuQzJi?=
 =?utf-8?B?YTJhYXQxb3ZNNnhUdjV3STFlemRpaGhGS1dtTnRHS3J4c2pmbUV6a3JqRTJK?=
 =?utf-8?B?VVlwL09jVldsbnhFbE01aTBhY3c4TDF1WXB1bld1RWR3QWw0RU9OUXBzYlhR?=
 =?utf-8?B?RWlLVXpNcE52dnoxVjRoWGhQY1FZWGp1akx6U2NrUEp2ZS8yMFZYZWszOHR2?=
 =?utf-8?B?S2U4SHM3ME80YlIzcjA3UWRob3F3Q24zVnRYVndUSzZuWGpNVnIvQT09?=
X-Exchange-RoutingPolicyChecked: o3c6PyI0/bwcDeBddBPTwPAgMGQA1izQLlNXfNQUTsUaF937dU3Ff1sRhDsVJhpyQq7eHTNkPHsERT3mFsfyQF5ywK2g4hoFQgugq4vL5nyGW0EjpkLCzOVFv3IiKNBKjmD7TKd/aSCqTzlGPUyiPdjZ1IRy809KOg0ZqbWHC0k7bLJUzwzZCVXSZEleHxEnHwmpUihkNs45qJxLTiGWiCtnYGdiaQqWaaVbJdW/gExJH7w4YE1nRZicpozXVEm8HYCdKZTF5JgQls+HCgd81iG6w2pBKrwb7YbuJCF4R6KW58vy+88ddx3LRLgzRlkfmdu8OP/pVvMPUv1t8xqknA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e06038c1-b2ed-46e0-8357-08df34be4075
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:39:44.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/zMxQxDUF6auHg6V55Xs+xQeeIGHXfHlL+GuT7mN1aGJQX0fSvkpgd/umti97HFMJMOGSrRgCAFyJ+K/YxmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9845
X-OriginatorOrg: intel.com


On 10/27/2026 21:00, Bjorn Helgaas wrote:
> [+cc others interested in VF reset]
>
> On Tue, Oct 27, 2026 at 05:04:37PM +0100, Lukasz Laguna wrote:
>> From: Michał Winiarski <michal.winiarski@intel.com>
>>
>> While the kernel representation of VF device (think struct device) is
>> preserved across PF FLR, and the PF IOV state (among other PCI CFG
>> state) is saved and restored across reset, the actual VF state is lost,
>> as from PCI perspective, VF didn't exist in the time between PF FLR and
>> PF IOV state restore.
>>
>> Save / restore all subordinate VFs config state, and notify their
>> drivers using .reset_prepare() / .reset_done() to make sure that both
>> architected and unarchitected state can be preserved across FLR.
>>
>> VFs are disabled only after the PF driver's .reset_prepare() and their
>> state is restored before PF driver's .reset_done(), so they can still
>> communicate with the PF while it handles the reset.
>>
>> This also fixes VFs handling during bus and slot reset. Previously, VFs
>> were handled like any other device found while walking bus->devices.
>> Since that walk is top-down, the .reset_prepare() was triggered on PF
>> before it was triggered on the VFs. Moreover, the walk recurses only
>> through dev->subordinate, so it never reaches VFs on an SR-IOV virtual
>> bus, as such a bus has no bridge. Those VFs were reset without being
>> locked, without driver notification and without config space
>> save/restore. Now, the bus walk skips VFs and they are locked, saved
>> and restored together with their PF.
>>
>> As part of this, pci_reset_function_locked() now requires PF callers to
>> hold the device locks for all enabled VFs as well.
>>
>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> Co-developed-by: Lukasz Laguna <lukasz.laguna@intel.com>
>> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
>
>> @@ -5340,6 +5402,10 @@ void pci_init_reset_methods(struct pci_dev *dev)
>>    * from __pci_reset_function_locked() in that it saves and restores device state
>>    * over the reset and takes the PCI device lock.
>>    *
>> + * If @dev is a PF with VFs enabled, the VFs are locked as well, their drivers
>> + * are notified via reset_prepare() and reset_done(), and their state is saved
>> + * and restored over the reset.
>> + *
>>    * Returns 0 if the device function was successfully reset or negative if the
>>    * device doesn't support resetting a single function.
>>    */
>> @@ -5360,11 +5426,13 @@ int pci_reset_function(struct pci_dev *dev)
>>   		pci_dev_lock(bridge);
>>   
>>   	pci_dev_lock(dev);
>> +	pci_dev_lock_vfs(dev);
>>   	pci_dev_save_and_disable(dev);
>>   
>>   	rc = __pci_reset_function_locked(dev);
> Today we can call pci_reset_function() on a VF, can't we?  I assume it
> will do an FLR on just that VF?  It looks like this expects to only be
> called on a PF.  Or maybe pci_dev_lock_vfs() is a no-op if called on a
> VF, although that isn't obvious to me from the implementation?

Yes, it still works for VFs and does an FLR on just that VF. 
pci_dev_lock_vfs() and the other helpers added here are built on 
for_each_pci_vf(), which iterates up to pci_num_vf(dev). That returns 0 
for anything that isn't a PF, so for a VF (or a PF without VFs enabled) 
they're no-ops and the flow is unchanged from today.

I can reword the pci_dev_lock_vfs()/pci_dev_unlock_vfs() kernel-doc to 
make this clear, if you think that would help.

>
>>   	pci_dev_restore(dev);
>> +	pci_dev_unlock_vfs(dev);
>>   	pci_dev_unlock(dev);
