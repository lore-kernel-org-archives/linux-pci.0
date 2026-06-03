Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB338424F;
	Wed,  3 Jun 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451368; cv=fail; b=rG6gvS914RHB5A/9YUFLib/OCFzNogke6pwnO0+Okyk9bKdWo17viG/yhtEWdF64f+7UoXCMLQZY3+wMcI+t2KhNUeumhYM2BB/BMD7T4snsrAgMFg/1PzDp0zMYbkGUWZn4C86x6IJEZUt4EWtS/7x5GwvfNvAiefzv3IaKNgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451368; c=relaxed/simple;
	bh=ftOXKCXUMIcQYuQLLCVDFXx180wOekmK8PbssyLeLKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cODADzVPLbnVQyRh0tir9/UuTLViV5YsulOK0UND1Jl15Z9MClXJTyo8omfccYyHB2QZMNU997CSCaC+chOoW/lV5axnBU3WvIABma+kgQ17dYMPkmidNsb2xP+L1kt/BDM4LBhZpfkPCpLCesjBFfH0ghJaW+U5MkoK3F0wQoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PnBGgySx; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PnBGgySx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIu6QTvBgLKjacv4Rz+j2eSldHDdTg9yX2lLXijAX/s7YhkRZ94oGECMDa99VucuPOf8rBeHTQ6d5pkgwC3AWQEqnTgIuIBedtNgD0E8s6E3oAZhYQz0n/hevFJKLgfLJWQ3N6MpriZZk7sPxsNmbEw8ihTUnS0Fn6KxP6HpDDyJ8oCmYP5r5TbNO7q+mbIMpVWsa6lt+4Kif7x1XKFhSp7NArRARafppQIPvhHSbvtI4slcUHyqVNab7i5XasAHiE3ubg3ECVwYTESpObFuUD7V+EYlN/pcRGUgCYbpIdaYzV1fLrekSxwMtpT31RLLTLbSNsYdbxY7Isd3y1oInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftOXKCXUMIcQYuQLLCVDFXx180wOekmK8PbssyLeLKg=;
 b=KT1FEz3xf+LxNxtPsmoDieKFRe/RdGCGdVfqR+WQStTdo+6qH3X8w83FAT9u3jlR9pMmSY5DB+9tCm79GnsfEQTSJ4ofUeMh+v70VBi9e70PRGyHL/BDnt8D4mIjzwmu5njnKZs9dwYTSRfijRXfK7O+8JvijHUhz0LrNxb3cHU7WaDF+5vnVlMGQKm67S0FZ7ZS6JP0gOpilkl+B8/EVxpHO4C5yiAJgCRRzRqyM8gcOhHdPUwCewkzr9cSqq18HfNfGgVPI7HPB4FuQpOKp8GD8HS4m0lhgarYlkFk6jpw12DTzOyIGmPIU/Kh7VsXnngsvpjSmDIIg7yoBRbA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftOXKCXUMIcQYuQLLCVDFXx180wOekmK8PbssyLeLKg=;
 b=PnBGgySxq1VY5Gfq3+1XrBoAJGdY9lyTkXEUQi1/UF+xd/QOk0BWUx3NJwBi2EWQr/+FIxEjJgHbhWg0UHzMzMKRkapYK8aZf6YjfIW7dBVfsaW9dDGKj98aC3tVHPvgjDSjm4dKvl+U89n3ItlGhIiYOhijzBLxwc5kMK3aptP0ZJySQMnXqqoBgVBOKZEDtlZw355thHdWLqYC8bQ0UUycoC2ksnG8zrdQ0e0FobgxNAU0L378HjiVZ7SuO7MxcMSO5phLhPqD00GgBeo++eM+zIMOGP2tI1ZpuH1P2c2g2bwILdIgUIZYFtgNI/vd0Df60nyB2OdtvgLUVRDUgQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA3PR04MB11204.eurprd04.prod.outlook.com
 (2603:10a6:102:4aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 01:49:22 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 01:49:22 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt
 entries for intr, aer and pme
Thread-Topic: [PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt
 entries for intr, aer and pme
Thread-Index: AQHc6QSEhqG5ZDJAhUOH3PWb3JlNA7YoFGsAgAQG9HA=
Date: Wed, 3 Jun 2026 01:49:22 +0000
Message-ID:
 <GV2PR04MB120196FCE8E665010B84F541E8C132@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260521093255.61585-1-hongxing.zhu@nxp.com>
 <20260521093255.61585-2-hongxing.zhu@nxp.com>
 <20260531-benevolent-malkoha-from-wonderland-cdfafc@quoll>
In-Reply-To: <20260531-benevolent-malkoha-from-wonderland-cdfafc@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA3PR04MB11204:EE_
x-ms-office365-filtering-correlation-id: 516551c1-c9ea-4116-bf50-08dec112559e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006|5023799004|4143699003;
x-microsoft-antispam-message-info:
 1OsM2uv9xeaERgLjkeTlTF+Hoq4Qj1HHiJo5vTaZ42KhR3hF1IoOFjKGv5gMwCJwg7FU1A4JzsQTONY0FWIJzbnWYWQhdgpSIKhJ4Q3gQ+1GLwEzAtBfMvgDlo62V5XpVAHRWgf9kWb1O1nmU0Ixpd3udnnhmIE+8JKBklBpWV+759+djs3/Ona7gHMEYCXdTQ3gnO68y60H3EFQkA2nDLG9nePu+h4ax1mW/kEbbU2ssuNIEnM4RWwtfSFV3eipr0NCdNhE7hWpUeT9kS+TAQY1KkLmb0D0aIH38Tq25/ENHIfFNWZlw3CP5/5KiGCiktQYGcqt4mjkLrbTF+LMI/hSnzRC3yuiovbPk8EXZ0NCjnETItHOjQiTUYcVMz3DtfTrGQt6SOAiGy9+zkpbtlQtRCum/ANjIZRV9A7o0mt6c4gn2ev9TWErQ/ExLGvoNFJfMu832sWYCDRVYE1dkU4jDviZOIrdfM4w+Zc6+xRAZ5gGRjCIrk5zlXKLQJUiG/Lw85cYZcmaxWT5iGKMHGg5aVh9c3xmDV7kJrYwlCB4MHHmiod0uOiLP9awLvqNKKzH1LEj6gWrgNgXQghcrjMXj06VWF4W6KWDipUeI1fSm9pQHg4hhauvjbmB3se4F0zzWvJcXo5GDwr8ObFPNK8uhiRngEV0OR6GUKUhsO7Ud2ITJEK0s2PZO7lNESYrS1SSZ9iJY7sgHnTl1CUtZwpqBmv7OWGfAItlQOO87mG3wrfNQItlaNMgWWDsEjps
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFRRT1pLbUNEdkEyQWMvTXVKQWJuc1BDNTVwaVVCc1BBdURXWGZDZTFVbWdQ?=
 =?utf-8?B?V01nTGtITWRsRnoyeEQ0c2I2ZUllVy9CYXFneEsrcS90ZEl3NzNGMmpOdjd2?=
 =?utf-8?B?L1B5MkF1Wlo5VFl1NEhKUzB4bGVMbC9DbURFZ3RJNFAwS2h5cTN2NVIyajcw?=
 =?utf-8?B?WFdOYzFZM3NiMUdpV2lXSGc0QlhLT1owMWFnVTB2MXlYQVg2UE01cFVTVW90?=
 =?utf-8?B?aVE4V05nSUhoQVZCaHF5VVk4OGU0ZU84R1pCU05ZQzVaQm1naVZ3UzhBcjU2?=
 =?utf-8?B?ckpkSTYvK1V6TVBQMGdlcFZqbUZtK1VqV1pVYUY1QzNaQ0g3eitlRXpnb0Qz?=
 =?utf-8?B?dFhEcERUbUZlc1NCTlY0UWdvUFlTL0JJdXY4KzhrVDdJZjl2OVREd241a0pK?=
 =?utf-8?B?bEhFRWk1QU9CQWZFTmhtb29JaWF2R0pBNkpxbk5XN1dHU05sNnh3c3JaYjFj?=
 =?utf-8?B?YW5QYzFkbnlLcGF2TTJSamI4RktRa1VqSE16K1FsZG8yYndnUVlvcmJnMlZB?=
 =?utf-8?B?NUFKSUR3ZURPNGdrazFmTTZGRURNcG9jaDVWeFowZ1pER2hXV2VwTXJTRHpr?=
 =?utf-8?B?VmhSdnNIYzA2UklGdWZYL3luMGtqZmVaTDY2WjF3WlFma2dwWStNcTk2WHhR?=
 =?utf-8?B?STg1MzhhRkljNTlvTmtmVHFxWmtoN0JKd1VHV0E3ZUJ3SnlhcWplMVlmTHdU?=
 =?utf-8?B?cldjdCtYbWFmZjdUcDAvMldNaWw5NlZRVW1OUHUxQ0Y2dGN6cWZ3YnJuN1l2?=
 =?utf-8?B?d2tnbmJQNVl6cHNkNXV5YVE2NjBBdW1MT1EyUDZkNEZzcWQzV29nT1d3ZnRE?=
 =?utf-8?B?QlE1UWJhT3VCbnNaTVBzSmdDSjNXTjJlRTlYRnBMeWNaT0ZKdE1TY3htME5u?=
 =?utf-8?B?Rk00ZEZDNjJmaW5rQ0xGdXA4cHlIcW1QYitkT0pFRTR2Nm9zd2NacXJGa2F2?=
 =?utf-8?B?NG1pV0lwTEJra1pjN3F2N0VubnpNejJKYzkvQUxya09LSTlFZ3R3U2prOWVL?=
 =?utf-8?B?eFNZS25NK2NxcVdlZkE4aEpKNmhjVmF5d2JhRWpwVHpuV3BGRkdrQUErckE2?=
 =?utf-8?B?NTV0U091RWlBcFFudEsyR2M1eWI5V1FxODRRSXMvYzY0U2Q5VHRTbzhHaFdI?=
 =?utf-8?B?QjE4eDlmekFMWW1UTWt1WVV1WkthbVRaUk1FYVRlVVY4N0pldUp6a2V2UGRp?=
 =?utf-8?B?ZEZqRC9ndkRiYlBBOFJWTTgvR2hkVmt1N0FmWDRkK2Rxa3NWN1U2VnIxN1dM?=
 =?utf-8?B?ZHRVaEJRK0l2UnorQXVmSW5IYVFlV0t1cFBnVEFHM1lWN1o2Q0RUNnhDK0pp?=
 =?utf-8?B?NnZMdmJvVzZmWnhPSi9yUmFMK0VYUDM1MmVBckZHMkZDeFBVNFoxTUJkYThW?=
 =?utf-8?B?cnNnWFVMN3hrVmd0L1JNdzFQMEtEaUYrWFFQcFNDWUJWREZ4NlhjeTU0elBu?=
 =?utf-8?B?dG1RS3BLblZQU09VQ3M5QWRvNDljOFk5SE44N2VlcVdHTFI4REZKeTE1alc2?=
 =?utf-8?B?a0JKczVXYTNzWE9KQWhRVVdwQVhNNzI4ZzJPUzB6cHBWUy9UN0ZxeHppYzRR?=
 =?utf-8?B?TjF3N3dxWVVTb1hyQndBRVV4dkE1T3NiaXpFV1I3V0JqOHB3RXFkZldZODRO?=
 =?utf-8?B?MjhMRDRsMTBScUJGb0h2a1JTOTNjNXE1TUhSTmVocm5IdjhPMUc5SWRiZW8y?=
 =?utf-8?B?YmFHZ1UwMXBhWFh4Q2I0OFR2cU80dGdVVVYzdC8vdVg0TGZkdEtMMnFtU2Ri?=
 =?utf-8?B?Ym5kT0VZelJJNnJRZGNmSkFja0hhQXpFRGRYcmFaMmNJM0ZiK0l3S0luUGZG?=
 =?utf-8?B?QmZzU1pMWVROWFhZVmtRaTF4VlRNcjZ5ckQybjVBVnFhZDRUNXNEYkhpdVh2?=
 =?utf-8?B?N3U5ZTcwM0sxSGt5a2RLTTZ0K1ZSOENQWUt0NFVmcHdGYXV2ZVB0ZHJwdWlP?=
 =?utf-8?B?d09Id0dWY1JTbkJEU1RETEtzc2IxdlVpVHJ1NTcxTzZpcjlTWTI2dWpsdXBk?=
 =?utf-8?B?YTdOdTBVV1BGMEZrMk9lNkhYU2QzaGRHK05xNTBBSzc4anFITE9PMWU5MFZH?=
 =?utf-8?B?bjBEYStNMm5GVHltWmJFRVVIaVh2MEkyU0dKekVyeDV0TlhTcHF4dXp4NkMw?=
 =?utf-8?B?VzZtUUJ4NDlrbkpZS0ZCdVhEOTF5ZE9SMHpHMzhOS01naXJjaDlhU1pVMmIz?=
 =?utf-8?B?cGZ5SEF6b3JTRWRiVVQxYUpUZCtwZGtaMlZNR2VCOVd3bGZ4NnljNmhMcFhY?=
 =?utf-8?B?MzdtcC9aRTRVZlg5enFRM25lcUNzWlVRV3d0ZGxQdERmSWcvR0ZKeitPUGhF?=
 =?utf-8?Q?kqeW/FkIkfOSim0Ncd?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516551c1-c9ea-4116-bf50-08dec112559e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 01:49:22.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpvHrCcG0N83D2pxx/Enjom/wq2EfZjh5GJKBX3c/iVeX5VMhCcEMUp+i//60DQjPrIADl5kKKvoMBhaAv1ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgTWF5IDMxLCAyMDI2IDc6NDcgUE0N
Cj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtl
cm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBl
bmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5l
bC5vcmc7IG1hbmlAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LQ0KPiBwY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8zXSBkdC1iaW5kaW5n
czogaW14NnEtcGNpZTogQWRkIG9wdGlvbmFsIGludGVycnVwdA0KPiBlbnRyaWVzIGZvciBpbnRy
LCBhZXIgYW5kIHBtZQ0KPiANCj4gT24gVGh1LCBNYXkgMjEsIDIwMjYgYXQgMDU6MzI6NTNQTSAr
MDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gVGhlIGkuTVg5NSBQQ0llIGNvbnRyb2xsZXIg
aW50cm9kdWNlcyB0aHJlZSBkZWRpY2F0ZWQgaGFyZHdhcmUNCj4gPiBpbnRlcnJ1cHQNCj4gPiBs
aW5lczoNCj4gPiAtIGludHI6IGdlbmVyYWwgY29udHJvbGxlciBldmVudHMNCj4gPiAtIGFlcjog
QWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nDQo+ID4gLSBwbWU6IFBvd2VyIE1hbmFnZW1lbnQgRXZl
bnRzDQo+ID4NCj4gPiBFYXJsaWVyIGkuTVggUENJZSB2YXJpYW50cyAoaW14NnEsIGlteDZzeCwg
aW14NnFwLCBpbXg3ZCwgaW14OG1tLA0KPiA+IGlteDhtcCwgaW14OG1xLCBpbXg4cSkgZG8gbm90
IGhhdmUgdGhlc2UgZGVkaWNhdGVkIGludGVycnVwdCBsaW5lcy4NCj4gPg0KPiA+IFBDSWUgYmFz
aWMgZnVuY3Rpb25hbGl0eSAoZW51bWVyYXRpb24sIGNvbmZpZ3VyYXRpb24sIGFuZCBkYXRhDQo+
ID4gdHJhbnNmZXIpIHdvcmtzIGNvcnJlY3RseSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlc2Ug
aW50ZXJydXB0cyBhcmUNCj4gPiBwcmVzZW50LiBNYXJrIHRoZXNlIGludGVycnVwdHMgYXMgb3B0
aW9uYWwgdG8gbWFpbnRhaW4gYmFja3dhcmQNCj4gPiBjb21wYXRpYmlsaXR5IHdpdGggU29DcyB0
aGF0IGxhY2sgdGhlc2UgaGFyZHdhcmUgaW50ZXJydXB0IGxpbmVzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgNiArKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBj
aWUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2ws
aW14NnEtcGNpZS55YW1sDQo+ID4gaW5kZXggOWQxMzQ5ODU1YjQyLi5jZjcwOTEzMmZmMWUgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2ws
aW14NnEtcGNpZS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gQEAgLTU4LDEyICs1OCwxOCBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgaXRlbXM6DQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IGJ1aWx0
aW4gTVNJIGNvbnRyb2xsZXIuDQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IGJ1aWx0aW4gRE1B
IGNvbnRyb2xsZXIuDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgZXZlbnQgaW50ZXJy
dXB0Lg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBidWlsdGluIEFFUiBTUEkgc3RhbmRhbG9u
ZSBpbnRlcnJ1cHQgbGluZS4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYnVpbHRpbiBQTUUg
U1BJIHN0YW5kYWxvbmUgaW50ZXJydXB0IGxpbmUuDQo+IA0KPiBTYW1lIGZlZWRiYWNrIGFzIGJl
Zm9yZSwgbm90aGluZyBpbXByb3ZlZC4gU2NoZW1hIHNheXMgaW14NnEgaGFzIHRoZXNlDQo+IGlu
dGVycnVwdHMsIGNvbW1pdCBtc2cgc2F5cyBvdGhlcndpc2UuDQo+IA0KPiBQbGVhc2UgcmVhZCBl
bnRpcmUgYmluZGluZyAtIHlvdSB3b3VsZCBlYXNpbHkgZ3Vlc3Mgd2hhdCBpcyB0aGVyZSB0byBk
by4NCj4gQW5kIHlvdSBhbHJlYWR5IHJlY2VpdmVkIHN1Y2ggY29tbWVudHMuDQpTb3JyeSwgSSBk
aWRuJ3QgdW5kZXJzdGFuZCB5b3VyIHByZXZpb3VzIGZlZWRiYWNrIGNsZWFybHkuDQoNCkkgbm93
IHJlYWxpemUgdGhlIGlzc3VlOiB0aGUgc2NoZW1hIGN1cnJlbnRseSBhbGxvd3MgdGhlc2UgdGhy
ZWUgb3B0aW9uYWwNCmludGVycnVwdHMgZm9yIGFsbCBjb21wYXRpYmxlIHN0cmluZ3MgKGluY2x1
ZGluZyBpbXg2cSksIGJ1dCBhY2NvcmRpbmcgdG8gdGhlDQpoYXJkd2FyZSBzcGVjaWZpY2F0aW9u
cywgb25seSBpLk1YOTUgaGFzIHRoZXNlIGFkZGl0aW9uYWwgaW50ZXJydXB0cy4NCg0KSSB3aWxs
IHVwZGF0ZSB0aGUgYmluZGluZyB0byB1c2UgY29uZGl0aW9uYWwgY29uc3RyYWludHMgKGlmL3Ro
ZW4gc2NoZW1hKSB0bw0Kc3BlY2lmeSB0aGF0IHRoZXNlIHRocmVlIG9wdGlvbmFsIGludGVycnVw
dHMgYXJlIG9ubHkgdmFsaWQgZm9yIHRoZSBpLk1YOTUNCnZhcmlhbnQsIHdoaWxlIG90aGVyIHZh
cmlhbnRzIGxpa2UgaW14NnEgc2hvdWxkIG5vdCBoYXZlIHRoZW0uDQoNClRoYW5rIHlvdSBmb3Ig
eW91ciBwYXRpZW5jZS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gTkFLDQoN
Cg==
