Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FF359A8B;
	Mon, 27 Apr 2026 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259841; cv=fail; b=J7nW5Id+CwxpACJjRjYSeFUSJlPQR8hl6UsZ1fAm3bopCWQKNFfQg8qLj1CsfsISVZeJrlDTypSd8prmsN/6q75TF0Iff48qv600mHScXEtaHqGDbZmuTWSlOsoS7KyLwfuCU6xaMEoH3XpQwc4Y4gXmbpuiGpGtAEA+o8g3IHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259841; c=relaxed/simple;
	bh=mrKA2D5LiYTMB7qGPyf1iCSYPPuuhqtDQlb/e6O4AZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChqJJhoziiRMvhOvtVjVe2Ev8VpLGrx5reWcsJTnDzu25niQ2nMNiq6DohTwyXudUtWiGPNdz8dwmjd+sTTZgA/vVzrc7K4Corv9r0yG6fr3kepkOOQxlbIS3G3B5GWmQac7lXS4irp29rXRvwIUAUSD6Faoy8mQt+GlxVDkyYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eSru7Q3A; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eSru7Q3A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN5I7lyfWUSZuUVYhfD4Ajhvag/BnNUjc0w0NbrS0e816mF2KUpprjc18Fcskm36/9dQjx6zSkGL3BjlGJHoIpg+FULbbbCQFIFbhN5Wtn+W13V6cHmzLsXlCo2zsFL5vIPU+vyB4a/fEG3nsuV287HNGBv//xXkYZci3e+FA3B0k3vWXVkVQbcqcaTJQa3OYWgyKtSjxbQXwSl1PRnLUe/o13M9XceVrddtI+auUrvOKoiR4NcusyCqqVTmpNhXm12us8DVW7WK7S79m2aiZ8bFPo/YkQc0E9vHI/Ckd6QCjUDyobjZuIuH9FJzgyif4mOg4Bc8aRQbQcjTmaK7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrKA2D5LiYTMB7qGPyf1iCSYPPuuhqtDQlb/e6O4AZ8=;
 b=RRNZsb36wt651Q+qr9kEXOXvbXrXm0R+cSumXGieHEflobPUGEAcqdBqRcdI1tJuKULLFs7zQTkrkv7XvakWJG+SMJi3QzH0w1SpJ5LSt5EEeTx852YfZPZv261PAGVSDvNEviH4aaReArwX0HjkABsSBxx43l4HklU91JEjI9e64rXY+eo/RYtaYgFY1XSni2G/rOfuPuiA0MVt/t43r00wL3qySkYZdMhXY0gSoQ2nuSBxh/sGyRGNMAdbovu81CH6H7P7lY7NH6td+TT9SXW7I1gxhbOsBXVGAHm46qjV0XiY/zFMp6a/vmcX2tndtT9IC4+TKIjjtj+bD7urgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrKA2D5LiYTMB7qGPyf1iCSYPPuuhqtDQlb/e6O4AZ8=;
 b=eSru7Q3ATxMuER/8RFNQjONqzEH87CjYwN78gMM0RqT4cpN+YDiE/H5vESTSxgN8VNxunRQqeusKxOnQXshEFfr+WFjTFQaV2HdyWEE/000S3y7yhBD+B7DCZt/B5dTCvrdBt5z63wvg6zsIfUsDygsGQTUbwZXEVxuo6i9ecrTcgXGlLyf/d5V0p98o2xEFIeCj6QxEaspmxMN1xbaVjjqsSj3pt1qSYtxcsZHe5xIV5NMv1LlgH/1FIuc7X22nEivvSWmNtDuuA1iYiShwCopwv9pTd+acmRKTePyb9E/qKB0IsY+wNQTfNiZJ8K6YgmWWdZHXokZATUhQvdh+Ew==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 03:17:17 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.021; Mon, 27 Apr 2026
 03:17:17 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
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
Subject: RE: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Index: AQHc05XoRj3SxGaMXEyZa09FUjk/wbXucikAgAEbSgCAAq11QA==
Date: Mon, 27 Apr 2026 03:17:17 +0000
Message-ID:
 <AM0PR04MB522092A5C4AE75007F9F020F8C362@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
 <20260424025735.1490772-2-hongxing.zhu@nxp.com>
 <20260424-sinless-unfiled-d1087a894da5@spud>
 <20260425-agile-impala-of-unity-cadced@quoll>
