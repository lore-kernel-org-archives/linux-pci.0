Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21C36CE18;
	Mon, 23 Feb 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873897; cv=fail; b=O+yyQTUcNhWYSfLESkE4SafoseTIwbNJ3gHQddJm91dtf8qi7afv1KkJ9VeKiqDES70CZRyZ/j4JXmxuNnajiP3VylC+KOdcpN02BzABD5YR9cKdvE66ztuc9YQ+AIiiSgL85hfdClt2OrFPKFilX/sGLcnv6TWUPwXJZ8CMa+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873897; c=relaxed/simple;
	bh=BRWL6NHtCU9Ub8OMXCpqBZrx+g2SpT9QszllgdvE++k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KcSd4Vh9UlteJcR6HAqUfzhGo4L8E9pbWsQFLivqxkYoud32QxmJaOVSPiayZnqEPJmr/v/Mo18O9Tq6jQj9lPNtpVrwkRgNB3jc2ZZBGTvRq+SyhBhxL0lxSxBZ410MQJFzGxD24Lz2P3F1GHyhkr9TOcGCZdAEPGa0xJkb5YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1jteYC7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1jteYC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771873895; x=1803409895;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=BRWL6NHtCU9Ub8OMXCpqBZrx+g2SpT9QszllgdvE++k=;
  b=F1jteYC7rYJKANDm3JCuFdN+5bqnpY2+QBJcVvKrF7/zr0ltC/aSdhon
   f+ftbG+XwxMBkzsbF8Exzh1KWP6qij5SfZpgj+EeZBc3h3olhCfW7RTY4
   XbgsCC1U1OfusawchT9jby5S4YdkHA3YjUmDfw0NG0bLRTTDJx72+0si0
   bjpMLbnbrPn8w3l0V2jmcJ/TNKEfUY4QoSR565aqP3IAVv+HB2ItIAstU
   OFvzbzQa9OT2pr5uspiggOq2PHBWowUN5ij5jQlN7DJKD2YhCcZYdlcqN
   BdTghYsTwafLQ+3EURkVceO5g0X/Yn+RjXErqp+A837tOsk4rX7vgnXM1
   A==;
