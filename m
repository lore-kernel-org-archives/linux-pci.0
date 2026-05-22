Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65E3BB106;
	Fri, 22 May 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441099; cv=fail; b=sYWXFtmPg6ahlWWwLxfckvih+hgAIdq4qVOWlbiLNFAx/O7FQItjndYfU2GcPU1uGYdKqjmd++/v5Yi1bkh3hgsQxkcizZabxDTa9W80emvPIKzyWTDJOLL8l917XYWl+52/lnDoqP72ft84NSOZIQGocyrcApd0MwZhrpYnHcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441099; c=relaxed/simple;
	bh=cu7pjL0X60PyxkH6BXs+Db2VXgbN3x5Bp7gH/9ZKZ8M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYNXVGoVpq5Not80Yz1D3HOkQz+jS0BUPdGOaiU1xtah6wWVmBm5LP0ktFGTGdhNrNx/dH2K00/0eoTUhMpcEeN7FunEFv/0l2B+JJzpqUFZQcXezsuf2UIBtHObgopusnVlHRqgas5nmLZgvhETQ5TSA+JRzqx9QzcjajWtHcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecTgR1jQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecTgR1jQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779441094; x=1810977094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cu7pjL0X60PyxkH6BXs+Db2VXgbN3x5Bp7gH/9ZKZ8M=;
  b=ecTgR1jQLaCe5kr8YAAOWqATM91hsTpnFj68lw3rW1HAsZ61V/xzrUKo
   23gaFeMt2Es5tinSBTPWBS8KwKEBd7mEatnPhy18+fHijgLbDNrETZL12
   iSRzqQlmMghX/m4rZdVddQ0zk4ezlnviqRg0bf9NeuRDqo3J0otb2gjpl
   HuHnBSWfpqMJROQcjtrtjXlMBq9ZEGrkSx/5ZyL3FdOeSAIaDWBbZ42kg
   vHNtlBHRUbUENBfnQzokKhBWlS6yGiM8IfBmW5SzUBh36I3ndY5VJiMas
   CU5lA26z+HbmGjlVYD2P9xUWpGTTvxdaDv6cxLfW7+zhZAXMzMV2iV+Wd
   Q==;
X-CSE-ConnectionGUID: AUQv/WmEQ4y3xUhn5ALbqg==
X-CSE-MsgGUID: gOQqZqT7QDaKzcHXYtX71w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80099297"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80099297"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:11:30 -0700
X-CSE-ConnectionGUID: ToB5b6/EQzWl43vztXoUdg==
X-CSE-MsgGUID: VvJPSoGSQ3O2zjKPCJ2Dcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="244906187"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:11:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:11:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:11:29 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+t5XhS9FOY1E6XGch7/i/5NQbXjhMmIzsIY9xF8K3+VwGeGlCTSaodcdELXLIgMekApc//xGQV8tXbDsh0YXLoe2kWnd+arrBZJeRwB6tISsIvQR7K6PVHTb3Nl5euoDU0vu/z9OlMqGR5MP8gQOCiMSzdAjjfkSWRSkvdrcQjVw5M4A9uNmMP6bBTLVWWZaPYXAyXtHpTJVQ8+BSZJu3xWiXDo0Oedgta0u/ZLLu6vVOF+Q63r7QunMzET4L94V/lm75baa3w5vBdk4YB2SVTMJUgqQqjKhwW6m02RlieDxJayhLB4+t374/+/eIJ4jrjOeIQyLwmFJaZ3aF12Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeC0OBo/7oqWCjGrA7oYlKCTQtjNcO9qTtrWF12ZWvI=;
 b=DvDcF+Cz/egy36ErkN6T8IBdmspZ8E5svpKKHDLwC56gy5Z+85Te4fc1iBtYOzHZ89FGShELg3hB+N3ButBfea2CZvrSq0ZJB/ZOnNeuaO56khzm1gbx8/wTOZi+XXCWW7S6iQQu9gKgds3ety8LHn0uSd2hb3qvWF7mRQUZ9zh6n6BC1DT+iv4E6j3PMMqLivfF6pn9h9sHHTgKEu+OEFEkMVizPA+K9s7e/VsrlAlE2Cq+K/QaBb/yenhgqVxgvNo3nnPdLqjqvNFJ5XFgFSVsfuahj7YLthSVPz25T8Z7gZR+EKSxyBCCFUz16EHlLqvvlOTfBWtI9GFbAVv6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:11:26 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:11:26 +0000
