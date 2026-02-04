Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADA381702;
	Wed,  4 Feb 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187451; cv=fail; b=L5eTGXiUnKo/HGHgi2XI9/hHeuiofHzX5rlyAquOYjYPKK94AM1e2B9dHx+2RIhsYpECQmhNspAyuhUKkaqRCmAA01kYK2w74Rq4r2htn3cZBBhrmNaPT2EEIAC0XRsWs6jigGq55Cer4TCKZ6yI6kD0uS77+3V2G+cSRXRLMv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187451; c=relaxed/simple;
	bh=R8EuGY6fYSM9xkWSiupyWiEiXilWvr6/Wny7fvJbeC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVlhhDMYyt1THVVjFFJCR38sJ0NBWHa3Qz1DQardA+MOuEpf17o9WaFPfrgj2NS7hC9mzD8C8KOVacbOytXXRbcGiLdXTYedXVoXUUHBK577IGvgNTGFmcPm5OwzyFYHJo8wvnP7UyECo8HNQfLf6FIK03QWW5sdnDIfAj8Ry78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YB5cF+6V; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YB5cF+6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic7hGoLBfhM+IvK7YUEQe6T1ElPMiuAmGZtVayo2sx+JMNBrvyXLEnye/+1CDj28worGgXUfMSOd1nUTi79b9FTbwNzvrh1JETu36dglKiMrxGEZZ1zDpkBZehuNbvr1fWsBZYmiDdyiVnbZ9a7lMoj6enklBYlfm75AKHP8bKVp8VwsWYG66e6qVGCFPFFsp/NjQVzVLLxWEcXNtlwW2QzPcLloW/asudi7l4YxSWKnc9ZdwdrMZ2cBU9D/oKrTYIURKsklf7hQHhc4FfGdUT/7FTn8ZjEFZsaNQABqVDK7p6r2TVfUiywHJtOowhGJneVAz5zofoV0shhqTLunZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8EuGY6fYSM9xkWSiupyWiEiXilWvr6/Wny7fvJbeC8=;
 b=cd3tiAq+VMYV4OqhfjneTDerRiozTSMtcw5OVpX+LAD3PZ0WcAgePEO9rXfXyZ88iq3EFGeB17HUif3ecAXiArlqtU1Zkg0AkxBDGNClvvd9UNku3iyMe5Fn/j1T3OL/+wQvDAaUkWZ2Npqryj+50gBafgCrtnSwIqNjHdRGyQQKV2gvNFjW6C17STzBgko17x44925IgJnQg2oXrN5plFJO1gT9rn37wCGolMremv2LmjIIpbWslYz0V9vIVbevlpuQ4enDPYCVNjCJm1qhS9Lb6rX/8izKwsYl8co2lPIPN2Pg0qkxCWaX4zcjUosspB5NGqGuCHjsRbguxXL7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8EuGY6fYSM9xkWSiupyWiEiXilWvr6/Wny7fvJbeC8=;
 b=YB5cF+6ViQpEbiZSYl14n1SwzToyuVK+IroFGn+dAsSxhHupRd83GhXt3ljb2fXj0R7LWUUqIiGs1ThJ2qnLGDo8pICMvXQFNrfnI/V9I9xVATlHfLh4H/ZpwRnU9DpoAqyxW13ZbAHKlr/b+PnUpiCRoBjCN9be1C9dDAniyxRV5izorfuOvVpcXO0GL6UNwSmDd3Kb6Tj/ZPySyj8Bddlr6XgrMGlVUkbQy92Dje+vwSc0nKiHeRn8f6x3DsY9OikSVrv93iuykR3MeWZFOzvXlF7Gwbtk0ysAc5k9JVMZXAD1Kivk/vGL+n9/DntfrBlCCVqjjZuqENQ6u1kzpw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB7677.eurprd04.prod.outlook.com
 (2603:10a6:102:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 06:44:07 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:44:07 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Topic: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Thread-Index: AQHclLAwRnXbLHdW00C5Uuw9dLD9vLVw8ywAgAElQ/A=
Date: Wed, 4 Feb 2026 06:44:07 +0000
Message-ID:
 <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-4-sherry.sun@nxp.com>
 <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
In-Reply-To: <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA4PR04MB7677:EE_
x-ms-office365-filtering-correlation-id: 48272233-437a-4eb2-6471-08de63b8cbbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dW8zRXkvNlVMUElXaXNlMElueTY2YUVaT1Vpd3RWa0VLY1VydmtMUjJEZk16?=
 =?utf-8?B?S3pubXUyM2gwS2d2L0xhbUNiWFhKTWdTaWp3bFA0Yy9vNksyUk5KdWNwVFpQ?=
 =?utf-8?B?UHZVcXBJNVhCM05OY0E0TVhMZVdFamZOa0YwUE5mOWR2R29sUWg2Rml2OXRG?=
 =?utf-8?B?UEh0WXh5c2JrNERNaTdZL2x3ZXlRVk1sTUwxSHZua1VPTFlJSzNnTHB0OTZV?=
 =?utf-8?B?UEVyVFlEcGtrVVA4MGdOTllZSk1nMUVnQjdJaEptaFV6SVJPWkxuWnZzRTZ5?=
 =?utf-8?B?dGJwK3R1dEhJTFp1UzIyYThXdWFUL2o3NStIWUtjaGJHUlRINXVwMm5RZ1Jt?=
 =?utf-8?B?MGVlUVBPZXZ0WnJjcTdMNm5ETEJ4eW9UbkluQU5QaTNkZ25EdzI0bldici9T?=
 =?utf-8?B?WHlkUmdMRGlnNENqbWV5cnc0RkxtVnRnQmhheGQrL1JNZ28xQXpoMURIR21n?=
 =?utf-8?B?WmI3VWZsd1pqTXB6akZ4Q09TdThwTHM1UEd6c2YyYlZoalIrTDE2T1JlQUZL?=
 =?utf-8?B?TDRMd0thL2U5VkpvZGgrTXR3YnBldWtaS2JjRERrdGJEbXdyRDd4V1RqVzdI?=
 =?utf-8?B?ZkhZL0lNMjVoMmdpRktLNzNiWnZhdHNId0hGYlJ5cHRZeHVQOGRBekdWWUlD?=
 =?utf-8?B?WEorbU1UQ0xwMk0xZnJxODdIN1hHR1lDRDFzQUNwNVBjMkJnOUpwM2VsK3VT?=
 =?utf-8?B?WTBVaXh3R285QWQySDdXY2d6akVrY3RjbTdlYm01andRbkl0dWY2emdxbkls?=
 =?utf-8?B?RHpGdGExWDlqRlZ2bkV1Q1dNa045TWE1bDdHVXFKNjFRbTRZVHF6RkpkOStR?=
 =?utf-8?B?TkJHRnEva1dUa0VsUzRXbFliVDBjRHZKT0IzMzh0NjE2YnpaV0MrNng4c211?=
 =?utf-8?B?Z0xOQURBT2xIcDhjbGpZT2U5L09pek0zdkFOSTR1Z28veC84OW13NlhSbjFo?=
 =?utf-8?B?VHZqcDl0YmNsMjh2SXFXLzBkLzgwMlNVL1hQYVBBQXdKaWwvQjNmQ0NyUFVX?=
 =?utf-8?B?d3pwcEU4cFJ1cWVubGNYWWd0RGp3UGZwQ2NQTXAwNk5DaUg2eFBjczdRdGtZ?=
 =?utf-8?B?ZFNaZVEzN3dYQjZZeTdsNURCeU4zaGFZM3Y5ZmU5ajkyUFlVb1E5SmNVZitR?=
 =?utf-8?B?ZFpZeW5MZ0xjM3VzeGZVcEFpcWRudi94ckJuMHFYejhGYktHejZsdVZDckd0?=
 =?utf-8?B?TkpIVXZwY2J0RnBHODJ2b0lNV3ZuRVVWcklNZk9jOWxRRVBaanM0L2pqcmZ6?=
 =?utf-8?B?ZFpYRW5YYlZyOFZaM1JWeVV5MHR2MXFneDJ3ZHozYlc1RWR1S2lRWENyU2ZM?=
 =?utf-8?B?cWVuUExoTThxTWNGY3NDcUVIZzc1OW1lNEc1dExycC9TaVIzb0xQenBLdUJK?=
 =?utf-8?B?cnhxQWx4OFM0M3NhdVhjQXhzaHkxMzl2UG1NOEo1aTRrZ0hJdUtIQy9WZEVP?=
 =?utf-8?B?Kzl2Znc4alJibHNjTmFsbWxCY3JXVXhLWElxUGdacnFvaTQ1b0ZNYXhMcUpU?=
 =?utf-8?B?b2I4M3M5MjJ0MEJsNHBDamx0cThYcktjMk1OOHhsTVVtOS9MbU94eUdOcVlD?=
 =?utf-8?B?bWQvKzI2bFNBc21jQXdSVUxsbXpSdCtVbHlVZER3Z1VBYkEzUlcyR29MRFhD?=
 =?utf-8?B?NjYrb3FVL2x4MFFwb2JOcS9xSGNVUmdhclpHeFJjTWpOMWpIT0JaOGUva3ZK?=
 =?utf-8?B?SGE4UEJuKzJyVWZJOU5rVjVGdlBFYUlHK1NFY243MzFvam9jbjcvMWNMbHBm?=
 =?utf-8?B?RWJZWmZTUkIybXI2cVhUNXE0Rm5XeWV3RS9NaDlFQ00vUzhQUFdOMlJVVHJN?=
 =?utf-8?B?aVE4TFlLbDYrTXVuM2VFMVlPYVlyaFl1ays1T0tmaGFqUDFrZzZuWU4wQnAx?=
 =?utf-8?B?RS9EWFNJOFFMZE5CS3F0cFMzOVA2VzZZMGNET3VCTjhMMGNPMW9ZWjRXeUVR?=
 =?utf-8?B?ajlZVjJsR0habXRWV2pxZnliN0FJVE9jZmhUcGthRU0yeGdWalJvZGNpOEpL?=
 =?utf-8?B?ZUFKRS9hTEtjQVRuSGFCZldKeEthNXlyUnJ2c2ZRSWk2Q1Q2eis3dis1SHNJ?=
 =?utf-8?B?dDFLZy9oUFhvaEkrU2FPU3JMU2MyZjlHbVVhZzdLaUJtVS84bmVyalV1RFBZ?=
 =?utf-8?B?d1BBVXNCYm94cm0vQlBPR1dSVXk4VS9LY1NadmNDS2g1b1FKRzNuQURSTlNY?=
 =?utf-8?Q?ejMy8f6Q0ca3HWiFqzOPYgE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDFzdnFlZ2VpeTNvdGZTbFNVc3hlaG9aalcrOFZheWd0bDRWbWR5YWtNL2xE?=
 =?utf-8?B?cjV5MWpLOFNHeEIza2xxUk54ck9UYytCb3ZrbGRBNGY5VE5DZjZxTmljRTRP?=
 =?utf-8?B?TzNRUnVETzJyMzZPYzRvRElkMlhmM2s4SVJZanhPNEk3NU9iejQ3TjB6UTNR?=
 =?utf-8?B?TTkzUlp2OUtESkFsdFZlL1F3TldXRjZCWnhRYmJseFF0ZHU0UFNiWnhqYk82?=
 =?utf-8?B?eFgxZEc0a3FXMjVPczBkWm8yVzR5bEZVeG5oVTllT0xMNS9LNEVhSlJHTGJv?=
 =?utf-8?B?RmY4K0grTmVGVEIwM2hSOTVKUUNSQ0VzZkdnS3RSYkc1RmlPLzBpRDl4MVdM?=
 =?utf-8?B?TDhobjZqYm1VajRxMnhDUWY1c2k1RzU4N1FidFZyYlBFeDB0eGs4ak51N29Y?=
 =?utf-8?B?bU1VdXdTRjdiY3F2bHdlL1NNQ2NYNzUrTUNQQnFDSE5oNitIRGhEUE9QMFdt?=
 =?utf-8?B?ZDYxbFYzRHI2dHJ3cTZpODBla3U3VjFzK1BnYTl1cjRRcGpHcjFuUEJnY1BM?=
 =?utf-8?B?Wkc2cWNNTXBYTFJDSG0yL1docHlESWJwZ3MrcmxhZE5wQ0pmdHQ1dVBCcUk1?=
 =?utf-8?B?MmVEQ0MxYUlSK3JqSzRCdjJtSlRoRXJVMThGRngweVR3Qmg4MWFTNHVJbFRB?=
 =?utf-8?B?U1o2a1pDTCtlS2djVXhCT3hha2pObXUvVU5OVmpOZHVCMklQSXNOeHFvbUZK?=
 =?utf-8?B?VVhiWUJsRVUrWklDa2MwVnc0cTZ2NnN5L0MyOVZaUE1ER0FONXhFRVgrc1Y3?=
 =?utf-8?B?Qm5BNXcyS09JYUpNQlYxQVFseE5oK3hDbytONWNNQmNuMUlKWUVXamZLclkr?=
 =?utf-8?B?cXRLcUoxQVhkNUw0VkN3amNzNEQ2YTJXRHJtYldNSjB3azRoREdOTzFuWEJy?=
 =?utf-8?B?U1dXc3FPRFN5bGxINDgxQlQ5WjYveWFnR0N3RWU4S2p3R2tOTURUOUJhWEhV?=
 =?utf-8?B?ZkMvSGJROWVKQjlvb25Ca2h1NS9Wc2NrSmhHWDRlalNlOFlLN2wzQStoeHdU?=
 =?utf-8?B?R0liUUYwV3VIM0l3dk8zUlpsMytsSERYYnc2bXdxNnh5K0tQVVpRTWNIQ0Qw?=
 =?utf-8?B?R1hKRjA2NFYyQVVmUzJhK3NrQ3pTMzNQNWV3Rk1pQnpXM3FjNk83SE5FYThY?=
 =?utf-8?B?ZlJZNjZhY2txZDcxQVEzaDNXejhJVGNnWjJIYk1wb01IRzMzSGM1MHphWnh5?=
 =?utf-8?B?ZG5iOTJWWittNHRDeUkzNy93ZzcrWit0QlIrWXRRTnZMclNwa1BEZkVkWWpk?=
 =?utf-8?B?bmJmV1F6RVNTSUlTTHlVRUdFcGRYbThncFV5S00ybGgvQnVPcFdaOU9ET0Rx?=
 =?utf-8?B?WE96Q2V0d2VkSTNaZ1ExRTVtOTRONzFWcjd1WWRoUDYvb3YzajFKT2FOK1JJ?=
 =?utf-8?B?WFh2ekJ6WXRyZXhiR1ZDeGE5UTEvNWJEaUl3VXBaTC9HVDRVaEJ5U0hSZ2Rx?=
 =?utf-8?B?Y2RSaTJoZUIxR3R0TTJlSnlPYngyQzdHc05XckZ5K2J3QjVJZnVSbnZuK0Zw?=
 =?utf-8?B?TkhEZWx1S1dqZnlreC9mTjVjN1BtUi95cnNYYnZkdHdvRlJJbi80M0R3K2c2?=
 =?utf-8?B?Tyt3MEh1QzV6TVl1OTE4cmxUaC8zZDJzWkZBL0pTaG1qbTZ3QWRqMTFQVEU2?=
 =?utf-8?B?a0VJVEVIY1EvVGNwK3hZTU91cjQxSEpSemUxY28yZTBRanFxT2YrQXRqWDNH?=
 =?utf-8?B?aWlINUlpeHhqMnZTR3IzWjlVdGNFMlRQdGt3MjdaZEFEdmRYRHVUOTlkbXdl?=
 =?utf-8?B?OXk0b0ZycENMajZzb1ZkSFFWVitCNElEYUV3VFpRVFAwMWhqcWdtd28xSUxq?=
 =?utf-8?B?d1RRZ1lHaVY1eUxRWjlNYjhMOFlrUm1VcmFSeEJrN0dxOHRvL0lLZVZPVWJj?=
 =?utf-8?B?R3B0aXFpRlY3OFkvSW1KODdsSFhRcm56cTd5ZmhTR0MydFBMRGZCSTJGNXpZ?=
 =?utf-8?B?U2xPb3hwSmNqZWVNUTl2SUswYUt2QzRHRzlyLzdJT1N5eFdWUGhycnJVdGxi?=
 =?utf-8?B?ekQ5MHEwci9tQlR4bEhRSlB6VEsxdWtsL0NteEVubXZIQ0JSY0xWQ0RKbHlG?=
 =?utf-8?B?YldXRDZoeVhpdnBQcjR4eUxWSmdGejAvYytCOU9OUkVGVW1QK1RPU2N1YnFY?=
 =?utf-8?B?UWE2WTN1N0gwcWt6R0lpY2VaeGkxWnBpWW9JblNTL01UbzgzYmNvbWdkcW1N?=
 =?utf-8?B?VkU2Zm9BYVlDZnJZSHhkRUV6bmo0ZXFrQkN1aklRdS9pb0FJK0l1VWdmWnRV?=
 =?utf-8?B?L3hoV2p2VWRpQVoxQUdyUFpvZ0Q1SkxzUHZRQ1pHMmoybERMdERnTFZBV2VQ?=
 =?utf-8?Q?bRiiu9vfTuzGg4V65F?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48272233-437a-4eb2-6471-08de63b8cbbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:44:07.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRsdVbwXbsrXlrBg1rQKCC0Xlqx74O2dYxpaqe4Z/oUDHyKBejtb1tqSditn/Nv9A3p7HmgBhRv+Oy3xgB8DHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7677

PiBPbiBUdWUsIEZlYiAwMywgMjAyNiBhdCAwOTo1NjowN0FNICswODAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+IFNpbmNlIGRlc2NyaWJpbmcgdGhlIFBDSWUgUEVSU1QjIHByb3BlcnR5IHVuZGVy
IEhvc3QgQnJpZGdlIG5vZGUgaXMNCj4gPiBub3cgZGVwcmVjYXRlZCwgaXQgaXMgcmVjb21tZW5k
ZWQgdG8gYWRkIGl0IHRvIHRoZSBSb290IFBvcnQgbm9kZSwgc28NCj4gPiBjcmVhdGluZyB0aGUg
Um9vdCBQb3J0IG5vZGUgYW5kIGFkZCB0aGUgcmVzZXQtZ3Bpb3MgcHJvcGVydHkgaW4gUm9vdA0K
PiA+IFBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3Vu
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFk
bC1zYWJyZXNkLmR0c2kgfCAgNSArKysrKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9ueHAvaW14
L2lteDZxZGwuZHRzaSAgICAgICAgIHwgMTEgKysrKysrKysrKysNCj4gPiAgYXJjaC9hcm0vYm9v
dC9kdHMvbnhwL2lteC9pbXg2cXAtc2FicmVhdXRvLmR0cyB8ICA1ICsrKysrDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1zYWJyZXNkLmR0c2kNCj4gPiBiL2FyY2gvYXJt
L2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1zYWJyZXNkLmR0c2kNCj4gPiBpbmRleCBiYTI5NzIw
ZTNmNzIuLmZlOTA0NmMwM2RkZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9u
eHAvaW14L2lteDZxZGwtc2FicmVzZC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
bnhwL2lteC9pbXg2cWRsLXNhYnJlc2QuZHRzaQ0KPiA+IEBAIC03NTQsMTEgKzc1NCwxNiBAQCBs
dmRzMF9vdXQ6IGVuZHBvaW50IHsgICZwY2llIHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ID4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNpZT47DQo+ID4gKwkvKiBUaGlz
IHByb3BlcnR5IGlzIGRlcHJlY2F0ZWQsIHVzZSByZXNldC1ncGlvcyBmcm9tIHRoZSBSb290IFBv
cnQNCj4gPiArbm9kZS4gKi8NCj4gPiAgCXJlc2V0LWdwaW8gPSA8JmdwaW83IDEyIEdQSU9fQUNU
SVZFX0xPVz47DQo+IA0KPiBZb3Ugc2hvdWxkIGp1c3QgcmVtb3ZlIHRoaXMgcHJvcGVydHkuDQoN
CkhpIE1hbml2YW5uYW4sDQoNCkFjdHVhbGx5IEkgaGF2ZSBkaXNjdXNzZWQgd2l0aCBGcmFuayBh
Ym91dCB0aGlzIGluIFYxLCBGcmFuayBzdWdnZXN0ZWQgYWRkDQpjb21tZW50cyBoZXJlIGluc3Rl
YWQgb2YgcmVtb3ZpbmcgdGhlIG9sZCBwcm9wZXJ0eSwganVzdCBpbiBjYXNlIHRoZSBkdHMNCnVz
ZWQgYnkgb2xkIGtlcm5lbCB0byBhdm9pZCBmdW5jdGlvbiBicmVhay4gT3IgbWF5YmUgd2UgY2Fu
IGF0IGxlYXN0IGtlZXAgaXQNCmZvciBzb21lIGtlcm5lbCByZWxlYXNlLCB0aGVuIHJlbW92ZSBp
dCBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCj4gDQo+ID4gIAl2cGNpZS1zdXBwbHkg
PSA8JnJlZ19wY2llPjsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+
ICsmcGNpZV9wb3J0MCB7DQo+ID4gKwlyZXNldC1ncGlvcyA9IDwmZ3BpbzcgMTIgR1BJT19BQ1RJ
VkVfTE9XPjsgfTsNCj4gPiArDQo+ID4gICZwd20xIHsNCj4gPiAgCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ID4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcHdtMT47DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC5kdHNpDQo+ID4gYi9hcmNo
L2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwuZHRzaQ0KPiA+IGluZGV4IDc2ZTYwNDNlMWY5
MS4uZWViMzc2MTkzMzk4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9p
bXgvaW14NnFkbC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2
cWRsLmR0c2kNCj4gPiBAQCAtMjg5LDYgKzI4OSwxNyBAQCBwY2llOiBwY2llQDFmZmMwMDAgew0K
PiA+ICAJCQkJIDwmY2xrcyBJTVg2UURMX0NMS19QQ0lFX1JFRl8xMjVNPjsNCj4gPiAgCQkJY2xv
Y2stbmFtZXMgPSAicGNpZSIsICJwY2llX2J1cyIsICJwY2llX3BoeSI7DQo+ID4gIAkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ID4gKw0KPiA+ICsJCQlwY2llX3BvcnQwOiBwY2llQDAgew0KPiA+
ICsJCQkJY29tcGF0aWJsZSA9ICJwY2ljbGFzcywwNjA0IjsNCj4gPiArCQkJCWRldmljZV90eXBl
ID0gInBjaSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgwIDB4MCAweDAgMHgwIDB4MD47DQo+ID4gKwkJ
CQlidXMtcmFuZ2UgPSA8MHgwMSAweGZmPjsNCj4gPiArDQo+ID4gKwkJCQkjYWRkcmVzcy1jZWxs
cyA9IDwzPjsNCj4gPiArCQkJCSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsJCQkJcmFuZ2VzOw0K
PiA+ICsJCQl9Ow0KPiA+ICAJCX07DQo+ID4NCj4gPiAgCQlhaXBzMTogYnVzQDIwMDAwMDAgeyAv
KiBBSVBTMSAqLw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lt
eDZxcC1zYWJyZWF1dG8uZHRzDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZx
cC1zYWJyZWF1dG8uZHRzDQo+ID4gaW5kZXggYzViMjIwYWVhZWZkLi42YjEyY2FiNzE3NWYgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cXAtc2FicmVhdXRv
LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFwLXNhYnJlYXV0
by5kdHMNCj4gPiBAQCAtNDUsMTAgKzQ1LDE1IEBAIE1YNlFETF9QQURfR1BJT182X19FTkVUX0lS
UQ0KPiAJMHgwMDBiMQ0KPiA+ICB9Ow0KPiA+DQo+ID4gICZwY2llIHsNCj4gPiArCS8qIFRoaXMg
cHJvcGVydHkgaXMgZGVwcmVjYXRlZCwgdXNlIHJlc2V0LWdwaW9zIGZyb20gdGhlIFJvb3QgUG9y
dA0KPiA+ICtub2RlLiAqLw0KPiA+ICAJcmVzZXQtZ3BpbyA9IDwmbWF4NzMxMF9jIDUgR1BJT19B
Q1RJVkVfTE9XPjsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+ICsm
cGNpZV9wb3J0MCB7DQo+ID4gKwlyZXNldC1ncGlvcyA9IDwmbWF4NzMxMF9jIDUgR1BJT19BQ1RJ
VkVfTE9XPjsgfTsNCj4gPiArDQo+ID4gICZzYXRhIHsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsN
Cj4gPiAgfTsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/g
rrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
