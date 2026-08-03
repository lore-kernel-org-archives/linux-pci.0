Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA433A9E8
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772559; cv=fail; b=BC50sj2GWoC8qLZagg2zPJpADNG335JvTfePFIVoXcuutv9mDxpaP5esKhOrsMmJjOf39nhOMvCltBmT8LXhGeIgQxVbk+5hVOnn5Fn0Tnvf4jTo9HNyjQQegBgwCghnxKfuQWY8Os+/TVyDCmSISGxa9kZ5qkuCoA8KFB8Ekhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772559; c=relaxed/simple;
	bh=QuTwBnDLjc9CAn3uy4rU7ruvrwWo/WymN36vLS7o1SQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JAYtIqoYBlePhI/eAOSDeN8Zkza7Udaxmw3R4Av2IPEdZ96T3QmblfWVf+yK7W52Tfd89ph3KKLHfBwrLZYYci0UwD6nMjW/vYfnKkzUO6PY5QcY6CpkPJI9Ews4Plzvj/v8ZZfr1DyKxvMrOl6B6m2NeFifmBkE0qmGQZB+nTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BY/Gkcei; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BY/Gkcei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785772557; x=1817308557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QuTwBnDLjc9CAn3uy4rU7ruvrwWo/WymN36vLS7o1SQ=;
  b=BY/Gkceio12gSjL9rPs/jZ+CYYdnD2P1+DTfULsMgju7YtJUxp3qSjql
   htxB3OH0R54c2ewZn43K0u+mktFGcpzDoOlH4GXO3RX52YE05M0tTNX/q
   hd5rLP02RKAbSSIQO2teObQHIR9VzW6jIKXv0uqwMRL0WoTfBsnzjpVNq
   JZGLSQATl9SD35L8prrtctAHexI9UNKZoysm4olLaHddeiHSgGlhuEick
   G3WLkmUizpYV79BKiA1ZqnukgZmzUCWl3zmNiLYqkgNms3AZi0SQMRpou
   5umCsU5SadDYkCxEI+xvp/9zCfd8AwoUhhSAnqmJ7clllDAw+eHcrPefF
   w==;
X-CSE-ConnectionGUID: 8sYD9RPITsK27OS+C+tNbw==
X-CSE-MsgGUID: PrQ7PJYAQH+IS24vYds0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96903000"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="96903000"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 08:54:30 -0700
X-CSE-ConnectionGUID: T2PaPpCBSBu1w+Ckx/q8oQ==
X-CSE-MsgGUID: W8wiGhsITHS8cv1o+/aG7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="254965069"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 08:51:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 08:51:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 08:51:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 08:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVd2B51KwvoZl9p9D7+50Lfu/MG+72BAhLSMP4hsypGteoahJHzP+b1DmY7JUN2MqdZA11X5+yznwLxYmzO3VBYcE1RMOJqmHUwS2faoNCFziFrGHTbzLNKjfC1AnK5k9rhE4oOX51HROio83Dy7cHj2xm7GhzQOM+D2htnyAvGCoh+vW4kwVGUtyAyl49A5pwPiyNJlADM0pMbVH+4/oaAtsIEb8OYX+FS/G4P5R8SqkeRC6NzpDck7LPmm2YgKEcpeFZP751qACYBbqaSzX4Kruvhda4scNpofHAV2FLd+jFuK7dOYsSPQLM+1kSri+mhSAnQfHtrI4nCfxAi0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqxremoGiecpcNz+SFuHs+qsFKdjBfLK2gvBkujGWFE=;
 b=mJbFvlfyNqYESuAkQ7EMCknsyY6sEylP0eyX7/pq45K7oH5FdnpStBwpmQ+BEmGm59bv4wrMPdJFnma+slgKbkK3TE3dIvoKOEL29kYrcRrnCg91g6bPYjxoOf5a7lsCznfgEaNBDgqsltz3qHYxpQJyZJubwu2uPYmsggc+uYTEwdvXlFpdEPR6igGaViMabpP4D9sNKWEjWQ4nFQnwV8Po0Gn7S6Da1R7bzWMUfjlaT5jq7H3t21Endo9iA4AM8CdYfuAJZoykjUioXuwn+BFPdZEbBU6XtbjMgCGSukqrJE8vKR867JXbg82SyN3b/vKd1VMsvUJb6/IcleakBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 15:51:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 15:51:45 +0000
