Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7123192590;
	Fri, 10 Apr 2026 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790055; cv=fail; b=AdIuI1gKUpmtTBuhOZu2JxQR0nhxcE1pcKcnUAzohf3Uv0VtTCM2rdQVcjwfb9xlC/4hqMB8gWfRxwN1IEmtwT56JL+1XbMpq7YItC/rMCFVWM2wY/+kIalvFN7MNABmq7L+gP5wB+OLkNCcduOEA5Lx3pKrPjyH6Iuu3v87GCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790055; c=relaxed/simple;
	bh=MuKy8G0h4ov6uECgU+7KhtsNDlOxBhJFcr8tXVmfv5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1E+fhTvDxw5TuFvOmpM61j/4fte4FN5AdRXakVPn8yJgfs95SqZb76u2FLPmFwi8M5XoSKPCzWnn79JHoaldVhiNFh4dD9jl9KcP+6AkASWNTC9NYL+er7nNtgcHaOYAm1eCSbTmPDNQC0lG1hfxvOs7VcZczBq9OrAGnohiMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Je+Ueg/s; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Je+Ueg/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM3Jh888+YF92CCId1tO6hm+h+phQJVqOKpPAanIGJpy06UH2xSS2m06ejx9fjZcaf/hmQJFoI0t1fSEq4DCS0sUzIzPN2kjp5h4kTXsLA0s0eRhLgTd2cd0hBO7/8LevnGZfxJgwM49cjwjg/W5TqpJjBzwGfdCTQ+U9ulMVDEqWF3XOjwhiEHjtdauc7PrLpKQp7pteJBAi2bwTVNUYw6v1rBw7G4TAMxbZJc61UV4smfe/QBPyiXnfQgUR+gRwT6jGBngvLIiBbqMYUHrmplzYwSXUWMZekCq5vG4ukQlZ7KPIFyOIrRMXF8VyDLsfG6Cniq/Uijco7J/aIJgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuKy8G0h4ov6uECgU+7KhtsNDlOxBhJFcr8tXVmfv5E=;
 b=U6ExAAqH0Bv6SwIDyAYo75X0FMX1mWMF899CjMP+SHFrcJa/vf0R//HMN3xNVpnCnf4o/ld/tUBi6/YdHLZu5iWD4Ltl8tMchnv6tOITtAkpjkhrKpOPnk0Dhb0yXZucejP3oNnld4VkEGiFBYGZ1g3hB21PSh5C+x18jgZG5WAPQZvpTcCWhty7N+JOvPu5r4Nna3TKyFx1nEF/RgIM7Llel4zlegY92NiHSKtM9w9C0U4D7megxYoLdQT2AknskXMMB0jzJ/iw31j52gX3U/t66dUlKi8fs5iDCyEns1NKGqHh91yVTFlaq5EwirOR9HnD4o/j05pBCZ2K4ZfSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuKy8G0h4ov6uECgU+7KhtsNDlOxBhJFcr8tXVmfv5E=;
 b=Je+Ueg/s9FCqLaPuy/0aPSf9Qp2NWcZKWu+H1Yx9Z5lSn7hKWHDfIOiIThej517IRebJAf39q7wVJmBjoADElypEFdRAtRKTWFkEKlmxi6HfRmczRinHE5FJdZX1NaSh6O93JSEjRnvr+6mcXH7tj7e6nfIxBXvD9VoXgeiJOWiCqFyDbOMUaFv49zb6+HQd8GEWNrrZooN/NxQb1xsNpP1SMyzkQXrOEpm4xI/O5Eq/kTpLZmyZHQaKxPhVX9dGczo23T8W8OuBQjES7h7NU08A7GTzCiQ74NDMNrHjmEyCYFi5L8zgBkiCr4ygcs3Ls/gJCSmu6rnlNsjwZdslVg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8398.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 03:00:49 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 03:00:49 +0000
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
Subject: RE: [PATCH V2 0/8] PCI: imx6: Integrate pwrctrl API and update device
 trees
Thread-Topic: [PATCH V2 0/8] PCI: imx6: Integrate pwrctrl API and update
 device trees
Thread-Index: AQHcwojBc+ekpdCTn06s59ZTbCzv4LXPJr4AgAh9WHA=
Date: Fri, 10 Apr 2026 03:00:49 +0000
Message-ID:
 <VI0PR04MB12114534B0861BB1AC5FACBEE92592@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
 <omtn42mopdz7igg7jaqwehd67l6xc77zk7zzqwkufgnsycvadg@5kodhpgfesre>
