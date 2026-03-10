Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BD40DFA0;
	Tue, 10 Mar 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179152; cv=fail; b=Dg8ywAo4N1MQyvOMMwPRh3yVhRsdxMnIRUFDSfdLAh2TcinqrumykDRq0SW6oZauNxeGwFI0dlDmRzrK5Eht02VZRneTRdFVVs+zfF/9Nm4Nvj0HZCNQGYATPA/dZDs7Nu98g61jbZPUWz15g4lTVugqNUyQ5phoxEs52U1NahY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179152; c=relaxed/simple;
	bh=0wmDeJI5Jw+3+FXjiYrxabrabvkvl8um8him7Fpj5wk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mmm4lVZTVLwD/L8HLdRLtXq9IuOVEtxZoZtXLtR5vnZTe26rumOkk4leyD4mkcpSc2nkcYurhXmCNNDVAVb3r1P1ZGP/5G5xFzjWunyJ6Ve/ijS55n7ICwuyBtNWsQEAacxM2rDK2tAkOBVHBZyIgeD2jEP3pFmViwzGcHH2Kbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQhLb+Xr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQhLb+Xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773179151; x=1804715151;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0wmDeJI5Jw+3+FXjiYrxabrabvkvl8um8him7Fpj5wk=;
  b=KQhLb+Xr3ooVodxpcFyDAZD1XvnlDZXpscvv5XkCFt++eYwu2DIY/oUn
   8J2251Ktsiu72O9mVUNqbZIJhSuYQv60JwoqDqUUP8devTdGMazcvJhwA
   VUM/t4vVVATCWneuEmAOFPkBJnSfIFqToL4jjZYGzJzgvXRvzHwEStc0J
   lRRMlGB8hr4eX04UdJBqMetd9XXOosLcpLdEJyIpqoF6m+MXtK7clkhu8
   AXrk7mbpTnlzFmAgGvXN1aOOfhtrB6bxjW3kFXQVW9BBX7VCG3Vk8KBqQ
   PVvO1/hOw4GTL0ylFgT2/EKquGOcd/6vJZXdZAbk4XwZsEvSdVM0L5lRi
   Q==;
X-CSE-ConnectionGUID: ohHgO0RWSRiHoNjqYM3/cQ==
X-CSE-MsgGUID: P8ub6QKHS/Oi10kTw98hJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73262233"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73262233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:45:50 -0700
X-CSE-ConnectionGUID: KZinbFuGRRuUOso27FKIyg==
X-CSE-MsgGUID: oFiCz4bMSB6+l/YanOH0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220209130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:45:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:45:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:45:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZzGSu64qpuTTraMK/vvdGBNiJlgy6ou6k7+zC0piD6QzIeLMxAEycwGkrQevsqNw1BwgzpYy+SrjgyIkaR7ZkjnBxxqYBw06FbcIeVSlIFkHqaSCiV86VjwKPSgG2jbxlr8NfkOPNmurJNIvobVNdSoE8fGSJjvQbRGbGrSkQMIS3hijuQEHxoxVGl0wYRFSI463rynLuM5oIWmAH/QvBzTw58RtnYGL3PRLJTRN+dbI/nQYVK0RbGdU+AGDap6HQsi+3p9/ZrMNZhinrLwY6uIeay9UPWAhNfETA0n3YflsQ57Euqqxp4NoHjcSX28h0v2D5bz4MiN7Z/CZsdeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4buGcupJ5I5o3o8NvmmYdgzwfNEKjTfBDzjYhdu4/w=;
 b=FZlhY5Nk/6TCbwLs/OktmFgsJUeZ4e33h5KOAZUA6eNsETzsEW13sYiTXXTmzH4GIG1LX3uDNJPAwKJkXwVSt7f+yRkvhmv+mM3oNGtNZwCJRtW/ikpZTmmcaaI5geaQeqHgkMTVk8wZ6pxhp9aR7fRgiDfR5z2mGiH7iG9H6M7pV/7M7qNbpyN8NM4RHasrYzf/fDwBHIQSn3ILtbAMyiJxb1C1bTns1/gPDP9RSmjWrgYc7ocanG9JFQeF40BICP7etAr7FpuxEwYONsrsz4GGjfmgu2gRrVG20JV7CxaLmCP9uuuLZZIX7sq1pkBtzoIaEzi4cd9MrEUWzp44OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:45:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:45:46 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 14:45:45 -0700
