Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AF248873;
	Wed, 11 Mar 2026 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209300; cv=fail; b=HS112G1FaYX10B1dZ1NgGXyHWyQqE/pev5Wi4lZzQ+bT0turVH5e4okHA+G/kIFkjTIH2vhC/AzIBPLK+XRO9dwKfR73KE39x9D0zGUfQ5ZhtGD6J85VPaQia7OvR0mFZZWQtNy77q07aBuSOG394Ttq5hiShmUjhjmfI7zkmVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209300; c=relaxed/simple;
	bh=Nbws6IhMyTxPJtAEuEmrlYHp3pes7NrCHjVDAUWSZ7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4gyKwLC8xD373l3Hl9C/Z3nITkX0WTTvtPI09q+VsUQ35NOlahWDy+gzmKgSJTUcuyJXpldfCb4dVbKBBWWglHISlgbYSx1y1YB1wy7gY03YtYmwNS/EIKBABufvWzgE4W0trDN3Ai9cLYTrB7KGu6eS6yflTZmEiCET5JJJJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kll2OrZV; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kll2OrZV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpqqOXJ68UUFRSNdW9LPiyXFNowYy/wBLrVK9gspXK8VxBaS2XSflSb6M3IS4iq2OGBvrbynqO8BCWhwdw7F64aUdDgiaVSwEYqvKF98D/YU/bcrd3I5ztEUgI32jTGAdPBNCwz8dJvFRs89MKbJPwERgC3doo0QBN/uMZQHQWWaXmgjxoMevPXRStVPQAGEE7IQwMPbFzr5JXRH0JHFnG6Cw9lr+Coe97Et35rUakA7cHlPMASu02el7Zyx7/vpBfY15uPx+yrwLfS8hQByTB7pNk0PepCWhZq4RAUoA2kFkUm4GiJZgv/IVdLfFFW0VpJajAiQWIJZS8utRha+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbws6IhMyTxPJtAEuEmrlYHp3pes7NrCHjVDAUWSZ7A=;
 b=X9I+GYybffME4RQXx8/sUZFlbYUkpE2Tt432tad5t6/WU8p6FIwp89dns6BUGzNON1T/x1rcPbdB4vEfVZHmpoVd+vFTgdKDu3UUEsSdpvoktHI3vmki7nzS/mSdYC8ZfFMsNaxhQ7MQX1BNDudJ/U9Kd5MhJzMNl1uJKoWkEKkcjRrBZLJkmMrLpSrV9cDmklfSl2CsnQ5ONId1yjOnV3Up21FVzpElqkLYMNdGSPKW0hF1i39m1V5ToG/mlI9vP2OLOc6EmoMB+7c0qf2ueBJsGgdv9Lkn8azmOPu7S0pwE8EFxuxQNiyeNejV9r/yn8KtCgSdH/9CQom/Lyy9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbws6IhMyTxPJtAEuEmrlYHp3pes7NrCHjVDAUWSZ7A=;
 b=kll2OrZV51sIwQejBXyi8P2VBvpJCNhNeyYBEMfuau8R+TWfCpwbj9hZJmJruRJsNVZePc1iD+iCn/k//NWdeq3juXnNmj9gW4SkqBPePjlSzzwlWSqfnWxFn1tXZuf3t58Kec6FVmeoWQk7CcEypNGXvDo1X4hIvy+Pcvu+p0c695TY3VQ8S8SLX8Mbrt4NbJmw4fJCpfndTmn4vHWgqzxM2+TdrlRzMufCU3ZRd4QYmzNS2HMbG72QPFsfciWnxp5Knj0j4t3+vAhlJEqQzKGlFuhwWgjyXTpe3G2PT43BebG8fkD5uGgV+OgLYAfyvKDtI6epZ3kdgJwWsbAApA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI0PR04MB11616.eurprd04.prod.outlook.com (2603:10a6:800:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:08:15 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 06:08:15 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Thread-Topic: [PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep
 supports
