Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794985741;
	b=19zt9yPJXv6At/ozKPCYr1pTs2gnrZhkGIfnkUg/xjMGO0UOebobPNSCxlVvd6/KTFIx
	 XcbyZzka2V9XQBzn1te7EjfE9JJZ4Jkp8FqCQKr6wQuqmfrjmkH2lj8v3FInkwzQF9krA
	 GQ1Wq6aE1DpMdUdZtiikgcpBRgeExqUbXGywpcJoqDMFlAOfuAknnoTa/IsbHCmbyGizM
	 O145+FXs7fs7KnGyhD56CS17oJWajC06HRKAMMsh2BJd7tt8SB8mJggqsllwbMDCEHswJ
	 HtYuLwLPNFCneOv78MzcctKGRu/ylh7DU6zrsZVpBxdkgD/zrtcGGSMIeUHQppTH19w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985741;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=n8D2GhOUGbV/w3JPRNOsS2CmuLLhXG1/PfqNodNcNv8=;
	b=I108WmM9m/o2IPlS5DKlKAkaCUBGhXK8IcmWK/+x9pYGBDIalJ+mu5AGqRnXQXzcb/B2
	 jcc4sSiZyQ5bLurnRJHKlRi32eG5WGLmXe9dVuksp/fr0NJGRehqQy3nCgvy6YYjFguAr
	 D9hveQ6QVjUofWS9hZI4BI3foZZ9W8Vg/5lNJc6OAoFsfdQmBg/K5Co+R0QgS29ckbFdN
	 kkIITvDoDyfpLED36gggCntrTAwp2SA/aWakGbzAuYOMVxljowEUQYyPnLUjr9O9eoLJv
	 BujzUzWIChwXgptnKHWZnEkcma1fJJ9WxqKV1kSmTG7WNNJWHB+2wdTkC1BlsHsNqPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHX8WGzF;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=J+599bfS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE1606A333;
	Wed, 18 Nov 2026 07:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCE1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZHX8WGzF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=J+599bfS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794985741; x=1826521741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d/SjFiEnxuvz+7hAkWdWw2FkOmdCQoArkZMma9kmmpw=;
  b=ZHX8WGzF9QUCk4W8G+pBOl/gowSjAfbLPb/+ZLEBdIGpb7GqVwCrfA7b
   CDmhPUg6Qx1s+BiFGNcZuH/hN6Xcew9edw79ZOhHfYLrUKWMyjxgiqDwq
   Tz4f/mQZTm11oClXOcm/OLNbKhQK7Qt2Sgm+NrQ/+s7EaI2LxoD3G4PJh
   wL91PwIPXFseLxVI2o1fnqQjvlRGuDwdvb3xtSKtwv+nD7M1N8v5IDF4W
   mAf7llnn0PZX5eAiusB2LPOXm17ees1n1AFfvZzE/3a0GE8JChEnwbKKK
   wDszxVLIxO3ZizSDnBWlE9u3h/C0gjfD3auZhPISGs1spNpM/zmeV5dSZ
   w==;
X-CSE-ConnectionGUID: 5jfqsuoFRQ2bHtUwmZ2KOg==
X-CSE-MsgGUID: sjKUaTwWQkG5j0QhhXEC8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3808264"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3808264"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:09:00 -0800
X-CSE-ConnectionGUID: JByLWf77RMWDmtV42sa3/Q==
X-CSE-MsgGUID: 2tJRcFZeQF2twoYfkDc3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11779732"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:08:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:08:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 23:08:59 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:08:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u29YUrbq8RBz2NlACdUU6JULsAC1Vv1PjYRMpj5RFUeXugokenWQVz1exrgC7TccvObLOVzn/C690RHEOSF4OTRyH7S8TQ4wGgubl8hT9Ptgm647nFsiMqBakIDrv8wT/r4FEFaqc+3YTGTuAT+rhpJr9FMx6NjtdYE38jYKAm59lsj0eChEGZPLclELY7k/gqJ56v2BgDH4/4ZUZxGVeSxn9DIzyvFR5ooESzztZQekVDk/QWvBccRB6U8HgCo6lD3NS2ThvFb61668cCEaWJ14Nn98wBzusdIlScUAKw+F65uVM35p4Vx49nG2hPKaUCEgVznnViqTd8cskNe96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8D2GhOUGbV/w3JPRNOsS2CmuLLhXG1/PfqNodNcNv8=;
 b=dRli6V8V6SEyysIMVHzwcX97tnE8H1cr9u7M2LD0U2WuAL2Hbg3YB9HkBrXT0Upkgtkfcchvx0ZuLouWu7OAJ0VnFHepz6/625aCDxI2BsrAti+NeQEIzlPE2OCC/tweEyW0pXwSXmeEqSevP0J9T53qOYBttk31T5NPXYenNDYA/G+r7Mdw1qcpTZqshGimXcdY+UaRN91LMHm7lyp0n1gdzi/lMk3y5AesVtkt1bH/6CFfVrcQvIvYdwbN7Ii3IHrBz/4qoJTNLgdmI2zo3c3PXImCaJpwfZkBizopfKZhoPJ2S7f2SWY0SawB7JZqN0YZhVdIt+0BbR+njTg0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8D2GhOUGbV/w3JPRNOsS2CmuLLhXG1/PfqNodNcNv8=;
 b=J+599bfSzL0CGSVzqXUWApANv+eguQLAltGyeWYo6F2Fo+X2rvMCp30kvWazoqHSlxHxwe6/f1tT9P/1lSr1oP625+vNuqlm7TPIiX15aPL1nfcvoFdOwv9oG3tAe6nRWGpePohulYjh17sDZknVSxdVbGZDmeImNFkZl+4OJbE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:08:51 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:08:51 +0000
