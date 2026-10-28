Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793196322;
	b=Ggn4M3FfpaMcU+FKH40AdCtoBsOb+YhANGPNXbYV6UN+4UHg/zvE7p4SmYfQ1IEN0S04
	 5aYm6ixwyT/RNtnZUdM43u0pMxEe4BLeWTintFyfhcU8voYu2PPLlN8MrV99q0/O2h/wr
	 YZKP995T+tcFoh9Q9uCUGOrtzkbDoa1rwTsfs7RerwqHvzh1COQfsTDjVNhBDK5SiT7sp
	 YFGx2Atn4UhQEPlEZV+hYo/Wjf/Ie9ibHcQBs34w5KKVAE/GwM02ADg0RBbn07jDbthto
	 tB8TD5EI94R2A9Ab0N00giAMSgSE6JJgX1Z7NQRe0nZvko/Cp4kVuidixnmpPealWtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196322;
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
	bh=FLmuHdz34Pcvx1bgPTOhiVUtWxvzafZqgdRRPS+9ecQ=;
	b=igGkFJdIBVWeAf68UKWQMX4iVjzQDt/aOUefO2IDdovdsBeZ2deS9/1BN4UFa98rWdD2
	 BY7mnOFUTH1w/Ii+NNKNjSOlNLU1TM8RIld+eAOJTKe6O1hdlxcnTgOkLhYvAtVfKbC4j
	 zvvyHNQC/tv5ekNWaF0jfbzIRmfXNLH+aTcLa+diHJm+ZmMqTQDqOhNIbtbc3gJagu+6X
	 qKzue3FaO6qYPq+AGIHc3V+BHLmW8jRNBFiEB7WxSnmUXWaIMBqYr4h4vodGIZKyBWcKS
	 CO6sck+fDBYbJomRlchQyVzfTALqZmfUYwVS7dJKKgwPFXJl8THtya7exGkQ1Fdb5KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gS02D44P;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C5606A31E
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 14:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 244C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gS02D44P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793196322; x=1824732322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Py0npMDzu4YOTfHvLAVLsTRHVj+UJSq/mvgkt+7ihzg=;
  b=gS02D44Pkd621FP3RekK7T1jjE4jjfVGxpXj2n0i48jn8wkIVK2FbtSj
   glQGrYkCjE5xUxyv9cOSe4m9YUeXT6vsvxVk2bEI24l/mhi7tFND7aUeS
   jx374sKoR0kK84LKDG/EqrYbqgHOuIHHLdIzRwD3JlXddFl0YtX+g3adT
   7fwZHcFrEWnIJP66TfyPMKKsn/8mv9SqVrLKD0M2wwFZkIQD6uqK4SR9f
   GWkp90k8HIefaLdVQqls6+7yviBX+sDtIj7MspcTslf2tGWkESaTJh5qO
   lc7E9K0tfHKxcj2boOIj5+u7C/ONvTPXA+shBbgGcKf4rqD5cnv/9c2MA
   Q==;
