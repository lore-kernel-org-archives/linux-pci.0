Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2224331A63;
	Thu, 11 Jun 2026 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150373; cv=fail; b=Rn8F7hKqvFZ4CXaEhlN/ipvQ6XAboBKDfgPl8mRsYFw5KXkJgixcFEEtsj5vHA9GVu0ShX3vQpiQ60LrFQ8Kgozf3QpNt7tzmxL6zRMvTwxJ4Z6jOQfCsUs98sQ4Y5ve4c+yGL7nVDYB9OoC3DejmOkQ8knMPq6xO/vMz1CprMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150373; c=relaxed/simple;
	bh=gsK3u+nzU62wnJ4kO5nBOCXwrlQQY/sx7++/kXpg+pY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1ojgLR6Nx2C6CUkZ/dBKRbiorU8c/Cy8cHIooJET+LvSPzfBD6/dODEMEXgVCvoxWZdCOjUGDvpbBf0n8wNTHYfJnhsAHYxEM7iVQ+T5Sxh/MfZLq7oop2SzoNK6EKsgQ2hTkdovUOl20duJ2LvWIOd3OHsdBAi/alWI4ulodI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fk65A4+4; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fk65A4+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avgSKkNcPwtzV6Uz34EW/FLN8A5pYVqv8C+Q11+RulDmzvwfDBAxMApe53CjQudDUqs2Emq8KXac0kSN3XP90lyhSDr8c7ATETETvsz/P1WE+UFrgouWX6RmDInxAzugNPQjAo59hU5cni7n12jk8c2+KqWvDowNO42/469TrKAsg/F+lUrml+oP/z206JAMowm5+jEaHe5I2se4GqLm3EJ/c+I05Zp6K0D3+2plIy86CDSck/fOlGyNvuAoZ792gP4Q1mvpdLxBtYBiNlNA6/GRSFEUYLRRog2QsCSWzHqg4u6QnIDzB4m6UvMN1TdBHZ0i7CfLgFAcnIkEFkXgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsK3u+nzU62wnJ4kO5nBOCXwrlQQY/sx7++/kXpg+pY=;
 b=SZnqtdFFh2rRhcS6puUXWWhjE7NtF08b2icnZeAUtX3WUFkm5g5GOMuSc2ZvfdchmhGtDSoehK/dumxkzQrP/pYuKknkoj4CEPF0teMlWbTO3SGImODcLAsquN07nIMhoCzRzSO7jfU1Wfzl8R5qqbO0WzlvC/7WdHXNO+cSbdC4KdtIwxiWtqBBgWLzT8LExP6IDG5U0YRoKHZ70wgXedgtHKX82eHWSv2Z+9yylsRkwLlHslEL00A4N2tqQhvHBSOMXqqpzXDQDraX1wX0V4+yQy1bkZLPLYQ2EyRx6OWrq37Ijz7EqdGkuY8x2MT3gHWzRFz0T1BFkGxkTBOWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsK3u+nzU62wnJ4kO5nBOCXwrlQQY/sx7++/kXpg+pY=;
 b=Fk65A4+4mjcmBAJkMGj+JmLxxyMF0QbNEso6SpSwmW/BOE3lOVrUWqo4oxDuv8V31j/30dPA/+PjJtIuIL6vJGFA2gXutcMYpWus890M8c/ZuPnCniIxNVsUdA7BJc16YR7lPmR0U7lZggKNu3s124ADS7Sb+8XzOYrl4/RH1g+uXv6nuKvk8i7Li6Z7f60lg1GOJL9HcuaQjMtmvv1W5+K7PwXTSzbaGueTqrLs1DXp1noIU1th0Me80CG89MOR+N66SCF7ZIZMg2WbbX9iAuYzp9M/fTdjF1pLE9ct9DA/H9wF8SJ0CENWPDhty5SOKq7gpsXamD2bAqtiyRYGAA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 03:59:28 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 03:59:28 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply
 support
Thread-Topic: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Thread-Index:
 AQHc98EqSHx96zAXkk2n7RCbK2H3mLY1lPEAgABAkQCAAaAD0IAAEgQAgAALARCAAAV2AIABGZew
Date: Thu, 11 Jun 2026 03:59:28 +0000
Message-ID:
 <VI0PR04MB12114DA25D08329D3DC2C3ADA921B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
