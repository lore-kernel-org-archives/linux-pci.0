Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B3429CE8;
	Fri, 24 Jul 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891739; cv=fail; b=TzL85+SJ2ES4ofVzIsbqBRN86Oqt0+v3r8nUYZxxbgFqHTBh1XtWb4jbRlDyqEk8CyGNi9phxJzCleDiwWJ/E+xarN092QSUOVWiUNW2bBzWBKYSv8z6tphBTPwrJyrvXdk3gfqKFbpq5AxwY4CcV5tyyckeyJb0rmoojrJtthw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891739; c=relaxed/simple;
	bh=61jKWfJ+f4C15j0psDJwXXjBucJP3xY0AM1PIvOVUxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0kXT25pRXqW0/ajwQLSITZz9IhpzLgesAav8wSqi+I5bV/yY7qBMugilgzG1XRk/J9D8WlYqVBhPrSt8SG9X081fHRdRLrEuvydqDkdBDB3Epbz3PaNOT79d3rnGkcMdJa7zayjP0BG5UmEzjOSk55UVlebEp0VohqcP+n+Tno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=dIi9j+RM; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="dIi9j+RM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdluC9RjZo7Wjd/Xw3ky064EqRF4yOUScyNKAIanPBindWmy1CYyU8ZPriRfjQsK26myYs/ZDE2ErGuEtedyoEtsCI9yxNXzBHUneo0gBvdp+3TlKrh4jtaseM6SOkhqGQfmRi6VFaFNGOUIE42n3x8vxWDIPVGEd+NNadFIbZ2kRzcGhTxOi/FaARLbEvPeJ91x/CeQwIrLBamBV5mFzb/K7ESZksy0kbvjXwLgggwDseoYccg5zJKjGiI5cMJoE6EUOtIXXZgLR4W76eJDq8gAUzfX4I/rCXee2gzuHDfHr5+iu4NqB34zRncx85v2Cq9Ap+YY5PuWQLDZc+nMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61jKWfJ+f4C15j0psDJwXXjBucJP3xY0AM1PIvOVUxA=;
 b=QkXC1PlcDJwcaPqEPgy3PLlaKZLg8CcvRwGIEF8xPkpK2i8VX8IshzSRJrUsa4fiSgdvRqGWj/TcLLLxwZ6Ld87ytsQA6r9vhzCumPfow/lLxY6iZCZ93o3YlAEXjk0phfcw2SoQc0Kjw6/XUT86qVsM9cU2I//5XdcUCbgxgVMabYdNzlrkDUaaATNdO6jk7oC5lQf8Dxv6kyL6Erf9ufvzTglimjQOhgRCI5We80tcif/8fveJXQIzOdnAT2OEdoPSL0Tl2xl+VZBrcN6KnqvNrinUCaINpdJBuzb9xecSRg3yyw/bZuzJwWMg1jWb5zsMCLTO09YsegTdjDV1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61jKWfJ+f4C15j0psDJwXXjBucJP3xY0AM1PIvOVUxA=;
 b=dIi9j+RMjrVZXJpH2EHkXnGm3JX5oA7g4vL2hhqxSjMBWI3bBVr5pBMge40tuzeSDzAUNEmT/6LKWaMvAEvEL5RWMdPhzrWaVSpmcq5aVTA9l7BAxSVgALVHci5YcHGmTMl7TG9/QZBWD4LP3w51wCsXh7twfO8pmShlLrHSIHOo2Ok35QbiOQBvyOCOe8H9WWYswZo9OQYS17QrHmNr9w7vt2qE/9nTbgduhCZIvHqCnwXQnoWZ61V97tDNqcbYgEhrAd1tCf8Kp3pmcyxDQHQQ0pK3upRfGEapc3Qn3nV+CoLid/jha6SpSpxW0wTxhFrXnfkmz17hbj/W3BWWaA==
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com (2603:1096:604:43c::6)
 by TYCPR01MB8471.jpnprd01.prod.outlook.com (2603:1096:400:15d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:15:32 +0000
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6]) by OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6%7]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:15:32 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] ACPI: PCI: misleading _OSC failure message when _OSC
 is absent
Thread-Topic: [REGRESSION] ACPI: PCI: misleading _OSC failure message when
 _OSC is absent
