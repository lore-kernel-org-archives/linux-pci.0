Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795224925;
	b=CEPf0Xf/TW9XeXVJa1aElfSnSG8KXsXyHGROJdlRhnK35uFCLB/uOZSEX4afieNvKmWQ
	 66mC8C8vy3gSlcxqxbYORwpacM+Cb1wnd5Lh8hiSsG5bkfugph0u3VXzVCKoAUywifveV
	 CY/h7bpM5BhKQ9gN2f0D2wXDkIPMjSGJZ+6pFXeag/a9Q8q2LY0xLxT5Lbbbju8uXs2JH
	 TnSBnGmMjS7h2IMdbSo0srTYJQIKN8I0QWF5WpKYAZlnrA113t8Q+d4Rsbz1vxDtHmAJ+
	 2ml+3ugYKtpEdybLdiK5zO0fFrD7OzVsEeWche+1m1kZMg89nj4Q3nYY+2zHx6QpWaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224925;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1/FTBJQ8f7cUJ7nI0iaIfyFjH3luS1nzNnHWHWphRcU=;
	b=iu3tTh7gVH6y4BuPeDfYcbmpRp/6a7RyKm37u8crXUcuHlWtAfdDpnZIA9Jz6HGwlNQ0
	 yAltxpQUc1nCe2BppV57wAQHUBb/PJgkWzuVF6C88ElgDTl+O2AvVUxyDk18+UFu6fGKH
	 Dx0/1ohUGRVWubUXGbL4N/7WtR6omB7BrxaBmYKgEys/IaO7t7tbKYA9qFiHVUT2Tvj9v
	 zp+wMN9ef2cBmhOQu3NX/mbSyvyPkEeqPNAbvP4+4fbytP1SA1GgmLXwj8h1Jh+T9x8lb
	 0zw+s14z16/+dJy4hCQye/SxKe46dPmahXL0edi+QZo9J5j0/B/vNCumf5cSsqArSuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AoiuCyJ4;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E0FAjCZj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B7606A6B7;
	Sat, 21 Nov 2026 01:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49B7606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AoiuCyJ4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E0FAjCZj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795224923; x=1826760923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1/FTBJQ8f7cUJ7nI0iaIfyFjH3luS1nzNnHWHWphRcU=;
  b=AoiuCyJ4kjS3bKwRXwivMA3O2cGk2RkcJL73Ir1gKkBcKWZSWOqTTo4Y
   tZaLvWImCetGv/bLUC8GXItj8w0Ot1xABLhjj+kBH7HDop1SS1WEr0F64
   y8UlkZTNObyEUUR9HCc2uCut/icb6v7BNQ/y93R2aQ8svkdLpWR4p8RFH
   F5lAdzxqFTZLGkJcVgDWvh4LsfFPFEEu0TmcBMcIarTp3CxBrceBiGHrl
   lj1jgJRcdP/I/Od/y9U4MGCjQqmpXt/YAcnCgFBAs+AoT6x0X7P8rEB6v
   knUhtCsqbRwbPFmr+NooafowQXRfH0Qq+YG0wZz7WaFikRXCJIYhcrEF8
   g==;
