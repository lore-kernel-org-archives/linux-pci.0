Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265960;
	b=KUtTx4Ae56e9UQpbIDUxW3YBzuarS6FFu9dMTupqjtbqPajasrbiRBHnVPa7pvx20KX6
	 MjPPbs/GuSktBEebfRs460xtzGqc3HdEAZtRBHSW2Y6qXZXj4auAQG2Arb9xvDJXzc8cv
	 GC9YVTT+AL+c2d0ZJhVitdm9wXIq5BK0NqdxLGwGjGKu8NBEl1zImaqUSPFNBj5TpuVK/
	 e/lkM/JY9TVJkzx+n8SrG9ccwstP/maZxq6qsqfM7tm8Womp0cFlsSDKvddUwkrmMaeJf
	 Qqd0J0EeE2X0sPD4s+2aFnMOLsSaF5f0mf3sAE6c518ORKt/AFKHMpwyS94dOjzmi3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265960;
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
	bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
	b=VL0cHKhxP1Iteh4kNyFT+VXOFxsqZE1/Z9QukEM30Iuro4lsa//l69jh8UPNi+R9rnQa
	 sjDKc1uFEbvXyApS2vKRudcGS7fdwlfzkPt4irrkQCaqVhHvtzbBa+zOk6AgFQFkzVCWZ
	 Oqvz3ha0HTEOAhW/S6wt69uMa108Buiea0aSQKHIrAoRvBeoCJDNJ16t/SewBulHTJH5C
	 ZfsVq8SMfDUcffBL1vvwV4w4sw19n/UDoJxnkKPG+cAcZsRfqppqFGXHfP+Ven/+7tKe+
	 ckt650IRDZSu+4W1xOwlESVeCQ/vZcFSVDKWhKerjneNER1jgdEYucAQjEs41XjFUkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="J0d/rkLe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010020.outbound.protection.outlook.com [52.103.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FB606A6A1;
	Sat, 21 Nov 2026 12:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2FB606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=J0d/rkLe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYW8BSZnOSKkoLUBRl1hxJk4+IMf7fc9jXWO9sWrhBG7HCtoNHpIhfUg42cojA7G/Qx+IWcNBc2SbeuyFaxzIJpr3KYfd84geno/RgjJiNnAvU7BIrFeHOyp7tmynR33s0aQm0d0OXnQFtY34gSrhNZdOF3imFXhWSis35kI8C7XevKxveN82lPD102qHYccKAurmtQuC0Ao477o25AFjnwRjiC5Yi2E2L6VugPxAgH8d+l9AOGr1AFxiqCfSvTURaPmivp+eEKxyEIRHLqKjYFbc1HhjNsk2cKJkYcwDwJn8Z97EX0Le7A4zqdGC8a2McVkJ2ohXRImGRFZzgh8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=azbEqCwoWyzrkZJLFWGVO2eob5JSaqUr4jtsjRv/V8eSmN15kirKxtK4J2UY3Njrq0Bnyt0HPpHKlKBJYmawYAsG4nCfrKHkgO0imlBGr5i31X/5tkker6u/uKKS18DKWzZaXt5miRVdhET0aCL/MVF5aT8RYSjlFQG8SvckJSciDg2eR1/MWJv1DKER7k/copNT79G0onea9XvrclvWsfoCeBvLFEj11tvPDcDJ/gPkCokMkoByC4CByRT/f3iWjPVewOV7f/FXmUBQS3jiwfNJrQWnT0Jnhey0pC0adOjwHg8F1SmNfuP1Rghr8abVLaJk/fhOB4vXk7CqvAoygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYxhWrKmXpQ6UGbDw83Ie76JUQI7tCmaDceRa5x7sCQ=;
 b=J0d/rkLe+W5cxD9uDe3abLe4oc9rKaXmVBX9bZvVGoIvXOxSfR7mmvAxIx8TD/qtrneUeQpMfs5UwSt6ftk86sR1GbvzUVUUjr9LYfWp/bOLEEsD5+oqL8Tz0I/g9r54CXInwBQToGokOp9mMcSj/WmKIOZ95/cy0omegFYtUHsOeC6Zx8zDGmWASEnQg4feIqptB2wQesZTtyjQX7e8140mpKJTJa0l1kGSOdUTrva3+VvjqLAcIu9mzufJhou/ft8wF8lK2H0ZqEQQwPJK9NCL0g+f7CbBEh237Sbj3QHwkD8xtwFDCJCZX7BBgpA7z3LdWVeWu3Q9OPNwLPA/LA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0248.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 12:59:18 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:59:18 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v3 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v3 4/4] x86/quirks: Use pci_power_t_eq() in
 apple_airport_reset()
