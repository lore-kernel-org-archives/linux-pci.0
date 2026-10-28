Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793225139;
	b=sXhrHfmeDj6JKet+W6MEhodg+uVnwrytY/XkSnOnTF1JiTdtw+fz6Ea60o/IADMQhlp3
	 kYO7zeh+2BVx/QQNUxfbVw+jL1IHSarCGJDLEFrv4xdyZyfDhZL3FoIT0tsWq7knj3ShG
	 Mt8wnsTBqc4e5GcoSxO9P/0ETVUwzGASzbOse6j9lSARnqVXdcr0EvcMxrJgh/nt3rZP0
	 hAGXZIcp/WfL2apR+wtIHL2yHh029tl0bLm0VDEUyC4SYWGapUs3bHgmO0Rv9NsYTlkZk
	 DzDO/LogaIFMbCyygBhYAsqwZvg3C6YiQ83fP28W1vObZfgPvd5uy9Om8oNKpzB7aZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225139;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TerczV2OfPmSSyQcYr0YCw7W6tlATuvXwCd60FgD+4E=;
	b=SYFaR2mRtsk5Y05kI9omRznfVPsoatGknOdux5Z1vaif1FguBJQYJgmFgHfevfqzkfPI
	 QQx9q7k1qYk8B/hDWm1P2SS2usLqRx+qUTNBjcM9Wd0FZVnWflrROuLOPGLxlpc3gD+Bs
	 BBae+vAPgXs9IMcSBGX/ROLnh0Xm5E6DNUg5ZIwqoXsKeYQjH1ZAVfAcvjAPPENiMMrq1
	 Beqtoa6dMRhfJ61qE7j7oZ0vX+5/SjNqYXu2czOwrxZdEoRUqEpPPz6mmn2ElfpOxm4CH
	 DjabfGnBne8L0Qxgm7kuaOWWl13iYN/PdcnMkelpKwDstLAJ5TprXavATONkgjmVK8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="oGz7B/r8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.40
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010040.outbound.protection.outlook.com [52.101.228.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C66606A31A;
	Wed, 28 Oct 2026 22:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=oGz7B/r8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/D+rlIjAkSEQmnfsEdUQ29nEEQOQsy8yY2e0rRrxRBGUQ5UNmP6aS9XCREaA4hhxeVxuY8QIQ5x4ozVs22XZAUFz633plfih7D1PB2fUp88rtTHLrtSiPf5oWyp8ow1ax6kXuieFML2sVi0gHXDHV/uHUi6wRviT1EjMZnVAK1cJjqKiJe5R90cyiasN/BWbhPK9INdyhcvT3d3TwO601Eb0vyg0sL7NGe/Ikhnv5OZjpOrEeA4+t6dCiFLeTZecLMvCUD/ey+maGi5FSJAGWvozlppqlfBD6a9tkxJWyvJ4sPSVHZX7OiH5tOBf2tY+qH8qD4FJnnCK+QYHSzSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TerczV2OfPmSSyQcYr0YCw7W6tlATuvXwCd60FgD+4E=;
 b=VO6vcAXHNJ5v8ZFIuCMvARHrk376uwEgMdR3KdVvlE4a++iUo7PEb/F8nX+MHGZaiPeW32GMKKIzuuqcE9Z66akevNH/hgQw6rc4D091SRn1m1R5u92Zlpf9v7O67MzNecX9gevjABvT3kbA6eD9rUpy6OxC+jP5b2HP4ey/bZlY8h3fh6JV/ThF0CDvgxisf7SzmNvrl7goU6nxZ48GL79p5tT1X8krHtec9YcfLidsQ2xOB9b/yyEsQWTMRmslIrhMTCIerYqq0K1/sA57Z+DUTW0hNU1+Mng/UOsauswW0tcUfOLxKyp5wgHZ0TcfeFopNvkOQH3ZwWidmLn3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TerczV2OfPmSSyQcYr0YCw7W6tlATuvXwCd60FgD+4E=;
 b=oGz7B/r800ccXzOq9mwnXnPeM/fia/Qj5dgNgOuYzLrYEoe0cj9xG9VGAm7sEqS0KmDZJf/YwofjNRqpYgjYt6xM7dh+AFa7zOp2/esO5pbOMNb3m9YFVmK9S94Vk9+Vl7EcxlBt94tfMvcBpvyU6OoA5JYsxuDNJLVP/IAG7Gc=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TYRPR01MB16229.jpnprd01.prod.outlook.com (2603:1096:405:2e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 22:05:34 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 22:05:32 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
Thread-Topic: [PATCH] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
Thread-Index: AQHdVLkK6u3U9T6uNEGkg6n6nYooc7cRgdKAgAIj1CA=
Date: Wed, 28 Oct 2026 22:05:32 +0000
Message-ID:
 <OSCPR01MB127691959282E653259A2CC7CD36F2@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
 <179310709974.16692.1197178939539578162.b4-reply@b4>
In-Reply-To: <179310709974.16692.1197178939539578162.b4-reply@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TYRPR01MB16229:EE_
x-ms-office365-filtering-correlation-id: 87129723-a1f1-49ec-7edf-08df353f95ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261028144727099003|6133799003|18002099003|22082099003|5023799004|56012099006|4143699003|11063799006|10067099003|261026121527099003|261022075727099003|261021121427099003|261009223027099003|261009221227099003|261026140227099003|38070700021|261022105027099003;
x-microsoft-antispam-message-info:
 Wqd6/vTL5DXDt1G5V+D0gQghg0pEVqEUmk4uLz/is3WEMF5po/gvxPOuEHB4V/sTMrPE2NGogZ/6D3s+KaXS9CkmjL5to5ABuvF9hRxXKkqSIb4h84SvcAf9FU5hW1sKDCwBw2rhzD5ZMmREokwkB52Uu9RZNdUqY/kvYAIYD55zgi16aMsNco1CAeezwzHrJnSxwBjnY8rPWO6o+odfvZtjHv6Uat5QJOhPM28SXcqMFN5tFyhIn/4Ir5RYjQDyQKJcdPFp7X/VHcO50ipe1ef+h28kQ7eU4p+/G1IE+F0bJIiS578yW0GAtYZcoQvOhW/x/VOpfMcLRj1C+AJG+eqNF47WHLbfdaAcTDdsagazYgBz9nzw6+Vh3paEBKGkAVa0Fdawaoa2Rgpz4fgXwT27D60IvT9vW+pU0qMvcfI6zWgmt4tXog2ojk4EzpKQTs0tNVF0fH6Uv93VEPCVUGrqUudjJPzspTNVedjzWtezrBkdjWz8X9f1f4/e65ybKbvdyI45LZOurpfBhIgyy9c8Tn4kbM1KfBMUjTyAIdMpVP6qApD6aYhwQuSbqqRQiEsHtIols3pnP/APQP5cjDvovTRA1yd8pW3bwZOL/amse5wqouSunfENVLSC36v2RmQ8c9XPKQGirzZ8NF1zSJUzhY21wTd5oT6gmc9G954=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261028144727099003)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(261026121527099003)(261022075727099003)(261021121427099003)(261009223027099003)(261009221227099003)(261026140227099003)(38070700021)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTV4SlJtU3B5SDJEV255b3QwQ3o0NE5CTUFlb2E4RFVCaUJoYjlGazhUTzdK?=
 =?utf-8?B?NERRMnIrTkMyMGFWU1pGUDM1VEdUdys3YXMrcGl6eGtGNmMwY2REbHJUNWpp?=
 =?utf-8?B?cHpJbzV0bGp1L1dsUjBmdGhkVHQzeGozQUFEYmR3dExTaW1WajZZaVhsOUVv?=
 =?utf-8?B?Z2x4Q2U5Y2FqYlJ4QVFXL3BjdHhISEpKT0VLOFd6bDNDa2w0czZGNCtaMEJB?=
 =?utf-8?B?ekEreGxZanRNTHV2Z1RTQ3lQZjNwelcxbmV2eUFnaXlXRE5URzVMRi9qWlZw?=
 =?utf-8?B?anRUa0VGS1QvZEh6ZElQRlc0R0RFN01SR25kWEJ5ajNsckZDZ2h2MXIyQ0FQ?=
 =?utf-8?B?U1NQcU1jWGVLZkMwMFBpU0o2dDJnRjdrMWhxeGpkTmc0bU5ZeTQ2V0RTRVpX?=
 =?utf-8?B?Z2QwUHRiL1FGK0VxTW43ZHlLSVZtWDdJaGZNTXRkeUc2RTNaRGQ5bDdSa014?=
 =?utf-8?B?YjVVeTVTZFVtMjdabEhKcGw3c3N3MlhQSkkrZk8yVGZ4QTUyQlBKbkNyUk1S?=
 =?utf-8?B?eGpRZVhKUEhTYThqd1V4cENsWVY2S1VyVzVISDI3UzhpWlBrcFhwYzNodlYz?=
 =?utf-8?B?d3NxdFQrN0dmbjZoTTBrdDh1ZDVvR1lhbm54dWltK0tHQVBRZnBpMUYzSGI0?=
 =?utf-8?B?b2hLdm9KVmlWSVFoU0sxVUFpZTBKWTA3SXJwTjljemcwUlFEK1lQc1lOSmY1?=
 =?utf-8?B?Rlp1VUgvb1JEaTFvbzA1cnlzUm0zZDlxZXp0NzJmcUxnOE5BL2crbnpNM0Qy?=
 =?utf-8?B?azUyanNvSDNtRlh6M0FUTG1OWTkzcml2dVBtUk5WMHhUNExnZUdpZ09sTTJ0?=
 =?utf-8?B?VURUTW5LMnFETDZLQk9JV3cwL21KaWNDc0VBOU01UEcxeHVqQ0V1UWREY1k5?=
 =?utf-8?B?TFVHR24xeGRXR3dzQi9wQnU2Wm9PSk5valIwTTB4NFAvSzBMMUoxYzFVampI?=
 =?utf-8?B?dEtFRFI0NHNKQVRidkhxRTU4aXduNURsT3dtN1NCdjRicFlNdkxzWk1Hd3ZD?=
 =?utf-8?B?TXFFNDd4VEdBdzhjQkt0WHdIbG9FTTR6ZFRBaStXVm1tUzcyWDhZNGlVZlB1?=
 =?utf-8?B?SWtuU0lkbkhFY1cvTjdWYWlxTXRLT0d2UTZMMTRENW9uWm1lazdlZS9PN3FD?=
 =?utf-8?B?WTU3Z1lrWmNtUTRRUUZNTFFhMlJtaHY4OVM0WGFKUCszL2J6WjY2QkxvWGJ5?=
 =?utf-8?B?WlRqaW5WS2toemxOZTRkVHVNYW1mTjFRaUVoSTBWYitwM1NiRGNnNXRyOVR6?=
 =?utf-8?B?S1UyWm8wN1YwcmVkTS9pVXdlandneVJMV3JnVmY1SVVMdm14WlYzbTMySlFv?=
 =?utf-8?B?VXF5Yk5iOVkrZkIraG5NdzJJdzRoWjZHS3oxamdSWTlpTEhmZ2dLNHJKMkdG?=
 =?utf-8?B?UkxwYURPUkNtaVVBVlVmN2l5ZmxaQWtqRTI1Y1NORkhLaW5FSlhPWlNMcWJm?=
 =?utf-8?B?ZmpPVUNCeWZ4dG1VQzNUZkJqRHRIVjFEaW11bWdXUnJKK3R6bzZ6NTRGNSts?=
 =?utf-8?B?d2lwRzg0bmk4NEFPQnlXRW1RYXNUUUxSdmdwZzZhc29LazhnVGx5Szh1ajNM?=
 =?utf-8?B?R3ZDMjg5MWE1MVVkZWI2T3NXckl6N1A0WGNmd0R4T0srSnRiMTRxbEZjSjdk?=
 =?utf-8?B?WmJIRG5BamFTZHozOTdUekh5RDluVzVuMHorSlZxSDVCRDZ1V0hNbUJPc0lC?=
 =?utf-8?B?WXhROFZLUWQ0MDFoRzJDWFNCL2hsMjl2dStRZlZUSk5nVVpJbk9Yb2hjTk9M?=
 =?utf-8?B?dFlPWGhDSTgyOVo3UDhmUEp2VlREVWVWdEh2ejNEK2JHbHNXWkE4aHR6blM0?=
 =?utf-8?B?QkxtamZEOW1RaGhPaUg3cjNnVjZKZHZkc0VRZEh3SnVUemIreWg0UGw4QWVI?=
 =?utf-8?B?ekRIRWNuZjVEZmlXd3hWQzVnM21tMDhqT21xTURldGJYZlFtcEEwVzFpemVX?=
 =?utf-8?B?cTVUZzFkNjJNQmwvTzlkWXFhdXpPTWlSczBNNEFzdXM4VFlsZ2dmSGRPOWhN?=
 =?utf-8?B?L0ovNjZmTWQyYXFvSGpoMGFoaWRmMlNDVkhJUnhldG85N0ZWaW1CbHBDaVI4?=
 =?utf-8?B?VjhPU2l0UHhCR0ZyRlFteHRDQjRKa2xnUnhYdHNaRWM3Q3RkbDRYN0E3bGZw?=
 =?utf-8?B?UW9pYm4ycjg3S3A3dHoxQlR3ODhEZEx4TTJCaVIxNjltbFRXcHJuNEdnVlJ2?=
 =?utf-8?B?S3J0RzAyM3V1SWZ6UFVOR3AydDdML0tvWmFmT25sdlBPN2Z6czBkcXpuUzEz?=
 =?utf-8?B?WENnWkgrOTV3YjJWNVZDdFlhZ0xhSjMrdmp4U0ZNTFBRMzQ5WGtibk41MzJC?=
 =?utf-8?B?NFRZZTFGb2FBdFEwT2F2UGtYN3Z5aG9nMy8wSkFQK29TaC9WbXVpTE92YUwz?=
 =?utf-8?Q?DBUu1uw+KGsPqN6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12769.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87129723-a1f1-49ec-7edf-08df353f95ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 22:05:32.5552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlIrhv2n+WImwjiojX4a67O5R9wd/s9gllNJNFODEeXdAmk2pYFGcu+ZgWaz/iNPU0Mizdtov2wioTfpyEpy2kjbxovKVjF2fVfpv7hnuu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16229

SGkgTWFuaXZhbm5hbiwNCg0KPiANCj4gT24gMjAyNi0xMC0wNSAxMTowMiArMDAwMCwgT3ZpZGl1
IFBhbmFpdCB3cm90ZToNCj4gPiBPbiB0aGUgUmVuZXNhcyBSWi9WMkggcGxhdGZvcm0sIHdoZW4g
QVNQTSBpcyBlbmFibGVkLCByZXN1bWluZyBmcm9tDQo+IHMyaWRsZQ0KPiA+IHdpdGggYW4gTlZN
ZSBTU0QgY29ubmVjdGVkIGZhaWxzIHdpdGg6DQo+ID4NCj4gPiAgIG52bWUgbnZtZTA6IEkvTyB0
YWcgMjcgKDAwMWIpIG9wY29kZSAweDkgKEFkbWluIENtZCkgUUlEIDAgdGltZW91dCwNCj4gcmVz
ZXQgY29udHJvbGxlcg0KPiA+ICAgbnZtZSBudm1lMDogRGlzYWJsaW5nIGRldmljZSBhZnRlciBy
ZXNldCBmYWlsdXJlOiAtMTkNCj4gPg0KPiA+IFRoaXMgaGFwcGVucyBiZWNhdXNlIGR1cmluZyBz
MmlkbGUsIHdoZW4gQVNQTSBpcyBlbmFibGVkLCBudm1lX3N1c3BlbmQoKQ0KPiA+IGRvZXMgbm90
IHNodXQgdGhlIGRyaXZlIGRvd24uIEl0IGxlYXZlcyBpdCBpbiBEMCwgcHV0cyBpdCBpbiBpdHMg
bG93ZXN0DQo+ID4gTlZNZSBwb3dlciBzdGF0ZSwgc28gdGhhdCByZXN1bWUgb25seSBoYXMgdG8g
cmVzdG9yZSB0aGUgcHJldmlvdXMgcG93ZXINCj4gPiBzdGF0ZSBpbnN0ZWFkIG9mIGEgZnVsbCBy
ZWluaXRpYWxpemF0aW9uLiBUaGlzIGFzc3VtZXMgdGhlIGRyaXZlIGtlZXBzDQo+ID4gaXRzIGNv
bnRleHQgb3ZlciB0aGUgc3VzcGVuZC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHJ6ZzNzX3BjaWVfc3Vz
cGVuZF9ub2lycSgpIGRvZXNuJ3QgdGFrZSB0aGlzIGludG8gYWNjb3VudCBhbmQNCj4gPiBpdCBh
bHdheXMgcG93ZXJzIGRvd24gdGhlIGNvbnRyb2xsZXIgYW5kIGFzc2VydHMgdGhlIGNvbnRyb2xs
ZXIgcmVzZXRzLA0KPiA+IGluY2x1ZGluZyBQRVJTVCMuIFRoYXQgcmVzZXRzIHRoZSBkcml2ZSwg
YW5kIHRoZSBjb21tYW5kIHRoZSBOVk1lIGRyaXZlcg0KPiA+IHNlbmRzIG9uIHJlc3VtZSBuZXZl
ciBjb21wbGV0ZXMuDQo+ID4NCj4gPiBUbyBmaXggdGhpcywgc2ltaWxhciB0byB0aGUgZHdjIGRy
aXZlciwgdXNlDQo+ID4gcGNpX2hvc3RfY29tbW9uX2QzY29sZF9wb3NzaWJsZSgpIHRvIGNoZWNr
IGlmIHRoZSBjb250cm9sbGVyIHNob3VsZCBiZQ0KPiA+IHBvd2VyZWQgZG93biBhbmQga2VlcCB0
aGUgY29udHJvbGxlciBydW5uaW5nIG90aGVyd2lzZS4gRG8gdGhpcyBvbmx5IGZvcg0KPiA+IHMy
aWRsZSwgYXMgZGVlcCBzbGVlcCBjb3VsZCBwb3dlciBvZmYgdGhlIFNvQyBhbmQgbmVpdGhlciB0
aGUgcG93ZXINCj4gZG9tYWluDQo+ID4gbm9yIHRoZSBkcml2ZXIgd2lsbCByZXN0b3JlIHRoZSBj
b250cm9sbGVyIGNsb2NrcyBhbmQgcmVzZXRzIG9uIHJlc3VtZS4NCj4gPg0KPiA+IEZpeGVzOiA3
ZWY1MDJmYjM1YjIgKCJQQ0k6IEFkZCBSZW5lc2FzIFJaL0czUyBob3N0IGNvbnRyb2xsZXIgZHJp
dmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBPdmlkaXUgUGFuYWl0IDxvdmlkaXUucGFuYWl0LnJi
QHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IE5vdGU6IHRoaXMgZml4IGRlcGVuZHMgb24gdGhl
IGZvbGxvd2luZyBzZXJpZXM6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYx
MDAyMTEwOTM1LjIwMDQzNDktMS0NCj4gY2xhdWRpdS5iZXpuZWFAa2VybmVsLm9yZy8NCj4gPg0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcnpnM3MtaG9zdC5jIHwgOCArKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJ6ZzNzLWhvc3QuYw0KPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yemczcy1ob3N0LmMNCj4gPiBpbmRleCBlZWEyMTU4MTg2
MzMuLjlmYzFhNWE0YmVkOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtcnpnM3MtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXJ6ZzNzLWhvc3QuYw0KPiA+IEBAIC0yMjcyLDYgKzIyNzIsMTQgQEAgc3RhdGljIGludCByemcz
c19wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHN0YXRp
YyBpbnQgcnpnM3NfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAg
ew0KPiA+ICAgICAgIHN0cnVjdCByemczc19wY2llX2hvc3QgKmhvc3QgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gPiArICAgICBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBwY2lf
aG9zdF9icmlkZ2VfZnJvbV9wcml2KGhvc3QpOw0KPiA+ICsgICAgIGJvb2wgcG1lX2NhcGFibGU7
DQo+ID4gKw0KPiA+ICsgICAgIGlmICghcG1fc3VzcGVuZF92aWFfZmlybXdhcmUoKSAmJg0KPiAN
Cj4gRm9yIGNoZWNraW5nIFMyUiwgeW91IG5lZWQgdG8gdXNlOg0KPiANCj4gICAgICAgICBpZiAo
cG1fc3VzcGVuZF90YXJnZXRfc3RhdGUgIT0gUE1fU1VTUEVORF9NRU0pDQo+IA0KDQpXaWxsIHVw
ZGF0ZSBpbiB2Mi4NCg0KPiA+ICsgICAgICAgICAhcGNpX2hvc3RfY29tbW9uX2QzY29sZF9wb3Nz
aWJsZShicmlkZ2UsICZwbWVfY2FwYWJsZSkpIHsNCj4gPiArICAgICAgICAgICAgIGRldmljZV9z
ZXRfYXdha2VfcGF0aChkZXYpOw0KPiANCj4gV2h5PyBUbyBrZWVwIHBvd2VyIGRvbWFpbiBPTj8g
VGhpcyBpcyBub3QganVzdGlmaWVkIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQoNClRoaXMg
d2FzIGFkZGVkIHNvIHRoYXQgdGhlIGNsb2NrcyBhcmUgbm90IHR1cm5lZCBvZmYgYnkgdGhlIFBN
IGRvbWFpbi4NCg0KSSdsbCBhZGQgYSBub3RlIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdGhp
cyBpbiB2Mi4NCg0KVGhhbmtzLA0KT3ZpZGl1DQoNCj4gLSBNYW5pDQo+IA0KDQo=
