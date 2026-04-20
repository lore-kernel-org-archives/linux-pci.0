Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCA388360;
	Mon, 20 Apr 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673504; cv=fail; b=ZpYJoAavZbi97JwDquWkf9yJXwtitIWfN57CjeG15zl+pjBsq7risgM8PxA2qn7YPV7UU8zNFWAQ/41/DkftKbJLaMpt+pTIH0iE+uKZyCwHB5bSC5M61cortjwplUlCfv1f2X4akkEPuG5vnJLqhf0CYRHjclZiJHosJfcxjyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673504; c=relaxed/simple;
	bh=Sg7sa5OcdBLBkFsBm+3u0pfrC3cFNCJFONCxBinJY38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8iFeU9RVnS5Y4BZ5GtoFaxaYatO03LdRCZvUqt2E9Vw54Bvxs/LH6nj02IPMt5wPfsaAn9oVCuJSxXncjvxp7N96KSNMckeWXpL6dYNv+mhdmKTHcHpmTi+dTydmlZDCZcZzmEcuRxq3H4EFFucbxH7b4GRJKaeWBF6ynOoAQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlJhJRN0; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlJhJRN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ltc6+3W1Tfzbjv2VFeZYlWwMcpAvDwZB3vuBk4jZbna+JHb6bDWveTtBIPrZC/swW2BzrDUL/sqQt6KUrIVjwRSqIpEtmhvLWns347ViavUOtApTL40sbmmiIGF5BtNPkrtZhj6CxyJtTihbmywPYq1dgdAmkIssIBy2ANe7D4yTKM4vGdUdCkxkYHFnPlOjTdOWzCUj0rPRJrN+XiCQ+FeOLlUP8TCmBjvDuJyvNlcZJp1xRhLgnuZ7UT+QyZtl+4zBbAUOF+O6d+TJu5GvcdeYb7Zpm4Gx7pW0wIgGMyVCONZ9UjmoxQpj4vY0K6v7/gVZJDNl8jfeeMqiFbprww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg7sa5OcdBLBkFsBm+3u0pfrC3cFNCJFONCxBinJY38=;
 b=Vir0HmMpTnrNggsfQHMw/6rdDAeHNXRZLVj2YKmg0ID7a03lqvYaYQTw0nNAtUanGXx1ssfdVKQ/0ZbGV6RZlDDxfHznAylYtSTVNePIqI2msje1ZudARcmCrNhcyQqNc7g7+CTLpj2L8bUgAAne/tiGaXdHWiQBaUHjnpWWmdiO/XZOeRBB2z3toHMJ9CV/4gxGqEerWYLDdCz01v/bnTopyVtAYw0QpVb08GSK96DMzrEf2CVVtAMo/LdofJDg1pu26PysfLyRiMLhAw6LhzfVRCJlM4hFcbZ31Xh527NGaYK9GsG7yBk+dsc2p6A8ka6WWkJS1/UjA30Q+ioA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg7sa5OcdBLBkFsBm+3u0pfrC3cFNCJFONCxBinJY38=;
 b=JlJhJRN0nIT5U+9G5Fk/ujvWNDZ/zwBPzgZdj02eAGH9djA619ttel6mj5nE7/ejiaO4jUSqLirnZSRjJO4Wt+ygM8U6nb5Jp4HP579C3ulZAyu78K+8rbHj/hr/tg9Ak+5I2yxJp0WJjkpHbG4OK47e3kkDFLcT2gk6IGRkGko+gXNJoXvyRr9/HIrjnzNYhKSdKYhFxxlYwB+Fyh9llR4UZIczaY9EMKiZtQfsQ6a77P3iCZ1rt6Pf8KaIli+I8Ny5JEvNpNLRHkTi21r3lAiQ9t5u90/P1HS3Ru8jsu9AzYS/1j1E2assdmDZBD2GvE1SDa8r5G7YbRtXwI03ng==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8900.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:24:58 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:24:57 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "mani@kernel.org" <mani@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
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
Subject: RE: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHczZH9Fw0NTzMvoUCb4PMSz4pIBbXiJv2AgABoHuCAAR4OgIADzW+AgAAm9nA=
Date: Mon, 20 Apr 2026 08:24:57 +0000
Message-ID:
 <VI0PR04MB12114304913B6AACF6A206E10922F2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References:
 <VI0PR04MB1211449884AC3BC8E3711F1AB92202@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <20260417195533.GA92707@bhelgaas>
 <viggqsxczf5d5hok4qpqhknalwb46xapsgdxbbgbqhruhyn2hn@wtck4yajmuw7>