X-CSE-ConnectionGUID: Sj2LEFr9Qdmc/Ebsun/yAg==
X-CSE-MsgGUID: 4R0b4bJNSzqk9pC/gX2QPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3960968"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="3960968"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:35:18 -0800
X-CSE-ConnectionGUID: nr+IAxPTTzi3gM8lEFfqDg==
X-CSE-MsgGUID: CAPjytWDTSa2W18vvtcsSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="10737162"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:35:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 17:35:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 17:35:14 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 17:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJdJqY5AatP10iiDcbv3VJz41xhF9LEc/BX9vKEiP/I3tMFRqmsEyjrHQ1Jmiten2wIpgp7O/LIU8B8cJGeYHL7UsqWKqD+ikREfINmr8nsmwjAffVyuia3zWu9WP3tw9TedyVsu232T1dOTHYnemV8dJ/f68uCvbs+OK6iywW2iOHo+bGSMf8NX7NyvD568jrY+S+IeZq2pW6vScRgKX2dZ4KQTG5PsKoF3MEu+T+uCMbWq+EEgVxQ5RZvkD1ZGqiXx3xhAjtdndDLoOzWGMQOKUSgkpdgZQaKfEhZAllr9qsRgmP5OA5l5ULAcx3S0KXgsFCelHEE33R+mRNqpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/FTBJQ8f7cUJ7nI0iaIfyFjH3luS1nzNnHWHWphRcU=;
 b=BzHSdErzCGhhP9aq7rSEf4Ostf1COu3RfilIQ9l1HgRM5csO0OASklISruAVzCcyewRtFGyZ4XL27MospPEeI6CGZ4My7zXxScUgl8wKZEyVfvVpekdTtOK44KJ6N+bqywlngzkYkI2KeXoen3DktF6ySb8juWw8p3M0F+RklD1ROWlqt4dWF4JGm/4VJznMi3nkZrTlMxsjb0uj+mTHkjyjxgs21YZYVn6gJC2bLJr2fcW2WlR8Xw3vH23vo/msXpLK8i6IHSZwNclY+a1ihNACJDU3T150gSkf4F2hXB8AAX94m7kotOdHfXWe5nA8bKyKQHARdDp8GddD7yV8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/FTBJQ8f7cUJ7nI0iaIfyFjH3luS1nzNnHWHWphRcU=;
 b=E0FAjCZj+JzsBPHLbs7XpavnTAtl0fCXGfvlCEtTLuNEgBvsXs6R6NGztzJfBgynjBMbi5PSCy5NxQeAOEo4HrO65S4Ctr8n0S5Al0n15uPw3QQI2oeNnzSh23sQMyT6q2JPwSCRO62IPdparMWKEXqbTId/BzRWLmj4gT6jVXo=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SJ0PR11MB5022.namprd11.prod.outlook.com
 (2603:10b6:a03:2d7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Sat, 21 Nov
 2026 01:35:10 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 01:35:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RFC PATCH 0/7] TDX: Enable PCIe link encryption for trusted I/O
