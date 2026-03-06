Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12012512C8;
	Fri,  6 Mar 2026 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766594; cv=fail; b=o2yZek1hCBthyOePYOaWFEfujJbr+5+1eA8DGIuhIGlHC/OOqbdjJln5F0IN3BRcLmkCM8UVFL6pcNrJlTMljbSkdqcgxwf7H831Z/GoyFt0LT3gcusU9v5QRGgCJBL+b44L1zOM4zWU4VnIryGewPNjs/dLUmiM26/8M5RnEEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766594; c=relaxed/simple;
	bh=6OlMU5YzaBmFtGYPyS8WHE4rS0K+20biAGhuSpXadZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWUR581E2JBVwE4kT8dUaf4Tl9SWMVnyAUmvkd6NJUkbAphdE54SvBP2u89onRKGTb63gt5imNiHna7Y7sjWonM4VI64DhMpjA5Wk7pWVo1F4xTMrO0m3AxLjb6KoW2L4+GsPPz14jSWDsGB9fR1Sj3cugI0g9g+IalWcpZ73aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMI0uLSU; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMI0uLSU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMbKrvH4byPXXXQFOAnbtgPkqDnzAfOKpWDhafiShpEDC+pCT9wHL9I4M1d4jbaF2Jj6aAQOd+bw1dr/0owLlIsmHn4ojdu8ryMumIqfewdRowlwg1E3DRa6GrBgFSLQ/OWNJJEesziPFSHl3M/bFjlosonTYp+XKrtLmNHIzREMl5m0+F4sp5iHu1Zd+GZ0c427jA2HqoRyd/tkkkoRAWybIC50NdhXBmNxC+UdlO9Nh6mT4pXaRmpd1OI7aBn8oh1sibjoQqGLiAetg2ZUKNToppwRge6uguaPj9r8hEKIZdh6NALychR0yQIdT7j9s5NY8+3bT1udgViUaHtIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OlMU5YzaBmFtGYPyS8WHE4rS0K+20biAGhuSpXadZc=;
 b=sga6Nqsqo2hpSQ/HxhybkuQ8UxBbffw7NPkxD6rRWQDuIZmk6i0zp8tpXSrwePWswJOGQtZPU+G9UCfCGwL5Qt4hPXeIhYd8gJgOB7NBGpz/pDh9KWCn1SEOlpI+sf0INCht0H32BlbzOe2OV6QHuGz4ygtNsEpKr8HOB0eBL+LEk/HLnzf+Ojsb38UQUw4eeLtLZ4nkAYX6WyvdSVKZQi0Y4wS/PU9OOEq0eKdCYePMYxYVtXIX30jrbisubDHfmhxU8an4OOsA07Wo8w6PmcwpJ0GTTrH4Rw/rgl4BApnqg+sfm/CWOpHwzrRXh84MzjpPjC/QNuyBbE1aE0/hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OlMU5YzaBmFtGYPyS8WHE4rS0K+20biAGhuSpXadZc=;
 b=SMI0uLSUKbBdlZu8IvDpqgELbqDadL1HAQTX9eDKgixl6A469/+OL54JJofSqJD9DhcSrhxOUjMm2iHUEdaxHdRFQiQucax+2brEB+eOMD5mt7gdcJ2YaTTq+R512GBJkejYPUOs6ZmN7pnZxOHPv9i7ENhw+n3uLAaovGnNwOS5Z2Bu5bVKSaTdhCeuydSdccbQdzTv4ovixFqpXp76n0iS4XXwt1O05QpIVDxerrS7YFTI4a+0z2t/ByCAatqklVeirS67c6XX3DrRZ+9o7UYOU4mRF/UDuRlqFbl9ATlTSaBij1ezDQdsPGFT74dLi3ij5uqkcYUv+Sxsn9d9Xw==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Fri, 6 Mar
 2026 03:09:49 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:09:49 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Separate PERST# assertion from core reset
 functions
Thread-Topic: [PATCH] PCI: imx6: Separate PERST# assertion from core reset
 functions
