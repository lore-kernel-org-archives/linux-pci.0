Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265958;
	b=P75GQ3941PAYxehDVjQlpm4Bgd8KL8hMQWu2CfGgCBAia+sgqBAbKfW2tbn2vGPWAgYE
	 ktAHnVlouNam7EHsPT0GBZ30dPDNmfOhHWuWeuwMTZ6MkWc3XCNos8bBYwtn1ar4WAtka
	 2FJ4i1mPo+4E1dKK0JvB97IN9INIglnMCp6iS3HKcnoCwd+GjxopBmsCyg9HDQX5pX0E1
	 BXaHle+wX3eaLgUtaJJzA6GlZ6VTD8riuhBddE6Bg27UAur2wYEQ5wwDVVCfMUSikxini
	 SGymVWENtOwx581/tEkCoNxaoNx+fgGfKE4W5DIdZAhU2uv4oXSWAVw6zqqnH9K6lOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265958;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=83f6hZosARDJYmkb1WDuY/5S3P8Xawq9LyLXtq/XuXU=;
	b=JOhFURapvsH0p52k8a4ZzMzSyF6q7zgtaXYcgbNC/W2hQCsc4shXLf7RMLViKxvlUB8+
	 HCrgTD69zkWWrVIVvS9KHjgbRJUVLkVqYdIeCU29pBWp1LqeYKNG5TWEd5b3h9JwlBQSF
	 nNIxVfvlk/wOq99g1VjVNwAWWT6fOeKixbJTD4DRai2FEddfTjDqg6E3NsHYRmztAA2f5
	 +UHJ5apTaCyhX6dMvUAqkBEWNzb4TUvUHw3oKdtGBUqGsBzZXBbx81IrboDhQO0wItBPA
	 Ok66TB04ZTCfGZMchMQEc57WrS9u8UvciSVlvivprNPfLEdGJym+aaGtn+IkikxA9MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=AAfWsbS5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010020.outbound.protection.outlook.com [52.103.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2E606A332;
	Sat, 21 Nov 2026 12:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D2E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=AAfWsbS5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM7xcq/oDYuQ5ss/jvIX7CuXIXoqE9d+cQXdJSbFbg0xb01K0GvfekxtLJW1XMNZBPlKoysr7uNCF8xLGvPxL0fBXJM4jDw7qSEXVi3RM0UJpAdDglFFZKOIfmkq8vLRpNB9xIDlyuFPj752gCdIJe3cdnRnhv5VybqecFfYXjQCT2N8BhYVljQuktL6EccDfEME4J4W7jSKzX0nRfQMc2ueb4se8VoZFD7ivW4zzOvwIS0wq8oLZ7/91vjV4SSNF4W45hYeRAnboA1vcmk11e/IZJ0BkLJJLQazAKm1ZY5OfIA5kyg/8iyV4aDpdO3iTfWWJgtlIRQqFhmROCru7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83f6hZosARDJYmkb1WDuY/5S3P8Xawq9LyLXtq/XuXU=;
 b=JcuJgQyzQOiWTGvIJoMHTiFZNxeja3RRvbeNEb8iwPLezkV1dm/5B2vOV+vvzJZ2WWTSpe3QYzCdjYAC8/FB9YTSfM+TGMH+KhllLOTemzbQLUDVgNp9Vjt5vGKz8WvWmYfXaXZvz6WOGB8QDCvR+x9FrO8ssP0r84MyyNwkNIFSaWAnUQgS+HoLNWx7iNWiVhdBxNjAP/PaKGTLlFtN8Hvz3mv1peUW/OtCfL5PXgXf1kaoumUQJ6Gs5sQJf8dHojQRifPH0Vpg0N4c+8Jex5NndIT5cF2lY98E7GH91IiVMu+rUf53ZtGj0tXoVpt1VQiD2tpIJQJIWVVrHt77Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83f6hZosARDJYmkb1WDuY/5S3P8Xawq9LyLXtq/XuXU=;
 b=AAfWsbS5b+zBGbZzHmuinQ3HqK1kV24eVQb/w8K4I9AVxUxglV/C4Hn7qSpelu+o00fwwx8TfU+bpQt7yT8iogTjRdE+z8YzdCGKKuf5T6h0ZJEFm7+PYahcOTW47CmSg/lAwob5c4PkpGy6kkpTtu1fKVIMtjA4gzgXtg3Z82yk/hu2jkIwtELFsOVBs+qqT5mtLVkKZR1pBcXg2oDGPBvPtgu1ppj1byjl2U7c4bX1liDNnvgXQkzDKNSq+FxHv9lKAahIJePG4Eeh6OzzD5SlxywB7olMH0KU+xlZQyzr0kx2vlyLchKNpVHZajw+DgHm4F/eQuCMP7yhQ2F98w==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0248.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 12:59:14 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:59:14 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v3 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v3 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdebgbdrOxB6JETUO2Pv7bYcoO2w==
Date: Sat, 21 Nov 2026 12:59:14 +0000
Message-ID: <20261121125811.50315-2-habilerenturker@hotmail.com>
References: <20261121125811.50315-1-habilerenturker@hotmail.com>
In-Reply-To: <20261121125811.50315-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0248:EE_
x-ms-office365-filtering-correlation-id: 1b7c0fae-07df-43f7-c354-08df47cf3eb5
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|24021099003|51005399006|15080799012|41001999006|8060799015|19110799012|8062599012|25010399006|55001999006|102099032|3412199025|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmFtN0huOUlMczZJd1VWeHVDaXJuMGJsckRQL3BXVUF3VU4rOWdjcGlYMXIv?=
 =?utf-8?B?d0lkb3pEL0Z4eXJmZFVHWnhTYlZ0eFIxY2F4WTlvdXlORkdBR2hKK2ZPS2F0?=
 =?utf-8?B?b24xL2RmWENaNXJnRWNneFNjSllMT3hrM3dTSnhuSjZRMFFtek5ob3V3c2JS?=
 =?utf-8?B?OHNESCtUSSs1ZDZ4TEhCTDVNWDVzNXJmMHNQQ1Y2WUZ3SXNjTEwvcTZjM3FF?=
 =?utf-8?B?L29CUGFObVFGVlY4SHFKY2tUS1BLMCtGTmdGKzZPU3FCVGZ1YlBJR3owSFBj?=
 =?utf-8?B?b1BLU0NRNXgwZElkTHUxVHM1MWJHQmQ5RXhONlg3VnZyd3hxRVRIS3BreklP?=
 =?utf-8?B?UEJCemxia3kvSTQxcGRIcklKME1XanpwWjhWRTJtck1oNlpya3g4d3J3Ymt5?=
 =?utf-8?B?TWV0ZUVCdmNlVlNuVzdwb1hBcnQzQm9Ddm9rREQyaEFySVJrTStMZjlNZkxo?=
 =?utf-8?B?RzZENmdhbjVGVGIwUmdzZ0VrVDhLR29FY0N3S1lnNzFpYW5VdC9DS1c2N1Fx?=
 =?utf-8?B?c0hOdU5rUVVUcFhnd0cvNDNvM1pIaTRFVzdYV244SFROdUtrbmhWdWZONVZH?=
 =?utf-8?B?NEhoUmF4WERVeS90a3pTMVdoY000WCtIUHJFdUdUNzA1MmZLaXljcWVyYW0r?=
 =?utf-8?B?M0ZWbHFmRW54NWVDbDd4Uy9DUytwRko2bjJnZUJGR2RJS3R6UjhScnNyRkdX?=
 =?utf-8?B?eUJpZWNOM3ZoalAyajN4cUlveXd1aTN5VVh2TTk2MzZ0RXZ5OFVxcGVVNnJl?=
 =?utf-8?B?a2hld2o4aDhSWURuUmJHc2Nud1RQSFpKQUhJMENYY2xRazBoZ3ExdmZ6Ny9Y?=
 =?utf-8?B?L2hSd3hJMExRbGpjSWFJbW5jK2o5TXk3TVZsc2dRVDlidnpEaVVtb21JTFNp?=
 =?utf-8?B?VWN5UkNmR21rSm50ZkNwMS9EMjdnZnpRblMzT3lzRllzTlpmMno4NElaQkRi?=
 =?utf-8?B?aURVM1FUeUVaKzVTZ1hDM0RJZGdWMkhvdnh1dG5mM001emMyM0lHSVJncWJl?=
 =?utf-8?B?RTI2QmxzZ2lpL0F0L2M2cm1aZVluNktmdGhyVXdqRG5vdjdONDFuWGVJUEFR?=
 =?utf-8?B?eFZIcXpYd0pXT2JYNElkMmhQMEtEZkd4Y0p5ZlpzVXkvcU9xeWs4Z0RCZFJJ?=
 =?utf-8?B?dnMyRFcvMGhzRVM4TnQwSmFPQ0dHZ01wY281R2dkUEI5ckppd2kvUmJTQWlO?=
 =?utf-8?B?YzNaeVFqczkzbHMwaXdSTG5PNXBLTmIrbjhNa0kwMDZ1Y0hqWlE3V25TWG1D?=
 =?utf-8?B?QTNrdGtsUHJrYVBvL3Z2ZXc1dFNUMlhrMVZDSlpGL2Z0WlVyQ2FsRkZsOFhW?=
 =?utf-8?B?VVlHMWw3ZTRNa0dycldCeDFIYUtGQlFmanpNUEVVZU1VVExQTmNWN1FPV2dX?=
 =?utf-8?B?MUJaU2o1emtSZFUrSzQ1OGlOakN5d1kvdWdaYncxZ3FzY1FjcU5TUnIvY1Fn?=
 =?utf-8?Q?UGYjAktv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1htaFVoVVRCc1ZFZDhTcFY2eCtvbGZaRFNSZlhRa3M3SWZvRFRkY1BCWUVP?=
 =?utf-8?B?QTREbFNxQ1A2MUZkOVMzY3gyM291UVJ3SjJkbFpnck5xYkNDMjVBZkhUMFdr?=
 =?utf-8?B?VGg4YWc1NTNEK1ZWS1k2Y0FGZHF3SFh3cnF0VEgyNm03RHljUGJML0UxTkQ0?=
 =?utf-8?B?QWg5R3NUeWdJZHZEeGhtRytmcERrbjZNbmVZVHBFRU8rR1F2S1FzMXY2b0lW?=
 =?utf-8?B?aVVoTE40eGtIM09wV2wxaUROSjZUWXhkaXNOK2Nub3kwOTg1UEY5bVhnNjFS?=
 =?utf-8?B?dDJ6QUlRYzdsZndtTkNJVlN0YVhBNU92VzV4MncyT241S3E2WXVoLzUrTFUr?=
 =?utf-8?B?REZ1SmJLVE1ERHk5b0FyUU4yV0xtRk8vR0RzNDRGb1JxL1ZNaTFHK1VvdlFD?=
 =?utf-8?B?YktmUkpwVlJUbFFDOTdZUVM2SDEvZTZGTlNteS95VnVaSVgxOWFmeU9tOU53?=
 =?utf-8?B?cE9ZUnNxSzJmTjlnZWNkTThCK0JTSWdReGp0UWNaaUFZZ2VENVFEN1dTUWpI?=
 =?utf-8?B?Q3I2eE0vUG5MRkdpcVdkTzg4K0dBemJCYTNybW1WMW9GSytLYkVjRUFzQ1RN?=
 =?utf-8?B?cis3bkRMQmF0WFdzZ2xUb3kxbTZyTzNFKzZmbU1uWGxMR1M2K3dVL2poNEhB?=
 =?utf-8?B?WE5aUEE3bDJmUmticUdXK3N3U3VRKzZJSUtKTlBxdzNtb3hTZVVCQUZha1l5?=
 =?utf-8?B?V2cyZ05Rd1BkTlJPZkhSVTF0RlUyZVZOTDJEUU1RZElhb0p4R24xSlh5cTl4?=
 =?utf-8?B?dTFZR2NhcnBwRFhCcUlWTUZmbWRJMUs3Vlk4QkJubWhNQ1BmWG5NQkszeStz?=
 =?utf-8?B?U2lnZnNBbzFab2Y3UHhXVnZHemc3WFFkRUVMZUUydWdqNzAzM2NZS1REU0VF?=
 =?utf-8?B?ZkROQnZMcXpnU1Q1ckYzTFVYQ1hzbkJJampVRkJaTCtRYk82R3E3OEh6azhU?=
 =?utf-8?B?RHJrbSsyNFA4WDFkazNtWlBnZ1p6bDQ3TVoxcFBBVS91bFNORGtrbjVYbVVz?=
 =?utf-8?B?bkN0Z05MdXlDeDBjbVh3Ky9aeDU3MDR5bEM4WjU2MzZkVFhzMUhTalp6Yzg2?=
 =?utf-8?B?VjZIcW0va0R3aGhFWTQ2SzR6Y1VTLy9BSXJLaksxYXZXeFJCNzJKTThoV2Zp?=
 =?utf-8?B?blVkYlIzTUlLWktXQ3g2NXlzSGRPQTVSV1ZyQjhyRXVVOXlSYjBlVUlSWGJx?=
 =?utf-8?B?TWsxOXpyU3JOcXZTTENuR25NaEVxL0R6QUNtZGw2aDY2TzNGVE9DZU1UTUtm?=
 =?utf-8?B?ZkcyUUVaaTNwYWw2enpwNTBZNU1FcTM2Yk0yOTlFaWcybXR1anJEK2I5cEd4?=
 =?utf-8?B?aW54ZkNwOElSYzVjdVRJS2NraUI1aVNEMFJZNkJzNUFJanJrLzd1ekNGaXFW?=
 =?utf-8?B?akQwczVyUHFUYVdwZi9rd3BXMkh3NEZ2clhicG5CaXcwVHBIYzhaWVY0YnFh?=
 =?utf-8?B?ZEJJdFFQTmhwYVk0QlA3MWJQRkVyVEhsbWxxdHRzbTJ2VExYMHpRS25ValVT?=
 =?utf-8?B?aXhFR0l5OHpiME90dkpTZUdSdGFBcXJ0dVhFVlMyNWMvRDNPdFlLWHV6blQv?=
 =?utf-8?B?dDlXZ09SajlISUtlajlWODUvZ00vNXZvZnhuSlk1Q2xiMG0vdWpVbmFJZnhl?=
 =?utf-8?B?UCtuS3pjS0NaQkZNOHNsazk5L2VTL2htcGpjVWZBbU1HZElkN3lDcExwS2xJ?=
 =?utf-8?B?NDJwbHhaMHlvRWtZSjhjb0N5U3grZkxrNnZRbytVYUVORDN2VW9zUVEzam1o?=
 =?utf-8?B?T1p6OW9SWW4rbTd5bGxoa2ZZR240L1BXbWE2SWhtcytNTlh1M3NMMW0yN0pj?=
 =?utf-8?B?eFRjVUNMWVRrd1lKZ1pJeVh1aG4vQk5iYmZjVDlVbUw0WTdkUkljQ3RXTWQx?=
 =?utf-8?Q?Nc253ZEXovssP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDF45BA9EE236946A1E316D1B9B0D710@POLP291.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7c0fae-07df-43f7-c354-08df47cf3eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 12:59:14.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0248

QWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gZXh0cmFjdCwgc2V0IGFuZCBjb21wYXJlIFBDSSBwb3dl
cgpzdGF0ZXMgaW4gdGhlIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbC9TdGF0dXMgcmVnaXN0ZXIu
CgpGdW5jdGlvbnMgYWRkZWQ6Ci0gcGNpX3Bvd2VyX3RfZ2V0KCkKLSBwY2lfcG93ZXJfdF9zZXQo
KQotIHBjaV9wb3dlcl90X2VxKCkKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8
aGFiaWxlcmVudHVya2VyQGhvdG1haWwuY29tPgotLS0KIGluY2x1ZGUvbGludXgvcGNpLmggfCAx
NyArKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaAppbmRl
eCBhYTM3NjVhMjBhOTYuLmJmYWZmMGVhNmMyZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9w
Y2kuaAorKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oCkBAIC00MCw2ICs0MCw3IEBACiAjaW5jbHVk
ZSA8bGludXgvaW8uaD4KICNpbmNsdWRlIDxsaW51eC9yZXNvdXJjZV9leHQuaD4KICNpbmNsdWRl
IDxsaW51eC9tc2lfYXBpLmg+CisjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4KICNpbmNsdWRl
IDx1YXBpL2xpbnV4L3BjaS5oPgogCiAjaW5jbHVkZSA8bGludXgvcGNpX2lkcy5oPgpAQCAtMjAw
LDYgKzIwMSwyMiBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKnBjaV9wb3dlcl9uYW1lKHBj
aV9wb3dlcl90IHN0YXRlKQogCXJldHVybiBwY2lfcG93ZXJfbmFtZXNbMSArIChfX2ZvcmNlIGlu
dCkgc3RhdGVdOwogfQogCisvKiBIZWxwZXIgZnVuY3Rpb25zIGZvciBQQ0kgcG93ZXIgbWFuYWdl
bWVudCAqLworc3RhdGljIGlubGluZSBwY2lfcG93ZXJfdCBwY2lfcG93ZXJfdF9nZXQodTE2IGNz
cikKK3sKKwlyZXR1cm4gKHBjaV9wb3dlcl90IF9fZm9yY2UpRklFTERfR0VUKFBDSV9QTV9DVFJM
X1NUQVRFX01BU0ssIGNzcik7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBwY2lfcG93ZXJfdF9z
ZXQodTE2ICpjc3IsIHBjaV9wb3dlcl90IHN0YXRlKQoreworCUZJRUxEX01PRElGWShQQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLLCBjc3IsIChfX2ZvcmNlIHUxNilzdGF0ZSk7Cit9CisKK3N0YXRpYyBp
bmxpbmUgYm9vbCBwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdCBzdGF0ZV9hLCBwY2lfcG93ZXJf
dCBzdGF0ZV9iKQoreworCXJldHVybiBzdGF0ZV9hID09IHN0YXRlX2I7Cit9CisKIC8qKgogICog
dHlwZWRlZiBwY2lfY2hhbm5lbF9zdGF0ZV90CiAgKgotLSAKMi40Ny4zCgo=
