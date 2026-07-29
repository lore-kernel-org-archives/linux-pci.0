Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D93C1D41;
	Wed, 29 Jul 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340175; cv=fail; b=aV72M+AKMqZaxjT++6fc+RQRjdNZzq27sd8tFhKO2KUXRQu0HEJ3IBizdXhWlyBiUvCECxjkg0ngGoMzaWezHZW3al0KYH1TlHSK0Y8BKg5u3dD6vAaTo2LUspWytswMkNGl4I2w5tkbRWEmtp78QFkkapV27lCV4Z0CckhaW9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340175; c=relaxed/simple;
	bh=1JqCQJ0WzmnL0ZJHJjBnvFenZhOPc7m2CPP6IqS0Eho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSVTmxGqJ9IE+Za6XerXAFR+aqdsc6qoP0neKkjr6I1KfhInekTodxV79t/OvtDzEP7EZA2aOver7GGB4GxzDtHoDV1gRKOrPbrq3przw24uJBOmBQc0HnRsJILssfaKeBOUPqH5KtEWWqw8dI5G8qyJOAuEdjz/6prtPkTj/sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFW8dTX0; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFW8dTX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brrPMG4UZLZOEvihIto4jS1vqbPbFxCk/V8ouIQHGk6xf8ZfrwgXrjofpXlE42wYoqW7dBjA+kk25mXJo3lCxMBrMVU64b09dou3KPymHcVX9b68aeD89qQiBMF2bzGi+3SlhgZrKNEvbdejqzz5pLZwJwzn1f+arvr3TnejrzHUb9R/8zbZASjHBucuE/Dg9gE5m2NZqgFZxzHPNTT7ihxHQ7OxiFAexEondrAt1MM6bYNbvxMZxYbvNFzlVibs1qLzQksxnLs4aVl9HgLrAd5RWaK4colDqaL/OPj7lb56RWbmsekyhlT19nzzAGNje53QC6uTz2nvS/9Rn1N0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JqCQJ0WzmnL0ZJHJjBnvFenZhOPc7m2CPP6IqS0Eho=;
 b=TyxApJVMx2pOoP3d6QGiEtgU4jvmDNDd708o7aBPJUIs04pxeS6EFnYLXCHydM+7481C0ZTAUJgCC8pbkCy39wxvLKKjTBjHphawimRZaGppi2CQbGmtz3lBlXmRWJLoucRLdvoEnEd71AP+dnP+w7NmhYXrc7fAngqHCQrICDbfkNVgl3LPXaI3FDnVIji55kKAVEBN/gxoIjuVKQHpJU/QSWIZtY+HosB/ws5bYnM4fpxlRHq//9wyrsgSw6Vhjc4UWfwdq//nV//kZqr90Ra/fQYFhMW/5QECEuYrNzLfUf5Qhjun3HQN31LndKquKCcgjnbiQaPHGC86h4AVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JqCQJ0WzmnL0ZJHJjBnvFenZhOPc7m2CPP6IqS0Eho=;
 b=EFW8dTX0XBDUMs4SuVPryPxqwF3NnpW1/pisIZj2GDTGHj+J46mpbtilklOc4shy2aSbXgEqn32hphdSJ0pSeBVnc3dp2N/K9Evc5kpwaz2VYjWy+7Kj6pnXuEDiTqbwm6Tzs+DflFKyP9xk4EuvQpJD4LfVrA/cn0bY4vL/Bzo=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:49:30 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:49:30 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB PCIe
 binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
 PCIe binding
Thread-Index: AQHdHs7F+BzMyBrQg0uVhd+MbYfh7LaEQtmAgABiTuA=
Date: Wed, 29 Jul 2026 15:49:30 +0000
Message-ID:
 <IA4PR12MB9810F020A9719A3C424C15F5CDCA2@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
 <20260728202044.1785986-2-sai.krishna.musham@amd.com>
 <2918ad67-7a78-4e47-824a-15500edeeff1@kernel.org>