In-Reply-To: <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DU0PR04MB9636:EE_
x-ms-office365-filtering-correlation-id: 550d5c21-2039-4c85-d4af-08dec76dd5d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|366016|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KAdV/4cKNEDSr+oWo8AKcCOc5FF0A8jVpNT4LXxn/Pqx+wM9mYM0zIn3NONkfAn7DswV2ofgqVUTuhc5aiGxAe+FX+Vy1WKWBX2YgqvBEr9lgOtnBDKJDH11v4Mx2qy0gJTPA1gpcp2Hi9srqVL+0+oGDA7wKdgCCYoekCkcAIXxKLzs0bPGbP9yffTljDT3wHvjHVrHbDuIOnbPP2xDmd7yQMWVtnSNMmTL4Xk0NU+WnqRdZjFPcN47NQsI0ofxS5ludVSgB6k4EkR28RTDlj7X/Vtoz8V0azCBYdQNolN1Bh/917Q+MXLJm45/1Z3sRLN1w6jEGp5/yOYNGlqllvmEQQlJyIjPCefzt29wdSu1FpSLr2xnFxXZItOZCrdhy6sVwzBW7AmKcwcYUt0V00qkRDPUbKBENdxJV/5BhkenQJ1+bjcQtGVSkL9GHAKDH1zCMLGZoGw7PKwG9RY0Wzy/Ffy4dMicQHneBrJ08lc6QgLsPhDA49UXuNAq0z6MzOjodgEHzvRVy+C2MRxqrWd2ayxbcfY0j49xlUlmREgx4YnvhIzPlh4hkIvws9H9/ax737P7X3aIw9FNCb849QsZgdiow5tqrB4h67gTNp8SIb48V38aQxNO7iscVDcuaR89zVIZQHALTEaTbZETbOVpQkkS/lCCkqEWuhvIG9ki9bn05ge5NS4czgPmL7/3moerjsdnwp43EWhWOjTSQVFGuVDZtN34L6Ult/9OdQjKgNbBNZwGdCdqfILhGVhg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDhFbm9YenpKZTlDbGY0RjNwTUYvZXpIR2lReUl3UnhuVVQzSm5UZXRwNU1u?=
 =?utf-8?B?TThXdUtSS3kzaXNZWHNTQ2ZySmxKV1AxRit6YUhFOEpMbHlUcmRUbTAyQTVk?=
 =?utf-8?B?KzY0Z0NuZm1FaE41dDJvUDRlSHBpamdDbWRreDBvVUREQ1JwZE1OYm4xcitB?=
 =?utf-8?B?MDlvNmk1TWVVOEQwdEI1WmVMVzZpaGZRcjEzb3p0VnNPcUhRUlBna2VCNmdV?=
 =?utf-8?B?TENCcHQzZ0RtUWlYVVFjTXpMQWNyRFR6aENpZEl4Q1F0SllSSDNBSStXVDkz?=
 =?utf-8?B?S0x1bzdPR09WZ1VlK3d1cU93Qk1TSS9rYk1ENXhJamlFc1BJOURJVW40OVM2?=
 =?utf-8?B?Qm42Y0E0NGZJeGlmUnZxUXh0eWNVZWlhMkZ4R3g4Q0x2ZFJHZHV5MHV4Umdm?=
 =?utf-8?B?a1ZHZzRoT09vSEJrbmZ4NGRCKzlYelJPQStpN3RZVld2N1RjMFVrYkpYQy9H?=
 =?utf-8?B?REJxK2VSWXMvNVgwWTZibm9QT0NMNEhuMUpycU9HZk43Z1M5U2lkWGpLZXNM?=
 =?utf-8?B?NjMrb3IvV1ZkWDUrbzFEQUsyNUhiaytWN1lBYnJTR0dEWHVwU0pJM1Q1QUFj?=
 =?utf-8?B?Sy9aNmpxN01BU0Jwcmt4TUZZcWhObk1qZVI3NTZwTk1OeDR6bnZMZjRZTElE?=
 =?utf-8?B?RXRCbFVjQ0V1VS8xRDZIRXJjSWFkQUsxdjZDSFhlTEhzQVUwSGg2M2NUV1lz?=
 =?utf-8?B?cnZmd3J5d0N3dnBUKzd5Z00rTnZTMXV6ZmxNWVUvWUZzVStacEo5ekNJQ3pQ?=
 =?utf-8?B?bG1zTWxHdFUzbXVsS01zdEoyUVNLZnpZbU1FbnM0TVRGMVBjOVVGWlYxdVBo?=
 =?utf-8?B?blR6bWhFRFhkcUVMUFJoQ0ZWbXpNV3lweEUrZGp1YlR3b01lRmdKZlh6cVlW?=
 =?utf-8?B?RUJpaVZmOHpXZU45dS9SU05iTjhLNC83ZFJxVmNQcmRMVmxLSGV0MnVkcERu?=
 =?utf-8?B?Y05UMlcwU29hT1c4QXU2Y1dmVE1lYnFvYlZIanVEZXJXS0RqSlRML0NIY1BY?=
 =?utf-8?B?KzlTYnRrd3ZpbnF2MEVrcHRweERpUk14Qml0eGd5RWk1VnNORnYyNFordEpS?=
 =?utf-8?B?Z0FCZTc3cFZuVzV0K2M3VlFPYkNsa0dhNnZnRWJFZE9hWnlRQk5LTkpOcm9s?=
 =?utf-8?B?elRJMXAySHpYYTFJUmkrVUlCOVZZaUVjVk5mYWk3ZHZSd0F2dk5rQ0IxYjRJ?=
 =?utf-8?B?cEJGM2dIM2lnNHlpUzQ4YzVlc2wzZlZ6cTE5bEIxdWlCTUEwVTVvQndPRlBl?=
 =?utf-8?B?Ti9Fc3ZCc0pRK2dPSVI5WXl2MUY4MHRhZkRnWW9pYVl0Z2ViYkJPL0ZOd1ZZ?=
 =?utf-8?B?ZnRTMHdTcU00d0l4RXBBdmVvVU9KYkFDcUlNSU5PWjhsWnZFWWxZRmN2QVF0?=
 =?utf-8?B?VGxzeHd6b1NpZTVaQThFbTNuMTFWSU82R0ZXTXNJMDE2OE9mTklmak5ZTCtC?=
 =?utf-8?B?WWxxdmZpUEJwZGJNejhpbitzR0pCbjFETFlIOWo3aXorY3prSm9ubmNsSFFP?=
 =?utf-8?B?RXM3ZDk1NmlvL3JoLytSQyt5V1JQZDdtSVp0b0REVU8wYnNZWkNqcWlDK0dx?=
 =?utf-8?B?Y0dZS3ZRN2svQXZ1WW14OStGUlh6bEV0bmMwNEJHWHF2V1BoaXpwcEFUUWR0?=
 =?utf-8?B?ZFl1bmVnK2RrQXF2ZzNoZGNVL2pOeUVHWDlYcTZkMzh1ZU1QR1VraGt2Ymgv?=
 =?utf-8?B?NG5DS0JEM0N5VGE2RWg2UDBxcHJmRXNoVjFkVW1FbG1YWkZVOU9NNmEwa29T?=
 =?utf-8?B?bWZaVGJtSml2TklLVnJNbVpWQUN0M3M5NGRWVmFTa1ZNUytkQVYvODBkMzFv?=
 =?utf-8?B?c0Z6NmhrcURMalMwRnlIam5OeTNiZU4xNGlpVVNGdWVLQzVVY1NzSzFLWm4x?=
 =?utf-8?B?NHlSck9PUklqeXVyODIyMUpIRmRUNi9maDRYVUVkRlNEeVFubTh5UXlzY0ZQ?=
 =?utf-8?B?QU1pTmNLQ0FPSjlIaXBsRithK1VKT1lIbDAvckdxcHpQUDhJZHJGbk1HaS96?=
 =?utf-8?B?ZXhkNmFIcFJRTkR3aDAydEFLeGpKR0xxMjEyR2t3b0JrS1BXdEdqcVhFcmxY?=
 =?utf-8?B?SmNJQnJ6WWJHbng3QldJLzVyWGN1a2Z3NHU3YU9nYjRjZzNIUzJBMVpZV1ZP?=
 =?utf-8?B?eDIrMG1TbGtrd3pXcWVYbXcrbzMwWk5NbjJtOVRDMnNnZ2p6OE1QUVJUV090?=
 =?utf-8?B?RUhKMkZnTCtsMkNSVCtSamJITlc1bEtKU29laDNWbm4zZlEvbVFZS3RVWWxH?=
 =?utf-8?B?TGc4NkhQQWlMRDZ2UU1nbVFCbDVvY1lTVG50SGlVSFIzOEF6aG9lTjBEV3l2?=
 =?utf-8?Q?Gap0hJ5vxOhLxvjIS/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 550d5c21-2039-4c85-d4af-08dec76dd5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 03:59:28.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRGJ5By15gKCY32c8HwXPCsMNomCRPvYntYD6G6odbmfloWzBk682icvbaJicLDF47WN6zs9eZzOcKzejBO+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

