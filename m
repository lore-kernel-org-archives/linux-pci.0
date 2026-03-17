Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E433BBD0;
	Tue, 17 Mar 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735275; cv=fail; b=mdMZJqHXyT3I28o3habDJXOHgqF68u1cjK3KkmIySkbKzCCFqfjezb3OwWtzUSTjCq/fRClJQ4FZzk9B37t1ILPLIOjU+gKtZJFW1MZ/J0aB08q5vg8V6BndgaA2JrERM6GX5OEbul/dcx3nt9owjRjC39FfYK9aWm7t4wVjqOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735275; c=relaxed/simple;
	bh=sabGN04ih5daGU1tyDHO3Ldz/iOd4HV3B8EwCm8Qb7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XBoA/nISiQQ2FhSFHbZWJPk8p1kR0s3JeIx3SaOE+KcjHGQZ8JiMh9Cp1fe92SznxALl6AxBh5tch37A+bvWNxlZA2OnkZOWexxFbSJes1L9IdbKdXtLWfVhWZnAeWM+W4a2IxzUUw0Q5++4psuPQ67wzDQ0TMuqvDojeqdrpgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uwy533+y; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uwy533+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZyMXCRnw/y6vNaMtV05E3Y4QIGgBvXFn9anWOJ72xOt5osy3vnk0gZfhc830/rAe5F93MSgebbTPuhM8DscUGH1MJD2BLwE78ChcyMuGBmsWQxKxkophlB+xYHG+t66dyj3wjEeOnwpaEHKQTPDBD1kEY5Rvpw32aQWF8Mu+aABbdXr7mgJkZJkyPqGCUGcb+3NYhFfWQbwRaHwcnL3ijGkaUBtBfPZyEt41EH6zX3YEi+znHXld1Tv4BEM11Rq1Y8dKW2F7uUQtj0SPg0SoFy8yoJnpKWElsMnbwcjIID+6dhvN+ZVSNjf57A6TNBWVvFvJBiLIca0FoT+ph+MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sabGN04ih5daGU1tyDHO3Ldz/iOd4HV3B8EwCm8Qb7M=;
 b=WuBc/fda1HeisEEDSFboLBpPTOZxFwOmY14lmCWP/+aJkRzFfVwVJQNXhCK/QbTWQFL+q8EHsLxIrrbPCTzZcT4VkCT1GZSSwL2jnWnb0bWey0Ib6Yigtlxk9hzWDD845n9A6jPRr8TW1cdAH3Rz+pPAnJlPH7ptf79z1IWz3H/nfPwL2bK1IDzbtSy385q1yhXE5T5y6rlKoWeCEsObUd6whPfhQ+gz+7/0r4Z5tNQ0UXlsSzu3hWfGvnInU2PFQxSRNAsoA+Drkl4KQVZRfQF87EcDwyx+h8CpHJ0DD1OHNmBNAyzl3GgP4XF8tz/rXd2ULhAh4KkrnNPAMdwGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sabGN04ih5daGU1tyDHO3Ldz/iOd4HV3B8EwCm8Qb7M=;
 b=Uwy533+yVq0uKTRtSjX6C8kCmaTT2zekDB66K/6OBD7P0jjE07nQCXLyb8onoWA20lA3pjU+TJ01KByhQ/qXQhUQvgK51cjIKbyDiM9CWLaG27M1eytL3iA7B1jk8CW1xII6KZl+inXm6yUyn1lOYRGKrUBkZbZWw9w1tXFlcM4l1vh8v+TYupVN0uv5lafD8XgbePbuRoamn04YeVtw4nvdKHaITV4OIiZCeVwWE4lUm1FSscKz9La+1CaqhX2mSQO7gHzWJTvcIzT3VsW2ilue0AaY6MzVxTzLBB6Gt84cA27q0iCA0uK2M3KK55QrHm4Y60G/zsU+zFntyExDKA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7100.eurprd04.prod.outlook.com
 (2603:10a6:10:127::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 08:14:24 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 08:14:29 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Topic: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Index: AQHcso5EihHzW0WZ+UyejN5MCJfCDLWr+maAgASsZYCAAb7EkA==
Date: Tue, 17 Mar 2026 08:14:29 +0000
Message-ID:
 <VI0PR04MB12114BFCA2249076D33ED16989241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-7-sherry.sun@nxp.com>
 <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
 <wnbxqzsxq5v33rr4cweoz2inkxsq536bqxvtpdleboll76gx7k@rdhh4ntyydk4>
In-Reply-To: <wnbxqzsxq5v33rr4cweoz2inkxsq536bqxvtpdleboll76gx7k@rdhh4ntyydk4>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB8PR04MB7100:EE_
x-ms-office365-filtering-correlation-id: 1c242453-306a-47ef-6d42-08de83fd3634
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 1oEGS0VAGMSmmYlFFxNj3GfGodNsF87lviEmkZWC/gk6/lvJ/509lX4Gfnj+t22Brw0wQk4vBgFcNGZCUl7ooe3SiNOiy52gacySisGQRStvJ16S5Q/Vrjm3qOvVaadEqYGkwkPjf6KnS3u3k94+k6i3J8VYe9s8FvG6P7C30hp/SyMDGBRVTbz/5Wosj7K2qH5S84vsN2Njqa/VKiYKnNU3qL3urVf5azRzjaIyG73BiNauOosd9GiXR68qf1daILdYyng7zuj/scwoQsUzg6EjKfbF1FEfsQQHlsnTjuJ65yB7xcsj5dPJiZ7g13b4qz48hoR+ghvKHHannbjGFrNQT6c7IQzGMak7yzr5qyMLfy+/FIlRQdUJ+PwXuMONJNPfL+Hz1MAHaq5wpqXbHCUjpjgDHWlf+mX0qfagaI9gsFC9tGs1k5OWTU4uyoNYj4CGhTnjy3HTUoyWlhgJfu4GgwiSDHz1yJCccYGuaFLxFELJiqqUxe8AcXnHq2v1cBkjRwU433k626sVU4wmCdZaKGKiuOLnUpfO9QxYAzhsHYIRXbq/n41Z2K4qCw0KmOAVuXX2BCZyARC/5d5b3F6qdzIHRFkBCQY76vxGvGIwIhGrjedNckCH8RJkt0Tewj2YUBUg/hybJLztVjShgW76BGb5hsaHcZta7B2UkYogukC3qCskscuy5it6fFcdtxQrKWM2WeWD42sqqldX2eCUM85V/yIfhJKiy1LwIBXeIB2n7+rr1RvngV9kMqgAPk8G3+7UXmxgycD9FENNHZujdj/lRcBCGlmSxLMyxpo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2dxdWVkb29VQ2tkcERIMzMyTmw2dGVJM0FTQlFiYXhoeWV4cXUyTDMzdDBB?=
 =?utf-8?B?ZzRCYUNiV2lVKytoaTAzcGhlOStvQXd4bmIrczMyRFFscThaK3dSRWZ1c0xj?=
 =?utf-8?B?emFDaVQyQjJlbGRPT3ptaDA2NFlVZldNVkFnZEZHNHBKS290WTZZMWRkU1J2?=
 =?utf-8?B?TmZZOFFneHhtY3V0YVRzTVpUUXhtRVlnTlcxbjdoaFFlNmNQUkhjdVBrc0pv?=
 =?utf-8?B?RVpkYXRzUHY5SFA4Nkh3ajRMTkhzeUs5MHlycTlUWTY1dWVFcCsvUTI4VXJT?=
 =?utf-8?B?TFdKTlMvNG9kbjFUUkxOcG5mNDNwRjJpUDN0YW1ITElFb05LRWFFUmwxbkZF?=
 =?utf-8?B?Qk0wMit3ZnErZS9saEFuUTVkczYvY0d4RlQrcVk1QWlVYk9xU0FOd0ViZ0JX?=
 =?utf-8?B?S0RqK29YWDN3L3cxZ0Vxdnh5Uko5Y0RPYjRaQ1J0S1IzYWNCS2x6UHZLY2c5?=
 =?utf-8?B?MytGMHpCc2ZXV0NzdDlFd0pNTE1aY21DVTZNRzVhNkcyak5YTFQvUUExelYw?=
 =?utf-8?B?RnRFT285cEhxcFAyTWZwYXVGVS91VGxDM2thWkdlNk9kZEhxQUh6UFJsZDQ0?=
 =?utf-8?B?ZmpDMGZkWW0vMG51UEc1VUJoOEQ0RlJqSzRVT0FLWDJMK0tEWmhTb3NWaWc4?=
 =?utf-8?B?QjZqMHhJS2U2T3I0eVdZMXRGTHRMOW5sc1QzM20vdkxPZ3d4aW5na0kyc3ln?=
 =?utf-8?B?S3c4enZkUVhkTE5qcDJkL1ZRcGc1dVRNL2FqUjVSTUNmbnRlSURMS2gwcDJ1?=
 =?utf-8?B?SVF2VE4vcitnU2liRGRtOGdOelVGeUgrNk1CZVlJb2FsWXdCYzBSWDRnZUtt?=
 =?utf-8?B?UFBINVIwRlB1SnRhL3NIbHRIYWV6bUx5WmNMOEVnZGYxQTJyRGdqZ3c5OWV5?=
 =?utf-8?B?MmwzTU1OVDdMVXp1UzRwUjFsN3FBSy8yUmpqcC9TaklJRkgwTU1TcWQyR2Yx?=
 =?utf-8?B?SGQ0aDNSMUFoZUlvZ0NINW9naWt2MjNpRldXV0QwUjJXeVlCdkNZeGhSYUZl?=
 =?utf-8?B?amE5STZtbE00czZ6WkFNbEhFaThJZ2J5R2g5OXNjSC9zQkJPZHh5NWtQcUVj?=
 =?utf-8?B?ZkhyN0M1anM2ZURyWHJQT2RjM25xS1BSTnNpQ25FSDQ1THZuTmMxSWhXejhj?=
 =?utf-8?B?ZmpmN3dFMXI4OExFTFhuTXdlTnhkU1R5Y0Y5Zjd3Z2MwOS81V3Y5b29jTERi?=
 =?utf-8?B?aDhhOGNpeXlZWlJHWDdVdUdJUGZ1Q2tFeEVDM3cwbTd3RGF3N1V6aE85RDZt?=
 =?utf-8?B?MkNUczRuZW5jdmJmREdxajdLM2xxWGU1Vk5WVDg3U3VvMXFJSTdqSjlEUVBN?=
 =?utf-8?B?R2hWcHVnVTMyenF4TGxSeC9Nd3lGOERXZGFFZ21id2JUTTFIS2FoOTFPZkFw?=
 =?utf-8?B?eVFtYkttZWdSbFRmUk1nOFZqNzNLL0tDR1VVTUN0cmNnUlVkbWVnR3lPSXBx?=
 =?utf-8?B?bVJnTENWRnRJakdHV3NDK0EzdmFzYnN6SUFldk1YQzhacGQ2RU5ibEZGUUV6?=
 =?utf-8?B?TnFyQm5SZWJlYW44bjNQdWF4dW5jYXhubHNsRVlxR1R4QWN1eGs0Ny9STEZV?=
 =?utf-8?B?L0NWcTMzdHF0aGp6dm5TZ25XZ3hjbjVNZ1dSckU1cjNwcFRTZ1lJWk1hQlpU?=
 =?utf-8?B?SlQyeUJacEpZVGl4c0JvR3JiMFVoYU82ZldpUXl4cXBrVGw2dmpLNy9KajN6?=
 =?utf-8?B?bjFmODJVV21LOVZuU2pBR016WVJ5M0lFMGVCUzJIOTBnbGR5bFZaeEVPVzRj?=
 =?utf-8?B?UXJsa3lwTm1RUy93Mnk3akhLcDFDK3o5WFZMODNnakZlL2xWaUZtdjZWTXU5?=
 =?utf-8?B?UWhEK2ZiR243dE8wZVZSQzgwcUJDcS9EYVZsVzhqT25TMGNrcnA1Z2xZakk5?=
 =?utf-8?B?WU1MQ2hsdDVSbXJhM1NuU3o3ZWh0NFJ4TVVDK1FvN2pTZmU0c0l4K1liRE8x?=
 =?utf-8?B?SnovNVNTT1puVlEwb0kwUGtSR21CZEdidWFsOWp2RU44ZUlqaHRrYkR0WExT?=
 =?utf-8?B?WUh2NUdkUExvcllqdnNTY1dhYzNXMmtiVGN4VnMxN3B2K2xZSlpjQTRCWVRP?=
 =?utf-8?B?UDJDOUVzeW9Fc3lHZ1FGbGNNTGRnaWloc2RYUGRwUmVJRVFpQ1gzVU1sczNr?=
 =?utf-8?B?YXZqcDlJd1l3b0tZNklLQkhvUHZOZFZqVmVCWlJLYUJzUmZEK3lvVCtkT3Yr?=
 =?utf-8?B?WktqOGxDYVpQNnZ3dWRGUGxQWjRLbzA2SEo3QXZtd2pWT1FPR1RlUFNxNnpB?=
 =?utf-8?B?eVQyRFdGbkdhNVBROEhqNkJIcDNXQzFFOE5UUzNPNTB3TGlvYWIreDZuTVdk?=
 =?utf-8?Q?BVDFafVHJDtNZBNPfP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c242453-306a-47ef-6d42-08de83fd3634
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 08:14:29.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRnLyiA7oj1x4Of4/oxGys5OimjLvreI5mEQqpSg5TQeBj7XHV5Hov9SVxzgeuN5o7MY1aI5n4N2nGqGwjcZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY4IDA2LzEzXSBhcm06IGR0czogaW14NnFkbDogQWRkIFJv
b3QgUG9ydCBub2RlIGFuZA0KPiBQRVJTVCBwcm9wZXJ0eQ0KPiANCj4gT24gRnJpLCBNYXIgMTMs
IDIwMjYgYXQgMDI6MDg6MDVQTSArMDgwMCwgQ2hlbi1ZdSBUc2FpIHdyb3RlOg0KPiA+IE9uIEZy
aSwgTWFyIDEzLCAyMDI2IGF0IDEwOjA44oCvQU0gU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAu
Y29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBTaW5jZSBkZXNjcmliaW5nIHRoZSBQQ0llIFBFUlNU
IyBwcm9wZXJ0eSB1bmRlciBIb3N0IEJyaWRnZSBub2RlIGlzDQo+ID4gPiBub3cgZGVwcmVjYXRl
ZCwgaXQgaXMgcmVjb21tZW5kZWQgdG8gYWRkIGl0IHRvIHRoZSBSb290IFBvcnQgbm9kZSwNCj4g
PiA+IHNvIGNyZWF0aW5nIHRoZSBSb290IFBvcnQgbm9kZSBhbmQgYWRkIHRoZSByZXNldC1ncGlv
cyBwcm9wZXJ0eSBpbg0KPiA+ID4gUm9vdCBQb3J0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1zYWJyZXNkLmR0c2kgfCAgNSArKysrKw0K
PiA+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC5kdHNpICAgICAgICAgfCAx
MSArKysrKysrKysrKw0KPiA+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNh
YnJlYXV0by5kdHMgfCAgNSArKysrKw0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9ueHAv
aW14L2lteDZxZGwtc2FicmVzZC5kdHNpDQo+ID4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9p
bXgvaW14NnFkbC1zYWJyZXNkLmR0c2kNCj4gPiA+IGluZGV4IGJhMjk3MjBlM2Y3Mi4uZmU5MDQ2
YzAzZGRkIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2
cWRsLXNhYnJlc2QuZHRzaQ0KPiA+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9p
bXg2cWRsLXNhYnJlc2QuZHRzaQ0KPiA+ID4gQEAgLTc1NCwxMSArNzU0LDE2IEBAIGx2ZHMwX291
dDogZW5kcG9pbnQgeyAgJnBjaWUgew0KPiA+ID4gICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiA+ID4gICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNpZT47DQo+ID4g
PiArICAgICAgIC8qIFRoaXMgcHJvcGVydHkgaXMgZGVwcmVjYXRlZCwgdXNlIHJlc2V0LWdwaW9z
IGZyb20gdGhlDQo+ID4gPiArIFJvb3QgUG9ydCBub2RlLiAqLw0KPiA+ID4gICAgICAgICByZXNl
dC1ncGlvID0gPCZncGlvNyAxMiBHUElPX0FDVElWRV9MT1c+Ow0KPiA+DQo+ID4gSSdkIHNheSBq
dXN0IHJlbW92ZSB0aGUgb2xkIGRlc2NyaXB0aW9uLg0KPiA+DQo+ID4gWW91J3JlIGFza2luZyBm
b3IgdHJvdWJsZSBieSBkZXNjcmliaW5nIHRoZSBzYW1lIHRoaW5nIGluIHR3byBkaWZmZXJlbnQN
Cj4gcGxhY2VzLg0KPiA+DQo+ID4gPiAgICAgICAgIHZwY2llLXN1cHBseSA9IDwmcmVnX3BjaWU+
Ow0KPiA+DQo+ID4gSSB3b3VsZCBwcm9iYWJseSBhbHNvIHRha2UgdGhpcyBjaGFuY2UgdG8ganVz
dCBjb252ZXJ0IHRvIHRoZSBwcm9wZXINCj4gPiBQQ0kgc2xvdCBzdXBwbHksIGFuZCBqdXN0IGFk
ZCBwd3JjdHJsIHN1cHBvcnQgaW50byB5b3VyIFBDSWUgZHJpdmVyLg0KPiA+DQo+IA0KPiArMQ0K
DQpIaSBNYW5pLA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cywgYXMgSSBleHBsYWluZWQgdG8g
Q2hlbi1ZdSBoZXJlLCB0aGlzIHBhdGNoIHNldCBhZGRzDQp0aGUgYmFzaWMgaW1wbGVtZW50YXRp
b24gdG8gcGFyc2UgUm9vdCBQb3J0IGRldmljZSB0cmVlIG5vZGVzIGZpcnN0LiBPbmNlIHRoZQ0K
cGF0Y2hlcyBhcmUgZmluYWxpemVkICh0aGUgUm9vdCBQb3J0IHN1cHBvcnQgbW9kZWwpLCBJIHdp
bGwgc3RhcnQgd29yayBvbiB0aGUNCnB3cmN0cmwgc3VwcG9ydC4gVGhhbmtzIQ0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS9WSTBQUjA0TUIxMjExNEE5OUE0MzhDOEU4
NzQ5MDIxQUFEOTI0NUFAVkkwUFIwNE1CMTIxMTQuZXVycHJkMDQucHJvZC5vdXRsb29rLmNvbS8N
Cg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j
4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KDQo=
