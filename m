Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41B3D9DC9;
	Thu, 20 Aug 2026 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223724; cv=fail; b=lqgw0TYMwft1wQxeVs27XYRXg8Ia1O9QiT/SghOmCxkflgRT+nRvvJbLsyQeAKGCaKs37MEFjpOjnZ9srMS89hJ3r1PGkWccyr41YuOqZH3n96YeRBnf9l62XCNPpb2vYWXQowvJOg0Yquc8iI9iOjK807Q53SjoaypA0B5YfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223724; c=relaxed/simple;
	bh=HjiM3Ez+iuRA8kNLPQLX5jg28RiVV7bvz/HAbgd9qpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=trF2ZFa9q2Z9sprL2tXDTnvE3iaZUdP1E3ehG4YY9AV2TyVAtDjOb99f51whCMk6w71IjjB84lIEo0m+iOq1p6losb4cWo8tFFF9b1pIiZaoe+0lu3EbnHd650jQeYiNK2d26OD86ryrmA6ahWuqCXAeIaNq7a4NAWrh7d74hZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN5PWvIh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN5PWvIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787223723; x=1818759723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HjiM3Ez+iuRA8kNLPQLX5jg28RiVV7bvz/HAbgd9qpo=;
  b=XN5PWvIheu7z66zDPwadCA/5fapuKsC1PxSxZLrCBsLhuuAxx7zQMRtC
   SFI6+iX+o/MroEgcfZP5rkv/FSxywcLUmbtaqs/gp2XkvE5gAu/oCT+/X
   MOS4onLY+tPKTVtmvTmWGWZeOwJJ7oR/+/aQHgSyyKU0bo2KakE4g0vMz
   rkVpi78zKQ+1uy0BFBqynRsy34E9Dhh6Cu5nZ5VXBJ63lltoa+o5k5rvf
   UHe+AOzngyxMcvqQpBBT7s996hYXkG1rtymjgNWD9JalmVhKaGPKeCU2h
   QG3Pe0ZBtRdSmpSL2QfRGH6I2UKyCFTu7ycuXoJpSrcz6wWS5sAoXAD5W
   w==;
