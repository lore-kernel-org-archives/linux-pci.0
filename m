Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499093B0ACE
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475485; cv=fail; b=uFzDYkxJyedp/f4SSEYEHQbDSp6FbXIZJu7+Ti7qo4LIa2UBEENd2OiIzrULcAa8VSRsDHFWoHL48ZAuKo21M+vBuSGLKGZ04PJB3kg5EA9fdTI0ZxUXEczD/EabVkd1bWaJe/35QZvHnYY1KegAfQgPUPCPivD66ePnqdDSH7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475485; c=relaxed/simple;
	bh=U1RVXNTuGUQbXohx7bm+4P2+Z5Erpbr5gcXbEKkB0HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B8GhhzS9YeY0lmR6+AeJq8Y7IdmnkeKW9t4PtL58cSBL6S+nkCfAOGZO5rW9rkaLwNaZ5VzVQ4wP3RsNdOG2nalSi1hu9vZ5qU6lO02BuIhXGPdhkLxR2iH6MlG9/WfCVw0PaI1fkaVj2R3JeW6pNQs+pcV59eZKRxwRoqOKIPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oZTR13zy; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oZTR13zy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm6xtbUq3ZsvFtXjt3+DdNAfZTy9ZBDTpxaCtlHntAbXoWwrqFRtMCXmHoy0QsmZ0OI/7qTMTiG+6BB/oEVFYM7r0LwG+ATv4SnAi+mBT6p2pH5HAZiquRD0r0TKwjmnw6/OrPAtKwM7UtUV9R5BjilZqJtXhnahnaWajNjXYOin+SIAW66gKE61eoQ95QXJ0RpFtFna5lt7RaNfS52v++0Z7dasAxD0K5T6aK+ntemrN57ZC8mNm+nRsxwaqMGCpIPjxWNzuSCAP99zG1cEm1/9bxbbHnaLWNRwM4cLnkYNNweLkVQiB1jwD7JKyfeBjnDnnT/cmZ1wbaLLqRm81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1RVXNTuGUQbXohx7bm+4P2+Z5Erpbr5gcXbEKkB0HQ=;
 b=ghSvBbLZcMi3y8/xN2vZD2wAUu6DGt36UjgVVajtxfI6JtovrmUhx3TAMtByDfuOjdYj4zj4/S6G5+h+yX6O2NlWEPPUHnIAU7+kg0PlA99ZwKmg/R4lYS9TPwaRAdp96qz1ipmjrRPtGLNtJbijlARnDg0B1T/Q0twnMP6Enu4h3j639gKMvLCsqi8VVqtiaROsQuQKGScDEAYW6uW43TZc4EyFzn8Q67LRCKoHmeT3c+48ruTzwM3w01leuz5XyzukpXajtNrjax6wHPSYFvFzfllcI6k3iIMEwQ0+kzCDwMYfs5LLFqkxZmbwcUyR44jOOP0k6CoUmVVCtpN9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1RVXNTuGUQbXohx7bm+4P2+Z5Erpbr5gcXbEKkB0HQ=;
 b=oZTR13zy4AQ/p/O2rGYcJUJ+nWAsv3ew+D7AA6WGIKtsV0Jc9Ob6m6tenFUxv0sV2XOInPUEplDdsSkOMhrc+VkQc91SkObjbqUjeM6pBI5MYG8x7Cx0z9w1UGIpn8XBpzPI7b2MwKlRC9w0dQqfmW4MOhaumwpO9sPg63urffXyFMpgPYS6qFRqf7KlJOTYsc+XUgTH5t2HkEK31t1PhgxXuHCne//IgunrskG07r0TguP6Ez8vQ7gJ7mBHA39URR5nSrR1KRDTnCYb6M0JHKYbOowVn8uZxC2v5Af3HqNvUwdi32tvfOK3e6ocyVp4hqtsIoT52KtoOMPZj3DXwQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VE1PR04MB7295.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 01:51:16 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:51:16 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3
 stability
