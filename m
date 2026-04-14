Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED323E358;
	Tue, 14 Apr 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203019; cv=fail; b=VGvDk6iXmDz8g5d1SCgfDU4955dwkcxj0u6OI+dfcu8EI39qpjAoRCMDCQgynqAgvABRvxoSufuEYUobKUfiZYq0YRqT4yoaYo8tg86ld1FiF6owfpTmPppX8qvv4E8Zeqg9YooRg1rmkVHT9ghJRDxjhGkqSPN5Aw1MXHAd0RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203019; c=relaxed/simple;
	bh=wdbyWgK8cBTx7AiEf5kG4Y/U/QSH+0GIm9brvmiaZf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cxC/5M5xnqcdWvYTQLRZBxYpdQnM652hxFiOeE0va5naS/sis8nY1nBjoYOsr+dUTww7nasQAneUmK7aBdido5W8AWiUMFilTTVaxXO/aaI+DIqOMXDfPOGKnAtG8xQZNYx1x3wzHh/3159zKJ6PJYfrDBltn66Lf+9Gxeyphas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGFcUVlG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGFcUVlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776203018; x=1807739018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wdbyWgK8cBTx7AiEf5kG4Y/U/QSH+0GIm9brvmiaZf4=;
  b=YGFcUVlGMQ/vQM5WNg/VQoATvwtQCFN5gpf1jOS+MGOnPTUGj2NMAuZs
   jWf7uheTw9IunSGhvy4xi3hxRt60lffqII7gS0xKnETHGGxMTL2vuAiwQ
   uzJp1oO6kGKvRIOpyQhO+v2KNM11pMhFxeGGY/ZYnXb8twNFRg6eWw8NA
   a8R8js1uSPyM0U0EfAiondHvZSAIPy5TbpZhgq9axaLV0Xr4BOnmEZLFD
   +hL4TTQcYzLfrlQjXEQ05Cj0PTcG+JRIjJoDixhFnVkdGPRDtotn/fIpd
   feVRQc19ScFGJhPhEFs+HSBbniInTYdZz+MH2VDY4kdoKsjtoZD8RJYRj
   A==;
