Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E405502551
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777660; cv=fail; b=psuYsrUBjL9lga3ERSUDrBtnfZjFLHRSe4J2L3GNJPmKBVHqWp3z3RMVuplqoNAMh8l/jKQs4QigESZrEEAudGPFPhkzhqT+zXW226d0uhxsFjLSNm1u+8F1/m0gn/jTzpt7e8O7SLMAwzd78vN2Rv0S67vRmF2pCrIzSDiXZjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777660; c=relaxed/simple;
	bh=ltkRISFvbSKIEE1CbhX/vHfXzBTzd/EEQ15DmlC8LKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CaAA8pMgAL6sinETNv4FD1CqNGZDU7GQ1ayXH3meczsHeUfn6R5FveH5YAAlRA/0BNVog8z4E83BfmWrfLP+VYw5Ysu1ROvyjM14aaBbYIeHOceVOMbDRLoqpRgenxBQWCewFyS+2fCSvhYNQ7+XYHcqvJ8rt/FysA2ZMo83sQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N58BYWLY; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N58BYWLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790777650; x=1822313650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ltkRISFvbSKIEE1CbhX/vHfXzBTzd/EEQ15DmlC8LKY=;
  b=N58BYWLYjufOTf9zP0z6kQtLR3mmqi+Y41hW28ybSqiYJNXhnw6nh+4m
   fKYQd6R3AZvTmQ8CEG+l5DW/bMjtT/h+6dOQ4XFomjEShKz2ms6Ja9yBS
   3ssz+F4zUozbsghWB2yza8voeSZL+obxzzUQWDmdK0EFJT8bWFHPtGIvo
   sGOnKJ4hr6Ouh7F/i2gCVFK1YDRSDJNn64rXRyn3sJ7LrHeEKsUlQ6d/9
   /Qf4u0CWFZvbXMAaeX4FiMgR3Ya3cNSMr8MNSZYBGK23ZHWkANLVo0Wl2
   kDBtFwyM9zIJw6MFtOAMccEUWgR0ozNpHsF/O0+fD8/wmX8Q0o3EaWSvt
   Q==;
X-CSE-ConnectionGUID: 8qbgtPfXSpqdcUSdmIZJWw==
X-CSE-MsgGUID: 2B1vZd6yQEagXMAL8DzxBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90568780"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90568780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:14:07 -0700
X-CSE-ConnectionGUID: WzbIP/zRTOiCPaIA2RWW5w==
X-CSE-MsgGUID: 0he5KZnfTsKWYQI6g+ikxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="272153344"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:14:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 07:14:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 07:14:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 07:14:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKZ0h5Ori6kZXmgLsg////jPXnbBaR6nGAdKqcs/iioQ5EiXQqKMlgUrg2MKECnnspv0CEyIMhgAJ5EtV0Lt1uRjj2A8Px/QFB7ppLk2nEWTN9t9C8dxW+RE0J4UU2hce4WhH9SAJsHGAnJreIkuLL7L2N12OHiAdvLqsOe5yXNXAKiA4v+cszoU2DZJKCPcBByO/1j4RQhJPucuIpOqft6cF9/9u0yVV8r9Bi6QZOUv+m0cQI64EyEZchqr1lUobfOHE5ApRvtNTw5Uydl5JDMNDzoeOagdOlTHR8TiTDfmsNckksKj9ewNfcWjmHUoUcRLVnTiYbqtqILBTijWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0+9/Cvz7qqyxd49c3RjmlyYoCvRV+3+YlRxFnXKAtg=;
 b=U8phz+VDDB21vPxeiUdytmP7axTvDvJMUu5I1nwlkCk+F4IMOv7gEpZhJnB4Drq4uo9rAc+e+5zenZiNNARxrpzKNMDt+JQ5L4ccm5IAJDtWdn9shYjv2h+5mLkxyAF1QNUGsYQGXPgONli2zIz+I7WZ5DuSCbb0K6Vj2V0SQrrQhPyMy7iBohEiXEWjQk7/eZG8JfLku+xZy2zB9ZuZx0MiGwK80jMl1zoJxcVM+MpP9GHy0z9hz9nh6tHwKkfgxKjbp5tJw/HUrcM2BE33hp+ou6afwxJ43uXaIi/5fo55C/6v51UH9xERl+n++YoJnsMDTYx344UMS6L99Pb03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 14:14:02 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::ac99:92ea:20f1:af39]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::ac99:92ea:20f1:af39%5]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 14:14:02 +0000
