Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5A3A9D8A;
	Mon, 30 Mar 2026 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913827; cv=fail; b=W1WRveEui9V8gTjWutpBv+mg6n/KRrxbZiNGXtaRZJs7FUCSjxBkcndMWjCpBzBoYA9TuEcHyGfOOG60OudyGu6Sk/IesqK7khzgwMzv/zQvOmWPop1Q6pwGcjg2EKudySagi80UAK7M94UI24Aoh/O5oYDduUrU06lB9pG18vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913827; c=relaxed/simple;
	bh=LaV9KrKD/RlJcG2w+BuzxHvVWKu1RFjSayg6jfVW6qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H6MyZVZRmfD3NwsDoiiKe7srT2Ktv1a3CDSRY8RZCthJ1GxVbnsDplKDHuxUKo6b56YC3WjTK9TpMARJ6ycQ9w+dU9+3odPKW+7E3dSg1BorCligse0l8MJuFGEsiQkmKkXtMa/wJdXNiLsQsKRKUJXnTXM6z0aIiqlzk8IAr4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bs6PjB48; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bs6PjB48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774913826; x=1806449826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LaV9KrKD/RlJcG2w+BuzxHvVWKu1RFjSayg6jfVW6qk=;
  b=Bs6PjB48HWvzUIvszud4B91j790nXKxPcy2XpYSUX+H7HHrxM4KmWgo1
   uRhPaTMcDiElMpvszH6Q+QSwTN0qv+Hxfe70G1Pb+wVhDrcwjfK9gjYzS
   0hYg5b5GXpeB8Sa82dDufuOLi6sES5VrNsX0xK+FRfBbULL/pn7GyX2kd
   qsYnFeVGo06MNO85MVScCkSMqEMyUtGdx0+HP8XgKNZPMygcRuX5DBdYu
   quZ/V2+7Xpu6cEnIJt5KrpeGVaXbA8jPQ231rZe5jdaGqXL3Ancj6ZY14
   XAKDqTg0fhPaG7yoVo02sgkWM9ndwXFolgIB96mChNnrOI9AHl9OKFdwV
   w==;
X-CSE-ConnectionGUID: +60NHhIgRxmLjpiwtitRVw==
X-CSE-MsgGUID: mPRBrEXWToyCD3v83xDucg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87310620"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="87310620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:37:06 -0700
X-CSE-ConnectionGUID: 7hFiC7B9T+yYfW/hppnUUQ==
X-CSE-MsgGUID: r0qrvX/6SU6dglVwBDr5Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="230257773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:37:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:37:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 16:37:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ij71PaXqTshprLmzqRWBCwYgSqlVGXw8dkeSxB091VPJvrwNDs0VuZuZ6JD2TnkUkBdwEEiaGoNJC/pKvTv1dok9WTqy/6ZBKo5LAIMsiKJcJM+irVWYbcA2Q1itjkdSHTU+x4GALxt1zmPSPII8KMrSDxehws7VuiIuHpNeAteJku65yFiaR1oT1QEip8cTIOG6UDitUlW5651fewBsbw8XpVL/ygNAwW7WFXOtfgwli62N8b/JrSCn8hXRwo+AA+4aYTgqi44FL+u+vtmI+F1+Fc19uh4WNPrX/xC1Y+djPg1Mtdz5GAr3vI+9JDwV1b2HlpWfwBW4X5gRDy1l3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaV9KrKD/RlJcG2w+BuzxHvVWKu1RFjSayg6jfVW6qk=;
 b=KUoOPreHUiaw9XeX5vknq42Xn4hS4s+qyMsuTn7fUgkpYU/RzbDEtZoW89A648OyL65PBNPuVt44YQpIPypJ2aqoQq7xaqAB1aPiMpiu4QG3TTluQyP+89FmTGqLxsXpLh4SMEmhQ4gtgUTbeUerJ/wx0/Y7yA6mxxkn6sDZHfUKR8h6RVjwqnlDGnwyamNgRpBflgUhf5dh+e25EWWXZTVuaFsbwoRT9WPea4Kvziktp+7yN5H+ymoyNU7pAoMTmt+CAP0v494z/kOSqUPrPcVqb1PPyyR3AIbaV3Wfju+mHNrabD/uGGJoifov+9xkktoEVMsQMTtgOzH5fiwEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 23:36:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 23:36:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgYHJkre5vG7jEePV/TlncNhDrXHwCcA
