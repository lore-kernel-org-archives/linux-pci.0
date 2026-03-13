Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022134.outbound.protection.outlook.com [52.101.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6423504B;
	Fri, 13 Mar 2026 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368021; cv=fail; b=TOzZ0LcA5eMDLWMNN0n05zaWCqcql6przQM5uhIigCD32b6t1WaVaNirOWOr+0yV9wrmFB42hm1ytyQd1tn64X0vu8XmvMnl+1tOVoAdpYtWj2NZtXjHM/c8AbgAEM6lcF/VZS1X/i5CdFvjoL9oBVKSyPFA68a9IdI4lvmNHXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368021; c=relaxed/simple;
	bh=lSa6fAYBHW17VwLWMNog7iGkF4iz20YNUfcVT6Fhdik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A055lUTlk5MfHe1K5BJ8pigWcCF3QO+QmeNYhEoU18tBauxTd57O9V7WyN9j4LhDZ84QNg83OmwmEBZRopqIVb9n/2ug9w8aeU6M9A5eRFhvx8ldjEwKd1rsaSIk4Qll4dn0fcSnqczZOdu0PBruJOommgH5ncp6Q/SF3f93HW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycF+A4lITZFzfFMj0cnpp/TbhCY21Lom1aW6VJy1CYCeIgYmnTkngAufuh+P+gQO4uUuQRwRsjapVS+3U2v2Y/Loycc9gfyn8KE4eKBmfFnFrjA9CaTxyIig7uWMfJCs8n/wjyDKIeFylDkBG+wbzO5SnXQlhLB0gOVEChjI5DBD1sC6muoXn0a7nyDG001r9hNjHuGcuAmVhi7mPQ8EMJQ4JYDGggk0T4zTLzU9z1ggWgPnmw5coBpz37dSH3cABbnsPaieVRvnW2wJDmU9/2/hwM6oehwI5PvkaWvenmHRewe9h5B7pGtmcGiy2XN9k400DAIOxSqPNYmM34/jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSa6fAYBHW17VwLWMNog7iGkF4iz20YNUfcVT6Fhdik=;
 b=HZ0ao5T8/ZiGyOxyu+btbTCIIjuMy+LScrv87WiAG6bcJiz2DqP4f2eBEZB/WYBYr94wZ6TzSwgmdWxFa439rxoDxdDmCu9Py3pnI9FlYjWmJN3p+a1q9GyRI+Ct4GwsIthOTzoZrZOg2wsR2Nex3uaacF5OBOQ5X2c7fuOXnxP4sBEiHYh2cFdxmzO0FEiJ3TNLg9e++QpboZy5Y2bdD+tEXvOGTq12aV+ZvIrZA1ZWpU6F77L1U7OHz7FYmlA5vyURRfTnPxo/WSbeHMWAU3shV754O+7Wxxu1tGuxnayTnptPv40AiTEEqPwX7FzHfdaRQikhw4EqKBe7gtvebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by TYZPR06MB7095.apcprd06.prod.outlook.com (2603:1096:405:b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:13:33 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::f320:58f6:4dc6:b908%6]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 02:13:33 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Peter Chen
	<peter.chen@cixtech.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBQ?=
 =?utf-8?Q?CI:_update_CIX_Sky1_PCIe_Root_Complex_bindings?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogUENJOiB1cGRh?=
 =?utf-8?Q?te_CIX_Sky1_PCIe_Root_Complex_bindings?=
Thread-Index: AQHcsFqmVTyaz6drxUGpqWO9ODpvBLWnXtEAgAEy0PCAAEQjAIAC41Fg
Date: Fri, 13 Mar 2026 02:13:33 +0000
Message-ID:
 <PUZPR06MB5887416BEC3C7593AC722C0FEF45A@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20260310065338.2337761-1-gary.yang@cixtech.com>
 <20260310065338.2337761-2-gary.yang@cixtech.com>
 <841c0b46-76dc-49c2-bb74-7fc2e5a2a702@kernel.org>
 <PUZPR06MB5887D091B6CF979DFC46EECBEF47A@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <168d4af2-5a5b-4564-9e53-fed9f0c062a2@kernel.org>
In-Reply-To: <168d4af2-5a5b-4564-9e53-fed9f0c062a2@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|TYZPR06MB7095:EE_
x-ms-office365-filtering-correlation-id: 2c9b3742-e662-448d-b3a2-08de80a620c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 eO6hm44UGG/7zYMP8BrzQLOUwap1HnLrdo0Qh6i2pp308YGS1eDEYgQ5zsYAmqiHN2q4y4GA3mLAp5eywzRoDuXRVVoi9V6ytOdxMCBrXsrsI6M5kEzKeaewI41lXyhMgd0sK3x+Y6jWh4ZG1wxXJbgJqh379SxxgW+JRfDrFM7SfMW5/HzyK3vfJA40sfOPB3KFS8K15I7JnCuoXy0Mq03ZKdYgwZj9UDlo50wSh7kYuKP4dvQZSrWtOLhakx/mvpNSwAqBSy1dx3JEjwWugmnSCXw5+kmgHdaKAB41NHdWWkMgVbx/UA1wM+9MJcc9Qof3emHHxJJIh6tUzkMYg6EROnzpLruD6YHQp/7yaUiflzjD8Ki7X1lW6vuMFJp13HRLLsz/L0jmP4JJqEK0eLzgZr9T1NMFZn0V+P2QSsnHRzz67OEackrBJzTguxdRoX1GuzeqMfYQ09o6y2oo3H0MZAEGsRiGdNU0FUKyj+qFydWQ1lCu1dbU5lcFY1S4S0F58yEeKOj0I9kk2s2zouOIPmddu6c0cSc+2AKGqzG78jetXaGR3bV8mPrFS+nNZ0VXMmrmqOuC786kxzJBkriVHNnIvbjJdXDhTua3TO9ggjs/IS2TcXiF1VGw1WXtZ8POTObmWctL1RHAQi4ZckDC63ToZHOnVGOG4ZLV+Gxb4pMweKVSIvTEqe+XCfjAiYQ5GxPzZp87/+Sbxea6yLDLr22Qd/9qUdQAPV1zRJedz2DOkkYsi/D3bOF9EuxGm+d/EJpEY66VN4KOtvYvrZGkNtorSixCGql5S6tfmS4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEVHd1R2MUlVVWkydU5yT0pzR3hWbnl3aDcxZno0ZUJCRmwrVk53THZIZFZ6?=
 =?utf-8?B?M21pZ2FpZGNNbEVtMVNsOVRrYzBtc0RMSXNuZVhqbVl0Zkd3RjczN1d5UzFr?=
 =?utf-8?B?Zm1jZ0pOSlNENDdsclIwQSsvT3MwRHhPRlBIU1F6Rk5MdlZHSHZXbVE3SnlU?=
 =?utf-8?B?YUs5dDRNblByRnJPbHk5OGx5QnJYSXFTYmY3RG13UTU5b2hLbWFLTTFkeHpm?=
 =?utf-8?B?S0xIM1BHTkhzZjJ6ZjZRYTl3MVRUSXhTRTRaQldxc3BvanZNcXhHVWd2MEFp?=
 =?utf-8?B?bmhubVZMaGtpelhsNWtWb0lVd0NBTWQ4RFFhODVsM2Rjak1mZEIwMm1HNEVz?=
 =?utf-8?B?eU92QXh6MHRLSkZTd0xQRVdkZjFrT3lldlZsODcxVHBrWWMveUFBdDh1MWhh?=
 =?utf-8?B?WFRnYktqS2xtYUZGMThHYXBPQ3ZPWkE5eUV3d0hNWS83K3luM1J2V2tudWFo?=
 =?utf-8?B?cmREVEIzTlFuVStWcEdRWUdOZ1Z2dldHaDFkQ21rL2pxdWNJZHdPL0ZjMEp0?=
 =?utf-8?B?eTdUV1BISERGZUIzODB6NFgrUy9GSTBRUVFscldQZzJzVVVTOW9lZlExOEdY?=
 =?utf-8?B?RzhkQ25DVlU5SFRTVjFaUTZUeFZPNkNCRkxzSU1PTFlSMFNEbFhPamcvN0FJ?=
 =?utf-8?B?MW0wWVlyYnRPUm1JNHh5YURmT0s1dUNDSHF3dzNHUkQvWURqZ2JhS2RENDd2?=
 =?utf-8?B?Q1dPYmhDMGw4SUphcjFYdFB6ZWlkQkNXVE1UaElpSXk5NllJM0MvYnpmU2Z0?=
 =?utf-8?B?bWcwM1hFNmRoTkprUDI1ZzJmcEpheFBjSG85b0s3ZkhRRGxldUpudGh0ekRn?=
 =?utf-8?B?UCswQkp0SVY4N0hYRUhhZVNra2lONXg1Y3grUTlVVFQwc2FOWkMyVFlFZ3M1?=
 =?utf-8?B?SS9CQitBTUI2YWRtNzcwKytCeVMwcHFibUsyTER4R3pPczhQOVZFUHhrUnhr?=
 =?utf-8?B?NGRPSExERXI3RVJra0hZUFVyWEMxWTkycmRpWm56a0RCTHdXdzFJdWV0M0l1?=
 =?utf-8?B?ckgrTjVRdFVwbDhQVXZuTkpnZFhPVUJ4TjN3YmtVcXVYZnliQ2NMRDdKaU04?=
 =?utf-8?B?SkdjUHM4eUpuVkQ0cUNwTGlaQmpxcjkwVmsySDVEZFFoSFFYZ1BYakgvb0xG?=
 =?utf-8?B?TlExbXZTWnZLM0szVDBWeUxTNGg1NXFJUFUyYUJRR3lORUNGVy9zaGptbmU0?=
 =?utf-8?B?VzhjbjlTN1g4WWQ3dkRnRElETWVjdUREdnFvblAzZ0ViZUY1S3loUHo4RUdN?=
 =?utf-8?B?TE5rb1l6bFM2cUJWa2Mrc05qMVh6OTdBbHV0T3hxQXNVYXB1UXl5eFJZZU9j?=
 =?utf-8?B?ZmJlV2hldTgrNDI5cmhzcUxtUTkvcnZGWTRsNmZsdGRrOWZyQmVSTDc4bGFy?=
 =?utf-8?B?NDR4U2g3ZWJxNngxTXVnT3pQbnd0a3RoNCtYM3FrUkh2ak0zdGU2L3dwb0Y2?=
 =?utf-8?B?UTNMZUplaW9BWVlWUkJNRUNxQnoxVFZtaEhqcDRwdnZHeEJITkFGYmNtQ0Fq?=
 =?utf-8?B?NTJyaWNnS1hGdDVOSHd0OFJJSXZtTVFGbG1nZ0JGQTZsZHR6bzkrc0FoTVZm?=
 =?utf-8?B?bnYrTlY1NzZ0MTB1NFdwVU9hY2REQit4ampUR1M1SzgyVVRHREZhM0d4bVlz?=
 =?utf-8?B?NWR5QlRhNExpV1VQenQzQndhUjk1Q2VSbFgwZW1SbEM0VUdSSmlTTzFWNXJ6?=
 =?utf-8?B?c2laa3ArSzd1UjVsamk0SUs4VTUzckhIVFY3Y3pkbmZUc1l4YmNjL041SVBW?=
 =?utf-8?B?TzJMN2xsRFVUZG9Rb2dtZHdqcW16L1J0bk9scUVvY1k4VUxBWXhuczVlY0d0?=
 =?utf-8?B?MG5oMmZLUmdtQjlaZEs2QXlRODRwb3VzcGI5amdkaDdQVzl5cWZMcldCOGVE?=
 =?utf-8?B?SjYvdUg0RFF3K3pxbCtETXhTV1RYalF3T1B5N0dVTGZZY3hVMkxmOGNWaDYr?=
 =?utf-8?B?NmovanZMRHAxL3dBcmVCMVdBdUVlb2VoU3VQc3JkblNLYnVwTklqOWhpa1FE?=
 =?utf-8?B?QXRod1ZQYnB6SEhkNitIYkJZNlNKUDV0U0hMajR1TWFZNTlHMzVVczJDMEdi?=
 =?utf-8?B?dTBycEY0TU8zSzVEMmtydGtaUWx6Q2hhbjZUbG5wZE05RzVjcW9oYldjY3RR?=
 =?utf-8?B?UWdwZVZMWCs5b2prejVZZlNYQUR2ZlJrS0ZPdHY0TDdLTkpJdnoyWUhVWkpT?=
 =?utf-8?B?WUhobnM3UUh4dWlyZmNXcldqei94MDFkSGtpN2Y4YlBpM3U2dnpqcXZMQWhi?=
 =?utf-8?B?NXVkTXBhRThBSG95QlV6QWlGQnhMdTZmWFROMEw5Wm53aE1jano5aUo2a1Iw?=
 =?utf-8?B?TnBYeVNrQ2E0UWl2Y09HZndWU0ZoRFdvbWM5WXh3UFJ2U3l0SXQzUT09?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9b3742-e662-448d-b3a2-08de80a620c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 02:13:33.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCqoa7rHwg7YTFjfhBd3LSXt3oS41XCyHuA78kAmaa0In3URHBEZFE/IeerVPQtA2yg8FpSmfkGv+ahft1sa5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7095

SGkgS3J6eXN6dG9mOg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KPiBFWFRFUk5BTCBF
TUFJTA0KPiANCj4gT24gMTEvMDMvMjAyNiAwMzozMSwgR2FyeSBZYW5nIHdyb3RlOg0KPiA+IEhp
IEtyenlzenRvZjoNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cw0KPiA+DQo+ID4+
IEVYVEVSTkFMIEVNQUlMDQo+ID4+DQo+ID4+IE9uIDEwLzAzLzIwMjYgMDc6NTMsIEdhcnkgWWFu
ZyB3cm90ZToNCj4gPj4+IGFkZCBwb3dlci1kb21haW5zIGFuZCBwb3dlci1kb21haW4tbmFtZXMg
cHJvcGVydHkNCj4gPj4NCj4gPj4gV2h5PyBQbGVhc2Ugd3JpdGUgY29tcGxldGUgc2VudGVuY2Vz
IGV4cGxhaW5pbmcgd2h5IHlvdSBhcmUgZG9pbmcgdGhpcy4NCj4gPj4NCj4gPg0KPiA+IFNvcnJ5
LCBJIGRpZCBub3QgZGVzY3JpYmUgaW4gZGV0YWlsLg0KPiA+DQo+ID4gVGhlIFNreTEgUENJZSBj
b250cm9sbGVyIHNpdHMgaW4gYSBwb3dlciBkb21haW4gdGhhdCBtdXN0IGJlIGVuYWJsZWQgYmVm
b3JlDQo+IHRoZSBjb250cm9sbGVyIGNhbiBiZSBhY2Nlc3NlZC4NCj4gPiBEZXNjcmliZSB0aGUg
cG93ZXItZG9tYWlucyBwcm9wZXJ0eSBzbyB0aGF0IERUUyBmaWxlcyBjYW4gcmVmZXJlbmNlIHRo
ZQ0KPiBjb3JyZWN0IHBvd2VyIGRvbWFpbiBwcm92aWRlci4NCj4gPg0KPiA+Pj4NCj4gPj4+IFNp
Z25lZC1vZmYtYnk6IEdhcnkgWWFuZyA8Z2FyeS55YW5nQGNpeHRlY2guY29tPg0KPiA+Pj4gLS0t
DQo+ID4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NpeCxza3kxLXBjaWUtaG9zdC55
YW1sICAgICAgICAgfCA2ICsrKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1ob3N0LnlhbWwNCj4gPj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NpeCxza3kxLXBjaWUtaG9zdC55YW1s
DQo+ID4+PiBpbmRleCBiOTEwYTQyZTA4NDMuLjFkOGVlODMxMDU4OCAxMDA2NDQNCj4gPj4+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2l4LHNreTEtcGNpZS1o
b3N0LnlhbWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvY2l4LHNreTEtcGNpZS1ob3N0LnlhbWwNCj4gPj4+IEBAIC0zOCw2ICszOCwxMiBAQCBwcm9w
ZXJ0aWVzOg0KPiA+Pj4gICAgcmFuZ2VzOg0KPiA+Pj4gICAgICBtYXhJdGVtczogMw0KPiA+Pj4N
Cj4gPj4+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4+PiArICAgIG1pbkl0ZW1zOiAxDQo+ID4+PiAr
DQo+ID4+PiArICBwb3dlci1kb21haW4tbmFtZXM6DQo+ID4+PiArICAgIG1pbkl0ZW1zOiAxDQo+
ID4+DQo+ID4+IFRoZXJlIGlzIG5vIHN1Y2ggc3ludGF4LiBPcGVuIGFueSBleGlzdGluZyBiaW5k
aW5oLg0KPiA+Pg0KPiA+DQo+ID4gU29ycnksIFRoZXkgY29tZSBmcm9tDQo+ID4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS1jb21tb24ueWFtbA0K
PiANCj4gVGhlcmUgaXMgbm8gc3VjaCBzeW50YXggdGhlcmUuDQo+IA0KPiBKdXN0IG9wZW4gdGhl
IGZpbGUuDQo+IA0KDQpNYXliZSB3ZSBzZWUgaXQgZnJvbSB0aGUgZGlmZmVyZW50IHZpZXdzLiBB
bnl3YXksIGl0J3Mgbm90IGltcG9ydGFudC4NCkRvIHlvdSBhZ3JlZSB0aGlzIHNjaGVtZT8gTGlr
ZSB0aGlzOg0KICBwb3dlci1kb21haW5zOg0KICAgIG1heEl0ZW1zOiAxDQogIHBvd2VyLWRvbWFp
bi1uYW1lczoNCiAgICBtYXhJdGVtczogMQ0KDQo+IA0KPiA+DQo+ID4gRXhlY3V0ZSB0aGUgdHdv
IGNvbW1hbmRzIGJlbG93IGJlZm9yZSBzdWJtaXQgcGF0Y2ggZXZlcnkgdGltZS4NCj4gPg0KPiA+
IG1ha2UgTz0kT1VUS05MIGR0X2JpbmRpbmdfY2hlY2sNCj4gPiBtYWtlIE89JE9VVEtOTCBkdF9i
aW5kaW5nX2NoZWNrDQo+ID4gRFRfU0NIRU1BX0ZJTEVTPWNpeCxza3kxLXBjaWUtaG9zdC55YW1s
DQo+ID4NCj4gPiB3ZSBkb24ndCBmaW5kIGFueSB3YXJuaW5nIG9yIGVycm9yLiBTbyB3ZSB0aGlu
ayBhbGwgaXMgb2suDQo+IA0KPiBObywgYmVjYXVzZSB0aGVyZSBpcyBubyBzdWNoIGNvZGUgbm93
aGVyZS4gUGxlYXNlIHRha2Ugb3RoZXIgYmluZGluZ3MgYXMgYW4NCj4gZXhhbXBsZS4gWW91IG1p
c3MgaGVyZSBtYXhJdGVtcy4NCj4gDQoNCk9rLCB0aGFua3MgZm9yIHlvdXIga2luZGx5IHJlbWlu
ZC4gV2UgZ2V0IGl0Lg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb25zDQoNCkJlc3QgcmVnYXJk
cw0KR2FyeQ0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
