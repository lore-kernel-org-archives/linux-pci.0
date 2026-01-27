Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307E3093C4;
	Tue, 27 Jan 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485048; cv=fail; b=flQAWLHd66fCvdsZb6t3SHzxLKHL3r2XMglxYEMRcZDPqLgfVJygTV4/w8AIz4gCvQP9BasljYdcfeR7rOiu9pMmxDsXMn+2UBqL0G9qgAdh2ThQCE1Q0TuAYiXXaiDqTw+w49Ma905k210/JdJiqKQe1Vl8U5PtoaA1+q50TbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485048; c=relaxed/simple;
	bh=wFZcjcN0CFP0qGW92gIaB9mhHkpDBg1lq1nKvkq4TCI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UPABTE6NmIi7URXVKZQZ6iMtPuE7Vz34TBjjQZ/68QRR0VSntnE5YQivBMG+OeZktLIAsmKKw9DK8dpORUkhqB/1T/Srzk3e3cRwG7N+b+yEPROl48a2HK+UE22BXzps+/PKP7ZG5bo+ADQltRTKh1fU0IKQgIzu8Ik+vpM55/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cV6kqIA7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cV6kqIA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769485047; x=1801021047;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wFZcjcN0CFP0qGW92gIaB9mhHkpDBg1lq1nKvkq4TCI=;
  b=cV6kqIA7gZrX94dIXl3t3QBp407CIunRSXdieD3YqNq9a+waJQVk56Wc
   8DIY70G2/B6Ee32UVyvckm2XfB7OP8S/g/EtPhzq5kXez7Nj41+nrbwCX
   UY/0b3/vubv5PUEVEdItS1F8GLYg5tUowdpHb0S9kE5f2Ugk6LtloGqdx
   IEuqXecRgr88g8P7pnJ4eYbbGZZ8SbRCC4fAeHRuRXsjhXxpxYMmumPVy
   9tOZTfefntErA5n01xkqc2LqQavO1VADjIz5ddyLGiJj7X1VYROTxqS1c
   ZlanAHqLS5H3Y+ZGnZfBtMFNup69BpYpiUfookK0RNZzNoqBFIkMM2S8N
   w==;