Date: Mon, 30 Mar 2026 23:36:59 +0000
Message-ID: <5deba060f683bdb6477428df4d152b98c0e924ec.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-11-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB5948:EE_
x-ms-office365-filtering-correlation-id: 30d431f0-4071-4c7b-1528-08de8eb53cde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: bYAhsEtBvW7jGRbpIOWihqZ9oAzktLxIibt2qmBcP+g1FXm3zbB7OpoA4aVxbjINFRfzTAOiS4sX9o40zI4wU4rMHnvi/nygJnw5HbqtUt6ODbzn5F7tLFeiyl5N4dmiqgJHwm4iqCjfeU0rcqRou4sbxh/kDb4zXHqYY47cV5WCsRb48SHv6W29SciYMEp11Hvv2lGVzA/aCrOK81IIxxOTtUyCY6ENkFwrc4bTzS8LB8j+1S+mzMK/OI3lkEUxhGLaz1p3x8177tO70cPnkOvfUKCv3875SR8qg2sRWmeCEdrmTtsMLmJupZwQ8JT1vnTZ1W1g64TiYWTbPmUjdzP3TwhVaqFScp5dng9llpyg9BTAGTRTgFtZknqdO6R8b9qE9rGPFgFj6lH21VEqWyF+zYoGSkIemEnXmtYFGXwhSfvtxqIQDkdb+x0c/qIz5SJV5QLORf2ATC7G5zJ6+7mlcDfn3nRko6rzxMHD5gC58r+5qrY7ThNdcZgKrZLaKIwchvnZtPdZFa7oWqJO5UYnvPY6Pj2hnjRFybO6IbS9jy2CL12Vydx8SMcffJSdQ5H4y5gk1wq8ldKTZByKn4hWAv1oaxvd6nDJdRNVz+lWtfs1JGiaBN1mYUubTJuRRhlvg37alv7d4Lp8haBW99VZV5dQ8ReqQTA0+XUx86Sg6FHAR1OsCxnMBvnOI76nS2+VHaLDUsYKr9A4jfPNDcPXkrupyDlAPtMCZzmCwP4n7YuCS2bNhCk7HQIw4kW+kBzkOBb1tSvf4GEiMfqUOscy+m0oaYxKbQAImUwdXzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1RVTjhmZVk0VFNHdHJBL0hBcDlyNkJyVWMxK0tJT0tXZGg0eFREaUozelho?=
 =?utf-8?B?TU1jWjZNWVNJSVNwSHhjY09jTE94bzMvREFualFva0xNRmZSdTNOZnU3M2FL?=
 =?utf-8?B?ZSs1b3ZiZ1dSS3FoT2dCZmVVbjZkckxOUkswVFc0ZmorQUlZalQrUmgwK0J1?=
 =?utf-8?B?Q3VzNnlwRlVaQktmMEFUT3dURThSNVVKWmFTQmR3U0trdTlWU0ZWbnpoUzE0?=
 =?utf-8?B?SU5WZVJQQjhDTE9hM2JFa3hrUmNsWEJnZzk2bkZjK1R3SG9nU3RlaTN0eGxE?=
 =?utf-8?B?NDhqWTEwakFZd1lTK2dmcTFRNXAxNlJFWUVFM2k2MzhvckpaaUpDTGEyVC9B?=
 =?utf-8?B?L2h1dUphSThETnN0NW8vSWo1aFJ1L2xNMmJNSUlVUEFrMnVMRi9tV1QrR3NU?=
 =?utf-8?B?dEpxclhJSjhxSWpabHA4d0Z6cXVhYUgxbEZ2ZytmTzBYNXdQYks1UkVGU0dx?=
 =?utf-8?B?bUZWWTVYbW1wQVJFWno4a2l3OUwrY3I1WGFvdFo4NjJvbUVhMnFrREZrRWFL?=
 =?utf-8?B?Q3A1V0ovZ3hXYVRRS0x3VUltbkcrWjdTaWgwZkxrMkZta3FKR2NRaHBvOU54?=
 =?utf-8?B?QUZBYllPZmFGaFJpSHhoeVZmakhkUll0Q1JWbWZtSnZnZGVSVFFoR3c2SDBO?=
 =?utf-8?B?V1owcnpyMzFaZ0tXcjUwVW15VTltMDhmWG9yRDY3QllWK01Ld2p1S3prMkpJ?=
 =?utf-8?B?MmQxckt0V05SL0E4NnBEWEJFQVMxSVVxNWV3M1lFSWtNOVVQcStsdHMwM0d6?=
 =?utf-8?B?aGh2L3p4WVB5VytKNUVaZkRXR3B0MWhUKzVmekdYT08rWXYwYkxKT2NsUDg1?=
 =?utf-8?B?Z0t1b2VvNUpJb0xZZG1Fc2s1M0g0N0NRYmdzQUc3eU5tRDg1OWM0QUFyRndh?=
 =?utf-8?B?bmVtVUtsRDkrTVI3K3ZHeGxxZEZtcmNBcjBRT1B3V3ZEVDlNT2hDM2JYcjA5?=
 =?utf-8?B?M2dxR09pK09IWUV1ekpUNUkySTFJeU1uTHVyZXgwUVhxZlRuSDNiVUpEdTQ3?=
 =?utf-8?B?aVJRaVNIdEdPSHIyQWhvQ3dHL1g3Yk9ZQjdmZHM4Z2NnT05uK1k0Vzg4d0Vv?=
 =?utf-8?B?NUIrL3A3OEE2NEhtZW1yTXI0enNhY094M3VObVRwdlBIcGM4Mys4b1E4SDRZ?=
 =?utf-8?B?MWVlOFVDbmRnVGMrL2NpVEswb1VNZHdqNXZEd2FVYVJRRktQYm9wOHBER3JR?=
 =?utf-8?B?bE9MUDV5VHkzSHMwRURoL21NSk4wY0tIOFdtVmwrRUtOSXdYYjFkUk5NSzhU?=
 =?utf-8?B?ditVQ2JmRlh3c3JlTXk0MDJET29Oa2ErUTFXOTdRZm9tcGVzQXpEOXEyZFFF?=
 =?utf-8?B?WndZVzllaXNNVklCR1haSks2dGlhNUVUbW80VmFTZjRDcFRZS1BsLy9HckZ1?=
 =?utf-8?B?amtkQ3d3UHpxRklvVUlQOENUck5FN1g3MGtCWHkrSzBKa29yYXRtQ0dCb2F0?=
 =?utf-8?B?dVBpL1FTczI2UEpFMFV2NGRRUGZVVEJBU216NVppcHFPVHV2L2JaYmtQNk1u?=
 =?utf-8?B?OTdDdjlUY0MyQXkxZWNUZVVQaEV1L0ZFTi9Cc0todExKWDA2TnJaR1p2Y094?=
 =?utf-8?B?Ri9xK3RaZUFybjJBREpST2d3RFJJOVMxa2RwWHF4NVg4MStTblAveUdoSG5B?=
 =?utf-8?B?eXJzcTlZb09PYjJLOEQrYXhleGdVQ3cxdk5hOEpFUFFXK3ZiN1QwckNJTGdW?=
 =?utf-8?B?TS9mTXBUanBpejhHVWxPNDVlZEl5WklIbEluTy8rOURyVnl0SXFrQlNIci81?=
 =?utf-8?B?OTZHaUJWK3cxa1MwNzc0TUorNVZKMnpZWm9TSnozUUtCQ1ZLaVRxL1o4MGNl?=
 =?utf-8?B?a0JwQzYvc2dUV1FzSnpFai9XS0VBdTRjTzAxandiVVhuOEh6eG5saUp2KzJh?=
 =?utf-8?B?SG8wamFUL2tEZ0tsYWlOclgwZUM1SWUyL3VmN3gwM25tY0JuOXc1VWVEcjNG?=
 =?utf-8?B?Ymh6djE4S0F2bWdHT0hTYXFHZllXQ3dZM2VCYm1tcG5IaTVSRUFVOUdCckwy?=
 =?utf-8?B?YW5QMlcrU05Wd21uR3Y2a3BESUVUbkNwbFRQUVppT2U4dHM1YmF0N1Zva3RB?=
 =?utf-8?B?bFJ6YTYwUHlEdjF0RlZFZHJwdUZIdkIvNmpqQ091MnJGVVhZZjcvK0dYKyt0?=
 =?utf-8?B?cHNEYkc3NzJBUVE0clFsUnI0NGpUenYxSlg2RXV2OCsrOGxYYXp3UDE3VFZ2?=
 =?utf-8?B?bmlxeHU5RXJ0bmxkSitjYkZJcjJrMVdKbkJyOCt3UEQ4b0FtR1RxRTVYdlFE?=
 =?utf-8?B?U3pJWVZwK05Gd3hWbk1VbU5tVFRVNUgxUGZRYUl4TExYb1NZZ2l5NytMNGpv?=
 =?utf-8?B?SS8vVTEvSDdNOGhpbERWMWlBMVp0R1NVdkY0MzlIcVpwNExlL0lQdThSNGVL?=
 =?utf-8?Q?kKLmIZJTSv+lUPjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16E884B3F343014791CAD70F26878046@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YPxcjtvKVAywTAWKoE7WI8NSSlBA1qACj6T9GqToqoP+S4UTBUZDHPJPC6E8kkjKzAy9loEsnoeXdotpZW+Y6saCw1RuWMmP8kIgj3Cmun86h8FBSWLjVXuqjcmINGC4r7CMYpa+MTnGNwyTTVwYSZPBdF3U2ILe49lBcTzdoYId+hkc6OCkfto98ZPgnZN2lhIdviyXzC8KYKWUXVpFzkaGrU57YnvSnPU5IMcs7tFVOXnDAr0LsfzqD2KYtUp/RpDVUuptsSVWDi8xGTWGVREfhYFp3loQ/mrHu3Fr0Q7LGerzLZmUjgPd4R1Ak5oKHGIcIYR4FTkgEGA8OUl4rA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d431f0-4071-4c7b-1528-08de8eb53cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 23:36:59.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyvXCNH41uVCRyWM3wMvCJLlIcBw812ErAWcnco/rFqRe063GF+CSD49njQ3VGe3YlPXCj7H8Yc2uzpFEezyahkcoT3Bs477jiDw79z9IAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQWRk
