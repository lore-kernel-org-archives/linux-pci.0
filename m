Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F14363086;
	Tue, 10 Mar 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131406; cv=fail; b=L+MSeBVi3RNHsudM3jU/R/O8K53wMtooe21LUfB/5Fv1DBfcbINPEAcP2AZj9ydfDJF0GD2AeA2hC2yjs2Tx00sCgjgqWahZPRNPMaagpjRDqf/jO4L74hn+b/bxBE1XnWH6iefNITbFXS98vavybsZoGgRzzjoU21vvxyg0XVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131406; c=relaxed/simple;
	bh=Y+BmOUalzzyWBjgV8DhwOhU7s6EXkeO+dTBXlnXted8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCw99lxnvzUOxu6Idxya7mZ6wX6gWoV6WOZVISZO1B68hrpzbxQgLMQFaOYOMumbm84g21bKUP4v29D3VQIKUDww6nr8GL4atWVJZzEGC09KoNP/6tsUZtbf+On9BX5mbW3+IQ26ckWLWVeKoaPZFp9QAA1ypZeVjTcnI7euHPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P18QjWaG; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P18QjWaG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaIhczh91vCxClu6+cKps4SPqiZ5igXPLRhcz+m/hUjpTB2uiAlB6suNJY9RZ8k2hbe8r27X+HvYTmj8Q6Ci70C2IQjeMN7kINpqv4uUefmBCs7dTEyj61TATF9OfBaWz7DfiS8nzvMFBsNu/rFKGeYai+3fbOi9tYpIa4RitcetSntOFFYcox5FKVL/7WhKGeSSrbmYSqugEz3H6msrRDA064TAfzoF0N3Vp0GQx0DBtYYwwG6L0nty4fx2+IXQMLcF4JIf5Khri8Dtw0GHZt4QsXzc1U+CiRF2ZBRtV+fPea3OrM2lJbya2y7Nz3p/bxN6IVbcJyKiBW5gpdA8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+BmOUalzzyWBjgV8DhwOhU7s6EXkeO+dTBXlnXted8=;
 b=XMygg+DfuunA2Y1hYGfwsqZNfmOuMUxMVZOLTOUhw+rKv13xCgq9yYbzYQicexrJVdVg7Sxt0zi9G91BnrpIx5ixTdcyBHvCjfmaGutP7Zq5LBzQKVVpiWBNpaZvFMc1K3o64daJzL36m7WUhdJN2W4B72uoo3dDdDKm/dbHM2q60IUcFwbc7kaovHE/VACdrqikypjyi0jOu0YBL/4HuOJw/r7JT03FKyvhftPX++/klHHvE+cYGE6+DqKyHsvyOI19prhfFOwzOtKEJlO/kIMgSaMEHrMh1Xxt0oTMhHvHxibFnL41FMUIBbbd1yqrjbi035fVM05QZi5foOJX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+BmOUalzzyWBjgV8DhwOhU7s6EXkeO+dTBXlnXted8=;
 b=P18QjWaGhC+SbESc3fPdtDUKRaZKX8SeVAWuKn/cKwpGy7a3CDVjyAvZYvOw0mf5bQ2PmTwhofVHyJxnI0aJiET+ILKtVFxNICLoZprzJfj3oEUNA4L0L/D8dTLe6uCmVKJ454M828V5yd66wtkQroQZIF8FC9TiZWlENP7la7v+ZWzOmBI//RNLbazBrWv1NATfgQGpb8Sw8Dlil0q/HstUywac1mdjkOv51i5eA5NjTTR4sui6D4TwycizJ2oAaYMQCztvJ8aU96CeqZhkO+HDRiDNJbUKrLUWKtYzZvGpUOoT+wR99eboSzqz/uHFZai3xd7pzHi2Kwixi4ThWg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB12320.eurprd04.prod.outlook.com (2603:10a6:150:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 08:30:01 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 08:30:00 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: PCI: pci-imx6: Fix build warning
 after adding extref clock
Thread-Topic: [PATCH v3 1/4] dt-bindings: PCI: pci-imx6: Fix build warning
 after adding extref clock
Thread-Index: AQHcr6DJQSDPE8+4I0aMfYSBkDW0NbWnaIGAgAAHecA=
Date: Tue, 10 Mar 2026 08:30:00 +0000
Message-ID:
 <AS8PR04MB8833F6456D5486D982D9D9088C46A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
 <20260309084431.3015463-2-hongxing.zhu@nxp.com>
 <20260310-prudent-exuberant-monkey-a4953a@quoll>
