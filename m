Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BD1A7264;
	Mon, 23 Mar 2026 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232625; cv=fail; b=EGeGigd1kvM4wcUfXhWkp3DyL1kRHuN3698hPzOygQssYs1E5xvle21d9zC3DgNm5M7G5z6otnuKbbXlGHSFu8lUrs2aWceo03sCITIAeaW3CBMXcEPbLoa8oMZBLnFKm+WWd+dWyeQeyHeFRs5pL6wMACrBXBf6DcBa32lalEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232625; c=relaxed/simple;
	bh=TjaQgV9coganeMcfMVvP6t3Vnvkbq53uz2IvNIetMmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDSDEYynxh5/Rvy+LgvhiudprLs+QgLJks5HO4ErfinK/yx0iGkvxph/WzD3p9p75Qzv1gP++s3cydE9mM/K1+HCeVBcDXiOelZK8yoyydeKCqS+xBdfaGdGknbHTq+QJkxLQgMehbdXVvtots4ofaPhLMg5q7DCYWHSpubRHBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fqklnjYq; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqklnjYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeR7saTAj/nKD4lbeygwz1/NJZX8mdzwTquWKxqhm4rvZb9T9Jnh5TQjZ65hRRIetvV4xitoldXY8KTyUqIsbV2+TMy5NgHeAPLnhjqrW3hR4koCB4JkEsxTjiBD3Vhn9jxuHO9IDVeaj9x2YHrn3u8Iu1Yf61sbtXGZfRqmvySmKTRUTkSHJkAuX0qoy3SUyCGF/K++PVhJVRZUkfKJHz2xlFwCsLks5tuPPZLCPlc3HLrkGOamNcr+5RCQDB0rXJpDRZmSfxlvVoIx1Dkp2skyMqz7N+LkkT9FeY6yoXQXT+x4c+zqrevJYl+CBhnv60O4dNWGjctK9PdfeBAXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjaQgV9coganeMcfMVvP6t3Vnvkbq53uz2IvNIetMmc=;
 b=LYIoAEu84ft4LVzrVbJ5ygexES+4cPGp+HS3GUGHJ5BYMg1ba4Zw5Qd81xh9vuGGdujS49jrXx9BfS+N+pUyPL4jJF8dXngQ8avd874PR6z8pPrZ4psLoiE5URrNwBSNXJyoyIuGeHjk22k0M+sNHF1Wk1h35QFU7WAcR442TDc4CmRT+iOe9lGLvMqpoN+1GFPG1o4BVeVovnZQE/WApC3veNNMKk0GS3ASCIWoig9U/s6rXvRbsghUoBbVO3ZidjqESfeXIk0TUW8UlD/jQCjxOHtvYgcXXk1rQRyvsJYF5jho1/B+XRJdH94Kj1C87bpMK4ZYuF91wOKrpniBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjaQgV9coganeMcfMVvP6t3Vnvkbq53uz2IvNIetMmc=;
 b=fqklnjYq+VJwgz+2zlE13XpFaPsI5hNDP+Y40pD9be6n/uoCa2QaIkXg1KG03WidDC6MsWCqqeqFtTuTxxa5ALQbpqXjG/wsC/urS63UsqTwpWTXTiuFLLWpRhWyZKgNedXmG3ZugVnhPBNBSdDuEapu9sgvzW17XBEGfr573oy1J/TOLHM/a+1fX4x38NJ8bnhIXcPUys42KaQiLVvBN8LnMn3z0+D4dDrnSSx+D5HEJHSGnl9OMOeIc8RknLKhp+P31tc8nrb+ClSKb80WFDprSLLz+BCwS3niNVapXAPDnil6tM+2lHrvuzNGsbipfgcejsgLmIkqM+oiIGOA2Q==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 02:23:26 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 02:23:20 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
 i.MX943 PCIe compatible strings
Thread-Topic: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
 i.MX943 PCIe compatible strings
