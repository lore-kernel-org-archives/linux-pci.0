Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF93148D8;
	Wed, 13 May 2026 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637722; cv=fail; b=BpmBMFaq4ncsN50TZtCq/eWgE6CmbUI17oBmtiQkwoy9mWW/DM8ujqeKpp1HRgsgNKn4J1+2wonvhSued87xA98kQafn4t6AYIcxb9QXbCrz+8KApgbXbifq4Psk0ys9PwuCLTKQfzFETbn8rtvLm2jev0uPPTWfc6RG5ydE3Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637722; c=relaxed/simple;
	bh=tXzUNJhak7HOVzxUvuYC7387QPCFjZeidMpiruLdA08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nA4zezI0cuT2BUEf0utqJkXExsiiSCS/59ha3E7UigBXdk8Vs1jTuwcK3gVo3VGUOZziQrUMn7N80gx26P1Fn7tLCdEkN7EsqJF6H3niFyEJGkGsE58ASO/4Kw1citOPH2fOv/IsQPT5zlpLco0L3s8+b6z6McYePrxrkcMNLVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z50dhFZl; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z50dhFZl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2KGmwvsoFyRANonzu1wEvifjOd/lj3VbbxfG1pdkVyqHcKr4yzKdR/VRiO5pZcf/vRkM8km/PyyH6ELaLbq+VJc5Ch4sY6ZDAJhiiOz8Q40ie7lKHnhEyasKXEwaYGK4ovbXFTxOZZfup19hxy0qcsi7yJ3frGua8zmBecpdBWJSefvggMAtmNO2hLhtRQr3On3MnNAwB0/pMaE0+D4y3ZdLo2YMqzGKf72nwmVBRIsLUtOc88WC451YBoLJryctJMcsDcEAt9DeYxg9DeNzbDRi03XmNvwosapmaljAOmdhRvHyv8Jai6V34TvR4aWIf21kmTAXv9K4l62yOk66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXzUNJhak7HOVzxUvuYC7387QPCFjZeidMpiruLdA08=;
 b=Ir9VfxL6gGLagb9QdbKFXJbfOc27zak4uuvJ45IWCz5wKxa7OiRTRBy2C81o3pnQTvv4sgoBS8Gq6sqPC0MtCiHWRrjgi3cTZbS+oWf3qULKlCm77gV6uccSDIzs4FipftsqI2Cj6oi5HtTwC9F9vn7T88ClnkALygQWJIhunmMaA+BuPh8JTGlCPlSUcmXjlZP5RH3ycPzihhj3tIMFzN8NXRmQwc4ot7+MJjUPUjvkl16STW8qWGr8hTASUOXHYte8JoX2K30PIXhu0SRWAAbaVCww6ryH5fEUyrNi48tXnkNiwUTh4WqRkzQSjDNtge6Ci1Rj2+4UvU0eoPgZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXzUNJhak7HOVzxUvuYC7387QPCFjZeidMpiruLdA08=;
 b=Z50dhFZlcdfkR8XDb3smLBbmKtsZcDB0l3sm8Zb5+DX5pQcpggL3dSn9/t9qTdUR4JbCfpS+7Z/hmVMNYh0I28C2d/GzyJYgdcMilG0nre2cE0zU+7r2HXxqsAKZ0X9NRFh9bLARjlkaOQJIbCoCuf/k+xThodFXDjNXCLV3xWTy+G19yPmTITL96N7cJB6LV2lLuccDay0odqybZZ8Uh07bFwFDzISucUxzRTrYL5O9A6xfvgrl6K+Ql7rUUMZfgJhe+8NxdIzxP7K9KjIKBCd+MnaSKJo079FijAynpfMwaaiLdpttM/7e0t8T+0pXr8NaY/TmLXdn5V2EbV7NCA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVUPR04MB12441.eurprd04.prod.outlook.com
 (2603:10a6:150:345::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:01:57 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 02:01:57 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the
 reset property in new Root Port binding
Thread-Topic: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the
 reset property in new Root Port binding
Thread-Index: AQHc0jsms3zYhKIK9EaBNLElHIMg+rYKeLqAgADaQXA=
Date: Wed, 13 May 2026 02:01:57 +0000
Message-ID:
 <VI0PR04MB121148EDDDA11C03C57EB4D3B92062@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
 <177859052375.25787.11297345759999790209.b4-ty@b4>
In-Reply-To: <177859052375.25787.11297345759999790209.b4-ty@b4>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GVUPR04MB12441:EE_
x-ms-office365-filtering-correlation-id: bba207dd-4806-42b6-7938-08deb0939ce6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|38070700021|921020;
x-microsoft-antispam-message-info:
 x6pvMWJ9J1xzruhGox3DSrOwnQ5HJKgDHLG0BLsVyGmnIy/oD0y85IKcqVeNZcBVu6Sldf4O7RHXvuFWTKBZZxDn09b5V+ikCDzz2ok4fz/DdYSr29Y/N3R81+yU/J0zf5FoY3p3OC4u8wx6d+0kJfDLOSowSBJ91b+VV7uY0h3kNbCIdNfSUEIsTxoXlnMwS5C4JGwin6JYY0XE1VwLXbUtN6vDd2VSzQSpg5hIW7WrDYiBiJg+XaKR11ZRHALUtjFv+6C5Spudlw4ZUR3010SCD0GYexBabmGNfB3C6ipqdWGezIM704mfe7r8+lajFUa6Gea2F801dMb1iaG1qxbBmpYzCUmcrTi19BDYiPN3FmQWnilKW43Uz9eI8HoujiEURsz5vJNAH6+h1FOGvAqg4i+nm5GZiPAJNuraiMe5Tb/84TIdKz2r6/b8EQlICt+ZwupxjcZgJuxuGGgTJsnRhxHBGybBemKjifs7mQpqlfYUBgO6EIOWdl86kErdFKkfaL76vv96FOk4zrb99slkP5LxwPb6dZO07l6OWLA9mzqt/8/K3DQNhNAuvaXwK74ytKY4vrrRl2gHuVX8H40ewM47zzC4G8jQ+VwAuJkogaj9g4r8uKtgBs5lHmtzm+m1wwF0UdlLbFm+/7gbBAc8MhdztvfbaOEcHLrCw84WioGpdsJOgNtUxzJzvlILOn81BcA1O1HHLH3n0KIuLXxk8vT0oEBdgteev3iQK1Ov47zTMagfhq5/zJ6cKCEaWqls52/C0WLu5EdguAhNpQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEZkQ2xxenltK2hUVTZSZkxneU1DdTNLaUFEN0lFSjQ2a3ZuclQvSHFRZTls?=
 =?utf-8?B?MS81UERRTVB6RGd2Q1pLNEZDdFF3cXg5cW1ITGJJUEs2WEI3amFaYUNSemU5?=
 =?utf-8?B?Q2ZsTFpRcE9Ka0N4WFQwbEdRd3NxNlFrSC9Jb3RWTnRBWjZJbC9zOXVWTldl?=
 =?utf-8?B?bFFkNE4veml4SzE0K2dzZDhtRTdsOHJzRG5RRXg4T2pwVjV4WG90R1E1dlhY?=
 =?utf-8?B?bnVBT1YxNFVEWk1neFd5TUJRSmErd2RBellrTlNFbGhVVUNPUnZJUDZQbjRY?=
 =?utf-8?B?MTh3dUdmRmVPdUZnQmVLa1NWM0lyTThhTjRnSXk5QWY4SWJJeVJqVTBvYzBD?=
 =?utf-8?B?QWNBbWVHR1ZxREtKMXhmdm9qcUJKcUNiRWRHbUVqTVlCZ2tFY1E4QzhsSm9K?=
 =?utf-8?B?eDJWb01rYzJ4bm5LT2dtYnFENVdOQ1U3Z0hjWVNGK2l0cnBUOEhkMnNWQzZL?=
 =?utf-8?B?NG9IOHBFbjhIcE9tSHlramRSOUlEQmxVeXJmR3dEU0llQ2cvd0pOWE1Qd01o?=
 =?utf-8?B?NnZwaHBYTmN0bjZ0MExHV2c4OXRqa1Q4SElOcDBYZXlENUllU2JpSmd4dk95?=
 =?utf-8?B?ZXN6WDI4akVZUFJvbWMwVHhEZlpHZXNVWXd3YVJqTU5kTHBkZkFnRGRtU0U5?=
 =?utf-8?B?T243NVVsaytiTUZvVVNBVGxKTENBL3NSTVkyTmw5bjI5aFhka1RIMmU5enkr?=
 =?utf-8?B?WjcvcVNyaXhPMVptVHdmOEVucDBPOXJ0TXo2UEdvdEV5dUUxK0xLZXM0d1BO?=
 =?utf-8?B?d2Z1YkYvblJWclJKek9iRCtqUG0ydkZ6VmJ4NVBmUU43bHBqa01xc1VsQytJ?=
 =?utf-8?B?SWR0bUJxOW9KYlNMWTR2SVFZSjlRdjZ2czJBOUE1UFFFdWdEL2JnRnZub2M0?=
 =?utf-8?B?R3FVU2pCQzRsQm9Lc1d4UU8wM2k2eldCNTNoT0JhcTA5cXk3V1d1VjRWQU9s?=
 =?utf-8?B?RUpnRm45YmV4MlpuVTNwV3NNZ0s0WjRIKzB6eStlMldqcU5iRU8ySjVFRFpt?=
 =?utf-8?B?T21BcmVrTGNIaDUwdGFwdnU0WXhkZVVqbWJlN1p5TWplMGZMVU1NSCtMelh3?=
 =?utf-8?B?eTl3QjJKMVd6SnZzYUtadFZ5UFpLYTJqT2YzZkxTejhKWTR3UHVHcFhXaEU3?=
 =?utf-8?B?RTBKV1Zlcy84MUZQU1pObXZXYzlrUlVPcUp3SDI3Y1ZyMDZaSng0a0lMMVBl?=
 =?utf-8?B?ejdWL3FCdzRmOFRhS3kwT3JuaWhhS1F4ZFdCMkFpQXhJMSs4OTg3Vk9VWWZK?=
 =?utf-8?B?dXQ1bUZ4c21Bd2pUM2dvNnZoL0U5a0haS0k1MUtDUUloQ3ZQK3BIOHpXeGZH?=
 =?utf-8?B?YlRtd3lveXAwU1JBWmFrWGxrVE5KUjY1TXF6UzlaQlpWa3hrQ2l1VDRtNmdi?=
 =?utf-8?B?LzlEeXpKeWJFZjFVVldVdWJZanRFdEsybEkzbU45ZXZkVm1pY1FGTjhQb2tD?=
 =?utf-8?B?ZEdrZzRqTVhwM1daYTRtS2ZVelBLWWJZdXd0cTNrQUdxeHNkdTkvSWZqRC8z?=
 =?utf-8?B?YnhKMXV1SVJCU3V5TjBLRGZNMys3NUEvVDBmSGtZZXRQdmJFTVF1Y2NCSFkw?=
 =?utf-8?B?azcxOHBmZVpOaU9MU3E2b2kxbTVlNi9ZZ0hkYnU4STk4M0ZOSVNnUVZKRUhE?=
 =?utf-8?B?MVJNSWpwTEFQajVqcXVlSGZTanZYUElFZkVNNGxwOEZBc2RQTkdSUGhTV0ph?=
 =?utf-8?B?R0FIaWs3Z0hyU0Y5S1NlVnZQeTgyamw1RUlXQmdBeHNCZ1NBRFFxa2RKU0tk?=
 =?utf-8?B?alRtMUxaeU15RHduNVY5RXdBUmNDUjB6OTlobFBpM3JBK01LYkMwVE05THg1?=
 =?utf-8?B?aGpVWmJtOUZNKzVHQXo1VmZSd3ZZQTVvUmNMM3VTYzkyZnVGTFE2WDRsMTJR?=
 =?utf-8?B?SGw0bGdOL1hSRTd4dERiTmNXczYyclNuSUk1SFdJTTl2S2M5eE1YcVZWdld3?=
 =?utf-8?B?a3E3eFk5bDJERi9jRUFmbjd2WUdZRU01ejhscmJBVjdOZzYrTHdHMHh1U1ZR?=
 =?utf-8?B?V01iZThRWjlSZjJQZkRjTFB6QnJMMG00VThkRXJ0c2FtOW5IUnBVTmFiNkdi?=
 =?utf-8?B?NzAyKzZYYTNOeHMzdW52bTNNRis2WGJpWTJld2IzTGkraXNlMWhkM3V5Ykhk?=
 =?utf-8?B?L2tDL0ZMVmdjWlZaejFsWHZWanBsTE1XZUxUemwrYjZPYXZZZUdrSFhvVTk4?=
 =?utf-8?B?WXd0Y1oxNkpkdnVWWFBtRFRMWXp6QklwM3dRUTVQSEpxV0M4WmQ3Vm0wYnJH?=
 =?utf-8?B?ZUw3aGFEb0pIY0NMbGZpVnptVGdWQXJCYVJEY3A4Mi9YMlh4a2hCOXVhK3BW?=
 =?utf-8?Q?d8eYDEiPlPH4WPzAGi?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba207dd-4806-42b6-7938-08deb0939ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 02:01:57.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FyYeej/o66OXjypJC3nrsZwtOCpmtUruA2LrTQIa6fSt1qdA4k8BWdhsbuSNgu09i1rDpKerJ7DXTkWtQb9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12441

PiBTdWJqZWN0OiBSZTogKHN1YnNldCkgW1BBVENIIFYxNCAwMC8xMl0gcGNpLWlteDY6IEFkZCBz
dXBwb3J0IGZvciBwYXJzaW5nIHRoZQ0KPiByZXNldCBwcm9wZXJ0eSBpbiBuZXcgUm9vdCBQb3J0
IGJpbmRpbmcNCj4gDQo+IA0KPiBPbiBXZWQsIDIyIEFwciAyMDI2IDE3OjM1OjM3ICswODAwLCBT
aGVycnkgU3VuIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2V0IGFkZHMgc3VwcG9ydCBmb3IgcGFy
c2luZyB0aGUgcmVzZXQgcHJvcGVydHkgaW4gbmV3IFJvb3QNCj4gPiBQb3J0IGJpbmRpbmcgaW4g
cGNpLWlteDYgZHJpdmVyLCBzaW1pbGFyIHRvIHRoZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUNCj4g
PiBxY29tIHBjaWUgZHJpdmVyWzFdLg0KPiA+DQo+ID4gQWxzbyBpbnRyb2R1Y2UgZ2VuZXJpYyBo
ZWxwZXIgZnVuY3Rpb25zIHRvIHBhcnNlIFJvb3QgUG9ydCBkZXZpY2UgdHJlZQ0KPiA+IG5vZGVz
IGFuZCBleHRyYWN0IGNvbW1vbiBwcm9wZXJ0aWVzIGxpa2UgcmVzZXQgR1BJT3MuIFRoaXMgYWxs
b3dzDQo+ID4gbXVsdGlwbGUgUENJIGhvc3QgY29udHJvbGxlciBkcml2ZXJzIHRvIHNoYXJlIHRo
ZSBzYW1lIHBhcnNpbmcgbG9naWMuDQo+ID4NCj4gPiBbLi4uXQ0KPiANCj4gQXBwbGllZCwgdGhh
bmtzIQ0KPiANCj4gWzAxLzEyXSBkdC1iaW5kaW5nczogUENJOiBmc2wsaW14NnEtcGNpZTogQWRk
IHJlc2V0IEdQSU8gaW4gUm9vdCBQb3J0IG5vZGUNCj4gICAgICAgICBjb21taXQ6IDU1NmM1Zjdh
YTA2ZDNlODExOWQzNWY0MGI2NjAyZDNhNTQ3Y2VmOWUNCj4gWzAyLzEyXSBQQ0k6IGhvc3QtZ2Vu
ZXJpYzogQWRkIGNvbW1vbiBoZWxwZXJzIGZvciBwYXJzaW5nIFJvb3QgUG9ydA0KPiBwcm9wZXJ0
aWVzDQo+ICAgICAgICAgY29tbWl0OiA2Y2ZkMWUyZmFlMWJiYWE5MjU4Nzk0YmE5ZjMxMjhhZmI3
NTIyNDVjDQo+IFswMy8xMl0gUENJOiBpbXg2OiBBc3NlcnQgUEVSU1QjIGJlZm9yZSBlbmFibGlu
ZyByZWd1bGF0b3JzDQo+ICAgICAgICAgY29tbWl0OiA5N2VhY2Y3MmQxNzU0ZWVmZjg2MjQxMTQw
NzQ5Mjk2MDZmYzNmMmJiDQo+IFswNC8xMl0gUENJOiBpbXg2OiBBZGQgc3VwcG9ydCBmb3IgcGFy
c2luZyB0aGUgcmVzZXQgcHJvcGVydHkgaW4gbmV3IFJvb3QNCj4gUG9ydCBiaW5kaW5nDQo+ICAg
ICAgICAgY29tbWl0OiA0MGI3ZjYxYTFhNGQ3ZmQxODE4OGYzZjg3ZTE1ZmY1YTkwY2UxZDMxDQo+
IA0KDQpIaSBGcmFuaywNCkNhbiB5b3UgcGxlYXNlIGhlbHAgcGljayB0aGUgcmVtYWluaW5nIGlt
eCBkdHMgcGF0Y2hlcywgdGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