In-Reply-To: <viggqsxczf5d5hok4qpqhknalwb46xapsgdxbbgbqhruhyn2hn@wtck4yajmuw7>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AS8PR04MB8900:EE_
x-ms-office365-filtering-correlation-id: 2487fc2e-cc3f-4d9e-ead6-08de9eb64eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 KROOqezBiG0T3VskYJfVcVEYZ418HKEXkOQl3M3sC5A+cC2xr7pAate9BI1zxKl6i7yW+AUFgrLJUgN2Pa5PuSVgfIUY15vVUJdQCEdTcCAHCRYW7uN3D8tbz3feaoJspVH8U4x91W/0G8RyKnyQ6YyGjO7xK1FIVZbaVpW4TD85biEAf/eHqnBvB3NS7u2UXmkbkVHR6ogqYRqlCg2fd5qf6UQoLnAJA/yx00h2RrJQBeA7Z3qwI1/SN8nd5wU4Dy6q2MLb8PwsvtSHpab2QghPPJFSwp2LPxTrGCRzduZXvifRnSfhDxqhrXGL4E9u7wv4lLaEr62lwOdSq+abCXQM5KJOsIOlpV1W1MvEEzF+aB6TzyFa1hqSGe/PmBo//+6q/aXg6AbZ7cKDnefJ8MEzG2hWk2dXsHRgAuaA8tXW+eXGkKOPOPjCNkjLiP+ClDzJpUgYbXY6u2vl8H1FQYKh015JlMf6qEsYepPPNhx1vFR0IUcFm6MhvK9w6hUHxTi9dv2LVDfFiT+cCGQSjliOLT78Xnk/COjCtGPjTyYWpC6vO2J684R86Vn0lV+269fxHIoO1KBSaKNrd6rh/CCtAl2yze9Ssq1e9xNhGGzT0JyV/ftM/Vs7Zf8A/dHUX7Vt4ubt4EWcZ6bTiMj5iMwJsvq3ezuLorrG2zBtCNneG1PqxnswMT6LhL/iSgIt2BZeDNt+63cROefNeP+mQlPezvQKcs8SXa2nP2LqEH8QvhRm97tXmfPAnNXmyzVGURJIiCsjTRWAGiaVx69uAqdz9pEejo3uEI8F3yGuBXc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVVkakFlN0l0M29wdENwUFhTcWE2UjdpN0haVDg0RzRSV0dqQnRmaXBheGRT?=
 =?utf-8?B?bGtVSlBXcURYMWhyV0lpNFlrbkRLZERFOEVBR1psSTZoTHlkckhoVEJFMEda?=
 =?utf-8?B?YnErUEsvUWxzNG1BMWZFVEVJM3FCNWF3bjd4RXhPK2hWQU5vMUxpNG0vTE8r?=
 =?utf-8?B?aDYwdG9aTm9qdE8yUitDTHJvYVk2dHBEZk9MWlN4UkJQT3BZTGVvUGJkV2hJ?=
 =?utf-8?B?Y3pUVHc1YTh6R0FsNzFwaVNXMWIyTWNUVHBFeDRoYVZEZDlXbCsyZjNUb0pv?=
 =?utf-8?B?UTMxMitPS2FyaWswVlRWdjFHa2M2dXAvZHMwL1lqcDRyWGwvV3dJTkVablBm?=
 =?utf-8?B?MlhTK0QwMUZCNDY2QVZqZXFleFpzZkpVeGY2VWk0WWhTM3B6TWxzUWJ3eDRG?=
 =?utf-8?B?Q3NIMHRUQ1ZKbDkzNU1RaFZPUE5hMlZUbWpkbWpXbC9YeVg2aHh3U0FZa3JG?=
 =?utf-8?B?UllRVTh0c0ZJVkI0TlB2UE1tWEFtTkU0N2hCclljRWVMaE82N3k1NUovWGpZ?=
 =?utf-8?B?WDdpbEM2ck5qZkJwN1B3clpvdUpDVjZCbmxXR0FiczBndU1BQ0dacFFDbHVp?=
 =?utf-8?B?OG1aY01SZXFrV3hBZFpOVlh4YzM1LzNHNjJWcllTYUZGaXpBUTJtaTdLK2Rw?=
 =?utf-8?B?ZlQ2ZEkxTjBqdVlZUTVxcDFxN0FmZ2dQK3F1d293amdYRHFBMkd0cWdxd0xT?=
 =?utf-8?B?Y0pyUGUrcFBrRld4VWZ5allFN25xWlUwaFBjNHBBSktpNlMxWmhVc1JMVXVx?=
 =?utf-8?B?MXRUSHc2aG5oVEQ0cmVvMEptYWVhTEhMeE9hTUlneG5GTUd6TFZmTGtnUTVE?=
 =?utf-8?B?V3I4Vm85MkZ0OVM2MTdIUGh5WHRBQUZKU294UTdkOW9mVDIybHIxUVpxbHI2?=
 =?utf-8?B?NmFibDU0b0ovNUlkV3lJbHJkN0pBU1RzbUFIUFB6bG1uUExUVSttYzdjdStm?=
 =?utf-8?B?dEYwNXlOSzRWSFJHOGZWWDdKMkZqMXFBdmNQN2FhQ3BLOWZZNFpONjFqampV?=
 =?utf-8?B?NUpXQzJTVXpaTkJScGVsT1FTaGJBdkZlMkoxaEt4M3Q0Q0t6ZU94dnBxTng3?=
 =?utf-8?B?amdQRVBLenVnVnlrNnhOUExIekQraEtMV2s3bk5PelkzVkpEVzhNMS9yVU5F?=
 =?utf-8?B?Z1MzTUNuS2ZwWmwrUGJaRlhsK01QQzl5d05qZGdvQURDbDhrUzBxZ0NRZEJi?=
 =?utf-8?B?dWJNZU43c0lhWXhteXhFdXY3Yk1CRGJXaWhFcTdwYXIzeEtFa05RRExEVlhF?=
 =?utf-8?B?cjhJQkRqTXprdUhaeGdjNC9PSDdnQUpYcFlzalRNMk1hbmpMQUtUdjB3eGNQ?=
 =?utf-8?B?azJ2N0U2dks1NDlGWHNlai9XcjNua0ZBeFBENHJQVFUyWkFLZjc0akhwaHZ5?=
 =?utf-8?B?Nit0aXdzaTBGR05QR080bG16Z2s2c1ZWZDNYUHVESlRWeFdQaXJpNXM2R2lm?=
 =?utf-8?B?ZGdNMzJEbmt1TFhYekwwZlAwV0twaGZtZnhkbzJHVHB5L2xJNFpibUJMZW1G?=
 =?utf-8?B?bDFpUDF4RE5sNjFvNzhIbjhsN0YyakdIbUJSVFNuTUxTd3ZOSk9lYzdVckpR?=
 =?utf-8?B?OFpBYml3ZzNBdzJINVNxSmNWQWp1OW5tZUZYSEVRV2psQTdVTDVweENqOGkz?=
 =?utf-8?B?ZW9ZUVplcStWN1dmMDk5MTRUZXBmcnd3bFQxeVZaT0toRVRXbzZlWCtNZmlG?=
 =?utf-8?B?d3E0ZW4xNXVqUlVpRVh0TXdEVS93ai9GdXJFSytYeGdhSUhHRTE4OTNGbjVU?=
 =?utf-8?B?V2REZm9xTnBIWmpkajludDJPQTJvUk9FRFB6cFUvc052UThBeU0vZTJGblFZ?=
 =?utf-8?B?QzZISnd4OUUzdmJKek1aZExETFlRNFgybGFudjROdVdSRmFCb2VZejFhN1pR?=
 =?utf-8?B?RkZVVHMyMDM3cENkenoyU0Y2Um96cnhhUncxN1ZvdEs1MWk3dEtzZC80bTM2?=
 =?utf-8?B?bEVjYmtaZDltZWtHcFV0MTlkUkhYM29NbEdaWmlQSW5Oc3ZQVWlOOERtNXNl?=
 =?utf-8?B?SU85c2I4ek5uSXp6V2J6TEU2Ny9iY21jVHYzeXNRbXB0Sm5xS2RUWDIrbm5C?=
 =?utf-8?B?eFQyVU56K0ZxSC8zdktVOXArL0NzeUgvSkxGSUJKOWdRZ01kbi93NEs1WFM0?=
 =?utf-8?B?MzlIYWMrNnhoRnp1ZmJ6RUFvbDd4YzdHUS9sWlZCclZBUi9vNitsdWxJSEV1?=
 =?utf-8?B?RU5hU1F2anU3bXM3OGhKZ2JWK2pENnZ2eUJob1VvTzJaT1U1VWdGbnorQlVv?=
 =?utf-8?B?QVZFSjNBTitHTlV2WE9odEtrQWU5eDlWUE9tRmdrZnh1WERzYVlkMFVqUlhX?=
 =?utf-8?Q?bexVAxPVsdOvtTPXGa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2487fc2e-cc3f-4d9e-ead6-08de9eb64eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 08:24:57.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vC6LFQNy3CPucZp9szdDkyzRK4gnSk0zZhHSmYr4pvjSoNVwSxhXYKaHiyh69YFivuF/ua8zuI1j8eGV/hHs/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8900

