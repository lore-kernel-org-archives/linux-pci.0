Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE92E414;
	Thu,  7 May 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141077; cv=fail; b=fTBmaxkqekDKfQSVZR+qyceJNe1OsgeAwhZCDyj+hp660YNPVCbwhrhCelvgYpAeuTzkfmMCyqFK4Cqf6g7inn8YFp84wDtEU3Gs0zpPOljG8/hzFGrs2U9Bt3yqwQofoBitjdizjuqZN4pOVcG/xcjx/HaauujISlqmHdRtOpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141077; c=relaxed/simple;
	bh=0KeyMnErAkkkAjm5WKGlpeWYV/bSRBHtgJioS1P4vHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiVZ4+UQQyTdh2MFMjQrnwsCM29As5Ug5aYRaMV0wcG8ZQsyfclEPn1KvnF7S2mbj8RakgElYrEw0GAiFamuhdPO4LfqW14Ph13yAeUPYC42+aCbtiUXWghwXpuBPSN36fSR2hIFtWxG9Q6mVzCWYAOxKTQXgwfnGxGDn9dibAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KBBYmuJ6; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KBBYmuJ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM7ySwTmPZ3LVkoxlEVH8lhHhzBlNOAXm4qYLeJaC+8ELz0sLb6Q/iCuiRcZhfnjKYt1l/2iajSkvpDlYyT8dGIFbyIrFa+U7o9UcyxPQuxsViTcReKtkwxa9L21nPTQiO508sT9vpoQgrTfnoQh1II5jLEGvUKQej97hUynn+qKZOaMu/iqv5XQmzxW/3O66f12jsyiz82ZoSrrGNRJCaTdKULxG8CbiBk7g2f6vddlvHurD0bTF59gvDW+XlJ/AXNGjgVe1tw2N1uQ3uNWgJIwwFO4BuamLmOOqa0SqzxAiX6MZpP30zSKDetynpngzJu9sp2q4MlHlgFkUPx3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KeyMnErAkkkAjm5WKGlpeWYV/bSRBHtgJioS1P4vHc=;
 b=tnf57+6io0Vp7Z54FTH2m8cxDrGyDD32i/AWw0JUqqanvBg6jfhcux4ISLyMw99invJCrh+h/7s4z2/x3lSJNSofxGANJCIgfHUE2HjB7Ukjwd9FnwUxh6JRLq9hETgJx1PLsdhOgS5J6FvetdDgGCwxFb9kb4nT1DWY+i6dWbCisKvEvbyxlh5LfIpuRi5E6xeI4EQsR1EleXHcPgVD7BpuSSpnOzNs9IPVV5KOQfNHTXM5wIWJYvEpCNFRTP4kMffhJzVh2yG3uGE1wAk6SaAe7WoMOPf5+BNsAgFE4R5r4IJuhT8H/G+QJdW7x1vRXiBIK/Ro8j0AVGOPPEhKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KeyMnErAkkkAjm5WKGlpeWYV/bSRBHtgJioS1P4vHc=;
 b=KBBYmuJ61mnLUXnd8vke2PSxQFUAg+5ZXxe5RhUpe7FDCxyzpGIDHprQEfwb/4M3rZPnrCluCjQLp7lsIWT0Uu1J98ksp06IqAHOOrDCEP6glHE6ePQXYJPSmZGQCey8hb04fmYm6Cq0w7ARL1sr1oMfeilU+IEJMBkd1hK7zMxJ240FB3BlIZyTrHbS+cMi9JtcZUAd6YCteVZV9iDaVYbzJ3BiRnToVvNLB4r9OeW6PR6TGWT15/Q1PYLlgeVVerwMlptWa1YS+iP84Jx35iFHQwPmwf/LzYi0KhkLqlXDh7+Hm8ZxAfJMbkiTFSNekkQb9slAI50V4oCnl/eU0w==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AS4PR04MB9624.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ce::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:04:23 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:04:23 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Topic: [PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Index: AQHc2F9QG/jCzwBBgk2TKFSsJndBkbX3Px8AgAADjPCAACpfgIAKw4zQ
Date: Thu, 7 May 2026 08:04:22 +0000
Message-ID:
 <GV2PR04MB12019F5425D6EB9AE52FC32CE8C3C2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-2-hongxing.zhu@nxp.com>
 <20260430-proud-ammonite-of-gaiety-abaafc@quoll>
 <AM0PR04MB52202A13D528B3AE16C3616A8C352@AM0PR04MB5220.eurprd04.prod.outlook.com>
 <55258a51-9cdb-451c-be06-74b9b3020cbc@kernel.org>
In-Reply-To: <55258a51-9cdb-451c-be06-74b9b3020cbc@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|AS4PR04MB9624:EE_
x-ms-office365-filtering-correlation-id: c4cd8584-9aee-46c1-d747-08deac0f3fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 UDbS6QF73rvZP4xiIMMDeDbFnINDRLcOYcfdNeWqwD3BXbqK2xtoqu9geF4MC5rEVMFKUhggn6N7TXtSMKqopjq72IgpVW2K+NOpNvEBqJOWTAYRd9UfBAJmXT11XdSYUZAcbUHJsKYogT5+UURpDW+GvZQCp+DApOYMp9XeVLpYI5y630/QztKC5jDwUZRZPMWCIJ341OcqmZ9STi21o1NO1Sw7VhegOFenp3QQyaaBIIJEH7RB9A556vE6lqrXR1qKtDYUjiJ+JcltfLmk6vYadDYODfcVErHH5dDPclG/+O+STdoxTC3IAfSS1/GQeAw+JP8K4zV8AlAKtk8nNyeXU/p9/bq8R/JuPMS1QV+5LnkQQKe8AFKXo1XyyJsafWcdWwQWNGDh+2o37gW2KARPc3R2vxmE/AbtchJGnuBGTLKGCmFGTt3ZQClcXbe2zqAcO0CVD1eKxKzcWh8bYDInUR9O9yT0bBnF4zZAU9kwnliK3++3PXuYXNu1mDVBSG5B2E6ozR3MB7/elYHspv8wLXHm/az9qe2mVIeHOFy6/CCJXl8d1+AtbJeGpPY46pJqOEse1CFSVb6PEeGwM9IQibviJawjUVF/LykNE3wFG/FnO7YjuuZW17hOffmg1hT8HS9ALjigfSV5t/jvjeWZKNkrdNgvOg5Us575EkLxkxquLsAl5Qcsq5q2ZrvZJyNzeaQ840T2/Ls3PdehMVrM53p2wW/f1xyGICkyLmfoT22eJ/v6MEgRlqzt3/xc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzB3dWlHMW50ZGdObk4zTVg0V3djME0rTDhPSTc2eDFqSk9QYWI5SldOaTlZ?=
 =?utf-8?B?ZFN3dXFuTkJUZ3Y5UGpDd1hhWGhtdnFHVW9rSDRjZlNGQk5xVUpPaHpCUFhF?=
 =?utf-8?B?V3ArQk1JWWdqZ3FCV3pyN0F1dk45RmY5emxKbkwrSWJjb1ZTNFp3LzdYdGY1?=
 =?utf-8?B?Y09KMXZrOFFjb055Z0l5dWhaTjFrcTBCL0paN0FHQ2VBVXZDTWRVN0FWaE91?=
 =?utf-8?B?OUwzVk9tL09mL015WkRFa0w4cDBQYTlRSnI5aHZma3JBcXNaNTJvZzNEVitq?=
 =?utf-8?B?QnRFdTAydFlIeHVOaTA2TDBpaGsxWDdsWm9RY1BlcUE3V3JZRmFqZ05JUk1k?=
 =?utf-8?B?d1dHRmNiWlliSG12QjdOMitIb3NjMW0vVU1nUFVzQlNQUU1BL2krL0lROG5q?=
 =?utf-8?B?elEvVHMydGtobXE3VXpHQjZGd2dTSUpDMklsak1ZWXNNdVlZTm5VMjd2RUor?=
 =?utf-8?B?ZzU2ZHBVZGpoUWFkbUpuR0EzbkZxYU54SzlINnF1NmxuQUcwT201Q1M3Zko1?=
 =?utf-8?B?Qi9sVWZLRlVTNTN6TGdweVVXalM3cUh2UFh4OWs1Z0RLTDQwSTN4eVV2dHhB?=
 =?utf-8?B?VmRTWGZxUVRvSEtlOGtNOUNWRFZtSkVaaG9BVkhzaWU2MFB0YlVjYk0xTE01?=
 =?utf-8?B?ck84akNja0dwTkVDeXE5d3lqdHNBbUt2d1kyZ1lRalFaWnBkK0RUNnMxenAy?=
 =?utf-8?B?bFp0aEZJQU83T3dKTmU4Z3VZZ2lIUENic2w4WGtLUlpRMFFpb0hTVDJnQUxj?=
 =?utf-8?B?Vmx2VS9xYnYwckk2NmplZlBvL05ncjg5SnRnUG1nekRKQ0haQ1hTbzBCTVph?=
 =?utf-8?B?Zi9ZcDZRMjlZbEdQaDZhZVh1V2lXeFkvU1RyY01CSXhIa1RDRFNrMGRoS0wr?=
 =?utf-8?B?VEwwSmp4SVU3TVQ0OUhhVmtQUmphTlRxZGdLVEJnZmY1blpnT0lXekhza0Nn?=
 =?utf-8?B?ZEcrVGl5THNVZXZjNndabUtPVDFONVlLRnVkbXVtUGdNS1JOS1ZLUFNyV0NB?=
 =?utf-8?B?emZtR2xsQXVZd254OHpTaVlLbHlBdUsrZUJzbWQ2bkZLVVNjUkh3RTF4cjBQ?=
 =?utf-8?B?MHlQREFkR2xTZzIveWV5OHhBTFhrWE92Zk5sSzM2b0R6ZDR2QldkaDZiRXFS?=
 =?utf-8?B?R09nbDVCK3ZyTkd0M2c3Z01HUXJjaHdFUVljT1ErUEtUY3ljbnZ3b1pWb3lC?=
 =?utf-8?B?NVdtV3dlajg4MWhhYTd4RUg0NDZ1a2dWOHRhUXRWdmJ0UUhpbTZHK205Rllv?=
 =?utf-8?B?QzR1dEYyWi85djhEakZkWE55S3FKK3gzY0hBQXY5cUdEM1lPRHJFSXptWlJj?=
 =?utf-8?B?M1ZZbWVta2JDR3IzYVJXS0IzczJvMUMvNEdSOUVoM3dCUTduK0NIQ29tTGpH?=
 =?utf-8?B?WVg5a1I1UEhXNWN5K25MNmpIUEh3TUFndFRPTG1tblNBelFoVHVLMlVnZE5q?=
 =?utf-8?B?OGFsSE9zME9jNFVyY2RRNHIwWDdsYWZNc1NNYjZkeUdKdytZaU9MS1lIQ2dW?=
 =?utf-8?B?c3hLUVJGNXJRTERZUmRXSjlkZjR0a0lkdGx1amd6Ym83Z0puOVdRWTBXQUt1?=
 =?utf-8?B?WlBvUitqRnZMelZyTGw0N0g3dmhEcjV1NW1GSTRROUhnV0FRRmFwL0FPNktu?=
 =?utf-8?B?T042eE54K1BpRUZHekZ3c3k3NE5tTyt5MmE5NGNUSUdiRURvTWVHU25ZRU15?=
 =?utf-8?B?aG1UUzIweXNsbndWS0hRb3lUU0tLMGNBNFNYZ1JMeWNEekkyMWl4N0dQd1Jp?=
 =?utf-8?B?a1ZwOVN0c2lUNUQ0ZVhGSk53MWtZQ2kyTUFZSzVFVU45RkVwM3JldzhZUkVM?=
 =?utf-8?B?My8yVWFYSXpPRHFIaDYwR1VnSnRySWphSWFzclBRcmJNSEowRXZWMnl0QTFN?=
 =?utf-8?B?ZDhQcjIwWmtEbkZyUU5EelAva3pJa0ZnS1F0WGJFcWFHdE5iUW5zbktGYTJH?=
 =?utf-8?B?ZUY0c1RRYXZhSythZklBMlovNFg3NUdMRWtQYlJlUGVLam90NThmQm1Za3I5?=
 =?utf-8?B?L3grcEg5OTNmMTM5OUhGVWI1VmppVHk3bUxYRUorYnZXOHJUa1k0aXRDY29H?=
 =?utf-8?B?SlN1L1FGWnRZdjdHOFRUTTZrY2ttNXcwUURRWjIxSTgvRUNMdW5ZeHVTanpE?=
 =?utf-8?B?OWhiYS9ZbFI1OGNUODVxYUtUaUxRUWJ5MllnSktvUC9VUjN5OWlBVWJJSDV3?=
 =?utf-8?B?MHQvS084NHQyNXlqa1FwR1dwbUt4a2dLempsbU5ibkdZMDZFbWpSbWZCSndX?=
 =?utf-8?B?M2tmbXR2MWYzS205bDdZMjd6Wkx1V2ozL3BQd3BtVUdiWWw0TE5PVGtlckc3?=
 =?utf-8?Q?NOqrIz0rtXVK+ix2Em?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cd8584-9aee-46c1-d747-08deac0f3fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:04:22.9113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8NY399x8RDRmbndE3zEwB7KI0e0PeVFwGj0VfGfVcwKSCHY0CKWIFkitW2niGbp4efb5Axc4kN+3ERjrebnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyNiA2OjQ5
IFBNDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcm9i
aEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
IGJoZWxnYWFzQGdvb2dsZS5jb207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2lsY3p5bnNraUBr
ZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC0NCj4gcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvM10gZHQtYmlu
ZGluZ3M6IFBDSTogaW14NnEtcGNpZTogQWRkIGludHIsIGFlciBhbmQgcG1lDQo+IGludGVycnVw
dHMNCj4gDQo+IE9uIDMwLzA0LzIwMjYgMTA6MzcsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMjYg
NDowNCBQTQ0KPiA+PiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4g
Pj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJu
ZWwub3JnOw0KPiA+PiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT47DQo+ID4+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9y
ZzsNCj4gPj4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOw0KPiA+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdt
YWlsLmNvbTsgbGludXgtDQo+ID4+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBQQ0k6IGlteDZx
LXBjaWU6IEFkZCBpbnRyLA0KPiA+PiBhZXIgYW5kIHBtZSBpbnRlcnJ1cHRzDQo+ID4+DQo+ID4+
IE9uIFRodSwgQXByIDMwLCAyMDI2IGF0IDAxOjA5OjUyUE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdy
b3RlOg0KPiA+Pj4gQWRkICdpbnRyJywgJ2FlcicsIGFuZCAncG1lJyBpbnRlcnJ1cHQgZW50cmll
cyB0byB0aGUgaS5NWDZRIFBDSWUNCj4gPj4+IGJpbmRpbmcgdG8gc3VwcG9ydCBQQ0llIGV2ZW50
LWJhc2VkIGludGVycnVwdHMgZm9yIGdlbmVyYWwNCj4gPj4+IGNvbnRyb2xsZXIgZXZlbnRzLCBB
ZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcsIGFuZCBQb3dlciBNYW5hZ2VtZW50IEV2ZW50cw0KPiBy
ZXNwZWN0aXZlbHkuDQo+ID4+Pg0KPiA+Pj4gVGhlc2UgaW50ZXJydXB0cyBhcmUgb3B0aW9uYWwg
Zm9yIGV4aXN0aW5nIHZhcmlhbnRzIChpbXg2cSwgaW14NnN4LA0KPiA+Pj4gaW14NnFwLCBpbXg3
ZCwgaW14OG1xLCBpbXg4bW0sIGlteDhtcCkgdG8gbWFpbnRhaW4gYmFja3dhcmQNCj4gPj4+IGNv
bXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBkZXZpY2UgdHJlZXMuDQo+ID4+Pg0KPiA+Pj4gRm9y
IGZzbCxpbXg5NS1wY2llLCBhbGwgNSBpbnRlcnJ1cHRzIChtc2ksIGRtYSwgaW50ciwgYWVyLCBw
bWUpIGFyZQ0KPiA+Pj4gbWFuZGF0b3J5IGR1ZSB0byBoYXJkd2FyZSByZXF1aXJlbWVudHMuDQo+
ID4+Pg0KPiA+Pj4gVGhpcyBpbnRyb2R1Y2VzIGFuIEFCSSByZXF1aXJlbWVudCBmb3IgZnNsLGlt
eDk1LXBjaWUuIFRoZSBpLk1YOTUNCj4gPj4+IGhhcmR3YXJlIHJlcXVpcmVzIGRlZGljYXRlZCBp
bnRlcnJ1cHQgbGluZXMgZm9yIEFFUiwgUE1FLCBhbmQNCj4gPj4+IGdlbmVyYWwgY29udHJvbGxl
ciBldmVudHMgZHVlIHRvIGl0cyByZWRlc2lnbmVkIGludGVycnVwdA0KPiA+Pj4gYXJjaGl0ZWN0
dXJlLiBpLk1YOTUgY2Fubm90IGZ1bmN0aW9uIGNvcnJlY3RseSB3aXRob3V0IGV4cGxpY2l0DQo+
ID4+PiBpbnRlcnJ1cHQgcm91dGluZyBmb3IgZXJyb3IgaGFuZGxpbmcsIHBvd2VyIG1hbmFnZW1l
bnQgYW5kIGxpbmsgZXZlbnQNCj4gZGV0ZWN0aW9uLg0KPiA+Pg0KPiA+PiBmc2wsaW14OTUtcGNp
ZSB3YXMgYWRkZWQgbW9yZSB0aGFuIHR3byB5ZWFycyBhZ28sIHNvIGhvdyBpdCBjYW5ub3QNCj4g
Pj4gZnVuY3Rpb24gY29ycmVjdGx5PyBBcmUgeW91IHNheWluZyB0aGF0IGZvciB0d28geWVhcnMg
eW91IGhhZCBoZXJlDQo+ID4+IGNvbXBsZXRlbHkgYnJva2VuIGNvZGU/DQo+ID4+DQo+ID4+IElm
IHRoaXMgd2Fzbid0IHRlc3RlZCBmb3IgdHdvIHllYXJzLCBob3cgY2FuIHdlIGJlbGlldmUgYW55
dGhpbmcgaXMgdGVzdGVkIG5vdz8NCj4gPiBUaGUgYmFzaWMgUENJZSBmdW5jdGlvbmFsaXR5IGhh
cyBiZWVuIHdvcmtpbmcgc2luY2UgdGhlIGluaXRpYWwNCj4gPiBmc2wsaW14OTUtcGNpZSBzdXBw
b3J0LiBIb3dldmVyLCBBRVIgKEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZykgYW5kDQo+ID4gbGlu
ayB1cC9kb3duIGRldGVjdGlvbiB3ZXJlIG5vdCBwcmV2aW91c2x5IGVuYWJsZWQuIFRoaXMgcGF0
Y2gtc2V0DQo+ID4gYWRkcyBhbmQgdmVyaWZpZXMgc3VwcG9ydCBmb3IgdGhlc2UgYWR2YW5jZWQg
ZmVhdHVyZXMuDQo+ID4NCj4gDQo+IFRoYXQgaXMgbm90IHdoYXQgeW91IHNhaWQgaW4gdGhlIGNv
bW1pdCBtc2cuDQpIaSBLcnp5c3p0b2Y6DQpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2Ug
ZHVlIHRvIGEgaG9saWRheS4NCkFmdGVyIHJldmlld2luZyB0aGlzIHBhdGNoLXNldCBhZ2Fpbiwg
SSdkIGxpa2UgdG8gc3VnZ2VzdCBhbiBhbHRlcm5hdGl2ZQ0KYXBwcm9hY2g6IHdvdWxkIGl0IGJl
IHBvc3NpYmxlIHRvIG1hcmsgdGhlc2UgbmV3bHkgYWRkZWQgaW50ZXJydXB0cyBhcw0Kb3B0aW9u
YWw/DQpUaGlzIGFwcHJvYWNoIGhhcyBzZXZlcmFsIGJlbmVmaXRzLg0KICAtIFRoZSBjdXJyZW50
IGltcGxlbWVudGF0aW9uIHdvcmtzIGNvcnJlY3RseSBmb3IgYmFzaWMgUENJZSBvcGVyYXRpb24g
d2l0aA0KICAgIG9ubHkgTVNJIGludGVycnVwdCBwcmVzZW50Lg0KICAtIEl0IGF2b2lkcyBpbnRy
b2R1Y2luZyBkdC1iaW5kaW5nIGNoZWNrIHdhcm5pbmdzLCBzaW5jZSBkdC1iaW5kaW5nIGFuZCBk
dHMNCiAgICBjaGFuZ2VzIGFyZSB0eXBpY2FsbHkgbWVyZ2VkIHRocm91Z2ggZGlmZmVyZW50IHRy
ZWVzLiBUaGUgaS5NWDk0MyBQQ0llDQogICAgd291bGQgYWxzbyByZXBvcnQgZHQtYmluZGluZyBj
aGVjayB3YXJuaW5ncyBpZiB0aGVzZSBpbnRlcnJ1cHRzIGFyZSBub3QNCiAgICBtYXJrZWQgYXMg
b3B0aW9uYWwuDQogIC0gQUVSLCBQTUUsIGFuZCBsaW5rIGV2ZW50IGhhbmRsaW5nIGFyZSBvcHRp
b25hbCBmZWF0dXJlcyByYXRoZXIgdGhhbg0KICAgIG1hbmRhdG9yeSByZXF1aXJlbWVudHMgZm9y
IGJhc2ljIFBDSWUgZnVuY3Rpb25hbGl0eS4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhp
cyBhcHByb2FjaD8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0K
