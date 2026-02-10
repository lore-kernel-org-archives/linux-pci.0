Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF481336EDA
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761652; cv=fail; b=BgO9jYobO3HGqDgEu1+y3cWeUEJSMyecwYTr2SaCoptBAENNL+bLsFSCIAXHUHLF6XrK/eu7OYXqCAQxiDtMwohCgntmyhL/1AQKMyVgGS4ChQp7batZmoen079FY+L4mmxjd/qo0ww5ZlG7z7lLT6fMHa7WsL3yUXYHDeOKYXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761652; c=relaxed/simple;
	bh=vzkc8/Nkuv72vkAb1czHQXPSfn9KmOPUg0ntH7ShhdE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EtTvsXT1ObWqbfbPmmbOWkGAkZXwLn4Z+bs5q8l7eyby2K9ng+jgbioOmlf+aXnXFHVk7wGLV0GkH6kXfiie04xXHH4Pz4NLS5B8tqeNuMTlbUgF6EB+QavgUgOEMMG0hjKqJpfA5RvgWMHowE3q0wKvgg7Ur7mDrZYyGYxIQr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAGq2ieN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAGq2ieN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770761650; x=1802297650;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=vzkc8/Nkuv72vkAb1czHQXPSfn9KmOPUg0ntH7ShhdE=;
  b=YAGq2ieNz/i9HqrCndG1TmEMiDWBBS1x/INcVF3ub59xDNjYoe2DiDT+
   B49CQ9AC+/eL+j0PUoeMxN95/IR4wcRyoyCAvxDSUCJ/soqCs35TXm9jT
   rBe5LInqDoMu4flAdxIBPZUeMAeIIlTBdXvC1ro03kanIZhUVvZqWU0zE
   oYcn+6nU14jVZ6yEZSKKpJyOoM8PqnOgxTg4EwXNV/1rayxP6hjLIh8OA
   j4Z+BmuawKkX0RygadrDWFdbIzLP71mkGTcHvdLg1nKV9jdxTkSEGJvY6
   ia6hsMzebhAJTYUJiUTH7lClveYjVa/1YZr00dSBSEJPOakWPENom8d5R
   Q==;
X-CSE-ConnectionGUID: B8aSpPnUS9eDX7JduEof8w==
X-CSE-MsgGUID: vTjsfS8jQNy+2bgq2hrcpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89493004"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89493004"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:14:10 -0800
X-CSE-ConnectionGUID: 4XXH41r7SYW3r0l5uLmjwQ==
X-CSE-MsgGUID: 2PVqAyijQTmdWfkgml46sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211122486"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:14:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:14:10 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 14:14:09 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:14:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6WJUc2rKsED2av3Nu2H1bnZAS+OujFlUU9cvmPrYUx385Gb7xkNw83RqPChzl/cwuSMUCOcIBYKJHXz4/gMgjrXVKJ8tjlEBn5NtHMnIzxNPtoJcOJ7h9s6sCQKqwFOnL40PQi9c4y3XE0S2FTEJV+g6v8/etRQvHCQE3raViXNcC2k9i9WAf7hgNowbe0K3FxmqhCJZAcYpgDDjx+z3tFosiuQFPzLW5/OxiD0FnpbKl4k5qPfEqb03ToR0ZFQh4Ih0vpiPf4ZXzy9oCg/2QUQZw4LV8zfjoNYXiJC7GtRwU7K+vSKz0HRY2pdkB780G2+E8Vn+q36vVkCWkRg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+bw4SS3OkMN8dH7s+FA7KH3p2qKecvCa7HlnuwzInM=;
 b=UBDOjVgBIn5W9jxtdxDtstTOjVGUsrpnZxerxtbYcFnCklMwK50v8x3pHHbF3Kw79VVH3tJ7F4nCl/beCHPZ5Oit/uu6Y09QG/b9J8Q2J5FdVAaGJJJF22FLj8SACpH2VIYT7ym7A4C/1lyW0occgyKXSHRleajeHapsWNgMPkqcro0+OkcvwoONCw04xExinNf4+imuKs6oLbRTPG1y2adLOnSyXhI1RHyXBk75JLNiTp03NT0wytirPegIVL33Ohu74qwmG1RP229SGkOfcs9JMnshtTKCVTBGSt3mp8JNNSL3SwUXVcn3MkbadpKSoChQAzxFsB196IHPMyH/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 22:14:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:14:07 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 14:14:04 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <698badacf274d_2e57100f6@dwillia2-mobl4.notmuch>
