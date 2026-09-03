Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011058.outbound.protection.outlook.com [40.107.74.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9894ADD86;
	Thu,  3 Sep 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439675; cv=fail; b=UsYvjMv24LB4jRKCC06cI3kNplKc2+VLEiydx1+k7b//hOjjJxQ0FvqycrIzR3MTwka+j1Xh0YTPXcEwv4uc6W5BCLskAEQX9cD1AY8H+Va4NBP5PvK4YSy4OuIFYw+DmYW/fWmoXrRM82WQlWNiq815v74MYFyXtMH/c5nODQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439675; c=relaxed/simple;
	bh=B3fmo8cJj2/wFI0fHDdyJxB3Qc4dSqwH63XN9I5pmKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UURvnaXKh/KUTOpxnw8a/QLEU2k7C5FvPQ46QWvMoppT+QJmvlD/Ce+t/tOAc5t5oL7pTs9Czb53CMZYQ/meexg0LNhJkBbHsF3KWGtKcjRO47WTNfXzHlyH3rvyG0VS/UXsMYmxmY4uSQt70YWfXgS+e8CVBekIrFjriMQXlRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mnCRsyqT; arc=fail smtp.client-ip=40.107.74.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mnCRsyqT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3KdQBO9MW6thQMaZt6xXeqDApRgJF9LX095CMYETMiZX5UJPxOr5eeekok6T/6esAPqSjn+C0z95a0xu6TP25sWdPf+8CACcjBchd2E6zKlF3D3cSdYtHkXNnwonB18/8woT+yDlIOq1W4C5IRXWMcaNlRtV7SmT/LKmafAK6zkgToAiUXwJR3g5dIaOqMSpDooOKv2wsvcIPc/0JmZ04+Bp7szT1PgXqus4gnAwH0lL8EXT0xFZxhAhOPkqxgLk+zYMFSfkWHF7GZ5IAJppzPlrO+Ran8QYWOkHgEUGrHFSMx/cdyZX13n1c0shvo0FKwLmyeTjkslMetk+p7TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3fmo8cJj2/wFI0fHDdyJxB3Qc4dSqwH63XN9I5pmKY=;
 b=TgQUmoKn2L3/JluhKxULpuZmW34GvZiy4S0DJODrpoNDNznh7HM0wVSEPTfM3scnpcHoF8Z3JAl7BE3a25xc8B71ar/D4DH4xbPnzT2tYraha4luXh+6uuB/ZiVg1hDOqaX+TEy7yC0RvZTKRTHg4zYhspJdBdpzLhOf0bdtZ9xdlfQTTxGd0C/0hKVuOfx64Ox598rK6O0vwY05NxbhfyirDWMkNIgpsjFaYqLczurm2oBisTECUBClf7yNAMbx00fIfTHrHSEuLZElUK/xjpqqAe/oey/D/S7CYgEbh+Pnm+VvcxsPVytcCct1C4nj0D/7oxodLYI4BqyyBYyhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3fmo8cJj2/wFI0fHDdyJxB3Qc4dSqwH63XN9I5pmKY=;
 b=mnCRsyqT1g5u9nKH0RQpDdd5vqOCfwQ9JzO7DOfun1Fuc5bRzagutEynwi0u6U3lFHBMOg6GBoMf7kgIieuZ2M+aQ9BI+UkuMDB4H9k3a6e+RfCfPWQWjazkSk79PEr2r8FDXlkBZorfQTcN4IwV2fOBB5Tof1KOpUUsoiFPPDw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB17540.jpnprd01.prod.outlook.com (2603:1096:604:443::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:47:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:47:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/4] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document
 RZ/G3L SoC
Thread-Topic: [PATCH 1/4] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3L SoC
Thread-Index: AQHdNHc86lsfwUzr406V4wlScbjPRba3vHIAgAUS36A=
Date: Thu, 3 Sep 2026 12:47:42 +0000
Message-ID:
 <TY3PR01MB11346DD51669F0D43F0DB4D8586B62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260825095047.9971-1-biju.das.jz@bp.renesas.com>
 <20260825095047.9971-2-biju.das.jz@bp.renesas.com>
 <20260831-neon-responsible-ape-e0cd02@quoll>
In-Reply-To: <20260831-neon-responsible-ape-e0cd02@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB17540:EE_
x-ms-office365-filtering-correlation-id: fe2256f2-4d3e-4c45-9866-08df09b98b98
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|4143699003|10067099003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 NrJs9oxg/sI858UxzJp5gFjtdc7LXckS3hC0H4Bwd7idSv70GXEVYJwtQ5x2DHZ+POn/fvKXmpUkFlFumi1zkJ9MyYOqaX3SXXef1RQnfWpIGHyIvKipEoDGG/8NSzjZGJs+v3debseMHzc6KV5aCxZ52AGLD7gbx4tfV9Mp7BNnIExKgR3s1vkjGe1wTThnd9uIVQgVg8UpRuYwq8ee3wpYh1jpuj+JdygBlc//1nFoFlBqfe6pu1MHOPVoQQo8ISZc5W6QVGL0MENXrnkOcn7evdydVUJyx2LR7fd+jFSTOioM1GlyFx54UaQRfcqSaymZ34UvYC6r8HaZ9bFa8QednFMGXxIAX6ynhi9cc8z5LR5LGAHfksmez2AGfwv147gC4tyBP5muZrkQSzZQRhixBZdqm0wfIWh/Vbl+gD8C2iA0AtvjQ242AzqzJF7JRRjNqJkTx/MaFUBTvcbA0KOaxK4qaFxsqfl2NnbAi9TbOBoHxIZGUNfrHZpv2RMz5/ztsRgCGqNE/Tz7sbeimGYUOpmXViSMGouR9q7BxbAkhoLaKj1jwL6oXXrSZ4yhlbhKxHab3ruCkFzP8e4TLPFp/ezH7mN66pIZprCnG2uhjeIe8x6iPAlNx9K4K9ATz1LQN27ku++QLjZAWIsy713+252PNDUKUONM7jDvXEhsjI3PQXsBzi2C9H2qRb45tum0/xFlZwf+dvHfTYmsASW0LhSCEb+u7Qq0a4SX4bg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG5TUHZpaGtGR1c3QjU5RHN4ODlqQkR1U21OQXRzQUNrVkJXTlp5UDkySmRx?=
 =?utf-8?B?OERJQTZ5QWZkMTRXY1NzR0xBUXFJdmc5eUQ0OWRpQVhjM29tMXNLcXJ5Ti90?=
 =?utf-8?B?bVBSNm4zd2lqL29XenZxVzlIVi9sNUpWd2psSWpEOTVUSjZ3K09DZkUvRXVI?=
 =?utf-8?B?N2lxbVhzWE50ZklJUkgxQnRqKzBxMko0SlJMbUtXcVNMWC8wa1JHdkdiUWhw?=
 =?utf-8?B?M2Y2eGRwTUlhbFZEdWVacTBMeDNYRWxLTE51MFp1L1ZiSmVmNzI1Yll6MWJ5?=
 =?utf-8?B?b2NaVTAvM3JXNmpKRnkrRk5pZWhvaDZTUmZpR2tLTmI5MXJsdXRlRDZXWGt3?=
 =?utf-8?B?L1U5aTdObVVhdWhzWXU3U3lQYjFta3kzMmlTNmVkMDJ4dnJHUnpSSXJJNllO?=
 =?utf-8?B?NDU0dkR2RHhpS2x0Q2JPVWdibkZzZ1FTYytPM2hFNTVkQWp0dnh0WlVnVEFy?=
 =?utf-8?B?Z20zSGYzV2ltQlR0NzFXTVRzallDZ1ZJVzY4K1NCcU1SU3Z3L3RVem1tYzN0?=
 =?utf-8?B?K0pyaFVRdFRnNXRSYytwaldWUEg3TFJLclNmS2cxcDFTbEcxRldwc2dPNVB6?=
 =?utf-8?B?cVYzcm5zeTMrNVU2dFlNNEQ2elhRYnQvbVJiMkxnaDdsR2xwS3hwZmlGZGMy?=
 =?utf-8?B?Qlpka2NOM1JxOWw5SldwaHNOekNTOUJhaDFEUkNIcWIxVkNOZ1RWaHlxbENz?=
 =?utf-8?B?TFFKR0dWaHZ3V0xBWm51MHRTTVArcXY2dHFiR1MycVRSYlRpYnUxTmhidndm?=
 =?utf-8?B?dE9nNFozY0tzUWZmeWkzck5GeHBvVktQb204M2JJbnhtaGV0VzROMFA5LzdE?=
 =?utf-8?B?SDBhVEtLeFFwQWZkUTJmeVg1QXZNbEtGYmJWdnplTlNWQzdzRzdhNGlsQWt1?=
 =?utf-8?B?RHUrYm9OaDhjc2x6SmNZMWNqOENhU3Z1MHUxRGRqcEQ3aDMxRzgrWFBLbzZy?=
 =?utf-8?B?N09QdDlqYm9GV2VTcEY0elROSG1PRzAzQVp0SjNEY2FUQmszTDlLOWU2cy9Y?=
 =?utf-8?B?ZS93OEFVUTh1VXhrbndLTFl4dmg4UzdBZHh3MjVtSDJnRE5ZYTJIa2RZNk9U?=
 =?utf-8?B?R3V6R29jbnkrSXdGQ0l5TWxteDlkRkNLOUpuUXFyNTlwQmdmZWh5Y3dNVU9u?=
 =?utf-8?B?ZWVvUWc3Q0I0WHZFYmZWdldicndSdnUyUkNFMEZrdkhzZGY4N2t0dmQ2OEpp?=
 =?utf-8?B?S0tKaEN2SG1kVTczcU9jQURJWlNPK0JYaStmdGVoSUtkNjVBbUMvNDFUUmFI?=
 =?utf-8?B?UUhOWEVPb3pxZi9yRWNrZit2N3V5VmpEZHBMM2xOcU1zd2EwV2tTSStHYmRI?=
 =?utf-8?B?RkFiekc2LzdmbElJWGhtNjU4cE84ci9QcUNoQ2kvcmE3WEZOWjRkeSsrSHdj?=
 =?utf-8?B?WmlWYW9odDlIRmZCdjB2RVorZGZXMWhEbWpmamsxTTVYaXBkV1VVOTZrcjE4?=
 =?utf-8?B?V2JKR2ljZEpUNHVkK0REclEyR1R4L2gwRkJYQmZqY0dFUGI5aHFjY3F5VjZS?=
 =?utf-8?B?QllvaFUycHluL0kzR0NQUExWOGtzUENHZEJBelkvYWZEdEdwUHBCU3NkWjlJ?=
 =?utf-8?B?OVFkRFcxQndJb0dQZzc5ZFYyRm81cmJ2MGk0VjlZaFlHVXNzdFp4YjladTlu?=
 =?utf-8?B?MjM1eEFvUW5Yb3lSQXlVZEFBRTNMeWV1dWQ3V3c3cjV6MW0xcHBoY0FhZmpz?=
 =?utf-8?B?ZDJ5dWVUVU5uM1ZnMlJzS002dDBLV0hsTVZPcFd0SmFXVmJXdzV0MGVUY1dw?=
 =?utf-8?B?SXVRd3h1M2pXU2EwNHNUOTVZakJiMkNLR2tzRVozcFl0NUF5TXliS05QQnl5?=
 =?utf-8?B?Y2t0R0tyMjB0N2duY091RXNMdDYyQ25STEd1WlplT0VyRTJWbjd3NlZJbXZt?=
 =?utf-8?B?RmMyK0FmbjR5VGh2djVKOHY3MjdOc2Zyam8reGEza2trVm01UElIaE9pZy94?=
 =?utf-8?B?b1ZTNzhxMGNjaFBHYTNRSzdQUEdnRlRXai84ekdPY0NESnJQMm9KQitUN1g5?=
 =?utf-8?B?MXpic1crS25QOTRLczk3NktQWlZPc2ZPZGE0TnAvN3FHajBmK3FMd3N4cFgy?=
 =?utf-8?B?blpUVjVMTU1wZmg0SDZLSFJrRXdadWt4aGVKOEJkajl6Uy9qMitkMHRyRkE1?=
 =?utf-8?B?TGJLVjloYlUrVzFwMEJvc3lxeWhrYk9rNGFVVG1DQjZPVkhjNjNWcTNuNDM1?=
 =?utf-8?B?US9wVWxkdTJIcUtkazdEczBHZnRrbldxQkNSYXdzZXdhZEh2Uk4xaTVsQlls?=
 =?utf-8?B?N25mTUNPNzNLWFhieEVsM1JHWGQwZWxhRDZ3eVRZWUVlVXpCRzB4U1NGcTJM?=
 =?utf-8?B?YzBTK2o0MWVkSkt2TUMxdmUzWTF6cEp0bmVMQWZkYnYyZVpqbEtXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2256f2-4d3e-4c45-9866-08df09b98b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 12:47:42.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXLZdGMVTw9lBMB9doRGnPRLgl/IYb6MgJx+eEmHygUyTpG/DlWO4dW7baNhzZwR2MZpkBas4j9QeQ/ac9t9Zp7haPOYaymJBLyKZD3dus8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17540

SGkgS3J6eXN6dG9mIEtvemxvd3NraS9HZWVydCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2su
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAzMSBBdWd1c3QgMjAyNiAwNzozNA0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IFBDSTogcmVuZXNhcyxyOWEwOGcw
NDVzMzMtcGNpZTogRG9jdW1lbnQgUlovRzNMIFNvQw0KPiANCj4gT24gVHVlLCBBdWcgMjUsIDIw
MjYgYXQgMTA6NTA6NDBBTSArMDEwMCwgQmlqdSB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBFeHRlbmQgdGhlIGV4aXN0aW5n
IGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciBSZW5lc2FzIFJaL0czUyBQQ0llDQo+ID4gY29udHJv
bGxlciB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIHRoZSBSWi9HM0wgKHJlbmVzYXMscjlhMDhnMDQ2
LXBjaWUpDQo+ID4gUENJZSBjb250cm9sbGVyLiBUaGUgUlovRzNMIFBDSWUgY29udHJvbGxlciBp
cyBzaW1pbGFyIHRvIFJaL0czUyBidXQNCj4gPiBoYXMgc29tZSBrZXkgZGlmZmVyZW5jZXM6DQo+
ID4gICAgICAtIEhhcyAzIGNsb2NrcyBjb21wYXJlZCB0byAyIG9uIG90aGVyIFNvQ3MuDQo+ID4g
ICAgICAtIEhhcyBhIGRpZmZlcmVudCBzZXQgb2YgcmVzZXQgc2lnbmFscw0KPiA+DQo+ID4gQWRk
IGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciByZW5lc2FzLHI5YTA4ZzA0Ni1wY2llIGNvbXBhdGli
bGUgSVBzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGNpL3JlbmVzYXMscjlh
MDhnMDQ1LXBjaWUueWFtbCAgfCAzMw0KPiA+ICsrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcmVu
ZXNhcyxyOWEwOGcwNDUtcGNpZS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL3JlbmVzYXMscjlhMDhnMDQ1LXBjaWUueWFtbA0KPiA+IGluZGV4IDA5ZDc4
YmQxYTU3Ny4uOTExYjE5NzZiZjUzIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9yZW5lc2FzLHI5YTA4ZzA0NS1wY2llLnlhbWwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JlbmVzYXMscjlh
MDhnMDQ1LXBjaWUueWFtDQo+ID4gKysrIGwNCj4gPiBAQCAtMTMsNyArMTMsNyBAQCBkZXNjcmlw
dGlvbjogfA0KPiA+ICAgIFBDSWUgaG9zdCBjb250cm9sbGVyIGZvdW5kIGluIFJlbmVzYXMgUlov
RzNTIGFuZCBzaW1pbGFyIFNvQ3MgY29tcGxpZXMNCj4gPiAgICB3aXRoIFBDSWUgQmFzZSBTcGVj
aWZpY2F0aW9uIDQuMCBhbmQgc3VwcG9ydHMgZGlmZmVyZW50IGxpbmsgc3BlZWRzDQo+ID4gICAg
ZGVwZW5kaW5nIG9uIHRoZSBTb0MgdmFyaWFudDoNCj4gPiAtICAgIC0gR2VuMiAoNSBHVC9zKTog
UlovRzNTDQo+ID4gKyAgICAtIEdlbjIgKDUgR1Qvcyk6IFJaL0cze0wsU30NCj4gPiAgICAgIC0g
R2VuMyAoOCBHVC9zKTogUlovRzNFLCBSWi9WMkgoUCksIFJaL1YyTg0KPiA+DQo+ID4gIHByb3Bl
cnRpZXM6DQo+ID4gQEAgLTIxLDYgKzIxLDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIG9uZU9m
Og0KPiA+ICAgICAgICAtIGVudW06DQo+ID4gICAgICAgICAgICAtIHJlbmVzYXMscjlhMDhnMDQ1
LXBjaWUgIyBSWi9HM1MNCj4gPiArICAgICAgICAgIC0gcmVuZXNhcyxyOWEwOGcwNDYtcGNpZSAj
IFJaL0czTA0KPiA+ICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA5ZzA0Ny1wY2llICMgUlovRzNF
DQo+ID4gICAgICAgICAgICAtIHJlbmVzYXMscjlhMDlnMDU3LXBjaWUgIyBSWi9WMkgoUCkNCj4g
PiAgICAgICAgLSBpdGVtczoNCj4gPiBAQCAtODcsMTQgKzg4LDE4IEBAIHByb3BlcnRpZXM6DQo+
ID4gICAgaW50ZXJydXB0LWNvbnRyb2xsZXI6IHRydWUNCj4gPg0KPiA+ICAgIGNsb2NrczoNCj4g
PiArICAgIG1pbkl0ZW1zOiAyDQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBkZXNjcmlw
dGlvbjogU3lzdGVtIGNsb2NrDQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IFBNIGNvbnRyb2wg
Y2xvY2sgb3IgY2xvY2sgZm9yIEwxIHN1YnN0YXRlDQo+ID4gaGFuZGxpbmcNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogUE0gY29udHJvbCBjbG9jayBvciBjbG9jayBmb3IgTDEgc3Vic3RhdGUN
Cj4gPiArIGhhbmRsaW5nDQo+IA0KPiBQTVU/IFlvdSBsaXN0IGJvdGggY2xvY2tzLCBidXQgaXMg
dGhlcmUgYW55IGRpZmZlcmVudCBiZXR3ZWVuIHRoZW0/DQoNCk9LIHdpbGwgZHJvcCB0aGUgb3Ig
cGFydC4NCg0KPiANCj4gPg0KPiA+ICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgbWluSXRlbXM6
IDINCj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGNvbnN0OiBhY2xrDQo+ID4gICAgICAg
IC0gZW51bTogW3BtLCBwbXVdDQo+ID4gKyAgICAgIC0gZW51bTogW3BtLCBwbXVdDQo+IA0KPiBU
aGlzIHNob3VsZCBiZSAiY29uc3Q6IHBtdSIgaW4gc3VjaCBjYXNlLg0KDQpBZ3JlZWQuDQoNCkNo
ZWVycywNCkJpanUNCg==
