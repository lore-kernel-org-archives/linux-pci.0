Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867606;
	b=RxhhihZWC0nzOYH+NKAnjqFFwu1dIggcs3vomoCd+VXx438UolqZMrpyXVb1tVph7tnV
	 hm9rY4jCIoYYF0yBoqMdjXUotTCfb7UuqRkUn1WSa/CMbNxKX1ThAa29m/Qvhia4iG9Ai
	 QujNrEec0A2V/1O4O+idJMINt6xgp8fjXsQBY0tu/gOi7LBkXjgZLZ0J+0EwDTQ2c4pXC
	 xcHViDkzID8X4EgtbHipda4vfcrsabyVNLv3SuT42OvBEUWvgzM6WT1vESfZnHScO3j6w
	 diPA+eLCuX9am337q2b/b3M/+WAbdDR3nIt97M2N4NA3x2RMoQndTDSEOP8otX1OW6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867606;
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
	bh=VS/6ULm/Bgd2NcqYS2JNiqRaVEtCvkczdBTkyxQcw6M=;
	b=X1whwZDtEYCAJXsGIQEkwmL/x+RaNJGrKDMfrS5WV02YVXJfW6g6J1oizGZgAffjsvKr
	 yp8LEGT2LjSV+WFQwrJ1N9f4zfuQSg+xdYaRjLSz9gPj4bEpjQxZvwdFnVG058TuL1S6A
	 Z+nHCF/1Evt3E1618BTe79MNhKhhO9X8FYqR9r4SFSsHDc6OPGEB4HX2kCQ9Hz1QyQPvO
	 71erTUtGyb6vsmPZ3+ciUXTEwyKddJTwsvL+zJkPFH2969SG5knEFT4/Y9nYOUV1qpXjX
	 wOZEkHwwjbaCq6NH++XrjIt9qdiSdlotLs8kia25wX6UWDzOpkR6z0QmSzukMPH1HHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=rzwJSKqx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.51
