Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71530677E;
	Tue, 28 Jul 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205530; cv=fail; b=WwzH8Mmax+mgkqM4DO6JVjD92X7NBx+N+XLdkyr8w9uX2U8GgTfOP0LC4qfzODPWs/LALlUhBPUn4eio+gzUYdAF01nriaJKHnoABCRfK1k6I7TXLuOezv9qotoFKW1sO4Uav2j/KwQPkeL8VGFZ8XG2eVmJzi89cWpQhQqxzag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205530; c=relaxed/simple;
	bh=RSNshkmBldERQcABDRwqHFhiPP1cntWqS10OuvFgX4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KODFBWSsa+k3Tt9Uj7wLGTRxDv0SoewECO0xiM4gdroCVxTKLmnNjWupT+SdrGedZAAFbjy/j3G8EgFPKpCXQ8GgRLwQQ8jhq0t3nTUdhh/ndm1RSz/A3plxhPGXyKpUwWDk9j06jxJij0UKIweFGq3ThUzbd09GL3EGRkAl0c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h9uqPB3m; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h9uqPB3m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSrRbAnHvwpA/R8b0yf710AZ07qnDTIVvstOH3Xt5Hi+uthfmD01RbY64fdyAiWw3u2+bqaMOzHo9AyB7hr/1pE70E0gPGBfmhhFdh0/VM07i68RxBF445VbX6zCoeEE2I+WqnAjxasRpJgaB8izSLbv0939Tmiqicz3iexHYqfo2h+8ls9sr186eK8uYqsLdPyBTR6UEb8k2pRkB+tdqLXIgW6ZAyWzCfFZ7RY9iuMWhyf8ZDFZfL9fZAFrLNYv5dI/Nl8rGTK/P8zgAEud6Sd2zivUX8CpbcyQj+inAFG6cfWSYlqUOI7Ac2Tvhfx4kASAueAHno/RrrFzY/2bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSNshkmBldERQcABDRwqHFhiPP1cntWqS10OuvFgX4E=;
 b=qYuEZDi+6CCCq4pPby8618i5Z41dt3r659v+P60n91cgei3jW8p+b5YpCgXQ0GnV+85uveufrDiFUHFVoR585YVs3DOgmpAFdChHAek5/fa4kbIEVGjEZRPSDHWkUCj8mjKf5W4fWCGrI9Wlbgzs0ShSIXlk2bX2B2iRJTy3hYHKuAuFolboW1xU054HCB6IhcHJLN1MUjJ8XW/RBjfPlCahcicsMcEIlFeF9t7eS2r6A4vsJwnKNIej5rz04swPSG/9Kopn4K831uhTOGihqaFmc5mtHAjpw5tWrKK3yKEJ1B3+jrxnG+DYy/Fh1MrunBL2CFFjoc00apdfczch4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSNshkmBldERQcABDRwqHFhiPP1cntWqS10OuvFgX4E=;
 b=h9uqPB3mH0POM7Gs7LvYS1/OTB9jwjmpvHmXE3hjy8kokWQxzoLyXhnkHAwbBegoindAR/l6kzxsg2c75Olt0XcfAvgfKdiPuZRFLsNsGGJuran8HUQ4juB6k+RA+mLSganXT753BPDVl667lPFlViXkznvGHh3xg05DBg0yIJC5BEXaTT8/+MjpOzwKxwwbXHLhmr0x/tHboRA6Hy+aKaecov9GVn6GU1ick+GNhywuqoFNk/sX7tHyQpHI3dbe6GoUSHqqU+MbUAfBoayHGkIJaZlHpBJunD98elGWZY1iGNYTu+hdUr8ibQoPHz62YUYSLDVgrF6TrGCbeRbx6g==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PR3PR04MB7289.eurprd04.prod.outlook.com
 (2603:10a6:102:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 02:25:24 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 02:25:24 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>, Leonardo
 Costa <leoreis.costa@gmail.com>, Leonardo Costa <leonardo.costa@toradex.com>
Subject: RE: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper
 PHY power sequencing
Thread-Topic: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper
 PHY power sequencing
Thread-Index: AQHdGajCYVUdI/iuQEqLrXmIitSRILaB7kEAgABO5TA=
Date: Tue, 28 Jul 2026 02:25:24 +0000
Message-ID:
 <GV2PR04MB12019B14AA0101AF286C358408CCB2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260722071030.2504711-1-hongxing.zhu@oss.nxp.com>
 <20260727214214.GA1265909@bhelgaas>
In-Reply-To: <20260727214214.GA1265909@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PR3PR04MB7289:EE_
x-ms-office365-filtering-correlation-id: 4e061b97-1185-44f7-4061-08deec4f7b06
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|19092799006|366016|6133799003|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003|3023799007|10067099003;
x-microsoft-antispam-message-info:
 F4q29NRwPoungJZyFMEpYBfU3TZtQcWMPGpo59UHU5++UP9RuLUkArVvEKPDbybycO+tzrSVqbdRqFo8/jvYstw4uPqx+fvWE2AkIc1kRArjyFE4JugjPod6IB7OfbiGDvjag5jWi91x77l9OHt2NKyQ4+Af16L0ISuVFjVcfa4ae5Cn1jPAPVgKRn+amEjHAyEscll36/Ndc3RlVmK6MVdag69Ra+T9IN/zk+nIyMijqnZK9I7RKN+a0wquooK0ME5YAZWBE79rC05MZKBX+3Cq0y3/hBifN/pRuk2kHPclyf3ogva4BisxOfzn+OBNfLM09lDgt4K/d5ZYwDnVNiOU3UzkQ4ZmIZ+umMo936dMgTaKLYe27YKlXnnW22qMFoj1XD8SsdB3NI7nhA+z4n0kOCwq4rGxinjuAGsDPxSdwvHQAj4rfe9UAmpoZFR6mu+xx19oHaXU+ELRsfFdpyfl7ttMn4vflg/uEXVc4LUaSTjYa7L61/1PoLF/hd7rCWp9pfKF5t22k+DrYskj2JnBn/JzYrtfqDRJ10djbvzfgWj1Dz3bxu0h9dd0vpXbzWII2XaExTTf2ikDouLZeQnDjqX00s8rrRwjn5XxBasKUbObAEpmgT5W0ppeMPB0GK48VPdGIP2urtTYRorLnmT35AYepp8UejZBUtdVrgpe+Hesq1aPl0JCXcnOv8wN7GrWCYs4hm54L4ua2wWBbBGBc13MCqcgRxI05ukQVTA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(19092799006)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGNxaitOUitCS0htMWRxMzN2clBkallJdjFBcmxDelIraGJSelczYVpHUzEr?=
 =?utf-8?B?RWZRSkd2M0tHMG42dURTL0VlQjhuUXUvc2I4Rmd0N2U4dmFTQkMzeVdMbVcx?=
 =?utf-8?B?WkJncS9IRWlqM25oazdsR2JPaDhJK005NVYybE9FaThuTlVYdFVhMTRIN1Iw?=
 =?utf-8?B?WHhyaTNlZmZzS0h3S20zd1Q1TUk1SUEwQkxudDlEM0ZtcUhnVkxGdzM0TWky?=
 =?utf-8?B?R2xsN1R1aW50bmJUNzV1NHhjcXpGK3p6UXRhUWQ1QnJ3ZE1aUk9KUXpmV3d4?=
 =?utf-8?B?bWZlS0Q1ajZoZFp1bllXVVZJV1BFLzBYbExkeEFTVjdGbXhPS3N4UGdKMDVV?=
 =?utf-8?B?NEozdm8xandjTjJrK2hRT1lXQUZqYkNGeXhjTEhYWlFlZXpHcEZnQVdWNFpx?=
 =?utf-8?B?bS9GdGowZndyYjYzT3p4RytlQmZqRDI2WldsU0tpd3RZUjJoUkNTRjFxUllV?=
 =?utf-8?B?R1J1KzhIVjl0WW95STh1eWdEL2RneURUaUdQMVE3ektmMmpQU1dpb1Jya0o2?=
 =?utf-8?B?UTFpbjJyNE9lL1J1VE1ZbUt3UGRvQjNZMG0yakNLM2M4bEhjYVR0OWVCaDQ1?=
 =?utf-8?B?bk0zUC9jS3h5VGo0cjAzd2h3WExkUkwwOThkOHJFaEg5RlFCUTNpTjNRM0I4?=
 =?utf-8?B?enA4QTFvcWJuVlkxSVo3b1dSK2FmRHdyMEF1NEhBRU1oRjJiS3gya0NNSHB4?=
 =?utf-8?B?akZPenNlMmVSYk1MNkM4RlN4amNvVDlwbUJzZHRFWndlOHFuRUo2c1YwalRK?=
 =?utf-8?B?OXRCUkoycCtLOEFpelhnV25yS25KNTE2dHpOOTB6WVNNd2tZM3QyTURUSGpG?=
 =?utf-8?B?a203MUFZZHBPMUp3ZVJtbGFjSHI0bXkvUHN6UTB3QVU5SHl0bHRJSklMdndv?=
 =?utf-8?B?eWkvUmFwT1NhaXNob3JBMUFqNVhzMDFobFYwNkNMNnB3Y3dCUlNtbUhJVkZT?=
 =?utf-8?B?c3p5OC8zZ1ZaTFY2SWFaRUcxdCtwNjgxdjdMUzV4VjBNRlpWb0JHWkpoQ1B4?=
 =?utf-8?B?TXJRRjFwK1M0Y29peW0xUnpQMDliTS9kRjNXWk1CTVdKYU5WMkdTbHUrYnl5?=
 =?utf-8?B?ZFBHMXJNb3YzcnlkN3FvTitLbysyQy9JNk1NNDVydURKbFF3TVZjdHVSMmJo?=
 =?utf-8?B?WnNJQVZaT2ZUZUxrdUV6d2hEZFd3YVBXQm8xQ3JoUXNGSlpHVTd4WVJ1SStU?=
 =?utf-8?B?aGwwWmRUYkhvUXZTOTM3Yng3RWNIOVVtZVczVFk2L0tUVnRPTW54eEY4R2ZH?=
 =?utf-8?B?ZjcyRWJONzFJWGdQaGNMc0RwcnllbnlFS1FIZUZseGFnZjg3TG5UNUFXbXJl?=
 =?utf-8?B?U1dUWTVCVDJtQUgvUHdwYkZ3ZEVSYW4zTEhrVzVQbGJ2RFdudzJld05Db2th?=
 =?utf-8?B?d0UxY3AwV3lrcUQ5Q3BHdTBISUdkZElZN2x3WWFEL0JhMW96bEtqZkc4OUNm?=
 =?utf-8?B?VlZIYy96Y2ZDM3FIWkt5THNsRHpoa0dCd3F6VkNQY0drdGlQRHl3NTBYcndo?=
 =?utf-8?B?b0tnWmVQT1h6dkNmNkVHOGRlOTFsWFhyelFvYXhZbEZvbUtBcXNOVEdscXBO?=
 =?utf-8?B?Y0c1YWNkQnB6TjN0VVZCWW9VaUxtTEZOVkFMK2tNVzd0N0t5cEprcDFkc3Mx?=
 =?utf-8?B?dndlK2dPUXV0WXE0Yzd0VkNtVWdxNU5uYnVya3BOalpPRXlRV2xaRUhwbTJw?=
 =?utf-8?B?WkVGbHYxUExuemE1ZFpFK0lOSXBlMjlhbHB0Y1AvMm5EVllLV2N3ZGxyenph?=
 =?utf-8?B?bzdrb1NaZWMrVzFtaEVSajVhNUZSdkNLYStyZmtmMThQVWZhTGlYNkwzVHhq?=
 =?utf-8?B?ZSttYngzMFRUUFByZ0Ixa2p3ZXkzY281cEIzNnh5azFjMlVQODZDc2graDc1?=
 =?utf-8?B?U0dTUUgyZ2Zmd3JoRUs2WmZoT1UwSUpMUzZNNDg1TjNINVBGMkpUQzFIZGUw?=
 =?utf-8?B?S1BCV1Q0alNMYjd1M1ROYjlTR1BBQ1M2d2psUlJ6WXJ0T0ZNcmpzbW1Ua0s1?=
 =?utf-8?B?ZkdGOHF5alRkL0JFek1vUkpiOTEwTHJiZ2h0VnRLK0xXdm5RZ0pGb2ZyeXZ2?=
 =?utf-8?B?cktGakdjU1BraG1ZdWNCaldXejBleHhkd01DR3VuTHArVS9jT0g4Q1ljOTVr?=
 =?utf-8?B?b0tWcitrbWVRY2k2Vkt1ZnNBUVUwMmJRcktRbSthZTByclc5OFMzbVZZdC9B?=
 =?utf-8?B?czZCVHdySW1nUG5OT3QrVjZDS3hocFNUNmFubGF3czc2alBPd1hwQ290RGpo?=
 =?utf-8?B?UWIwMW83U1lVTE1UamZjbjV3aVQ4dkszT3FJYzNnREJXMVlxNUJLdjl0dDFZ?=
 =?utf-8?B?eHAyaVRXN0w3MkVqMlNEbnRuTlUxc0xSTzhMQlg2QlhmUXZlblJTZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e061b97-1185-44f7-4061-08deec4f7b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 02:25:24.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtHae7Nqha6y4SnwlP0LEluPKsaF1vRkzq5h8BClKuOF3O3VjwADYKgJlmdK2omWOcPxHwOb7GWcTrpv418+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjgsIDIwMjYgNTo0MiBBTQ0K
PiBUbzogSG9uZ3hpbmcgWmh1IChPU1MpIDxob25neGluZy56aHVAb3NzLm54cC5jb20+DQo+IENj
OiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwu
Y29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTGVvbmFy
ZG8gQ29zdGENCj4gPGxlb3JlaXMuY29zdGFAZ21haWwuY29tPjsgTGVvbmFyZG8gQ29zdGEgPGxl
b25hcmRvLmNvc3RhQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBQQ0k6
IGlteDY6IEZpeCBpLk1YNlEvREwgYm9vdCBoYW5nIGNhdXNlZCBieSBpbXByb3Blcg0KPiBQSFkg
cG93ZXIgc2VxdWVuY2luZw0KPiANCj4gT24gV2VkLCBKdWwgMjIsIDIwMjYgYXQgMDM6MTA6MzBQ
TSArMDgwMCwgaG9uZ3hpbmcuemh1QG9zcy5ueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPg0KPiA+IENvbW1pdCA2MTBmYTkxZDk4
NjMgKCJQQ0k6IGlteDY6IEFzc2VydCBQRVJTVCMgYmVmb3JlIGVuYWJsaW5nDQo+ID4gcmVndWxh
dG9ycyIpIGludHJvZHVjZWQgYSBib290IGhhbmcgb24gaS5NWDZRL0RMIHZhcmlhbnRzIGJ5DQo+
ID4gcmVvcmRlcmluZyB0aGUgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UsIHdoaWNoIGV4cG9zZWQg
YSBjcml0aWNhbCBQSFkgcG93ZXINCj4gY29udHJvbCBpc3N1ZS4NCj4gPg0KPiA+IFJvb3QgY2F1
c2U6DQo+ID4gQmVmb3JlIGNvbW1pdCA2MTBmYTkxZDk4NjMgKCJQQ0k6IGlteDY6IEFzc2VydCBQ
RVJTVCMgYmVmb3JlIGVuYWJsaW5nDQo+ID4gcmVndWxhdG9ycyIpLCB0aGUgc2VxdWVuY2Ugd2Fz
Og0KPiA+ICAgMS4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSAtIGFzc2VydHMgVEVTVF9Q
RCwgYXNzZXJ0cyBSRUZfQ0xLX0VODQo+ID4gICAyLiBpbXhfcGNpZV9jbGtfZW5hYmxlKCkgLSBj
bGVhcnMgVEVTVF9QRCwgYXNzZXJ0cyBSRUZfQ0xLX0VODQo+ID4gICAzLiBMaW5rIHRyYWluaW5n
IHN0YXJ0cyB3aXRoIFRFU1RfUEQgcHJvcGVybHkgY2xlYXJlZCDinJMNCj4gPg0KPiA+IEFmdGVy
IGNvbW1pdCA2MTBmYTkxZDk4NjMgKCJQQ0k6IGlteDY6IEFzc2VydCBQRVJTVCMgYmVmb3JlIGVu
YWJsaW5nDQo+ID4gcmVndWxhdG9ycyIpLCB0aGUgc2VxdWVuY2UgYmVjYW1lOg0KPiA+ICAgMS4g
aW14X3BjaWVfY2xrX2VuYWJsZSgpIC0gY2xlYXJzIFRFU1RfUEQsIGFzc2VydHMgUkVGX0NMS19F
Tg0KPiA+ICAgMi4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSAtIHJlLWFzc2VydHMgVEVT
VF9QRCwgYXNzZXJ0cyBSRUZfQ0xLX0VODQo+ID4gICAzLiBpbXhfcGNpZV9kZWFzc2VydF9jb3Jl
X3Jlc2V0KCkgLSBkb2VzIE5PVCBjbGVhciBURVNUX1BEDQo+ID4gICA0LiBMaW5rIHRyYWluaW5n
IHN0YXJ0cyB3aXRoIFRFU1RfUEQgc3RpbGwgYXNzZXJ0ZWQg4pyXDQo+ID4NCj4gPiBUaGUgcmVv
cmRlcmluZyBjYXVzZWQgVEVTVF9QRCB0byBiZSBjbGVhcmVkIHByZW1hdHVyZWx5IGluDQo+ID4g
Y2xrX2VuYWJsZSgpLCB0aGVuIHJlLWFzc2VydGVkIGJ5IGFzc2VydF9jb3JlX3Jlc2V0KCksIGFu
ZCBuZXZlcg0KPiA+IGNsZWFyZWQgYWdhaW4gYmVmb3JlIGxpbmsgdHJhaW5pbmcsIHJlc3VsdGlu
ZyBpbiB0aGUgYm9vdCBoYW5nLg0KPiANCj4gSSBpbnRlbmQgdG8gYXBwbHkgdGhpcyBwYXRjaCBm
b3IgdjcuMiwgYnV0IEkgaGF2ZSBhIHNlcGFyYXRlIHF1ZXN0aW9uIGFib3V0IHdoeSB0aGUNCj4g
bGluayB0cmFpbmluZyBmYWlsdXJlIGNhdXNlcyBhIGJvb3QgKmhhbmcqLCBub3QganVzdCBhIGJv
b3Qgd2hlcmUgd2UgY291bGRuJ3QNCj4gZW51bWVyYXRlIGFueSBQQ0llIGRldmljZXMuICBJdCBz
ZWVtcyBsaWtlIHRoZSBsaW5rIHRyYWluaW5nIHNob3VsZCB0aW1lIG91dCwgYW5kDQo+IHdlIGNv
dWxkIGVtaXQgYSBtZXNzYWdlIChpZg0KPiBkZXNpcmVkKSBhbmQgY29udGludWUgd2l0aG91dCB0
aGUgUENJZSBjb250cm9sbGVyLltdIA0KQmVmb3JlIGxpbmsgdHJhaW5pbmcsIHRoZSBpbXhfc2V0
dXBfcGh5X21wbGwoKSBmdW5jdGlvbiBwZXJmb3JtcyBQSFkNCnJlYWQvd3JpdGUgb3BlcmF0aW9u
cyBmb3IgaS5NWDZRL0RMIFBDSWUuIFRoZXNlIG9wZXJhdGlvbnMgY2F1c2UgYSBib290IGhhbmcN
CndoZW4gdGhlIFBIWSBpcyBub3QgcG93ZXJlZCB1cCBwcm9wZXJseSwgd2hpY2ggb2NjdXJzIGJl
Zm9yZSB3ZSBldmVuIHJlYWNoIHRoZQ0KbGluayB0cmFpbmluZyB0aW1lb3V0IG1lY2hhbmlzbS4N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo=