aW5nIG1vcmUgbWVtb3J5IHRvIFREWCBNb2R1bGUgaXMgdGhlIGZpcnN0IHN0ZXAgdG8gZW5hYmxl
IEV4dGVuc2lvbnMuDQo+IA0KPiBDdXJyZW50bHksIFREWCBNb2R1bGUgbWVtb3J5IHVzZSBpcyBy
ZWxhdGl2ZWx5IHN0YXRpYy4gQnV0LCBzb21lIG5ldw0KPiBmZWF0dXJlcyAoY2FsbGVkICJURFgg
TW9kdWxlIEV4dGVuc2lvbnMiKSBuZWVkIHRvIHVzZSBtZW1vcnkgbW9yZQ0KPiBkeW5hbWljYWxs
eS4gV2hpbGUgJ3N0YXRpYycgaGVyZSBtZWFucyB0aGUga2VybmVsIHByb3ZpZGVzIG5lY2Vzc2Fy
eQ0KPiBhbW91bnQgb2YgbWVtb3J5IHRvIFREWCBNb2R1bGUgZm9yIGl0cyBiYXNpYyBmdW5jdGlv
bmFsaXRpZXMsICdkeW5hbWljJw0KPiBtZWFucyBleHRyYSBtZW1vcnkgaXMgbmVlZGVkIG9ubHkg
aWYgbmV3IG9wdGlvbmFsIGZlYXR1cmVzIGFyZSB0byBiZQ0KPiBlbmFibGVkLiBTbyBhZGQgYSBu
ZXcgbWVtb3J5IGZlZWRpbmcgcHJvY2VzcyBiYWNrZWQgYnkgYSBuZXcgU0VBTUNBTEwNCj4gVERI
LkVYVC5NRU0uQURELg0KPiANCj4gVGhlIHByb2Nlc3MgaXMgbW9zdGx5IHRoZSBzYW1lIGFzIGFk
ZGluZyBQQU1ULiBUaGUga2VybmVsIHF1ZXJpZXMgVERYDQo+IE1vZHVsZSBob3cgbXVjaCBtZW1v
cnkgbmVlZGVkLCBhbGxvY2F0ZXMgaXQsIGhhbmRzIGl0IG92ZXIsIGFuZCBuZXZlcg0KPiBnZXRz
IGl0IGJhY2suDQo+IA0KPiBUREguRVhULk1FTS5BREQgdXNlcyB0ZHhfcGFnZV9hcnJheSB0byBw
cm92aWRlIGNvbnRyb2wgKHByaXZhdGUpIHBhZ2VzDQo+IHRvIFREWCBNb2R1bGUuIEludHJvZHVj
ZSBhIHRkeF9jbGZsdXNoX3BhZ2VfYXJyYXkoKSBoZWxwZXIgdG8gZmx1c2gNCj4gc2hhcmVkIGNh
Y2hlIGJlZm9yZSBTRUFNQ0FMTCwgdG8gYXZvaWQgc2hhcmVkIGNhY2hlIHdyaXRlIGJhY2sgZGFt
YWdlcw0KPiB0aGVzZSBwcml2YXRlIHBhZ2VzLg0KPiANCj4gRm9yIG5vdywgVERYIE1vZHVsZSBF
eHRlbnNpb25zIGNvbnN1bWUgcmVsYXRpdmVseSBsYXJnZSBhbW91bnQgb2YNCj4gbWVtb3J5ICh+
NTBNQikuIFVzZSBjb250aWd1b3VzIHBhZ2UgYWxsb2NhdGlvbiB0byBhdm9pZCBwZXJtYW5lbnRs
eQ0KPiBmcmFnbWVudCB0b28gbXVjaCBtZW1vcnkuIFByaW50IHRoaXMgcmVhZG91dCB2YWx1ZSBv
biBURFggTW9kdWxlDQo+IEV4dGVuc2lvbnMgaW5pdGlhbGl6YXRpb24gZm9yIHZpc2liaWxpdHku
DQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFh1IFlpbHVuIDx5aWx1bi54dUBsaW51eC5p
bnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oIHwgIDEgKw0K
PiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgOTIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90
ZHguaCBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiBpbmRleCA4NzBiYjc1ZGEzYmEu
LjMxY2NkZmNmNTE4YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5o
DQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaA0KPiBAQCAtNjAsNiArNjAsNyBA
QA0KPiAgI2RlZmluZSBUREhfVlBfV1IJCQk0Mw0KPiAgI2RlZmluZSBUREhfU1lTX0NPTkZJR19W
MAkJNDUNCj4gICNkZWZpbmUgVERIX1NZU19DT05GSUcJCQlTRUFNQ0FMTF9MRUFGX1ZFUihUREhf
U1lTX0NPTkZJR19WMCwgMSkNCj4gKyNkZWZpbmUgVERIX0VYVF9NRU1fQURECQkJNjENCj4gIA0K
PiAgLyogVERYIHBhZ2UgdHlwZXMgKi8NCj4gICNkZWZpbmUJUFRfTkRBCQkweDANCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguYw0KPiBpbmRleCA0ZmI1NmJiNDQyZjAuLjVmYWUxN2MxMzE5MSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYw0KPiBAQCAtNTYwLDcgKzU2MCw3IEBAIHN0YXRpYyBpbnQgdGR4X2FsbG9jX3Bh
Z2VzX2NvbnRpZyh1bnNpZ25lZCBpbnQgbnJfcGFnZXMsIHN0cnVjdCBwYWdlICoqcGFnZXMsDQo+
ICAgKiBTaW1pbGFyIHRvIHRkeF9wYWdlX2FycmF5X2FsbG9jKCksIGFmdGVyIGFsbG9jYXRpbmcg
d2l0aCB0aGlzDQo+ICAgKiBmdW5jdGlvbiwgY2FsbCB0ZHhfcGFnZV9hcnJheV9wb3B1bGF0ZSgp
IHRvIHBvcHVsYXRlIHRoZSB0ZHhfcGFnZV9hcnJheS4NCj4gICAqLw0KPiAtc3RhdGljIF9fbWF5
YmVfdW51c2VkIHN0cnVjdCB0ZHhfcGFnZV9hcnJheSAqDQo+ICtzdGF0aWMgc3RydWN0IHRkeF9w
YWdlX2FycmF5ICoNCj4gIHRkeF9wYWdlX2FycmF5X2FsbG9jX2NvbnRpZyh1bnNpZ25lZCBpbnQg
bnJfcGFnZXMpDQo+ICB7DQo+ICAJcmV0dXJuIHRkeF9wYWdlX2FycmF5X2FsbG9jKG5yX3BhZ2Vz
LCB0ZHhfYWxsb2NfcGFnZXNfY29udGlnLCBOVUxMKTsNCj4gQEAgLTY0Myw3ICs2NDMsNyBAQCBF
WFBPUlRfU1lNQk9MX0dQTCh0ZHhfcGFnZV9hcnJheV9jcmVhdGVfaW9tbXVfbXQpOw0KPiAgI2Rl
ZmluZSBIUEFfTElTVF9JTkZPX1BGTgkJR0VOTUFTS19VNjQoNTEsIDEyKQ0KPiAgI2RlZmluZSBI
UEFfTElTVF9JTkZPX0xBU1RfRU5UUlkJR0VOTUFTS19VNjQoNjMsIDU1KQ0KPiAgDQo+IC1zdGF0
aWMgdTY0IF9fbWF5YmVfdW51c2VkIGhwYV9saXN0X2luZm9fYXNzaWduX3JhdyhzdHJ1Y3QgdGR4
X3BhZ2VfYXJyYXkgKmFycmF5KQ0KPiArc3RhdGljIHU2NCBocGFfbGlzdF9pbmZvX2Fzc2lnbl9y
YXcoc3RydWN0IHRkeF9wYWdlX2FycmF5ICphcnJheSkNCj4gIHsNCj4gIAlyZXR1cm4gRklFTERf
UFJFUChIUEFfTElTVF9JTkZPX0ZJUlNUX0VOVFJZLCAwKSB8DQo+ICAJICAgICAgIEZJRUxEX1BS
RVAoSFBBX0xJU1RfSU5GT19QRk4sDQo+IEBAIC0xNTEzLDYgKzE1MTMsOTQgQEAgc3RhdGljIHZv
aWQgdGR4X2NsZmx1c2hfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gIAljbGZsdXNoX2NhY2hl
X3JhbmdlKHBhZ2VfdG9fdmlydChwYWdlKSwgUEFHRV9TSVpFKTsNCj4gIH0NCj4gIA0KPiArc3Rh
dGljIHZvaWQgdGR4X2NsZmx1c2hfcGFnZV9hcnJheShzdHJ1Y3QgdGR4X3BhZ2VfYXJyYXkgKmFy
cmF5KQ0KDQpJdCBkb2Vzbid0IGNsZmx1c2ggdGhlIHBhZ2UgYXJyYXksIGl0IGNsZmx1c2hlcyB0
aGUgY3VycmVudCBwb3B1bGF0ZSBjaHVuay4gSG1tLg0KRG9lcyBpdCBzdWdnZXN0IHRoYXQgdGhl
IHBhZ2UgYXJyYXkgYW5kIHRoZSBmb3JtYXQgZm9yIGhhbmRpbmcgdGhlbSB0byB0aGUgVERYDQpt
b2R1bGUgYXJlIHR3byBkaWZmZXJlbnQgdGhpbmdzPw0KDQo+ICt7DQo+ICsJZm9yIChpbnQgaSA9
IDA7IGkgPCBhcnJheS0+bmVudHM7IGkrKykNCj4gKwkJdGR4X2NsZmx1c2hfcGFnZShhcnJheS0+
cGFnZXNbYXJyYXktPm9mZnNldCArIGldKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCB0ZHhf
ZXh0X21lbV9hZGQoc3RydWN0IHRkeF9wYWdlX2FycmF5ICpleHRfbWVtKQ0KPiArew0KPiArCXN0
cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gKwkJLnJjeCA9IGhwYV9saXN0X2luZm9f
YXNzaWduX3JhdyhleHRfbWVtKSwNCj4gKwl9Ow0KPiArCXU2NCByOw0KPiArDQo+ICsJdGR4X2Ns
Zmx1c2hfcGFnZV9hcnJheShleHRfbWVtKTsNCj4gKw0KPiArCWRvIHsNCj4gKwkJciA9IHNlYW1j
YWxsX3JldChUREhfRVhUX01FTV9BREQsICZhcmdzKTsNCj4gKwkJY29uZF9yZXNjaGVkKCk7DQo+
ICsJfSB3aGlsZSAociA9PSBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFKTsNCj4gKw0KPiArCWlm
IChyICE9IFREWF9TVUNDRVNTKQ0KPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCXJldHVy
biAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IHRkeF9leHRfbWVtX3NldHVwKHN0cnVjdCB0
ZHhfcGFnZV9hcnJheSAqZXh0X21lbSkNCj4gK3sNCj4gKwl1bnNpZ25lZCBpbnQgcG9wdWxhdGVk
LCBvZmZzZXQgPSAwOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKg0KPiArCSAqIHRkeF9wYWdl
X2FycmF5J3Mgcm9vdCBwYWdlIGNhbiBob2xkIDUxMiBIUEFzIGF0IG1vc3QuIFdlIGhhdmUgfjUw
TUINCj4gKwkgKiBtZW1vcnkgdG8gYWRkLCByZS1wb3B1bGF0ZSB0aGUgYXJyYXkgYW5kIGFkZCBw
YWdlcyBidWxrIGJ5IGJ1bGsuDQo+ICsJICovDQo+ICsJd2hpbGUgKDEpIHsNCj4gKwkJcG9wdWxh
dGVkID0gdGR4X3BhZ2VfYXJyYXlfcG9wdWxhdGUoZXh0X21lbSwgb2Zmc2V0KTsNCj4gKwkJaWYg
KCFwb3B1bGF0ZWQpDQo+ICsJCQlicmVhazsNCg0KRm9yIHRoaXMgY2FzZSBvZiBwb3B1bGF0ZSBp
dCBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIG9rIHRvIGtlZXAgYW4gYXJyYXkgb2YgUEEncw0KaW5z
dGVhZCBvZiBhbiBhcnJheSBvZiBzdHJ1Y3QgcGFnZXMuIE5vdCBzdXJlIG9uIGl0IHlldC4NCg0K
PiArDQo+ICsJCXJldCA9IHRkeF9leHRfbWVtX2FkZChleHRfbWVtKTsNCj4gKwkJaWYgKHJldCkN
Cj4gKwkJCXJldHVybiByZXQ7DQo+ICsNCj4gKwkJb2Zmc2V0ICs9IHBvcHVsYXRlZDsNCj4gKwl9
DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZCBpbml0X3RkeF9leHQodm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgdGR4X3BhZ2VfYXJyYXkg
KmV4dF9tZW0gPSBOVUxMOw0KPiArCXVuc2lnbmVkIGludCBucl9wYWdlczsNCj4gKwlpbnQgcmV0
Ow0KPiArDQo+ICsJaWYgKCEodGR4X3N5c2luZm8uZmVhdHVyZXMudGR4X2ZlYXR1cmVzMCAmIFRE
WF9GRUFUVVJFUzBfRVhUKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlucl9wYWdlcyA9IHRk
eF9zeXNpbmZvLmV4dC5tZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdlczsNCj4gKwkvKg0KPiArCSAq
IG1lbW9yeV9wb29sX3JlcXVpcmVkX3BhZ2VzID09IDAgbWVhbnMgbm8gbmVlZCB0byBhZGQgbW9y
ZSBwYWdlcywNCj4gKwkgKiBza2lwIHRoZSBtZW1vcnkgc2V0dXAuDQo+ICsJICovDQoNCklzIHRo
aXMgZXZlciBleHBlY3RlZD8gRXh0ZW5zaW9ucyBhcmUgc3VwcG9ydGVkLCBidXQgcmVxdWlyZSBu
byBwYWdlcz8NCg0KPiArCWlmIChucl9wYWdlcykgew0KPiArCQlleHRfbWVtID0gdGR4X3BhZ2Vf
YXJyYXlfYWxsb2NfY29udGlnKG5yX3BhZ2VzKTsNCj4gKwkJaWYgKCFleHRfbWVtKQ0KPiArCQkJ
cmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwkJcmV0ID0gdGR4X2V4dF9tZW1fc2V0dXAoZXh0X21l
bSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlnb3RvIG91dF9leHRfbWVtOw0KPiArCX0NCj4gKw0K
PiArCS8qIEV4dGVuc2lvbiBtZW1vcnkgaXMgbmV2ZXIgcmVjbGFpbWVkIG9uY2UgYXNzaWduZWQg
Ki8NCj4gKwl0ZHhfcGFnZV9hcnJheV9jdHJsX2xlYWsoZXh0X21lbSk7DQoNClRoaXMgbG9va3Mg
dmVyeSB3ZWlyZCB0byBjYWxsICJsZWFrIiBpbiB0aGUgc3VjY2VzcyBwYXRoLg0KDQo+ICsNCj4g
Kwlwcl9pbmZvKCIlbHUgS0IgYWxsb2NhdGVkIGZvciBURFggTW9kdWxlIEV4dGVuc2lvbnNcbiIs
DQo+ICsJCW5yX3BhZ2VzICogUEFHRV9TSVpFIC8gMTAyNCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsN
Cj4gKw0KPiArb3V0X2V4dF9tZW06DQo+ICsJdGR4X3BhZ2VfYXJyYXlfZnJlZShleHRfbWVtKTsN
Cj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaW5pdF90ZHhf
bW9kdWxlKHZvaWQpDQo+ICB7DQo+ICAJaW50IHJldDsNCg0K