X-CSE-ConnectionGUID: kxqUkUDXRD+Nzrc6mdKndA==
X-CSE-MsgGUID: nK+DtqRvQvygL5K71zAeNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75287136"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="75287136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:02:01 -0700
X-CSE-ConnectionGUID: bmlj4AD3QmOqdSjsvfmpyw==
X-CSE-MsgGUID: ey1GXBUQRSGcuGB3dEjMkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="269807158"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:02:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 04:02:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:02:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 04:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2X+PG9tIW7pxuBVluIqr1SmiNl8rQ/G7JyRJ9nSa4SaaF4j5GB/NDvjMVwmjXk3WmpGpHecVLSCmFwIYrcpYU5pR6ThpLxDRkBgKltnlWClvkeye8AVYAsE+sVEps+T312WWpmLtjoo65SMJ5xTVDa6uH9Bj9ASfZt+/UjmS8gQMUNS7GIT3dzxZ0mZ2xwlAQmvwenIHuGDn0iqilyGfkbbNBBkmvSthdwlr1Zvalquc/IdSo1lknV/2mCWSZGYDhiU0/hw9loZYMcZLCRts2pSJbrEUBNHTLyAvdYOF70kujfzr6lJ6+9kPAhQbmLPZjihIiZPD1IzNO3fvmIErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3JMZRWesSF3jEuXe/GcjoOYI6KeACPYG6NYtEYoilk=;
 b=HHvbcL+GOI4vVmLa1FE0CB4fdwDks5e5ONMoRqzrrRc4DuVJopXtq3pmxCJsw23r51d8HG3V4w1FTEc8AIOGm5ilJ64sZemVLAuWky6y7xUsQ5POKeWJukM5RThckvO8ygIYaCaUo5KRu64bAHsumAHgyhGwk/6mSUhJe+bZKwzo+VoxpTH22C9Jx5s/HQ1R9KGh2kF1mCAkoiC8k0sCmzyGQo3me14ArjaCR+UYJmAMdRqNa7eKzfwMCdpVG5WfxdNPTbrs8Xn72WvU2okKqRffSFN5SBX1K+f9f8xKKVNIshhT4atpdZ60KNtL6XTP3Dh+MvV10G2+8OnE+Cw0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA0PR11MB4575.namprd11.prod.outlook.com (2603:10b6:806:9b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 11:01:58 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:01:52 +0000
Date: Thu, 20 Aug 2026 11:01:41 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<intel-gfx@lists.freedesktop.org>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable not supported reset methods on DG1 0x4905
Message-ID: <qizxseykeoa4672wyg4vl2upbgs2texweq6esra32on7yhiqgj@d6izqf7cjz7v>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
X-ClientProxiedBy: VIUP296CA0124.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::9) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA0PR11MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4217e9-c832-45c9-3876-08defeaa708e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4MjLZ40txSH7xJDGTbDuD2IHgY9Y427WYAkfMC40XR80NznVhl6NCYn2BQEQ2IXE/ZCsLwyGVEiTqVkTzc6zk8G0QNkhHwGEQpO28J5lO/glBBZoWJ8HRmM1WwwdxROivCGH11YvMKmwHUgyGGsQy578HwX+H9siGyJC5uB7mgn+rGeNpgyoWc+0bINNFZmYSKjdW3nGunmIGBnL+QR/wzmq3y1dHBto2oZxPeMAlIndk+UPGgxj1eaFK0yVUksgFPwsuTpL86NOyc9neYiy+wnbH0GyAUpHff6QgmqgEVoaa1uOxHajlrJReBNJ2AA5bTvM5uPeS7k1CGop73rO6HrfKf+6pgXHzIHrLbVRoC+gYNK6uay9HvfmEFNgqbUUfmy2/kkU2QBLJ3BkVVhF331ACsNxFap3yJY0WIBSwXWJpRb/uHBG1WMqBhEN/dzauZU5LpUq20+mLfwcMl8TbHujcMGJttdPOnrTFfVqzVPenXVfWpIX5gXkOaFMf1VQi1mIPVb2/prgXcQjXrDv4b09WFor2h4cpviNbhd3EuJnXP41rQQzsoodAHJjHYxr5cb+28jpBI02ARBwad6at7jRZMKlBi8dNS1LGuN+1NDIilG7MCgDjKjtOK5EOF6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9LQUszY3lIY2hGYndtOUpiTzRLNFAvKzR4bFZFS1VxMzB2N3YvVmMrM0VX?=
 =?utf-8?B?VEY0bVZFRk1jNUYxbzIxdDRGZ0NZTkxwblhwM29sN1J2UXZWTnI2MGd1Mmhq?=
 =?utf-8?B?b3Bkc0FvUWJiVkYraUtrTkphRmk2NjRYN1MxYWhKTitVQjU0QzdxaGpFbTdr?=
 =?utf-8?B?bkp5N1lhQ1U1UzRoY09OSVZQUWYzNVdhUG5QNzlBVnRTS1ZtdWFpU3FZUmNS?=
 =?utf-8?B?QUVDYWV6TlNSelN1OWpaQ2lUbUNBYVFkTjBSK0xCNGJuc2h1ZUdkVi83UCt4?=
 =?utf-8?B?MkpvbytxUStvdkp1U1ZJTkgzYlhYTWdkRFVsTCtHaUdmODBoUVVuR2JmN2Zw?=
 =?utf-8?B?cGZrS2w5V2NTbWpUMGhRQkRpN25hZFZUVno3M2luMUR6M2hlMlc3S1ZEdGdF?=
 =?utf-8?B?OHl6SGZNOFg3STdpWnFoY0hnekdyQ0ROY2dUc1dyQWlwTi9MNnpKN1ZIeVN2?=
 =?utf-8?B?aHNwY0VHOHdnajlHejd4RUEwM0xVOWxzeUo3Zm5SOE94eUZnK2NkNGE3Mjgx?=
 =?utf-8?B?RlRPTUFjQ09sRzNLNXk0ZXpMWGFPdWxxOFFtR2ZZRVBWUnQySlNpajZNaVVD?=
 =?utf-8?B?OEFBQ20vcnEzWHpoZzFrcUZJNkQvRFpyVkpMUjhCNzYwQ1M3d1MyNS9vRzBl?=
 =?utf-8?B?cmhIZTduWDN3NDY0TUQvbEU2ZmplTFNpUWthOHYrZzNvQTduYVA0UTY3Ti9B?=
 =?utf-8?B?NlE5bmJTYkJOaUdsQ1A1Z09lMTBJcG1qNmowQ1hPei9ING83MWY5NE5tWVpN?=
 =?utf-8?B?RzBUaCs5ZHhhSjU4Mis1QXl6TGpYY3BrTndWWkpMS3BuUjFwcE9tWUpUMFl3?=
 =?utf-8?B?UGZZTWthMVlKVGF3WHlhaEpDMm1qT1JLV2owLzFsME5KbnVBT3FaMXo3eVo5?=
 =?utf-8?B?Y3J6MUNPRW1VQzlRcW45MFBHMkpOV1ZGSUZpNkNqMUYySlorUDRBUWhpMUY0?=
 =?utf-8?B?ZkZPR0tCK21DdXh5MGxaT2x0YU9IZTI2TEdoZDkvU3IwS1RKdVRiY1Arb1Bi?=
 =?utf-8?B?YU14QjVTN1FNeVZUM0drQU8xcUNvb1I5ZXBhRyttZGxEWGpqcXFGSXpFVWpO?=
 =?utf-8?B?OHZWbzNzOTVRTWRGVVhtK2FESnZIdTUxYk9qSHVqTHFwNENpOE9LeUIrcU5q?=
 =?utf-8?B?dFQ3bTNzUGIvdlV4bFdHT1AybGVQc01wMVRUYXVkclc5dEZKb3ljZDR2MzN5?=
 =?utf-8?B?MCt3RnpDNjlRUktXbkZWUndFRkp1cTZHS3BPU3o2WDYveVF4NFIrbHdaeDMv?=
 =?utf-8?B?eTNVTTcrSnlkV0JVR2RGRnI1OE1veDVnNFY2SWF1Q3ZFY3FrRWw1bkFNNThR?=
 =?utf-8?B?OHAyYmdYTitvT1g1N1pQYlZVREVXenYrR0dmRm53b3liQjFMRDFXTXBuL2l2?=
 =?utf-8?B?d05YYVVsOGs3U0haZ2FMejdONHpheDY4ME15NllhNkpQK0pqd2lLcmd2QXBM?=
 =?utf-8?B?TXNDeHY4VHBBTmhUMUVEMm9USVppYmJJYnBFS2lzY1BEMzk2VDlGN1BJajBI?=
 =?utf-8?B?Q1dkRkV1OE05di9MN0lGL0hQNitqMFloOVlvejNzSWZQLzZRWTByYk9kbE5N?=
 =?utf-8?B?anBOb052Ri9zNG9tR0FxYVdpc2lsV2JaVm1KWTUxdUhtYWI3RVQwRUJFSW9P?=
 =?utf-8?B?TWlleWNNSElkdjc5MEZkOTlXaE5lb2NMODY1UGYzQ0NPbzhsWElwcDdXN0pG?=
 =?utf-8?B?bmcxZDNLVnVBa2NncVhhdHhMUTV1TFZtWlRFdUhuYkZ1WGZ2NkIxTldtOWZK?=
 =?utf-8?B?Zm16ZnZJb2t6NFZkTGtWVlVtdU9hdzNkYTdDMVlCam1iTzZTYlFCck5MS3lD?=
 =?utf-8?B?SnRZY2pGdm9kTXViSG1Qam15aEE1YTgrNEkvTUNqY0hOUXVJSXJvN04vTGZQ?=
 =?utf-8?B?UFl5NXdCQmh3RlNjNEdNOTVpeW1maGpmaUVUc3YwYWJobG5ZMzZ6dFFnYzNP?=
 =?utf-8?B?TW1LMW94dDAwZFIxQkF3czI2eDloSjdJZ05vdXdyTXZmdFJzMW1BMkw0LzJJ?=
 =?utf-8?B?UkI5Y1RRU0VGei83bERKRlFqcGlhczdoL3JyUk1NY3NxL0c3bWtBZ1NjenZI?=
 =?utf-8?B?UEhPZm9VQU1Ib1pERHRYK2pDVXloQk5qM3JvdkhuVUhvMjNHUC9YN2hnYlk3?=
 =?utf-8?B?R2dnb0xCTmNZTlpmZzJzbTNtbmp2emFJSTVtVVFGaFpZd3BpVlJVakRudmF5?=
 =?utf-8?B?VUZTcnZRcnNweHNINVkyaWZMcDBQZ25NcUdFdVZHbUdIU3k0aHo1TzlzZ1lq?=
 =?utf-8?B?T0tuQkNXdkxRTEtXZSsrYnpLV2N0dUNZYXJRNjY4SmVVeUZtSU5aTWtSdHBO?=
 =?utf-8?B?SXExVWpWTzJmT3d3SGplK0haOFI3cWtmVDlPWGphbmhxY2xyNmlQMVlZRWtY?=
 =?utf-8?Q?7qTQtyZJlbz2MZxQ=3D?=