In-Reply-To: <omtn42mopdz7igg7jaqwehd67l6xc77zk7zzqwkufgnsycvadg@5kodhpgfesre>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AM9PR04MB8398:EE_
x-ms-office365-filtering-correlation-id: 842db70a-231e-4f0d-ca6c-08de96ad5ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 uszM6Sy+eLRVbhwKTQYdjLce86STSs3+rdyQ+x33bZ+eg0/LePNLLYZ0phF45e01L1Kd7gy01ppVUnboqoUNTyR3zdG31JrwVPg9KHB/y9bIMXI2JTbzTSkRjoy7JnguK/mkVGBjdxM5mdqTj5kx/5goN6n114AQ2xDZCynvm07orXhJf0LXQl59jbk7QGGgrH4DXz8mkCZ08sHLdlzS/x5iZ79VRp4YsV3wp7yAgm/iAZI01E9fim1pNKuf1ry4jZMNFNDQf72JkP5fd38qEI2/EoxZtci3Q1plHvS6wGLhveFK+XI5CaeeWqsJmc2OT0BpsUDLk7WSsYKvYwOrahaSTICVgfSz6DKAuVTqPssNh+6PZESautT2tQ/Q12qFW0qlPRGDfxIh6HGBohMwi1gysjkRcHhGuc3/UMBnIADRtzIp93zLTA+62y/gq3YtSPHSFwkWPfO6j64kVwBgmepQFCTBkKcDICHT/ZlF5ALGwk6TITPy5TRPFEY5k1yxqoGo/Lq3Xzjy8HRJQBoaQEKAn8xvREmT2S6Y1AoswZ2uwV/MuhlfAT1WpoIboV5EdyOF55t+jocwUWUKY3X6bQhpAB98Xn+sAJjozRRl8I3foQyYASg4WB4Q5pl0DGwnwBhmqRaX3ITC+V/EcTxSwVUnIsvkDI+b9HkUOBSyC/NkdG1vZb8Y1LSYpCFZC70dC6ivzW6S8U9bB2EFtiR+r/IxCE5wmnE7Hq/19UhnvRjw3Gpaj8tdRMBU1878FRsvcxzBGYYP/ojedtZTvi1iq7vPz5kYwgdKrvSjsXVEiX0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFR5WEg4VXdLcmd3bEZWbk1OMDhPWkgrdnpiZVlkSHIvK0RyQzQvU2pRZ29m?=
 =?utf-8?B?RXNWM2x4bzNoc09LRHhmQ3Y2UitGQkxIVUFoZG1HZkhWOFhOdzhZR2d6TEdR?=
 =?utf-8?B?RXFBcVhNWTBPdTE4SnpkMnlZNzVpc0w4WFlYNHZYcGZzOTRTNk50N1k1UTRQ?=
 =?utf-8?B?VEUxWVRiVWEwWGltTG9vaUlpN0JzRlhpRElET1FldTBaVXZQQ1N6bHRINkc4?=
 =?utf-8?B?dXh1bVBzMklzbjkxYUVZVU55dC9MTXhiNDhDQjkvMURIcFdRZVZweFVTcm5J?=
 =?utf-8?B?Y2FPSHUvRThZZ1BVSFo0cVVacCt5Yi9kMHpLRHNNem5zdkVYRTIyQWVtbXho?=
 =?utf-8?B?cE5kQlluWjVCdW0yS1dHSHcvOVRqSEtVcEY0OGNRTG5oQU93eG9uQjE5eTlh?=
 =?utf-8?B?WjYvZWhOQU5uS21lZng0d3hpOHVOZHpqRFpld0dmYlBWckdLc1BLM0VKRHJF?=
 =?utf-8?B?QTdJVEtrNjhmNVVHcVZ5OE53cThvOEZGUmE3L0VWQk1jVkh2bzdZNytZWlUr?=
 =?utf-8?B?dVI3c2p0RFU0cGxoZnQ0a0J4RFBDb3NiZWdHZFI5Q05qbU5BdDZlZXIvSjNY?=
 =?utf-8?B?bXlIVFltTEpCVEdyS2hRZHpOd1JPbUpuWnljYzJWZXJuUDRMY3pjSnRqNUV0?=
 =?utf-8?B?MDJOV1ZrNURqM3dqSXlDaFBZWTdrMHptK2FLVFcxb2FPNU8zU25UdWxGRFdr?=
 =?utf-8?B?SDhXcWIwaGswWFFjV0ZBS2ZVUXNMakZuQmY3RGorL09FaGwrdnpaenJiQ0d4?=
 =?utf-8?B?NzNvYXNpUTVmSXpyUVh5aW9HZ21uTlV2RlhpNTEwOEdLY0RkNkNHdnlkWHd4?=
 =?utf-8?B?RGdrK1A0dU0rOFFucEtiSVBqTU84L0hSYkRLOWtDdzZuS0dNc1UzdXV4SzBn?=
 =?utf-8?B?Zi9xdjEzSENjZ1pUZWQ5UTBhVDYxV1FyWnVaQ25VR3QzMzZObDI0eDR1cy9n?=
 =?utf-8?B?YnVCVTVyR3pWRzgySkY4ZnZIZFNJWTdGRkIrcE5EU0tFTXRnOVU4VDljL2Y1?=
 =?utf-8?B?dERBMFF0Yk1YckxWN203cHRQZFgwSTJRU1J0UEF5ZnJZWnowdUFkbldmeHlo?=
 =?utf-8?B?T0hIK05IL3FBQTJidEZUUEF5eHkwdjlYNm1lK3QwS2dCb2JZbFoyVUN4YXJk?=
 =?utf-8?B?MCtNd1IwNU1Pdm9iUUI0b3pmQkpzUitCSXk5RFpuWmt0WWRocytuRnRTeWM2?=
 =?utf-8?B?NmNTa2l0TnRVeTFDNWQ1cUViMU85dDI0SDJ5Q080RGdvbndJZ3ZNejcxcVZM?=
 =?utf-8?B?cEROMFh2OWU1YVdpYXRHb1Y3ODd5YUhURVNiYk1PcWloMlVjNWhXUHJKWkFZ?=
 =?utf-8?B?c1VYV3NueitGMDB5R3hPNVYrSnRaTXZWN2lRcUZNb0VNbm1GUitCeUZtdTI3?=
 =?utf-8?B?SmVRc2Yxc3cydU1qZXFtTFIyZVBEL2UzNWNKcy9KL1hONVdyUGFlYUVzWDdn?=
 =?utf-8?B?T3NGdUlRME5RK3dkQWNER2dXZDJCZ2EwVUdMVUt3Zkk4cWJmMEJuMnhwT3FD?=
 =?utf-8?B?QWQ5eTZnZW5nVGtYNVRBU2VPRGZBRUVGemVjV1k5V29zendyWXpIMDFOeGNT?=
 =?utf-8?B?a05PV2NtTmw5aXFucklPRVpOVEMyb0RKWnNESUQvN3AwQk1nT2xhYW5lMEdL?=
 =?utf-8?B?RTBtdjhjTFBsU1lIYTQxZHBHNHR4cGJ5WUJMazBMTDFJRlFEdG5WR05iSGtP?=
 =?utf-8?B?WExJeWNicHRUYmczNkV5blV5VVNsbUI0bVdMWDIrWmg1Mm4wWGY0OU0xM0xi?=
 =?utf-8?B?eWNueis3dkZucHRyRVVOYW0xbm8vSER5ZG5BSmtJQm9nS29HcGF5MVFwTzBI?=
 =?utf-8?B?bnhUR1UrZjZCaFd6Qi9ZOXNaTHkxUmVTVkRtUTlDeEExY1FJRnEwMXl4MjZC?=
 =?utf-8?B?QXVCeDhoQkZJcmdaM1RKYzh6c1FZZVZZa2pPelZyYW91V0RUYy9DOE40cmpl?=
 =?utf-8?B?OHRJZXFzcHJPbWFKYjdqVWRJTjkvOE1lblphVzRCVTFSUG9BaHJEU3lvQmxp?=
 =?utf-8?B?ZjdlZGc5dm5SMFdNbXpyWFhnR2NFOGVPT0hsSDdRUk0wUllIQ09RUGpZdTFt?=
 =?utf-8?B?dWlBNmwwalVNU2hYQ2hYeEJBbWRWMStRV2xHVTVZV29Kd3g3NU1sRk9nUE9I?=
 =?utf-8?B?NjlZRDE4S0pmeTBDeFp3VzNtbVhuSHhVcjhNRFpGdzllV0x5bVVNbHowbFd2?=
 =?utf-8?B?SVdJd1hDbHZZUm5HeTUzNW9MdFFnRlNGTXFUdUU2T0pvVGRxTjJFbFVIeUda?=
 =?utf-8?B?WCt1RzZoY0N5WG1oRkpLejI4d2ttQ2R6YUZycmVEVTU1Y25nSXlpNlI1ZUds?=
 =?utf-8?Q?HSKhdn+FYybFBNkVqg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 842db70a-231e-4f0d-ca6c-08de96ad5ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 03:00:49.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiWjexFqpVRsnQ16feWNz9iRIzbqmJT6HQlz9cYQvvkyB0CZfRD/CAi8Yglihmn/alX/qBKgfabCJYE5eHzpOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvOF0gUENJOiBpbXg2OiBJbnRlZ3JhdGUgcHdyY3Ry