Thread-Index: AQHcssQPUmBHcrX15kCO8vWYYBOb8bW7PH+AgAAu5QA=
Date: Mon, 23 Mar 2026 02:23:20 +0000
Message-ID:
 <AS8PR04MB8833815B161AEAA3648DBF908C4BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
 <20260313083443.2391254-3-hongxing.zhu@nxp.com>
 <20260322231003.GA69234-robh@kernel.org>
In-Reply-To: <20260322231003.GA69234-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PR3PR04MB7484:EE_
x-ms-office365-filtering-correlation-id: ecc3dd62-6e36-4e47-7d72-08de888326c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 XmsIrDL0k0L/VbLo7oK/438GiMD4PEK/XHNFECNJCLgVnld5ZjYprfPN8lGwtjU++62tJ2rAU239a7FHzGGlaGFD0Y8YZae6YBLqhIGtwAiujxPaltK+mjeCDnGnts4srrP0v3HZtAyPkX1GjJciETbrJXtHf5YB3Y6WTrCWzJ0fosuh1hBauNHrThXbDYVCffP0OF80w+NEQqVDPMs664PM6HNVXXWHj3WaqySLiGNp8f+rG/MPxzpcJZV0Tfxg2FDpIOh10Yk3AoaaqO5HM6FifiOtZrgCSRC3/pHWhe+NvthrKXoRpn6bwO9LinesQPKEGAl1lNCkAjrViNgxS0N+weJdfZ9RlVqjLLDdNYh9v6T2E8912gHOTMC7WCTdtMTOVi00xAg2mqA/H7E7Cg3anzCZ+alCV51HGt0jC2iVxa6LLepCAd/2rpC1x9dyXkWKG60cKlLmPBBPOQiGR6vktzjvr9Yx1NDZj9ttHKnNQjysZatpXCOVIAAPjbbA8wla1M7hxD8S0A7PkFXXQN5++BA26ag/7qleNtdxEXdhBwR+v2jw+6xgVUKE6AzJEy9idJHQvDV1H1Yz/FUh1TzdjeG4gTCYp/01Yk+ZwKqPYP0zJyiOTnt6k6U/H55BpbeazoWFtJuRJ0eIocPP2qr6xwVr3XDG994UpnFkBbKwXAVG3l2g80AwJU0Sx7gEH3Em9ePDqUtEoXv33Bs0zqL1yMXxhc9aA+Lyt6rnZEG3jUHLMU6Gi371myVAr0JvTOE7IVCPCtuvZyTuwXQt/09xs9P94g6vw6WKyeuie5E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Z3BqSXNIK2RqOGdObHlZdUxqaTRpampCcmFSdk1nMHQ3dWFsa2xQUVNGN0FO?=
 =?gb2312?B?V3ZtUzBnNXRFSFV0VkN1eEVxd3pyMGtTRm1NRmxINEJKd2pKcUpTQmsvRjlp?=
 =?gb2312?B?bTB3SUdYZno3NjhxdzMxTkpsU2pOcXVtYVN6YTNiVjRvSVVLY2dydCs5QjMr?=
 =?gb2312?B?SXpzK0d1eUNwYU9iRDRDZ2pTRmJHa1k4bmswV3BkVEdsNk50bmIzL2cvWFIr?=
 =?gb2312?B?dUx2MDNIRmx3NGZ3MUxlQWRMTS9uaTlWS2lsYzg3a01UV2Q0M0J1VVFLTVcw?=
 =?gb2312?B?Zjh4OElwSnhZU3hQZEV5TGJaMncwMnR4dFFjNVRVd1IrRXc2OVFuTkNlcUYr?=
 =?gb2312?B?aUhwQkhGUVl4NTZlL1ZWR0JSRi9PQ3o3UEdFQjhkRlh6akF2YTNvSDRiUTF1?=
 =?gb2312?B?R0dRTGFub3BRRDFXTkllQXg0TzBTQ1ltMDIvTkNsOHE3Y1VnWC9zSW52Q2or?=
 =?gb2312?B?dTM3VGViTCtINC92dGllcUFTOFplenB4RmVrRlhMM2NUVFBpZDA5czBETExH?=
 =?gb2312?B?UUdKdWFsa2NDN0QwVnhZOVZxZTQ0bWF2VmxFMDFpbThaWWQ2amVXZFJnR2NN?=
 =?gb2312?B?MmZoVW00bXM5MytzcTRIQnBzdDhVcXU3OEg1RDE2bnVsODJHakQ0NlRyVVJV?=
 =?gb2312?B?NUc2MmdsTllDTmNhRmxQL0RtYWZ2b2gzQzkyOFB4U1QvOEcxL1pDN0hGRFBT?=
 =?gb2312?B?OEZnY2NJZmRHWHBDYUY4MHhrbHhxV2ZGb2M1QkFFNEZSZEpEVlhTZDNYaEIz?=
 =?gb2312?B?YnJqWE9iQVQ1c2lPTjVSY0QvTjVyaGkxdTBVNWRlK0w3MHNHWnpsbFk5UkFV?=
 =?gb2312?B?eTIrZU1SaksrNUlmNi9SeFE2RjYxQnhUTFgya01jMVdNOHoxTnBQZ01EMUd4?=
 =?gb2312?B?NWQ3RUJIVDlUVHZVWFBQVjl2ekNXcHdGZDVSVkNIT1RPbkVObW5mOEVhUjZQ?=
 =?gb2312?B?dExwTWVGZURaTVh3VGVNUEE5OEgyNkV4aHFpdTRvWU1yY1ZKKy9KYm9ielFu?=
 =?gb2312?B?S0dCZTBRTnhXZFkrQjd4QTVxenVVUm0vU3hKbGtuNFVSeFdqNHhHUnBmK0JI?=
 =?gb2312?B?TUFuQ09mK2M2VE5uNGt1YUdBTjhUSXAwQkJPcmdjZllJQ0RhZnEzc0FLWHdj?=
 =?gb2312?B?ZFFsY0tNVkQ4Qng5MXZoa2FQay9tbE9tMXc3QzV4Wm1paWhJL3dGUnZEdWti?=
 =?gb2312?B?N1VMQ1ZvZ1ZkZVB2cFlmRDd2bU5WZ21yQ2VvdVN5L21mR083Yk5aS1NuR0lR?=
 =?gb2312?B?MHdJeUh0Tkt2d1MrT1ArYitDVSt0ektiOFpEcENEWlM1M2VNMG9IWWVuMDZu?=
 =?gb2312?B?WVBxZ2NBNDdGT3ZjeEFRK1U5K2s0UVdNdUd2UFFVWTZ3NEEvamVIZ3N2RGlt?=
 =?gb2312?B?cDA3R0RENGlZVllnZHpmeVBxMitqZ1p6N0JKSC9janQ4NDVBVnBVRWZiMmIr?=
 =?gb2312?B?TC9jTUtNajNBYUZ4eXlHeThyMTdBMnlJVkM0Wk9kTWhJdjBRczJpcGdDeHZD?=
 =?gb2312?B?NUpRNCtxeUtkQ2pFdGk3a1lWeXBQK1NSOHdLYld0N2FNMXNudkhqUEdWZG5B?=
 =?gb2312?B?dWlGK3dSQTU2Wld2bTlocnBmSk52aEowTysxbU4ybkFaK3NhUnVUQnhkb1p0?=
 =?gb2312?B?bklJTTNKdUR4c0duT3ExSXNIcXFzY3dHUExoQmJPNU9GOEFFcThOeWxxREdK?=
 =?gb2312?B?dHJrQmdoNXYrdjNsOEpOSG5RbHBYeHdmeHFaaG1yU21CbGxhdVpadzdNUnJW?=
 =?gb2312?B?WXo2Z1ZCY3picmUybXlhc0laWGlOMEY3WDRueXB4NE1IRWM1UDRJRi9YTkZ3?=
 =?gb2312?B?NUJOOGREZFlLN0w4Uks3OFR6dXIrS1ZRTGU4akJtWnowamZ2bHF2aE9BWW5E?=
 =?gb2312?B?TzJSQndWYVpQMERJM1dlREw1aWx6NHJnZVNzeU9WQ1JPdWQxcjNVL2xPOVlW?=
 =?gb2312?B?aU9qWnhYWWJVRytoaTVyZjBZK0pIYTQvM04xRUdCbmhDUDNFcEFnSWZnNHZw?=
 =?gb2312?B?cjdnRTE3OVJ0YXFTejZJVUh3eG9YRHBiMlViTkpzUEpPNzFXMVhiSGRSTk42?=
 =?gb2312?B?MTlCMUw0ajBsRVVBQlY1bXBZdkJ6QjlZODAxcEl1dWI0ZGEra1QrZmlPa3o1?=
 =?gb2312?B?bm10enNiOHZ2dmM3NE5ybk8rYVkya0gyVFZ3emx3eUhjZ1NCbzBwRXJDaTRL?=
 =?gb2312?B?SGpBVmRUbE1CYktFQ3dOVkVhV2lqbEorcVdQYzR2aHFKMnZvTWl5anV0bDhE?=
 =?gb2312?B?eURHSlRDaVlQem0waUcyVUs1ZzJDcmVveWNnV2x2R3JBTVlMQjVMZ2krdDZh?=
 =?gb2312?Q?uZ5exYDaKOAJvLisa1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc3dd62-6e36-4e47-7d72-08de888326c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 02:23:20.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puRocLANIO/KYLoW+G6uLiCXOTxUH+3aRqqpxgWk2ytkd0em9O3wNxMJFwe0XlWjd+Uk04ki3iJlLe7zPbxfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI2xOoz1MIyM8jVIDc6MTANCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9y