In-Reply-To: <2918ad67-7a78-4e47-824a-15500edeeff1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-29T15:46:20.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|SN7PR12MB7131:EE_
x-ms-office365-filtering-correlation-id: 54e1aaaf-3cb9-45e4-e7f6-08deed88fa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 2+LCu9s7gjDue2oWXV9N/sEbU2HgOl0f6ACeKkZm4c15aaj+wyMvDEQ61nCWNI1DDeUaRmo72ijDFuHu/myR5kl6q1l7eOHrwfdx1hBfzmA+4GNtBvu6rphSrMe4pvaPPbrjpMoPG9uCOCeUV+XhgrHrz1hd3OCMZZAvXgteTJZtQldHP4C6tZFaUwkugjf7qgy6kTBo6Fc9nJWOFU/Pcqfyrwe4ujD69otrSuzpIPvoGa3xKLgiUoha+svrPOiE5Z+pf8ql5wiBBdpIEuuRsKz14XagD+euNq6AzT4cnOrYWEt5gBhRn0Kj6moLWKml2F2uP3PUtMfel++QzEJoH4mApdhUROXm/Xde/2ntfYLSKDo6i37fIflypvUS0EASp9QNDW32ny+n10FKKP47ODWWlph5Mijv82SBazep6+vgdW5McaE4tKbpIgUBRSLLpr036SAwKDceANx8l3z+JjtJoeeHHydfJkTZKen16J/k9sjsn/7WLne9MmIL7TsacNiUpEhtAv+A7cwXb5Kk8mzOEk+Tm8mh4DObzt0lcOp54rdxszolGi7nhNp7B9xPhvAKXadBmpa+kWn6hsJoM6ptYTvChnw2uX9Yewaa/HR2m18OZjxKdI0ZAXNDYMTZl5Q91OPg6fXYt9G7SSE6oXvqOMaFmo8UWNWYZPayobc1tfV8nh3fk3dOvEk4gk5V7Oxw8Dl6I183M5zTcjC8WUQFDe3gLo3eVdsh0cYmVzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnhjRGZ1b2RXalZVSTJDU1NjZFNXOTJGbFR5dllIZHBGZ2htUVBzLzV2MDVD?=
 =?utf-8?B?WmN6MkdyejYzTzFtdEVVU2p0UjRiOWFZYkdPY0RMcGJBTi9JaUJoZ1Q3cVJF?=
 =?utf-8?B?aE5yNTZIeFRvVGQ1WWdhRC90T3VNT0kvbzZWdnVid0RnMWpjdG9CbElNQm1l?=
 =?utf-8?B?VzZzaDBTZVJJYUNpT3k1U0pEdHdCMTNNWllMMC9JZUhOQURsMUxyUHdwVHow?=
 =?utf-8?B?dFB6L0RhQVJ6UTJ0dVFycE9IV0czUUZyTXhDcWg2SC8vV09CazUxZld6bVl2?=
 =?utf-8?B?ZE54Z1N2QWNyaXlmdkVHb1dCZVB2Y2JFZytIWWFySjhUWHFScCtpR2syK2k2?=
 =?utf-8?B?cVJsTDZkZy9zNndBZGtQSWU3dVBnYXVCSndMNlZiUEZTUHJ5S1RXNVNLOUNU?=
 =?utf-8?B?U3l2TU82TFlDenRVa08wQ2gvS3VOcy9tOVFKeXZiNHoyVDlFR3MrM3RLWXVC?=
 =?utf-8?B?S2Q5KzY0Q0RtZVAweUpsVjIyZ1ZjZDQvcnRaYUFBSXlvZWNEdGIveHVXdGZI?=
 =?utf-8?B?YTJNUzFnU0QwQ3FIaGtGaEhNcHBUUTQwYlVyS2lWSWZGeG9ULzd2NW9aakNr?=
 =?utf-8?B?ZTJVb1hVTDREQzJsOTJBamdyaWxWQVEzTDVhTTFoREhJckIxWU12bG83b2xC?=
 =?utf-8?B?aTRZbXJ1WVRFZklTSEVCZjg5bzlHN1dBVUtTZFNPVXNPSWlLWnJ3dmRzWmVY?=
 =?utf-8?B?LzQ2cUloVVFVamNVSmovVUJCSDdsQlZiRU9hbEQrTmlWcmxNZXF6VWo5TW5m?=
 =?utf-8?B?d05vaTBoYjlxTFRhT3BRa0l1SklEQnpsWlo1WElCQ3ROWkNMVXNkRGZFYWk2?=
 =?utf-8?B?TmFYcXdtRzFwSDlOQ1dSVmZ5d01ZZGQ5WWd6U0lnekxoZ0RVRWJySUh4c0RS?=
 =?utf-8?B?S1kwZGZ1WTBWVjcxVnFOVHBBRkR5bkoyQ1hOZTU0cWdVQXBSYlA1OXZFbU1h?=
 =?utf-8?B?Qm5neVBKcE5kbHp1VUkrUnRhemNESzF3ZVAxTFh1QzN5WDZQTExzN2M4cjVt?=
 =?utf-8?B?Sm1FbkJPUkFhL3R1Ris2NkxmaHBacElyWFMxQzFYcmRza085MDhvTGlidjdx?=
 =?utf-8?B?Zmt0Vy9JY1JDWmFvOU9iMHdIeFd0UFZmWE91VCthZ2NQNFI5QVMxWTRGeFQr?=
 =?utf-8?B?ZXBCd1lHaXo1U1Bha1BWbjZNdldqZmNYZVFzWGVmYzdVZkppVklvWURvQzY2?=
 =?utf-8?B?NXBjbWV5T29LTDNZZVRJOEhaY25lL2V4ZGJjajA4U0pFbjh0WnRsbHVpOFRv?=
 =?utf-8?B?ZG0zUEZCalp1TzZPVWMwSWp6UFFxQTBtdUJhSUtJazZBU25INmVjZ3ZLVW91?=
 =?utf-8?B?bStSaDFwcGdHVE50ckVCNVFoNHlqMjlyOUZUVkNVRGxCaXY0V0p1ajNsbi9s?=
 =?utf-8?B?TytpNkhEd28vakFXTytnektJNEpURGQxYnFJU3o4K1dwOG10SjNrMy9CNTBD?=
 =?utf-8?B?SVJ0bjZRNVZjNnlrdUJ6TGVzU0FTVnhXTDV3SlB1dkhKSE5NVW5RdTZtcmJh?=
 =?utf-8?B?WUoyR3UzdHJCUWNYajZ1Rmgra3hXUE5Bb2NMaTJHd1g3VlZxZnllZGJnY3l4?=
 =?utf-8?B?d0N3b1ZocmxHZGdCanNLODVVY2xJc2RDNFYzekFHSWhxRWlUMDc0SkhRNHZp?=
 =?utf-8?B?UGlzYzlaVDNqTlRQS3BEUnM5bU56Rzg4Z09KOE1OelNqdHd0M2w2NkVtTVkw?=
 =?utf-8?B?bFpveXF0RmM2cHkrbm9zTVVnVHltOHMzRThSd0JkWXNxeGZqbmxEbW5FdU92?=
 =?utf-8?B?WDhYWjg4dEc5R2Z3a3djakpIcUFLQnZQY0Z1Wmg5cHhxRnpDaGpWRW9RM0M2?=
 =?utf-8?B?bzRoSWQ0SzUxQk1CQ3dKTXpSNzBiRitUWEVrSHI5UWNtaGxlWHpHWXBMd1pV?=
 =?utf-8?B?SWZJNUxCT0trdWJSUmNsdzdyRWpENmdlTjAyMTFDamRBdTk3QTRsQ3VMWTYz?=
 =?utf-8?B?VjN1OXZKSlFRRHhoWll3NVJMN0RyZjA2cktoRFpBWXcweERNdkRrK1lkbnE5?=
 =?utf-8?B?M0JCMnBUV1ZucXUxNDU4alZBWHNrUUo5bkMvYnJ6blhDZERTUndZeEt2MS9k?=
 =?utf-8?B?S2pzMnlNS1RvUE44TnJmSGVUS1FwZHNxb2FqUkhNeDRleVRIRVNNOUVka3F2?=
 =?utf-8?B?TDlyQUsrWjNrZjBhVngrTXBwOUE5TVBzYzRMdVZIMWlqNEErYmdBKzlCNVVl?=
 =?utf-8?B?MTl4VDY2MmRoRFF0R3pCOWdpYUg3bklxaXY5Zk5mQlNHbjdVUW9ZdElNYVBS?=
 =?utf-8?B?Tzc0UkNPVDNkaTA2STFnWGVNR1d2NlgrYWtyQUwzQ2IrQzRMNmpzSXhKMVRG?=
 =?utf-8?Q?RLhV3+bwAaSsw2Gq9i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e1aaaf-3cb9-45e4-e7f6-08deed88fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 15:49:30.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiGDUHwIPmgUr4EwLqAPl6v/JyVJcKJ+aOCVRTMyBii5hK6FteKJaA9jA8zzx2t5K6eEpRGUo8nj+UD4xlNJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