PiBPbiBGcmksIEFwciAxNywgMjAyNiBhdCAwMjo1NTozM1BNIC0wNTAwLCBCam9ybiBIZWxnYWFz
IHdyb3RlOg0KPiA+IE9uIEZyaSwgQXByIDE3LCAyMDI2IGF0IDAzOjE3OjE2QU0gKzAwMDAsIFNo
ZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgQXByIDE2LCAyMDI2IGF0IDA3OjE0OjEy
UE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiA+ID4gSW50cm9kdWNlIGdlbmVyaWMg
aGVscGVyIGZ1bmN0aW9ucyB0byBwYXJzZSBSb290IFBvcnQgZGV2aWNlDQo+ID4gPiA+ID4gdHJl
ZSBub2RlcyBhbmQgZXh0cmFjdCBjb21tb24gcHJvcGVydGllcyBsaWtlIHJlc2V0IEdQSU9zLiBU
aGlzDQo+ID4gPiA+ID4gYWxsb3dzIG11bHRpcGxlIFBDSSBob3N0IGNvbnRyb2xsZXIgZHJpdmVy
cyB0byBzaGFyZSB0aGUgc2FtZQ0KPiA+ID4gPiA+IHBhcnNpbmcgbG9naWMuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBEZWZpbmUgc3RydWN0IHBjaV9ob3N0X3BvcnQgdG8gaG9sZCBjb21tb24gUm9v
dCBQb3J0IHByb3BlcnRpZXMNCj4gPiA+ID4gPiAoY3VycmVudGx5IG9ubHkgcmVzZXQgR1BJTyBk
ZXNjcmlwdG9yKSBhbmQgYWRkDQo+ID4gPiA+ID4gcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnRz
KCkgdG8gcGFyc2UgUm9vdCBQb3J0IG5vZGVzIGZyb20NCj4gPiA+ID4gPiBkZXZpY2UgdHJlZS4N
Cj4gPiA+ID4NCj4gPiA+ID4gQXJlIHRoZSBSb290IFBvcnQgYW5kIHRoZSBSQyB0aGUgb25seSBw
b3NzaWJsZSBwbGFjZXMgZm9yICdyZXNldCcNCj4gPiA+ID4gR1BJTyBkZXNjcmlwdGlvbnMgaW4g
RFQ/ICBJIHRoaW5rIFBFUlNUIyByb3V0aW5nIGlzIG91dHNpZGUgdGhlDQo+ID4gPiA+IFBDSWUg
c3BlYywgc28gaXQgc2VlbXMgbGlrZSBhIHN5c3RlbSBjb3VsZCBwcm92aWRlIGEgUEVSU1QjIEdQ
SU8NCj4gPiA+ID4gcm91dGVkIHRvIGFueSBTd2l0Y2ggVXBzdHJlYW0gUG9ydCBvciBFbmRwb2lu
dCAoSSBhc3N1bWUgYSBQRVJTVCMNCj4gPiA+ID4gY29ubmVjdGVkIHRvIGEgc3dpdGNoIHdvdWxk
IGFwcGx5IHRvIGJvdGggdGhlIHVwc3RyZWFtIHBvcnQgYW5kDQo+ID4gPiA+IHRoZSBkb3duc3Ry
ZWFtIHBvcnRzKS4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4gWW91J3Jl
IHJpZ2h0IHRoYXQgUEVSU1QjIHJvdXRpbmcgY291bGQNCj4gPiA+IHRoZW9yZXRpY2FsbHkgYmUg
Y29ubmVjdGVkIHRvIGFueSBkZXZpY2UgaW4gdGhlIGhpZXJhcmNoeS4gSG93ZXZlciwNCj4gPiA+
IGZvciB0aGlzIHBhdGNoIHNlcmllcywgSSd2ZSBmb2N1c2VkIG9uIHRoZSBtb3N0IGNvbW1vbiB1
c2UgY2FzZSBpbg0KPiA+ID4gcHJhY3RpY2U6IHVzZSBSb290IFBvcnQgbGV2ZWwgUEVSU1QjIGlu
c3RlYWQgb2YgdGhlIGxlZ2FjeSBSb290DQo+ID4gPiBDb21wbGV4IGxldmVsIFBFUlNUIy4NCj4g
PiA+DQo+ID4gPiBSb290IFBvcnQgbGV2ZWwgUEVSU1QjIC0gVGhpcyBpcyB0aGUgcHJpbWFyeSB0
YXJnZXQsIHdoZXJlIGVhY2ggUm9vdA0KPiA+ID4gUG9ydCBoYXMgaW5kaXZpZHVhbCBjb250cm9s
IG92ZXIgZGV2aWNlcyBjb25uZWN0ZWQgdG8gaXQuICBSQyBsZXZlbA0KPiA+ID4gUEVSU1QjIC0g
TGVnYWN5IGJpbmRpbmcgc3VwcG9ydCwgd2hlcmUgYSBzaW5nbGUgR1BJTyBjb250cm9scyBhbGwN
Cj4gPiA+IHBvcnRzLg0KPiA+ID4NCj4gPiA+IFdlIGNhbiBleHRlbmQgdGhpcyBmcmFtZXdvcmsg
bGF0ZXIgaWYgcmVhbCBoYXJkd2FyZSBlbWVyZ2VzIHRoYXQNCj4gPiA+IG5lZWRzIFN3aXRjaCBv
ciBFUC1sZXZlbCBQRVJTVCMgY29udHJvbC4gSSBjYW4gYWRkIGEgY29tbWVudA0KPiA+ID4gZG9j
dW1lbnRpbmcgdGhpcyBsaW1pdGF0aW9uIGlmIG5lZWRlZC4NCj4gPiA+DQo+ID4gPiBCVFcsIE1h
bmkgYW5kIFJvYiBoYWQgc29tZSBncmVhdCBkaXNjdXNzaW9ucyBpbiBkdC1zY2hlbWEgYWJvdXQN
Cj4gPiA+IFBFUlNUIyBhbmQgV0FLRSMgc2lkZWJhbmQgc2lnbmFscyBzZXR0aW5ncy4NCj4gPg0K
PiA+ID4gWW91IGNhbiBjaGVjayBoZXJlOg0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2kNCj4gPiA+IHRodWIu
Y29tJTJGZGV2aWNldHJlZS1vcmclMkZkdC0NCj4gc2NoZW1hJTJGaXNzdWVzJTJGMTY4JmRhdGE9
MDUlN0MwMiU3Qw0KPiA+ID4NCj4gc2hlcnJ5LnN1biU0MG54cC5jb20lN0MyMzI2NDRmOGJiZTY0
Mjc5Zjc3OTA4ZGU5ZWEyMGIwOSU3QzY4NmVhMQ0KPiBkM2JjDQo+ID4gPg0KPiAyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzkxMjI2MTU5Nzc4NjI4NTglN0NVbmtub3duDQo+ICU3
Q1RXRnANCj4gPiA+DQo+IGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdM
akF1TURBd01DSXNJbEFpT2lKWGFXNHoNCj4gTWlJcw0KPiA+ID4NCj4gSWtGT0lqb2lUV0ZwYkNJ
c0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPXI3c3pDTENzR0ZOMg0KPiAxVUxa
DQo+ID4gPiBpYkg3R2ElMkZIMGU2VnlJZHF6bktDSjZ5SUdNNCUzRCZyZXNlcnZlZD0wDQo+ID4g
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZnaQ0KPiA+ID4gdGh1Yi5jb20lMkZkZXZpY2V0cmVlLW9yZyUyRmR0LQ0KPiBz
Y2hlbWElMkZwdWxsJTJGMTI2JmRhdGE9MDUlN0MwMiU3Q3NoDQo+ID4gPg0KPiBlcnJ5LnN1biU0
MG54cC5jb20lN0MyMzI2NDRmOGJiZTY0Mjc5Zjc3OTA4ZGU5ZWEyMGIwOSU3QzY4NmVhMWQNCj4g
M2JjMmINCj4gPiA+DQo+IDRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzkxMjI2MTU5
Nzc4OTIwNDQlN0NVbmtub3duJTcNCj4gQ1RXRnBiRw0KPiA+ID4NCj4gWnNiM2Q4ZXlKRmJYQjBl
VTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUkNCj4gc0lr
DQo+ID4gPg0KPiBGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNk
YXRhPW8zUkl5MVNmdlRHZmtYDQo+IDlybTgNCj4gPiA+IGROSDJvcjVTWjd2NWJZRiUyRmwxWEdh
ZjhhQSUzRCZyZXNlcnZlZD0wDQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaQ0KPiA+ID4gdGh1Yi5jb20lMkZk
ZXZpY2V0cmVlLW9yZyUyRmR0LQ0KPiBzY2hlbWElMkZwdWxsJTJGMTcwJmRhdGE9MDUlN0MwMiU3
Q3NoDQo+ID4gPg0KPiBlcnJ5LnN1biU0MG54cC5jb20lN0MyMzI2NDRmOGJiZTY0Mjc5Zjc3OTA4
ZGU5ZWEyMGIwOSU3QzY4NmVhMWQNCj4gM2JjMmINCj4gPiA+DQo+IDRjNmZhOTJjZDk5YzVjMzAx
NjM1JTdDMCU3QzAlN0M2MzkxMjI2MTU5Nzc5MTAxNjklN0NVbmtub3duJTcNCj4gQ1RXRnBiRw0K
PiA+ID4NCj4gWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUkNCj4gc0lrDQo+ID4gPg0KPiBGT0lqb2lUV0ZwYkNJc0lsZFVJam95
ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWQ4U0JHY3FLY2pZZTFpDQo+IGlxczkNCj4gPiA+
ICUyRiUyQmcxbyUyRmJFQ0hZdG5FVUxnN2hUWHlLbVklM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4g
VGhlIHVwc2hvdCBvZiBhbGwgdGhvc2UgY29udmVyc2F0aW9ucyBpcyB0aGF0IFdBS0UjIGFuZCBQ
RVJTVCMgY2FuIGJlDQo+ID4gcm91dGVkIHRvIGFyYml0cmFyeSBkZXZpY2VzIGluZGVwZW5kZW50
IG9mIHRoZSBQQ0kgdG9wb2xvZ3kuDQo+ID4NCj4gPiBJIHRoaW5rIGV4dGVuZGluZyBob3N0LWdl
bmVyaWMgdG8gbG9vayBmb3IgJ3Jlc2V0JyBpbiBSb290IFBvcnQgbm9kZXMNCj4gPiBpcyB0aGUg
cmlnaHQgdGhpbmcuICBNeSBjb25jZXJuIGlzIG1vcmUgYWJvdXQgd2hlcmUgd2Ugc3RvcmUgaXQu
ICBUaGlzDQo+ID4gcGF0Y2ggc2F2ZXMgaXQgaW4gYSBuZXcgInBjaV9ob3N0X3BvcnQiIHN0cnVj
dCwgYnV0IHNvbWVkYXkgd2UnbGwgd2FudA0KPiA+IGEgcGxhY2UgdG8gc2F2ZSB0aGUgUEVSU1Qj
IEdQSU9zIGZvciBzZXZlcmFsIHNsb3RzIGJlaGluZCBhIHN3aXRjaC4NCj4gPiBUaGVuIHdlJ2xs
IGhhdmUgdHdvIGRpZmZlcmVudCB3YXlzIHRvIHNhdmUgdGhlIHNhbWUgaW5mb3JtYXRpb24uDQo+
ID4NCj4gDQo+IEV2ZW4gaWYgdGhlcmUgYXJlIFBFUlNUIyBHUElPcyBmcm9tIHRoZSBob3N0LCBj
b25uZWN0ZWQgdG8gZG93bnN0cmVhbQ0KPiBwb3J0cyBvZiBhIFBDSWUgc3dpdGNoLCB0aGV5IGNv
dWxkIGJlIHN0b3JlZCBpbiB0aGUgUm9vdCBQb3J0J3MgKHBjaV9ob3N0X3BvcnQpDQo+IHN0cnVj
dCBhcyBhIGxpc3Qgb2YgUEVSU1QjLiBUaGlzIGlzIHdoYXQgcGNpZS1xY29tIGRyaXZlciBkb2Vz
Lg0KPiANCj4gSXQgaXMgdG9vIGNsdW1zeSB0byBoYW5kbGUgUEVSU1QjIGluZGl2aWR1YWxseSBm
b3IgZWFjaCBkZXZpY2UuIFdlIHRyaWVkIGl0DQo+IGJlZm9yZSB3aXRoIHB3cmN0cmwsIGJ1dCBp
dCBhbHdheXMgZW5kZWQgdXAgYml0aW5nIHVzIG9uIHdobyBnZXRzIHRvIGNvbnRyb2wNCj4gdGhl
IFBFUlNUIy4gV2UgY2FuJ3QgbGV0IHB3cmN0cmwgaGFuZGxlIFBFUlNUIyBmb3IgYSBzd2l0Y2gg
cG9ydCBhbmQgaG9zdA0KPiBjb250cm9sbGVyIGRyaXZlciBoYW5kbGUgaXQgZm9yIFJQLiBBbmQg
d2UgY2Fubm90IGxldCBwd3JjdHJsIGhhbmRsZSBQRVJTVCMgZm9yDQo+IGFsbCBwb3J0cywgYmVj
YXVzZSwgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMgYWxzbyBuZWVkIHRvIGNvbnRyb2wgdGhlbSBm
b3IgUkMNCj4gaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBUaGF0J3Mgd2h5IGl0IHdhcyBkZWNpZGVk
IHRvIGhhbmRsZSBQRVJTVCMgZm9yIGFsbCBwb3J0cyBpbiB0aGUgaG9zdCBjb250cm9sbGVyDQo+
IGRyaXZlcnMuIFNvIGZvbGxvd2luZyB0aGF0IHBhdHRlcm4sIHRoaXMgaGVscGVyIGNvdWxkIGFs
c28gYmUgZXh0ZW5kZWQgdG8gcGFyc2UNCj4gdGhlIFBFUlNUIyBmcm9tIGFsbCBwb3J0cyBkZWZp
bmVkIGluIERUIGFuZCBzdG9yZSB0aGVtIGluIHRoZSBzYW1lIFJvb3QgUG9ydA0KPiBzdHJ1Y3Qu
DQo+IA0KPiBJdCBzaG91bGQgYmUgdHJpdmlhbCB0byBpbXBsZW1lbnQgdGhpcyBsb2dpYyBpbiB0
aGUgY3VycmVudCBoZWxwZXIuIEBTaGVycnk6DQo+IENvdWxkIHlvdSBwbGVhc2UgaW1wbGVtZW50
IHRoaXMgbG9naWM/DQoNCkhpIE1hbmksIGRvIHlvdSBtZWFuIHRoZSBzaW1pbGFyIGxvZ2ljIGlu
IHRoaXMgcGF0Y2g/DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTEyMTYtcGNpLXB3
cmN0cmwtcmV3b3JrLXYyLTEtNzQ1YTU2M2I5YmU2QG9zcy5xdWFsY29tbS5jb20vDQpJZiB5ZXMs
IG9mIGNhdXNlIEkgY2FuIGRvIHRoaXMgZm9yIGN1cnJlbnQgaGVscGVyIGZ1bmN0aW9ucyBpbiBw
Y2ktaG9zdC1jb21tb24uYy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