Message-ID: <dd61b902-5181-4306-84e8-c7fe1ccf8d6d@intel.com>
Date: Mon, 3 Aug 2026 18:51:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/8] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <linux-i3c@lists.infradead.org>,
	<Frank.Li@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-7-adrian.hunter@intel.com>
 <20260728171817.9362E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260728171817.9362E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 473c031d-df93-4712-30cc-08def1771eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TOC1ESeZi/mc+9b/C9khnAgo11DnLiq6BS0GyX/iZ6hGmzEknB/lMsdk23oWd2SZCeiMr32LG2pr9TSg0tIjpwuFMVRzC8Fj7te44i3S3GJOjKEPeHukKzH2oMfoxW+TNtdMZSf63dYNQYMjJFxv/k/y1Wj5uDxIDyVCsTGKWFJOHpzchJLt3Efhzv/UOkmlGWzi1R7BOaCjmWL0wXMx1f2ZmmJeyng3kAet3i9+Kc6hk5M20BFnrcY2VenFgqT4BoMV1D/nqYJvIdwO7c7g6IVoSQH1cOfCvQ9oUrqJ4yT+DUx56MEBA7lC+YYsOUQg3ZO5C/q3y2IUGYiPFt34Qx8vsuyRIz0Rxo4kIm3vncl1EohxqT4OwXiJZp+hqrKsRk6R2+9hWhZPFxYPwTYlQl1Uu1qghMyenL6n/7Iufhu4jzwtYnt8dgcvnjezPZlEne7rhilhunctec2/jFdKICJAw6dQNKF8oPo6sRIVitF47IPQvnGGiYGOMwuncTIBcsWJk59wbVEVQCQ9KpUyGCkgymIZzj83K1xjkVjquafY6FKS/tC3AWLTwhLaBBUjpDMFGbsFZHM2AI78V2TXCFOB9m5xCQ4a7zEtzxIU+rD7VHc5N3izZJ4pUxBNor9vFfO6BOjjXkvHg0f013ziY57U9gxe7NYMCl09Y2bMZx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9RUk83RXlWTVRqNHMxak81VE1DVDV2QjlaMDMzOGdmTUtIS1d0NGtBVkpJ?=
 =?utf-8?B?ZCtWb2dKOE9pRmhJZy9GTVJvTlNhVXpwalROUkJrZ3VYWVBqeXZxNHh2Qk95?=
 =?utf-8?B?NkxtY3VsRFdyUWtsVHlkT1BPZEFBU0JhMXJTcjg4OCtPOGhlVXpwQUlGRXln?=
 =?utf-8?B?WTdKU095cldzQTcxbU5HUWUvNTEwU1V2REY2S1VnWjUrbzdweFZBdmQzNDJP?=
 =?utf-8?B?aTVyN1k5LzVXcU9BUHF2c3QrcnQ0eVJ3dEU0c1N2WlMzc1cyOFpLODk5QzdY?=
 =?utf-8?B?U3VlaTdIRm5MSHdHbnJQQWF0YnBDaHdKUUhhK2lRU3VwKy9mM3JXc3dzdFhw?=
 =?utf-8?B?TUNCTCtSQ096SHVrcFo0eUNrRmQ1OFNGc1VsSngyVGYxdU53ZnA4Nm9CYmJD?=
 =?utf-8?B?REFtZFZGTlR3RWFPS1J2WVZvMzN4dFFrS254T0dFNlZUSzZwMlNSRGxoYVh5?=
 =?utf-8?B?ZTRhSnkwVjAzbVE4UDlJN2ZDR2UxZElFdmprZTZVVjNwWDJLMW1MM3E0VlZZ?=
 =?utf-8?B?NDcvUTVJcFZ0dWc1azR0VEtZdWIxYUUzUE44WE1UV1pHK3hsOG9pc24zQVZ3?=
 =?utf-8?B?ODBjRHVBQzN4TC90UStkRngzbWdVNmZ6QXdTbUtOeE5QYm9DeFYyTGVMcEFi?=
 =?utf-8?B?MW94eG4veFRxMXNZZzhjVnI3YUduWEl4cy94ajhiS24yN2t6Y2JSU0dVVUpQ?=
 =?utf-8?B?R3BRTy9kWjVwVXlaaUNqMFpGb3J5SjRoalhkSUxrSjREMWtDanJlS0t0VkMr?=
 =?utf-8?B?TllSTkNqbkplVTZzdjVSM0ZiTFIrdm81MkEzeTdzeml5U1pMaDdTRDRUekF6?=
 =?utf-8?B?YWc4R0s5aXZUYXFrMjRJRU13b01TTnRZWERaL1VraUtSdnRTNTNqYnYxRnAr?=
 =?utf-8?B?b3ZSTjFVWjM3WXQvWTNIMnlzZ0xxTGV2WkdrWnN3K2ZNL0lrenAxSTRRWUNm?=
 =?utf-8?B?UkwxT1ovZXJtT1QrT0FxWUVpV0EvK2R3aTBEUjk5R1JDZXBmWlA0bDdNbXF0?=
 =?utf-8?B?SEFodmtscVU3K3RmczFaS1NqVmRoOUQ1S282VW1DOEw0Nk5KaWtmZDl2UDNW?=
 =?utf-8?B?QUtTakdtQWhIZ1JUc3VnQnV6RFZManREWXpsMi9tVVd6TW1wK3crRmQ4VmxL?=
 =?utf-8?B?a1Fram5abjRia0NUbk5PWjJUYnA1MFpPT1NQUlVIVzNtaTZOekVPYlNxdnVl?=
 =?utf-8?B?RHZVT2FvcW5oTyt6MlBMc3RwQURVaXBuQkh3NjhvMS83SE1pWmF4b0VHeGE5?=
 =?utf-8?B?Znc3RmRTd0VmZDRRZEhEcCs5aUlrQXNGVk9EN05mTkd2SzNlM1lQaElNbHFv?=
 =?utf-8?B?OW9HVXd3ZU92bDFsQ20yNWZYQVprU2F0bnFBZytHVi9NWE1pbnVDWUg0L3ZQ?=
 =?utf-8?B?bjJ1c2RzODd2bElOemZRNGlneWpOYklObzFHb3drbWJ4L0JxRWpEanFjVVFS?=
 =?utf-8?B?ZEFJUzR4dURUZTNGTTA4TkhYOE5aenAvSlZFeVZMOHQ5RDMzaHh1ZEp1Ylg2?=
 =?utf-8?B?VkN3RTZZZkY4bW1SV0xHY2RQWjdOMlFkMUw5MmZLbjBrVXd0ZXlPYkNLbGJp?=
 =?utf-8?B?bTBZTWR0Z05CNlA5TStqeEZkTXQwZlhDaklpbWR5bGxqN1l5RFd3ZHRwY2lt?=
 =?utf-8?B?dlk2UzYzbGRtdzRhN3VXK0I5RlRCM3IxNGlhNnA1N3Yrb3ZSUytVU1paVFhw?=
 =?utf-8?B?cGhWTUI0Y3R0bzhDakFJSmFOSGI2d3BUL1ZxTDZuWE9UUHgwejVSNzlnWmpK?=
 =?utf-8?B?MWF3MmdyeFAyY2NLa3I4dUEwNnFDNDFtdUNqS3c5WjlFb3U4VFZhTE1OQStZ?=
 =?utf-8?B?NjdCbk4vbEEzNlZBYkFSS0Fldlo3T3g2WDVrbXU3ZkJSYlVkdHJKb0s2UjBp?=
 =?utf-8?B?VXc2dW05ZVBESG5ieFZESWJHYWdxTmtFeitkODY5aUlNYmFMMnVSaTB4K1ZU?=
 =?utf-8?B?dUxKREZSRUpobXlnUG8xb1kwdVJXQmFwUm0zYlE5VGxocGpnWmE5VlZieDFz?=
 =?utf-8?B?MUlycVpDU0xBREZpMW9UR21hTVJpZC9VQ0ZxWlB4QUZ3ajFIRXZnUW1IdktQ?=
 =?utf-8?B?aENLVm1aaEFQeFJhK2hpd0tQMjFYRHdIY3FEYXdjaXVjb2ZiV1JFV3IvVGRY?=
 =?utf-8?B?WmtTQWljZUtsV1hsN05kV1UwZjJhOGpYT1dCZ2Y2cWlsNHg5TGtXWHY0bnJl?=
 =?utf-8?B?azgxdk5MUnBnTDUzeGdITUQ0YTlWV1Jwc1lDeXdDZ2xNWVRaTERKZUdGaTU2?=
 =?utf-8?B?OWtaa01XV0YxYnM3NStDVVduWVc5K053K0F3VlVqemhDZUFMYlNXLzhmZ3Mr?=
 =?utf-8?B?aUxnS1ZUV0pDVzF5bHRkRHY5TU9Ja01DTWdkWmZOVEdRYm9iVFl2VURBNmwz?=
 =?utf-8?Q?fqgWnXyhAFV1wTkM=3D?=
