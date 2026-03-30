Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A62A1BF;
	Mon, 30 Mar 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774830675; cv=fail; b=AnSUrN0JNpECIQTRD4LLnC4HW4l3SQPjWDEvXLb3ck6phIdUZBPE+LBHepXmIsVUFODfIlit/8gNxmSbZlbKdBFk7TUR0O6Ob62blSeon5hopemHS75o37W8ImU5fJwEAHQ9yhJRiKFcBIjzfS8LRL2bsPKN7q008gh0tde0y0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774830675; c=relaxed/simple;
	bh=yjTLlx464/DcvHOjMEqlGTJWPx2LaAO3FnwGvv+wSWA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=V/5MkiLfJZHJIQPHdbMpv5W47myL3tG3JaCWWkpRUh94xfQ8W8BoNaxhe3yauCGvy87gyWXx8ccmERD7CmUsMyJTRk8Vu+48FGMXvw+crWtGRUi5heFT8aJCrARcglODUQQ6UQryg4omsuHxfo/hht6ZOYJw4squaCYQPl+ibAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg9fxBpO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg9fxBpO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774830674; x=1806366674;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yjTLlx464/DcvHOjMEqlGTJWPx2LaAO3FnwGvv+wSWA=;
  b=Eg9fxBpOTtQBhj8S7ACHfvT4prqBM40u1Nr71ZCmuyhACNw7KtThpGap
   ldVynM8oikcsP8yrthBc24VLadOkGV7sLpgz7qTxRs4FF2ebfNHGsFdvJ
   84bpSCnkiqI+aZd2PIKACr682fHWRZCgDwkYaI/6njyP334ngyz9aHpAb
   EfQWhLUeRKTAWW5Y/AqvLuV0NPZJJ/RRvV9Uy9D78aVRfDtjWThu1lrUz
   9kgie8ZNOTlGOscQXJgQYgvGnHMw2G1Z3IJi30lI/fGTQUYLwi4Ep4v/A
   G/WAublBSgOxsyXj54ecGCGm2/uEOeR1mUqF5OiB1xufXOQIlDED9C0nq
   A==;
