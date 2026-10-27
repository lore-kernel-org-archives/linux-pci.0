Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793119918;
	b=5jdbCuyMMn1jPxgvuhpwgoF0MjC+hcc4ijjIYTG8BZ80PSVPSi4eQ7fMHC7yct1Xi+93
	 KIjbX7lCPF0j+ZfGgSj9/mRY+mf202+6IiAIFC6cg3UsWLpT+iXIgyCZp6vnFWbozhBPh
	 I2aBmX16N9nbdlGoD+mHXjZ7e2I6uGLDZiyxoKL5ZKecBUksD4nJ+0jZ5kNU4cX6GhtRD
	 2ZdYQQOqX97L7WYKg6i+a5Hg8tT/zUzkcKGrYagQG0raqtUc6CuTmRAD3EKgzYH5PWcPd
	 3XZQGxZhvrhjOQnVxZVBnjdDApEbDt0H23+ylG/lx/V1QkxdggtLBn8jSAyo1b+Ws0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119918;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
	 References:From:Content-Language:CC:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=HvCDg419zTFn+0QLpLoJee30ZQONpRG0RioLpq12Ufw=;
	b=t5OQPUu77HUmlUem3FnGpzgdIqmufX/xzBCl7yYabLrIsqwjQPYbXVa0HhRLcoLQHKpO
	 NbarL+Y/yDj5DtYPbjEE1P47BGaM9I6qAvjhnSKZ3A1NenIBV/PI+LBuvHl7taEvqsR0J
	 R2GSsXPmtOYHD3lX2l3C3tpGpp+GZYOI8MbLnOpb9H9so53ZZzcpS1yAhsgLWgm4ZoHaw
	 5eutavaJ1JkG9B6sVZHNWADZ3uID5wizdW9dwvyWNeAuakvX6+/l2TF9n4VMNtN29wXmi
	 kSrvqJ205OgVF5cifOlGLUujSuuD9RueUU2ccAj1p+OxNynU0gLWI3Q5zujGosNGhxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6ak0naA;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0010606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0010606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6ak0naA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793119916; x=1824655916;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/naa8ir761U9ygQPaJhbfCugKukSByta/Hqe4Ze2AwU=;
  b=N6ak0naAbB4Ksvxb2mnJhHo83HswdGA0Ol3bdlFS83X2+l+1WGPJ88B6
   dSNQj5nFhsDk4Tdu67nzVkYVjDtOjEOA9iLiR/v6CVnODWOigWF/0qMBO
   acEMwboFQ6U8Zcc2mtDUblf6vT/BdoB1TFMRp9Hd07GmVERRD0Qca1hxM
   TxUSHZ1rMjK9b4IvZ2UHHrGtVUkevhGk8+tQoA0i/rlumgaWhoo8wsInL
   1GJ9KJ9VIbbCWMIqttvEe4kNrnUiC3NV7jKWyidVZ5/YNALj17ahFFfCD
   unHZwRFoR+TFBP665mx3+qK8cmS1hplck7rpE4YQZuG13O9QmMMyBj4/+
   Q==;
X-CSE-ConnectionGUID: 6F8JBAvkT/ybvWz3cs048A==
X-CSE-MsgGUID: bXFAAgoyTguzzz0+oA14xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1848654"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1848654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:51:56 -0700
X-CSE-ConnectionGUID: yEZIdzyyScuLjeSXB5+xCA==
X-CSE-MsgGUID: 74/7vKMIT+O7XTjMVQUTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4605125"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:51:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:51:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 09:51:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMIZYFBpzaU6gKKLn9flL0iQtRGu0W/NkjWPadth6vwwrFlTdyzp5MhiCrJyT7c1S1SzladIGUmKgtBLla15E5b7RavZV4JgCdwBkfANSb+pu6lrba8w//Tg5Xp8nA23aGE9UzjNlgo5BoYuV6eeNwC2pjEpJBDzikqXFyx/mXq1Yi4LNKy3SSFuVWGf182dqe9frBV+dmRwDV+WGKBd4JRNhE0OGn4D3GV8VOmBybR6A0yMKflTfSa9OdLf3UQsZarPEZ1ux5nrmdsm8w38q2YstmpNrog4mtDGVQ86J+BN511SXxMmz2OvRcBeYShm5ATlimSlpIPETAcPPe41kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvCDg419zTFn+0QLpLoJee30ZQONpRG0RioLpq12Ufw=;
 b=yKGZm9BifTMpiwYhrTkNIntrX4eDQk9m/9eWxB4BQspXfMq56OFoyXqoNRWIqOzDKcqs8yKkPnNl9OaYjai2LpGkPPdEXDKXzYBeG4x8Gf3ieE/RMcDgrDhTjJn2XdfY1HhjzFCCPJssGmudAQ9ClToZT66kquucfBFWbJeYeQ4T5ZqZ9yV7PWj98U+1bfe/lJmEU7E0BK1DhN1NmbKOKBtmwkBgRVi1ljrGBNE6533wKGDXjClhBx2IlE2mS7gzysZgEjFNg0J1iy2yUVvYOSCMAJg55pBjC5FTwme1RyPAFfXCJIMwGB6T6S9+ellIWt1A8PeyED800339q0hkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:51:50 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:51:50 +0000