X-CSE-ConnectionGUID: r2e/cH15SWGnz8v1T9tsUw==
X-CSE-MsgGUID: 3Wt5yRvBQBmom+G9QswUXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72918138"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72918138"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:11:34 -0800
X-CSE-ConnectionGUID: XBmYu+SFSyC/wH/xY7Je2w==
X-CSE-MsgGUID: cRulS0ZeQLGRdPv3oRSXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213975010"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:11:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:11:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 11:11:32 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFv1fUL8vhPvrkaFVWaAU3I4TwR2QvsD7V4nn8N5IGiv/+zswHTJU32+fnnhhsWIXyunZo8VZVMW4EvsKX4Emu62BlbVdLIf8Z1dUXUrtkLzp3xHFrmuZ9vjRRrnTi2RNPEsZ6Z7KwUBSPg0Daqs3eitlz5S1f6qbt3RugdJn9IJqaFg6V10olShRbuDAvz0cBI68h9/I17LRG4ll0vjtu0zfo/DU3NF+L04pj5/DhO7mwJX48L/j2Y+BL9LwDadnhjckycMrERliLE16I2tDGyXS9ApgPmVWNa5FtmEFkFTeU644c91O6+dfVMpfXPcOyjV7XXh7TJtLttXsYolQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COsvkaY+Xc0GeI6gdmei/3UL2gqmhYuZLx4ivnw/f2c=;
 b=sHb8YUgDtkgpfuy5R+3CYVAl2XtJUxReX+J1iFP3ze9jQMIVlxql6HovXokOhpY0J3YWjHNbJErFncB4pPlOidD5BvbpeCiR0ZjJKConQz4x7/+eOdZF77bRiEtl4dz8vu1fQlBSyddVzynWR70Jfh/EHJKGLOm945QHYjx6+sHSy6F7VlKz8GZaYtPxJ/zSvQWZ/v6yBmZHITVc84FMxf+lxi2ZUKCRXXik1XCitYc32puZsyNEOXVBmFO4oOvHfqkLhJZOKMQtK9wMbWOf06JjT0P73dmV+vS7RI7D7+jzqzrDKNvkBqWgrcn7Pya7Ulir1TV3+IZpQcs7/+/Ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 19:11:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:11:29 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 23 Feb 2026 11:11:23 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
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
Message-ID: <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
In-Reply-To: <20260223171527.000016ef@huawei.com>
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
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f75ae8a-32dc-44c4-ccc2-08de730f5961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXJRV1FnZFdOdENpSGYzd2xjUDl6R0lpMVQ2RmorVGNhckxVOWF3VTk3eFp5?=
 =?utf-8?B?RytUdDZKcDBjdzViRythTmtLZW5TTHZVQW5OZSsweGhsZU4xZU1IdVJKamh0?=
 =?utf-8?B?Z2VMUGdiNXBoaWVyeGtLQWk1ZEV1QjJEN01LYVJTamJiTUJod0hIU2lZSm9L?=
 =?utf-8?B?RUFvaDFTOGJwUXl0eDRldUtWUit3QUozc0dmT0ZpSnB1SUZweHZtZEVmRVAx?=
 =?utf-8?B?bjc4NE85YitMam96Sm41UjYzcUVmd1pGM1NMWDczV0R0NVdRNUtLbVAzSjJh?=
 =?utf-8?B?R2FnZDh2cjhpZld3bldWOXh1eWlkK1NVWmF5V0JobXFhUSs0L2p2bStqWENH?=
 =?utf-8?B?U2sreHRmVVlmdE50aWk1blFIUFhwWDgzQnQzU0ZCc3RBQTBLWGlHWENWMXNt?=
 =?utf-8?B?dHBWODc4TGZiYk9BdzZtdDFQZlJyKy8xNjJWRjFBMC9xWkIzWm1sWmw3UmxU?=
 =?utf-8?B?NjBtWW5USFZyOUJ5NHhBemRPVU1UREFYbVo1UWpDTnlodjFKQVpwVXBvRGNk?=
 =?utf-8?B?ek1NTkhBZG5VazBYaXIwSVpPNmFISXZHcU9UNkNnWS80eitzK2k3d1BhaTNz?=
 =?utf-8?B?Q1dlL2VoYkN5enZFVTBkckZ6Uy9CbHNnTFlDbkk1WnI1T1kxNTlpMUlCVTZM?=
 =?utf-8?B?NkdrbWJIcitwM0owQk56R0Z6R2llN2l2SnQwMFpxOW5CckdMRUR1ZFdQUUVJ?=
 =?utf-8?B?RGZNdndRaUM2bS9xSGwvN2d3dE5UYU5DUEUvZGp0Yi9SeHNob3VldU8zWmdN?=
 =?utf-8?B?MmphSTB0dzF0QUZLc21lZFhqeWN5cTBsMGVPOHowZ3lndy9Wd3RZQnpFOXFZ?=
 =?utf-8?B?d0dhV3E2amo2azZSdWYrUDE2YmxiOTg4anFSdjk1WGRPeUFJUTZHNDRKU0RQ?=
 =?utf-8?B?NFJnRkFlRWtTM01yTTl5ckVSU0ZxK2F3VTE0RlN6MFczVXdvbU9PRS9BVDE0?=
 =?utf-8?B?K2ZOcFAxdnlnbmdnUmIrQ0xHU0t2ZjBLK0lTcHlKa3BPb1lIUGJ3aTNUK2RC?=
 =?utf-8?B?UFNkS2Z2cVdvTUFhZjVaNGg3RGFGYlhXb0VoZ2FkRFNtRmZ3dTBYTWJac21M?=
 =?utf-8?B?R2FyaHhUckZIVldHa2MrNlJrakh4Y2xLUkE3UXNHMnFjTXVFR3RGNWtQZzBo?=
 =?utf-8?B?YnAyNUxLSGdBT1FDeVpDcmZ0ZER2bWRteDNWUHQ3YkV0UCtDaHVvNExrdlNU?=
 =?utf-8?B?eC9Xd3J1WWxGa2dpWERhL3dTbHRJTVh0UExIQjhOYmNjUzc3blhnWjRCUWNz?=
 =?utf-8?B?NGdqWGNKRUpONWNyK1V5blY3OHdYbmlyY21vZXBXaTlqeE43SjNSZnNDaFhp?=
 =?utf-8?B?Q0ZRZ09IUm1WNGhXTFk5RG0vYk1NTlMxZnF3ckJsZkRqV3N4a2I3VmFXMC81?=
 =?utf-8?B?OWVpTXVhTmxwYWJaVmdPNEtyODZzMHhtREtvb090MTNZRXZZdDNsRDBMa2Y3?=
 =?utf-8?B?cmcyb253eDFRQkhKUUtzb1dLaUpEcFdwYkVrMWFESVR0UWphVFQ2VjBaaHBH?=
 =?utf-8?B?SHlIcENQNEVjMWF1R3lXQWRmNFZVall3ak0wR3JvY3MveUgzVzQwbHpaOHh4?=
 =?utf-8?B?WG1zRVRlNjRBRElHT0NTZHdoa3BIVEdMV3VxZzdqSEdQSjB4SVZPU3pXdFBa?=
 =?utf-8?B?LytaZXdNemZaRndtRUxxR1ZyKzE5RlI1UERzaWtUbzhVTmFjNjBQVCtEWFV3?=
 =?utf-8?B?TkQzMnY5ZWtwUEJrZEdEMUlSVmoyWThqMFBHMmZCYVh4Q0toZUx6WTgybjNX?=
 =?utf-8?B?U3dDc2ozSDJNeVVqekdISmFYVERCMTFBc3lWZjZ4clpqa0VpWk1RcU94N3JH?=
 =?utf-8?B?cTFkVng3OWZORTh0SVZaQmdTdSs2NVdvRkgrb0p6K1JJcitLOHJ0YjBOUjc3?=
 =?utf-8?B?emNKUXhMbXkxcWdDWFVVbEs4WHdKSjRaU0JDN003MFprU05COEhQT093dWQ5?=
 =?utf-8?B?MEZsZGlQYmpHYytsdkRHTzV2SSswQXpCVXhDK1VFZ0dhMXlUZnRwMERiV0xG?=
 =?utf-8?B?QlMyOUg1N3dPcXFMZ0hxZlhUeTQ4ZmVhWEhPcHZOQ1hQWEE2emxWN0RDd0NK?=
 =?utf-8?B?bDR0YnVPUEpyZzdhcVI0UDh3U0lIZHpveFpsbld1VitDckxHNGUzNFUyMEFv?=
 =?utf-8?Q?LNp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFI0K1A0UzVqYjNZWHp5Z0VxcjEwYzhoMndRaWk2ZzcvZ2QwNnZiQ1dJdG80?=
 =?utf-8?B?aVFyRWVZKytSWEMvQVJLTEt4QndsRkd5dklMY3NJUDUwSjdabEg5bWVzQXRZ?=
 =?utf-8?B?UWFaek0rT0RXVjRUd1krMDBudFdWMmxGclFFblhpMmxQNE5YYklTbjVaMGRK?=
 =?utf-8?B?QUxtRCsrcnRqR3JIMWFreG1tOUlwcUFOS1h1ZFkvZ2FTUElyQ1pUOURxd0JF?=
 =?utf-8?B?NnoxaFQ2WHhCbGx2d2Y1Sm85L1l1V0NOeHJaOUtOYkJudXZxOTRwWjFXaTdJ?=
 =?utf-8?B?RGI0YjZnQ0t2ZXZRUWZyMW5ueHIzaWtzNFd6MFNrRFVXRmdkSEZwY0toV3VD?=
 =?utf-8?B?bllLcWFiNjFYOEFYOFF2Zmd1UXgzMXlYL0NzZGUrU3UxRjhIc3UvdlZRRTdm?=
 =?utf-8?B?Ky9SdEdMN1VGSnpvQk1XUjF1UjVFa0QwdzRtVGVUZ3ZzUWZuR0ZIMmVBTEUx?=
 =?utf-8?B?Y2FaV3JXNSsxMjVSUWRKd0RnSjF0VEhMUXRUSEpid21sUHhSZHdUWXVLaDJi?=
 =?utf-8?B?RzhUS1M2RFk4T3BCRWgrbHpaVE1KNjRmNHpFSk8wTEY1bEg5ZWZXdHVkdkhB?=
 =?utf-8?B?U1BSSTRpajNMdmVvYXRXQ2dZUnRpUHBuUWI4NjlsM1Q3ZXhvdWtGelVKekxm?=
 =?utf-8?B?ZkxhblhyaHNOczJEMlJjOHlpNklXb3JZNlByL0lQVUZZRzU0YXNweWNTSVh5?=
 =?utf-8?B?MzdGaG9OZkE1NTlMMnl6RUFuaHUvV1dKQVZJdEhmSFhqaHEwUGZweHFHazdl?=
 =?utf-8?B?TzF6T1drT3ZyT1BKbWZSOTZsWERRN0FmWXlJYm12K0liMXBGd1JkSFQzbDVT?=
 =?utf-8?B?RTJxamI3MGtwM1lGYzAyRW9UZnlmNjhRenZWQ1VSc2xZY2hzbkFrWGprMlhW?=
 =?utf-8?B?MWRWdEdDMUxzSXppaUxLbUFIMk14WVdENkVUSSs3azFqZHhGQzBFTHdGZGQw?=
 =?utf-8?B?Wnk4Vk5vYlI4aStOdFYwc1Y1ZHA0RTZmdHNLei81UjdVQ1RMUWxXb0hIb25Z?=
 =?utf-8?B?TG9mSmNaM2k3U3d1OXdXVi92RE4vM3Y3cVh4V1MzU2NMUkR0R243d05Pcnp1?=
 =?utf-8?B?WnVCak5oODlZcVNOak4rdkp3bjl0dUhGNDdnUGVtejdWWGN3SEZZdUtKQ2Fw?=
 =?utf-8?B?dWYzVDVCMVFKdk9sOWZPbHNWY1BvNThHSEhmdHRtY2t1anl0ajZaZlRlMXJ2?=
 =?utf-8?B?eDQ2RnNWWVZJdmdzYUlDWTV1azdsd2s0eFVZTDJ0d3BiNVkrU1J2Z0d4SWx2?=
 =?utf-8?B?TXpaMjNuajFHbzBTamp2TkplcTRTbU1NbEcvckxLRldaQSs0UDdCdFczSkE1?=
 =?utf-8?B?aG1KUVNGV0cwT3FZMmdHRlpBWW1BZ1YrZldOdERWbGJTTVhsWFpUQ0hyRmpB?=
 =?utf-8?B?dXpyTFdyU0V4V0FCZ21ydXpseStSaWhGeTZGV09PSjNTaU5vRHNMdGlkYTBn?=
 =?utf-8?B?MWZuQ2h0TXBjSG8rTXFJZ3ZFMlA1NDdjSWw1VmQ4dE9vZlp5bFladWJ3dHhP?=
 =?utf-8?B?cGlReGhGT016VFI2TFNOSjI2RUJMVStSQjR1TFhKb1c1aUQ5UHgyMzl1S1FS?=
 =?utf-8?B?MmpsVGFZZmVldWdxaXpNVmVQRGZxQW9tTCtTVkFtYkhkS1FnNW5QSWl4RWc3?=
 =?utf-8?B?RVJmbnZYTXpLNW9ZNTZ5M0xOcnFZdTBnUkk0bWFubkZoS3FMb0pxN0g2T3Yv?=
 =?utf-8?B?TmNCbmdjUWwrT3ladS9ZVnpOczRJVHZkSUhCNFRQSjFUelZsbXdRb3BOQkl3?=
 =?utf-8?B?emtQZWI4UEtiWEhIRlF4SmhuWnE4UlhKaVRsWm1mSFBhUE8rY3lmeXV2WklH?=
 =?utf-8?B?SHNLR0ZMbFVCMG12N1JDU3RtYzlYRzlpeVpsU0EyYkc3ZHVDbVJIbjNGL1ZV?=
 =?utf-8?B?U2ZuS3NoR1A3eEdyR3hSK0VCWXNrSW5YYmp5anJONk1tYi80WkkrNkFXWmlQ?=
 =?utf-8?B?UjlUeU9QYXpGaU1GWjhkbzU0NXhiVG1LWlJsSVFMcFBpYjlUK3pqSmtoOFFl?=
 =?utf-8?B?MDNzU0h3ZUJKUnAyR245WDBVR2VIZzBFS0RLU25pckwrRGI3aHhFWldueDhY?=
 =?utf-8?B?d3hGVnVHUG1weHdzZlZjRmxjL0lLdUVzOGl2WTRBbldmaDJtWnZGN1hJM1kw?=
 =?utf-8?B?ZkVzWW0zcjFlUk9GdmoxdVNzdU9KVGgrRUo2Rk5Qc25zVDF6Z28wUng0TnBs?=
 =?utf-8?B?b1FZdDZDY05UeTlLc1VicjRhbzNKanFGbG1RT1RNRXB2b2sySzNVb3lJcnRN?=
 =?utf-8?B?bXZrZ1ViTDh1ZVNkNFhvQ21GWDc3SDJOMEF0cEZ3Z2NYUnhZdE4vNU5vNFpR?=
 =?utf-8?B?Y1QwdUVZd1laTXlKL3Zpb3FhMU9FcG84STYxazNITytma09rZVBLZFhDdWNC?=
 =?utf-8?Q?niA8T2KR4WK5U9zw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75ae8a-32dc-44c4-ccc2-08de730f5961
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:11:29.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVyV24Sm7t5Y+8gqNSRiC1ngeRdNnD6lTiV7K2r8oms5knXGNYQ+qzV0bAx5/ivLLQ39zr9JVSxKy4z/4VxFqq25UQZp1ZKyMzCIGysuWr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..] 
> From a simple case of 'what is here' in this set, the only bit I'm seeing
> change in order to implement what I think you and Jason are describing is we
> don't bother checking the cert chain in kernel for the first time: We
> provide that to userspace to decide if it's good. If I understand
> correctly, this will be at the end of the full sequence once we've pushed
> through a nonce and gotten signatures + measurements.  Same as checking a
> TSM provided transcript. That was sort of happening anyway if we consider
> the .cma keyring as just providing a short cut filter if we didn't trust
> the device provided root cert.
> User space got the transcripts before it had to make any decision on
> binding and could do anything it liked with them.