Received: from WA2P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19012051.outbound.protection.outlook.com [52.103.53.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C1606A31C;
	Sat, 28 Nov 2026 12:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=rzwJSKqx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVyloX4MbJeyBakFMF+5I9/ujQAwqmVg32nagmOxxvbZo9v+0X4gNuMD9gxmGJ/P9gdf2FQepphnkPNSNXCFZR5iNIUszaL/7sdZ94KovOV227ymWllYd82U7i6TSUjJd6PRe1dKYOQfQ/FHH1BOBjp8DpW/HLiUN6HUQMqbjxzNKJb8/9ih5sXLrV7MQZruq3E8nFtJgl2HExCo+O6pTEwVrZFHJ9zM8fGs2LHqcc0rxpp8GjB2iJk0IGQIq47USvAxGREO6w7/dn+AT1XDJKVuSBCWZTbmOOJxcG83vpsLbVSXWiuoboovvUEBQ33bHgUiWKPrkyl5fFxTwl5ZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS/6ULm/Bgd2NcqYS2JNiqRaVEtCvkczdBTkyxQcw6M=;
 b=sp2u+R50nJNOaraqI8l3DudtuzC77ZH3rXLIpl+QbqJ0gleX3Ftle4akY6AxmWb6zzZq6bKzG3zRjrRbz+MbwIKvX+OeBpXcvLw/dsCrGSC2rjSe0gGrCXZayquNX23GmdIUjlMKG+RF7AyY1rWSumgtfGgw4yJ2oXsm7/LI0eIg2O19/mWcpj4Gpgsw1BQ1l2XXNupBDVwiuf09+Mgj6RlRj1265Trvw4Zxt8ACg/q9FZi+lSDCtPesF5UY4A/E1DTI8nVP6VFhcZoQ5ffrjbDsmruIadd1dhMTScWtaXNs9OI19NYIZW8BWr0xikSenFIz1HYKgOMFtfMjuqRZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS/6ULm/Bgd2NcqYS2JNiqRaVEtCvkczdBTkyxQcw6M=;
 b=rzwJSKqx09hO1gmwRc2gI4PPh2TLZqGABlLIkD5N+0HOv2JAFBTL1//Vzd/d3C3GzqFDlZtXsJWa88Y6pwKevXQO0W/YxTO3HBcaU+iVcVt74RS7ul86mjqiIxXnlaDI9fFOEqgQxx/ttFxbN3Sa9QlfAnRm2dlzk4ZvLcwLmtUBscUeRTupGlKHwaYejPoLg4/80AKs0t5urp+nfYQ3Gvu/dKZXFIOk5I2beRkEys2WUG53j/QkDgYVt77hRPuJQosEi2nh++9r4BxR2n7h/wnCW1JPrqvG3aR+F53P1qEfQULEhQOgm+g8yN4lF632wUzOymb7sGaKNdeVTJJvhA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA1P291MB374577.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 12:06:42 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 12:06:42 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Index: AQHdeDNGToMhTgBsW0WxP5JvTKrwTrc1oooAgALGnYCAAusUgIAIHRqA
Date: Sat, 28 Nov 2026 12:06:42 +0000
Message-ID: <20261128120641.8677-1-habilerenturker@hotmail.com>
References: <awP1Uc-zyiawX3Dw@ashevche-desk.local>
In-Reply-To: <awP1Uc-zyiawX3Dw@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA1P291MB374577:EE_
x-ms-office365-filtering-correlation-id: deace5ff-29e6-4daa-cd03-08df4d4810f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|25010399006|51005399006|55001999006|24021099003|8062599012|38102599003|31061999003|8060799015|21061999006|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnhSQXFDMklhbU5ZV1RXajBuR0JBN1p1RWVUWUVxU09IRmd1d0VlcDJEemFS?=
 =?utf-8?B?YVBSVW9PRFlyTTZpaGpPSTFLRVJ3bGVCRDFLRG4vbG9pUGVZWXNjbmpZYmFz?=
 =?utf-8?B?dVpSc203QWs5RjR0ZU9KYk11T0xpaHZweit2U2hxbjdGa21TV1hhb2ExL1Yr?=
 =?utf-8?B?bUNYeDF6OHZvNXJHMjhNYWdpSG02TGtEVUlXd00rSGQ0T0FleEkzellIODBM?=
 =?utf-8?B?SmFPRW9rSHgvczA5S0hrU3hqWm5YbWJBV085Mlo2SFYzRkh4UWJYekhSZEhG?=
 =?utf-8?B?QStOSzcvMmZDMDZsbDBZQ0pCeitqRTdMaEtWYWNIbWJidExOLzRzc1dGMTR0?=
 =?utf-8?B?MUJ4VldBS3Q4MDhjWmsvRkNJU3lxaDRiVnBXR2hJT2tNS1ZVN1RpUnMzMWFR?=
 =?utf-8?B?SGs3RmFBOS9TZzFWZnZrbk8zRG1zZE5xVURqcjRRS0F4L0d0d2h0YmJ0ZFdE?=
 =?utf-8?B?QXRqblFFTUVmdElRSCttbmxZcCtXamlMZjBqWVd6SjZnSjduQWJwTWpXbW5v?=
 =?utf-8?B?Q3NHOTZVQkp3cUZKTHp5UkFzOHJzN2xwN0NmN09sK1dVRWZ6cHc2M1hlUmlN?=
 =?utf-8?B?SkorMGEyeWovOEFEUmZTWDVLTzlIeVFJUllOYmV6a0YwajZRckQ2ZEhuL01E?=
 =?utf-8?B?alhPd0VqRWp5RXJiUm5pN21wdjJJWGVhQmtNT0RzdmF1bEhrSklWYkZlZkpV?=
 =?utf-8?B?Qy9UbUNXNkc1WElsb2dwL0pGRzJBejZnK3JUczFHVlNZbGc0anJ1am5PK2Ix?=
 =?utf-8?B?LzRsMU9XRjVNaE84OU5WQ0ZqczJTemR5WGoxc2ltUHZUcHBHVS9LSHBybmgz?=
 =?utf-8?B?YU1FbXJQcEM0TlFFL2c2K3N0dzYrdTJKMFF6V1hZT0xBQUNocVYvZkZ3ZXNL?=
 =?utf-8?B?clJtMW5ka05hRlJxK1RIOXl4YXBNaVlMTklGaHBTRkcycVc4OHZCdzNPOHQ2?=
 =?utf-8?B?RWQ1c3RLK1FIMk5EV3BWZTIybVBjU2JISHZIRk1FSmZxRUovY2NkaGZqNk5W?=
 =?utf-8?B?OUJKU0Rrd1IwYmNhNTVld0xXRlFTZTl6Y0VabnpuQmsza2gvYkRpR0M0MkUv?=
 =?utf-8?B?Q2ZqbFFGY2RLOUhLdjlLbXY0dWdLM0VwVkdRZ01XL0FRc1NSZlBWc0w1OThM?=
 =?utf-8?B?THF6WW1hcHVlLzIrRk5Mdk9jZFdySDNEQ1lHbEFVblpNb1pCQ1RDVXE5OVp6?=
 =?utf-8?B?K0pyeHAwUmhETG1xbytyY0RYNVB5YkVwR0N6b09jYStRcW1QcFJwQ0htUzdo?=
 =?utf-8?B?VGxQRnJidU1saGRQMTlubHFNdjhjaWNLRGttc0lDdXhUUVUwbFVMTzNabkEv?=
 =?utf-8?B?K2g4d1pJMXMvdEZjaEIrYzYwQWpnNVZKTkFSOGE2aDJKcXRYMHNLVS9QRVNj?=
 =?utf-8?B?eEhvT2hXZW5EOGNsMXY3R3BsSDh1K25DVUtLZFlIdnhkOGgvMXMzSGp6bUc0?=
 =?utf-8?Q?QqgCBF2H?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um5SOUU2QWlaU1ppRitOV3VYbmZUSlBYaDNtMmhhb0FNeTdpUkwzb2lITVlB?=
 =?utf-8?B?a2U2Q1I3alFjUitFdnRtcW1DV1RSLzJ2UGFNOUhvZ2RXTVB4dDVIR2xkeURy?=
 =?utf-8?B?ZHFSQnBZcjBPUDA0UGFhWHFjRzBGL25mT2ttRWFSMGo0c2lxSWxsa3NLZWJY?=
 =?utf-8?B?K3dHOG9oVDlka2JCakg1bFlpMVArOW14WW9uWm9GVmRCRXJ5VkJiRGY5MHVS?=
 =?utf-8?B?Smk1RjZBczM1aE1jL1lSbnhCbmF3QVNNdGwvY3dOR05NUHp0ckVlWHNFcldx?=
 =?utf-8?B?bWJEUDc1eTV0QXRyMEQ5NXVnL3NTWFNySU0zb0wwdTBvcVBKNE5GYWtubENW?=
 =?utf-8?B?SWdtRE51NitOTUtZK3ZReG5NcnA2b1ZIVXZDNkxWdERKRjMwcnc1ckxFaG42?=
 =?utf-8?B?V2svSk9ZUnUzbW0zanREa1dRNmJoWHRpSkhMMHgxZlZ2R1NCQWpzYUdxQWFD?=
 =?utf-8?B?NkxCMTBxaUxTbTBWV09qT1h3YzViM2VwTjhuZHdyaEYxVE15UDhOaTY1NTRK?=
 =?utf-8?B?a0RDbW0rZkxMRnRsSjF3dFJodEg5L1JtNGNCTXdJVUNrb2taaTdyT0dZR0tU?=
 =?utf-8?B?S1Q3bVNTT3VRZTU4ZkhjNldvMFA4eG00eHJwZm1LVkFlb1FjamNXYXFaSFd0?=
 =?utf-8?B?eE56MGp2OUx2dUppVXFQRTl0Z2QwZU5SUlFid3RQb01GOVArU3AzR1lBM2R4?=
 =?utf-8?B?TFpqU0J1eHZlYXh4UVJ2Z05jUUM2c2c2ZUVpR3FEV0xRNS8xRGhtaDFWK3hO?=
 =?utf-8?B?N01DTms5bzFwZUNvejVBV05EemIvQjdmRFBWV0d1NGVJMDNvUFZ1L1dGeisz?=
 =?utf-8?B?bzlWVEV2MmNuSjdCeSsyNitwUWY0R3BGZkhET0wzcFZtNS9WaFRMQm90Z1pP?=
 =?utf-8?B?UDl5TmdyaTB5YkNvTU9IOUJCZEZld2RuQUdQbmtCK3dwOWNmemNvZmcxclJi?=
 =?utf-8?B?djh0Q1FHU09kVVF3QThUNmJsUVdvbGFqTE5jVSsvTjVqZjVxOC9jVGp6c0RF?=
 =?utf-8?B?b0kyR3pLRHl6ZjZzNTU4bXJ4NjV0TXl5ZjUzOVN2MSs4czI1OGdaUy9pMStS?=
 =?utf-8?B?YVhjZzQyeEtTbkh5VXFMbXVyNlFidlh4S096SzBUY0NCYU8vRUxvbXVXMFlv?=
 =?utf-8?B?SW51SGdzRnova3h3UGV0ekxtcUtWdndzOFMyL0ovclJmVVZwZVZQQS9jaTdh?=
 =?utf-8?B?WEJvcEpMYWV3eTJsZlJOcnorQ2pBWFpINHlxRWVzZDdlY1Nvd2w0NzBndW8r?=
 =?utf-8?B?Wm9waEJnc0ROeFFTejZzbkpmOGh4bU16dk10d29rbXlia0hrS1B6a0x2MDVL?=
 =?utf-8?B?RWZtN2tMb1hDL1MwcVd0Zk1SRmVoK3ZSSUQrV1lPY3paNStoSU5vVXFJTmxH?=
 =?utf-8?B?b1kzTFl4NlJkeWNBUmI1ZW1sMUk4Sm5OaUVjcHRtNXVKRjBuWkJNVlNvT2pT?=
 =?utf-8?B?TXE1dWhEc3ExZkZqekdRWUtKUlNzOENxbE9tSEMwK1d1RE5IU2xxS0liYjZ2?=
 =?utf-8?B?OUtCNmtpbDBMOE5CbmJXME4rQWc2UUZvYVg4OHpROEppMHk0VW9NZEwrY2Y3?=
 =?utf-8?B?WG1YazVGK1JtYWNKVWszR0tNL1YxelBaU2IrY3lrWG1lSGVwUmtvenRCV3lT?=
 =?utf-8?B?bjk0TGVnTWhIMmplb3JTVjBSWFE1S3luSlFiUERSeUVEcWhOSXRTVzVrRG5C?=
 =?utf-8?B?Vm94cy9QWkQwSU5kdkFsTEJUaytLYWlUZkMrblVhKzh0MDBmTWpQY0pOb3Nl?=
 =?utf-8?B?VmRVZVZ6MEo5a0RVTFJGVXNYUWZubEJUMEhzQjY0SXlQMDYxWG1IaXkzVXNy?=
 =?utf-8?B?MzBCQlJZM2JjNTAyM3g2RitVYWFMTmRnMmhpTHVJSFNvaE9xZTZDOUdXUm9K?=
 =?utf-8?Q?L8jORVSqojqVD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A2E13FFDCCE0A458FCED053D40E985C@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: deace5ff-29e6-4daa-cd03-08df4d4810f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 12:06:42.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA1P291MB374577

SGkgQW5keSwKCkkgaGF2ZW4ndCBjaGVja2VkIGFjcm9zcyB0aGUgZW50aXJlIGtlcm5lbCB0cmVl
IGZvciBvdGhlciBwb3RlbnRpYWwKY2FsbGVycyB5ZXQuIFNpbmNlIHRoaXMgc2VyaWVzIGlzIGFs
cmVhZHkgZm9jdXNlZCBvbiByZXNvbHZpbmcKdGhlIFNwYXJzZSB3YXJuaW5ncyBpbiB0aGUgUENJ
IGNvcmUgYW5kIHg4NiBxdWlya3MsIEkgd291bGQgcHJlZmVyIHRvCmtlZXAgdGhlIGhlbHBlciBz
ZXQgbWluaW1hbCBmb3Igbm93LgoKSWYgbW9yZSBjYWxsIHNpdGVzIHNob3cgdXAgZWxzZXdoZXJl
IGluIHRoZSB0cmVlIGxhdGVyIG9uLCB3ZSBjYW4gYWx3YXlzCmludHJvZHVjZSBwY2lfcG93ZXJf
dF91cGRhdGUoKSBhcyBhIGZvbGxvdy11cCBwYXRjaC4KClJlZ2FyZHMsClTDvHJrZXIK
