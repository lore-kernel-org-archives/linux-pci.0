Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10109F9D9;
	Sat, 24 Jan 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216680; cv=fail; b=ne1qmxDlenKz/RWaBkB8MjVCwiZhGBznDqonZimc2RgGnNtuFm6VTsFLEuglO97CG/UqY0TFg3CI9Zb39fydmpvzBJRljA85YiqYGgMr2kA/XdR+BWGN4wnXCrezM+e5YblPTtsjIb/Y9ovQIQUTO9w3tfKWcF90k+16z241wp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216680; c=relaxed/simple;
	bh=Oi6k3FFXzmNM7TvJBa2qENOGNHNpi4Mz/XHTaVNoiiY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GvZk89qajQaL/WggCHPIQ4rpmUE8TiRfs5MPuYmzjm8disx58FuymyUKYUlsXvmfL1E3KfSNO5UUKIXN4avFGLJNSAbNDEOF+Jz9dldG1P/5WNYm14AghA2AeR8cmkppRU4lB2u7TREdUVBxJj6f2wmEwOcTA9TkZxM8Tw5nzPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0FeWXnM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0FeWXnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769216678; x=1800752678;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Oi6k3FFXzmNM7TvJBa2qENOGNHNpi4Mz/XHTaVNoiiY=;
  b=O0FeWXnM4HGPaHXIZWctV92vcfKorqEPnt/cGj1/LzY4iVSn4c+1WLqv
   OSaZrWPCmAYz+yqvbzJ/fEM7nR6z37M8Yq4cDg/iCHTZuj8CG2Lj1UNdA
   FAnToDH0CXM8xkn30+QQFk4+frMMqgJBXcCCU44O8g5fCAJ9586FUyScn
   90M+gn2+SjpBqsnoBoj3ihxodyGUCyX5k2MNG5AXdON29UZARJs3/HiEZ
   c8WtC1uSZtrv14beVtA8OpJZEOIC8HI34vjlFmjkyrUm4+eD4CCtIJui6
   +PCyi7FAXYv7hxFlCpIkpCU40bGMWKF28kijlwLApM9gYpk7zLQ9GIEAx
   w==;
X-CSE-ConnectionGUID: WOk2XOreSdCu6MWoc5EpiA==
X-CSE-MsgGUID: uRg8KXWlSwiOXfAMuRgF7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81102129"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81102129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 17:04:33 -0800
X-CSE-ConnectionGUID: bw3sifPuSAazchw2xwyXIQ==
X-CSE-MsgGUID: +NNII//VSZChQ5M8Gi0Q2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207072440"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 17:04:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 17:04:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 17:04:32 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 17:04:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdclcRzW5NlD7POHbkjSgZZldd1Vo57fNr58nT1dQkLuSQ04jQxCbwClAgI9VjPqM4cSZD8Te05P/IZVu2z1bLo0rBlKHtgmoWQZm28Kz9FGMSyFzK/nbFp0tHjCjoRHDKQsjNTbtDIAlkqXsNc4Ra1NeN7SkkOfBkkyC0XG2Btj+7qqda+q4UPixQV1HNFGBBAwg1QXkWlf7U1FB8gp9YFmGZ/8RWs/Ito0l280QEB4H9ak8laudb0CrIjt29DZ8vz2AhDruURP15wGu4X0ivHpHsHjkZWWc0eCMmQhR0MK0ylSj8O3ZHSCTqHuqwPBsp2oCsAUwkaSuHn7L07xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZG0O4WqPt92SL2WytTsM2kyYymHnwZflI9ZfedQ/8=;
 b=y02ruwkaaiD7AU+wA51UoDNMjrHAsxVOvMxAn0z4spOAy+8o7ui0S5GQBEMiTSpqtHfm7TpYTb0k3AsTka0Heo/fWbCCdcGW1AmBD+B/EcP1NZhmDs5+ragkFZ6J2t2IlfanElwRAyYFUgfNVHxiYbj5utETg3VsxEOQ1KovlcJHk0Rvod4Of57ycs5HA7W7vxacsMeGMHaHlcMJ/zWgzUMRl2Z34bWvlQoGMtJbWGAYuiKM35QKCrq66ZfqFlvp86nsKo0eVwodzqn0W8MjuG4WxEO2DHqQRslIyeclH9jDdBt2aJKoEwN6b81Kz2YZJyuFsMjU+Q4LGu1AY0IrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 01:04:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 01:04:29 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 23 Jan 2026 17:04:27 -0800