Thread-Index: AQHdFeQMAS/v/uLN7UirAHJi05upjbZx5SaAgAqqigA=
Date: Fri, 24 Jul 2026 11:15:31 +0000
Message-ID: <03e9f950-4791-4c77-a961-204398255adb@nec.com>
References: <d0be949d-0e21-472e-a44b-cedb1dd8695d@nec.com>
 <CAJZ5v0iacu-FW04zgTO5WDvjB4BgRvfhE9hsGskgOLGHrNwUSg@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0iacu-FW04zgTO5WDvjB4BgRvfhE9hsGskgOLGHrNwUSg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB17384:EE_|TYCPR01MB8471:EE_
x-ms-office365-filtering-correlation-id: b2c656d4-ac8b-4c89-544c-08dee974e02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0i6cRoX6+3DLx900CODgCrh0MwOJ+Qkb+K+rsQkd884fXU/9rjiw456f6rGzIlNgV5+OJm4KQ1YwjvbDWR0EI/3+yHN+stIwf3ii3YDync2ErkvviV9/BhCTP2lxYGhLPuR3vuZpwx6nUVjsxSoTSaAwIx4gUO0mNtxCDBB/xs+jc41X99oAGfD2lTewud9ftzhcIS5W7nTygnd0forGyQo2wIkRdU+6fo51kV0dym8N/WN6JhLYyEWIGs4OS+Mk+VZ8mfpE2odndJoz9FtVbUttaWBHSgtVbkZecF8qSMFPEmPTieKZumS8iwrWhxfczGY6BmkfOS1YeBG/utucolsqNQ6ktVTaltXO/Xf5f5Bs8j7JsftmHdbpelYieOE62ZgP27PynwtgnQ8ax3QlO2eMqyvJi44d50iAm6/I7a+PDr1V4CD7tx0c6S+53waSYJhmACs9AON5dePX1h8FUdT99ZReSQZ9PWiTgDIFmE1QuCbHes8FQroeiTy4/2lr53GpchxzrxpRjGPd/p45M9prEVls8GsMqcZLz9qKwrQDP1Vt7iraMjBTeIWcnxzorjout9Q5L6tr2f6GrqpGt0y+axYuWqCTanXz/AvvKiY2AjqGzU1D6ZgIjbdKJM6IlK6OR9GA/8svWP03stzguV/hd8jMDqXU6kOUtxPFnagTTBo9LcwICrG9X79a/Eu3MmM/B/EwyktOA9czNRttshXa2dywr6kibFhEsyY5uYU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB17384.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yjh1aFBYYlp5YXVZQjd1eDRFaXllTHBNOVBLUzJUQlNQK2tBSFhCUisvUUdM?=
 =?utf-8?B?WENDdWcrYStFVHc2bHBuODROYW9JR3huUkVZYk5pK1BTUDE4ZlFybHdla1dF?=
 =?utf-8?B?L3A4a3UrYjRrZC9adUsrSWRBSm5CTksxbjNLMi92UC91NUZkZW9hYlhuZUQx?=
 =?utf-8?B?ZWFNV05IaElhbERnM0FUOS82czk3dHE1amFJdERJR2g1MXJ4YWdtQ0ErRzBr?=
 =?utf-8?B?cEhXTERFanFibHZzYW12aTlSMC9aTXB1VVFSbzI1WHJTVC85Z1Ztc2NzdlRu?=
 =?utf-8?B?Z3BHYkNxYmlkOFJVcTc0d2JKYXZFemE5NWk2WDJqY1R3aVFoSEdtT0xNaFdl?=
 =?utf-8?B?VjZoYTh6N2hBRWFPZm94bkx5VDNPODhrZGc5MFdhVmhGMm1hWDY2cVBJS2pB?=
 =?utf-8?B?cHQyYUk1dEJIQVRyM0Y2TmNBbDRjUEcxQkloZnptUGFHSE5pejM0TXNoNGh6?=
 =?utf-8?B?QlBrYVUvQkVza05CVU8vMG9sR1dVdnVIVFdSL1JNaGZVQTlNZVpuRmVMbGtF?=
 =?utf-8?B?aXU4YlZRZ3grV0hRbktlQUxSd3VhZmZmS3AxL1RHRG1aVVVuY2hVQTgwdXVW?=
 =?utf-8?B?a2RmR3VqN0x5eEN1cDArWDN3T2RKWTF6ZWVoajlTQWJ5Um9mcXY5V1lnMGow?=
 =?utf-8?B?WTkxSHZhdEtQeFFPVm1WOHhwdmsrVGNqdG9mME4rdUREb0J0elFWOGVnaDBw?=
 =?utf-8?B?ZWlsVDBnRkVYcW1LN0QxZmJNUXZEQ0ZsazcwcWlvTnY2VmdIL3J4KzNvaWk5?=
 =?utf-8?B?YkhmWHNhT2huMEg1ZjhZSXU0ZWwvZE1MUERrZHE5N09mZHF4N0toUytUYkxt?=
 =?utf-8?B?aGxIKy9WbURFdzl1OW5FMEVxWXBCUCtpUDMrTmZCMmtSdmYzS044bHVVeHZB?=
 =?utf-8?B?MzZJWVl1WktTcjJHOEVOU0l3MHFoVTdZeXR1RDc2U0hkaHFKdmVSUFk1Qi96?=
 =?utf-8?B?MEhVMlpjbExQNWpzMVhHUXJhWGpRV00wcmJyb2dLdEZpTUZmYVJvTmtaMjZI?=
 =?utf-8?B?aDJybm9QdHJVMW9MQ0c1YnhsL2U2TXNMdFVMaGR2U0J6clBWM1JSQ3ZBaVZB?=
 =?utf-8?B?TzdUUmhQWEUvYU1jUHlxbGtKYzkxdFlYbWZXSnhjQWFhWUUzcXZnUUdKYy9Z?=
 =?utf-8?B?UUZmVXE1RkpzNU52RU1VemlnQ2JzbXI1eFFTdXBtUkQxSmVGOWtUQnFiQnY5?=
 =?utf-8?B?aElOMEh0T0ZBVnVuUUx2TE5NMXBEMVY3aHVhU01iYUExUVJLN0RyelBUR0RT?=
 =?utf-8?B?c3UzVi9LTGc2b2JTN3ZYanpuM0I0VE1rNGdPblQzWlpkeEVNQTd0L1RESFpT?=
 =?utf-8?B?bEtjUFBJNnBEWitOZUFIOW9aRDFvb3VrUjVUYktJU282QUxPY1JkaU1Iem9Z?=
 =?utf-8?B?US9FTnRkWXVUS0xoMHFSdVEzWkU5cDNQam1Kb25IZWovTjhoS2JLTTdRWExJ?=
 =?utf-8?B?ZXFTMlV4YUw4RTdIeklOSEU0VnRIZ3k5Qk82WEFqaEtob1ZOYjR1cy9wMUxq?=
 =?utf-8?B?L3hURXlERFR4RVNSNnA5ZnQ5dzdyUm9Rdi8raTAwQXIzOEZPSkpxOEpoaktQ?=
 =?utf-8?B?MjRQZDRxdjN4WHM1MUlPOVkrbXVwUUhGRXFCVThzWXc4cyt3dVJnWHNYeVN0?=
 =?utf-8?B?M0p3STluZVZkbHJaS2c2dkRQMnlLaVI3REhxcjlTSFZpbGxvTUZHOGVkOEV4?=
 =?utf-8?B?SUhDaWtzSWQweGRySTkrUGd1dy8rNjF5YkxhSHQvVitsV2FZU2FNbXdob2x6?=
 =?utf-8?B?VXlGcmo0cHFUaVpSRG1sQ0hoT1RLNzdreEcyQ2JIM3Q0Szh6RWdNeEE4d0d3?=
 =?utf-8?B?Tkc3Zmc3WldOeWdLNUpCT2hRcHNzSjk1UmowZ01TeWFaSFA0Y1ZSSjZEdlFa?=
 =?utf-8?B?Qkc0QXRBUTBsTnM5Ry8yN1llN2J1Yytlb2lHdGRaTUhpZUlSQ1BxaHpiclJG?=
 =?utf-8?B?ZGFyZXRZUXlzOWdXaXU3bkpMWjU4T1Rwam15VHJUdXFRQXI2eVhmMjIyeDAy?=
 =?utf-8?B?bzgrMHVlZE9OMHhiUnMyTVdRanNDZ2xVcS9YRDZWYnIzOUVwMDg5ZmJ5YnRi?=
 =?utf-8?B?S05pVmJxRkhDZ1h5QkN0Z3hrVHJ5RGc0anlJcFh3dXdLRVBYS1hac2hZS0I5?=
 =?utf-8?B?RElEMVBOdXlIOFJVakNya21NTUoxSUhZRVlaeDZPNmR1aHQzMkpsQ0JwbkNR?=
 =?utf-8?B?eWFLUkNaaWM3N1o1K0g3ckVJL2JKRmJvZzNKcHhHMTNrY0VxcXk4R2xvbWRl?=
 =?utf-8?B?RDl1RkJwYmY0VU5id0t4U1F6aWVueXFPQzVUZktCMHJGcnJXQWhrUzI5bHlk?=
 =?utf-8?B?R0kwRGZUakw0T0dXb1NSeGFyK1lPYnptQ05pcFc0TURvQmE3MVRhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6FB5585B922124AACCE1D9FC3972ED5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB17384.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c656d4-ac8b-4c89-544c-08dee974e02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 11:15:31.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifO6wSXsSGWTDYwrGH12rjPGbU4EOXIyd/fcaySVGGUkUJV3mZ/cr52gDRkiwA6FjVNXq3TUxQc4y4NUyloE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8471

