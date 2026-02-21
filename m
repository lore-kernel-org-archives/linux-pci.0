Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF183312832;
	Sat, 21 Feb 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716610; cv=fail; b=EmbnxPopEOsXtPtuMId1d9zLtnPqz/0YV67KxsPYWJYDKzBBdIPU7jgsRyYQyr2bbtFGIuZ3Dj3R6iVQBxP6hFnmPXvw0IJ7uPAqhfejtofmyw1lJFO5CgV/lUtB69faJLhORHRNaJ+Rawc57Q+TllN8ILwvscIzoaqyKZGzCtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716610; c=relaxed/simple;
	bh=WyIarUhTnwoU06dvx6VCruejeauZeE8jIcpa+81x+wY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FI+jbFqsRAP82Zz+2qFq2GwZ81LPej1FB/6+ay4PnwIB4urA7NDCKRTNfgD4MlTmlLv2pxBP/umWYm+DL4UyVDjO+ew/sS4E6UVPehBewUKpAXg3oWO8r8NIIIu2NeXqJyw8tKuWgY1WTcu3cVChhFtsWUoFbSmxKvZGPzDSa3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUwsYHZT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUwsYHZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771716607; x=1803252607;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=WyIarUhTnwoU06dvx6VCruejeauZeE8jIcpa+81x+wY=;
  b=BUwsYHZT6EjomXWDgWJSfxydCqxHBfqpo86TrWQquvpT3JD8ljGDABfN
   a6ibIjh+MgvHiE51cURItaX2biP6glIa9jql1qhqeRDIEkns8fjMEBmIQ
   +HAKpg8xt0BxgiSX+oH5T+YlM5Y1wdRfn/yVsTz6I7zdkU0oCEyFrrUwE
   WICQ7sDYnSRjhuWwn5LIQBlH2Zkp7EVYTldoKi2tdHn/Zf1EU/IPp2Vn9
   gmYgtT55NcG7xvuT4cb25cIrJ/ToauVU5nLiP2KSnq67ddtKT13+D3kUy
   Fr4YarvUV6firbsJOHphnZjxCIhBXa+yTWqtB7PQDsn8fa6102Wm69fPy
   A==;
