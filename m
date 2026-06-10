Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C756282F1E;
	Wed, 10 Jun 2026 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080859; cv=fail; b=r7XKuVQ/F8B3eTZ1iIMEWilkv9gP2jVj4MrchSjaV2SaUvZJByBv9ipy6sFYMOK+IBzr5GCeWkJGF6+4/gMseYfw/3JBbkHP08up+k/mPNaKAA16YFrnQlEkjiNFwig4lhZtbQEB8xhI/dmC2Ej8cv3Kg52oMgtzG5eHp4HFO2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080859; c=relaxed/simple;
	bh=l/o3cirmx1O2YCtFFDH5TZY2PgKZka84vA6IQ8a3Ki8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pNt2ns+lNpcS6Ovzc09Pf82ouIABwZPyC9sKxf2crAaY6NlpDC1EUzKfrqN5pa1Sc6qDFMsiTwY/mlYrMpxSLK4rw/OKemPAtJhx1wg/xSYJJU3imtKIGda6TUUoeQMqwc8FtoI2NPYxTXELh0atnLmY7ud/x+w5HDpahG85Dms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DiVQvwD4; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DiVQvwD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhs0p0HX3eEYuKi6FeKdSDM6H95F5URhRzqj2ia5tLvyY+rWP82PDBhHrkOz/xAtkw5E9XOLkRBPPASEkuiWCyw3SVAsJlpiSLWJ1ELKWghKiwFYM1/QaI0MnQOaHb4MFPOV6wy72RScymouEtflsjKoFdFqg/Q3WfvtaLWZ2TS7jsive9pbikKAPu8Q94A9r/Ehfr2rChN1jy/5l5lcyVoSmXJ2qcyC1dNh//pmB3qbQLdg597N7B+udqAxNbOKNv7AFyOBSkcdtrNX2pJfhYujh+th1DHN2k4ITEvxQuulRFKGO2wqx8JI/fuL9NGrjloO28BwGhbnLPEoA+nXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/o3cirmx1O2YCtFFDH5TZY2PgKZka84vA6IQ8a3Ki8=;
 b=TXGij3VLqNGZESzP2UE/BcEFWEr9uBtDvMTXxlW75mwhizJH2S8+G+gMkCFwLrIpdT7LqmyuVHpwpFn9flASyiMRx4joT26tv8vLkIK3o31edIDE31hzzDFjdAGdxoKeuZ6oXLDC58NldjQNMoGqFqDRJlwJAdcJMEhfpdngkON57WaxCkEsS2I0yIxFSzQ5cqS2rO1DU3b0GRRb58xwYx4UNrVP6T3VE5+ueI9nRVJP47+NJ6hhgn/HQD3ql5hPPeGnR7oYJuAoR/KYd6GsquXZc3NKVTxvH06ET7n/ADZxm/ynmopLKSSyxsuKdZYMzdlNsMyOnyhHqF5+FWODbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/o3cirmx1O2YCtFFDH5TZY2PgKZka84vA6IQ8a3Ki8=;
 b=DiVQvwD4YSNaS9XvE8owubTXzKhriolTYJOn6AQoCkGKDhiOA+VOuR6sZXw/chnN9PTo9Y0CQoBaGInKvAcPf+Eeo42nQ6ImwjwLobd1XCL7cVbv7NWH7kO3oZoUiRzY4wYXJ1VDq5nGx1wVZcmu+IxnHDkzoNnOyQI2H/S7pxNl0zvY2S6c+7lGFKgi5qRZH4voAJvcAUruzE5M3yJUAUEjUvJKkKjF5xv+KRqLeYMkpIoZ2GWEjHz9mOhVTJSkDPF8yBNnGnRWypYFFE49v9VQJrhIdHqXvNtrdkEiEoz28r/B5Sibj/Pa+wvZoj4XREm+b6fvGzd0lEzJBLGF2A==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB7695.eurprd04.prod.outlook.com
 (2603:10a6:102:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:40:55 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:40:55 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply
 support
Thread-Topic: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Thread-Index: AQHc98EqSHx96zAXkk2n7RCbK2H3mLY1lPEAgABAkQCAAaAD0A==
Date: Wed, 10 Jun 2026 08:40:54 +0000
Message-ID:
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
In-Reply-To: <20260609-unique-magnificent-eel-eb623f@quoll>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA4PR04MB7695:EE_
x-ms-office365-filtering-correlation-id: 6f74e2e8-9d7b-43ca-d265-08dec6cbfc7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /qoRBPAWHD28dA7lTP4SZkmuqMIYY0c9lU0P07mCC+OIO3ziNxTmucQWGTOvBGlsMrr0+0dwLxarZ11eGQfh6lsYLSDB5DlYays1betqL11XXsg1+k7/SHkejNBwtsCKWDWWHQatsgqR/trmlCHGghWQAOjtI1Co++H2tyJTycFe+qd6jJ5A5Sfa45fd3sIqKryGDO50uL8r6aguyiplZtZmCatn96TqTgWNQdVoyCuJkNZmSR2TUhLVBCEjxTfu9dEvaoPIrV5CAvjH7dklYufC69A9TpiatyyKPYMBZUh4Plw72El1+VetNGIbMDeHc1iAkUTTJuk2m1x8Onyw7qEBsAH2fC1vKrPtWQmxYCCJ6Sz1Xy90OYJH9y+ue62PheGxU/1Y94QQaIzRuXv/FIqvQsI6WrXiR3zM5LNJUMGzzlUBbg15aOT3dtvFhf/oKRGomWGkBmbjaQk2gZ5FpKLlCgtyxZItjfoKci/KCYXJ/xnaq8E4ax1V30aOg9DKgHECvMe3XHK4QRoyruq2uQvZeFKY7k8Q+HLl7SW/fH1BID+pAz/c75c6HolzOwgEOPuJlS2obaXFec9FB6XCRBAuAs6jlGDVLSfiOaneW5yNxpz3PeCyHWACZ0k8otyuR2XU0ni+aR05zeKfukZTH/tTzryD0v9BM7qZym2gLYF66qIoEYO7ZxI0a01tPiMUpyvYZ49pnwcKkwikyBzMXj1u2DlRiJs0VeUPZuVbiAj4V4xGkU0yntQtVKm61EA+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWdaak1zQWlERFJxU2pHRHcvbnBQYnNGcFMyUjRnMzluMklFcko3M2J1aHNU?=
 =?utf-8?B?Sm5GTDhnSzR3dTJCOFVzaWhsdHlDK3FLaXlwcERBTjIyZ3UwSHFvajh2RWs1?=
 =?utf-8?B?QllSUGNYcEJWZDh3UkVJWFlJNVhMbkd5R1F0dWxKY2NwUXdwSmxPd2phMTJO?=
 =?utf-8?B?T1UvTWhIS05Ja0JnNEVoZ3FMNEVZWnZMVnpBUWFUb0x0ZnpSTmJ5aG5ZbnpE?=
 =?utf-8?B?MGpvSHI3UUxKbEdzeVNFQ1NESS9FTHlaVlNIejlLRFQ2VTdSMHUvNFhET2NZ?=
 =?utf-8?B?bGpmT2EvZ29RNmYxWmVySXV3S0paL0t6U0dqanR4dkRtVDBTMUhBSnZrTE52?=
 =?utf-8?B?SFJySlVtZE12a3V6dGJtM1A2WmZkZmxSZjNjT3djOFVVQ3RTQlVtOGdIT2xp?=
 =?utf-8?B?UzdUR0pMempXOWxkSnNxbnBYOEFhdm9lbXgrYlVKS05QQzkrTCtaaEVSU2k0?=
 =?utf-8?B?VW55Y0JUNUNNWk5XeHpKRzNmSWxRSHBQS0ZTY0JtK295MmcvcmM5QmtPc1px?=
 =?utf-8?B?YkJyaWMzL2ZwK3crYmhxU3l5N0dIMWtObFRzNVV4OEJQaGY1MUhYS0dPYkVC?=
 =?utf-8?B?NmtSRVZmTkpKSTJqZk9jYjhlbXl4S2ovbnhHODR6VllXQU56QzhldmtTRHhv?=
 =?utf-8?B?b2ZTOFoyVDhaTU1WK1ZlK1NBNWx0SFR5RU51bXJ0Sml3SllZQXJjL3Jia3Yv?=
 =?utf-8?B?WTZTZzJIVVhxQlY1UnlwclJoaGRGNHVtQVExRGpjbHZUbjhzVEJkVlJDRXBk?=
 =?utf-8?B?RFV1cXZ2UWRRVllzSTNvRFd4Ujd4V0YzM2tHdTBqWE5sWlBFeUFyRU53allO?=
 =?utf-8?B?YzlWeElyM0VtMGtGZUx5YnNINThUa2JSVFBtU2xHYTJQWk1KTUsrRlBjR2N4?=
 =?utf-8?B?UVBZdEFNcTQ0SkhWSEZzVnVKRFdvckJEOTFhSEppcjRwM25PTnh1dGtpNVRx?=
 =?utf-8?B?b3dLck1CSVRycWVZV1dUNExsWkN6WFZuSkZxS2s5RTRnQzFWOHVBR1dQNklu?=
 =?utf-8?B?dHRONHIyRVkyNkhCVldQQmEzM05iS2dUbVZhWVFtYndvQlI1NXA0NUtrbFJS?=
 =?utf-8?B?SXZzMFlnZGJMekdjcmhEVVNxWElmcjFmK0hwY2tvbC9OVUVOaS95Rm4wVEU5?=
 =?utf-8?B?UVd2RENDRWVCSkQ0V0pFU2RYQlVvQldzTFhzOWZNZlpqeU51TEVpQnlieWxr?=
 =?utf-8?B?WlNEdjRWVURPZE85UkZjalpCbnFpb2d5Z3h4NnlUS0RhTWh6NXNncTNGNWsx?=
 =?utf-8?B?Z2xwZ2o4dlR2T2xKWi91RnhtcVBNRWNXODRDOUNpNGZpVGd6TUJxTFYvaXFj?=
 =?utf-8?B?aW5QU3g5NHgzZVROdmdUbGFMUy8rZHc5U3M1M0VrWUo4Tko2QVpmVldsN1U1?=
 =?utf-8?B?YjBIMmNGNmtqdVlnZEFCVm1xQjdPNFB2ZzRzWWFQdGlpYTN1anFWRGc5dEtz?=
 =?utf-8?B?RFhIZ01LdDMzZmxtWDlqK09weThWazVnVWJPV3pYSTFLdkxJalptcXA1eFZt?=
 =?utf-8?B?THVqTFVrTkRTQW5YaUN4d0F3NjZXSnMvczQ3cmVxcFp4QXNYWVBJSU00VzNF?=
 =?utf-8?B?aTFubWlwVnMrcktaMkxUTlVia3orSVdCUEIxSEFMekYyM0dqdXIvc25iSFdz?=
 =?utf-8?B?QkZDWFZaUUU4YzN0cHNZZ0IydzQxVjBwYnBoR1pjcnRLS3ovMldCSGV6eFVr?=
 =?utf-8?B?TEtxYmxhMTEyWVRPYWllMFZEM2VEWUE5aE1kTnNPSVVyNm5NWnVCTHRyTGhp?=
 =?utf-8?B?VDZzZ0t6aXV6Y3pQbURrWElGallyWWsycWpmWHR1SDN0Y21Ldnl2eTl0QS9u?=
 =?utf-8?B?N0hEVDRhRnkxRUkrWFdRYllkRHArVHQ2aUJlNVdRU2lBcWF6R0VOclZWMWhi?=
 =?utf-8?B?NW03bUpzMkE1RlpGajE3WE9pdHl0bnJiaHMydEx6SVRSZnRLUVd4bHFYeURU?=
 =?utf-8?B?UVNKdVliQmJTaVpjNStEYktEQ0JMQ2M4VXprLy8rQkpPN0Z6dEpHWXd3SUx0?=
 =?utf-8?B?SVU4ZWZPTmQ3U21RL0NBcS9wUjVCSlBTYTZRUll4eEEyT1huaDdxdlNtU1Vj?=
 =?utf-8?B?ajhrSHNialFlZWYxSU03R1BYMlZVb3NLZldpWVh1MFAzbjEvcGE3S2Zwb250?=
 =?utf-8?B?Y2NZUUd6VGRFYUtvcllTNGplT01ONjVPNFcyazFLSXFOWmozVWdxVjMvaHZw?=
 =?utf-8?B?dVVmOVBJYi96N294Q3gxaDVCWFRwNVJPMlJiUEpjQ1lhK1NURDNYb2dIeTlt?=
 =?utf-8?B?WWN1Rkpmb29lc3YzekdqNmxkQXBUZGMvNE4vNlh5Tld5NFowaE90L0JjTklq?=
 =?utf-8?Q?Jbp9Dd396rOP+g/5EN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f74e2e8-9d7b-43ca-d265-08dec6cbfc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 08:40:54.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sw3trw1YdYeO9NWWudh2owDWyoNBKiZcmTPtVRmIevKAlhNlMMW4/0LU1gM6BNps1uIKVubr9VgP3edQMKPKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

PiBPbiBUdWUsIEp1biAwOSwgMjAyNiBhdCAwMzo0NDowOEFNICswMDAwLCBzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnIHdyb3RlOg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNh
c2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsDQo+IGlzc3VlKHMpIHRvIGNvbnNpZGVy
Og0KPiA+IC0gW01lZGl1bV0gVGhlIGB2cGNpZTN2M2F1eC1zdXBwbHlgIHByb3BlcnR5IGRlc2Ny
aWJlcyBhIG5vbi1leGlzdGVudA0KPiBoYXJkd2FyZSBmZWF0dXJlIG9uIHRoZSBNLjIgS2V5IEUg
Y29ubmVjdG9yIHRvIHdvcmsgYXJvdW5kIGEgc29mdHdhcmUNCj4gcG9saWN5Lg0KPiANCj4gRmVl
bHMgdmFsaWQuIERlc2NyaWJlIHdoaWNoIHBpbiBvbiBNMiBjb25uZWN0b3IgYXJlIHlvdSByZXBy
ZXNlbnRpbmcuDQo+IA0KDQpSZWZlciB0byBQQ0kgRXhwcmVzcyBNLjIgU3BlY2lmaWNhdGlvbiBy
NS4xIHNlYzMuMS4xIFBvd2VyIFNvdXJjZXMgYW5kDQpHcm91bmRzLg0KDQpQQ0kgRXhwcmVzcyBN
LjIgU29ja2V0IDEgdXRpbGl6ZXMgYSAzLjMgViBwb3dlciBzb3VyY2UuIFRoZSB2b2x0YWdlDQpz
b3VyY2UsIDMuMyBWLCBpcyBleHBlY3RlZCB0byBiZSBhdmFpbGFibGUgZHVyaW5nIHRoZSBzeXN0
ZW3igJlzDQpzdGFuZC1ieS9zdXNwZW5kIHN0YXRlIHRvIHN1cHBvcnQgd2FrZSBldmVudCBwcm9j
ZXNzaW5nIG9uIHRoZQ0KY29tbXVuaWNhdGlvbnMgY2FyZC4NCg0KQnV0IHRoZSBjdXJyZW50IHZw
Y2llM3YzLXN1cHBseSBtYXkgYmUgZ2F0ZWQgb2ZmIGR1cmluZyBzeXN0ZW0gc3VzcGVuZC4NClNv
IEkgIHRyaWVkIHRvIGFkZCB2cGNpZTN2M2F1eC1zdXBwbHkgdG8gbGV0IHRoaXMgMy4zIFYgcG93
ZXIgc291cmNlDQphbHdheXMgb24gZm9yIFBDSWUgTS4yIEtleSBFIGNvbm5lY3Rvci4gVGhhdCBt
ZWFucyB2cGNpZTN2M2F1eC1zdXBwbHkNCmFuZCB2cGNpZTN2My1zdXBwbHkgYWN0dWFsbHkgcmVm
ZXIgdG8gdGhlIHNhbWUgMy4zIFYgcG93ZXIgc291cmNlLg0KDQpATWFuaSwgZG8geW91IHRoaW5r
IHRoaXMgaXMgcmVhc29uYWJsZT8gT3IgZG8geW91IGhhdmUgYW55IG90aGVyIGJldHRlcg0Kc29s
dXRpb25zPyBUaGFua3MhDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQoNCg0K
