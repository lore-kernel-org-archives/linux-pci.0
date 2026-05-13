Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D330FC27;
	Wed, 13 May 2026 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643154; cv=fail; b=lT6aGOoTffkT8VbF8fDNxPFevcfUqTG1A20S3b7JPz/+IJ+yIf8l2TMFrNPuGcJuanQKEXQLfwY8wNMsLcOwCTVvlpQh64+NHDT4BPc5jpjpVWaRIi50F9L4/isljtN1MaXYshDTdkYBnVLOPb749ivNztcGnBMfmWJqChQqpSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643154; c=relaxed/simple;
	bh=LJEt6dZyjcs0lA24fIwxBjRDvEfiFRMWbK93s3w7doA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GBRPsasEqFHxGmuR9o7Tm7vacxCayb1H/H5ncx4vSBeCyi81QwiXHQg0AvNboqmK96++Qr0SABYdctBHt4CMsHE1rAbInLZuwoH9eKopyJGpwDMhHxKP+tFrE8mb3eWdSW2zi6WAQ2vsB3fWdKYMp0WMPs7Zh9CqSGIcZ9E5SC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c1qua0GW; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c1qua0GW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg70KG5V2bzz8Bz+glkFgnNZenYSjIP8VYbDCJXcHrS88KdePJFyT61/5VE7B1pyqGu9CDnbJ78NPnrFGSXyJJ+NxSZjVMwIVtyzYIGcAUMYsVUPM1tqgbvdR4gpuIXgiZOspIEb/WGgjH9l9FawgRPkyzJjoDR9FzsFGfyi0Hf+R/3BXSGTxzy89eGZ+QduEy4cMs2xBlzYD2OKK/f+38fYxi+KzqxNi4Um7L8lrHLeMYWjbyo6EZHbjjYypLF69QPcOVuqgeOgAVKvcUBaNt1D+UVS0dZ/Azw3yULHTua6PWRqWyyJL77Z+qUogBRWXNo/QCqFctV2JaaoRZAN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJEt6dZyjcs0lA24fIwxBjRDvEfiFRMWbK93s3w7doA=;
 b=rf1OqmN1SCXXFzfc8k79I5GHZyTSc26CcUxRd8LsCfL0WYwf8SOVocoPNve+xaPe2NJfqTaksAKcwJ6NzBQjDL8eyTaa30nTooPO4CayzQtBoCogbPJtBB+YFR1Y7kJiSSjiu9Fq+lnZweODCDcLAvx4keiekUqzXSwcfqU9ThTJryMSr0nd1ZUpYb8292eUV3KIaaQ9A7WRdHz1rEjx6FrGAqwD2w/iJtXBPvx3/2QIwSmcmBEMjyVLOotnxbmtACWdI+qLjuROaWQhLQeAYVZJZbBRM3qZtfkWVhGBq+iCro0ZvhSD+uTUt11brOrK6kjiPCawphxXuJ4YhM/kHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJEt6dZyjcs0lA24fIwxBjRDvEfiFRMWbK93s3w7doA=;
 b=c1qua0GW2jvIY0IwczLhmAmG9pKyRn0J08580i16zzMxRjbdc+xVjqDHCPYw74q5JBFTr3rbqhmwmmuNDLhhgdqoq/5Q1MfpCMMjqLi/7rrmbvagkpH7dFJMpvDh46o49kmJJk0BzVu6j9zfdnoHWymUdpoTdmLcwlBOkxAa1VhDWVz3DIBzJMKgE0BAhRK4hCN6MXa/html5rxfrt1fJuHOTaps5ktL9A4seT0QWq6Wbjir8CjLqhOcJKbrBgwJu17Lui7NMwbDLeV7UW9coSUsfMw5AKbhbJG1WTsWn94w3T5Y8EUYyYXiM+ZYmhzNzvsQFGaFFaz4yaAd6CkGPQ==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by GVXPR04MB11019.eurprd04.prod.outlook.com
 (2603:10a6:150:226::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:32:26 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:32:26 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu
	<hongxing.zhu@nxp.com>
Subject: RE: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Topic: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Index: AQHc4oNmDO7P2+2TREqYVaVKfXI5iLYLS/RQ
Date: Wed, 13 May 2026 03:32:26 +0000
Message-ID:
 <GV2PR04MB122726C1150FFA1D8B0125B3890062@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
 <20260513025101.1498104-4-hongxing.zhu@nxp.com>
In-Reply-To: <20260513025101.1498104-4-hongxing.zhu@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|GVXPR04MB11019:EE_
x-ms-office365-filtering-correlation-id: af007a0b-af5e-482c-6806-08deb0a040db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|921020|38070700021|56012099003|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info:
 Zaw+en8BrDSSpAaD/iioNzlnHDWR9+HVRVvWQpcqH6SmfYXR2DWq29r7K8xWOJx+KkXg4G2po6TPyUOnj9tHyUcpFAUV7ghM2m5lfnJ2g3qnajN04G9gls6UNxKsSWgWlXG5rImYWwT5+O78/kmE4jI6g0D71yhbv4iKXGI4+M0edNXbiJzr/0bA8/CtqEVGP4H1lwqj8S1iszcEG8UJdC9tT3oN89drWICMwyijb+M5m4K+2q/hdFxnzp8HsYJMIFmLJFM8X7AtR6D5oPxh7bimzFU2pl84G0ekQyiW84Kj4affZ8Fg+uzqLFXjGqj1lWeHuXl7qiCsfevR8YH8v+YYoI8Vu/fOY+LxHspk55rmk1pUcIrL7pljNmhnfn+gkMIXJbJ+hp3jnwiL0zpS1l+gYJqCu0jjjpA936U70yOz/6OlsLevq1++qAYnuDe8F0ozIJBQmYrXg4qHLg+DxhDrMdSQc4vCuC/SmlafVtUG/tb4mTC5O05ODF0zqyMmv3N6pmZJCt9YZmQnZciTA+ZUpS9V2xWV18V6moZAKsJkrxMBaS9exsD0lPi4hdTDAVquzfG2a6kf9G+VITtffBiWEGsfSJ+mBmIlC/2cpgIT9oNrLYyjVrq925zqwiweo/FHdafOmJJY14f9SdBjWMP4mtZtO+5IyIiMb8tv8O/M/IcwckMfZurCfHabhMalzVthysb//hrhIJn23D+CigGDtmw+wPpEcvIeHhzirvJfv9oF4p8mJwXrMlt/xuM250bzOCaCh/pgs/MbtjXFoQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aFkzTVJIbHF2UXgvMS96bkp4OHA1KzNuWFF5V0JUK25scWlzczhucVdZVkNu?=
 =?gb2312?B?VFNkaEdRTjRCdHRkQjZTYVdtYlhTVzV0ZjJsTFZGNGdHYjNWeTdNMHZ5VDFH?=
 =?gb2312?B?S1paL2lZb3lnL01EeFRBaVVrSy9zaVlMRExSRnZMY0ZqYjgyUG5PSi9FRzVq?=
 =?gb2312?B?cVoycEpia2lnMTFpVEM4MzRFWEtzMHdUaTNwTkN1Y1owSkVhRE02SUpPa01r?=
 =?gb2312?B?TFcyUHNScXUrSnZkWkFVWk44cjA4alEydnpxQTRPVE5WZXlPeE9kTDhpOUFQ?=
 =?gb2312?B?b2JJamRqbFZhSW9wYUtScUdFc01uZmV0ZDRzdTY2ZVk5NkRROVMvdGtGNEFF?=
 =?gb2312?B?b2NVMVlxb2o2QlFnZWZ6S2xPUGZQOWlBdzlXVkhSSWdCUVFEWWE0VkdPZlZQ?=
 =?gb2312?B?ODlidE01K0ZuZ2doMEpBd3h6VzZ3NW96NExnZmRsaVdsZlBtOFhFSk1mMTYw?=
 =?gb2312?B?MWtpQkVYMmM0Qi8xZ3MwcnppYlp6ckdSLytQbW95a3ZuMzdjdUdobnh1MVVs?=
 =?gb2312?B?dmdXc2k4NkR5anh0V1VOL1ZnYmVRalF1Sm15LzBFemMxNncwSDVFMU1YWkpQ?=
 =?gb2312?B?Q085VVpWUjRZeUhaUW1BSy9IQmk3aWNzVC8rQUx6d1NpUVZSTmY2S1V5ZlAw?=
 =?gb2312?B?NW4xNFBna28wZGdIcElKTG9SZW5mVnRxUUtPcThWNFUrUXdoZ3F0NEFEcWlv?=
 =?gb2312?B?YUFCVCttQnl0YWNzWXJvVmMwdS95OExBRVNxRzdZN1lrcFRhSFpEYWFXd0hX?=
 =?gb2312?B?WGd4cmxYMG1vRU9TaGZuSmp4Y3YySE1PMElTS3RNdDBUZUszNDVKWjROMTk2?=
 =?gb2312?B?K01ybEJTNWhtelR1L1VQSWUxT0diTFpPWWE3SjdqTkk2QnRzZy9keEd6Ui9S?=
 =?gb2312?B?T2FZSWFzL2NsZ2RXMnBWQjE4a3ZDTXdnQXppcFF3R21IN3hIN3piSDJnd3Y2?=
 =?gb2312?B?RndQMERhUkQ2WDFkVi9aRUk2c0MybXFjbEcwaUxRaXdSNFhnT1BhMGpZQ05o?=
 =?gb2312?B?ZHc0MFVObmprUFBZQkFQUyt6SjZqMFlFN0RWcDJmZ2RsNGlXaE96UXRWMTZU?=
 =?gb2312?B?Q2piWkVkOFZnV2NuRWV1Z05Ud0Uyek94M3h5Mnp4K2QyeHQxNWFPdVRQUGZs?=
 =?gb2312?B?SkkrL2lpZ01HV3k1aEh1WkN4dGIvL1hzVDdGZVZiNDRHZmN4aThER2ZrVGV0?=
 =?gb2312?B?bXdKRkx2UWxhdDZoSWdSTTZyc2dCOUZSVWtFYytFclhPRmNOUk5zVVV4a2RE?=
 =?gb2312?B?OE1SR1RrSjNIRURDNEpNWm0yK3R4MUJTWjlTanpSU3lXaFBGSW55U1FXazFX?=
 =?gb2312?B?K08zQnpDNjNZTnBLa3lQN3Z6YS8xeWtKR0dHYkE0dUUwVlpkSjl4R0VsSEJ6?=
 =?gb2312?B?c0NRZDhpNW1YSzlTYWpFaXNNaWZ5ckQrVmRZaEZSLzN6d296UU5JazI5Nmpl?=
 =?gb2312?B?SVBwVVNxOFdpbVhxV3V1c3NTZXhjR1gyQk1HSENsdEJSVnBjUC9TUzFRSTlt?=
 =?gb2312?B?cjl5NzltdjdTbTNXQmo1WnAwK3FDaEsyMG5JdnZ5UG9HUEhxR3U0RHVXVnFW?=
 =?gb2312?B?RFBrUmcyNkRzQ0lJUEEvMXRqeE13amhzM1p4WERQRGc5TUx0WmhXQ3FaKzFr?=
 =?gb2312?B?Z1VNcE4rSXA3VjVKekZKZFdIdzQzSmFaUndWVTM5b3NSYTRjRnV1YXlxdjRM?=
 =?gb2312?B?K0xIS0FtU2g0RXRvcE0xbytNSTVtQmJTWjhCQmJsZGlXY216akl6b2R5T1Ro?=
 =?gb2312?B?dUd5UTNEZTJPcUNWY2JBWmxrOGV4d0ViWWlBU29wZXB3ZXZlTWwvRVR5Rmln?=
 =?gb2312?B?ZUVUalRiWm55Q1FCYUV5Y0IraEZSQVZDazR3RzM3T2R6dXNaVkVtOXJXQXpu?=
 =?gb2312?B?ZFhYcEJocE1NREh1QThLdGNwNVFQUlJ4SkJIVzFxMVk2QWFSeFdYZURYWEJm?=
 =?gb2312?B?ZlJSaDVBbWlDQmlCYnEraU0xOEdvM2hadnJlajFiRGxrQmd4TzVTNVpOWFpw?=
 =?gb2312?B?eWVSdTgwdTYwbnpsRTN2WDM3K0RQNkpSWXl1emZvb1Erc2RrVFMyKzVjMEtk?=
 =?gb2312?B?VzIxKzd3VnlnL0tNN1VFbEN1ZWFTaitwNWlYSThmdUl6MDVvN0Y0ajVBVUxw?=
 =?gb2312?B?NXF1U3J2ZVUxRlN3Tm9oTkx3TnlESWJuVHFwVWtMSnV1aXhnWUxZemxBU29s?=
 =?gb2312?B?MWJPNFF1S0FoOVhQZzVHbDlGTGZ6OENETU1TeEREMVNOWlQvZU4wc1pmdnR3?=
 =?gb2312?B?NXV2K2kwZTlhc2VxNDgxcUpaTnBTNGxsYUVKK28xeWFDL1haRTliWG8vZUFW?=
 =?gb2312?Q?r8Z5lr/fVazCmayZdK?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af007a0b-af5e-482c-6806-08deb0a040db
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 03:32:26.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGAIZ5UaWHcbMfKs2v33MI/qk7ILuKTTf4H3qnTpGJGfFFzIYA0T2AmXLirCAsjXBDkITonrRJEhDh+Sog0bJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11019

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IDIwMjbE6jXUwjEzyNUgMTA6NTENCj4gVG86IHJvYmhA
a2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2Vy
bmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHY0IDMvM10gUENJOiBpbXg2OiBBZGQgcm9vdCBwb3J0IHJl
c2V0IHRvIHN1cHBvcnQgbGluayByZWNvdmVyeQ0KPiANCj4gVGhlIFBDSWUgbGluayBjYW4gZ28g
ZG93biBkdWUgdG8gdmFyaW91cyB1bmV4cGVjdGVkIGNpcmN1bXN0YW5jZXMuIEFkZCByb290DQo+
IHBvcnQgcmVzZXQgc3VwcG9ydCB0byBlbmFibGUgbGluayByZWNvdmVyeSBmb3IgdGhlIGkuTVgg
UENJZSBjb250cm9sbGVyIHdoZW4gdGhlDQo+IG9wdGlvbmFsICJpbnRyIiBpbnRlcnJ1cHQgaXMg
cHJlc2VudC4NCj4gDQo+IFJlc2V0IHJvb3QgcG9ydCB0byB1bmluaXRpYWxpemUsIGluaXRpYWxp
emUgdGhlIFBDSWUgY29udHJvbGxlciwgYW5kIHJlc3RhcnQgdGhlIFBDSWUNCj4gbGluayBhdCBl
bmQgd2hlbiBhIGxpbmsgZG93biBldmVudCBoYXBwZW5zLg0KPiANCj4gT24gaS5NWDk1IHBsYXRm
b3JtcywgbGluayBldmVudHMgYW5kIFBNRSBzaGFyZSB0aGUgc2FtZSBpbnRlcnJ1cHQgbGluZS4N
Cj4gVGhlIGxpbmsgZXZlbnQgaW50ZXJydXB0IGNhbm5vdCB1c2UgYSB0aHJlYWRlZC1vbmx5IElS
USBoYW5kbGVyIGJlY2F1c2UgdGhlDQo+IFBNRSBkcml2ZXIgdXNlcyByZXF1ZXN0X2lycSgpIHdp
dGggb25seSB0aGUgSVJRRl9TSEFSRUQgZmxhZyBzZXQsIHdoaWNoDQo+IHJlcXVpcmVzIGEgcHJp
bWFyeSBoYW5kbGVyLg0KPiANCj4gVG8gaGFuZGxlIHRoaXMgc2hhcmVkIGludGVycnVwdCBzY2Vu
YXJpbywgcmVnaXN0ZXIgYSBwcmltYXJ5IGludGVycnVwdCBoYW5kbGVyDQo+IHdpdGggSVJRRl9T
SEFSRUQgZm9yIGxpbmsgZXZlbnRzIGFuZCBtYW5pcHVsYXRlIHRoZSBsaW5rIGV2ZW50IGVuYWJs
ZSBiaXRzIHRvDQo+IGVuc3VyZSB0aGUgc2hhcmVkIGludGVycnVwdCBzb3VyY2UgdHJpZ2dlcnMg
b25seSBvbmUgaGFuZGxlciBhdCBhIHRpbWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyB8IDEyMyArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggMTAzNGFjNWM1ZjVjLi43OWM5MmM3N2I4NWIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAtMzQsNiAr
MzQsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gDQo+ICAjaW5jbHVk
ZSAiLi4vLi4vcGNpLmgiDQo+ICsjaW5jbHVkZSAiLi4vcGNpLWhvc3QtY29tbW9uLmgiDQo+ICAj
aW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+IA0KPiAgI2RlZmluZSBJTVg4TVFfR1BSX1BD
SUVfUkVGX1VTRV9QQUQJCUJJVCg5KQ0KPiBAQCAtNzgsNiArNzksMTAgQEANCj4gICNkZWZpbmUg
SU1YOTVfU0lEX01BU0sJCQkJR0VOTUFTSyg1LCAwKQ0KPiAgI2RlZmluZSBJTVg5NV9NQVhfTFVU
CQkJCTMyDQo+IA0KPiArI2RlZmluZSBJTVg5NV9MSU5LX0lOVF9DVFJMX1NUUwkJCTB4MTA0MA0K
PiArI2RlZmluZSBJTVg5NV9MSU5LX0RPV05fSU5UX1NUUwkJCUJJVCgxMSkNCj4gKyNkZWZpbmUg
SU1YOTVfTElOS19ET1dOX0lOVF9FTgkJCUJJVCgxMCkNCj4gKw0KPiAgI2RlZmluZSBJTVg5NV9Q
Q0lFX1JTVF9DVFJMCQkJMHgzMDEwDQo+ICAjZGVmaW5lIElNWDk1X1BDSUVfQ09MRF9SU1QJCQlC
SVQoMCkNCj4gDQo+IEBAIC0xMjUsNiArMTMwLDggQEAgZW51bSBpbXhfcGNpZV92YXJpYW50cyB7
DQo+ICAjZGVmaW5lIElNWF9QQ0lFX01BWF9JTlNUQU5DRVMJMg0KPiANCj4gIHN0cnVjdCBpbXhf
cGNpZTsNCj4gK3N0YXRpYyBpbnQgaW14X3BjaWVfcmVzZXRfcm9vdF9wb3J0KHN0cnVjdCBwY2lf
aG9zdF9icmlkZ2UgKmJyaWRnZSwNCj4gKwkJCQkgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0K
PiANCj4gIHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIHsNCj4gIAllbnVtIGlteF9wY2llX3Zhcmlh
bnRzIHZhcmlhbnQ7DQo+IEBAIC0xNTgsNiArMTY1LDcgQEAgc3RydWN0IGlteF9wY2llIHsNCj4g
IAlib29sCQkJc3VwcG9ydHNfY2xrcmVxOw0KPiAgCWJvb2wJCQllbmFibGVfZXh0X3JlZmNsazsN
Cj4gIAlzdHJ1Y3QgcmVnbWFwCQkqaW9tdXhjX2dwcjsNCj4gKwl1MzIJCQlsbmtfaW50cjsNCj4g
IAl1MTYJCQltc2lfY3RybDsNCj4gIAl1MzIJCQljb250cm9sbGVyX2lkOw0KPiAgCXN0cnVjdCBy
ZXNldF9jb250cm9sCSpwY2llcGh5X3Jlc2V0Ow0KPiBAQCAtMTMwMSw2ICsxMzA5LDEzIEBAIHN0
YXRpYyBpbnQgaW14X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwDQo+ICpwcCkNCj4g
DQo+ICAJaW14X3NldHVwX3BoeV9tcGxsKGlteF9wY2llKTsNCj4gDQo+ICsJLyoNCj4gKwkgKiBD
YWxsYmFjayBpbnZva2VkIGJ5IFBDSSBjb3JlIHdoZW4gbGluayBkb3duIGlzIGRldGVjdGVkIGFu
ZA0KPiArCSAqIHJlY292ZXJ5IGlzIG5lZWRlZC4NCj4gKwkgKi8NCj4gKwlpZiAocHAtPmJyaWRn
ZSkNCj4gKwkJcHAtPmJyaWRnZS0+cmVzZXRfcm9vdF9wb3J0ID0gaW14X3BjaWVfcmVzZXRfcm9v
dF9wb3J0Ow0KPiArDQo+ICAJcmV0dXJuIDA7DQo+IA0KPiAgZXJyX3BoeV9vZmY6DQo+IEBAIC0x
NTY4LDYgKzE1ODMsOSBAQCBzdGF0aWMgaW50IGlteF9wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0
IGRldmljZQ0KPiAqZGV2KQ0KPiAgCWlmICghKGlteF9wY2llLT5kcnZkYXRhLT5mbGFncyAmIElN
WF9QQ0lFX0ZMQUdfU1VQUE9SVFNfU1VTUEVORCkpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gKwlp
ZiAoaW14X3BjaWUtPmxua19pbnRyKQ0KPiArCQlyZWdtYXBfY2xlYXJfYml0cyhpbXhfcGNpZS0+
aW9tdXhjX2dwciwNCj4gSU1YOTVfTElOS19JTlRfQ1RSTF9TVFMsDQo+ICsJCQkJICBJTVg5NV9M
SU5LX0RPV05fSU5UX0VOKTsNCj4gIAlpbXhfcGNpZV9tc2lfc2F2ZV9yZXN0b3JlKGlteF9wY2ll
LCB0cnVlKTsNCj4gIAlpZiAoaW14X2NoZWNrX2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lFX0ZMQUdf
SEFTX0xVVCkpDQo+ICAJCWlteF9wY2llX2x1dF9zYXZlKGlteF9wY2llKTsNCj4gQEAgLTE2MTgs
NiArMTYzNiw5IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gIAlpZiAoaW14X2NoZWNrX2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lFX0ZMQUdf
SEFTX0xVVCkpDQo+ICAJCWlteF9wY2llX2x1dF9yZXN0b3JlKGlteF9wY2llKTsNCj4gIAlpbXhf
cGNpZV9tc2lfc2F2ZV9yZXN0b3JlKGlteF9wY2llLCBmYWxzZSk7DQo+ICsJaWYgKGlteF9wY2ll
LT5sbmtfaW50cikNCj4gKwkJcmVnbWFwX3NldF9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLCBJ
TVg5NV9MSU5LX0lOVF9DVFJMX1NUUywNCj4gKwkJCQlJTVg5NV9MSU5LX0RPV05fSU5UX0VOKTsN
Cj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IEBAIC0xNjI3LDYgKzE2NDgsODQgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGlteF9wY2llX3BtX29wcyA9DQo+IHsNCj4gIAkJCQkg
IGlteF9wY2llX3Jlc3VtZV9ub2lycSkNCj4gIH07DQo+IA0KPiArc3RhdGljIGlycXJldHVybl90
IGlteF9wY2llX2xua19pcnFfaXNyKGludCBpcnEsIHZvaWQgKnByaXYpIHsNCj4gKwlzdHJ1Y3Qg
aW14X3BjaWUgKmlteF9wY2llID0gcHJpdjsNCj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gaW14
X3BjaWUtPnBjaTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRldjsNCj4gKwl1MzIg
dmFsOw0KPiArDQo+ICsJcmVnbWFwX3JlYWQoaW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X0xJ
TktfSU5UX0NUUkxfU1RTLCAmdmFsKTsNCj4gKwlpZiAodmFsICYgSU1YOTVfTElOS19ET1dOX0lO
VF9TVFMpIHsNCj4gKwkJZGV2X2RiZyhkZXYsICJQQ0llIGxpbmsgZG93biBkZXRlY3RlZCwgaW5p
dGlhdGluZyByZWNvdmVyeVxuIik7DQo+ICsJCXJlZ21hcF9jbGVhcl9iaXRzKGlteF9wY2llLT5p
b211eGNfZ3ByLA0KPiBJTVg5NV9MSU5LX0lOVF9DVFJMX1NUUywNCj4gKwkJCQkgIElNWDk1X0xJ
TktfRE9XTl9JTlRfRU4pOw0KPiArCQlyZWdtYXBfc2V0X2JpdHMoaW14X3BjaWUtPmlvbXV4Y19n
cHIsIElNWDk1X0xJTktfSU5UX0NUUkxfU1RTLA0KPiArCQkJCUlNWDk1X0xJTktfRE9XTl9JTlRf
U1RTKTsNCg0KSGkgUmljaGFyZA0KDQpCZXR0ZXIgdG8gYWRkIGNvbW1lbnQgaGVyZSB0byBwb2lu
dCBvdXQgdGhhdCB3cml0ZSB0aGUgSU1YOTVfTElOS19ET1dOX0lOVF9TVFMgbWVhbnMgY2xlYXIg
dGhpcyBiaXQsIG9yIG1lbnRpb24gdGhpcyBiaXQgaXMgVzFDLg0KDQpSZWdhcmRzDQpIYWlibyBD
aGVuDQoNCg==
