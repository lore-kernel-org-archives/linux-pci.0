Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFE22A4E1;
	Thu, 23 Apr 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906008; cv=fail; b=N5fSsmQIRUR9zYW3ViZiPR5nInZCqOX1e5Rj9c6D7wSCoV+CHLdCvSX1oVu6Q8d1Ot3D5afdSfMUCSWasFFEIhr99U920IL1VPIvRlLRH0yemjfi+hrMgJHb3/BLmGAlA1OgvX1gVTWuf+3/abCINGF4RpJOPLqjh9UsNaS8RcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906008; c=relaxed/simple;
	bh=yaena9zXM/CTptYvlJMDCXhtV7nKIruTlCS6SnRH1J4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWjwKT6zhug+S9mCvvy9j044lYF76gZLWMivSLYiMJQNi2FHBpwb4OdkCT0u962AP6Yub2J1ygGWqEZvdC8rVjkTRRwjF7vCT28jP91NrLsN1l1EnrX43wdHuGlsM7H1t2LG9ZjGvQ0PjkiM4BaET9k8NK4zZr02tR0rFHde5Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzicRHyv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzicRHyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776906006; x=1808442006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yaena9zXM/CTptYvlJMDCXhtV7nKIruTlCS6SnRH1J4=;
  b=hzicRHyvx4WyqM0bQa7gRrFLvGit31cAOVdtEgZCAj3Hp+Xq2XEL+nJ5
   Tsc085/Fuy9KXmqZXUuNuvs/ZTvEHJt8Hso0VvSNpbWeWP9L7YtAYVZnu
   IOEUoeOxoOgF3QaWcSbIxwRdOeiswAFlS3RG2eKF4wEZFeW25Uyi3pgqO
   DeNc6Dy5AngoneOfT81ioJgGAJSAPDg0Vepm+Ct2Ai3tw80x+Nz/bK9jB
   PAkWpBpRpjkl+QY4U+YGhVrcy+2DrcACTMW0onR971BbFFZu0bESJzmm8
   Bc/VpEe9Q2mmzxA06E3es78b3eRej5qm24DAgDQId81GIDbPNySPgHjMN
   Q==;
X-CSE-ConnectionGUID: 3sMwtOSATyKPJn03C2dLZA==
X-CSE-MsgGUID: rfMqnqP5R/qDV8NMONJu+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81731892"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="81731892"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 18:00:05 -0700
X-CSE-ConnectionGUID: KuBj70iIR5C95uIU43lxPQ==
X-CSE-MsgGUID: CKc4RU/3TgmgGkq/WLN8Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="236871334"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 18:00:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 18:00:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 18:00:04 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 18:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alOqeiopbO2sWVc0zaJ4tuzIOgJBQBOmz5n3X3gA8+uAYs8SNGVxK6sp2UdtUbredJf6Cvm1jTmLyvrjEmRKvCj1oHyuhPFJYNCojZPxgGd+/7slAEPeMXxGf+/KSRyw6RMGA3pgtOnK0PGsywn7mxVhTjP3IA/V93odUCN7ReXrlCpm8GicZMSi19cPJT9Dr1ITaYAf7gYR19II3jxMsXUzzoDQXH31q8KSe2gbGmOpbAv2bJVEWQq2trOGU48m5Yl4Az1YRKIAZ5vX2XiCD7P38oj4mDlNG44bZgSSLJqzWdgwTvX3P/OANxFiVwzFdBlXImAHGoYL4neCKgoQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaena9zXM/CTptYvlJMDCXhtV7nKIruTlCS6SnRH1J4=;
 b=X9OP5X9i4jih2zV3W4pM8354CFEJkMK+GQpHOzvrVvuRzw88HKfOnX3j79fdlYxguSve1CHdOf3wyZrpanuXD6Wf+BiqJQn2vXWeJy3GH46v2TkC8JktmnDCdp+pETSr1BnyRQAhK0H0OMc9CghhvFLsCpL48h1GudHAus/WA6aXst1fFkQlyA+LsH0rjQHMdMAhAqE8iHQqiAyc42YeRdUtn4mw3c9ddQBR6fARH+TH/+FSPw2ICaPvfRwbXLykINCbw2Fgd6YCOnS16FIY3zBx2lBhD2rfewd8G3VufFIAbWApVGwDFwQavg7wgY5dc4+6h/+5v0x0e1UNARSW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Thu, 23 Apr 2026 00:59:56 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 00:59:56 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgcsp3iEtTEG/UOFY+bW5PCg8LXr/O0A