SGVsbG8sDQoNCk9uIDIwMjYvMDcvMTggMToyMiwgUmFmYWVsIEouIFd5c29ja2kgKEludGVsKSB3
cm90ZToNCj4gSGksDQo+IA0KPiBPbiBGcmksIEp1bCAxNywgMjAyNiBhdCAyOjAx4oCvUE0gS09O
RE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnykNCj4gPGthenVtYS1rb25kb0BuZWMuY29tPiB3cm90
ZToNCj4+DQo+PiBIZWxsbywNCj4+DQo+PiBBZnRlciA3ZDcwM2RmN2Y0ZjUgKCJBQ1BJOiBidXM6
IFNwbGl0IF9PU0MgZXZhbHVhdGlvbiBvdXQgb2YgYWNwaV9ydW5fb3NjKCkiKSwNCj4+IEFFX05P
VF9GT1VORCBmcm9tIGFjcGlfZXZhbHVhdGVfb2JqZWN0KCkgaXMgaGFuZGxlZCBhcyBBRV9FUlJP
UiBpbg0KPj4gbmVnb3RpYXRlX29zX2NvbnRyb2woKS4NCj4+DQo+PiBJIGhhdmVuJ3QgeWV0IG9i
c2VydmVkIGFueSBmdW5jdGlvbmFsIGlzc3VlIHdpdGggdGhpcyBjaGFuZ2UsDQo+PiBidXQgSSBz
dGFydGVkIHNlZWluZyB0aGUgZm9sbG93aW5nIG1pc2xlYWRpbmcgbWVzc2FnZXMgb24gbXkgSW50
ZWwgc2VydmVyczoNCj4+DQo+PiAgICAga2VybmVsOiBBQ1BJOiBFbmFibGVkIDIgR1BFcyBpbiBi
bG9jayAwMCB0byA3Rg0KPj4gICAgIGtlcm5lbDogQUNQSTogUENJIFJvb3QgQnJpZGdlIFtVTkMw
XSAoZG9tYWluIDAwMDAgW2J1cyBmZV0pDQo+PiAgICAga2VybmVsOiBhY3BpIFBOUDBBMDM6MDA6
IF9PU0M6IE9TIHN1cHBvcnRzIFtFeHRlbmRlZENvbmZpZyBBU1BNIENsb2NrUE0gU2VnbWVudHMg
TVNJIEVEUiBIUFgtVHlwZTNdDQo+PiAgICsga2VybmVsOiBhY3BpIFBOUDBBMDM6MDA6IF9PU0M6
IE9TIHJlcXVlc3RlZCBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FIEFFUiBQQ0llQ2FwYWJp
bGl0eSBMVFIgRFBDXQ0KPj4gICArIGtlcm5lbDogYWNwaSBQTlAwQTAzOjAwOiBfT1NDOiBwbGF0
Zm9ybSB3aWxsaW5nIHRvIGdyYW50IFtQQ0llSG90cGx1ZyBTSFBDSG90cGx1ZyBQTUUgQUVSIFBD
SWVDYXBhYmlsaXR5IExUUiBEUENdDQo+PiAgICsga2VybmVsOiBhY3BpIFBOUDBBMDM6MDA6IF9P
U0M6IHBsYXRmb3JtIHJldGFpbnMgY29udHJvbCBvZiBQQ0llIGZlYXR1cmVzIChBRV9FUlJPUikN
Cj4+ICAgICBrZXJuZWw6IFBDSSBob3N0IGJyaWRnZSB0byBidXMgMDAwMDpmZQ0KPj4NCj4+IEJl
Zm9yZSB0aGUgY29tbWl0LCB0aGUgbG9nIHdhczoNCj4+DQo+PiAgICAga2VybmVsOiBBQ1BJOiBF
bmFibGVkIDIgR1BFcyBpbiBibG9jayAwMCB0byA3Rg0KPj4gICAgIGtlcm5lbDogQUNQSTogUENJ
IFJvb3QgQnJpZGdlIFtVTkMwXSAoZG9tYWluIDAwMDAgW2J1cyBmZV0pDQo+PiAgICAga2VybmVs
OiBhY3BpIFBOUDBBMDM6MDA6IF9PU0M6IE9TIHN1cHBvcnRzIFtFeHRlbmRlZENvbmZpZyBBU1BN
IENsb2NrUE0gU2VnbWVudHMgTVNJIEVEUiBIUFgtVHlwZTNdDQo+PiAgICAga2VybmVsOiBQQ0kg
aG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6ZmUNCj4+DQo+PiAiVU5DMCIgaXMgYW4gdW5jb3JlIHJv
b3QgYnJpZGdlIGFuZCBkb2VzIG5vdCBkZWZpbmUgYW4gX09TQyBtZXRob2QgaW4gdGhlIEFDUEkN
Cj4+IG5hbWVzcGFjZSBvbiBteSBzeXN0ZW1zLg0KPj4NCj4+IFByZXZpb3VzbHksIHdoZW4gYWNw
aV9ldmFsdWF0ZV9vYmplY3QoKSB3YXMgY2FsbGVkIGZvciBVTkMwLl9PU0MsIGl0IHJldHVybmVk
DQo+PiBBRV9OT1RfRk9VTkQsIGFuZCB0aGF0IHN0YXR1cyB3YXMgcHJvcGFnYXRlZCB0byBuZWdv
dGlhdGVfb3NfY29udHJvbCgpLg0KPj4NCj4+IE5vdywgaXQgYXBwZWFycyB0aGF0IGFjcGlfZXZh
bF9vc2MoKS9hY3BpX3J1bl9vc2MoKSBubyBsb25nZXIgcHJlc2VydmUgdGhlDQo+PiBkaXN0aW5j
dGlvbiBiZXR3ZWVuIEFFX05PVF9GT1VORCBhbmQgb3RoZXIgZXJyb3JzIGZyb20gYWNwaV9ldmFs
dWF0ZV9vYmplY3QoKSwNCj4+IHNvIG5lZ290aWF0ZV9vc19jb250cm9sKCkgbm8gbG9uZ2VyIHJl
Y2VpdmVzIEFFX05PVF9GT1VORCBpbiB0aGlzIGNhc2UuDQo+Pg0KPj4gVGhlIGNhbGwgY2hhaW4g
bG9va3MgbGlrZSB0aGlzIG9uIG15IHN5c3RlbToNCj4+DQo+PiBuZWdvdGlhdGVfb3NfY29udHJv
bCgpDQo+PiAgIGFjcGlfcGNpX29zY19jb250cm9sX3NldCgpICAgICAgIFtyZXR2YWwgPSBBRV9F
UlJPUiAgICBdDQo+PiAgICAgYWNwaV9wY2lfcXVlcnlfb3NjICgpICAgICAgICAgIFtyZXR2YWwg
PSBBRV9FUlJPUiAgICBdDQo+PiAgICAgICBhY3BpX3BjaV9ydW5fb3NjKCkgICAgICAgICAgIFty
ZXR2YWwgPSBBRV9FUlJPUiAgICBdDQo+PiAgICAgICAgIGFjcGlfcnVuX29zYygpICAgICAgICAg
ICAgIFtyZXR2YWwgPSBBRV9FUlJPUiAgICBdDQo+PiAgICAgICAgICAgYWNwaV9ldmFsX29zYygp
ICAgICAgICAgIFtyZXR2YWwgPSAtRU5PREFUQSAgICBdDQo+PiAgICAgICAgICAgICBhY3BpX2V2
YWx1YXRlX29iamVjdCgpIFtyZXR2YWwgPSBBRV9OT1RfRk9VTkRdDQo+Pg0KPj4gQXMgYSByZXN1
bHQsIG5lZ290aWF0ZV9vc19jb250cm9sKCkgbG9ncyBtZXNzYWdlcyBhcyBpZiB0aGUgT1MgaGFk
IG5lZ290aWF0ZWQNCj4+IHdpdGggdGhlIHBsYXRmb3JtIHZpYSBfT1NDLCBldmVuIHRob3VnaCBf
T1NDIGlzIGFic2VudCBhbmQgbm8gc3VjaCBuZWdvdGlhdGlvbg0KPj4gYWN0dWFsbHkgaGFwcGVu
cy4NCj4gDQo+IEZvcnR1bmF0ZWx5IHRob3VnaCB0aGlzIG9ubHkgYWZmZWN0cyB0aGUgcHJpbnRp
bmcgb2YgbWVzc2FnZXMgYW5kIG9ubHkNCj4gaW4gdGhlIG5vbi1QQ0llIGNhc2UuDQo+IA0KPj4g
SSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggdGhlIEFDUEkvUENJIGNvZGUsIHNvIEkgbWF5IGJl
IG1pc3Npbmcgc29tZQ0KPj4gY29udGV4dC4gSG93ZXZlciwgaWYgbXkgdW5kZXJzdGFuZGluZyBp
cyBjb3JyZWN0LCB3b3VsZCBwcmVzZXJ2aW5nDQo+PiBBRV9OT1RfRk9VTkQgaGVyZSAoZm9yIGV4
YW1wbGUsIGhhdmluZyBhY3BpX2V2YWxfb3NjKCkvYWNwaV9ydW5fb3NjKCkgcmV0dXJuDQo+PiB0
aGUgZXJyb3IgYXMtaXMpIGJlIHRoZSByaWdodCBkaXJlY3Rpb24sIG9yIHNob3VsZCB0aGUgbWVz
c2FnZSBoYW5kbGluZyBiZQ0KPj4gYWRqdXN0ZWQgaW5zdGVhZD8NCj4+DQo+PiBJZiB0aGVyZSBp
cyBhIHByZWZlcnJlZCBkaXJlY3Rpb24gZm9yIGZpeGluZyB0aGlzLCBJIHdvdWxkIGJlIGhhcHB5
IHRvIHRyeQ0KPj4gcHV0dGluZyB0b2dldGhlciBhIHBhdGNoIGFuZCB0ZXN0aW5nIGl0IG9uIG15
IHN5c3RlbS4NCj4gDQo+IEkgY2Fubm90IHNlbmQgeW91IGEgcHJvcGVyIHBhdGNoIEFUTSAoc29y
cnkgYWJvdXQgdGhhdCksIGJ1dCBwbGVhc2UNCj4gdHJ5IHRvIHJlcGxhY2UgdGhlDQo+IA0KPiAo
c3RhdHVzID09IEFFX05PVF9GT1VORCAmJiAhaXNfcGNpZShyb290KSkNCj4gDQo+IGNoZWNrIGlu
IG5lZ290aWF0ZV9vc19jb250cm9sKCkgd2l0aCB0aGUgZm9sbG93aW5nIG9uZToNCj4gDQo+ICgh
aXNfcGNpZShyb290KSAmJiAhYWNwaV9oYXNfbWV0aG9kKGhhbmRsZSwgIl9PU0MiKSkNCj4gDQo+
IGFuZCBzZWUgaWYgdGhhdCBoZWxwcy4NCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQpX
aXRoIHRoZSBjaGFuZ2UgeW91IHN1Z2dlc3RlZCwgdGhlIGZhaWx1cmUgbWVzc2FnZSBubyBsb25n
ZXIgYXBwZWFycy4NCklmIHRoYXQncyBva2F5IHdpdGggeW91LCBJJ2QgbGlrZSB0byBzdWJtaXQg
aXQgYXMgYSBwYXRjaC4NCg0KVGhhbmtzLA0KS2F6dW1hDQoNCj4gDQo+IFRoYW5rcyENCg==