K2R0QGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IEZyYW5rDQo+IExpIDxmcmFuay5s
aUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3Jn
Ow0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGlu
dXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjcgMi81XSBkdC1iaW5kaW5nczogUENJOiBpbXg2cS1wY2llOiBBZGQgaS5NWDk0IGFuZA0K
PiBpLk1YOTQzIFBDSWUgY29tcGF0aWJsZSBzdHJpbmdzDQo+IA0KPiBPbiBGcmksIE1hciAxMywg
MjAyNiBhdCAwNDozNDo0MFBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaS5N
WDk0IGFuZCBpLk1YOTQzIFBDSWUgY29tcGF0aWJsZSBzdHJpbmdzIGFuZCBmYWxsYmFjayB0bw0K
PiA+IGkuTVg5NSBQQ0llIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4v
YmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWVwLnlhbWwgICAgICAgfCAyMCArKysrKysrKyst
LS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbCAgICAgICAgICB8
IDI4ICsrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWVwLnlhbWwNCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWVwLnlh
bWwNCj4gPiBpbmRleCAwYjM1MjZkZTFkNjIuLmIzYjFlY2U2NjgxZSAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWVw
LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Zz
bCxpbXg2cS1wY2llLWVwLnlhbWwNCj4gPiBAQCAtMTgsMTIgKzE4LDIwIEBAIGRlc2NyaXB0aW9u
OiB8Kw0KPiA+DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAtICAg
IGVudW06DQo+ID4gLSAgICAgIC0gZnNsLGlteDhtbS1wY2llLWVwDQo+ID4gLSAgICAgIC0gZnNs
LGlteDhtcS1wY2llLWVwDQo+ID4gLSAgICAgIC0gZnNsLGlteDhtcC1wY2llLWVwDQo+ID4gLSAg
ICAgIC0gZnNsLGlteDhxLXBjaWUtZXANCj4gPiAtICAgICAgLSBmc2wsaW14OTUtcGNpZS1lcA0K
PiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gZnNs
LGlteDhtbS1wY2llLWVwDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg4bXAtcGNpZS1lcA0KPiA+
ICsgICAgICAgICAgLSBmc2wsaW14OG1xLXBjaWUtZXANCj4gPiArICAgICAgICAgIC0gZnNsLGlt
eDhxLXBjaWUtZXANCj4gDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg5NC1wY2llLWVwDQo+ID4g
KyAgICAgICAgICAtIGZzbCxpbXg5NDMtcGNpZS1lcA0KPiANCj4gVGhlc2Ugc2hvdWxkIGJlIGRy
b3BwZWQgaWYgdGhleSBhcmUgY29tcGF0aWJsZSB3aXRoIGlteDk1Lg0KT2theSwgdGhlc2UgdHdv
IHdvdWxkIGJlIGRyb3BwZWQgbGF0ZXIuDQoNCj4gDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg5
NS1wY2llLWVwDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+
ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OTQtcGNpZS1lcA0KPiA+ICsgICAgICAgICAgICAg
IC0gZnNsLGlteDk0My1wY2llLWVwDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14OTUt
cGNpZS1lcA0KPiA+DQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAgbWluSXRlbXM6IDMNCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14
NnEtcGNpZS55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9m
c2wsaW14NnEtcGNpZS55YW1sDQo+ID4gaW5kZXggMjFkZGE4MDY2MDE0Li5mZDVmN2ZmOWM0YTQg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9m
c2wsaW14NnEtcGNpZS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gQEAgLTIxLDE2ICsyMSwyNCBAQCBk
ZXNjcmlwdGlvbjogfCsNCj4gPg0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6
DQo+ID4gLSAgICBlbnVtOg0KPiA+IC0gICAgICAtIGZzbCxpbXg2cS1wY2llDQo+ID4gLSAgICAg
IC0gZnNsLGlteDZzeC1wY2llDQo+ID4gLSAgICAgIC0gZnNsLGlteDZxcC1wY2llDQo+ID4gLSAg
ICAgIC0gZnNsLGlteDdkLXBjaWUNCj4gPiAtICAgICAgLSBmc2wsaW14OG1xLXBjaWUNCj4gPiAt
ICAgICAgLSBmc2wsaW14OG1tLXBjaWUNCj4gPiAtICAgICAgLSBmc2wsaW14OG1wLXBjaWUNCj4g
PiAtICAgICAgLSBmc2wsaW14OTUtcGNpZQ0KPiA+IC0gICAgICAtIGZzbCxpbXg4cS1wY2llDQo+
ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBmc2ws
aW14NnEtcGNpZQ0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14NnN4LXBjaWUNCj4gPiArICAgICAg
ICAgIC0gZnNsLGlteDZxcC1wY2llDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg3ZC1wY2llDQo+
ID4gKyAgICAgICAgICAtIGZzbCxpbXg4bW0tcGNpZQ0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14
OG1wLXBjaWUNCj4gPiArICAgICAgICAgIC0gZnNsLGlteDhtcS1wY2llDQo+ID4gKyAgICAgICAg
ICAtIGZzbCxpbXg4cS1wY2llDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg5NC1wY2llDQo+ID4g
KyAgICAgICAgICAtIGZzbCxpbXg5NDMtcGNpZQ0KRGlkIHRoZXNlIHR3byBzaGFsbCBiZSBkcm9w
cGVkIGVpdGhlcj8NCg0KVGhhbmtzLg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiA+ICsg
ICAgICAgICAgLSBmc2wsaW14OTUtcGNpZQ0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAg
ICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDk0LXBjaWUNCj4gPiAr
ICAgICAgICAgICAgICAtIGZzbCxpbXg5NDMtcGNpZQ0KPiA+ICsgICAgICAgICAgLSBjb25zdDog
ZnNsLGlteDk1LXBjaWUNCj4gPg0KPiA+ICAgIGNsb2NrczoNCj4gPiAgICAgIG1pbkl0ZW1zOiAz
DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0K