Message-ID: <0576e676-b9b5-422b-8bbf-0643065c1bd5@intel.com>
Date: Tue, 27 Oct 2026 17:51:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
To: <sashiko-reviews@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<wangzhou1@hisilicon.com>, <qianweili@huawei.com>, <liulongfang@huawei.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-5-lukasz.laguna@intel.com>
 <sashiko-outbox-186926@kernel.org>
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
Content-Language: en-US
CC: <michal.winiarski@intel.com>, <bhelgaas@google.com>, <alex@shazbot.org>,
	<kevin.tian@intel.com>
In-Reply-To: <sashiko-outbox-186926@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0162.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::15) To IA1PR11MB6195.namprd11.prod.outlook.com
 (2603:10b6:208:3e9::8)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|IA1PR11MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: bde88b29-d363-4da5-f442-08df344a9885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|6133799003|22082099003|261026121527099003|3023799007|261021123027099003|10067099003|56012099006|11063799006|5023799004|4143699003|261022075727099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: z3La8CmHbv4tzp8OEY+m8u5/hVLK7FlwmtLMmgP2z/XbC+DOPQYTFGDgXyTcy1cfIAmfzjNIYjI14X/zeVTAlo1DLT8wjsUFXS4Fj/QlHN3VIod4oYRFCzAvkUXzdbVFlGtlg57zRWkO1PnS7HvGCftK3RC7jtLLXdoPaZBxeVP0VKTvgufvbDKhDtef2uo3w7A4cJ5Nf86I33vTQciULHnGifjCXcMa1LU0Gxymkt5GOvtkz5aOtjqQVQ4Olathrf2X4JN0jJPs0CxKbZNXCwk6i0xpzRkpUH9+JBF5J5AE4k1AUQyz1gTmcLlQ4Jq6Oj0zXoiHWs+7E+i7IGKQqO+GkvIacIJqiYBMJZ2g6MwTtrR3DgNNEZ205K94MhBo0ECqZEKJ+iDA41OxmZTemGlsfpzFFCyGe2Mkarng01MRl3A4Q4NANa2m8NqrTrLmzxuHV0D0p/2vMtf0SVU/KDcXRZ8JucItj1c8Q9yu0fx2f1OOT6N1K+7m59ON24xZc3wUxoEKQAH1fFiDXotmXx5jnjDtq2H/hLQOI8PaOTXC+ScJtuipKPC6MICxSBCV46sgZoyfeiC8M2dsA3+zkSJRBV2BBDVVRV/FYzpzFn/4uHuZRCX91nXYPgnlySs7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(6133799003)(22082099003)(261026121527099003)(3023799007)(261021123027099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022075727099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5OQUZQQmtCSEd6YUVFRHlaTDFIV1UyVkNnZ1NlcWdHY1A5Q2FJaHpyZDY1?=
 =?utf-8?B?TThFWW40M01xOExRTXZYYmFJZURJdVlhSnpYNWFPU1MzWXNlNFcxZi9UVzhZ?=
 =?utf-8?B?NFNrclpWdWJWSG1NaUpVN2xqVlN0NGg0eVpBZ0d3MFFxcURoNjQrT0laZ0Nu?=
 =?utf-8?B?dm5GMGd6SEJCbmRqSDA5MEFxOG8yTFlXSUkreGh4NFNZMlFDNVlTbDNxTXQr?=
 =?utf-8?B?WFpDQmFRR3Bzd3NBRnhhc0J3SS8rMUdxT2k0Y3o4SzQva21tVmJhU3BuMENy?=
 =?utf-8?B?VHVOZm12QyszOHA1SFBxUERWUTN3ZlZuRXpGb1VjazVwUmdZRFNiSWxBTzE0?=
 =?utf-8?B?QzNJd204QnMvb1pnVTdTVHZuajdsblR4Z2JXSlk0WFhOTVJtdGhlUGcrQ1NI?=
 =?utf-8?B?YS81WFFoV0g3TnhGZ25kMFpQMVl4N3JNeW1LWUozWTBzYkpwOCtFQU1SNTRx?=
 =?utf-8?B?SXJObHIyMmJZOTVqa2RkL0VOdDNFM2JWd2duRHgxbW5XUWlwc1l5aG0yS1lH?=
 =?utf-8?B?OGZBbWdpaFJqbnZSU2drT2Q5bVFndVh0T2VoZWhhSzFuY3lJQTJiNlBaUi85?=
 =?utf-8?B?emVDUDJXL0lpTVZtOFZrenA4YlVGT1o5RklMOFNVYlZ1U1RhaUpqNUNCaG1q?=
 =?utf-8?B?Q2FhUDVvNzF5Y25US3krS0RTVTNIVDZaeWdiZ0xmd1ZUTGJZSndBVHpobnN6?=
 =?utf-8?B?eElnRmNublJPcDZhV0NuZWxnaEdpTjg5OTgybFZrQVBOU2FZaGZqNXVhOS9T?=
 =?utf-8?B?NXFYMDJtVnB1ck1CeHNRS2FPUm5OdHhHVisxWUFlZ2dTcXl5aGlVampTWW1X?=
 =?utf-8?B?SGtmRTQyTGkzZVlHVnN4TlRmSG9zODRteks5Smh1RlVFb1orQ204S0tJeXl1?=
 =?utf-8?B?YkRTQ3FzVUQra2ZsZTJyVmlqaWs0NVZocU02WEQyRmxQR1ArWkVYRW1FNkVO?=
 =?utf-8?B?Ym9zbjNtcnhIaUZLYjFiTzZwVVhuekM5bVZWSURnWEhOTk13aFZVWXFpMXky?=
 =?utf-8?B?UFpJQ210Qm1LeWtTdC9kVUQxeTc2SUhMN1gwbGNDTGg4WGZEUzlOMDZwdjJX?=
 =?utf-8?B?VlpLSVBjSWR6YkNuNzZxYW9uOFpnNmlRejF1YlpTSVdvakllSnNKM0VjMEYy?=
 =?utf-8?B?R245YVlxTmZqQkc1YVBGVDJGdDNIT2N4Z0xRSG1EREppU0ozdjVwbHp5WHQ5?=
 =?utf-8?B?SEwxSW1VVmc0Uk1pWGI2Y0w4ZjlkaStIS2dUZ0dHajRBS3Y5K0VmVm9mbGg0?=
 =?utf-8?B?N3F6bHpUODJHVkpzRHBZU2R1U3kxb2hUYTJNS0huc0JmRmswYkJqSkFGLzBR?=
 =?utf-8?B?SlJoYlVQNFBnajI0NXg3SkE1R1ZCUFBteHZsRTh4NWVOZmNZUHg3cW5vUHNS?=
 =?utf-8?B?WGRyU2ZYeUFmcUh4aU1qeUtiV05nTGxZV3RnNDBzSVRlU0I0TnJvQlgwRmxk?=
 =?utf-8?B?M0xEQzlWSmVQNDl3WlpSYnhITzJUQUNueDRhS0V3d2xvck4zMWxycG4yUW1J?=
 =?utf-8?B?M3NJZlV3aDZ0ckY1cVJ1U3pnak4vS3ZnWHVhS2RQcCtvTGVJdUNNTDhGTURh?=
 =?utf-8?B?K0Q1NWROZnZZVU83Ky9tWUtnb3dVeXlycEZqZ3lKNFlEOTVjbjlsSXllTVBo?=
 =?utf-8?B?OWg0MUlWM2czVTUxZG5Vb1lBaEhkczBOcDk1SCtrejhpM0llekR6UVg4TzZ1?=
 =?utf-8?B?UzduT0RXckFZZTdxdmY1T2QwR3FhdXhkUzRkVjNET05MTGtvdlM4TXp3bEF3?=
 =?utf-8?B?aWg0L2JQbUY5c2MzR0graGxhMTZJNithVlhjYzRMaTlpVDhldlczRDhrS0dO?=
 =?utf-8?B?UnhpWFFJVGN2c05hdFpKK1J3VmgrOEpnRW5oU01aVnF6R3lTL2NlWlFCNHd3?=
 =?utf-8?B?V0pzazlIMDRUUjYwM1lFVXB5VjRLcldoajBTQ2pZaVVZblFPSTZBRFovSDAx?=
 =?utf-8?B?djE3N005ajZJMjF6VTNYbWxIY1VXVG1IRHlRVTk5OXc2by82dFdpRGZjMXhy?=
 =?utf-8?B?Znk1N0QxTDJtWGNJZmN6YTdwWC9pbUQwSXJSb0VKWFpDMHFsQWpuZ3VzM28z?=
 =?utf-8?B?VlgyTVNYaU52ckVtaFNGZ1ozZzRTd2pNYjJ0WlFvUkQ3enJVc3g1Q3RRQXVL?=
 =?utf-8?B?bzE0MVlXblRTc01Ndnk5MGdBT0t0M29PUGhBTWszTGd0Tk5Vb1E0ZzVoYW13?=
 =?utf-8?B?YXBKZ1gxeG5rTm1hMG8rYXo5MXZOTmJIRkFJdks4Z0hBc3I0aUpNRHpwdVg0?=
 =?utf-8?B?SFZkekwvRGtRb1poMXBzbzdJWmhkTHlOVlpGdmRtNGdIU2hyU0dwb05RdWg0?=
 =?utf-8?B?SWEvTVhmQlU3Q1NhUEtUVmwxNHF0czVwNDEzM1dSV2hEak1lTTBhQT09?=
X-Exchange-RoutingPolicyChecked: Fa7czxOpx35WdXznIEaWTxDRV+LMrHD+kodw6dg5zbWuAhRSPwAtgDx/0IMY7DlQSAYNK/KjW/QLokMqEaWawDanbgL7CGKnXsDNkAhIQ1UmWptt2HcJNcBeB8nHDX+8xvfy0rV8qU7T1mjZVkuV8uOppNGD7BEhUEByybTSFSFfvb03mBonrHr+1iPyqRt66sCbrV4WiMgGn47WYyaRPq+TrB6MTpvXcA5Zrsx4UZaqxuXRaCUvsS3oejEyOekb6B7tGhyXCTFwwIpo1dnwsjlE0sKk2qjLkp5iJNmFg8iYcp6nu5uI9jxxJD2sqU5jV22ATUbaOItTwCOlSRqqfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bde88b29-d363-4da5-f442-08df344a9885
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:51:50.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0VCruVtj2SINoRnlrPIu5r4OsiAynJWop5foycw6JjBF/0JzVSEjCjvUZ69iAWN+LFP1wMpISicoAMY6ceKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441
X-OriginatorOrg: intel.com



Adding HiSilicon QM and hisi-acc-vfio-pci maintainers.

Hi Zhou, Weili, Longfang,

The series [1] adds generic handling of VFs across a PF reset in the PCI 
core. On PF reset, the core now saves / restores all subordinate VFs 
config state, and notify their drivers via .reset_prepare() / 
.reset_done(), as VF state is lost on PF reset anyway.

Sashiko points out above [2], that this conflicts with the 
driver-specific VF handling in HiSilicon QM and hisi-acc-vfio-pci. It 
seems to be a valid point.

Could you please take a look and share your thoughts?

[1] 
https://lore.kernel.org/linux-pci/20261027160446.858300-1-lukasz.laguna@intel.com/
[2] https://lore.kernel.org/linux-pci/sashiko-outbox-186926@kernel.org/

Thanks,
Lukasz

On 10/27/2026 17:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] PCI/IOV: calling VF reset_prepare() before PF breaks hisi_qm PF FLR
> --
>
> commit b82e20ef0c7a057bbb242268e11b3dd9218fd7d8
> Author: Michał Winiarski <michal.winiarski@intel.com>
>
> PCI/IOV: Allow VF drivers to handle resets
>
> This commit updates PCI function, bus, and slot reset handling to lock
> enabled VFs, notify VF drivers via .reset_prepare() and .reset_done(), and
> save and restore VF configuration state across PF resets.
>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d8e7c7d8e4021..d088302547c34 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
> [ ... ]
>
>> @@ -5171,6 +5202,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>>   		return;
>>   
>>   	pci_save_state(dev);
>> +}
>> +
>> +static void pci_dev_save_and_disable(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *vf;
>> +
>> +	for_each_pci_vf(dev, vf)
>> +		pci_dev_reset_prepare_and_save(vf);
>> +
>> +	pci_dev_reset_prepare_and_save(dev);
> [Severity: High]
> Does calling .reset_prepare() on each VF before the PF here cause a
> self-blocking timeout and reset failure on HiSilicon QM devices
> (hisi_hpre, hisi_sec2, hisi_zip, and hisi_acc_vfio_pci) when resetting a PF
> with enabled VFs?
>
> In pci_dev_save_and_disable(), pci_dev_reset_prepare_and_save(vf) runs for
> every VF and then pci_dev_reset_prepare_and_save(dev) runs for the PF in the
> same thread before any .reset_done() callback is invoked in
> pci_dev_restore().
>
> When VFs are bound to hisi_acc_vfio_pci (where hisi_acc_vdev->pf_qm points
> to the PF's struct hisi_qm), the first VF's .reset_prepare() sets the reset
> bit on the shared PF qm->misc_ctl and holds it until .reset_done():
>
> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:
> hisi_acc_vf_pci_reset_prepare() {
> 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
> 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
> 	...
> 	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
> 		msleep(1);
> 		if (++delay > QM_RESET_WAIT_TIMEOUT) {
> 			dev_err(dev, "reset prepare failed\n");
> 			return;
> 		}
> 	}
> }
>
> Similarly, when VFs are bound to hisi_hpre, hisi_sec2, or hisi_zip on
> Kunpeng920, hisi_qm_reset_prepare() -> qm_reset_prepare_ready() acquires the
> same bit on pf_qm->misc_ctl via qm_wait_reset_finish(pf_qm) and only clears
> it in hisi_qm_reset_done() -> qm_reset_bit_clear():
>
> drivers/crypto/hisilicon/qm.c:
> qm_reset_prepare_ready() {
> 	struct pci_dev *pdev = qm->pdev;
> 	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
>
> 	if (qm->ver < QM_HW_V3)
> 		return qm_wait_reset_finish(pf_qm);
>
> 	return qm_wait_reset_finish(qm);
> }
>
> Because the first VF's .reset_done() has not run yet, every subsequent VF's
> .reset_prepare() and the PF's own hisi_qm_reset_prepare() will spin waiting
> for that bit on pf_qm->misc_ctl until the timeout expires, log an error, and
> return early without stopping the remaining VFs or the PF prior to the
> hardware reset.
>
> On Kunpeng930 (where qm->ver >= QM_HW_V3) with host-bound VFs, each VF's
> hisi_qm_reset_prepare() sets the bit on its own vf_qm->misc_ctl. When the PF
> subsequently runs hisi_qm_reset_prepare(), it notifies VFs via mailbox and
> waits for them:
>
> drivers/crypto/hisilicon/qm.c:
> hisi_qm_reset_prepare()
>    -> qm_try_stop_vfs()
>         -> qm_ping_all_vfs()
>         -> qm_wait_vf_prepare_finish()
>
> Each VF's mailbox work handler (qm_pf_reset_vf_process() ->
> qm_pf_reset_vf_prepare() -> qm_reset_prepare_ready(vf_qm)) then tries to
> acquire the bit on vf_qm->misc_ctl that is already held by that VF's own
> .reset_prepare(), timing out and causing the PF reset preparation to fail as
> well.
>