bCBBUEkgYW5kIHVwZGF0ZSBkZXZpY2UNCj4gdHJlZXMNCj4gDQo+IE9uIFRodSwgQXByIDAyLCAy
MDI2IGF0IDA2OjA5OjU5UE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gTm90ZTogVGhp
cyBwYXRjaCBzZXQgZGVwZW5kcyBvbiBteSBwcmV2aW91cyBwYXRjaCBzZXQgWzFdIHdoaWNoIGFk
ZHMNCj4gPiBSb290IFBvcnQgZGV2aWNlIHRyZWUgbm9kZXMgYW5kIHN1cHBvcnQgcGFyc2luZyB0
aGUgcmVzZXQgcHJvcGVydHkgaW4NCj4gPiBuZXcgUm9vdCBQb3J0IGJpbmRpbmcgaW4gcGNpLWlt
eDYgZHJpdmVyLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgaW50ZWdyYXRlcyB0aGUgUENJIHB3cmN0
cmwgZnJhbWV3b3JrIGludG8gdGhlIHBjaS1pbXg2DQo+ID4gZHJpdmVyIGFuZCB1cGRhdGVzIGku
TVggRVZLIGJvYXJkIGRldmljZSB0cmVlcyB0byBzdXBwb3J0IGl0Lg0KPiA+DQo+ID4gUGF0Y2hl
cyAyLTggdXBkYXRlIGRldmljZSB0cmVlcyBmb3IgaS5NWCBFVksgYm9hcmRzIHdoaWNoIG1haW50
YWluZWQNCj4gPiBieSBOWFAgdG8gbW92ZSBwb3dlciBzdXBwbHkgcHJvcGVydGllcyBmcm9tIHRo
ZSBQQ0llIGNvbnRyb2xsZXIgbm9kZQ0KPiA+IHRvIHRoZSBSb290IFBvcnQgY2hpbGQgbm9kZSwg
d2hpY2ggaXMgcmVxdWlyZWQgZm9yIHB3cmN0cmwgZnJhbWV3b3JrLg0KPiA+IEFmZmVjdGVkIGJv
YXJkczoNCj4gPiAtIGkuTVg2US9ETCBTQUJSRVNEDQo+ID4gLSBpLk1YNlNYIFNEQg0KPiA+IC0g
aS5NWDhNTSBFVksNCj4gPiAtIGkuTVg4TVAgRVZLDQo+ID4gLSBpLk1YOE1RIEVWSw0KPiA+IC0g
aS5NWDhEWEwvUU0vUVhQIEVWSw0KPiA+IC0gaS5NWDk1IDE1eDE1LzE5eDE5IEVWSw0KPiA+DQo+
ID4gVGhlIGRyaXZlciBtYWludGFpbnMgbGVnYWN5IHJlZ3VsYXRvciBoYW5kbGluZyBmb3IgZGV2
aWNlIHRyZWVzIHRoYXQNCj4gPiBoYXZlbid0IGJlZW4gdXBkYXRlZCB5ZXQuIEJvdGggb2xkIGFu
ZCBuZXcgZGV2aWNlIHRyZWUgc3RydWN0dXJlcyBhcmUNCj4gPiBzdXBwb3J0ZWQuDQo+ID4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIHdvcmshIER1ZSB0byBzb21lIHJlY2VudGx5IG1lcmdlZCBwYXRj
aGVzLCB0aGlzIHNlcmllcyAoUGF0Y2gNCj4gMSkgZG9lc24ndCBhcHBseSBvbiB0b3Agb2YgcGNp
L2NvbnRyb2xsZXIvZHdjLWlteDYgYnJhbmNoLiBQbGVhc2UgcmViYXNlIGFuZA0KPiByZXNlbmQh
DQo+IA0KPiAtIE1hbmkNCg0KSGkgTWFuaSwgdGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuDQpBY3R1
YWxseSB0aGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uIG15IFBFUlNUIyBwYXRjaCBzZXQgWzFdLCB3
aGljaCBhZGRzDQpzdXBwb3J0IGZvciBSb290IFBvcnQgZHRzIG5vZGVzIGFuZCBjb3JyZWN0bHkg
YWRqdXN0cyB0aGUgc2VxdWVuY2Ugb2YgUEVSU1QjDQphc3NlcnQvZGVhc3NlcnQgYW5kIHJlZ3Vs
YXRvci9jbG9jayBlbmFibGUgaW4gcGNpLWlteDYgZHJpdmVyLg0KSSB3aWxsIHJlc2VuZCB0aGlz
IHNlcmllcyBvbmNlIHRoZSBQRVJTVCMgcGF0Y2ggc2V0IGJlZW4gYWNjZXB0ZWQuDQoNClsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MTAwMjMwNTUuMjQzOTE0Ni0xLXNoZXJy
eS5zdW5AbnhwLmNvbS8NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
