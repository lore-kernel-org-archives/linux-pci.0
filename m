Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4633345A;
	Tue, 19 May 2026 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170862; cv=fail; b=WqRGaPAcTMLiEGzsfSFkLz/jLLrWXuGn25M512KZ1KeV0qxRut1ZaoJSOfMKjtWjYnwqYg/viQKmugrTs9Lt8kvUrQfu4LJPDH013gJF81OiluzWqp+ibSMPlC4GlyUsh3UrH8Wb8KX2+pJ8NiQOEo9TPEbFlNNIAC3hnqTeyeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170862; c=relaxed/simple;
	bh=KQdYfG8LWmcKAK/vHp/PJu3LNmgr2Jvwc0vcoSI2gZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qvdy6OBKcFkrht7zA88b32a4Hl2BLakgGc+hZ3sHR7DNF5NjsTqpz0ir/uOVKX+8wFW7SpfkFN+axe3YYLlQSRQmxbdV7geTGBRe+PhdcnCux7ZhOgGdKdw2VEoHAYEEIyelE3ljWoPu8k+RY8hW4eB10oNmJJw3srjX8GyiJIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e51gipR/; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e51gipR/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0ypARikfLi83QDP2mARi6hjNtroxNgp/WwzQF2nvGpKFs6/844TvvbGtm+8xGjFgIKfm8j9k4v1mU3LajqjTS9V1JEtCQagLm3DLGdq7oNenIxOmUyIghrsqJ9z7OrVwBNkCFPREbCTAKCyQjvjWz9Fj0AnAK0cURHCgH4CMSBfG0rKVS8zLAUuCjBL4hMTKX7/lYvMIoeIeQV6V8D5mJ84JIU0HGwdRm26jWmBpEAP+Gk90zhw6hQCfqR0lF/Q0bqESjhWXH7kQexO3LFeTSragQzf7/RABtTXA49MNK4o9msrnxjf3N0wDG3RpslBUiZdaHWDB3GThuH4O39q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQdYfG8LWmcKAK/vHp/PJu3LNmgr2Jvwc0vcoSI2gZ8=;
 b=uWC7F7GHvVHq9AUDkyRdHbX/EsdpXvPsKAQ8BSJpLGszqYoXDS8Qk91xzGYkxgweKHYgyHcaDgnhvbJWF1BsGQPieSVRHTaO605S3H419cj+9aEvirL/jGVb/OWn1iyDkSmE5MD0JunBeKZ1koF5WxlsgtmkDH4RCyvbwczcDYxoNrelrXHcapfQjlySyXqQiKubC1dFP9S4+czpE203VfEh6MxV2X9j2H9N531iur2NuSCvlYTyhksRBp4USI2gCOOrinrHhND22TXJ7uCcvv8+x4NMhzuC5QmNSekxcKAwI/zJzzNPPmfClMLoE2aiHpDGDrbtIINCuL8kT6wNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQdYfG8LWmcKAK/vHp/PJu3LNmgr2Jvwc0vcoSI2gZ8=;
 b=e51gipR/7A8/pdx+r1x7EuQeHYPGGl8SzCKPAR3mOQegpF12nPY35atkd9xzIP+hHuaxqgnpN+QCYTpX6uymt9Dk9VhtguSw2S4RJGHu2sAxTAM3Vrc6E54Q6Hhv1CvifoE7LO21y/TRUrN8QxKyFF/vdrpegjwlXJ2EsMLr0GgYFzwhikZtMPigkleqtNm5JT6dgHXBTPVyvpfy1SEHK0XLh/K0+ZKtcNkovjJgZoMTeo1sOCuimsS28jYD8VmvtG3kK/MtYzQq6EmHlrbsUnS0GFmqCzBjslT3XUR2IPnPtOcjwqCC9DlQJbgGLBimnnza9z3+ffSb1WCO4ZuxGg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB12092.eurprd04.prod.outlook.com
 (2603:10a6:150:316::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 06:07:36 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 06:07:35 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: "mani@kernel.org" <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Hongxing Zhu
	<hongxing.zhu@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHc0jsxliV0xf54o0mI/gzBxIIshLYMsR4AgAbuO4CAAWOHAIAAA5AA
Date: Tue, 19 May 2026 06:07:35 +0000
Message-ID:
 <VI0PR04MB12114CD0320BB9956CC14B1B392002@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260422093549.407022-3-sherry.sun@nxp.com>
 <20260513224944.GA341451@bhelgaas>
 <VI0PR04MB1211452312EB9BC6EF1ED2E0192032@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <xyued2adtz2fs47nnl537aef7rsjuhswivcaieh6lxhlxpohkr@gpxmdcpczik7>
In-Reply-To: <xyued2adtz2fs47nnl537aef7rsjuhswivcaieh6lxhlxpohkr@gpxmdcpczik7>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GVXPR04MB12092:EE_
x-ms-office365-filtering-correlation-id: a8d61987-5e5f-4d51-353e-08deb56cec49
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|38070700021|56012099003|18002099003|22082099003|4143699003|4133799003|11063799003;
x-microsoft-antispam-message-info:
 LyO3DAxt0HMPQcpBCKc3tcvk515xo05/5lJHfr5dp3cPuUl1T2++RgP56f+foguLUFDb/Ccl12LQhnXUIT7GqA3WeH7LxtvarfzlgrY8Kt8RlYWGOk1i517PPckRpjJJ3MJrFfVtCCwRtIBWP6q9mfARaKY+CC+p/DPzHYe9y/8gDPc3gGzNC2zyaPB3bTQiwbYPb1aA0ViFad+6oUSxqK/x4T+1fbjdlFmECKML/X78ToiKrQfYmBQKPqye7fn7VnQXNx1DBh9OIEjrOsUk/FXSK3Pm2zo8kx4d1g6eN2RjBSQi3PIC4IwsECKQxwS0ENW88XSPBURE29g8U6Nl9zJ1mMOxM+HLMZ7G50pGRhepU91dqMn6NEDK6XQzJsOQASlcK/+DFV1uoRydOFDC5s0pRpRnn7z5nxDxLy+Kl+yCwtyetPGu2Th3GPDSJPCp0yPs5+IGYOihaGzlRkNxK+6dneLCCfAXMuOHz8wi7YLgI8cq0diQGaXCxmCr8fILj2zLbQlbPtAvHXSDadUAszMefeUD85zMpHTllTZNL4wzcYavbMoqWbVWWsTSWLplAxy1mKM5LE1EOXjHhnJMfh5P0vo0b0jM6UXkZkV5KlIg3JuqHp6QvyMjxMN+8jAq9LElKJ1cJRNYc5SydwhCaurNv/RYBAaHKL/iIYDoTD510NaIOC8kC8NQMAEmf78J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(4143699003)(4133799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dS9XRWgwK0JSWWltcnVETlk3bytkNUd0T21XamthdktvQmpPMDFiVUgvVCs0?=
 =?utf-8?B?YVptc0tpa2pKWGx6Zi9BaGJDa3BoRmpYeFl5Y1lTalJ2ZnhFYncyMnhrakQ4?=
 =?utf-8?B?Si9UQmorQVY3VTNpVUtuaVF6bm1rSndlTzJrV0ljZFhLV1VUbTQ5MVQ0R0Fn?=
 =?utf-8?B?RGtyYk5QUVJDb2o1TDlQbFNtTXVhb1oycVVTblREa01rcmtwbExuWnhGNUFX?=
 =?utf-8?B?ZFl5KzJVVWxmSGJxY2VFdjZTeW1NWnBVdENDLzJCaUQ1Q1h5bncyVnpjTVR1?=
 =?utf-8?B?cW5CYTZaMUVSRFg5YmdXcGg2d0JUMGZiemljai9xYVcxaThUMzQvUzN4WVZx?=
 =?utf-8?B?cS96c0ZiRXU2cDhYdVRGTHlCdW5memZ2YWhwRXV2YysxYjE2S3BDQk9XQ05M?=
 =?utf-8?B?dWNoanNySVRVSStCd0RZbXJnY2dycE14R29EY1ZuMmJXb0w4eFJ4bzBwcGY4?=
 =?utf-8?B?eFMvNE1DeTVkckt4cnp1Z3ErRWoyU2xDQUlYQkhMTXdqZEJMUWN5bURwSklp?=
 =?utf-8?B?OXBmSkVTTXhUVnJDZFFkRy9yM0FybUgzUDFyZGNXUEk2eFhmekhha29neWZ1?=
 =?utf-8?B?V0VsYVYvMm9KL2xoZnZVV01NNGszamc4ZU04YkNqRzVKaEY5RW85N2g0Rk5w?=
 =?utf-8?B?OHY0Y0VQSnl4UXFCZXMrVXY3bm1zWUFjMTh2VHdvd2ZPdTlQUU5kUHV6UXZj?=
 =?utf-8?B?M0ZmeWV3elVZdGd5WUppT3N0YTZxekVxc05YQjhJTGQ1ZHlBak1SbHJqYzFR?=
 =?utf-8?B?UW9pNWh5Nk1hOGdZcVp6NDdNcW9HYmFFZW9iNVMrV0QzakRHT0NWSWYvdjly?=
 =?utf-8?B?eDdmdVU4VGFXdWMxWUF1SkpPcDMvNW8wbkRJMVpoR2dCMEF4VWJHQkxyWC84?=
 =?utf-8?B?TCs1TjFsNFJocEtUWWtCdy9rQ2tsN2FOM2lXa1lOZ1FuOXdpYXZvQmp5c2ZU?=
 =?utf-8?B?VDB6YXYxdlhRUE9VNlNMMUw1ZXlwT1ZvNkk1c3g0aktuTFBqTlBqZ3FkNmlH?=
 =?utf-8?B?cElDbTZFWndxWllGZFNpakhzb3NJemt4NUVVQng5VHliNWpxYVhZMjBpMEMv?=
 =?utf-8?B?ZVN0QU5GQ1p5cDE5ZkFoQm02WTFWbjRMb0x1STNGRkdOb1duQlliT0pETXVM?=
 =?utf-8?B?ZUN3SHo2a3VNNWNUdVJRU0o5ZGhXUVFrYXE3Nnc0QUxEcDBtK1lralNSM3NX?=
 =?utf-8?B?OGRKeERET0NaRndtSEJuZ1QrWGd4MlMxRmRtdmlHbkpKd1c2dlFPNERUZFFC?=
 =?utf-8?B?Q2dpMkRXaVhLMVlUeW1ES0NmMGdjNXNoa1paZUFZSU53VlVQRkZJcXdBbHBk?=
 =?utf-8?B?VHJtWHh3OVRXdzkwV2tWZW1SaXhpWWhhMG5JS0dmV0hIMDUxV1pLdjlJenhP?=
 =?utf-8?B?OUVaM1ZmejNIWXJmWUxLdFpwVGd2VE5yOGh1TG5EejMyejd0cDZmaFlQZkk1?=
 =?utf-8?B?Zks2NGpUazRhWVFOTjdDVGpTNk81azYvZU9zeFJHeCtyM09SdWxOQlRZSVk4?=
 =?utf-8?B?ODVWZHRzRHhVZjAySndmTWxwYTAvbDdibmYzMVZETUxpSGM0eW5TWDVBTDV3?=
 =?utf-8?B?MlVPQmdDRUQvdHhRWVlqMms2V1lacWovL2JNeUxxTGd2WEM4K0w2T3h4K1BP?=
 =?utf-8?B?VWIrV2ZtKzNCL0xiSm41aFdSL0llT2VicDF2ZU1DMjBuRGh6ZzVoYXVUOUdV?=
 =?utf-8?B?T0F0enNmcEppdC8wM3ZwL3NiUytoSXh3QThIb1AreFFUakxOcjQxd2IvSXN6?=
 =?utf-8?B?eG9xcHVMSm5OS2Y5NXE0T2llSmc1TDlmOXZ5M25idmUxcFlkMFZrY1l4WFJX?=
 =?utf-8?B?dysxaDhzNTE5STI1M2lnK0FwVXRqSlFqaml6RmFmNmZvRThaSmJqdUFFbGNI?=
 =?utf-8?B?VkhPc2FCODFVdHhTUVNES2dXNWs1RXk4eU04SG1KMTdMWHZ0U3ZlUFVGVzlI?=
 =?utf-8?B?aSs1YjQ0ZStxMFpKNzVuTFp4YkhyV3R1UHJPMDJ5RE43dktrWW95ZVpJT09C?=
 =?utf-8?B?aTZPbTBFQ2MvU01ZeUY1dDZydldJLzBhcm1DSE15ZmZtdDhjNCtBTTlyMkIv?=
 =?utf-8?B?b3VHOTdhN0tvaW1oZVZJb0VTZWY4cXQ3OTZoUVp2ZC9ZUmVCcUVmZVJHb0tV?=
 =?utf-8?B?SjFoUTByY1hpaEpLalV5Rjg3MzhKOG9QWG0zTFd1bDNPYnhwemI0c3NOa2ZJ?=
 =?utf-8?B?MTh3VkEySGRMTFZvRm11RGU3bUxBb2tVSm0yL29NK2dybDVMOFViUTI3Vytz?=
 =?utf-8?B?UHZVSVE4aHkwM3JwVTNzTzNOZVpIZEt3R0w1aENINVkzOExSR2lyQWlhNjJW?=
 =?utf-8?Q?UeL5VoM2FxczAWs9hP?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d61987-5e5f-4d51-353e-08deb56cec49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 06:07:35.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZz7sAE5uffTakniNveQUSfs1fwmt4/x/bpxYZFBGMdFWDLoQi2vxaJNBoEBWbIeQX36Hqc8qyV9fgYYLVlyNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12092

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYxNCAwMi8xMl0gUENJOiBob3N0LWdlbmVyaWM6IEFkZCBj
b21tb24gaGVscGVycyBmb3INCj4gcGFyc2luZyBSb290IFBvcnQgcHJvcGVydGllcw0KPg0KPiBP
biBNb24sIE1heSAxOCwgMjAyNiBhdCAwODo0MjozOEFNICswMDAwLCBTaGVycnkgU3VuIHdyb3Rl
Og0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWMTQgMDIvMTJdIFBDSTogaG9zdC1nZW5lcmlj
OiBBZGQgY29tbW9uIGhlbHBlcnMNCj4gPiA+IGZvciBwYXJzaW5nIFJvb3QgUG9ydCBwcm9wZXJ0
aWVzDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBBcHIgMjIsIDIwMjYgYXQgMDU6MzU6MzlQTSArMDgw
MCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiA+ID4gSW50cm9kdWNlIGdlbmVyaWMgaGVscGVyIGZ1
bmN0aW9ucyB0byBwYXJzZSBSb290IFBvcnQgZGV2aWNlIHRyZWUNCj4gPiA+ID4gbm9kZXMgYW5k
IGV4dHJhY3QgY29tbW9uIHByb3BlcnRpZXMgbGlrZSByZXNldCBHUElPcy4gVGhpcyBhbGxvd3MN
Cj4gPiA+ID4gbXVsdGlwbGUgUENJIGhvc3QgY29udHJvbGxlciBkcml2ZXJzIHRvIHNoYXJlIHRo
ZSBzYW1lIHBhcnNpbmcgbG9naWMuDQo+ID4gPiA+DQo+ID4gPiA+IERlZmluZSBzdHJ1Y3QgcGNp
X2hvc3RfcG9ydCB0byBob2xkIGNvbW1vbiBSb290IFBvcnQgcHJvcGVydGllcw0KPiA+ID4gPiAo
Y3VycmVudGx5IG9ubHkgbGlzdCBvZiBQRVJTVCMgR1BJTyBkZXNjcmlwdG9ycykgYW5kIGFkZA0K
PiA+ID4gPiBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydHMoKSB0byBwYXJzZSBSb290IFBvcnQg
bm9kZXMgZnJvbSBkZXZpY2UNCj4gPiA+IHRyZWUuDQo+ID4gPiA+DQo+ID4gPiA+IEFsc28gYWRk
IHRoZSAncG9ydHMnIGxpc3QgdG8gc3RydWN0IHBjaV9ob3N0X2JyaWRnZSBmb3IgYmV0dGVyDQo+
ID4gPiA+IG1haW50YWluIHBhcnNlZCBSb290IFBvcnQgaW5mb3JtYXRpb24uDQo+ID4gPiA+IC4u
Lg0KPiA+ID4NCj4gPiA+ID4gK3N0YXRpYyBpbnQgcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnQo
c3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZSwNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUp
IHsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGNpX2hvc3RfcG9ydCAqcG9ydDsNCj4gPiA+ID4g
KyAgICAgICBpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcG9ydCA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqcG9ydCksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArICAgICAg
IGlmICghcG9ydCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgSU5JVF9MSVNUX0hFQUQoJnBvcnQtPnBlcnN0KTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldCA9IHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wZXJz
dChkZXYsIHBvcnQsIG5vZGUpOw0KPiA+ID4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyoN
Cj4gPiA+ID4gKyAgICAgICAgKiAxLiBQRVJTVCMgZm91bmQgaW4gUlAgb3IgaXRzIGNoaWxkIG5v
ZGVzIC0gbGlzdCBpcyBub3QgZW1wdHksIGNvbnRpbnVlDQo+ID4gPiA+ICsgICAgICAgICogMi4g
UEVSU1QjIG5vdCBmb3VuZCBpbiBSUC9jaGlsZHJlbiwgYnV0IGZvdW5kIGluIFJDIG5vZGUgLQ0K
PiA+ID4gPiArcmV0dXJuIC0NCj4gPiA+IEVOT0RFVg0KPiA+ID4gPiArICAgICAgICAqICAgIHRv
IGZhbGxiYWNrIGxlZ2FjeSBiaW5kaW5nDQo+ID4gPiA+ICsgICAgICAgICogMy4gUEVSU1QjIG5v
dCBmb3VuZCBhbnl3aGVyZSAtIGxpc3QgaXMgZW1wdHksIGNvbnRpbnVlDQo+ID4gPiA+ICsob3B0
aW9uYWwNCj4gPiA+IFBFUlNUIykNCj4gPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAg
ICBpZiAobGlzdF9lbXB0eSgmcG9ydC0+cGVyc3QpKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBpZiAob2ZfcHJvcGVydHlfcHJlc2VudChkZXYtPm9mX25vZGUsICJyZXNldC1ncGlvcyIpIHx8
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgb2ZfcHJvcGVydHlfcHJlc2VudChkZXYtPm9m
X25vZGUsICJyZXNldC1ncGlvIikpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiA+ID4NCj4gPiA+IFRoaXMgZG9lc24ndCBzZWVtIHJpZ2h0IHRvIG1l
LiAgVGhlIHBhcnNlciBvZiBwZXItUm9vdCBQb3J0DQo+ID4gPiBwcm9wZXJ0aWVzIHNob3VsZCBu
b3QgYmUgcmVzcG9uc2libGUgZm9yIGRlY2lkaW5nIHdoZXRoZXIgbGVnYWN5DQo+ID4gPiBtZXRo
b2RzIGFyZSB2YWxpZCwgaS5lLiwgd2hldGhlciBhIHByb3BlcnR5IGlzIGluIHRoZSBSb290IENv
bXBsZXgNCj4gPiA+IG5vZGUuICBJIHRoaW5rIGl0J3MgdXAgdG8gdGhlIGNhbGxlciB0byBkZWNp
ZGUgd2hldGhlciBpdCBuZWVkcyB0byBsb29rDQo+IGVsc2V3aGVyZS4NCj4gPiA+DQo+ID4gPiBJ
IGRvbid0IHRoaW5rIHRoaXMgZXZlbiBuZWVkcyB0byByZXR1cm4gYSAic3VjY2Vzcy9mYWlsdXJl
IiB2YWx1ZQ0KPiA+ID4gYmVjYXVzZSB0aGVyZSBtYXkgYmUgbW9yZSBwcm9wZXJ0aWVzIGluIHRo
ZSBmdXR1cmUsIGFuZCBub3QgYWxsIHdpbGwNCj4gPiA+IGJlIHJlcXVpcmVkLiAgVGhpcyBmdW5j
dGlvbiBjYW4ndCB0ZWxsIHdoaWNoIHByb3BlcnRpZXMgYSBzcGVjaWZpYw0KPiA+ID4gZHJpdmVy
IHJlcXVpcmVzIGFuZCB3aGljaCBhcmUgb3B0aW9uYWwuDQo+ID4gPg0KPiA+ID4gVGhlIGNhbGxl
ciBjYW4gY2hlY2sgd2hldGhlciB3ZSBmb3VuZCB3aGF0IGl0IG5lZWRzIGFuZCBmYWxsIGJhY2sg
dG8NCj4gPiA+IGEgbGVnYWN5IG1ldGhvZCBhcyBuZWVkZWQuDQo+ID4NCj4gPiBIaSBCam9ybiwN
Cj4gPiBUaGUgY29kZSBoZXJlIHdhcyBzdWdnZXN0ZWQgYnkgTWFuaSwNCj4gaHR0cHM6Ly9sb3Jl
LmtlLw0KPiBybmVsLm9yZyUyRmFsbCUyRmxuenByenJkd3JhN3BuN2Q2bTNzYmo1cHZqeTY0Ymx3
cGpsNmkzbG1sbmZieWhvNjNiJTQNCj4gMGN6cHlocGd6NXZ1bSUyRiZkYXRhPTA1JTdDMDIlN0Nz
aGVycnkuc3VuJTQwbnhwLmNvbSU3QzRmZTkwNGE0DQo+IDVkZDI0MjExM2MwMDA4ZGViNTZhZDQ5
NCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM5MTQ3
NjY3NjEwODEwMDAzJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZQ0KPiBVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBi
Q0kNCj4gc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWpvODc1aUdpbzE5djV4
bGxDSiUyRnhhM3hRTw0KPiBCUlVYQTZQTGsxbGxEOCUyRlA3MCUzRCZyZXNlcnZlZD0wLg0KPiA+
IEkgdGhpbmsgeW91ciBzdWdnZXN0aW9uIGhlcmUgaXMgcmVhc29uYWJsZSwgdGhlIHBlci1Sb290
IFBvcnQgcGFyc2VyDQo+ID4gc2hvdWxkbid0IGNoZWNrIHRoZSBSQy1sZXZlbCBiaW5kaW5nLiBU
aGF0J3MgYSBwb2xpY3kgZGVjaXNpb24gdGhhdCBiZWxvbmdzIHRvDQo+IHRoZSBjYWxsZXIuDQo+
ID4NCj4gPiBIaSBNYW5pLCBpZiB5b3UgYWxzbyBhZ3JlZSwgSSdsbCByZXdvcmsgdGhpcyBzbyB0
aGF0Og0KPiA+IDEuIHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0KCkgb25seSBwYXJzZXMgcHJv
cGVydGllcyBmcm9tIHRoZSBSb290DQo+IFBvcnQNCj4gPiAgICAgKGFuZCBpdHMgY2hpbGRyZW4p
IHdpdGhvdXQgY2hlY2tpbmcgdGhlIFJDIG5vZGUuDQo+ID4gMi4gVGhlIGZ1bmN0aW9uIHdvbid0
IHJldHVybiBmYWlsdXJlIGZvciAicHJvcGVydHkgbm90IGZvdW5kIiAtIGl0IHdpbGwgb25seQ0K
PiByZXR1cm4NCj4gPiAgICAgIGVycm9ycyBmb3IgcmVhbCBmYWlsdXJlcyAoZS5nLiwgLUVOT01F
TSwgR1BJTyBhY3F1aXNpdGlvbiBlcnJvcnMpLg0KPiA+IDMuIFRoZSBsZWdhY3kgZmFsbGJhY2sg
bG9naWMgd2lsbCBiZSBtb3ZlZCB0byB0aGUgY2FsbGVyLCB3aGljaCBjYW4gaW5zcGVjdCB0aGUN
Cj4gPiAgICAgIHBhcnNlZCByZXN1bHQgYW5kIGRlY2lkZSB3aGV0aGVyIHRvIGZhbGwgYmFjayB0
byB0aGUgbGVnYWN5IGJpbmRpbmcuDQo+ID4NCj4NCj4gRmluZSB3aXRoIG1lLiBUaGUgcmVhc29u
IGZvciBzdWdnZXN0aW5nIGZhbGxiYWNrIHdpdGhpbiB0aGlzIEFQSSBpdHNlbGYgd2FzIHRvDQo+
IGF2b2lkIGR1cGxpY2F0aW5nIHRoZSBmYWxsYmFjayBjb2RlIGFzIGl0IHdpbGwgYmUgbW9zdGx5
IGdlbmVyaWMuIEJ1dCBJIGRvIGFncmVlDQo+IHdpdGggQmpvcm4gb24gdGhlIGZhY3QgdGhhdCBp
bmRpdmlkdWFsIGhvc3QgY29udHJvbGxlciBkcml2ZXJzIG1pZ2h0IGhhdmUNCj4gb3B0aW9uYWwg
cHJvcGVydGllcyBpbiB0aGUgUkMgbm9kZSBhbmQgd2UgY2FuJ3QgaW5jb3Jwb3JhdGUgYWxsIG9m
IHRoZW0gaGVyZS4NCj4NCj4gQnV0IG5vIG5lZWQgdG8gcmV3b3JrIHRoaXMgc2VyaWVzIGFzIGl0
IGdvdCBhcHBsaWVkIGZvciB2Ny4yLiBZb3UgY2FuIHNlbmQNCj4gcmV3b3JrIHBhdGNoZXMgb24g
dG9wIG9mIHRoaXMgc2VyaWVzLg0KPg0KT2ssIHdpbGwgZG8sIHRoYW5rcyENCg0KQmVzdCBSZWdh
cmRzDQpTaGVycnkNCg==
