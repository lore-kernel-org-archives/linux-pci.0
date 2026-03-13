Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F6366070;
	Fri, 13 Mar 2026 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386176; cv=fail; b=F2aqV3eLF6eWBUTXD79dNFa6rUPQkJldc47bZUONq+ohBsaqfVk+z5it9el8lP8wNyJmJUFO5+iyM7f76Qcg04ifShux3I3BXHaI241Uf1yaaD13bGg41R2OiagT++Tnc8EO+OwCz+fMpTUu0THO9ryA9tMnoAfGnH5GAlkzWMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386176; c=relaxed/simple;
	bh=3a7ml5Fy03bDZO53TayIJkn8NEgvChdVeF24ZtuZOp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EjcKISk4EDc9RFUlpLPGEVh0Yy2xaJTU4naLqORyeSwG4IrSP/47/Sdoki4/wXEQB88KRYC5JJe6YOX6PAlhi7B4YSWveEfiyaKTnYUkVz3fhQVPtpM5mkkz8hP2oH1JMpYFbNCMKmr+q9rQ/4qVMGAAsUTZIC7B+9FTOxO0VoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vs324uF/; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vs324uF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL4ON7mmeLfD/ceOhzJwJh/jlLegqKenCB2V9fxbXtAZabcjVAbKd2aXu+5xpiutJERY/dw8MrPIQVpI2pkECwqocJI/aUuSTb4rXogHwlLkWFfkxgjvRoJkiRVaOdAsEQZO9xEmkdktIlYG0cxPo87ZcOwKaF/TJCpyBC/0fSLiHDfvqzKJZ2BtwxuEj4G7PUoqLaYEerP5U7EdYufAocXddbXZCx70gvfnfxiFM6a5O8Qkl1dOd6yKtNtQHbLJ/L7eA3NuLPZ+5h/gDJa898WtnBAhR51gJrW6l77y5CBoGMtVvQMeE+VCMER9ucT+DjmWc5Sz1neqsN3H+23M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a7ml5Fy03bDZO53TayIJkn8NEgvChdVeF24ZtuZOp0=;
 b=OUMZtzOn6VzLk4jhxQePrOvKl9VL5BB84J5fhuSf7F52Ci7/oMLfCZ08JLgVUpGl/RjxiHv591m8+f8qpzqHxaYm4SCe7oP5LB6EaGPsVfTmAz+pZ9Qo+8JhogGc9lAwRuuCEUDoA7Hv/QMvIjFIFpQTI8VtTPHAivyZXxYMjt4wcI5WIppiTTtiW1fh2gU7nmIdKXKGj5qLyP4crIcVVyQgS2UB5zhkvbMdX+FTmWeHAYELr7qTFu4NDtXE8gPuPmaMvzdp6kD2OFMNMDIu9UHefgN73q9FOYaDB4bkeDJSvXGYP1j6gdyllGDvMOOyqBN86j/aJFnZQD3q/eulfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a7ml5Fy03bDZO53TayIJkn8NEgvChdVeF24ZtuZOp0=;
 b=Vs324uF/Luj8fteswOtVqFmvEEc43r2UDsySZ81gj6gv0raAY/RJvIMn06b5AOJJeMYdKoM7z3BRn2S+AEmN1ADz0pFevd2H0siu/mQ84HT4FKbkPMlhmp5Td6SP3s5RdR/blKEx4WputLXPf0zmOJ9zDse/ZxDnUoqu9tOobUb5Ob+h1AvOyDCz4LAjo8c9H+tJV25hcSWYTap6v9MPry5qRWTkcDwUvr86nBdGjP43+vkqJiOnMsAHjQCuI0HJHnWqR3pk/srdCKQ3MIOhVzB0JtrSEEXn82FqrSGsF5KcvWBmh3qvhb05H5mJEKJaXwigY7aGNasMSBOwJTHKIg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 07:16:04 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 07:16:06 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Topic: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Index: AQHcso5EihHzW0WZ+UyejN5MCJfCDLWr+maAgAAOKmA=
Date: Fri, 13 Mar 2026 07:16:06 +0000
Message-ID:
 <VI0PR04MB12114A99A438C8E8749021AAD9245A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-7-sherry.sun@nxp.com>
 <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
In-Reply-To:
 <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VE1PR04MB7471:EE_
