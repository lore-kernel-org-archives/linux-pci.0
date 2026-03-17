Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC63A6B7E;
	Tue, 17 Mar 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743712; cv=fail; b=CApTF9v7MVKHHNuNu77XWJwovNwBL6BaxGKj6Az7rBVxN/i3Tj4j0h2NaORm85oobc9mQh2LcWoESgFDBIy3VAEeQnra7w9r0VQR3CFIXOfp+5cUCmwyNF1KHmXeVIePoosT0gQOQfiSJ/O/xQgLWAz3pxQ0YX+tajPHUkkVMFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743712; c=relaxed/simple;
	bh=NdfAxBC7vrK+6kmQjd+9S5yVb+sbHK2JBV2y/HZq2/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftwLJlFfPVy17knYHJjPbxJFEhGeCv2vcBmADG8+cLprSR8pmcqR6DClWuY1NqrBSkOwR6sVyUm65iDEeT4ojEgFNPiRxCjeMCVFqBalQ4Qal9Ls2jNVueR+Fo51TbUwAMH3WDZ7hPgNAL7ASkA0ESQV0od6PgYJzlYGywFHvMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HsqkiYyC; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HsqkiYyC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmzFW2X3hs+NZVKu5OUWmbcvSrMRiI6mFigHnM1hhu1LMoBrBVvBCXhnQoxyyt3hReGnljmAFfthHiO4xCj1wYiC66ZYmCDSKmJx47PSbV/tt8Q7Zf4Ve/wnAnANVhpZRw+AU1gPd6ESTYNaKXuXl8ygUOZ2iSaIK5kHekxxSfBiT/o4oE9hs2EcC5NhLfsBBaS5qA6EwBQakN8m5+UyDGnBzAwmzJ2h0Sk6Fc2yDauqJec2zPh1vmZQa+hwlCbtsQNAEpYJ4iMh8KUK04s0Ckrgpq8Xh3fSwuV5piACIBW7jRuHjyd5IInG/uLDE/hT16octvob5n4//hNEW+IFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdfAxBC7vrK+6kmQjd+9S5yVb+sbHK2JBV2y/HZq2/M=;
 b=c72+bH8LeKjlcevQDwqTUA7xLVdBIlb0qSUuYbh7wvfHpbc7vs8QFVSnWj4yvAkO2Avamo5SV4PlYj9HO11wYBL/VZNUOgjp7zI+qPHgzSC4TqXvWnxpD1de0TfeX53RHHNRgnpXu7lIQZkINPQSFAv23t6F7X0LSAuwZt32Xeg7YuAgKYAqERe/f6VUyq/soBZRDhltWVsd2lI/f6O34UU3tKbQVtMWcn/r3GEZjS9+6Fz0qQKlXJ3BUO6Y21izPG0Ax+DOLOjVUQBfLUFi4FP6yCTdh49n/noSgqiXQ+Mu2hrwmYSCXAS8rZx9EiKojlpNBcY+l0o1Ujxh6lVEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdfAxBC7vrK+6kmQjd+9S5yVb+sbHK2JBV2y/HZq2/M=;
 b=HsqkiYyCa/irxYGnZ1+i4Xq1ZzDq42qIiJEBNt+aDWxJDM5tQRqp9S/++uLsl88egDm9CUhW0uPevK/tLzOehfO8islXtIM/JJjeH/v1qNlZolAYh4tRqtbnuUyZqaaNpNJBK8O+IJzSbRxpX90a+se0buUII+I08YQuWlnpX3hUzi4kySHCJ8pxnjQ8yXksuHCJMFFTXY1qGqGBhTI1nlLOzQfcVyiQdk3jqR8XIr58wUs6R5s4/mgI1SWYGl3yv+GBfHPqGOTek3NfnQdKUuvRUd1LIAjfhv5wUPPMS4A04xkS8ds9njd/ie7n1CYk6rZNG11e+rziqtVsYxrzzA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 10:35:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 10:35:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V8 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V8 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHcso41LyLa5Yhnh0azxXWswLaPvrWwqb4AgAG2mHCAACHagIAAC9ww
