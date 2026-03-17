Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C843563C2;
	Tue, 17 Mar 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738572; cv=fail; b=NcxB3FEKbuzzb+Ke5jbadIB4rIv33Njnd/3C6fd1UW8oCbrm6lldFQ9+2zH9zuEI7ml5+fy1X3YT+TjhLYEcrU/xfbjIieyP0RovzmuT6gXtoOSaSyz/T7kcSSxMQtcX4qzYG1ZAdXuB78Z64jTrdi4wXv75xEWCMWkO9i3Y4T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738572; c=relaxed/simple;
	bh=j7j5mXxWkop+/UPmXqYIwdU2t8Md2YvK0mAP7732jGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3eGIC4FtH6EZtaOuNLlVdQWEPxex7CfqGDN9I1GWE0SPrWnZFfGSMpOLrSLcm8RPCBsvv5x0bF4nxAIFszH7PHOVCo4tclH4JvAVwK/xJ6ms+d8I3PGnM0cZbe3FH2u8cIRBcEFB2XFrjM9jrTO0DxmDBBATosxcg5TyC8V4n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dUf97dUg; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUf97dUg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7VXX7rvFTO8/DpFJqBaQNaymg5mRxFyS3FKPfFDJpGGN3IXkV1cKQ2UjSZGsyVrbKQzVE+qUa05AHkg+U9psaT3o18kpGZ0JYqMyuq6+f3EAMx/Gbcvo6EsrFHvCwQeD3dKlaP8hqJ+i3bCNFRc/HC3uMJVXO3xsSwP1qqSkuIPO9Xt6amsc/8l/uoxbXYkuLlC5NmiztBqzEhZRT0eqpxHz4MZAb4mKhJYzO65KEGAh+jaDilDgg8p0ZegZSsrKccDa3nUQywQb4fwOm+a2zpslFpgk2av2KAxpuw5eiVJ5tll90Rjz3KpaMlDM2/JOHFrrAUWHe1PVvYgeqGokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7j5mXxWkop+/UPmXqYIwdU2t8Md2YvK0mAP7732jGw=;
 b=cGgRxbn9a2Au+yXs+JSVvBUfT8Kb5iPQ3YbiBkv1xESWSSWEg7ru81+kW/2VqzFq0m1dT3aG997PRQgZvc+sKrAZk+QL13JKF5rdcrFFcYpC+CoHRbb4fCKDb70vC3xfbllKlvx/Og0urmFgc2Ft3IAgSDzky37UhGDsN/9ooYcVJS6NPoIW0w43moqstXgmw10rRMB76D7WzA+709erD7bfGgNg8ymX4EpDSRTwV+etU4cPZ51DhoJUILm0DhCpss8OsGbdGdF+YpNdp0XyP3lehEag2cFMvJEZilr2M+o24DL187WV+1VwPWJmnWC5gf2h0VoyytrnmA88nCZ7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7j5mXxWkop+/UPmXqYIwdU2t8Md2YvK0mAP7732jGw=;
 b=dUf97dUgqKjkyqL3F38emwsr1UeGalVsc3U9ouK4hxSj9p/gllyo0M5IdcFuVK5rcW06k3mZzZZZmpJrB3z0wNJFjVKVph0UXUJUXd7diAVtIuaoxgYgAc8sPC+rcM+xGE1hmJvLExUjSuz0AQhAHDcZMbmLvNavrGnlbS8Rp5bmcGcmiTGWODz8EhzwnzEBbtvm+wWUTCQlYFwi/n3Fa/loRz0cPs0uWqpfPkgP9JCpA4bgZMmM/6I9VlbOAS3qTYavjY+NBFcNRn/a/kKttuW2xN7rRL1z8DObPnFPwH4uQx75OgyVnemsf5VDQmkP/seU2ZNKiJkciamFL5cx9w==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VE1PR04MB7376.eurprd04.prod.outlook.com
 (2603:10a6:800:1a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 09:09:25 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 09:09:26 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
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
Subject: RE: [PATCH V8 05/13] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH V8 05/13] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHcso5AqTXRrltoYUyTA5LfBPcrrbWwsFgAgAHF0yA=
Date: Tue, 17 Mar 2026 09:09:26 +0000
Message-ID:
 <VI0PR04MB121148F11CDB5EB4ED89ACA949241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-6-sherry.sun@nxp.com>
 <tot7suhdkydo5er4zjcxkdvfalii7k72kqyw54o5frtoklkxif@l6x6ipaezlmq>