In-Reply-To: <20260425-agile-impala-of-unity-cadced@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|PA1PR04MB10604:EE_
x-ms-office365-filtering-correlation-id: b6d166da-0c4e-4bf2-cd5e-08dea40b7c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 dxGM3f6g+V535cl/7xNfHqG96hXSkFhp9SpAXludKbZCDDKZbNNbneq5AQF7aOm4z+58oigOfeseuSKm5LsOjiB1vPZKP1B1GbEYiiCCudN7MEiz9r/5UK8KyT4D5vrkvB84Zy9MlUBy70aYSI4BpB2S2v//oKX2Rj06ztZUnC3dUkwY7XdD9U+xTvva1s0bhN7TQ5BrCJmS0aZ5TD7/T/IlSJYZUmV6pcZNPmG6oKtfeuWoXqIM43Wwn/UXMEPHoxFNiaVBdSoeA+i+RmkjeS42cTc3XSJby4GXkBV8M59/Byeiuou/0HOSxpf4gR5YP42bctdp/iCA7aRxf+7xezCzm1+soEoJZzK4o3AjowiiKlsU6W79rhT0Imv672/0IWrec6GXpYModinCJ8pkUuQgjTsGrGxBKxn+cJ3tXiDOq4Gu86M69MSMjs6rEaU15dnqi8wvDm9jd1T/kS3Ey4cR1wesboNSlbikITfSUinrMs44Wr8lXaJ0lNLegoe8y6NIyffIPw9NzahEgBXNxCVsJxoE9ghfHtn75UA+727QYcsEyZMvull0DbgZvuVKkYmTgT9oZuS2+p7Swft/raBpNL5D1z13jPeW6s1IcvPwpEtMSBTGRN50/P63ssPKeqVTI8gjabEF1gQPvD7z9/eJDpegs4tFkEjBIFlpbNOWeHzpqfq4SmRxwHOVrxqscqhkvz3xg83RtQkfozXBwT8GWYkTBGEfcYPPvnQiTJ1l7daKlrfa/ySZP0EBpNDrxIg9MKmU+Jkp+bNXCrhyygc4+RLWkOrRpRfCU0YSRws=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0F1UlJpYVRGMGZtYXA1Y0ZsYmxSZDF1WUhRUVBUamw0SkMyMXdKdEkydmdL?=
 =?utf-8?B?emVod1FsR2tsa1E0UHdaeWw3Smo3QnpqL1BkbnB6QTlyc1JKNm85VTAzbE1F?=
 =?utf-8?B?bENZNWhZRDROZ0lqS1ZCb244aEVQKzd0ZWlCeHN4b1lZTlhHMlZtUlpvKzJl?=
 =?utf-8?B?eCtLNDNWbkFlRHNCdUY2STFOVmg5V3pDOFRCTlVJMlhvNFVXQ204NjNvUEU1?=
 =?utf-8?B?NDFqd2VuUUxVQUpLQzVGQnFPWGFQZHpMOUFMakF2MlNLMCtRRWxZRmZBWi85?=
 =?utf-8?B?S25PNkp5ZkN2VE5vSlJmbVZrVW84ZmNjV2owKzIvWkhma0d6UlRaNkF3ZWgw?=
 =?utf-8?B?WHdVcHdud3BjYUJ0T3FVZVFxMTUzZXM0Y3BMM2ZuamtQMTR5WWpxZDVYRmFL?=
 =?utf-8?B?cHpHbVN5YWdWOXNudVJzQWsxVWh6MDVBRDJXTmpwL011NHJQV1psVnZ5bFF0?=
 =?utf-8?B?eHNOKzBOT25LMkF4aHFFdm11WmpRR0tHMWZvc2htSndwUkdkYXNOcDNuMFBW?=
 =?utf-8?B?NFFlSktMNHk4dDRjQlBWTVdSbDA2WEV2NWN3eEpGci9xVUtILzBVbnBTdDdt?=
 =?utf-8?B?TEVpSkhKNzNLM3g0VTFDMlc4ckJZK1FhVlZrT21jdHRxNDZ5S2dhVVU1K29Q?=
 =?utf-8?B?YU5sc3ZaMVdhSTc2V0xhUGFtU21LUUxYVDVtUkYzWXNsTit6bWdaRFJZM1la?=
 =?utf-8?B?cUN4OXhZdEhpK0xNeDBTVDd6NUlrS2dyU3NRSDJDb0ZjY0JEUGwrZ240MmVE?=
 =?utf-8?B?SkZFaXpFeE5RbXNzcVoyTmlTRzZDUHRBQTRNS2xVZnBXcDhIYWJmWXVROFY5?=
 =?utf-8?B?VVcyY1haSXBZMnFkdkxyMjkxdW43ZGV0blloZmdpbi95K3BDU25BaXd1QVBW?=
 =?utf-8?B?YW5TRGU1cUtIV1FXRUFLTmpIeWZuWFpYOTNIbWFKNENseTBNay9jZ2VERzha?=
 =?utf-8?B?ODkreVVPOVI5a0JwcGp5dTVpZDZRMVc5UGFNUm1hRk5KZ3ZwMld4a2MzNVUx?=
 =?utf-8?B?cTBnTEx2NEJvVWp4Z21ZNVFiQUFLVEdEZFdRUmdLT0Z3TnNjc0pSRW5MaGpl?=
 =?utf-8?B?cmJ0SmhmU3pZTDhlMmVEVE15Vzlmd3lKQUplMk56ekxMUGQxbXhOcDhGQjRl?=
 =?utf-8?B?c3dvR3p6TXl3MU9hNHMxUDUwbFdaTTczYUU2VVRyTk9PQmpiRFdtWU5zSTRu?=
 =?utf-8?B?ZUNGT0Z6QkcwMmlsNEdxTmwvQWJ3d0xmSUNkdTl4T0JxcFhScUloMnhhMjJI?=
 =?utf-8?B?b0dKVXQvelZZSTJ3V0xRWkk5bXhtamRNdU1sa3dhNkRMbXdUdFdQcVhuYVhj?=
 =?utf-8?B?cEtsSFRTeXdSUTJwbU4xK25KdzNpVk9jRTllTDJUQzN2dHZHU0NTc2hwbFpR?=
 =?utf-8?B?amVybjNxQmY5TmpRUnlmczQwUjRjUWw0bXhJbnJTeEVnWWRQZzNqMDhhY1FF?=
 =?utf-8?B?MC9meDBFY0lZNEQxcjhnLzE1TzJUN3MzaSsyOHF4WG5CR0ZzNkhMQlZpKzZV?=
 =?utf-8?B?UGEyb2FZRExOVytOZVdYd3A0MFdKUnFwb2t2Um0vRHlIaGFrRlcrV1VJdUIx?=
 =?utf-8?B?ZzBqMU5rOHdEbWxlNFd6TmUvLzlJN3dQcEYxT0pscEwrb0N1Z0o2NzdaREdn?=
 =?utf-8?B?djByWG1ObDN4b284eXBkRU15MVQvQ2RnNTZ2ZzU3UTM2NDljNjlvS3BvajRG?=
 =?utf-8?B?cDZyR0RFOGJheFVVUFR5L1BhMWxHbjVWMzNLcHYvNllqajZXaFQyM2JtUFVn?=
 =?utf-8?B?R2ZFTHE5ckVyUGEzL0JzSzVsNlJ0TE1uOTZlcHNWMFlicmNHRnVMMmdTQzgr?=
 =?utf-8?B?Q0pPcUFkUVVrblFBZWs2Q3k0ZGp3MGZ0a3VidkJaRm5GbHRzSEFLd3IvOTRL?=
 =?utf-8?B?WWZKRWRYa0dqSVc0alZMMUxKQ3pNdVZZOWh0anM2YnJWZEROTmJoVmFWTXpG?=
 =?utf-8?B?c0ZHZjJZR1NEcEN5cXdJc3dCMWZhaFYzR0ttenZHd2pzNmFzRWQ3TjBaR2R1?=
 =?utf-8?B?MTZQNTBTK2M3TFFQNlpDQytSYk41eFJ1TGtkbXF6eVlrMGE3M0l1VHZqL2tN?=
 =?utf-8?B?VEZadVViYW5uMEZDZmFIYWF2MkZ3dk4zbGlLUm5ETTFjdHNLOVEveXZZaEEx?=
 =?utf-8?B?Sm5EMDVjZU9CMkovZW1EUVNLbnc5OXdJK1VlYmlFTzBCYXFPUmt1ci9jZVY5?=
 =?utf-8?B?RWlxMnVUbTUzMVJkWEZnV3g2eDdrWkRDTFZuTlRYMmd3ZjJkakEvcWs2bTVx?=
 =?utf-8?B?VmJsZ3VCQ3UyQ2U0VkF6ZXJQWjZXanlsMk9CRUlicnFHV0JNQTNnTDN4SkhS?=
 =?utf-8?Q?etNr4AldOZHzZ35Nhl?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d166da-0c4e-4bf2-cd5e-08dea40b7c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 03:17:17.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trnHhYJ19XZgbEqcIfJe6O1d3sAz786yQBFo0ImmVUlto6xzGFAd3EG2wP2UQWW/8LtRgtRIWh7ytpa917gi+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAyNSwgMjAyNiA2OjAw
IFBNDQo+IFRvOiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+IENjOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnprK2R0
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IEZy
YW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10gZHQtYmluZGluZ3M6IFBDSTogaW14NnEtcGNp
ZTogQWRkIGludHIsIGFlciBhbmQgcG1lDQo+IGludGVycnVwdHMNCj4gDQo+IE9uIEZyaSwgQXBy
IDI0LCAyMDI2IGF0IDA2OjA2OjE4UE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiBP
biBGcmksIEFwciAyNCwgMjAyNiBhdCAxMDo1NzozM0FNICswODAwLCBSaWNoYXJkIFpodSB3cm90
ZToNCj4gPiA+IEFkZCBvcHRpb25hbCAnaW50cicsICdhZXInLCBhbmQgJ3BtZScgaW50ZXJydXB0
IGVudHJpZXMgdG8gdGhlDQo+ID4gPiBpLk1YNlEgUENJZSBiaW5kaW5nIHRvIHN1cHBvcnQgUENJ
ZSBldmVudC1iYXNlZCBpbnRlcnJ1cHRzIGZvcg0KPiA+ID4gZ2VuZXJhbCBjb250cm9sbGVyIGV2
ZW50cywgQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nLCBhbmQgUG93ZXINCj4gPiA+IE1hbmFnZW1l
bnQgRXZlbnRzIHJlc3BlY3RpdmVseS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPg0KPiA+IFRoaXMg
YmluZGluZyBzdXBwb3J0cyBsb3RzIG9mIGRldmljZXMuIERvIHRoZXkgYWxsIGhhdmUgdGhlc2UN
Cj4gPiBhZGRpdGlvbmFsIGludGVycnVwdHM/DQo+IA0KPiBZZXAuIENvbW1pdCBtc2cgc2F5cyBv
bmx5IGkuTVg2US4uLg0KPiANClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uIGNhdXNlZCBieSB0aGUg
ZmlsZSBuYW1lLiBUaGVzZSBzdGFuZGFsb25lIFNQSQ0KaW50ZXJydXB0cyBhcmUgc3BlY2lmaWMg
dG8gaS5NWDk1IFBDSWUgb25seSwgbm90IHRoZSBvdGhlciBkZXZpY2VzIGNvdmVyZWQgYnkNCnRo
aXMgYmluZGluZy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KPiANCg0K
