Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB22F25E2
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753668; cv=fail; b=VCT1NoAOzeorlORP8EUTui04bLVKYYvx1wdcEfWK8zWUEF3fZ/qKvlQ6dZpAMhDsE1MpJL3nhn4+5CMbBCH7k33aEEEytHNLrkpY1NfHKE6EleligCuvk+s+7GbFGjWvmk8/L2hiNh2agk4lzFtEMmB1MqHwwQWy69MBQxCWgF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753668; c=relaxed/simple;
	bh=Q0zKbwYHCx0Teo2sDzDtKkUBQW0d6o5CGKt5kT+grJg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=boZr7pee18wnPIP1xoqWvW6Glkm7Z6+9fdL8d4cFQBurCZz8GzXtIcpC1oABnv75F12fiXj5HhZvIFpGMsyQFJA8u9+GbTRg4gKAg4/hEARSfMCOnWv6mZimQ3UXay4zqvIId3Gv9R5lYG07SnOAutcSgkpN416dW+HgmfRNAQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FteGHtT2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FteGHtT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770753667; x=1802289667;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Q0zKbwYHCx0Teo2sDzDtKkUBQW0d6o5CGKt5kT+grJg=;
  b=FteGHtT2zTLsu8VQPctDoWanY2HhRNkZ5luIFQiCd3BQeJHIvtnrb2tb
   gKboNkiK5NjhUlX3413QM050VX8FHG2rz4mstKwhVzSe0R3Tk4ImK8A38
   iEReaFbf3rSxVuot3yEdMU85ruqLOXjUTP9su//VHQ5utEEq5yGDWglSm
   qyZAYHE4r6ayFYltBojl+tOcvLILUz+higDFJPrnlM/wXD3EQOASinQN8
   q71o0a0t+4vLYK8aFB40qZpyVl7xXqkANxHgBB1ATmWH7AQLgCfSRy7rC
   1/E/gMLCEbuFUwqlipSYAd/2KEu/ioBxavVAuaKxHU1S/yZv+5RyCTB7U
   w==;
X-CSE-ConnectionGUID: oqaEF0dhSTiEFABeMpFmIg==
X-CSE-MsgGUID: IS00khfSRN2BbAWi7Y007g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75521175"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75521175"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:01:06 -0800
X-CSE-ConnectionGUID: ztf9vQlASmOMnItZR4b1Uw==
X-CSE-MsgGUID: U0qEZI4TQrma85wf+f5jug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211851286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:01:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:01:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 12:01:06 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJEreSdvFIQW49AkbcX6EqAl/kqYnNlpU+rtNpmr+EdCDFilthmHL651iWPtd63EiH6Jcv5jjrL2ZuXGWtc5OUihATRitfbunWh6VZG1JohJxW8XmLHgQYjoBYWWBL4R0Q4lDK8reBPPVhuu8Ty6q1mAVndFxRHI0E5Vt1OeYMUIEh6Dr3vxsKTTsW2KwK6csaJcDDbQwd8Tz9N1ieMtrhvTtiWCqI7JpqWjx7S6O24g830nvPUoBmLtM70FTlgaAL9/5TlfjXvjM+tSIULuDzRcwhXc3VDLiCKzNCSHKwi/5X2Zzp9kl0NRjVSD51vUPTjqswL4ysJpTjmaAzjf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc5ZJb+Du7sHjhyp2aFhUKOF3V1a239db3KikJcLd4o=;
 b=O3P6fQf6QoOg9oJkCPzkSmYsk431U9QJYamYwgjZ6xpeNIlVuMrU0tcR7YwMiIlHnR7CrWUOOqxS8i2k1JlLroOtDyodBxvh3v83oQXlGe0/3yywyx+16HOv0P0VfL9YxkQcr94CeRU/KlL3duejq70dAMe+e7WwnmmgDoODNzKe4xFJlRv5IyWnlgC5qFVhMfIEIdWWmkwd5MoGoI+n2Wo5/AdkZg9cKxgqyXHjgIndLjq+XdsJt8e2Tcd+szkCxxXmWRL9YhGsNFVXske4jLXQb5PXmMeTuAmy78bMW3gKUt/NTTAabALL9pr7Y0RBmP0QOVOVdt97MNQgMytKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 20:00:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 20:00:59 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 12:00:56 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <698b8e7894eb4_2e5710078@dwillia2-mobl4.notmuch>
