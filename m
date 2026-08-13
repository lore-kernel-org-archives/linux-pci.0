Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFA3603D8;
	Thu, 13 Aug 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607383; cv=fail; b=JlTHzqqf1AuKweGXinlhB89wO4RqRqbNd2BeysGgfr6ZL/5ga6CRpa+EZL62uSipUSjadJ5FhvRcFUR7JET4gFa5LE9aNMrpfEfrAI4HP24vlAuqE9aeWrfJJBH73VdGAsyYSsqJq5QG893NzlCLaH7CmVBHLt1tj9+b9XWFvZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607383; c=relaxed/simple;
	bh=9ENbNqusky4cC1HnMfKQy0DJ2XfgUF/2pgmcMn/89Tg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Igrr21pUBqlaYngPFIEprh2+AyPfdBPgKqkRoF2nIyqy8ieX+KaBrXOY0VEwrtNhVtXm6ZRiAa4NYdp2GXgUE1QU9462hl7Ak2GwmfvA2uAF78tKxsXTQt5UsgsuE98x/ZL15Hg51bngjTc44KGLc3QSGr/yu8OKqm47xWx9szw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l+mepRe5; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l+mepRe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl01YC0iD17A4W3Nvzgk3thaCuyppUHSzMWMgEE2WOo6Pwp+seE7awIE+90mBeDU5AnAuIrwER1dBMiJ4qIjc6zW+ufvArkgG9eTQ4GDBn4xtdqZapMP4EeAbnPJ9oSi5ugUrEgpVqfKxbgO8p7f/TCGfdJxrZXDpx4POE3dB7h6WuVdXxW7QhtUAvNTbtncuahd+YxOZOkppCArtbl3O5hN85TqZUUilRo49h1OOa6HUQDuZp2DnGCDxo7pxpBZFZl1NKfg5WZj93OqyMcmtUYBCmIHCusvGHq72vTLtdf3VHI01JAPfn/6pM2h0Y1ahd5A13tn+bgd5KPBlM5lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ENbNqusky4cC1HnMfKQy0DJ2XfgUF/2pgmcMn/89Tg=;
 b=hqI8HREkGu9mE67HhB0uJb2WQ4yJHg+zHFg0d/GCmxFGPXzQK8Co9IMc88+l7UjknJRPthU9vw8xzaeW+P0LHQ0Hr09VKdshCPRDAH20w2vvuxldSyHp8aehyDoviHQgilJCMjrgBtkYK3TQqNFLIwKrLe7ygru95sKkO0zdx5eVlquF8MN9uwg5WYKxhfts4g86elFJduDsZ0MvF9QXs22hU596ITQTDVjPwS51dqgC485gZhY908tHBSIHh5pv1mV1+QjOkAjGkqAgQkZpByPKAOmlEz7oQ1GgvaYr4fkFSZS4edqJmSrblUov4NxGrIWMweRS/bdjWldZ3qKm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ENbNqusky4cC1HnMfKQy0DJ2XfgUF/2pgmcMn/89Tg=;
 b=l+mepRe5j3vOmoYsLumTntXD2SBOdaWwy634+I3jokT1P7WBqgdZAUKbEzk0MN7k4w/sgsTO59Rxf2a2bxOrt11P7FuuTB2dtt72uGIbCGhgGABZ3WawR0P57ass/3fmJKrEZ0SbUa68jhen9syv9IOVvZXXapHsFenBIz+rjFFhuCI7QmG9Kfrv2hu3hbkABL/A0Z/rfW2Ar0Uze0p/aQgK4HzMwkYUSxNOriNTQojSmH089IB651rJ7gNFSnfdqVh0WhsPzqXEMvs85wULcu4pC5ThV9ZQ3uq9oTbauC4fUBY1dPcH9bp+afQ5NzGmlTeWS+PVscuK12m51nQTUA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PAWPR04MB9987.eurprd04.prod.outlook.com
 (2603:10a6:102:387::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 07:49:32 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 07:49:31 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Franz Schnyder
	<fra.schnyder@gmail.com>, Hongxing Zhu <hongxing.zhu@nxp.com>
CC: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>, Leonardo Costa
	<leoreis.costa@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "leonardo.costa@toradex.com"
	<leonardo.costa@toradex.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Sherry Sun <sherry.sun@nxp.com>, Manivannan
 Sadhasivam <mani@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Thread-Topic: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Thread-Index:
 AQHdFLRQqewhn1aJKUO40yds8E4l57ZvZwwQgAD7KwCAJ1/lgIAAYssggABpjgCAAY1tsIAACXmAgAGddICAAAOYgIAAACxw
Date: Thu, 13 Aug 2026 07:49:31 +0000
Message-ID:
 <GV2PR04MB12019E2DA2EA87FD090B42CD78CDB2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260811063752.GA7332@francesco-nb>
 <GV2PR04MB12019BC21C743E1BEF1BE8F4C8CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <anwYlX0uC1nFCxnp@gaggiata.pivistrello.it>
 <t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj>
 <20260813074653.GA11024@francesco-nb>
In-Reply-To: <20260813074653.GA11024@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-13T07:47:29.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PAWPR04MB9987:EE_
x-ms-office365-filtering-correlation-id: a95e05ca-f317-477f-8723-08def90f693f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|19092799006|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info:
 Sx53OumS8dMRM/TVzXx+eg80zuVQkL22C1D8cnR9x4ytreDVBhwWEU5v6/Yz6UUrV0AdKe7wsGGkNpf5wlM5PFRN3PrfXojdP38kczGMFxiTutcayNtEBuqsezcB3eBVKsjcqbqYDAEqvenro4yU4ynqy6bUeJxrOZt/t0sWUh1EtkE+ZsQFNAoh1FZu6B0ObCf8KAbpbUVoBxONCn50xW6vmRorePHX7rHis4JuJj+6RvpV1Nn4Q9pCoTcIujmIlNn9EIJEHiNIwqaSbO6X1yzqfeV85VxQZ1tWKKD7gZ2idRirJKO6sJd8x4yiHJRigcZlqpn1Og82h/GUpuQTVQC8I/GyHocA8yU27+f+9eAeLoKZkf5rICLdWmlkIgTIqmSDxttZYEjM5OPqYHSXk143jpwGTrSEJ7cuvlly8UpQR8RWekmggAZApc9QMDBC92On4BfpYFTyrBLSxN6eXc35Y15TKI3Sg9/dKJ2E+qsq2T6eROj/ZSiZEoUW10OEUzzqMXtTm8xf1x9b8WzHiw21Kiw8rFyMmsh+0j4kcZkwJOTNWwOIgS4GfjXVn9VyedumCKCOeAeDf5HLRuB2OmEXMNMbMbv4+Mxg9oxI0T4u5HhEuId6Tr9w+4fZqM26qtpUWvaWRpELlJqIck+/5yXrXDXAB26XT7dS92gSZ1lLn0UlcULekElZDZowTUy0ptQEIO6xr9d1EPKovzDBI7jEZh9nL7NgOAUN66KaZYU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjdqaGZsdDgrTmdMa3ZmeU5MaGR6azVEY3FRZmlYVEtJaVJQT29ySXJld2h3?=
 =?utf-8?B?T1J6UWEyNDVuN3lOWEN5UndLbFZBa1dXUlI1WXlwSEdwcURhVnI2U0dQVm9p?=
 =?utf-8?B?MDBqQis2TWNGZGJtczVCTTBSRzM2RTRmUnVRWjkxLytlYTBsdU8yQlpBallV?=
 =?utf-8?B?cnR1dUpENlVhcVk4emxhRWhJWWhXMG5ocWt0N0xoUmEyU0FUeVZCbmZtcUQ5?=
 =?utf-8?B?d0JSbWJHRzdQYjk1aG9BYkkrWVpkc2psemRCM1Rvc294cVRXbTJXdGRLZlRj?=
 =?utf-8?B?OTY5Uk1KbDhpM3FXU0NsdlhTWkpqR2M5d0dKOXZrdTE1SkdVL1lYc2lUbWts?=
 =?utf-8?B?S2JTZXRSbldMUlc1TTBDdnplZ2pYdURiUVVqZ215OFdlUjQwSHppQldaTDUw?=
 =?utf-8?B?TEJZdFZnOGFhV05uZHppTGt3dVl1Wm9kcmo5QnUzV1A5bk1MSWcybkUyYkpC?=
 =?utf-8?B?dDBETGdINmk5OTFOTkJmNlZ6RmYrUkZHYXBDRE1lNUdrUUM0Q21TQ1Bab3lm?=
 =?utf-8?B?Y3VBbWJ2NnlLekhWT2tuZ0xiWTBQSkJVUk1SN1RRS1hmcmlpZlRLdnduUzZx?=
 =?utf-8?B?YTlFTFFkVHViRHR2aGxNeC9DV0FPMzVFbW54Y2dOK1ZHL213TVNGRENSamhm?=
 =?utf-8?B?UWV0cGZMR1JmZGlSZTdKYVkrVm9sU05ETXpETjkrNlhqSGFHNUZEekRQY3dh?=
 =?utf-8?B?clV2UDVRanF1b290U3V0OFhna0ozQy9LR1IrTThNcVc5ZzFCY3UyNm41ODdX?=
 =?utf-8?B?SVI2MHJhSTE4YnFPUFlTOCtXb0U2ckZhV0s1ZEdLQVBjeE9zVEVpUytqMnRK?=
 =?utf-8?B?Q2lqS0lSTjZjZGdSbkZRMDYzMUlpeGIvZVdMNGZxZS9jallwekN6NXRFN0lU?=
 =?utf-8?B?OFI3QllNU1VyeExRWWZVMzRYOGN5blRnQm1NOEl4b0NHdXJyWU1mSTUweVA0?=
 =?utf-8?B?WkxmMFRLdGhqQzg1K0lrcnZ1UzlLamc0WnlCbjhaTDhZLzR4M1hqTXZpS1JV?=
 =?utf-8?B?VlJmREh3VndNbEpUSnlkQUtaR1JmNGJqUTZHOGgrdVJWQVhDYVE1OVlCdlhW?=
 =?utf-8?B?YzVBaWFHdkVyZm1TTSs1TWtvRWxGUlB3SDBJQ2U3TWJDRlBFc0tpNy9PZHg1?=
 =?utf-8?B?ZzZRRFk3R2tQQiswTEtYeEVqT3JXdE0wZ2YvdTZoQ3ExMXdRc0Rlak5XOWkr?=
 =?utf-8?B?M0JZMGZ4R043blZ0cUZYdzE4cWxLbnduRHJDL0hiOTE0bjh5dlVNYisxRGIz?=
 =?utf-8?B?c2E0WU1YaXhyc2Uxa0dPdUhjSXA0cC9Ra2VBNXRpSlVTSXRVY0ZuempNQ2RK?=
 =?utf-8?B?VWo4MWtLcjdGYi8wcDBSalJnK2dYK1hFcW5wa1FqSkd0QlJrZUhtYWRMUEJH?=
 =?utf-8?B?M1dBdlJuUEhCR3BnSVYyeUg4YzgyVlRTRkZNS1Y0bTFPSnJOaTZqNEVtODd0?=
 =?utf-8?B?eHRVTXFwWi95UXZCY2tQbDBnM05RdXpEckNXSDBnS1dxdUJzWmlkM1dZRllP?=
 =?utf-8?B?bFRnYm5RYzhabmZraTNURGoyalI0RGRlQitXY3lkNzNnNHNqbExHckR0a0oz?=
 =?utf-8?B?b3FQVWpTWDNKZUZBTmN6cHRyL3k5ODZqMHdDOWdVWmQxcmZZejUxR0FHdkhY?=
 =?utf-8?B?OEd4VFRnZkM1TFlqZDhCZU0rVmhEbDBBZVFOQ1JkeWZjT2IyZ0NRcFR3WjFV?=
 =?utf-8?B?cGRRMHhTSVp1Ynd4R2ZYdlJ0SUdURktIL2JIeHFpcGhvQ2NCMThoL2ZDTDl1?=
 =?utf-8?B?NFFOM28wYUYvWFhyNG5wNEVrbFkwOUtKVWpieUY5bHM4SjZnRVFRcnVrZ1N1?=
 =?utf-8?B?R2o5V0ozSWFvRkdmQXBMSFBhc3RFdUVZT2FVYzAzc1FjeThGYmF0T1NCTzly?=
 =?utf-8?B?c2NJQzQzK3RkNGlsTG9JTXlKVDc3TFZkaDFWNnZyeC81ZnI1WUR4R2ZodTZR?=
 =?utf-8?B?NHloR3F2OGkyNUFHeDAzVEI2SnJkZTJ5Rno2V0xwN0VyUnBJaU5jSURrMVBw?=
 =?utf-8?B?REs5WG5IMlcvcnZsRHZrL0dJTTNDTHNFR3NLV0duYTRlci9Wd3Y3MDk2RDN3?=
 =?utf-8?B?UWVsdFdCOWpJczVxWHAwcXBFUWZOcVREdlNzZ1pSVWs5RFdkdjRoblJJVkxT?=
 =?utf-8?B?ckJadEZVNHZKL083NXlnZThsSHVScU1ZZVZxdTNtZTVBeEh1NW4wTTdRSEJQ?=
 =?utf-8?B?SVJQbE0yVGM3eERyR3gzeXdPeXVqOTJsdzUvdjcwVmFoK3d3RWtCQnRaSG5X?=
 =?utf-8?B?bWcwakZQaFQxcisyaDhJZ0c2SVBxcCtBMFZpdWNZSElDYVhuUGhwYUk3OTFs?=
 =?utf-8?B?SFJwQ1VhdEs5V3NSZUwwN0twMSs2VjdsN3orWnRMdExwRVhvVUVydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95e05ca-f317-477f-8723-08def90f693f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 07:49:31.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REqqF7oJAWRvMId6wUKiL8S5CpflJNrq+mWQaZeAp0rW/WXAiK+oGdzLeBJp/xMvwqi3LWNAoSp3z4H8bPEVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAxMywgMjAyNiAzOjQ3IFBNDQo+IFRvOiBGcmFueiBTY2hueWRlciA8ZnJhLnNj
aG55ZGVyQGdtYWlsLmNvbT47IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+IENjOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+OyBIb25neGlu
ZyBaaHUgKE9TUykNCj4gPGhvbmd4aW5nLnpodUBvc3MubnhwLmNvbT47IExlb25hcmRvIENvc3Rh
IDxsZW9yZWlzLmNvc3RhQGdtYWlsLmNvbT47DQo+IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2Vy
bmVsLm9yZz47IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitk
dEBrZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBs
ZW9uYXJkby5jb3N0YUB0b3JhZGV4LmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJlZ3Jlc3Npb25zQGxpc3Rz
LmxpbnV4LmRldjsgU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPjsgTWFuaXZhbm5hbg0K
PiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUkVHUkVTU0lPTl0gbWFpbmxpbmUvbWFzdGVyOiBBcGFsaXMgaU1Y
NiBubyBsb25nZXIgYm9vdHMNCj4NCj4gT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMDk6MzQ6MDFB
TSArMDIwMCwgRnJhbnogU2NobnlkZXIgd3JvdGU6DQo+ID4gT24gV2VkLCBBdWcgMTIsIDIwMjYg
YXQgMDg6NTQ6MTNBTSArMDIwMCwgRnJhbmNlc2NvIERvbGNpbmkgd3JvdGU6DQo+ID4gPiBTbywg
dW5sZXNzIEkgZGlkIHNvbWUgbWlzdGFrZSBpbiBteSBtYW51YWwgdGVzdCwgdGhlIGlzc3VlIGlz
DQo+ID4gPiByZWxhdGVkIHRvIHRoZSBzcGVjaWZpYyBQQ0llIGNhcmQgb3Igc29tZSBvdGhlciBz
dWJ0bGUgZGlmZmVyZW5jZSBJIGNhbm5vdCBzZWUNCj4geWV0Lg0KPiA+ID4NCj4gPiA+IEZvciB0
aGUgcmVjb3JkLCB0aGUgZmFpbHVyZSB3YXMgZGV0ZWN0ZWQgYnkgb3VyIENJL0NELCBhbmQgaXQg
aXMNCj4gPiA+IHN5c3RlbWF0aWNhbGx5IHJlcHJvZHVjZWQgb24gbXVsdGlwbGUgaGFyZHdhcmUg
Ym9hcmRzLg0KPiA+ID4NCj4gPiA+IExlb25hcmRvOiBhbnkgY2hhbmNlIHlvdSBjYW4gdGVzdCB3
aXRoIHRoZSBzYW1lIFBDSWUgYm9hcmQgdGhhdCBpcyBmYWlsaW5nPw0KPiA+DQo+ID4gSSByZXBy
b2R1Y2VkIHRoZSBpc3N1ZSBvbiBteSBzZXR1cCAoZXZhbCBib2FyZCArIHNhbWUgUENJZSBjYXJk
IGFzIGluIG91cg0KPiBDSS9DRCkuDQo+ID4NCj4gPiByb290QGFwYWxpcy1pbXg2LTExNDg2MDQy
On4jIGxzcGNpDQo+ID4gcm9vdEBhcGFsaXMtaW14Ni0xMTQ4NjA0Mjp+IyBkbWVzZyB8IGdyZXAg
cGNpZQ0KPiA+IFsgICAgMC4xNjI4NjBdIGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBob3N0IGJy
aWRnZSAvc29jL3BjaWVAMWZmYzAwMCByYW5nZXM6DQo+ID4gWyAgICAwLjE2Mjk3NF0gaW14NnEt
cGNpZSAxZmZjMDAwLnBjaWU6ICAgICAgIElPIDB4MDAwMWY4MDAwMC4uMHgwMDAxZjhmZmZmIC0+
DQo+IDB4MDAwMDAwMDAwMA0KPiA+IFsgICAgMC4xNjMwNDNdIGlteDZxLXBjaWUgMWZmYzAwMC5w
Y2llOiAgICAgIE1FTSAweDAwMDEwMDAwMDAuLjB4MDAwMWVmZmZmZiAtDQo+ID4gMHgwMDAxMDAw
MDAwDQo+ID4gWyAgICAwLjE2MzE5M10gaW14NnEtcGNpZSAxZmZjMDAwLnBjaWU6IGNvbmZpZyBy
ZWdbMV0gMHgwMWYwMDAwMCA9PSBjcHUNCj4gMHgwMWYwMDAwMA0KPiA+IFsgICAgMC41MDUwNTZd
IGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgNCBvYiwgNCBpYiwgYWxp
Z24gNjRLLA0KPiBsaW1pdCA0Rw0KPiA+IFsgICAgMC41MDUyMzBdIGlteDZxLXBjaWUgMWZmYzAw
MC5wY2llOiBMaW5rOiBPbmx5IEdlbjEgaXMgZW5hYmxlZA0KPiA+IFsgICAgMS41MDgxNzNdIGlt
eDZxLXBjaWUgMWZmYzAwMC5wY2llOiBMaW5rIGZhaWxlZCB0byBjb21lIHVwLiBMVFNTTToNCj4g
UE9MTF9DT05GSUcNCj4gPiBbICAgIDEuNTA4MzE0XSBpbXg2cS1wY2llIDFmZmMwMDAucGNpZTog
cHJvYmUgd2l0aCBkcml2ZXIgaW14NnEtcGNpZSBmYWlsZWQNCj4gd2l0aCBlcnJvciAtMTEwDQo+
ID4NCj4gPiBBZnRlciBhcHBseWluZyB0aGUgbmV3IHNlcXVlbmNlIHByb3Bvc2VkIGJ5IFpodSwg
dGhlIFBDSWUgY2FyZCBjb21lcyB1cC4NCj4gPg0KPiA+IHJvb3RAYXBhbGlzLWlteDYtMTE0ODYw
NDI6fiMgbHNwY2kNCj4gPiAwMDowMC4wIFBDSSBicmlkZ2U6IFN5bm9wc3lzLCBJbmMuIERXQ191
c2IzIC8gUENJZSBicmlkZ2UgKHJldiAwMSkNCj4gPiAwMTowMC4wIFNBVEEgY29udHJvbGxlcjog
QVNNZWRpYSBUZWNobm9sb2d5IEluYy4gQVNNMTA2MS9BU00xMDYyDQo+ID4gU2VyaWFsIEFUQSBD
b250cm9sbGVyIChyZXYgMDIpIHJvb3RAYXBhbGlzLWlteDYtMTE0ODYwNDI6fiMgZG1lc2cgfCBn
cmVwDQo+IHBjaWUNCj4gPiBbICAgIDAuMTYyNTE1XSBpbXg2cS1wY2llIDFmZmMwMDAucGNpZTog
aG9zdCBicmlkZ2UgL3NvYy9wY2llQDFmZmMwMDAgcmFuZ2VzOg0KPiA+IFsgICAgMC4xNjI2MzZd
IGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiAgICAgICBJTyAweDAwMDFmODAwMDAuLjB4MDAwMWY4
ZmZmZiAtPg0KPiAweDAwMDAwMDAwMDANCj4gPiBbICAgIDAuMTYyNzAyXSBpbXg2cS1wY2llIDFm
ZmMwMDAucGNpZTogICAgICBNRU0gMHgwMDAxMDAwMDAwLi4weDAwMDFlZmZmZmYgLQ0KPiA+IDB4
MDAwMTAwMDAwMA0KPiA+IFsgICAgMC4xNjI4MjhdIGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBj
b25maWcgcmVnWzFdIDB4MDFmMDAwMDAgPT0gY3B1DQo+IDB4MDFmMDAwMDANCj4gPiBbICAgIDAu
NDg4ODkzXSBpbXg2cS1wY2llIDFmZmMwMDAucGNpZTogaUFUVTogdW5yb2xsIEYsIDQgb2IsIDQg
aWIsIGFsaWduIDY0SywNCj4gbGltaXQgNEcNCj4gPiBbICAgIDAuNDg5MDMzXSBpbXg2cS1wY2ll
IDFmZmMwMDAucGNpZTogTGluazogT25seSBHZW4xIGlzIGVuYWJsZWQNCj4gPiBbICAgIDAuNTkx
MzMzXSBpbXg2cS1wY2llIDFmZmMwMDAucGNpZTogUENJZSBHZW4uMSB4MSBsaW5rIHVwDQo+ID4g
WyAgICAwLjU5MTk2N10gaW14NnEtcGNpZSAxZmZjMDAwLnBjaWU6IFBDSSBob3N0IGJyaWRnZSB0
byBidXMgMDAwMDowMA0KPiA+IFsgICAgMC42MDI5NDddIHBjaWVwb3J0IDAwMDA6MDA6MDAuMDog
UE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMjkxDQo+ID4gWyAgICAwLjYwMzUzNF0gcGNpZXBvcnQg
MDAwMDowMDowMC4wOiBBRVI6IGVuYWJsZWQgd2l0aCBJUlEgMjkxDQo+ID4NCj4gPiBJJ20gY29t
cGxldGVseSBvdXQgb2YgdGhlIGxvb3Agb24gdGhpcyB3aG9sZSBpc3N1ZSBhbmQgSSBvbmx5IGhl
bHBlZA0KPiA+IG91dCB0byB0ZXN0IHRoZSBwYXRjaC4gSG93ZXZlciwgSSB3YW50ZWQgdG8gYWRk
IHRoYXQgYmVmb3JlIGFwcGx5aW5nDQo+ID4gWmh1J3MgcHJvcG9zZWQgc2VxdWVuY2UsIEkgY291
bGQgb25seSByZXByb2R1Y2UgdGhlIGlzc3VlIGJ5IHBvd2VyDQo+ID4gY3ljbGluZyB0aGUgbW9k
dWxlLCBhcyByZWJvb3RpbmcgYWxvbmUgZGlkIG5vdCB0cmlnZ2VyIHRoZSBpc3N1ZS4NCj4NCj4g
SW50ZXJlc3RpbmcuIFRoaXMgbWlnaHQgZXhwbGFpbiB3aHkgSSBjb3VsZG7igJl0IHJlcHJvZHVj
ZSB0aGUgaXNzdWUgaW4gbXkgc2V0dXAsDQo+IHJhdGhlciB0aGFuIHRoZSBkaWZmZXJlbmNlIGJl
aW5nIGNhdXNlZCBieSB0aGUgc3BlY2lmaWMgUENJZSBjYXJkLg0KPg0KPiBGcmFuejogdGhhbmtz
IGZvciB0aGUgdGVzdC4NCj4NCj4gUmljaGFyZDogd2lsbCB5b3Ugc3VibWl0IGEgZm9ybWFsIHBh
dGNoLCBzbyB3ZSB0cnkgdG8gZmluYWxseSBmaXggdGhpcyBpc3N1ZT8gIEkNCj4gZ3Vlc3MgaXQn
cyBub3cgdG9vIGxhdGUgZm9yIDcuMiwgc28gYmUgc3VyZSB0byBjYzpzdGFibGUgYW5kIGhhdmUg
YSBmaXhlcyB0YWcuDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIgYW5kIEZyYW56JyB0ZXN0cy4N
CkknbSBwcmVwYXJpbmcgdGhlIGZpeCBwYXRjaCBub3cuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCj4NCj4gRnJhbmNlc2NvDQoNCg==