To: <smadhavan@nvidia.com>, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Message-ID: <69b0910946884_490a100ed@dwillia2-mobl4.notmuch>
In-Reply-To: <20260306080026.116789-4-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <20260306080026.116789-4-smadhavan@nvidia.com>
Subject: Re: [PATCH 3/5] PCI: Add virtual extended cap save buffer for CXL
 state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcba7ef-bb5a-4add-33fc-08de7eee62f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: f2xfH9yardBJo9pCkCDRg6kiFRUKW4eVunv+/Fv3SBYlIIV8gX5M1/JM6vsPCDazJ0jf2t2RTeMLInV5B4l2W4Vm64wrKSqKFYH2G2rjRv9ACx6eB8GnWkWnGUClliqQF3w4QEMiFo+XPjT3/h0C+XzeO6rjme4GmVswuaMt8imneD7IAbTSgrA7H3XYUsrkhiBGGx+H82Tvf722NbpdK2DogvM1U1INLEeAWEJy8F/3nqvndwkxX+ABdBtODmtbOmiz+/mOGCJc1E8+nYzK1cpPLwJFO3r2B7EJ8ZDfPGx/tD37oya4H+Zcx+2e2DMJ1sQ5g3i1C6eQPRBDbRV+UH+b4oSzEf08usb456+zmf2XNNzuH0OgrJFS7pHECd+PmZFwh2sNLX9aiVXws/mnY+OIU6PEt0sFDFhaL1c4cgEIxAksEX08LwKjslWQyf2f8Ac7Gwv+QPywsjp+0WFGYle1J4D/WptnYscQ8puXwlPTJooXuMjMEmt5MlS1WR2eciOTbP5TmdjU3FUK1OHAOniu7+m/4NxEkFsdaMV+ztK6J6pJKexxTq1SaEbTpiOVS2047LUHOz3ss0m1FZZFR5db5vuQGrw5SEvzlGw7oKfgkYMBI6pH8kC9B31PbXUpKftxJYkY2/PqXxyJsiSdQiMA6hC8nONI0yGDXg47WvFeppgB91vm/EkukB9z6188vnq1+mk9Qir+CyV44xttEHq2ElbicGTiuLC8ioN5xeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUk3dUFmcTRaMHdOL3ZwbllzVHlvUDMyeVZkMk5md2NYMlI4YndjajVocjhP?=
 =?utf-8?B?d0I1RTJKMlJxOGNBMnBXNFZjMFl0NUpQNFZYQWlOMURBaW9GU2RoOUdxUCtX?=
 =?utf-8?B?MWd3R3VPS3F3MERsTUdDZHFXbHRQVG93Q0JwNHhBYUhOZWxVbkhObkMwQlBn?=
 =?utf-8?B?Z2VCbDN1Yko2aWJSUzFVYkh6NGZ2R2tpdkxJUlNpN09zWEZheEhzcVhKdTBM?=
 =?utf-8?B?VjE1M1VYbTM3Zk9hTkQxb3BTMm9mRlNCUXp1cjcrbjU0OE4wWHM2a3F1U3BG?=
 =?utf-8?B?MHJUTTVORFl0TFNoeCtpSHZhc1hnalB2alFqeERCbUpoSE56dUNyUnNZUzZu?=
 =?utf-8?B?Z1hLWUJGYTRKSiswaDVoR2Rpdi9MaFFMNDRTVW95UEpVUmhvazdycVFpaE80?=
 =?utf-8?B?YXFkQU9oaWVBUWxaOFhPRWZGdGsvbEZXazFrdG4zNG1rYytNTEVWRll5YndE?=
 =?utf-8?B?UkhybUpWMU1hY25taHBycnUxQ1I0VXVOUWJTQXRsWVA5LzBic3BRYUZSMkIz?=
 =?utf-8?B?c0VXMzc3QXIzQUp2UEs4V0w0aXR6d3I0L0J6bnFjbE9WcTBJMFVLQk5JTGRU?=
 =?utf-8?B?NWtTYUVrN3E5dEN3VW1sYjMrTWtDZmhna25laHRCK3hjSFFTdklQQkYxM0d6?=
 =?utf-8?B?SkxJSUQ4ZXN1Rk5zR1gza2VEOEdpa1NRbkJqT1k1Ui9kT2gwNEwvVTR6OFVI?=
 =?utf-8?B?NFZIc1k2L2dEN3AzYStTR2xpYjQ0NHI4cmR1eGZlNUpkM0pEMVJqV1ZOcXJ0?=
 =?utf-8?B?TE1ubTNsMlRxTFZoT2pCQzdQNHlyQ1JIY0Fqa2w1empkV3Q5TVRrZnJGUXpx?=
 =?utf-8?B?WXFHaThkdCtqTi9mL1lxOTV0QXVLVXBsWm4ySXRIdzI5QXg5dWdScGx4Q0dV?=
 =?utf-8?B?UGtOQ1NaQXhrMVpmRHBBejJCRzVzT0x5Z0czQWFRSUxuMWsxREFkTkZlT0t2?=
 =?utf-8?B?SjhZT3JOOU9EYUFNenJxdng2M0hKblFMdVdONm1RUndwcFFDU05pdkR4K0M0?=
 =?utf-8?B?SDdWMlRvd0R1dGtnakVBNThMb1hkaEE4ZmlQU1lWWWRJQWtPalVLd0pOMHJ1?=
 =?utf-8?B?UDREVnpHa1NjaklQUWJvcUp1Y282V2RFRkpKbWFmM3NDZzVzNTNqUVpyZWk4?=
 =?utf-8?B?ZE9ZMU55ZWVLMU5jRk4zb1lQZjZ5KzJsRDFrMXRZR3lsZG9sZE0zZ3Z0NGpZ?=
 =?utf-8?B?c21CTUhVNHdCSko5YjFiZjQvQnJVekxKUXp6cWo4N2hoZ1F6aWtEWks3Wk1M?=
 =?utf-8?B?dWJ6WDJTSGtUV0p6TlZrSTg4T3E2NkJnZmJnNkwwRXRZaEhtc0JIVmtWM2hM?=
 =?utf-8?B?aUhjN3BwVkZXSUV1cnhVY3pFUXE0L2JOOTgyeHZ4WFZDK3kvTy9rUXMwWVUr?=
 =?utf-8?B?NksrTFkyaEtZM0dwWUV4d0JUVUFKbmRCc0x5SE1Zc2JUdDBIN1ZXanIvT01j?=
 =?utf-8?B?VnhhNFpHWlBlZXdld3NrQnNBL1ZJYmFDVFp0OUhod2x1WEdrTWNhSjc5a3Zs?=
 =?utf-8?B?LzFKR2prNE5vOEE5Wlh6N3N3eXA4eHRnTkk0VWVQT3BOYVBXejA1eWZETHJi?=
 =?utf-8?B?ZERkZEx5dnZIS1hVT0hyYzVQYWgyWXhxa0lCalNrcVM1VmdmNVAyWjFhS3hn?=
 =?utf-8?B?NEwvbzUvM2FVR1k3ZlNPcTJpQW5hN3lQSGlVbEdEWUpLMHk1MmgrRDZVN1BK?=
 =?utf-8?B?akQyenNuOUdvOWo1VDRjVFFwa3JtVG96YTlvZ0JmN0w3bXlGaXFVdUV6N3Vl?=
 =?utf-8?B?Z0hEYVFsYXI4MEZoNE52NlU0MWk4S2J0Z21JTFowNVRId2FKbHpuRHBjMXpt?=
 =?utf-8?B?ZXhFWlB2MDJqM1ZWQXc5dHhwR3FaTVNqQlpDNzFqelhESUV6TEQ4cFpoekdU?=
 =?utf-8?B?NjJTS3pkRzZMdTRGZGpnS2dBYjZTQTZPSkQ3NEluQWl2elZWbGJjaHNpdFVn?=
 =?utf-8?B?dmhoMFBEUk9Oc0lDNjI0ZzNiZVJOYXJ0cnB2NUNHZGNaTlNybGo1M0Qvd2pT?=
 =?utf-8?B?a2FxZ1YrWFFRR0JUOXFzVWZ3TTJ4Y1RxaENkd1ZVeEJXV3FIbWdVTWhsUllU?=
 =?utf-8?B?NlkvdVBONUVwN1RjZ0F4aFYyTU9zZytUVC9WRnA3enNRTXpBeWcyV1U2d01h?=
 =?utf-8?B?ZFNoZW1WMTB2TXdLMlZVdnNsZnFubkFCWGF1UHRaUkhtT2xYbFVGaGNGTExa?=
 =?utf-8?B?Ym9kYnRGMVBMMEp4RmhGQ1dDMWIyWEp2d3dSVDl4RmJVZzN6N1JQWVBjQWFn?=
 =?utf-8?B?Q1doQ0R2SldKSUR0NTlzS3JTQVVrUFlYWmpnUm12cUgvanc4WXJtS1VMaVlF?=
 =?utf-8?B?ZEF6RGx6ZFVSZzkwUFpXZ0RVMVJqakV1MDJsRnJ6MmNEekVJeG9OcWlZYTBL?=
 =?utf-8?Q?4UuBFmJbPkG24XoQ=3D?=
