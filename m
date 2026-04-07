Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154739B49C;
	Tue,  7 Apr 2026 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553544; cv=fail; b=jrU7c1nGQTCIuvmh5D8Vr784Sn4BRk/HB3wPOi7GzV81dmRfqGYnL9q7U3OIEHFXtPHlFl7q2qAw+OEAY98d3XpF5io9Vl4rHMSafgZEfMjZupO4aYvRnumESlXLtt2UxU0rWIc+f4W4rAM9c+lVdkhnLbEDiS6qRHcf6fO9u3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553544; c=relaxed/simple;
	bh=5cnCHuHGibpfu0GmV+YVRQDsrDoSiMArkVz6mGbYOuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aBTqTFrket+ZtrxTlnnXG+rY91fmS17go5FxIPSYlS1eUFuDFNSJrBFf17qzeO1+SDM1tTjfg4EaibOcvAM0QEz9UQiBqXMpjRWE0AC1Y8oae0G1LoJmCaIv+J9COmNZl0XebUlw1SfZiakchb3jivNA/pGS6ZuokDwNprOmMdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CLjoJq1n; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLjoJq1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLNdtOzPxjxLerJQNygTOkjGf6And4rqL1IPZPKsyvoKGDBoXFZWMhG7ltR+UDzlMYjaxiSQq6QpoIuJEo80jeKegiTfXEjBJxVrC3vAAOWhq6040FNl0BqQFtie6R9byR92JS+66FalmVc3QxEhysRdT9i5sV9/JA5tINhUGMM+6fPVe5dLA4gKgz68c6DK+X6Ht68dwP1Lw5CARj9kzXvVIIxXWFdK5/m3oHZLQcMCL4Zn02MneYgwnOETNrrlD79wmRbZTK0Yl3bWFMGQ07Fn6Evtb8/lOdePODNPJ+iPkvFTXEoWwJwbAceL56fNKvGGHzP3K5f8b+tl4V6Uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cnCHuHGibpfu0GmV+YVRQDsrDoSiMArkVz6mGbYOuE=;
 b=d7izg+sCOnEvztVgZCwN/Mmb2tb/Muthky53q6bhJD8mmkqNcbYoFN0ma2T+KtGU8cdZZXmRMb27RcuTZuQwTuaNIHJI8khvAF/U9nRnxy8Xhicj158jwcsLaJnEViJEP1XAYNEurNRNUe02TSwTEuglPEzM96+DXkXjK7QCF5ykxE02UVQ/LORuSkhdZwJ1ZxOJVnu1mQg12ssQzskwTqUK+zCF+9VI8szki6b4XaRPWygicJW/5NqJ3J7Lkkv3HKZVxeqDV4/Yvvfvu9vpjiaNNFh2WdpHQKqsz1IJLuJv0NEext6ETOMUxXk9Ji5uUDtit8bbF3AtVGdUArvRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cnCHuHGibpfu0GmV+YVRQDsrDoSiMArkVz6mGbYOuE=;
 b=CLjoJq1noQrlBzDVNKYc7udUz7T+0Ch+H0bJuToJcp20dP2r7RODX8WMfSr+pJA0SWVv9jZfjpeVAL2Dw/DcPoVG2vWrsL5hnd4SRumj5bErFcNTuzTGoScm9ALjE2Ik4QLeljbY7BcTZ3lQ/WguzrPlTU5/+LFVvCKPZJu4OtyWC7M9EC+l97jw7OHk3Sgg2kW4Qdcv4xJGwMGIqLywhQv/bPSmyipLTjnCdlw/yu2Z4Zi9jQng9RkoLdclGzuDkLMBFZesMuhqYv8yYJpzzyRBVEAF0ytD1Tgxq0ywBxySa7rsTIghjatzvx+DASm+phgdyEi2PKWYYilRRBkwlw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA6PR04MB11804.eurprd04.prod.outlook.com
 (2603:10a6:102:524::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.37; Tue, 7 Apr
 2026 09:18:59 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:18:58 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V10 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Thread-Topic: [PATCH V10 03/13] PCI: dwc: Parse Root Port nodes in
 dw_pcie_host_init()
Thread-Index: AQHcwoYefe6+BsgLpEG+Z8UB9ulCibXNhqqAgAVuQwCAADxJAIAAJchA
Date: Tue, 7 Apr 2026 09:18:58 +0000
Message-ID:
 <VI0PR04MB12114DFBAB7D1537A9A0A7CEB925AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
 <20260402095107.205439-4-sherry.sun@nxp.com>
 <xlsfwtcy3wl6nasmx2w2oys6u4bbnvh24qiwr4pf3v5uz523gz@qvhzqfcs5q2c>
 <VI0PR04MB121147E4D3F9FDC95391C1153925AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <gxqcmujdzlzcoawn4rkttasftuyusqtvycu7oagogxaw4yggeo@ww6rjdwbyj2w>
In-Reply-To: <gxqcmujdzlzcoawn4rkttasftuyusqtvycu7oagogxaw4yggeo@ww6rjdwbyj2w>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA6PR04MB11804:EE_
x-ms-office365-filtering-correlation-id: bbaff2e9-9a7e-4620-8f45-08de9486b336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 3hxOiLIW5pCeRYGV6AWgGzczxljakgoh9dug3qahdcLDTBVnUUpP62leI/tAedbUNn0jyS74oyc3FCkagitQrG7l+Q05Otc16iV1+sMKzwXIOPEMLxyzlgLWc843AsQ1HheJ9sUPw/kxEvA1AOuPAgP6oqVnJpXlI8deeHJlVz0CALbVy7UO+UlcPttTl8kc/1yFeQAZs8TdF53TfYe6STFhFaydRpziyrGcv0M4EPj8flrJ1sdOxvcVXvVNjf5bOO9PsGj7YqNXe7ZBDIGnik1Wxs1gt2Xu/VvE2j8gqs+VBj/jN0u0CZRfD4loTinMab7fy+nJ6SeVNf1vSL2UtsVTSSvgS2mPAwvtWsnTJksyEMmut/1GPNMxlJoZYSc/hLPFT1UYHQ0di4vo8GNF3ILUKR+JGXB68sPL5kvD1N3TergpKNEyiqXl0aWh96aWaXm/uwaK7a0m+ocP45IHbKXz3nL+t56hX9rusV4RfsmVszNg6JagrRbc7dnxYccQdEdExUfqIx+7Qkz51P9R2zyj74j86OMpIstfFdUg7BXT2D4iMAVnFCIqhKqsUZHu4kstMfdU5/E0CdwiGYc+z1TZcKRd9uuUwQEiXad5CpgplqeY0ExaQLlA33YZ114r54F3xJ5Rg/0VXrnHauFY3YSh2pIyg+u6Xn9yelLtc5TkOrUBh1l9Rl4h72tb5oV1lQzTFAX93DhtTeHrzgjziayDEUkhaYWJfL7/yp57Tb8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVNDZWJEMy94aHJCOFF3bHl3WDBCb1A5TzFHTlNmQk05RFBXWTlOL2JGZWNH?=
 =?utf-8?B?WmhKcFdNeFNzd093eGgwR2RmckNMR0c0NHB3Vm9UbW9NSWs5b0tBR2F2TEkv?=
 =?utf-8?B?eGhDWWhEMlg1Uk1NeUdnYll1WWFuYzdzZGhLdm12aThyNys3b2hXRFN6MXJn?=
 =?utf-8?B?SmVhNksxZXV6L0NXZXlHVnVsaHBNd1l4SFE4MzBJWDZ4MGtRa0s2TmoxSUxT?=
 =?utf-8?B?SXJ3aHR1cmtsRGhrekpudktSTFhiZjhRcDhvU2lkWWdSRWpyZGI5NXI4T2RW?=
 =?utf-8?B?dDVsSHZRMS9uTFRjdWxpYVgxYWUvNTZDeE1KUE5NVmJpTitDdWNGZFZNV0dj?=
 =?utf-8?B?V1ZXakFMcU94VWcwb0t6c056b2dDZ0pOSHVxOVpDRFBkMllUcUVjeEVCZlhi?=
 =?utf-8?B?OVFCSUtyK1U0aFVCakhlVFQ3Q1g0NlhkczF6eWhZdUp0dEdZMzZJdnFyb09x?=
 =?utf-8?B?bFpLV0FzQ3ZqMFZvN0xlNUYxMWcwcWx5dHFrRGVEbWJGT0t1WEdjdG82dEdU?=
 =?utf-8?B?aW9WWm93TnV4c2RWUnlBMEYzU0hoZkxhZEdWQUY1dUR5b2NtSjdGeFNaT0tn?=
 =?utf-8?B?RHlnSDhLVVVLN2ZRbjM1WFlXNTRwOUt2VVJHaXNSZ2wwNzNEZ1hsNU1NSERI?=
 =?utf-8?B?b0ptQktkVHpwTHF0dVhxNSs3dVFSOGVCSkQ1NWxGMFRSdFY1ZVF1UE55NW9x?=
 =?utf-8?B?Tlo3U2ZpZDJweTd4dEVaK0s0R05mOVhYOGpwWFhBRWdsSEZybngwMm40WFlK?=
 =?utf-8?B?aWJBRStqZk9zd0w5U1YxMGE5UE9pUlExNmRZZ1EyOHlMcWNYSEsxSFdNbDdF?=
 =?utf-8?B?ZkMvc2Z3YjJMUE5QaDdjL3JYUVowNGgrb09xZFRYUCtqSmtaWXhrb0J4VEdC?=
 =?utf-8?B?ZVhZSHVSVlJCNGloa1FOYk1vMnFnaTRHSWJzdkpHQlZTb3VKRU5FUExaTXRK?=
 =?utf-8?B?dmFuNXRwQ1ZVdnFqRHhhR3RaT3BIdkc3ZkFiU0Q3RURSTXRYQUFESzExcDdR?=
 =?utf-8?B?VTl0ZXFuZ2FQUnRZc2dHbkkxc1RDblBzTUZwcnVvM0h4d2hKSnFKaHJ3bmhp?=
 =?utf-8?B?MG8vekdRaFpnYlo3czZXR2xGZlY2N0ZiYytKUVBaTTFYSTJBZWpFM1Q0RGQ4?=
 =?utf-8?B?Tlc0MUFtUkw2REZabnhJUkVLVVJBd2xMNW1iYnRTVHlxenpRWFY0SGJjQ2ZW?=
 =?utf-8?B?a3pYdnVYa1VvYjZ5R3lSdnpQOGdFT0VONzdFMi9oelI2U1Rxd0FLNWU1Umpi?=
 =?utf-8?B?SUlmd3crMDRLWkZXVGJubHhsWEFta0JRS0pJMVc3bklQeVZ6dk0yWnJNZDJI?=
 =?utf-8?B?dXVwQk1nRks2KzNZcnJJZ3QxVmQ5RUh0R0Y1Q0VEeUt0V0lnS0tVdTBrNDl5?=
 =?utf-8?B?N0dzOHpqajJPMFl6clFwRFFFcG4zTmRmTDV3SU1YWEM0aG94TmdIVGtsenMz?=
 =?utf-8?B?RWI1Nm5Pa2RPY0tKa3RrNGpNMjk0VGRFTFEzOFFxRHFvcjZoY0xxWVJ4M3FL?=
 =?utf-8?B?SjZYeVZoTUNVS3JralBjRjMyTmNicnBXWEszYVZSYTc5REsyVFoxTVdsQm80?=
 =?utf-8?B?QmRtY2NIdkhlcnRxdDBEWjVkMVBiNmVsZDhEY3I3OVlBcEh5R1RhdXE3Q2ht?=
 =?utf-8?B?c3FHQWVvR2lmbXQxRGt2d1FTUDJxZlQyS1ZQb0hjZmk2aDhmMFVFTUpvOFRE?=
 =?utf-8?B?NkFvM1BwOUkrQmhGUmt4dWtHNnFna01hNjlNN0V2eGN4eGhDcVZMQ3NrMDlJ?=
 =?utf-8?B?bXBQejJuaHpsMitaK2oreExoRnRiS2VEU3hIMm1ZWGRmQlBqVzlvamFFdWZz?=
 =?utf-8?B?U201eU0wNS9BaFN5R0g5RkZrUzJMUFkzUHYza3pMdVBxOUdpTWsvOUYyUXZY?=
 =?utf-8?B?NFlJRitPa3FBVVcySzdrM3hyY1pRRGNBYk8yemRNMTF0Z2Z1dm5PaWU0ZVEr?=
 =?utf-8?B?MGJBWVlhYW93UDhaSUV5bEVZdWtMV2JvMlNOMjhZV1ZkNGorMVdjM3dPTlR3?=
 =?utf-8?B?QUdpZnp2RVByNWJTeEZXNUdiKzlMU1RlNW13UGJ1aHlmTm5laUFqNVBoVkpU?=
 =?utf-8?B?eXI5MS9vbmxZN1Y0ZjVva1UrVXM2Vk9DaU02UVhZTFJGTzB1YWcxeE9CRkpn?=
 =?utf-8?B?QTloT1NtU0lpYjM4aGh4eGcrVU5KQlVBempvRndpU2tLODNXUmw4VzBteEJP?=
 =?utf-8?B?TG96MEt3WVFQVDhoQURaVHg3U1hZWXdBd3RQN2FRbm54SXR2K2pteEI1cHlO?=
 =?utf-8?B?T1ZNdW9wN3JBQno0Skx6RjBxd3JHQnNROXY3WHROdUpKbkcrWXZzUVF6VVk4?=
 =?utf-8?Q?3sD4xZuEkDOr9I7x12?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaff2e9-9a7e-4620-8f45-08de9486b336
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 09:18:58.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBcJuF18ylpLP2iaJuGqntJPxwDgY7AzcXyLWk2QSFcmjbWQYDnhq4eowmshezOokDVFLbvuWIwiIJqtRqnssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11804

PiBPbiBUdWUsIEFwciAwNywgMjAyNiBhdCAwMzoyMTozMEFNICswMDAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+ID4gT24gVGh1LCBBcHIgMDIsIDIwMjYgYXQgMDU6NTA6NTdQTSArMDgwMCwgU2hl
cnJ5IFN1biB3cm90ZToNCj4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHBhcnNpbmcgUm9vdCBQb3J0
IGNoaWxkIG5vZGVzIGluDQo+ID4gPiA+IGR3X3BjaWVfaG9zdF9pbml0KCkgdXNpbmcgcGNpX2hv
c3RfY29tbW9uX3BhcnNlX3BvcnRzKCkuIFRoaXMNCj4gPiA+ID4gYWxsb3dzIERXQy1iYXNlZCBk
cml2ZXJzIHRvIHNwZWNpZnkgUm9vdCBQb3J0IHByb3BlcnRpZXMgKGxpa2UNCj4gPiA+ID4gcmVz
ZXQgR1BJT3MpIGluIGluZGl2aWR1YWwgUm9vdCBQb3J0IG5vZGVzIHJhdGhlciB0aGFuIGluIHRo
ZSBob3N0IGJyaWRnZQ0KPiBub2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDggKysrKysr
KysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+IGluZGV4IGRhMTUyYzMxYmIyZS4uZjZmY2E5ODRmYjM0
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4gPiA+
ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiA+ID4NCj4gPiA+ID4g
ICNpbmNsdWRlICIuLi8uLi9wY2kuaCINCj4gPiA+ID4gKyNpbmNsdWRlICIuLi9wY2ktaG9zdC1j
b21tb24uaCINCj4gPiA+ID4gICNpbmNsdWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gPiA+ID4N
Cj4gPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgcGNpX29wcyBkd19wY2llX29wczsgQEAgLTU4MSw2ICs1
ODIsMTMgQEAgaW50DQo+ID4gPiA+IGR3X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3Jw
ICpwcCkNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBwcC0+YnJpZGdlID0gYnJpZGdlOw0KPiA+
ID4gPg0KPiA+ID4gPiArICAgICAgIC8qIFBhcnNlIFJvb3QgUG9ydCBub2RlcyBpZiBwcmVzZW50
ICovDQo+ID4gPiA+ICsgICAgICAgcmV0ID0gcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnRzKGRl
diwgYnJpZGdlKTsNCj4gPiA+ID4gKyAgICAgICBpZiAocmV0ICYmIHJldCAhPSAtRU5PRU5UKSB7
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBwYXJzZSBS
b290IFBvcnQgbm9kZXM6ICVkXG4iLCByZXQpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gPiA+DQo+ID4gPiBXb24ndCB0aGlzIGNoYW5nZSBicmVhayBkcml2ZXJzIHRo
YXQgcGFyc2UgUm9vdCBQb3J0cyBvbiB0aGVpciBvd24/DQo+ID4gPiBFaXRoZXIgeW91IG5lZWQg
dG8gbW9kaWZ5IHRoZW0gYWxzbyBpbiB0aGlzIGNoYW5nZSBvciBjYWxsIHRoaXMgQVBJDQo+ID4g
PiBmcm9tIGlteDYgZHJpdmVyIGFuZCBsZXQgb3RoZXIgZHJpdmVycyBzd2l0Y2ggdG8gaXQgaW4g
YSBwaGFzZWQgbWFubmVyLg0KPiA+ID4NCj4gPiA+IEkgcGVyZmVyIHRoZSBsYXR0ZXIuDQo+ID4N
Cj4gPiBIaSBNYW5pLCBzb3JyeSBJIGRpZG4ndCBmdWxseSBnZXQgeW91ciBwb2ludCBoZXJlLCB0
aGVyZSBhcmUgbm8NCj4gPiBjaGFuZ2VzIHRvIHRoaXMgcGFydCBWMTAsIGZvciBkcml2ZXJzIHRo
YXQgcGFyc2UgUm9vdCBQb3J0cyBvbiB0aGVpcg0KPiA+IG93biwgaGVyZSBwY2lfaG9zdF9jb21t
b25fcGFyc2VfcG9ydHMoKSB3aWxsIHJldHVybiAtRU5PRU5ULCBzbw0KPiA+IG5vdGhpbmcgYnJl
YWsgYXMgd2UgZGlzY3Vzc2VkIHRoaXMgaW4gVjgNCj4gaHR0cHM6Ly9sb3JlLmtlLw0KPiBybmVs
Lm9yZyUyRmFsbCUyRmRjbDNiZGxqcmR6Z2VheWJyZzNkYzV1YXhrZWJram5zN3Bhaml4Nm14eGZ0
YW81ZzRtJTQwDQo+IHZtM3l3eXlwNHVqaCUyRiZkYXRhPTA1JTdDMDIlN0NzaGVycnkuc3VuJTQw
bnhwLmNvbSU3Q2Q5ZmFlZjY0Yg0KPiA4MTU0YmRiYzZlZTA4ZGU5NDcyNGIyMiU3QzY4NmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCUNCj4gN0MwJTdDNjM5MTExNDE1NzkxODAyMTE4
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxDQo+IGhjR2tpT25SeWRXVXNJbFlp
T2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWwNCj4gZFVJ
am95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPVBPc3VycXI5UnFCQ25hUXllWERLMkhRVE4N
Cj4gYTROYzB0Zmw3dGhTaU05cUhBJTNEJnJlc2VydmVkPTAuDQo+ID4NCj4NCj4gU28gaWYgdGhp
cyBBUEkgZ2V0cyBjYWxsZWQgZmlyc3QsIGl0IHdpbGwgYWNxdWlyZSBQRVJTVCMgZnJvbSB0aGUg
Um9vdCBQb3J0IG5vZGUNCj4gYW5kIGlmIHRoZSBjb250cm9sbGVyIGRyaXZlcnMgdHJ5IHRvIGRv
IHRoZSBzYW1lIGluIHRoZWlyIG93biBwYXJzaW5nIGNvZGUsDQo+IFBFUlNUIyByZXF1ZXN0IHdp
bGwgcmV0dXJuIC1FQlVTWSBhbmQgdGhlIHByb2JlIHdpbGwgZmFpbC4NCj4NCj4gT24gdGhlIG90
aGVyIGhhbmQsIGlmIHRoZSBjb250cm9sbGVyIGRyaXZlcnMgcGFyc2UgUEVSU1QjIGZpcnN0LCB0
aGlzIEFQSSB3aWxsDQo+IHJldHVybiAtRUJVU1kgYW5kIHdpbGwgcmVzdWx0IGluIHByb2JlIGZh
aWx1cmUuDQo+DQo+IE9ubHkgd2F5IHRvIGZpeCB0aGlzIGlzc3VlIHdvdWxkIGJlIHRvIGNhbGwg
dGhpcyBBUEkgZnJvbSBpbXg2IGRyaXZlciBmb3Igbm93DQo+IGFuZCBzdGFydCBtaWdyYXRpbmcg
b3RoZXIgZHJpdmVycyBsYXRlci4NCj4NCg0KT2ssIGdldCB5b3VyIHBvaW50IGhlcmUuIFlvdXIg
YXNzdW1wdGlvbiBpcyBiYXNlZCBvbiB0aGUgcHJlbWlzZSB0aGF0IHRoZSBjb250cm9sbGVyDQpk
cml2ZXIgcGFyc2UgdGhlIHJlc2V0LWdwaW9zIGluIHRoZSBSb290IFBvcnQgbm9kZSwgbm90IHRo
YXQgbW9zdCBjb250cm9sbGVyIGRyaXZlcnMNCm5vdyB1c2UgcmVzZXQgdW5kZXIgdGhlIGhvc3Qg
YnJpZGdlIG5vZGUuIEZvciByZXNldC1ncGlvcyBpbiB0aGUgUm9vdCBQb3J0IG5vZGUsDQp0aGV5
IHNob3VsZCBldmVudHVhbGx5IHN3aXRjaCB0byB0aGlzIGNvbW1vbiBBUEkuDQoNCkFueXdheSwg
SSB3aWxsIGNhbGwgdGhpcyBBUEkgaW4gaW14NiBkcml2ZXIgYXQgdGhpcyBzdGFnZSB0byBhdm9p
ZCBpbXBhY3Qgb3RoZXIgcGxhdGZvcm1zLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo=
