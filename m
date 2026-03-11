Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821C29A9C3;
	Wed, 11 Mar 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210697; cv=fail; b=nI1fvFZZ+ROG8wEyFFS4lBKin2lIAHWmF3DYc00dhUm5xxix178e1Sm4j6vBxsVPf8UPjgR/ROABmOJS0fPxoeSFoMiRIy+Vv+FmytCL1oVYe2HLcpdCfVE7e5PU7orl6Wj+/00yL+a7BNSpbbWWt24RJ5KnSpAsM2aOb2Nh2Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210697; c=relaxed/simple;
	bh=E34Usqard2a9ufCxpwWUjKhaHcGK5a1CvSrtapKTEqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpuaGWfBYFdsyTOHfWHapDauaLvzBOkNykLuTNtkm2P9FkIdCwUxId6fExAFV68PjF9y9+hKtJ6pW0T13NLVdfbVxuiHZuOGR1gnDxuVHq3X4fEN0y5/kIORXQnwXrCyDY+nOn0Fq6rwd6in4FU8hn9AjHH/a4DTwG5fZ7WD6S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWOXJbEB; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWOXJbEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHYs+pdL/MaYu7M2Gh0j03fu/siODuz+LAutoadHHxGE90W2VaBjw8DSQjtFoIJ9WQvQ6v76DXWtlwoAZL70S3n24tNxT6HHcgUPflRCP+kPs5IfADOuCPGUyEuqcVpEBgRh2xYu5/Betv+XcMAQv33YnIsSdd0yLTLppM88aVkF9QTzFJVBz7FfNfVmu4vyEtpgSoFAj2oT1Ww5fbUrGHLOmcXb+d01YGZaEmYmibL8IFPSEaUS9qOdqOGODPQSablMbRuZUPRr8mnNmPMlYEvwjaTjcH/iRLk/5hPoOQyH9nmvp+tefNx/1QmnHjDX27A2fz+2gXLSrIExjDoTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E34Usqard2a9ufCxpwWUjKhaHcGK5a1CvSrtapKTEqM=;
 b=kW8ayO0sGfuPgNhtu3rQb/PVlrSLjUb8Wiptv7vBKuSiCR3x+Xr8rW7Hxy98E1GeH5VOYjcaJg7tSEduTGR3+52vBJvH/Bt04k/9D2a6cmOvgS7YuTpPNR2rSa1SFgGH+v05bmVffXS9opbzi7vS2oj2bw/PahOpFq/NfOqf7vJGIN9T6SAd0ROKd6VVizHFKvEbUnYYZnd9x5ucuRiJwOWzFJvqJDzSVVw/J5VfpZMZzUKB6twh72GwTX7M7q8BxdGeMOAlMPGraGIaOqzXlehL+qDxbucrT4GmnY2gFbwSDA9+0TmtiD6BhHmijdxMHSa29dnaqiqW5kWGOTPFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E34Usqard2a9ufCxpwWUjKhaHcGK5a1CvSrtapKTEqM=;
 b=LWOXJbEBmiW13kh5LsOTbphmG5XllrZB7ymW6ci7ZLJq9zepgbyhEuGv2lZ9JJYyHtGYOtw2tUwpfVtghzVTuOGFnWZ69f+sxIT9PMlQ9P+HOwqXimBkIlheueZd3s8ZbQFAYWO4Jts6QeNlvFyjDKbWDXu6U9sRjISBr/MbjnnEfSUutZt6cTkICE/71yDDngFeAjFkMhE8VSVjChspsPid9GMcZy7xsmMEEsmw4pdDB4+sU+x6KzgeTufYLIXHTvjyTuT11y5uCfy+M9+rbK/t9hYMqBbEwXz/amASQicQoidYu2lHFAL5GeEzQS6TFozjUSHcw/6zci1wOoMFiA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:31:31 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 06:31:31 +0000
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
Subject: RE: [PATCH v4 1/4] dt-bindings: PCI: pci-imx6: Change maxItems of
 clocks and clock-names to 6