X-CSE-ConnectionGUID: 4ZNqehBWTGKr+uxwg6Do0Q==
X-CSE-MsgGUID: atDjW4KLRsOijZ0ewNahxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1943408"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1943408"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:05:20 -0700
X-CSE-ConnectionGUID: iY0J6N8oTASxKVKESO2t3Q==
X-CSE-MsgGUID: /5ixC/KwQAa0C+O9uQY9ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4711795"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:05:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 07:05:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 07:05:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 07:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQqbfoQeJgMqeZoTi59yZvEuk/HZznRQSGg/vIiOt06ZogAtLEA/2+wdl3iva0M3F7dWGyCf2JXtc6U/+194IRGlQdC4HU78WRf94Oq6yBtXx2oWJlEDpVSwuRnPza4wNV/6Ct5Ml1tJgWIcSjF6QTe5XlsJfju6iu+YHMGab4YhisJQ9cvGxOLxOYqVvAEvqoHMD+mGfFQqUQPqlALVCB6KgjIOX+9gIHRBtsNuZxadBQj3hp3L0Yf36EdAj3pnXX8jWDPgpKnLxlJA+g24Rlo6/UF0ogk7neDzMX8qXgL6PUu1fJ0yiB/nOclHdPaRp1UMlJgSJihn+xDhXE5fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLmuHdz34Pcvx1bgPTOhiVUtWxvzafZqgdRRPS+9ecQ=;
 b=RUQlPROYHcBIUCLjtvSGOcGzQX9lTuHkwQ2Be0GsEVJ2LSfeAR+W0PyyuoVL0zxeg17rAKFchC5RtbyytxUKPFTsQmPQpyxnGe9T8SYrv6d0PHZEqMV8QgyceqHdWz3hHUsW2EHj81YZ+22/0An80qQuhtvFWW27MabshPqG4fwQQVvfwePlkOYU5UtIUQh06lZJLkqkpwhefcnZ4M2s2vGDY0GP2pnm4XkwUmaWnPq1sChLr0Sn7UUkBv5vI+YZoEHFaQ+glSm4/7iLJIU+zzGDanYvaBIxowf0p5F309yZ5mHc4Q7HDNb/xogajwAzdY/ds73Tdd3Uhr8fwCsytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by DSWPR11MB9822.namprd11.prod.outlook.com (2603:10b6:8:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:05:17 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:05:16 +0000
Message-ID: <769b5216-b2ff-45d0-b265-9252d7becfbf@intel.com>
Date: Wed, 28 Oct 2026 15:05:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
To: Weili Qian <qianweili@huawei.com>, <sashiko-reviews@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
	<liulongfang@huawei.com>
CC: <michal.winiarski@intel.com>, <bhelgaas@google.com>, <alex@shazbot.org>,
	<kevin.tian@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-5-lukasz.laguna@intel.com>
 <sashiko-outbox-186926@kernel.org>
 <0576e676-b9b5-422b-8bbf-0643065c1bd5@intel.com>
 <3464fe3b-8a9a-cbe0-c96b-e4929ec46264@huawei.com>
Content-Language: en-US
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
In-Reply-To: <3464fe3b-8a9a-cbe0-c96b-e4929ec46264@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000219.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8c9) To IA1PR11MB6195.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|DSWPR11MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160998e-ea2d-4545-2579-08df34fc7e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|5023799004|11063799006|56012099006|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 6Pg6eDlJ+S0mqBywA8l48Fegl3c86IVlWpV8OEZ8WvRLOYoGfDkd/wrXbiKpAMPjfaeHmeG10KDMYzUYzdYmQBOSqcroaaXGjZe8tDfUmMIjgu4Vs5mVEjua+EoHr5PzoMOmh/riCFa940Jre6IAANdvrzlAk/DIyqGffGLkx2PLCD1mrTh8Y2la45Dd0xMn6jXr4D/kPpDCKBB9FAT8wBYWvHzeZKhRtGmL2yc+m4KQvUez00CB3MVnbs9h9WoTBUL87Me0YNerza3zb6esrY+uS4JALgUG7o25zeApltHpJUimMr90Qt64mh5mXVQquf1fl/aIdZn8rLgMxacjcBtpny1zCkatTjAuUaPYw5WKHIBg2Vpq1GuOH24HO9sKiTnZcVOfOmyrIt2Mmr1Zhm0fJSmWzsVDciS5RS4wZM34+iqOV8X8UjM+1X9/Arj8AaywtEExgircQ0SIFp12uKSnaHOSOOql6cxU2xQ1ZrlXE0DLzPiSJvURucK0pc2xaLhcYU6T2TtCgYoF2j16NNV+PQpb0lPsfxuEXyrSsBlX0KpcqFUV2ESZe4FCqjDKndWwTuMvGlkpVMedftT3mBR99LteoTnWgbbWLswmDzf9aSTOuFOVotskidrdLr83
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklPU2NtM0I3eXZaRlFINklPaW1GbkY2SHp5c3JJVlFaTkpjVC9wL28zUGtQ?=
 =?utf-8?B?Q3h5U3JjZUR3YXpxWkF0cmxwaFlSQjVuZUQrVXpMdTZ1Z1BLR1NlNEFuSW5v?=
 =?utf-8?B?eWd0NUROWWE1b3JHWGlNU0x3d3FVdWQvNk9UaFJ2R3dJOW9LZzBVM045bHJy?=
 =?utf-8?B?eHUvMHJjWEc2YXNlRXd5VU5kNHJBa1V1NzZTdzN5dDR2TU13dzB0a0gzOW9Q?=
 =?utf-8?B?b0VLL0VsM3BnalFPMFVtUEwxS0I1Z2hEdUM0OFJ5WDNNNmEyQitHRHMydzJj?=
 =?utf-8?B?R0RiV0RNNmhiRE8rekMrNnExNFJZQk1jUzlHWVl0WTlKSGdrMDhOVmp3aHp6?=
 =?utf-8?B?RHpjZlFDNG1tQjhISTRLMkpyMkhERUh3Q3NYdHBWZ2FuWFlGV1ptWmJia0FF?=
 =?utf-8?B?SFU1SWh5WENpRC9JNU9uTldHT0RwK3Jxbk95SUdmVGpULzR5YXhWdzNwRk5D?=
 =?utf-8?B?TFFTNCtzUExpN2pudXR1UFZtYTNuVjVQMXRzYngzNjZaWGJWT3hOZmc4bk9r?=
 =?utf-8?B?cUw4eStnWjZUYkJjKzgwdXhSTlBiQlBCV2UwVWpIUFpoamN4R2FRNHE2YU5G?=
 =?utf-8?B?K1VBeWo0TE0wZWNQSS9FYzFOL2VpN25hdlFjaG9waldoWmtpS29LbXU5RXRP?=
 =?utf-8?B?MlNYNEtxc0ROVE1IaXkzRjUwMmEyMTZhbEtMbFBqNlByVWJSN0ZhWS84cm5O?=
 =?utf-8?B?cXlKaEdjek51aFdrTHdlL21rbDdGbGNDUUJVQVJNbjEvQWRRa2U5Qy9oSDBQ?=
 =?utf-8?B?Nk9vZ3FQRi9jeXlUb2VHdVJRUGo4QzRvRW4zV21NUU9WTll1NWtjUXFTT3JJ?=
 =?utf-8?B?ditxZVpKK0FScE5Nd0JWSG1BalVRb2xBQnQ1RDdZbno1NGdNdFAwUi9jVEV2?=
 =?utf-8?B?dFFIdjFEUkc3aFdpRkdkTi9EN0FORUd0TUNJbWlidnJwT0cwNjdyaHV1OXE4?=
 =?utf-8?B?OVJVVmltM2J2QWZyM3hucDF4VWs5TGVsMTVBVW9JY0ZiS3dLNUxtUEQycE5I?=
 =?utf-8?B?eG5kSEs3VGlJSW5nWThud0xZbUFKT3hHS3hQMkkyaUpISjZSenhIZmUvSXha?=
 =?utf-8?B?MW1pcXZZQ2dNd0hmeW9pcDFrT3pWQ0JuSjRFcUFuakRUU0lHOWpLNTcrV3RI?=
 =?utf-8?B?N3lHdTFrd0tlWGc5T0t2ZmlOblFSS2lZMkRIMFlRMW56Y3cyWklXRVE0L01w?=
 =?utf-8?B?L2RFS04vMWdtUG45NWpDMUc1ZlBwcUc3eGw0eU81Z3ZCMi9pMUtIdkNTQzB1?=
 =?utf-8?B?Y1FldUcvNWR4THN6UjdZOHpZaTFocnRlUFNjWVBUTFV1emNscjRCcEtycUpp?=
 =?utf-8?B?OHREWVMycG1ucXRuSGNKc3M1WlRMTituUytGZW5UVDVEWElzVUxqOHlTT2E2?=
 =?utf-8?B?elhVY1l2N2tnbjFkN0hUUHZXQXZHK2JOSkZ3cFNGZUlZMTc1Q2dCa0NRSFEw?=
 =?utf-8?B?ZSsyWTNYV292SEpjRERWOGpHOC9pNkFFaS9OdXRIZnJuK2tBd0Mxb3I3TW4w?=
 =?utf-8?B?NnA4eG1UekJmTWVOdnVlVVZmQThlOXh1UmtzNjZhbmwrdmwzMlBoSnFuMFpJ?=
 =?utf-8?B?V3lRVmErMWMwbmROL1JUUy9URHVoWDJOS2hUeE0vdzc0Q3dGNmNDSlVGY0to?=
 =?utf-8?B?QzZPUFZRQUp5dFJNenRCWjk1RlU3Wng5TDExWXljZkVqVXBpb1JEWTM3OStF?=
 =?utf-8?B?TUREdDNwaFVBd0YyYTZRcndMd0VUSXYzREh5bTY2eTNhN2xhY3VkQjN5WWdw?=
 =?utf-8?B?VjNLUFFKWHY2MWU3SUhwYXNVaEl6aStiK3FOb3NaSkkwVDZHa1puNHZRRzBW?=
 =?utf-8?B?Z0Rmd3RDbnJSTkE4cjhjMmRBcDhVRVV1WTNBN1l2WWJHSjU3LzZub293aUVh?=
 =?utf-8?B?T3BBMzBwa21KL2lOa3Y5Wm9aS3pTd3JvVndDaTZ0b2k1dkdmYU5MZVR0YXFU?=
 =?utf-8?B?TVhpK0g1VHhSYjdsM0ZSbktFQVA1R3FwZVlKV3IyQkM5aVF5QXluUGFpRkxq?=
 =?utf-8?B?ZDJHKzhoa3BFRS9UcWcxdkU5OStZVlNaUDl1VzRmNWNOeTJpQjRtcXNuYW96?=
 =?utf-8?B?d2pEencwUWxYTCtBaFZpQVZSd29UVklWVHZxVkorcUs2bUdYZk0wVmNoWmd1?=
 =?utf-8?B?UXljeXlyZVEvMTJVZER5QjdqSHpEZnR5ejhzdTVqaTg0NUhGdE1nN0UyNVFi?=
 =?utf-8?B?VUI1OWRMK0NXenFTWitIVzBFbVRuU2xrRlVteTlNSEZ1T1FLMGtsM01CNS9D?=
 =?utf-8?B?VjRoNC9ZRmNZcnlZWlIwVXVrcjQ5bk5oL2M5U1FCMDZsVDZ4akQwTjZaOGlq?=
 =?utf-8?B?NnpWekE4NXgwaDhHMFQ5STJsajh3RnJ6Nm9lV3I3aEUwZWpHWXgwUT09?=
