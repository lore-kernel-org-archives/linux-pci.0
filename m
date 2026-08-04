Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADA473C60
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859954; cv=fail; b=uEB1bER6MWgczU8O547idBidvN+dVIqC6yaxMAz85+BduMalAFqONb4L5ZvtAbs9/Y2pBgzIa2hI3r0DZ9HY+bFBVdHG5dP8wgCrQZucFXVnGTOI5XIt/jRlLBZvRg4Gr5JLee3SBlw7jQfWzn/9FJE2eT14hq4lNbe2TvL9d8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859954; c=relaxed/simple;
	bh=TdO5RWh/+1vTu2RxSl/CD9q9aytP+R0eVpORkW1iJxo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2tDuvbEgFCbfaPmyh0e+YJ8Dy42ZOrLxMqt+jzCpbd1JhZzpTuy0iQ8XP2oSPr2YhWcfcz+V/Vqbf4CsDwHNdkTE/Rmqckf84bLvjqIzuSExdGrNTsbhmZzaoYB4Thqt4kj8G/ur6ndRDIWH7vP7b2Ph7A1wOi6WOoD1+ydckw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNSWGijG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNSWGijG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785859952; x=1817395952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdO5RWh/+1vTu2RxSl/CD9q9aytP+R0eVpORkW1iJxo=;
  b=QNSWGijGZaFXlYbbh/yl5/t7hOxswBCpFmI5tw2eiHxXYZGYStvNHqNh
   xWr8x1YzSygsf2sR9oeLhuDOVc3oRIYgCvtlrdv+d5fvQXjz11UG0g5qY
   SNXy6o1JhgRKgSN4Wpz/sJP4ZN1tlTfKuxKsbYgU28coyiOnBAcx+Frfx
   1FHeadUxAT5FhhRj2rSwAwABv8fKLcvTU6g6YxPcr6urmIzqxIn/bZTRZ
   YZ5WbN1SvpMK8j+WJQpQ9qiL+e+o9burG2QQIgfLBb6HBjZvba3NB4fVz
   jzK4I77LuZs0Z9gJ7/lGhREzlbuIPGNLnMzS+MnlYYGcCXX+uhQiJfxpx
   w==;
X-CSE-ConnectionGUID: eT2H+gW6SAipEgcrRqWJYQ==
X-CSE-MsgGUID: iCsI+WvNRuCrWzWYXTNUFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="88944002"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="88944002"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:12:32 -0700
X-CSE-ConnectionGUID: tiuuXPKoRkeAcvxs8nXDwA==
X-CSE-MsgGUID: xG2nU/ZSRB6qNYiw0ti5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265050268"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:12:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 09:12:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 09:12:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 09:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMB4vYPWMgfYsR/s1S60/RtVW+50Ek+05lpsZc6Aa7KlzNp1EO01OMGPeGFqnQ1lup/949eDbI/NhdMRnPu7o5U0LXtQ0WuJdNwJn4xITCo8Vy6olYz7jixxqcw+kBimTMTnuHtOKYqI2Az0f/RMi4oy5CwJ/OdtV9tYC63I68/U/YG/cZwIydSmiDMq8OYob+gR4rkNmllqNG19fQcQqGALzwMQzlngYMt9f+nOY74mGz3BnZLfdFxKK35hxEEwAr08yhB8L/3Snc2ClYncPUpTLoQFA4Ufrpnf0fgt8/Yfljbxaa+NF9T9GPK7RuOZqwX1/uFO5WLuDA/47x34+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+5phHjW+YZ3I62rFaDdfm8etpb7+VUTSdaML9GM0vw=;
 b=eSk/veXN4aFStE+OkedE0+xa+0CWgMdAAQn/yn9aea1yyHPFqDS9x1ZeGqQ4GsahM6/McoxLBzTS7dA5xnG+q4Jts9cZZ5kq1IlbYBhZ7csPgzWELbO68rUq4gnbOe/7FIhOPkYmSPusp6u562KhWkBBpFXxrUyHAZ8dJuhKUBTy5ocIYLP8uIYidPLkbJs0fBmrWTz8xUYa5mLLcGWy0UZifSYFJ/dbd5yCX7XrNo2xV2EpuD3BGd1m9ECmce2rqUtoTFaIMEv0T+ix76myyH1VS1mYA+4wQButGsZrcjN/JCjrs5zHOngl1BecgDrS+IrmKz12PFLEUg9wa9ExQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:12:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 16:12:23 +0000
