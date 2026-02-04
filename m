Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B821FF4C;
	Wed,  4 Feb 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218522; cv=fail; b=UESI0XGxuSFupEc+/LFYncsfcZ8a6WT0HV1tp3RVzkywzfw1iTJKHQn2Nb2LpfO92THKwDMEWh/AWBDEL2/Pt/lc0w5ZMobWvH69UNefquPtD6ZzW1/hJJXmiLjXWr5/yEdFLzaBoVVX88Z89VezKUc/U2Ivxugbb7ve5wYyJMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218522; c=relaxed/simple;
	bh=oimnGzK6cv8S+TcYiQgswRsNJiTu1JR8RwHO6K9AV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBD31hPV3RgvnyJ+PmIdK9yvw5/H4d2D02kvMXObwf6yaVs1PVBHe7NywgNs4ALGYKH0jTK+4SKyweV8Q4Zge0xxAldw8oa0Gf4uXPq2mwiQiIFEMzo/c4eci+e7TM/Cm39JyX+2jG5Ev5guXG/Yh+eKSzsDiVPWFgTDhS4UuzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aGe+jbFH; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGe+jbFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fePaNWNonyVRyc7cO8Mci+EqIGOZZHThyAT7zTaLspCslgULwvK6W6VM7GBCyL/GJj3MjYKyxcgPQn9TdZ+uVClXGhLLY02EFqbo8JyK+DEadsleGrMIyVcCSk5Gaw1XzMFDtfutxJZv0CYjecX8HQyeQWGGj89bVGonkVwZ7ARmBqhKRTVOEEtGIMjk04OCSV0SC5oSIdhwzGZhTB6+TRUSg9Pw8shYsYFbFlHaa+u5AHazfZnGCCg/gvUs8sxSsP9gRRaYO+PQvH87TVqt/02iyofTgQ1rzmr/zql7u268kYEJsP28aRH9WOHqLI+R+YUjhWtBkGNzfEgN68yiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl+n1VEGOwEM/CJHL5Gwp2tLbvtbOu4mt2Ts8rYYs44=;
 b=fsuDanXpS5uRj9vHB0sU+AOnIiIMBEHWwLOP+Jz/O1bsmtgLGVviNwftTJ05UcPgm3/IHV0xSwJP2kLPZv2+8Uac7b57EadC48L2xK360wkoIYTwTn/vrC1dMGxFUdBVdOPbg3aPxLG6Z8B/jexxo5ECv50gL1GOONYfcl2dlpyxViemzKy7Dx6se9XkqFuFgCikke/WwJuiJ5GBYk1iKCZxhrJgxAX25y585b3ds98TxoAxLAqgSvZdSGOxFM9uF3U8loY4oAE2YOs4m00zLNkfZardQcAoKT0WKvfHv/kLXvTHgS2IuhA9Z1UJL+g6/EIAIAuULLj/ina0NgIPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl+n1VEGOwEM/CJHL5Gwp2tLbvtbOu4mt2Ts8rYYs44=;
 b=aGe+jbFHIrHX//Ihv9a01VNMwLqgD97BLRZnM9SEoUzbtOLpj7ZGCmDD4ZuYikc+56XFtSVEd21S1Ynx/CvG66X9zjOfohm+aR/BmOLBpnQLiohvszFLT3YKBQcfV3p9g9CE5wIzWQUNuQSYbfZRBCoA4tM2gEV9VSCnH4wKUtLWOW0nuu1G98WNzV6n62U+fNQOJ5I9KQ3bieKiegDNEsoLSmJ+HBa31oZpvFAPloOzILJoI9MSoiP4cA/Hq4ouV5JNhOhRB365YcU1PnbBYJop3H0zZh27iyqqfm26MMTmRTZltwAQJnw8NADN/PFSwP0jFu7XqKEJpt5LDfmYpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8202.eurprd04.prod.outlook.com (2603:10a6:10:24f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 15:21:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:21:58 +0000
