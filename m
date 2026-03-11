Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022114.outbound.protection.outlook.com [52.101.126.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3D22FE0A;
	Wed, 11 Mar 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196302; cv=fail; b=g/Y3gxDdoDXsx512Bjq908CDhlqQIaI7lsJDFGzq2NbA20WFUT1v+z40m+MlMHmDwz+uBBiejA/Kv1sG4AyLJ7pxSI62B57GIFQKV7/8tP8i46WC8uyTVGlHuf1T4r9LjWUujLUodlvrj0ZXNmJP5hENsvHJ6P1rSZTTRn5SjVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196302; c=relaxed/simple;
	bh=bTd7DrS9TkhKEi0ifblXzWLcXR2TWr0lPuwlDusaiMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlFVnWrDCFMSiH/YdAqpMcPVT4Vpv62b9D7s0DdfbD6dzMOaK+NVvJrR6HH7pnMuORvCfhaGIrVp7hh9bY22Mma/4IOGCcHN7dGZONXpOyd/+avMZkhZjwbZILaOz1CYnwovQMSCSOtKDrPZ+jHA+cfd6P7DXXu7DXkVSR2S7wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTKVEtMimvNcRnsxujmPLOq20plCGKVvRCHAFk9J14xGNXPncYWqiWJfRXjY1R8I19Cvty04zL0xqtMrnwg7f6x8/wdHd3PQcK4y1FsjKzJvHANm6K8gB8BTX5IBMmfT4hn75LYHO70KR2AIgDqcrIeZ5bRWbDMHLr6LT0DKZJ9w+9JmxBHFfJ2yfOM56I3iUoh4JwkfQjOF0SpUHdvtJ8yxH/gQ2p/D2m1EXKt1H+BHVNtMmwyfb06oRXUYry+BqSRm0OrHKFEPUiNuZWdOtwslN1kZ4zSoB5OwSRm9/vSPmVNAzLAYSrCrUsESfr6SZmLFfq2/UR03iT3vTCC01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTd7DrS9TkhKEi0ifblXzWLcXR2TWr0lPuwlDusaiMM=;
 b=DRt7mHthlH/KkarqyJbqkPwokBWbzcP865VYGNDvh4FrXOmhaZUarh0vwelF3kb0mtHBGMYjlWGr1dVVklhYO33Fjq48mllRGzVAX5u6w2RlSU+O8sRz9eX5u3a3K8nWH75znHToT/6pxQuoIjjwpJx+FDWygYXP5X9Hcb99RPhTr5CUUzehSZmbEJf0a2jGDhubyAGfEZ5xWnbLH4OvR8d9iRn4y7zjFuNjYpjSobgXjmyGuxh+jrqPOI+9wL6yXhgrbFZTLpscxPuMHKqZ0gPF/u2rYZNtCdrR8rji8w+iwkWeToQwBqGvVcRFWCuyDnDD8Zqby9R2FtWUCw+B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by SEZPR06MB6600.apcprd06.prod.outlook.com (2603:1096:101:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 02:31:37 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908%6]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 02:31:37 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Peter Chen
	<peter.chen@cixtech.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogdXBkYXRl?=
 =?gb2312?Q?_CIX_Sky1_PCIe_Root_Complex_bindings?=
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: update CIX Sky1 PCIe Root
 Complex bindings
Thread-Index: AQHcsFqmVTyaz6drxUGpqWO9ODpvBLWnXtEAgAEy0PA=
Date: Wed, 11 Mar 2026 02:31:37 +0000
Message-ID:
 <PUZPR06MB5887D091B6CF979DFC46EECBEF47A@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20260310065338.2337761-1-gary.yang@cixtech.com>
 <20260310065338.2337761-2-gary.yang@cixtech.com>
 <841c0b46-76dc-49c2-bb74-7fc2e5a2a702@kernel.org>
In-Reply-To: <841c0b46-76dc-49c2-bb74-7fc2e5a2a702@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|SEZPR06MB6600:EE_
x-ms-office365-filtering-correlation-id: e6ddacfd-b548-40b2-7d46-08de7f1651ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 O4sa2A0nxHx56ddh74Zj2/n2aK7fuKNqZ4q+71dneR2ccItWWIxshFOMrGuln4Wr5z8R2w1REdMCJOeJH3kElWqxiOnUyNeBUFc7yvzzLc43m+XM717CuXBmYYtlVvSIDhn++hKRlr2zwXMi0U9PPLhhNg+36ReBwgvc+T9QM4cq/f+HmUpfdCM3GnRlvEPQ+0XH6Oqykk37Mv2rcTJZIuPGazrRy1ES9porErN/6mamsM8BTosgARheB3ze1jKLHRjnYcZ7wwaKchhNe6y0dn8Kw/kDfRc/8vcnubRt19ZLQeEiY6gW9kZPTM2R/fcu9FijCkV/Y8DzjCGqF3Sl2OIjd1CfnwjOa10VbnkNZZnj6PRRjqfi0Ec3fMC62WQGv5qbrNJVASdljicXYyY+7k+hb/tyga8A3HrqYcoYPsT8fGJ8ZPoudF+ZCAILZx9Denr4Mc6TaWlOeCkEl+qU3KKIuTtrw3BZi5n1Y90YSwzK+59WebUafJtjvSAFMgMMDbDVEnqrcthprZW+/w1hh3kGDnbIBm0QGHZ6q82P1uZUcKdt9uD6s2kjXhmaFkwlslxw/o7DI/dKQqPsybCi0HWoTAzszklyIBRGTzAkbSbjQiBr7u2Bj7v9tUTnbV20A/fYPXrgQKYsTyWHJ/Fw29XE4W9bQzZIvLgVFR1D9eTltOzqTIpTkY9rQ+hcECMvzYZeyx1bkcxnIdNucm9iP0X36M1zfxUFgPbHwZZ2btmVuf2mPDhUDgsuEL9AjuYIP3Pcc+hFfJ8p0RtYDOec/GVBndX6iH2PoSO4YuUH98Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R0ZKNEJwejl3S0ppVGZsYmhaaVhOK010L2JFancyaXN5b1N1ZkJ1bm5lVktO?=
 =?gb2312?B?ODl1VGhHaTZhVE9sN3R5ZThoVEx2NlA0Nm5paDVsQ3R1UFByby8vcEhMWEhE?=
 =?gb2312?B?N3dSZEVsWEI1T0t0RjlPeGFVcDNBRFQ5dHVzK1NhdWxlWkcvZ3IybjI1Qnl2?=
 =?gb2312?B?YVo3cHRQY2xoSWlycFFrTytNYVVxT2c5eFFFZXJZWmY2OG9kcE94OU1GYTFU?=
 =?gb2312?B?ejVWOGtJMm4wbkNHQXFCelpIeWhvWTYvUjB1UEtUdFJJanc5eEEwUWtWaTJh?=
 =?gb2312?B?YkhBVzV5SGxnMnVQZ3F5YlpxU3Z1bXE2eWJJb0x1OTZnQmFPR0wxb1h3ck1w?=
 =?gb2312?B?RU5WNFphNzRSRmxNakRjWnp6aTF0TFQ0aGxRZmNGY1Q4ekVSSitNb2I1UEc3?=
 =?gb2312?B?M3o5N1hTaC9tUXpqcVFGZnBPRmxycFlUTTBKN1RPdm45MUpnWCtnUGJQUE85?=
 =?gb2312?B?c2htWDB2Q1IxUUxFb3NzQTRNYmFubXFFZWFCMUhOb0NkMjBsS0tRQ1pyUUxs?=
 =?gb2312?B?TXJjN2FGaXFmMlNPWlVxTjB2eTNRR1ZDZHR0OEVHQTA1WHJjVjJVbzdydDBI?=
 =?gb2312?B?cmdiRUpFQlh4anc1SkRoSFdROVNmUE50T2kvQjRMVkFrQlRkNWpaQXlvQUk4?=
 =?gb2312?B?MjhUc3RRdzJnRURranlPREplRnVEZS9SNytkYWtROE9DZEgvcDUxeDVHc09p?=
 =?gb2312?B?YjdJSUE4bzdkRTJaM0NqQjFYeXZjbzYyYzVjb2ZabjUwRnBhQkg1MjFaUTNu?=
 =?gb2312?B?NlhVeTNFN2gwWUVBRi9mSHRiQkwzeUIwS0RvT2sxVTB3cW1qVVY2alZnZTB6?=
 =?gb2312?B?VTJPRkdOckJnMGNJTjk3YlFQOUNlRTNIdDR5U2t5ZndPY1oxdWp5ckVMQ0ZH?=
 =?gb2312?B?TGhxMzVpSStlOUtueHJ4MG9XUkpvVjdMamxHcWFDQTE2N3ZWWFduVkN0Ujg5?=
 =?gb2312?B?RDhXL2xjTFNCWTZqVVVPOVFuTlFHemwxMmNiTThxNi90dzlGc3dEcEVkM09V?=
 =?gb2312?B?dlR1Qll2QjZwLy9sVnRTWGN6Y0RRcjRvdklSYXhmdEpiR1BVWWFRdVZmL0pB?=
 =?gb2312?B?SU1weVF0a0ZFU0pQZWFwbEtFWjhtN1h5RGZNVjE1eUZWNzdBdjN6S0NrbUlU?=
 =?gb2312?B?dUFtSXNBSU9nVVAyakRweHhGWVFTZzRRakJML3VtVmJLakhjNzZtaGoxOFg2?=
 =?gb2312?B?Sy9hNi9WYlVIREs3NU1iRnQyb1d0UTkwT3NVOEs4cFRsM0kxaDRLajNQeE1S?=
 =?gb2312?B?VnoyYkdydzFYUHFMbGU2VEZ6TzA2ajduSy92Ujl2dkg2N0U5TitQU29FSUw5?=
 =?gb2312?B?UVhkWGx3dFpYeUUxTTNxU29jTmpxdUcwTW1KbndPQnF2ZUh1N3ljUXpsU1Zl?=
 =?gb2312?B?WHF4VHVQb0RCcWN0VkQ5WkFQazBRR3FDOC9yUzFEREV0ek1GcEtIZ3k2WG9m?=
 =?gb2312?B?UEY5ZUtqaDhuT0dQMUpCUlp6bzRBSlFSbnVZQ0tvQTJJR0R3eDVqZWlzZVVv?=
 =?gb2312?B?SVhJaVpsaHhiMExtZFp4aFdTWXNQOFYvYzM0UStKNkpVcUxDVS93cHlLc3pL?=
 =?gb2312?B?V3Z5dlpBMGlaa2ZIL1Z0TEY1ME90Z2J6S25rMjVkRkEwUlFVVmppMFdBWnoy?=
 =?gb2312?B?eDJqL0cvbzVsRkRRL29qbUc2Y3RPSm5zeEYwT25TMlVhMWlFZXZrNXh2WnE5?=
 =?gb2312?B?V1JJaTk2RmJxZXlNaXB6bkMwUmQvZk14dXdBVFFQSTM0SEwxbnJKTGZKK0dQ?=
 =?gb2312?B?YWNMYjVlRk42ZEJ3QW9XREZsQXZZeGo4RlNoWGZiZTNZS0hrZ0UxNWtVa3cr?=
 =?gb2312?B?UmVJUXVKdWxOQmp1UEcrNlNzU29sN01CNlJaUlg5bitRclZtQ0E5VmpTOFI3?=
 =?gb2312?B?U0V3YkRmaHlmSngwSXdTZ0NMMUNVM2x6UmFqRmd6MUVYYVRmT3IwL1FzQnFV?=
 =?gb2312?B?SGFuU0RidnoraUpxSmZKbGZrQklUenZKQWJmVXE2S29FM2paZzJIV2ZFN0dw?=
 =?gb2312?B?QkFxcXl6ejZ6OFQvMi9vVXVtZk9UazhKamxxdTFjUzRKeUxqWUpWWHY1UFRM?=
 =?gb2312?B?U2JyeXhZM1dtaXRwa1ZPODVWdmNBdm50eDlGcXVWTHlIMk85TzdUUU5LUGt5?=
 =?gb2312?B?NW91VlR5N0tIOWhEa1FNVnIxa1B1bW9LTFlKUkV1Q2JSQm4rY0U3Q09rTG51?=
 =?gb2312?B?STJuVEJXZEExbmpoYWtzZEt2a0tjMEZCd2kvQ25ZOE4vNnlHb1BmUVFpZEJE?=
 =?gb2312?B?YkRsWkFOL3IyWkN4Rk9QZ01xejU2cmtiRXRRN2haQ1ZWTjNsVnNZamFqRFZV?=
 =?gb2312?B?bEJPMWhqQXNaZ2pWb2ZoTXE0Zk94cTJSdk9HL0ZDdmd2UWd5bHV4UT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5887.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ddacfd-b548-40b2-7d46-08de7f1651ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 02:31:37.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heovF5OC4YO1b+Iapvjhp6kOIgGnWX2/nsAZ9u9uA4P76QHLJyLQBc0h5FzyflWnCSMzm/bP4JzRsLee2iYILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6600

SGkgS3J6eXN6dG9mOg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KPiBFWFRFUk5BTCBF
TUFJTA0KPiANCj4gT24gMTAvMDMvMjAyNiAwNzo1MywgR2FyeSBZYW5nIHdyb3RlOg0KPiA+IGFk
ZCBwb3dlci1kb21haW5zIGFuZCBwb3dlci1kb21haW4tbmFtZXMgcHJvcGVydHkNCj4gDQo+IFdo
eT8gUGxlYXNlIHdyaXRlIGNvbXBsZXRlIHNlbnRlbmNlcyBleHBsYWluaW5nIHdoeSB5b3UgYXJl
IGRvaW5nIHRoaXMuDQo+IA0KDQpTb3JyeSwgSSBkaWQgbm90IGRlc2NyaWJlIGluIGRldGFpbC4N
Cg0KVGhlIFNreTEgUENJZSBjb250cm9sbGVyIHNpdHMgaW4gYSBwb3dlciBkb21haW4gdGhhdCBt
dXN0IGJlIGVuYWJsZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIGNhbiBiZSBhY2Nlc3NlZC4NCkRl
c2NyaWJlIHRoZSBwb3dlci1kb21haW5zIHByb3BlcnR5IHNvIHRoYXQgRFRTIGZpbGVzIGNhbiBy
ZWZlcmVuY2UgdGhlIGNvcnJlY3QgcG93ZXIgZG9tYWluIHByb3ZpZGVyLg0KDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBHYXJ5IFlhbmcgPGdhcnkueWFuZ0BjaXh0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NpeCxza3kxLXBjaWUtaG9zdC55YW1s
ICAgICAgICAgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9jaXgsc2t5MS1wY2llLWhvc3QueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1ob3N0LnlhbWwNCj4gPiBpbmRleCBiOTEwYTQy
ZTA4NDMuLjFkOGVlODMxMDU4OCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2NpeCxza3kxLXBjaWUtaG9zdC55YW1sDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jaXgsc2t5MS1wY2llLWhvc3QueWFt
bA0KPiA+IEBAIC0zOCw2ICszOCwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIHJhbmdlczoNCj4g
PiAgICAgIG1heEl0ZW1zOiAzDQo+ID4NCj4gPiArICBwb3dlci1kb21haW5zOg0KPiA+ICsgICAg
bWluSXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcG93ZXItZG9tYWluLW5hbWVzOg0KPiA+ICsgICAg
bWluSXRlbXM6IDENCj4gDQo+IFRoZXJlIGlzIG5vIHN1Y2ggc3ludGF4LiBPcGVuIGFueSBleGlz
dGluZyBiaW5kaW5oLg0KPiANCg0KU29ycnksIFRoZXkgY29tZSBmcm9tIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUtY29tbW9uLnlhbWwNCg0KRXhl
Y3V0ZSB0aGUgdHdvIGNvbW1hbmRzIGJlbG93IGJlZm9yZSBzdWJtaXQgcGF0Y2ggZXZlcnkgdGlt
ZS4NCg0KbWFrZSBPPSRPVVRLTkwgZHRfYmluZGluZ19jaGVjaw0KbWFrZSBPPSRPVVRLTkwgZHRf
YmluZGluZ19jaGVjayBEVF9TQ0hFTUFfRklMRVM9Y2l4LHNreTEtcGNpZS1ob3N0LnlhbWwNCg0K
d2UgZG9uJ3QgZmluZCBhbnkgd2FybmluZyBvciBlcnJvci4gU28gd2UgdGhpbmsgYWxsIGlzIG9r
Lg0KDQpEVEVYICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNr
eTEtcGNpZS1ob3N0LmV4YW1wbGUuZHRzDQpEVEMgW0NdIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1ob3N0LmV4YW1wbGUuZHRiDQoNCmFuZA0KDQpD
SEtEVCAgIC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzDQpMSU5UICAgIC4vRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzDQpEVEVYICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1ob3N0LmV4YW1wbGUuZHRzDQpEVEMg
W0NdIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1o
b3N0LmV4YW1wbGUuZHRiDQoNCklmIHRha2UgYW55IG1pc3Rha2VzIGFuZCBtaXNzIGFueSBpbmZv
cm1hdGlvbiwgcGxlYXNlIGxldCB1cyBrbm93Lg0KDQpCZXN0IFJhZ2FyZHMNCkdhcnkNCg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