Message-ID: <59d05b05-37a6-498e-8dc4-3d4ba1c83d93@intel.com>
Date: Tue, 4 Aug 2026 19:12:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/14] i3c: master: Report wakeup events for IBIs
To: <sashiko-reviews@lists.linux.dev>
CC: <Frank.Li@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-pci@vger.kernel.org>, <linux-i3c@lists.infradead.org>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-10-adrian.hunter@intel.com>
 <20260804151019.BCAA81F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260804151019.BCAA81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: d795e937-e9e8-4866-34bb-08def2432b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10063799003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 9Fzr8XLhgNzUKXtowSfB+9d/S7MRM59pXdFP2edaZz3uaGH88VKywdZ9YgU/RZRUR2MhWe61yxAGlT3hp8q7A+Fw0zVQJXPznodBllDlMwh+Mq5CyjBenQoqukVA0kMOJzrZXTAbbu0hPCrLf8I32FschW7AWT4ePUvRoDfzUm9oja4q7X9Y2eAWH9JPnX2WEWGTeROoF6xcsZ6BanI+5cjVByRHpnEm/krYwVFFl9ikm5dmwbzEqQiW7saf0YpFP0pf0+HTq0ewE02txuo2Rlpz7dEAik9hsJgE0A/QBNWF1Vu3alPadAiU9cM9U70pIoExC5uurvkxWNQO1pFlqpgo9EkAUdVnyOjPMiWqbFPvKuQNJ4q5ihz5N8lHDCeyIgDT25pfcVsKb97Ay7AhMFhwPApcthhsLxllTcPAm00zrD1g1YEUF69Z18Gb35M79/Xf2kfzzDj3kATJrb5x+aCyL9HIa2RrhDknEnn1HkD2FIlbyIXqpkGQy62HcAHpA7+9jQ4p019ZzDPdNQvbrXbMwe34Nku2Y8kP5fnDPD39ClmztTdhQFFhVZk3MTDCOf0c7ROmooSVnQAgnPIlut6AgWVbISDEYOmvz12Uw8hf6/v8IefDRLZ+yTFm/l966ECEzQasXSGneyCLQuLixNJ64Y8SXgTFbgCKwv/7gaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10063799003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQxb1o5SFQ5bDFweUU5UXVnZmZmUEtDUlh4dU9neHJFVk9wMmlxZXZCa0xC?=
 =?utf-8?B?Q0NkN2s0MjMzZVF0UDBhZnZFbm02UU42L21QdmVRV2lPUUZPT3doSEM3T3dh?=
 =?utf-8?B?eFNDbE9mV2VXcHNuNnFZemdsNlNXMENuTXU2TzdzQ3JyNkdnK1J5MTkzcDNo?=
 =?utf-8?B?aC8ydXNzckRneklZMW9pVXM2blFYODJ5dHBTR1FNbTZ3YldUSU95TzF5dUNH?=
 =?utf-8?B?UHNvQUVGcTA1UVdBUjBQMnNVblh2UjVPdjZsUXR3eXFabEo1WnVhY1ZxMWlR?=
 =?utf-8?B?bDRUNTFyYUZGUkFsRGFySWRyVjhQUExLaHIwN3JlM2tnWFJ4UUYxNit4S1Ni?=
 =?utf-8?B?VldXc0FMempSYzFKckYycVBiSCt5bUNDUUlsZmdEN0RObm15eVdid1Vyb29a?=
 =?utf-8?B?ci9nYmJZcFhvSkliQzIvTlZBMml3Yy9EekhOekxUQXBlZVlyM0JVS1pvc1hP?=
 =?utf-8?B?ZExON0Zzb1VPdjRlN21FbWFFRFltWHAwSFVsckFtb0tBTldoQ0dVaXE3Mi9i?=
 =?utf-8?B?Myt5Q3JhdURBOFZmUW1CVVJOZ3BBVVJOL3QwMElOZDMzVUxzNnE0L0RacjZR?=
 =?utf-8?B?N25iRHN3WnRqTklUSU5oVU5NUGNBYUpiOXdFaS94M3lRUmxWYTJJMEMzTVhp?=
 =?utf-8?B?a003UitXbHF2UW5wVDhDMkdiVDh0VUZSV3VTMDJJUGljZ29hOHFEN2NOQ1NR?=
 =?utf-8?B?UHJMS2NkenM1SVBEMVdxRGNhRjhNeml0ZWZIYkxkbzVBdVc0K1BBeElHTHA5?=
 =?utf-8?B?SVVHbkpvOFFKTHd0NjVpbHQrdVpJRUE4S2M2WTdhSWV1c09ZNG9kV1ZINjRH?=
 =?utf-8?B?WUFBR1Rmdm56RFF5cFA3ZTRrWTRuSkFJeElrWVhBM2Y3NTIzZUt6TWZ5ekxq?=
 =?utf-8?B?ZHhwTzhJMFZiZkRvaW9BVm9oTjJvWjFUZU1NakRyc2tHTXYydy9qUmRBaHlj?=
 =?utf-8?B?NzBsK1VVeTh1eWZBRGVUNWMvdlJuRTBFMWpsQjc0ZHY4NFE2VVpkbmFqV1Rt?=
 =?utf-8?B?Q1pQYlRyVXhtQm4wS2lRTk5saEcyQXpDWVBUQjhjeFNyQitUZXNURG5ZL2Vm?=
 =?utf-8?B?eEpyeWVrZEtrbnZISTBTczlKK3o4bmpGRmR0VkVZUGQ2cW5iT1A5aDNNMmFh?=
 =?utf-8?B?NGNnd0x4MC9hVHFWS1Bha2FtUkg3QUZKREUyS2F3emxrQjVKQlZ1UTVkZDhQ?=
 =?utf-8?B?QzRNc1p5MTgydkVZTXN2ZnhEcnBoR01STTdtb1ZpTGIxR21QN1hVbnIrWVVt?=
 =?utf-8?B?RXZoQ2gwUmNuc2FrRkxJbXV3OFU5eDNaVTNqckZxMmZiTngzWDVTc3JJaVY5?=
 =?utf-8?B?aWY3RDBHV3p4cmlPMDMrcVZ0WlY0b3F1T2Z1ZmwySkpsR1JwRnVDdXF6TlA5?=
 =?utf-8?B?aVBIdEdDN0ZVQlpUMzNoK2U3TlJQSHNmbm5Ha3NacHY2b1JwTVpQYWFZUCtZ?=
 =?utf-8?B?ODZuM3hOTEE4S0p3SFhIUmI5d3h4VEl6YldvaVNhOCt5YWR1ejNLNC9xMmND?=
 =?utf-8?B?ZnZhcGNhV1BHb25pcitIYmxaVGdRK0dZRzRnVXRodUdYTXh2dC9Kelk4VEd6?=
 =?utf-8?B?Yi9FenZ1VmZaNWlWUDYyZGxYbVdOTEZqTDlsZURyODRDc2JBcExYbVZONGY0?=
 =?utf-8?B?YlB1QlRQdzVKNW5nT1lzUWxJeXUvZXc3ZE0yUHUzaWlVazhTWEw1U0NtWk1H?=
 =?utf-8?B?VEpPZDVxeTZiYXg5UjdwaC9Dam1BU3c0WEpzVERIaVpTSEVLQUtmM0VkVGIx?=
 =?utf-8?B?VVlyeTJnbHhzYjVvTkhlWUpFNTdUdkpLTDR1UGx0SktzNTFZb201VHlDbU9I?=
 =?utf-8?B?ZHlweFdSeUFUSHhacjlscE10ekVWMXdLY3d3d3VQQ3d0K3VSZUNiU2lMZGVB?=
 =?utf-8?B?R1UzUDFuUG8waW9qNG0wbml4WUpqYllNcFhON21HbVQveFRKSXlwaTM4ZlV6?=
 =?utf-8?B?Mmt5NHRDUXVyL2d6WSttckVkTHdUMEJUN2Jrcnc0YTR3TjN2bERDRExCYjBF?=
 =?utf-8?B?UCtESE5OV3FSMUltN0o0THJqbXlqMW1aTmMwWm0xaHBCaUJ1YU5EeUhOTEV6?=
 =?utf-8?B?WHlUTy8wOVIyNzhNMExUT1Z5RURSRnlVM3h0dWRLdzlVMGFuRnEvMTMzdFhj?=
 =?utf-8?B?MEdwdndMZWR4RE1zT295Um0yT3IxVElWTTVhMDFDd09ncktNbHFpUlU2YXJq?=
 =?utf-8?B?bzdvSkgvYVVnWnBScXNvb0pxTEF3Ri9RQkV1czNMcjBESFdFTkJENzVRenZV?=
 =?utf-8?B?K0pUcTEydE5aMGVTZ3ZFNzh0SXk0eElyZ1Z3REYxcE5sYkJXdVVwb1YvSVhW?=
 =?utf-8?B?ZWpSVDBsYWRzY3RKZXNtb2NmT3llMDZ0RSs0S2dUOGkvaVU4aWdIUC9HdDBQ?=
 =?utf-8?Q?CkvaelPvsUTNztVo=3D?=