To: Jinhui Guo <guojinhui.liam@bytedance.com>, <dakr@kernel.org>,
	<alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>,
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
	<helgaas@kernel.org>, <rafael@kernel.org>, <tj@kernel.org>,
	<frederic@kernel.org>
CC: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <69741a9beae22_309510044@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
References: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
Subject: Re: [PATCH v2 0/3] Add NUMA-node-aware synchronous probing to driver
 core
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa6a327-a009-46d7-5d64-08de5ae486a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkNVNUU2ZlRaTFlZdUtMbklEWDgzS2RPYTlHUlBzKy9JNHYrSHY2Y3phRzNz?=
 =?utf-8?B?RGdmOFhzUjVUSFJtMnlFek01L1U4ZnB2elg1L2s0MHozM1RXdTNHeWV3bVA2?=
 =?utf-8?B?Nmd0MTRtVEhqMkNac045SW1hclZ3QlFJOTY5VXN5MTI4Y2tmOWtHczNOSXBH?=
 =?utf-8?B?Yzh0U3FuVHh2ZDNUZ2tOYkl2WDJpY0YzMzc3ZUhoQ2JJc3pmSkVEL0YwVjVV?=
 =?utf-8?B?R2c5WVdBaGF0bmFiYk81M1V3Zm5uNHdCa1BQaGIvM3lsdHZXbmlnbFJkNkpG?=
 =?utf-8?B?dUlGd3ZYMUdteVVnRHVITnNmRXVjVzZYdUphV1VHQlV4cTA3S3N5V0taL3NF?=
 =?utf-8?B?Y2FVUVd1dEZIZllPNnFDQnltaUI1UFhkaC9mWkJndFhlRU1KK1poMGdSVTBV?=
 =?utf-8?B?ZlpjRmF1dlpCcnpXOXNnY1FJQmgwQ3JBTG8zYWNUZXA2YU5QSFF3NnpUb3hr?=
 =?utf-8?B?dWVoZlRrMHB2TFZNWHgyUldPbTNid3Q3enRybDZ2aUtUd3hJb3pZQ09XaWZV?=
 =?utf-8?B?c05BN25nYytIdUU2WVdPWm9CbmtqaVRxZGxlV3JJOGdGVFFhY3Q1SW9sNDlo?=
 =?utf-8?B?eTR0MmM2cHh5MnpEY1d1SnlCVExLQk1tUDBIdXJMdXJvbU82R1ZBYXlMTExq?=
 =?utf-8?B?bDRGLzAvaWlwR00wbE9TbkRYemlFaEFXSUhZdUlPVFJSQ1ZBb2hLTTZ0NjdX?=
 =?utf-8?B?TGxsa05vdGhjR3BVWmVxS1lpT1Rhb2I0NnBETDFsZEFHaG5OeEJOSmJpUHNB?=
 =?utf-8?B?YmZpMzZEL1NHSlFmaHM0WW12ams1TEtabVVreGlBYWttV1RCL2FRY0Z0K0ht?=
 =?utf-8?B?ZVRhUngxT1lzbkp6Q1kycnZwaTJNNm93Z2VxR29EWWIrai9hWFUxbjNXKzN0?=
 =?utf-8?B?M0x1SDh1c2ZqNlR6ejJkelkzMWh3N2c0b0JPRjdWZXFkUjJDZjF6Ynpkd2ow?=
 =?utf-8?B?RnNROGJEd3BmanI5VUo0T3MwUFk5c1hmTzhDTkVIVmFGOHZ3Ry9PbUtXSFJw?=
 =?utf-8?B?aXJxUkNMYTdkVTVzRnFOajlrdjBtWlRCaWthcEhhOHpwejhBYzZRWjhDaGs2?=
 =?utf-8?B?Y05uK2hnMkNnYSt0M2NpQ3pVTCthMWZZcGVNcTJRSWR2V2NVcGY4elgzaG9n?=
 =?utf-8?B?WkVyZWJTRzJheTl0Y0g5NERWY25TVE5UWEpvcHdYL0JQYk9vdUVhckV3SXpU?=
 =?utf-8?B?RlpVeTh4SXZ0NTBYQ2lsQVRNY0s1ZkJna0dYbnlFaDhYWEExWVkrZEtQVXB3?=
 =?utf-8?B?TjNEK3FTUGowcVVJODVjcUtFbnpmSlpMM2h0SlAzVlc5Y09xN1l5VDlMRnE3?=
 =?utf-8?B?ajFnR0ZqenBqV0g5ZWtGKythazltd1hXZXd2RUc4Tlc4b0tCRWRCVDZXVnFB?=
 =?utf-8?B?VXh1eWYyb0NtekZ6MEg2S05IRk01NmFzcEVTQzNaWW5hNWVwTTRlSTB5WE0w?=
 =?utf-8?B?K292K2ZDcHBBeUtzTS9rNmNYdHZncElGY2JCOFJKQXU2VVlRa2NvQmpGell1?=
 =?utf-8?B?WW1MUjNqSGdzWGZLNDUyQ29WY3RuWlpvdlNacHdnVXFwdFhYcExTSUlvdGVB?=
 =?utf-8?B?eURsczdzUG16aStwUXVzR3FydXdZdTJRb3ZFVm5GMkIwQzl2eTN4WURkaWNx?=
 =?utf-8?B?UU1jUG4reDBWb25HK1JCYjNEMlllZUJvMlhNY2lIS1NBTjI3eThiUGhVT0pT?=
 =?utf-8?B?dGVHTmEwWEtiendQdmRtQjN5cnI3bm8wVzB5Zy9nZEh3clVZcjcrRWhwQTha?=
 =?utf-8?B?TWVFbHExTllnTTE5NytLT1dRc3RGTG9CZEJiREhpcGhDRnF1cmI3Q0U4SExP?=
 =?utf-8?B?Z3pRS3Q3cG1WZGlDcmdDczZRbmNGb2NFa3pjNjVvY1cyK2FqTlB5b0JqRVhC?=
 =?utf-8?B?bVUvOXJZb3ZzT0dxR2xLMzhtRlFxQXB2YllJU0xGRlpVNmczYi83RGRTSzhB?=
 =?utf-8?B?OEhEeTlmMkljUXRrK2I1ZEZsZU14eHcxVElkM3M3ZW91TVhOSnl5NmdVWU9W?=
 =?utf-8?B?MnNQclJUWUNSRE5xUHQ3SjNYZ0EwYUJKaVV4WmxhOC9oTjFGWVhYdEJCNkFU?=
 =?utf-8?B?a1NaVis4N3FZM25TcmR5ZzRDZnd6Vjh1VEFPS2JNaTRERUZab1h1RXZiSGJj?=
 =?utf-8?B?VVlDYmxjMSt5TnpTdkpkQXVpeXhrNWZOdk9RVFU2SDI2ZWUybUovbXRGTml1?=
 =?utf-8?B?Y1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjh5VC8xSmNjRmViT2Z1bzhxMU1jNmttUVBPazh6dk1nMVhlNWR1ZzFpLzF0?=
 =?utf-8?B?YnZPNElseFcydWhTbXQyRDFIeldOYVRCL3d3amppUitBWFF2Z1JrY1VtYnlM?=
 =?utf-8?B?Y1BCSEJpUUVpNDlYSnVaZXFGcjNtT2g3WndkVXBGYVZFdVROb0oyeVhpQytm?=
 =?utf-8?B?NzBwbGRwai9TK291RllYdUxqTUJ4V0lLYXdOdGYxV0dPUHBTQXNRb1A3RnF6?=
 =?utf-8?B?YWlSL2JGa3lwaS9qRWpIWDRXTkRqeCtIakl6eG1lTS91NjZMbFdaaGNsdkYy?=
 =?utf-8?B?T2xNU0N0TE0wYUVVbVJiYkgrZG5EWVVUSElkR2ZQWWJ6SXVIemdHSjU1Zm52?=
 =?utf-8?B?a2RkTEs5UHZxK0h2djBDcmY2N2NVcGFBd3o0bkVZbUFHN1UvcW56Y2g0N2Nq?=
 =?utf-8?B?ZGJ2NG9YQlRxTldvRk5JamxqRTcwbmhWcmw0RDJTYk84Q3dhZ0NOWlgzV2Rk?=
 =?utf-8?B?UkJnaUNJTHVVZFZzSDJUWkRYV2UzR1R0Nys5bTg2ZStFV3IyYXRzOTFkdk01?=
 =?utf-8?B?QzdFMm1PM3MyU1M0SEUydm5IbGxrbXRoalhOZFdIU0hMOHlobUtuZGlhcmoz?=
 =?utf-8?B?MS9IUFM3UU9weFlOK3E5b1VPMjNwTXphdmNFQTZraXkweis2bVJoc2hFUHQ2?=
 =?utf-8?B?N0FsdTR0a29idFB0Y280ZHJPV01FNytieGp3K2h0bFh6U1NyNWhsU1Rrd3Zx?=
 =?utf-8?B?bnBKV2h2Nk5lbzVMU1gybVl6OFVCS3ZFMUt3ZEh6UXpFa3R2UjhPKzd6dUJF?=
 =?utf-8?B?RS9PdWhldEZiWXo3bjhzSW9XTFlJaXM0cU9BcGJMZlp2L3M0WnJoM0V2MTlW?=
 =?utf-8?B?MHVhdGUrNUUrYldTN2JndVI2eGNZZzVFYTNJTEFDZEVpUlUxWlVUNjFaUGd2?=
 =?utf-8?B?YjhtUUswSnJUNXBVVjdjaFpUeUJkaER3cHJwSTY2a2dsVC9BZ1RGY2xIWUZk?=
 =?utf-8?B?YWRmOGdnTWpLeVF6VExuVEFiL08ra0Y4SjN6SlhyWHNESEtCRUpGWjRuTjRi?=
 =?utf-8?B?Y3VvWStPN3QxcG1CbWNhVElmd0YvVEowMEVJNGFOZlFzY3JRUHJrSzgxbG43?=
 =?utf-8?B?WmdUQXIzY1F4NGwvWU5uR3dGSTMzNG9obUQ3Q2R4aTRIdDV6WngyMDRJZDVB?=
 =?utf-8?B?TUs0dEZnUU5qVkNmYVpibkV2Z2FwQUttS3VnWjVNRHhRMVhpWHRxRnB6VHpC?=
 =?utf-8?B?aTV5emVqS1h5ajR3azlaaXBnOUJWMmpzRCtrR1JONWxuRzFwVmZVYm1Vd2VK?=
 =?utf-8?B?Qzhzd3FJcDQ1WlYyUUJlZ282c3hpR2R1NGRTRExHNzV4bFpQQWIxbUlVaWpx?=
 =?utf-8?B?Q3R1cSt0WnpaY0h1QkhydVVMVmFKYUowdWFVTVN4b1NhUHZUbGNoK21rc1hU?=
 =?utf-8?B?TkE0NDJVTW01NTFYMDJzeHUvZUExQUc5OW9ESDJ3YVRnUjFQVFhTdklnc0xK?=
 =?utf-8?B?SGFRcGhNcERHN004a3BrM01zTWNRSms4SkUyMjQ2ZmJRWFp5QzJXUWRXVk4w?=
 =?utf-8?B?WVVTL2JBbkdUUzFmYXk0VHQ3SnZZUEJyTG1iNGcxTUJnUmpnK1d3TngzOU9T?=
 =?utf-8?B?Wmd0MUEvcTZrRzNabHVuaGlHNkJZb1NBL25sOE5McEUybXlyQTN6Z2l5VnRD?=
 =?utf-8?B?YlpiU0dVUG53aTRkanFnQlBDV3lEeUt3VHNkWU1JSTVJcVRtYnRoSlpKbmNN?=
 =?utf-8?B?VVR6MWhwOGM1L3lRdDFKTDlUM0R0bENIYXVwZXhmbWRxM1VvT1FUY2xUV3Bw?=
 =?utf-8?B?Y2h3Um93NUhrbWo1eG5rLzB4eTVuNmF2OVJKdGVVMUVuQnJva2dmUVJ5VnF1?=
 =?utf-8?B?N2hnZGJwZWIzNVBhSG85eWJEUFRpMElJKzE5c08ya3AwbTRKaXNCS2lpTVlG?=
 =?utf-8?B?c29kS2VGSll2QkVGM0o2WmNFOVRpR3dLK0ZpNEZzQkplL3hWN1RKbUxtRGx5?=
 =?utf-8?B?UytENjRzdVpCdkRJaTA1WWhiTmdXVTFQalVONlN3aVdtTHdZNEV5TFRlTGVm?=
 =?utf-8?B?VlluRHJ6bjdNcDdZSmxxcFVyd2Q0bytjQ1pnMkRJc3hNdHBCN2F2c1UyQi9n?=
 =?utf-8?B?VFJRaVRFbElqaEVVd1BNdkMzRVRlSkEwNHBCOGNMUzJ4MmFGMTRrK3F3c0dL?=
 =?utf-8?B?ZTdGbld1SDBBN2pOSXc4cGJ2ZWtCUDhocGU2NUMyMlJoSURLa0lEMHQxcEc0?=
 =?utf-8?B?clc3blhjdWZNMk9DeVh3b1gxL3RzZHd1QTBuQVJBRCs4ZytuRFZDTldudlNS?=
 =?utf-8?B?a0tnc3RiaWZTWTd4NTdBZ0RCVG5GQjBoajh5VjV3MmRyMjRyMVJDMGtrK1NQ?=
 =?utf-8?B?NVBEWGtrZjFNeGRaTzFTOFZlZzVFbENFMGhxblpqNUlETDlmSEw3Smd0L01N?=
 =?utf-8?Q?FKBpTZpo0AJ46MSA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6a327-a009-46d7-5d64-08de5ae486a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 01:04:29.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JzVUY7lj6jqtzTxhOpGL8mbGzk2oym1Oc920uV+4kBzGTCAVt8Q93LuVVr4ZT2y2kuk0tADbYS/jl6YcNNyVCRiKROD7ggvHxiMxK0kaIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com