Thread-Topic: [RFC PATCH 0/7] TDX: Enable PCIe link encryption for trusted I/O
Thread-Index: AQHddbsHPi1/gebqbU6U4KLrXKenMbc3xaEA
Date: Sat, 21 Nov 2026 01:35:10 +0000
Message-ID: <76f4fbf366451fe48d689ce9c8b231b9fe07338a.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
In-Reply-To: <20261116111037.3478844-1-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SJ0PR11MB5022:EE_
x-ms-office365-filtering-correlation-id: 6e355f19-e6e5-401a-6f5a-08df476fae98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|38070700021|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ikv5khtoinHMLFHvzwECWIBnspdRnWG2zBb36EfRgnsXHU6LOlNaSKkc/CIJQo4cDromEt51NSBPk8VF9XsNiT8ZRnbAJscaTx18iTWbd1Q8rNfwbfv1jQuRxJQdU/ezJMNWKwaTZN42yGqRM66G6RPevNamPR08NwS2QjvYmsU6NYzCrnCuys3HiJu38HT+VVrhhkK/a//w5zKoBPM/B+Iu2wqIGkNZ0wofuzEcyMjhPAhYVdjQd0HEnsQHP7FUusUi6Ov4DXXe1O32dkhB2qOvmCR1ibuhxXS+MgsC37dK1uzhCfi68gbJBVDLLSjNiLnzDS4NPrdrU/sGec7MQLhmsVdBcdQQgUXyvjfqlhA9mlV5OqIgurQ3Pod/0sD5xjL+bmnYDdwPy5K5fdjWY17OY3OyUQ0s1LXAeq8z3/IHojEKWK2GXhnvlJ+eMxfWq1n+ArQsnydD0xuMzgnaHNqYs1nyjiYmR834B8p0RZ4YPbvSky2k0OXsgGWc+jpyOn3TN+FB2Kbu5oW1pPjhY1VcgufMDwUAQZNUxw5HdTn/1+seftHYXBKmNMtFSOkREiSfbRoHbUdjmBHOI4CYXP5nNnmnILEBbVR9IU5K9j1t187qBle3YEBg4r0qF2PRkIs0ukmIgUCRgd7DRuB36h6IK6fa0umej69qt2rLvBIS0jcgQsBWcXv9XM/RaDF6YdDnMop+OKeJCBpJDtqRYjI+iLbojqZP2fhFXWPmeec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVN1M3BiajlPSUV5YWZvWWxIQ2VaUWk0THlYNWU0ZkNnRWIxcDBDdWlScGZD?=
 =?utf-8?B?TEl5QWVGdHVOTWlTZ3JvUjZyQWVLWnU4dytROWh1elRINzlKMFc1VTNoTjFz?=
 =?utf-8?B?dWVqcTZJVXpUZW05d3dzRmphV1JxaDI1VnB2SWo3T2FqeXZXcWxXTFBYRk5S?=
 =?utf-8?B?Vzc0OXpQN1lCVWhEVUJldG1rTXN3Wnd2TFlFWUxRTENtYnBxQ1FwUXdtOGtW?=
 =?utf-8?B?dHloSmFGNzNVZThCVm1rQjlwcjNHeVRnRks1Y0xBb28xQW9ZTGVKeEYyWWFY?=
 =?utf-8?B?ZE8zQjBEbU9pMHoySVJFa1QrbW4xOUVrdER3Y0NpdmhDUG5VbUUyamJ1YWZP?=
 =?utf-8?B?Q0hXeitXQ0RldFVDK2VjVElxaGlKdENYMCt3WEY4N2lpdHh5c0NXNkJsekhm?=
 =?utf-8?B?TnFDYUUxL2djdWZuUC9uOHFtZ2hmZlQ5K1R0eDRZdVQzdDk5U3VOa3dlSGdz?=
 =?utf-8?B?UmlJY2l6Y1dMN2hSMlFqS2dYaWRFRERVQWlWUHU4THRNU1JiZy9xcXlwU0I0?=
 =?utf-8?B?WUFJdW5GSnpIbnEyT0RXZnY3bTc4MWJ5TjRzazNrUnVJL2tlZzl5RnlVOXZK?=
 =?utf-8?B?aUhNcUx6R0pFbG9OUmhMcSs5RXhPdURCbU5acEw2ZlhBR1FsT3h4Qk1DQ2l3?=
 =?utf-8?B?NmZGZGhjQXBLOW9WQnZoNE1EWkJSbUxJNE9RZWd1d1dCdzNiSElnS1hBcmNi?=
 =?utf-8?B?NkRNaWg4bm5ubldTdmFxOWFZZkcwd2VpVWZJWnJDb2VBMDFXdTE3ck9ISTIy?=
 =?utf-8?B?bk1tUmJMTjhaZzdOSXZ0L0w4QXFhMVltM1RqWnI3dWJoVVpFYmRuTE90aTNp?=
 =?utf-8?B?ZkVnbXh0dGdmRFBOeGRkcjA1NWRrNEJDT213U1VkS2Z0Y2NHakRKYWY4dnZu?=
 =?utf-8?B?bGZGRDFYNUNHbkVYbkpuT0pFTnhUZ2dPN1NSbUFpK0wvdjZGYU4vcDZHcnd1?=
 =?utf-8?B?NHB0OFhWK1g1ZzRuck5FWTVZZ0Z5cVJMM2pDU2h2d2szcFRzdU0rZHlsbTBJ?=
 =?utf-8?B?bzBHT2t5bmhFZnhXT0E3RzBKT2VlajZxY21wSzFqd05VYmNkQ0xscUp3SFB0?=
 =?utf-8?B?blUySGk0YmUrcG10Ri9GNXhwUDVLUmhtTjlQSUlaVGRtQnZzc3lrRi9PUHlX?=
 =?utf-8?B?UTFSaHlqM2Q3TVZHdWxCeXJzM010ZE0rc21LblliMjNRdEV1YVgvU2k0V3hK?=
 =?utf-8?B?TGVTWmU0Z0xibnpoK0U5RjQwKy9OMzJQUXZKYUc2NkJ1c1dBNWE0SisvcVg1?=
 =?utf-8?B?RVNieGlCUmdta0FYeWJ0Z0VpU3ZtMEZmanUxOHhodGllTCt5eGc3dDdiS2lz?=
 =?utf-8?B?SmpZaVFZbW5XeXhwTXcrMElocW04dEtPQjFVdzdrMFNnWHdtTGZhQnY5V1hK?=
 =?utf-8?B?alMvMkkrNTl2UzRjeEhhRGxBYVZJTGJiQ0JpdEZzNHdZdUZLNGFRRlBNMXNQ?=
 =?utf-8?B?RmFTR1ZEdkRXMWpvNWxJcUNjdVI2RXN3RS9GcXJGa3VwQjcxN1dwWlE0Vkt1?=
 =?utf-8?B?aEI5QlRub0pZUEZZU0tFQ3FMQmM0aVJFRlhrSmQzZ3pSNXR3YzVpckMySDM1?=
 =?utf-8?B?a2hiemFvejNmSml5bU1ra0VrOHhDaDFHYVViTDQ0enZ3RTlWSVZUeTRNbUYz?=
 =?utf-8?B?SGNPMkhvQklFL3NjWUNFQjhGbFpSdXAyM0N2VzMrNzZrYVBmN2h4RjRQRDJS?=
 =?utf-8?B?Q0xha0xybUZTdW9QRzcrd0JISHFGSlphN0NmSkRua0RZcXBsdXJrVVlSMTNC?=
 =?utf-8?B?aEc5SmVzSW9WdDN4THVQckpFZ0p0UnBKcU5mTlpqSzRtT0lZbCtVVnNFbjIx?=
 =?utf-8?B?aytTQ2RwK3BYZCtzWVJQZjRtU3o0U1VpdGtkUFk3NHZVTktCeWFmV28rL0lH?=
 =?utf-8?B?bTF6ZHhBY0xUb252STk5R3BpWXNUTDI5bG13M1NQWFl6SkVSajA4QzdWeW44?=
 =?utf-8?B?a0FDMEJtek04WTJCSmpKS2FiRWRKMyt4blBSajZUdkk4NkFwTUc0OElCQTh6?=
 =?utf-8?B?RTZ1NlNsV1VNQXNpVG9hYkNWaEt6ME53NFpXdXRUbU54cXpCcXhNd25GM0dV?=
 =?utf-8?B?Ynhvc2JTTS9tNXVtSUp6YTVFRDNJR0hpSHNSRW5UQWFmK3NlTUVNTE1WQTJE?=
 =?utf-8?B?K1FQdkpKUjNpanptVlUzUlQ4R3JiRjk1Y0NJWitzZHhjQjZDbXpUUGwxd2FE?=
 =?utf-8?B?WjVXLzh2L1VUaU4vbUVHTTJKZ2FFbmRPZUp3WU9HenBRdHBVZkZ1V2N4KzZ6?=
 =?utf-8?B?c0h6eWQ1T0lBS2E2dk41M3VoS0JydGRUWU5zakMrelZEWGVGUWlzaWdjUFY0?=
 =?utf-8?B?RHcxczhrUnYrZjRRcVZUSnB5d2FVUkZhdk8xdllWcTQzcGVyNFZGOUVFVERS?=
 =?utf-8?Q?K7U9vsZUcuL39p8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3DADCBD140B7241BF5122F7F20BAC87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QZLgQnmiWe/neC0unfNKWzoW1RZt1faGfV+GGHfvbNlUHXxeZwp4OFCTde5rOAJ5WuR2iAfTiIVzbhzF+WJrT+vxRFKlOuXSjuE71tRXp9GCrXFVPiTueurJWHn5trnXlLA/ktBbkXEMVgHGHHsq6gO2vJuurGdaA+lqPyTZKGp+HJ53AKT0CwkBu8B/hSw1jJ2noDZiLkKX802ThONzSlqYR75l2/wXoxLfNGDyA9NvUfkhPDKwDHgTJgucu1x1KelCxdSUMWUx4bTq0/fL/itA/fm28KeyOmqG7azPFe/lqNV7/KvPMGXjDSWivfB1ozrd/Jf2DcOAFcO7Um123Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e355f19-e6e5-401a-6f5a-08df476fae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 01:35:10.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67uijaqSholHsWZ+16MapCmp/YMcc/iE+ig79GfPzDeq68C/DVeLDyEJ5YdMKW627SGdM6FkQpFZOu1bf0Gy2furXtmVmk/Er4ZKVDDId0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTE2IGF0IDAzOjEwIC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPT0g
