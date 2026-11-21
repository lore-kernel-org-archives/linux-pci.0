Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795260368;
	b=5KcwbQCawGKb3u3sCHIqI50Tu6lffPUIXXyb+9HfE7sgz8Y0xkkOU0TvN6yXuKBE31Wl
	 S9pWrqOAUZ7XZrPsz2qsqPoXqbC4BC9+ZdMBsB4xYH2w05itWKhYt4LzJqFcdy5Ssly+O
	 DzsWNlX1nCJ2T5REONdBE7M4dONqSbxOL9skcVpRyHPWAt+vty68h2mEmofY3PbN/TaBv
	 jPyT1aMXNTapZejvcpn2WIoA1/8MZmQElR5ssOPosSus2pmSPbWhnbyLK0Z18uRew8Ppa
	 Rvwqd+1j1RpvAZVroCcDQcLJ/irpheMvEl0qBtpnoyquJz/rDiy5v03lX0tEZtdlQvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260368;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qRSrf0oi/i+17wMow74Gb6wuiZjtiEVyLDOPBKExg0I=;
	b=QoUAsjEKc6iNPYoUZhdELV58jtLK91il5zdYS8fBssWkRofARp8M8shUcgr1ldv3DnXY
	 TSgVXLvunVdTY8ANqldoShByM3abzuGafp+pP1NmyB5/5La+RMftHLkiEmagPDDzQa2zb
	 lGdTEwIl5rZhZBrmRYn74Wvc9ZXyJvfsl7oiSlqDQZZBndBeLXK9L3cc/9Fs0/Kl1L2g7
	 t9l0nenbN8QWd97gYcr9nmPiXNUbWuovHezOvrXA+hBqxhjQNUA85PaEFxC/byp19t4UF
	 fYheO0ekUDKkOiempno2lxkXCSzOfu53PrpE7brnzI0TXwrJiiwdaSWu/6w845GUy4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=eiNztnC4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011034.outbound.protection.outlook.com [52.103.53.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA0606A32A;
	Sat, 21 Nov 2026 11:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFA0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=eiNztnC4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqtSD+yjxMMPFQrJl2F+dmBQ7VVx5VafabTTjyjushtJgNgN7jORuftfAd3/G6Hn7gGzMPN2+txKf398Bc5mXgwkvrRysuqnSuHVw3aDBCkgRw9JyCmagwh58vGcSmO0WXEx6HE6T2YK9u7e1BbF9aNW3k3/I+60nLjHLNwBZQZAWts1iRjmzuj/byZaKqLJ3BXzhcbIVoGTWHi7UNMM2PJaxAH4EhMWa9JeSJYBF7BO6RzLoj8CZrRJ65ph4YR7M9W3RTGCVCLcJimHjq+8hBeZFNpr4oIvt6eN3Sld1Cp5l+9c+Ev7Ce23iVq2/PVHBg1mX3lqdYgTNJcOvlwjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRSrf0oi/i+17wMow74Gb6wuiZjtiEVyLDOPBKExg0I=;
 b=EZQqO5Qa0W6sfRdPPN5hRvg7tTOb4jlOgKgobwG6x0aRaJS4Rzvgexq4sja4K3REssui7lBoB28Jd05rVSTzaoRV0QRDarHIlw+W7pfau0J/ridL3wW6U5TEtiwpakf1GlsnGR2DeeUPXso+b40GzmAfTZ92AvbHN7WUYFwDX3UHYU9ZJh8Ducb55EJP9cdtwfaVYw5nYK/Sul1p6hC+uY3EvG8cQX99HMltHS1dvf54DSrZXk0QrldnDmHAaTFVcT6o1v/TnNiBioD34fBOSJ0+aqNhxLuqc715AYz35yVCfF9OhNGRaQKyyiJHoi6c4zSqAntkic+NgPUDQk5tJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRSrf0oi/i+17wMow74Gb6wuiZjtiEVyLDOPBKExg0I=;
 b=eiNztnC44khbLZCc6+WdFg5jLEkMu/7Dia+fTpQroKOpPgmvefRoiW2o74fOAU7W57iNO0POVc2pV98g5O5gDZDSeUqA4GBzvfZCRyl4tGiZv+cPWZGwfg9/ex6DmcyWgYG5xB3OoT++6E24zXHwew06WyvLMH26bWPqEu3fXaiHBrQBxHLb3vRb/jsHPsdiWHIx1o993I3p6iYmAKSrbsI7hqszVsxoF5dMNxcj56S6JgWBfNiHdCGtN05418CtMfIjpiy8KIc0wOdG52/uz5MWpNQ8ludHLwb/W1U41VA6kNIdlup6GpYy8eGo0C67a5cOqY+DwWSAWmAojGT1RA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB0115.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 11:26:05 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 11:26:05 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Topic: [PATCH v2 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Index: AQHdeDNFCSkt0YnohU+kbfy3sJ7a1bc1oYCAgALEPoA=
Date: Sat, 21 Nov 2026 11:26:05 +0000
Message-ID: <20261121112604.42689-1-habilerenturker@hotmail.com>
References: <av8tpQO7KYGUXQmN@ashevche-desk.local>
In-Reply-To: <av8tpQO7KYGUXQmN@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB0115:EE_
x-ms-office365-filtering-correlation-id: 1dc9c525-b1c1-45c5-505f-08df47c23b4f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|8060799015|25010399006|15080799012|51005399006|38102599003|31061999003|55001999006|24021099003|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qld2dkZhaWhYYm9LZWR3ajF2S2wySTZBU25XK3AzVVhWWXBqMEFEanFyQlZX?=
 =?utf-8?B?VWtHbCtsdmxWK3NlZGxIUUt1QmhlU2NqWGNydnJnVW1OQWxrQTFzTUhWeERi?=
 =?utf-8?B?N2Q4MVNzV0J3akxlQ1UzTTh2RjVNZ3NkZWw5NE1uWEVsVlBQSjhOb1hGUmoy?=
 =?utf-8?B?enFnV2Y5UnRxTDl4RGJsNVdsaFFXclBPeGtJODVHRXUrREErMUt6RkxiMis0?=
 =?utf-8?B?Z2N2cVNpZWFnNEpKT21EcUx4MzVGUVh0SVRRMktDc2dsUFRKV2w1YzI5NTJr?=
 =?utf-8?B?N1hMMEVWRXREWm8vRkJacEtMeDN4V1VQbEV5SWFJTmx0SWhBTDEwYWMvT0s5?=
 =?utf-8?B?UWpFRDg5UjkyZHNjZDRKSUFLVUlZQlJKbFY5OTNKU1EyQlViV1k2TkV1ZUdx?=
 =?utf-8?B?UTZRUjVxcVZXMGFnQ0hrZklEa0s5cS9BRXdEZUhoMGFONWRIMkJ3bmhtYTc3?=
 =?utf-8?B?aFN2cElZTkxtUjZCWlc1Sk1EdFQyRkpqeFZYbXU2TVlqSkJlTzlOekZuTzI5?=
 =?utf-8?B?L1pERmRpSnNJTUlLdWppWmFVcEJQSW4zbzh5N1RpSXh0d1VjWnIzL1RDdGxw?=
 =?utf-8?B?eGZUdkJLN0hScnp6L1Q3VGp0ditJWWNjdWU0QU1uNGg1S1I4c2V0OENIaEcx?=
 =?utf-8?B?VU1pSXByVlV3b1RxYjJkVFdFSERDUUtES2Exa1drWmRTWk5TSVRycVhiOXpN?=
 =?utf-8?B?ekNoUzRkdEIrWjhDWlRoLzVNN0dYVE9lNGs0R0RiUW4vRlVOTDFqVGNBaGQ3?=
 =?utf-8?B?OVVTMFpDTDA4WmRlQ3MydmQzb3JLcGhWbUwrRmNrcFJHK2QzaDBSMW9QbHNG?=
 =?utf-8?B?RlZrSzNqd0MyOFFUQytyeTFqNUpwd0tMeExYSnhyYVM3MWlUQlNFanRhb0c1?=
 =?utf-8?B?MUxiZ2Q2U0R3VUxJdTdxNkduM3EvSnhGbVVKZUZiNkoxNG5zN0xOUmhHM2My?=
 =?utf-8?B?ZER3TGoxSFlNODJQMWYwa243Tm9peGlFZ0FLMmlYQkNudk15S1R5bVh4SXg5?=
 =?utf-8?B?RTlwZCsyTEFKbWUzZmE0bEo1eWFKbk1BbmRoVFRwYXB0b2FQSDVGRnhHZ1Z1?=
 =?utf-8?B?eXR2OW01YVJuWkQ5RkJ2UXA4K1NWTnVONWJaL0RVSDBYem9MMGFKOTRCU05q?=
 =?utf-8?B?cFFPLzVCKzlkZWNsS05weElMS3ZkSC96Y2ZCTW01dUZ6MFV4Q3VQdjdzV2lJ?=
 =?utf-8?B?eTJSNUJHdjJ2Ym5jUTkvd2FoSnVqaDVHdkMyd2k0cm9aSVgxWlhOZUxiaHRI?=
 =?utf-8?B?OEZLUE9UQUVHdkgzdW55dzllRTMrSmJsSXJKNFJVYUhHaUlQZ0lEUmpRQVIw?=
 =?utf-8?B?REFneExPSVAyR2ZWdFhrR29PTkxOR0xxRGQxRXpmWlRtY2hnaUhtazhiSmZt?=
 =?utf-8?B?ZlQ1WEM4d2dIYnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUJEcUlkTXY1NmF1MEozNU9XRVdJOUFWNk9KSmIzd0lFc3JEcGlGeXo1YUkx?=
 =?utf-8?B?WFdlU3BPWGUvQVM0d3dlK2E1S2dYcDIzcHNodnZtNlZMUU1IUE11MVl3SHlp?=
 =?utf-8?B?SVp5SUNUS2gwb1B4Rk5MQUlicENGdkkrZWg2YUtNQzQzSjh2S0RBazhzK0xj?=
 =?utf-8?B?TEZqZkIrY2ZuakNIY3Y4MkVaYitHNU5xQ2V0N0duZmMrTDNkeTUxL3NBZVFZ?=
 =?utf-8?B?RmlPbkFjSnNpSG0xbWFidUc5WGVWbnNKblljc1MvMTI4ZnJDeXR3ZHZwTk1X?=
 =?utf-8?B?c01vS0VKU1k0VTJiZUduNlV5WGkxRVZqU0lZeWp2R2pnb05uc2JiK04rdjlk?=
 =?utf-8?B?NHlnZVYwT2U4NzRwR3haemFCY1dRQnJRd3FXMnd2ZUpaYU5KUERrcEhQRkRp?=
 =?utf-8?B?aFRlamkxcS9RU0dYYnN0VytwRWw2SXRQQVJuQURIcmRGMzEwUTAyUVk4WE40?=
 =?utf-8?B?YklNQStnMk5nUFZEK0VsYlg3cmk1eHZFYmJrK3JDRTdyYVl2V1FuSSs3blBV?=
 =?utf-8?B?b2VlN2RqN2RSbmRJNklXa21HckpOTHRubElzTGxua3lJRDd3aWkzSGFOSW1T?=
 =?utf-8?B?aFRjWlRETjU0ZWl2MURCMU9IVWMyU1d3N1BjK2ZDb05ScTh3QjlNSmtzSTBm?=
 =?utf-8?B?UzlRQjh6RzVVcUF3OEFuZUY4czc4SXo4bUJUTHM1K1NqMjV1QnpmcXp3WmRt?=
 =?utf-8?B?ZGpnOG9MSWtXTlo3ekhmSWhid0FrWDlaaVhIOUk0bjl6RTRib3dZeEtqRzZn?=
 =?utf-8?B?VlFwdmNyc3VvaFFLcnpOVVIrYnEvM29kaGY3UTFRV3h5ZUQreDdNa1RnMTFC?=
 =?utf-8?B?elFKSUYxdDRWWWUxSUVIRUxnSGVzbXhnbkY3UlpnZ3lBYlRBOTBsd0FZZ0NE?=
 =?utf-8?B?Ty9DOXFFS09lYWRNVUpzVENHcnRrRE1Hbk5LMU1ESXJQdGh2Z1FlZ3ZmTFJF?=
 =?utf-8?B?Mk1nYno4WW5QNkhxekJEVVJxQkJSYmU4OVpuUWRkeVFjTnlLS3R4ZWVaYXl4?=
 =?utf-8?B?Z3R6WTY0eXF5Uzg5RE9BRUNoakFwbHFsSlo2dHcxNVU1c29VTVY2QzJsRzkx?=
 =?utf-8?B?VWswc1M3bFVlYWdkbE5YM0RQNW5IbWVBNFZKbXFHTE96RTQ5ZU1YK2l0OGdI?=
 =?utf-8?B?TEV3bXNzaTVUaStkcUhXMWVKQUE1cUZ6aVpVbFRBamw3YnVaQk4weHZkM3Y1?=
 =?utf-8?B?VkxFME53YS9pam5Cd0JaQS9CWlRjcVdGTmJvemNxcU9BckgwL0l1QkxhbTJR?=
 =?utf-8?B?WVRyTEFWYlJwYi92K2wxY1BDR1YxZDh6ZzRjdEM5clVlUmowemI1UHJReHlY?=
 =?utf-8?B?eWhFL0RHQno2YU1USU5NYTVVNFlocjVod1NGa2dPT2hMWlExNWdHeDNwZHJS?=
 =?utf-8?B?eEsyUVhBQWhsZzZuNldpVkJUK2ZCN09ROWV6K0RpS1VBVktQMnU5MW9oalJZ?=
 =?utf-8?B?ZjNXZFRnNGMzWU9odTNTcnhVdEM2emRlald1aUsrNlZ5cnRiZUppQlJwMjFP?=
 =?utf-8?B?L3VQRk1wNDVZWUxGeWExakhRUHc5VW55aVg1MUpYNTR1cmxTVldJSC9SaVVO?=
 =?utf-8?B?RGoxSDlwWlJ2OHlNUGxDdWhyenFrQXUzNHlXWmg3N1pzbWtzUkpPM0luSjBa?=
 =?utf-8?B?VmRUbzhLYlVxdHBPaVlZMThHY1Jqd20wakJrVGdKb2U3dlBETVhKZFYzYTVQ?=
 =?utf-8?B?aTRyVjZLbzhpdm1rZzZJcWF2NXRhcTgvUEdVOVprUGlaanFNZHhnY2lpblFK?=
 =?utf-8?B?NFFzaTVnTFBiVlB0NlJiZTVYcjJOcHpYV3hDYVhmVDFFcEZQS0lVWm9ORTFn?=
 =?utf-8?B?R3RHbW01dnJzSjZ2MjZVdzExRXBiOWtFUHFOcjkwbFAwd1Y1bkc5R2s4Yy9B?=
 =?utf-8?Q?fpalfFc1t1sTk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D86D6E9F384FE24B84B5FF10FEA0A5EF@POLP291.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc9c525-b1c1-45c5-505f-08df47c23b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 11:26:05.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB0115

SGkgQW5keSwKCkkgYWRkZWQgYSBvbmUtbGluZSBleGFtcGxlIG9mIHRoZSByZXNvbHZlZCBTcGFy
c2Ugd2FybmluZyB0byB0aGUKY29tbWl0IG1lc3NhZ2UgaW4gdjMuCgpUaGFua3MgZm9yIHRoZSBz
dWdnZXN0aW9uLgoKUmVnYXJkcywKVMO8cmtlcgo=
