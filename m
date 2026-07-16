Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017D38F250;
	Thu, 16 Jul 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185900; cv=fail; b=MqOagujQjHTenNJ7//6ZyEpj7mZsfF1ihV3Lb0vVhjdXJxQm/KWwujBD1kgguCX+SPKu4vQVkhT01gD7tU0V/9NXkF6pPeLG8w5oPp/LxxH2gSKraVRKGuJ6GXgddTveACukdwGBBppCVcNCPIDkGKZbe4m7fAvyoxuN+Bv9jhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185900; c=relaxed/simple;
	bh=4bGtPOIJENxql0wUotkRuchmw88lRY6O0AEx8/gEEwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=juNzCI7yPTcwUzv2LcaGVjP8II6Wh3Qm7jXLHitXVpmc1lCRusURkJyIGdu18VktwZIO37qG3QYoVOjXgcBOb4U42aae8qHOtvSZzT80JDsOxgatXI1litdef7nk01uP6gKiohce4wprDiqUd4Oc5wKT39LadDmYcDsysaVgtow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EfUfOS/4; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EfUfOS/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCjyCCCFlH7SPuHoFNq4wpVHxX3n58ShrbY0jp2rEZdM/jlI8kcf7jSJFnpGFmsjs7dz/5bBEX652+R0yipuL0kq/Il2O9JUbOpqWky3+zEDDVJKj2qdozwcOybYLJS4YGxNS7DOVbCpbTzsoQv9lvHfBmtAyH6tSb+Y7Fir15Tf2O/GS2X+sqWZEl6+LnjOmLkvhMAbEmYggyHufQfwSHipeiiRSC4LLwRii9YSlwMKWZIog0aEyPzEqm0/bZsjRQgjUiLSUWy33/XxmudV8m+H4wTww9ET0AkNc33Mlpm0iTffRnrGJgf3yHOUpoz6CM3XJvXkbUWDVkwtxinClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bGtPOIJENxql0wUotkRuchmw88lRY6O0AEx8/gEEwI=;
 b=EJGMaAxkIOuZQx6l6Za3GnJyksDqWD04OOjdBmi4bEKqc7RQvsRMx/3voMUcdQOBikpGDDhHC5JsF/ZtnL5r+oYZSBvxoGHfBniFNYMCTFxHOh1cdIeZ+WkRq1lNiE0ejKANVzDVIqgCdP/NCwPtCZhXIdIkKeaw9g9L5PDdrIqp68WbvG3MbzZSMxKt+bWmMPLPqeKGduIOAMxC+ZxRsRFeNxG1HB3i3QLKMKoK/CTThTNmfynen6CP8gQh6hnx7t3e53EacZBCJN2nFBnzvMTNm5bGMcgUWL915ZxYUCjmZPlxyDovEp5vBGfdLXfR7yK201Nss4H6rBsJeOvKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bGtPOIJENxql0wUotkRuchmw88lRY6O0AEx8/gEEwI=;
 b=EfUfOS/4wo/GvnAHUG4+83z3p+fB6QtCVB6Pvy4dsjDXFoQwXVoshacw/0cO+q8xbmMuUHvZ//z22UXva4ByJtkuH8LqwGcN48uUPob7NjCCLyFkP1bD4G1nm/KYTD3eiUZ/4bX6Kj7/IYsBbJkcZEPRLxYosgAUFUPvfOzS6KTKFPdhzU8DUXIwXRniLn/QsVrzYevXLHsXSNiq9zMFw+evSo/HUayhvQxQk++vRWww6T3lFvTqFgYGy+YvrsvmELS3zxpxVsMYfjQDU0UysHaqf7u94mCUTOetki4N5t+BTTw865wQwWaBPlqEq6k7I7lNJ7//I9yaKyKqDAeOBQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AMDPR04MB11607.eurprd04.prod.outlook.com
 (2603:10a6:20b:71e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 07:11:26 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:11:25 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v1] PCI: dwc: Add force_l2 flag for platforms requiring L2
 entry without D3cold
Thread-Topic: [PATCH v1] PCI: dwc: Add force_l2 flag for platforms requiring
 L2 entry without D3cold
