Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFF1427A
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702156; cv=fail; b=iG/yCt8q0GNxr5DeKVO+5dD0QgyySWwIJP2kzahyOYauYoWsoUVXQQwujtEsTkOuvFHElHFiwNw30Z5w3unekU/m6f3uG0LNOjffGMhK6uhRGV+NiJrf5i/PWX4LIGSzQpndTp30tz+0V1rnfsmVJU1lmHjrNvTUcmL/DoFXXGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702156; c=relaxed/simple;
	bh=hzqbh5oSAIj0GZdnixMbnJoSd+sefOSTF2zkj2mXdVc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WtrUDEfKZW3z19j1HUiph5KcKd5Q268Zy1/8zX6Ntt95eRHf9NmszoBUb0JfsqmnGhcD+TXckLO/vDkludoBqE0DMSzWEoARS4SRnfjKL0zHvmTneGbPIe6PnBBsHCu2OW3NiSJ+qoMEdh/3E+C1arRAAi6BJoQd4KLGNPUivAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr7H1gcR; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr7H1gcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773702154; x=1805238154;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hzqbh5oSAIj0GZdnixMbnJoSd+sefOSTF2zkj2mXdVc=;
  b=Qr7H1gcROGE4HQyg4/5ZMO4EIjW8GUvA+NTcImwWuaDv8oQRLTGBKDVu
   x3XLDwuaJGu3kFU9kf+wk1riPxL+iHMs/XK6JmB+SZZFca6VAloMoUmnz
   10SrVRXXP2MqpPCXjQmEEJfmz89YMqocYJpMO5DqTdnbyC16cG46kreOL
   StNuuxmvoZ27u7zAwGwAxKgbTZQlloFerEk3IwERESTI41YOklVlz2KnV
   a/77Ncw90FXzsnamge4+dWBijP3+JUg++IUNNuV8+9WEBHKOlUulYgeVN
   /JlVPtTp0KeJriHXxVQknJMPWb2tIL1iF1LSlp6S5pUPyVli61mBbbCMt
   w==;
X-CSE-ConnectionGUID: Hs32CnUgSuOJG1j2GqNqag==
X-CSE-MsgGUID: TnaH4OMmQU+RDBytXWdEzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74644718"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74644718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:02:34 -0700
X-CSE-ConnectionGUID: 7V+vqTgRQXipXihBvRqraw==
X-CSE-MsgGUID: VLy+rFDfTlSarfvxgget/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221098319"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:02:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 16:02:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 16:02:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 16:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D29+1wQHp3Z4Egx3L7NGh8jnM9CGBkkaj5iBDVGvRT8XP7UGB9DHd+vbY8JX2Rb17FIEGKnqZHxNn+pnkCA2vRxta66nhsx2S65k9cRzWYWaT7/8Gb7cXwjG0zcMDV7FzAzNjNgrZ0Fku1XyK6xu21ME/U43pkGSidjuHVUEG4m0puuAlMhvaRm+oabzbZE/w+1SRwsiSlxxHJKXQ+2qkb7DlqVE0k19lbBKfDnenVxFRyqUuZBUy1JYqhRFCdogZclm8f8ApAqOZCRWJOTBh6mrCOTeHLDznQR/b1xo1Gy4Zna61X6NhXxT13cxFAAowwj37BTXEDZMZSehYEESrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMYBF0yrKpdj7y4QkNjhYfgZwF2YS0O+j5CxwiZ0R1M=;
 b=W2HijK9sfEiRQAcHi6VGUP+911cQZB3fAuyc/YGZfldQWARNoW/naVBdLxw16zYMeSnGP1OJD6s9PF2NYXMreJbYeRuhhMSqTA/ecMLxWCCJO4uCE36XU7gfCKHGiaQIn30/tXqK+8BW5caB3nAil26gLztuhCqH2IVokMIymUooSnjhUeb3iLVZswyRD8IlmmyWi9CIKIKv5i+pzQMzvZc+bTVxCphORMDQ1rGVaTVIVcb6naYVMWmMAq9iiBkOe7tfVcJDPA0nTdt+MGzE7+DwCi/rTe6Uxm4N+nuhUie+YSP86aNGy5lsJ8UQHv7YUEEsvmO5tiaFauDSBrSIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 23:02:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 23:02:24 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Mar 2026 16:02:22 -0700