In-Reply-To: <tot7suhdkydo5er4zjcxkdvfalii7k72kqyw54o5frtoklkxif@l6x6ipaezlmq>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VE1PR04MB7376:EE_
x-ms-office365-filtering-correlation-id: 40ccfe31-3814-40a0-27a8-08de8404e348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 oarCebov10ux+3Pr4tLXODpp+AJCmDj8XCpATuxDon2IVUjXDkYMyg4PI6U9ye/6qvEcZr90QUTqc7poHAuK8G90uAxtjR8MY2EdRbKgv32Z7KBiHpFO+EowIwBtnBf5spD4ApT4oULq7DSYRNa5f0sik+N9Lo3ED9L0KcWhMTYQgjzGraNzrRZ/aOX839ApuzpOp+WT+hxX41/TrkfIGGAY55dTDHrsKTjgQDJp8RYTpy0DYuBCkiz1/vnfRiQztBSLVUZeF18qszZdsWts27L+QZVJvxtaYLmMXqaXdlJCqP2uSQ/XHursE+FoxNSaZqjE8gw/DCKF0gLU27PjJKSaumU9j/gWgTS+rJqXDIAxNAiz0F4vIAxbJ872eCU6di9ZtBu3SdcgTHQ5ZeNh/MvxEcPOOTLkj/xhuiOsmBeF5RfwZft+Gr+PD2KLW38XvjTH+gwtlGn52q56UtQ2x9zweeYchh/zjCA4E9naMjfqChp0NhhMXaxxndP/gIinQMdqYPnHwXfhNvW1VH8ubwlosokL4wsjzyzemlUOXLMxZ6PsNbYddrOcvwCEzRRK78lUlERA+fXOsferQQMfzfKG4YwfABoSrPn6ueeEKhXeNqUbIgEPEvyA49Upnf77einjRfJqLNi8Mf7StATIrUAJGTSexwbx9/ADXImuoL5Xn7YXHp3KvzkxEpQp/wcwrDWCH3M4wSsJWldfLbdFpcLESLcev/uh2ys2sVdTJNnQiuWhslhX5T6mPb6+F5QUM+n10z6j+7RI3tAfGZmtUZLwow3jYlduUo9K0aKvbRs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YU5iZWZFZU5OV3RyWGpNSHY0a2ZnQWdUeU5qa1pleEdMVE96RnZEV2Y1U0I2?=
 =?utf-8?B?U2FETzFydXRkZDlyZFY3aUxINmJCWEtNRXMzcVRTWHVuM2lScjZaa091d1ZS?=
 =?utf-8?B?TVM3dzM1eXZKUnUyQ2NSdW1lQ01VU1JLenJlSzRjM1E2TkQ4TUZseVlCOUY1?=
 =?utf-8?B?SzN2NW1sbE8yMk5TWTBlbkcrdk5jRWpDazFxTHc5YlJrNERZOFJXTGdtQ2xy?=
 =?utf-8?B?UEtkTFgxVzlZNDhFWHZaT2xrTXdCbWEzMzQzR0VzZXU5RzNkQVRJd3F1L3l3?=
 =?utf-8?B?TWxPTWlyWkkwSlFXRjIxMVB2K2V6UFlWQTRTVHMzMzZ5MGZWUFFIK0dLakJa?=
 =?utf-8?B?Q2szTnk1QTR1UDZZRWIzNnhUenQ0Nmx3N0tqM3dEZUFBeHh1R3g4aWUwazBr?=
 =?utf-8?B?MFJMY1lUUjN3a2V3WFB5YnQvT0M0ckdYRnd6SnZKcURSZk1LNVNpOWpNeVF5?=
 =?utf-8?B?U0pGVnpXMElwRmxQREZHZ1RybnJkMHZtemlLSk1EaFVCRHRyek1ROHhac3pK?=
 =?utf-8?B?OU52WUoyL2dEWHhOb09OaXNMc05DaVlZL1ozT0loejhkeEx1dUlSVHRhTUlP?=
 =?utf-8?B?WXRKNmdwcWxlcFh4ZjJ4RU9GcVpCN0F3Vm0vRTVBTlliVWtzN3BuS3NETGZq?=
 =?utf-8?B?TCt2b0M5VUFoRnZKeWx4ZlAvNnErNzFYT0hBT3htaCtOcEFPMXU5Sy9Deldk?=
 =?utf-8?B?eTRCSkR1L0xCWStlR0ZZSGZoeENPUlFxSmVJYW41djJPTzZsRWFUVDEybk5r?=
 =?utf-8?B?dzE3OEJGSHpEbm9KYWhJOERQQ2dhL25wa3M4ZE5WWUMzVnFGZzVPNjREZU5p?=
 =?utf-8?B?SDZvcCtTOTl6MnRFc1ZPUXNGUVJuUW5DWGZFcUgwYTZneHZ4ZmI1aERRZUt1?=
 =?utf-8?B?dG9zaW52dG00aUpZRkJCc3JXSStkMDVaaHdFTzF0MjZYS2orSWJlQVhpamNp?=
 =?utf-8?B?c0RsekRQcVhaRUYyNTh0MGcwM2tuRG1BL1FpcFZCMnlVaWwwV3NhK1lSMVVP?=
 =?utf-8?B?NElPWllOeTJYSVJWVHR0RnJCTUFqWThnVUhYaE45cTNFT29CbW9tb3YrUG5l?=
 =?utf-8?B?K3UvMDJ4SFZXVjBhbXVZdHVOemtIdFprRi85VXNaVkwwMVdNcU54QmZnSE5U?=
 =?utf-8?B?OFNUTjFqTitVeGlmNndBTnd5SzNnUWZsSjNVQTBWblVsU3NLZklYUnEyR1ZW?=
 =?utf-8?B?WS9YaVBPMU5MSzJ4RmdOd1NLZnlKcGNWNmR0bUE1MklCRStuTkgyQVpGMmN4?=
 =?utf-8?B?UEtLV3dKZ3g4Myt5SDNDSktnRVoxWHJWWlZJalZVNXN3TmRrLzkyaE94QjhZ?=
 =?utf-8?B?UmIxWjYrMjFhck9rRlA5ZzZtRDkveUM4SGxEUmdZOGpwSGFIQnp1d2FxR1k5?=
 =?utf-8?B?d2RmMXNnM0RwYW9WMDFHMVpoU1Yrb29ZU0l5d3hvVndWTzd6QXBSQTRqcmZa?=
 =?utf-8?B?dmhWbDdZYzRBZzRKZTZ0d211RGhlTlhyV2tMdEFPb2dPeHJxaWhLdTZCaGRE?=
 =?utf-8?B?MlIyV3J5TEsxVWdkV0lmRmI4V1VySzBsWlRlY0wyNEkxV0dQakJsRW9ESGFa?=
 =?utf-8?B?bTNUQm1CbU5nUXZlTDl3ekEwL1RYdi90TW1vOFMvM2wrUkc4aWt5cWMweDBG?=
 =?utf-8?B?eXdtTnNIaXpMbWhzN2R2OFYyQ1RENFFZaXNNQllMRWNleFd2R3ZLeE1OVERF?=
 =?utf-8?B?NGcwODR1Y0puTmFzQlFBS3NPQ2NyUk5qcmhXY3EyZDdkbzloSXdSZkJvazJW?=
 =?utf-8?B?RDEzRDRBUWZXQVMzcHYwalNuNjROU3ZxWTllcjFDQnRad1hXVnFTeEZMcFNM?=
 =?utf-8?B?VHJzZUxXQ1RVWHNnekVkZkFFRG8vOUNFeFRma2k4eUFIOXJVdEdwSmo5TkFF?=
 =?utf-8?B?OVZqaC8zMWFKb1E3MitCekR6eHovcjhiL3RQWDZHQnVXMHUxTnpHQUc2VVlj?=
 =?utf-8?B?dytXbXJiWXJoUGZaNjBmVmJ2dW5iaGxZT2JSMVgzamthS1VBWVlKYXI0VC9T?=
 =?utf-8?B?VjZGd3F2d21KTFJWcUx2MmkzZjlhQ0J4b0ZvMGpBR2FsRVV6UWhFVktsN1Nm?=
 =?utf-8?B?SzBIMUNqdm1DTTdSVWVEenZuRjNtWnYrRmZQTTExcVhBc0EwamYyYTRJYXMy?=
 =?utf-8?B?djdtOHlxQWJ0UTBOMWNWamI5TTRTZXpicVh5cExvSDdPVlBQV3o0U1ZXa0ND?=
 =?utf-8?B?NkJiWlhHdFVKREpFMzE3dFZlRzJCYVdIQ0Q0am9rbjR0MDNHb0doYmp3Ylpi?=
 =?utf-8?B?eDBXaVJNL0lNUkFTcVFabkYyUWxnUlg5eG51Nll2QlBGL2FJOEZrQkN4Nm5C?=
 =?utf-8?Q?mxG+s8ufQnGPGP++ld?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ccfe31-3814-40a0-27a8-08de8404e348
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:09:26.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IQ6H8DAFJypHtEfAJfORgGcDOj5/Ac0Lh1s5WgVZDGfFy0Nti1Uj7rzD7u8M1ndFguMY4THug36UfWZes7ZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376