Thread-Index: AQHdDPFi8E1DQ3gNcEuJzjGLIfqimLZu3CEAgADufGA=
Date: Thu, 16 Jul 2026 07:11:25 +0000
Message-ID:
 <GV2PR04MB120195DCA30AC89B82D4BA7788CC72@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>
 <4d77g33u465lemzlal4mtf4b7vqxgrmjgtoars2yypbyuaz2ae@rrqsfc3ml4af>
In-Reply-To: <4d77g33u465lemzlal4mtf4b7vqxgrmjgtoars2yypbyuaz2ae@rrqsfc3ml4af>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|AMDPR04MB11607:EE_
x-ms-office365-filtering-correlation-id: 308caba7-9999-464b-eedd-08dee3097309
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|19092799006|366016|38070700021|56012099006|18002099003|22082099003|5023799004|11063799006|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info:
 0lcIgbMT9JpnevuG2a8Pb+VGZedkipzUwNchJKgsw0elKC/kOf2aDe9FxSXVGuoyC82g3pyU039T4o3IS8VZOIkt/ZeInbLxCQ1Bw0TEzVvIVRkcKZYhmRVpIzcYrkY6XLx76PAglvf7Nl0yB8zF3m9E3ITZV21hYDkZRWjMdDpoN7eBxCUgb7fa3EnWRVMk6ShKSrTRX3O02PUhts4CSK8Uiz8X9tcx9/3KAA+mXC5mkhsOAW5PRpiadV8jHmN1NrIer0TDylHxXFH9kiS92aHh4MjZK9fjelv1VewX3vVU8vayCElS6yhmAx8RcZ7JhKLmrYhFQhGp80wUCMwqAwR5/wd3nBCD5yVKueVT6emkHk4RF5qHtxFuy+A9mm4TIwyN/7qXkD1NLuIT6RRdmaDu0LpXfVdeO/KZ3RdX6/yA8YwbKmJCti+a9f3s+unvt3BRHHtpgV9tGorDL8FSg/2gw3g+ugXbSzZsQTEzq67uDcbMKcgkVvT60RfR5Axn17OFgTD+yh4xZK6AkTD4cpvCkWgD0IadrOk86oBXi+ozd+ag9ZtJh+E/I8o1z5qNJl7KtPCHXj8TJ+u5fi/hwvMhQuqbY6G+r6IEnzY018SA5RaMCm8NkT+S3ImcYJPufWyjDTtFb9TCOAPanAKsO8MSq6w0meHnnWOWXoJJHwLImOepcXk3QNlEIvos6pp44ty4A5hGb5fwNwREb3eFhiw/i8qAX7cwUl/nwihpWc4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700021)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDRkT1llaTNFaU9tOEdvMVlySU9qejVpcUFINkhyOGpUbnkrZHhCYzN4UlZG?=
 =?utf-8?B?Nk1RaHlFNGlFb0ZjcGxzaHd4V0p5WVNNeUgycTZrR0hVWWlld2FOdmdoaXEy?=
 =?utf-8?B?TjZIamdicllYM2RrOEtPeUY3bkJ6cjgzUlcwcTFKOUF6SlBrYlhSMzhhMTBw?=
 =?utf-8?B?QzFublpPdHhXY05IVUsxMlkvRHJNcHN3NHZpOUszc1VRTVBXUFNtSkh3MHFT?=
 =?utf-8?B?Z0FXQXIycXVCeGxTaGFmSlZxcnZDRHNVOWRNTXNEZ3ByeFFDdE9yUkVnb2x2?=
 =?utf-8?B?Ym1aV1VTeVlwbk40ejMzSlFlbzZKRVZMK2VUVHNMb0kwRFRQR2NiN21GcktN?=
 =?utf-8?B?aldJU3hvME5oeFh2ZWhUQlZubndBVFpKYThqSVVjRGN5OXZFTWJQckRnQnVi?=
 =?utf-8?B?N3RsTFJ4SjkrbDZFNHBid2hpcGYzVHFXeFVySS9JZlNyRE5uTmRpa3Z4ZUM0?=
 =?utf-8?B?ZGxkbkVjU1dFVDBVY0xBNWtRYXk2am8xcFJrWVhLczhJMDhrZzdNM1JiRFpn?=
 =?utf-8?B?Z0o5eW84dCtFM0RpWVdQZC90SHVENnlTckI2djNjWGtsZHlqRDUzalViSzhG?=
 =?utf-8?B?T3FqUFVkeStmVE1qNWJyNWRmZ1pwWUdlVG9HZWt5aXdaa2VxTUpxU2N0dkRZ?=
 =?utf-8?B?eDhPNm1udHg2aHhDUlFzazhTUk1WTmx4UkZ3VFEyMnl6Q3U4Q2VyMXRXSWQr?=
 =?utf-8?B?NTUrMDhEL0pVUWN0ZDJWUzZzcWMxU0tFbmlSSDJ2bmhTQVRQOFUvenc1Unlt?=
 =?utf-8?B?ekYxd0lOUlZlTDFCSGI3Y1lIWVlmVzBJVnZ5VVVneVZjVlZlb2RnOTVvd2Ji?=
 =?utf-8?B?WUhuQ1Z3OHFDWEQxL1lzcDFhcEVNZXhUcGErdHBIRk5KUmJySnp5djA0bGxP?=
 =?utf-8?B?UVhjZUJRS2M1NTU5bTNVNXM1RTQzSnFiY29yS3BtVDhqNGU3YTgwMG9RWmUy?=
 =?utf-8?B?MjdHdGsrS2N6elA3MkhvclV1TGI0UE1mOExueUFCa1VnUE9ydWNKaEtsT3Iz?=
 =?utf-8?B?RG0rZEFVNFhYR2NJZFFSVWE4djJNM21iWCtXVHlpVEVDSWxjYmxhT1YvczZS?=
 =?utf-8?B?M0d3SGF6SmpxVHlpZm1LdERSVXRGVE1DeWJUM0FJaUNiMXRkZWpsb3pSa0NC?=
 =?utf-8?B?TTY0YjR6RUVTRGtzY1RVQzRJOG1vRnVJNC9hMWVNM0dEYWE0ZlFBODN6Z2Vk?=
 =?utf-8?B?cEFmTHdFSEFsWDJqYVhhT25rU1JJL0NlQldxTkI1c0JwWVcwcWlvY0NaYndX?=
 =?utf-8?B?YzlTV1lhSVowYkUvckNDR3dNK3AzK3JlMk9Kb1dSdDVyUnhPT2d0Zk9LQzFB?=
 =?utf-8?B?TmhLaUlhYkx6b0ZxUnpjWlVteHd6VG5HbldRNTJFVDNsN3drNC84RDR0MHJY?=
 =?utf-8?B?OC9qbGFQQUJ5emJEYkNFK3VWZ1pDSGh4bEQ2US9MOHBHbzU1bnpkaW9QeWdV?=
 =?utf-8?B?dE1RWENkei82dytaSkxyc1NDbFlUWnp2RUJTckI5V0RtL1FMekhvWm00czRH?=
 =?utf-8?B?V2JHTU80b1pwYjlDU1NzRzFLSTZ2L2JwTnQvdVpCR0x6YzV3Y1RwcmttaFZV?=
 =?utf-8?B?S2tZQ1hyaHBsMGtPNDVLZDZvTE1sVjNyMThnTmtVSWJyMm05UTdSUktkZXlk?=
 =?utf-8?B?c3lUemhkYjgrTlVLWTZGUXlnWThxSkpTSnAxWlYrMFRPVEJWeXFwY3p3ZDVu?=
 =?utf-8?B?c25yc2V3NW1XYjEyYzF2dVVZb3NVOU9WanRkS1BnN3d4aWZZOWw1VDdlUDJ3?=
 =?utf-8?B?NGFzMU5BQTFvdVVZUEMzc3dZWlJlWWxTcUtNY0U2alVJZVl5TTlaZDh0bzFy?=
 =?utf-8?B?d0hKbjRHQUlzM2FHRFNyY0J5ZmZ1YnlIS0Vka2RIZnVZSEJqZ1I4eGZSY2pu?=
 =?utf-8?B?Vk9iVlk5bWtqd2lBaW5id0haeXNKSm1VdHc0amlsM1BQTm1wNFlNNDFZZU01?=
 =?utf-8?B?TlNrRDFkYW9lQUdSMTQxN25INmg5OXJkaER0RllYODBrbEFLMUFBWUIwZXhr?=
 =?utf-8?B?SUlGWVE1UzFBTlA1b0RWbFMzbVl0dTYvQmxmOXIzYy9taGJtb3ZrSFBNTTVY?=
 =?utf-8?B?bFBjZGRVWmtIN0NHbGM4TWJwN0xWbHQvUTJ4M2VodEJoeVF0bW5pK0hZK0NZ?=
 =?utf-8?B?cEZsbVd1VU8vT3NOQ2JBVEIxOEpyVFVqeGJqOGcrRm52RWt6OGdCU05wNXhV?=
 =?utf-8?B?NFJsbHp3QkczZGNSNTkyT29JRUhUbDNnK1pLQWpYeFhNU2VQRDc4eDY4Z0Ry?=
 =?utf-8?B?ZWhkUExuM200VDk5U1FDMVo3YzdWTUtndGVmeDB1S3NrSC9xNXg0ckRnSHZz?=
 =?utf-8?B?NU93RmtqNVE3QUkxR1E2SUx4c01pSjFOUXd0NFZaM2FMUVNOVFJ5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308caba7-9999-464b-eedd-08dee3097309
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 07:11:25.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoF10WasfNwHWVKI33GJse/LOz9My1qc3kIcUwChI+kUrKTGxUPI3sWCpB9XgdULwdS2RNdI33phvT37/hGfoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11607

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTYsIDIwMjYgMTI6
NTcgQU0NCj4gVG86IEhvbmd4aW5nIFpodSAoT1NTKSA8aG9uZ3hpbmcuemh1QG9zcy5ueHAuY29t
Pg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWlsLmNv
bTsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2ls
Y3p5bnNraUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5j
b207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVz
dGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBkd2M6IEFkZCBmb3JjZV9sMiBm
bGFnIGZvciBwbGF0Zm9ybXMgcmVxdWlyaW5nIEwyDQo+IGVudHJ5IHdpdGhvdXQgRDNjb2xkDQo+
IA0KPiBPbiBNb24sIEp1bCAwNiwgMjAyNiBhdCAxMDo0Nzo1MkFNICswODAwLCBob25neGluZy56
aHVAb3NzLm54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+DQo+ID4gU29tZSBwbGF0Zm9ybXMgbGlrZSBpLk1YIGhhdmUgdGhlaXIg
UENJZSBSQyBjb250cm9sbGVycyBwb3dlcmVkIG9mZg0KPiA+IGR1cmluZyBzeXN0ZW0gc3VzcGVu
ZCwgcmVxdWlyaW5nIGZ1bGwgcmUtaW5pdGlhbGl6YXRpb24gb24gcmVzdW1lLg0KPiA+IFRoZXNl
IHBsYXRmb3JtcyBuZWVkIHRvIGVudGVyIEwyIHN0YXRlIHRvIHByb3Blcmx5IG5vdGlmeSBlbmRw
b2ludHMNCj4gPiBiZWZvcmUgcG93ZXIgbG9zcywgZXZlbiB3aGVuIEQzY29sZCBpcyBub3Qgc3Vw
cG9ydGVkLg0KPiA+DQo+IA0KPiBTbyBkdXJpbmcgc3VzcGVuZCwgUkMgZ29lcyBkb3duIGJ1dCB0
aGUgRVAgc3RheXMgcG93ZXJlZCBPTj8gQW5kIGR1ZSB0byBSQw0KPiBzdWRkZW5seSBnb2luZyBk
b3duLCBFUCBpcyBvYnNlcnZpbmcgTERuPw0KPg0KSW4gZ2VuZXJhbCwgdGhlIEVQIGVudGVycyBE
MyBzdGF0ZSBiZWZvcmUgdGhlIFJDIGdvZXMgZG93bi4gVGhlbiB3aGVuIHRoZSBSQw0KcG93ZXJz
IGRvd24sIHRoZSBFUCBpcyBwb3dlcmVkIG9mZiBhbmQgb2JzZXJ2ZXMgTERuLg0KDQpIb3dldmVy
LCBJIGhhdmUgYWxzbyBvYnNlcnZlZCB0aGF0IHNvbWUgRVAgZGV2aWNlcyByZXR1cm4gZmFsc2Ug
aW4NCnBjaV9ob3N0X2NvbW1vbl9kM2NvbGRfcG9zc2libGUoKS4gVGhhdCdzIHdoeSBJIGFkZGVk
IHRoaXMgZmxhZy4NCg0KPiBDYW4geW91IGNvbnRyb2wgUkMgcG93ZXIgZHVyaW5nIHN1c3BlbmQg
ZnJvbSBwY2ktaW14NiBkcml2ZXI/IEkgZ3Vlc3Mgbm90Lg0KPiANClRoYXQncyBjb3JyZWN0Lg0K
DQo+IEFsc28sIGlzIHRoaXMgYmVoYXZpb3IgYXBwbGljYWJsZSB0byBhbGwgaS5NWDYgcGxhdGZv
cm1zPyBJZiBzbywgaG93IHRoZSBzdXNwZW5kDQo+IHdvcmtlZCBiZWZvcmU/DQpZZXMsIHRoaXMg
YmVoYXZpb3IgYXBwbGllcyB0byBhbGwgaS5NWCBwbGF0Zm9ybXMuDQoNCj4gDQo+ID4gQWRkIGEg
Zm9yY2VfbDIgZmxhZyB0byBhbGxvdyBwbGF0Zm9ybSBkcml2ZXJzIHRvIHJlcXVlc3QgTDIgZW50
cnkNCj4gPiBkdXJpbmcgc3VzcGVuZCByZWdhcmRsZXNzIG9mIEQzY29sZCBjYXBhYmlsaXR5LCBh
bmQgZW5hYmxlIGl0IGZvciBpLk1YDQo+ID4gUENJZSBjb250cm9sbGVycy4NCj4gPg0KPiANCj4g
UENJZSBiYXNlIHNwZWMgcjcuMCwgc2VjIDUuMiwgbWVudGlvbnMgdGhhdCB0aGUgc3lzdGVtIHNv
ZnR3YXJlIHNob3VsZCB0cmFuc2l0aW9uDQo+IHRoZSBkZXZpY2UgaW50byBEM0hvdCBiZWZvcmUg
YnJvYWRjYXNpbmcgdGhlIFBNRV9UdXJuX09mZiBtZXNzYWdlLg0KPiBTbyBoZXJlIHdlJ2QgYmUg
dmlvbGF0aW5nIHRoYXQgc2VjdGlvbiBvZiB0aGUgc3BlYyBpZiB0aGUgZW5kcG9pbnQgaXMgaW4g
bm9uLUQzSG90DQo+IHN0YXRlLg0KPiANCj4gQnV0IGhvbmVzdGx5LCBJIGRvbid0IGhhdmUgYSBi
ZXR0ZXIgc29sdXRpb24gdGhhbiBpbnRpYXRpbmcgTDIgZW50cnkgc2VxdWVuY2UNCj4gZm9yY2Vm
dWxseS4gQXRsZWFzdCwgaXQgc2hvdWxkIGJlIGRvY3VtZW50ZWQgaW4gdGhlIGNvbW1lbnRzIGFu
ZCBwYXRjaA0KPiBkZXNjcmlwdGlvbi4NCkFncmVlZC4gSSB3aWxsIGFkZCB0aGlzIGNsYXJpZmlj
YXRpb24gdG8gYm90aCB0aGUgY29tbWVudHMgYW5kIHBhdGNoDQpkZXNjcmlwdGlvbi4NCg0KPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAg
ICAgICAgfCA1ICsrKysrDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS1ob3N0LmMgfCA4ICsrKysrKy0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5oICAgICAgfCA1ICsrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggZjU1YTY4ZjYwZWVhOS4uZWEw
YjRlYjAzYzFkMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IEBAIC0xOTY2LDYgKzE5NjYsMTEgQEAgc3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJCSAqLw0KPiA+ICAJCWlteF9w
Y2llX2FkZF9sdXRfYnlfcmlkKGlteF9wY2llLCAwKTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gKwkJ
LyoNCj4gPiArCQkgKiBpLk1YIFJDIGlzIHBvd2VyZWQgb2ZmIGR1cmluZyBzdXNwZW5kLCBmb3Jj
ZSBMMiBlbnRyeSB0bw0KPiA+ICsJCSAqIGVuc3VyZSBwcm9wZXIgZW5kcG9pbnQgbm90aWZpY2F0
aW9uIGJlZm9yZSBwb3dlciBsb3NzLg0KPiA+ICsJCSAqLw0KPiA+ICsJCXBjaS0+cHAuZm9yY2Vf
bDIgPSB0cnVlOw0KPiA+ICAJCWlmIChpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwNCj4gSU1YX1BD
SUVfRkxBR19TS0lQX0wyM19SRUFEWSkpDQo+ID4gIAkJCXBjaS0+cHAuc2tpcF9sMjNfcmVhZHkg
PSB0cnVlOw0KPiA+ICAJCWlmIChpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxB
R19LRUVQX01TSV9DQVApKQ0KPiBkaWZmDQo+ID4gLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggMDY3MjIyNTlkMmUzNy4u
ZTNmMDIyZDJkNDUzYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IEBAIC0xMjIyLDE0ICsxMjIyLDE4IEBA
IHN0YXRpYyBpbnQgZHdfcGNpZV9wbWVfdHVybl9vZmYoc3RydWN0IGR3X3BjaWUNCj4gPiAqcGNp
KQ0KPiA+DQo+ID4gIGludCBkd19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBj
aSkgIHsNCj4gPiAtCWJvb2wgcG1lX2NhcGFibGUgPSBmYWxzZTsNCj4gPiArCWJvb2wgZDNjb2xk
LCBwbWVfY2FwYWJsZSA9IGZhbHNlOw0KPiA+ICAJaW50IHJldCA9IDA7DQo+ID4gIAl1MzIgdmFs
Ow0KPiA+DQo+ID4gIAlpZiAoIWR3X3BjaWVfbGlua191cChwY2kpKQ0KPiA+ICAJCWdvdG8gc3Rv
cF9saW5rOw0KPiA+DQo+ID4gLQlpZiAoIXBjaV9ob3N0X2NvbW1vbl9kM2NvbGRfcG9zc2libGUo
cGNpLT5wcC5icmlkZ2UsICZwbWVfY2FwYWJsZSkpDQo+ID4gKwlkM2NvbGQgPSBwY2lfaG9zdF9j
b21tb25fZDNjb2xkX3Bvc3NpYmxlKHBjaS0+cHAuYnJpZGdlLA0KPiAmcG1lX2NhcGFibGUpOw0K
PiA+ICsJLyoNCj4gPiArCSAqIEVudGVyIEwyIGlmIEQzY29sZCBpcyBwb3NzaWJsZSBvciBwbGF0
Zm9ybSByZXF1aXJlcyBmb3JjZWQgTDIgZW50cnkNCj4gPiArCSAqLw0KPiA+ICsJaWYgKCFkM2Nv
bGQgJiYgIXBjaS0+cHAuZm9yY2VfbDIpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAgCWlm
IChwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKSB7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IGRlNGIyNDViMTc1OGMu
LjVlODg0NTllMGNmYTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC00NzEsNiArNDcxLDExIEBAIHN0cnVjdCBkd19w
Y2llX3JwIHsNCj4gPiAgCWJvb2wJCQluYXRpdmVfZWNhbTsNCj4gPiAgCWJvb2wgICAgICAgICAg
ICAgICAgICAgIHNraXBfbDIzX3JlYWR5Ow0KPiA+ICAJYm9vbAkJCXNraXBfcHdyY3RybF9vZmY7
DQo+ID4gKwkvKg0KPiA+ICsJICogRm9yY2UgTDIgZW50cnkgZXZlbiBpZiBEM2NvbGQgbm90IHBv
c3NpYmxlIChlLmcuLCB3aGVuIFJDIGxvc2VzDQo+ID4gKwkgKiBwb3dlcikuDQo+ID4gKwkgKi8N
Cj4gPiArCWJvb2wgICAgICAgICAgICAgICAgICAgIGZvcmNlX2wyOw0KPiANCj4gQ2FuIGl0IGJl
IGNhbGxlZCwgJ3N1c3BlbmRfcG93ZXJvZmYnIHRvIGluZGljYXRlIHRoZSBhY3R1YWwgcXVpcms/
DQpHb29kIHN1Z2dlc3Rpb24uIEkgd2lsbCByZW5hbWUgaXQgdG8gJ3N1c3BlbmRfcG93ZXJvZmYn
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