Date: Thu, 23 Apr 2026 00:59:55 +0000
Message-ID: <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-11-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7997:EE_
x-ms-office365-filtering-correlation-id: 8a2a24ae-e8d6-490f-d271-08dea0d3a2a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: uwEFU3cdamcVz2jL4rLFXF/SqXZ9gPlchDBId7gFB7BsVPDvpl7eL2Tg9qccYaDan+bYliL5tWI0LuQarp3QX+ky/vIAK3M7scwpzRDkWcOhPmWwYp9k8v2tE4h6yAVjwuX1qQITJ0myrKmAxmnRAJZUdMb0J3QnnnvmBeqrbQgHMsiMhknMkF/ml9137bpie0UUZT/YsFM5q9GQYcWxhXQGJ5276GvG6UTyX6CT6ycL/1+n2tHtQ4br8RLHsPiSQrCouNbgvzWm8Ir5fJnyXcOoivTaxaofUS9qUw7GqVte/MKBPIAXWcsPyvCoBDovqcx8bhq3nu0b4rCjwhOBALGIZvWJWYxtw7kN400i8py+XTbFTVUkg7B6lQ2PpBk27gyMPQGTiEw0Pfi6Mscky48zOBOh1KJ/hLEH7HgEATAglauMnv1GK2yee9sGoDr9bnJYzTSHkOfxmPAQc00WhyguYoChyz3Boz3C4+pJAPf7spCrsKopto5EuUJDEUZF1fy7/lU6hIZLIwAekbIXg7tZSmc5Q3cOK/RMCTgdZlH/OH3/Vi5gUQvJpMwmA5wxEKs5DGBMFkKq/Y9iPb0My0F0kpHdi4FdKh0uTFFebUTUfLRtKvzpGGiwBs5SBMCCpTdP9Z8rzAT9af46SnYOZ1lz7bmkToEX8YFNXX7eVeIxeyrNGDuyukOD9/v5WegwYZ5q2Z63f99uQ8nplOr/1CKv4xJJJfYAOFnUYOv9+7JD19R2ia2LVo4f9JJiYZFRaCwJLxKMXg9UlqT6fglYVIkYyFlgr2OuDE8L8F1NYr8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU8xdFlqNlF5ZjZnTjRwYzdZLytvcXVBMjJVNHZBaVFGeVdVa1RTTlpFSDhY?=
 =?utf-8?B?MHRmK2JCSnVCVzl5QjFTdmd0bkNlRUdWbjNxNDNVaVhJTndobnRMRmduNXNw?=
 =?utf-8?B?ZlZjZ1orMCtQQkRiQWFTQkhZbXk2MjBmeXY1ZTFLY3JSQVVld3pyeFNLS09K?=
 =?utf-8?B?S2pCOFlMaUFoYnBkQjNpU1VGVk5kR2doU1hRSUpMZnFwbXREL05kdGkycnFW?=
 =?utf-8?B?RklpQUJuQndUUTI1dW94d2VSNmh6Y2hpYXI3WHdLOTR1SmRJZUVNc2xpYVI0?=
 =?utf-8?B?VXBNZW1YUjRnbjdrMkVOOUswMmhoMXpFYk1HRlVOL1FYWnBWdTFvdFE0ejVY?=
 =?utf-8?B?RVJDYkkxbURHbFcxcmVMS2swUFlMRmtlQXVyajFKMEw2VGNTQnBsQWVwUm9E?=
 =?utf-8?B?R2hVVHcxUTBnM1FUM0liZU8yalg0Q1BhV1dhaHZONlgrNW0rSnlnbGE0aWoz?=
 =?utf-8?B?azBVR25mbzM1Sm16K0dBRjJveTlqQVo5M2o0aU1CUlRZUW5PSnNYenBab09q?=
 =?utf-8?B?elZ1ejhsMFhPTTkxMDhyYkZnV3RPMXBJeW5yVmFrckxpaTN1U2ZwRE1rbUpx?=
 =?utf-8?B?QzBhc2dSTjcyMGUyaUhJWHZxd0M0Q1NCbjJ2RWsyc3NpSkp1eHBaeXNOZk5s?=
 =?utf-8?B?TUpvdUJraFVpdmppZnNZQ3JMR205SXZqMFllVElKQjBMOVVHam43TzQxbXpr?=
 =?utf-8?B?K3Q5L0M4V2puUmZmQ2tzQUg2dnpKd1Y3cEJkS0IwNGZNY1ozaXhiRHlyQUpR?=
 =?utf-8?B?NDFaUGo0MGxYRnZ4OXhVZExYUzdPZHJpNlZ1cFM2L0l1aXdvMWN4VFpJTEpM?=
 =?utf-8?B?QlppOXhqaUYwVVFYaG8reGRuRHU4cjl1bnhzbjlOTE1BajZyQlNOOHM0ZnNh?=
 =?utf-8?B?ZVhyVnpqdHdlZUIyclpIMTgwcFdWUDF4YlFWMWJHcGxRaHdmWFFRQUg3bkFY?=
 =?utf-8?B?VTJzUWRSQitlc1RMZFB6cTFGZmNWa1ZzTDdRTTdDaG1XRmQ2S3RsaTB6elFK?=
 =?utf-8?B?SGxUTHlrb1dRaDM5ODV0WXBpMkRQYjFGUFE5M0hhZXNIVXVndXpLQ2hRM3Nj?=
 =?utf-8?B?QkhCaE1KOTlKN3RGazM2akJTWW1jZmJxU1lwTEhyKzlMMzdiUTZFM0pxSWxJ?=
 =?utf-8?B?a2Rob0dTNStoSGF0algyY0dTK0g0R0ZWZUdEOHZIME5rbG1SWi9VbldpMVor?=
 =?utf-8?B?cHRPRFJhRHVRMm9NWGFGSFQ2TEhZaE54YkhucVFaeFN4K1VsVFo2d3Q1UkhG?=
 =?utf-8?B?WXhGOGxjL242R3QwNzFkc0RXQllLenJOaDNkT01lRkt4MVU5eGY5SE1JRk9E?=
 =?utf-8?B?cDc2WFhlcUVNZGhLMkdyL2l0WGptVmJQQTh4cWlkTVFtU2MwRG5YNlVndzRZ?=
 =?utf-8?B?Tk9qS2JJKzRJbUEwbG5JeGFvcGJDa0RWYnE5eGVndnZ3UDZVdyt4c2tPQUs0?=
 =?utf-8?B?RDBoNXMwQmc3YnYzOHZuZXJEMHF4bWZmaU91MmpFMml3eGhOVFQ5RXlNQ1E0?=
 =?utf-8?B?endVMW9sSXB2SmFOOEVGWFc0MFNna0JqVkg0alBuWEFUdThUTUhld1p5dm10?=
 =?utf-8?B?TTRhdlNXQys3MWRTL0U2dGUvem1RSkwrQm9tMDJEeWFqeXFVUTVwdjFlQnBy?=
 =?utf-8?B?NmR2aTBIOGphNWMrVW5seEo0U1FJc3pmcmtvRWJDM1pyMkxzQ21UQ29ncWhS?=
 =?utf-8?B?UzQ2dGtRSnFURk9kaGZ0MlFzUkZ0K09NMHJvTHBQTHpvZlI4WG9QRDh0bFpP?=
 =?utf-8?B?dVpwYW8yV2lJbG01a2I2ZGk4S1JvK0tRcGdkbTZ0YnBaaWg5N2NMK0g4OXdm?=
 =?utf-8?B?NWx5di9hSk0rMzVzSWZLcmJlemxNL1NIalZTeVU2R1ZqbnE4NlZyczNlR3Qv?=
 =?utf-8?B?Y25Lb3RYMWttbFgzNXlNcEJpa3oxczZkZ0tGNGlZTXFPdWhudXZWaTlLVmxv?=
 =?utf-8?B?Uy9LNDlnS1RTYS96a1lLMUFnTHFOdnUzbVNoZVl0bEdUbkZlYnVwRzZLV2Er?=
 =?utf-8?B?K2R6RG03R2IybVpjV3hxYlVkenRESE4yZnBQM1M4Uks0RnA0emdud3lQQ0di?=
 =?utf-8?B?eTNrOFFIY0ZoMGVmMVh5d1ZXZmlLZ0xSb24ySEVOalR4SjhTNWxWWmliN2Fq?=
 =?utf-8?B?RlBlRTMveVVXWE5rakRiMEkrdURYa0xIR0pUNFprZlNRVFVmakZjTmprQWtz?=
 =?utf-8?B?TCtBaldidy8yNnZKNkdxNTlqKzl0OUpEcEVmK0RZT2JXdmw5K2I1QTZaeDR2?=
 =?utf-8?B?T3dubGRJb1NPMDA2YmlPQkZrdzhjcUxoMGFRSUdwVmJ0YzNmV01JUWxmY3NZ?=
 =?utf-8?B?OEdjUlR3MVZpamZNamZQOVR2NGFmSEtaRlRHNzgrbVJPUXBWSXRoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4290858CBA7824F8E92852D7C8BD3A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HmQflhav+kRpPdfhMpYBaDT1zKoVqmbBT7wle4+ZVwHjQjkxhbAkkgBTHxt17VzoMcSqmUv00lE2+b+XfaZOZn+W6pnTcSSqXty0u9tG3xVP+L5gNrOZX6MJWX5avnMd1Zym2N4VrlrPcAzKckuAKrneVwJEWtRF4jvHvrt84E7baJ4HNsii2rgqf78KBvKtxrsKeTkr7lH00kLgvA1kLi4n4iVt35a8gEQWIy8HzUdpoLiRObojc4XfAGxfPm6fy/9W+MxOEp8Qp87w6bwBgGCoY3FcC8Gy3L33udFDXNH0Bl5qI9ykle935Q75ZPPylqEKi8JNYkFnQo5pG9U4sQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a24ae-e8d6-490f-d271-08dea0d3a2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 00:59:55.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DfSdL7kYSJZDqASXAmB8Y8n/ijOR0qGsO4Zbn8t99RHXVT7+97mwb5JMNv0Nds02ovUR+OjuI0/DWPGW9VIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3N0