Thread-Index: AQHdebgeQ4ZVsH2QzE6c0hXGjxwWDw==
Date: Sat, 21 Nov 2026 12:59:17 +0000
Message-ID: <20261121125811.50315-5-habilerenturker@hotmail.com>
References: <20261121125811.50315-1-habilerenturker@hotmail.com>
In-Reply-To: <20261121125811.50315-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0248:EE_
x-ms-office365-filtering-correlation-id: 48284523-5c72-4f6b-3c0d-08df47cf40c0
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|21061999006|24021099003|51005399006|2604032031799003|15080799012|41001999006|12121999013|8060799015|19110799012|8062599012|25010399006|55001999006|102099032|3412199025|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?anJjWWRsRzAyQmk2VENpbWJLTHd2aXdPUStMZGhYZDBPdmhJeld1UFpUa3l5?=
 =?utf-8?B?M2tJeU9vQ291djlkQllra3NqeHFZdFM3MGNUMk9id3FXODBEV0JYallTeFdU?=
 =?utf-8?B?N0RSZlpMOGNPbXN4aGU2SmtuVWxHMUVEK2FDT2g0bW9uUmxHZmc2TDRiQ3RG?=
 =?utf-8?B?NDJpZ01NMVlROVZxMHhFSDZTYk5HUmRtMWltT1pZVFFhcFJYTU5kcnVNQUhK?=
 =?utf-8?B?Z0VqcU0rWnErb0tYWFc4VjYxZGt5ZGxnWWhZeGJheWJrUzRhK1diTnExUHc3?=
 =?utf-8?B?bWNpbnRRVFY0S2c5Z0QwTGNGby9xZytYb0h0NHBhU0pVNm9sTmgzWFl4bk42?=
 =?utf-8?B?SDNLSFRjNWJqWG16V0l4UmV2b05sK2IxNFFia1dHTEVEeUtROURLMjhNYmg3?=
 =?utf-8?B?N0ZWMGo2bnVwc3RDWWJjbVVPQlNFcG10TE9LZjZaMkd0VDFWWTdnS1BTUm5v?=
 =?utf-8?B?VVZLbUlxbDVEL2tXbGVZazhnY1BROHhPMnkvL1gxa09oV1kzQ09TQTA0UHkz?=
 =?utf-8?B?bUc4RHI1YVNyaDlJdjJDRGxpYlAvS3JMTWVDWm9PZTlldXNVakpwcm1nd3g5?=
 =?utf-8?B?TTV3QmVGVHlGdWszeEVOZmpxZHV5ZWwrN2JkVENvZG1YNC9GSjNURDhaMFBM?=
 =?utf-8?B?QVBITld6aEZkMFViT1F1UXRGRWpvWUJzeVlQdmsyazFCWG8vMTJYdDI1OUpT?=
 =?utf-8?B?L3plVlVKOVpFUUVkK2N2TzQxL281STk0TUlyMlJRYUFRKzBxMkZJa0hxcU1p?=
 =?utf-8?B?R3U1eGg3N3p6UG9HWTZESnZCT0E2aDU2aE5mZGozbk5BYi8wMDhzVitsMXFO?=
 =?utf-8?B?K3lRK0lTK0k0K1BjSFhqQVIxZ3pUOXcwWHpoQlIrb2RGTW1BcnE3ZFkrbTF1?=
 =?utf-8?B?aW9qenNqckNRV3c5bm5PVkEzdjZxUThpNTFHN0Npa25TRnZ0RU1Wc3R3bk00?=
 =?utf-8?B?RlhFVTg4amh2dDFOZExpTmgzZWRFZkd3MWhYdXVKYWo5ZWhISU0wOWIvM29G?=
 =?utf-8?B?SU1YTHBDRVFDa0xBKzNFbUNGWU5TSGVnUHd6V1A3OGlyL2dHaklGNE9iK2xT?=
 =?utf-8?B?bXRFMXdLZlIvckpuN1JEbDJ2Y2hIUWNZdVR5VnBLOC9XMncxaVltT0MwNjh4?=
 =?utf-8?B?Q3l5V1NVbnJxeW9vWUkrK3A1Y01GajdLekxOUm1sSGNObVU3NGdzNnFKUGoz?=
 =?utf-8?B?YmhUTlRuVTRqenZWRWxQdTNhY1hNSklwTlk4ZzUrTm92ZUtQZ1gxT0lOdUVv?=
 =?utf-8?B?WXJUcGpxb0hBWDdYUTlHeXhzK2ZIS25iZ3RDdFg4bTNnYU9HRmEzYm0rQTRv?=
 =?utf-8?B?bXdNalhkQTNlVkVJWUw4UmhCV3ZCbTB6QVVpTUc4ZXNIcGsrUXAyOUlhVDJJ?=
 =?utf-8?B?VGhkM3JHMkZJaXVKYVRvejZwMTlhZm5mMTdyVGhRTmY3NGhqdXg2Qm1naHhI?=
 =?utf-8?B?dVZvT3ZQZWVUVEhFSVAzbFgyaGNSR00zb2ZudEQyT0wzTDg1cXlCMUg3SDJS?=
 =?utf-8?B?MHJrdVZGTUZZSkRoN1dqNGZWaUF4VHBFVWRiTThtWmFkcUthaXlFTjRGSmVI?=
 =?utf-8?Q?tJA1LnPKwBl/XIHKVa7E0KdGs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnBTeExCdEN4TDRRK0YxYmd1NHpWZ0ova3IzWHNjUEJpSUJQS0wxbC9yeElr?=
 =?utf-8?B?VnlTeVJhVVZsY2YydXBGMUtEemI2OE9lODlTTEdPdHRrOUdra2J3NzJONHFP?=
 =?utf-8?B?SDNmSUF2Q3VyaUNRbkx3REt0RWErWUt2RGVmK21XSGtoQ3lyU3B0aVNkeGdG?=
 =?utf-8?B?aG5Nem41aEtlNW1mN0I2NFdWR2hSMjNYN2RsY2N1ME1YbEpqbmM2UXZMb2RJ?=
 =?utf-8?B?aGZKVTJtL2VYbDliT0tCZ1FyVUlITnJ2OVE4THBFRlB5TUJ4c1htM2FlL09r?=
 =?utf-8?B?TzNCYUpaRVVrVEROS0ZYYTNzRWpXK1BKQk1lNWZFdGVtdjhmOHUweU5PYThh?=
 =?utf-8?B?NGd2YzNzS2ZQeExiMFk0aEVSS2ptMENuUTZleWlyZFhVc2NDbVExc2p4eFc0?=
 =?utf-8?B?dVpaTFQrSHNKY3UrTUlZSTZIT0xUK20vN0lUYWtPMWdGZjhDR2ZMU0hKWTE3?=
 =?utf-8?B?VzlVekhxQjhwa0VRRzBjMW5sVzlpMjkrcUtDdWJEMG83S0hOZTliRVFWRS9T?=
 =?utf-8?B?RDU5V2pVNncxV3ppWk9hYUx3eFZwL2xtMVgyc1MyaENTNFZqSjJ5YzBPb0lP?=
 =?utf-8?B?eXArTDdVRVFDdHRmMnlpTVpPRHhncjRJOGIwM2NXMGFzTm1Bai9lMUZlRnN4?=
 =?utf-8?B?MTVOSnQxbFkzUVd4OWp2eDg3OWJyczhaZGpvY0RrWVpOTmVsWlZWQzlmeDdN?=
 =?utf-8?B?V1B4Slg4bEhrZlJIaFNBdDF2b1REcWkzY0lxTkgxTmFiSnNad3RDZXlQeENU?=
 =?utf-8?B?aXc3WG1MWXpHQWFnV0c0cVZobWRtWFFDaVZ1MVZZNlU4cGVRZVEwZTRRS3Av?=
 =?utf-8?B?b2xkaWVXNkxpYmpsTmt3OTFVdTROWkcwdGg3bCtqeVFZZmRraGlDTVZISmZz?=
 =?utf-8?B?QUhtMllJTUJDZGljZjMvRVI5R2RITnBvSlpVNUZrRnlPaGRQazk5Q3A4cUxN?=
 =?utf-8?B?cXZmVEZramtyc2lYN1JQZ3c2TUNOMndJQWJEdkM2ayt0UXBScnA0M1loVlli?=
 =?utf-8?B?QTZFa3l5Z1RuTy8yazhOWnhsUlpyOHZBWTdNbzlYOThiSUFLYzV2amhRaERp?=
 =?utf-8?B?bFI2M1FWVHRuSGhxR1U1dTBpaWV1aHBrT0ZnMng1VXhseGhDRkN5YVBFSTMv?=
 =?utf-8?B?YW9kZmRSSGVnTjVqdEtWYm5HWkNwTmtHVlVia1pkOHY3K2JKY25Ha2hpQkNF?=
 =?utf-8?B?NzlEQjVxR1l2Qkh1Rlh2dzhUU3lOWGtOM3I4V2Y1M2ZUeG1KN3JXYk1yanhG?=
 =?utf-8?B?aWpDeGlyQms0Wi9TcDhMNGM2YndVN2Q5WG5IUHg4ZEpQNnFiMEtkS2c4MW5U?=
 =?utf-8?B?TVlpY3BnWDF4Z3FBTVUvMndPWk9Jb2hjWlFZSVpzOEhVM2hpbGdobys5amdo?=
 =?utf-8?B?dStBVUpUTXVOM2ZKLzFXcnJyalYrN1ZWQWFyREF5VjZPRXRPamRwSnFlRUJ4?=
 =?utf-8?B?alRCRzlHUkhRTHZmb3FaTHBUTWRQZlBNRCtzWWtPVmxYeE5qRTYzaGQ0RjRp?=
 =?utf-8?B?aVlGbEJXbU9oaVJ5aENZRFluL1hRdUtuQktTM0lMZFE5d2xpdjZXUTQ2Mnpz?=
 =?utf-8?B?c0JTQmk5djlqYzVKQndJT2x3clJVNlU2a0o0RS9NN3FyTlg2TFFVb2ZjYjZh?=
 =?utf-8?B?anhPVWgrUFZaa0ZoTkJuajBnb3lPRkd0YUZTRWdsUFpFamJRVW9NVFlLK0k4?=
 =?utf-8?B?OEVIRWRrbjY3OWtuZnVBU1hEUHVxdVZXUzA1QU1LVUYvQ1lqeVMvZ2ZNT2RG?=
 =?utf-8?B?QUZPd0I5ZDl1dm5tMmEyaG1UMnJRYXlJVmduSm9zazJET1J0Q2E5ZktvT1Fo?=
 =?utf-8?B?UjhaOE9wVmxwWU12Y21jWkFlbksyWjFrTW5DUmdUMmwyQlBScm4zZW00ditr?=
 =?utf-8?Q?HDfYD0vkDnOoG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB3C88983C947A419890513F74A855D1@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48284523-5c72-4f6b-3c0d-08df47cf40c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 12:59:17.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0248