X-Exchange-RoutingPolicyChecked: TYXlEwB6tkwTgg25rj34Kt8DnVBh5bsTnfZQbzr8DgSxx8CTCmaR7rKmqc+4dzIk+7+8BfhQDfH2iBo1UbLou56t62EUooqr0Jirz9EiJfLHuGGQOIqM3OiRUIJn3lrVTodelA8mHkHXjZY4XrzssLD+hvKRtMfaQlEZEkR5JBYXcEooTfj6HuI653HmhadQQGgmkwdICwCqqMkeBr2TCMRMNrHfn4QbbFIsmPs13iH2khjb7Dnh6Q6vWWqb8hCqFVx8vD9dTkO+eIhF03L4ogG9+W+ACA4d757mCZnchUK+OUTlAMH03dMyvfZ004r9oZgrTM7NH6PTpMni76002A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 473c031d-df93-4712-30cc-08def1771eeb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 15:51:45.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwdAwoRPhWkXTDZSQ/pJKK+jULJhz2uHw2Nqoci75FYhEojo0yBr3Y8EI0IkpvAX18krYFdJe9dGa50J6xghjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

On 28/07/2026 20:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Modifying device wakeup state dynamically during the suspend callback violates PM architecture, overrides sysfs UAPI, and triggers allocations and PM core warnings during system transitions.
> - [Medium] The driver violates MFD architectural guidelines by dynamically allocating the `mfd_cell` array, calling MFD APIs outside `drivers/mfd/`, and the patch introduces a bespoke accessor that tightly couples parent and child drivers.
> 
> Pre-existing issues:
> - [High] Unbound child devices cause a NULL pointer dereference and guaranteed kernel panic during the parent's suspend loop.
> --
> 
> --- Patch [6]: [PATCH V2 6/8] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI ---
> commit bd9a09f1c602f19882ed3fc13b554af06b2d2298
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
> 
> This commit updates the PCI function's wakeup state based on the wakeup
> requirements of the I3C devices attached to the HCI instances during suspend.
> It checks if any attached device is enabled as a wakeup source and updates
> the PCI device's wakeup capability accordingly.
> 
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
>> index 5a9e2a43eff8d..2b3bf6fa74f29 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
>> @@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
>>  	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
>>  }
>>  
>> +static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
>> +{
>> +	struct i3c_hci *hci = dev_get_drvdata(dev);
>> +
>> +	return i3c_master_any_wakeup_enabled(&hci->master);
>> +}
> 
> [Severity: High]
> This is a pre-existing issue, but does this code handle unbound child devices
> safely?
> 
> If the child platform driver is unbound manually via sysfs, or if it fails
> to probe, dev_get_drvdata() will return NULL. If the hardware bus was left
> enabled