To: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
Message-ID: <69b88bfe2662f_40c01002c@dwillia2-mobl4.notmuch>
In-Reply-To: <69b8646c8aeb1_452b100aa@dwillia2-mobl4.notmuch>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abWq1oiE-YkksxNu@wunner.de>
 <69b8646c8aeb1_452b100aa@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f19066-81e8-42ce-ead2-08de83b015e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: S3rrC1yC6+dg5/wxDHhSUQ/EoP92ebQgJHytSC0Udupv+Ao4LJdfg19gHVy8vIuO4gnpG6v2HP7GOgEeHsEhDhXSU+bNx8JwYXq49SI6HIv8AD6sSIcBc6+NAM2Asxoi29qExNXF0PUhNQs+aQ/c9Y9YiqN08EnXgYJk/y4O2WwtNWlafgcvUMCXaZE5s3en8yXbWV1nII/Y6zz+K7erDXlvcUI49ReZZ5PPAiK7NkkC72PJaQ2bSuIpRJ6hHjdYQB57to6GdgIp041ZE2k1jK4waOpsmi4K13IXWOmbCaiTdT/7FRHiRY4AwglTy151y3qY5EEScgs+xHlNa25KAHojDEvCF4rToN9F1BJbpC2JKqj7N0fByx45d2bOScldH+jjikIRZUVwxcnY2L/ys6unB5pB4NN8Z9i9GWEjMnRvWp14eNgmZlOIJu5S52BwLFAamBxNKq9v8HQBSc0V8a+WQ+niYbrWjUasquQ13QqnD2zqbEBfI0hp+i2ZcgFo8XxU1bvfXnpto++M/kg3do2qrV80qhw15JyDCHWwkntOG1wnn3sawIt/uP3QfmE0vCCV5DNomSSjEJxlJuLCn4ce3Ym6/pmV+V12wVwzw+66d3wlnsl0+L2fr+MOpYjD+jrHMM2zHUNL4JbsAXQ0DcBKy5PCu3PiVQKy4skGzZ+z2R8ac/d/ewxL9POp75hZlRl1A500RYN6b/7ggc6AQBzbJXrJsJ5IyVd1hyI5thR8xtpua1mjB8kj+ZIANUjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hqM01yUytXSXc3RkxjSVdXM3VPaEhGeDVveDEvVnB1Y0RrTU5IeEtXeEhi?=
 =?utf-8?B?MVRYZmRQbzhGSjk2aHF1cHRkZ2gvenNObGVZRUlGMC9yOGxmM200a2VvbkEr?=
 =?utf-8?B?cFlOSFhpYkVwZDJBZDYzc1RyMER4Vzd5dnVtUE5JQjloRWh2WVBKcDZvVkRv?=
 =?utf-8?B?Q09yb3lma24zQklGTjZJc0tqdjhUTGVTUEtuV21yQncxYkZRVGtxNVBGUkVa?=
 =?utf-8?B?aUFkQkp4TkNwV0NWTHIzTm01RHVxMXZzNUI5MDdHejlMV0RjdUtwQktpVHVR?=
 =?utf-8?B?WTI2dW5ZL0l1Z3llZ0RFL2QraUsrd09Ea1AvTEdVZEFucUJoOEZ0Z1lMT0Q4?=
 =?utf-8?B?b2dQR1Fwemx0UmdLWjZSSitnb2V0SlVMMjRkMExtTXN3UmhCWWNiaE5IWWpY?=
 =?utf-8?B?MFBLOUxPSmFKTjFvVnhKeHJ4UkdJLzJpK09DOTQxNjFKVmtaNGxhbG11UThu?=
 =?utf-8?B?a0VoZlQ4aUxlZC9YWERSUHkyNlFhZklZbzZtRUtTY05JVitSaDVQNVhmYWMw?=
 =?utf-8?B?MityNXR3elJ0clhzbDdXSFBVS2JEQ1pEWU01dEZySHQ2R3FFSjE5dFMxSG85?=
 =?utf-8?B?cHl0S3UyNXJ1b2JqMmprMFAxTUlaNlZsZzNkOTZLNEVvNnQ2VzJCckxGKzV3?=
 =?utf-8?B?c2VXQkQ2cmwrS25IZWNqM2RyL1hLZWZBbGZTMWFsb29hZWtKVFhIbTAyYkls?=
 =?utf-8?B?TERzY2pnOTVQTFcxVUJWL0JrdjNOdVVrZHF0ODJ1Z09hOW9Wa2VjZnFteHhO?=
 =?utf-8?B?Vzc4S2J2N3IrNURGSDdHSm5rczlhWTJuTFV5V094amdDbG54eEFxM3BZNFhK?=
 =?utf-8?B?Z2tJd0MvdVA1YmJtT1ZyMFlVVFlmMVplUFNqM3Rld1FrQUhSQlFqTnZZQmFY?=
 =?utf-8?B?RVByWGw0ZTl0djBTNFhJY0Fqc055RU5lZGJSS3FqV2hrWkhEaUpUTDduRVBy?=
 =?utf-8?B?dTJoQXZXZ29Nb3M2OFhZdFZ3bkpIVnA0WWI3L0cwTnUwRzlIeUF4SFNUSnRU?=
 =?utf-8?B?MTc2dWtLcGZLam9aNHd2WStWUldBOEdYMm5CQ0Q2Y2NuNzdIbkdwTTNyNDd4?=
 =?utf-8?B?TDdEWURhd2hXWFJJQk4rRU1od3MxZUZwRTJGSUZlSFFjYjN5YWQrbnVzQWlV?=
 =?utf-8?B?VEFVNzFoVVBxS1pudmRZY3lyRlRMM08wS2Z2d21sbkZtcGp3aS9JUzVpSVZa?=
 =?utf-8?B?Z1c0b05SRXJNbDQ1T0NZUTFRYmNEN2hHZng2YWRaOFB5S1RzaUtBVkJYUVVn?=
 =?utf-8?B?QllIczdmRDAzbFZ2cGI1VGZqK0JNSVRLMVBuL2NJUlFTZXRscFN4Rm1jaWxs?=
 =?utf-8?B?eUl4cTdrSDhHNTJqUzlLaUxJbVBwUVVKbldUcHdybndlS1JrVGVEL1BVOHhZ?=
 =?utf-8?B?QllqMlB1NnFQNFAyc2dUWGcwY2FXTWFEQzJvYTlmUlV1ZzhsQnliNXpJanBk?=
 =?utf-8?B?UGtuTHVxTTBtcWJ0Y2NZWEx6UUJleFc3M25IK0hQN0pudi9wUUJ2Qlh1My9q?=
 =?utf-8?B?VGhpVGtIZkdCeWNNSEZjY1JuQkM2UkNBZG9kTUk0bUZaZm0vTGYrUXRvWjho?=
 =?utf-8?B?cjJRK3BTQUR1d0xzckliUXVNOWR1UHJIZHBzMEZDZlB5cFd5S0lQL3JmQmxX?=
 =?utf-8?B?YkJ4bE1nQ2hXT3hEYll6cXMvMmlKV2hRaXhCRnhCMjJXdFk2S0JvTmIyZUph?=
 =?utf-8?B?bkhOb2U4SmZIMk9waUxVeUdwaE1CUGNZSjVDdlNyNGszdThRK3pCM2hreGJs?=
 =?utf-8?B?WFpNUU5MZmw2YU9qcHlodUk0RTR4TWMxbktWS0JtelY3UmVUaXJZTGphTGxV?=
 =?utf-8?B?RWR1WUw3dFlJdnVNeXdLMzlQdCsyRWdwdS85UHhqY3BZOUp6a1c2NThRMStR?=
 =?utf-8?B?Z0puWHF3NEt4MzBrU1dGdWtwaUlxb0trbGRxMThhQ29MUEt1S3hKUjZybVMy?=
 =?utf-8?B?UmZQcHBwNWV0dFY4SmE4Y3BTaEZDeGdTYTN0dzFIT3VVckIyR21ySVNaZmhV?=
 =?utf-8?B?aGFnMzZ4eUJGb3VteGFZdHFMUWMzV2R0L2hRVTF6emZ1QmkwUUZmOUFsY2JJ?=
 =?utf-8?B?dkp4WUtpdXhhUzJaMlkyaldZL0djNnlTbUVUWWZHVzBWMm9ESzRYM3NKRXhV?=
 =?utf-8?B?ZjVhWHptMXlLaDRUNmFDZzAvQWx6a2h6TVNSVFZzTTllb1BZZUlnR05Ca3pL?=
 =?utf-8?B?QnpsVkY1VVlXK0tEekpsMStKQVRkQ0ZZTlZidWtFZXZvKzZBb3JMWXFqaC8x?=
 =?utf-8?B?ekprQlVoLzNzaVRRMDBmWkxqVDRKaGhrU2pEQVN4M2pYVm5DMStxVkFiaEJm?=
 =?utf-8?B?Y3pvOE9BTWJsNEswWnNId2dmMmNVVmFnY3VZYnYybWRxTWdVdEZXeDAyYW1a?=
 =?utf-8?Q?boG+fvM1Y6OvqcYs=3D?=