X-Exchange-RoutingPolicyChecked: atY9cViKCY+R1kmlAZbkXOjiIBy09BOwJfe5GnyIq3NBVN3UCjG7b99n2e7KmXuffCHSXq4QIv0ZV3GTLK1RwxQCDFc6+HAuH/CkEy2UwdFbY86kXzaGc03cgSSD5N8DSriqioS+NA8szT/J7mqRlcLFyD1MJF0+fyeful2uGtI7/N0GgbKCKQGZb1+yYPA8cAwecfr7cRYR/N9iJjzqZoXokwQHw59y8fruWFBcsddptvfhCrNZMF+JOHD8lzjcwJgCRAn+MMZUyo72+iVXUoZ2F4d9RcCZop5Y2GEKwKs0QeOZwgw9CjrDKXlTgXS8Qs9YXgrzsrKnlp9tnQ3/pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160998e-ea2d-4545-2579-08df34fc7e4b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:05:16.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww6Xv5FuPAbj35q2rT1AZhr4xss+uMqAyEGfqfvpsj4JHA61ujhgmWWygic2+wDkIH8ZdDZHoOX89SLG6zOVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9822
X-OriginatorOrg: intel.com


On 10/28/2026 09:52, Weili Qian wrote:
>
> Thanks for adding us.
>
> We've reviewed the series and confirmed that it conflicts with QM's 
> existing PF↔VF reset coordination. QM currently handles PF FLR through 
> driver-specific mechanisms: the PF notifies all VFs before reset an 
> each VF stops itself and acknowledges back. The new 
> reset_prepare()/reset_done() calls on each VF before the PF's 
> introduce a second path that contends with QM's QM_RESETTING bit lock 
> across reset_prepare/reset_done, causing timeouts on both host-side 
> VFs (QM driver) and passthrough VFs (hisi-acc-vfio-pci driver).

