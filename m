Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6843FE350;
	Thu, 30 Apr 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538244; cv=fail; b=SXdrzWWtWob9j8x1xmNelmytfSBSOdK7YFS0OSa93PFkVP4qkG+8TcqNuwYW7Ze3b8hTfypnv3/kepuREtxsLyWrAC2XIDxJ9uP5zow/haBesbV7hICGPrSPyL0ErgGGYELoBZZtS8Fgc4RSIpFOYrJw59cIZkHD5hnRpZPR8c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538244; c=relaxed/simple;
	bh=IWYq0gbhCDCmWd1UbcKPSt4ll1wLEXOttHA0pGmK8/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJvGedp7xHCwt0qw9gREVsapzV+9fRthELLZLYB6lXorWN3zCMNcKQmLsupfYY9+4lkcO3gli03MxJstVfi2adCACi4M8Vv8ilJFDBG7XJJ8UA4i+7XDrTMwycFlzLnLPoafyvMdjs9fOGAtJHXGIxVEorVC7j5QMBZWhbPnAUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WHiZXoZL; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WHiZXoZL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoMzQvgyEIeXk0SqtCqgHswmKH4oIo+u35egK8yi3B0Li1nf9rWV82G067AP9pRxcNChIIZg4QjDtymOeEfXkBIyMZAm92x2+wILsXEoDLlJRSvpx6+EPRvZ62KBRBPiyMc7RA0Ffq/P1Ft6oi3/f3H7g51TDP9Dd/pUXNXrXBUcgW+fUdr4bZ3jIXohojn8T9VQEco3bK9d3Rd5sD0YEo1gvWSSIM94TbkmQ14R15cqnijB5xLZxlP/skYx8uJZoYU1EBj2Z0FJiUs3KjkKE1K7YyIIhsqKF4manTzX0e4MJmvr9RYWbMLfZs6Tey1gpR1bYa7SAZBVWR6PYf1/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWYq0gbhCDCmWd1UbcKPSt4ll1wLEXOttHA0pGmK8/M=;
 b=VAWpeijp4BYIwZrHeKn0Okx4lkU3Waffpy176uXRmx4Lg29PNoKftP/PVcpJF0tDzblDLN+K/tdAwKUwpSaoADs4RLzuoFe+Eo3Qt2e3jzTt6+vVu+Bb8FRoonuQaLRxpPJP9+DFJWrgos9JjpOZjSFOa8/ISRpIt9B8TBoteVqOICAtCNoPqMkO8e8vxcKdyYl/sorzMNWOXNUr3RKWFcgrzqPOba+ewt4En4GgOFzm/D3fIXw7bfzIQ7VEcn2jW2BNuK5mfQOIbDEICXbwhN23vUjmwNNLVjNTfijL66rQfmV2bcqo15+APdtaONQZ+W2cQEto+uyE6+lbaxM1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWYq0gbhCDCmWd1UbcKPSt4ll1wLEXOttHA0pGmK8/M=;
 b=WHiZXoZL/nLcPKy5acz6P6TshojBMKvloGYxUQdEhtX51GXvzEdGIgOaRqGx5czYuyxML2LaI4wqXq7W5K+GH0W8n9wBxM9NMvCz/IlocgaatkNNOK6POEq2TxcUU3Nq9A0IZkXHq2P4r/JnMY8nLmwDgqSf/+3f9G0jSNS70wx2nZazXNdOt7Wznyd5/ryu+nZHPJECOF4nMRnvJiqZ6eYrGa6cXu0t0WdmBlrqA7oCoGwQhGZDql4Q1CBA4PDOalrql1dgzzQNmFtIajl4YBM3/+659WbuRpxleXt+Chuqxgk8se2ELGu+6tOMLP6ZsNwbLwbcQyxjcq68MqoDWQ==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by DBBPR04MB7706.eurprd04.prod.outlook.com (2603:10a6:10:208::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:37:20 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 08:37:19 +0000
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
Thread-Index: AQHc2F9QG/jCzwBBgk2TKFSsJndBkbX3Px8AgAADjPA=
Date: Thu, 30 Apr 2026 08:37:19 +0000
Message-ID:
 <AM0PR04MB52202A13D528B3AE16C3616A8C352@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-2-hongxing.zhu@nxp.com>
 <20260430-proud-ammonite-of-gaiety-abaafc@quoll>
In-Reply-To: <20260430-proud-ammonite-of-gaiety-abaafc@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|DBBPR04MB7706:EE_
x-ms-office365-filtering-correlation-id: 44338471-0e2b-4236-4168-08dea693b150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 hKHPve1sfSXaeaxQTtndEO9O/aVJKKjr9a4980+RgP+ba6LnPK5b9zujtuQzpibrLtnfuEA8S678wlaOYvl5NnY015ocC87/YfFKri42ft0FOJSi4HPHvXOXnUNYO5rR5f4lCSifnDAp77dLBaTPRUslLL9gQN0fbiJAC5qq/FhqwjBhF3P8IPdD2xjaUm7sQGMIpslB76odujwlqevmj1x5ryhHBDLEaUgZcfIGSDcbHAMBe3M4ZeEHCiif5AtQm5psX83yOBo1HkpGn1S3QZgYKKCJdY6FGEy2uu1RcGOb/slyv6GBdX6FyJ9KQAtPrur+mame+Hp3JTGuA8ZOT70WBohMfL6xt22oq4YquP6wlzci/1Wqoeg0Xn8Ba1RGld6MmVJBrzexamjnpuQNtBvIyiUqe2X36YJGCBu3HgREiDuR4JklFxHuy8vcCiutvOqDmh3Od1luVQEojPJBRr0x/0h6V5EYpJv7lb7IWX8ycT4qI7bVVFY2lizIMwtWtWKp7oGKcus4acNFGnriFkB3p6ybVAg0UbqdM1OpG3DfvZxeJsh0zNNQVxNJS2o4MeuT41g9lH6pq61WqKfE7l+H3v2UIlUlNp944/brzlvo9Xv5wUDyhxQKX11ttz5Jq2BDg+0ljr6kJp1cxeQGhjfzqvNletC54o4YHEzJLpN5gbwIhNvw0gXZjR+kIcOxBt85cfYWgof7Q6RMqlkR4UlO035AAKyEnry/Qn9PdyFHabE4tf5+XOauGkigzyhPV2wZnCHZ4ulDAuiQewAnxlg36Hl58/+sxEuk5wmZrwE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MS9JK0JoUTFIOU1zc1gwcTFoWFo1cHhxNEQyY3QrcGR3bjBqbS9Bbk13WnBx?=
 =?utf-8?B?YjZZUGxuK2RGME1YZSt0SHc5dXJTS0VXcXhLYmVJbnlEb3FJemdsdm9aVE1i?=
 =?utf-8?B?TlpRUDZYdGF0LzZtTXgxL2Z4NmNnREVvUjhLOGg5RmZPcHhQdDNpWW53ZTZi?=
 =?utf-8?B?b0hwbVZZRzdxMDRibG92L1VhS2x6Z0pta1V1WE9ZOC9xWTduZjYxa2NVeHJU?=
 =?utf-8?B?elVPV2xjNkxkSUZBMEJGNGRvUE0ybm9teWg1K1ZPSmZqRlh1ejBHNFdWc28r?=
 =?utf-8?B?STBjbWFsL1ZEaDZ5TkFFZjZlNmxRMGNadFYvSkxVRGV2ditFVU9mcVJha2o1?=
 =?utf-8?B?WkROR0R5cmpza2RuZEliS0t5NzhpMlpSTFJlak55SnFFNklyZDdYUExXUzlS?=
 =?utf-8?B?eFVDYWlEbGRwcENSZGdFY2taNjZwTkIzTGJXQkp5Z3JZanlQRUt3cWFBbm90?=
 =?utf-8?B?c3hBUHI4TjZnekFiU3Zxd0RxdFk2OUQxSTk3TURGZUpaMDRsUGNNZXlGcjhk?=
 =?utf-8?B?WVNxUEVIU2p2Mk9oRVVXd2RocFJyYjFnSnRvSFlzNHpiQXZTSjhKUjRxSWt1?=
 =?utf-8?B?WVNvdldaL3VKdW9LdDA0T3lUNU1KdWlVN2plcjVFcjFxTTdxQXJxRnBZMWY4?=
 =?utf-8?B?Y1lGRUtSeDh1SzJoNFFuY0pyZHJYeU5yaldnNjhNUmYzOTRTeE5LQm5RWjBp?=
 =?utf-8?B?cDVnSjdSa1kwZzdTd01iNy9DUThTeU9NaERLeHFQSWUrM1M3djlLUlgrL09T?=
 =?utf-8?B?Vzh1Sm1XanhjSWZ2Qm5zdzd4bHEzZm40dExxQnZGRUx5a3pSR1o2d0UwN2hn?=
 =?utf-8?B?V2laSDFnbVlCb0RkSHRIaVROcUhDUzhBN1lta0RYQlBKbzhtNmc5OUJ5bFFn?=
 =?utf-8?B?TjVMSXlWS2thZUJJK2UwaS9vbzJ4a1p1ZlZvY2l2L2xydzFZTDVWdDV4Qmx5?=
 =?utf-8?B?Z3VTUkNYNjh4TXRCNHJQZ3NaNGFESVkzMjluSzJlTVpYZWVLMWdxWmNkNnFK?=
 =?utf-8?B?RDI4R0x2T3IrODdDSC9lNGFWR2wzM0t2VHZxTHNZUDZ1cC91YnU3a0lJWnVk?=
 =?utf-8?B?Qm9ranFPaTlTWVhIOE12b3hYL01ZaXdwdlJ6TElvZVNqcmc4R0VMaUV4RDgr?=
 =?utf-8?B?SHdaZlYxYjZ3aTJlZjR6VHdtRTRVLzVyN2w4OXNTaXJML3hpeFhWMHB5MUpN?=
 =?utf-8?B?b3VVVG5LekNCUUZpL3RGTFE3ampsU21xU01yUXppcitLSWcrWmZUYjM1NU5p?=
 =?utf-8?B?YTI5QzBySHl4bEdBaVVYblRMTUJxajhNMzBCaFRGWlVjUlIvVUZaMTVFRlZM?=
 =?utf-8?B?YlNDc2ppbjBaSThVQnlYSHBGTE0xQUFhcWlLQWZHejRYQnRJMTVkUkVsQ0Ra?=
 =?utf-8?B?Vko5dEdFbXI4cGhsVnpHcVhPQjFrWjEzUUNacnBhRHIzczMrUzNKUkJVRnNC?=
 =?utf-8?B?WmFWSWdCaU1OQjI4Q0JHNnQzZHBKNEM2dTVGcW9CeWJGTnY5ZmY4RGhmU3F4?=
 =?utf-8?B?MkEwR051Y09HaGgwN2ZKMlZ6azF3WjJwbjQ0aFg5NkZxbUZOU0lYTHRMK3dj?=
 =?utf-8?B?VEx0M2FPVkNRdlJKVGtkRUNjekhYR2loQ05OUnVxNFd6QUFpL1FrZWw1R1Iv?=
 =?utf-8?B?Tm5haU9IeTltUVZNUk9xNTE1eTNEZUNpMTlOMjA5eCtEKzd3dFlEclJuWTlP?=
 =?utf-8?B?U3ExL2JlQ29iZXB5RU84WFFRL2RMZXBYY1N5S0lwVWJKV0hpTEp4TkFZN214?=
 =?utf-8?B?QlhRK1RMcVBsSC8yYkJuZzFwVDhha3AwblJJUU56b3BBK2lCaTA4NnhZWVgy?=
 =?utf-8?B?Y00zclE2S2tIRlFPbVBLYnlmNmhTS3ZSZjFLamU3TE9IblhsUlBzOEhFaUxH?=
 =?utf-8?B?bnl6REZmTGRmclNOdmRKc1Q5QjJzeU9tUkJYYVZJY3NGYWtVQ3Y1V3FUa2xY?=
 =?utf-8?B?eUpzZldKMDRBYmFON0dDOHlhYTFaSVM3ZXZGZld6Z3lOb1RVU2l2SUdZMEoy?=
 =?utf-8?B?KzZlK3BaZEFlbno5S3VOVXFiOU9XSjhkY083Wk9LalhwQ3BrZFNMKzgvUEY4?=
 =?utf-8?B?KzArR0N5a1dwTzVVZG5tTFBiNUNVNmZ3TDRWYy9ud1lrdU5uU2M4MUQrK0RX?=
 =?utf-8?B?REpIeC9EWU9HbXJJYTJUYXo5QU1xUm9TbStxOU9aTldCTnF6Zld0dUplMFZ6?=
 =?utf-8?B?S1ExZWJkRnRGVUREejBDN2srczE0d0pXL3NOR0d2NE05ZkZCcE5Rc0k0WUlQ?=
 =?utf-8?B?WmdKdys5NXZ5d3BMOUFpVWRCLzZ0WlppcWxqL0hJV0JRRU5IWUlPR01JNFN5?=
 =?utf-8?Q?URqIP7PRZIwUz41ddT?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44338471-0e2b-4236-4168-08dea693b150
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 08:37:19.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMJn1/vHZpKSqk7dxfZomftjgRjSP+QhZoQypZup3qTM87m9sAy1IHxOpuesj6EAnxsY8IVmSCxkxCWoB5JE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7706

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyNiA0OjA0
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
dHMNCj4gDQo+IE9uIFRodSwgQXByIDMwLCAyMDI2IGF0IDAxOjA5OjUyUE0gKzA4MDAsIFJpY2hh
cmQgWmh1IHdyb3RlOg0KPiA+IEFkZCAnaW50cicsICdhZXInLCBhbmQgJ3BtZScgaW50ZXJydXB0
IGVudHJpZXMgdG8gdGhlIGkuTVg2USBQQ0llDQo+ID4gYmluZGluZyB0byBzdXBwb3J0IFBDSWUg
ZXZlbnQtYmFzZWQgaW50ZXJydXB0cyBmb3IgZ2VuZXJhbCBjb250cm9sbGVyDQo+ID4gZXZlbnRz
LCBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcsIGFuZCBQb3dlciBNYW5hZ2VtZW50IEV2ZW50cyBy
ZXNwZWN0aXZlbHkuDQo+ID4NCj4gPiBUaGVzZSBpbnRlcnJ1cHRzIGFyZSBvcHRpb25hbCBmb3Ig
ZXhpc3RpbmcgdmFyaWFudHMgKGlteDZxLCBpbXg2c3gsDQo+ID4gaW14NnFwLCBpbXg3ZCwgaW14
OG1xLCBpbXg4bW0sIGlteDhtcCkgdG8gbWFpbnRhaW4gYmFja3dhcmQNCj4gPiBjb21wYXRpYmls
aXR5IHdpdGggZXhpc3RpbmcgZGV2aWNlIHRyZWVzLg0KPiA+DQo+ID4gRm9yIGZzbCxpbXg5NS1w
Y2llLCBhbGwgNSBpbnRlcnJ1cHRzIChtc2ksIGRtYSwgaW50ciwgYWVyLCBwbWUpIGFyZQ0KPiA+
IG1hbmRhdG9yeSBkdWUgdG8gaGFyZHdhcmUgcmVxdWlyZW1lbnRzLg0KPiA+DQo+ID4gVGhpcyBp
bnRyb2R1Y2VzIGFuIEFCSSByZXF1aXJlbWVudCBmb3IgZnNsLGlteDk1LXBjaWUuIFRoZSBpLk1Y
OTUNCj4gPiBoYXJkd2FyZSByZXF1aXJlcyBkZWRpY2F0ZWQgaW50ZXJydXB0IGxpbmVzIGZvciBB
RVIsIFBNRSwgYW5kIGdlbmVyYWwNCj4gPiBjb250cm9sbGVyIGV2ZW50cyBkdWUgdG8gaXRzIHJl
ZGVzaWduZWQgaW50ZXJydXB0IGFyY2hpdGVjdHVyZS4gaS5NWDk1DQo+ID4gY2Fubm90IGZ1bmN0
aW9uIGNvcnJlY3RseSB3aXRob3V0IGV4cGxpY2l0IGludGVycnVwdCByb3V0aW5nIGZvciBlcnJv
cg0KPiA+IGhhbmRsaW5nLCBwb3dlciBtYW5hZ2VtZW50IGFuZCBsaW5rIGV2ZW50IGRldGVjdGlv
bi4NCj4gDQo+IGZzbCxpbXg5NS1wY2llIHdhcyBhZGRlZCBtb3JlIHRoYW4gdHdvIHllYXJzIGFn
bywgc28gaG93IGl0IGNhbm5vdCBmdW5jdGlvbg0KPiBjb3JyZWN0bHk/IEFyZSB5b3Ugc2F5aW5n
IHRoYXQgZm9yIHR3byB5ZWFycyB5b3UgaGFkIGhlcmUgY29tcGxldGVseSBicm9rZW4NCj4gY29k
ZT8NCj4NCj4gSWYgdGhpcyB3YXNuJ3QgdGVzdGVkIGZvciB0d28geWVhcnMsIGhvdyBjYW4gd2Ug
YmVsaWV2ZSBhbnl0aGluZyBpcyB0ZXN0ZWQgbm93Pw0KVGhlIGJhc2ljIFBDSWUgZnVuY3Rpb25h
bGl0eSBoYXMgYmVlbiB3b3JraW5nIHNpbmNlIHRoZSBpbml0aWFsIGZzbCxpbXg5NS1wY2llDQpz
dXBwb3J0LiBIb3dldmVyLCBBRVIgKEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZykgYW5kIGxpbmsg
dXAvZG93biBkZXRlY3Rpb24NCndlcmUgbm90IHByZXZpb3VzbHkgZW5hYmxlZC4gVGhpcyBwYXRj
aC1zZXQgYWRkcyBhbmQgdmVyaWZpZXMgc3VwcG9ydCBmb3INCnRoZXNlIGFkdmFuY2VkIGZlYXR1
cmVzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=