PiBPbiBXZWQsIEp1biAxMCwgMjAyNiBhdCAxMDoxMzowMEFNICswMDAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+ID4gT24gV2VkLCBKdW4gMTAsIDIwMjYgYXQgMDg6NDA6NTRBTSArMDAwMCwgU2hl
cnJ5IFN1biB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEp1biAwOSwgMjAyNiBhdCAwMzo0NDow
OEFNICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3JnDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4g
VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MQ0KPiA+ID4gPiA+ID4gcG90ZW50aWFsDQo+ID4gPiA+ID4gaXNzdWUocykgdG8gY29uc2lkZXI6
DQo+ID4gPiA+ID4gPiAtIFtNZWRpdW1dIFRoZSBgdnBjaWUzdjNhdXgtc3VwcGx5YCBwcm9wZXJ0
eSBkZXNjcmliZXMgYQ0KPiA+ID4gPiA+ID4gbm9uLWV4aXN0ZW50DQo+ID4gPiA+ID4gaGFyZHdh
cmUgZmVhdHVyZSBvbiB0aGUgTS4yIEtleSBFIGNvbm5lY3RvciB0byB3b3JrIGFyb3VuZCBhDQo+
ID4gPiA+ID4gc29mdHdhcmUgcG9saWN5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRmVlbHMgdmFs
aWQuIERlc2NyaWJlIHdoaWNoIHBpbiBvbiBNMiBjb25uZWN0b3IgYXJlIHlvdSByZXByZXNlbnRp
bmcuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUmVmZXIgdG8gUENJIEV4cHJlc3MgTS4y
IFNwZWNpZmljYXRpb24gcjUuMSBzZWMzLjEuMSBQb3dlciBTb3VyY2VzDQo+ID4gPiA+IGFuZCBH
cm91bmRzLg0KPiA+ID4gPg0KPiA+ID4gPiBQQ0kgRXhwcmVzcyBNLjIgU29ja2V0IDEgdXRpbGl6
ZXMgYSAzLjMgViBwb3dlciBzb3VyY2UuIFRoZQ0KPiA+ID4gPiB2b2x0YWdlIHNvdXJjZSwgMy4z
IFYsIGlzIGV4cGVjdGVkIHRvIGJlIGF2YWlsYWJsZSBkdXJpbmcgdGhlDQo+ID4gPiA+IHN5c3Rl
beKAmXMgc3RhbmQtYnkvc3VzcGVuZCBzdGF0ZSB0byBzdXBwb3J0IHdha2UgZXZlbnQgcHJvY2Vz
c2luZw0KPiA+ID4gPiBvbiB0aGUgY29tbXVuaWNhdGlvbnMgY2FyZC4NCj4gPiA+ID4NCj4gPiA+
ID4gQnV0IHRoZSBjdXJyZW50IHZwY2llM3YzLXN1cHBseSBtYXkgYmUgZ2F0ZWQgb2ZmIGR1cmlu
ZyBzeXN0ZW0NCj4gc3VzcGVuZC4NCj4gPiA+ID4gU28gSSAgdHJpZWQgdG8gYWRkIHZwY2llM3Yz
YXV4LXN1cHBseSB0byBsZXQgdGhpcyAzLjMgViBwb3dlcg0KPiA+ID4gPiBzb3VyY2UgYWx3YXlz
IG9uIGZvciBQQ0llIE0uMiBLZXkgRSBjb25uZWN0b3IuIFRoYXQgbWVhbnMNCj4gPiA+ID4gdnBj
aWUzdjNhdXgtc3VwcGx5IGFuZCB2cGNpZTN2My1zdXBwbHkgYWN0dWFsbHkgcmVmZXIgdG8gdGhl
IHNhbWUgMy4zIFYNCj4gcG93ZXIgc291cmNlLg0KPiA+ID4gPg0KPiA+ID4gPiBATWFuaSwgZG8g
eW91IHRoaW5rIHRoaXMgaXMgcmVhc29uYWJsZT8gT3IgZG8geW91IGhhdmUgYW55IG90aGVyDQo+
ID4gPiA+IGJldHRlciBzb2x1dGlvbnM/IFRoYW5rcyENCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBU
aGVyZSBpcyBubyBWYXV4IGRlZmluZWQgaW4gdGhlIE0uMiBzcGVjLiBTbyB5b3UgY2Fubm90IGRl
ZmluZSB0aGF0DQo+ID4gPiBzdXBwbHkgaW4gdGhlIGJpbmRpbmcuIFlvdSBjYW4gZGVmaW5lIHRo
ZSBjdXN0b20gVmF1eCBzdXBwbHkgYXMgYQ0KPiA+ID4gZml4ZWQgcmVndWxhdG9yIGluIERUIGFu
ZCBtYXJrIGl0IGFsd2F5cyBvbiBzbyB0aGF0IGl0IGlzIGtlZXBzIHN1cHBseWluZw0KPiAzLjN2
IHRvIHRoZSBjYXJkLg0KPiA+ID4NCj4gPg0KPiA+IEhpIE1hbmksIHRoYW5rcyBmb3IgdGhlIHN1
Z2dlc3Rpb24sIGJ1dCBhZGRpbmcgYW4gYWx3YXlzIG9uIHJlZ3VsYXRvcg0KPiA+IG1heSBjYXVz
ZSBib2FyZCBwb3dlciB3YXN0ZSwgY3VycmVudCBzb2x1dGlvbiBlbnN1cmVzIHRoZSAzLjN2DQo+
ID4gcmVndWxhdG9yIGlzIG9ubHkgZW5hYmxlZCB3aGVuIE0uMiBjb25uZWN0b3IgbmVlZHMgdG8g
d29yayAuDQo+ID4NCj4gDQo+IFdoYXQgZG8geW91IG1lYW4gYnkgJ25lZWQgdG8gd29yayc/IEZv
ciBnZXR0aW5nIHRoZSBNLjIgY2FyZCB0byB3b3JrLCB5b3UNCj4gYWxyZWFkeSBoYXZlIDMuM3Yg
c3VwcGx5LiBJZiB5b3Ugd2FudCB0aGUgYm9hcmQgdG8gYmUgYWx3YXlzIE9OLCB0aGVuIHlvdQ0K
PiBuZWVkIHRvIHN1cHBseSAzLjNWYXV4LCB3aGljaCBzaG91bGQgYmUgYWx3YXlzIE9OIHRvby4N
Cj4gDQo+IEJ1dCB3aG8gaXMgdHVybmluZyBvZmYgdnBjaWUzdjMtc3VwcGx5PyBNLjIgY29ubmVj
dG9yIGRyaXZlciBvciB0aGUNCj4gcGxhdGZvcm0/DQo+IA0KDQpIaSBNYW5pLA0KSSdtIG5vdCBz
dXJlIGlmIEkgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uIGNvcnJlY3RseSwgYWN0dWFsbHkgaXQn
cyB0aGUgcGxhdGZvcm0NCmRyaXZlciB0aGF0IGNhbGxzIHRoZSBNLjIgY29ubmVjdG9yIGRyaXZl
ciB0byB0dXJuIG9mZiB2cGNpZTN2My1zdXBwbHkuDQpUYWtlIGkuTVggcGNpIGRldmljZSBhcyBh
biBleGFtcGxlLCANCnBtX3N1c3BlbmQoKSAtPiBpbXhfcGNpZV9zdXNwZW5kX25vaXJxKCkgLT4g
aW14X3BjaWVfaG9zdF9leGl0KCkgLT4NCnBjaV9wd3JjdHJsX3Bvd2VyX29mZl9kZXZpY2VzKCkg
LT4gcHdyc2VxX3Bvd2VyX29mZigpIC0+DQpwd3JzZXFfdW5pdF9kaXNhYmxlKCkgLT4gcHdyc2Vx
X3BjaWVfbTJfdnJlZ3NfZGlzYWJsZSgpDQoNClRha2luZyBiYWNrIHRvIE0uMiBTcGVjaWZpY2F0
aW9uOg0KUENJIEV4cHJlc3MgTS4yIFNvY2tldCAxIHV0aWxpemVzIGEgMy4zIFYgcG93ZXIgc291
cmNlLiBUaGUNCnZvbHRhZ2Ugc291cmNlLCAzLjMgViwgaXMgZXhwZWN0ZWQgdG8gYmUgYXZhaWxh
YmxlIGR1cmluZyB0aGUNCnN5c3RlbeKAmXMgc3RhbmQtYnkvc3VzcGVuZCBzdGF0ZSB0byBzdXBw
b3J0IHdha2UgZXZlbnQgcHJvY2Vzc2luZw0Kb24gdGhlIGNvbW11bmljYXRpb25zIGNhcmQuDQoN
ClBlciBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBhYm92ZSwgdGhlIE0uMiBTcGVjIGFjdHVhbGx5
IHN1Z2dlc3QgdGhlDQozLjMgViBwb3dlciBzb3VyY2Ugc2hvdWxkIG5vdCBiZSB0dXJuZWQgb2Zm
Lg0KU2hvdWxkIHdlIHNpbXBseSBlbmFibGUgdGhlIDMuMyBWIHBvd2VyIHNvdXJjZSBpbiBwd3Jz
ZXFfcGNpZV9tMl9wcm9iZSgpDQphbmQgcmVtb3ZlIHRoZSBwd3JzZXFfcGNpZV9tMl92cmVnc191
bml0X2RhdGE/DQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