Thanks for the quick review and for confirming the issue.

>
> We support the direction of this series and will adapt QM and 
> hisi-acc-vfio-pci to work with the PCI core's unified VF handling.

Great, thanks. Once you have the patches, I'm happy to include them in 
the next revision of this series.

>
> Additionally, we notice that passthrough VFs bound to generic vfio-pci 
> do not receive reset_prepare/reset_done notification. We're wondering 
> whether there's a way to uniformly cover both host-side and 
> passthrough VFs in the PCI core.

With this series, the PCI core handles all VFs regardless of the bound 
driver, so VFs bound to vfio-pci are covered at the PCI level. Generic 
vfio-pci just doesn't implement .reset_prepare() / .reset_done(). I 
don't think there's more we can do on the PCI core side.

Covering it would require vfio-pci to implement these callbacks, plus a 
new VFIO uAPI to notify userspace / guest about the reset. There's an 
RFC series [1] adding such uAPI for PCI error recovery, and resets 
initiated by host could probably be handled in a similar way, but that 
needs more analysis and is beyond the scope of this series.

Thanks,
Lukasz

>
> Thanks,
> Weili
>
> On 2026/10/28 0:51, Laguna, Lukasz wrote:
>>
>>
>> Adding HiSilicon QM and hisi-acc-vfio-pci maintainers.
>>
>> Hi Zhou, Weili, Longfang,
>>
>> The series [1] adds generic handling of VFs across a PF reset in the 
>> PCI core. On PF reset, the core now saves / restores all subordinate 
>> VFs config state, and notify their drivers via .reset_prepare() / 
>> .reset_done(), as VF state is lost on PF reset anyway.
>>
>> Sashiko points out above [2], that this conflicts with the 
>> driver-specific VF handling in HiSilicon QM and hisi-acc-vfio-pci. It 
>> seems to be a valid point.
>>
>> Could you please take a look and share your thoughts?
>>
>> [1] 
>> https://lore.kernel.org/linux-pci/20261027160446.858300-1-lukasz.laguna@intel.com/
>> [2] https://lore.kernel.org/linux-pci/sashiko-outbox-186926@kernel.org/
>>
>> Thanks,
>> Lukasz
>>
>> On 10/27/2026 17:34, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential 
>>> issue(s) to consider:
>>> - [High] PCI/IOV: calling VF reset_prepare() before PF breaks 
>>> hisi_qm PF FLR
>>> -- 
>>>
>>> commit b82e20ef0c7a057bbb242268e11b3dd9218fd7d8
>>> Author: Michał Winiarski <michal.winiarski@intel.com>
>>>
>>> PCI/IOV: Allow VF drivers to handle resets
>>>
>>> This commit updates PCI function, bus, and slot reset handling to lock
>>> enabled VFs, notify VF drivers via .reset_prepare() and 
>>> .reset_done(), and
>>> save and restore VF configuration state across PF resets.
>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index d8e7c7d8e4021..d088302547c34 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>> [ ... ]
>>>
>>>> @@ -5171,6 +5202,17 @@ static void pci_dev_save_and_disable(struct 
>>>> pci_dev *dev)
>>>>           return;
>>>>         pci_save_state(dev);
>>>> +}
>>>> +
>>>> +static void pci_dev_save_and_disable(struct pci_dev *dev)
>>>> +{
>>>> +    struct pci_dev *vf;
>>>> +
>>>> +    for_each_pci_vf(dev, vf)
>>>> +        pci_dev_reset_prepare_and_save(vf);
>>>> +
>>>> +    pci_dev_reset_prepare_and_save(dev);
>>> [Severity: High]
>>> Does calling .reset_prepare() on each VF before the PF here cause a
>>> self-blocking timeout and reset failure on HiSilicon QM devices
>>> (hisi_hpre, hisi_sec2, hisi_zip, and hisi_acc_vfio_pci) when 
>>> resetting a PF
>>> with enabled VFs?
>>>
>>> In pci_dev_save_and_disable(), pci_dev_reset_prepare_and_save(vf) 
>>> runs for
>>> every VF and then pci_dev_reset_prepare_and_save(dev) runs for the 
>>> PF in the
>>> same thread before any .reset_done() callback is invoked in
>>> pci_dev_restore().
>>>
>>> When VFs are bound to hisi_acc_vfio_pci (where hisi_acc_vdev->pf_qm 
>>> points
>>> to the PF's struct hisi_qm), the first VF's .reset_prepare() sets 
>>> the reset
>>> bit on the shared PF qm->misc_ctl and holds it until .reset_done():
>>>
>>> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:
>>> hisi_acc_vf_pci_reset_prepare() {
>>>     struct hisi_acc_vf_core_device *hisi_acc_vdev = 
>>> hisi_acc_drvdata(pdev);
>>>     struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>>     ...
>>>     while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>>>         msleep(1);
>>>         if (++delay > QM_RESET_WAIT_TIMEOUT) {
>>>             dev_err(dev, "reset prepare failed\n");
>>>             return;
>>>         }
>>>     }
>>> }
>>>
>>> Similarly, when VFs are bound to hisi_hpre, hisi_sec2, or hisi_zip on
>>> Kunpeng920, hisi_qm_reset_prepare() -> qm_reset_prepare_ready() 
>>> acquires the
>>> same bit on pf_qm->misc_ctl via qm_wait_reset_finish(pf_qm) and only 
>>> clears
>>> it in hisi_qm_reset_done() -> qm_reset_bit_clear():
>>>
>>> drivers/crypto/hisilicon/qm.c:
>>> qm_reset_prepare_ready() {
>>>     struct pci_dev *pdev = qm->pdev;
>>>     struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
>>>
>>>     if (qm->ver < QM_HW_V3)
>>>         return qm_wait_reset_finish(pf_qm);
>>>
>>>     return qm_wait_reset_finish(qm);
>>> }
>>>
>>> Because the first VF's .reset_done() has not run yet, every 
>>> subsequent VF's
>>> .reset_prepare() and the PF's own hisi_qm_reset_prepare() will spin 
>>> waiting
>>> for that bit on pf_qm->misc_ctl until the timeout expires, log an 
>>> error, and
>>> return early without stopping the remaining VFs or the PF prior to the
>>> hardware reset.
>>>
>>> On Kunpeng930 (where qm->ver >= QM_HW_V3) with host-bound VFs, each 
>>> VF's
>>> hisi_qm_reset_prepare() sets the bit on its own vf_qm->misc_ctl. 
>>> When the PF
>>> subsequently runs hisi_qm_reset_prepare(), it notifies VFs via 
>>> mailbox and
>>> waits for them:
>>>
>>> drivers/crypto/hisilicon/qm.c:
>>> hisi_qm_reset_prepare()
>>>    -> qm_try_stop_vfs()
>>>         -> qm_ping_all_vfs()
>>>         -> qm_wait_vf_prepare_finish()
>>>
>>> Each VF's mailbox work handler (qm_pf_reset_vf_process() ->
>>> qm_pf_reset_vf_prepare() -> qm_reset_prepare_ready(vf_qm)) then 
>>> tries to
>>> acquire the bit on vf_qm->misc_ctl that is already held by that VF's 
>>> own
>>> .reset_prepare(), timing out and causing the PF reset preparation to 
>>> fail as
>>> well.
>>>
>>
>> .
>>
>
