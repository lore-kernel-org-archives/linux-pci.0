Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A02BEFFD;
	Tue, 17 Mar 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734495; cv=fail; b=dzqbDL/QVmc6zYn6Kj4zHRHPlyu66wD/di/kmMHXu7/ClvWct+pqHZ2IAKxH3tiIbkMOPjq0yaoMvTh88qbfybPEsyhFxGP8phh+nHCh/zums9zTapFrzH/r/mBTIOd5343EOtc1jY2bRyYH3/Zw92r2xH4RyDV65qndA0d+nT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734495; c=relaxed/simple;
	bh=Z+opE4KfITHA0mpYchStZbIQC9zYRZrZVjmQNXkVP/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rDGRcsaEdhr8FCsqAKyNyoxi3Iq//3DZZnqdqHobGgpyq1mD1UclimP6Q7fXVUsxh3YO8lpCj0fbOU7PHn0PHJhLy0XBeDpqwZd7gp2QjJkCAOXtp7XexNEOqCpxN/VZnL6PR9Fv8pGwcF24CAlBvHqs/ZobohTu5ipA0/c1njY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GzesnzGE; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GzesnzGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKVt1j7n0UXtfYKxYlFqY7Jz6HMJOHXHX2YCDYFrCZ22UAIEN9nq7UHVVNN7JMfD9eJGAUl038JDhuT/orH5ySuQGWdhntXUnPEG4iCZjBBQ/SaSRzv0xsCHuvcpAwDFSbvTPE7fQeLzIhuu87X7TLh0u1+mD0ksSlue9kGS3w964YLs88LOG4b33/6azpoe4mehsz6srZjSD99E8tSTaXXxW1gBHq60/M1LHADS2oj+4Rkec/Uh10eVaOOwEPiIWEXSi6kB399gYFeKor9yhA5gNwvz9ePIMts6EOouPGJcN7UAF26kG8ibBjzbXmFiA8MdsjUICK/TIUNI0MVelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+opE4KfITHA0mpYchStZbIQC9zYRZrZVjmQNXkVP/Y=;
 b=fDrPa7/fcA29822icx7H58CXeSEiRHpt7YzOy2Qo1bmYpPCkauTPvquSQHe2cTpz3QC7TmvQMHbuj2asyVt+Pghl+HYr7/lIjA6ZEhaRLZ7U6sJ47QYUg55OLXtCVfKXzpzCWWlZP+XAVDFZp2H3kFak0AVTpHuMVMhP2VLi0+ZIccPW+jylEG5hym2BYqDE/IuZKOzVW21sMeBNpkVvH0BgbYaXMi4QzvTDxHGR5R9wyK/hgu4OyPpeoULm4FjwF1VNdFuBoy0KCOr+s9NlpRVILNWM3ZCWsS1m7LoA6YS4gmWmXVrEI5EowTgVzHe64LobnE2I6zXsOHktUBqECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+opE4KfITHA0mpYchStZbIQC9zYRZrZVjmQNXkVP/Y=;
 b=GzesnzGEuQvoOeqqKDn8uy4Wa1oQ7ROXexLaQIEO57us3norMrQJxPJaI1RvNnhYu6FmRAElD5Z41wKW7h2tjn5zU5/x5yk4k8MXbmAot+cq+YtARH5BYuyc6RYGcQf2b1F3wEswJtxsNKfELBzecBTsYMKIb6KhWeh0Z9owegDNAcPGT15Ffzv2znecsjzjzNLxhcR2CZ6gMNxE2pyfopKRi4kdW0Gubw+ZturdL04mIEmB+mMBSDdJfZCwJpUm/hvcFv2UdaocF9HSPUNy46rOzmAY8I02pL8bNZ195GQ2qU+TM8sbOOLoKMiw9p2R1cDC3apbW304c2B3cXxccg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI1PR04MB9979.eurprd04.prod.outlook.com
 (2603:10a6:800:1da::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 08:01:24 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 08:01:28 +0000
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
Thread-Index: AQHcso41LyLa5Yhnh0azxXWswLaPvrWwqb4AgAG2mHA=
Date: Tue, 17 Mar 2026 08:01:28 +0000
Message-ID:
 <VI0PR04MB121147739ABAB0F3D5F402ED89241A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-3-sherry.sun@nxp.com>
 <phrbp7ypfsilv75dh723l5hekjfm7hn7wetihibjqgix7czyyf@rq3sgaqsvu2s>
In-Reply-To: <phrbp7ypfsilv75dh723l5hekjfm7hn7wetihibjqgix7czyyf@rq3sgaqsvu2s>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI1PR04MB9979:EE_
x-ms-office365-filtering-correlation-id: bd9771c8-47bf-4f94-eb65-08de83fb6503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 /fFRoZWWlMOwHcBgi/e5w7X13DqbQw1QmhGJ3eIiuGMDqGSSNC0bogMEjar5a/OQHvhvyD/SUtSjpUNh7M1rBUDq7V4Wk4A3GAcTZw7VnNOA05Jps74WSNN4U/SD/tSjwMC74sDG+R3NrKK1MOEwa7K0qvx3bO4C3jjuANqMZE/oS+54cajypdppZ1GdeGLOa2TdNBl9S+hgSJVZE+/JrLEIGfsOUS/hpQhYTO5nIsy33LpOYtc6tywIv2o9d1JYD3nZ1RktZK7x583gUXVXzktZmBmbg9qh/2WAucGf5twzNiOGteXmtPuRfWcnzQzOlcCvYzaxVdYRh9Bii/s0C9yLG8ui5ZEUdPvAvCP1XtpNqwdh0cHQKhY3b2Yn9Chllinl/AWG6zWMTYY2TkJy10OEIO6HJGkAOlG1oXRhkSkAyiSm5nsxAMu7bdErSaPo3sye/uQS/EdrbUgdOt9sCrOpHo30DyM2DRugBkzu9HyO1YF8Y9fu2UjPyt5qWA7X0lpkllmGE1khITW6bkpE5ZOS2+21t/+BzOAZGa/n/mQrGDufFdkKPoeF9olM1QInd31vo3DMdENIH6BavsQqAEyyLJWKBPDufZoYKWdGK2DNg6o6HFr6hZJRLr73M7E28uGbnRa5QlO8IsLkii69B0dfhN8sMvQJwHoEZY16SzdXaGRNZ8dZLgzluMVsXlVZCT1MCleiTbZPTj0RGWtX0AidX9luD+fVcQMxV7PaItxkAtOJhv9HDKr8WUaUQtJd71/wXMPte95hqlIXmrw6TdxZrrwkJYGDs1m707vNUcs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eW96aTdGWUV0bVE3dUhJUTVjbUQ5M2VrVlZ4MnJpRDNWZ1Y5YVpkbXZFL2Q2?=
 =?utf-8?B?V3RzOGRnQ3hPUkxNdG9MNnBpRGQ1c1B0Z1lHTEVNYXB1Q0VsbmRVT0xjTEV0?=
 =?utf-8?B?VlhIR2hhWm9IRlVxL2JleC85UUpFaE1UeEJjMDloaWN1c0E1YXFuQVdLaGlI?=
 =?utf-8?B?MG04OVhrUTFFUnloaFRKdFNVL1liUVdteDAwYlJpOHhHaXk0dDZYZkJkb1dx?=
 =?utf-8?B?b3lpY1VHcEVKSjZiSFZWdmZMNkRDUjh5SVBDQnFOT2tzZTMxWk5GTWxISFNM?=
 =?utf-8?B?TGpBOWdHQkptL0dOcVR0YU5zSy9ka2JYeVBHT1o2WTRTYXVCUURQeTJKeXRr?=
 =?utf-8?B?YlpNbjBNYW9uVjN3dGRiRElyTmZMQ3ZOY3ZPUXlLQkN6YXVRSW1vYUF4cmZK?=
 =?utf-8?B?aDNaam5kOGlEd2ZtTTVSVW82OGtKOExIMXgxUlVFWS93V0xnRkpOaC9VQUZZ?=
 =?utf-8?B?U0dFS1Y4THg4WlZ3T0toM1RHTUdtblZVdFpyR2lzUFpxTHBNWVZNTkFxM1Mz?=
 =?utf-8?B?MExpcllyWVRUZnNNWENTOG8vaEEwYXpEd2phVmFKNW1SVmRKZHFhUWdIV24v?=
 =?utf-8?B?U3ZvQ2NHNDFGVGcrN3Zrd2YzOW13VC93LzFSb0hhdGpWemFTOWpHSmhRQ0pn?=
 =?utf-8?B?UUJtekVGRURYMS9NSG9vTjBPbjNIazNKRHhCSm9kb3phMjYyY1pZbURMY0Ev?=
 =?utf-8?B?Z0FITDNYY245RG9Qa1BqN05oR05CRjdUdEF6NXoxR3UwT2x4U0ZKQnhURGNh?=
 =?utf-8?B?RXVTbjg4K1c3bldyZThzcGNQTWhod21yUUswVkRqRkRWdnkyV1BhVDBZUEVW?=
 =?utf-8?B?Z2g5bnpZeWV6c0IxQmpWSVRTK2hxcXBTbVpaT04xdTZwRndZYmJablFPc3B1?=
 =?utf-8?B?a2NBeVBmSlFHbVVDTGx4U2ZMVkFyY2o5cEpMbFF0QUYyaXN0ZWoraExvb1kr?=
 =?utf-8?B?T0xhOU10eVU2akhXRUdCUzdDK0xFMkJKU0h4bnhZdlNOSUc2ZXlnOVFxRnRV?=
 =?utf-8?B?ZzlSSS9MRGtCck1jVjloWDBFaEhzMXhhM0plYjRwWmU4a01zeEdwcmdSMGo5?=
 =?utf-8?B?WEY0Wk5sMHBPSEtQc25hbm1LdHdCc25pUnlHWHNwVWk4d2VESXZiRHprMUgv?=
 =?utf-8?B?N1ZRV1N5RnlpcEFkZmZKV1dZNkY3OGVtTWFDM2ZuRVZtTHM3OExkejJTUDhk?=
 =?utf-8?B?dlo2dW1rM0M4YnJNL2R4K1RNemRldUVxT3hlNDExQUplMWl0Q2h2Y0VpZk93?=
 =?utf-8?B?R3BNSnpmS1M0dEVMei9PemoxbkFHTkducUp2aXZRZktMRmxhcVRVQlNQc0sv?=
 =?utf-8?B?T3RIV3VKNmg4MkYyT3BMcE4xZ2NxRk10MzZTNnNKMWJodUN5eUNMY2JtRDNq?=
 =?utf-8?B?bkhSWnk1TnU4NGFPV1FSWnl0enJUVU5VM0RKekV0SG04RmN3TjBicUJURC9T?=
 =?utf-8?B?TlpodGhDS2R1aFkveFRDTFhFTXlUNHkraFNnS1h4NUdJTFBQR0RCOURCbUpq?=
 =?utf-8?B?SGp6MDg3a04wYjg0MS8xYlFqbzQ5c0U3OHlIWGNJOXhvZ3h2Y1dqRVU4TUIr?=
 =?utf-8?B?N2plNjI4VVNRQ241MUZHSldsTStBZzNFcFlnS0dITEJrQkVETUxsdGRrem5M?=
 =?utf-8?B?Y1Bmb0puRENid0lweE1Udld5Z2FoM2Q4TGJIMndBWkxHSUQyWktyNCt3WjBY?=
 =?utf-8?B?YURwWTVWV1hubTFlanhBRnQ5NDJRRi9UQTJ1WTVBeGhMZ2dkMW1EVitIeHlm?=
 =?utf-8?B?eUlNREJhRmNrb2RZYXpyQlRHd0lWWU05Z3EybW9Xdk5EcmlZTVZod2twa1RO?=
 =?utf-8?B?dGFmYzJobllBb2VDUUZKRVE0dDl0ODkzM1A3clBXQnNkSnNLTm1PWEtoRW5Y?=
 =?utf-8?B?SnYxdXkybW5mSXlUYkhDeGl5bWpFeGUzLzhYZ2RrNWEwZmExYno5Vllxd09L?=
 =?utf-8?B?THVkQ2M3K2VSTkkwL2grZ1VSMVBnTXhZeDRDeFhYcUZyczFsYVljcXJ3blM5?=
 =?utf-8?B?VmxqekFHYTJ5ci9SaGFxbW9PVEllOWZXelVnb3pydjNsV3Rqa1ZIUThOcEpP?=
 =?utf-8?B?NjBrNG1KR0w3K2w5dHJ1UFd5TWNYSWRlQzVzK2RJempoSHF3enZaalNhSkhK?=
 =?utf-8?B?cGpXY2t2U3dPOFJBQ3Zhejl3bVUxdk8xYldGSHlEN1BWZ25BZTg0UUhNZlNu?=
 =?utf-8?B?QnIycUowdVVXZVR4dGR3Y0NZZCtsZ2todkVSUTYrNjdWelNEb0xteDQvWEsw?=
 =?utf-8?B?aDBnQWRKV2EraDF6NzZ4ZUNGOS9URkJUckVILzE1aEtYVzJ5VGY3SW1zTHhz?=
 =?utf-8?Q?e/LCWo80hElMFmEqTX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9771c8-47bf-4f94-eb65-08de83fb6503
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 08:01:28.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLt9IZl2T9E48hJnP+ZebO5gW8Q/GNQ7RIWDDSDaVMb5LCwu+sGPVMnxLCungji+nbXovf+2iA4/2yJO8xDEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9979

DQo+IE9uIEZyaSwgTWFyIDEzLCAyMDI2IGF0IDEwOjA4OjEyQU0gKzA4MDAsIFNoZXJyeSBTdW4g
d3JvdGU6DQo+ID4gSW50cm9kdWNlIGdlbmVyaWMgaGVscGVyIGZ1bmN0aW9ucyB0byBwYXJzZSBS
b290IFBvcnQgZGV2aWNlIHRyZWUNCj4gPiBub2RlcyBhbmQgZXh0cmFjdCBjb21tb24gcHJvcGVy
dGllcyBsaWtlIHJlc2V0IEdQSU9zLiBUaGlzIGFsbG93cw0KPiA+IG11bHRpcGxlIFBDSSBob3N0
IGNvbnRyb2xsZXIgZHJpdmVycyB0byBzaGFyZSB0aGUgc2FtZSBwYXJzaW5nIGxvZ2ljLg0KPiA+
DQo+ID4gRGVmaW5lIHN0cnVjdCBwY2lfaG9zdF9wb3J0IHRvIGhvbGQgY29tbW9uIFJvb3QgUG9y
dCBwcm9wZXJ0aWVzDQo+ID4gKGN1cnJlbnRseSBvbmx5IHJlc2V0IEdQSU8gZGVzY3JpcHRvcikg
YW5kIGFkZA0KPiA+IHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0cygpIHRvIHBhcnNlIFJvb3Qg
UG9ydCBub2RlcyBmcm9tIGRldmljZQ0KPiB0cmVlLg0KPiA+DQo+ID4gQWxzbyBhZGQgdGhlICdw
b3J0cycgbGlzdCB0byBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlIGZvciBiZXR0ZXINCj4gPiBtYWlu
dGFpbiBwYXJzZWQgUm9vdCBQb3J0IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jIHwgNzgNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29tbW9uLmggfA0K
PiAxNSArKysrKw0KPiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5jICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAgICAgICAgICAgIHwg
IDEgKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jDQo+ID4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jDQo+ID4gaW5kZXggZDYy
NThjMWNmZmU1Li4yZjAxMmNmODA0NjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2ktaG9zdC1jb21tb24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLWhvc3QtY29tbW9uLmMNCj4gPiBAQCAtOSw2ICs5LDcgQEANCj4gPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L29mLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9vZl9wY2kuaD4NCj4gPiBAQCAtMTcsNiArMTgsODMgQEANCj4gPg0KPiA+ICAjaW5j
bHVkZSAicGNpLWhvc3QtY29tbW9uLmgiDQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIHBjaV9ob3N0
X2NvbW1vbl9kZWxldGVfcG9ydHMgLSBDbGVhbnVwIGZ1bmN0aW9uIGZvciBwb3J0IGxpc3QNCj4g
PiArICogQGRhdGE6IFBvaW50ZXIgdG8gdGhlIHBvcnQgbGlzdCBoZWFkICAqLyBzdGF0aWMgdm9p
ZA0KPiA+ICtwY2lfaG9zdF9jb21tb25fZGVsZXRlX3BvcnRzKHZvaWQgKmRhdGEpIHsNCj4gPiAr
CXN0cnVjdCBsaXN0X2hlYWQgKnBvcnRzID0gZGF0YTsNCj4gPiArCXN0cnVjdCBwY2lfaG9zdF9w
b3J0ICpwb3J0LCAqdG1wOw0KPiA+ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShw
b3J0LCB0bXAsIHBvcnRzLCBsaXN0KQ0KPiA+ICsJCWxpc3RfZGVsKCZwb3J0LT5saXN0KTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0
IC0gUGFyc2UgYSBzaW5nbGUgUm9vdCBQb3J0IG5vZGUNCj4gPiArICogQGRldjogRGV2aWNlIHBv
aW50ZXINCj4gPiArICogQGJyaWRnZTogUENJIGhvc3QgYnJpZGdlDQo+ID4gKyAqIEBub2RlOiBE
ZXZpY2UgdHJlZSBub2RlIG9mIHRoZSBSb290IFBvcnQNCj4gPiArICoNCj4gPiArICogUmV0dXJu
czogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUgICovIHN0YXRp
Yw0KPiA+ICtpbnQgcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnQoc3RydWN0IGRldmljZSAqZGV2
LA0KPiA+ICsJCQkJICAgICAgc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlLA0KPiA+ICsJ
CQkJICAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qg
cGNpX2hvc3RfcG9ydCAqcG9ydDsNCj4gPiArCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0Ow0KPiA+
ICsNCj4gPiArCXJlc2V0ID0gZGV2bV9md25vZGVfZ3Bpb2RfZ2V0KGRldiwgb2ZfZndub2RlX2hh
bmRsZShub2RlKSwNCj4gPiArCQkJCSAgICAgICJyZXNldCIsIEdQSU9EX0FTSVMsICJQRVJTVCMi
KTsNCj4gPiArCWlmIChJU19FUlIocmVzZXQpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKHJlc2V0
KTsNCj4gPiArDQo+ID4gKwlwb3J0ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwb3J0KSwg
R0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXBvcnQpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICsJcG9ydC0+cmVzZXQgPSByZXNldDsNCj4gPiArCUlOSVRfTElTVF9IRUFEKCZw
b3J0LT5saXN0KTsNCj4gPiArCWxpc3RfYWRkX3RhaWwoJnBvcnQtPmxpc3QsICZicmlkZ2UtPnBv
cnRzKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+
ID4gKyAqIHBjaV9ob3N0X2NvbW1vbl9wYXJzZV9wb3J0cyAtIFBhcnNlIFJvb3QgUG9ydCBub2Rl
cyBmcm9tIGRldmljZQ0KPiA+ICt0cmVlDQo+ID4gKyAqIEBkZXY6IERldmljZSBwb2ludGVyDQo+
ID4gKyAqIEBicmlkZ2U6IFBDSSBob3N0IGJyaWRnZQ0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1
bmN0aW9uIGl0ZXJhdGVzIHRocm91Z2ggY2hpbGQgbm9kZXMgb2YgdGhlIGhvc3QgYnJpZGdlIGFu
ZA0KPiA+ICtwYXJzZXMNCj4gPiArICogUm9vdCBQb3J0IHByb3BlcnRpZXMgKGN1cnJlbnRseSBv
bmx5IHJlc2V0IEdQSU8pLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3Ms
IC1FTk9FTlQgaWYgbm8gcG9ydHMgZm91bmQsIG90aGVyIG5lZ2F0aXZlDQo+ID4gK2Vycm9yIGNv
ZGVzDQo+ID4gKyAqIG9uIGZhaWx1cmUNCj4gPiArICovDQo+ID4gK2ludCBwY2lfaG9zdF9jb21t
b25fcGFyc2VfcG9ydHMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gPiArcGNpX2hvc3Rf
YnJpZGdlICpicmlkZ2UpIHsNCj4gPiArCWludCByZXQgPSAtRU5PRU5UOw0KPiA+ICsJaW50IGVy
cjsNCj4gPiArDQo+ID4gKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZV9zY29wZWQo
ZGV2LT5vZl9ub2RlLCBvZl9wb3J0KSB7DQo+ID4gKwkJaWYgKCFvZl9ub2RlX2lzX3R5cGUob2Zf
cG9ydCwgInBjaSIpKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArCQlyZXQgPSBwY2lfaG9zdF9j
b21tb25fcGFyc2VfcG9ydChkZXYsIGJyaWRnZSwgb2ZfcG9ydCk7DQo+ID4gKwkJaWYgKHJldCkN
Cj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiBJIHRoaW5rIHlvdSBz
aG91bGQganVzdCBkbzoNCj4gDQo+IAlpZiAocmV0KQ0KPiAJCXJldHVybiByZXQ7DQo+IA0KPiBh
bmQgZ2V0IHJpZCBvZiAnZXJyJy4NCg0KSGkgTWFuaSwgZG8geW91IG1lYW4gdGhlIGZvbGxvd2lu
ZyBtZXRob2Q/DQoNCmludCBwY2lfaG9zdF9jb21tb25fcGFyc2VfcG9ydHMoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UpDQp7DQogICAgaW50IHJldCA9
IC1FTk9FTlQ7DQoNCiAgICBmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZV9zY29wZWQo
ZGV2LT5vZl9ub2RlLCBvZl9wb3J0KSB7DQogICAgICAgIGlmICghb2Zfbm9kZV9pc190eXBlKG9m
X3BvcnQsICJwY2kiKSkNCiAgICAgICAgICAgIGNvbnRpbnVlOw0KICAgICAgICByZXQgPSBwY2lf
aG9zdF9jb21tb25fcGFyc2VfcG9ydChkZXYsIGJyaWRnZSwgb2ZfcG9ydCk7DQogICAgICAgIGlm
IChyZXQpDQogICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgIH0NCg0KICAgIGlmIChyZXQpDQog
ICAgICAgIHJldHVybiByZXQ7DQoNCiAgICByZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQo
ZGV2LCBwY2lfaG9zdF9jb21tb25fZGVsZXRlX3BvcnRzLA0KICAgICAgICAgICAgICAgICAgICAg
ICAmYnJpZGdlLT5wb3J0cyk7DQogICAgaWYgKHJldCkNCiAgICAgICAgcmV0dXJuIHJldDsNCg0K
ICAgIHJldHVybiAwOw0KfQ0KDQpCdXQgdGhlIGVycm9yIHBhdGggbG9va3MgYSBiaXQgcmVkdW5k
YW50IHRvIG1lLCBob3cgYWJvdXQgY2hlY2sgaWYgKHJldCA9PSAwKSBiZWZvcmUNCmRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldCgpIGRpcmVjdGx5Pw0KDQppbnQgcGNpX2hvc3RfY29tbW9uX3BhcnNl
X3BvcnRzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdl
KQ0Kew0KICAgIGludCByZXQgPSAtRU5PRU5UOw0KDQogICAgZm9yX2VhY2hfYXZhaWxhYmxlX2No
aWxkX29mX25vZGVfc2NvcGVkKGRldi0+b2Zfbm9kZSwgb2ZfcG9ydCkgew0KICAgICAgICBpZiAo
IW9mX25vZGVfaXNfdHlwZShvZl9wb3J0LCAicGNpIikpDQogICAgICAgICAgICBjb250aW51ZTsN
CiAgICAgICAgcmV0ID0gcGNpX2hvc3RfY29tbW9uX3BhcnNlX3BvcnQoZGV2LCBicmlkZ2UsIG9m
X3BvcnQpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgcmV0dXJuIHJldDsNCiAgICB9
DQoNCiAgICBpZiAocmV0ID09IDApDQogICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9y
ZXNldChkZXYsIHBjaV9ob3N0X2NvbW1vbl9kZWxldGVfcG9ydHMsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAmYnJpZGdlLT5wb3J0cyk7DQoNCiAgICByZXR1cm4gcmV0Ow0KfQ0KDQpCZXN0
IFJlZ2FyZHMNClNoZXJyeQ0KDQo+IA0KPiA+ICsJZXJyID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jl
c2V0KGRldiwNCj4gcGNpX2hvc3RfY29tbW9uX2RlbGV0ZV9wb3J0cywNCj4gPiArCQkJCSAgICAg
ICAmYnJpZGdlLT5wb3J0cyk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gDQo+IHJldHVybiAwOw0KPiANCj4gLSBNYW5pDQo+
IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K61
4K6u4K+NDQo=