X-CSE-ConnectionGUID: iKkDzNeLTZmDmNSNXrfKvg==
X-CSE-MsgGUID: HUTpfp6gT4myiWJiBmPmKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11708"; a="75372085"
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="75372085"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 15:30:06 -0800
X-CSE-ConnectionGUID: Pq7SOof1ShiLbmDWftdU0g==
X-CSE-MsgGUID: FXcVDJJCTgCngYPYBn4rWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="215031628"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 15:30:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 21 Feb 2026 15:30:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 21 Feb 2026 15:30:05 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 21 Feb 2026 15:30:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nByYK6YM2VtQNVyumCLqdZTueLtGIUFXZgI/SGsj/x4suEeFX/ex5Iu38y/ONK/FsRWx7jeLTfhlZ737GcNj0UiWz+SPHHSUT+PvmY8U8VgzJJpZTWt1RtbVG+KThFmif0sqIo7ZKkWS3tVXbSrY3CuwmOPLIArN5ZZSAHOGk6KWqmRAmkOgSptjE3jelOukDciojdbi/ROC/HGDDcEYP8eM8xGWskrjCUHGrLMyXty6xLSLbMk7gbOv1952uh2C3nfhFuF4qatWPHsy0GTR9obNHesIYe/VccaLNVehRZzv/TRD6Ld9id/HjDt/IPSHNJoDU2rvi927Y7L9kaW/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hGWocWpwQMK2DT3s1Z79Po5QNPb51aSJmzGZUqxErE=;
 b=YnKo+TCKuwZ+Iw0mkZFHjy24SnaP+fgOfKnWS5T0Y1CDfuzmsyQxpd0i/w8+gcTDP9hsngKHG3A0JDonasHy8uikuaSgt/JtA8e5YATz0q/+Nsm0Hc+nzpZr9/26qZSjsvMEGRtqX247rEiiZCuMyQ5HabhOTXDP12xp6BkKtPvgZyW79V22ZKHqA+AE6UDEAM9ZB2imwHJgLu9zAVa4vtUcmnFwtVOMGA7vetFtsyIBfkBysjdC7EzXM+WxsTX4F6AGUw47ELJwclJYAf3mit68haHeRDLKegsC5CCuK3ZWhZTONiwA/3cJ1G9cwX4Br6DRSSNIklIbkXV3+b4Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6121.namprd11.prod.outlook.com (2603:10b6:208:3ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sat, 21 Feb
 2026 23:29:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 23:29:57 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 21 Feb 2026 15:29:55 -0800
To: Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, Alistair Francis <alistair23@gmail.com>,
	<bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Thomas Fossati <thomas.fossati@linaro.org>
Message-ID: <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
In-Reply-To: <aZn9cfhv0YRxI1mw@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8ab961-279b-4444-1c2a-08de71a1200a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MURlWERjMWpPVE1jVjFtblA0TVYzbWxwS3NxM1h5bHhZMjQ4WjBQaE4wWjJK?=
 =?utf-8?B?QTk2M0hUQmgwbU1MV2k0SWttb0pzdzdtNmhraGpJelJlY0ZJMjNVN0d1UUFo?=
 =?utf-8?B?bjFyOUpPd0dlYWdyYTluNnNxMktoM3VVQlh1VVN0SmtUeWs1TU1HYldqK0Rl?=
 =?utf-8?B?SEdSY2s4emJuSG9ET2hMbkVselFGenRrWE0vY29xL2FOM0V5L0FmL0E5V3hC?=
 =?utf-8?B?UHBlQzlVY1VsZzRLd0tFakJJNmR3NndpSEhha0pDMlUvT1J0U3c2ZWlXaENl?=
 =?utf-8?B?clU1d0IwSjQyQjlaRU5wWGk4L2czZ2hjR3RDY25KTHRsZDBvdzcvemY4Ukg4?=
 =?utf-8?B?LzQ3Y0UvTEx6MitVWXNxVjdQUjZOenNaUmsvTmM1K2szS0k2ZVl5Q3VpOEc1?=
 =?utf-8?B?UndmSXRteUpIa0lDSTZHczlsd3hTc2Urd1YxWkhVcnIvOUY1NjIvQXo2N3dY?=
 =?utf-8?B?QzFJWlYxd0YzYjJKRGFBSFAzZFlMd1lSaU9zYU5oKzkvT1BqTHVwU2ZzMC9R?=
 =?utf-8?B?eHh0SGxxWGVTc2FJU3pReW9QTlpaUUxaNW52Y0p1dXJDSUR0YkhMdkxLTmMx?=
 =?utf-8?B?eUlKemh1bi9WYVpHZzNaZnNKM20wNXBYZnB2bG1rak8xeFlyYjFmNTI2bThE?=
 =?utf-8?B?aisyVDJJOTNvaVJ6YmRkT3BqUkdjY0FyWmV6TjhhRVZCbDhONEZNMWswNTg3?=
 =?utf-8?B?SDZkdmdaQlJqNlBkOGUvV2xoN3hVNGZPS09RQTdmQmR3MW0va2Frd1A1VXRR?=
 =?utf-8?B?M0RXTkdRcTViY0xLZHYzUEdKNlEzeEhUbGp5eFZsMnZmYXhIbXJXcitYalNq?=
 =?utf-8?B?QWhZOU0zUzhEOHFOdndmQXZvMnVRRnY1V1VNbVVHWkVSRE53L1dZZzBKOXpz?=
 =?utf-8?B?Q25zeGl2SDBvdmYrWFVLMmY0ZnVXeVZSU3ZhYjZ1dm5oVXJKaEVXdW13WUdq?=
 =?utf-8?B?RlpkVEZPMGVrRkRPd3lOWVlQUUFYU29FekdONTVaeG5DaCtQYThNaCtMMnF0?=
 =?utf-8?B?dGZwUkM0dmRJZjh5RFduSDhnVktnNFlWZ2lab2NnZnlCUm16blRnUXhIdkQ4?=
 =?utf-8?B?M1JXMEF2Nm5DN0tYMUUrRHl1ZlM2L0EyL3Q5Qmx5Q1RxN0pHUzJRRXhrdGhZ?=
 =?utf-8?B?ZnpCNFNtcS8yaUE3NW00SThuNFMrK3dMN0QrNXAyQnBuR1pOUnd2TjVJMkc3?=
 =?utf-8?B?UUVTeW9DckJmS2cyU2d0Qk5pSDhOdnlPSVdUKytYT0diMUNLZVJrRkJycDJt?=
 =?utf-8?B?dURwbzhpTnNnOERHUVYwdXUzRVBHUVRPRUY3dDM5L29INVJkRG9NNmxCZ3ln?=
 =?utf-8?B?MUpXeE9lak9vazk2ZTNXL2M5QVFvRHRTMGJuUHY3YUxaRVhWMTdBbzdaL2Y4?=
 =?utf-8?B?MXUzL1NRVmgzQUZzclB0THpQRytVMC9heEFEUkcrZkxPNkZtRnBzbU9MSCtQ?=
 =?utf-8?B?YzRuQysyK2VjN09hUG9GRnAxWUo5VFNEWXZPc1RvcHp1N29HakQ0NU5YaTEr?=
 =?utf-8?B?amNIRmFXT1Z6RFZ1NUxyNlRjN21JWHVYM3FYS2FPYWpnOTJRYk8xaEpSZkkw?=
 =?utf-8?B?MnllQTYwYjN2ZitucXlmUXBjZjVMckRGL0V0TFNMY0dBckh5V3ArSWROdzdV?=
 =?utf-8?B?a2N6WFo5cUdKV0Q4QlVnbnFsQ2I1NURBMlpBMzRJMHAzQk5IU2NTU1RyeVdL?=
 =?utf-8?B?QWlyT3htemxIQkRZRjJRem9RYk5jdGgvSUVzcFpoSDFKWWV2ckZJbzl2RHBv?=
 =?utf-8?B?dkUrQm5EbENtUldGT3dVNnJIVjdaQlIydUtwR25wREVUc3FKOHhoV00xa0d1?=
 =?utf-8?B?ei84NFNOcExqbEd4OHJjSXVVeDQxRzR0T2R2YnN0Nml3aHUzSW04dTNObksv?=
 =?utf-8?B?YlZ4UnpKUGJsLytENXAvb0xYVWJkV2xmYjRNUnhJcHc4elplQnpheVVMZEpP?=
 =?utf-8?B?eVkrR043TzNrZFNFdVZqUnJFcDJOTEphSEtVRHNFcmV2eEg2TGpiVzBRa2Nv?=
 =?utf-8?B?ajYvOEFXNU5GaFJKbHhGMFVyZ1lyR1M5WkFMbFFmMUdoMmJRWmlQRHdnYnJV?=
 =?utf-8?B?OUNCQVFIMVpVOWhvd3FvUFNZcElveTRYV2JQemNIMWlSL0M2SW9YZlVaRXpv?=
 =?utf-8?Q?PJHs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FRM3JkRWYzaGQvOW5ud3E3eC9nWjhLbzU5bzVEZHBKMUdYR2RmRXR2NUxr?=
 =?utf-8?B?Y0F5aVdmbXhVaGdPQ00wdlFtb2VGenI2ZUMxT3JtMWlaWXhEb1RVVzBsUVZJ?=
 =?utf-8?B?Q3R3alBuTVgxWXlKMENaekhTQTg0aHZ6THhhWENrcUlORWloOGdWYmxwZmRk?=
 =?utf-8?B?aElIclZvMmdGVWtxVjhRaHp1cG1sRlF4b0oxcjBjZUlsTG5tVmVvVGpaNDhD?=
 =?utf-8?B?ZkdkaGhCaHRWVHZXRWFxK0hTaVhrL1VMOWg2SDBZNTJOTmZRKzBuMWJZTVlR?=
 =?utf-8?B?S0huNUJ4blk0VjBXMWZaNGxHUlZrQ0NiWmN5bkN4ZENKQkdwQUxhb0VBMDJy?=
 =?utf-8?B?VU80QkVpdlZiNDhLNml1OVdmakNkNE9iVVZjUlNkOGE0VURKaWRjbGU4MUdk?=
 =?utf-8?B?MUs1K08wM3IxN29JekFSTGNpWXo2SmhmY0FHeDEzNGp2Qk9FMmIrTUVSQUxm?=
 =?utf-8?B?SHlER0FGYjhKdXFMWHdzMXRMak5qSFdoOFVsaURxTGwyWGFYNDBEZHZCYXdH?=
 =?utf-8?B?V0RsOCtiQkFPVVM5RWN0SmQ1NTIzMDdkTG95UWVIay9GYkhvbTFWSTN0Tjl2?=
 =?utf-8?B?ZjFxaEVCUFZIcHZ0RHdJUjdnaHUrYWJPaUx3akFwbWw4KzBuQ0owNnRaMzl0?=
 =?utf-8?B?czdQMkcxUHFENmlTUFo1aUFHUkk5N3V6eDBkT0Zaa2tZVStSNVUwWUhzWmhp?=
 =?utf-8?B?bTFxeEJzekFodDJtc1YwYkpubWpSbE5OOGYzZ1JneDI0Z3dEZml1RXlqNUZn?=
 =?utf-8?B?Qk1tbUdhb09HUHJtVUxSQlFSaVhCVTFzUy9WbUo0eGtmK2NXWG5QODAySnU3?=
 =?utf-8?B?UkdFY0J0emsrcVlZTDJGRXNsMERPc0Y2ZGoxNTM2VkgwS1F3Umh3TTJUZkxx?=
 =?utf-8?B?dnFqb1lMc3BJTktiVngwYmV5QXg3UWpUaXd1YmZWVEljRFdKRmRjMm1MekhJ?=
 =?utf-8?B?dFROdUNWbE54VklERkh4cUtvc1o0TnJudituSks5TkE5VGhYbCtUU1VKMmlN?=
 =?utf-8?B?Wmh1VkpYODZVdno4d1dXc1BXM1dsdm93aElTMURCR1NLMFdzTVNvakt0Qkth?=
 =?utf-8?B?M3ppZFdYNFBtL2gvSFc1Wm9ZUHBaaTRwTXk4KzRVVHdLRC9ROVZNR1Frd0Jh?=
 =?utf-8?B?WjY0bHhpa0xPdldPRWVaenBjcTRLL3RicjBZYlJudWQrUEV1QlFpZWtFcjFD?=
 =?utf-8?B?eHhabVVZOUdtNkVyTGtkYzlVVkc1N2ZNNXlwRmdKTUNQUzYvNDlzUlBkZExv?=
 =?utf-8?B?N0p4TThRK0dhaXRSVGhlZndNNHN1bDhmSTMrMHZ0TTNtcTlrNEF1aGRYUEVu?=
 =?utf-8?B?SHlIWTFkYTQxVTlRc0VxMkRQZjlFSTdxTXhxUGpaanAvU3VMK0cxRkk4Rmtx?=
 =?utf-8?B?T0Z1NWtaWGZQTkRUdVp1WEU3aXZwdXlkVXhDNXZjSTVnSUg3RC9DWjBBakpQ?=
 =?utf-8?B?Y2grYXhOc0IyNzdKcTVpWkR0K1FDUlVWLy9QS2p2Sk1FZ1FVQlJwZFpsZWFD?=
 =?utf-8?B?ZmdsOG9ES0RuRGdscTAzc0FiNWFNWUZZZG5RRk1jdnpIOTBNc0pyLzl5c0g2?=
 =?utf-8?B?N3hHRnZKZDgxUVV4N0QrRkNSc2R0K3M3Tk43ODhTQysrUTB4NFNvQkxGYktJ?=
 =?utf-8?B?Q3ZjcmRtZjBmcE1XaDhxZlBXV2lzNFM5am1SKzBIQlB2QVVTUW8xbmpCeHM4?=
 =?utf-8?B?aWIyMkpRa1Z5Wk5mTnVzcDBTd0lGQWF6VGhLWTU0amRsdjk3bWVEbG50b0RX?=
 =?utf-8?B?ME1sZ2FhQmF6OVd0N0Y0UkdqcGVBWElHVUtuY1UwdW9CUUlBQ0lXdFRWOEVv?=
 =?utf-8?B?U0NWaHFPNHBqbXc3dUdnNzdBdW93TGNrbHRydElYK1I2MkNkMUJUemlva1JX?=
 =?utf-8?B?a2tSRk9MT2IzN01HNjdQN0c0ZUdOU1o2MUlCNVJIOG5RMEE1N2JFTkYxNncv?=
 =?utf-8?B?eEVRbnYwVy9uYTl3eENKODZYOVFGaTg3Mzc4eXRLaTdSL2ZmSjQ3Q2lYT29n?=
 =?utf-8?B?MXdzYU5IdzEyREhBUnZvckg0VHd3Z3RoUmo1VkdxbmswZXJuV3pFNEdZQTFr?=
 =?utf-8?B?ZHR2ay8za3RjRElNRGVjeVMzdTBNRnRtNjZCZThWTnllTEM3bFNNNVllMFpw?=
 =?utf-8?B?N1FKc2hCYUlvaE90Vzgyc1JmQWJnZG5QbTA5VFg2Rmo1bWVRT29QTVQwaXN1?=
 =?utf-8?B?ZTI5dFFTN2djYW5uM21zUkpiODNCSFdWd0tuUFE2UVdTV3JMaHNzUE15M0h0?=
 =?utf-8?B?QUJTNlpPZmFNN1FNSUtqcEVwdWlxMnZmMDg4MCs5cHByc0Z4VkdWdVg4M2dl?=
 =?utf-8?B?VjNraWR1TjFiVllERCtrUUlQTjZORVBoV1pXNlVZaU5Deklpcytkdm0zMGM2?=
 =?utf-8?Q?sQN4RZ5m9lWCRIH4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8ab961-279b-4444-1c2a-08de71a1200a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 23:29:57.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA5NNmuFRq79VPsQQ3e66+/9D8kCuYp+St4o+aZKUHcJgdC1ADr9FkbxF7rFlVlz8f/wdL+uaARQxWbaPo9pK5K+bbSm5grEDyf0O+8MC5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6121
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Fri, Feb 20, 2026 at 10:10:57AM -0400, Jason Gunthorpe wrote:
> > IOW the resume/RAS acceptance criteria is that the second nonce was
> > signed with the same private key(s) that the first nonce was signed
> > with.
[..]
> > Linux will have its own sw model, the spec is just the protocol
> > definition. In the CC world everyone just knows the verifier needs to
> > be external.. How else could it even work?
> 
> There are products out there which support CMA but not TDISP.
> In other words, the CC world isn't everything.  The modest goal
> of this series is to allow authentication of devices in compliance
> with PCIe r7.0 sec 6.31 and the SPDM spec.  I understand there are
> features and authentication modes which are important for the
> Confidential Computing world, but CoCo needs to fit into the
> spec-defined mechanisms.

The TDISP proposal from Jason and I bears repeating because it is a
superset of what a CMA-only solution needs, and security guarantees it
provides. I also submit that "identity revalidation over reset/resume"
is not a *primary* concern. It is certainly *a* concern that needs to be
part of the ongoing discussion to avoid painting ourselves into a
corner, but certainly a complexity that is incremental to the base
enabling. Recall CMA is only a building block to trusting the rest of
the device interface outside of the SPDM session.

Userspace is in charge of all trust and verification decisions. A TSM
driver, whether that driver is in-kernel-SPDM-library, or platform TSM,
establishes a session with a device with a given certificate slot. The
session establishment makes cert-chain+transcript available to userspace
and caches the public-key. If userspace does not like that result, it
opts to not bind a driver to that device, or retries with a different
cert slot.

If later we want to support a "same device" capability in scenarios
where a userspace round trip is infeasible then that is incremental ABI.
That ABI would allow userspace to cache golden cert-chain+measurements.
The resume path can revalidate that identity description with a fresh
nonce and the cached public key.

For TDISP the violence of dropping the device out of the TCB likely
needs more sophistication than golden measurement revalidation. For CMA
mere trust in the root cert is not sufficient for many of the
adversarial device threat models, so the kernel need not carry that
responsibility.

Aneesh and I are putting together some POC patches along these lines.