Message-ID: <3216f9d6-a07c-4af3-a2f8-1bdb43be3d3b@intel.com>
Date: Wed, 18 Nov 2026 09:08:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] igc: don't disable ASPM L1.2 from
 __igc_resume()
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20261111093035.513635-1-danividanivi@gmail.com>
 <20261111093035.513635-2-danividanivi@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261111093035.513635-2-danividanivi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|PH7PR11MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed6d743-8857-4380-1440-08df4542cc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261021123027099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eZ59/xpHPEa9s/9fEaVtnQEPA9qCfgZMxgJxLQs30GnVKe2fMJ70hFbQ4xB6XLt/72SrvCOSqMcLEbg/OHLaM5HHXs0QBY+rOsvKWzS5EyeASdbwsVe4tnLO0npTVzepOQBP3Y+XSRoqNDmpaACMuOL/VdAuXr7x9uZbKcuOppSJTt1L3htoFXNjsyGtBz9J5Q4gvfecOIrLofCLFZq9Di7LH0/HYygPUtrJ1QlDGnmhs+WwfiuCrPv/jDemSpXiTkIiiryiYo6I5S+rV+y4muW3oGd2HEdnlodo7EPVSDkSAMBO5lkofsxkmO0tzKspXPtGCwRU7ei3ACWSEIHCoYDldQCACopLROhk9mNtMLnRbzD9CRvpT+xTn74lS3De2UEQZdgrlCZk15d+n/baQW6HpwBJjcwD84fRyuIbJZMo1kd5WzPXqDgQlBmXPRReNeZjIJKhPhEldTfbdkE53J92ZvlWPyizDqzDoqCQQBFhoFE3KWqEtvnDyP0MMgPyzEjFjBXMn2gEBpz1pV6sMhL9eXpWnpJ5SFM5M/PI8XjaeEs3+nJbZtEN5/vwF5rdxuWQJA8fbjkKWIlzuqkmiiUpMvKuuDZb/KFvVQsnIPMoLHFdXKeZPuOnnuUG2Ib9VQHX/TTjo1T7eTxOTOnDJPjrANEKjgSuNpR2iCCKQKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261021123027099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnQwL0toTi82c1VNWmdZQmc2eUNPTDdnRFBnVGFUMnpnejNMTXNndWFrYnZq?=
 =?utf-8?B?L2o0NERjZHhyZ25ZL0pCSTloVVpCYzBhZThYcUZKUHJkVUN2cXZTSlNScVl5?=
 =?utf-8?B?TTJrUEJXdmJ6YTQrellIdFB2aWRqQitGRkE3WHovNHNtV0ZVWjJuVnNTdGVD?=
 =?utf-8?B?anpOUkd1bXNTdGRkY1FMSlRlbzRTSGViS3U2Zk0vN0c3c2JqSThITW9WNFdT?=
 =?utf-8?B?RWJGc3kxbllhSGNlRzBlSWw4SElFVjdlSWVFRzdaNnNGVmhLZk5nbEtRUmZq?=
 =?utf-8?B?M08rK2MxNXNsODQxLzZyb3RkeEFpUjh4QXIzTFNDVytUbGw1S3pPRmp0STY4?=
 =?utf-8?B?a3pXWTNJSWdnYTdwVFVYdFArY2FRcUcrSXRRVDZvK0FQbzdKOE5YRVNkZitj?=
 =?utf-8?B?TXBJSDZJODlCVnI2NFRvUTZVNlRBRDVZZjJsaCs5NDUzMzRTV0tCZXRER3I5?=
 =?utf-8?B?bXZxT05oZUdGQUY0OGhCUVJhZnF2YzhJTlhqaWtYSUlRVzA0WUdvNzV3L3BY?=
 =?utf-8?B?aXRwcnZzcG9WMFgxVFlXcmFsLzNLRTB2V2FHa0Fnd3dick16YnBVb3FuOXY1?=
 =?utf-8?B?Y1ZJNXR5aDRIK1NJSkVndmJUU2E1cEh1WG1IUWhTcHNUSm5nQ05NR0diSW5a?=
 =?utf-8?B?ZjJnYUswMk1KNVk0V05JU05sa09vTGdoV3c4UXNXZElOR29LQmhCclRkbm9Q?=
 =?utf-8?B?ZEZNZ0xmZ241Y1h6MEtKYkVrVFd4YXVldnF4RGZRWEhPNXBqTFBPWlIvVnRu?=
 =?utf-8?B?S0h3U1E3TXg4WGQ2TXNOQVAvZndEZVBxZ0FZeUF4R2lBVkpNWnAwS3ZmTUti?=
 =?utf-8?B?T05zQnBOZnJXM3dtTy9aSzliZnp0dUpEY1lvbWZSN1E0QllGaW8wNXRQank5?=
 =?utf-8?B?RUU3VzJYQk9IaUNiSXgzVU8yU1p1T1pScXFoV3ZESFA2ZWk1MTlwSWdwSm5l?=
 =?utf-8?B?UnV3WjByaG0rbzMzWDRwc0ZYT1NtMTJwVHYwcTUzK0VmUDZ1Y3BlTitNRUZY?=
 =?utf-8?B?eVJvMUxMZ3NjdFh2K2hqZm1kNDJtOWorTmdNOEkzZTdqUnUzV3B6OXdBLzhr?=
 =?utf-8?B?UXNLNlhjcHRpOVgxdUVPNllTVlViTUQrTlIzNDNBVUwySFdoMzFhYjlyY0tz?=
 =?utf-8?B?emdCNVBTdU84cVhVVHo5amQ0Nlc5dS9JUlhsVnRVSTFXdHNyYnQ4dWlKbFNB?=
 =?utf-8?B?dFF3VUZUNE93b0R1K2FvRW5oRkJmeHNDZlJZajlrdUVEY3lKK2pmWXBHVHVh?=
 =?utf-8?B?UUVDQVZwRSs1Z3BZTDhud0NrNmoyaVJ6Wm5LMHV1bGJjUU84K2g1anpFcUFS?=
 =?utf-8?B?ZjcwTUgvQjlaaUNveDNhVnBwMXhpN3lNMGQxelZUbGdGTHRXK0lvb0Jrbllt?=
 =?utf-8?B?NGZkNDYxL1ZmUWgwU3VZQ0tUSUZoNFVkemlSc0RxdEUxeHJabWppVWU4bmU1?=
 =?utf-8?B?eGVsRHY3RkdtaVJ1S1BkMzY5UzR2aGRrVHJneHk3Vy90aHdVM3o0Z0VZcnkx?=
 =?utf-8?B?a0REbGErQnpYK2J3VjFYclZOaElMSjVPekU2dGFHQmx2N1R0bm50U1dONVM0?=
 =?utf-8?B?MGtDbzFNSjlRUWpSdVRJek9CRDJpdjFDazhqR092amh1TWxiTHRlVGwwR2Iz?=
 =?utf-8?B?RWpCbDNXKzZ6clIxVjZDUXg3dTZWM3BpUnVGL0huaWJDNXU3UzRoU296SUI0?=
 =?utf-8?B?WTVjdEIwMGNlVjFpSjBMSnRBMnhSZXhBUnJuemZVaGZGMW1vOUVmRlA2Z05j?=
 =?utf-8?B?NUMvazVFemxNbE1JL2NMRThLV0V0RDFJcmtwS05sSWJwc2NYMExLMWVybkVZ?=
 =?utf-8?B?Y2tpYWFCTkdqSXl4c1crK3NvUWFmNnI5U0hlZ09ITjFjYTIzaE94VmVYOHFX?=
 =?utf-8?B?cnpKdlErb1FEbkl2S3FYVTRXWHltZXJ0YWZEdllHR2VKUXFwNFp5SjdJUVlD?=
 =?utf-8?B?SFc1aXJ4Z1VxcTFmQWFXUXJFNytXbm5GcU9Tc216RmxUVERQQWNhOXBiVS9Q?=
 =?utf-8?B?NkY3bnQrOWxHMFF3aFlqdFdMRkh0cElVUDk4NVdLWlFFbXZXMDFvdnBaeDUz?=
 =?utf-8?B?dVIvbXRLR29POHhteW5ySS9XcS8vUzhQUFN3VGpQZUd4ZGIwRDVoWWhzVjY4?=
 =?utf-8?B?ZStsSEMrSk5SK3c2UDFMTTJrZVpLaTY0WVZPdnE5c0U2bFFBckp2WDFsdmdh?=
 =?utf-8?B?NGV3VXMwYk1zMmgwWmk0S2I2Z0hxRlN4YnBhMkJQWFZTR1RwakR0aUhTdlZ6?=
 =?utf-8?B?Zk54NldlWGJSYWVFcjJlUWVUQWw2Smg1NmFPTi9ETVh6c0h4dVAzWWY4S0kv?=
 =?utf-8?B?aWZ4WGEvcCt2dVNYYTJTWExscVoyTlI2SnlOTmtKRGdyNFNLaUhLZz09?=