VXNlIHBjaV9wb3dlcl90X2VxKCkgdG8gY2hlY2sgdGhlIFBDSSBwb3dlciBzdGF0ZSBpbiB0aGUK
QXBwbGUgQWlycG9ydCByZXNldCBxdWlyay4KClJlc29sdmVkIFNwYXJzZSB3YXJuaW5nczoKCi0g
YXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lf
cG93ZXJfdAogIGRlZ3JhZGVzIHRvIGludGVnZXIgKDIgd2FybmluZ3MpCgpTaWduZWQtb2ZmLWJ5
OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCiBh
cmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvZWFybHktcXVpcmtzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKaW5k
ZXggNzQ1OWEwNzNjNzRkLi5iMTBhNzNmYjRiY2QgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5l
bC9lYXJseS1xdWlya3MuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKQEAg
LTY0NCwxMyArNjQ0LDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhcHBsZV9haXJwb3J0X3Jlc2V0
KGludCBidXMsIGludCBzbG90LCBpbnQgZnVuYykKIAkvKiBDYXJkIG1heSBoYXZlIGJlZW4gcHV0
IGludG8gUENJX0QzaG90IGJ5IGdydWIgcXVpcmsgKi8KIAlwbWNzciA9IHJlYWRfcGNpX2NvbmZp
Z18xNihidXMsIHNsb3QsIGZ1bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwpOwogCi0J
aWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRFX01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lf
RDApIHsKLQkJcG1jc3IgJj0gflBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CisJaWYgKCFwY2lfcG93
ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CisJCXBjaV9wb3dlcl90
X3NldCgmcG1jc3IsIFBDSV9EMCk7CiAJCXdyaXRlX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBm
dW5jLCBCQ000MzMxX1BNX0NBUCArIFBDSV9QTV9DVFJMLCBwbWNzcik7CiAJCW1kZWxheSgxMCk7
CiAKIAkJcG1jc3IgPSByZWFkX3BjaV9jb25maWdfMTYoYnVzLCBzbG90LCBmdW5jLCBCQ000MzMx
X1BNX0NBUCArIFBDSV9QTV9DVFJMKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lfRDApIHsKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShw
Y2lfcG93ZXJfdF9nZXQocG1jc3IpLCBQQ0lfRDApKSB7CiAJCQlwcl9lcnIoInBjaSAwMDAwOiUw
Mng6JTAyeC4lZDogQ2Fubm90IHBvd2VyIHVwIEFwcGxlIEFpclBvcnQgY2FyZFxuIiwKIAkJCSAg
ICAgICBidXMsIHNsb3QsIGZ1bmMpOwogCQkJcmV0dXJuOwotLSAKMi40Ny4zCgo=