UG9pbnRzIGZvciBkaXNjdXNzaW9uID09DQo+IA0KPiAxLiBSYXcgRE9FIGZyYW1lcyAoU2VlIHBh
dGNoIDMpDQo+IA0KPiBUaGUgVERYIG1vZHVsZSBwcm9kdWNlcyBhbmQgY29uc3VtZXMgd2hvbGUg
RE9FIG9iamVjdHMsIGhlYWRlciBpbmNsdWRlZCwNCj4gYnV0IHRoZSBQQ0kgRE9FIEFQSSB0YWtl
cyBwYXlsb2FkcyBvbmx5LiBUaGUgVERYLVRTTSBkcml2ZXIgdGhlcmVmb3JlDQo+IHN0cmlwcyBh
bmQgcmVidWlsZHMgdGhlIERPRSBoZWFkZXIgaXRzZWxmLiBUaGUgY29kZSBpcyBzbWFsbCwgYnV0
IGl0DQo+IHB1dHMgRE9FIGZvcm1hdCBkZXRhaWxzIGluIGEgVFNNIGRyaXZlciwgd2hpbGUgdGhl
IERPRSBjb3JlIGFscmVhZHkNCj4gaGFuZGxlcyB0aGVtLiBBIFBDSSBET0UgQVBJIHRoYXQgdGFr
ZXMgd2hvbGUgb2JqZWN0cyB3b3VsZCBrZWVwIHRoZW0gaW4NCj4gdGhlIGNvcmUsIGJ1dCB0aGUg
VERYLVRTTSBkcml2ZXIgd291bGQgYmUgaXRzIG9ubHkgdXNlci4gSXMgc3VjaCBhbiBBUEkNCj4g
d29ydGggYWRkaW5nLCBvciBjYW4gd2UgbGl2ZSB3aXRoIHRoZSBET0UgZm9ybWF0IGhhbmRsaW5n
IGluIHRoZQ0KPiBURFgtVFNNIGRyaXZlcj8NCg0KV2h5IGNhbid0IHRoZSBURFggbW9kdWxlIHJl
dHVybiB3aGF0IHdlIG5lZWQ/IEkgZ3Vlc3MgQU1EJ3MgZmlybXdhcmUgbXVzdA0KYWxyZWFkeSBy
ZXR1cm4ganVzdCB0aGUgcGF5bG9hZC4gQW55IGlkZWEgd2hhdCBBUk0gd2lsbCBkbz8NCg0KPiAN
Cj4gMi4gRGVmYXVsdCBJREUgU3RyZWFtIChTZWUgcGF0Y2ggNSkNCj4gDQo+IFRESVNQIHJlcXVp
cmVzIGVhY2ggZGV2aWNlIHRvIGhhdmUgb25lIGRlZmF1bHQgSURFIHN0cmVhbSBbOF0uIFRoZSBQ
Q0kNCj4gY29yZSBkb2VzIG5vdCBzZXQgRGVmYXVsdCBTdHJlYW0sIHNvIGVhY2ggVFNNIGRyaXZl
ciBzZXRzIGl0IGl0c2VsZiwgYnkNCj4gbG9va2luZyB1cCB0aGUgZGV2aWNlJ3MgSURFIHNldHRp
bmdzIHdpdGggcGNpX2lkZV90b19zZXR0aW5ncygpIGFuZA0KPiBzZXR0aW5nIGRlZmF1bHRfc3Ry
ZWFtLiBBTUQncyBkcml2ZXIgYWxyZWFkeSBkb2VzIHRoaXMsIGFuZCB0aGUgVERYLVRTTQ0KPiBk
cml2ZXIgZG9lcyB0aGUgc2FtZS4gU2luY2UgdGhlIHJlcXVpcmVtZW50IGlzIHNoYXJlZCwgdGhl
IFBDSSBjb3JlDQo+IGNvdWxkIGluc3RlYWQgc2V0IERlZmF1bHQgU3RyZWFtIG9uIHRoZSBkZXZp
Y2UncyBUQzAgc3RyZWFtLCB3aGljaCBpcw0KPiB3aGF0IFRESVNQIGV4cGVjdHMuIFNob3VsZCB0
aGlzIG1vdmUgaW50byB0aGUgUENJIGNvcmUgbm93LCBvciBjYW4gaXQgYmUNCj4gYSBsYXRlciBj
bGVhbnVwPw0KDQpOb3QgdmVyeSBzdXJlIG9uIHRoaXMgcG9pbnQuIERvIHlvdSB0aGluayB0aGUg
VFNNIGRyaXZlcnMgd291bGQgbmV2ZXIgd2FudCB0bw0KcGljayBhIGRpZmZlcmVudCBkZWZhdWx0
IHN0cmVhbT8gSWYgdGhleSBkaWQgaXMgdGhlcmUgYSBwb2ludCB0byBtb3ZpbmcgaXQ/DQpNaWdo
dCBiZSBiZXR0ZXIgdG8gd2FpdCB0byBzZWUgaG93IGl0IHNoYWtlcyBvdXQuDQoNCj4gDQo+ID09
IExpbWl0YXRpb25zID09DQo+IA0KPiBUaGUgVERYIG1vZHVsZSBjb25maWd1cmVzIHRoZSByb290
IHBvcnQncyBJREUgc2V0dGluZ3MgYW5kIGFjY2VwdHMNCj4gb25seSBvbmUgYWRkcmVzcyByYW5n
ZSBmb3IgdGhlIHN0cmVhbS4gVGhlIHJvb3QgcG9ydCB0aGVyZWZvcmUgZW5jcnlwdHMNCj4gb25s
eSB0cmFmZmljIHRvIHRoZSBkZXZpY2UncyBwcmVmZXRjaGFibGUgTU1JTyByYW5nZSwgYW5kIGEg
ZGV2aWNlIHdpdGgNCj4gbm8gcHJlZmV0Y2hhYmxlIHJhbmdlIGNhbm5vdCBiZSBjb25uZWN0ZWQu
IFdlIGFyZSBldmFsdWF0aW5nIHdoZXRoZXINCj4gdGhpcyBjYW4gYmUgbGlmdGVkLg0KDQpDYW4g
eW91IGRlc2NyaWJlIGhvdyBpdCBpbXBhY3RzIHRoZSBpbml0aWFsIHN1cHBvcnQgaGVyZT8gSXMg
aXQgYWJvdXQgZW5hYmxpbmcNCm1vcmUgZGV2aWNlcywgb3Igc2ltcGxpZnlpbmcgdGhlIGluaXRp
YWwgY29kZT8NCg0KPiANCj4gTGluayBlbmNyeXB0aW9uIG5lZWRzIHRoZSByb290IGNvbXBsZXgg
dG8gZW50ZXIgYSBURFggbW9kZSwgaW4gd2hpY2gNCj4gb25seSB0aGUgVERYIG1vZHVsZSBjYW4g
Y29uZmlndXJlIHRoZSByb290IHBvcnQncyBJREUgc2V0dGluZ3MuIFRoZQ0KPiBrZXJuZWwgb3B0
cyBpbiB0byB0aGlzIG1vZGUgd2l0aCBUREguSU9NTVUuU0VUVVAuIEFzIGl0cyBuYW1lIHN1Z2dl
c3RzLA0KPiB0aGlzIFNFQU1DQUxMIGFsc28gcHV0cyB0aGUgSU9NTVUgaW50byBURFggbW9kZSwg
d2hpY2ggY2hhbmdlcyB0aGUNCj4gSU9NTVUncyBiZWhhdmlvci4gVW5mb3J0dW5hdGVseSwgdGhl
IHR3byBjYW5ub3QgYmUgZW5hYmxlZCBzZXBhcmF0ZWx5LA0KPiBldmVuIHRob3VnaCBsaW5rIGVu
Y3J5cHRpb24gZG9lcyBub3QgbmVlZCBJT01NVSBURFggbW9kZS4NCg0KSG1tLCB1c3VhbGx5IFRE
WCBpcyBub3QgZWFzeSB0byBlbmFibGUgb24gYSBzeXN0ZW0uIFNvIHVzZXJzIGFyZSBub3QgbGlr
ZWx5IHRvDQphY2NpZGVudGFsbHkgaGl0IHRoZSBleGlzdGluZyBsaW1pdGF0aW9ucy4gU28gSSdt
IHRoaW5raW5nIHdlIGp1c3QgZG8gdGhlIHNhbWUNCmhlcmUuIERvY3VtZW50IHRoZSBsaW1pdHMg
YW5kIG5vdCBhZGQgYSBzd2l0Y2guIEJ1dCB0aGUgbGltaXRzIHNob3VsZCBiZSBjbGVhbmx5DQpo
YW5kbGVkIGFuZCB1bmRlcnN0b29kLiBXaGljaCBpcyBhIFdJUC4NCg==