X-Exchange-RoutingPolicyChecked: rGJcNNnKZKtq08len3zXhtvl5SF0MevXZchE1Vfp59C6JRjxCunpyagwCwqH8t/i7u0l8WSSFzWwtaAxVR41jsetXj2DZzEeWBrjNRcSRCnNKtPu7SUk5twZ8msmBAH0yWTd0THxzet04qOR+l0fGBKbo/8roBh/+XDwdxS9estvGlHSmpFVJweitIo3iwXykuTLIYN4nBBWchfdl782KojgbhGSXXsiW4e/riynSNQeWoI7kIyUnPJwZy1vljcE8apzJ4C1mrQ4wHgSfkGpI87eqrm9fcxkPV/Odyi1OD0QG7k/9lQfqA93eiPsHnWOAYlfwlWc8t1oEAXB4RbYNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcba7ef-bb5a-4add-33fc-08de7eee62f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:45:46.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQmLoqfOmke2Ks7mhOLlriUn36nIvq+c/wP5CC+1CiGE55eHQKpJ+74d0bB0U3ac4rw+6L0o8WWzntaz8Y7rIe1kPRp9xc4YVuGbcMTgdPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

smadhavan@ wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add pci_add_virtual_ext_cap_save_buffer() to allocate save buffers
> using virtual cap IDs (above PCI_EXT_CAP_ID_MAX) that don't require
> a real capability in config space.
> 
> The existing pci_add_ext_cap_save_buffer() cannot be used for
> CXL DVSEC state because it calls pci_find_saved_ext_cap()
> which searches for a matching capability in PCI config space.
> The CXL state saved here is a synthetic snapshot (DVSEC+HDM)
> and should not be tied to a real extended-cap instance. A
> virtual extended-cap save buffer API (cap IDs above
> PCI_EXT_CAP_ID_MAX) allows PCI to track this state without
> a backing config space capability.

I think this goes away if PCI core is not tasked with understand CXL
internals.