X-Exchange-RoutingPolicyChecked: m8XC6rEx/Vd9eS4pNHngYV134/95sCDKfBSNpiXU4t4H2ttHZc/TySX1L0yOQjortegVXGIisjGCiXUx7nwujOH8MCuKZ28aa53H133Y7c3qR41ggfje7tbxyb11DRx7pEngeaW/8ehwCTrk/T+CPtmqN3eRftOeoD/wJ0N94v84fhzO4mL2/aHXl9b7phoFdcf2kTgnxbzL1iOeF3N/uJe9e5K+ozFe7iZmXcrnQFvkLwXnM7h++9B5YyQd2v64HzQ+NnFcMov63QbJNmd/TWloAVM5r4397513zxNCEVUeCzhVBz9vXv5PP8lvn5K2et4W11eGdmORYI2X+yNPqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d795e937-e9e8-4866-34bb-08def2432b44
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:12:23.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pCWS9UAOVOCls4nRLi1Y141NBR5KhEe8pf0ACLFtTJNrpX1bMc0v2TSj0kSxvnWeR8Ksw+xzZExU4OuDOpCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
X-OriginatorOrg: intel.com

On 04/08/2026 18:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unprotected dereference of dev->dev in i3c_master_queue_ibi() leading to NULL pointer dereference or Use-After-Free during teardown.

