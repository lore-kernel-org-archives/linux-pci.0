Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6C25B0B9;
	Mon, 22 Jun 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098308; cv=fail; b=Qw2s5h4MyfQdIToIBUu7DCa6CgwGE1qVx2IugWlnKCeXpo3MSWXo6y4NsTvOs6UgWAIltCZ3Uq7NhG14W3I3xv69xCfT2OM41vQkA/MJ2JpqeNOQex+18m7PcbOMI9nyzrHv+91h1XSpxzBpjW9WVMZt41YpzKUo2HTjX+k6SBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098308; c=relaxed/simple;
	bh=FX/yboqB8P4qzv72Eq+y5Ty52MP/0VGl6nkTEWRwjT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m2B5KqTyawFUr3H4RhvH1nk8XDjuZmS2SIfR50VnsQj/axD1jNtQUQcxpZoseRG41OyxX6fnyRdseeWhu9+YfyyU7OcS3Fww0HIu31J+a1PVLCXXPnwi1altRALDrI9CSFS9nucxF9mvsztka1/Hqa9M+Cx2AqtD6AcWjB8iIa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hmd9yM0Q; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hmd9yM0Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmi58vf4ZNLgf6R/xk3kXUZAHQ9P8GAcxp9H4OFj6O2OLhlySAy3vvQlHJ1Iwfw2rFjTWFXzj3y1PHEAM0kfbsAofu8QaBApXIVgyxJ9or1bnFeRBGQwKp58ZPtxPlYjpRIKmg7FXWRWpDyo6G+COjVqFOpA+0Lug9fXoH07BcKsUeZpNtanJofu9Y+agV1hlNDKpGE5WP9eoZMT+4kHwl7L66m94yAUqla7yjE61i/jIs/9iy/m+Wm1IznZmoNYniLnSQaxsADzM/dOVVVn750TkWw95CIPt7s/rkMBUhPsN6DgAcwFA5cOJHYR3jf66zv9f+I4dbr74G36Q/vHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX/yboqB8P4qzv72Eq+y5Ty52MP/0VGl6nkTEWRwjT8=;
 b=d/oCuugKyiBqeTDY+fMND5uORley6u5d2a72eN1gDf0+GhXHKVL+x2A524A7/zWhBTbmuGfJdXEE4Elsm5eE21IsG3+2NWuWJkI6LPIqLFOfCcPCfls/CjA+rIscQLvvh5lXnzcWNU8hyy92O7y7VaoPltyuU70OpWX1+BV+tjt+YhnrRCeQBmyq+ipUiiTQGBbHFcRKKSkVBhmS+BKr9IOrMYY0PCK8aK0OXVdnT6B2x4FWOVILvw65KxrnIyTBDtzYAxGbUUpQy1mpZOa4ZZPYXrqOyGlRanlNzW3KzA11xNFCDID4/g+vgeFVs8NaP7sSDgfDfwrbp5zCXKFW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX/yboqB8P4qzv72Eq+y5Ty52MP/0VGl6nkTEWRwjT8=;
 b=Hmd9yM0QzdeFgBrjkHiSmoMb9Hd9v2aCgOCMGLMIvpeK6S5IIYl+iC7n9SQZY2Tv7QoJsOrHzsAkYXjPVA6GGpmTgFLf6kIMUTLCtNRUyUg68H/TZvuL987gLSykR6ShItEu6Z1BE5PAtGeeAKPpJXv3cyzywpxwpszHwuGgs9YKax35WHDy4jb7enrSt9UQEsADrUEJ8LrD+xyiDkt1SHZPsGtSFYzHBn3JvDunEb/5nAgPON16lsfRybEyWT/H6Emc34oUyD7MtVbo+dgduJbST/A/fLIGESpjFhEEWyZLbAlSUw+hs1OzEycH8Uu2nHlRMY/g1eMy+7svm+iyTg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10242.eurprd04.prod.outlook.com
 (2603:10a6:150:1a8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 03:18:20 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 03:18:20 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bartosz Golaszewski <brgl@kernel.org>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>
Subject: RE: [PATCH 0/8] Add PCIe M.2 Key E connector support for NXP i.MX
 boards
Thread-Topic: [PATCH 0/8] Add PCIe M.2 Key E connector support for NXP i.MX
 boards
Thread-Index: AQHc/wp3wjxjhDT8MUmCUtNbU0t9ZrZFftCAgARr2iA=
Date: Mon, 22 Jun 2026 03:18:19 +0000
Message-ID:
 <VI0PR04MB12114111FE0E8253A496F7F9492EF2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <CAMRc=MfsNa4itdpyGtR16wMb+wMkJwg+9=QJF2-oOoVVfFCF3g@mail.gmail.com>
In-Reply-To:
 <CAMRc=MfsNa4itdpyGtR16wMb+wMkJwg+9=QJF2-oOoVVfFCF3g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV1PR04MB10242:EE_
x-ms-office365-filtering-correlation-id: 203a3363-a1dc-4685-fa8c-08ded00ce8eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|23010399003|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 EE3mLulA0mgCz2LfX2PXRZPpyxMaIXrZk4cgKxWCmmM+VJy/X5qg1JRQ0dRAHhcZFByvATUgBDdoEb35ZofzrTgcXmp/13gRH2kIZ/WviZE+EMLYM/aU2CrtnjSX8fgGcLxZmCFZ3PH5brgfZkAIOdAbvAzPR7dQ0ZpWDzfkFMxiftXdF48tRiXxWuHlBROXHgaUNss+YVOovDcLbg9CNII+BXKBFUqgA/vfdcHNtZe7zZibln5SIqJ3jcoPO/hBqtF1gEGCxwuDM1Eo3LIyCYiU/gJn/ib/sRcQw7SbPyW9PJOULmDtDK06Yga7o6UY/3XtKZc8AnS2c7vCF6m8EFdJ8sexGZpuWFuEoOIda7RSRRxDaxU6a5iPiVuS+4yo2W8C/fPlLWIkzowG5PAJj9pp70Ao5V1Ck5k8hoajseSzFH2gxgYd5Qh8nRAgSCKyblR6FhDn8pJ2i9BnFMYkrnEn0+WSVn/XC2vy7q3OsGHxLOA/I6dE4ZLSLs7DJar/KbmD+rbegm+rBCHVK7eOjk80+nO1cVZ23FSUmRFXZeCCQhPLfMinq5+2KXDGRdPagaS68tq5uTjIbt/zUDqy9lxl+3zqaVj78ZmkbVeoym4zodGLqCvLL81FH1t+xzGLpXxCANhDOD092zzTtTGxw6OnxQO+20TnqlVnARs6uZHA+IjC5qGNLU/i9wajOej05/ZP41NeOjb7VoaL1kNuATAWGTPEk/SqpxRNh+/ilB8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODArY2RxeERZbTBtQ09LbHJCQ3NteXdXSG5iR3NyNjVHb3o2eHpXVzM3WjlF?=
 =?utf-8?B?Z0JONUpBbG1VSk9rUmJoVTBPUUtNMjFmMkdhMEM0QXJSL0U0SXNxQUo3VXFI?=
 =?utf-8?B?UHpMQkh1U3hzWjNmZUl6WFBFZE5WV0MrVFBOM2QyTUQ2cWVITE9LVnh1N3dP?=
 =?utf-8?B?bTlqeE1yY2pPdWF2M0kzNXJNcjM4blNqWi9YNTZPRk9QNG5oQ0dwcEN2MWgx?=
 =?utf-8?B?dGMxZHdnU3g0dEF5WDhyMTk0dVkvWVhWNlhzWGdUU2dVMzl1cHVyanRVTHJC?=
 =?utf-8?B?amZocjhnM0RDK3pBWTlXd0xtVk5MemxHYWN6UDBjK2xLdHhQcUdLUWtuLzZa?=
 =?utf-8?B?UzNoNVlJZEwxZFR2QmVWU3RpY1dPdHo3SmE0WVd2NmdXcUxVNXVLOHdGL0ZE?=
 =?utf-8?B?NWpOWG5pQ3RETjdDK2MySlE3VHBIYWIzTFFCLytNaDk5Y2RjanJuUk9tcWs2?=
 =?utf-8?B?Z3ZkWmw3TVBPNkVIMHlxUFZSYmR0aTZBNlQ5ZlI3emNrcURsaXNaSmpPenVG?=
 =?utf-8?B?NHhiYkU0ZHpoVS9jNWRibE1BRk5JbzZTenhyZVl3YlU4aXU4NENNRks3dVBM?=
 =?utf-8?B?dGFGVEtGV0JTSWVvY2E0dTVrYTRnNTA3QTI3ZWc2M29JNXVIa253Tk1hTU0r?=
 =?utf-8?B?ZW05Rmk3MHU1bngvazB4Sjh2OHMvV2FCVUM3ZXQrb3lacTRrMG9BSXZZN3Nv?=
 =?utf-8?B?M01XZXAxcnhSWFZ2MUxwVzNxL1ArSVJzZk1uOHZvM2tndDdYbHFjei84SWR5?=
 =?utf-8?B?NmdDWEszL1plVndaOGhxYVoxNUpmNUg5T0RMeDFnaGxyYm5GWFBKZng2bFVC?=
 =?utf-8?B?bkRCRnJEWFhzOERMRkpqL0hPSzd4OGU5U1lVc0l6SHlrRlorK1ZUb3FPR0Jw?=
 =?utf-8?B?eDR6ZXNZbGs2S281anI0a05VZWE2bXJIc1JWOXdoRVJTeFBKdEZSSEt6QWRj?=
 =?utf-8?B?NGpuQkRTRXV0R3k4QlpOSEhZTVVsMVhQQk9tZEF2YjRwRlNJWUFnMW5aVmQw?=
 =?utf-8?B?YXNTSjlGZ0ZWYVd6T0UrT2hRMVhVcExtN3c5V1lsN2w3RXJkaFNUcDVXb0Fn?=
 =?utf-8?B?L1ZPVVExemVuOXJoSzBSVkZCUlFHQ1R3R3BmTWNlTUo2OEVUUVc3amM2N2g3?=
 =?utf-8?B?MlExZkJIS3BGV1lwZUVhZUdnekFndXFBbnVNYmRZdG9mcUxhY0RkeDRlMVlx?=
 =?utf-8?B?ejF1N3VKZ3Zub3FOd200SHVxZ2xnU1lHMENmQXcrbTIzbnZPUHNxRWJPempk?=
 =?utf-8?B?VEJSQlkvd25rSDkrNHpGbzNSVWpyckRGWVplNVl4Q0hwV2hHalVCMEF5cHZX?=
 =?utf-8?B?NXBnUG9ZbWdXdVVTVHYwWWY5dFZnT1FqUXFvY0ZpbDhjeHZJMTR1bUlUTGQy?=
 =?utf-8?B?ZkZMUkdwTWxFZlp1ZzBZRU9zL0ZPR1V0b3lKYlJKa3lHTGJ3SU5mempKejhF?=
 =?utf-8?B?WVI4QUt1Z0REZlRvbFVZemIvcCtScjBsdXZDMFJtMTcwNUxSem5yNTlkNmQy?=
 =?utf-8?B?M2dFOVJIMmwxOG1kWlV4N00wQUdFVlJpeFBwQ3BTNFpiQmxWaGsrYmZWQkhk?=
 =?utf-8?B?dzFLcEFaOEpQQnd1MU5IOFBDS0JxajBtTXZtYWJERTZ0MEpwOGY3NkxMNHpk?=
 =?utf-8?B?TVRhTllVREtqZXVjbkEvL3gxbnQzT0Z2dllVaTE5ZWRpODN6QXY5VVFVaW5x?=
 =?utf-8?B?VHZKR3N1TjVUQ2N2b3lhMUlid3p2dE03elNJVWFpU0RZOWZwOU0xbzNqbStF?=
 =?utf-8?B?MzdubmloTG56TXd6azY3ZjQ4bDlRYkFLUlVjQ05YOGZDSjhnNFVmTGU0cUhu?=
 =?utf-8?B?a3gwNXk2OE54TnlPcENCWUZrU3ZOYS9xMTFlVjljWm81SUozYWZ6U1dhWHE3?=
 =?utf-8?B?MXlKSVQ4NlZNc081T0F6LzA2aTdobGEvMkdHbllVNWI5SnRidWJZSHdsdktL?=
 =?utf-8?B?Ym9xUmZGV0Nmc2tKV3cwZVY4Yk8wekhCUU1oVzFiZzZvVU9TOGVHaTRnNm56?=
 =?utf-8?B?Vmk0VURudHBMWUpuUm1abG83Q2RsbG9BZWNhVVBBazZoMi82ZllPcFdUbUZD?=
 =?utf-8?B?UWRDaS9nMi9NR05JMDZzNXNlTzdwRjQ2Q3FNNTNmQS9sa1pkbHdQTWwvbjFU?=
 =?utf-8?B?MzN3UldZaXI0VUFIUnVseitLc1BTWEU4VW9wazRYTjhielVPZG12WjRrbGRN?=
 =?utf-8?B?Z1NMam9ycTdsRWZtQzMweTJMUlRtaWtCbjZmVWRUMURDZnNuLy85UDdvS1dB?=
 =?utf-8?B?T0VYaTRHUy9LbVpqLzl3cHJzb00rSUlacGJ6VTluckJVUEJCa0J2Snd5NDNv?=
 =?utf-8?Q?nG1fbEQHZCsT5LbHAl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 203a3363-a1dc-4685-fa8c-08ded00ce8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 03:18:19.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjF0No/S1dOKuaeuEt0E3kkAW/DDHqCX9sGRGwj3cXgiJrWByP5epe89tZIvHYp3cbKRcYlA8s+3I3bhgxdieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

PiBPbiBUaHUsIDE4IEp1biAyMDI2IDEyOjEwOjM5ICswMjAwLCAiU2hlcnJ5IFN1biAoT1NTKSIN
Cj4gPHNoZXJyeS5zdW5Ab3NzLm54cC5jb20+IHNhaWQ6DQo+ID4gRnJvbTogU2hlcnJ5IFN1biA8
c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZv
ciBOWFAgV2ktRmkvQlQgY29tYm8gY2hpcHMgKDg4VzkwOTgsIEFXNjkzKQ0KPiA+IGluc2VydGVk
IGludG8gUENJZSBNLjIgS2V5IEUgY29ubmVjdG9ycyBvbiBzZXZlcmFsIGkuTVggRVZLL01FSyBi
b2FyZHMuDQo+ID4NCj4gPiBGb3IgTS4yIGNhcmRzIHRoYXQgcmVseSBvbiBQQ0llIEwyIGxpbmsg
c3RhdGUgYW5kIHdha2UtdXAgbWVjaGFuaXNtcywNCj4gPiB0aGUgY2FyZCBtdXN0IHJlbWFpbiBw
b3dlcmVkIGR1cmluZyBzdXNwZW5kLiBQYXRjaCAxIHVzZXMgdGhlIGV4aXN0aW5nDQo+ID4gZHdf
cGNpZV9ycDo6c2tpcF9wd3JjdHJsX29mZiBmbGFnIHRvIHNraXAgcG93ZXItb2ZmIGR1cmluZyBz
dXNwZW5kIGFuZA0KPiA+IHNraXAgcG93ZXItb24gZHVyaW5nIHRoZSBpbml0IHBhdGguDQo+ID4N
Cj4gPiBBbHNwIHRoZSBidG54cHVhcnQgZHJpdmVyIGlzIGV4dGVuZGVkIHRvIG9idGFpbiBhIHB3
cnNlcSBkZXNjcmlwdG9yDQo+ID4gdmlhIHRoZSBPRiBncmFwaCBvbiB0aGUgVUFSVCBjb250cm9s
bGVyIGRldmljZSBpbiBwYXRjaCAyLg0KPiA+DQo+ID4gU2hlcnJ5IFN1biAoOCk6DQo+ID4gICBQ
Q0k6IGlteDY6IEFkZCBza2lwX3B3cmN0cmxfb2ZmIGZsYWcgc3VwcG9ydA0KPiA+ICAgcG93ZXI6
IHNlcXVlbmNpbmc6IHBjaWUtbTI6IEFkZCBQQ0kgSUQgZm9yIE5YUCA4OFc5MDk4IGFuZCBBVzY5
Mw0KPiA+ICAgICBCbHVldG9vdGgNCj4gDQo+IENhbiB0aGlzIGJlIGFwcGxpZWQgaW5kZXBlbmRl
bnRseSB3aXRob3V0IGJ1aWxkLXRpbWUgaXNzdWVzPw0KDQpIaSBCYXJ0LA0KDQpZZXMsIHRoaXMg
cGF0Y2ggY2FuIGJlIGFwcGxpZWQgaW5kZXBlbmRlbnRseSwgSSB3YXMgYWJsZSB0byBzdWNjZXNz
ZnVsbHkNCmJ1aWxkIGl0IGJhc2VkIG9uIHRoZSBmb2xsb3dpbmcgYmFzZS1jb21taXQ6DQozY2U5
N2JkM2M0ZjE4NjA4MzM1ZTcwOWMyNGQ2YTQwZTcwMzZjYWI4Lg0KDQpIb3dldmVyLCBwbGVhc2Ug
bm90ZSB0aGF0IGl0IG1heSBjb25mbGljdCB3aXRoIHRoZSBmb2xsb3dpbmcgcGF0Y2ggd2hlbg0K
YXBwbGllZDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjE3MTQzMDU1LjgyMDA5
Ni0xLXdlaS5kZW5nQG9zcy5xdWFsY29tbS5jb20vLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
DQo+IA0KPiA+ICAgQmx1ZXRvb3RoOiBidG54cHVhcnQ6IEFkZCBNLjIgQmx1ZXRvb3RoIGRldmlj
ZSBzdXBwb3J0IHVzaW5nIHB3cnNlcQ0KPiA+ICAgYXJtNjQ6IGR0czogaW14OG1xLWV2azogRGVz
Y3JpYmUgdGhlIFBDSWUgTS4yIEtleSBFIGNvbm5lY3Rvcg0KPiA+ICAgYXJtNjQ6IGR0czogaW14
OTUtMTl4MTktZXZrOiBEZXNjcmliZSB0aGUgUENJZSBNLjIgS2V5IEUgY29ubmVjdG9yDQo+ID4g
ICBhcm02NDogZHRzOiBpbXg4ZHhsLWV2azogRGVzY3JpYmUgdGhlIFBDSWUgTS4yIEtleSBFIGNv
bm5lY3Rvcg0KPiA+ICAgYXJtNjQ6IGR0czogaW14OHFtLW1lazogRGVzY3JpYmUgdGhlIFBDSWUg
TS4yIEtleSBFIGNvbm5lY3Rvcg0KPiA+ICAgYXJtNjQ6IGR0czogaW14OHF4cC1tZWs6IERlc2Ny
aWJlIHRoZSBQQ0llIE0uMiBLZXkgRSBjb25uZWN0b3INCj4gPg0KPiA+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4ZHhsLWV2ay5kdHMgfCA1NiArKysrKysrKysrKysrLS0tLS0N
Cj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyAgfCA0NCAr
KysrKysrKysrKystLQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1t
ZWsuZHRzICB8IDU4ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5kdHMgfCA1NCArKysrKysrKysrKystLS0tLQ0KPiA+ICAu
Li4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE5eDE5LWV2ay5kdHMgICAgfCA1NSArKysrKysr
KysrKysrLS0tLS0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgICAgICAgICAg
ICAgICAgIHwgMzMgKysrKysrKysrKy0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYyAgICAgICAgIHwgMzYgKysrKysrKy0tLS0tDQo+ID4gIGRyaXZlcnMvcG93ZXIv
c2VxdWVuY2luZy9wd3JzZXEtcGNpZS1tMi5jICAgICB8ICA0ICsrDQo+ID4gIDggZmlsZXMgY2hh
bmdlZCwgMjY0IGluc2VydGlvbnMoKyksIDc2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4g
PiAyLjUwLjENCj4gPg0KPiA+DQo=
