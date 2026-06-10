Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA13BADA2;
	Wed, 10 Jun 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082020; cv=fail; b=KqMTW9/lhvHDBRfCIWH0mOFudrJIxG3wEnqqpZHD4lvjL1Wa+YPWajFCkuo18lqKnGZYNM7gznW1LO3S7x833X1HG9iyppcrvzeowVllivh9mgD1i5DxBjXE2LNF1bNnRNHv269Zn7yZuqkfNI2PhWgxxtRIloocIYRzjOm9H/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082020; c=relaxed/simple;
	bh=Em+GDP0BIDT0pOpZdkDCYiKTn02/cDsZKjjRZ/4llOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7vcD9TQnnuk++pIHk18aX+/csIOo4kIcbBbXI9KSFjE3GHkN0E9Yr6+iGOPLQTlS/Bu/M9d7BwImdsdXXU92f1MRil+QbkvcAsEl2KbT8gPeXh3CusL8fl7i5llDNYFfUCryensRXXoMtxfBLGtx9gZL27xB287cgDXTpcT/0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JUukjixR; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JUukjixR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl1WstOgbmKh54lOU8WAg7lYvodBpHdS/Iy1RaeKdCg8uC5l7X+rvX+XbhvI8Tmr95pwhVHbyMQpYFMXJgAIV3UK8oipQ+yTpeIfe+41IXFia1jt6uHvJv45S+YjtykrKern0irdqioK1ORidFUZEk0o4CUgVJsuh7rbgSM63xrGapswxvXeRGiAens5u1dh5yvLEvHzwfPvfe/BwlhzbyzFiggaQzfM82IYPzAp2cpYWvY98BlEBBJnY8DiBrXgR59T8drP1IalON3n2gMGP64sCGb3PFcSfD2c/3YXXTeP8jibmtCGrCcWZ/CpNTiP1IjLlzY4G612gY0snml8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em+GDP0BIDT0pOpZdkDCYiKTn02/cDsZKjjRZ/4llOk=;
 b=t5w7axKJ8x2zWi688OVjAB3GkiV9YPi7ZFOHY/741g6rRxLkxm2ZLFDpEp/qSoywH+qYfvu6U8wbKe+a1kDwjMb5lAKI/Q1ljyzquGLEfDoUzAHdvR6PPeekUcjdGtyuR2SnQxELKnx/Ax+BTKniTrxBmXaEwIhf9dygMCFuXDFRl+Fdv9VNW3ynK8q1i1Ydw9NpDsAv1GxpmmXeTSQbEpf8V4l1Vi8v6L5TN6VMmx3vYnOuetTeFAdlODY18xxKRTK6LC78co3Pi7/5Pf8Fk2nPLvHnD8CL02YqgR52NO1+jq5soFHja0V9/Hx5KnlPc/+JlQ6lhRfrpVOHrrVxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em+GDP0BIDT0pOpZdkDCYiKTn02/cDsZKjjRZ/4llOk=;
 b=JUukjixRN4Kn8YBdTFeU6+WU+C9Bc2/wQiW4juIwyFXLrfWUHjz0l4+f3OOsm0UX9rG5+o0x5yKhbSGBn/gEpD4MYVg0GILZvC0aPuuPMsQaUO81+sspkGo/BwBZwspROdEmvMrqbQf1JMbxvTYJf6kK4moaGnNNdjaOapHXS6tFhw7PMHjfrgGy4MSJbmq0RJjJGPuUYC8wGxCW6tVzjyxtEEzlN+dUZUrqknqGfJgVujfSpdPZKIk7iktMtmk3g+xTFs0u+8z6h8UVyc/vbSs+9d+QRs+/eJDhC3KCw6CTJs/PZqRhJx+rz6GxLXMtCw7MHiKUNX+2XG2mdXemIA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI0PR04MB12211.eurprd04.prod.outlook.com
 (2603:10a6:800:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:00:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:00:16 +0000
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
Thread-Index: AQHc98EqSHx96zAXkk2n7RCbK2H3mLY1lPEAgABAkQCAAaAD0IAABQ6AgAADzaA=
Date: Wed, 10 Jun 2026 09:00:16 +0000
Message-ID:
 <VI0PR04MB12114452B9EA05635BE745D54921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <10f5d51a-2e0e-477f-8431-9a305d57118c@kernel.org>
In-Reply-To: <10f5d51a-2e0e-477f-8431-9a305d57118c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI0PR04MB12211:EE_
x-ms-office365-filtering-correlation-id: 74a1bbd7-c88b-4f04-93d5-08dec6ceb09d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 v2QliVkYYnjmWWxpOqUCcBrjsZ/Z2RsAc5eppYo35p/nG2/48IKfCIO81xhrpXFXBWVe4JLa14SEECGHiKMOw1Lkq50C63MyQYurZDGS3ueIrpNlGwQYKQ3p0FSfO31fape/R3gR5yMwb6Rr2YhoauyBpIz7IcBG7/CYBzs0fnNjrQspiha0ZFDXmFFKxcoVAnUB3F3S1gdBdrfVw1lrx6mv0KPwOEh3QMYjHp7qoYsef6rZtYuXR3Jz61LWxIzmdF9JaXqO2fYIpWNNl2WZgXg82XSzt2JGw4qZfxXw029rJtT1hdbDuumvFiv8KpKvazmGFNuR/wu5257rSL0pix3xStI/1gzSpQ0feL/4GKa0dKkmw6bVTRG3PsbgfH6dja2MdeDAHKAAGfxeiBsaOn/Yz7MAsBM1MBRTgOq4QEreW3sbFamsNK4h5xYYE1sT94MtpjiramXC7W09s7+Tazu5wIo4VM5/oUZoiRypd+ySqeiXn3vBJ0TBuCBIWhpnAh2yNYdZgjGDF2z4QqXvAfjXu8G5Ra/iS9BkCT03vTqdhvxL/KkYVDviF3jgz0YqF9ARbYpgg6o4oh2U3i5wul30CkGy8yg/g6gZNTLCmFgdI7G/HPGXbAwLOXrkL9U7QvcCZBpq4N4Oul789YOQ6Y2lAuuiELqkMbWzBF1SLrRCpQIgKMC8V1HbPSj6QgrS2nJ23RFd1XF73+fxZkcd9oQKNc6Pg+Jt4xa+gF4WVajMs8grj6fjNICnwLV09GHh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2hLRTNuNVBnendkUU9Bc0Jmb3VLWGRlb3BTUmc0ekE5VlBMcDB0S3o3MHA1?=
 =?utf-8?B?ck5UZFZlSUsyeVFCZFZnUTJLY2J0VW9rWENIdURmT3c4NjIvcDkvNWpCY01q?=
 =?utf-8?B?enVCZVpEUGNPRXZtTWxqUWhSTS83bitOb2VaZVROc0FYQ3B0cWc5SXlxczk2?=
 =?utf-8?B?MCtrL1lYSDN5c0lsTE5IZUU5bGIyZ1FmVEpqcE4yaVJrN1BDdFA0TzREaTdD?=
 =?utf-8?B?akk3UzJ5d1U1TjBoZ2l4dWNpOUVNTWRLK3QwNUxoRlVJdlUrdjhoeWRyMGo2?=
 =?utf-8?B?dFZtbkVXbTZLUElqcnNKeTEzczlGWFJXZEhQaTdaVGlPRDJBZ2dmOFRsWTFq?=
 =?utf-8?B?Mm5ydzg2VDFNVENBZjcydnp1Y1Z3UHVBbXl2a2xzN3hiSDlNV1dRSUF2cXlE?=
 =?utf-8?B?WkdaUnl0Y0R6SFlmRTVyZTdNeldJUXg0bFVaNVNHUzMrS2p3TmQ2aklHVUlo?=
 =?utf-8?B?MXBUc21oMWwvYW9XRTd1N2UxallTU0hoWDBXeG9hNHV1U01xQmRpbTRkNGVn?=
 =?utf-8?B?RFhmZnB2ekFERzkwUkJYNFFibDRVVFU4MytRV0ZES2pnbWZpMWhBSkljSTJ6?=
 =?utf-8?B?TEcxZGsrbmc3dVZiUXZzVDVZY09lMk1mZVFTQTFDOEdiTjZDblRNVTM5Um1h?=
 =?utf-8?B?LzgvOW0yS2FUWm1SVFJOSHdpZmo4dHV0NGhCV1VKQ2kyYS9xOHNQaHRRcS9S?=
 =?utf-8?B?OUFTeW5ITmp6QlpKZVAzK25FWVlNa04vdi83OU5VU3IxSi9uS1B2OUg5U0tV?=
 =?utf-8?B?ZXRxZnRiVm5LcFJpajRoaEV1UDcyNlNhNFpVOHFRQ05aRUdIT2xDNWROV3dK?=
 =?utf-8?B?OWxyY3IyZmlCYjFveDBZWE5IRFJwMlVNWjFiWENJQXRad2FSL00rZUR1bDNr?=
 =?utf-8?B?aWJvb0FrbFNtM2xCT0ZiQ01EeXIzR0FSOTFSNWxjU1prR0wzanpRSXRNWW4w?=
 =?utf-8?B?bDVKNEZGaEl0UVFmK2VSV2h1eDVKQm9NMnY1UFV2WTBGTGswajBBb1hadkw2?=
 =?utf-8?B?czYzUGpMQUFCc0tXeXNaZ0I3czE1VUNodDhqczlWTEVjNUh0RzlVeGFOajIx?=
 =?utf-8?B?d1F3YmxheEUxL1VlNFBMaXdjRnUxRE5sbmJmK1B5YWhDeTJXdUd0QlU0M0dL?=
 =?utf-8?B?STROUjQzMkpYTTljTmdmNXJVNlMvcUd1dWdzZjJLSnhud0NqTWxRNTJRK3dW?=
 =?utf-8?B?QkhLUjNEM0ltdlA2dDJ0a3puQ2lLQTUzaStlN29oYisvNE1kT1RHY050QWU4?=
 =?utf-8?B?WGdlYmZIN05nYWhreWxrem9FbUpJcTUwZmx4M2hTaWJ0T1YwLzlaSGZGZTNq?=
 =?utf-8?B?VnArMFkwTnFXcmRQVmp6OW1vOTB6VERjdnpiZDlLTUpncVBrZXZaaGFwcG9P?=
 =?utf-8?B?T3JEYmsxVFdYeWRrQVdCaGxNckJXUDRHckJ4R3IweVR0dzlXUll3VWtBdmxX?=
 =?utf-8?B?R0dkU2xXWWNMVUtOUU9QTS9keHdnTmZXSUJONWVac0lMSzR5Z3hTOFlPazF0?=
 =?utf-8?B?Wk1Dcy9RVlU4VlExTTluSUt5a01PVGQ4dTNsYncxTXpDWm0wUmN0RzA0WXJ1?=
 =?utf-8?B?elQ2dGprN082Tm4wSVZoemEyQUdmQVVZblVUdG5vVFFJcXl0ZFB3eEJlWm45?=
 =?utf-8?B?U0lmRWRsL25iNmFLaHJ0eTdBUG5FY3RpR1ZCRTFGajgzd1E1STFMZzViWUJa?=
 =?utf-8?B?T1gvVkZrSlV2UEUyUFp6dXQ1NmZtdXB5QWk5cU1lc21PbVBGd01LMkRoenF4?=
 =?utf-8?B?MG9ya2N3dy9NNHpubmdvTGhjdElKSUxJUkRVNHJxc0NQYzl0WVlKczExSWNI?=
 =?utf-8?B?TlY5WXZxVFUzclVzTjNvckZmQkVOcGZCY29NRzdLandSdXZTeGNNenJ4WGxC?=
 =?utf-8?B?TC84RXpDS1RmMG1EZ0hYUlErYkd4UjljRlhlZDc4R0VtdWwrbjN3enJlTzBz?=
 =?utf-8?B?VWlheEZVNUhlSllYei9IV0REUGRZVms5MGxVempuQitGRkRlUk1SdnJDRGtV?=
 =?utf-8?B?L25BeEF6UUZWdFhGVmJLeGZ6dWJ4L2ZxRVE5S29kSE9kOEZ0ZThjV0hDWmE3?=
 =?utf-8?B?QkJocU4ybVN4Q01ZbXNrWFRBSkdUN0lmdHFpOFhGdU8raXR2c3IrSEIxazg2?=
 =?utf-8?B?MHludlR4QlQ5YzR3V3p1M3gzTVBtaTNqczFqbk1TVWNYaS8yRXFJd09kdEJu?=
 =?utf-8?B?ZlRqbDRLdERiSU8zYzV1T09vODZBQmh1akdLcUM3OHFYS3JUakxFZHlxT0hk?=
 =?utf-8?B?WGFSMVg5NnBROEVzdzBETmJvUnVTdWcrNkdaMjFPRWZMN2FuUkNQS0U5bGdN?=
 =?utf-8?Q?5/m75jEi3ZJ1Q8rIhp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a1bbd7-c88b-4f04-93d5-08dec6ceb09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 09:00:16.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XKOiKY5JmQ8uRn9DR1OWe3pqXUZgku4BVHdq4xDyTcKMuxDG7A8xqo+/KOEJBrrVOJc8CgnFslYHVGNlB6drQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12211

DQo+IE9uIDEwLzA2LzIwMjYgMTA6NDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4+IE9uIFR1ZSwg
SnVuIDA5LCAyMDI2IGF0IDAzOjQ0OjA4QU0gKzAwMDAsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcg
d3JvdGU6DQo+ID4+PiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJ
IHJldmlldyBmb3VuZCAxIHBvdGVudGlhbA0KPiA+PiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4g
Pj4+IC0gW01lZGl1bV0gVGhlIGB2cGNpZTN2M2F1eC1zdXBwbHlgIHByb3BlcnR5IGRlc2NyaWJl
cyBhDQo+ID4+PiBub24tZXhpc3RlbnQNCj4gPj4gaGFyZHdhcmUgZmVhdHVyZSBvbiB0aGUgTS4y
IEtleSBFIGNvbm5lY3RvciB0byB3b3JrIGFyb3VuZCBhIHNvZnR3YXJlDQo+ID4+IHBvbGljeS4N
Cj4gPj4NCj4gPj4gRmVlbHMgdmFsaWQuIERlc2NyaWJlIHdoaWNoIHBpbiBvbiBNMiBjb25uZWN0
b3IgYXJlIHlvdSByZXByZXNlbnRpbmcuDQo+ID4+DQo+ID4NCj4gPiBSZWZlciB0byBQQ0kgRXhw
cmVzcyBNLjIgU3BlY2lmaWNhdGlvbiByNS4xIHNlYzMuMS4xIFBvd2VyIFNvdXJjZXMgYW5kDQo+
ID4gR3JvdW5kcy4NCj4gPg0KPiA+IFBDSSBFeHByZXNzIE0uMiBTb2NrZXQgMSB1dGlsaXplcyBh
IDMuMyBWIHBvd2VyIHNvdXJjZS4gVGhlIHZvbHRhZ2UNCj4gPiBzb3VyY2UsIDMuMyBWLCBpcyBl
eHBlY3RlZCB0byBiZSBhdmFpbGFibGUgZHVyaW5nIHRoZSBzeXN0ZW3igJlzDQo+ID4gc3RhbmQt
Ynkvc3VzcGVuZCBzdGF0ZSB0byBzdXBwb3J0IHdha2UgZXZlbnQgcHJvY2Vzc2luZyBvbiB0aGUN
Cj4gPiBjb21tdW5pY2F0aW9ucyBjYXJkLg0KPiANCj4gQWdhaW46DQo+IERlc2NyaWJlIHdoaWNo
IHBpbiBvbiBNMiBjb25uZWN0b3IgYXJlIHlvdSByZXByZXNlbnRpbmcuDQoNClNhbWUgcGluIHdp
dGggdGhlIHZwY2llM3YzLXN1cHBseSBwcm9wZXJ0eSBpbiBjdXJyZW50IGR0LWJpbmRpbmcuDQpT
byBmcm9tIERldmljZSB0cmVlIGJpbmRpbmdzIHBlcnNwZWN0aXZlLCB2cGNpZTN2M2F1eCBsb29r
cyBub3QgdGhhdA0KcmVhc29uYWJsZS4gSSBhbSB3b25kZXJpbmcgaWYgdGhlcmUgYXJlIGJldHRl
ciBzb2x1dGlvbnMgdG8gc3VwcG9ydCB0aGlzLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