X-CSE-ConnectionGUID: jUryykwXRPSDAGRg7gvtwA==
X-CSE-MsgGUID: fdAXEIzeS1qhZ34zjbvCsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77353743"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77353743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 14:43:38 -0700
X-CSE-ConnectionGUID: L7cQXSMQT/WmCOC24KRBpw==
X-CSE-MsgGUID: o3S/1j5RQ7uPnEjwwBlkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260641607"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 14:43:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 14:43:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 14:43:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 14:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l24nCI3ZpN+CVeayl947WxWbx/jSANQLhJknoyttNFln+3gzd1ywgY1IucMSxR2SbCZQGsK19o6bKoPYmOsC/j/DjoVNtylN8jIPfvMATXkholDdvI8IUhnc6BQCxDtLdA+gvOVKXn1megmCx6lKyZb6GMY0oQhtp8dOGfF7ZLgWM/ASfXP+uQxAZeKTVXbB5FOa3XrSH4jdbgUZ59Xaz8tQ2+13vs/0dh48zNtgKFeYWcKYNw0EaGAEHUcIAWcUwmLbOlc6QmROBzn5SC0dpLM73iQFL3ugGBH2DIKGW4j7Ocjmy9JR37Nx0QIKhVXBZ/KfQZrappYCkj8lo5QNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOJS7qdn1Opi9/bjZyrtphFkdesWGHdW8piHcVaA1Ds=;
 b=ZJxQ6PQdSlaEFlqhdE388s7MUkq9q34AIskFvM/1YNhj6pCO61jpa+NTohzyP4OB0DjC1anXQm1FYNDDiB6rqk6JtkyNUvLfLlmf49zYgyCH/1BEnXZtpBHlj3g4k1eN7U4STtwckpJHwKL5Tk3O3R3a1SbgJ/TgaZBLLK8mFSo2XfjNTCgRDegOnuDYtmJ9tOOIk1a7Xz0PLL8TPA7szMNBpf7fklkEKYN3oKGSGFczSJyfx5HgwAGcyKw8J4tAbKTVi47uDWmFCgzuYWEq05TZ4DD9xahTEP3DVUsud1mt9yDB8mSDQms9H7ESNlv3Bfsd47HRNvtDr5QuPy/pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 by PH3PPFB9A266170.namprd11.prod.outlook.com (2603:10b6:518:1::d45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 21:43:35 +0000
Received: from CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee]) by CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 21:43:35 +0000
Message-ID: <df536130-a375-48ff-8544-f107a63f7452@intel.com>
Date: Tue, 14 Apr 2026 14:43:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
To: Lukas Wunner <lukas@wunner.de>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <jay.bhat@intel.com>,
	<ivan.d.barrera@intel.com>, <aleksandr.loktionov@intel.com>,
	<larysa.zaremba@intel.com>, <anthony.l.nguyen@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <aleksander.lobakin@intel.com>,
	<linux-pci@vger.kernel.org>, <madhu.chittim@intel.com>, <decot@google.com>,
	<willemb@google.com>, <sheenamo@google.com>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
 <ad5ZoDCuSsPW0lKo@wunner.de>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <ad5ZoDCuSsPW0lKo@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To CH0PR11MB8168.namprd11.prod.outlook.com
 (2603:10b6:610:186::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8168:EE_|PH3PPFB9A266170:EE_
X-MS-Office365-Filtering-Correlation-Id: 212e006c-a3ab-48be-5de2-08de9a6ee16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 02l4WUrvwOiwynD0eMnoeagxZ9tAwH1gXB6sdyp6zpGz69MsNJEv80MGo8UgD8kpWmQ08le8/W7LYk0LX6r/hArHs/WMvq4N+al/yiWKDF5L/olSMp9y8X/8DbBT1xyUIbNFQeqpgSoS3hgReNEEqybsQTv2dPLZ+5wi4k2g3YTP9yqQPBKJwJJjYvbHtodwBn+ryOGALQByv+EzPSIywEWJxh1DjL7HIvHGl2u6zKyf3nPTsGErJ5DmAU0oXv99RVyHRNklbS3KVH9BtRPQsWxzs/a5EZ4h10m7ZcXqAx1ZzsdGqdbSMXCLMZV1N/oD0LyI3EwhUFYsJXxF7GIyXAUyV6gZq7PeY3zzptQUHEXkspOnLv8AtDbAfNBzEBw82GUT+xK42TKe8790y1bU4AJogU3pK+l2D6LBcuwnxP+AN6qEALkuReu8gzuknh+ohz4/f7cg+NgLFP5XRuBEBqvGPbBer+kSciTHV5DytwLvTmOtYDsi8zcYHJEODY/wHVBjOtLF+RwwJlSVJuPzE15NeZsllmY0Eymf/f4AKF2lJBYM7NfldO1+kTOqhAysAOUocYrbrwc3A5ytdJULRsFF+XkhBm3B5iKY1IBY8JUTrcmSmAagC6QqGDfDCsb0/DHSZWXpanMLC0RS5gBnIsXHfDGjj3yN/rrhFiX+kl4YZ6pSnEqN9abBLK+6req0yjF/XONF/LP4NJFywt0x9nIVQMZLlWnDqEDZBOkVy7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8168.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZSMW9RU0ppbFBoRklma3FJU01WVmEyTTRsUnUwdVlxTFJXL0ZaWlZDVURq?=
 =?utf-8?B?ZVVYYmRET056cXdkbzFGZU5YZlJRQUFYNGhFWitMVDlaWUdOaFJzL0VTd3JR?=
 =?utf-8?B?d3B3OTl5cGZRWHdlVElrSlpMMFFJNjlKaWlRWm05WUZ4ekFrZEk2ZitwSkYy?=
 =?utf-8?B?YVFKVjJJSVZoRU9QbjVMbHh0ZURUN3JrMTdScXRtVmlWRE5TMVJ2N1MrWFJN?=
 =?utf-8?B?Yk9JTllJd2d3MDB1M05WZ2lwbS9xTzA0ZWppMHpvY21QK0RvcDBWdDVIT0Zk?=
 =?utf-8?B?eWY2bHZIRUNvQW5hNUlpWkZnTis1cHlWenc1RVZyUmd5dXExWTBNUWc2YzBm?=
 =?utf-8?B?aCtLL3BEbmtIeEtBZG9iSTc3dEMzcHNwbDJZRUR4TjUwM0cwK0hlWUFKM2ln?=
 =?utf-8?B?VU5GZC9DQWRVS1FNSGxGZUtqbnRXbGNsbkxLSUFnMDY0bEViV3lUdXBrVjgw?=
 =?utf-8?B?RXl0YUhOdEJxT3REbnR5ZFVvREptZnkrb3R0TnBKdXRUbU8xdWE1cUF0T2dn?=
 =?utf-8?B?M2pnU1FXdkFxQ2ZxRVBmcmVXbFBKcFNZa09Vck9rQkRLL2dYc3pDclBKZjNB?=
 =?utf-8?B?bjJDWU83ZVdkODF1cHBFYXkybW5URFNlTTN5ZElGaTUzQlFJeWRjaDFtcHJt?=
 =?utf-8?B?T05TTWVySHpGQUZpM3ZSOXdSVktROWdqaVY0ZEVqaStORUcxREdsK3hvSnV1?=
 =?utf-8?B?TzFtdWgxR3NVSFZOUzYzZ3cwQ1IrOXFObUtGTlRSY3NYSTZoSzM4V1hheWVq?=
 =?utf-8?B?OGFJOCtpa05PYlVwRFZzQ2pmbnQ2SVFGOXN6Z2FBbXpwZjRFNHBKOWFDZnlZ?=
 =?utf-8?B?dEc5NkE3MGVRZkpuT0ptU3JGWEpmRzJaZVFJZUJ6SkhHb0NlZVI0R0llTzVw?=
 =?utf-8?B?SE53TnNLc0hrRWZSWUwyNXIrVDJFNGdURUZZRkJMQlpMNURHQUJrV3Jzc0pq?=
 =?utf-8?B?SjhnN2xBRVJnT0ZmMjgzSjdMdU1oOEF6QjJQc295Z2p4SWtQY0JpdWRCZ2tr?=
 =?utf-8?B?TnI5YkxsT0d1WGtOaGJScEtrU2tIM2ZHSXcyUk55UEs1dncrRFBFR2tFQVgw?=
 =?utf-8?B?NTR5eExGalF0WUdxQ1FVTnpzZkxwdWRPU0NCVHJRNmNwSStMM0NpbWZCUExB?=
 =?utf-8?B?RUZFSzBvcklWUGZ3Y2poRFlQY05aZUNURkFXRER0QkVFWUpvWk1QRW9aRElM?=
 =?utf-8?B?QThhaHQvZm92NjBQcCtDRTl2dFltNUtzMmN0cC84UmdpUHU1dUxTdlVpa3R3?=
 =?utf-8?B?a1gzRi90UHRlaytOMXhqOHZHRDF0dGl1NGNIYTVIcnlVaWZ2by9ybm5FdUlF?=
 =?utf-8?B?YnRkWlZSaEl6QklNTlpkcFZRbFVEalZtV3Frc2pKSWlpSkZBWUErMUc0bFJT?=
 =?utf-8?B?c05WZTJQczNla1lydVRiQ05UL3RlK0krd1RFVTB6SHY1Ti9Rck1PR29odzdI?=
 =?utf-8?B?K1lEeml0QkxIUDJSaVZJM0pQVHVHS1ZWa2g0aGhQK2F1bjJoeDBHT21ZekNU?=
 =?utf-8?B?Sjg0dEM3ZThNdDNkWWVBSzBrZnZZY2lUNTRFNEJGRER5bXV3SjJQN3J2ekpm?=
 =?utf-8?B?RFVidlNXUzVrM2laOGg3b0d6bGhNdzNhZGRGTG5wVTBMbnR5TDFwRXFscnht?=
 =?utf-8?B?Z1JRMWQ1VmJjZDgvTjdRV3FlR1E2YkVOTE5vamk4VUFLZGlJMmFvOWE1cEEr?=
 =?utf-8?B?NHljai9oN25ERjhuc2JXc1hFWk5QY3dpUExDQ3FWNVBCOHdoVnJtb3NCdVIr?=
 =?utf-8?B?WVpiWWh0TzlxS1gyZ1hmK3J5KzE4Q2hKakRtT1pnckZCRTZJeDIrakVpSE8v?=
 =?utf-8?B?RnRwVk9RV2tOZ09xY3loM05IR2ZkMkh5emtLMnJGODJxOVBpdHJTVFhITjZP?=
 =?utf-8?B?QlFZT25vUDUvVlJnYkZoZHZZeUlJaGF5M0hmcHRZSGhXS21PbG43UE5Iakt1?=
 =?utf-8?B?U2xuOUFDbi8xQ0JhSnN2cFN2Nk1pVjlnOUFoeldPdHdmMEhZeklCQnhNWHlu?=
 =?utf-8?B?ZFJLdmxESkRYNFcwcnFPRndWdVliT0IvZEoyS25LQ1pLUDlIK2RUN004NFFG?=
 =?utf-8?B?djkzVkt3eFBueWFLamplZFlDc3lGL0hhemZUQkx3MGxjRXM1S1NkYjd1cm8x?=
 =?utf-8?B?WFU0Yy9FVENsMnpXcC9GellYS01weWt2UVVURlpyNTJMcFd4amNTM053elcr?=
 =?utf-8?B?WldBZzU1YVloVUwyOGswdkZlS0RVdU5xLzE3WXZueUtIQ1FUY1VkY1dXdTNC?=
 =?utf-8?B?VzZpYXB1T3F2TkZSaWRjWWNjRDhJc1grVnc2dW9rS2FKNmFBbFd1UHhyNHNT?=
 =?utf-8?B?UHc5dXJjK00zczd4RWJoTGFKWlhrWWViT2VRak9TanlaL0tVeDc3T1JLcCtJ?=
 =?utf-8?Q?EbFmOUhmEMOOcM+I=3D?=
X-Exchange-RoutingPolicyChecked: AKWyX0HuDWJOCpKX3ruasZna4pcHEhGEoHQFoIMU5vpK4dVGGJ3EeakqDAAO3U//ywI9UkHjTUGAnKtMjapT7YzyxsCalrNsia/pwu8bFnPBx0FepGs7QxK16XGZjmEwm5/5aXbMLA6q6dEmvJIRcgJ3ZkOCpCKYRDr8drD9mjo6BFjpoOcc4s6Nqd3h8s/mPTfAadst97MLUSPsHGahI82K3TFIsqtR8WwmjATFs2DejAQz/bUePKGL2HCUpyGy77NE7EZqMNqsO1hinRkuX/gjtzFMsb7jpO4CRZMnb4PkMuOpLP6Ze07PtB++P+pOH6xE8CjZSS/pJ1elSH8MxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e006c-a3ab-48be-5de2-08de9a6ee16a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8168.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 21:43:35.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhksSAxrPrrZgUBbHROWnMSoD7gTMFGd2h9DKBSeejgWnDcsV/uv9QtFSAPaQyrJohqxDGbVb9e9k+e6bhbv2LhTPQNTkkW0ZQwhsSEqADY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB9A266170
X-OriginatorOrg: intel.com



On 4/14/2026 8:13 AM, Lukas Wunner wrote:
> On Mon, Apr 13, 2026 at 08:16:31PM -0700, Emil Tantilov wrote:
>> +static pci_ers_result_t
>> +idpf_pci_err_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>> +
>> +	pci_restore_state(pdev);
>> +	pci_set_master(pdev);
>> +	pci_wake_from_d3(pdev, false);
>> +	if (readl(adapter->reset_reg.rstat) != 0xFFFFFFFF)
>> +		return PCI_ERS_RESULT_RECOVERED;
> 
> FWIW, there's a PCI_POSSIBLE_ERROR() helper that you may find useful
> to check for an "all ones" MMIO read.

Will check it out.

Thanks,
Emil

> 
> Thanks,
> 
> Lukas