Thread-Topic: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe
 Gen3 stability
Thread-Index: AQHdDRUbl5Igr3djM06998s3EL/7GbZgFIaAgALIdYA=
Date: Wed, 8 Jul 2026 01:51:16 +0000
Message-ID:
 <GV2PR04MB12019A317C069FC97540B6F758CFF2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
 <20260706071622.1E0131F00A3D@smtp.kernel.org>
In-Reply-To: <20260706071622.1E0131F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VE1PR04MB7295:EE_
x-ms-office365-filtering-correlation-id: 0eea2e64-7435-4ea9-732d-08dedc9365f9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|376014|6133799003|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /L0qwVdhMYH+zqU4sepk2pmmZCOSvA8IY3zF4B/WcRM4c/UPdN8GPFLV0CDD+KkC4dX1Of7d0bw5r+m5yTINwEzdDaT4/w//vNJ9FmIEaCE6Z64uZ51BI+ZT+C0tmId0tzadM/3j6tE8QtTzPUcNOFO8T9AWWOltB7GoSnQmS+SN4DVdfj6oun4C3ihDnDm3Iyhw/w1QJCcyvbUg1b6wvAJ1ZJOHMsqfBIEg42vnmAtCYFmOoa2kz4zAHnGoJg3zpQ+Z+zQk3jOFLp79rKJCwSa2gQzUo4G1d8dyZ3kiyLYuvYW5g+5TQ5qB8PqDhffNvHSgrIQJxQo/QZpVmYM6so2/kBpssEhU+DWCU8+j/jfQoJYhbXGub3RaXg5fi4nLnjtsO1wvwhpaNjW+/gKDaG6cewfUzH5mee+1r/mBPkrp6f00s+vjbDTYW5+CUVuE9e+B36z1U3/LR9jYWyKIGW3eIkCSTNS2FMpBm29SGQtrqs/H7smcecK5lTQA9uBls7MTHI2QhNpXPwf6ObeAN6OJ4iVrih71mEQl45xz5c7NZX9Y9w+I3FI/37HQqnLw4QoRCsBRVsGGqoZYaIzCNjuyAzDxmltvIVODc8embpKY3ySObE+CJX9SxRT40Q7b0VdXWJSjgaLDBJJFscickHdM/v6YPncuykFQtLx1UMs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(6133799003)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmFKL0JKQ01iQmpYR3lON0lPRXp1S0ZYVU9MY0pZOU9yNXJkdkh1cEVvL0U4?=
 =?utf-8?B?WjdUWE1wSis4WmNoRUpOdlBFUkFpandtQUlIaFQrYk15NnlvNHhQNWlQU05B?=
 =?utf-8?B?MHo2OW9mL3VUcElsR2M1dWgxVm5MUDdZTCtrOGpaSXN3NkRiR2lsSGdLZUNB?=
 =?utf-8?B?VStYQVNlSzN5Y1RmWGZKSGQxb3dIZngvMW5VeUJ5LzhxYkhKSUIwVVN1bjhZ?=
 =?utf-8?B?TU5CcVpqUzJVSVJZYUhOclRvV0tQNEIxNlhZODFCWUZiMFRmTW1vWTRKclVJ?=
 =?utf-8?B?UXBoRzZRellBdDVHcGhBdUdDNE1IS3ZTbHRYMHhrc2svZTJMSjNMNVhtYXhS?=
 =?utf-8?B?TVlyRTVGSk9XSkdUZjdub0xCOFNhbXAvZ1RtWHQvVERuR2paR1paNXdjQnor?=
 =?utf-8?B?dnlkdkNpVHFMTjJJc2pNQUFwOEVlVkM1Z3pYcXF5bFBITFZZU3VodGM3S2E3?=
 =?utf-8?B?NzQ5Tm1vYlhMY2o0RFRNSzJTUXl0Kzg5dmROK0g2YzhiWlRrUEMxWlNnajlw?=
 =?utf-8?B?UVAyM08vTnllZUE1UVBFYSs4bitieWpRd0o0TVJoTmVGbXZuTGRSN0kwQ01m?=
 =?utf-8?B?Nlc4aFdMdW5USHdwZUIzS2MvcW93emxPbU5TQ0hQUU5RNGREeityRk5kNlVW?=
 =?utf-8?B?NlRnaVp2andhRG13d2F3Vk9VMEwyMVhqYXhxK3FqUGFxUXAxY1F1QlBGRnRv?=
 =?utf-8?B?SWNWazBEQ0t0YWF1Y1R6WlJpdXVmam9pN0dRa3hOVzEySERHVmVNYUU2OTJn?=
 =?utf-8?B?MDFKand2ZUR0U1pyMzdTdWlsd0JLQmY4a3MxcFhVTi9tK1MwZFdnS3pUMmdu?=
 =?utf-8?B?dVllazBiemtZSE1mK2Nqb3Y2YkVXd3hZUTl0Si9PNHc0SkxQbWV6S0UyeGRX?=
 =?utf-8?B?djd2eVNkSTNxMmRWRmg0ZEhmMUY3dzNJVW1sVkU1RmZ3cDhKR3RDeldDUi9V?=
 =?utf-8?B?S1M1WmxlclhUWmk5bUUwVTd3NFlmT3ptTk8rcFNRb3Y0VW4zMDFrUjBxY2hC?=
 =?utf-8?B?WjNLN1F2TjV2QWxqbExiMVFWOGJWREJUSlRKYXVTM2NrL2hBU0x5YnA5eFY4?=
 =?utf-8?B?dTRZa3FIZU5qdEkwOEh3QThiZkhtWm5CbjhXRmthb0FtcGl1K3FrOW9iazVi?=
 =?utf-8?B?Vjd1aDVFRjhRZEVKcGE3bVpBb3N0Vmo1ZVVwUSt0VlhsUHdQNFlZdzl4V1ll?=
 =?utf-8?B?ckg5YlE3aUNOUVgxMTh1T01wUDA0WWNHNXg3bXpTeWZMTHRRZFFRUHdWUTFE?=
 =?utf-8?B?cVd4OTdidlpXaWdjNVpvNnJNNDRpS1NxT2hTOWw3M2h3OGd5Vmo2cnhXQXZH?=
 =?utf-8?B?UXl6NHZiOFNGcVR4eWNUVEJhaVA0ZmRRU29tVTR1dEFxREVPRzRmdUNTaTVw?=
 =?utf-8?B?akZkMVNENDd5TEVSQm1UQWZkRVpVRGhWTDlPb1pKZXErS0pCbDFhTVNJd3U5?=
 =?utf-8?B?eHZYMEs1THV5aUVJcGN1b3llY1VicXRhaEJxOWFvSXFoV05qTkx1TlcxVGpl?=
 =?utf-8?B?V3VycnFnY0Nlcmg1cUJTTU4yY0xSMTlNZm1qYW1LcFpvL3lvTHRiQk9CM296?=
 =?utf-8?B?Q1VGQzhxVFp5MHVuS05wZlplQ09UYVc5RUdsMXBTWEhqVmlZb0k4SDJwb0Ro?=
 =?utf-8?B?S1UwbG0xMDNJNGxPUTdSdzBETVVZalBUSU5iRTlJVTU2bDMxamRKTGhHZFVF?=
 =?utf-8?B?aXBHZUJwRVE5N0NVMC94dzUyL0t5MDFYU3hocUVRV1F2UzlLSTI5eGZuK25K?=
 =?utf-8?B?Wk5lU3IwL3pMZVlDL3FyZU1paHV5QkFXOS9VbUtmdVdieklWUUljdjIxSGdT?=
 =?utf-8?B?SEU1N2N2eGQwQzNaTHErRVVWK1hPZ2o2RGRpcXViQ2RMV2Y0d1VXVlJBdmlW?=
 =?utf-8?B?eVZsR3NJb2dKVnNLR1FDaHFvVW5xNWVyOU1jakh4UU1sczZ6ZTI5dzc4eW9J?=
 =?utf-8?B?NFVDY0l1aGZTM2RXZTVpNWk2aG5UN25xbExLT3BlNTZsaU9Xektnb1lVUE5V?=
 =?utf-8?B?UUl3RSttZzFHRHNHc01iU25HcGF5cVZIUXNsMzFGdFMwZFlVK2NacXZqcUVt?=
 =?utf-8?B?dm8xb0NFaHArcDJkYytRNVV4TDFSbC9OaTlnMWF5WXN6ZVBHb1VjZEhaaWxp?=
 =?utf-8?B?eCtpQk51azFDcVVneFZsRi9WSWVxekl0ZFIwRzMzMVgwbzFVREVmaFdxMk1v?=
 =?utf-8?B?a1dGQWUxWkdqbDg4TXJCcm5uVnIzWURXUC83RG52Vjd0T3A2c1RFMStGQTlR?=
 =?utf-8?B?QVlCYnFoSUR0NS81WTFPRWpHL1dDVlZFL0NGVGFQaElDZUZFRVVDY1JGdk1T?=
 =?utf-8?B?K1JISUhYTHRZT0J4M1hDZWdQVGVaVERaTHhESWRhMS9UaXZWOWN6UT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eea2e64-7435-4ea9-732d-08dedc9365f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 01:51:16.2062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5qYMNm7BX9ls+hR2/tA16dVaTggcu0G4WK0wLN6bHTLf2EeDpXadTo58fP47jwl8QpHBvlrqsSewLglPoLwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgNiwgMjAy
NiAzOjE2IFBNDQo+IFRvOiBIb25neGluZyBaaHUgKE9TUykgPGhvbmd4aW5nLnpodUBvc3Mubnhw
LmNvbT4NCj4gQ2M6IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IEZyYW5rLkxpQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBp
bXg2OiBVcGRhdGUgTVBMTEIgYmFuZHdpZHRoIGZvciBpLk1YOTUgUENJZQ0KPiBHZW4zIHN0YWJp
bGl0eQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSBy
ZXZpZXcgZm91bmQgMyBwb3RlbnRpYWwgaXNzdWUocykNCj4gdG8gY29uc2lkZXI6DQo+IC0gW0hp
Z2hdIFNsZWVwIGluIGF0b21pYyBjb250ZXh0IChOT0lSUSkgZHVyaW5nIFBIWSBpbml0aWFsaXph
dGlvbiBjYXVzZXMgYQ0KPiBrZXJuZWwgcGFuaWMuDQo+IC0gW01lZGl1bV0gTm9uLWF0b21pYyBj
b25maWd1cmF0aW9uIG9mIFBIWSByZWdpc3RlciBhZGRyZXNzIGFuZCBlbmFibGUgYml0cw0KPiBw
b3RlbnRpYWxseSB0cmlnZ2VyaW5nIHNwdXJpb3VzIGhhcmR3YXJlIGFjY2Vzc2VzLg0KPiAtIFtM
b3ddIFJlZHVuZGFudCBpbml0aWFsaXphdGlvbiBhbmQgYXJiaXRyYXJ5IGRlbGF5IChmc2xlZXAp
IGV4ZWN1dGVkIG9uIGV2ZXJ5DQo+IFBIWSByZWdpc3RlciB3cml0ZS4NCj4gLS0NCj4gDQo+IGNv
bW1pdCBkNjA3MWRhMTVjODhjY2ZiYjA4YmU1NWNlMWM5MTk4ZWM4OGZkNjhjDQo+IEF1dGhvcjog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gUENJOiBpbXg2OiBVcGRh
dGUgTVBMTEIgYmFuZHdpZHRoIGZvciBpLk1YOTUgUENJZSBHZW4zIHN0YWJpbGl0eQ0KPiANCj4g
QmFuZHdpZHRoIG1hcmdpbmFsaXR5IHdhcyBvYnNlcnZlZCBkdXJpbmcgaS5NWDk1IEdlbjMgUENJ
ZSB0ZXN0cyB3aXRoIHRoZQ0KPiBkZWZhdWx0IE1QTExCX0JJTkRXSURUSCB2YWx1ZS4gVGhpcyBt
YXJnaW4gZGVncmFkYXRpb24gd29yc2VucyBhY3Jvc3MNCj4gdm9sdGFnZSBhbmQgdGVtcGVyYXR1
cmUgKFZUKSB2YXJpYXRpb25zIGFuZCBkaWZmZXJlbnQgdGVzdCBtYXRyaWNlcywNCj4gcG90ZW50
aWFsbHkgY2F1c2luZyBsaW5rIHN0YWJpbGl0eSBpc3N1ZXMuDQo+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggOThlMWRiNzUxMTMyYS4uZTY1
ZGVmMTYyMDQ0MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtMjY5LDYgKzI3OCwyMCBAQCBzdGF0aWMgaW50
IGlteDk1X3BjaWVfc2VsZWN0X3JlZl9jbGtfc3JjKHN0cnVjdA0KPiBpbXhfcGNpZSAqaW14X3Bj
aWUpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGlteDk1
X3BjaWVfcGh5X3dyaXRlKHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUsIGludCBhZGRyLA0KPiA+
ICt1MTYgZGF0YSkgew0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNf
Z3ByLA0KPiBJTVg5NV9QQ0lFX1NTX1JXX1JFR18wLA0KPiA+ICsJCQkgICBJTVg5NV9QQ0lFX1BI
WV9DUl9QQVJBX1NFTCwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9QSFlfQ1JfUEFSQV9TRUwpOw0K
PiA+ICsNCj4gPiArCWZzbGVlcCgyMDApOw0KPiANCj4gW1NldmVyaXR5OiBMb3ddDQo+IERvZXMg
dGhpcyBleGVjdXRlIHJlZHVuZGFudCBpbml0aWFsaXphdGlvbiBhbmQgYW4gYXJiaXRyYXJ5IGRl
bGF5IG9uIGV2ZXJ5DQo+IHNpbmdsZSBQSFkgcmVnaXN0ZXIgd3JpdGU/DQpZZXMsIGl0IGlzLg0K
DQo+IA0KPiBCZWNhdXNlIGlteDk1X3BjaWVfaW5pdF9waHkoKSBjYWxscyBpbXg5NV9wY2llX3Bo
eV93cml0ZSgpIHR3aWNlLCB0aGlzDQo+IElNWDk1X1BDSUVfUEhZX0NSX1BBUkFfU0VMIGNvbmZp
Z3VyYXRpb24gYW5kIDIwMHVzIGRlbGF5IGFyZQ0KPiBwZXJmb3JtZWQgb24gZXZlcnkgcmVnaXN0
ZXIgd3JpdGUuDQo+IA0KPiBDb3VsZCB0aGlzIGJlIGEgb25lLXRpbWUgaW5pdGlhbGl6YXRpb24g
cHJpb3IgdG8gdGhlIHdyaXRlIHNlcXVlbmNlIHJhdGhlciB0aGFuDQo+IHBlci13cml0ZSBvdmVy
aGVhZD8NCj4gDQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBmc2xlZXAoKSBj
YXVzZSBhIHNsZWVwLWluLWF0b21pYyBidWcgZHVyaW5nIHN5c3RlbSByZXN1bWU/DQo+IA0KPiBU
aGUgaW14X3BjaWVfcmVzdW1lX25vaXJxKCkgY2FsbGJhY2sgcnVucyB3aXRoIGxvY2FsIGludGVy
cnVwdHMgZGlzYWJsZWQsIGFuZA0KPiBpdCBjYWxscyBkd19wY2llX3Jlc3VtZV9ub2lycSgpIC0+
IGlteF9wY2llX2hvc3RfaW5pdCgpIC0+DQo+IGlteDk1X3BjaWVfaW5pdF9waHkoKSAtPiBpbXg5
NV9wY2llX3BoeV93cml0ZSgpLg0KPiANCj4gRm9yIDIwMHVzLCBmc2xlZXAoKSByZXNvbHZlcyB0
byB1c2xlZXBfcmFuZ2UoKSB3aGljaCB3aWxsIGF0dGVtcHQgdG8gc2NoZWR1bGUgYQ0KPiBzbGVl
cCBpbiB0aGlzIGF0b21pYyBjb250ZXh0Lg0KPiANCj4gU2hvdWxkIHRoaXMgdXNlIHVkZWxheSgy
MDApIGluc3RlYWQgdG8gc2FmZWx5IHdhaXQ/DQo+IA0KT2theS4NCg0KPiA+ICsJcmVnbWFwX3Vw
ZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiBJTVg5NV9QQ0lFX1BIWV9SRUdfQURE
UiwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9QSFlfUkVHX0VOLA0KPiBJTVg5NV9QQ0lFX1BIWV9S
RUdfRU4pOw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLA0K
PiBJTVg5NV9QQ0lFX1BIWV9SRUdfQUREUiwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9QSFlfUkVH
X0FERFJfTUFTSywgYWRkcik7DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gV2lsbCB0aGlz
IHNlcXVlbmNlIHRyaWdnZXIgYSBzcHVyaW91cyBoYXJkd2FyZSBhY2Nlc3MgdXNpbmcgdGhlIG9s
ZCBhZGRyZXNzPw0KPiANCj4gQnkgc2V0dGluZyBJTVg5NV9QQ0lFX1BIWV9SRUdfRU4gaW4gSU1Y
OTVfUENJRV9QSFlfUkVHX0FERFIgYmVmb3JlDQo+IHVwZGF0aW5nIHRoZSB0YXJnZXQgYWRkcmVz
cyAoSU1YOTVfUENJRV9QSFlfUkVHX0FERFJfTUFTSyksIHRoZQ0KPiBoYXJkd2FyZSBtaWdodCB0
cmlnZ2VyIGFuIGFjY2VzcyBpbW1lZGlhdGVseSB1cG9uIHRoZSBlbmFibGUgYml0IGJlaW5nIHNl
dCwNCj4gdXNpbmcgd2hhdGV2ZXIgb2xkIGFkZHJlc3Mgd2FzIGxlZnQgb3ZlciBpbiB0aGUgcmVn
aXN0ZXIuDQo+IA0KPiBTaG91bGQgdGhlc2UgYml0cyBiZSB1cGRhdGVkIGF0b21pY2FsbHkgaW4g
YSBzaW5nbGUgcmVnbWFwX3VwZGF0ZV9iaXRzKCkgY2FsbD8NCkZvbGxvdyB0aGUgcHJvY2VkdXJl
IGZvciBhY2Nlc3NpbmcgUEhZIHJlZ2lzdGVycy4NCkNhbid0IGNvbWJpbmUgdGhlc2UgdHdvIHN0
ZXBzIGludG8gb25lLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiA+ICsJcmVn
bWFwX3dyaXRlKGlteF9wY2llLT5pb211eGNfZ3ByLCBJTVg5NV9QQ0lFX1BIWV9SRUdfREFUQSwN
Cj4gZGF0YSk7IH0NCj4gDQo+IC0tDQo+IFNhc2hpa28gQUkNCj4gcmV2aWV3IMK3IGh0dHBzOi8v
c2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDcwNjA3MDM0MC4zNjAzMTUwLTEtDQo+IGhvbmd4
aW5nLnpodUBvc3MubnhwLmNvbT9wYXJ0PTENCg==