Message-ID: <b32438d2-4470-44b6-aa62-b691f93a2b9c@intel.com>
Date: Wed, 30 Sep 2026 08:14:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
To: Jiri Pirko <jiri@resnulli.us>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<driver-core@lists.linux.dev>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca> <apl39vOiMPP7VloW@wunner.de>
 <apqSAQykEK3MF9AO@FV6GYCPJ69> <arzr32ZDComnfmny@FV6GYCPJ69>
Content-Language: en-US
From: "Quigley, David" <david.quigley@intel.com>
In-Reply-To: <arzr32ZDComnfmny@FV6GYCPJ69>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To BY5PR11MB4306.namprd11.prod.outlook.com
 (2603:10b6:a03:1bb::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4306:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f635cec-1d11-484d-ec06-08df1efd1435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|4143699003|11063799006|6133799003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J162ciqXfo4BkthFszKxkvhTegMJv/Iz0gn92NKearuZtZvdVGxs5nomgJY4uvoBJLOEtKegwEYqc0MKRTyYAeMuHpfeb2K/gkYDG0zfFaY+Ttj5Eg6hPlkkGywsyq0MhS9nhKw/qiG2lZtNj1M+UTAcZNiWV9U8HmvbV/XXb5K1UZlYSOJWfLcDC/QDxZlq2GGR4KJPbDvgP5iLqWmqdb4fSYI0A/M28VZrFDOPvtTXPQa8tWQoOdHIWrLz3K/o01xZ/NxR/22ZRLbUuXEUa7sgSzSl714renhqknjGl6gN0PK+jRUulVtiiNQaXDjPm7k3Wu4eW88wdlkp+8tK+9s79+XU9Q1VC5CIaTgCQpjpK/AIYydUM9K0rzayqRh0cSSGpJONk2To/RMKkv35tXlwRBl6X9gJGRKO1o+ZK8WQ1HZHVsKzoIU6MTNfFkec56jSbu0Mk6oRBUwmnc8YNs39tI1n2QcIazI3whkmH9Tbe7TrdRGCAz5hHLRqPluwlx0PQVLL483OTDpYIwSXQg3ue/cvZD+i/BE70xK6WWNflqiTqGgguhMzWD55uWTz0NDsSFNBN1yjXajqNGHYMHucs6FCLamYOzNCMb85P7qdyy45uVbu0YecKoHYHE/A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkMzV3RVMXZURXNWT0FvbEFKZ2ZNN3FXOXN3WlgybmxOZDRacWxOUlF3MkhV?=
 =?utf-8?B?bWMyQTNySFk2Ti9VcTJmQWJUa0FZTTltVk1PTkpkOGsxek5pdWt4R0FFM2x4?=
 =?utf-8?B?WFJaM28yRXoxT2lnL01kTE5WRklMZE13MTRSeGQ1ckFyM0FzNlhpZS85YmxQ?=
 =?utf-8?B?aWlOM2h0ZW5HN2RNdlp4NjRlNG91RStWOG1OM3dRSWw0OFlCTFZnRjhOYnFC?=
 =?utf-8?B?VFY4emR2Y0RWUjI4akR0dFlzN0ltdVJFU1V0N0hXTUw3TnNMRXoxNG4yNFhZ?=
 =?utf-8?B?YkxGMEg5T2R0UC9oUk1ad3J1UkRmRmQ5YkFIY3JESkUvNUprNisvdkVUVU5V?=
 =?utf-8?B?ZVZ3UWdRZFBUMXU5VzhMMHdVVHhRd3dGRnNURjYvbTlVRmo5UHlQUmJjQWNm?=
 =?utf-8?B?amxWZmZoeU5rb240dkFRZU1tRnRMYXpIM2hJREdxSGVBYlVNNW9oblRGcHFN?=
 =?utf-8?B?TFpqc2VJVURhYmFQSm1UM2lma052cXlkMEg1ZmlYVVpOc2ptZWIwbTVsQkVv?=
 =?utf-8?B?OWFrd3hSOVZSRnZjNlhpbHdmZjFORFNrUzEyQ1dTU0lWbG9aWnBvbkNzd0hz?=
 =?utf-8?B?RkJYbDZjT1dMdVltVlVSb0FKcGpjaU4yYUlFNTQ3MWU3bllYMmpDUjZIdk5G?=
 =?utf-8?B?eG5udVNBSDllY3RWd1JhUmorUlNxZVJKU2Q1UnZTNGlkbmpNc245RFFQbThC?=
 =?utf-8?B?UjhYZnVyYndSckNwcUEvN0U4aWZJMnJrRy9vRUxpQXVFU3pTSnY0UFJBWklP?=
 =?utf-8?B?TDZDT3c0ejhuUGhRdXJJZWRrV01OdFZTVDdCclljSlpkampvRHptSjdTUWtm?=
 =?utf-8?B?T3l5cG5VSmhlbGFpYzdYUURFUmlZRWphSzFjS1ZzQXBqRGZTL0xFblVkZ05D?=
 =?utf-8?B?RThLZm1wViszdGxwT3hUak9Wc0JqMmc3MzFYajhiYzBTclNNcHV0eEE3S09x?=
 =?utf-8?B?aUtLUkZMK2NORU9XM2phMzc3MkU1NlZDSDBXVUM3WU1obUhJak8rRWowdmw5?=
 =?utf-8?B?YUFRVkVubE5nQWJTNTJiQnk4cVp4TzBudjJYM0VUNTV5QWlCU3RaejhrNG43?=
 =?utf-8?B?WGxTSHgzTFcrNE9KOHQyK2lxczFhNEJJNUFVRk9PeDZLYTdibU5HSUQxRWlF?=
 =?utf-8?B?bS8rV25rQXpmWEhibHBQNnRubGNZODlJR0RPMXdybmRnOG9lTjR3Ly9xc1Ir?=
 =?utf-8?B?MCt6SUV5MVhqWVBwNzhERUhiL2k0MlFCQUdjeWdqbHpqWXY3TXV1Ry9wc0Jl?=
 =?utf-8?B?Q0tnNXJvbEE2L2tpZms4UVB3Umd0aXB2dUI0N3ZiZDF2MWZoTkI3aFVkdVZ5?=
 =?utf-8?B?V1ppOUt0eUhrOTh1S28rZVBHN2pudGw3OUg4REJhdHhqTGNXbHF0cXZiNURZ?=
 =?utf-8?B?Z1AyU3dldmlzZlVIQTlmUkZ1NzJPK3dPVWNmMUdHbnFVdVZQM2ljdWxqLzdI?=
 =?utf-8?B?NWtJbGFaKytOTDRNaHlFUGxsVEdBZ3U2MGpkT2pxc216SzE0dUlKcVlONlhp?=
 =?utf-8?B?WE9SaitDc3lDQ2RTVllhL2xmZEk4SXJQbCtxaVl6TGw1WVVNbWk4bStmUnJ3?=
 =?utf-8?B?eHN4YjYxaTlUdXRhRHBXTGN6WFczMkpLRUY2VTRDV1lzb0dlaEJDelNNREcr?=
 =?utf-8?B?Nk93QnhqSm5CVG01dWdRbHRWbEs4aXRVZGVPL25OeCttRzU3MWRRY282QUhO?=
 =?utf-8?B?SEpIdzMwWXpObm0wMU11czlmM1QwcW9Ub0VJTll3REd4UWJGQ2F4d1JCR3BL?=
 =?utf-8?B?MllocndvWFVUMWpSSHA5UFlJWGN5UFVwSU8yTU1NU1htT0REc3UxK1dtRmFY?=
 =?utf-8?B?STE3MmJsYjlXd2xPWk1pRWN2UWs0d0pwRFIyeEhWektPOHdRb21iV0dOTmhi?=
 =?utf-8?B?MHdMK0dyb3ZGYXl3UWUvR1g5SzNRWkw4Z1JJRmdqU1YwZ2dXZ1VySnozZ1ph?=
 =?utf-8?B?OGZhMGFPTDEzcXB0L1RnNU1JV0o4K3Fxa0RPdVE5VzZDcDEvOUIvMGVCNXhD?=
 =?utf-8?B?OUdDOFF4ZmFoMXhvbGxQN0RYUXFLUlUxQzlFN2hlRVRQQVV2ZkRrdmtFUGM4?=
 =?utf-8?B?STdMb3FLb2dxSG45aEErM2JzRmttUmZ4V2VzMEtRRnVoWW9teHYzeXpORUZJ?=
 =?utf-8?B?QnJ4ZEtKTWNrVzU5U3Z2RG5RSi9ja2xhQXdGMTVDSWVIRHk3RUJ0Q2FHc3pI?=
 =?utf-8?B?ekFzOTJWVXhycUsrZUE1YVVnT2FhZmY3UUV3NUxWWTRtdUxXK21iS3pkN3I2?=
 =?utf-8?B?Y0VNMno1MXppZUhxd3pCdEFOWkYwUkhrb1d0ZlA0MGFQaEpsR1ZZWWExdVUy?=
 =?utf-8?B?SjM4NWUyTnFMc25VYXNlblpESlhkVjBQTko5OVpucGpHa3pXWGc5UT09?=
X-Exchange-RoutingPolicyChecked: bHBWZc9hlrV/HEVjlJVyDuppL+XLOfDYl9L4KqHmWnzIhEPQtm+K9DzZMVOk+7pNH1xBdiZKvMhu/UKZiWGKHs4XVinceTG4OOAE4x0JWaVzgOSLHprZdtSwTNP9lSikCKPSLHh5umNTsVHe32Lwa9bCmwOEZv6JYCBzOsk70uXxQEZXaILVgBTYH6gd6k5qB/PtzSt/liFnR606YnFmErxQwshqlh0Dl9lCV5NvzwMxXI0ciEMe2e/u8CNTvpfxHTPN61jTKg1tbBoazCloFDyzOiT+mya3T4uOZDJ31PypuVs2K382t68TnCs2PUpW1o55CmHiw1ki5sgmxFGF2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f635cec-1d11-484d-ec06-08df1efd1435
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:14:02.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2dIkLwccDNxdumtd87wAJmjdvBeiKpHrIFsTICrY2nvJy5D4HTKWsCZeCRJJuEZTSEI07unav1JSqwwG02+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com

Is there a way for this to be posted as its own patch set so we can 
provide feedback inline? Also do we have any other potential uses for 
your proposed ctlv mechanism or is attestation the only user at the moment?

On 9/30/2026 5:22 AM, Jiri Pirko wrote:
> Fri, Sep 04, 2026 at 11:52:12AM +0200, jiri@resnulli.us wrote:
>> Thu, Sep 03, 2026 at 03:36:54PM +0200, lukas@wunner.de wrote:
>>> [+cc Jonathan, start of thread is here:
>>> https://lore.kernel.org/all/20260902150125.GD2890729@ziepe.ca/
>>> ]
>>>
>>> On Wed, Sep 02, 2026 at 12:01:25PM -0300, Jason Gunthorpe wrote:
>>
>> [..]
>>
>>
>>>> I've asked Jiri Pirko to work on
>>>> the PCI evidence uAPI based on his deep netlink experience
>>> netlink isn't well suited to transport large blobs because the nlattr
>>> len is u16.  (The len of the enclosing nlmsg is u32, which is sufficient.)
>>>
>>> Previous approaches, including the one proposed by Dan in this series,
>>> work around the problem by splitting the blob into a sequence of nlattrs.
>>> I think we should instead extend the netlink protocol with 32-bit "jumbo"
>>> attributes.
>>>
>>> I suggest we reserve bit 13 of nla_type as NLA_F_JUMBO and use the
>>> the first 4 bytes after the struct nlattr header as length (if the
>>> jumbo flag is set).
>>>
>>>
>>> A second problem is that the size of a socket buffer's linear data
>>> is limited.  Also, copying the blob into the nlmsg is a bit wasteful
>>> and we'd want zero copy instead.  The solution I've come up with is
>>> to attach the pages backing the blob as fragments to the skb.
>>> It's very simple, overcomes the skb size limitation and allows for
>>> zero-copy:
>>>
>>> https://github.com/l1k/linux/commit/6e73bb999128
>>>
>>> That commit is from January and the time I've been able to devote
>>> to this has since been limited as my employer prioritized various
>>> AER feature gaps and fixes.
>>>
>>> I worked on this for native PCI device authentication, which faces
>>> the same netlink blob issue as TSM-mediated authentication.
>>> Both should use the same uABI for evidence exposure.  Additionally,
>>> native device authentication may be used by non-PCI buses such as
>>> ATA or SCSI.  The uABI should work for those use cases as well.
>> Not sure if netlink as actually the best fit for this purpose,
>> for large blob transfers ioctl-based iface is probably much more
>> convenient. I'm working on a uapi framework that make the best of
>> netlink and takes it over to a fd-based ioctl. I call it CTLV, here's
>> a link to an early pre-RFC draft:
>>
>> https://github.com/jpirko/linux_mlxsw/commits/wip_ctlv_pre_rfc_draft1/
>>
> [..]
>
> Following up on this, I have a very early draft of an attestation
> framework here:
>
> https://github.com/jpirko/linux_mlxsw/commits/wip_attestation_pre_rfc_draft1/
>
> It introduces a provider-neutral, fd-based interface for evidence
> retrieval, userspace verdicts tied to exact device/evidence generations,
> measurement registers and their journal, events, and device-security
> state transitions. Large evidence is written directly to referenced
> buffers instead of being split across Netlink messages.
>
> For this series, the intent is to replace the device-evidence
> Generic Netlink UAPI and the draft PCI/TSM evidence-accept UAPI.
> It does not replace PCI/TSM connect/disconnect or lock/unlock,
> nor the underlying device-trust, SPDM/IDE/TDISP, MMIO, or
> DMA machinery.
>
> The branch currently contains the core, a simulation provider with
> tests, and a TDX provider demonstrating the provider boundary.
> The PCI/TSM provider is not implemented yet.