It never is.  Doesn't happen.

>          mipi_i3c_hci_pci_is_operational() can still return true. The parent's
> suspend loop will then pass the device here, and to the existing
> i3c_hci_rpm_suspend() function, where both will unconditionally dereference
> the NULL pointer.
> 
> Could a check for a NULL hci pointer be added to prevent a kernel panic
> during suspend?
> 
> [Severity: Medium]
> Does this custom accessor bypass MFD architectural guidelines?
> 
> The MFD subsystem rules specify that parent drivers should not use custom
> accessors to dig into the private driver data of child devices. Here, the
> parent driver is directly extracting the child's internal state (&hci->master)
> instead of using standard APIs.

No, the PCI driver is a glue driver for the platform driver.
They are in the same directory and are meant to work together.

> 
> Could this state propagation be handled through standard device PM wake
> APIs rather than directly coupling the parent and child drivers?

There is no standard API for wakeup propagation.

> 
> [ ... ]
> 
>> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *dev)
>>  	if (!hci->info->control_instance_pm)
>>  		return 0;
>>  
>> +	pm_data.can_wakeup = device_can_wakeup(dev);
>> +
>>  	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
>> -	if (ret)
>> +	if (ret) {
>>  		for (int i = 0; i < pm_data.dev_cnt; i++)
>>  			i3c_hci_rpm_resume(pm_data.dev[i]);
>> +		return ret;
>> +	}
>>  
>> -	return ret;
>> +	if (device_may_wakeup(dev) != pm_data.may_wakeup)
>> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);
> 
> [Severity: High]
> Is it safe to call device_set_wakeup_enable() during the suspend execution
> path?

It is not unprecedented.  Changes to the wakeup state should be
relatively rare i.e. mostly device_may_wakeup(dev) == pm_data.may_wakeup
so no actual update.

> 
> Calling this function during a system suspend triggers memory allocations
> via kzalloc(..., GFP_KERNEL) and registers sysfs nodes while the PM transition
> is actively in progress. This triggers the PM core warning "Suspicious
> device_wakeup_enable() during system transition!" and introduces memory
> deadlock risks.

There is a debug message, but that is all.

> 
> Additionally, does this unconditionally override the user's explicit PM policy
> configured via the power/wakeup sysfs attribute?

Not really.  The user sets policy via I3C devices' wakeup attributes not the
bus controller's wakeup attribute.

> 
>> +
>> +	return 0;
>>  }
> 