YXRpYyBpbnQgdGR4X2V4dF9tZW1fYWRkKHN0cnVjdCB0ZHhfcGFnZV9hcnJheSAqZXh0X21lbSkN
Cj4gK3sNCj4gKwlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7DQo+ICsJCS5yY3ggPSBo
cGFfbGlzdF9pbmZvX2Fzc2lnbl9yYXcoZXh0X21lbSksDQo+ICsJfTsNCj4gKwl1NjQgcjsNCj4g
Kw0KPiArCXRkeF9jbGZsdXNoX3BhZ2VfYXJyYXkoZXh0X21lbSk7DQo+ICsNCj4gKwlkbyB7DQo+
ICsJCXIgPSBzZWFtY2FsbF9yZXQoVERIX0VYVF9NRU1fQURELCAmYXJncyk7DQo+ICsJCWNvbmRf
cmVzY2hlZCgpOw0KPiArCX0gd2hpbGUgKHIgPT0gVERYX0lOVEVSUlVQVEVEX1JFU1VNQUJMRSk7
DQoNCg0KRGl0dG8gaGVyZS4gIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGludHJvZHVjZSBhbnkg
bW9yZSBjb25kX3Jlc2NoZWQoKS4NCg0KQnR3LCBJIHRoaW5rIHRlY2huaWNhbGx5IHdlIGNhbiBy
ZXVzZSB0aGUgc2VhbWNhbGxfaXJfcmVzY2hlZCgpIHlvdSBpbnRyb2R1Y2VkDQpsYXRlciwgYWxi
ZWl0IGluIHdoaWNoIGEgbG9jYWwgJ19hcmdzJyBpcyB1c2VkIGFzIGEgY29weSBvZiB0aGUgb3Jp
Z2luYWwgJ2FyZ3MnLA0KYnV0IHRoYXQgaGFzIG5vIGhhcm0gZm9yIHRoZSBjYXNlIHdoZXJlIHdl
IGNhbiBqdXN0IHVzZSB0aGUgJ2FyZ3MnIHRvIGxvb3AuDQoNCkkgYW0gd29uZGVyaW5nIHdoZXRo
ZXIgd2UgY2FuIGp1c3QgdXNlIHRoYXQgaGVyZSwgb3Igd2UganVzdCBnZXQgcmlkIG9mIHRoYXQN
CmhlbHBlciAodGhlbiBvcGVuIHJldHJ5IGJ5IHRoZSBjYWxsZXJzIG9mIHRoZXNlIFNFQU1DQUxM
IHdyYXBwZXJzKSwgc2luY2UgdGhlcmUNCndpbGwgYmUgbW9yZSBjYXNlcyB3aGVyZSB3ZSBuZWVk
IHRvIG1hbnVhbGx5IHNldCAncmVzdW1lPTEnIGluIHRoZSBTRUFNQ0FMTA0KaW5wdXQgJ2FyZ3Mn
IHdoZW4gcmV0cnlpbmcgVERYX0lOVEVSUlVQVEVEX1JFU1VNQUJMRS4NCg0KVW5sZXNzIHlvdSBo
YXZlIGdvb2QgaWRlYSB0byB1bmlmeSB0aGVtIGFsbD8NCg0KRS5nLiwgd2UgaGF2ZSBzb21ldGhp
bmcgbGlrZSBiZWxvdyBpbiBvdXIgaW50ZXJuYWwgS1ZNIGNvZGUsIHVzaW5nIG1hY3JvcyB0byBk
bw0KJ3Jlc3VtZT0xJyBhbmQgcmV0cnkgYXMgdGhlIGNhbGxlciB3aXNoZXMuICBCdXQgbXkgdW5k
ZXJzdGFuZGluZyBpcyBEYXZlDQpwcm9iYWJseSB3b24ndCBsaWtlIG1hY3Jvcy4gIDotKQ0KDQoo
eW91IG1heSBzZWUgYnJva2VuIGluZGVudC90ZXh0IGR1ZSB0byB0ZXh0IHdyYXBwZXIgYW5kIHNv
cnJ5IGZvciB0aGF0LikgDQoNCi8qDQogKiAuLi4NCiAqDQogKiBUaGUgcmV0cnlfZnVuYyBhbmQg
dXBkYXRlX2FyZ3MgYWxsb3cgdGhlIFNFQU1DQUxMIHRvIGJlIHJldHJpZWQgaW4gYSBsb29wIGlm
DQogKiBpdCBjYW4gc3RpbGwgcmV0dXJuIG90aGVyIGVycm9yIGNvZGUgd2hlbiB0aGVyZSdzIG5v
IHJhY2UgZnJvbSBib3RoIEtWTSBhbmQgDQogKiB2Q1BVcyBhbmQgY2FuIGJlICJyZXRyaWVkIiB1
bnRpbCBpdCBzdWNjZWVkcy4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogKi8NCiNk
ZWZpbmUgdGRoX2RvX25vX3ZjcHVzX3JldHJ5KHRkaF9mdW5jLCBrdm0sIHJldHJ5X2Z1bmMsIHVw
ZGF0ZV9hcmdzLCBhcmdzLi4uKVwNCih7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgc3Ry
dWN0IGt2bV90ZHggKl9fa3ZtX3RkeCA9IHRvX2t2bV90ZHgoa3ZtKTsgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCiAgICAgICAgdTY0IF9fZXJyOyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCiAgICAgICAgbG9ja2RlcF9hc3NlcnRfaGVsZF93cml0ZSgma3ZtLT5tbXVfbG9jayk7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAg
ICAgX19lcnIgPSByZXRyeV9mdW5jKHRkaF9mdW5jLCB1cGRhdGVfYXJncywgYXJncyk7ICAgICAg
ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgaWYgKHVubGlrZWx5KHRkeF9vcGVyYW5kX2J1c3ko
X19lcnIpKSkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAg
ICBXUklURV9PTkNFKF9fa3ZtX3RkeC0+d2FpdF9mb3Jfc2VwdF96YXAsIHRydWUpOyAgICAgICAg
ICAgICAgIFwNCiAgICAgICAgICAgICAgICBrdm1fbWFrZV9hbGxfY3B1c19yZXF1ZXN0KGt2bSwg
S1ZNX1JFUV9PVVRTSURFX0dVRVNUX01PREUpOyAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
CiAgICAgICAgICAgICAgICBfX2VyciA9IHJldHJ5X2Z1bmModGRoX2Z1bmMsIHVwZGF0ZV9hcmdz
LCBhcmdzKTsgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAg
ICAgICAgICBXUklURV9PTkNFKF9fa3ZtX3RkeC0+d2FpdF9mb3Jfc2VwdF96YXAsIGZhbHNlKTsg
ICAgICAgICAgICAgIFwNCiAgICAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgX19lcnI7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCn0pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCg0KI2RlZmluZSB0ZGhfaW50cl9yZXRyeSh0
ZGhfZnVuYywgdXBkYXRlX2FyZ3MsIGFyZ3MuLi4pICAgICAgICAgICAgICAgICAgICAgICAgXA0K
KHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICB1NjQgX19fX2VycjsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KICAgICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIF9f
X19lcnIgPSB0ZGhfZnVuYyhhcmdzKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIGlmICgoX19fX2Vy
ciAmIFREWF9TRUFNQ0FMTF9TVEFUVVNfTUFTSykgIT0JCSAgICAgIFwNCgkJCQlURFhfSU5URVJS
VVBURURfUkVTVU1BQkxFKSAgICAgICAgICAgICAgICAgICANClwJICAgICAgICAgICAgICAgICAg
ICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAg
ICAgICAgICAgICAgICB1cGRhdGVfYXJnczsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgfSB3aGlsZSAoMSk7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgX19f
X2VycjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCn0pDQoNCiNkZWZpbmUgdGRoX25vX3JldHJ5KHRkaF9mdW5jLCB1cGRhdGVf
YXJncywgYXJncy4uLikgICAgdGRoX2Z1bmMoYXJncykNCg0KI2RlZmluZSB0ZGhfZG9fbm9fdmNw
dXModGRoX2Z1bmMsIGt2bSwgYXJncy4uLikgXA0KICAgICAgICB0ZGhfZG9fbm9fdmNwdXNfcmV0
cnkodGRoX2Z1bmMsIGt2bSwgdGRoX25vX3JldHJ5LCA7LCBhcmdzKQ0KDQojZGVmaW5lIHRkaF9k
b19ub192Y3B1c19pbnRyX3JldHJ5KHRkaF9mdW5jLCBrdm0sIHVwZGF0ZV9hcmdzLCBhcmdzLi4u
KSBcDQogICAgICAgIHRkaF9kb19ub192Y3B1c19yZXRyeSh0ZGhfZnVuYywga3ZtLCB0ZGhfaW50
cl9yZXRyeSwgdXBkYXRlX2FyZ3MsIGFyZ3MpDQo=