UHVibGljDQoNCkhpIEtyenlzenRvZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAyOSwgMjAyNiAzOjI0IFBNDQo+IFRvOiBNdXNoYW0sIFNhaSBLcmlzaG5h
IDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT47DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiBtYW5pQGtlcm5lbC5vcmc7IHJv
YmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBjYXNzZWxAa2VybmVsLm9yZw0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwNCj4gQmhhcmF0
IEt1bWFyIDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBIYXZhbGlnZSwgVGhpcHBlc3dh
bXkNCj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+OyBTYW53YWwsIFByYW5hdg0KPiA8
UHJhbmF2LnNhbndhbEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHQt
YmluZGluZ3M6IHBjaTogQWRkIENQTTYgc3VwcG9ydCB0byBBTUQgTURCDQo+IFBDSWUgYmluZGlu
Zw0KPg0KPiBPbiAyOC8wNy8yMDI2IDIyOjIwLCBTYWkgS3Jpc2huYSBNdXNoYW0gd3JvdGU6DQo+
ID4gVGhlIEFNRCBDUE02IFBDSWUgY29udHJvbGxlciBpcyBiYXNlZCBvbiB0aGUgU3lub3BzeXMg
RGVzaWduV2FyZSBQQ0llDQo+IElQLg0KPiA+IEFkZCAiaW50ciIgdG8gc25wcyxkdy1wY2llLnlh
bWwgdmVuZG9yLXNwZWNpZmljIHJlZy1uYW1lcyBmb3IgdGhlDQo+ID4gcGVyLWNvbnRyb2xsZXIg
aW50ZXJydXB0IHJlZ2lzdGVyIHJlZ2lvbiB1c2VkIGJ5IENQTTYuDQo+ID4NCj4gPiBVcGRhdGUg
YW1kLHZlcnNhbDItbWRiLWhvc3QueWFtbCB3aXRoIHNlcGFyYXRlIHJlZ2lzdGVyIGRlZmluaXRp
b25zOg0KPiA+IC0gTURCNTogNCByZWdpb25zIChzbGNyLCBjb25maWcsIGRiaSwgYXR1KQ0KPiA+
IC0gQ1BNNjogNSByZWdpb25zIChzbGNyLCBjb25maWcsIGRiaSwgYXR1LCBpbnRyKQ0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgTXVzaGFtIDxzYWkua3Jpc2huYS5tdXNoYW1A
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gVXBkYXRlIHRoZSBD
UE02IGRldmljZSB0cmVlIGJpbmRpbmcgYW5kIGV4YW1wbGUuDQo+ID4NCj4gPiB2MSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MDIxODAwMDYuNDg2MjI5LTItDQo+IHNhaS5rcmlz
aG5hLm11c2hhbUBhbWQuY29tLw0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGNpL2FtZCx2
ZXJzYWwyLW1kYi1ob3N0LnlhbWwgICAgfCAxMTEgKysrKysrKysrKysrKysrKy0tDQo+ID4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9zbnBzLGR3LXBjaWUueWFtbCB8ICAgMiArDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
YW1kLHZlcnNhbDItbWRiLQ0KPiBob3N0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL2FtZCx2ZXJzYWwyLW1kYi0NCj4gaG9zdC55YW1sDQo+ID4gaW5kZXggNDA2
YzE1ZTFkZWUxLi5kMjJkZTI0YjQxY2EgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9hbWQsdmVyc2FsMi1tZGItaG9zdC55YW1sDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9hbWQsdmVyc2FsMi1tZGIt
aG9zdC55YW1sDQo+ID4gQEAgLTEyLDI0ICsxMiw2NSBAQCBtYWludGFpbmVyczoNCj4gPiAgYWxs
T2Y6DQo+ID4gICAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvcGNpLWhvc3QtYnJpZGdlLnlhbWwjDQo+
ID4gICAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvc25wcyxkdy1wY2llLnlhbWwjDQo+ID4gKyAgLSBp
ZjoNCj4NCj4gTW92ZSBlbnRpcmUgYWxsT2YgdG8gdGhlIGVuZCwgYWZ0ZXIgcmVxdWlyZWQ6IGJs
b2NrLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsIEkgd2lsbCBtb3ZlIGVudGlyZSBhbGxPZiBi
bG9jayBhZnRlciByZXF1aXJlZC4NCg0KPg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAg
ICAgICAgY29uc3Q6IGFtZCx2ZXJzYWwyLW1kYi1ob3N0DQo+ID4gKyAgICB0aGVuOg0KPiA+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIHJlZzoNCj4gPiArICAgICAgICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBNREIgU3lzdGVtIExldmVsIENvbnRy
b2wgYW5kIFN0YXR1cyBSZWdpc3RlciAoU0xDUikNCj4gQmFzZQ0KPiA+ICsgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBjb25maWd1cmF0aW9uIHJlZ2lvbg0KPiA+ICsgICAgICAgICAgICAtIGRl
c2NyaXB0aW9uOiBkYXRhIGJ1cyBpbnRlcmZhY2UNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlw
dGlvbjogYWRkcmVzcyB0cmFuc2xhdGlvbiB1bml0IHJlZ2lzdGVyDQo+ID4gKyAgICAgICAgcmVn
LW5hbWVzOg0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6
IHNsY3INCj4gPiArICAgICAgICAgICAgLSBjb25zdDogY29uZmlnDQo+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IGRiaQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBhdHUNCj4gPiArICAtIGlm
Og0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4g
KyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAg
ICAgICAgICAtIGFtZCx2ZXJzYWwyLWNwbTYtaG9zdA0KPiA+ICsgICAgICAgICAgICAgIC0gYW1k
LHZlcnNhbDItY3BtNi1ob3N0MQ0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcHJvcGVydGll
czoNCj4gPiArICAgICAgICByZWc6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogNA0KPiA+ICsg
ICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IE1EQiBTeXN0
ZW0gTGV2ZWwgQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVyIChTTENSKQ0KPiBCYXNlDQo+ID4g
KyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IGNvbmZpZ3VyYXRpb24gcmVnaW9uDQo+ID4gKyAg
ICAgICAgICAgIC0gZGVzY3JpcHRpb246IGRhdGEgYnVzIGludGVyZmFjZQ0KPiA+ICsgICAgICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBhZGRyZXNzIHRyYW5zbGF0aW9uIHVuaXQgcmVnaXN0ZXINCj4g
PiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ1BNNiBQQ0llIGVycm9yIGFuZCBldmVudCBp
bnRlcnJ1cHQgcmVnaXN0ZXJzDQo+ID4gKyAgICAgICAgcmVnLW5hbWVzOg0KPiA+ICsgICAgICAg
ICAgbWluSXRlbXM6IDQNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAt
IGNvbnN0OiBzbGNyDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGNvbmZpZw0KPiA+ICsgICAg
ICAgICAgICAtIGNvbnN0OiBkYmkNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogYXR1DQo+ID4g
KyAgICAgICAgICAgIC0gY29uc3Q6IGludHINCj4gPg0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAg
IGNvbXBhdGlibGU6DQo+ID4gLSAgICBjb25zdDogYW1kLHZlcnNhbDItbWRiLWhvc3QNCj4gPiAr
ICAgIGVudW06DQo+ID4gKyAgICAgIC0gYW1kLHZlcnNhbDItbWRiLWhvc3QNCj4gPiArICAgICAg
LSBhbWQsdmVyc2FsMi1jcG02LWhvc3QNCj4gPiArICAgICAgLSBhbWQsdmVyc2FsMi1jcG02LWhv
c3QxDQo+ID4NCj4gPiAgICByZWc6DQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBkZXNj
cmlwdGlvbjogTURCIFN5c3RlbSBMZXZlbCBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXIgKFNM
Q1IpIEJhc2UNCj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogY29uZmlndXJhdGlvbiByZWdpb24N
Cj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogZGF0YSBidXMgaW50ZXJmYWNlDQo+ID4gLSAgICAg
IC0gZGVzY3JpcHRpb246IGFkZHJlc3MgdHJhbnNsYXRpb24gdW5pdCByZWdpc3Rlcg0KPiA+ICsg
ICAgbWluSXRlbXM6IDQNCj4gPiArICAgIG1heEl0ZW1zOiA1DQo+ID4NCj4gPiAgICByZWctbmFt
ZXM6DQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBjb25zdDogc2xjcg0KPiA+IC0gICAg
ICAtIGNvbnN0OiBjb25maWcNCj4gPiAtICAgICAgLSBjb25zdDogZGJpDQo+ID4gLSAgICAgIC0g
Y29uc3Q6IGF0dQ0KPg0KPiBMZWF2ZSB0aGUgbGlzdCBhbmQgZXh0ZW5kIGl0Lg0KDQpUaGFua3Ms
IEkgd2lsbCBleHRlbmQgdGhlIHJlZyBhbmQgcmVnLW5hbWVzLg0KDQo+DQo+ID4gKyAgICBtaW5J
dGVtczogNA0KPg0KPiBZb3UgbmVlZCBvbmx5IHRoaXMuDQo+DQo+ID4gKyAgICBtYXhJdGVtczog
NQ0KPiA+DQo+ID4gICAgcmFuZ2VzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDINCj4gPiBAQCAtMTQx
LDMgKzE4Miw1MSBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICAg
ICB9Ow0KPiA+ICAgICAgfTsNCj4gPiArDQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICsNCj4gPiArICAgIHNvYyB7
DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUt
Y2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgcGNpZUBmY2RkMDAwMCB7DQo+ID4gKyAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiYW1kLHZlcnNhbDItY3BtNi1ob3MNCj4NCj4gWW91IGRvIG5vdCBu
ZWVkIG5ldyBleGFtcGxlIGZvciBvbmUgbmV3IHByb3BlcnR5Lg0KDQpTdXJlLCBJIHdpbGwgcmVt
b3ZlIHRoaXMgbmV3IGV4YW1wbGUuDQoNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg==
