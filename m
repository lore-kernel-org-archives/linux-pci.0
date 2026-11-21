Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795260182;
	b=wpBdMik32CtW8vFMRyz7ZDhWwnFPrvj1/NTu3MPUpEmH3PVSl5327jc892jWS0TSL3EC
	 Er68K9M05QzxL2G7EF6ItpMfTuQZmaNGMkYUvZCBeh5/Vb7WHC6IegQp6go+9LLKto3p1
	 bcfMkYKx8Um+4P0PIeVRN39KvhvPFKu+JxlZIS865BhWNuaYyicFqTQWab562V0r/Cw6X
	 sMA4OU+veHvKJaO3Ml2OIYTH5TF3eFGP4Buh2MYqQOjUxdLeoYTNSnvlHlJpnWXdRKTv/
	 IsNRGYC5sbnAWL9Bg4I3zTsnxI+4khvm3g/fsxYeWbualXKrP93QZwl0rjV/i8iogbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260182;
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
	bh=7hFavImFzQIgokukyIrpkPMM7fvJ1zc6fK+Gy2mZjmQ=;
	b=GLUHMQMQ9OymBIuqSO5razR1nQ+BquYtiYBTQXvLWDjbv9J3Px4TIp3LwdySE+T4gCgF
	 M1vuHvEsrbyBcv1+DHvacVSAwus7mnT2B5L8Tj0ImlQEqrz/hYlbu6dj9Mz4cwrmJ0RC3
	 6n2lsbT3NkNpZAtPgx7R5Dvt92CAHhR+5fQzj4kLL7PhVH+xty4A69k0e0pLBnxa6L7Q7
	 E7p5gbkmvplRqZgvlXgnQ3i4pcOlNlK1bIqeTuMXxALqjJoHmkRKVDeIsPEavci6sIyqa
	 3bwwOkaQbthbocsfElGbaNKvgmfd5Q3rfP9CW+dwLp0VuNbUO+93Z7PQjplm6GvM+Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=g53h3xdf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.28
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011028.outbound.protection.outlook.com [52.103.53.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F9606A320;
	Sat, 21 Nov 2026 11:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=g53h3xdf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7ghO/QvCJZDaVNDuqF2o26zJdOLUeQ1Pgeax55bXQUjprDX3+r0H9uyomEB0HVkZ45q1xqIK0LhfyKCnt+n4Aetqlrp+Q9A+Biaiqq3IoTkvQc+kETuMfc1vGzqYG4MbIY39HJcNHwv3UW5eIwTA/dIHU990gVTGWorqcK4Q492pVbQYlWbVRYFfilqKg0IfPlLUVAWdKOQ7hJ2/DwvtJgp40pI01ERHeShoccbtBOt4yX/YDoVlO4pQQVNe6PRQ373rFl3ZEFy+134GG/E2jdWIWMaTqCzHEeRSDaQlU7PxZ8PER29vYgJc1QrbhC9Ntvn+IqxfuVZBT8mGbHnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hFavImFzQIgokukyIrpkPMM7fvJ1zc6fK+Gy2mZjmQ=;
 b=KL+VPAcyAkJrMOMBtzYurfqFFYBfpcey/fbNNcMqAe8i38CfUgOr62SgVKXFUQePZ3BDilOWDxNN2ToAHcZ3vmekNT+RxVkNCftbJYRTOr58e0MB1jpa/S/Wn5XoeS+rKtalGMO3ZDgs3N/3N1ahK9OY70ZJ1NNhE/8bRMXdpiyytJ2gNfVRxrDvszbwafFivxpz6EEZTShUhB9vXG2igojckmBrXadWoIKb9GIO6LUBXLm/z1I8YUsy3PKaQKIv/Vs6KIlNpCqlY0Z4Tty6pvWRs6bcq+uee48Hs54Vg9lufp4OJnaumx/Gk/vWNqR5akui3q9hVDy57yxyYt3noQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hFavImFzQIgokukyIrpkPMM7fvJ1zc6fK+Gy2mZjmQ=;
 b=g53h3xdfQwb37PXzMfcFc+jUWfgKNPQVrD2YJUDP+DeM5c4UPJ+LbkbVog0tM0QfuBYKHxIu4hyIvdg5I98bo71QKUfbXgxAEP1W68v+bNuhH1QsA5iSeRWDq4/TafPzAv4V/lKNKsXdvpS5/ih3w9HhdBBuLkssklb2CARk6wyz9LPTyRrzyfCizXAr1qsnRQy3mn6bhcnkHgYyAJldhQIUI8zp8VbjZpWnCCHoE85YwNJXJJ6GTE7uuWDWgFkDxyaARRFl+ChY9GEx/deXIsT4ymkvjACxlZujEYlpdlzU+37qaexpHld8MKVZn73vZW+xepUpYzIPYKYADB0e8Q==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB0115.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 11:22:58 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 11:22:58 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Topic: [PATCH v2 2/4] PCI: Convert pci.c to pci_power_t helpers
Thread-Index: AQHdeDNEl5SnbY+LlUKyXX5lZTmKKrc1oSqAgALDrgA=
Date: Sat, 21 Nov 2026 11:22:58 +0000
Message-ID: <20261121112257.42094-1-habilerenturker@hotmail.com>
References: <av8tXbagXZeM443k@ashevche-desk.local>
In-Reply-To: <av8tXbagXZeM443k@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB0115:EE_
x-ms-office365-filtering-correlation-id: e23b4d19-caa0-4edb-26f6-08df47c1cbdf
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|8060799015|25010399006|15080799012|51005399006|38102599003|31061999003|55001999006|24021099003|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjlHL3U1SXRSRDJXeFFvSmZwd0UzMk5MNk5CTjRkaDlmMVJtRFZnZVZ4SUNJ?=
 =?utf-8?B?R2lmenh1RkNsbHM2cXZiVkpNZ0NsbnY1MkUvUjFiSjN3ZDBRaXdLdWJTazlG?=
 =?utf-8?B?c1Fnam1IcDdrV0JHMDJGL3I5ZHJPTW1sbkJwMzZSRkRPbEZHdTdSOUtpb1dr?=
 =?utf-8?B?RVJTZmtlQnF3c2dKTWxGaERWRjNFSzNXSjB5OTFmRTk1cTVFVkZ6bXhuVWlj?=
 =?utf-8?B?dkxyT3MrUmI3TDN4NStQaDJPUkk4T2FwaUFHc081dHNwWUNNSnU5dXVlMVRI?=
 =?utf-8?B?ZGRjVU4wdzZsaTJLNmwzYmlZVzZ6dERia2pkdzdRcHAyMWtYWStOQ2VhUTJ5?=
 =?utf-8?B?TmJQUlVMc0wwdE9aRkhPR0JjUm85M2tzRUFUa0VManViRWJ1MGFTZGt5c2hi?=
 =?utf-8?B?RkplQUxlQ3l0eXY1N3ptRTVLZzk0VDlieGV2bXNrNkM2eWF2UTlvK2R1dHFF?=
 =?utf-8?B?d1V1K1NBZkNXdmVKRVZHVkJramF1dDZ5ZU51VWx6OHZSSHI1d2NtQTVRcnBl?=
 =?utf-8?B?SSt6S2lTSmVickhEdE5vTllvaEplVWJmYzhid0s2Q1V6ZGZMNjJWZGdVUTlt?=
 =?utf-8?B?QjZSaEJteHdWRG5vY21MbGpSS1QrRUwvdmFRaWpJbkxXNVh2WUtBNGhvb2xz?=
 =?utf-8?B?YnVBV2MzZ2xGSllzOTJuNkFsaVJvMy9MSXFOQmNYblZHeDM2MXV6VVRkUWRo?=
 =?utf-8?B?MGFaOXV3WkZRSXV2TS9pcWYwaHk3M3lNdFVYblNreVYvblBOcTJDci9kTVZO?=
 =?utf-8?B?OVNIK1hGU1BrdTdiTnM3ZkdZeUI1WFR0VDYreGtLMkhWaUI4RGFEK0o0dWxs?=
 =?utf-8?B?NHdnRmY5NkFxc2RxdDh2dnVwMVV6N1ppdUc2cGo0TWNGK2M1aGVXdE5aa25H?=
 =?utf-8?B?dXFoK1NxNk42d0Uwb3V3Q2M0d3owNUt4VytmZmIxNys2VEhrS2lsRW5jc2VG?=
 =?utf-8?B?UHV3YVdxdjFQdDNPU0poVlZaSEx2b1hqTG4yZXdSaFFFU0hTNVRzMFV3MWxn?=
 =?utf-8?B?NUhvY3RRTnlua2JBVVRyWTdzSWdEdDZwOEtpbkpjUUh2YnF1Y2RFc2VjNVZ4?=
 =?utf-8?B?ZUpneDMwMnNVdFBZVzNqZ3FsK0xERmlNVU5xcmU5QUtDa0l3SnJ6K3ArcWpr?=
 =?utf-8?B?a0JoR1k2bVVFZko1WFo1YzBPRnI4RlU4Qm9CbHhaeUI2NS9mRUFHTDg3ZVhH?=
 =?utf-8?B?MGYveVZVNzZIT2k0V0NXbVc1ZURuSkpPT1RtNklMY3B6THV0ZGJRMk1OSDVX?=
 =?utf-8?B?WUcwMnZ4TktKYmlnbWhNdlFTV3ZZT1A3N09yQS9OVTJCcGsxYy9PVXFmQitY?=
 =?utf-8?B?NFpjTjhSdzNYZitQMy9FWHhzQVNaclNHOWNvY2t2WGNVSVk5a1puTzE3aUVU?=
 =?utf-8?B?UUNFaURpTDZid1E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEcyUEhuc2I5d2w1bFVCZXNtTlRuOEVJcTIxT1RJM1pvdzRrYUhqbGRmSVZW?=
 =?utf-8?B?RDhMUHQydVQwcmVLdEoyRTlrQjJsODZxUlpNdkFYa1cyalpuTWREKzVUU2xT?=
 =?utf-8?B?V3ZFZUptaUVKcUVFN0VDcVBBRHBxMzBlMk1BYXBJd255YUJRZHArT3lUMnBt?=
 =?utf-8?B?RDFnL3E2eXFSVC9VNysyL005MnNqdU9ta0JtWCtMNzJWTnp3bnc3Mmh3bUJC?=
 =?utf-8?B?eUdJVVBTTksrU1ZJblgrdEk1NFAxbk80L1dPRVYvSjJhWE1TRTdvVGtzL2U1?=
 =?utf-8?B?eERVUkcyNGE2dXlNWXFjTTZ6eCtPaytlK1NYQlk3Yjh2Y0JMaVBjZyt0V29m?=
 =?utf-8?B?Rzg3R1U5bUcxMi9BdmNOYjExa0RmcHBJQXVrMTNPd0ttWU0rQUliempORlBJ?=
 =?utf-8?B?NDlManlLL2JFQWl5QThzYXJIYVZSR1hqWjdwRlNFQk5TRUhraGZGL3R3Z2t0?=
 =?utf-8?B?Q2xGbHByVzRSbjljOW5yM28ya0VyNFBNMmdOYlc0MlNtSXhqS2pnN0YvY2xG?=
 =?utf-8?B?ejVlYng3MmhaL1lxQlBzRG51WUZUaVcrOE5yb2tzeXovSTNkK3Y1NHE3WHJv?=
 =?utf-8?B?RS9JbklycWkwYk8zZzRwVE9ubEJkdmV4NDR3SjhHeEwvaVBuRHZvSTQrOHJW?=
 =?utf-8?B?aVQybzVlY1BGZkRqNzA5V2hZVHpEcWQ1c1AwVHhkc0s0YXczMVFLOGY3WU5m?=
 =?utf-8?B?bktGbUltUFowVlNncXRjbFdtQlQwU1VKaStYWFhJbDU5U1g5OGxVcjhhQVBH?=
 =?utf-8?B?K2RIWkRqVTR5WmFMVXk2MHRtekZieldrZWdDZFZnRlN6bzN0YkdWRzlpRUFO?=
 =?utf-8?B?bXZtNTN5eE5Qby9xLzlXTXVJUFZWcVljaEl6c2U3UWhxNE9XQ2dzdjkrb0pt?=
 =?utf-8?B?Q3I1RE9SZGRJbU9xNWRxbUdqR1ZrOFVXeUxZU3NKTjZMYlJ6L0E2R1ErcEJT?=
 =?utf-8?B?QkliYmg5MmswdzdlbE9HU1JWRGtKeXRTc0diY0h6R2tZTTV4RlN5UldDYnZx?=
 =?utf-8?B?ejY2MmE1cCtnbnFReUR5QUVzbEx3YUp0L09WLzlBQ3JTeEVKRFpjUW1rYXFs?=
 =?utf-8?B?N0E0ZklUMk5EOEZwMlNXQUVza1lQL2l1bUdzUTRHbkQ0Y3dsUlc0bXY5dzR0?=
 =?utf-8?B?VkJjelg1eThOdGNhaXlOVTJKcUlKVWdhcENHLzJzWUpINEowZEVMalJYM1pU?=
 =?utf-8?B?b2tOYTcvZUN6aTg0UUIvVlJSSW1kSjNqVGdLektQZlNUcUt1c3dEVStwZjhv?=
 =?utf-8?B?ODNVQ0w3VWd5NFE0dEpqRTVkc2ZpN0NLemlXY2RPYzJwaHBHbmp4V1FIWDdX?=
 =?utf-8?B?VmxzaENXSElWSXI4Y3o0bG84cm9MSExJSUlBYVlzeWVkTDRLd2hiMzdJNk9v?=
 =?utf-8?B?RWFMRk9NWXVsbk1FNVdNV0pYOU12TmRwenA3QzFkbklmc2FpcHY0aUtydGIx?=
 =?utf-8?B?QWNxMUJ3ZmI5aEVWZ3JYclZ5M3ZLU2J0ekZyWXVtS0tqc2lTeWxJLzFsQWhE?=
 =?utf-8?B?SHJRWldKY21GdmgxMkt6aEd4Q2kwNGJsbmV5Z2g5cmJJUytqQmZ4SFhNQlhC?=
 =?utf-8?B?bWlWQ3lOTHBHcDR4Ui80bSt6N29HOE9FZ2x4ZEtLWVpkbjM4ek5VV2dwcFo5?=
 =?utf-8?B?WVFYZjZpR0dETG1QbGRHVC8zL3JFZmM2MHpIdUlIWnJ5Ykt0aGRkcG0wSElw?=
 =?utf-8?B?K0lwK0E4Zjh0VUlhSEIyOVBYdWM2SFdiNDYzUVRUbTJaRW9UWXYzZE9ucFFT?=
 =?utf-8?B?Zlk4L1p1SGdZb1kxYm9pdHBkTHlrTjY2emI5L3lFQmQvUThEWWpnRXJpbDk1?=
 =?utf-8?B?dTVsM0ZqSi80NmVubitSeGE3NWNMNDFFUWp1Z3ovMVRkTzZDUkVEV2MySEVO?=
 =?utf-8?Q?n3LGctZYJSU+S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <665068E77EAB8F45A5F8378CB625C10B@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e23b4d19-caa0-4edb-26f6-08df47c1cbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 11:22:58.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB0115

SGkgQW5keSwKCkkgYWRkZWQgcmVzb2x2ZWQgU3BhcnNlIHdhcm5pbmdzIHRvIHRoZSBjb21taXQg
bWVzc2FnZS4KCkkgYWxzbyBmaXhlZCBpbmRlbnRhdGlvbiBvZiB0aGUgYG5lZWRfcmVzdG9yZWAu
CgpCb3RoIGNoYW5nZXMgYXJlIGluY2x1ZGVkIGluIHYzLiAKClRoYW5rcyBmb3IgdGhlIHJldmll
dyBhbmQgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApUw7xya2VyCg==