Exactly, the kernel checking the cert is not sufficient to establish
trust in the device interface (Link + MMIO). If userspace is making a
driver-bind or TDISP accept decision, it needs
certs+measurements+interface-report and does not benefit from the kernel
also validating the certificate.

> For that caching the public key bit, I'm not clear on whether you intend
> to do that from kernel side (which I think I'd prefer) or have user space
> squirt that key back in again?  If we are doing it in kernel we can
> at least always verify the transcript is self consistent and refuse to
> give anything to user space if it's not consistent (other than debug material).
> By self consistent I mean we verify the signature against the device provided
> cert (might as well verify whole chain as that's trivial given we have to partly
> parse them anyway to find the cert).  I don't think it maters hugely if
> we do this in kernel beyond advantage of removing a few foot guns and
> simplifying the userpace interface to "I'm fine with the provided transcript
> for use when I'm not here next time" write. Disadvantage is we use the
> cert parsing code (which is there anyway) and parse it all twice - once
> in kernel and probably again in userspace or at some remote verifier.

Right, the proposal is cache the public-key from pci_tsm_ops::connect()
and at least require that the resulting transcript from that session
establishment is properly self-signed. No point in continuing with a TSM
implementation that is not self-consistent.

> Measurement verification (in kernel) is potentially a trickier bit of ABI
> design as the space of what might be in there and what matters for a given
> device is complex to say the least.  Only a small part of that is spec
> defined.
> 
> I can see there may be some use cases where we relax things beyond this
> (potentially including .cma keyring and root cert only)

So I expect there will be an extended tail of problems to solve from
same device and same measurements checks, to full recovery into the TCB.
A .cma keyring may be a part of that eventually, but the "as simple as
possible, but no simpler" starting point is userspace device policy
wrapped around self-signed evidence.

If the device interface is adversarial, mere trust in the SPDM session
is insufficient to protect against the type of attacks that re-checking
the certificate only after reset/resume is meant to mitigate.