PiBPbiBGcmksIE1hciAxMywgMjAyNiBhdCAxMDowODoxNUFNICswODAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+IFRoZSBjdXJyZW50IERUIGJpbmRpbmcgZm9yIHBjaS1pbXg2IHNwZWNpZmllcyB0
aGUgJ3Jlc2V0LWdwaW9zJw0KPiA+IHByb3BlcnR5IGluIHRoZSBob3N0IGJyaWRnZSBub2RlLiBI
b3dldmVyLCB0aGUgUEVSU1QjIHNpZ25hbCBsb2dpY2FsbHkNCj4gPiBiZWxvbmdzIHRvIGluZGl2
aWR1YWwgUm9vdCBQb3J0cyByYXRoZXIgdGhhbiB0aGUgaG9zdCBicmlkZ2UgaXRzZWxmLg0KPiA+
IFRoaXMgYmVjb21lcyBpbXBvcnRhbnQgd2hlbiBzdXBwb3J0aW5nIFBDSWUgS2V5RSBjb25uZWN0
b3IgYW5kIFBDSQ0KPiA+IHBvd2VyIGNvbnRyb2wgZnJhbWV3b3JrIGZvciBwY2ktaW14NiBkcml2
ZXIsIHdoaWNoIHJlcXVpcmVzIHByb3BlcnRpZXMNCj4gPiB0byBiZSBzcGVjaWZpZWQgaW4gUm9v
dCBQb3J0IG5vZGVzLg0KPiA+DQo+ID4gV2l0aCB0aGUgY29tbW9uIFJvb3QgUG9ydCBwYXJzaW5n
IG5vdyBoYW5kbGVkIGluIGR3X3BjaWVfaG9zdF9pbml0KCksDQo+ID4gdXBkYXRlIHRoZSByZXNl
dCBHUElPIGhhbmRsaW5nIHRvIHVzZSB0aGUgcGFyc2VkIHBvcnQgbGlzdCBmcm9tDQo+ID4gYnJp
ZGdlLT5wb3J0cy4gVG8gbWFpbnRhaW4gRFQgYmFja3dhcmRzIGNvbXBhdGliaWxpdHksIGZhbGxi
YWNrIHRvIHRoZQ0KPiA+IGxlZ2FjeSBtZXRob2Qgb2YgcGFyc2luZyB0aGUgaG9zdCBicmlkZ2Ug
bm9kZSBpZiB0aGUgcmVzZXQgcHJvcGVydHkgaXMNCj4gPiBub3QgcHJlc2VudCBpbiB0aGUgUm9v
dCBQb3J0IG5vZGUgKGluZGljYXRlZCBieSBhbiBlbXB0eSBwb3J0cyBsaXN0KS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDc0DQo+ID4gKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1OSBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggODNiZWNhNWExZmMyLi5jYjE4ZTE1Nzk3ODggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtMzQs
NiArMzQsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+DQo+ID4g
ICNpbmNsdWRlICIuLi8uLi9wY2kuaCINCj4gPiArI2luY2x1ZGUgIi4uL3BjaS1ob3N0LWNvbW1v
bi5oIg0KPiA+ICAjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+ID4NCj4gPiAgI2RlZmlu
ZSBJTVg4TVFfR1BSX1BDSUVfUkVGX1VTRV9QQUQJCUJJVCg5KQ0KPiA+IEBAIC0xNTAsNyArMTUx
LDYgQEAgc3RydWN0IGlteF9sdXRfZGF0YSB7DQo+ID4NCj4gPiAgc3RydWN0IGlteF9wY2llIHsN
Cj4gPiAgCXN0cnVjdCBkd19wY2llCQkqcGNpOw0KPiA+IC0Jc3RydWN0IGdwaW9fZGVzYwkqcmVz
ZXRfZ3Bpb2Q7DQo+ID4gIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YQkqY2xrczsNCj4gPiAgCWludAkJ
CW51bV9jbGtzOw0KPiA+ICAJYm9vbAkJCXN1cHBvcnRzX2Nsa3JlcTsNCj4gPiBAQCAtMTIyMiw2
ICsxMjIyLDQ0IEBAIHN0YXRpYyB2b2lkIGlteF9wY2llX2Rpc2FibGVfZGV2aWNlKHN0cnVjdA0K
PiBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZSwNCj4gPiAgCWlteF9wY2llX3JlbW92ZV9sdXQoaW14
X3BjaWUsIHBjaV9kZXZfaWQocGRldikpOyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgaW14X3Bj
aWVfcGFyc2VfbGVnYWN5X2JpbmRpbmcoc3RydWN0IGlteF9wY2llICpwY2llKSB7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5wY2ktPmRldjsNCj4gPiArCXN0cnVjdCBwY2lfaG9z
dF9icmlkZ2UgKmJyaWRnZSA9IHBjaWUtPnBjaS0+cHAuYnJpZGdlOw0KPiA+ICsJc3RydWN0IHBj
aV9ob3N0X3BvcnQgKnBvcnQ7DQo+ID4gKwlzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldDsNCj4gPiAr
DQo+ID4gKwlpZiAoIWJyaWRnZSkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiQnJpZGdlIG5vdCBh
bGxvY2F0ZWQgeWV0XG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwkvKg0KPiA+ICsJICogRm9yIERUIGJhY2t3YXJkIGNvbXBhdGliaWxpdHk6IGlmIG5v
IFJvb3QgUG9ydCBub2RlcyB3ZXJlIHBhcnNlZA0KPiA+ICsJICogKGluZGljYXRlZCBieSBlbXB0
eSBwb3J0cyBsaXN0KSwgcGFyc2UgcmVzZXQtZ3Bpb3MgZnJvbSB0aGUgaG9zdA0KPiA+ICsJICog
YnJpZGdlIG5vZGUuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghbGlzdF9lbXB0eSgmYnJpZGdlLT5w
b3J0cykpDQo+IA0KPiBZb3Ugc2hvdWxkIG1vdmUgdGhpcyBjaGVjayBhbmQgdGhlIGNvbW1lbnQg
dG8gaW14X3BjaWVfaG9zdF9pbml0KCkgYW5kIGNhbGwNCj4gaW14X3BjaWVfcGFyc2VfbGVnYWN5
X2JpbmRpbmcoKSBjb25kaXRpb25hbGx5IHRvIG1ha2UgaXQgY2xlYXIgdGhhdCB0aGlzIGlzIGEN
Cj4gZmFsbGJhY2suDQo+IA0KDQpPaywgdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgd2lsbCBk
byB0aGlzIGluIFY5Lg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo+IC0gTWFuaQ0KPiANCj4g
LS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCv
jQ0K