Message-ID: <34b17d7b-04f2-494b-b44d-994c326e92d1@intel.com>
Date: Fri, 22 May 2026 17:19:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <05044d2113e20d81f96677ba53605311662b6b10.1779392420.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <05044d2113e20d81f96677ba53605311662b6b10.1779392420.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a83501-8503-43a1-4b46-08deb7e21a08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|7416014|376014|366016|56012099003|11063799006|22082099003|18002099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: 6ZCl7F5Mw72hrETqVFNUpiIzo6Xwtgwg4vkF1q6iKaCOJpj0gsPj5VmCdYg0ChPH3FzaCltMIvsGEgepKOPPM1t4oXubAq8PgSYpNUkVT8cxMRW1WdWHqPo1XcdPR13rVmrV0Offyvc4aelbieoBcUIysbHyhcnc093NetDWvjJx1ZyqJr5WAJPDtFMaMxssCzXBUEKTgxjwm0+G7KhnYlUMr+0S9aZ+IwiW6kBMIUswKBk65xMiv/sIS8iHNS6QfZg4FtFfbsAN4KetWW9L2ybI/5d0CNIWKYvTy90Js+806Jgh0p44CZEwv92+WkHAvmEznB0kyp8f/nTxuqucucLIl8OIjrOjwVfopS408BvY7j/6OqPrjc1FZC7VGO5hlIlzxCzVZBw5Apy2C+bOROhYVYELIaZXaTDa/aSqgCfnq+TxX3a3OyWZ3Ob2kfxV77beyNJa6GY1zZOPsy65wmXoJJ8URpDKh4Tj68jzFGA3tTc+sdovzKnVCNZ5TZN7e7SmtEwVSF1u0rGgzoERt8tfD703mLJRUCIr40N3c/TeMCSUDxCLIx7tX3B5fh6QaVMhsZXATQimcNqDcncC2VPx0x1rl+XMeiibBFs5kg/yovy5JuQaWLoEjOUOhZKxgpHpxDfZ7taA5w2T/zElzzpSACVP8xYC6rrLxnmF6LL7NdEu15KhuQbcrdiIqMUF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZTMXl5d2JIbk00UlcwOXNUSWJwcFdlWUFBejFJR3FVYzJKNFRpbSttck5R?=
 =?utf-8?B?bERTS3pQekJFQnJjaXpxTEdZOVdLbDJBSTJkZEcxc1d3ZGdwdENYSlAycDd4?=
 =?utf-8?B?NUF6RE9qWXFubURjc1ZnUUtWRjkvaUYwWlMrenY3aHR4QlQ1azJYNGc2NnJZ?=
 =?utf-8?B?UXM0d1kwQi9rNEN2TVg2VUxoTFFzVEpDeEU4andzVFhhTXN3L1BnSUlxRHNt?=
 =?utf-8?B?NVFpYUcvWjZTYzd5dnRMbkxlUUtlLy9uMXFnSE1BVmF2dFpDY3hQdVN0Rll2?=
 =?utf-8?B?NkZDOUhiU0dVNDJjL0NuRnAzN0JwSUxwalNxVTFod3d6b1RvRklpMVRuU2ls?=
 =?utf-8?B?dldUeTdqbEhzRllLVWt5bUpXT2VYUG5vRStmS1VKOFBNN0lnQkY4RkpZc0gv?=
 =?utf-8?B?Q2dXMzQwNk92aU4wb01KYlAwRk54OWlLMXFuWW9WVGcza0xXcFY5RHhub3NL?=
 =?utf-8?B?aGE4cktMVUY4b014NWVFOWFNWC9VODZ2SkhVMkJ4cTFPWWVMOTVWdG1zUVpK?=
 =?utf-8?B?V0FDdU9zUmxtU2EzcGVObWlueHRFZ0xpcE5CYkQrcEh1VzBIREowRXRlT3NT?=
 =?utf-8?B?aS9Wc0tVbitQU2tLTmNXcGhJZlcvbndXVUVUNW90V2NxaloyMlFreUFKMXpB?=
 =?utf-8?B?RkUwUjI0THlYa3dvbDVjSVVaZGZpb2lZK29rbWtEU3R0Wmg1YTN4REt2Z2xD?=
 =?utf-8?B?TE5xa2ZhU3RBbk1UajhUNzB2KytoQlc1dlBBVytJQktIcVkraG5UaDJCZUFx?=
 =?utf-8?B?MHYvTkRhbkNUbmpzSGxSTno2ZWZ1c1Zlem0vQzRnL3djTXVTMTNXMFk4NmNr?=
 =?utf-8?B?cHhzKzh5OHBTRHR2c0ptK040OWFQQXpvNVM5Zy80eGFzYWdvbjNnanh5ck1j?=
 =?utf-8?B?eGd3Y2lTSDJWKzFBejl4aGRJanZLMFhGTks4S1llTjJJa0dnY05SUlJnL085?=
 =?utf-8?B?SzF2ME1keXJjSHBhSUlVK1NyemJweTJYano1UXE2VGsvWWg1VW9aTVlwcG5Q?=
 =?utf-8?B?Z0xiN0c0RVBQUGUrcFRYb3JsVytEaW1YNjhiQkRHVTltdkI3VHF3REtnMWJq?=
 =?utf-8?B?My91TFJmbHpvMTREQzRleXp6aldKeDVVL2l6c28xNERXcVBOVkhtMUhVcHFZ?=
 =?utf-8?B?cUd4dVMvWlp6WU9BVXp6OU9PQmMzMUhrUExuaS9YVWJKNy9NN0NhZTl2Nk5i?=
 =?utf-8?B?TDNTaWVIaE81ZEJKWGJWcW9CUFNhaFRSL242SktRWk1QWlV6TGxBZzAzTW9o?=
 =?utf-8?B?TDZWcHFFeUFhUnBxN0pTb20ram4yd0pZOVI3cjBRTkdyQ0pGWisxdUVScDdi?=
 =?utf-8?B?L29VS2dhc3BEOXlVbHdzSDZlZWx2OUtCNk05VUh3UTBrb0N4SUZWb2JYcnJt?=
 =?utf-8?B?MTZrWHVBTW83MW94amVXanNYTldHdmNNSG1nNmJFTkVreHlZZE5QVTNaQytN?=
 =?utf-8?B?S2VGR3AxczVpaXB2QlUrMVd2dFV3aldaMlltV0lObUZ4Qi9WK0FxSWdUdjgv?=
 =?utf-8?B?UU5Jb0kvN01wS2pCWWZkV0ZNN3NRVmRYS2ZNNEJteXVIUEFvSy9zRmxXbXhy?=
 =?utf-8?B?WmRxNlByNWJpVlorWnNsZ0ZLNXNPTWo0NkJodWFmS0lzWlJjWG1uYy9BZEw3?=
 =?utf-8?B?RmdHaG95VGtiamNIdC9VcXFsd3RYL3RBUENQMG1uTE5nMEpjUTBDQ1A2NW1Z?=
 =?utf-8?B?YytvM3Z3Q3JzQi96bE5aeWhMZEpPendZcUNQRU9FUEdhcVdJbUhPZmt2RW1i?=
 =?utf-8?B?SGdTMWZTdmZXUzBMcjVnRkRXay8xY3lkQ1Zoa1ZSRHNBWGt0VFd2M2FSeFhn?=
 =?utf-8?B?UlJSZEtzZ3htUE1Ea0FKdkRjOU9PRjJzcU90T1poLzFIK1RUeXUyK2VLTzdM?=
 =?utf-8?B?T3VHUGRuU1pwUDdYVW9aSWI1ZkJrVjIxSTl5RUpFM0NzTHpSd09kZDhqZkla?=
 =?utf-8?B?anpjcU1rZDhkSVN6ckU0c2dmTGNEZ2RGUG44b0Y2WmQrYlFOTTFFdlVSMGZz?=
 =?utf-8?B?bEZWNVBTbmVuYUdiV1RTN1YvaTNaMU0wY2FnNmpmWHR6bFJEYk1ETDNWNXpK?=
 =?utf-8?B?UnZnSS84MFgyN013bXZCYlZPTTlKT29xbW1pck9NWWFkYmJZV3RVemswSW4z?=
 =?utf-8?B?UVZSWUxLRnA1ZHV6UGFwUlJjdEl0S1UvUDU2R0ZJN0pGVWZ5bm5sR2dqa2U0?=
 =?utf-8?B?MWZEeGNMc2hVTVo1SXNVMW5SUHFuWUlBZVR4T1BibC9wUzJSWjBrcUZzWURJ?=
 =?utf-8?B?MGFUT0o5ZEpSVmJ3TDZGZjZneVNUSWJ0NFgwaGxJU2h2RzBWVXduMy80MUJv?=
 =?utf-8?B?c0psSHNCQ1U5VVlmZnhUMFhIbk9oc2lwL1FVeEQvbWRZSEVyVGFFUT09?=
