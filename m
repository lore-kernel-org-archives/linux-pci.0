Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795259107;
	b=EkVGkyG8iZ+YE80R0n0WEUaPirniP85EQPqgJAKKpfIH+Yw/GfVWVKdJCOFh0la5+2e4
	 Ls4Ilsd9WlXBchfJsqi27n6ioLODIbDyQeIh+7RxISMi3MMzgnmfCmcThOkEcEgWUpakH
	 FAHkqGUJeJz9IEzMOFnQXhmKyJfasvCZzOzjvMcqC7nu3GlXU/IaonZVknYPHRFCGf2DN
	 2CTW0mEp2FS90GRGkN4H0+Au2Yt47qgLC3eFkcP+5/+9hmrOiw+5eIRcShvBMt2vpE3bQ
	 z7Q09hfT9Er6sfcZy80cOqBlTE118M+BNQuMQvgUSpEV6NvQky/bC3HB8GWCvSuh7xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259107;
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
	bh=iiSpWmaOtSo+jeAME+mB9aKf30K6RszGZqIxqTj50Cc=;
	b=vd8eJ6S6grQXBSCc6aigYwjVY4AT8+NYWEBH33xWy7hbVtVRUA4MMEo03fUhGg8bDbZI
	 hXgAnkXzsMIzMDtB+Qi4rwbl27xf3dAsr2gmUnPdajaqJSrXkkG8Fm8hGlciReZHdrvEh
	 ScQjPqi4mc0dsidvK0ZtktXve0RBmsvGf/CStL+l9HmaIQGXtBoxnxoLJNcN9aqrVQhiu
	 2wyaP2k8vEwQHyu4PR1uwN7E/VIyNo2E0A7mHmot+PLUb/3XXvPcz9Hs72tQ9h+yjkGXi
	 8A58b6f2MkPtvQBRqwATDlg3xrO+m2omsE0zAmfi4UkwLq3oaAyzfo38CdclBHT2kfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="LOSj0/9a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.32
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011032.outbound.protection.outlook.com [52.103.53.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1887606A325;
	Sat, 21 Nov 2026 11:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1887606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LOSj0/9a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umh4ePEACxlWjMR3uHxxcBxaIThWrg90IQ433JehSLu516s/Nu9AdLXjjc6uw7QoM34vAKGoBrKt60WWMWWoaAzv/chD6H+Rh525kBAfFrZf0BMEvrGbS6mh6Xg7zj8hNpDRa54xsgZT2IoNLOlFBDJ0uEKgjIlBy5l3u3PWwCg9Nxj/UU9TAjXi/4qHxk/LkHwEAYnaOwwiN4vFQEwq1inLMYEkEotjjt76psKD2YbPopppwpMmYwhYLaTti+bYXypKTmobTM7+HrY6Dr0s+t5ZQTbVW6mIB2G0zJvpGJZcejwOfKPyfvD75nCBoOYVbEOE49Ell4nogMc4U+sBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiSpWmaOtSo+jeAME+mB9aKf30K6RszGZqIxqTj50Cc=;
 b=SBIK++H9vWb7oP3/Jhd0GGzR0ulu5Fh8tSVdSyY5YQ2iAPXq3iDKW9mzC5KHJLd+GVNHm5755Zrv59FO0vQGHuN2v/rg4TiksMdP3jFqtlBaJv7FvHRkKZa53ALfTp0vmFUdM0c1spgtDiUXX3/OMrLgIELLKRDmdmJEt5aZ3ZtAyyTlym9hDqHSgSh5VRlNRgRc8O+dUcPf1XpH+/rEMpvLqgBBWYUwvGlf+hf2bu/ZX3JnXnagwl1sYcVSvIxxjOQx60b2tj9THbDXcnO95hHhlsigTZWFi32qYc0vbSBDMJ1AB0wrUD4n583xXxYUWxNqCsll+pdgn1Gm3HPxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiSpWmaOtSo+jeAME+mB9aKf30K6RszGZqIxqTj50Cc=;
 b=LOSj0/9aEKX9beSMpKB0vdmHFyk5i5Bx65VvROhtYePyiKM6Btsk/aLmesRrHAXMfsZhS16Zys8oGFIf72hxDlF5zijJLQ5J4xp7100XAlA9mgCrA764nsZl/oeyfBtNIa6mwO6jbeMsuzuIqarxC3rUYcQRUfljW+YGoVyCd8qtw3biNrwTV/h7SPhIJVbXpy/DknWyRySyQQ7se91ZQhXplUp5+mKZos7/97Qvv8Iw7ZXdwa0IyAyEgxZ3qzQ1fQVI5zW+Ip/01AJuQMdDjkBTL4VqkySs4WCbUtqgrcbHCpuMgK5Ns9GUW1g/g9TdQfEMMJCq/eadlJs2gDJJEA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0176.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 11:05:03 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 11:05:02 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdeDNDxGPpnfUHUki782tDVkNO47c1m/AAgAAIbPiAArsIgA==
Date: Sat, 21 Nov 2026 11:05:02 +0000
Message-ID: <20261121110501.41363-1-habilerenturker@hotmail.com>
References: <av8vdHPJhXII2955@ashevche-desk.local>
In-Reply-To: <av8vdHPJhXII2955@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0176:EE_
x-ms-office365-filtering-correlation-id: aebfecfa-6fed-4d6b-13df-08df47bf4ac0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|38102599003|51005399006|25010399006|24021099003|55001999006|15080799012|31061999003|12091999003|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0twRTQwSXdZN0NCMzBNK2Q5NEZtUWR0bXBqSGZMb0t0Z3NrSUJaSTh2WFd1?=
 =?utf-8?B?K3V2UERORzMwcVYyQ1ZVVkFuZytTWXpMeHhBTVFGaFl4Ry82cWlMYStGM2pQ?=
 =?utf-8?B?YURuLzRrdXRacGpOZ0ZaSWJ5VkhZUXBuZDRCbGpCTkxQb1VBcGh0RW9vUytN?=
 =?utf-8?B?Y3JUalQ1bEhDL01qb0FVMENCalRhaXpiWGx2bnBHdDMwSnZ0MTB3bC9wNURN?=
 =?utf-8?B?OFpiOUZBL3EyZ2IySTdwMjB0TjMvQXpUeFVmNDRYQU5kOEROTkRIUkJxMjJU?=
 =?utf-8?B?NWFEcC9uNWdmRGQwQjc2dVBEVTdzL3RKcVBOejJiMkt6SFlNT2ExT25oakt5?=
 =?utf-8?B?enpzS0VBOENkNVRYc1ovYWRRVzMrRjI0ZnE4bDZ5d2xCUFFSNFZsQ2M0Z1lK?=
 =?utf-8?B?YWZWdkhYa2gzblFadzBoQlovSG00N3pmRG1nQ3BmcGttL0QxYk5JTzRjQlQz?=
 =?utf-8?B?eE1wbncrY1Q2UXhFd0JkazlZZ2J5OUh1NFVPM2RHL1hBaURQQU01b3NFWTJR?=
 =?utf-8?B?T3lxTXhVeUN1S3lPZGtDZS9Vc3l5Tk0vOC9BaVZhbkRCU2FWK1BsV0g1WVpJ?=
 =?utf-8?B?Skg0WFhJbjlwcmFPTWlvaXNORDBDbnBqMlM4Z0t3N1ZYZ1FkUVRvNWgxVW1k?=
 =?utf-8?B?Q0F4dnZTSWJrN011M3FvUWRPaTBhbEsxTXl2N2NSQWNOQ0xwU0dEem1OQnRt?=
 =?utf-8?B?L0UvMXFoa1RQdlJWYUlsQU0xY0xGTnd0RG9tQ1VOR0dHem9LeU9qcUdTS3hM?=
 =?utf-8?B?d1ZKT29FbHczd3E3ZWwrUWkzb09uN1VRSHN1bk1haUdDSm5MZjdUM2ZmYVFs?=
 =?utf-8?B?VlFvcFRoazdUSjU3Y0ZYRDFKNVJwdVNXQ3g1MGhEUkhZMTBMLzFndkc4UlRF?=
 =?utf-8?B?NkRwVWozYWpyQTZjR21GYlN0OUZkU0pCeVV1L092V202RTYzREhzRzlnQWIv?=
 =?utf-8?B?enpmY1NjUlExNkdtZGNWbURyeEZKcmpVRkhneUFlYzF4ZHVET2xiTVF1SVlZ?=
 =?utf-8?B?ME1SVysxUGxzaWdGY0dGVkpmNi90RDMxZE9SMm42QTJoTGRSdFRKM1BadWZh?=
 =?utf-8?B?N0MzMzF1TVdpWHZUc2psZHF1YS84RjZxc08vTWJiUEwxUzNVS05BY0ZuNThh?=
 =?utf-8?B?enZ2VkpIaitkOVhSM2oyaTNCYm13K0VnUW1ZT2E3UXhIR3BVc2xCcVM4eE10?=
 =?utf-8?B?eTZNS1Vtc2gwTkt6MmgyOHFmdEFLck92UnhJSkFDZjB4R3pJanJhanRnWEpi?=
 =?utf-8?B?N3VHSU11aE9ndWgweHk5L21CQmlMbXdCSDE3SW1qUFlQRGI2NWpyRDBpMXVm?=
 =?utf-8?B?dkZQcWJDRUZ6VTJ1QUFvR1l2NW53eW9LN042RzFBNHUwZ2FRY3Bqd3R6Wm9Z?=
 =?utf-8?B?cTUxOFV1TjNVa04zWFBWcXdrUDVKU3RBd0RGZWdRRVZsV0NnS2ovbnYzMzk1?=
 =?utf-8?Q?SDIDy3/7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDJURGxRK05aTFovSEZsbFMweUFnQ2JSRGxiOXhwRy9nVzE5bzBnMDZqQ1VD?=
 =?utf-8?B?NTd4dG5RU0taYW1LMk1nTFFlQ0c4eUNWK1JSZUhCeTNzYmdzODdWdkNaTGpR?=
 =?utf-8?B?S0FuWmFqM0t6dE9uenh3VVlQMVFWTXZxbHBNRGxrRTYwODVBb3I5Qi9veVpa?=
 =?utf-8?B?bEJUMDlLdEdYZ0l4UG1kWjFwblVIdHhkcnRnQlRPbEhpQktKeHlMS05BZTRP?=
 =?utf-8?B?eFV0WDY3K2RzR0F3T2hMS3UvYlNwSlY1OEFhR3ZFK0hlaWxGRktvNHl0N3d4?=
 =?utf-8?B?b1V1ZmNNeHNYYm5tbE1vNGRmQ0dQNVhSSXI0U0s1cjE4ODRuS2cvTnJWUmMx?=
 =?utf-8?B?K1diKy9WS0R5S1AyVGtOSmdZU25BU2ZhL0dCc09pRmpaMzg0eDdjUzF2K3FY?=
 =?utf-8?B?R0ZZZVZZZC9NWEtRNlFoRGl2WnpvcFBmbHhmdmd0Q2laZkpTZG9LTmgySWZi?=
 =?utf-8?B?RS9wQ3g4Y1lhRnIwOUJkNkg1RW9xVFlCUGcyNHlPRjBTLzdwNFNNSm50REZu?=
 =?utf-8?B?MDFDd21ScVptMm8vVnhTYzVNS2QwdkFabDVhVVR5QXdEc2xtRDJMNEdwWmhl?=
 =?utf-8?B?U2dhdkQyTWhzNjRkRzFOS05lTXZ4WjdQU1hQdDY5SWNnVVRQbVFQaGxuV2tQ?=
 =?utf-8?B?UFJ6TUdvN2I4MVBROWwzRDFqaG05T0I3dEg5cUY1cEN4T1R1NEJPc3NSS3cz?=
 =?utf-8?B?MUp3NXQ5STNidXA5eEx4MStRR3RlcTRVaXBaNVR0N2U3UFBRQ09wa3F3MmtT?=
 =?utf-8?B?MmNWYTdQTDVObmJ4N3dGdS9MeTZnODZ2cllaT3VaUFl2MER2elV3ZlN6MEc2?=
 =?utf-8?B?czFqd3MrZmdveXpoMXQxWU1OOWtCWHdsMzlBbGc2VXNaZnhqcDg5U3VCa0Nu?=
 =?utf-8?B?VEwycnM5STFsR3dWODlFT010azZ4aUZZMFZzODYrc1hGZFA4eTA4bittcEt6?=
 =?utf-8?B?VjY5OStKM0Ura21SOXVBOW5pVHpXcU5mVlFJaUt1RFl6UGVGZGNyeWxVMzF1?=
 =?utf-8?B?dk91WVArSUtQa25lR1ZZbVZRWktnS2xlY095bGFUUlppbVpZbDRoM0plK0ZN?=
 =?utf-8?B?MzFiUUp3bDk3MC9NT3BmUDQxWG1VaVlTd0RaZWM0bjRBT3piMFVkOW8wZmt2?=
 =?utf-8?B?Y0pqbThnU3VWQ1V3NTg4SThJLzNpRm1jYm80ZGpuY3JlWFNBYkZMaGRLSlEr?=
 =?utf-8?B?U3M0MWFNUUQ4ZmpmYVFZbW93Nm9lUlFOQjdReEJxZ2tSbnBmMVNVSFB5bW9m?=
 =?utf-8?B?SHZ2TlhiMWRkRm9mYVFEM2hacyswNmZqQkFJUi9hbHB5VEppRy90YWVmSjlG?=
 =?utf-8?B?WitjU2NNTEdNdTlQNDhMMGt3d25mWFdwdTFYYlBFQUlUMWVESm1rMHN1YjBX?=
 =?utf-8?B?UHhnLzhmZUJIZkxDYlpORUpacndyQlovNWxKaXE0eXprZVFtcXBwRXh1ZVJS?=
 =?utf-8?B?RitHMWVWL3VVeENVZEh3NThQL3lzVExUM1o2V3pnZ1U4Vm5qTEtHVWoxQkFl?=
 =?utf-8?B?S3JOcnhVNXRhUm9nTFlaeFlvYUhhTS9wR1NkR1ZZd2hVZUF6Z0IwaXgzVW4v?=
 =?utf-8?B?VFdWS25PbVY2dVdBZS9haXNnU0E3MlB4U0d4N3NLZ3JNdDFOejRiWGw4YWZB?=
 =?utf-8?B?bFRrTDJJT3VsUUllb0twa3pNR1RmT0N3c1Rrbk9FTFNjai9wakdCUHY0Mzk2?=
 =?utf-8?B?SktQdHRpZmRyUkN1K21DZVp4WWpUdCtRZHVDYVR5VmJoaGJ4TERGSjlHSG9k?=
 =?utf-8?B?VWpxRXZDSFhqdkx3MnBWVnJBdnFzeHFVYzUxSUNlZFBrb3RQcWxjcU96d2Vx?=
 =?utf-8?B?RS9ud3ZmV3FTSFphbFVIeSs4TnkzMksyZnVaOFNRWG91YWFBd05EREd5aS9E?=
 =?utf-8?Q?x2VYfDST8Kmn0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4241E31980EAB4439D6FEBE8EF5CC6D6@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aebfecfa-6fed-4d6b-13df-08df47bf4ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 11:05:02.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0176

T24gVGh1LCBOb3YgMTksIDIwMjYgYXQgMDc6MTg6NDRQTSArMDIwMCwgYW5kcml5LnNoZXZjaGVu
a29AaW50ZWwuY29tIHdyb3RlOgo+IE9uIFRodSwgTm92IDE5LCAyMDI2IGF0IDExOjA3OjEzQU0g
LTA2MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gPiBPbiBUaHUsIE5vdiAxOSwgMjAyNiBhdCAw
Njo1MTowNlBNICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20gd3JvdGU6Cj4gPiA+
IE9uIFRodSwgTm92IDE5LCAyMDI2IGF0IDAyOjM1OjQ2UE0gKzAwMDAsIEhhYmlsIEVyZW4gVMO8
cmtlciB3cm90ZToKPiA+ID4gPiBBZGQgaGVscGVyIGZ1bmN0aW9ucyB0byBleHRyYWN0LCBzZXQg
YW5kIGNvbXBhcmUgUENJIHBvd2VyCj4gPiA+ID4gc3RhdGVzIGluIHRoZSBQb3dlciBNYW5hZ2Vt
ZW50IENvbnRyb2wvU3RhdHVzIHJlZ2lzdGVyLgo+Cj4gLi4uCj4KPiA+ID4gPiArLyogSGVscGVy
IGZ1bmN0aW9ucyBmb3IgUENJIHBvd2VyIG1hbmFnZW1lbnQgKi8KPiA+ID4gPiArc3RhdGljIGlu
bGluZSBwY2lfcG93ZXJfdCBwY2lfcG93ZXJfdF9nZXQodTMyIGNzcikKPiA+ID4gCj4gPiA+IFdo
eSB1MzIgYXMgaXQgc2VlbXMgdGhlIHZhbHVlIGlzIDE2LWJpdD8KPiA+IAo+ID4gSSB0aGluayB0
aGVyZSdzIG9uZSByZWFkZXIgb2YgUENJX1BNX0NUUkwgdGhhdCBkb2VzIGEgMzItYml0IHJlYWQs
IGFuZAo+ID4gSSBmaWd1cmVkIGEgdTE2LT51MzIgcHJvbW90aW9uIHdvdWxkIGJlIGJldHRlciB0
aGFuIGEgdTMyLT51MTYKPiA+IHRydW5jYXRpb24uICBCdXQgbWF5YmUgdGhhdCByZWFkZXIgc2hv
dWxkIGJlIGNoYW5nZWQgdG8gYSAxNi1iaXQgcmVhZC4KPgo+IElzIGl0IHNwZWNpZmljIHJlYWQg
b24gdGhlIHNwZWNpZmljIEhXIHRoYXQgaXMgYWx3YXlzIGRvbmUgYXMgMzItYml0Pwo+IChQZXJz
b25hbGx5IEkgZG8gbm90IGJlbGlldmUgdGhlcmUgaXMgc3VjaCBhIHJlcXVpcmVtZW50IHRvIGV2
ZW4gd2VpcmRlc3QKPiAgUENJIEhXLiBUaGlzIHJlZ2lzdGVyIGlzIHdheSB0b28gc3RhbmRhcmQu
KQoKSGksCgpUaGUgcmVhc29uIHdoeSBJIHB1dCB1MzIgaXMgdGhhdCBpbiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9icm9hZGNvbS9ibngyLmMsCnRoZXJlIGlzIGEgdTMyIHJlYWQ6IApgcGNpX3JlYWRf
Y29uZmlnX2R3b3JkKGJwLT5wZGV2LCBicC0+cG1fY2FwICsgUENJX1BNX0NUUkwsICZ2YWwxKTtg
CgpIb3dldmVyLCB1c2luZyB1MTYgaXMgbXVjaCBiZXR0ZXIgc29sdXRpb24gc2luY2UgdGhlIFBD
SSBjb3JlIHVzZXMgdTE2CnJlYWRzLgoKSSB3aWxsIGNoYW5nZSBpdCB0byB1MTYgaW4gdjMuCgpU
aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgoKUmVnYXJkcywKVMO8cmtlcgo=