Thread-Topic: [PATCH v4 1/4] dt-bindings: PCI: pci-imx6: Change maxItems of
 clocks and clock-names to 6
Thread-Index: AQHcsGMFcgKgcGMcrkyDzOazDhXknbWo3NyAgAAA0MA=
Date: Wed, 11 Mar 2026 06:31:31 +0000
Message-ID:
 <AS8PR04MB883364D970713670411E497F8C47A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
 <20260310075459.726495-2-hongxing.zhu@nxp.com>
 <20260311-invaluable-nondescript-manatee-a3c4cc@quoll>
In-Reply-To: <20260311-invaluable-nondescript-manatee-a3c4cc@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PAXPR04MB8800:EE_
x-ms-office365-filtering-correlation-id: 3e5c24c6-f543-4195-b0a3-08de7f37d571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3I+xCOjiFPxqPID5WgLYmQzH3+8dwDr2wYoPwCTAsUGeLmZZKZ5vIZDcMRf2E5Ja+BfF57/6oODRHQzriW2rQIAI9NmMxR44jlb4wgz5WCKYOwyHCog3NXXUGGiNQjGPQVX03Lh19WwmNFBc/N/0zMYJMHaBGtOk65bDCrmU14POJhKenL7yOxstyFdzI2j2gdI9+GBt4aWZkjtTSygMiA5OiVWJv4dhKNM681mU7jra5th0DjjCW0jPtoauVwJFl25CHY/rhPhSEpls9JwR3c8xzuGc/yCr1n/PViPJUAhEyJ8TryIv1QI6OZJkRuzozhNs8Vc390EBEHwYiDeOFhenT/mz+9lUO80rRVy+BVeYuYsGLukd9hbL+0xa9h8jd/Ji13TJNo2lQKypE2QwLozCKTWw8f466hYSity60P+kBcSw/poNf9GtQtuAUfOpUL6JOxiaVOT1EFlnG3/Z03P99PerRrul4syaoHGQl5jeicZHo3n3eveUi4EnT/OugqE3TPL2GFQKLLkcl0V31R24JyM/44mxF83hJoF3Jawb6N9DX8+UVuZejjX+lhrkbXtxekp61Gy9YSkRaHc0zvMloq9bMblOL4qmXFTT5U42i1sYmM99ObrPRjE2+v2MJc1WrvlKmMO/usX0Zm/pi6qLafcQO9ZhsuS3o7D2BuksbApCux5OY1CVZSFIcJ8Td65ja23lxquH7NpXG8kR3AHVP4TGTezy7UGfEcsSZmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L3hMMlUyTWpqeVRRT3NsVnduN1FkWE55STJYN010SnFYTkJmRkpHSm93NkdV?=
 =?gb2312?B?WHIxUWp1aDNFamQ5bXI5Q3BaVGVLT3Rnd1pjb1c4eDdWNmkvcmhNMHIxNVZh?=
 =?gb2312?B?Z2FRbkR1Y0dza1BlbXU5RGgvY3gwRkhLWDV4ejJFRUgvaXJCbGdIQlQzbGxC?=
 =?gb2312?B?cHFMN2Vrcnk2Qm1icXFQaDlXQUJKUjNSaWNRLzU3cFlOL3NqZ2t0djZWekxY?=
 =?gb2312?B?NEhDaEQ0dTZRTmR5dnBTWkc0Yk8zcHFVVS9keUdiRlNxQSt2WUYvaTMveTFr?=
 =?gb2312?B?ODJ4N2RyeUR6WWdlbzVDTmdTdDBnUC9CbVdlMDhLWVZiT3FhZll1TnRyS25I?=
 =?gb2312?B?b1RDT3d3ZVFEMFFpeStzaWt1RE9aNDIyS0haYVUrU1dVeTEvb0lLaGpWTzZ3?=
 =?gb2312?B?cHdmUjZFSWxqM3B3S0JaMFRBSFBkYTNLK1MyYTg3MVNEeFlIa0g3cmRmOVQz?=
 =?gb2312?B?a2RxYTR4blZYZEZxTXFWeXBNRzJOY0FXZ2lGTVVlUkxGL2pSQ3NLNVJQK013?=
 =?gb2312?B?aWs4WHM3VWtqKzc5TEZCenIvejNJOWprUnVXbUFJdUdzR1pPRDZyOGxRbXQ5?=
 =?gb2312?B?UWc1a1RLRzEvQWpNSm5SNXRSMCtnSzlhUk1oSWtNM3ZzQlQ3TS9JYW40ZHBu?=
 =?gb2312?B?YTQ1SHRNeHRqRS9NcFRNWGViQmV3YlN5RWFFRnZ5M2hFNXRueEFDWnJYUlYx?=
 =?gb2312?B?NFA2WWVQemxQRHpJZi9rVHQ5NGQ2UmtaRUlTQWQweXhpU2xnSHQ1Nk1kUGdi?=
 =?gb2312?B?NnFnSzdEK0pZcURJa2liaTUwUWhsKzBWRjVWV3BVcEZ6SWxWdWtyc1A5Yngy?=
 =?gb2312?B?ZVhxWGlKZzZRZ09tckVqS3FwejdKUFpSVmEza1owZ0gxRHpqWkJ6M2FCeEVn?=
 =?gb2312?B?cHN6Uko1bGgrd2JiaXplVDlCZHg1NnFTZE4xWFpzbWgrTURyUHBLMUZ0ZUo2?=
 =?gb2312?B?QTJYSGYvdDZYV1AvbzgwZEwzTnNpVDZsdlczd1BSa0RaTERRMFI4bEZQK0RY?=
 =?gb2312?B?R1dYOFZYNXB1SFd5TVZaaktrKy9hL01Cc0FxZnJCaElpaFQ2RUEwTjBGcU5z?=
 =?gb2312?B?TDlvTXQwQmI5L0todmtsdG5lMW1neGtLZnJJS0o2YUowSVZxTWVzRFVTanlC?=
 =?gb2312?B?ZHhzSVlHSXBPVDNaR3MzdENGMitDK2ZNU0w3YkVFV2hvcVVZcDRGbmJ2T3pQ?=
 =?gb2312?B?bHRhTGxkdDJocGlPK2dOMFVmUzV4bSt0d3Jrb1dMQ2pJRHVFdEEyS1Y5bE1u?=
 =?gb2312?B?RXhUaWVCTmdEb3R6bXlQWEY5ZCt0VFoxdHp0TjEvajR4M0p2eWJac0hGY1Ar?=
 =?gb2312?B?Q3hUOVBTZUNFWmh1SXdpQXZaeTVYQUIvbncxdDZEMnM2ckxEb1l5b0FVZkxE?=
 =?gb2312?B?bXRGblBKK2Q1ekp6cmpxcU1yQU1EdTJYYWtRRU1zMVUzLzJzUjBkN3hWUGNB?=
 =?gb2312?B?aUthWnRyMUVnUTRxc1FQei8zS3RxRTRDYzErd0VFZG9lVG1xY0gvZEZpOUlU?=
 =?gb2312?B?Mk5pS01XU0d5YXFib1BPbUJpVEhTMnQyQytTcURhNmZqT056WlM1b3hmSDdo?=
 =?gb2312?B?bDBXOHNiVEUxOEowSnF5R2t5TGFjbTFPeGZWNjU3WmJadGZBVThvYjhzS1Mw?=
 =?gb2312?B?aUhXOUd0bkY0WlJObGZMT1NIMXc4cUwxRUJ5Z1ZId0hMSW1WdXgyS01oV1VF?=
 =?gb2312?B?WGF4eUJ5MzIxTncxME9JMUxYR1dIWXM0WjhZMUJXYldoZmFUelJkbHkybXlP?=
 =?gb2312?B?L1FlMVJTQWIxWDFPNy8xOW8wQmJaNyt1d1RSRmlLTUovWU54ZE1CSXFBYmli?=
 =?gb2312?B?Y1d2a0N1V2Y4bTNrK1FlMnJZY3Q1cVV0WHNsTVlyUDRodWhPL0tGcitOT0ZE?=
 =?gb2312?B?dDdaNkZQUXhtZThMRmJudjNkNmEwaVA2U1B3SkR3QitJQmh6K0tDa1pLUWFH?=
 =?gb2312?B?a29IcE5zWFBjS0tFMDgwaWlxTkhYUmhWWS9DampJcXc2NzlxbDFmRHhLbzU2?=
 =?gb2312?B?N1YxNXVCMGF4Y0NNL3B6Q0hOTWo0S0JiclB2WEN5WWdWY01ya1cyV2NibThO?=
 =?gb2312?B?Q0d4enFHdTJpREVuWDFTRTNwTm1TY2pLUDFlMDJBczZZbWRPQzYwWW5sbDMr?=
 =?gb2312?B?SXZGUnF4MUo3VHhZRkhHdkZ2UkVqditaWE40UDJjTmVlTk1NMXFzVzNCMjZZ?=
 =?gb2312?B?RXQzL21JK0x0WUxQWmtFeG1lTGh0aHdIR3ZJc0lIRkU5QWloZnBoS0xvYmJn?=
 =?gb2312?B?TFVxQStqaXZiWFI1ZVRuV2MwWk5uRWQrRVEzbjJzekRPWk9HV2VEQ1RBT082?=
 =?gb2312?Q?Jahb2qkY+ZQEft+uMj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c24c6-f543-4195-b0a3-08de7f37d571
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 06:31:31.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRzWPzmqGP6kgG1QT+RSs0K1Z7NRvdEC0MdMuh03XdNHnwwGHkErQ7X5POisUUQdj86zL4/pe1T5Hq/VIAHftQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jPUwjExyNUgMTQ6MTgNCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7
IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1h
bmlAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzRdIGR0LWJpbmRpbmdzOiBQQ0k6IHBj
aS1pbXg2OiBDaGFuZ2UgbWF4SXRlbXMgb2YNCj4gY2xvY2tzIGFuZCBjbG9jay1uYW1lcyB0byA2
DQo+DQo+IE9uIFR1ZSwgTWFyIDEwLCAyMDI2IGF0IDAzOjU0OjU2UE0gKzA4MDAsIFJpY2hhcmQg
Wmh1IHdyb3RlOg0KPiA+IFByZXZpb3VzIGNvbW1pdCAxMzUyZjU4ZDdjOGQgKCJkdC1iaW5kaW5n
czogUENJOiBwY2ktaW14NjogQWRkDQo+ID4gZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2NrIGlucHV0
IikNCj4NCj4gUGxlYXNlIHJ1biBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgb24gdGhlIHBhdGNoZXMg
YW5kIGZpeCByZXBvcnRlZCB3YXJuaW5ncy4NCj4gQWZ0ZXIgdGhhdCwgcnVuIGFsc28gJ3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCcgb24gdGhlIHBhdGNoZXMgYW5kIChwcm9iYWJseSkN
Cj4gZml4IG1vcmUgd2FybmluZ3MuIFNvbWUgd2FybmluZ3MgY2FuIGJlIGlnbm9yZWQsIGVzcGVj
aWFsbHkgZnJvbSAtLXN0cmljdCBydW4sDQo+IGJ1dCB0aGUgY29kZSBoZXJlIGxvb2tzIGxpa2Ug
aXQgbmVlZHMgYSBmaXguIEZlZWwgZnJlZSB0byBnZXQgaW4gdG91Y2ggaWYgdGhlDQo+IHdhcm5p
bmcgaXMgbm90IGNsZWFyLg0KPg0KPiA8Zm9ybSBsZXR0ZXI+DQo+IFRoaXMgaXMgYSBmcmllbmRs
eSByZW1pbmRlciBkdXJpbmcgdGhlIHJldmlldyBwcm9jZXNzLg0KPg0KPiBJdCBsb29rcyBsaWtl
IHlvdSByZWNlaXZlZCBhIHRhZyBhbmQgZm9yZ290IHRvIGFkZCBpdC4NCj4NCj4gSWYgeW91IGRv
IG5vdCBrbm93IHRoZSBwcm9jZXNzLCBoZXJlIGlzIGEgc2hvcnQgZXhwbGFuYXRpb246DQo+IFBs
ZWFzZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5n
IG5ldyB2ZXJzaW9ucyBvZg0KPiBwYXRjaHNldCwgdW5kZXIgb3IgYWJvdmUgeW91ciBTaWduZWQt
b2ZmLWJ5IHRhZywgdW5sZXNzIHBhdGNoIGNoYW5nZWQNCj4gc2lnbmlmaWNhbnRseSAoZS5nLiBu
ZXcgcHJvcGVydGllcyBhZGRlZCB0byB0aGUgRFQgYmluZGluZ3MpLiBUYWcgaXMgInJlY2VpdmVk
IiwNCj4gd2hlbiBwcm92aWRlZCBpbiBhIG1lc3NhZ2UgcmVwbGllZCB0byB5b3Ugb24gdGhlIG1h
aWxpbmcgbGlzdC4gVG9vbHMgbGlrZSBiNCBjYW4NCj4gaGVscCBoZXJlLiBIb3dldmVyLCB0aGVy
ZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRvIGFkZCB0aGUgdGFncy4NCj4g
VGhlIHVwc3RyZWFtIG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZvciB0YWdzIHJlY2VpdmVkIG9u
IHRoZSB2ZXJzaW9uIHRoZXkNCj4gYXBwbHkuDQo+DQo+IFBsZWFzZSByZWFkOg0KPiBodHRwczov
L2VsaXhpci5ib28vDQo+IHRsaW4uY29tJTJGbGludXglMkZ2Ni4xMi1yYzMlMkZzb3VyY2UlMkZE
b2N1bWVudGF0aW9uJTJGcHJvY2VzcyUyRnN1Yg0KPiBtaXR0aW5nLXBhdGNoZXMucnN0JTIzTDU3
NyZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDDQo+IDBhYjAxMGYwYTIz
NDQxNTdiOWUyMDhkZTdmMzVmNjg5JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2DQo+
IDM1JTdDMCU3QzAlN0M2MzkwODgwNjY5MDA1MjMwMDclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4
ZXlKRmINCj4gWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhh
VzR6TWlJc0lrRk9Jam9pVFdGcA0KPiBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mm
c2RhdGE9NGREdzRHSWlFVndSam5aaFlnZkw3c0ttDQo+IHVkamNzOGNpREtpMDIybjc4elElM0Qm
cmVzZXJ2ZWQ9MA0KPg0KPiBJZiBhIHRhZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFz
ZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCj4gPC9mb3JtIGxldHRlcj4NCkhpIEtyenlz
enRvZjoNCkkganVzdCByZWNlaXZlZCB5b3VyIHRhZyBpbiBbUEFUQ0ggdjMgMS80XSBhdCA0OjAw
IFBNIGFmdGVyIEkgc2VudCBvdXQNCiB0aGUgdjQgcGF0Y2gtc2V0IGF0IDM6NTMgUE0uIFRoYXQn
cyB3aHkgaXQncyBtaXNzZWQgaW4gW1BBVENIIHY0IDEvNF0uDQpUaGUgdGFnIHdvdWxkIGJlIGFk
ZGVkIGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo=