Jinhui Guo wrote:
> Hi all,
>=20
> ** Overview **
>=20
> This patchset introduces NUMA-node-aware synchronous probing.
>=20
> Drivers can initialize and allocate memory on the device=E2=80=99s local
> node without scattering kmalloc_node() calls throughout the code.
> NUMA-aware probing was added to PCI drivers in 2005 and has
> benefited them ever since.
>=20
> The asynchronous probe path already supports NUMA-node-aware
> probing via async_schedule_dev() in the driver core. Since NUMA
> affinity is orthogonal to sync/async probing, this patchset adds
> NUMA-node-aware support to the synchronous probe path.
>=20
> ** Background **
>=20
> The idea arose from a discussion with Bjorn and Danilo about a
> PCI-probe issue [1]:
>=20
> when PCI devices on the same NUMA node are probed asynchronously,
> pci_call_probe() calls work_on_cpu(), pins every probe worker to
> the same CPU inside that node, and forces the probes to run serially.
>=20
> Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
> 2.4 GHz processor (all on CPU 0):
>=20
>   nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
>   nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
>   nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns
>=20
> Since the driver core already provides NUMA-node-aware asynchronous
> probing, we can extend the same capability to the synchronous probe
> path. This solves the issue and lets other drivers benefit from
> NUMA-local initialization as well.

I like that from a global benefit perspective, but not necessarily from
a regression perspective. Is there a minimal fix to PCI to make its
current workqueue unbound, then if that goes well come back and move all
devices into this scheme?=
