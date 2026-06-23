Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9B22256F;
	Tue, 23 Jun 2026 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179827; cv=fail; b=CJX0yzbIpGV43ALtTjdqRiqcvcKnMgWvlrBrpr+hEvbfWQtPesuVE+ARh+tYqRrJxf8Ds0881QlfkG1EavDauLNKH8z5hD7Lpk+HqQPE9SohyGCRvSnuqQKvti1dkEYHwj/6eVhGd6ZECSS4nRnAYB6+D4MRUUhmejhrUcjTRU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179827; c=relaxed/simple;
	bh=Gs7qCQYsmjucLU2wJXgzah9E5h+W5dmPnuaOi8+pEF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foVciVUGtAeJBs/usQwK7w7ijLzxl/DbYr+IQqJr2RSF53EEb+cN/Ldfhr3UCgvFlX7upQyx91g2L6k/aOscU4KQGVgflmqP+v4VReDQoYJa/MDkJ//3l9wuZM+3HiP7gLKxST8bYgciKq7FvxFQBIsp+gbIpflDkz2ggzphezI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4Z2L0C1; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4Z2L0C1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boEDChK3pq6yzARorgrXd8GQosfxHq9gyfWoMuwyNrL+6h46WKDQidcVtvLFgnBw512yIVzjFlmYkpYlrN/0vM/fYTDdfBauTTf9zXVHBQN9wzGAqe13gW5BVb4M8aE0mP5ticPhOwygqaZG/nedXHf1fNTXILtWHOSE7Uyj73Jc9cZdR/y8s+f0sk1cfZ1GKpYKNlqkX0x/RHS7/1p9YsX/ZoNmO73+FYitForOdmhhhhGLZ96gKucpizl7GzFHcHGz+p06w6OhMpBuhzy9hxKIowBfXaGFRQREP4RJSlmMNztjeBTi9SsvSOVFQe2amtsCNYwca32XB5WR1ZXa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs7qCQYsmjucLU2wJXgzah9E5h+W5dmPnuaOi8+pEF4=;
 b=UsL69YjD92gPEZFSB/E3ws+11VilV2lJLYDJuwBzMfvZ5fWXd95dCl5L01e24d+Aut/F14lNuvezreayVnZSIiC9huWeCEw9aSbO+J5aQSucDc1U5/ZVQ1mqsfCnDFkDvBA/D8FVmMrx2x6qV+beJ2SLM7hsu+jWP//RXwVN93DXEAMPDBX9fRxaalwiIkN9SsZ74cNuVipu23VzRTJzwNMzbIfqH0cxvMrBQnoCm9EYfuOHIwgZAx+BqEdfD2Nx2d5/WzXgHneYU9zsnffCUyvX6pSEFNsmCv6yYLZ0Gwoc210zyXbW5QLhSaor1HMJs3kmwMe5r0l/W3MXQRvMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs7qCQYsmjucLU2wJXgzah9E5h+W5dmPnuaOi8+pEF4=;
 b=K4Z2L0C1SvD47CgN1ttoAAxed6br0joBl23rOQpDNmTevxiXrANi601alhp5MNB7HwZ/wJdqzlnGcV8fUnmKVlcpVQQ4NUTaDFiOgpRnNZc+qCyBi+KszHbekjz1D0wwAbwOjAfELMw6jw2f9w4LWLnBYHKGbHJGKqbeIPWKrp6hNxVvSuG6iJzUCL0vcThBGr3pvz5XPbNs9/yU9OYNUotHrb2j8BYKXpSc8YTX7LIg1c5P8egkv6KzasEGoaFKaHzGNKPsyCWHvHLneQGmVYytr5KPVxLjd+G+b9AtJ7cTQ3Xn1V3XYjJ1NUEnXKaxwBI1fzfHE9YixlWiOb9uew==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PAWPR04MB11673.eurprd04.prod.outlook.com
 (2603:10a6:102:512::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 01:57:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 01:57:02 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@kernel.org" <brgl@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Topic: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Index: AQHc/wqF6j9CS1xPUkaamLsLC0p+KrZEojoAgAVUbKCAAHCxQA==
Date: Tue, 23 Jun 2026 01:57:01 +0000
Message-ID:
 <VI0PR04MB121145A2AE63BDEC34E9DDD6792EE2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <20260618101047.4185497-4-sherry.sun@oss.nxp.com>
 <ajQ4oBUNGOrhcPX5@SMW015318>
 <VI0PR04MB121141C8A15758C0244AA351F92EF2@VI0PR04MB12114.eurprd04.prod.outlook.com>
In-Reply-To:
 <VI0PR04MB121141C8A15758C0244AA351F92EF2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PAWPR04MB11673:EE_
x-ms-office365-filtering-correlation-id: 9c0810b0-2445-4d61-2243-08ded0cab7e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|38070700021|18002099003|22082099003|4143699003|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 yRe+5joqfqMmvYjs64L8gKBuWGRMMdis8s9EG88Q/sGodT+s37Whuh/ybFhsbIGF9po8jumfGy42hiJ6FlP4UowLtzvrkBmCACFln6dAK9xCIduWtSt1rmaftF7Ace5e1Llt90OedsqiJGQoM+lb4dFJuiVUFPApcaHMNFkTrwnm/p7/9rF1LoQNSUNxWpdRVl2umVDlLIOti9kyVIn04ZvvXEBop/1kXOYaRduCNaKfg5el1VkdeJYDfMu8H48ttp5Sy0wjonMLq0XoXN3OzxOYTZmJud1ekE7kV01DMD0n/p5aEL1ccM9DigvEoeD7d+zWPVFJ5TBsqz3et9oA7S0Ym9AoiEImhUXJcyylz8b4Pz6pr4m7Ilfo8rJmi0NhHdHpJ7twUvXmcd1AgWGegdwojuGYfqA2pmma7YCkXoHLBnrrzZlIOmOhViXffaAhTkmCVOlqomAzZzPkEx82UplwbYRJtFp2VSUejXbwU+rjnS6Zt42SGOedgLYjhEOkBjQ9//uA1tWi/zqKZpdzLhqZyiueSeFknuTQWszOM7tcee0cOgqR68c+XwAx2eZefkXkVFXJSdYRrt49v94ZbdsWLWyioES69GO5rxPzQwzQUzf3gMNsaPR0wLAJOZPrjJ+H9jV/jxxfv8t0uY1Fa/f+iabnZH6hMdcICekHLKr7dUGD282ZMlk1lKXkNgTnSSfz2X+Pu8wBZPyaRbrubJTTGCtmnNIcyBmKITif+PE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(38070700021)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NnlhQ3ZKbDNiMnJLeUQzem5JM3hUbjhRSCtxSXhnbXJxa0xvdHgzSWFGSVla?=
 =?gb2312?B?cG5YeUh3ekRlbVpRcGxpQ0hyWmF5blBJbUFYaTZyR1BFcGZMbnovZ2pPckEx?=
 =?gb2312?B?RGl0dHZzWWVDeUw2M1p5eCtHM3k3T3BGRnprSDV2ZlNoMFF2TjVYOXc2QjJq?=
 =?gb2312?B?VWNKc0swK2ZtcEdXbExkQlFGUEJCcFIrZzJUL09sQURrcC92V3lSVEhsMllW?=
 =?gb2312?B?WVU3RSt2TkU1VWYydHpRVzc3SzhKcHNacTNoNTJVT1k3QnNQOXJob3ZBRFgy?=
 =?gb2312?B?QUlRTmsremo1cjgxbFd1aCsrenNVaVkzckxrNFFDZlFXd2NlRUhCd1pHL2dz?=
 =?gb2312?B?WUFvQUF4SXU0aEdsb3NFZi8zRDh5UTcyem9kV0xEcFFEUUpCZW5wUkUvcnBk?=
 =?gb2312?B?NXVGSDgwdnQrVmJJS243Qllpc3B1UjFNMVJGYTJKeEUrZjFyQ3lwa0JmREhW?=
 =?gb2312?B?ZmpQM0x3V0VnR01CcnJIQS9ocWxlblVvUWM5aGpvK2pKN3FCd3BOWUgzSkhk?=
 =?gb2312?B?UDRvQWdSYlRnaEYyTEQ2SW01bkswb0JqdFFJUi9ScFN0VG91R3ZzbnRPNGFO?=
 =?gb2312?B?QTN5SW11SHpQWVhzNlFXbGordm82WHphWng4Uk8yeUswUTUzZnBpQ282NTNn?=
 =?gb2312?B?TGlmOTQzeG43WTBvT2pYcHliNUFnM3VmRjYxNnpxR0NkcEJpQnhGV1RPaEQz?=
 =?gb2312?B?NkZNa3BwQjZkNXBtNnRPVi9nZHZhMXhOeW5yQ2crYm9pT0RjT0V5NzVYMTdy?=
 =?gb2312?B?aWxnSFVSQWxUWnNZeDQvNlhHdEV3WUx0U2tVK0l5RGlIVDlad2wxSkxEbXpp?=
 =?gb2312?B?Q2tKV014ejlNOEFiTFUweEZHLzZ0VlJhaWszSjhwdXBzRFpXY0JPUkZISG81?=
 =?gb2312?B?U0R6bU91SzFOYWtSQlpJTEo1THdKc2UvcTVCU2o5bEVwblplOUdoOHBJUnhK?=
 =?gb2312?B?UkEvRVk0ZldhVkJWcnN4YXA1c2NObmZpMlZ5bE9yeVVGNVp4c2hjaG9iT1RZ?=
 =?gb2312?B?cVBsRzZYdUlnMXloZW50aytCNElUTUVLclJkZnFReU1PTkNvbWt0VEhvbjcv?=
 =?gb2312?B?bnNVQ2h1WjlOMFNqR252MUlKRFg1QnUrRzc3elNmeFRNSnVRQ2x1OGFsbFVa?=
 =?gb2312?B?U1JGM1NPRTJUVVNlbTZPRW9uNi96T2pBRDhtOWY1YWIydExTdmNsVW0zMDNQ?=
 =?gb2312?B?dTlKSmZVYlNXUnB4ZWpSMm5yMnFTVEg5cy83NUVaNFB2d1hGQ0lPb3c1K1c3?=
 =?gb2312?B?d0FEbmc1S1U1b3VnUTduVDh2Y1V1emg1V25DaVFoNXYvdS9VYVZIUENwcEpO?=
 =?gb2312?B?KzJLNkIva29LRndKSzlMNThHY1A5dUhXUk9yalk5M1A5RkFYZjRmWUNGWThL?=
 =?gb2312?B?Vk02aEI2Z1FlRUI0K0RDc1B3TWpzc2R3OXFOblBaTWgrT2FIRVdxcnoreDVX?=
 =?gb2312?B?T3VteGk2N0FtK1d4bkpFUUg0THArUjFjYlRHOXpMcDN2QkJ1UFdxQVdJOVJF?=
 =?gb2312?B?WDBJYXBKTit2TTBtWStIcG1yeFc3NGNRajN6YXRnL1BhVUJ0SGVuS3FyTFM0?=
 =?gb2312?B?dEJnNzV5MExRSFcrSVdHR1hHTTNGNWVjWUxBcXdJbG5pQ1k5YU03cXJvWXNj?=
 =?gb2312?B?Yko3cG96Smk1L0dUSkxMQkl1U0RjZ3huYWRmd0FmdHNCZFo4Mytpazk0ekMv?=
 =?gb2312?B?a2tvOEEvdjJTZHM0Mkd1anViV0ZUdEhaUlVxREtmMFMyc0tFWE5BWnFxZEF5?=
 =?gb2312?B?ejJUOHFrUnViL0Z1aUl2SWZhRzBlSDdzeU90dzRNZ01MQTlLT0dURVRkMUd1?=
 =?gb2312?B?OGRSN0M5MzN2WGJHaVc4d1VYMjRXa29UR2l3WkpGUmM3YjE0RExDaGpHeUQx?=
 =?gb2312?B?TEFHT2NQbkQvNlFjbkFpeXh4aWF5S3NvZXB5OXA1dU5zUU1EblRPQ0pydC9N?=
 =?gb2312?B?QWdJRW9HVHlRY3VzL09HQ3hvYzFHb3E4cHZlRkFrSFJSeW5zVHhHNkkwSjhm?=
 =?gb2312?B?L1FoeEpLMExkYm03NlRjMHFBSWpFTit1Mld0TkVTalRvdVo1Q2R6QWZqR0Jl?=
 =?gb2312?B?U0d0a01PeVNGWGt4b2xVRXlrREpLSkVkVWVRamN5RDJuY3QveWtBN1p0L1Y0?=
 =?gb2312?B?eFdtZElocU9rdmtnY0FFaEdoajhQNVV3eFZ5SzhxNDdJV1ZzdGFybnJGRlE2?=
 =?gb2312?B?UGV6MFNCa0I3b1ZmaE5jV3MzZGcyMUlJNmNCSm56VHgwV1lYNUtuZUVXMm5W?=
 =?gb2312?B?RnBLNGRUaitITGVFM0h6YjE2eHlZVXVuYStxL05zNDJ6eGswZ0tHc0t1b2lD?=
 =?gb2312?Q?s19yabH27sB4VCUjHA?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0810b0-2445-4d61-2243-08ded0cab7e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 01:57:02.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z27W4qTTgprezax4/GC/epCmaufCnau7Q6P5CHs1cj61NoPUn18tTOS4GwBM9zELt7mpa52/ypAELl+/zwSSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11673

PiBTdWJqZWN0OiBSRTogW1BBVENIIDMvOF0gQmx1ZXRvb3RoOiBidG54cHVhcnQ6IEFkZCBNLjIg
Qmx1ZXRvb3RoIGRldmljZQ0KPiBzdXBwb3J0IHVzaW5nIHB3cnNlcQ0KPiANCj4gPiBPbiBUaHUs
IEp1biAxOCwgMjAyNiBhdCAwNjoxMDo0MlBNICswODAwLCBTaGVycnkgU3VuIChPU1MpIHdyb3Rl
Og0KPiA+ID4gRnJvbTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+ID4NCj4g
PiA+IFBvd2VyIHN1cHBseSB0byB0aGUgTS4yIEJsdWV0b290aCBkZXZpY2UgYXR0YWNoZWQgdG8g
dGhlIGhvc3QgdXNpbmcNCj4gPiA+IE0uMiBjb25uZWN0b3IgaXMgY29udHJvbGxlZCB1c2luZyB0
aGUgJ3VhcnQnIHB3cnNlcSBkZXZpY2UuIFNvIGFkZA0KPiA+ID4gc3VwcG9ydCBmb3IgZ2V0dGlu
ZyB0aGUgcHdyc2VxIGRldmljZSBpZiB0aGUgT0YgZ3JhcGggbGluayBpcyBwcmVzZW50Lg0KPiA+
ID4gT25jZSBvYnRhaW5lZCwgdGhlIGV4aXN0aW5nIHB3cnNlcSBBUElzIGNhbiBiZSB1c2VkIHRv
IGNvbnRyb2wgdGhlDQo+ID4gPiBwb3dlciBzdXBwbGllcyBvZiB0aGUNCj4gPiA+IE0uMiBjYXJk
Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5Abnhw
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jIHwg
MzMNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+ID4gYi9kcml2
ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyBpbmRleCBlNzAzNmE0OGNlNDguLjFhYTg5NzJmMGRh
Yg0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiA+IEBAIC05
LDYgKzksOCBAQA0KPiA+ID4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc2VyZGV2Lmg+DQo+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBo
Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3B3cnNlcS9jb25zdW1lci5oPg0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9za2J1ZmYuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvdW5hbGlnbmVk
Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ID4gPiBAQCAtMjExLDYg
KzIxMyw3IEBAIHN0cnVjdCBidG54cHVhcnRfZGV2IHsNCj4gPiA+DQo+ID4gPiAgCXN0cnVjdCBw
c19kYXRhIHBzZGF0YTsNCj4gPiA+ICAJc3RydWN0IGJ0bnhwdWFydF9kYXRhICpueHBfZGF0YTsN
Cj4gPiA+ICsJc3RydWN0IHB3cnNlcV9kZXNjICpwd3JzZXE7DQo+ID4gPiAgCXN0cnVjdCByZXNl
dF9jb250cm9sICpwZG47DQo+ID4gPiAgCXN0cnVjdCBoY2lfdWFydCBodTsNCj4gPiA+ICB9Ow0K
PiA+ID4gQEAgLTE4NjYsMTEgKzE4NjksMjcgQEAgc3RhdGljIGludCBueHBfc2VyZGV2X3Byb2Jl
KHN0cnVjdA0KPiA+IHNlcmRldl9kZXZpY2UgKnNlcmRldikNCj4gPiA+ICAJCXJldHVybiBlcnI7
DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4gPiArCWlmIChvZl9ncmFwaF9pc19wcmVzZW50KGRldl9v
Zl9ub2RlKCZzZXJkZXYtPmN0cmwtPmRldikpKSB7DQo+ID4gPiArCQlzdHJ1Y3QgcHdyc2VxX2Rl
c2MgKnB3cnNlcTsNCj4gPiA+ICsNCj4gPiA+ICsJCXB3cnNlcSA9IGRldm1fcHdyc2VxX2dldCgm
c2VyZGV2LT5jdHJsLT5kZXYsICJ1YXJ0Iik7DQo+ID4gPiArCQlpZiAoSVNfRVJSKHB3cnNlcSkp
DQo+ID4gPiArCQkJcmV0dXJuIFBUUl9FUlIocHdyc2VxKTsNCj4gPiA+ICsNCj4gPiA+ICsJCW54
cGRldi0+cHdyc2VxID0gcHdyc2VxOw0KPiA+ID4gKwkJZXJyID0gcHdyc2VxX3Bvd2VyX29uKHB3
cnNlcSk7DQo+ID4gPiArCQlpZiAoZXJyKSB7DQo+ID4gPiArCQkJZGV2X2Vycigmc2VyZGV2LT5k
ZXYsICJGYWlsZWQgdG8gcG93ZXIgb24NCj4gPiBwd3JzZXFcbiIpOw0KPiA+ID4gKwkJCXJldHVy
biBlcnI7DQo+ID4gPiArCQl9DQo+ID4NCj4gPiBDYW4geW91IHByb3ZpZGUgaGVscGVyIGZ1bmN0
aW9uIGxpa2UgZGV2bSBjbGsgZ2V0IGFuZCBlbmFibGVkPw0KPiA+IGxpa2UgZGV2bV9wd3JzcV9n
ZXRfb24oKQ0KPiA+DQo+ID4gU28gc2ltcGxlIGJlbG93IGVycm9yIGhhbmRsZS4NCj4gDQo+IE9r
LCB3aWxsIHRyeS4NCj4gDQoNCkhpIEZyYW5rLA0KDQpJIHJlLWNoZWNrZWQgdGhlIGRldm1fcHdy
c2VxX2dldCgpIGFuZCBmb3VuZCB0aGF0IGl0IGhhcyBhbHJlYWR5DQpyZWdpc3RlcmVkIGRldm1f
cHdyc2VxX3B1dCCh+iBwd3JzZXFfcHV0KCksIGFuZCBwd3JzZXFfcHV0KCkNCmNhbGxzIHB3cnNl
cV9wb3dlcl9vZmYoKSB3aGVuIGRlc2MtPnBvd2VyZWRfb24gPT0gdHJ1ZS4NCg0KVGhlIHVud2lu
ZCBpcyBmdWxseSBhdXRvbWF0aWMuIFNvIG5vIGV4dHJhIGNsZWFudXAgYWN0aW9uIGlzIG5lZWRl
ZA0KZm9yIHBvd2VyLW9mZiwgYWxzbyBubyBuZWVkIGZvciB0aGUgaGVscGVyIGZ1bmN0aW9uIGxp
a2UNCmRldm1fcHdyc3FfZ2V0X29uKCkgaGVyZSwgSSB3aWxsIGRpcmVjdGx5IGRlbGV0ZSB0aGUg
cG93ZXJfb2ZmDQplcnJvciBoYW5kbGluZyBpbiBWMi4gDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5
DQo+IA0KPiA+DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICAJLyogSW5pdGlhbGl6ZSBhbmQg
cmVnaXN0ZXIgSENJIGRldmljZSAqLw0KPiA+ID4gIAloZGV2ID0gaGNpX2FsbG9jX2RldigpOw0K
PiA+ID4gIAlpZiAoIWhkZXYpIHsNCj4gPiA+ICAJCWRldl9lcnIoJnNlcmRldi0+ZGV2LCAiQ2Fu
J3QgYWxsb2NhdGUgSENJIGRldmljZVxuIik7DQo+ID4gPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4g
PiA+ICsJCWVyciA9IC1FTk9NRU07DQo+ID4gPiArCQlnb3RvIGVycl9wd3JzZXFfcG93ZXJfb2Zm
Ow0KPiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4gIAlyZXNldF9jb250cm9sX2RlYXNzZXJ0KG54cGRl
di0+cGRuKTsNCj4gPiA+IEBAIC0xOTAzLDExICsxOTIyLDE0IEBAIHN0YXRpYyBpbnQgbnhwX3Nl
cmRldl9wcm9iZShzdHJ1Y3QNCj4gPiA+IHNlcmRldl9kZXZpY2UgKnNlcmRldikNCj4gPiA+DQo+
ID4gPiAgCWlmIChoY2lfcmVnaXN0ZXJfZGV2KGhkZXYpIDwgMCkgew0KPiA+ID4gIAkJZGV2X2Vy
cigmc2VyZGV2LT5kZXYsICJDYW4ndCByZWdpc3RlciBIQ0kgZGV2aWNlXG4iKTsNCj4gPiA+ICsJ
CWVyciA9IC1FTk9ERVY7DQo+ID4gPiAgCQlnb3RvIHByb2JlX2ZhaWw7DQo+ID4gPiAgCX0NCj4g
PiA+DQo+ID4gPiAtCWlmIChwc19zZXR1cChoZGV2KSkNCj4gPiA+ICsJaWYgKHBzX3NldHVwKGhk
ZXYpKSB7DQo+ID4gPiArCQllcnIgPSAtRU5PREVWOw0KPiA+ID4gIAkJZ290byBwcm9iZV9mYWls
Ow0KPiA+ID4gKwl9DQo+ID4gPg0KPiA+ID4gIAloY2lfZGV2Y2RfcmVnaXN0ZXIoaGRldiwgbnhw
X2NvcmVkdW1wLCBueHBfY29yZWR1bXBfaGRyLA0KPiA+ID4gIAkJCSAgIG54cF9jb3JlZHVtcF9u
b3RpZnkpOw0KPiA+ID4gQEAgLTE5MTcsNyArMTkzOSwxMCBAQCBzdGF0aWMgaW50IG54cF9zZXJk
ZXZfcHJvYmUoc3RydWN0DQo+ID4gPiBzZXJkZXZfZGV2aWNlICpzZXJkZXYpDQo+ID4gPiAgcHJv
YmVfZmFpbDoNCj4gPiA+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQobnhwZGV2LT5wZG4pOw0KPiA+
ID4gIAloY2lfZnJlZV9kZXYoaGRldik7DQo+ID4gPiAtCXJldHVybiAtRU5PREVWOw0KPiA+ID4g
K2Vycl9wd3JzZXFfcG93ZXJfb2ZmOg0KPiA+ID4gKwlpZiAobnhwZGV2LT5wd3JzZXEpDQo+ID4g
PiArCQlwd3JzZXFfcG93ZXJfb2ZmKG54cGRldi0+cHdyc2VxKTsNCj4gPiA+ICsJcmV0dXJuIGVy
cjsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gIHN0YXRpYyB2b2lkIG54cF9zZXJkZXZfcmVtb3Zl
KHN0cnVjdCBzZXJkZXZfZGV2aWNlICpzZXJkZXYpIEBADQo+ID4gPiAtMTk0NCw2ICsxOTY5LDgg
QEAgc3RhdGljIHZvaWQgbnhwX3NlcmRldl9yZW1vdmUoc3RydWN0DQo+ID4gPiBzZXJkZXZfZGV2
aWNlDQo+ID4gKnNlcmRldikNCj4gPiA+ICAJcHNfY2xlYW51cChueHBkZXYpOw0KPiA+ID4gIAlo
Y2lfdW5yZWdpc3Rlcl9kZXYoaGRldik7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KG54
cGRldi0+cGRuKTsNCj4gPiA+ICsJaWYgKG54cGRldi0+cHdyc2VxKQ0KPiA+ID4gKwkJcHdyc2Vx
X3Bvd2VyX29mZihueHBkZXYtPnB3cnNlcSk7DQo+ID4gPiAgCWhjaV9mcmVlX2RldihoZGV2KTsN
Cj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuNTAuMQ0KPiA+ID4NCj4gPiA+DQo=