dev->dev is always valid.  It is use of the first 'dev' (struct i3c_dev_desc *)
that is questionable because of the oldev/newdev dance in
__i3c_master_add_i3c_dev_locked().  As it says there, olddev does not
exist on the bus, so it is unlikely there are any IBIs inflight from
when it did exist.  It would be strange if a newly DAA'ed device
started issuing IBIs, but most controller drivers do not accept IBIs
from newly DAA'ed devices anyway, so there ought not to be any IBIs
inflight for newdev either.

It is fragile, but it is not a new issue because struct i3c_dev_desc *dev
was/is being used anyway.

> 
> Pre-existing issues:
> - [High] Race condition between hardware IBI interrupts and IBI teardown leading to Use-After-Free of dev->ibi.
> --
> 
> --- Patch [9]: [PATCH V3 09/14] i3c: master: Report wakeup events for IBIs ---
> commit 044b30e8813c466ee0c955f282a081170370a564
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: master: Report wakeup events for IBIs
> 
> When an IBI is queued for processing, this commit records a wakeup event
> for the device if wakeup is enabled. It uses a 100 ms processing interval
> to give the I3C device driver time to process the IBI.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index e6b320da475e0..8c9e62e6f1469 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -3398,6 +3401,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  	if (!dev->ibi || !slot)
>>  		return;
>>  
>> +	if (device_may_wakeup(&dev->dev->dev))
>> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
>> +
> 
> [Severity: High]
> Is it possible for an IBI interrupt to fire concurrently with device
> unregistration?
> 
> Looking at i3c_master_unregister_i3c_devs(), the teardown path sets
> dev->dev to NULL:
> 
> drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
>     ...
>     i3cdev->dev->desc = NULL;
>     put_device(&i3cdev->dev->dev);
>     i3cdev->dev = NULL;
>     ...
> }
> 
> If an interrupt occurs during or just after this unregistration, could
> dev->dev be NULL when device_may_wakeup() dereferences it here?
> 
>>  	atomic_inc(&dev->ibi->pending_ibis);
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but is there a race condition between hardware
> IBI interrupts and IBI teardown leading to a use-after-free of dev->ibi?
> 
> In i3c_dev_disable_ibi_locked(), the code checks the pending_ibis counter:
> 
> drivers/i3c/master.c:i3c_dev_disable_ibi_locked() {
>     ...
>     if (atomic_read(&dev->ibi->pending_ibis))
>         wait_for_completion(&dev->ibi->all_ibis_handled);
>     ...
> }
> 
> If a hardirq handler is already executing but has not yet called
> i3c_master_queue_ibi() to increment pending_ibis, the teardown path might
> assume no IBIs are pending and proceed to free dev->ibi in
> i3c_dev_free_ibi_locked().
> 
> When the interrupted CPU resumes, wouldn't it execute this atomic_inc() and
> queue_work() on the freed dev->ibi pointer since there is no
> synchronize_irq() to drain active hardirqs?
> 

