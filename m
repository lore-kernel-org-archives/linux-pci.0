Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1F1B4F0A;
	Fri, 17 Jul 2026 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784255654; cv=fail; b=H5zOEisgUG2mHbjyTH05Wns1ze4N5gLK7tIq42oNDQ/IguDhDMFbi8/prdfkEDammv+H+4HX+F8qQyPnzdBZ593zjbYdBtvhq+ZyLwEjsTkOSclcgg7cHOIHY0W0GO4vdDhBFoNS3c3RqCZBz9xn6j1ZLfKbBHzTUY/3PT6fbxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784255654; c=relaxed/simple;
	bh=985vGZblUrf09HUPyx+ONiUzQIKgNy8QLK1wMUstnIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xzm8cPHGtDibHjVeYZuUnQxCvK+419ApePkYiJXU0vujMHk64wlAWzSw5IEH0Q/qYQZxTMTyfhq0ePAlSNgwSbQB7Gdu+faYkhETqCxhiI9moQ9p11QP0I7G9Wqsnx01I/mh9197HHSViQZVnxExJsXvjwKbE2fpZt0r4okJV4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RSrTK4ID; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RSrTK4ID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbAKFQFfpttXR6EyRD8iqFEkjc3uN8aYGTQUXJj4DgOGkZQTx/VGfMZFx0GnsLU6ZQQBntaxn4dmRPT2seoMO67VpQqVsVBybe1kq6pB+Y8wI44QTlTPsAqZNFdBfulVsdYa0sVmx8BoYOnmXFU5b3c901IpKR4omJqkgw/ELlhz4u5YGvILWcgXJ89KTDT5aV/yfE/PFg5+Nf7NsJtbHf4gO518oAERTo7pmjUmimpMrdKPQntr2xumnyy+Evx8/cXLGp7IC/qA0sTmnTwBuD9EfZVEuc3kw/37u5b4lYRxnyIR5OXnoxbdsBwgRQ5HpbAeqfdVpDHIzke6nlR3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=985vGZblUrf09HUPyx+ONiUzQIKgNy8QLK1wMUstnIg=;
 b=udrmY+aTLAkTCGBTNrbm7kcdvufc81WEB2DQStXi0n8rzq9fVdPNZX3lgRmhJVP73lvYlr3Tz8pVsOhjNFDTvT7sBNyk+BEAoymqGo05YiDNuv1ZagVOyXktKm66LJvYcpk8WquD0Ht/t1zXqXxX8peFttD6TIteiuYnJl0JcczHoZSf7vxMmj5J41pj4ow07wG3j1XePv+yrsj9KsxSJ/08j01pix5M5N2uhBIVIQdD60IEf1CLgB01cSxHMvU2g9R0cASiVr+XqJ+hfjsLlEeFWdE66IlXw+e8Rkzx7997Kji3DF7qCgQ/Mp+fqxj+kP/YP+M6RDvEV8Ne+znw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=985vGZblUrf09HUPyx+ONiUzQIKgNy8QLK1wMUstnIg=;
 b=RSrTK4ID3i5YRC7b97gfCrGQZQoqfxRzvOM1EblmkLj7wKMyuNO2vDZR5Rf+CpQZXeNh2pW41hMk1nuFGV6r6a0R9IXvidKkCKf1v5LjrGJvu2BpxVKDS5L27ySH6KDH3CrP9tv6ZoG7UZAdkxZts5ubaWdmJy2rItSJCHIAn90OEI2s6tTv9YNavMNA4n/acnfoJKxgyb1408rLtxhJs8b0kj4jQkHtg23sLV4/aiIJfjNQNyuswHbeEHeTFiAOkQHlXU0ZDvgwpzJVkVfoylNpU2NUcGtDmXkmXK4Hf1gclkdf8UxQlxvSgUO7yuEVmyb0uSVJkJYlRKTQ48p3Hg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DBAPR04MB7365.eurprd04.prod.outlook.com
 (2603:10a6:10:1a2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 02:34:08 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 02:34:08 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Thread-Topic: [PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Thread-Index: AQHdDo223MmT6wt2E0C/7FVeLjgzG7ZwZ3AAgACkztA=
Date: Fri, 17 Jul 2026 02:34:08 +0000
Message-ID:
 <GV2PR04MB120192A93BCD5A9E8F3C81A498CC62@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <aprkipjl3lpdn37dlcdv7wx6piepbbqjsd6ljfgpa5pmua2axu@etxjfuahtg3u>
In-Reply-To: <aprkipjl3lpdn37dlcdv7wx6piepbbqjsd6ljfgpa5pmua2axu@etxjfuahtg3u>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DBAPR04MB7365:EE_
x-ms-office365-filtering-correlation-id: e09a3e72-b095-4043-04c3-08dee3abe0ac
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003|38070700021;
x-microsoft-antispam-message-info:
 SlQ3j1yWyVxW1d9lL4LwvmXbMmyJ3tL+cXOp9BposNBKvD4vIuA7tKMJe9fPBaXZaZ59pNGqhLNsVsdqvHdzBPnyHSt3kDkclciVPHwvaNvX24HmMXwVsq49mpWq992XWvAWoX2aRdE8ldJQalF/aalwAphTKVFdc6UDa8sIQ8r50Lw0nCMg3MaSwtWxstFG3AKnFJk/ecaNP4dOEJoSYrAnxTXbUsEGodxc1Gb4enOvzbm7ZkHSQv+U9boycb5QNL9ErfTQTWuM03TOy/KN51dOTJAt5Nb9uTNQ61Og6i+NPs3BzBDgYxe8nJrgqr4wmbYh059jxeG4MjTHNrihqoveVFEOMqo4AfzK/pxsgjfXgjISyqqrhbbkSbRlKK9lJls0KWogxOexw5UKxlhy7oPnHeKGuLWZ+2TbayhXNUXZtHNLFj6VvogcS1lz5c9X1w74tzw1PrcTgTpJa97DCJv/EwQkZQMMaoaAMedvM0SICoZo0Y4Yq2KOIv9vRb1seQNtnxGNNJbRwGQ4KxeK/WBOCXu0sThkP+VGqOFCxzJqbJMkK6VVS5EC7qH12bxrxyZ3CViOfpMOl1AWCj+cE0UBQfgpBB7z/vwlRrTPUqcitItl8kOi6pst8UkFxzIe6jbIE4B9SnZAZ7sOCA9LcIzkLPnf8acmiN0ViicwlIVWPvT0tglo1j4i/YIfgM26sYxT1dDqvQ6Tr7vpk8JO4JLwYsYoFWIIA/xCXKMw28c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmlaWHUwaGhUZE15MGRzYmhpa3RSUU9BT0s1ZlJqbC9jNzluOHhHUWFSc1E3?=
 =?utf-8?B?R1QrQmhhQ28xdWNOalQ1VHBVOTVlMkRNQVE1dW4rTUw3NVpPVFZ4L2prMk1N?=
 =?utf-8?B?WUpCTVF2Z0w4cEhqWTFZNUNwTStWODZaQTl3T0J0ZFZJdHNwbFBkZC9yeEZ3?=
 =?utf-8?B?d3h1VlUzQ05YcDVNYnJPaXk3UWo2VVQwMDQ0YVdPM2p5WWtpdUViYS9uWFJF?=
 =?utf-8?B?R0wweWhteERaL25rdG9aU2ZwS2pUSGtkU2JUU2pMb0lBQVMvcFVCc3dpWCtS?=
 =?utf-8?B?Q1BhaXpqRllsTDJNZGpNcGxuU09oQXVsckc0RktvbzQxNVpYN0dzVVlta2to?=
 =?utf-8?B?RFcxajd0RlRSdSs5UlRiMERuMnA2cjB3MC9nNWl0NEM4bjhqQTFKS1A0TjNG?=
 =?utf-8?B?ZGxLand6MkhKdWEwUkhDaE9HekhabE1Ebk1FZHh4Tm5LYjBlQUgwdXE4NlBS?=
 =?utf-8?B?UmxUVHJmNHlUZlBleVFoaS9KbHBKSkswOTZRZGdoZnJEV0oxZ2s1YTFNdVBk?=
 =?utf-8?B?bmNCSmlrazdaZU5RR2xxZnhkRGovbm9jTy9OaURWTXBucDZaTHdJdy9XUFcy?=
 =?utf-8?B?R1FKeUQycWdUR3Uvbzhsb2MxSGhLSU1JdzcwUWlPaG5HSElOTnFoWlY3NWRm?=
 =?utf-8?B?cjViKzk2a1RBNTAwRFpNTWFycWo4c2h0MWQzMjhxVEhoMWkvOUdacDVqenRh?=
 =?utf-8?B?U3lONTAyeWpyZEllaGNyK3BaSFRBdlZlTDk5Vm5BTnluZ2t4VGtUdERCQysv?=
 =?utf-8?B?USswb0o0QUhJanhlWFlEbTBvUFJqYmlIWVluOGcrMjRSN0R1aHRNSHhiVEpP?=
 =?utf-8?B?MTIxWmpSS3EwZHpMWDdIaWcxYW1WWTg5cVN2RWJIVnlLTUhVNmxGWXhheXRV?=
 =?utf-8?B?K0ZCZllYM1JRaGJoY0VrQzd2aE5KdlphNjhTdzhpQmd2N2Z4dmpXQXNTVXQ0?=
 =?utf-8?B?YWgxOW1IOFdNellnNEt4MVdLWkN6MFEyK2xGS0JkNUE4cnhSTnZCUDJPNDhz?=
 =?utf-8?B?ZXB0TkFOaFd0cUxGL1FlZVlid3k4ZUVJUllDTFlnODBZOTBiZ1hXYWgvbTk2?=
 =?utf-8?B?Sys5OWxiMUt4eDhxRlg4dU1LMmwyYk11UndERmk1eUREcXBtL2huNEozSE1S?=
 =?utf-8?B?SG4wK1RpWk1vMjBGcHFPYUVWbUQrY0l4T09MeFZoZ2tZSnRSMWFQQTd0b3Yy?=
 =?utf-8?B?VU4wUjhGWXJ3M2hzcGFkRWhHUSt5N2VlSFNrdkFVN2lHYU1FL25SWE1WMzRX?=
 =?utf-8?B?TmVkck92MG51QjR5TksvdjdWejFnSHlnV3puNEtQNWcwZWp6Qnl5N2VNeHFP?=
 =?utf-8?B?TXR3THd6elB5RlNMUWIwdlUrbE1TbWI3bGw2SjkwVlZuVEIyRkZvV3J1U25l?=
 =?utf-8?B?NlhBTWhVNlQ3NmIvd09FNm5ScUxUa01qYitmMU1ZbkFEZGM4MHNNUXRkblR0?=
 =?utf-8?B?NWtwTEZqUmxJRmJSbVIxUStPMUZOR1JrWmpHWnJyLzA5dDVXVTdaNDgyVURk?=
 =?utf-8?B?WmlqTVRIYi9hUVRxVlpmTnZJK0VWeW51UlJyRUlpbmVDb0FzcGl0OGNKeEpw?=
 =?utf-8?B?R1FEa2JFdFdQMENUYTFJc1I2a1JaSnd2c2h4QncxVnZ1ZjVQWFlnditNTWxw?=
 =?utf-8?B?amV4SW93T2JXTURuZExEcjlCZDVJODdTeGYvdWFvWUhBZWpOOTlpSW1TYktO?=
 =?utf-8?B?ckN2a1oxVFkrRklqdkE0RG9nbnZzc1F4dWxUNlhCRUQvbGNwUzRaSUtQSmtm?=
 =?utf-8?B?VE1PNGEvTWJJSkE1TmozTTk1cDR4RlVnUmkrSmYxYmtxdTEvOXp0UmF1c0Ez?=
 =?utf-8?B?dVR5YllLM2ZoMHBqYzJKcHE0aDdrSTE4N2V3U0ZBMm8vbjY0eWIzbk9QOHVT?=
 =?utf-8?B?aUpxQVBDczdYRXdzSXRYS05vbHc2eWxaVmVQZ05qTmF6c0VNWDdSdzBVUUJt?=
 =?utf-8?B?Uzh1SU1WeXB3WGdRSE1WRXgwQzJxbGFBZE8rNThTUjE2V24xd2QvS3BRTi9U?=
 =?utf-8?B?dXRlQ2I2V1JJRllGdWorTURiVWpvOUx6S29MTmtZbWhUMGsvd0VFeWVZelVm?=
 =?utf-8?B?UHpzTVlzMkgxdlRPMUhJcXFaR1dlVTdMRVFISnpuSXp1NlF6R3pSMExuV0I2?=
 =?utf-8?B?R213RHJ6ckMyYVNNOVJlLytPSXhKV08rc2pjc0VzR2pka3FLcTQ0Z0NERWxj?=
 =?utf-8?B?eWdDbWJOVGJLTU5YZXZmQmdvYWVsNERBc1oxWnpSZFRYaUZvM0ZnWXFTMkVK?=
 =?utf-8?B?bHArb0ZTRnE4K1RBaGoyVENYbzVNakIxdGk4blBkVElmUGlwVHJwRGhrNzUv?=
 =?utf-8?B?eGV6U3V4QVBSTkUrcXVqZWxvOEFYZ3NYR2wwaUpZMkZCY1ZqWHh0Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e09a3e72-b095-4043-04c3-08dee3abe0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 02:34:08.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye8V71UdpMbg5rMc57ZCVY/QmT50eHNhXg/NqimGKHi+XRDGa0SJxo7GAAPbewAEpTWhpRz5vb8rVzGQDEF5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDE3LCAyMDI2IDEyOjQ0
IEFNDQo+IFRvOiBIb25neGluZyBaaHUgKE9TUykgPGhvbmd4aW5nLnpodUBvc3MubnhwLmNvbT4N
Cj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2Jo
QGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC0NCj4g
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBQQ0k6IGlteDY6IEFkZCBydW50aW1lIFBNIHN1cHBvcnQgZm9yIGkuTVg5NQ0KPiANCj4g
T24gV2VkLCBKdWwgMDgsIDIwMjYgYXQgMTE6NTk6MjZBTSArMDgwMCwgaG9uZ3hpbmcuemh1QG9z
cy5ueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPg0KPiA+IEVuYWJsZSBydW50aW1lIFBNIHN1cHBvcnQgZm9yIGkuTVg5NSBQQ0ll
IFJvb3QgQ29tcGxleCB0byBhbGxvdw0KPiA+IGR5bmFtaWMgcG93ZXIgbWFuYWdlbWVudCB3aGVu
IHRoZSBQQ0llIGxpbmsgaXMgaWRsZS4NCj4gPg0KPiA+IFRoZSBpLk1YOTUgUENJZSBjb250cm9s
bGVyIHN1cHBvcnRzIGVudGVyaW5nIEQzaG90IHN0YXRlIHdoZW4gUENJZQ0KPiA+IGRldmljZXMg
YXJlIG5vdCBhY3RpdmVseSBpbiB1c2UuIFRoaXMgaW1wbGVtZW50YXRpb24gdXNlcw0KPiA+IHBt
X3J1bnRpbWVfbm9fY2FsbGJhY2tzKCkgdG8gbGV2ZXJhZ2UgdGhlIFBDSSBjb3JlJ3MgZ2VuZXJp
YyBydW50aW1lDQo+ID4gUE0gaGFuZGxpbmcuIFRoZSBQQ0kgY29yZSBhdXRvbWF0aWNhbGx5IG1h
bmFnZXMgRC1zdGF0ZSB0cmFuc2l0aW9ucw0KPiA+IGJhc2VkIG9uIHRoZSBydW50aW1lIFBNIHN0
YXRlIG9mIGNvbm5lY3RlZCBlbmRwb2ludCBkZXZpY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gUGxlYXNlIHJlc2Vu
ZCB0aGlzIHBhdGNoIHNlcGFyYXRlbHkuIEN1cnJlbnRseSwgeW91J3ZlIHNlbnQgb3RoZXIgcGF0
Y2hlcyBhcyBhDQo+IHJlcGx5IHRvIHRoaXMgcGF0Y2ggd2hpY2gganVzdCBtZXNzZXMgdXAgdGhl
IG9yZGVyLg0KVGhhbmtzIGZvciBraW5kbHkgcmVtaW5kZXIuDQpJIG5vdGljZWQgdGhhdCBpc3N1
ZSBhbmQgcmVzZW50IHRoZSBwYXRjaCB5ZXN0ZXJkYXkuDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9pbXgvMjAyNjA3MTUwNzMwMjQuMTM3NzIyOC0xLWhvbmd4aW5nLnpodUBvc3MubnhwLmNvbS8N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiAtIE1hbmkNCj4gDQo+ID4gLS0t
DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiBVc2UgZGV2bV9wbV9ydW50aW1lX3NldF9hY3RpdmVf
ZW5hYmxlZCgpIHNpbXBsaWZ5IHRoZSBjb2RlcyBhbmQgZXJyb3INCj4gPiBwYXRoLg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgOSArKysrKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCBlYWU0OTVhMWI3OTkw
Li41Nzg0MTBmMjYyYWVkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ID4gQEAgLTEzMCw2ICsxMzAsNyBAQCBlbnVtIGlteF9wY2llX3ZhcmlhbnRzIHsN
Cj4gPiAgI2RlZmluZSBJTVhfUENJRV9GTEFHX1NLSVBfTDIzX1JFQURZCQlCSVQoMTIpDQo+ID4g
IC8qIFByZXNlcnZlIE1TSSBjYXBhYmlsaXR5IGZvciBwbGF0Zm9ybXMgdGhhdCByZXF1aXJlIGl0
ICovDQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19LRUVQX01TSV9DQVAJCUJJVCgxMykNCj4g
PiArI2RlZmluZSBJTVhfUENJRV9GTEFHX1BNX1JVTlRJTUUJCUJJVCgxNCkNCj4gPg0KPiA+ICAj
ZGVmaW5lIGlteF9jaGVja19mbGFnKHBjaSwgdmFsKQkocGNpLT5kcnZkYXRhLT5mbGFncyAmIHZh
bCkNCj4gPg0KPiA+IEBAIC0xOTczLDYgKzE5NzQsMTMgQEAgc3RhdGljIGludCBpbXhfcGNpZV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJCSAqLw0KPiA+ICAJ
CWlteF9wY2llX2FkZF9sdXRfYnlfcmlkKGlteF9wY2llLCAwKTsNCj4gPiAgCX0gZWxzZSB7DQo+
ID4gKwkJaWYgKGlteF9wY2llLT5kcnZkYXRhLT5mbGFncyAmIElNWF9QQ0lFX0ZMQUdfUE1fUlVO
VElNRSkgew0KPiA+ICsJCQlwbV9ydW50aW1lX25vX2NhbGxiYWNrcyhkZXYpOw0KPiA+ICsJCQly
ZXQgPSBkZXZtX3BtX3J1bnRpbWVfc2V0X2FjdGl2ZV9lbmFibGVkKGRldik7DQo+ID4gKwkJCWlm
IChyZXQgPCAwKQ0KPiA+ICsJCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICAJ
CS8qDQo+ID4gIAkJICogaS5NWCBSQyBpcyBwb3dlcmVkIG9mZiBkdXJpbmcgc3VzcGVuZCwgZm9y
Y2UgTDIgZW50cnkgdG8NCj4gPiAgCQkgKiBlbnN1cmUgcHJvcGVyIGVuZHBvaW50IG5vdGlmaWNh
dGlvbiBiZWZvcmUgcG93ZXIgbG9zcy4NCj4gPiBAQCAtMjEyMSw2ICsyMTI5LDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gPiAgCQkuZmxh
Z3MgPSBJTVhfUENJRV9GTEFHX0hBU19TRVJERVMgfA0KPiA+ICAJCQkgSU1YX1BDSUVfRkxBR19I
QVNfTFVUIHwNCj4gPiAgCQkJIElNWF9QQ0lFX0ZMQUdfOEdUX0VDTl9FUlIwNTE1ODYgfA0KPiA+
ICsJCQkgSU1YX1BDSUVfRkxBR19QTV9SVU5USU1FIHwNCj4gPiAgCQkJIElNWF9QQ0lFX0ZMQUdf
U1VQUE9SVFNfU1VTUEVORCwNCj4gPiAgCQkubHRzc21fb2ZmID0gSU1YOTVfUEUwX0dFTl9DVFJM
XzMsDQo+ID4gIAkJLmx0c3NtX21hc2sgPSBJTVg5NV9QQ0lFX0xUU1NNX0VOLA0KPiA+IC0tDQo+
ID4gMi4zNC4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDg
rprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
