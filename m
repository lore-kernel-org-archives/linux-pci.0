Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B943FD15F;
	Thu, 30 Apr 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538253; cv=fail; b=YqrRkFuKhP7TZp2vY+HcwlCqp5wwpwITLa+XjhH/lK+bKamSZ3JHfoj62oMKCzbI1HnCnlFv++g4oRbW3CulYhQvEnPj/K4nIpoS6oK7a7cGjvLG0Lbh6bgPveQB3V1kvTKU8TGUezvhR9BIE0FKI0I+3Bc8fv/IlhPEvoR8jBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538253; c=relaxed/simple;
	bh=7HmcXHz39t4yUkizs1jrMq2noXoUnFCjhJMUT6SAbBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlUu8ZRG8muSpr22vjHwo4O2jHa77FNC/23la6xzF7vGuaDvyz6aqo79z0slY3rfMxzdm/bvh6Zr0kCmJ6KtUvkM90Sg0iaFs+0cyGntTAsR3fqrnZsqqbQMQJhVq2TaE4FefPcR8Ks4TtWio1+RYSDKzN1dqMp6yEOSsGvTfJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cLm7mqrk; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cLm7mqrk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P26ouXw0FiuIedFiflD1/DeOVWxGGisUZhmMZtr5adW3MzDmoemkCfbFPwKJEPqR2t+Y2C0DhdGgjVU/DSlcKHfi07/tdhyAdahvHAWZHpAaEU8AZc83NpbJvLqVaTqrW+iK9H2592ZrwaGLXIY/il15LbmtRY9srtND794tSKiGujcRrOMIXzgBTrv8r9+FLoOlrFUlxbTiTYanFc64/MeD1/MbwH99wJ3eytinHe69s/WC29TKLqmrDo/gaWvhwtgb7UjPbr8N9l4iDj4ru4pyPZubYEZhz2QTWv7X1R2qRuTbktwbmM3cTbD1ggp23wynDOxLyhea3F4BX6WWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HmcXHz39t4yUkizs1jrMq2noXoUnFCjhJMUT6SAbBo=;
 b=qohpCRrJVM1iIRzCMIawoLXLntU8jakVB1EfKo2Dl1Hl516StknYxlnGbfHcRbyV+rX4GFgDrQA5Q6nqwGG74Dh7vu4Qx8PVv39kbKlUSIFrKA2pGWreiOqQNU/Lak4OT6ZBI9hCD6ey+AxODb7WjC8F8kHdo9jqQXaSna6bK2i/LMprjBS25BcY4bcfTmBl56CtBXiWAMtkFKLxPSuZMljWi9+MCsXj2n5zihZpHnJLTjQaCiLDpKNw2x7f+8KqFyMXRyRBWbtORvISmPem8HeQEmKJxPkWOdu76H3rV+qFEBgtSDlIYArdiTfxQLxZtMqFX+xg/55bpTrhaDWeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HmcXHz39t4yUkizs1jrMq2noXoUnFCjhJMUT6SAbBo=;
 b=cLm7mqrkcdOmdZsZWMjuVDtVwr1k5m2fwFANNIYN9WzVN+XAgcMCjOMnOKTzuDlTDRu/kpe6vYSj6432uNMIXU+fGGGfe2bG+j98K/fCb+n1imwUsIQZvSLqKcIOW+7TmoQ93edrBBZ/vspCpViWwi0gEN947Ho/8lxykelj/lqh//5xIW3QUPC5WA41mnc3rTS9jJuedkAeJw5YIw/z0cNpikwNeMEUJHTYXJZWP7QjEHGgaq4ZHhERcRL8u0Y+xt180xFSinS/yYacUOOyif+GmeUel18M0iohWsa7g+S7N/A37o+9GOfJPgohMhNJGLhgXjYCTtqC6QVZEyHU+A==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by DBBPR04MB7706.eurprd04.prod.outlook.com (2603:10a6:10:208::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:37:28 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 08:37:27 +0000
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
Subject: RE: [PATCH v3 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
 interrupters for pcie{0,1}
Thread-Topic: [PATCH v3 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
 interrupters for pcie{0,1}
Thread-Index: AQHc2F9T0LwPqaUyUUaBiOO3uEdVu7X3P1QAgAAEoaA=
Date: Thu, 30 Apr 2026 08:37:27 +0000
Message-ID:
 <AM0PR04MB52208A6081E971A8BF05B2888C352@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-3-hongxing.zhu@nxp.com>
 <20260430-adaptable-wonderful-hoatzin-e1056f@quoll>
In-Reply-To: <20260430-adaptable-wonderful-hoatzin-e1056f@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|DBBPR04MB7706:EE_
x-ms-office365-filtering-correlation-id: 76680b5f-6668-45bf-3fe7-08dea693b5a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 OMDkIyGY+z5dB0rMST05YapFYoLdXa7BWo35dQSOAEmf70L+fKfvCVKGLzZp6UNFpKeM56B2Cu+6/jENCDKTTV8g36ot+rvQwnVn6+RvOJ+lP1hyyiAtYAHHJm8wwH1Bum1o0Q6xXxNo9P/PZJIV3j7I19WYOqQVLsXzuEg21uKbMn7hN4xuI0vIlNNzZrGySkkYTSV018n1LXu2rI9bil3Jz0S3yO4oEUDh2/QFaF3uXiQtOTrZjgaphFw3gQe0NRxZptwDeKLAYa+Yh1NClKSIZNX7mr1yZO3tv59MjXWSpLoY81AkJ9TUkXnI4rTGC33pqa+SSQthpRgYIkYZ779upEkrAbBTi6ZPsrHUSF21gObfOE4Bzn1UP8tVmp47wLkukzSepwIMvTaalu2WJp/BaVoeP18587b6LhyrAn9lalDN/KVXUWDksThXsxpl/xrZqSlppOPdGwFsIzrhPR3OneDVApgxbx7hFa8jclo+Tmk6rO/uASSQCL/IbNAIcQthuNUwWuH+1jzDXw/0ggOErkUGLp346b9/VGxatuxYY6l6zz7wvWTLZWPWL52euPcB8KdXe7912Fyp8UjD2K9/fPA3GvHxNJNAHnUp5wo9LkLmqpzNa7V1pPfQAOdzyXcUfhMrOEP7F+a1eh02RfPYIomkpp/9YQtla0OimQM4cCVibk51oLQpLzCLuX+bdIJCTi3z+Va8/A1DLPMcmHaVGPkRUzRCSkwt5TU6PxcsRLozOO6O0UkQ/Cows0Gp1SgYL4dYejpmz++hKptYC2IDUYz/TR+cOooMB/JZ8vw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWM3dzlPa3lGZEpVZkFjY3ora2lucmJST0JyYzYvcCtmUENDeHRscXY4bDlq?=
 =?utf-8?B?ZnpJTkxpNTF5YkNuQTkwV2l0MlhJd3pOcmc4TjhSOEQ3RUx2ZlpjUi9hR2Qz?=
 =?utf-8?B?a0VnclF1cmVFUHRXZE1PWSt4TmJWZ0JYRzNYaHZMK1NyaUhZdVR5Z0svUXF0?=
 =?utf-8?B?Mk0rWENEUk5mRU1xTFNOOXIxbElmVVNKaENaei9NcUEwNlZZZ0V6dTVCbFdJ?=
 =?utf-8?B?QzJKaGxhRkRQMi95Y2xoRFdxTmJ4TThQWVZGejV4UUxVR0JpT0o0TFV2UHFI?=
 =?utf-8?B?TWQ5UVl5MU1WK3F6ZnpYM2ZReVZ5c1d0b2RybzlFQm5Gd1hpczN5dTh1S05t?=
 =?utf-8?B?WWRiVFFIeW1MVUw0cU92RGpMNXJOWUVwZWZqVjR5T3dnSFpyS256ME5pYWg2?=
 =?utf-8?B?QnE2K1M2bTcxMVMrWTlaQ09CbXF5WVRNTStIb0N3VWhUaTMxODNhbEJSbFZk?=
 =?utf-8?B?Q3RlNTlKaDlJZ3ppb0FwKzBYbkJ1NThmYXlaOENpYjlnbWdMcWNqYnBCQk15?=
 =?utf-8?B?dDVRdlZiR2Y4c2M4c3ZhQ0FUeDd5YWYrd0x1TGFmd0NCMHVxWkdycitMMzRF?=
 =?utf-8?B?VzRRcUJoUDZnbW40MFpERUlWQm9rUlhzZnpQVDdPZzh1ekVpbmZweVZySTBJ?=
 =?utf-8?B?MGZudXBHVzM5UllwZnpOL1ZZdEhxVWQ2VnhwZmd2Wjd2Lzl0T2dUbGZ2cVZD?=
 =?utf-8?B?Umx2MnFJR2EwR2JyajdpME4zOUh3UmNrS01Fd3NjU2hWZDV3Tno3SFFYTFI3?=
 =?utf-8?B?SEk2dkRXNjRDS0R5a2JWbG5jWXNpT1dSdDBuY2RwOUdKRE1OR0paNExmS0RB?=
 =?utf-8?B?a1VCT2tVL3M0bi9pL0hVcVlMS2Z2NjNhelpGdWZXOXJRbFRKV2ZUSDhrL1Vy?=
 =?utf-8?B?ZmxWTkdZTHQ0dHYvSytndExFSjN0T1I5Wi9zSTNYZFZsa25ZakJFM2RxTVdy?=
 =?utf-8?B?c0Q4RXlMWW0rWEpYcTFNY0JsNnRjbC9pbHI0RExaUmg0MDdYOEdIRnVYZHh6?=
 =?utf-8?B?YVY5NERPVk9jVnZpR0tlVkl5T3ozWXJYOTd5dmZENFQxNXRZS2hLZ2plZUdY?=
 =?utf-8?B?MWE1a1RBS2doZ1hzcnZuWHg5NUltbXgvR1RVaUkvTVRqWCtKM0VXaHZmbWF3?=
 =?utf-8?B?SVBRQjJGNzNXRkxxQ0M2NC8zSzZlMnpwV0lVMlRWbjkzeW0rVUp2czUwUWFL?=
 =?utf-8?B?cjA3M0VlYzJIbTBUdS9zcmhKWVRyYW4vRXNSaDJkd1BiYlJVNTlGd3dVRjRr?=
 =?utf-8?B?QS83N0IrdkpmVVZvYVV2dUJueVBKTGFtQ3dxNWZFSXhlYWNuZ0I2anhhNVFq?=
 =?utf-8?B?dE1KVTNReUZBMm05czRrcTRlUDBPNGZwWFBpWmVhSXd2OU4yU1VYTkRUZXZB?=
 =?utf-8?B?V2VNaEl3RXNYcjlPSVliTDRGVXBZMUxmMUhJK0t6d3hyaGJpaXlETXJYTlpn?=
 =?utf-8?B?R01wOWF6aDV5dGQ3MnB4UXZVQ3BXSGppM0ROWFYxSEQ0Vk8zdkhKVHBmYjhp?=
 =?utf-8?B?UCtHS29JVWl3bTRlR0p2cm1pamxlNFVnQXF1TEVDcnZEanhIV2NnL1g3Snp4?=
 =?utf-8?B?S1YxeGRqS1NOYWN3K01FQXFpbGR3dEZYN1BoWC9RVUhoUnNFQm1xSHM4bVQw?=
 =?utf-8?B?KzFnMHNSTTNhU1JqK1hLaUcxS1ZhaTRJRk1tLzJQVnc0akJLazZyazZVWHc3?=
 =?utf-8?B?cDh1REJFekV1U1IvTXlRRWNnN0Q1NDJhQWhyUDhhZ0xkZERzbW9oVEgwV2dG?=
 =?utf-8?B?SStWeDlIWXo3dklnbVdoZVBCNXF4RXhlV3p1M0lrY0VUaHJLNlhzT2Z1eFdu?=
 =?utf-8?B?L0FpTDNPTDdaMnN6bk1LbWVpdjFJcWhnSE9OY0N4ODZ3bkhJbGZCd0NZK2xE?=
 =?utf-8?B?cm9oeVd5TVg5RUtIMlV3QTl6WEF0akJHdXViOVovdjNtQ2duZjFvbmZ2cGcr?=
 =?utf-8?B?QUZRWEZkaUMyYU4rRFBqMlpzVWY1MTFuZG8zRFhqdGI2b2NDT0NtY21zMkhU?=
 =?utf-8?B?N21wTDQyTnYwYXVRQ3RkWGFpSUZEdU1hVGsranluMm9zYmloZTRkeFU4cjQr?=
 =?utf-8?B?UnA5Vmk1R3FXTGtVSGVPQ3dnVzJyMXM0VDUwSW1ESThLZjduczcvWGdmUURm?=
 =?utf-8?B?QUJqRTgwTVliLy9uYk9vOFMvNEFpQnNHbFNWK0RJZGlqcHNTbk94VWZRL0VZ?=
 =?utf-8?B?QzRSeTd3TnZPKzNTRzBKcWpTTmxrWDZkRlBjc3NMcEtEQ0dTR0xPbTViN0VX?=
 =?utf-8?B?Zk9uZkM5U2hMWlZQNTh1Y2NDYnU3cWJ0cStNcHF0NEVBQ21OaFIxRm9uaith?=
 =?utf-8?Q?siGKW1RWBAw38DCKYX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76680b5f-6668-45bf-3fe7-08dea693b5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 08:37:27.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7bV7QqWigTcqGfkVXYrIEDjwD7/LAzc1GTEYjmC028U4XAsoorb5a0WoWK9dLjWk9IvtWigvJT6+q1030DlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7706

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyNiA0OjA1
IFBNDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcm9i
aEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+
IGJoZWxnYWFzQGdvb2dsZS5jb207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd2lsY3p5bnNraUBr
ZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC0NCj4gcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gYXJtNjQ6
IGR0czogaW14OTU6IEFkZCBkbWEsIGludHIsIGFlciBhbmQgcG1lDQo+IGludGVycnVwdGVycyBm
b3IgcGNpZXswLDF9DQo+IA0KPiBPbiBUaHUsIEFwciAzMCwgMjAyNiBhdCAwMTowOTo1M1BNICsw
ODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgZG1hLCBpbnRyLCBhZXIgYW5kIHBtZSBp
bnRlcnJ1cHRlcnMgZm9yIHBjaWV7MCwxfS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaSB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0K
PiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiA+IGluZGV4
IDcxMzk0ODcxZDhkZDAuLjY4OTZkOWMxNWJmNTMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDk1LmR0c2kNCj4gPiBAQCAtMTg2MSw4ICsxODYxLDEyIEBAIHBj
aWUwOiBwY2llQDRjMzAwMDAwIHsNCj4gPiAgCQkJYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47DQo+
ID4gIAkJCW51bS1sYW5lcyA9IDwxPjsNCj4gPiAgCQkJbnVtLXZpZXdwb3J0ID0gPDg+Ow0KPiA+
IC0JCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzEwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+
IC0JCQlpbnRlcnJ1cHQtbmFtZXMgPSAibXNpIjsNCj4gDQo+IFdoeSB0aGVyZSBpcyBubyBmaXhl
cyB0YWcgaWYgdGhpcyBpcyBoZXJlIGZvciB0d28geWVhcnMgYW5kIHlvdSBjbGFpbSB0aGF0IElU
DQo+IENBTk5PVCB3b3JrIHdpdGhvdXQgdGhlc2UgaW50ZXJydXB0cz8NClJlZ2FyZGluZyB0aGUg
Rml4ZXMgdGFnOiBJIHRoaW5rIHRoYXQgaXQgaXMgbm90IG5lZWRlZCBoZXJlIGJlY2F1c2UgdGhp
cyBpcyBub3QNCiBhIGJ1ZyBmaXguDQoNClRoZSBkcml2ZXIgaGFzIGJlZW4gZnVuY3Rpb25hbCBm
b3IgdHdvIHllYXJzIHVzaW5nIG9ubHkgdGhlIE1TSSBpbnRlcnJ1cHQuIFRoZQ0KY3VycmVudCBp
bXBsZW1lbnRhdGlvbiB3b3JrcyBjb3JyZWN0bHkgZm9yIGJhc2ljIFBDSWUgb3BlcmF0aW9uLiBU
aGlzIHBhdGNoDQphZGRzIHN1cHBvcnQgZm9yIGFkZGl0aW9uYWwgaW50ZXJydXB0IGxpbmVzIChk
bWEsIGludHIsIGFlciwgcG1lKSB0byBlbmFibGUNCmVuaGFuY2VkIGZlYXR1cmVzIGFuZCBjYXBh
YmlsaXRpZXMgdGhhdCB3ZXJlIHByZXZpb3VzbHkgbm90IHV0aWxpemVkLg0KDQpUaGlzIGlzIGEg
ZmVhdHVyZSBlbmhhbmNlbWVudCwgbm90IGEgY29ycmVjdGlvbiBvZiBicm9rZW4gZnVuY3Rpb25h
bGl0eS4gVGhlDQpoYXJkd2FyZSBzdXBwb3J0cyB0aGVzZSBhZGRpdGlvbmFsIGludGVycnVwdHMs
IGFuZCB3ZSdyZSBub3cgZXhwb3NpbmcgdGhlbSBpbg0KdGhlIGRldmljZSB0cmVlIHRvIGFsbG93
IHRoZSBkcml2ZXIgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgZW5oYW5jZWQgZmVhdHVyZXMuDQoNCkkg
aG9wZSB0aGlzIGNsYXJpZmllcyB5b3VyIGNvbmNlcm4uDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
