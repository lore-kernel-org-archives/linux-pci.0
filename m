Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C13161AD;
	Tue, 17 Mar 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738301; cv=fail; b=NijkzdTigxrT5j5QvZxEQgUvgqtErskO2xPL8Dn2P4cD+aN2sl1olQYhr7FTykVmv2ObelLwCFcO4JY2T+PNw/6kj1RxeHY6bOvUVxLtLf+IRW8bTF6yViOp/8P/ZE1AvJgy7byLKEGJbvYZ4ClxGsQ4bS13HwI9tgQg6YO3z5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738301; c=relaxed/simple;
	bh=kqiqc2c28wMLL9bVJYjeamTMoC4zrJ6RR/mnYbO+bJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbcolshRq78X9oEXQxZ213HIzXABs1W4r7VbjvAynFGemoU4PNjT0tC0UzFa7RIom8QlLIAGdB6wyXzGpmUtjhxbx0qGIvU+/1bGIa8Wwi5XJWgDENiPN3Mx3B1BmuDx/WVuGEUse/X9XR8QEJHDO8erGbu1BlalT+7p4yT5k+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R8Z+uKNI; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R8Z+uKNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1QC4MWPGbhyrt5cIBcQNHUOJZ1+vRzhV7o/g2Dxzuw+thuJGXSCCWEq32F45Wxc0JPYhbClucf9p5j8RD+o0b87NPXiLtGuxQD9HZKDqnXWya/5FLUi5Lhtl9xSWsOsErZQtKjk5uWY2bfni83GaQCq8eb+VMzeX8Eo8BDii3Gdij/JlrYfzskaURNtcsk+oCrKsBgyy/qHZoxMysunNF8hbFrgXQ4SF3QCQedq9gz3AXNB6FJIC+LWpQQEfjkZAp0hhzgi4DJXqU6gklDNip5RrfQ2L9t88nlGQmurBU949qbQO+evqR1RIGZ/p5wEsxc8IYa3LjG2u5ohiOYjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqiqc2c28wMLL9bVJYjeamTMoC4zrJ6RR/mnYbO+bJ4=;
 b=r9r/sSSZaPtehijAp6BwvP1BjfRXLbnDEosmCVm6xwp2os5LY0Fe+5EGim8NWc3/MghRJ2Bm2qlSd3andk+fMAKgS1kHHpi9KfyIXayQlxVYqzhui/pn4DvvIt5L4P6rQLUTFS6ZLdVuSDqnarvtM7Pb9K7UZnA2sXNWv+7JRYQmjs5Mzo0GZv/rESrnPARnqPtXIiLEAMzVpl9pZzTvOJvn1HtK8BorsNeE6c0eD+GjovERPAGNG3vlkcV/02EtyHERjEdaFBGWJv1zy3BRB3YTZ0jdJdesB14dxxAd4iH6mDO2FeonIUGFLSvRuDTxsFBRI+Rzg5NkKIQXSHBupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqiqc2c28wMLL9bVJYjeamTMoC4zrJ6RR/mnYbO+bJ4=;
 b=R8Z+uKNI7O9gM8KzBvgokiSxgbPgAjQh3Bn4P4q71gDgIwoWb9eo7lK/hdFetzanauqK37xjHwYEFXnkpFSz0tc8vpXcg3UryQZ4GG1XG+DtuaJvg0L70KAPtk6tUJPl713Uj8mOuSJHz7PR+4prNFQgdfJpk6hGAZYRPfsvByMFrnXXJr9lvcDFDDeQQkZoGYJO2otMpQcsvJ1gInF19lCSct/+TZKQHoWTYmOkH65ICyROMY6Ccklm+JaFQXKCt4d/TaTnICLCfgZG6DKC8STn3SUIbRtS0vnSJp5W+X2N9nbEbkZQPZf2zJ5AOucstvwiEB4B9IvWSDwx1pVOTg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10540.eurprd04.prod.outlook.com
 (2603:10a6:150:218::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:04:53 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 09:04:52 +0000
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
Subject: RE: [PATCH V8 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Thread-Topic: [PATCH V8 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Thread-Index: AQHcso45PYR8tzC3U0K8mpeup+TLXLWwrj+AgAG7/wA=
Date: Tue, 17 Mar 2026 09:04:51 +0000
Message-ID:
 <VI0PR04MB12114EC2939CCC6D0696685B49241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-4-sherry.sun@nxp.com>
 <ay67y5hr7sn5zzugb4swkujao3bvz3puaee4bc6qqr67eyk74t@equoecxosaen>
In-Reply-To: <ay67y5hr7sn5zzugb4swkujao3bvz3puaee4bc6qqr67eyk74t@equoecxosaen>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GVXPR04MB10540:EE_
x-ms-office365-filtering-correlation-id: 1d97c950-335a-4c08-0073-08de84043fed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 qa8jFd7x2CJV++bEe3ptZvC6aZrSDL2vX20HJubLacG9tTstR/qsAO/1gtSQ7GxrfQfLjfsCQkg7tUEFjF6V0qHNpeADcsiVaspV+KHcQXqv37zas1othqUvn9B0us6YPx/RsSoVegOyzdgVRp82CFPpqt9gfKoe/RJQ2GUBE+M8aLSqYy6tot9cDpK8Y8D+xHbHsCT7VApTfA6X5a+oT6os3s5mr1706qvZFBxF2tadOKX173hgP8YhEmrzn9oM1IDzo0Y2Y+pUNd59F03V03Y+LxO5v2eWkdx4w7pj4hVVEaELYsaxCllkqwkFVmvwj0acg9Ckn5nrzOtZs6w27F/5WOE994spdN6FB7HfjqtOEy5bLbczfi0/dJW15CGNWg6+wYZwDVlUSP38yrpctpaK4r2ptjmhyGZl3OqQdWfskz9EB9A9k+l5EYFnAqBk380ionyi/Gs69q16Ps5/pTtmRtaBJcC5hE/wFxZq08tXDzg197FvPJR/dA5KynVuYbVSJDZoFHcqw9Aq/oJW8N1hS/wLk4wIUU+7+QZJABtZWgDqvsl16J+YxoXIc2TutgWy/P//LbrM5+FVzzMV/KsuAsR/wfjnU+B5ltsoRirSrVDl9Cs7CAMttqTVOYi811ml2Z02lOa7bqfKVpcgagN9h6Kq55LvJ7PO0M2WZDSYXz8L1D5yYGAM+64MO25W/e+ZzqdUtu4D1Bpz1fztk9Wwq0xSh7d0V5fhlStT7JDStPFVC/S5Vcvrn1iNLkzpe4/f29KHNsl8mhSiKHCk59U6oSLUY06qWpI6vFGDZjE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkNuNE9vbzVVYWRBR045R3A2cVdDeG85MVZGUHR2VGNGSC9HM3ZRSDlMUnIv?=
 =?utf-8?B?Sk1aR3REdVErT2psS294dThJQlhEemFHNU1ZYnNqWUpyVjV6WlJ1dGpTYlBs?=
 =?utf-8?B?TlJQQVBDSnMwaXdPb0pqcHVCRmJRUXY4QS9JemkrRU4yeEhBMkhHdGROMnRh?=
 =?utf-8?B?MmsraUpxeDcreVdsa1JlcWxyVkQxNlZBRUtDMzNRSmtuTVdzbFd0amw0aDVs?=
 =?utf-8?B?a3AvRHNVRm91ZHVvMG1rWktycWxvWTMxV1JnM2xMeFV0RjZmRWNtV0FaT2o0?=
 =?utf-8?B?eWNMdVlwWGVrVlNSWUE5SkE0RGlXTTdpcWRiUHZJQStlbkticmgzUVV4SzNZ?=
 =?utf-8?B?QWQ1VkY0eEl2ZC96b0VNV21uZWZBbVBMamtxYk1uOCszeHNtZHNZN3MxTTA2?=
 =?utf-8?B?amVMY2tXU3BNYVZibnhKbUkwd3M3emRzSTFSdVc4aDhZTDNxc21iRWliZjUw?=
 =?utf-8?B?aHAzbmJ5aGJwU2R0d01Id1ZnSTRuUGNtWTV3a1dYVmllWmtvNC9OeUdqMzMw?=
 =?utf-8?B?c2RhVHI3YVc5NCtIeFMrdWZ4c1R1KzVBQ2E3QjA2SUM3YXVSVGlPc28rYnhU?=
 =?utf-8?B?d1NqblhZVWp0STFrU2pENzVROG1FMHArSUZ4Mk5HTk44bTRRZytIdW1sZG9Q?=
 =?utf-8?B?Z2V1cGR3cW1GeVVENW8zcTBnRVZWYURmcmg2Ukhlb1ZvU2JTaFZpRW1hN1dU?=
 =?utf-8?B?V2tEWDhVQ3pqMXRiRGpleDgzUmJUVXEzd2dPTTFaakorRHdDVEwxMVRpbnRz?=
 =?utf-8?B?Q3hKOWhEdUlLdnMzRmQ3NkFHMjRIR0dzcUIzcnVOcEZIZ0FxMmFEeklkWitZ?=
 =?utf-8?B?YVZWbjFyWU8wdzdQTXVEN1pQM0FFOEYrTVhIRk4yc2RwbG5OZUVqUVJaak05?=
 =?utf-8?B?SFp0SUZwQUIwKzY0TUU3OTRWY0l0MzBsVDNuU3dpTVJRa200d05Ga092dU1G?=
 =?utf-8?B?dWZxT2lGTnFxTkZDRFRLaHVmVGpoOXhvRU9oME4vQ1prUVpxRkVRZ2JheUc0?=
 =?utf-8?B?cU02eUUrZXVCZXlDMTVRbCtJY2ZYejdySHNWTjF5ZTJlMXRueU5wY3plZWZL?=
 =?utf-8?B?bUUxbUF5blFQOURMRnZVWlJNOTl4R2N0dTAvc2lyUlNnU1ErTW1vRWprNnEr?=
 =?utf-8?B?ZlA2aTJnY0twSlF1Q2xSTnc0VWVnRmpBWFRxakpvKzhrU0JhWU16QXdDZ1B2?=
 =?utf-8?B?ZGtLcmRGa0JYS2RpV3VhM01UeWwvejU5MFFFSGdaTHByL1BCeXUxNEZBTlZK?=
 =?utf-8?B?UVRueDVXWDg3U2g0Q084YzJLMnVKeTRuQmZEUkFEMDlyYlZCTTN3cHBqVXpl?=
 =?utf-8?B?MkZ1SGRIUGdqYzNhdS9pdDl6ckZFa09xOGFOK1lhVlgrRXVNVHdLTjltT1BF?=
 =?utf-8?B?Q09tQWlmeVFqSlBCMnFZdXQrUTAyblAwWEM0MW1rTDEvWGhFekhPOEFicW5z?=
 =?utf-8?B?REt3U1ZXdUU0MVAzL3BLazNqUElkTmNoZHpkaDdNaElpR1FVUFA1amRaVkFp?=
 =?utf-8?B?YmtnSGVNREl5NDNzOWh6SjdaeVUzeHkvQnBKVEFQTjNUdXRyZjYwbTQ5VnZi?=
 =?utf-8?B?ZlpTc0NOL3NzdUZLYWZ3SnpEd3FpakpKUG1vOUoxeVBLSFNwcDFtMm9wRSsx?=
 =?utf-8?B?UElXZUVHOUo5NzhBbUJQYWI2aDl4ZW8xL3hzZzh3U3ZURTQ4c1ArNlpyTTZv?=
 =?utf-8?B?NGV4cmRCaHdaVDNTZzdobmtValNMbmpGajVZdkQzd3BSV3BIY05JWklzMkph?=
 =?utf-8?B?M0pxcXREMFlYWmJ3Z09DWHdsL0JvQmx0V1lCVmJWbmVtaVBQamc4WnJJK1Uv?=
 =?utf-8?B?UnhyQW5JUjhlcmIxaFM2T1ZLajJMWDQzWWkvKytVcjVqbjdXNHBPSjQ1Nmw1?=
 =?utf-8?B?aGxLZW45aTV3L0k2SUpyRml2KzVlUitmcGdwVjZnY0p5REx1SVVzKzh1dk9a?=
 =?utf-8?B?U2pObGxBYmdqdkx3cUFocWdXTDR2T2FWcFBiRHVnY21LUG5Ja25pTFVtSC9N?=
 =?utf-8?B?bVZtcmVXbmJGa2h2Q0VvOUdDS2x2b1dzU29jL1dvblZpNWhHVllQeTMxVms3?=
 =?utf-8?B?YmNjcWxGYWVOUmdkRnQraHB4VlF0SUtxWUVkdmI5THJ4L2w4OEovb25pNCs2?=
 =?utf-8?B?NytVc1VneHhtMExqaDNIVlVsVlRIRjlXWnYxQjQvenM0ekY0andod21pTVY3?=
 =?utf-8?B?bzlEMmdHOVFob0JSTFkveGVuOEJWa283NUFkdjhHUldsbGNCSkw4WC9OTTMy?=
 =?utf-8?B?N241M1ZQS0lvYm0wNXdNdHhTU1NLL2FYUVVwSndyRzRXNE9LNDZyd3U4UTJr?=
 =?utf-8?Q?mOWoxrZNokofiQTH98?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d97c950-335a-4c08-0073-08de84043fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:04:51.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdVjb7x1bZn6g/8RxFt/f4+n6xQ/yw7rk8GlegBk0N8gIlTp9Ut34mFuqidzbhXhemGs96OvS+ZK6zfoQTVjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY4IDAzLzEzXSBQQ0k6IGR3YzogUGFyc2UgUm9vdCBQb3J0
IG5vZGVzIGluDQo+IGR3X3BjaWVfaG9zdF9pbml0KCkNCj4gDQo+IE9uIEZyaSwgTWFyIDEzLCAy
MDI2IGF0IDEwOjA4OjEzQU0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gQWRkIHN1cHBv
cnQgZm9yIHBhcnNpbmcgUm9vdCBQb3J0IGNoaWxkIG5vZGVzIGluIGR3X3BjaWVfaG9zdF9pbml0
KCkNCj4gPiB1c2luZyBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydHMoKS4gVGhpcyBhbGxvd3Mg
RFdDLWJhc2VkIGRyaXZlcnMgdG8NCj4gPiBzcGVjaWZ5IFJvb3QgUG9ydCBwcm9wZXJ0aWVzIChs
aWtlIHJlc2V0IEdQSU9zKSBpbiBpbmRpdmlkdWFsIFJvb3QNCj4gPiBQb3J0IG5vZGVzIHJhdGhl
ciB0aGFuIGluIHRoZSBob3N0IGJyaWRnZSBub2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgOCArKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGlu
ZGV4IGE3NDMzOTk4MmMyNC4uOTYwOGY5ZmNkMWIzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTIw
LDYgKzIwLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+
DQo+ID4gICNpbmNsdWRlICIuLi8uLi9wY2kuaCINCj4gPiArI2luY2x1ZGUgIi4uL3BjaS1ob3N0
LWNvbW1vbi5oIg0KPiA+ICAjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+ID4NCj4gPiAg
c3RhdGljIHN0cnVjdCBwY2lfb3BzIGR3X3BjaWVfb3BzOw0KPiA+IEBAIC01ODEsNiArNTgyLDEz
IEBAIGludCBkd19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApDQo+ID4NCj4g
PiAgCXBwLT5icmlkZ2UgPSBicmlkZ2U7DQo+ID4NCj4gPiArCS8qIFBhcnNlIFJvb3QgUG9ydCBu
b2RlcyBpZiBwcmVzZW50ICovDQo+ID4gKwlyZXQgPSBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9y
dHMoZGV2LCBicmlkZ2UpOw0KPiA+ICsJaWYgKHJldCAmJiByZXQgIT0gLUVOT0VOVCkgew0KPiAN
Cj4gSXMgdGhlcmUgYW4gaW5jZW50aXZlIGluIHRoZSAtRU5PRU5UIGVycm9yIGNvZGU/IFNob3Vs
ZCB0aGUgQVBJIGp1c3QgcmV0dXJuIDANCj4gaWYgbm8gcG9ydHMgYXJlIGZvdW5kPw0KPiANCg0K
SGkgTWFuaSwNCg0KU2luY2UgZGV2bV9md25vZGVfZ3Bpb2RfZ2V0KCkgaXMgY2FsbGVkIHdpdGhp
biBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydHMoKSwNCmRldm1fZndub2RlX2dwaW9kX2dldCgp
IHdpbGwgcmV0dXJuIC1FTk9FTlQgaWYgbm8gR1BJTyBmb3VuZC4gVGhhdCBtZWFucyB3ZQ0KbmVl
ZCB0byBjaGVjayBhbmQgaGFuZGxlIHRoZSAtRU5PRU5UIGVycm9yIGFueXdheSwgd2UgY2FuIGVp
dGhlciBoYW5kbGUgaXQgaW50ZXJuYWxseQ0KaW4gcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnRz
KCkgb3IgaW4gdGhlIHVwcGVyIGNhbGxlci4gDQoNCklmIHdlIGhpZGUgLUVOT0VOVCBpbnNpZGUg
cGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnRzKCkgYW5kIGFsd2F5cyByZXR1cm4gMCwgd2UNCmxv
c2UgdGhpcyBkaXN0aW5jdGlvbiwgdGhlIGNhbGxlciBjYW4gbm8gbG9uZ2VyIHRlbGwgdGhlIGRp
ZmZlcmVuY2UgYmV0d2VlbiAibm90IGZvdW5kIiBhbmQNCiJmb3VuZCBhbmQgcGFyc2VkIHN1Y2Nl
c3NmdWxseSIuIFRoaXMgbWlnaHQgYmUgdXNlZnVsIHRoYXQgZGlmZmVyZW50IGNhbGxlcnMgbWln
aHQgd2FudCB0bw0KaGFuZGxlIGRpZmZlcmVudGx5Lg0KDQpUaGUgY3VycmVudCBwYXR0ZXJuIGlz
IGFsc28gY29uc2lzdGVudCB3aXRoIHNvbWUgb3RoZXIgb3B0aW9uYWwgcmVzb3VyY2UgQVBJcyBp
biB0aGUNCmtlcm5lbCAoZS5nLiwgZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKCkpLCB3aGVy
ZSAtRU5PRU5UIGlzIHJldHVybmVkIGFuZCB0aGUgY2FsbGVyDQpkZWNpZGVzIGhvdyB0byBoYW5k
bGUgaXQuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
