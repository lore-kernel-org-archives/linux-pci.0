Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621F34E75A;
	Tue, 14 Jul 2026 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023898; cv=fail; b=si94jISQs9m/ii0nVNp6bK3ID1BhFDlAx2poYMQiSEwMcEKeZM0L8tO1RjR6ns1qtkOgykjMgG5Q2GZZcGc/ap2uTUoW74MF73kg7kUmTkxdOo5St3fKGj60/77COF81EInf6bWXMpyT62ekdKjbjjaWupawrbulD4IhNFBOF3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023898; c=relaxed/simple;
	bh=lzJtQrtXHzWUD3GaOGO5i/rai6pl+GOZqhBoyHReBzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dp+yc8sKw6E7UF89XJGJdDSkJpHTgaQ0w2vJkGCZ9I1NAres8mWxK+qvlJs1gi6S4lsRSA8Qr2H7/0SdlnuN0eZIkPwBw8UeY4MykMuZxBUkFEwKo7dv3aRIq0zR/+WgNNKGGzghYwWvHOOk0YonQYdYbCy2r7xGL57i/Kte8F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIUYhtXa; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIUYhtXa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gilo8UCA6yMOko25U7z0mddDXkc65Tz3cQsHSFKRaTABeitjUG8ROUbWdFJN0X/xz7O5RGSLSOiq65juCIWwTCjbgP3U0LUliFMadP/IoPvu5rd7WZYO6x0ZJhKEmR8489jxcOh3RQXZwo1z2XXq/nQjChFDLfG4t5CEP/pBneBqzPRmRBYFtzOvZgUyttLraowPxYmYZLv2ZQgcDWDp2s2LvItwYqRSYXXcCpvAhWMAnYboQj/q3Y20fwJ39DSxYfPy3vtOgJFypo9zbA/LuccEWphviLTTfqw7gAhy2Tm2kgKakgBXn0awk57QKKiFs0S0Ar2jiws1f+B5E+nxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzJtQrtXHzWUD3GaOGO5i/rai6pl+GOZqhBoyHReBzY=;
 b=w8v8yLF53hF8aGZ9XcNVPEhdaoNkHNWtOe5JBRvmZO3OQN1h78+5uXQ+2xJeG2alz0InZKw3fcGbcFOxU4CCksfT/aQRLyiRn5YjU/C8xWSuBwd32Ty86i6gS6p1aUQtx20YV3vWZjpCAs/NLfGMvkOIa9cpKhNFol7RuJ77YisZlq4GmSj1cWffKbw8+iuGo8FNxPp24wJUjbkOcY98xNVRpLa4Pyqi4FraOdhy1DaZr+rzxxCKR7+IIG0Oyrhdx07bnRtsPATCbVL4hmEBE60EbFokdR3S8qKVYAo+yiK5scPCK8rEdvI2ObKSojIy7VNh9fNhfyM6J9Ws1i0Y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzJtQrtXHzWUD3GaOGO5i/rai6pl+GOZqhBoyHReBzY=;
 b=XIUYhtXalWZFH1vaGjBnvGU8ajEcTmd8redksNPJvr3dXCwsx3P6zGdFND1lNhxU4qX16y14QPI53JUsNrDYDteaCfd0/gCem2/gW24+Cp5pVGMWwSFV139eSm9xyoSBqvmf1WAz5XqdXCr0dGvNPrH5xj3LE5itIYtDxbhdJmdMMcHdiDE9QBmD+n+SSYqCpgCuSGxieHiXIUXBKoaXJWbgMa04qV0vX04QZpJ+jduKSArDDDVkEfHtCdgScOy61etAUzoC4xSCr05g9jM34CM+IOvAXg8LOQgedIfXAB2rrST+ed6bZQTtFmIa/ocC/qmEavtncIwoaNCKaK/sCg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11327.eurprd04.prod.outlook.com
 (2603:10a6:150:2ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Tue, 14 Jul
 2026 10:11:31 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 10:11:31 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "brgl@kernel.org"
	<brgl@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Subject: RE: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Topic: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Index: AQHdEm/b8LfnBcjhvUCaiAiI6/01h7Zq4yGAgAHmK3A=
Date: Tue, 14 Jul 2026 10:11:30 +0000
Message-ID:
 <VI0PR04MB121142317154797575D4CA90B92F92@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-4-sherry.sun@oss.nxp.com>
 <mow4vuf6zf6c7uzb7zbvwuw3b5p5q5rfghw266f2eiesvhssle@7jzavek52rt7>
In-Reply-To: <mow4vuf6zf6c7uzb7zbvwuw3b5p5q5rfghw266f2eiesvhssle@7jzavek52rt7>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV2PR04MB11327:EE_
x-ms-office365-filtering-correlation-id: 8f0cfa91-89de-4c0d-5425-08dee19046a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|23010399003|7416014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 87zmkH+sFzHs8qw2rX2bBkIyUT7TjENFBNWnhO/l5BZJjs8RGArc7edhoqpfm5DMSZ0zqyiwnprRbj30PoTNDMpmDnT2WYyFmlJ/6fsSZN/aIv33C1Mc1RS3XtjCI3A5uHJTBpabsOq60NbOeLjUlDVM4rMObXaXTs9onLGlvvJ3j2OFIGBNcPDhG2Lcv4L82pPk+VM2GmGNtvpEdFYLWa7UU5Tyieu+BgeNKga3OllMX5/hRWi+yG44YwmDU4YBO/2xCqV4fY8C+tUH8FA3H3BZc5pvfEa+Yp9PV04ZnDTq4Ko0PhBR55jaVcPwhuUh3w+93WKUl7wSekVl7dyHZ6M2oh+lcTK7cHA5XU9F2URhefAJvnv4wrRNn+RSAt6IJ49avKAPJEbvMRwxCgI53NZEL50UF60/Sqbo8i/8pGbQdUBCWUjZJXQ7I+rL3Dq0QdvdfJjVf0jW80ObNaPvcjrnBAbvAtq3njV9sEWn5nZfl8LQkV5iy/BOi8aX0avAbpVgUqs0QxSbL7I07DqCrXAbO83kj6P9TsXqx5EsybTTFRsqj06H62xERlKJL4xwHQgx+opvf9hgAxux6eH5YlgCV7jxA4K85dYLbpSwcGiMmSdvl4WbVubjMQfMDYTsi75DXMcVyqxiBVdNpWiXVaLWkydhE1JVh1Rg0WVkvZ71xTSKp24YOyF4Du21EldM0k8U3+UeOw18S9Q5gktSDmBaDkCLJ83qzbG9a013efs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(7416014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkloQmxnenVBNHo4TGV2Vis2U0dQYWdHK1B2dEdGdmpjRGpNc3NuK3ViaXBC?=
 =?utf-8?B?MVc1TU5xR094cDVOaW5vZXgxR2dBYmtDVjNEKzNNRVhMdjQxUEpyL0w2d3cz?=
 =?utf-8?B?ZUUzRHpaUW50d01MZnQzTW9kVGVuWEpuSWlxSDJwTkt1Z29DQjJwSUZiNHNm?=
 =?utf-8?B?VGFlS3VPYTlnZkRKUHMzajJDZDlmNmdkY1dGM2o4dzU5dWVTd3dEZE8vMzcr?=
 =?utf-8?B?T05kRDBLQjlKMlJXUXpBV0NZb2ZOQjhCamVtT08vVHFLNDJwQ3dpeVE1SHJN?=
 =?utf-8?B?OEQzOVJyaXlqdVVFeGtoYnFBYWVqMFJWRlgvSDh6SytEcnJhejI5aUN1WHdo?=
 =?utf-8?B?bTBuaHRTOGc3ODgxVWliQUZYaFQ4WXNKaXZORnFka1FVZ3dPQ1hjTEovWTN6?=
 =?utf-8?B?a0JPSE42S0NTNldvdHRRZ05SR01lWDMxbGJNSzdxT2h6UnhOK2UyNm9hSDBv?=
 =?utf-8?B?dlhlcy92NHBldXJSQmplVDlnS0k3S1grcUdkaCtRZTNaWGVQd3ZKZjVvVC95?=
 =?utf-8?B?R3oxaFJEN0wrSG9OUDJVcmY0SCtQZVJobkx3SEZDY2czM2V3YkJuNUlzOHJG?=
 =?utf-8?B?bk1VcjM4MmJTQjRRRTlTQ2dCem5IOStueUt5OStRWU41WVB4Y2VHV05QVmdH?=
 =?utf-8?B?MmwvVWdnRzBkSWdNYkJtMnhHaE8xcWFQVGVLdjNOZlgwb3ZjRzRTeGVTVzBz?=
 =?utf-8?B?K1FjOUJRbjBqdE5YcW1oa0srOEJNVEhKOEtFWEh4OUNVQUExQTJUNWlvc29j?=
 =?utf-8?B?NjRVbmVndmFUTjZMOEJYaWVJcE5YbGZicW5nNUROc2ZMVkhhYmZEc1JqRUl0?=
 =?utf-8?B?OW9TWnB1eDB3RXhYVGlLSVZsR25yRGNGR2lEU2UwK0Zna0Fab1BzMDdiRGZ2?=
 =?utf-8?B?VFMyQlhFMEIrVkxvQ3lEVGhaS2JZNXNQbDkzY3dpTDhPeUI1UFRzdFdIbDVm?=
 =?utf-8?B?SzlqWVFIclloSEdDSkN2bTJPTzVRcXdQWUFzTzVFcVh6dXIrYzQwSnEvOE9t?=
 =?utf-8?B?cDNBMUEyVk96Q0ttRW1BNzB6bzdiaXdXQlo1bXJuc2J3NUwwQWVjWjhFbWQw?=
 =?utf-8?B?Y3lqM2t0MkFzZzV3NEtLZUpzaFBoVDJBbitpU25SNGJEdHNuL2J6R2ZCZTZy?=
 =?utf-8?B?c092c0diQ3lPNzVHN2tJOGVWTVUrb3RMMnlIZUNvRWduVGdrMHMrRVpNbDFV?=
 =?utf-8?B?L1hNZDJ3MkJMbUFEczZpMUZ2T280ZjZ1UytvWk5CMUg4T1Zma0hRWWV1NFJ0?=
 =?utf-8?B?TE0wVHBNdEZMdldQRHYxNWRCc2FmbnpzUXpZa0NITEVyTlhTU0t5dXYzMWVW?=
 =?utf-8?B?SEhJemxGd1FRZlh5TytzeWlyUkE0a3R1QXUyQ2FiYXgvRXFxbkpWM0xmTDBX?=
 =?utf-8?B?MU9LeTNRY05wZk5ITVRqcW1kTjNtRFpVOHQ5Tmt6dUZjK2RzUWxiUy9rMlZW?=
 =?utf-8?B?QmlyK01TQWFBTnlBK0s1dXMvMVRvRFArU1pWcTAxazl5eXA3OWtZdWhTRHpZ?=
 =?utf-8?B?N296Y3pqdXlXYjdJNkZpK1FpYklGeFEydlprQ05LTE42RERpTTVSekhRbXhK?=
 =?utf-8?B?MzRqNVFqbUpWeEhidzU2THMxS2p2ZDAyMEkzdjF3dDIxNzVUQTJEdWo1VnMr?=
 =?utf-8?B?WnE4NHpTTnFMTm5jbldBbFhPaWwvb05XWVAra0xvakxublowZkkrNHZkV0gy?=
 =?utf-8?B?RXgvU2lQQXZSUmxBc0ZRSzFSUm12cytPZFVlWVJaa0ZXc1FNTkFKYm50ayt2?=
 =?utf-8?B?dGh5aWphdllwYUc1UlNScVEza2VjUU1qc05OR3dmODNCb3BxaEJlWC9xM2hi?=
 =?utf-8?B?VUx2c1dqZ1R2bHkwbC9PU1J5WHJkb2xiS056OVFtUjBVeVdhSlVjZytUa1Ez?=
 =?utf-8?B?Q0R0NFlCVFV1czFLTFFMRDRrSmlQbDhjYkdZcTlTeWRDbWpFQ0dGSlJwTDEv?=
 =?utf-8?B?bXplaTRicFFMUW4zNHR6b0RQTURQMGY5VUpmY01kYms1TVREenU1MXFOank3?=
 =?utf-8?B?VDhmT2RlVk1pMjhVd29tTHFaYnRGQlpudXJUcTV6RFZYUlFYRjJPTjNEdk5S?=
 =?utf-8?B?Z0Z5N0pQd2xMQmZGVTRTaXptTzJjQnd6Tm5OMVJtRFlBQUc0ZldOeWk5cmhM?=
 =?utf-8?B?N0xiRjVRU2VSbHQ5UWFwT3NsR2xnNXdIUFRMNjYwdWkyQ3lMYjFhZVNoZkFG?=
 =?utf-8?B?cCszRFlPblJEbVlBaUdqUnY2cVhEOGtFSyt1NHdQaFZGK3crd25lZ3N2VHZ5?=
 =?utf-8?B?SzQzNTN3dStWS3pucmtxb3lVbG5NTGtHVVpaMmwvaTFRenJZWHRmOUN1a3Nq?=
 =?utf-8?Q?V5m+njyaobya5nx+U6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0cfa91-89de-4c0d-5425-08dee19046a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 10:11:31.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZmNCF+9gAT34+SA2XgNCixVj/bQ3vEEomPjf/8tNTiuLcmzsf5GbSKtXF8QtFdV2M6iJ7m/q4VO4lCYeivR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11327

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDMvNF0gQmx1ZXRvb3RoOiBidG54cHVhcnQ6IEFkZCBN
LjIgQmx1ZXRvb3RoIGRldmljZQ0KPiBzdXBwb3J0IHVzaW5nIHB3cnNlcQ0KPiANCj4gT24gTW9u
LCBKdWwgMTMsIDIwMjYgYXQgMTA6MzQ6MzRBTSArMDgwMCwgU2hlcnJ5IFN1biAoT1NTKSB3cm90
ZToNCj4gPiBGcm9tOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4NCj4gPiBQ
b3dlciBzdXBwbHkgdG8gdGhlIE0uMiBCbHVldG9vdGggZGV2aWNlIGF0dGFjaGVkIHRvIHRoZSBo
b3N0IHVzaW5nDQo+ID4gTS4yIGNvbm5lY3RvciBpcyBjb250cm9sbGVkIHVzaW5nIHRoZSAndWFy
dCcgcHdyc2VxIGRldmljZS4gU28gYWRkDQo+ID4gc3VwcG9ydCBmb3IgZ2V0dGluZyB0aGUgcHdy
c2VxIGRldmljZSBpZiB0aGUgT0YgZ3JhcGggbGluayBpcyBwcmVzZW50Lg0KPiA+DQo+ID4gT25j
ZSBvYnRhaW5lZCwgcHdyc2VxX3Bvd2VyX29uKCkgaXMgY2FsbGVkIHRvIHBvd2VyIHVwIHRoZSBN
LjINCj4gPiBCbHVldG9vdGggY2FyZC4gVGhlIHBvd2VyIHNlcXVlbmNlciBkZXNjcmlwdG9yIGlz
IG9idGFpbmVkIHZpYQ0KPiA+IHB3cnNlcV9nZXQoKSB3aXRoIHRoZSBVQVJUIGNvbnRyb2xsZXIg
ZGV2aWNlIChzZXJkZXYtPmN0cmwtPmRldiksDQo+ID4gc2luY2UgdGhlIE9GIGdyYXBoIGxpbmsg
aXMgZGVmaW5lZCBvbiB0aGUgVUFSVCBjb250cm9sbGVyIG5vZGUuDQo+ID4NCj4gPiBBbHNvIGFk
ZCB0aGUgZXhwbGljaXQgcHdyc2VxX3B1dCgpIGNhbGwgaW4gYWxsIGV4aXQgcGF0aHMsDQo+ID4g
cHdyc2VxX3B1dCgpIGFscmVhZHkgY2FsbHMgcHdyc2VxX3Bvd2VyX29mZigpIGludGVybmFsbHks
IHNvIG5vDQo+ID4gc2VwYXJhdGUNCj4gPiBwd3JzZXFfcG93ZXJfb2ZmKCkgY2FsbCBpcyBuZWVk
ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5j
b20+DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5l
bC5vcmc+DQo+ID4gDQoNCkhpIEx1aXosIHRoZSBCbHVldG9vdGggcGF0Y2ggaW4gdGhpcyBwYXRj
aCBzZXQgaGFzIG5vIGRlcGVuZGVuY2llcyBvbiB0aGUNCnJlc3QuIFRoaXMgcGF0Y2ggc2V0IGlz
IGJhc2VkIG9uIGxpbnV4LW5leHQsIGJ1dCB0aGlzIEJsdWV0b290aCBwYXRjaCBjYW4gYWxzbw0K
YmUgYXBwbGllZCB0byBibHVldG9vdGgtbmV4dC4NClNob3VsZCBJIHNlbmQgaXQgc2VwYXJhdGVs
eSwgb3Igd291bGQgeW91IGp1c3QgcGljayB0aGlzIEJsdWV0b290aCBwYXRjaCBpbiB0aGUNCnBh
dGNoIHNldCBkaXJlY3RseSBhZnRlciB5b3VyIHJldmlldz8gVGhhbmtzIQ0KDQpCZXN0IFJlZ2Fy
ZHMNClNoZXJyeQ0KDQo+ID4gUmV2aWV3ZWQtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kNCj4gPiA8
YmFydG9zei5nb2xhc3pld3NraUBvc3MucXVhbGNvbW0uY29tPg0KPiA+IFJldmlld2VkLWJ5OiBG
cmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBIaSBGcmFuayBhbmQgQmFy
dG9zeiwgdGhpcyBWNiBwYXRjaCB1c2luZyBwd3JzZXFfcHV0KCkgaW4gYWxsIGV4aXQNCj4gPiBw
YXRocyB0byBmaXggdGhlIHBvd2VyIHNlcXVlbmNlciByZWZlcmVuY2UgbGVhayBpc3N1ZSBkdXJp
bmcgQlQgZHJpdmVyDQo+ID4gdW5sb2FkIGFuZCByZWxvYWQgYXMgcmVwb3J0ZWQgYnkgc2FzaGlr
by4gSSdtIGtlZXBpbmcgeW91ciBSZXZpZXdlZC1ieQ0KPiA+IHRhZy4gSSBjYW4gcmVtb3ZlIGl0
IGlmIHlvdSB0aGluayBpdCdzIGluYXBwcm9wcmlhdGUuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0bnhwdWFydC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0K
PiA+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgaW5kZXggMGJiMzAwZWVmMTU3Li44
MWExMWFjMDUxMTQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54
cHVhcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gQEAg
LTksNiArOSw4IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NlcmRldi5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBoLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9wd3JzZXEvY29uc3VtZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L3NrYnVmZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvdW5hbGlnbmVkLmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0KPiA+IEBAIC0yMTEsNiArMjEzLDcgQEAgc3RydWN0
IGJ0bnhwdWFydF9kZXYgew0KPiA+DQo+ID4gIAlzdHJ1Y3QgcHNfZGF0YSBwc2RhdGE7DQo+ID4g
IAlzdHJ1Y3QgYnRueHB1YXJ0X2RhdGEgKm54cF9kYXRhOw0KPiA+ICsJc3RydWN0IHB3cnNlcV9k
ZXNjICpwd3JzZXE7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcGRuOw0KPiA+ICAJc3Ry
dWN0IGhjaV91YXJ0IGh1Ow0KPiA+ICB9Ow0KPiA+IEBAIC0xODcyLDExICsxODc1LDI2IEBAIHN0
YXRpYyBpbnQgbnhwX3NlcmRldl9wcm9iZShzdHJ1Y3QNCj4gc2VyZGV2X2RldmljZSAqc2VyZGV2
KQ0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlmIChvZl9ncmFwaF9p
c19wcmVzZW50KGRldl9vZl9ub2RlKCZzZXJkZXYtPmN0cmwtPmRldikpKSB7DQo+ID4gKwkJc3Ry
dWN0IHB3cnNlcV9kZXNjICpwd3JzZXE7DQo+ID4gKw0KPiA+ICsJCXB3cnNlcSA9IHB3cnNlcV9n
ZXQoJnNlcmRldi0+Y3RybC0+ZGV2LCAidWFydCIpOw0KPiA+ICsJCWlmIChJU19FUlIocHdyc2Vx
KSkNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnNlcmRldi0+ZGV2LA0KPiBQVFJfRVJS
KHB3cnNlcSksDQo+ID4gKwkJCQkJICAgICAiZmFpbGVkIHRvIGdldCBwd3JzZXFcbiIpOw0KPiA+
ICsNCj4gPiArCQlueHBkZXYtPnB3cnNlcSA9IHB3cnNlcTsNCj4gPiArCQllcnIgPSBwd3JzZXFf
cG93ZXJfb24ocHdyc2VxKTsNCj4gPiArCQlpZiAoZXJyKQ0KPiA+ICsJCQlnb3RvIGVycl9wd3Jz
ZXFfcHV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCS8qIEluaXRpYWxpemUgYW5kIHJlZ2lzdGVy
IEhDSSBkZXZpY2UgKi8NCj4gPiAgCWhkZXYgPSBoY2lfYWxsb2NfZGV2KCk7DQo+ID4gIAlpZiAo
IWhkZXYpIHsNCj4gPiAgCQlkZXZfZXJyKCZzZXJkZXYtPmRldiwgIkNhbid0IGFsbG9jYXRlIEhD
SSBkZXZpY2VcbiIpOw0KPiA+IC0JCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJCWVyciA9IC1FTk9N
RU07DQo+ID4gKwkJZ290byBlcnJfcHdyc2VxX3B1dDsNCj4gPiAgCX0NCj4gPg0KPiA+ICAJcmVz
ZXRfY29udHJvbF9kZWFzc2VydChueHBkZXYtPnBkbik7DQo+ID4gQEAgLTE5MDcsMTMgKzE5MjUs
MTYgQEAgc3RhdGljIGludCBueHBfc2VyZGV2X3Byb2JlKHN0cnVjdA0KPiBzZXJkZXZfZGV2aWNl
ICpzZXJkZXYpDQo+ID4gIAlpZiAoYmFjbXAoJmJhLCBCREFERFJfQU5ZKSkNCj4gPiAgCQloY2lf
c2V0X3F1aXJrKGhkZXYsIEhDSV9RVUlSS19VU0VfQkRBRERSX1BST1BFUlRZKTsNCj4gPg0KPiA+
IC0JaWYgKGhjaV9yZWdpc3Rlcl9kZXYoaGRldikgPCAwKSB7DQo+ID4gKwllcnIgPSBoY2lfcmVn
aXN0ZXJfZGV2KGhkZXYpOw0KPiA+ICsJaWYgKGVyciA8IDApIHsNCj4gPiAgCQlkZXZfZXJyKCZz
ZXJkZXYtPmRldiwgIkNhbid0IHJlZ2lzdGVyIEhDSSBkZXZpY2VcbiIpOw0KPiA+ICAJCWdvdG8g
cHJvYmVfZmFpbDsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JaWYgKHBzX3NldHVwKGhkZXYpKQ0KPiA+
ICsJaWYgKHBzX3NldHVwKGhkZXYpKSB7DQo+ID4gKwkJZXJyID0gLUVOT0RFVjsNCj4gPiAgCQln
b3RvIHByb2JlX2ZhaWxfdW5yZWdpc3RlcjsNCj4gPiArCX0NCj4gPg0KPiA+ICAJaGNpX2RldmNk
X3JlZ2lzdGVyKGhkZXYsIG54cF9jb3JlZHVtcCwgbnhwX2NvcmVkdW1wX2hkciwNCj4gPiAgCQkJ
ICAgbnhwX2NvcmVkdW1wX25vdGlmeSk7DQo+ID4gQEAgLTE5MjUsNyArMTk0NiwxMCBAQCBzdGF0
aWMgaW50IG54cF9zZXJkZXZfcHJvYmUoc3RydWN0DQo+ID4gc2VyZGV2X2RldmljZSAqc2VyZGV2
KQ0KPiA+ICBwcm9iZV9mYWlsOg0KPiA+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQobnhwZGV2LT5w
ZG4pOw0KPiA+ICAJaGNpX2ZyZWVfZGV2KGhkZXYpOw0KPiA+IC0JcmV0dXJuIC1FTk9ERVY7DQo+
ID4gK2Vycl9wd3JzZXFfcHV0Og0KPiA+ICsJaWYgKG54cGRldi0+cHdyc2VxKQ0KPiA+ICsJCXB3
cnNlcV9wdXQobnhwZGV2LT5wd3JzZXEpOw0KPiA+ICsJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+
DQo+ID4gIHN0YXRpYyB2b2lkIG54cF9zZXJkZXZfcmVtb3ZlKHN0cnVjdCBzZXJkZXZfZGV2aWNl
ICpzZXJkZXYpIEBADQo+ID4gLTE5NTIsNiArMTk3Niw4IEBAIHN0YXRpYyB2b2lkIG54cF9zZXJk
ZXZfcmVtb3ZlKHN0cnVjdCBzZXJkZXZfZGV2aWNlDQo+ICpzZXJkZXYpDQo+ID4gIAlwc19jbGVh
bnVwKG54cGRldik7DQo+ID4gIAloY2lfdW5yZWdpc3Rlcl9kZXYoaGRldik7DQo+ID4gIAlyZXNl
dF9jb250cm9sX2Fzc2VydChueHBkZXYtPnBkbik7DQo+ID4gKwlpZiAobnhwZGV2LT5wd3JzZXEp
DQo+ID4gKwkJcHdyc2VxX3B1dChueHBkZXYtPnB3cnNlcSk7DQo+ID4gIAloY2lfZnJlZV9kZXYo
aGRldik7DQo+ID4gIH0NCj4gPg0KPiA+IC0tDQo+ID4gMi41MC4xDQo+ID4NCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