X-Exchange-RoutingPolicyChecked: kYuLt0gdhYZ+xv8R9gJ4zl8RFFXaAStPbzGu8u4V25L96fJxswYmFGH9YdzxLb3EjOFAjorOYZXI2xIbgiD+iSAuc63wQx1td5xGjir2kNfasz3fP66idl/w86Wyh9MtPILgPli1riHCf1CW95KMihbRmpUhMYeHNRwLWFrUp+KDDqeLoWgr2Vj+3QJyKxJyHEFaU+w6eEPeCYDhSQrkCbftiL2nLel75vHpDxPEHLaenDRZdegK32KYDD+8CrnsxGkAiJ3zvSe/mZuYKzo5bGV+hDWr718pCXIbT809Yw9X+DBB0ZVBIu5+i+aCt2xHGlctXR7/eMJ7XJ2pnQCudA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f19066-81e8-42ce-ead2-08de83b015e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:02:24.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NkKYezVVdteiG8+85ohR0hvXrhBVnsdU8SfaZDxuX8/xhDWgrO6FBIKkEu5mtyQhUfrXkJKELjW7Z6U5tgmIZ3OSxSyG+SWDq8TFMDWVjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Lukas Wunner wrote:
> > On Mon, Mar 02, 2026 at 04:01:56PM -0800, Dan Williams wrote:
> > > +definitions:
> > > +  -
> > > +    type: const
> > > +    name: max-object-size
> > > +    value: 0x01000000
> > [...]
> > > +      -
> > > +        name: val
> > > +        type: binary
> > > +        checks:
> > > +          max-len: max-obj-size
> > 
> > The length of a netlink attribute is a 16-bit value, so a 16 MByte value
> > (0x01000000) won't fit.
> > 
> > Moreover you're referencing max-obj-size but are defining max-object-size.
> 
> Good catch, not sure why the tooling did not complain.

This ends up not being a problem because 'val' is not referenced by a
request, only a reply. The automatic code generation does not generate
an nla_policy for replies. It should just be deleted because, see
below...

> > This doesn't look like it's ever been tested, so at the very least
> > it should be marked RFC in the subject to convey that it's not yet
> > in a cut-and-dried state.
> 
> The 16MB limit has indeed not been tested, the test script in this set
> was using smaller than 64K payloads to check out the interface.

So 16MB works ok, slow, but works. A given attribute in this
implementation never exceeds the limit because the protocol is for
assembly of a bulk attribute over multiple messages.

> The RFC comment for this piece is fair. The whole became a v2 based on
> the maturity of other proposals that were in v1. This "evidence"
> proposal deserves its own conversation.
> 
> > The two top-most commits on my development branch have solved the
> > size problem and may serve as a template:
> > 
> > https://github.com/l1k/linux/commits/doe
> 
> I was concerned that gets the same "too inventive" feedback from netdev
> folks, but I ended up triggering the same with a broken alternate
> proposal.

I think your patches address the performance problem if userspace passes
large recieve buffers, but I do not think we need to make that a
userspace requirement.