x-ms-office365-filtering-correlation-id: b169e159-22fd-4879-aadc-08de80d064ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Dxz3c6Uvnw0nWL4F0zF+QrB15VGO7ZhQvXjcKC/3+sFCJLxZeG46HD/nzc9ssbYgbooxtYsLImBPBxW5ziMlJA6PqKKVi5okCd3wAQq76xln4H58r47DVrJyzGI5MDegaAhzU9CDpSWGxe25sHXX6OBzgFH1pqiDqyhBai2fcX0twZIA30TNo3V6wi4Z+JiuM7c5ac3A7CmQFJLWv2uMSm9v6nfy98kjezxE1SW46KOvwKWpkO0N4bgEVTCHKb3IbR/MxkkdAAvboPhBQyvL0t1Cy2AhvHxalOwNv73vNcF6BZP2VTV4MA91sVerN4nUyWOb41z4uvoZInd4O75KKNGumim/szDEDLi/tom0IyCtkCJD5FjxcA9aTxeYJqTPVD/IcWri042fhcEmrxYb7Wv1GmPJKRMg9gJKYPC2TxNm93sKcYk3rPlnNkPFD2pXds4KpfyP/AFI0zp/u9GHOWo16UW+BAbZ5533jfFpMdUjW6OMqZ/8CUNTdDr2mkAPGVe+VIUk7j5t1CixkX4vbpA7V/p9FzWez2urh2o5jFNl+qxs2Txouxwyx7QtG58OgC5T1/j5Ee/Gl07HflGnx55GYuHgnMs+PQdBKIdIzkOmdkDQYDfePmfXWrG00nCqDY2CgQRnjl2Jz4oL73VC1z0PghnaL6FFlWBweo4RDQ2Q4IJxfrNLD3dEK9kgMxsjkGU0DRVJnQoKc8FrWTPv7BaH/rwLx77jrH9cu8L4co94tBPF/Ys7RHH30Mu4v3Zd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wno2blBqbDF5bDA1YWFmZEdEY0NlNUJCUkZUQTlYVkp0dUI5OUliM0xueENi?=
 =?utf-8?B?Qzd2L1VDcmtSTXhlQjdxZWx4dTRqV2EyajBrS28rUEFBQmdJTi9SK1JnbGNq?=
 =?utf-8?B?a1orQll5SXY1WlZPOXVsK0RJYzlnZ2E4SGdvb1gvWkZ4RUt0dUdkaFREZDN3?=
 =?utf-8?B?UUV6eFgyOEw3LytLbGgxdGRtUzBCZldTdHUza0lML2hXNmdtTWpLSHREa3dM?=
 =?utf-8?B?dVNsc1F1Q0lvaWliKzUyWHQ1d043SnI5clVnbGRKaTkxdzdwNCtGVktMMklP?=
 =?utf-8?B?Mk4xUkkzRk5yUDFlR2g2UlRXNU9TVDh0MnB2RGYzd3VmSEdCc09NNGg3dVZE?=
 =?utf-8?B?Z3BNNG9JNUdXRE1hdXdLRHcxbndRVlY2L05UdGtNVnBPU0JTTml0UFAxaE9S?=
 =?utf-8?B?anBGYkdYam1RcGZEZDR0eFJDRUJLQUJYMG5COHVHTThaZ3ZaZVprSlU3NnRo?=
 =?utf-8?B?Sk5waXpBTllPYzJ0ZXdqbkhrTTdtNnR0bEtVcHlVdEs1ZFB2QlpIcFBuRTZ6?=
 =?utf-8?B?cFlnUVNPNUIvUU9yaWYyTE1Fa05Kdm8zUjE0Z0dOa25hZTNTSFgxYkEwUS8w?=
 =?utf-8?B?N09qc0dnRkd0U2JSWm1ucGJqZHRxaG1VT0M2YklmczVNeEljLyttN0RocHNv?=
 =?utf-8?B?Yjl6QjR4RThibTYyQWIyZGF2ZGV1M1FFeER5RVVBV0lGaFhYS0tzN2NTTDdh?=
 =?utf-8?B?OGI2VGFLOWRONGhoZ0dPcjE4aUxvN3MzSmEzaklCWTZHTFZ2YzU4eU9kQVEr?=
 =?utf-8?B?SGhHTlBOYW9Xd2hjTTV6OWlrdXZNUGl5d01hNXFUeUUyYko5blBXczQzVlZj?=
 =?utf-8?B?RWoxbnRlTlFTYUw5QmRxMlZiamYvUDB5Q3M1Z0JJQXZvWUh4RUJCTXUrVkF1?=
 =?utf-8?B?d05xRGdsNC81RFluWERVY2RkdzUvZ3RuaGhoc1Q4clNxcU9veU1FdG4zTmhz?=
 =?utf-8?B?YnpjaGFZSTJJaXlGd0J4SEtnSnJwZ2NSamtYa1M1ekJHb1kwb3Z0TVZPbFg5?=
 =?utf-8?B?NXdWU2RwaXlTakRYL2UzN1dVczkrNkpBcmtjVkIwSHNsWlB6L1hESEI2ZVFr?=
 =?utf-8?B?bmZBWUNTNEpuUG9BaXFLTkl0ajBrK1FORzNDZ2hESW5uYU9Oa3NZazR4RU9H?=
 =?utf-8?B?cWFhUm9qUERuMzN0N1B0RmtVVGk2KzJLODdzZWVJaFNDYWhXNXVpYWROYXBR?=
 =?utf-8?B?dTVVL1NESXNXdStZbkQ2RVJBUlp4cnpjLy9KYVZWYWF5SFRrN2U5MEVmZ3Y3?=
 =?utf-8?B?KzVuQUszSGprZmFxNVlMTXJPZW9HcjN6eUZrRmw2ZW9abDhVVDAwUmcrdTRQ?=
 =?utf-8?B?SUhJOGN2TmZ6dlZIRE9kalg3N0ljaHdXMkxCKzJoQldyVThaQ0ZCc1lyUGRp?=
 =?utf-8?B?WVFRUnZMbWVHc0k2VjhWTXpCazc5bnhRTzcxSnA4OC9Hb3B2M3lINm15TXBU?=
 =?utf-8?B?eHZNSmVIVy9PNlJVbmN6N3ZxVncwUXd6WVNXM0FOSWwydmd2dmRMVkVCNXln?=
 =?utf-8?B?aHdFT2tTdi9EQmVzQS9XbW9ETHBTZHF6YThiSVJiN1h5VUpickUxT2FOd1p1?=
 =?utf-8?B?R2dQdWh1bm5XMTNEQ2Q3ZHBvMlUzNkRKbTRROVEvbkI4VHZKNmc2d3YraUJZ?=
 =?utf-8?B?bDNzbzJ6Sisxekt3V294U0xaNGNpcm1OMSttYXRYQk5lWXZZUDBNMnFJWnBj?=
 =?utf-8?B?UG1HNzhVOU5uYmMwdko1RTFVRVJHZ1lKQzh5YlE4TkxLTHNlV3pxYXhIVUwz?=
 =?utf-8?B?RitTMjMwQUlFdHJCbmpxUm0rRzM2ZkdCWndYeTg2ZXR3by96T3RxeFlUZy9h?=
 =?utf-8?B?YlNJT3dSKzBVR0lDRWgyUWtja2dJWkV4Ujdid2UzOXozTGxyQUFKOFlwWU40?=
 =?utf-8?B?cVloaUdSMmUvNFlVV0xKbFFJM0M2OHBJMm1yd3lKNERjMkJJM2p3STV1VStv?=
 =?utf-8?B?T0ROeDB2SjFjRXpxZ2s5YXFWOWFSckZadDRUYnVCczZTeWdWNXc5NzUxS3M1?=
 =?utf-8?B?TnF6TUR5ZkFHdnZhZ3ZmQU9MNkNZOVd3anpYdm1jd2R3ZTdiSjlqWks4V0ov?=
 =?utf-8?B?Y3Z1a3hMcjhPaFQwOTZFcWp0SnlVUjlGaG90MVQ3Zmd2U2dUVzBadzRxR2hB?=
 =?utf-8?B?ajlMOGNJdElNWDRoSmlHYmM3MTRWWEhTUm1MSFlmZi9TRXhycDJiUllLV09U?=
 =?utf-8?B?ZlNBTE1ncGhyNEpUNTd6ZVQ4RE8rVEN0eHg1Q25MRlZ2UnpQWkJ6dXh3ZUdn?=
 =?utf-8?B?dk00UHFKbW1wbHl5SmZXdnEyQnQ4OVNLa0NpK0dvSnpTQUl2L3pOT0ZyelMz?=
 =?utf-8?Q?UZ9bINitd1W1oU7NUQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b169e159-22fd-4879-aadc-08de80d064ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 07:16:06.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vigouvQZjR2mPW6fuBxCGPS500wGBqYRtfXR4VNl1FVEVAOan3QPyMTb5igUQPFUSrkdJ0QrQg3gpIruC45R3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