Date: Wed, 4 Feb 2026 10:21:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Message-ID: <aYNkDWt89b26wJWf@lizhi-Precision-Tower-5810>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-4-sherry.sun@nxp.com>
 <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
 <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <gshz5zc7qkfkqkla2mkpu7jjf3sctrqf5jo5vszzgxzpegxzni@yhdqkykyn2ar>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gshz5zc7qkfkqkla2mkpu7jjf3sctrqf5jo5vszzgxzpegxzni@yhdqkykyn2ar>
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ebfd20-9e10-4448-72b5-08de64012314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5aajY3aHNQM1ZuREhBMU9ZQ3JESUdlVHJxM0htU09FZkFuMGRWTzV3dHRZ?=
 =?utf-8?B?SGF1WWxGOTJ1NjFwcTZMMld4NTFvZFBDNXNjM2Q5RXpLc29rUFplMjVpVWVB?=
 =?utf-8?B?eWtqQXBEM21pWGVvaktkM1JMcXRxY1RLRlp6OTBMWHUySm4wWFZKMm8yYXVh?=
 =?utf-8?B?NUxzNlpCV21CWXgvN3RNcU8zWlhhUGNsMkZESFF4bmJCY1picWhDcS9wcmpM?=
 =?utf-8?B?cjhURG9BNEd5SmlIQzloQ0Q0eENPOUVPZDlDMWFzTjEyeGc4aWl0ang3c1dQ?=
 =?utf-8?B?d2FUU3JhU3hFRHVqSlFMK3pmTVkwNlJ5aUl5Vm52cnUreEdhb3hLZ2dPYkpH?=
 =?utf-8?B?VGZZcFdSMHYyeG5CbDN3VVJJUmpCcy9rL2tvWVZWa0ZnT3NLMDNoVTlpOWRZ?=
 =?utf-8?B?NThyMmxEWFhucWI1aWV6cjllazFFRmNDNDhDTnRjOHNkVjNRTkZqakh0NDFV?=
 =?utf-8?B?cFZiY2JqV3BsUEZOcGFsQTYyb0xuSTNESWRMY3Bqa2xvYis1SnNqTEw2MDRR?=
 =?utf-8?B?Z1hUdnh1UzJNc3J2d0xBdnZoZWRneUd0ZXNJcWE3aDlYSElFZU9BK0luMFhz?=
 =?utf-8?B?TTlic2NnT2tnMmxWaUlZY1hMSzRDbk5rVTRQMjNhSW00UXBNMmZmNFE5MFZs?=
 =?utf-8?B?Rmkvb1U3YmI1bDRwZ0J3RFE3YVZVSlU1U29qZ0lPWURLTHVValh3Uzl4cmNz?=
 =?utf-8?B?ejZlcTNzQUhEYU5zSS9ZdGtpWmFGMGtNc1N0TU44S1IwMklqeUdGKzQwM3Nj?=
 =?utf-8?B?dCt6bUpERVp3NnJmczRSdzJzbENDSUJPZk9MY01CdmZDa3IrVlVJdmp5cEts?=
 =?utf-8?B?WHZvZWlRZ2NEbWk5aENUZU9MNnR3Ykd6RFN1TGxCT1UwRHY2NzZIT09Nc1N4?=
 =?utf-8?B?OWgwZ3hvSVNRSDIyWTRoL0pLajA4QmhZUjdIdkhXNHllSUFpb042STgzakRU?=
 =?utf-8?B?RzBIcWd3OFdxZGlYL3lwS1dldTFrV1VVSWxRS20zU2RaSE1EWTh5VHAxQlBm?=
 =?utf-8?B?OENsVXdHSm9YNDc3aHNHRWh0bHdyb2Z4V3NBWHZST0ZJbEFhMXZFeTk3UGZ4?=
 =?utf-8?B?NDNtMHNqZW56S2QxK2VUV3liNlV4VVhNUzBkQ0d4ZVJ4amlzbzkxM0JqL3Rq?=
 =?utf-8?B?cXRva2t2NzE3b1Y0NldUZmUvclVKMTJSZSt2VWd1Y1IyU2tWMlcycmtlMlY4?=
 =?utf-8?B?UnlLTi9yelZaS0t0c2lUcDB6bzMxSndqUSsvQSs5MHVYbTV1Wktucmthc2d4?=
 =?utf-8?B?eGJPeXR4MjhkNlBpeXFLK01pTWduc1JZQkJSQllEKzNCNlJQUEJuZ0VzQmtC?=
 =?utf-8?B?d2lreDU5eVRPenBJd1lvbUo4TlZxN1hvRDBhVlQramhZeXk5ZlJ1OHhRMmMr?=
 =?utf-8?B?SEpqK0JKbnE4cUFWSUE4VlJaUEY0NGo5RWlKK2NLSG41aE5IR2RCd0M2d3ND?=
 =?utf-8?B?YitEQTNIZy9oY2ZqMUJ2SDluYzRjUTkvd1ovUmVmZTFtMlRGUVlrOUJOR096?=
 =?utf-8?B?aVVJalhLUXp5WS9TWGhualpnME1HbFlYVCtTTlpGWG1UZTIrSDJ2NThxOUFQ?=
 =?utf-8?B?SDFjM2NZamd4dGs0ek1KWGtrOHFiNTh0aHNnT043Y2UyNG9vR3BnOE9vVG83?=
 =?utf-8?B?M0hhVklrVnJuWFRTTHkrajh4aHpjU2JuSytOYkMyenAyM0VhRTFabGREUmVG?=
 =?utf-8?B?V21JMkNiUTNsT3lMQjI1L2ZPbnpJSFkweXZuZnR3K0JYb2VzQmU0T05OTWlx?=
 =?utf-8?B?Ym5ydXYzV0ZiZUcrNFh5NkxzaGFZMitkTC9vZGpVNzF2dDJna1hYWTJXS2p3?=
 =?utf-8?B?WW9QOVJ3UXpCT2gvamNVUVE3MGF1TFBuWDhDRXQxS241SkZDaWZrQStUUHJF?=
 =?utf-8?B?dTk2TzJ0cmxCNWFXeEhzeVRHdG8rMDY3UzBsK3o1NW9HalU1alVwd3V0Q3dV?=
 =?utf-8?B?SzVtdGZVRFBQckplWVRBenNkOG5hRWxsT2lodmlkVzdPYnBpSlA2Mzh4Q21E?=
 =?utf-8?B?bTRmbmVMdVQ1eTlsczYzSHgyaXlGWDA4Q2FlQlBiNkpWWjNqQ3RRTG9GUTNi?=
 =?utf-8?B?QlZqVlI2cFk0VkZhYW9LZ1lGQUJnR0t1TTBkdGFqa0NsTjBabU5RbEV3enB3?=
 =?utf-8?B?cS95S2h0QU96MHNhRkZUZjcwWmh4OVR5VXhHMkd6d3VxQWZEdGo2dHRvRGx4?=
 =?utf-8?Q?Ga6CPOVRWQDi3eK372Plai8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0UrbGhGTGdSYW5tU1NmUjgyVnpxREQxL2pPOXlIblRFR2Q1NXZzdHpEWllm?=
 =?utf-8?B?WjBoUW4vc05kcFZjSGJYVWw2TmZUUGZMMlROejR1NGZLSHJXdFZid0RKSEVt?=
 =?utf-8?B?bmRJaGJSdjNNV1pqZzBPWjZCMVBTUk9PUjY5dDFIYTdkMkJDc1FNNDUyRkMr?=
 =?utf-8?B?WXc1Sk55OGVvZ1ZmRHlkWWVweGZ4U3M5aVE1MTkySVdxMUxmOUROdlhFREV5?=
 =?utf-8?B?RStkOUc3RjB1aW56SXhQQXNRWEdJRjgrVzRCb0hiR2plT3BrbGZ1MEJYZTdZ?=
 =?utf-8?B?Wkw3c0VqUEYzbnUrcWFMV1hWcWJlQVA1UzAzNlVvYjcxSkdXTmpEakpLZzlW?=
 =?utf-8?B?Ulh2cTdEMDlKNXVvTXY0U1FpYm04blpIQWFuTkxQbUttT1RIYlA4K2hCTG5Q?=
 =?utf-8?B?cjNlQVh5NW12RUE5bm1zRmlnWitZOG85b2VvTys3ZVZPMGtoeks0Qk1aU1Ro?=
 =?utf-8?B?dnJ0RHZwbEoxTWNOcWJHaDZONkJPWVNrL1NwWkFrZGV5RnRBSHBBT3ZpQ0ZK?=
 =?utf-8?B?S0FPdmlxU3Brdm85K3lQbGZyTnpSSms0RFJSODk4UTZZOGtHL3FaNFNRZkQ0?=
 =?utf-8?B?WTNqTzRZQS8yckFPNUU5NWpMaFh5c2o5ZFozN2xLeUYwaUFwOCsyZ1ZUSSs1?=
 =?utf-8?B?a00xU0lyUkNIN0xmb0k2bnp4c1JRSkEvRDRzOFhWS1kzUnBFUDJoSDFndlpR?=
 =?utf-8?B?WXozQkVtYXhDUjZ6eGQwSk5HcW5CWi9JZWtDTlpWTTBHRGtmMnA5cHdoQUVD?=
 =?utf-8?B?bEUySGtwMGFKNE40RHVHQXYxd0lyWkZYams5OWtOWDlpU3ZSMHRiZzY3K1F2?=
 =?utf-8?B?K3R3Qys3WWZuL0NzSm5SMlk3QmNqa2NrUnh2SlAzUkViK0hVWlB0T0dQeEY3?=
 =?utf-8?B?OTY4N3YxL09ubGZVc2VuVmIxenFSQ1NMS25EQUpmeUhjVFBOT1BUY1VWMG56?=
 =?utf-8?B?eVgwVXgyVTYydTBRWm83WUZKbmxCb3VFeUtsa1hJUnJ1YSt2c0FCUk5md3A0?=
 =?utf-8?B?VjhEbjFKbVZKckJQUlJWKzVsMzE1Rk5uUGxPbndzcGt4U3V1eFRhS0gwU1pu?=
 =?utf-8?B?VHlrS3RYdCtPbVo0dGgwL2V4eHMvM2VOSnhzYklhSFRuM0dzZi92Y3lUazQ4?=
 =?utf-8?B?bEtBVHdlWU5ObDBIOXJtZVp4SU1URnV5NUhxVExkbkVSV0FNbmxjd2YyeEVa?=
 =?utf-8?B?NEU3bjFkT2gyMzFYaFJPdHh5M2Q2Y2gvUjMyUFhuKyszMlZsUVNDU3RkUkM2?=
 =?utf-8?B?TEt3dmRBb2VmV1R6cWx4eEEwa1VERVlLRjdaUTcvUE5CcmpQZHE0Ky9GVWZi?=
 =?utf-8?B?aGxnZVl5WWxjSFRscWFUcnpiZWZCeWhHOFhRRUxMalRjSVh6cTNJTUFXeVFT?=
 =?utf-8?B?cjExcXljYWwyTHlrTStNeWpVK0RMaE5tRk54UVlBc2ROeWc5eVl4VVFUL1hG?=
 =?utf-8?B?M3B4WUtnTXV4c0NTT0t4QzRqMWdweWYxbXJZVFI2bkJ5dTRGRlV3OXN5UmFn?=
 =?utf-8?B?cFlsYmpCOEwvYWs0cDF0aWN4NHJ6SmsycThicVFiK1pZdjZpQmVlOElCcmVK?=
 =?utf-8?B?cWJkOHJQZWtzdUgvQStwV3BmeVordHJkcGl0RWhWK0MvcFdJK3Q4Vi90S2p1?=
 =?utf-8?B?YWM2eHUwS2hDeFJ6N3pCMzVpWDcyT0dOaDRvZVlsb09PNmR2ZGt3ek8rSmRi?=
 =?utf-8?B?UmoyRlN2eStNSlUxNVQyTXN5VENDSmRyaGNrRSszaXVEUzhPUy9qUUFieDZa?=
 =?utf-8?B?bkg0dUJxMWFkVEdqSXRac09HZE1rU3lEL2Ywd3BvWHFrMzRKWllVbDRHQnhK?=
 =?utf-8?B?UEV0d0JnQWtVYXJnbTJTeHFyNHczMDZQSldObkd5ODdSMDI1VzFNNDlJaUQr?=
 =?utf-8?B?ektjYmpzcW1XQmpWc01JVnVjN3k3M2ZxZVZWeTEzZ1o2N3ExbmI4K2Jnci8w?=
 =?utf-8?B?ZXk2YXM1V0xza2FkdExmODN4M2NoMjFyZm4ybmE2MUpPSUVzdkN4Ukh4RHBw?=
 =?utf-8?B?ODBpbGF1cGJUcFJObTMvY25GZGJjTEttSjJYZVROR2k5T2dQWDU2Rm8wSlBy?=
 =?utf-8?B?b3pRdmRvYUJaSHJpaTNOZjlseGRnUXdVZEdod3lyUnpSVzV1MDdLUXR0cGFY?=
 =?utf-8?B?d0xEaHRQNy9hQzJTem5lVW1TclF2cnh6blNuekpYeVdkOWM3NlRVYkx1TnlX?=
 =?utf-8?B?OGlRaTNUSE40UGpMVzl0YTBQL3p6RHc4Q0JaZzc0S1pGeTNoREg2UWdQN0gz?=
 =?utf-8?B?TGRSVGpsdWt0QVVLRU9BSnVmSWg2YmxrblNsUWZGZk8xTm5tSkpvM1JPZ05Q?=
 =?utf-8?Q?aVGcRify3z7cGFf3UO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ebfd20-9e10-4448-72b5-08de64012314
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:21:58.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPvfRVZWZV820JdbVB7cK1OWCFYW8yZX3KPGN/TOAvbJ+WBdE7ruLYYsIMKU3t3mx7cIIQQ+zkKc207HHN/99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8202