X-CSE-ConnectionGUID: LGWpvpwJQ9ulVF+uHApMaA==
X-CSE-MsgGUID: 0hCEnHunS2mkSJ3Skz4tpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70729262"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70729262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 19:37:26 -0800
X-CSE-ConnectionGUID: FPwrouehTg6WY4EvF/XWQw==
X-CSE-MsgGUID: foIPtRGIRYCR7HNbhR+YSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212715584"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 19:37:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 19:37:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 19:37:25 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 19:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4B+X5qmdcmS1rHCe6U2dswTRY2lIvko7dlWzXFrF53K5tlpC1lPITbrW/dx4iihoQFr60O+e3P55gr0RWToiV4sLuhQ4v12/lCEFPvhQfwxHSXyJRXo87pMAjfJT9b10UVbyg9+3c02DKPdxOid1a5gBgTdIlIITaGjQkOrx9G5w2vnXAYNX7Do84NtGm0BkCOmA26iJsXAcFeVySd/3C/MMciKZ4CvrST+HtC0O2p0xOk1T3qQj2UazaQxXPh84y3qz3rMxK5B1tOM3fVI5NsqFJ9z0T6ufTplZhh3+3e4dXLqHMj7NiPF9dCJ+Y9b7tDxaV8CA8TD/Ee0widTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmhXuo2LR/U5Qrzo1EQvYIrpDoG47mIMglGHDHYWxag=;
 b=tbprzsnQ2n2/w2fP/JXLHtlsOIWzSD/U9QR1ltvc6xjF89RYgAPn03GkGh3A0JLv78f8L5tn15gQAOCLb2u9WcgMNIhVsmdSNMxG73kKrSDu+A0kpOlC/HcnhgLazLFpIkNYlFh0vJBTfEeXPngiqjMg/onP6bWugEiWNFqBA5ztMqmPhSyhd393wsqOgD7VjO6BGnsMOeAARwgJ4qklRWwFjZYi39q35eYiYiJKgPAX9oXfP2YwTreKvnF0FE061eN0bmZKU8GgCScobYj2nYg4iZ6ScOZLMpLFxWdFQwrhtPaYYGpdAnNS/7yAAtR/zovZgvi4O3rl2Kh/ShWpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8692.namprd11.prod.outlook.com (2603:10b6:930:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:37:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:37:15 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 26 Jan 2026 19:37:13 -0800
To: Jinhui Guo <guojinhui.liam@bytedance.com>, <dan.j.williams@intel.com>
CC: <alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>,
	<dakr@kernel.org>, <frederic@kernel.org>, <gregkh@linuxfoundation.org>,
	<guojinhui.liam@bytedance.com>, <helgaas@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<rafael@kernel.org>, <tj@kernel.org>
Message-ID: <697832e9f00c3_309510076@dwillia2-mobl4.notmuch>
In-Reply-To: <20260126091749.307-1-guojinhui.liam@bytedance.com>
References: <69741a9beae22_309510044@dwillia2-mobl4.notmuch>
 <20260126091749.307-1-guojinhui.liam@bytedance.com>
Subject: Re: [PATCH v2 0/3] Add NUMA-node-aware synchronous probing to driver
 core
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: f16d79df-420b-4190-6623-08de5d555d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEw2cC9MZ3VZaVh1bytvT0l5dlVFRS9KdzExVVRRNHBmZEwxSWw1S3FZbjJR?=
 =?utf-8?B?VkJiaFRUTHBjN2t1QXFkY2ZlMHJNYkRucWMxMHZ0VjVzVVBuak9lUk9tckFy?=
 =?utf-8?B?VDdoWXBOSFNINk9JMGhHamM4T0pIM0dPd0dqb09FMEZ2RGpGYmJBN0F1ZlZN?=
 =?utf-8?B?ZDVsUzFsRlhQdjh4V1daY2xZTVpaT29SSjhBQUgvMkNCZjlWQk00amFKd1Bk?=
 =?utf-8?B?ZnFsMHBLQm9henE4cmhheStRWHZ0dFZEek9hOXFVcjZkZzZJejI4TElFZDNO?=
 =?utf-8?B?c3cvcWlDQWdLbWNmaWo0SVdzK1JRdUdhZmFUY2NlSWRBWmp0YU9UWkxCS2dX?=
 =?utf-8?B?QlJJQjhTcElwbElIeStDcHFQcEp3TFhmR0l5by9odzlRSGVNRkNOcWpGTytH?=
 =?utf-8?B?RjBCcGlpVDJROW5hQ2lVTG9wbmNHUkpDUjNtMEhoQmhrVnJDTURheTlWM3Z4?=
 =?utf-8?B?UmQyR0lNUjJHRXVBM3JNYUlUS0pleFNJNUR6a0x4WjdKQTVhTVN3WE1wb0ly?=
 =?utf-8?B?VzdIVE5OY3QzMzN3MVpFWnZPOFdDazNudUJlYTRPWDhrUnlKU21tdk9Zellw?=
 =?utf-8?B?a2Y1Y1Jkb2VFZEVmNDk3eFJleFdUR0h2UVdtaVdzT0xBbXA4amxvMUpKNW9I?=
 =?utf-8?B?TFprbWVnTVBFa0pTOGtHNEpPQmZiN2RHMGJDckNhRDZPMVdOV2xYNXdLMTla?=
 =?utf-8?B?T3pxS2NzTEdaWEd2MGFPSHVzU2phamd6b0E2SlM5RjN3bGdNMGZGdTlRZGZ1?=
 =?utf-8?B?STBDa01rMHV4bGZNQUZkVFFRaFFEalJMSzFxdzhSeVFsenRwb3JLQnR4UlFj?=
 =?utf-8?B?M1FMVE03VXlmQUs3SHI3T3JWYUcxSnloczVFVVlybERQd0JiQ2dVb1JZYTgz?=
 =?utf-8?B?VmkzaW1WYlgvSzFsMHVqWkVjSkM3aGlHU3dHQkFzcjBPK3ZBTGVZSGpRd0dq?=
 =?utf-8?B?SnFBVWpGM1lQSDQrcWFwQit4akcvRWJLM0p4TC9hYkUzSit5N0FReXJuN0RB?=
 =?utf-8?B?dEdlMEYwdEF6UVg4VlhySWxvaFhrNUMxeXFFT0c1VEF6QVczdEFGVlBwbjJt?=
 =?utf-8?B?NDh4OGRWNTJUWnZ2Y3NWSElBOGJnTWdTc2dTVmhOcnFaRGhJd0x3eGJXWWJ5?=
 =?utf-8?B?QllXWi85TnVpbnhtZHp3TllIY3lESm9aU0hJMjlCb1A2NldjdmNyczM1QWFV?=
 =?utf-8?B?M2x2MVZGd0s0dG81M3dQK1JYd2dEdFlHOUlDMmkwTnpoWkhtbktPVXFwT05J?=
 =?utf-8?B?YUZEZitZb3FiU0wvbXpJYnlISXViNUpnQ2Y5alI4c3AzK2ZMZ0hrVEZuVCtX?=
 =?utf-8?B?bzhHSStpQU1nb3YvQWZUbWFxUjNvdkIveUtmWEorSnU2T0NHcTBQTnVHd0tR?=
 =?utf-8?B?STJ0R2JtcCtzRDRFNHhaakFOd3V1dVVBeHhPUDNQaVNNb1hMYVpqMDB2eWxx?=
 =?utf-8?B?c3JNL0JEcnE3RFlKQStxcEV0c3Rsd0UyTVAxYWJBWDcyS1Z6UFAycGY3Y0ZS?=
 =?utf-8?B?SzRNdW92d0tUbTdkRzN2d0FaVTFVRXpCakhTVWR1ZHd3aEo5YWcyT1F4K0dh?=
 =?utf-8?B?N09rYTYwcHp6K1dhYllKamZtanRFb0ZoZHdzYjV6RHg3WXhtdWQ3Mk9ZKy9S?=
 =?utf-8?B?S2grRVZVOWUvanNtYXM0enhNd2dIOWVVYmhHNkloUEJXNEVXUUVaKzRrVkRh?=
 =?utf-8?B?NEtmamNReGEwcTB3SVBZUzRtMFdXZUo4V0t0TjV5QTBERytxWWs1SGtKeUI4?=
 =?utf-8?B?M1lpZVdBRVdHcVZXeklValNrSWJyQjNiVnM5NVFjMnJoVDhTaUY2VFRyU1B4?=
 =?utf-8?B?RDlOQTZ1ZWlPdVlSS0drQ1Fua3RQczgvdFFCU29taDZWS2g0aFQ5aU1LMjZv?=
 =?utf-8?B?alZxY1Z0Y0crNGZMY3gzWERSeVdSSnE0aXVpL1NheHNwR2wyWW96Qjg1ZW1a?=
 =?utf-8?B?NnlJQ1NuNmc4d0ErNWdOcDRlSCtSazI3YXovRFlPR0djS2hUM3gyMHlLbktx?=
 =?utf-8?B?U2p4RXdVVEZOR3pnZ1VGY1NoeHIzWnZoQUtZSGllSjgyWjExVHBpVlpQYktI?=
 =?utf-8?B?WFB6Y3N6ZERJRHJKNGhUYkNHNFYwVUFhcDlTcTFmR1Qxc1ltU29NNzhRZisz?=
 =?utf-8?Q?8G/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmEwZTJ2b2xlUmJKY2tKUmkzYm5paUc1RjFzOWJxZkVQWUVVdUtNTTBocCtM?=
 =?utf-8?B?NlUxU2pGMEtQOVVpaFhqeW01OXJpUHc2YVpPeUdlUWw4MWN2bm1SeHp5Wjg3?=
 =?utf-8?B?TndDNm1sam04L0xKMVQzeFlpb1dSd1B6K2pGdVZIcG9wL3ZzU3FvdnE0UFFS?=
 =?utf-8?B?N0E5cUlTdmhSall1T0kxSmVvelM3SEplVFY5cStIdTRsWDNOQllOZ3k4RElL?=
 =?utf-8?B?eWxmOFYzdTl2MmJaYm1lc2VVL0lwYVkwVWhrd09RT01iL1dGMDJOYmhRTmlU?=
 =?utf-8?B?S2p3WGVBNHo4UFIza1UxTzF0dWx5Y1FXKzJKNGMrb1NmK3l2eXhKb0Y1QnFK?=
 =?utf-8?B?YjBtTDRya295NTd2RjZqK1dUNjRibTkyaUFYVXl4Umo0MGhQR3J3Sk9IQVRU?=
 =?utf-8?B?NkVuTC9IeFZnVUVNTVd6VVh0VFZtanFWTHRzOTRPcjluQzBjS0ZLYUpJL3pV?=
 =?utf-8?B?dkVJVlZIQU84SUQyNnlONXoycjJwN3d5RkhEMWRhdEY3ZXp1OCtUQ3BFTzVU?=
 =?utf-8?B?NWNVV2RiUFlYL2pkaDF5UWZDSEozaHdoUlRWUlBxTENHdWlnVjl4QXI2ekdq?=
 =?utf-8?B?a3FsanJJQ2xzbElML25FWFc3L2NJbm5SdVhORzNkN2tWM2lveEtMem5rcWk2?=
 =?utf-8?B?UnhVb3dudFlpUDZQdTRlcnJ1Z0pWWlhpR21kUkdWbGFoU1F4MlQwZ1lyc1NG?=
 =?utf-8?B?UUp3QkpKZzg5QmVQZ2I5Q01LMVZOUkZKeUJaeDlhV0hLRTJsWE40TVJ5b1Ix?=
 =?utf-8?B?cnUzZWh5WUU1dFR1TmFhVENCc0ZpV0tEQ0FCL3l6VDltYy9vUUhydXdLeW83?=
 =?utf-8?B?Q1BaeVgwL1hkajNqK3RtMVkzaUN0c04vQk5vL1c1OWhTMnlPYnB5K0pNSTNh?=
 =?utf-8?B?VkFXQWlrdk0zamtlekp4V0N6VmRIc21MMnhRVXdwM3g2SXd1V0hHeWZ4eURV?=
 =?utf-8?B?ME1PUGhyWUxVN1gwRFE3Qk80SVFQTW5UR3pKRU9mamdoMjJjUVFlSDNzeHNx?=
 =?utf-8?B?M2hhWFR4UGsxQ1FLUkxmZkM4Y1JtTS94Z3ZhK2psQVc1eXRlbldGZHJrNHc3?=
 =?utf-8?B?S3NOQkowZFlhbEsyQ1hnTmNRc2ZMKzZJTnFOMWM1bHNMZmEwUFpHOVRFRy9n?=
 =?utf-8?B?VXRKV2lxR3FjRUdWMXhwK1BpZHFVczRqMHFpQzI0Q1BaRlgzakNBRUh5RERs?=
 =?utf-8?B?Sy9TVzFoL2tBZGR5Y1BMbnRHRktUT0hqY3phUGdpSllSekphclZwT1lUOVAy?=
 =?utf-8?B?aWVVY3NVMnlkMXBZQk5pN2RCQ2dDT2xxVEJjak5UdlVkUHovL1Erd296ZU9p?=
 =?utf-8?B?Q1NYakRETEx6WkZXVEc5NzhlcUVJeEhJWnhoRFhYU20zQkdiS2E2TTVIZ0lp?=
 =?utf-8?B?c3Z0MktKYVUrcnJRdHdScXMxWlMxQWJod3hwQzk3SFBUMnQ3OWV6dDJHOGU2?=
 =?utf-8?B?dWp2b0l6OEpDZUlJa3NBSHFBQ3NGZFp5RFJBdlNJaGQxZEhjdjVMSW0xb2U4?=
 =?utf-8?B?RUV4RUJQKytnY0pJanRtZDNkalFDWjR3ZWRDQzVqMzdwa1hncGFvUnZydUM1?=
 =?utf-8?B?eXFkeTV1OWNJdjZDaWxSVk5BeDZxdU1GVm1qbWJ6WU9rUVJFZ3RJS1IrQTVj?=
 =?utf-8?B?Mzkvb1lHdDNKVzVZWjNTcEhSWGIvWFQ3ZVpKb3FNOE81K2MrNk5uYlNVUTJF?=
 =?utf-8?B?UzBvZkZpc2kxaEFic2NVUnpzQWxHbnNkdmJnUm84SnYzWjlCQ3RKUVVmZklW?=
 =?utf-8?B?M1U5aVc1dHFubk1hWHZ6dldUZmdFMnI3QWxsK292eGUxU2xSRVdIUjJlNkVZ?=
 =?utf-8?B?NUJaUHhwTDJwZy9rNVpZcnNNbkNnQTh0WXNCNW5FTFB2MUhsL3VmME1VRm8v?=
 =?utf-8?B?blBTcTk5OU1qbm9VM0FuU0xPRnBVTEloZXRyei9sbWl5RHpYQjdvRjYvdzVi?=
 =?utf-8?B?QlIwYmR2TUZTQjVhenpiNkxiQjU3emRpREVCQWJXSzFnQVZGcnNGZDUxeGJa?=
 =?utf-8?B?ajIvb2s2TVpTL1ZweWhwTDJRcXNHUXVFWXV3bmRIZU1MY3dWZk1VcEdiS0ND?=
 =?utf-8?B?OTdYU0ZlMGl0ZHZUYmtnOENTazhZMzVScURIWXlCMzBHZC9QTFd4RlIwbHFX?=
 =?utf-8?B?RlpHdCtnZU0xaE90L01zZW4rbXBMMWprRW9hRlFOdmV4REpWaWszM3ZGUmsy?=
 =?utf-8?B?UENzME5pU21SS3gxcjJVL2oxVUJvMUFQVlU5bGxMbSswWm1lU1NIRXg4TFc2?=
 =?utf-8?B?eDNzU2F6OVB5TW1PUmpMcjMvekh1T1JXK21ZNGJ3S2puUlE2U0xSZ1JJaGh6?=
 =?utf-8?B?Tll4TzltTHR2OUtZZ2wwUXRaOXFYeXZ6L1drbmc1TjNSY2dpejgyZEtqSHhD?=
 =?utf-8?Q?VR66Dz26WKCR/SIg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f16d79df-420b-4190-6623-08de5d555d62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:37:15.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR9Xc1d/iOZchAjw+yCnSp8PcQ0CgE3royyYfc4TiKDN8VAcU3fdbCxyivE7kz7MDGVWwRiUU1bx6zQMvbrZ6neGbPgxJfe4AciDs+C0vvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8692
X-OriginatorOrg: intel.com

Jinhui Guo wrote:
[..]
> > I like that from a global benefit perspective, but not necessarily from
> > a regression perspective. Is there a minimal fix to PCI to make its
> > current workqueue unbound, then if that goes well come back and move al=
l
> > devices into this scheme?
>=20
> Hi Dan,
>=20
> Thank you for your time, and apologies for the delayed reply.

I would not have read an earlier reply over this weekend anyway, so no
worries.

> I understand your concerns about stability and hope for better PCI regres=
sion
> handling. However, I believe introducing NUMA-node awareness to the drive=
r
> core's asynchronous probe path is the better solution:
>=20
> 1. The asynchronous path already uses async_schedule_dev() with queue_wor=
k_node()
>    to bind workers to specific NUMA nodes=E2=80=94this causes no side eff=
ects to driver
>    probing.
> 2. I initially submitted a PCI-only fix [1], but handling asynchronous pr=
obing in
>    PCI driver proved difficult. Using current_is_async() works but feels =
fragile.
>    After discussions with Bjorn and Danilo [2][3], moving the solution to=
 driver
>    core makes distinguishing async/sync probing straightforward. Testing =
shows
>    minimal impact on synchronous probe time.
> 3. If you prefer a PCI-only approach, we could add a flag in struct devic=
e_driver
>    (default false) that PCI sets during registration. This limits the new=
 path to
>    PCI devices while others retain existing behavior. The extra code is ~=
10 lines
>    and can be removed once confidence is established.

I am open to this option. One demonstration of how this conversion can
cause odd surprises is what it does to locking assumptions. For example,
I ran into the work_on_cpu(..., local_pci_probe...) behavior with some
of the work-in-progress confidential device work [1]. I was surprised
when lockdep_assert_held() returned false in a driver probe context.

I like that buses can opt-in to this behavior vs it being forced.
Similar to how async-behavior is handled as an opt-in.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/tree/dr=
ivers/base/coco.c?h=3Dstaging#n86

> 4. I'm committed to supporting this: I'll include "Fixes:" tags for any f=
allout
>    and provide patches within a month of any report. Since the logic mirr=
ors the
>    core async helper, risk should be low=E2=80=94but I'll take full respo=
nsibility
>    regardless.

Sounds good.

With the above change you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

...and I may carve out some time to upgrade that to Reviewed-by on the
next posting.=