X-Exchange-RoutingPolicyChecked: nTSxzOG1kzpxcUDvVcuANS+SMq1+Wb5hFFPZT73sKx/xaxBZ2NA5JQjuthq+vEZm7GNy5uFh3cPLokvmN0JxLEAlBjskR4thvLd5bj4Jj6q9onpA+3Q10NNaSf4QWAOQ1grhIwMkOb6VCsFwYNFdx/xt8Tp7NOklfhWQPv1zCVOV45NnhnG+bYzUZZZXPAt6Qn6M6qZwyTXlTU+IaqZyeaLmY11GD8KQ8/23Su4TR2Y+gicFj7Fx9EYJ1GZH/ZFkAx/xzTJytTF65eEbYykVVLBD9bzlrc4KU6eOvsmblKEGvXyBvPHQiSJXUqNM6URmBOPWsXmj5JfB3q9H/yPwlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6d743-8857-4380-1440-08df4542cc55
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:08:50.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz22QMAwri4pZjnNfY6nYjZ4Wc382zRBtigSwDk7/PeIdKKVMQpG/Fuboh9iErDnTTf6ap/YWn8ckccT55lAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-OriginatorOrg: intel.com

On 11/11/2026 11:30, Daniel Viaño wrote:
> Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
> performance issue") disables L1.2 on I226 in probe, in __igc_resume()
> and in igc_io_slot_reset(). The resume path uses
> pci_disable_link_state(), which takes pci_bus_sem for read.
> 
> __igc_resume() is also the runtime resume callback, and it can be
> called with pci_bus_sem already held: pcie_do_recovery() runtime-
> resumes all affected devices through
> 
>    pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)
> 
> i.e. from within pci_walk_bus(), which holds pci_bus_sem for read. If
> the igc device is runtime-suspended at that point, the call chain is
> 
>    pci_walk_bus()                      down_read(&pci_bus_sem)
>      pci_pm_runtime_get_sync()
>        igc_runtime_resume()
>          __igc_resume()
>            pci_disable_link_state()    down_read(&pci_bus_sem)
> 
> A recursive down_read() deadlocks if a writer (e.g. a hot-plug event
> adding or removing a device) queues on pci_bus_sem between the two
> acquisitions. pci_disable_link_state_locked() cannot be used instead,
> because on the system suspend/resume and ordinary runtime resume paths
> the lock is not held.
> 
> The call is not needed on resume in the first place. The disable done
> in igc_probe() is recorded in the link's aspm_disable mask, which is
> only cleared through the ASPM sysfs interface. The PCI core honours
> that mask whenever it reconfigures the link, including when the device
> returns to D0 (pcie_aspm_pm_state_change()), and pci_restore_state()
> restores the L1 PM Substates control registers saved with L1.2
> already disabled. Drop the call from __igc_resume().
> 
> The issue was found by the Sashiko AI review of an earlier version of
> this series.
> 
> Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
> Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 62a7c5178..1b5dcc166 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7585,9 +7585,6 @@ static int __igc_resume(struct device *dev, bool rpm)
>   	pci_enable_wake(pdev, PCI_D3hot, 0);
>   	pci_enable_wake(pdev, PCI_D3cold, 0);
>   
> -	if (igc_is_device_id_i226(hw))
> -		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
> -
>   	if (igc_init_interrupt_scheme(adapter, true)) {
>   		netdev_err(netdev, "Unable to allocate memory for queues\n");
>   		return -ENOMEM;

Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