On Wed, Feb 04, 2026 at 06:03:55PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 04, 2026 at 06:44:07AM +0000, Sherry Sun wrote:
> > > On Tue, Feb 03, 2026 at 09:56:07AM +0800, Sherry Sun wrote:
> > > > Since describing the PCIe PERST# property under Host Bridge node is
> > > > now deprecated, it is recommended to add it to the Root Port node, so
> > > > creating the Root Port node and add the reset-gpios property in Root
> > > > Port.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
> > > >  3 files changed, 21 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > index ba29720e3f72..fe9046c03ddd 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > @@ -754,11 +754,16 @@ lvds0_out: endpoint {  &pcie {
> > > >  	pinctrl-names = "default";
> > > >  	pinctrl-0 = <&pinctrl_pcie>;
> > > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > > +node. */
> > > >  	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> > >
> > > You should just remove this property.
> >
> > Hi Manivannan,
> >
> > Actually I have discussed with Frank about this in V1, Frank suggested add
> > comments here instead of removing the old property, just in case the dts
> > used by old kernel to avoid function break. Or maybe we can at least keep it
> > for some kernel release, then remove it later.
> >
>
> If the new DT breaks the old kernel, then the kernel needs to be upgraded. But
> typically, one would update both kernel + DT or just the kernel, not just DT.

But it should not impact bisect. Driver and dts is not in branch. If driver
applied ahead of dts patch, it should be fine to remove it. But default
linux-next can't guaratee the merge order.

To avoid merge complex, keep it for a whole, then clean up it later.

Frank

>
> - Mani
>
> > Best Regards
> > Sherry
> > >
> > > >  	vpcie-supply = <&reg_pcie>;
> > > >  	status = "okay";
> > > >  };
> > > >
> > > > +&pcie_port0 {
> > > > +	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>; };
> > > > +
> > > >  &pwm1 {
> > > >  	pinctrl-names = "default";
> > > >  	pinctrl-0 = <&pinctrl_pwm1>;
> > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > index 76e6043e1f91..eeb376193398 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > @@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
> > > >  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > > >  			clock-names = "pcie", "pcie_bus", "pcie_phy";
> > > >  			status = "disabled";
> > > > +
> > > > +			pcie_port0: pcie@0 {
> > > > +				compatible = "pciclass,0604";
> > > > +				device_type = "pci";
> > > > +				reg = <0x0 0x0 0x0 0x0 0x0>;
> > > > +				bus-range = <0x01 0xff>;
> > > > +
> > > > +				#address-cells = <3>;
> > > > +				#size-cells = <2>;
> > > > +				ranges;
> > > > +			};
> > > >  		};
> > > >
> > > >  		aips1: bus@2000000 { /* AIPS1 */
> > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > index c5b220aeaefd..6b12cab7175f 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > @@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ
> > > 	0x000b1
> > > >  };
> > > >
> > > >  &pcie {
> > > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > > +node. */
> > > >  	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
> > > >  	status = "okay";
> > > >  };
> > > >
> > > > +&pcie_port0 {
> > > > +	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>; };
> > > > +
> > > >  &sata {
> > > >  	status = "okay";
> > > >  };
> > > > --
> > > > 2.37.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
>
> --
> மணிவண்ணன் சதாசிவம்