X-CSE-ConnectionGUID: nLpljtLKR/OKbDjCZHc+aA==
X-CSE-MsgGUID: 1KFCHuFBSFaJXoPSQ9kzLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75882126"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75882126"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:31:13 -0700
X-CSE-ConnectionGUID: cVmA+yR2RdyOSOSTsXLcPg==
X-CSE-MsgGUID: nGEkQg/JS1GAC2Uka+D9dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="222580313"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:31:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:31:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 17:31:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 17:31:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/tUbPAEUzcuDqrcESIibI9ZdCxUFwNmmFn5ENW9f9CSW8ycox5XoyJaSkjQnVtA6Hv0itZPQ+iz6kD8AHeJDvc1rWaXWRZ4jlSz9EPvEJr9JZxFwusZ8fZoDjvXsEvM1YM6YXzEDr8iX9Mu5olmpnuJDWh6Q4rTcoTZpXTtW7L4KYXNXj6hdUJlIIualRqTq1Uaag1/yS8mH5Hy/yyEkms7J2VOHP39z42YXLnh7QDNl5xM72i2n2TkB6tJkR2Uc8W/gMJk3/Do5o/r4FhG3buSGwyIWEe+fjaguaeS7TgqwtVV623nY5r7XL8k2TKdDMznn4UlP234KhtXY2goWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7+e1RZENF5D92j3I4/JOA1rvbtABc5TCRjUUzseHrk=;
 b=f9Kn3SMuvIEtEd8kjlDPlbW1QQReAalWAmLRiOrHrVAei1t9NIyoYjevpglYzJlwz8I3KxSUAkFROgK3ezfTAR7+0bcTc77rv8Hx9fayiNZckkgR7WXgS/85cdwoEOGOHHOQKAMoSWRL/Mcr5O1csqkmlT+qzxZEsaNsyI6CAn3/Dc+ODSVdThUmUoWeHeYe8O9G5y3Ziu3vftC2Wj/LJcfRtpGyxhI/PGvpZivTsAbySQjzXSd+zjG/tBfSEto/Mwp7CLTQ30Nsp44HNGIl1wztSqd76OnSbg9GkM3f6OCLcxSO+gWKHOiN25C6vRUTv8Y7R/dYWU+fg4ZjQcJ4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF2EEA5C68E.namprd11.prod.outlook.com (2603:10b6:f:fc02::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 00:31:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 00:31:09 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 17:31:06 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9c44ad84f2_1789041009e@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-7-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-7-terry.bowman@amd.com>
Subject: Re: [PATCH v16 06/10] PCI/CXL: Add RCH support to CXL handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF2EEA5C68E:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7c050d-396f-4132-9f5e-08de8df3a38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: hmxGMTRdV+DBdODW1U8g+vd82Hwz9sh1hbGmrPbhAmP7+ri+umnD0grUQKtbHo8i0HQd2C4iy9JagUdCV7WEPBLWJq4QxHHH34R4VKGn8VOi7J5D38Azmxu7dJLhfWATzPelhHFtCM6Oja1mrcvGD3qhnA8RCb1uzObaNE0KOWCg7F9H9c7QJatZIBruyvpO63uh9PSC2IcETtCSLJ7oK0oilmRgKV8EXdBHqcZYQ9FHBV0+jbqvZejXcnZGfpj23kYkxr1/kb170CjcstKPhwTyoWuLH8r1cb/TJJfsgQ5YlrdADKQNFm4CC28VPKsjPfLqX8gUNKdzY5mxhTgSC8E4+oJychNfDw8c/YF8USEHzJNqjubXQFQHaSInDicxZvIxE84qGArhzqM7NQpskmURTJ8+iHW34ybn9fvoG+KLunKsly4iXqzgW+3l/MxDcA3+A5o/NXstBqB7/h6BenEuFomAe2gN5Ng3yUSNQi+UhaUIqkN2pjtP/NouO6eUJXncRGCGct4tOEvNmwxcqXizTRPbW4u1WLoENlH1ZZaD5SZX5JO5b/yDd9pGbiKOwPZcSM26zB09K5oMHRuhnrstsIKo8ZaFKuSXAdO/PJ5LVYhEsvku37cbNvQ4IX6txkY4FoJhLDJ0lVeWCnq+8GVHOO1QCPawvLFxLxNU8b2Aw1brxLXrLtPTfBbN0s2kr1SDFVOwhOOeKIZ1duED1x1Lj6dP+PIHVNQPtJbsyawHhjx3IUB0vKTgbG9PVBsKykMNypXfbqqYxR3ADmNkzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dlekZUN29KeUs3cEtNSGlEZWZNaUh3Q01YQXl2MWtsTU9hSVRWdzlWV21o?=
 =?utf-8?B?L1QxM3lGZkZqaUJnUlo4K0dBL2txY2RkZ3FHcmpCa0plT3V4TTBYZ0U1NGVz?=
 =?utf-8?B?NHpreEhDanAzS0VCWmo5dkVtN0lBK0laSFRkUzhqdlgrOHNhSVJ1cXZUZXl6?=
 =?utf-8?B?ZXpTNVJWNWhabWoxbzdDSzJaV3dHa2cvcHRPZkpMYXF3bktScVFpVEwyZ05D?=
 =?utf-8?B?R2U5RHpmT05wRVZPbzNPTVprT0tqREJRUnRzV0d1TGRhcjZUZHpWMHRJK3FF?=
 =?utf-8?B?S2hjMVNoY0hFaTAycVdpelgwWXR4Um5yUmhOU3NSM3VCM0xzc0kxK3p3TGR5?=
 =?utf-8?B?V1hkdTNFUVgxT05RcThqU3ZHajAyTFNnMjFiUHIwbmxMWE1QTlovZWo2eG43?=
 =?utf-8?B?a1JvTy94b0pqbVgrRWozWWprRThMY1FaYVdYaWxCTmZjWFFHSndHYW9JSWxN?=
 =?utf-8?B?cmhjM0xtODFuamUxYzVIaWJFdnZFeDBCUFB6cHZuTGtPYjUvWkNKekJWMndX?=
 =?utf-8?B?T3lBQ1JGeTRrc0JCdEYzVmJIYitXTE0zbjFuK3UrUzRNU3ByaUQrRmRlS3U1?=
 =?utf-8?B?amdJRmtDK0VscUdVc3NSeUZ6TUhnL1lpdWZGMGI1aVdlQklyYStYU0dWMVRN?=
 =?utf-8?B?L1A2VEs1UHI1UkRyajEvTURwakpyRndyNHRnTTB3N2x1dE55ZjVIRVVRRlNz?=
 =?utf-8?B?L0FNZWhPOEJKZmpmKzd5S1B2NGxuQ3RxLzQxT3JTSDdaQm53cnltTU16dE54?=
 =?utf-8?B?bmpvMlBibGp6RHVObmJWbm5sT0xqL2NFdDBRbVF0SEl5cEhaRjI4dm5UNzRy?=
 =?utf-8?B?TjlvOUtxOUFNSTN0TnZQU0tWVzNNdFhTZG5GcUdhZjlrRGExbVBYUFpsWGxE?=
 =?utf-8?B?L3lkV2IzZGpWak9ONCtodUM1bG1EQld6MGVIdUJQUE9QN2NxaTVXejhJdXhy?=
 =?utf-8?B?Mk5TQlFkT0lCZEhoT3kvNGRnOUxPbjBjd3Z2anRyTlF1V0wzNHIxVm1KOEN1?=
 =?utf-8?B?YU0yMjg0eFAxOVBWa2dPdzgvK3ozYnBPRUt1bXlMRUdjR0lNUGFFM0RiZ1Ri?=
 =?utf-8?B?RWJMSlRvYnVCZk1ib3dSYXR5TFZtbGtncTRRVmJNYkVIdEVwVnlZdytUQXRi?=
 =?utf-8?B?bDFSUDVaZHlHK1pCRnp2YWlsaTFVMXN0amdMYXJaM1FqWWt6Ym54SHFKeVhU?=
 =?utf-8?B?OG95ZVkxZHQzOXliZHRvbzJ4Y2toNU9EL0Q0OEd4YnRMbFF0NzluTWl6UlNx?=
 =?utf-8?B?bm1tVHhyeWhhU1JiS2s3bHgzZEZzVStoSkgrMktvZHMzVEx4VkNDNHUvOEtm?=
 =?utf-8?B?RWRnUldSMThMbEJmNEVFUlNobXVGRXdObXpMWHFzZzRXNnRBeTNva0R0bUQ5?=
 =?utf-8?B?ZXRQdHJaNHB2NUFlME12TVVDdkh2NFJ2TThOQm80UjVqRi9lUDFLOWEzZC9X?=
 =?utf-8?B?RVlkalJHcDhQb3kwUko5bXdEcWNwR2dTUFFUTXlmdXdlNGo2ZEtmRHJ6UXAy?=
 =?utf-8?B?SkQ0OHZDT3I0ZHF1eG05Ylpkcjl0aE9RWHZreUJhOGhYNThhUHlucUZlZkd3?=
 =?utf-8?B?Q0tGVGMxQXUwd21ydzI0OTM4UkQ2TXNudHcvQ3oycnMzWHNhMzdNSU81N0l1?=
 =?utf-8?B?TzRnN3FwZ0l0ancxT092ci9TNElNMktjcktla3VHVnN0bS82a2xjUUREdGo5?=
 =?utf-8?B?c3k4aER3QXRrWExlcHliSXJJcGlvMmZpeDdtUFdEaXdpbzdhK0Q3R2ZBM091?=
 =?utf-8?B?RlJKZk5kY2UvczJZT3FEK0NOcHRDZ2lQTDV0OTVVRTUyQzVORXpwWkl1eWJy?=
 =?utf-8?B?SU9GUHFkTHlMVTBnaVF1WTlRb1c5L2dOMzdpUG53d0VGVDRBN2JFcHkvamtL?=
 =?utf-8?B?b1FDT0R1SmRZTGhXM1d1RDBEblJpcDJ6WU9BQ1VMUnE4Y0F3azRFTnpYSlMy?=
 =?utf-8?B?TmV2UERkdUJjMXRuV1U5aWgwYzRrU1plMkNqMUVoY1d6c1ZoNE5oRDVhRnBR?=
 =?utf-8?B?YmR0WEdYNHNHY2FGNGQwUFArdkhGMnRRVzlNYUlHdlQ4U3ZpYlgvajRZcXFi?=
 =?utf-8?B?Y0Y0Yno0ajExSThrdzVoNTE3NlRMYlVqa0ZNZDdmZGNwNHEwZ2o2ZWpJTVdL?=
 =?utf-8?B?NDlYMmp6cHhFblNMZkRNVlczSTNJaXZKcWgxVjFjSjZSdHEwODVUYnQzcUU5?=
 =?utf-8?B?OGQ2akpVT2ZOWWtlOVhGRHBsUUlReUU4ZjA2ZHJTa0hUUTU2WHVHd25hMFhL?=
 =?utf-8?B?SEpONy9PWUZISlltSlpSRVFpWXFBcW1sRzQwUkdDNU10dno4NE9mLzJRRjlP?=
 =?utf-8?B?VjF4ZjQ0V2VPRWFqN1lUbWR4OE5GRTJDV0VMeFhZdHlIK1dzcTZhLzV5VnZv?=
 =?utf-8?Q?cBqzi8vjR4/MMkBI=3D?=
X-Exchange-RoutingPolicyChecked: LeJMlv7GxsuXcfqnm1PwN0lQJg+pTqDeGox5F2J55QYZMOueVwlC7XWeugJnjL2U39wDQ9aHQ/hQq4qSv/FPs/gF9JUKQNQGfqtKJDdjYgVWxRQH7gfzal3E1sIgTiOrF1manle+XDaaN5WYrfDISHtoeolNFEVUHYh1CJjO0+cmPoLKPcLMmJgTrLKTKkgXFmVrfhtoyxZnD+xYIjCJLqpquuSHe7mbMwODddfdqMyhfBbwhc+6ZG/dfhzHMaN26tZ33N2Y3tj+paXG2gI1VpPVZU7Lyoy3Ru7cB3Cf8dPfG2Zs1h+e0Ik8gJZBJcH1jpQgXgelIjivCUeTzed7ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7c050d-396f-4132-9f5e-08de8df3a38d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 00:31:09.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WMjRcnwFsaCPHLNmMKo4aTNOgpTSkJomt6EHRTn0a8olrBQtZdqc2bKzCPAhBcWOSNCm1KAGdstwmpSj4tGwH+N+PLt5Tz22EbokYseSiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2EEA5C68E
X-OriginatorOrg: intel.com

"PCI/CXL: Add RCH support to CXL handlers" makes it sounds like this is
a brand new capability rather than converting old support to new
infrastructure.

This is more:

PCI/CXL: Forward RCD errors to the CXL port error handler

Terry Bowman wrote:
> Restricted CXL Host (RCH) error handling is not currently supported by the
> CXL Port error handling flow.

It is awkward to reference brand new infrastructure in a series as
legacy ("not currently supported"). It is useful to quickly set context.

"Now that the PCI core is prepared to forward CXL port errors via a
kfifo and the CXL core is prepared to receive them, it allows for
additional unification. Convert the existing "Restricted CXL Host" (CXL
1.x "RCH") error handling from custom error handlers in the "cxl_pci"
driver to generic CXL port error handlers in the CXL core.

> Integrate the existing RCH error handling
> into the new Port error handling.
> 
> Update cxl_rch_handle_error_iter() to forward the RCH protocol error using
> the AER-CXL kfifo.
> 
> Update cxl_handle_proto_error() to begin the RCH error handling with a call
> to cxl_handle_rdport_errors(). This function handles both correctable and
> uncorrectable RCH protocol errors.
> 
> Change the cxl_handle_rdport_errors() function parameter from a CXL device
> state to a PCI device.
> 
> Report the serial number of the RCD Endpoint in the RCH logging. This
> is used to associate the RCH with the RCD in the logs.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Patch looks ok, but it will cause some adjustments to the fixup patch I
shared against patch5. I still need to rebase all my proposed fixups to
the end of this series.