X-Exchange-RoutingPolicyChecked: GJlSZCegd9D0Ul3tEVF78RJYQjHWetj+ZNgSuQkchtiShfcvcTMCSbbkdC+CVtEvogfsayDUKYH+IXBEAUTdr1XaitAxh1cT6rRD6MO7vo3wxpFrU+ro+mxlUdWKoibj4N9Mspd633L63MxLy8idLjOUy4p6p1bVOOn66lfJA5lD+8aatqZehwJN1bkcOXCQciVD4xod/DTlwM9os5yu5v9knBuSepBr1voKeKVJprAK0RtesGsNeIOTdxWTwc7mRI/xbx3NnWZulKoKeFH9X1HhV+OrL85uWYG5mJuTs7gAVkcwMGl8mwulK7EXJJ6Q4zHfl14Q/vEW2g2Eyx5AfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a83501-8503-43a1-4b46-08deb7e21a08
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:11:26.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JnhBpEOW+Wpr7lp4CgVRClHvkQgyretNNE9Y669o4YFFn/ShVfklJ/kc11M5n1DqaWDYcEgbrt6lbh/cIHtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 5/22/26 04:34, Nicolin Chen wrote:
> Controlled by IOMMU drivers, ATS can be enabled "on demand", when a given
> PASID on a device is attached to an I/O page table. This is working, even
> when a device has no translation on its RID (i.e., RID is IOMMU bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "ATS always on" in IOMMU term.
> 
> For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
>   "To source requests on CXL.cache, devices need to get the Host Physical
>    Address (HPA) from the Host by means of an ATS request on CXL.io."
> 
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_required() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_required() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
> 
> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   include/linux/pci-ats.h       |  3 +++
>   include/uapi/linux/pci_regs.h |  1 +
>   drivers/pci/ats.c             | 46 +++++++++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 75c6c86cf09dc..f3723b6861294 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
>   void pci_disable_ats(struct pci_dev *dev);
>   int pci_ats_queue_depth(struct pci_dev *dev);
>   int pci_ats_page_aligned(struct pci_dev *dev);
> +bool pci_ats_required(struct pci_dev *dev);
>   #else /* CONFIG_PCI_ATS */
>   static inline bool pci_ats_supported(struct pci_dev *d)
>   { return false; }
> @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
>   { return -ENODEV; }
>   static inline int pci_ats_page_aligned(struct pci_dev *dev)
>   { return 0; }
> +static inline bool pci_ats_required(struct pci_dev *dev)
> +{ return false; }
>   #endif /* CONFIG_PCI_ATS */
>   
>   #ifdef CONFIG_PCI_PRI
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350d..6ac45be1008b8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>   /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>   #define PCI_DVSEC_CXL_DEVICE				0
>   #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9c..84cd06d74fc9c 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,52 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other words, CXL.cache devices cannot access host physical memory without
> + * ATS.
> + *
> + * Check Cache_Capable instead of Cache_Enable because CXL.cache may be enabled
> + * after the caller uses this to make its ATS decision.
> + */
> +static bool pci_cxl_ats_required(struct pci_dev *pdev)
> +{
> +	int offset;
> +	u16 cap;
> +
> +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!offset)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> +}
> +
> +/**
> + * pci_ats_required - Whether the PCI device requires ATS
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires ATS for basic functional operation.
> + */
> +bool pci_ats_required(struct pci_dev *pdev)
> +{
> +	if (!pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_required(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_required);
> +
>   #ifdef CONFIG_PCI_PRI
>   void pci_pri_init(struct pci_dev *pdev)
>   {

