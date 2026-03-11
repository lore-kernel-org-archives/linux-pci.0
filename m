Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023093.outbound.protection.outlook.com [40.107.44.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6927F017;
	Wed, 11 Mar 2026 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193668; cv=fail; b=iJIMw7TaYavSXKwnorP6fKh8flfjvQlqflw1YWHs/SbSTxTB2+1jdSchj/HhHIhsiM5BDhTJs/g77K5kQRSV3Bf4kiBkKuu08Lc8LY3wL1AXhfHQTO1Eh4J2OGOuRsUHOnhwN5FEvs1+a8pzAKIRofM2kRPPJTcwGBB1mPfiEcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193668; c=relaxed/simple;
	bh=tEcXaN/31s19pI2psZU3M476ohUlGjQtEdHVTqRISfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hk+drs+jQxGtEZjupVdXk73OvtXW7XJ1MbDCkic6lWjd6W3B+sOteDNW2NjhzRh8pYSRscOZP9kwxR6ycwHpYZH+IdwY1oSMYYu0GETr1yfokcJcJeI0aBViWeSsaYV7ECF2BCL0Lqx5dygcBUW6kBGTZRqd40tbXEhp2BrMbRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b15JodCAe71Rc8sr92/O8oOmMOsXZE4GuJa/0H7j2HvXBcGL1rJCce6IXSDjKhoG3Bmy5avrCQDx9VKHr7E6pXyFTs4wmJGFb7f1jQ7F+4/B7M3KkJY/1bsmkT3n3VxpCS/00dAmxJOarAMQNfb+YQA5r0EJZn+wiWZzAR2vQT/CsJxcIAB/HmYCijCaWdQBMyZPc0lr7aqKHanwKie4Gp3LQUrAB3zrM9zLL9YhzOg5z1kWpuKajBadkH+q522vXNTd5hzERbojfZd/dpi0nbY+df3q5Nz4AZOrM/RkBaPLP1+70AieGaP7Xk5GnTzUHLScb86mns0BJF957sJRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEcXaN/31s19pI2psZU3M476ohUlGjQtEdHVTqRISfc=;
 b=sjEDlD8gqlj8vNAPDvh04jzy92uHCGjhahmVB3zXD/k0vpyb/ZLy2Rx3IB4f5klAKIAfnGeG41C2bBrFlBQar9oqAABgmk1QfiL6ZAgf3wP1eevUrDV7w+ikbkAJaVAIL4h9SDdu9JmhPLR9LQKXPRyKysr+XLbuOqRamtvwzTneB0PUAGqdWgxI1z+W1j8oZCXrIaU1Gfu/3ypHvpMY5xQt8b5W/8wQLOo5p2uTF2iWi2K/dtnqRIDELECZDgZkADf3mXsvk+RK4WZ6NT8JHRg9HdxQZdg4YFuTGU9RusdjL5aIsQ0N9cWxVhGFThjCUYIkJiNWnT4bQQLwcoBWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by PUZPR06MB6267.apcprd06.prod.outlook.com (2603:1096:301:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 01:47:40 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908%6]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 01:47:40 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Peter Chen <peter.chen@cixtech.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogdXBkYXRl?=
 =?gb2312?Q?_CIX_Sky1_PCIe_Root_Complex_bindings?=
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: update CIX Sky1 PCIe Root
 Complex bindings
Thread-Index: AQHcsFqmVTyaz6drxUGpqWO9ODpvBLWn7/QAgACfg3A=
Date: Wed, 11 Mar 2026 01:47:40 +0000
Message-ID:
 <PUZPR06MB5887EC5DF2C85B7FCDD651D6EF47A@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20260310065338.2337761-2-gary.yang@cixtech.com>
 <20260310160954.GA691804@bhelgaas>
In-Reply-To: <20260310160954.GA691804@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|PUZPR06MB6267:EE_
x-ms-office365-filtering-correlation-id: 1132deb4-cabf-48fe-cf9a-08de7f102e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 gA8ALIYNS1tCa55wBG/H+Y7q3HwwwNP1x3zwT+SEd5aQYPeoGzmm9YMTI/bAnA8imTgPuLuNyeA7jkt3CM/QrouJcuCdMUX7xIgJftylkH+FhjyuNwAX0Oe4brsfDwYnzBt53fyLAKZb87He88ru1+Y4QmQ++xIHsw7jqNx3tX7eSNPg1qIODyaYBr/ljlrEjHZfF+nac4iblP87eh/ZnaIYuaFXg0PPZx0s1J7poBjHkb0ccY9e+bZopKPDrbjZ7AC1Le4Miq9wdbLXwOEf9AF2/kwiSATHVZs8BEyYFiXekAKazuMTv28lIpxWsh2DZG9UeVzPBjzsyvJe+HHgvWsht2Rgkzmr+SFhMYJJVVFoo65ZJD1nBdXiT0mJadSxm8HFLLvZli6Ot7NYeHojqraVLOgCCY8wQ0LazoD5+DhNEMzpU42rwW2CJcdlYvQRfkhvs3auj010FA+bHRsE1b4W150xN/WQRTHzmW76OwmAsqFBmfvkswvg97OzjOtrkK+UNow37dObGs4WG/hi5FvYxIIv6y36rkj18cxE71hkZVYkTreKM6ml2SiFIU6ht7m2Sv209nNTtngjHNBZML7jPt0r1u7WasKrdJxxZxEdfxN7izW2t81UpyYKalC84ooSCGJKzDino8cMWEnVrG3w4O8dKd7jBi1Ur5wBpzvV8LvVrWARM56EryQnsAuxH5nfwl+2ketupIPimeqE2m/cdUCwAUFl8tMa0fVQWk3pO4jsVQxEKTSQorvh18PJhk70GQmP3UnUkLwvgfKMuJuDeZ8RdQqsFPs7EhmGD34=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?a25mUXVCNmNDYzU5VXFqUFhuOFdVVmhuamw3VDJkTitKTHUxNkRUeElaL1ZB?=
 =?gb2312?B?cE45aHVPV0FKMmVlM1pRQXptSHVuaTRHUXpkaUJTK2JCUXVnaUJVQjU4QzhW?=
 =?gb2312?B?ZGEzcWVoTzhhWWtoL2VDNE80Mit0ZTAranFlbFVpZ1lrVGxRTG5JdTgvUnYy?=
 =?gb2312?B?Tm5Gell1STVjMjJPZ0k4c2tMK284bmhuVDlWV0dSSkg0NmFLZ2Jocm9ra3BC?=
 =?gb2312?B?WnRFMDBySVBDaXhtR2NVVTN1N2tTMktZcVYyVUtIWWhiTi9zUEhBRHdMYis0?=
 =?gb2312?B?QTU1SkJvcFUwdjN2dDYvV1J2enp0ck85MHo2blZqV0NITDUxSHhad21iSlls?=
 =?gb2312?B?bDBJeWxHWGwxUGpacDZxUnI2SnA3RXd3TXdBby94MGloaXhrMDZkZ1VRQ0Vk?=
 =?gb2312?B?UlVjYjMxNFV4WkMwNDNSY2s1R1ZjQ2kydnRwWDkxbEFKRmlTMDZiZ2c5aVhO?=
 =?gb2312?B?clo1SEpiWk9rcVUwZlhFZTBpcmhvbkxuSXB1RldrRXpPUTZUQ3Btd3RiZVB2?=
 =?gb2312?B?S2RVazFJaGRhMm9aQ0xFZ3kwdFZhTGxwV3JLK01PdzhzdWdnQU9iS29vVFIy?=
 =?gb2312?B?RmhzOHhZODF4blNzem9HdGpGdWdaOFpXc1hRUENRM3orbXY4WUN0ZXVLSDBC?=
 =?gb2312?B?cEg3dVpEZG0xSlRHR0lKemQ1aU02VzVvMHo4dm0vUk5rbThvM1lyTlJYMnZN?=
 =?gb2312?B?UFc0clZWQUNrNUVSOTY5Yi9zS204b0FoSHRCTjI4cFQxRGYzOGU3WnF6c1pJ?=
 =?gb2312?B?bWhRRG5zSXBVNzR3OXpSVlhyYytOT2NVbURtK1llRzhKamRhbHhWRElTcEFX?=
 =?gb2312?B?NGtpbUw5VFRUdzdWcWQ0YVR2eWlGalNhSUMrQnFZYW81cE10L3pQZytuaHpX?=
 =?gb2312?B?WU5BdkZxREMxWXpQMW9OOEtwWFpiU3ZIZ3NleEdGYXI3T0tFeGw2Wmk4aTdw?=
 =?gb2312?B?VTM4NmF3N01OaGxLYmxGMFErek5sMWc3NWlHZ05XQ0lyemRzaHJjanBRZXBh?=
 =?gb2312?B?WFBUaXZsbENWelExUVc5WlNTN0tSN3ZUTUFYU09mWnN1WHZlSlM2RFJOR2My?=
 =?gb2312?B?Z1dBdzQ2L0JMTFJiclNmQkNlSDlRSkVjZWxVdjRwQnA0cUlrLzJrUG1HclUr?=
 =?gb2312?B?N0FBU3AyMks5N3NRTEpaRm1NYTR0T3kxWkRDUTl1NG9ZRUxzSUNUeGpHMitO?=
 =?gb2312?B?Y2ZiQ0tWRXFJejBTTGF5aW1lK3N3MENMN2d3NW5zZENhdGZqY3ZuQWdXTjZ0?=
 =?gb2312?B?VGNWalFJeGgrK2p5bDhuVi9XRm1iWFpJOC9UTXpKSTBlcE5JNzd6TVRaR0tq?=
 =?gb2312?B?Tzh1Qjc4QUlZOE5pdDhzSXNuaXltOXp6VmttMzVtTHVwb2Z3TXphMWdXcU9U?=
 =?gb2312?B?Vm5ZWW93NzJYTHJiOTd2aDQ2alhiZENJSCt3eGhzWGxPdWJVL2txUHpwbFZK?=
 =?gb2312?B?ZGFtb2ZmamVvaWJGZnp0Vy9yWXNjY0l3aGFTVzVmVmROTDUwd1RJNEZFMnd2?=
 =?gb2312?B?KzY1a1d2cGRKWGhPNkxFbG9JZlozQnBFRmswU0htWStGZ2VENFJUdGtQY3Z1?=
 =?gb2312?B?WVRmcEFwN1J5bEo1YWdTdXNaOEtqcGJic1ZuNVEzbXFGTVdjU1FKclRlQndO?=
 =?gb2312?B?ck42Y2MzTWduYmVnRmE5VDlJdGdsSDdvcTVQZk1PM1VVRDBoU1R2LzdsaFFa?=
 =?gb2312?B?RGhSUTBXdnRTVlFlb3AyT2lLUGJKSXdvY1Bidllqdjc5RS8wWCsyeCt5V0pJ?=
 =?gb2312?B?bnZSaXdLU2NqWU5MeXlkMnBwbW0zYStUS09ET1pzOEpWOGhBdWVBRFZVL2Np?=
 =?gb2312?B?VWk5ZzNJbFNXV3NPalpXMzV6cWNMVG9CZmhaNVJHT0JObHp3dUJiY3dtUm1H?=
 =?gb2312?B?UER6MWV6am9mWnFzdnZtT3NwcVN0bDVZZXJhejdtT09HcllrdGl0WUIyY0wr?=
 =?gb2312?B?SXdRaUlFN2drUnM3NzRScmc5ZnoyVmpFanlMRGdOOUZRck55RUw2UTNVTnlr?=
 =?gb2312?B?OE9XN2llL0NHZ3BJZnpwRW13U1JpeGJtQ2VlNk1HUkhKMm5OYzJVaCtPdDZv?=
 =?gb2312?B?RkR4ZmJFb2Vyem1aS0RiMUp3aWtuM3dKbFBZdy9wVml1Uzd0aDdXQlAySFdp?=
 =?gb2312?B?WHlleUc5dTRFOXdtRGJwSGRvREdVemo4ekp0dnlGWW5CdGZURHhPSXRoSzFE?=
 =?gb2312?B?Rk9HeDRhMEZxNzRpVVJ5RDJ2RWdJSVF0bXVuVFY3Zy9xZ29LdXAvVEd5a2w2?=
 =?gb2312?B?RDQvdXhHWWN6cVlOM1gveFFtOEgzdVdGaWYxOEJraVFqeS91djluckFGSDZy?=
 =?gb2312?B?MVdvdjcyWmtBNEhJWWFpWTRwOE5MazZpRHVSbFg4cytzOHdZV3pIZz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5887.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1132deb4-cabf-48fe-cf9a-08de7f102e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 01:47:40.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XxDyfbblxm1MAn5lYuL9PKX5xqgBjArOVBz+U9OV3Xfdw77k0uwHDJXxR+I/iDa/+nHCOmvgRYSDlkJiV4xYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6267

SGkgQmpvcm46DQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cw0KDQo+IA0KPiBFWFRFUk5BTCBF
TUFJTA0KPiANCj4gUmUgdGhlIHN1YmplY3QsIGV2ZXJ5IHBhdGNoIGlzIGFuIHVwZGF0ZS4gIENh
biB5b3UgaW5jbHVkZSBzb21ldGhpbmcgYWJvdXQNCj4gdGhlICpjb250ZW50KiBvZiB0aGUgY2hh
bmdlPw0KPiANCj4gQWxzbyBydW4gImdpdCBsb2cgLS1vbmVsaW5lIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvIg0KPiBhbmQgbWFrZSB5b3VycyBtYXRjaC4gIEluIHRoaXMg
Y2FzZSwgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgIGR0LWJpbmRpbmdzOiBQQ0k6IGNpeCxza3kx
LXBjaWUtaG9zdDogQWRkIHBvd2VyLWRvbWFpbnMNCj4gDQoNCk9LLCBUaGFua3MgZm9yIHlvdXIg
a2luZGx5IHJlbWluZC4gV2Ugd2lsbCBmaXggaXQgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2Fy
ZHMNCkdhcnkNCg0KPiBPbiBUdWUsIE1hciAxMCwgMjAyNiBhdCAwMjo1MzozN1BNICswODAwLCBH
YXJ5IFlhbmcgd3JvdGU6DQo+ID4gYWRkIHBvd2VyLWRvbWFpbnMgYW5kIHBvd2VyLWRvbWFpbi1u
YW1lcyBwcm9wZXJ0eQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2FyeSBZYW5nIDxnYXJ5Lnlh
bmdAY2l4dGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9jaXgsc2t5MS1wY2llLWhvc3QueWFtbCAgICAgICAgIHwgNiArKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jaXgsc2t5MS1wY2llLWhvc3QueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jaXgsc2t5MS1w
Y2llLWhvc3QueWFtbA0KPiA+IGluZGV4IGI5MTBhNDJlMDg0My4uMWQ4ZWU4MzEwNTg4IDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNr
eTEtcGNpZS1ob3N0LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL2NpeCxza3kxLXBjaWUtaG9zdC55YW1sDQo+ID4gQEAgLTM4LDYgKzM4LDEyIEBA
IHByb3BlcnRpZXM6DQo+ID4gICAgcmFuZ2VzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDMNCj4gPg0K
PiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsNCj4gPiAr
ICBwb3dlci1kb21haW4tbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsNCj4gPiAg
cmVxdWlyZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4gICAgLSByYW5nZXMNCj4gPiAtLQ0K
PiA+IDIuNDkuMA0KPiA+DQo=