In-Reply-To: <20260205212533.1512153-3-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-3-kbusch@meta.com>
Subject: Re: [PATCHv3 2/4] pci: allow all bus devices to use the same slot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 365d8866-8470-4ae4-3eb9-08de68df1bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDlhaXpnRGhlcXgzcTkwTzEwZHFJU1hVK2l3cE9FQnMvdUtIZUl5MXdBRUIr?=
 =?utf-8?B?TitTNW8xQUMrTWhDSm0xN3ZoeEtrZE9xWkJ3ZExsY1BNL3JGWTRnU0RrR1pH?=
 =?utf-8?B?VjBEVDR6aThvSElvZ21RVzlFVWtOK3pXVXdxbEJJbXlRM0lXQ1Z6VlJsLzAr?=
 =?utf-8?B?eDRkSS9mZk5ybEhjU1kvQnFaR0RDNTZwQ01wdy93WEhyMGd1RjR3V05Idkhk?=
 =?utf-8?B?ZG1mQm1jVysyTldJWmJxVzhQTFpEWHd5QmoxMDBwdmhDZVlKQndYbmtJSWJ2?=
 =?utf-8?B?NndhMSsvd3N1a0ZEYUZJbHk3THNQWWQ5ZHBzcXlQS2dtMEkyeU5mdTJpTG0x?=
 =?utf-8?B?OVdEd0Qwd2NPd3hWSFMxWlRtRFZ1dGE2TGQzSmZMQzhpNHlpZ1dkcUhJWldw?=
 =?utf-8?B?WkVWT3BJcUxIb1dnRGtNb1hIZlJFM09KY3RrekNlTERaTVdheHhsS2JicVFp?=
 =?utf-8?B?MXFCSG41cFFubTk3Q3dkOGJFRFk1S2d2VU1TZmR0VjdLMHlzeGE3QTA5a1N3?=
 =?utf-8?B?SzUvWHB4QSt2dHI3WWNFRGZyaXRnZ1pBNVpaR3c4c21MSE12WjIwWXR3SjZ0?=
 =?utf-8?B?ZkF1WjBLdWUzcnpxeTBlUGxjMzR2dkxBZEJZS21EMzh3bmxRYXR0VGRrVUhZ?=
 =?utf-8?B?bWEyNXM2anFyMHdUcjdFSVZoczQ4d2x6ZVA0QWRXcy9uQ0NRZHFXcVBlZHdD?=
 =?utf-8?B?d3RmcFRRaDBGZGdLbU9aZDUwQkdUQllWQzFyUi9jVzJoNkJMZHVjTzJuSkc3?=
 =?utf-8?B?WXJjQ1pkem92NHlOZ1MxODVzbnRKN0RmUC9CM1YyeU9ZVGh2N0gzQUIwUVRW?=
 =?utf-8?B?Rk1TSXJUL2JHRjRxRE5VcUY3NGNjb0RGUVNMaDJwVjhuOGtRTUczMFF6MVRV?=
 =?utf-8?B?dGs4dDRLMjdHRzcxU2NpZXh4bkdUc3c4ZFczYm5tMmczUUZNSjBYZHVqR1Vk?=
 =?utf-8?B?UHpZaWh0MnlWbjJ3ZzBvbVozMERQQ0V0d3BrTmhSUHppbjQ4bWdNOGE2ZU9I?=
 =?utf-8?B?UGNiUEtEWk4yTHZPYlJXNFV5VnpFWTEweVVENGE2U3FFdnNXWE5MVGhYQzJl?=
 =?utf-8?B?Y3dJZmpsa1lBNDBUaDRIWjV6ZnZQQVEza3JUM3VrY09ub3dISlBGZ0lBck8x?=
 =?utf-8?B?NW9BRkpwK2s3dll6VDN0cjhXVmtncmNXUUN1U09ZYW16WjlJYTJqc3d6dkZo?=
 =?utf-8?B?R2pubzNPVlczOGFIbVFCTWRPa1VHYktKSHRyVVZUNUJUcEhFbFQxd1pWcmVw?=
 =?utf-8?B?SU9pdFN0NWtlMUVqQVRzQTVTQ2p2b29rSDJBcWM1MTJEclZKUVdpeWd4WFJr?=
 =?utf-8?B?L1Q4MmhZU1orUmNXVlNnSWdVRFVUbFY4T0tiYnZWRWFTM2RKcnlnRFpEQXFw?=
 =?utf-8?B?V2NsM2RNV0JyNXJqeDFmRXg3Z1YvUFlKTktyK2o0ZldJNFovZWt5bGxIbDZn?=
 =?utf-8?B?WlFGUy84cTdGdFhRTTN2Q1dFbHZGRXBFTVRWRWtEREMxN3U2aURJYVIydDJt?=
 =?utf-8?B?Z3pGS0QrK3hhSHNxSEdWUGlodFZrdytPRDRmTWowbUpDZ3hGdGNaWVEvTFVk?=
 =?utf-8?B?VE1kWS8zd2dWc2NOdmdyVUdzeTNwTTJIclJxNm1yN2ZnaEc5V0ZBWjJvM0ZY?=
 =?utf-8?B?SFNnYWdxZXJheldpYTVJYVhYSlRId0dvdldzMDNLb3B4cmNPeXZPZDI1NlIv?=
 =?utf-8?B?S1R0TnpUNFNncE9YcllGVUkva1Q3UFJxaWhtcnNaTWltbmpTczJPdkRUTkRz?=
 =?utf-8?B?RUJQTlVRUFEvOWpEUXhOL1ZVdmJFRWFRYStQZ2ViT1JrRTAreGNJMU9EU05o?=
 =?utf-8?B?SkxVcWNZdzlwVDhDdTREMXlUOGxZekYwNXdOcWt2ak5HVnpKclpTRGNrLzRq?=
 =?utf-8?B?TS9iMExJNTEvR0x6eHJ4eUJNWExEemdmdEo3Qk94OVJNaThvRnRiODZiTHY3?=
 =?utf-8?B?U0dIQWt2RHFNck9kcExISDMvV0RqcDdOT200VzJWT1FuUXJVOW05ZHZiNG1x?=
 =?utf-8?B?cERsTlZyMEg5SzdSUUhRa3J2aFZqUitWK3dERW5Rd3VNNmw3V3RMajFvelUz?=
 =?utf-8?B?UlplQUVVbEg2aG9TcDE5ZmVHa3VKNlc3VXQ2RkV3M1ZnSnhXYTYzandZVSs4?=
 =?utf-8?Q?nJAE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVHMTRYZ0dvSTJ4QnY4ZVBVelBRYjdxMW41Vm9MQmJkbUY4YlBtSzdncGsx?=
 =?utf-8?B?UjdXcnZsWldkVGowYWJTanVBYVN3dWxvUDlFaGdTdlFUMDByZmJuWWJHSmFM?=
 =?utf-8?B?MkdZWlQwc1lmeDN0MUs1eXpFYXpqbnVhbkFxdHcrRnlnajlEZEtvVVArSnNX?=
 =?utf-8?B?ajBSdGx4ZGo1Y3lxZEkxdllRVk5wc1FzRkV0K3k5SXp0TmJGT1JPZFdhMTQr?=
 =?utf-8?B?QVVjbVlPcisvUTljZ21OZWM5eVpuNzI3M1F6NkJ5TzJSUUFmUGVOTlR6K3Ey?=
 =?utf-8?B?SkF1cExsTVJvWjlDWlhoRjFKUUZEYkxDNFovRWlkdFpXS1N6eU5iSUF4dzB2?=
 =?utf-8?B?T2Y3TzRwa3U2S0NYVG1tLzVhT3dPRmVITUFrNGJ4ckxGUFY4SmRFRXZCbVVp?=
 =?utf-8?B?d2Y1V2dIdzhTa20xaUl6NEFrMERqdFpFQkQ4ZFBHNlJjZ3U0dVNKa2NCU0VC?=
 =?utf-8?B?YWhZa1Q1dUg2VWt0a0k0NGVqa2sxbFZ0d3JJMWt6Wlp4N0doNTJjSTdYMngy?=
 =?utf-8?B?dno2Y254WSt6S3dycmhDTGRnMVhld0JqbHNnWDhWZyswdXhhOENIeEFUYUJ4?=
 =?utf-8?B?WDV0TkZlRmdkT1NISi9aNXZxMVQvZGNpTWZET3NYMGo2a3VkNit6YmxwTWJO?=
 =?utf-8?B?MURzRnRmZ3RXK3hSTUt2eFpNRnloUUtLbVJXWkJrZXJGb2pSeTE2THJmSko3?=
 =?utf-8?B?MzNZaFJTVTlRNEFjQWliUUpkZHRwamVYdEVZOXVlcXg5T2UyQnJXdWRkVHUy?=
 =?utf-8?B?NzBjREdKOVY1MHlrSGlFTlFlWk1mTUg0VFBPV21qaHZwN29iRGdFTzNCcnRT?=
 =?utf-8?B?UEFDYjdGZGxTRHBud0YxNFJKeDUyUVJKMVdNamRzdlRxS0o1TzJlQkNiZ3ho?=
 =?utf-8?B?ZC9sRVJmVEd4MmFhcDI2cm43d2Y5Y0c5T1BFeXJZT0pSZ0ZGUnd2dmFyYjJL?=
 =?utf-8?B?bVd2SUJ2QjBjaFBvUmlteWRhd1ZEQmtEOEdROTkyemJERjdTc2o4bW05LzMw?=
 =?utf-8?B?OWI0RTJnWnNtZEdPMTJkbWwzSFlFSDI5UFlPNWFDTHhxVmlHdUY2Q2lzcVAr?=
 =?utf-8?B?bkhNSHJDQ2xMQ1NKWVFwRG1OY2t0RjFJOUx5VDFhMkNQQm1WZjNTT2R1ZmNF?=
 =?utf-8?B?dy9nNUkvTVRzaEVPMDBVemlWSElTZXVKVVRSejRuRDVCdVFsVGU4YWttcFJx?=
 =?utf-8?B?RHZJZDJKVEVTdDFnV0pJZ1BRc0ltcmNBNmxqUGhkdUhzeWpVSkhWUnJnTmVG?=
 =?utf-8?B?WllDcjVzVDc5c1VWUTNialZrY2VtSE1mL1lrYm9KV1lNbFBScFFaNWRkNk9I?=
 =?utf-8?B?eGE5bG5lbTBjZ2xIT2w2OHhKc1lKakYvc2drVFZhUDBTU2tOZDNETmdvT2pH?=
 =?utf-8?B?alE0MHUxcHBtOEMwV1FUL0RsWXprRjVaTjRnYk41ZC91VjFrYWVNOHZGQkw0?=
 =?utf-8?B?VzlTNk9FQnhkdWQ1cm16NzZsTldUN2g3WGN1OUlOZ21HREMyQjdJUGd3cnRS?=
 =?utf-8?B?NUJrOXhUQ0FYU2FXRURCRldOWEFYL2s4clFXSVp2N0xYTm5xY3g0d2ZvWFR2?=
 =?utf-8?B?S1VERjZSTmJ1dUZzbjBNOStsTWpnbk9pVUQ3SHhyTnZqSWNrNWpSNTlZZkF0?=
 =?utf-8?B?bXBBY3FtRDh5cUR2VjlMdGQ0OWtGRU92RkFuMVQ4UlNscUVYajBrNWNzaytY?=
 =?utf-8?B?aFBsd0dMdDdjOEhJZVdTMHBPb1FiV21EcU5EeEczRVJBQXhqelVJaG55L1Vu?=
 =?utf-8?B?cnBnN3RNOFVUeVJGZys2QS9vWnVKV2FUMmd2ak5BYTZzWVl3MXNUNkZray9l?=
 =?utf-8?B?K2FDKy9yVmQ5bjd2c042UzF6L1l1UXBqb2JCaTVuY2crbWNIVDhIY2o0MXFs?=
 =?utf-8?B?bkNLZ2pxQVNPc3RmbkhLS3NMYSszNm5sVVpHb0I5M09DWUR3cExTMGsvWDg3?=
 =?utf-8?B?UGFvQkhnbTV4QVd0d3ZUczIvWURqVWRCajRNUzIvcGNyRUYyYWVVc1drTU56?=
 =?utf-8?B?blY4SjRqMy93RjNSbmdxdVZxREhlc1M2MWNDNG5PL0Fod2VpWE42T1RuYmJI?=
 =?utf-8?B?aUFIcEpmVldMbk5Gc3F2TGV1TWpyZTZPcWFVelU5dnZCbnY1YkE0UHZWN2NC?=
 =?utf-8?B?czVkUkpkaWVMcTB1TlhiSFl0ejdVNVNpRjJXdURzdmtzS2NWYXJVbWRkbW5F?=
 =?utf-8?B?SmwvUzF3c3NhWFVKcW1aZ2V6RGl6VE5zK0tOOWZFZWQ3QU9xUGFsZkl0UC9x?=
 =?utf-8?B?NmpFUmFVQ2hjR1dub0ZyZWNzS0kwMjdGTUgwR21VZXB3NlI1cXozS0c2LzRE?=
 =?utf-8?B?WWh3eTRneTUvVDdQQnZUS1NuOFR5MjFNOTJhS1ZPaE41MjdDODlDYi9zSGFP?=
 =?utf-8?Q?qPBaHApPp/T5Uf8g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 365d8866-8470-4ae4-3eb9-08de68df1bde
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 20:00:58.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh1VBTaInnD4ucGq5CjGU3cLyWhpeYzF4pGHVsJp33j+qB8jGdKTQBwplqDVUMaJPySJ+FELWnzOVv07mXf9SK8ZX9Dc3OJ+Vcv7oRcj93o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A pcie hot plug slot applies to the entire subordinate bus. Thus, pciehp
> only allocates a single hotplug slot for the bridge to that bus. The pci
> slot, though, would only match to functions on device 0, meaning any
> other device beyond that are not matched to any slot even though they
> all share the same slot.
> 
> Allow a slot to be created to claim all devices on a bus, not just a
> matching device. This is done by introducing a sential value, named