In-Reply-To: <20260205212533.1512153-5-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-5-kbusch@meta.com>
Subject: Re: [PATCHv3 4/4] pci: make reset_subordinate hotplug safe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb22587-194c-490b-21aa-08de68f1b571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTQ1VHQvTXUydU1taUtaYU0xK1pEdURRK3BYNnczc2p0T3g3UnJuREhRZmI0?=
 =?utf-8?B?M2Q3WU1FYk9qanpETjViVjdyQU54OHFrMUtFVDllaXZNaTVHN3BrZnlhRUhR?=
 =?utf-8?B?TkFIWjhRT2x4MmlOaTR3dUxScENBNXVzTHNkRW5CU3k3Q29iNWtDZXZxV1cy?=
 =?utf-8?B?T0ltb09zbUw5VGk3QmFHd21TSjB0SG5Lamk4U2pGL0k0U3lGbTA4ank0UjVY?=
 =?utf-8?B?WEhQQ3lRdURWNUlBY0R6bmxxS3poc0tzNGw4bXl6UWVZUWdKcUg5NWYzVzgz?=
 =?utf-8?B?NkJEQ3JQWDRkS0RGcW91MUZnU09KWTJOVkFZamc5YlZDYzBKV1NIQmJ0bjVS?=
 =?utf-8?B?eHBVT3Y2RGpBODdzclFGenRBbks1MFpGUmR0WnphaDc4NzRzTVBFZDV5cEFn?=
 =?utf-8?B?dTlTS2lEQ04rSjRQRjArUXBJZldob2tvLzlodE5GRnQxdmk3c1VCb2pvdW9E?=
 =?utf-8?B?a3BzUVRicUhQL2FVZjA3OFhDZkY0YkZtaWxMYm5qMWVsajRFQnp4dmYyZksw?=
 =?utf-8?B?OUNFK2dEc3k1T1Y1K0UvTG5VWWYxa3lzVjFGRS9aZEk1Vk1nMU9iN1hTOTZk?=
 =?utf-8?B?NHNlYmpCSkVBVG9Hc3FudXFVSlhMQi9pMzE5b1gxcGJzWVRTbEl2OUxpVHJ1?=
 =?utf-8?B?VHYxNEt1bWZxR0l4V3l3QllMdXV4U1F5dU9XRldYNGFhN1cxSWlPYkd2ZHdY?=
 =?utf-8?B?Y1dxSGVrUE1TSmJGSFptUGJYd3VCaEhOZ0hpMGduTUlqRFlOdUZpMEtWdFJN?=
 =?utf-8?B?cjk5OHB6R0REK2J6TEVPNi9mNC94QklyMEV0KzFnTHlEVjJVSzVYNXRTcG13?=
 =?utf-8?B?MkMvS0xlYlZMdFBzb3ViRVoycUZmTXg5dDhScWNuTzZYWDB0elMzQWZhS29Z?=
 =?utf-8?B?dXJtMEV1aThoTjdyS2cvVWxNSjQzbjQrWnFaczl0dTd5NW5NWDZPb1ZqK08r?=
 =?utf-8?B?SU5jZDhVdzZiT0NHVE9hRjl5WjV5dlVxYVJhWjdyNjROR0NBOFg1STNzRVZ3?=
 =?utf-8?B?RmtBOVNiakh3VzVWV2RYRllFQUN2aUhlZzBoRzBERlZzTFNoNTJrekpuMHZB?=
 =?utf-8?B?SkpGN0J0L1pBUnNPY2hGNGxKcVlYY1Zab0hyMDYwL2N4Y001bWJxZFAyM0ZR?=
 =?utf-8?B?WTN3ZXhQTEt6TFNEK3FIU3phY1FkUDRmWEI1RVA2NUZsYktOb3hpSm9YMGlI?=
 =?utf-8?B?SjJrZWMrUHZ2YTdsNFpNM2JJT3ovU3hNM1VTSmExYTNxTENiUlVMbEVlcVhO?=
 =?utf-8?B?c3g2NzdFZi9JUXNFaGxMaFovWUpkT3NsMjJYWDBIYk1lc3RheUZhWUEzV0py?=
 =?utf-8?B?TEFDRU5TQTQxa2pyai9MdGRGOXlDb0NFT2NPclZTZ2FQdmc5K3BESEFnT3pm?=
 =?utf-8?B?WkhOMmNhcEF3MUZQZU5uY2cyRFducU9DT2hralhQa0pud2xYUUpITzlkeUYy?=
 =?utf-8?B?eWNUYVVFMks0VkVHSm5DWXhNK0xDWEVvQ0tIZWZuOTVMMnRIVlF4Y3ZMbGNn?=
 =?utf-8?B?REJkZkRFK2IxdmJ5cDRROEUwcGZWNVhlOGl1blFDRm5vQmEwRkhqdXV5SzNu?=
 =?utf-8?B?QjhKbmFqSTY5b3Z6cE1LY2ZTSFpub0FJMXUweWFLWlJzcTk5SGU4dTV3LzE1?=
 =?utf-8?B?Q2Z6WkhGYk1JcmtCYzhXKzNNejJ1bUJ0L1E5VFAxLzBqUmNEUk15M2hTWFIx?=
 =?utf-8?B?anYxNXNlaFliNER4QzN2VCtmMm1HS1pBRENPTUwyR1NzUkR2dGlTckVhTlJZ?=
 =?utf-8?B?bXFFYVo3UUF3VGo3bmNKN3pjTHdlZk8yUkhjUnRSUUtGa1VzbkN4TkI5RzdF?=
 =?utf-8?B?WVc5dVV4Mk96VmpEclR3Y01acW1xa1ZsUXNOWXM2YU5GVURjdUlpMmw1d21N?=
 =?utf-8?B?YWY2bTNBaVBnYnVnSGVZbHdHKzNzTVVWV0ltQXM0SE01cUIwc083Mlk0SFJ3?=
 =?utf-8?B?cTZLbTQ5V0h4NHdwMXVhamU5WGFGc1VERytBVzlwYU8xRXc3d0pyUjh4TVZJ?=
 =?utf-8?B?a3l6MGowM0QzWWxCOGZzS3BhbHpzb0tjS1NhU1FRQXVZL1htVmg2Z0h6Tjlz?=
 =?utf-8?B?MXhxTjAzb2tZVldQV003TW1kRmFqZk8xc1F3Z2Q2bUQ5c3BzaXpPWi80NTVm?=
 =?utf-8?Q?bC3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZVbUIyT1dhNS91eDlVQUlGZkNCeVZ5M2F2cFczZ2Z3NlF3TVNIZ0J6NkxP?=
 =?utf-8?B?VFFibHVqcUFoVGFKRmQzbUJjTXZPVzlmUmNlcklpOUJXbE5BMC9ndUx0Vlhq?=
 =?utf-8?B?cklXZWRFMGlxQUs1T3VBTDFSKzY0dm1oUk9ZUWhHWW1GM202bGRjS1p6TFZw?=
 =?utf-8?B?TUllVlVWTWxEWUdTWDFaTkYzcmlpWHVxU3JRd3Q0SVlnMHF0cnpJclhSTm5z?=
 =?utf-8?B?Yk9NRnZudHJlRUttQU5MSEJPbEtxUUFEbE5KdlVyL1E3cVlmWDBzODJmUHpC?=
 =?utf-8?B?bVpjQU9BcUxoRW91UnBrWTBZOWpONjQ5cExxYVdUS29vSmpGZWRUc2V0emk4?=
 =?utf-8?B?TDBGR0RjdkE4QlFXeGdRR3QxZ2VuTmhOVTNUaXZlQnhqZ25HUFl3VnF6WGNy?=
 =?utf-8?B?RjhlekdTVkpha3c4YlR6VG56bDZPeU1KUUNML0dGT2ZodkZuRXRKYlFSRnow?=
 =?utf-8?B?WFd1QTJYdFJSRS9ValhVczBuNFdTTUNDWFl4LzhONUFzckF2d1BDTEU5ZHJn?=
 =?utf-8?B?alBoeENlR2laNWVnRkZPMmxtQU82ZEpyWE1BQ3N4Qi9abDJ6cFF6WjRmRkxV?=
 =?utf-8?B?dmlkT2xhekk0UXNLaUtjVnViOUZGTnVWWjZNczFWRXBQUEtINncxTGlYZXYv?=
 =?utf-8?B?QUw2VWZHR0VEdTJqeG9RcmRlUjZoS0REWGd5UTB3SHBPZUsxYVQ5OHRrcWZE?=
 =?utf-8?B?UER0UDc0QWNXSWZOOTg1aEdoYkhlK2tVRldYZkxneXIxaW1uYThwem1jV0FO?=
 =?utf-8?B?NksxQXd6cVNkWkFWNFR0RzExNy9uNjJSUk4zYWV4RTkwY0JzbHBRZ0V6T1JE?=
 =?utf-8?B?UjYzNHdkd09xcW90bWpPamRXZUVuaUd0Umh1ZCswZUN6U2k5Q09iSG1hUWx4?=
 =?utf-8?B?dFdYWWY0YkwxYTdTdFFETGhqMXhITk1US2JHZDNYQjk3SHUrKzJ0QWpqZ1dC?=
 =?utf-8?B?ZHdYRXMzZ0FxMUV4L0RtUUFHZlJCMExQZWRsNXR6ak1Xc0h3eE5HM2h2QTVB?=
 =?utf-8?B?cWVycWZyOUprbnR5M213TENBYkhYcTBVVVA5VVc0MkVtWkV6bGcrc3hvN1pu?=
 =?utf-8?B?N2FhOWFtcTNESlB2c1gzYlJLOTVQVUNESDdFOFVqdkZkWlV3eEdRRFVOc3la?=
 =?utf-8?B?RGVBLytVdEhnNWpJeTVSdm5XK2VIWXBqNEswcVZrVW1IVSs4akNHaDNxR1Rn?=
 =?utf-8?B?WjNkQ1ozOXVsUzJxSWRDbU9xQ1JZZDdtRHIvWXJXa29veVFEa3FZd2tIOHlF?=
 =?utf-8?B?NFU0SFlSNjJCSndBT0xQUklzNU54UkxEN0ordEowaWdmRmo1aDg0a3hhM0l1?=
 =?utf-8?B?Yy9vYUlTQjBhbjF0ZGdJTjJ0MGtMS3kwS0FnMEJLclBYNjh6Mk01cTlNVzFn?=
 =?utf-8?B?aWV0dmFJQ1psVXFIQjM1MzJTakc2MFlhQmVEK2pseU8vTmo5NW5LMzhMeG8z?=
 =?utf-8?B?bkJ4SEpRTHRRbFROeDR5M0FkR0lsUVN0S1ZGZ2FzK05qaGxUZUQ2MGttNXhk?=
 =?utf-8?B?ZlhGQmwrTjF0ZHIrK3ByUUVrdyt5eG1pbHpsRGV4OFp2bkY3bnBmMTl2dFU2?=
 =?utf-8?B?bjI2VzZtakNJK0dRVUZicWV3cHJmbVY5d29TVnBhdy8yVGVLeFhqQklQSzBS?=
 =?utf-8?B?NHd6OVRsY1d4ZDltUGM0WU13MlRiV0lZTmEvMGVESGJJRW9oRWVTSjlZNkI0?=
 =?utf-8?B?Z0lCY2pQVktReU5PV3RSMVdPK3hjNWlva3ZLbVJyMDByZmpWY0dHM1ZoL0lL?=
 =?utf-8?B?NWFmZjJCTlF4OThMbFlzU3FRNmtHUTB5Y040eEdjUGNuL2tKNzhzbEhkRDR2?=
 =?utf-8?B?cm5Eb2E0YzJsaDJERmFKcUtIWTljUjJMYk84eWdVbFh3QTZJZ1c5aDduMENx?=
 =?utf-8?B?MnV4NXhFWFhBRllhR1Nudk9ySXE3UGhTYU5oWDJRL2gzNkkzRkZiSjFDTkdn?=
 =?utf-8?B?ZXdCUkFFY3h4Z211blhYbGZTMlk0Tk16bWhWRGh5Y2EvcXNzWks3V1VwcDc2?=
 =?utf-8?B?ZW1Od2M4bHJnL2w4Mlo2bm9RenFNbFFUU3R0UWxhSjVsUUYwZDMxSmRsZnpX?=
 =?utf-8?B?VUlSV1JzelB2M2xEM0RRRHNlZGpnd2JEZFZ1TDhDeThRR0JJY21OaGpnRmRB?=
 =?utf-8?B?VGJ2enZmRERnRStTQm91TjZaM3JpL20vYnVxWFNEcTJiejR4SWsrL0M4M1RM?=
 =?utf-8?B?UTYrR1dYUFVLWHBHemJZUWRuaTdxNGZWN21uZDdIamNqeXg5dzFvN2VjR0wx?=
 =?utf-8?B?WFlacTZJaGZZMkRYMkpsY0dMZS9wUkVuS0F5aVdOcEpiUEsyWGNuRTQwOVVn?=
 =?utf-8?B?YXBXTnhhQUUva21JYnhxalF4WXZFTTNqeFRwU0hXWjhqNTJMWnBOR0x5R0tX?=
 =?utf-8?Q?7EN4Ms2HHaN8CZgo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb22587-194c-490b-21aa-08de68f1b571
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 22:14:07.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQo5XXPSyo9Oc93PKANSoNMgwfREYWl245N4AHllZxuh0c1ABvaU0nP00kotAaQwV4bcXMownZiNmvRaRRY8VKRwBMBNCsI5Mg4iIRCo6yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the slot reset method when resetting the bridge if the bus contains
> hot plug slots. This fixes spurious hot plug events that are triggered
> by the secondary bus reset that bypasses the slot's detection disabling.
> 
> Resetting a bridge's subordinate bus can be done like this:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate
> 
> Prior to this patch, an example kernel message may show something like:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down
> 
> With this change, the pciehp driver ignores the link event during the
> reset, so may show this message instead:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c |  3 +-
>  drivers/pci/pci.c       | 71 ++++++++++++++++++++++++++++-------------
>  drivers/pci/pci.h       |  2 +-
>  3 files changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c2df915ad2d29..039d3dc157006 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pci_bus *bus = pdev->subordinate;
>  	unsigned long val;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  		return -EINVAL;
>  
>  	if (val) {
> -		int ret = __pci_reset_bus(bus);
> +		int ret = pci_try_reset_bridge(pdev);
>  
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index df9ed73dad416..27817c6603a5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -51,6 +51,10 @@ unsigned int pci_pm_d3hot_delay;
>  
>  static void pci_pme_list_scan(struct work_struct *work);
>  
> +#define PCI_SLOT_RESET_MASKED true
> +#define PCI_SLOT_RESET_UNMASKED false
> +static int pci_reset_bridge(struct pci_dev *bridge, bool save);
> +
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> @@ -5420,29 +5424,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>   */
>  int pci_bus_error_reset(struct pci_dev *bridge)
>  {
> -	struct pci_bus *bus = bridge->subordinate;
> -	struct pci_slot *slot;
> -
> -	if (!bus)
> -		return -ENOTTY;
> -
> -	mutex_lock(&pci_slot_mutex);
> -	if (list_empty(&bus->slots))
> -		goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_probe_reset_slot(slot))
> -			goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
> -			goto bus_reset;
> -
> -	mutex_unlock(&pci_slot_mutex);
> -	return 0;
> -bus_reset:
> -	mutex_unlock(&pci_slot_mutex);
> -	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> +	return pci_reset_bridge(bridge, PCI_SLOT_RESET_UNMASKED);
>  }
>  
>  /**
> @@ -5483,6 +5465,49 @@ static int pci_try_reset_bus(struct pci_bus *bus)
>  	return rc;
>  }
>  
> +static int pci_reset_bridge(struct pci_dev *bridge, bool masked)

Perhaps a comment clarifying that @masked refers to hotplug events, or a
comment to say "see PCI_SLOT_RESET_MASKED", and put a clarification
there.

> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_slot *slot;
> +
> +	if (!bus)
> +		return -ENOTTY;
> +
> +	mutex_lock(&pci_slot_mutex);
> +	if (list_empty(&bus->slots))
> +		goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_probe_reset_slot(slot))
> +			goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list) {
> +		int ret;
> +
> +		if (masked)
> +			ret = pci_try_reset_slot(slot);
> +		else
> +			ret = pci_slot_reset(slot, PCI_RESET_DO_RESET);
> +
> +		if (ret)
> +			goto bus_reset;
> +	}
> +
> +	mutex_unlock(&pci_slot_mutex);

This feels like it wants a helper with a guard() inside to avoid goto,
but I can be convinced that are already too PCI reset helpers. This
otherwise looks ok.

With the @masked comment fixed up at a minimum you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