X-Exchange-RoutingPolicyChecked: T4G4oRrr0Jt1pXdTtuAgTLsHISe/UWKsRX4fTmn0zi5bakcWf2seuLgqYcZjiGzi+1Dpl6YRQoq948WA5l545gnXBUWCBhkYDnY0Pe/7ThCNgUqa+mW64bFwXwDIxolcHokWsa/OtG6qyjbpAB0UkwUyGPSRqdovQUHD+ojXadEBlBi18jf3C2dfLRKgk6z+UstQge1uwi+TID3ct2OTmufDdIqPY/PqV285xsZbuQJEN/pLKTQo+iJalPd8npdxg05JobOpCZlhC/wDRuHJypEhpbRgblFroLzhE9oJLYtpWGTI3tzEhc/NoP5z48ip9FgnmtZEAkc16lIs7ziP2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4217e9-c832-45c9-3876-08defeaa708e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:01:52.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 020O+MuTiPYRCkcDA17UhbUe1lTUt+n1PN3nLI3Pz5/u6kSmelnaggMc1uwdYxFH+76TaJv8Munz4hVITfAxAZNpkvUAZKenfEG2LPZeiNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4575
X-OriginatorOrg: intel.com

Hi Janusz,

On 2026-08-19 at 12:24:53 +0200, Janusz Krzysztofik wrote:
> DRM CI consequently reports failing device reset attempts on Intel DG1
> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.
> 
> Since consecutively failing device resets may lead to system hangs,
> disable both useless reset methods.  A respective CI test will then be
> skipped instead of aborting whole CI jobs.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
>  drivers/pci/quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..63298fba9ddeb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3808,6 +3808,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
>  
> +/* Intel DG1 0x4905 may not recover from bus reset */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> @@ -5594,6 +5597,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   * AMD Neural Processing Unit 0x1502 0x17f0
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
> + * Intel DG1 Discrete Graphics Adapter 0x4905
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
>   * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
> @@ -5609,6 +5613,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
>  
> -- 
> 2.54.0
> 

LGTM:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

-- 
Best Regards,
Krzysztof
