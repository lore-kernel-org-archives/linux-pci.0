Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA5372EC3;
	Tue,  7 Apr 2026 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532095; cv=fail; b=OaPyp+nyvefQTP4vj+CNFxuRGfhwuhJxBV6Pxc64wxv7zkAF1qZmkCSzep7PyMkic5DwY/zuzdtCggsjoBPSei35VqAp6CHn3RSpl9RaK/7Hgs7GdGJpf3/+e8nBtCSnikWkRVGCxEBK45zarmeC9u/kdj17xsZrewNFDbc4o38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532095; c=relaxed/simple;
	bh=CcpgO5GhmFHXy1vVzX3U2t0KbFOammNpEafdTL3c3Qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGLy/C8wV89Z2bFXjsUcQw7/Cco7PkjCCjEWHBDVREudVrQVsHWBfGNeoNS8p+ZSXEBBAMyzQqiq7gVqIKgUAUOrSgBAXIE48TpXu3h5ndtZ4qRnjSj4b4YGu7S3kR1XA1iHeO244O1R4Iia1gwsoV5Q04oA09QPFvsZG11rXwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GU5v9g8C; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GU5v9g8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI/zttOgSQCsY6ANaVnOP5Zx1sfwFGCtq86jGozEF5F3R+la4+DnwGPtu+WIN+2GSp/dofBIqEUtoYMVqQn7tmHk5NE3a3WypGhoiVClftNOlSPdrbdFomk87AjUt0b9hf3ozkOP1kzEe6FGrKjc4kqk3uo4bRBJbwe+5p4bgTZpYWOLwzay+S1AUINpaz3LH/aaxrZ6UXKQU2AlqoiF4G1NiX+ezY9/zGTRA4PXTx+mcdW2ty8FqGcCHGf5x3xwT6TO0/+7i0Lw/scA2GLIX6HH/5AF2Y64i3O4au9E/7ARm1yv1VKiQ0YbiRhUkWB4IRXBDR+Fa0SPdqRE0jrOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcpgO5GhmFHXy1vVzX3U2t0KbFOammNpEafdTL3c3Qg=;
 b=qRhG0+YXvQZTDeyUe+f13Z6tNE4sfpWcZ1u7+S8YGUWR/ny9GigXkLJNHT0xvQRZaKzC0cHAXuCWqAXwBztMW5ZfSWUGGwJwjdh6Yl7tK/3KgPyflpLsL+4633Ez0uXPH1n6HED3HVXtN4cnAt1wGRCV4wOGul/uNAc0RmO/N3GdiMTf2ZxUSiVXOA4jfPXSjOnfpzfHtbBRZSi1uqczdqZc3dh0dcT8ZtKzImhS4DgpxJVTUGt+/IEROEafpfrMxaVzCviCLayYimLbotrdDk/nr/Y0ivCfhmwvR72rDFMSpSvnZcXuC5rzOC+kZysXkqIq6jA7r85zG1U9dEveJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcpgO5GhmFHXy1vVzX3U2t0KbFOammNpEafdTL3c3Qg=;
 b=GU5v9g8C9MgOS8JCrbZrYFU2w7oA8k6W2rAnd/REA0dPTweAXKABM8h1x7N9Orim24RpCwroo189cM3tNm0J1KidUflJsnSXg+BjksJoLFd2z0dJOCqGGQfJB8m1l+7XtYNT9Km25R0BqqmrQ+z8Zv51LozZHx2NfQQZ7jC+h3RBOI2FbF27N0q1kP+N7qjvVY8qZNRdx3fbfP1P3n7Ehk8nBXsRicWpv14NiVbK44HmgjqitRP9Pv2c/MmlI2pVC7Mtq+On2WzoCcpvcO/w4Yw0HjnLDI71FWhBJoktJYlxcyPE8RM4NR36nByiYDJJ403upaVM4eqBfrcgLl8LYA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9732.eurprd04.prod.outlook.com
 (2603:10a6:20b:672::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 03:21:30 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 03:21:30 +0000
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
Thread-Index: AQHcwoYefe6+BsgLpEG+Z8UB9ulCibXNhqqAgAVuQwA=
Date: Tue, 7 Apr 2026 03:21:30 +0000
Message-ID:
 <VI0PR04MB121147E4D3F9FDC95391C1153925AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
 <20260402095107.205439-4-sherry.sun@nxp.com>
 <xlsfwtcy3wl6nasmx2w2oys6u4bbnvh24qiwr4pf3v5uz523gz@qvhzqfcs5q2c>
In-Reply-To: <xlsfwtcy3wl6nasmx2w2oys6u4bbnvh24qiwr4pf3v5uz523gz@qvhzqfcs5q2c>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AS5PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: d3dcccd2-6ac7-4e02-891e-08de9454c30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 tkgGLVkyUmZmTrOlQz5IUKO3oWYuA++kaE3bG7MAh0eLtTbhLbglA0EWdgcyfpL/k5g4UV3ReFRai8ThY0a9RImv9gsgHr1XLqkd5xsbIewLCzHLp609HJSnfqXVMs4zz+wHyydAURp3YmdAJb8SfowRPrej2daSJsnvhpLXKyEEdmbGBYqJltXsdBnjM/D8qsMH9yi42XpkWJwgy4SJumznhecYldpnUBhr5Z5+z8dzyAPUUNYqybzdMQBiKaQ2aMMHiggO8349PsMxd3hPYa86NtP+hTVrf4gQZoilxxeHE4o1ATvXFlCtV8QWf2xd9FfURF1F4GYe99VyCLBqeOwhl/nO9pXZeWMuRAkIrVm0Ny1YLCO1WgC4nTHmO7oO8AeiCmJ134zOMv8biM9nCv2eyVyvaSMTZnnOupghoU2I8gtGuef6XtzzsBEP0mLey2OGoswtxbkyN3u67V7FSOm4Yb5Y5TjE8PIJJe8ZMbHj7f+z+CGJ0NuD7hB2rONNVNovyAGhLCucQA9ozVX85+y6d0ERxitsIozucIu2V7giXqYgm2w5ff9gsvqLe4Uqws9QbTFt0BoG6foF5TtloOncHPxr+6lWjKvESqb4IJqcRAGxcQIinOMYpWpDfVqIk2D/vNudrxlYBTkusApouVIpYGsN/LQ3dehKgxVXz7yWC3E1DMNhNFKj9zeBkkIHvznskPlr9Ycgam+qUpaJxeQR+9W7cfl4IElLHvEF/JzQ2UEeOOy8KrQk7fvbWtETVatPiy5+mBvduS12gBLRJwLMAP9aWDzPq42zBNQ9axE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek44ZVE4ZUpZME92blRsZnk0Tkl5Vk44VmFnRG41Sm5ySjRWVFB3RFVsSmpG?=
 =?utf-8?B?dm9vTVRVajRpRndnc1FXMnQxNWtuTG5RTlFESW45RlMrTHFzbTVZWjhCNU9j?=
 =?utf-8?B?YVBIb2dSN2xCakZnQ1p6NUd2RzErOFBiTEVSRE9JSXVuaUxKVjNDbGNGQXNV?=
 =?utf-8?B?S1o5Y1REZjZQaUZlSytjL3BFSjJzUmlNdVRyR2FzNUdySWdwa3ZxTjAvYk1V?=
 =?utf-8?B?ZVJWamJwemZsRnlsT2VQZmNkYlhlUkV1NzI4bDQvMmVRTmc4NEd0Q2VxRGx5?=
 =?utf-8?B?RGhMZnA4LzVMNkJ5RDJ4Q3NmNmcwZktVa204eS9kK1paRTRDZG5hMWo1VHN3?=
 =?utf-8?B?VFZoYjRLV2lsSUVOcEZkSDQrWHVMejRMbmRBUTIveW5peVRPcHNXRW9Bb1dO?=
 =?utf-8?B?VUtjSDNieE9qSmJEV2hjSEJxZEZTNUx0eHA5QkEzcUhrZ3VjbUZScDV6WGlj?=
 =?utf-8?B?YWpGMVN6TmxFSjU0b2IyNDh5ZUc4b0J3eEJORG1ka1Q4aVhlUHRYZWN0VnZQ?=
 =?utf-8?B?WXcyUWxEOWdUUGlkOU5uT0pHSlVJaGdlR29jV2dWcTdhTnZTL3NxY3lUaEdj?=
 =?utf-8?B?V3M5cDB5U21vN1FuelVNYzBobWMzZStVbE1iQzFHRytJZlppY3c3WUxFeEtR?=
 =?utf-8?B?Mmt6b1JDYm1LVHhucGdGbVY0Z2hKS2hvQVRSbVNWMkMrZXZuRElqRVFqUW5u?=
 =?utf-8?B?WTJOejNQM1l6LzFKZFNCZGtWalMwTzlHU2pENDNSYXdJbUJkaHJUQWx6ZThk?=
 =?utf-8?B?UkhKUlhuUm8rY1VDNWgrY2hieEtoVDYxdFpMRExKNlc1bC81QzFaVURQT3Qz?=
 =?utf-8?B?OU5obG1tb3BJbVhSTWJvYkJER25zWnRrVDNxME5tV0N6WFNSM01MaGYva2w3?=
 =?utf-8?B?a1JuR3JLSmNxREc5bUtVWmx6cUllWkJUVEpGWGV1UUZUaDhtM21QUktKdFVD?=
 =?utf-8?B?d3dDbW5SMzdma3d2bTZERTFETHUvWEFGb2lTTEtlcHJCTnhPa0FiY0YwRmNJ?=
 =?utf-8?B?OEJicldoOUFyaGMzL05kYXkwMWtYV2MyWFVkN000MGk2NGZGbVc2Vnl0UnEy?=
 =?utf-8?B?dFQvNDJJK1Q0NS9oWlArbmxEdHQrQWZEVXpIV2pOY0NJUmVwaHdvcUc5Smd3?=
 =?utf-8?B?UWl3dCtpOU1MNWZYalBhSklLOGRoeVI0T1lXN0VwSDVORFVmT25sZ2cvck5v?=
 =?utf-8?B?R25GTXZqYmoyMUN6SVJSLy9vYjJycUVuaDZaM0JEdmI4alZSYTZkczNldDY5?=
 =?utf-8?B?WDhaMkFzTFZVUDl0UVUrRnJUZVdtZHVXYWxJVzduVmVKU3N3a29iS0FwSmJ3?=
 =?utf-8?B?Wkl0ODRTdm9SZTdXMkpKRDNTMlJSNTRqMHRTSnVmT3hxc2w5Z2VtaDIvRVcz?=
 =?utf-8?B?d201QkwzNWlna2s4Y2xoeno0Z2RPbk1BdXM1cUNRV0NScy92SmF5YXkxYjhj?=
 =?utf-8?B?VTZvWjlYQmxZeDFEbWp4Yml4ZWdTOVZNUnhWNnFidUZWQjJzVXo1aHlENExy?=
 =?utf-8?B?cElEZ3h6RHo3S2g0YWFJZno4ay94NTNGSW43czUvSlFyRWdFaVJpb3VDa2lo?=
 =?utf-8?B?ZHdMMTZEMkRlckVMVUpNdWNmRVZXVnNXL3VVM3hReFgvMVh1cWM4b2p6djI1?=
 =?utf-8?B?MmE3YnNydzV0bGpXWmJPSEdpTUpWdFQ5dGlVc1JPdC9ad1pDYjJNVEhmQ254?=
 =?utf-8?B?WmZIZGtrbitEbjQyWS9sRWZaeWVZQjl6WEtpdEFQQ2NrcnpVdFF5SC8yRmNi?=
 =?utf-8?B?cUtNS2hxTy96U0llKzlhajM2ejhsdnZTY0pWNWYzcFNZcmtyQllRbk5OTytP?=
 =?utf-8?B?UDIrcFZpeDA0OWZXYTJ0c3JoVXRRUFltWVJId2ZSaVhwY2dLSEI2K1ZUWWZ3?=
 =?utf-8?B?Rjdld1lUejVwWTVBaXJVSkFxaVJhVGxBb0NNc2NhbXpYaS9oQTQ1dnZOTzd2?=
 =?utf-8?B?ODZBZWc3aFNCNHlMY21jZXhUeHhrY1pScFlKWGxWRHVjNGN1V2l2K1FwM3Bn?=
 =?utf-8?B?RDQ5MzdIazJ6ZFU3WDIvb0prM1NsdlYrQ2dlQndGRnFEcUtXOUpUT0hLSWVj?=
 =?utf-8?B?NjEwUVFPQVY3K1BieU9LQXhqYkNvcFZZQzZHSXFYTHpVNHQ0R1YzTTFOa3lG?=
 =?utf-8?B?Qm1EWFdRM1lHMk5DcGNFWWphekpQYUZSREEwaDBnbTZ3M1dPbWZRRzBxOEg4?=
 =?utf-8?B?QmlzekpjZk5iNnFJcE5PZG5SUVorNFVUcFd5eW1MaFdKSmk5dVMzNkV0ZDND?=
 =?utf-8?B?d1VnS01odzZtcEFadmp3SThMeDJwN3dpZEJkTWVuamtYZHI2dHFnZ0I5S09x?=
 =?utf-8?Q?qtc5gXs7WckoO2X3B4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dcccd2-6ac7-4e02-891e-08de9454c30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 03:21:30.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbeFv1FB+DiOlcKr+UtY+Ux+33bUTzLh+Db5hzJjILP9zWQMRBnuupiFw1jZjXS652iJpOyAse45Bww1XeE8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732

PiBPbiBUaHUsIEFwciAwMiwgMjAyNiBhdCAwNTo1MDo1N1BNICswODAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBwYXJzaW5nIFJvb3QgUG9ydCBjaGlsZCBub2RlcyBp
biBkd19wY2llX2hvc3RfaW5pdCgpDQo+ID4gdXNpbmcgcGNpX2hvc3RfY29tbW9uX3BhcnNlX3Bv
cnRzKCkuIFRoaXMgYWxsb3dzIERXQy1iYXNlZCBkcml2ZXJzIHRvDQo+ID4gc3BlY2lmeSBSb290
IFBvcnQgcHJvcGVydGllcyAobGlrZSByZXNldCBHUElPcykgaW4gaW5kaXZpZHVhbCBSb290DQo+
ID4gUG9ydCBub2RlcyByYXRoZXIgdGhhbiBpbiB0aGUgaG9zdCBicmlkZ2Ugbm9kZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3Qu
YyB8IDggKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMNCj4gPiBpbmRleCBkYTE1MmMzMWJiMmUuLmY2ZmNhOTg0ZmIzNCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWhvc3QuYw0KPiA+IEBAIC0yMCw2ICsyMCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0
Zm9ybV9kZXZpY2UuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAiLi4vLi4vcGNpLmgiDQo+ID4gKyNp
bmNsdWRlICIuLi9wY2ktaG9zdC1jb21tb24uaCINCj4gPiAgI2luY2x1ZGUgInBjaWUtZGVzaWdu
d2FyZS5oIg0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGNpX29wcyBkd19wY2llX29wczsNCj4g
PiBAQCAtNTgxLDYgKzU4MiwxMyBAQCBpbnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3X3Bj
aWVfcnAgKnBwKQ0KPiA+DQo+ID4gIAlwcC0+YnJpZGdlID0gYnJpZGdlOw0KPiA+DQo+ID4gKwkv
KiBQYXJzZSBSb290IFBvcnQgbm9kZXMgaWYgcHJlc2VudCAqLw0KPiA+ICsJcmV0ID0gcGNpX2hv
c3RfY29tbW9uX3BhcnNlX3BvcnRzKGRldiwgYnJpZGdlKTsNCj4gPiArCWlmIChyZXQgJiYgcmV0
ICE9IC1FTk9FTlQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBwYXJzZSBSb290
IFBvcnQgbm9kZXM6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiBXb24n
dCB0aGlzIGNoYW5nZSBicmVhayBkcml2ZXJzIHRoYXQgcGFyc2UgUm9vdCBQb3J0cyBvbiB0aGVp
ciBvd24/IEVpdGhlcg0KPiB5b3UgbmVlZCB0byBtb2RpZnkgdGhlbSBhbHNvIGluIHRoaXMgY2hh
bmdlIG9yIGNhbGwgdGhpcyBBUEkgZnJvbSBpbXg2IGRyaXZlcg0KPiBhbmQgbGV0IG90aGVyIGRy
aXZlcnMgc3dpdGNoIHRvIGl0IGluIGEgcGhhc2VkIG1hbm5lci4NCj4gDQo+IEkgcGVyZmVyIHRo
ZSBsYXR0ZXIuDQoNCkhpIE1hbmksIHNvcnJ5IEkgZGlkbid0IGZ1bGx5IGdldCB5b3VyIHBvaW50
IGhlcmUsIHRoZXJlIGFyZSBubyBjaGFuZ2VzIHRvIHRoaXMgcGFydA0KVjEwLCBmb3IgZHJpdmVy
cyB0aGF0IHBhcnNlIFJvb3QgUG9ydHMgb24gdGhlaXIgb3duLCBoZXJlIHBjaV9ob3N0X2NvbW1v
bl9wYXJzZV9wb3J0cygpDQp3aWxsIHJldHVybiAtRU5PRU5ULCBzbyBub3RoaW5nIGJyZWFrIGFz
IHdlIGRpc2N1c3NlZCB0aGlzIGluIFY4DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZGNs
M2JkbGpyZHpnZWF5YnJnM2RjNXVheGtlYmtqbnM3cGFqaXg2bXh4ZnRhbzVnNG1Adm0zeXd5eXA0
dWpoLy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KDQo=