PiBPbiBGcmksIE1hciAxMywgMjAyNiBhdCAxMDowOOKAr0FNIFNoZXJyeSBTdW4gPHNoZXJyeS5z
dW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTaW5jZSBkZXNjcmliaW5nIHRoZSBQQ0llIFBF
UlNUIyBwcm9wZXJ0eSB1bmRlciBIb3N0IEJyaWRnZSBub2RlIGlzDQo+ID4gbm93IGRlcHJlY2F0
ZWQsIGl0IGlzIHJlY29tbWVuZGVkIHRvIGFkZCBpdCB0byB0aGUgUm9vdCBQb3J0IG5vZGUsIHNv
DQo+ID4gY3JlYXRpbmcgdGhlIFJvb3QgUG9ydCBub2RlIGFuZCBhZGQgdGhlIHJlc2V0LWdwaW9z
IHByb3BlcnR5IGluIFJvb3QNCj4gPiBQb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hl
cnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9ib290
L2R0cy9ueHAvaW14L2lteDZxZGwtc2FicmVzZC5kdHNpIHwgIDUgKysrKysNCj4gPiAgYXJjaC9h
cm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cWRsLmR0c2kgICAgICAgICB8IDExICsrKysrKysrKysr
DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNhYnJlYXV0by5kdHMgfCAg
NSArKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwtc2FicmVzZC5k
dHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwtc2FicmVzZC5kdHNp
DQo+ID4gaW5kZXggYmEyOTcyMGUzZjcyLi5mZTkwNDZjMDNkZGQgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cWRsLXNhYnJlc2QuZHRzaQ0KPiA+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1zYWJyZXNkLmR0c2kNCj4gPiBAQCAt
NzU0LDExICs3NTQsMTYgQEAgbHZkczBfb3V0OiBlbmRwb2ludCB7ICAmcGNpZSB7DQo+ID4gICAg
ICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICAgICAgICAgcGluY3RybC0wID0g
PCZwaW5jdHJsX3BjaWU+Ow0KPiA+ICsgICAgICAgLyogVGhpcyBwcm9wZXJ0eSBpcyBkZXByZWNh
dGVkLCB1c2UgcmVzZXQtZ3Bpb3MgZnJvbSB0aGUgUm9vdA0KPiA+ICsgUG9ydCBub2RlLiAqLw0K
PiA+ICAgICAgICAgcmVzZXQtZ3BpbyA9IDwmZ3BpbzcgMTIgR1BJT19BQ1RJVkVfTE9XPjsNCj4g
DQo+IEknZCBzYXkganVzdCByZW1vdmUgdGhlIG9sZCBkZXNjcmlwdGlvbi4NCj4gDQo+IFlvdSdy
ZSBhc2tpbmcgZm9yIHRyb3VibGUgYnkgZGVzY3JpYmluZyB0aGUgc2FtZSB0aGluZyBpbiB0d28g
ZGlmZmVyZW50IHBsYWNlcy4NCg0KSGkgQ2hlbi1ZdSwNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRz
LCBhY3R1YWxseSB0aGlzIHRvcGljIGhhcyBiZWVuIGRpc2N1c3NlZCBpbiBWMSBhbmQgVjMsIHRo
ZQ0KY29uY2x1c2lvbiBpcyB0byBhZGQgYSBjb21tZW50IGhlcmUgdG8gYXZvaWQgY29uZnVzaW9u
LCB3aWxsIHJlbW92ZSB0aGUgZGVwcmVjYXRlZA0KcmVzZXQtZ3BpbyBwcm9wZXJ0eSB0b2dldGhl
ciB3aXRoIHRoaXMgY29tbWVudCBhZnRlciB0aGUgcGNpIHBhcnQgZHJpdmVyIG1lcmdlZC4NCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvYVcreDllQTFJJTJGbkdkQUw5
QGxpemhpLVByZWNpc2lvbi1Ub3dlci01ODEwLw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtZGV2aWNldHJlZS9hWU5rRFd0ODliMjZ3SldmQGxpemhpLVByZWNpc2lvbi1Ub3dlci01ODEw
Lw0KDQo+IA0KPiA+ICAgICAgICAgdnBjaWUtc3VwcGx5ID0gPCZyZWdfcGNpZT47DQo+IA0KPiBJ
IHdvdWxkIHByb2JhYmx5IGFsc28gdGFrZSB0aGlzIGNoYW5jZSB0byBqdXN0IGNvbnZlcnQgdG8g
dGhlIHByb3BlciBQQ0kgc2xvdA0KPiBzdXBwbHksIGFuZCBqdXN0IGFkZCBwd3JjdHJsIHN1cHBv
cnQgaW50byB5b3VyIFBDSWUgZHJpdmVyLg0KDQpZZXMsIHRoaXMgaXMgbXkgaW5pdGlhbCBpZGVh
LCB5b3UgY2FuIGZpbmQgdGhlc2UgaW5mbyBhbmQgbXkgbmV4dCBzdGVwIHBsYW4gaW4gdGhlDQpw
YXRjaCBzZXQgY292ZXIgbGV0dGVyLiBUaGlzIHBhdGNoIHNldCBhZGRzIHRoZSBiYXNpYyBpbXBs
ZW1lbnRhdGlvbiB0byBwYXJzZQ0KUm9vdCBQb3J0IGRldmljZSB0cmVlIG5vZGVzIGZpcnN0LiBP
bmNlIHRoZSBwYXRjaGVzIGFyZSBhY2NlcHRlZCwgSSB3aWxsIHN0YXJ0DQp3b3JrIG9uIHRoZSBw
d3JjdHJsIHN1cHBvcnQuIFRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KPiANCj4g
DQo+ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4NCj4gPiArJnBjaWVf
cG9ydDAgew0KPiA+ICsgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW83IDEyIEdQSU9fQUNUSVZF
X0xPVz47IH07DQo+ID4gKw0KPiA+ICAmcHdtMSB7DQo+ID4gICAgICAgICBwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiA+ICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3B3bTE+Ow0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwuZHRzaQ0K
PiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cWRsLmR0c2kNCj4gPiBpbmRleCA0
ZGMyYzQxMGNmNjEuLjk0Mzg4NjJiOTkyNyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9ueHAvaW14L2lteDZxZGwuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL254
cC9pbXgvaW14NnFkbC5kdHNpDQo+ID4gQEAgLTMwMiw2ICszMDIsMTcgQEAgcGNpZTogcGNpZUAx
ZmZjMDAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsa3MgSU1Y
NlFETF9DTEtfUENJRV9SRUZfMTI1TT47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAicGNpZSIsICJwY2llX2J1cyIsICJwY2llX3BoeSI7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcGNpZV9wb3J0MDogcGNpZUAwIHsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicGNpY2xhc3MsMDYwNCI7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDAgMHgwIDB4MCAweDA+Ow0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MDEgMHhm
Zj47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlczsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0K
PiA+DQo+ID4gICAgICAgICAgICAgICAgIGFpcHMxOiBidXNAMjAwMDAwMCB7IC8qIEFJUFMxICov
IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNhYnJl
YXV0by5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNhYnJlYXV0
by5kdHMNCj4gPiBpbmRleCBjNWIyMjBhZWFlZmQuLjZiMTJjYWI3MTc1ZiAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxcC1zYWJyZWF1dG8uZHRzDQo+ID4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cXAtc2FicmVhdXRvLmR0cw0KPiA+
IEBAIC00NSwxMCArNDUsMTUgQEAgTVg2UURMX1BBRF9HUElPXzZfX0VORVRfSVJRICAgICAgICAg
MHgwMDBiMQ0KPiA+ICB9Ow0KPiA+DQo+ID4gICZwY2llIHsNCj4gPiArICAgICAgIC8qIFRoaXMg
cHJvcGVydHkgaXMgZGVwcmVjYXRlZCwgdXNlIHJlc2V0LWdwaW9zIGZyb20gdGhlIFJvb3QNCj4g
PiArIFBvcnQgbm9kZS4gKi8NCj4gPiAgICAgICAgIHJlc2V0LWdwaW8gPSA8Jm1heDczMTBfYyA1
IEdQSU9fQUNUSVZFX0xPVz47DQo+ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gIH07
DQo+ID4NCj4gPiArJnBjaWVfcG9ydDAgew0KPiA+ICsgICAgICAgcmVzZXQtZ3Bpb3MgPSA8Jm1h
eDczMTBfYyA1IEdQSU9fQUNUSVZFX0xPVz47IH07DQo+ID4gKw0KPiA+ICAmc2F0YSB7DQo+ID4g
ICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4g
Pg0KPiA+DQo=