Thread-Index: AQHcsGMInlhricerAUWaVPGnkRznNbWn3huAgAD7sNA=
Date: Wed, 11 Mar 2026 06:08:15 +0000
Message-ID:
 <AS8PR04MB88333BA891E5C4F3E0A846708C47A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
 <20260310075459.726495-3-hongxing.zhu@nxp.com>
 <abAzZ-7AQQNNmHLz@lizhi-Precision-Tower-5810>
In-Reply-To: <abAzZ-7AQQNNmHLz@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI0PR04MB11616:EE_
x-ms-office365-filtering-correlation-id: 8d18ff68-e881-46a1-864b-08de7f34954c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info:
 JwFjv+mdIfQ+w+xP6qQioeXGeqWCpOB2+CD0PgS+wEv0zruCPuW3e2aPd84CJc5RErRusmoylsIT/J3X8sGT7MjDik+qWLViBWVr8qQWZuRXa3de1GSF8wXQ6I5aQoIamSR34IisKsFcOKXrhPCvLclP41pF86nj0zF1dg5KHnVugOMGVUHZiQSC1Wnh+5wZ9idovEiAwlQ7X2tikurrbaO6/5qMGQhggtuZlXg9dSJma7fmQTSTg1NUVnBHtLiY7cTTi08XPHxyWFhPuZV/sXBt+IJVixdJ+/JG0PtgjLU+0nQn1Kd7RG5I0Rsp1lCEBGPJjVk/gRnS/E1bvCpVCczw7wNyOigKgNMp53YiuE76bRblv75JyAcc9BCgH4JkiTKaSsP4qx2uP5a5haexYQCTs70v5fOZI/NYKwgYoMzUvDG1bWwWHiEbgr4zz2eDqvyCUlg8P56gqLCJGthuA3acdflYcnOfIiXMYqTnu5L/sdMwfiGQQnUPGznvu+gzYsStT9Oimup6nCofFi0iC0c13N+yMVMmvYA091td3Ula2ve/AdLdho9qTwp0Ami1MiE/zKr/L9ONfCn5hxEp0cjC8/MgzgxyQYMeFvqn8vWpfcRtpjso7glTL/m87KCkY2uK/p/OzQSWF9Hu85oTe4B1wjvvZ+JxCxRY0APVat900FLSNn43ztINjxrLxRx8RpxeNqmPKbhfjaMT85udZ+uK50pFotIiqIeB/5lNGvH4zehK5Xa10yN9rCIfsGuf6smzSfiRZInDqFJo0TLxFJA/uH/PPaVMFKyCffAPmOg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bFY3N0cvZkJ3ZkcwRExLSm1tT3NEaThoZUZJRUx2UlJ1ZCtUaXRQbzVVVmV6?=
 =?gb2312?B?VU1XYzM4OTIwR1NxSTJseDQ4SnFJazlSbm81N2Jxb28rWUw4L2FoS2RORjBL?=
 =?gb2312?B?NksvQXpLYXR0TEcyL2JqdTcxYVBaenBFU0NlTzJnbVNUM2txankxUmZPNitu?=
 =?gb2312?B?SjBnSkNlYUtUY2NqQ0JIQmhtdyswdzVRM1JHbUYxdGdteGVlcnl3NHpXQ05r?=
 =?gb2312?B?QVZFdllhcVVTZ2xQcDhLRXBDU09QUXBnQkpSQU02eHVnMDJmMG81NEhMNE5Q?=
 =?gb2312?B?OUJWWm5KNVBLMDNaRHRTeTdwYkJITFBJYndkU1RUVGVlSHU3UjREcWorTWtk?=
 =?gb2312?B?cEpjQWNqQVI5ejhMOWJzQUdyd2FoVnJxdWF6ZXVCYklFaVN1ZGxQZVNFYUp2?=
 =?gb2312?B?b1FhZUJUYjdoaGZlZTFIQ3VhYVRIRjJ6WmIwSHBkb05sdUNzaWtFUHc3aXB4?=
 =?gb2312?B?ZEVkbzRuTTBVT0hncmJtM1UyTHYzU0MrUmo3a05VVXltc3JxSW5FaXZKZzBK?=
 =?gb2312?B?b3pTeGJwOFhXeTNSR29yZ3YxNUI3OFRqRVArYWVSTDBvd3poSjJuUjNEclgv?=
 =?gb2312?B?NGtDdFBPeEIxWkRQVTl3WnZwNjJQTHlMVy9qK3o1aHk3OHA2OThnSnp1NEN6?=
 =?gb2312?B?YW9lVEVXWDVheVc5ZGhkVi9pRGZxcG80OEhqWkNrYkgwbmdMcFJuOXdreDFy?=
 =?gb2312?B?cWl3SW5Db2t3NTVncU9TYURkUVliYzZqd1VKa2hwVzg4ZFI5WjJ5empWZ2dt?=
 =?gb2312?B?OEpPMVo1SytGVE4vL3hDNTZuaWdydWdRWjRFd3JFczJmVktpSHpwZktIQXQ5?=
 =?gb2312?B?bHBXcHFoREY3T1lTQnJUOXRmSnRTcS9WR0ZvZmZOSUtONGdZaXVzU0xuY1JK?=
 =?gb2312?B?UWovZTIrRjU4NVZuQ0E4NGt5dXRFR2hnMXpONklFRURFSGFLSnlyMW9rSks1?=
 =?gb2312?B?bjloN3VBQ0FqMWl2elNCUnMrdXQ3U2JLMW52VTVSVkgvMjdQWG5lcE5JcFVT?=
 =?gb2312?B?eGRUcHFWNXAzK091R2U2Z1BmQ1A0b2pMWVlLRkxNV3k1bzhtVFNyamFWQzJ0?=
 =?gb2312?B?MjQwSXBuV1h2WDcrVDc1czNHWXlJTlRaa1I5R2tJSXAzRGRIRk1CaFNsV0hK?=
 =?gb2312?B?aTdFMm9FaGV4RUlrTi9ZM3ZaWDdIS3IyMDdGMjJSV2hDdjNWdWszYU5rY0pP?=
 =?gb2312?B?STFVQjNPbDhEVGNNdEdTNGh0eHFOOEl5eVRYU2phd0E0ZlZSaU9pTkJneGo3?=
 =?gb2312?B?Zzlad1c1Zi9KaDR0ZUVWc3ovaXBOZlJQSG5Qd3RQWU1QNnFmdlZLaFh3ZUgy?=
 =?gb2312?B?U3NJdlVkNlE1dms2MFBCR251bkd3a0JPSDBZbU1wYys4dnU0ZWx0MmVpM1Js?=
 =?gb2312?B?TFl2cjVzeUJTaDZJNkdxTnAwWFlKRDdmTk5PSHN1amlPbDJFa2FrYkE0dGxT?=
 =?gb2312?B?V1U4REZsOUszMWgrT1RjTU9iVzNaWWVSdXZxSEhmYjZZSjFvWGZHZzZqbnpC?=
 =?gb2312?B?emJkRVlEazVFN1JwUll4SWd1MDNUYVpxUHFSTGx2L3RWUzhpcnlINXA4b2l2?=
 =?gb2312?B?bldCSzNKMzRWTHV4U2RnNXBTMFFqS2Myck1vQjI4QnM1SnA0a003eml5YWVy?=
 =?gb2312?B?Tk5VNGVXYkUvb1MzOVhKVDc0T1FBNUJqTDNBczV3MlpQR3N1YWNiRzJ3enhJ?=
 =?gb2312?B?d1pwUC9VZTQ3NEo1QnVBVWVUL2trTXcwelBzK0lZUG1HTlYra2Y0YlRvQXI4?=
 =?gb2312?B?MXpqQ3BCOWM3cGg4c283TkxHRVdmV3BDbFZUOXlzNXg3Z2k2cEw2QmY5ZUdZ?=
 =?gb2312?B?YzNNeUlYRGs2N3BCZXljRmJzNWRnQTdpRUVvb0V6OUhRQnYzVUN1MkJRbTk1?=
 =?gb2312?B?dDVLT0dROEoxYWNNMTBIbHNqVjZsT2JqSDR5RlFmbFB5eElZN29wYVNIdkRa?=
 =?gb2312?B?NGFkZTFGTFpmd2toaUMyNDZJdUF4Z2Y4RU9JUk55a2w0dGVSUXZDYWVvMFps?=
 =?gb2312?B?QmkrV245QStSWDJIdGR3alVMZmRqSjRmWHJCTmZBSlMxaVJWd3JDMk5hdVBH?=
 =?gb2312?B?Z2hXdGNOYVJGTERlYlB5ZWlWWGFzSDgzRHhNMXJ0bW02UWp6bkxHcTVEaEZu?=
 =?gb2312?B?SHpyczdKUkFldW5Oby9GRVpmdk1yQ214MEhmQ09CajYrelA4UUVRckVlWjVk?=
 =?gb2312?B?WFdGVWVacWZodkVJK3JLMEI4eC9pNGdYaXBrRndaa2JsMldvRStBcmFmUWlu?=
 =?gb2312?B?SW9uUmpMUmpoMFFLa1RTbWNJUUlTaFdYN3lDT2lLcitFL2t4VXprR29VaGhp?=
 =?gb2312?Q?2QCUqYMnyMOMxSWbpA?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d18ff68-e881-46a1-864b-08de7f34954c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 06:08:15.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XHjtyl4PbjZH6iK0ijMTUtwx8pa+6gjnjixg/C2WtAu5qAEdLb6mG7qb3hFGHSv4IXfGNRroxvvblpuFrrJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11616

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNsTqM9TCMTDI1SAyMzowNg0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBr
ZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBs
LnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3aWxjenlu
c2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsN
Cj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzRdIGFy
bTY0OiBkdHM6IGlteDk0OiBhZGQgcGNpZTAgYW5kIHBjaWUwLWVwDQo+IHN1cHBvcnRzDQo+IA0K
PiBPbiBUdWUsIE1hciAxMCwgMjAyNiBhdCAwMzo1NDo1N1BNICswODAwLCBSaWNoYXJkIFpodSB3
cm90ZToNCj4gPiBBZGQgcGNpZTAgYW5kIHBjaWUwLWVwIHN1cHBvcnRzLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0K
PiAuLi4NCj4gPiArCQkJCSAgPDB4MTAwICZpdHMgMHgxMSAweDc+Ow0KPiA+ICsJCQltc2ktbWFw
LW1hc2sgPSA8MHgxZmY+Ow0KPiA+ICsJCQlidXMtcmFuZ2UgPSA8MHgwMCAweGZmPjsNCj4gPiAr
CQkJbnVtLWxhbmVzID0gPDE+Ow0KPiA+ICsJCQludW0tdmlld3BvcnQgPSA8OD47DQo+ID4gKwkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSAzNjQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJ
CWludGVycnVwdC1uYW1lcyA9ICJtc2kiOw0KPiANCj4gYWxleCBhZGQgImRtYSIgaXJxIGZvciBv
dGhlciBzb2MuDQo+IA0KT2theSwgSSBzZWUgQWxleCBpcyBhZGRpbmcgImRtYSIgZm9yIGkuTVg4
UU0gUENJZS4NCg0KV291bGQgYWRkIGl0IGZvciBpLk1YOTQgUENJZSB0b28uDQpUaGFua3MuDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBGcmFuaw0KPiA+ICsJCQkjaW50ZXJydXB0
LWNlbGxzID0gPDE+Ow0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==