s/sential/sentinel/

> PCI_SLOT_ALL_DEVICES, which then has the pci slot match to any device on
> the bus. This fixes walking the slot's device list for ports that don't
> have device specific slots.
> 
> Since 0xff already has special meaning, the chose sentinal value for

s/sentinal/sentinel/

> this new feature is 0xfe. This will not clash with any actual slot
> number since they are limited to 5 bits.

Can you say a bit more about why other hotplug controller drivers can
continue to get away with a single device number as a hotplug slot
target?  For example, would you expect that the ACPI hotplug driver is
broken if an ARI device is added?

It looks like the goal of this sentinel is to turn all
pci_try_reset_slot() into pci_try_reset_bus() only for the native PCIe
hotplug controller, or did I miss a detail?

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_core.c |  3 ++-
>  drivers/pci/slot.c                | 22 ++++++++++++++++++----
>  include/linux/pci.h               |  8 +++++++-
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index f59baa9129709..d80346d567049 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -79,7 +79,8 @@ static int init_slot(struct controller *ctrl)
>  	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
>  
>  	retval = pci_hp_initialize(&ctrl->hotplug_slot,
> -				   ctrl->pcie->port->subordinate, 0, name);
> +				   ctrl->pcie->port->subordinate,
> +				   PCI_SLOT_ALL_DEVICES, name);
>  	if (retval) {
>  		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
>  		kfree(ops);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 50fb3eb595fe6..647f6d2cceef6 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -41,6 +41,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  		return sysfs_emit(buf, "%04x:%02x\n",
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);
> +	if (slot->number == PCI_SLOT_ALL_DEVICES)
> +		return sysfs_emit(buf, "%04x:%02x:00\n",
> +				  pci_domain_nr(slot->bus),
> +				  slot->bus->number);

Why not treat the PCI_SLOT_ALL_DEVICES case the same as the 0xff case?

>  
>  	return sysfs_emit(buf, "%04x:%02x:%02x\n",
>  			  pci_domain_nr(slot->bus),
> @@ -73,7 +77,8 @@ static void pci_slot_release(struct kobject *kobj)
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list)
> -		if (PCI_SLOT(dev->devfn) == slot->number)
> +		if (slot->number == PCI_SLOT_ALL_DEVICES ||
> +		    PCI_SLOT(dev->devfn) == slot->number)

Maybe add a pci_slot_matches() helper for this pattern?
