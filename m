Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96333B7B68;
	Thu, 30 Jul 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395289; cv=fail; b=l7ADs6+vxRFEjbwLTmdg/+Wv9GY2cNCGG7tY2noRT8KM7aOlOkD03o2ChI983D4DYB65ac3+d08pj8O66oE3KDLXmntnFelPX9X3SV+/cDBHKlOUUXvF49JH1QX7M6lWerkrn2NCr+1LnMl9Ex+grYpB+MaDvx9NNiRkVeEZ1MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395289; c=relaxed/simple;
	bh=CrtDUEfHYtkFpsOiLvkcxEseit8cymC7zUVT1QkWXeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOA1Zhk6rTqpsQyi1OjgUW12KDKfH3l32A4V83MQruOYXULhLl6M7Rbe9x/b5s6os16C1xJGJprolspR3aM4JJoQPLbsZbFLndxGmRMeDY2lTmr+oUsMCryw07/51QCfV0ctfNaDS4IRqUnnHmPbfTVL8HERfpAP6c1Z/NUtKE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P7UXt9n/; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P7UXt9n/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfGQqtx7f3TYrVRKJIKKoAKd/XGS4C/UmErS/lcNybCSq75yHBjQj+lNECwsg/P0ZJ8ZlhAwno5bAhVIp7TeEg0cPsDGPoPm1kX8p+iyFEPYmJAz/FzbJebAtMEaT8w9kzc+nfxTH4IzmGMYlgJc5/BP1g1SNSe1AAN5CM7IbrABZZ9SMcP36Vt4COhX0qpDuqwjVpiJLWZyMVmiQC1lbFn03EhQRSh1eBm5kWdBBGk2qy2FjmB2v2JJcvXd9wfdFK3a+M9PiQp7Ucil34xKQJogiH2VkenAjB4kmIx7vtJRjYcm3Ym+qK9h1u0C1wtQZ+ay7hnlo3lrEPuvOctOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrtDUEfHYtkFpsOiLvkcxEseit8cymC7zUVT1QkWXeQ=;
 b=n8JReGKLjBg2mljZIH1dZZmfBe4Ch69PqdoMYMMeNWiSKFgmmBvjn3fXQHv7uxBMzj52wyrfUqTk7czqhZC/6/XfWoShTYlur5B90lWbten0ITuvs4/jJ+zkMob6tIdK3cjJ7u+kMCdoMlhNwnhjlzcA7enOVaztfdmwTVSM1uai3uerGk3BRP0/rc9DS4Nt6R9GoCbX0maf9LS6a9Sox5D2+WZjROszuHCGM2nG0khR9pzoUQBwZEIwcc7e8y3HUnXhhSv8jMbP51Cha8IdaoeBG+4lD9YVJFOwZ/V4GxhmewBoQ9EctDxp53S/+5zWeaQ89UkUI0mIQJPKvjABZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrtDUEfHYtkFpsOiLvkcxEseit8cymC7zUVT1QkWXeQ=;
 b=P7UXt9n/8zlSh14Vr3/s+/1vwSVVlor2+oHbPksXlv3SMOCDqCm0hvFxjh9STnu0gKZini76CIXXSbEPx+07OySJote4PsNyYKky8K+yTTzQXql7Cy10OgJlxYhxJt3k1ebORwPMXlIH1EqRT1jkdf37MkQWjRE4ADpupsi3osk5fhd4iE9XDOV0rbqxOKtxxxz+DQBqftxRDBvD6yM9wHUNn/Ujhk0l7wXxxwGYYnMKOeGeLf/G8xhyPcjku7RL1hnOV8uw5FgXW7GOWmNubXTJ3YczA2ETUNeD+3ZOLCYjco5Gtqf1+6WLMm8xgb3BDDgzrB2Bqxz6pU36rtGp6g==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI1PR04MB6895.eurprd04.prod.outlook.com
 (2603:10a6:803:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:07:58 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 07:07:58 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Topic: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Index: AQHdEznE8ZJEwBksLkioEzwtbW9MZLaEnfuAgAEfn2A=
Date: Thu, 30 Jul 2026 07:07:58 +0000
Message-ID:
 <GV2PR04MB120191536F2B3F4B093719D418CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
 <jtpctss4hz3djqd4ukq634ujfk5jdud6c6r6apgo2syrsubqz2@jivsombtim3v>
In-Reply-To: <jtpctss4hz3djqd4ukq634ujfk5jdud6c6r6apgo2syrsubqz2@jivsombtim3v>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VI1PR04MB6895:EE_
x-ms-office365-filtering-correlation-id: 613b2063-a0e5-4af4-3153-08deee094911
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 5APikDcSBz36XD1tlIJEbd7Kf4tWw2TaGEa+Zy/MHF+onMDMjdpvMhZqP7yLP2S5sO3Caxf8HTlQSqxJCCvgy7zjI+COf+3E965NpFpMt5FOK3GnbOW/vhhAUNkx5Awj0HRxNmQLT8JuOT3k0/JcdgEQv73ZT3V+oKNuCAc3AZgZ5QAVlgX0xp+u93SAj/JKmzUbMq2Qzx2fUGWxxvVhlLV2eTlhyLnLbx1E/U30GGxDOpmXEX4r6B1x2Nc9NaxLoGBkJja+WcRulgpor5DpXsjkj/We3Aw7gbYhJjZW5EyhsRlE+CEbKpUG1L5Jpdgtm06V7REl41sihcf74CVETtjRw2EYTj0X3vL19fVrfTFpLmgFb4Vc1b+HQdphORU3ZT5HUsL8v20iCzxGtxjOCnNAcuJsIL4fBQqe7qB88pJBT21jWTtyPOqtTaDRPqgWYWRCFuYJgediLgQlYiQeIxjm+fWr/8xFCoTiLYCWbvIjhSNJa3AWklqIz9H/6py0vrZGeaIqbDQaAG9T5UO2SBBlqPBSLqW+oJSxmTQLM4e4he+4OK9n0nHHDphmBzxukScFz1VlqzeWKsZyxXPsejOzEJk5unLjFnAWZDuWX2neA/7ff8jXb1wsdtJCcyjd4ndawBSnk3aXdotjb6vOe5bHbYeQHdgF+ij296j1ybDx+xOZmqWZcE1UNwPoK5wGwIovRxl/lrcY7/rXl0EtXXitj813tY712IT5ejx4y90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFVTUFpabTl0cDBRaEY3Q3pxY2dLNHBBS1JVeHBaQlRXR1RZdjVuNnl2Ylc2?=
 =?utf-8?B?eDhIWkZMc3F0TWlGNEp0VWYyL25MMkt5OC96QWJnTjJqdi9sTUN1S0tzdzM5?=
 =?utf-8?B?c01PQTNYMDcrMzZWeVU5L2NwL3RtZ2s3RnpqT0w4U0s1NjBTUnZnV241d2ZC?=
 =?utf-8?B?VU1XaStVMWYxbHd5M3hXYlZBWEhTMk5CaUszVVN0UkVrREhMR29SeXBDeXRx?=
 =?utf-8?B?aGNzQVh0NXpFODBOR05LNGNIU3BNendMOXMwdnIzK1ZJMVNrVy9zVHNsay95?=
 =?utf-8?B?bWR5TlhRYmZLeFBjVUVWaGd1eG1IUHJDUDdac08xSSt3aWRzVEovT2hXWVM3?=
 =?utf-8?B?eWgzS0IvUHRPUGFrcjFZcEl6WTRFWGhUS1QvKzNualBRUnN6ckZiRFJjK2x5?=
 =?utf-8?B?cUFhdkRnN2xTcjJIaUxTYVZFVGsybTArWHMxVkZZTVlnZEZsQ09ncHhlZklw?=
 =?utf-8?B?TWo3UDdMMXdHejBOQkRmZnpWY2NEaFlXWFhKbFhQbXhheFh2YitqbTdJZ0lv?=
 =?utf-8?B?Q3RMa1kzNTRTeUEwYzkrTjgyUWhKK25URllUOG9wRmd3RWp6bjRlcm9sb0RB?=
 =?utf-8?B?QVo4SklTdUJWVmRDb240aEVKZ1JST3lzWUlsVXovR3JqQjZMWWk0U09TQS8y?=
 =?utf-8?B?YlROQnBmNXhha0xJa0FKMkxWMnZocFN1S1crS2QwSzJJSzZFUE1qaCtMV3U3?=
 =?utf-8?B?aTVSais5LzRmTEpUNkRvSXhZWDM1R0FwdVErQTJ5d2dvL1hibTFSdlVXU3cr?=
 =?utf-8?B?R3pPM1o5ZlRKR1o3M1NrN2RiQ2lkbC9IZmF2ejFlNklSdWhmRDc4VkN4THIz?=
 =?utf-8?B?UnhJLytBRnFVazB5OEJoWkoyRnRzanR5UEROYVZET1lWMFpYUERqemJMaUZa?=
 =?utf-8?B?L3ZOQ09uT2kwU2NndU5TckdhTkpRZjhUUUFEUkd5UFhoZ3N3a0ovZHFJeUhG?=
 =?utf-8?B?eTFqVzl4U1U0bDBhWU41M0V3OThKVzhFTDhPaTlYTlc1V0ZHakF0YTA5M2dx?=
 =?utf-8?B?STlXTDBFUGdNWEQ5VTUwVWxXSDkxV1hXY1lPR0FmczI5emlCcmZnazR3dXdS?=
 =?utf-8?B?bDRoSEkySU1GRHVnR3dDV3VZQVF5Tks5SlQxNGpVYXFPNjAzSVhkU21hWHJj?=
 =?utf-8?B?Y1N6NlNHWlFiUmZPd3NGSStRTlJUQ1BjTFI4RVpxYU8xVFJHdGQyZzlnd2Nm?=
 =?utf-8?B?TW5LdFhXY2F4a0ZMYXVkL2IxRjNhY0dONVA0L0IvTERDK3pjSTdGK0szTWhQ?=
 =?utf-8?B?WFlHREQ2TFlhWEhaeGhYMndPcS9zNTNRb2tNV1E0N1hrQXd3RFg1VGo3aXlD?=
 =?utf-8?B?NFF3aUN4cTZRa25DaHh5V0xWc1hIREZkNlZnSDRLWmxpSGVqNHZDN1dic0k1?=
 =?utf-8?B?dnpqQVRJeTYrUVVpSVloZ09RUWlQb2pZRVFRdXpGanN0bnJYNTZ3aXdqNGI4?=
 =?utf-8?B?c2xrZTVYOHdFL0ZJVjhBblpDbGNUNVVGaHlpbGlSU1pmamhQZXhVMnk5Tnps?=
 =?utf-8?B?c1AzU21nMGpVY3AyM1JxNkNVaFdvQ3dkNkNGaEIwMGxqdGgwS3VMYlAwNjhY?=
 =?utf-8?B?QlNDdWdic2k5MndCci9BRTF2a0VxWmp4SlpDblB4WlNvWUhyNTBRZVNnQThH?=
 =?utf-8?B?VkdNZlVDZDR3ajFJT2M3bVdNZHBIdkRPZHVjUzNhZEYwRHJBbmEwVUJ5ZGlC?=
 =?utf-8?B?QXBhZkxTUE1TeXljMHBESFJRaGwxcGhCNWRyb0RqQjIvL2kyZXZXdVRpWktn?=
 =?utf-8?B?YkMzNVZzazJnbEVmUzNpZjYrT09YZitOR2sxeG5IWnF0VGwyMEZ6RkJLWGJI?=
 =?utf-8?B?RGRIZW1SZlBaTEZiVEVxTHgzbjlGOFlXb21NaXJveWJTU2VSRkR0TXlTRG9u?=
 =?utf-8?B?ZnF2bmJ2VVQvYk5LenZ4TWIyUDN5Yjl3bjhjcUlNVFQrVUMycEc0UDNiM053?=
 =?utf-8?B?ZjNGTHcwbWUwcEdSRTI4RTBFSkIrZEVvaTllY3JzYjV2Q1RFWnVCVWtkeTNZ?=
 =?utf-8?B?emd5WlJCQ1FMNEpxdGhIUDBVbFRnc1JFdFV5cEZreFNPVWZZdUFwUkVRb0ZP?=
 =?utf-8?B?L0RpNnZSZjE4Sm9VMHdmNWZiZG51Q1hqQUF2Zk50eFRaS0FXQ2xJbUtCZElV?=
 =?utf-8?B?WmMzdU4xdDFlWWdFRFFyZEkvb2lMUTJ1YXFxaXZ6ZDE0bjN1bkR6M1pzT292?=
 =?utf-8?B?ai9acWJGaTF3ZytISEFxTTJkMmZrKzRVeG8yQ0NWb3A0cS9oQnQ1V3BtRzZp?=
 =?utf-8?B?RVZzLzQyQnM1OEhHanVVTkJaYXdrNjh5eW5YRHcwaVRPRUtSK1BjU3ViOVVq?=
 =?utf-8?B?dTJkbnZ5dDhoNkdCWEJYdk9QTlRLU0lRYk1lT290QkNPcGw5OHdKZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b2063-a0e5-4af4-3153-08deee094911
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:07:58.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrJGYra+4IHeAshJCpG5Lb5FXciqHx8nW/tKLgmcPxJ5xv/OjrULglkW98Yvz0SwI5ofHodWNjQk/IuP/DYNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6895

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI5LCAyMDI2IDk6
NTggUE0NCj4gVG86IEhvbmd4aW5nIFpodSAoT1NTKSA8aG9uZ3hpbmcuemh1QG9zcy5ueHAuY29t
Pg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJv
YmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LQ0K
PiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjNdIFBDSTogaW14NjogVXBkYXRlIE1QTExCIGJhbmR3aWR0aCB0byBpbXByb3ZlIGkuTVg5
NQ0KPiBHZW4zIFBDSWUgc3RhYmlsaXR5DQo+IA0KPiBPbiBUdWUsIEp1bCAxNCwgMjAyNiBhdCAx
MDo0MTowN0FNICswODAwLCBob25neGluZy56aHVAb3NzLm54cC5jb20gd3JvdGU6DQo+ID4gRnJv
bTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+DQo+ID4gQmFuZHdpZHRo
IG1hcmdpbmFsaXR5IHdhcyBvYnNlcnZlZCBkdXJpbmcgaS5NWDk1IEdlbjMgUENJZSB0ZXN0cyB3
aXRoDQo+ID4gdGhlIGRlZmF1bHQgTVBMTEJfQkFORFdJRFRIIHZhbHVlLiBUaGlzIG1hcmdpbiBk
ZWdyYWRhdGlvbiB3b3JzZW5zDQo+ID4gYWNyb3NzIHZvbHRhZ2UgYW5kIHRlbXBlcmF0dXJlIChW
VCkgdmFyaWF0aW9ucyBhbmQgZGlmZmVyZW50IHRlc3QNCj4gPiBtYXRyaWNlcywgcG90ZW50aWFs
bHkgY2F1c2luZyBsaW5rIHN0YWJpbGl0eSBpc3N1ZXMuDQo+ID4NCj4gPiBUZXN0aW5nIHdpdGgg
TVBMTEJfQkFORFdJRFRIIHZhbHVlIG9mIDE0MCAoMHg4Yykgc2hvd3Mgc2lnbmlmaWNhbnQNCj4g
PiBpbXByb3ZlbWVudCBpbiBiYW5kd2lkdGggbWFyZ2lucyBhY3Jvc3MgYWxsIFZUIGNvbmRpdGlv
bnMgYW5kIHRlc3QNCj4gPiBzY2VuYXJpb3MuDQo+ID4NCj4gPiBJbXBsZW1lbnQgUEhZIHJlZ2lz
dGVyIHdyaXRlIGhlbHBlciBmdW5jdGlvbiBhbmQgY29uZmlndXJlOg0KPiA+IC0gTVBMTEJfQldf
T1ZSRF9JTiA9IDE0MCAoMHg4YykgZm9yIGltcHJvdmVkIGJhbmR3aWR0aCBtYXJnaW4NCj4gPiAt
IE1QTExCX0JXX09WUkRfRU4gdG8gZW5hYmxlIHRoZSBvdmVycmlkZQ0KPiA+DQo+ID4gVGhpcyBl
bnN1cmVzIHJvYnVzdCBQQ0llIEdlbjMgcGVyZm9ybWFuY2UgYWNyb3NzIGFsbCBvcGVyYXRpbmcN
Cj4gPiBjb25kaXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gUmVn
YXJkaW5nIEZyYW5rJ3MgY29tbWVudHMsIHJlZmluZSBuYW1pbmcgY29uc2lzdGVuY3kgYW5kIGNs
YXJpdHkuDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IFVwZGF0ZSB0aGUgcmVnaXN0ZXIg
bmFtZSBhbmQgYml0IGRlZmluaXRpb25zLg0KPiA+IERvbid0IG1vdmUgSU1YOTVfUENJRV9QSFlf
Q1JfUEFSQV9TRUwgc2V0dGluZ3MuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA1M2YzZGE2YWIzMGQ1Li5mYWRmMTRk
ZTEwZjdjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gQEAgLTgwLDYgKzgwLDE3IEBADQo+ID4gICNkZWZpbmUgSU1YOTVfU0lEX01BU0sJCQkJR0VO
TUFTSyg1LCAwKQ0KPiA+ICAjZGVmaW5lIElNWDk1X01BWF9MVVQJCQkJMzINCj4gPg0KPiA+ICsj
ZGVmaW5lIElNWDk1X1BDSUVfUEhZX1JFR19BRERSCQkJMHgzMDA4DQo+ID4gKyNkZWZpbmUgSU1Y
OTVfUENJRV9QSFlfUkVHX0VOCQkJQklUKDMxKQ0KPiA+ICsjZGVmaW5lIElNWDk1X1BDSUVfUEhZ
X1JFR19BRERSX01BU0sJCUdFTk1BU0soMTUsIDApDQo+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9Q
SFlfUkVHX0RBVEEJCQkweDMwMGMNCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9NUExMQl9P
VlJEX0lOCQkweDIwMDQNCj4gPiArLyogQklUKDEwKTogT3ZlcnJpZGUgZW5hYmxlIGZvciBtcGxs
Yl9iYW5kd2lkdGhbMTU6MF0gKi8NCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9NUExMQl9P
VlJEX0JXX0VOCQkweDQwMA0KPiANCj4gVXNlIEJJVCgxMCkgcGxlYXNlLg0KT2theSwgd2lsbCBj
aGFuZ2UgdG8gQklUKDEwKS4NCg0KPiANCj4gPiArLyogUmVnaXN0ZXIgb2Zmc2V0OiBPdmVycmlk
ZSB2YWx1ZSBmb3IgbXBsbGJfYmFuZHdpZHRoWzE1OjBdICovDQo+ID4gKyNkZWZpbmUgSU1YOTVf
UENJRV9QSFlfTVBMTEJfQldfSU4JCTB4MjAwNQ0KPiA+ICsjZGVmaW5lIElNWDk1X1BDSUVfUEhZ
X01QTExCX0JXX1ZBTAkJMHg4Yw0KPiANCj4gSXMgaXQgcG9zc2libGUgdG8gZGVmaW5lIGluZGl2
aWR1YWwgYml0cz8NCj4gDQpUaGlzIGlzIGEgMTYtYml0IGJhbmR3aWR0aCB2YWx1ZSAoMTQwIGRl
Y2ltYWwgPSAweDhjKSByZWNvbW1lbmRlZCBieSB0aGUgSUMNCmRlc2lnbmVycy4gSXQgYXBwZWFy
cyB0byBiZSBhIGNvbXBsZXRlIHZhbHVlIHJhdGhlciB0aGFuIGEgYml0IGZpZWxkLCBidXQNCnBs
ZWFzZSBsZXQgbWUga25vdyBpZiB5b3UnZCBwcmVmZXIgYSBkaWZmZXJlbnQgcmVwcmVzZW50YXRp
b24uDQoNCj4gPiArDQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9SU1RfQ1RSTAkJCTB4MzAxMA0K
PiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfQ09MRF9SU1QJCQlCSVQoMCkNCj4gPg0KPiA+IEBAIC0y
NjksNiArMjgwLDE2IEBAIHN0YXRpYyBpbnQgaW14OTVfcGNpZV9zZWxlY3RfcmVmX2Nsa19zcmMo
c3RydWN0DQo+IGlteF9wY2llICppbXhfcGNpZSkNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+
ID4NCj4gPiArc3RhdGljIHZvaWQgaW14OTVfcGNpZV9waHlfd3JpdGUoc3RydWN0IGlteF9wY2ll
ICppbXhfcGNpZSwgaW50IGFkZHIsDQo+ID4gK3UxNiBkYXRhKSB7DQo+ID4gKwl1ZGVsYXkoMjAw
KTsNCj4gDQo+IFdoeSBpcyB0aGlzIGRlbGF5IGF0IHRoZSBzdGFydCBvZiB0aGlzIGZ1bmN0aW9u
Pw0KQSBwcm9wZXIgZGVsYXkgaXMgcmVxdWlyZWQgYmV0d2VlbiB0aGUgYXNzZXJ0aW9uIG9mIElN
WDk1X1BDSUVfUEhZX0NSX1BBUkFfU0VMDQooaW4gaW14OTVfcGNpZV9pbml0X3BoeSkgYW5kIGVh
Y2ggc3Vic2VxdWVudCBQSFkgcmVnaXN0ZXIgd3JpdGUgb3BlcmF0aW9uLg0KV2l0aG91dCB0aGlz
IGRlbGF5LCB0aGUgdmFsdWVzIGNhbm5vdCBiZSBzdWNjZXNzZnVsbHkgd3JpdHRlbiB0byB0aGUg
UEhZDQpyZWdpc3RlcnMuIFBsYWNpbmcgdGhlIGRlbGF5IGF0IHRoZSBzdGFydCBvZiB0aGUgaGVs
cGVyIGZ1bmN0aW9uIGVuc3VyZXMgaXQncw0KYXBwbGllZCBiZWZvcmUgZXZlcnkgUEhZIHdyaXRl
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1PiANCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDg
rq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