Thread-Index: AQHcrRXavyr/mXQEAUSFc90OcDmEEbWg0sIg
Date: Fri, 6 Mar 2026 03:09:49 +0000
Message-ID:
 <DU2PR04MB88400A428E953BF196D9FE348C7AA@DU2PR04MB8840.eurprd04.prod.outlook.com>
References: <20260306030456.1032815-1-sherry.sun@nxp.com>
In-Reply-To: <20260306030456.1032815-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|AS1PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: 05bd3dae-f209-4210-72a0-08de7b2dd3de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|921020|7053199007|38070700021;
x-microsoft-antispam-message-info:
 0fStnC5RfRzpl7M1XyTGiZzxmMtsv2m+8xCjMMAq2PlUrWZheE+JXEMBgQj7VkfNlExIBUfWJsbmNO7SiCP/Ycq5740TL1MMkh2YmewvvPreoy98yPxe3E5C0XAN5+dtqGJYTDrpio9axcXk7T87dTYlKu5TXVLe4d6n5Pr2fz5gRtx/XQCt4Q5+aCPjYv8/ZQFb84b8OzGa5tJjc4/2sEd+nqVsw4SkRx76rRq5APPXtQgMnTDF7TfMxx82gZRSs0fWP5U6/6qVKZXx2TiXxckswjxyA9EbaLuBQp7PiHsWAK0I8S+IYmOcDpi67n4Ca0qILDMFFGGQRIH8mZ84ZNKKx7CuXILxvb4U7V99wTtsEZeq62nwzan8+NHPUlCsnB6jg0ganUJiGFSVSkIQd0wMMPGyIBv97TttFbApHY3xgdS6ReEmyLliH1/BM1vFcaGNARAK9iwBhRDyhX01F8ysvf6nJKzW7wycvfB9n7r7Hfp4WcHYKSCHcT7xyeHn08+V/MbksncfZnGroH8T2glMYji9X/V8jVAvA6f2oydOrLj9EPOj+ptxIQ0A5nws3c2Z3m8mfLUgDEOAml8Tqoc7u6fR0goQf/re2+twkfZ84KHrNFUO28UIUKD73JXWPFopyDB6fKxF2sKp9aP0zdr9bSXJ/5iPEdszyjhY5NFLDoS1qwF2xA7Yvkq1yvH6yR8hC/33UFGCk108NFuBUZCRcN+M77S8+yIDTu7gif6oo7R77S//aA/fJW4HNXmzSt5oveGvouZ8kKILA84w4aVxHwHW/BbSGJHug1O+g/JwZlDyHbCHB79zOtUvbJTs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ckNmbzNlbUdVNWcrckN0bHpaeTR4YXBrOW5lU3Y0a3I2L0pDUTZGYXFIa3Br?=
 =?gb2312?B?ZHlTZjh5S0JseXFpUjlsemVpeWFXYXZEUXcvYVVkamtid2VnWkIxQko5T3kr?=
 =?gb2312?B?MmRyUnBDS2wveUVGM3IrdXAyazViemtmbWQ5YlhKdCtEUVYwRzlPME9ON3pT?=
 =?gb2312?B?VWY4ZEk0SVVBc3daNVRaYXhkeEF1bFI0bWFObWY3RzdTYVQ0anpNZ1NUVGhR?=
 =?gb2312?B?S1F6U1hrbG1vNmVVUHZBN2xYc3duMmlOTUNxZlRqSkdoVDM5emUrbHJSNkd6?=
 =?gb2312?B?S3JuL1JDa3J4a1pXdFRKRElPQ0NXM1VWZFlxUXFLZjZkS0F6Y2ZiVE9QOFBG?=
 =?gb2312?B?QUVsT3JVTERFVmp3UFhld1RUdG1lQmlMMk01WE83Yzh5cHBNSitWcmtwWWMy?=
 =?gb2312?B?QzUzS2RaWjk4N0RmSEpzSzhmOFBYQ1Y5azROVkdrVVFYVjczT1I0dFkvNmV4?=
 =?gb2312?B?MVhWK3BqLys3dnlydU42Wm5YcVNtTmV1OWhmbVBnb0Z1SCt6bldpaHZWelA3?=
 =?gb2312?B?dVhBRnRZT0FwSzRNWCtvZGxwdVFSYlgxeHlwc0pBdzR5NGFYUVlTblhvYnpy?=
 =?gb2312?B?NHpMSlJWZ3BwNmZoMlc2Nm03bW52aGc3TnptcFNWa0RweU0xQlhRNmU5TEU0?=
 =?gb2312?B?cXJIR0N1SEEzUjY5WlR6UEZ4VmM2WG5kY2FtRy9qOFBxaUpVbWdHVFpPZHBU?=
 =?gb2312?B?ZVNIOEJBL3RLRWJ5bWZJZ0Q2djlFeTFORmxCazRDZndUWEl6TE1OL0Z3Qld2?=
 =?gb2312?B?ZTVZRGJKZy9sTHdyUklJRThaQmZQbEJlNVdjWmNvN1pwSTVGMHJKVlhhaHl6?=
 =?gb2312?B?Q0FQYk9TR1A4aDFTVUxrUTRhYUVwelB4bVpQT3JOdUlXNXpGT0ZTYlEvWkd4?=
 =?gb2312?B?bUxtMjZldnExdUUvVENTR3R2L1RaZ0xwM21Ob2x3Uit4K2NMQlBhMFliM2NY?=
 =?gb2312?B?TStQR1doVEZ2dDZMVEJnbGpKR29kQmJoc0Z1bG5GdU1rYVNtcGFEMVdwOEwz?=
 =?gb2312?B?UTl0cTF0TjVxK09sU0d2QUtvY2VNY0RCLzZCTzdROG90NmcwV2NMS2dzTkx0?=
 =?gb2312?B?WUNlTjJQa3pPc3VuQ0tqdTdtOU84aVZ4Nnc3OVc5cjRsZWZVZnlsYitDTXdj?=
 =?gb2312?B?enJPZVIvZDVJeklQckRYbkF0MVlWR011WWdRd3VKSnl5S05UdFpVWFUxZi82?=
 =?gb2312?B?RVpuZGlOWVZSMnNHaGowakZHVnhSWndpaFBodVY4WTRlT1NrY3RpdkVXY2hk?=
 =?gb2312?B?ZlprNmg3ZVVjU3lKMUsrRXh6RHNFdkRlcm1sTk5aajcvZmdzNW5BWnhsaTVW?=
 =?gb2312?B?YnV6ZVhybStPVnZXQzNTZXVhQjh5eG9JdG4zZlNtTml1WllXUW05eWxsbGZ0?=
 =?gb2312?B?VFBmWEhOakxGZ2dJR3NubWlPUi9VYVVPR2hSd3IyVUtjVjlCMkJyM00yRFc4?=
 =?gb2312?B?L2hzNHhtUUFFbnNQOUI5cXhPWUZtczBrVXF5ZWtFTXkvKzBKTkJyYnh2OHpH?=
 =?gb2312?B?dTFUWnlGTGFrVE53Sk1HUWZ4L0VhY1EwU2Y2Ukk3dHk1K2JyMkczc3FQWVp2?=
 =?gb2312?B?WE1TM3NZK3FkUG5XREhLQ05PRDM4d2I2b1hvL0g3bXp4djF2MVJ4OWl6SzRx?=
 =?gb2312?B?aGFkei9WRndmS3BWTE50L2VDaU9FM1dZYzVuVTVDaXREcDJIejJHeFRTOGda?=
 =?gb2312?B?NHhlR3hpemFtWWVYWGs3cXVDNE5WSjcxdTRneklhSjhyTnYvVElmT3FaR3la?=
 =?gb2312?B?M0JxSzJaVk9IdXpxeFc5VW0wVHpIRDlSRXJ1OUt6VnpnVnBJM1p3Vk9pTGlL?=
 =?gb2312?B?OXRWTDYrSTZxWVBITVBDTi8vVGNBK3czRk5xc0NmSW92eGdrQ0xLbUZxYjhm?=
 =?gb2312?B?NnFLQWplK1FMVVdJZHdVdEU0VTFhWXBDak4zMW4vSkZMbVNrV2xWaW5UYXhx?=
 =?gb2312?B?dzlMMXYxTkxERkk5WjRvQmtLYXZxbWpFNEdlQWEySlMvSGJFWldKYkpXc1Qx?=
 =?gb2312?B?SS92RFFzM2dLK3kzbHZIZXBqUFN0TGtpK1lEdEljdTVHcEtTdEJma0dsWDFJ?=
 =?gb2312?B?R1hBelRSWlNLaEdhMzUvRk9NZTMrM0p2NkxiZEtDZ3AzVWV1bXlUTkU0TDJv?=
 =?gb2312?B?VWoyZVdiWlFTbnkzMFl4VFdBTk9LYWRZdXZ2NkQ4MS81VC81TG9GdkJId0xZ?=
 =?gb2312?B?TkNPS1hhWi9SYmJsdFExZ2MxOXZYS0VZSHlVZjZPSmVMSVl2VTF2Uy9OSk12?=
 =?gb2312?B?cFNGa2YzeTBtT1hjdVdVQmdmZFU2YXc1U01RdWFoVS9hSmc5ZThrcHk3VkpF?=
 =?gb2312?Q?DG9xXINAGhPtrcjVDN?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd3dae-f209-4210-72a0-08de7b2dd3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 03:09:49.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9qVFsNpoRgrSuVhaB3k95rj8Ui5fWIzvZls2ARsFrhnuP1UIDxLjwqi4iWFPXp6YtoIsXtBoP6vwHGjUuPmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9431

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuIDxzaGVycnku
c3VuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjbE6jPUwjbI1SAxMTowNQ0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IEZyYW5r
DQo+IExpIDxmcmFuay5saUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7
IHJvYmhAa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tDQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFU
Q0hdIFBDSTogaW14NjogU2VwYXJhdGUgUEVSU1QjIGFzc2VydGlvbiBmcm9tIGNvcmUgcmVzZXQN
Cj4gZnVuY3Rpb25zDQo+IA0KPiBUaGUgaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBhbmQg
aW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpDQo+IGZ1bmN0aW9ucyBhcmUgcHJpbWFyaWx5
IGludGVuZGVkIHRvIHJlc2V0IHRoZSBSQyBjb250cm9sbGVyIGl0c2VsZiwgbm90IHRoZQ0KPiBy
ZW1vdGUgUENJZSBlbmRwb2ludCBkZXZpY2VzLiBIb3dldmVyLCB0aGUgUEVSU1QjIEdQSU8gY29u
dHJvbCB3YXMNCj4gcHJldmlvdXNseSBlbWJlZGRlZCB3aXRoaW4gdGhlc2UgZnVuY3Rpb25zLCB3
aGljaCBjb25mbGF0ZXMgdHdvIGRpc3RpbmN0DQo+IHJlc2V0IG9wZXJhdGlvbnMuDQo+IA0KPiBN
b3ZlIHRoZSBQRVJTVCMgR1BJTyBoYW5kbGluZyBpbnRvIGEgZGVkaWNhdGVkIGZ1bmN0aW9uDQo+
IGlteF9wY2llX2Fzc2VydF9wZXJzdCgpLiBUaGlzIG1ha2VzIHRoZSBjb2RlIG1vcmUgbWFpbnRh
aW5hYmxlIGFuZA0KPiBwcmVwYXJlcyBmb3IgcGFyc2luZyB0aGUgcmVzZXQtZ3Bpb3MgcHJvcGVy
dHkgYWNjb3JkaW5nIHRvIHRoZSBuZXcgUm9vdA0KPiBQb3J0IERUIGJpbmRpbmcgaW4gc3Vic2Vx
dWVudCBwYXRjaGVzLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaXMgaW50ZW5kZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQpSZXZp
ZXdlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDI5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IGJhNmU3YzdlZTYyNS4uZDgwZDNiZTI4
ZWU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTkw
MSw5ICs5MDEsNiBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1
Y3QNCj4gaW14X3BjaWUgKmlteF9wY2llKQ0KPiANCj4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEt
PmNvcmVfcmVzZXQpDQo+ICAJCWlteF9wY2llLT5kcnZkYXRhLT5jb3JlX3Jlc2V0KGlteF9wY2ll
LCB0cnVlKTsNCj4gLQ0KPiAtCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBH
UElPLiAqLw0KPiAtCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChpbXhfcGNpZS0+cmVzZXRfZ3Bp
b2QsIDEpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIGlteF9wY2llX2RlYXNzZXJ0X2NvcmVf
cmVzZXQoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkgQEANCj4gLTkxMiwxNCArOTA5LDYgQEAg
c3RhdGljIHZvaWQgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gaW14X3Bj
aWUgKmlteF9wY2llKQ0KPiANCj4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVzZXQp
DQo+ICAJCWlteF9wY2llLT5kcnZkYXRhLT5jb3JlX3Jlc2V0KGlteF9wY2llLCBmYWxzZSk7DQo+
IC0NCj4gLQkvKiBTb21lIGJvYXJkcyBkb24ndCBoYXZlIFBDSWUgcmVzZXQgR1BJTy4gKi8NCj4g
LQlpZiAoaW14X3BjaWUtPnJlc2V0X2dwaW9kKSB7DQo+IC0JCW1zbGVlcCgxMDApOw0KPiAtCQln
cGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoaW14X3BjaWUtPnJlc2V0X2dwaW9kLCAwKTsNCj4gLQkJ
LyogV2FpdCBmb3IgMTAwbXMgYWZ0ZXIgUEVSU1QjIGRlYXNzZXJ0aW9uIChQQ0llIHI1LjAsIDYu
Ni4xKSAqLw0KPiAtCQltc2xlZXAoMTAwKTsNCj4gLQl9DQo+ICB9DQo+IA0KPiAgc3RhdGljIGlu
dCBpbXhfcGNpZV93YWl0X2Zvcl9zcGVlZF9jaGFuZ2Uoc3RydWN0IGlteF9wY2llICppbXhfcGNp
ZSkgQEANCj4gLTEyMzEsNiArMTIyMCwxOSBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9kaXNhYmxl
X2RldmljZShzdHJ1Y3QNCj4gcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UsDQo+ICAJaW14X3BjaWVf
cmVtb3ZlX2x1dChpbXhfcGNpZSwgcGNpX2Rldl9pZChwZGV2KSk7ICB9DQo+IA0KPiArc3RhdGlj
IHZvaWQgaW14X3BjaWVfYXNzZXJ0X3BlcnN0KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUsIGJv
b2wNCj4gK2Fzc2VydCkgew0KPiArCWlmIChhc3NlcnQpIHsNCj4gKwkJZ3Bpb2Rfc2V0X3ZhbHVl
X2NhbnNsZWVwKGlteF9wY2llLT5yZXNldF9ncGlvZCwgMSk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
aWYgKGlteF9wY2llLT5yZXNldF9ncGlvZCkgew0KPiArCQkJbXNsZWVwKFBDSUVfVF9QVlBFUkxf
TVMpOw0KPiArCQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGlteF9wY2llLT5yZXNldF9ncGlv
ZCwgMCk7DQo+ICsJCQltc2xlZXAoUENJRV9SRVNFVF9DT05GSUdfV0FJVF9NUyk7DQo+ICsJCX0N
Cj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaW14X3BjaWVfaG9zdF9pbml0KHN0cnVj
dCBkd19wY2llX3JwICpwcCkgIHsNCj4gIAlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNp
ZV9mcm9tX3BwKHBwKTsgQEAgLTEyNTMsNiArMTI1NSw3DQo+IEBAIHN0YXRpYyBpbnQgaW14X3Bj
aWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gIAl9DQo+IA0KPiAgCWlteF9w
Y2llX2Fzc2VydF9jb3JlX3Jlc2V0KGlteF9wY2llKTsNCj4gKwlpbXhfcGNpZV9hc3NlcnRfcGVy
c3QoaW14X3BjaWUsIHRydWUpOw0KPiANCj4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEtPmluaXRf
cGh5KQ0KPiAgCQlpbXhfcGNpZS0+ZHJ2ZGF0YS0+aW5pdF9waHkoaW14X3BjaWUpOw0KPiBAQCAt
MTI5MSw2ICsxMjk0LDcgQEAgc3RhdGljIGludCBpbXhfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3
X3BjaWVfcnANCj4gKnBwKQ0KPiAgCWlteF9wY2llX2x0c3NtX2Rpc2FibGUoZGV2KTsNCj4gDQo+
ICAJaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChpbXhfcGNpZSk7DQo+ICsJaW14X3BjaWVf
YXNzZXJ0X3BlcnN0KGlteF9wY2llLCBmYWxzZSk7DQo+IA0KPiAgCWlmIChpbXhfcGNpZS0+ZHJ2
ZGF0YS0+d2FpdF9wbGxfbG9jaykgew0KPiAgCQlyZXQgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+d2Fp
dF9wbGxfbG9jayhpbXhfcGNpZSk7DQo+IEBAIC0xNTg3LDYgKzE1OTEsNyBAQCBzdGF0aWMgaW50
IGlteF9wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiAgCQkgKiBj
bG9jayB3aGljaCBzYXZlcyBzb21lIHBvd2VyLg0KPiAgCQkgKi8NCj4gIAkJaW14X3BjaWVfYXNz
ZXJ0X2NvcmVfcmVzZXQoaW14X3BjaWUpOw0KPiArCQlpbXhfcGNpZV9hc3NlcnRfcGVyc3QoaW14
X3BjaWUsIHRydWUpOw0KPiAgCQlpbXhfcGNpZS0+ZHJ2ZGF0YS0+ZW5hYmxlX3JlZl9jbGsoaW14
X3BjaWUsIGZhbHNlKTsNCj4gIAl9IGVsc2Ugew0KPiAgCQlyZXR1cm4gZHdfcGNpZV9zdXNwZW5k
X25vaXJxKGlteF9wY2llLT5wY2kpOw0KPiBAQCAtMTYwOCw2ICsxNjEzLDcgQEAgc3RhdGljIGlu
dCBpbXhfcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiAgCQlpZiAo
cmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gIAkJaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNl
dChpbXhfcGNpZSk7DQo+ICsJCWlteF9wY2llX2Fzc2VydF9wZXJzdChpbXhfcGNpZSwgZmFsc2Up
Ow0KPiANCj4gIAkJLyoNCj4gIAkJICogVXNpbmcgUENJRV9URVNUX1BEIHNlZW1zIHRvIGRpc2Fi
bGUgTVNJIGFuZCBwb3dlcnMgZG93biB0aGUNCj4gQEAgLTE4NDUsNiArMTg1MSw3IEBAIHN0YXRp
YyB2b2lkIGlteF9wY2llX3NodXRkb3duKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+IA0KPiAgCS8qIGJyaW5nIGRvd24gbGluaywgc28gYm9vdGxvYWRlciBnZXRzIGNsZWFuIHN0
YXRlIGluIGNhc2Ugb2YgcmVib290ICovDQo+ICAJaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQo
aW14X3BjaWUpOw0KPiArCWlteF9wY2llX2Fzc2VydF9wZXJzdChpbXhfcGNpZSwgdHJ1ZSk7DQo+
ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFb
XSA9IHsNCj4gLS0NCj4gMi4zNy4xDQoNCg==