In-Reply-To: <20260310-prudent-exuberant-monkey-a4953a@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV2PR04MB12320:EE_
x-ms-office365-filtering-correlation-id: 5e92ba4d-7c4f-410d-ce01-08de7e7f389c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 hrixfeuuiz0TECw0Q+baQxhaOpnmd8eRoXnqoMctHRDkVpHBTSzQkt7u1vXZ3M3mV6J3jnLfoQEFiyZyq82L7R/AHel0dbqdm33AxvaZgZe1guMPIJhw8fknPdJortduvHm/dugvgeiX3uDI7MSDkIT0dlFJsrXEX0Uad/mRvlyHYE9oFJHwvQ76mtz/QiyJxFCT5o4z23ug7CdqG27kRl2Htm6v/Ih4iE9SnQKMi6hLbjvWQsNDzSr2B58sypfC3ggxLuwVPfQfY+3snQ+hxr+PbEE1Ks4a2Sw4mnZQaP6XUNfTN4/5KtPSMkY6/ocWT4tUQElai5LLgzENM4SJuL8eBg67vKjloSpcWxAZPFry921bpz085HEse4kChrZsisMbDwZqodndEOLOQLqqx13alV6SthSDmAX8JfSDFZSmiQ0jiGM2ul4SDhPAxaxZDdNdtvQCooj+M9Ysi3WpM+pSLmNxeMDJIE8NRrjfpPa2QZU3ze4Ae4RtbLpF5aS6hV2qK3RtI+l0rk6x5biDPh5xZmEP6d3O2DggUHqXJAA8wuR1N7lnoYF6AwlPJdocfwDMOB6Y9IxUICPEQBncUlh+VcDgsq5jUcXlzizHKofHy51PI4a4vlzB+yyARGht+h1bCvpvKlbjpN8SPmsmA/QeS6qb8xvtDpLCbKgd/JRn70MDhCVGHH04XLuDFbiAcVNh5AewMhyEQM4fRu8ZHLhtMieK5TRlSoYmmm1EYdIZCQkMAS+qZRCig31yzH3bynX4X3hEmN1Xkt3Qp/V6ICoVqmBVqYE/VvyJsD2h9E0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFhQdGhkV0NpbEtGTm5QemJ5c1BGaGxwa0h4WFU3ZG5DL0VIZXZvTStPRVpV?=
 =?utf-8?B?cXdKd3pkTlkzRDZCRnhlS3Q4MGtBRktqRzNTUHdQbnh4WW1vU0l6QVM5M0xn?=
 =?utf-8?B?SnFtWkVraWc1b3N6c0p3K0IwQ1V0ZjdVdEs5MVNYT3F4RWR2eWhPRnBDYnhr?=
 =?utf-8?B?ZnZLVzRHZ3U1YjRNb0hxNklxMkxPcStVeFhad0k5cVdjQnhMZ3hYSUxsYU9j?=
 =?utf-8?B?SFc0dWlUK2FMVU1jcVNwanV4UnNwZzkwTGtKbWd3cTMrdGtub2xJczY3dVFv?=
 =?utf-8?B?aDhxQnh5SlhqM3c3ZDQ1QjVYR3Vrc0FHTDI0aDNqcUdWa1c2S1hIVEtkS0h0?=
 =?utf-8?B?K0NzbW02QmFhdlFucldxM0NLS1NXYzd0LzVINTFFcVhKL0pUQ2xMbVJNWms4?=
 =?utf-8?B?M2NHVDNCVUdmME9DT1ovak5Yd21YNHFXZ3hQZjlTUGVtRkU2clFxd1FiMVNV?=
 =?utf-8?B?eVMyejN5MXBEOC91cW1IWERRNlgraEtvdWJCQXlEMEtMZ0swSkF4OHM5aXRm?=
 =?utf-8?B?M2JKc2t2TVdtdTVtaU5lSENDQjRwWmZiTjZMc3I2RzlrMVpjSkJEQjNET3ZL?=
 =?utf-8?B?eFVQT3I1QWIzZi8xRkNHUllJWnV2T0VhdUErRGZUaHJXaGdIaWhFWUpCN2lQ?=
 =?utf-8?B?cFBDVzlLMCs4Vm9jSXhMN2xoV0dtd204bzVkUHlzM29MRFBNVU5vNWM0TmQ5?=
 =?utf-8?B?enFQeXM5WGJzL3M2VEZDOU53TzNXRkJDN3BjOE9BR1p2VncvT0dBS1JLdnY0?=
 =?utf-8?B?eGN5M1NDMHFjUW1kUWR6UjZRMWRYYXdQTnp6eEZTY2h3TnZDNk5sdEt3SWZl?=
 =?utf-8?B?cFZtYVJ5VzdUSG52SjJiTDNqZk5wcThzeFlrRXdRaGNJWnQ3OGgweU9vNm9E?=
 =?utf-8?B?VHFqRi93aDRvQWpMM2FCVEYzZkJ2bElYUVZrVUtNNkF2MlhiTDVNbUY1T0RN?=
 =?utf-8?B?aldNN2NlSlI3RVV0Vk1yN3JXaTZhQmd3M3FLWHZ3ODR3NkZnaXAwbjl0RGZz?=
 =?utf-8?B?Z0huMXJqaTZ1N053ZmZQd3RjNFZYbEowZWFYZ3I1U3JVc1d5YXk3cmdob3Vi?=
 =?utf-8?B?aHZxaG5QNC8yakVidCsrNFA4NXVYNzVzaHFsL3JpTlc3US9YWGNIM0I1NzdG?=
 =?utf-8?B?dEl5N0dHdnVmdk8vdEpzNGJJdC82L3RkQzB3WGtwTlIzV3UwTDNBM1duaFE5?=
 =?utf-8?B?VkFSakpkR2JhUzJIZzh2OGp6bzBjd21ESEVUQlgydW03RkRLZE1odFRUM2J2?=
 =?utf-8?B?dTFYRU00WUh2VU0zTlpXZXptWlVndTFQbHUxdEVyWFpqY1NYRVV2Mk1BVG9L?=
 =?utf-8?B?MER1TlA5NHlNSC9TV3R3OE1zbmU0KzV0TTJ1UUpmT1AzK0lqeVcvdVd4dHhJ?=
 =?utf-8?B?UkZOREQwd1ZlZU10REJ4dXZiM2NTVEJ0RkVKREtoKzRTYnlGOGNPbmgzY0Ex?=
 =?utf-8?B?b2xIOGpVcm8rRUtDenU5WFh0ejNNVzFLUkZGTHhXY3dUZUxZYllSNGV2NXM2?=
 =?utf-8?B?ellBOHRxaWFZQ1h2dFNsdDF5cjkwNEhJVGdROTBKVHBDczZKVmVXbWwrQmhZ?=
 =?utf-8?B?bUZIbE8xUUxtZFF5NTZ4eFgyeHRWaGVuYUx5Q3BwNWRXdENYRnN1OURCUnd4?=
 =?utf-8?B?bWUxRkV6R3I4b3NlVGZ0TnY3RmYyMThPWGF6eWNnakY4WDFGcGZ3cVdvOTgr?=
 =?utf-8?B?Q2hhb0xLVmdqMTdQamh1Y3RRUFhtd2lqQ1djV25rRnJGYnFTdVNaT2dRcVhj?=
 =?utf-8?B?SEJkMWVIZ0kzbldHazYvNm5jNE5EMkl5YVN4QkZsaUlLTUg5bmY3T1F2cUZJ?=
 =?utf-8?B?NWRFZWo5Uk5TUzJmdnRJT1A3c1hwbkFYSnRkVEo5aVMzeFhLQ2F2aXJjaXFE?=
 =?utf-8?B?amw1d1JNRytBOXFDOGFrRlQrRVlOVGFRNyswaEoyK2J1dXExcFNWQkJSNGUy?=
 =?utf-8?B?QXpmc3BSc29ueTR6RTdRTlIrcWtpN1JGVUVNS0xGTmpyQnQyMzRuSGlkVWYv?=
 =?utf-8?B?TmFUWEpnWFdzRnpUSjl2VUowdkpDWjFVSWcwN1U4Sk9LNlF1dmFzdm92bThP?=
 =?utf-8?B?ZFNacEp4T2NWZkVBTm4vUFZLY0g1L291QWdkNEtoUThwMk82MmNBZUkzTUsy?=
 =?utf-8?B?d3NmSkFSaUI4YWsycEVwZWdqV0txVTdFMyt5ZWNuYjVYZ0lMbG0wdk4vRWZr?=
 =?utf-8?B?NnEyeE80Slp1cVpmcDZ2eU9HVmZVdUxqblA3ZUVKWVUwajdpZXhuenJTN2dW?=
 =?utf-8?B?TVlMVDFsSlhRUTZqOVlxSHo5L0pQS3lNc0d4NmRIMlQyWFVTb0xkWWpLdWN4?=
 =?utf-8?Q?KlsVRZ0e4b6MJ8iTNC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e92ba4d-7c4f-410d-ce01-08de7e7f389c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 08:30:00.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Knd8lT80BUpvp9vcTnGbB0QNlypeXIKzDE7KH8yNQfq0NApQEn2OFnh6hUsWCLWrJoguvmHmy8LPqz3WwFsdog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12320

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjblubQz5pyIMTDml6UgMTY6MDANCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5v
cmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7
IG1hbmlAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzRdIGR0LWJpbmRpbmdzOiBQQ0k6
IHBjaS1pbXg2OiBGaXggYnVpbGQgd2FybmluZyBhZnRlcg0KPiBhZGRpbmcgZXh0cmVmIGNsb2Nr
DQo+IA0KPiBPbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwNDo0NDoyOFBNICswODAwLCBSaWNoYXJk
IFpodSB3cm90ZToNCj4gPiBGaXggZHRic19jaGVjayBidWlsZCB3YXJuaW5ncyBieSB1cGRhdGlu
ZyB0aGUgbWF4SXRlbXMgcHJvcGVydHkgZm9yDQo+ID4gY2xvY2tzIGluIGZzbCxpbXg2cS1wY2ll
LWNvbW1vbi55YW1sIGFuZCBjb21wbGV0aW5nIHRoZSBjbG9jaw0KPiA+IGRlc2NyaXB0aW9ucyBp
biBmc2wsaW14NnEtcGNpZS55YW1sLg0KPiA+DQo+ID4gVGhlIHdhcm5pbmdzIG9jY3VyIGJlY2F1
c2UgdGhlIGNsb2NrIGFycmF5cyBleGNlZWQgdGhlIHByZXZpb3VzbHkNCj4gPiBkZWZpbmVkIG1h
eGltdW0gbGVuZ3RoOg0KPiA+DQo+ID4gaW14OTQzLWV2ay5kdGI6IHBjaWVANGMzODAwMDAgKGZz
bCxpbXg5NS1wY2llKTogY2xvY2stbmFtZXM6IFsncGNpZScsDQo+ID4gJ3BjaWVfYnVzJywgJ3Bj
aWVfcGh5JywgJ3BjaWVfYXV4JywgJ3JlZicsICdleHRyZWYnXSBpcyB0b28gbG9uZw0KPiA+IGlt
eDk0My1ldmsuZHRiOiBwY2llQDRjMzAwMDAwIChmc2wsaW14OTUtcGNpZSk6IGNsb2NrczogW1s1
LCA3NF0sIFs1LA0KPiA+IDQxXSwgWzUsIDQwXSwgWzUsIDc1XSwgWzQ2LCAwXSwgWzQ3XV0gaXMg
dG9vIGxvbmcNCj4gPg0KPiA+IEZpeGVzOiAxMzUyZjU4ZDdjOGQgKCJkdC1iaW5kaW5nczogUENJ
OiBwY2ktaW14NjogQWRkIGV4dGVybmFsDQo+ID4gcmVmZXJlbmNlIGNsb2NrIGlucHV0IikNCj4g
DQo+IFRoaXMgd2FzIHRocmVlIG1vbnRocyBhZ28uIENhbiB5b3UgZmluYWxseSBzdGFydCB0ZXN0
aW5nIERUUyB0aGUgbW9tZW50IHlvdQ0KPiBzZW5kIGJpbmRpbmdzIHBhdGNoZXM/DQo+IA0KPiBJ
dCBpcyBub3QgYSBvbmUgdGltZSBpc3N1ZSAtIEkgc2VlIG11bHRpcGxlIGJ1Z2d5IHBhdGNoZXMg
cG9zdGVkIGJ5IE5YUCB3aGljaA0KPiBhcmUgbmV2ZXIgdmFsaWRhdGVkIHdpdGggRFRTIGFuZCB0
aGVuIG1vbnRocyBsYXRlciB0dXJucyBvdXQgYmluZGluZ3Mgd2VyZQ0KPiB3cm9uZy4NCj4gDQo+
IE1hbnkgb2YgdGhlbSBhcmUgcG9zdGVkIGFuZCBpbW1lZGlhdGVseSB0cmlnZ2VyIGJ1aWxkIGVy
cm9ycyByZXBvcnRlZCBieSBMS1AuDQo+IA0KPiBBcmUgeW91IGdvaW5nIHRvIGZpbmFsbHkgdGVz
dCBwYXRjaGVzIEJFRk9SRSB5b3UgcG9zdCB0aGVtPw0KSGkgS3J6eXN6dG9mOg0KSXQncyBteSBm
YXVsdC4gV291bGQgdGFrZSB0aGlzIGxlc3NvbiwgYW5kIGlzc3VlIHRoZSBwYXRjaGVzIGFmdGVy
IGZ1bGx5DQogdGVzdHMgbGF0ZXIuDQpTb3JyeSBhYm91dCB0aGF0Lg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K