Date: Tue, 17 Mar 2026 10:35:05 +0000
Message-ID:
 <VI0PR04MB121142FDBECE74AC6ED0DBD259241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-3-sherry.sun@nxp.com>
 <phrbp7ypfsilv75dh723l5hekjfm7hn7wetihibjqgix7czyyf@rq3sgaqsvu2s>
 <VI0PR04MB121147739ABAB0F3D5F402ED89241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <vixlrnt3a2mohavjbchth52sweq3syxlkps6dr45yj2uhkbgb5@kznmvy5kjygo>
In-Reply-To: <vixlrnt3a2mohavjbchth52sweq3syxlkps6dr45yj2uhkbgb5@kznmvy5kjygo>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI1PR04MB10049:EE_
x-ms-office365-filtering-correlation-id: 55159128-5285-4a00-56e4-08de8410da70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 sBPCqNB6eXxe+JIjfIK60fkoHKPyUfXVinq7WQ5gmg7lAaG+Y7/M18Utv44umJhCmDYRdoWK/FxFE+5UJrUagHXK7DD7f+fMHaXg+cGDGLFSCrWKSyK/UU9mCKsqc31qMalZSiFLXOEwPU9wH4+6hOJAnymd7zk2I2LhiuWLnkm7nv55rdjH+RgdDBNdVLeR+93FVB11BBJtzHWg5S6aJyD11zlLxSI3x4AUhXNJrHK6eDSvs0iPeMdi1rURGey4EHFFepVF9HAkW7RKuCA2VgtyTT1M55azMKQLmk/6T+8cOXgnWQ+kdbbFNMe9VT2cs/iblW8blk8TFB2vvd3iE/YuntlZN6VVN7r3kxg3sBjyqh+XWOYWSaQdvN/raM2QeG8eqEt+5dEXBTzVuKf9ZLVldGtUOeWCFti7EsDv2MxogXo4Cd6L1ea3CN9hO5TV4G2CZXoYESwnew46yw152snsO7N8zU2lWbpbpjCX1vApTgVgYb+rNLPzcDGt+sxk6CIX7kHGlTRCZr+QylH6+IaEMWlSBtON52+UJZJIdX37BlHlPLdME8T/yJp5BrPbVlqpstaFEAqG3+BKiBqRQ6aJLnix+gslT/Y5TvGxrhAvTZs9ji0eT2q4BsJnO3QUQZ86rLzY9V6t8njPzQ1AhOaUoxLsWo6CGggcXq2bp0bVqDxi4y23LyczSOTN1HJSbEFDn7naTwgWABOpH/zcNXt1MNqrKxpxrSr/pkwZihu/rk22rajvO1smMGuZ9VzWuZne2BSzRSJtfCoWyy3ItF2eu07umWyFx7S+2hfW7Wk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WENnWjI4MGQyazZqcW5yWTYvZGlKK3A2YlhsL25jSWo4dFlOcDNiZzBudlkv?=
 =?utf-8?B?T0VlUTk0TnA5VG9rRFBCaVpJcE14aEtidmZ6QkdKNUJJZnFtUmx5dDhiTThW?=
 =?utf-8?B?eHJDemhmWlJ4bG5QdlJqOHBnazhoQmloYkRiZGkyYm9GZkp3eU05cDJuZWFj?=
 =?utf-8?B?bVl5TnJvUUtVd1RQV1Z4Z1djU3RjRnNReGtJL3QvRkRvckpqUWVudytWd0hE?=
 =?utf-8?B?L0VWZ3kzUldFYmdmWW9UdE5tUFZ5dW9sMzBEaHJTNHZBWVBxMHdDYUVQNXdG?=
 =?utf-8?B?NXhsMmcwblpManJ3b3QrMU0rc0lTdHVGMldLNXdVbzZVR2wvTjJlMlJrcGRw?=
 =?utf-8?B?RmRRTlZzRndxSVUzWDRCbkJDNkNBZ29Bc1Z5b21ZOXhjcnEzdEU3SURUd0RL?=
 =?utf-8?B?dzJicVNYVVNpak9rTnhGQjRlbmVwcGNPU3YwZVpUamRHQnVmc0lRSFJaM09z?=
 =?utf-8?B?UmFSMlBYQ3dmN05JdU03blpZZFJoa2Z0R2dFSmFEWlMvTUF0TW82c3pmTWdz?=
 =?utf-8?B?aFRhdUdLUlJpeFlvYUJEODRnaGk1Y3FYV3ZwakRIK09FODRSOFI0R1BJSE9Q?=
 =?utf-8?B?eld6aEhtYU4rUDd1UlVNYjg4TDFTT1hwZ1pHV2FETldqWkxpSytpYnhZeW1i?=
 =?utf-8?B?Vy9IZUpTd1NQUVZpY2hOenhHVmx6OVlWWGc5QmNZTzRkTkM2UVpNWXY5aGRP?=
 =?utf-8?B?S1J0N2pZeWRZS2JlVURLc25kazV1VWR4RC9TZncxV3UvSjNqY3hGeThMeUVa?=
 =?utf-8?B?Q21WSXlIK1Vrd3lXUVBlSkc0RnpCcGpDNm52ekZmLzRjcitxUE84U1p6WTNi?=
 =?utf-8?B?VGFTZ3NsNzcvck5GSTlHQ0F0Zkg3cHpPbEZoK2g4enFWdk1lUmpDWXhCcE56?=
 =?utf-8?B?cFNBWnBOVzY4Z2t1eWRFeHlEU3hSSXQ2KzVjSUgwNkNGWXplem93UmdKa0JL?=
 =?utf-8?B?UFlad2dLa3htaDVHdU5oTXJnOUUwaWtDUmlhbHRNbmF3WWY1OGpJQTgvVEFq?=
 =?utf-8?B?UWhJaUd5WGZxSzdEOG1MNSszWVRxa1IzTk5DbTdnQktXdDRqWlk0cGhZdWV2?=
 =?utf-8?B?RU9jN0VuUFpVK2ExYlpvcU0zNzVyZjcxdk1jdDl5UEwzbDA0Sy9BOUtaN0N4?=
 =?utf-8?B?a3BzUllkOTBnaVRoaForMUxUYmpGWEVuYkxXZUU3K3U2NEFzVWV5QmZobHFL?=
 =?utf-8?B?L2pxZ1lEQm83czIzNFFmMkV1Lzlrak5OM3FaWUtrcVJlZnJoU3dVRXlHSzhW?=
 =?utf-8?B?YnVIRk8wMTFQVzRvVDNUTUhMTmI0S2M1anBLZDNjK1Bsc3FpdFB6blNhaDkz?=
 =?utf-8?B?MDFvWDkyamc5UDd6eUFFUXZrOXNueGxUYlZUbnJjM096T1k0WGU5T3dOWGMw?=
 =?utf-8?B?WEt5dGZlWkRyYjk1MmYyajVtZFk0SHNTTk9SZEZlSVNMYThRQnNBVGx6NG5k?=
 =?utf-8?B?Nk1yMVJaZExDcTh2bVFmcTBQcmNESzBIWVIrblFLTkE2clFTQ0FpbzdJVmRk?=
 =?utf-8?B?MXZPYUwxZHlNdTNFTVlHb3JneFd2TmtES2pTTGE1cC9uWS8xd2duYkxLMUZM?=
 =?utf-8?B?RU5UNHZwOGtYeGZENUlOa25HVEZJMkRYRTBKVnMrK3pUaC9CV0tZZkZVUWJW?=
 =?utf-8?B?MlRwUUFPeTBhMXpZZHpVNlBXVWswdFU0UmNlZVNYZFNYMjFZMEJGVEFBVkNT?=
 =?utf-8?B?NlNQbUhxay81UC9yQjNNVy9YcGY4SzBWalNuUEFweVdRcGRtTjI5WVE0bUlz?=
 =?utf-8?B?MGJmZGVBVUFqdjhaaS9lSEkzdWkzNVJzVEpCZnBaSitzVW5KQk1vQXIwbW9C?=
 =?utf-8?B?T1RyVnFBVStJbXlvdXJRUEZqcXFJeFVFQlFGRmNVRjRBdW5ldHo0R0RBczUv?=
 =?utf-8?B?aHBnNmNwRDhCVytPNXowZ0tlZmUwT2g3dzJqbDR2Wk1FL0xwaDN4TkNiV0M0?=
 =?utf-8?B?OUFXNnVzcWhveDR4VnczRWYxT1FEd0dqazQyTk1JOUpWOCtueVdWVVQyNWJP?=
 =?utf-8?B?ZFJ5WWtndXR5WmdvS2VvOC9KOC9FcFZ6UzAvU2hjZ0Jzb0oycVVDclhCV29n?=
 =?utf-8?B?QnE5OGJSRXVYQ1E0M1QvUVRGdzBvUEtwQUtISkd6RjE3NGw3NW93K0hxMzRx?=
 =?utf-8?B?Nkw4a1BnSCsxaU5IbmZBUUVweFpZbU1wVmNualdHMitKVmd4bFVONlZvNU9M?=
 =?utf-8?B?ZVkyODBWczN1YUo1TVp3QkxHSnRJUHRnbUFMSVFsbDZLQS91TGJDcjBCRVZG?=
 =?utf-8?B?WmJmdkJ3M3l4NUc5R3gwb0hRUHovUDVTOEYzRk41RFdnWFV6b0l3WGFINEV2?=
 =?utf-8?Q?qksE8jP6SHQQnCTKDR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55159128-5285-4a00-56e4-08de8410da70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 10:35:05.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnM2O5ZA/jb+r3v06Z4lOZ0dWNK+i55OE9HdQFJOeKCsFS9qXXdRYIQK/PKcMmgIbjJ1bZPYoxdEuNRZlWfi0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

PiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAwODowMToyOEFNICswMDAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+DQo+ID4gPiBPbiBGcmksIE1hciAxMywgMjAyNiBhdCAxMDowODoxMkFNICswODAw
LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+ID4gPiBJbnRyb2R1Y2UgZ2VuZXJpYyBoZWxwZXIgZnVu
Y3Rpb25zIHRvIHBhcnNlIFJvb3QgUG9ydCBkZXZpY2UgdHJlZQ0KPiA+ID4gPiBub2RlcyBhbmQg
ZXh0cmFjdCBjb21tb24gcHJvcGVydGllcyBsaWtlIHJlc2V0IEdQSU9zLiBUaGlzIGFsbG93cw0K
PiA+ID4gPiBtdWx0aXBsZSBQQ0kgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMgdG8gc2hhcmUgdGhl
IHNhbWUgcGFyc2luZyBsb2dpYy4NCj4gPiA+ID4NCj4gPiA+ID4gRGVmaW5lIHN0cnVjdCBwY2lf
aG9zdF9wb3J0IHRvIGhvbGQgY29tbW9uIFJvb3QgUG9ydCBwcm9wZXJ0aWVzDQo+ID4gPiA+IChj
dXJyZW50bHkgb25seSByZXNldCBHUElPIGRlc2NyaXB0b3IpIGFuZCBhZGQNCj4gPiA+ID4gcGNp
X2hvc3RfY29tbW9uX3BhcnNlX3BvcnRzKCkgdG8gcGFyc2UgUm9vdCBQb3J0IG5vZGVzIGZyb20g
ZGV2aWNlDQo+ID4gPiB0cmVlLg0KPiA+ID4gPg0KPiA+ID4gPiBBbHNvIGFkZCB0aGUgJ3BvcnRz
JyBsaXN0IHRvIHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgZm9yIGJldHRlcg0KPiA+ID4gPiBtYWlu
dGFpbiBwYXJzZWQgUm9vdCBQb3J0IGluZm9ybWF0aW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaG9zdC1jb21tb24uYyB8IDc4DQo+
ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKyAgZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaG9zdC1jb21tb24uaA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysgfA0KPiA+
ID4gMTUgKysrKysNCj4gPiA+ID4gIGRyaXZlcnMvcGNpL3Byb2JlLmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMSArDQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEgKw0KPiA+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aS1ob3N0LWNvbW1vbi5jDQo+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaG9z
dC1jb21tb24uYw0KPiA+ID4gPiBpbmRleCBkNjI1OGMxY2ZmZTUuLjJmMDEyY2Y4MDQ2MyAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaG9zdC1jb21tb24u
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5j
DQo+ID4gPiA+IEBAIC05LDYgKzksNyBAQA0KPiA+ID4gPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxp
bnV4L2tlcm5lbC5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiA+
ID4gICNpbmNsdWRlIDxsaW51eC9vZl9wY2kuaD4NCj4gPiA+ID4gQEAgLTE3LDYgKzE4LDgzIEBA
DQo+ID4gPiA+DQo+ID4gPiA+ICAjaW5jbHVkZSAicGNpLWhvc3QtY29tbW9uLmgiDQo+ID4gPiA+
DQo+ID4gPiA+ICsvKioNCj4gPiA+ID4gKyAqIHBjaV9ob3N0X2NvbW1vbl9kZWxldGVfcG9ydHMg
LSBDbGVhbnVwIGZ1bmN0aW9uIGZvciBwb3J0IGxpc3QNCj4gPiA+ID4gKyAqIEBkYXRhOiBQb2lu
dGVyIHRvIHRoZSBwb3J0IGxpc3QgaGVhZCAgKi8gc3RhdGljIHZvaWQNCj4gPiA+ID4gK3BjaV9o
b3N0X2NvbW1vbl9kZWxldGVfcG9ydHModm9pZCAqZGF0YSkgew0KPiA+ID4gPiArCXN0cnVjdCBs
aXN0X2hlYWQgKnBvcnRzID0gZGF0YTsNCj4gPiA+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfcG9ydCAq
cG9ydCwgKnRtcDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZShwb3J0LCB0bXAsIHBvcnRzLCBsaXN0KQ0KPiA+ID4gPiArCQlsaXN0X2RlbCgmcG9ydC0+bGlz
dCk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogcGNp
X2hvc3RfY29tbW9uX3BhcnNlX3BvcnQgLSBQYXJzZSBhIHNpbmdsZSBSb290IFBvcnQgbm9kZQ0K
PiA+ID4gPiArICogQGRldjogRGV2aWNlIHBvaW50ZXINCj4gPiA+ID4gKyAqIEBicmlkZ2U6IFBD
SSBob3N0IGJyaWRnZQ0KPiA+ID4gPiArICogQG5vZGU6IERldmljZSB0cmVlIG5vZGUgb2YgdGhl
IFJvb3QgUG9ydA0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybnM6IDAgb24gc3VjY2Vz
cywgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlICAqLw0KPiA+ID4gPiArc3RhdGljIGlu
dCBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gPiA+
ICsJCQkJICAgICAgc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlLA0KPiA+ID4gPiArCQkJ
CSAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkgew0KPiA+ID4gPiArCXN0cnVjdCBwY2lf
aG9zdF9wb3J0ICpwb3J0Ow0KPiA+ID4gPiArCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJcmVzZXQgPSBkZXZtX2Z3bm9kZV9ncGlvZF9nZXQoZGV2LCBvZl9m
d25vZGVfaGFuZGxlKG5vZGUpLA0KPiA+ID4gPiArCQkJCSAgICAgICJyZXNldCIsIEdQSU9EX0FT
SVMsICJQRVJTVCMiKTsNCj4gPiA+ID4gKwlpZiAoSVNfRVJSKHJlc2V0KSkNCj4gPiA+ID4gKwkJ
cmV0dXJuIFBUUl9FUlIocmVzZXQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcG9ydCA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqcG9ydCksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArCWlmICgh
cG9ydCkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlw
b3J0LT5yZXNldCA9IHJlc2V0Ow0KPiA+ID4gPiArCUlOSVRfTElTVF9IRUFEKCZwb3J0LT5saXN0
KTsNCj4gPiA+ID4gKwlsaXN0X2FkZF90YWlsKCZwb3J0LT5saXN0LCAmYnJpZGdlLT5wb3J0cyk7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0K
PiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydHMgLSBQ
YXJzZSBSb290IFBvcnQgbm9kZXMgZnJvbQ0KPiA+ID4gPiArZGV2aWNlIHRyZWUNCj4gPiA+ID4g
KyAqIEBkZXY6IERldmljZSBwb2ludGVyDQo+ID4gPiA+ICsgKiBAYnJpZGdlOiBQQ0kgaG9zdCBi
cmlkZ2UNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGl0ZXJhdGVzIHRo
cm91Z2ggY2hpbGQgbm9kZXMgb2YgdGhlIGhvc3QgYnJpZGdlDQo+ID4gPiA+ICthbmQgcGFyc2Vz
DQo+ID4gPiA+ICsgKiBSb290IFBvcnQgcHJvcGVydGllcyAoY3VycmVudGx5IG9ubHkgcmVzZXQg
R1BJTykuDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICogUmV0dXJuczogMCBvbiBzdWNjZXNzLCAt
RU5PRU5UIGlmIG5vIHBvcnRzIGZvdW5kLCBvdGhlcg0KPiA+ID4gPiArbmVnYXRpdmUgZXJyb3Ig
Y29kZXMNCj4gPiA+ID4gKyAqIG9uIGZhaWx1cmUNCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiAraW50
IHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0K
PiA+ID4gPiArcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UpIHsNCj4gPiA+ID4gKwlpbnQgcmV0ID0g
LUVOT0VOVDsNCj4gPiA+ID4gKwlpbnQgZXJyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZm9yX2Vh
Y2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGVfc2NvcGVkKGRldi0+b2Zfbm9kZSwgb2ZfcG9ydCkg
ew0KPiA+ID4gPiArCQlpZiAoIW9mX25vZGVfaXNfdHlwZShvZl9wb3J0LCAicGNpIikpDQo+ID4g
PiA+ICsJCQljb250aW51ZTsNCj4gPiA+ID4gKwkJcmV0ID0gcGNpX2hvc3RfY29tbW9uX3BhcnNl
X3BvcnQoZGV2LCBicmlkZ2UsIG9mX3BvcnQpOw0KPiA+ID4gPiArCQlpZiAocmV0KQ0KPiA+ID4g
PiArCQkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBJ
IHRoaW5rIHlvdSBzaG91bGQganVzdCBkbzoNCj4gPiA+DQo+ID4gPiAJaWYgKHJldCkNCj4gPiA+
IAkJcmV0dXJuIHJldDsNCj4gPiA+DQo+ID4gPiBhbmQgZ2V0IHJpZCBvZiAnZXJyJy4NCj4gPg0K
PiA+IEhpIE1hbmksIGRvIHlvdSBtZWFuIHRoZSBmb2xsb3dpbmcgbWV0aG9kPw0KPiA+DQo+ID4g
aW50IHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dA0KPiA+IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlKSB7DQo+ID4gICAgIGludCByZXQgPSAtRU5P
RU5UOw0KPiA+DQo+ID4gICAgIGZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlX3Njb3Bl
ZChkZXYtPm9mX25vZGUsIG9mX3BvcnQpIHsNCj4gPiAgICAgICAgIGlmICghb2Zfbm9kZV9pc190
eXBlKG9mX3BvcnQsICJwY2kiKSkNCj4gPiAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiAgICAg
ICAgIHJldCA9IHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0KGRldiwgYnJpZGdlLCBvZl9wb3J0
KTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiAgICAgfQ0KPiA+DQo+ID4gICAgIGlmIChyZXQpDQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+DQo+ID4gICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIHBjaV9ob3N0
X2NvbW1vbl9kZWxldGVfcG9ydHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAmYnJpZGdl
LT5wb3J0cyk7DQo+IA0KPiBIZXJlLCB5b3UgY2FuIGRvICdyZXR1cm4gZGV2bV9hZGRfYWN0aW9u
X29yX3Jlc2V0KCknDQoNCkhpIE1hbmksIHRoaXMgc291bmRzIGdvb2QgdG8gbWUsIHdpbGwgZml4
IHRoaXMgaW4gVjksIHRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
