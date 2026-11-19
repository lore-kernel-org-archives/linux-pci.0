Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087289;
	b=WzUFcQkxAu8k+DOYkJMWJHq838thffGFj9BhtmGyAmAuhaoYZgShGcIHv/CUhRwvj7hB
	 WdtW/HoeGqU1YqvnJQFjDr0fSgCxzsq7V81RAVsJaRbt0Unr2kbL7V1wZPbsdOOKgAoba
	 STY6CMWYwW/ZBOQhWDdrB46TXvhJjBbslMdBnU+vo4FHNlP1s9dWYSOsDvfICy8F4lxuM
	 ibWV4ViKRv2YCwN7s8DdBnSkuSfykNKJAHxOTqGsRZJwQcci9ipijFyeqRUtG/UlWuwPM
	 6u+90ELTqyGgUOBmp74vwoi/JOmwU9Nk54RS7YAv2x4xM+R1uPsfUhnsXggVXB674+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=8lN7WXcf7Z74tP6iWnNO2lb/aoJDcUY8nFu2puEFRqk=;
	b=FUNpK8RCJBTmM4lk0+fMhqyQGpG4c9cnwVJ+JTXUP7v7VJYB9watNDUkVD+6Vxiwz6vq
	 4lHv1fX6HZTWBVIWaMGvN8KNkqvjtjZXejOPv7z4uFVOCCuuaU77rO9kz52vwkpKyxs9e
	 h6RH6bMwMPPeaRcEb7PKAj6PPSBDE8WpmeXwdaOAd6EZLUXJPgGreF1lX5vMytEAU/cbe
	 T0yq96BRIeDcdDjliMUWCvCWvvUbXFchr/LKSfIRqJ84RjYr1e4gAGt11LfsfY2wLp7Jk
	 gZxkFWzOKd3qFDRXhWJAgsAo8OWUtyezasapOjLHf2VhVK7uHhTmGTZb8ub9l1kPTqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=hO+IyBJR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.84
Received: from WA0P291CU002.outbound.protection.outlook.com (mail-polandcentralazolkn19013084.outbound.protection.outlook.com [52.103.53.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F5606A32A;
	Thu, 19 Nov 2026 11:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 984F5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=hO+IyBJR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1PHGZABE3mi0ORT4SerzODn0QKoOruiJMwahdU0Ij4yTwh45CowrD1G1E9vytghDyJr5iFEM3HB1MRcFsiegol6McHlYm2ZDJcH4G5PUDyz0cvaZsoqH1O9BRY6v+ByNXJQwDypi/0b7FAaMAEtv+rgt5221s8TeRaKeWAluuZbe+yKV4eXXuYmIjjmirFXhoLEUXQqewrTFyRXfFr6iQ8qxIQ6Weoqh1nX+USRNCGGnrmfmTV+W2OR/kO+0S9IuXuzXsYzJzm/ax6EErlhes6ACrAE5JJRCSQjVEF8sLUFhD2pqIr6Yrl2O7Vlaf1ib4U1K0a2SM9nfQg3weOkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lN7WXcf7Z74tP6iWnNO2lb/aoJDcUY8nFu2puEFRqk=;
 b=VMKKit+1FvUMhiwnHkmfzv4YVTcfjG9UZTN4ja+3zgFDuKTEc+/jp2cPJDzQg1HIG13x0Wh4kbUGRK0DuU/KBGGheQTOOTJN9huNNqYan1AZnJgC99cl1fX817BQY41vBHvD91rh+2ZRgTwNtvksbHo2EMDv2kHlSXnQEK6zqQi9JUBY09kv+P1ZKNZzuKMOwUZ6IRHPG1d519GbgNakmyolauRQmQH79LC1+/ysrnXQb6dWgR2JO2N3aXOras55QkwUaZQGoXRgU8CVy9yK1FbWNAZ3sMjfXq0hLkSVyfrbtvApTrhse79k1CnpKFWGMYWUc94jH0FAevXX1M1KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lN7WXcf7Z74tP6iWnNO2lb/aoJDcUY8nFu2puEFRqk=;
 b=hO+IyBJR5Q6GO7r3VdMVoORX+G+DPs4rk61orokN1SiFvXtc00U9hoiJEmYEC39clIOp8VR4gsCIPllW1byqeoLbCdt0m0ucTggH7Ducapoe1suXWpzCpC1+qzp6p6M82UOsSMWb1s1skllyYicq9/Sg/xLY7uRcpKW0/pVCG03IRlTVCzFHMA7ZVp+pMQ4GuqghCJs61tc8i57q0MPw+lChDniV3DGriilViJkvu5yOFHO9i1UQzbh8qBZweIOgSYVy78EJQNV7WS9DZHr/kPYeXNEGsFmwoWlN/HHKTaHMCLq5nVcl0XcBlLonkqxSYF8MknAw2FgrjKwETouzrA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA1P291MB063504.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:21:25 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 11:21:25 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"habilerturker@hotmail.com" <habilerturker@hotmail.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Thread-Topic: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Thread-Index: AQHdd3gbW+1bmUjs5E6RWZ8qpfDQtrc1GzYJgAAk2IA=
Date: Thu, 19 Nov 2026 11:21:25 +0000
Message-ID: <20261119112124.6442-1-habilerenturker@hotmail.com>
References: <av67u5GSVL0KWolF@ashevche-desk.local>
In-Reply-To: <av67u5GSVL0KWolF@ashevche-desk.local>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA1P291MB063504:EE_
x-ms-office365-filtering-correlation-id: 566c9bd6-ad07-4b5e-8b92-08df462f3fcb
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOoG+ELzI07R8IXXcurQkP48J6acMqvpNbIrpGCbNT8bu86c7t4qVDKaY5RAqo3xbfe1Ih2r9Fzw2Jsnq/nfcCd2L/z6WxCdoX21cD5dC+9QqbLTpZuDHOxBWBfDt6/W5x3WHz3V5uBD0mLKerPROk33EXHd7g5ioA1RyCjJg4el0a5BcSojV7r3OEA/lINlpuKZu8lsFVlLgtLiC2LI44hMHAJ/TXL9NFa3Y6e5YZaAlg5ye8tg4iTYcHDk+BcbqXUiErrLzLo6sSysYEHu5FmKFJN9qlJdfe+xfFdtGVmEleGWgYYufls6NoutzzjQX+qTnVjbTUI9Pngn8tcT+dNZos19pegufsnepWUm3mCnCaeCYyM5zUgXEMjuXRRnHPAjLzfHptzuDljef56ZezVNlxBep2MwpyHfiCaPIHr1hYQkIe4xDk0LL0Oox2iWFH0QiAE3RUa2JrCO/ZKhZbx35h9rsfe6eNB18ysarKXIc4YIHj8fNYE0CyLYRk51+mfnngMtO8OjBj0Wytfe8if28Ak6mMgQPXQvsPtcN/j0o+Ch3Pzikgq9hIAIvXoij0KaAF4P+WFZjQjCEbzfJ4IdM7H8yIShal5//rWEnWihG8QAIxUcg3gKp7G5bczmhJHKYCfypEf6OnycPbvSVJNetqoVVH7h6agopFL9qTthZlkXgskrr5bjpojnors9xkUVh0XGGbZyNfe3U0iS/Hf8XkNEJ7KLVo1YG8oGSarso=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|31061999003|24021099003|55001999006|19110799012|4140399003|25010399006|38102599003|51005399006|15080799012|21061999006|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVFDbXRoNHkzUjFIQklHQnphelhpamRUQXRSeEYxeDVDb2djZVZ5UmN0SEJy?=
 =?utf-8?B?dWFwN3lmR3MrRDJkSXRlcVYvQzYraE01bWFyWGwwMWxaQk1SNHVIcVBIUFRV?=
 =?utf-8?B?cFczZ3YvSDJxcEFxM3NmYkE0Zk5lWjNvcjVUS0t1d0RDTVRWOGpucWZ3YS9P?=
 =?utf-8?B?T3hRV0p1K2lRTVFBcHZTOTN1dzNuazhNTzA4ckx2b3N5bkdVSkJGdzhON2hY?=
 =?utf-8?B?TFZYcEgyMEw4cXA1QnhVVXhXMTN1aCttNmI4TFFBYnBzYWszK20vKzBTVmRP?=
 =?utf-8?B?QTBlZEJMYlE3RVRNUXdkcjJETmpkbVo4cUZ2bkRYZzkxdlFYbTIzaWJkYTlm?=
 =?utf-8?B?aTk4d1luanBNZENOZ1BRckw4cFlIMXdwN0E0bzEwWWlGNE9tdUxyRTd6VVll?=
 =?utf-8?B?RGFlQURhdlpsRzNZSmt1U2x0bWlrd2xzcFc4SVJPL3ZyWkthTTFFK2lmQmZE?=
 =?utf-8?B?aWx2ZzFBSTNHOVN3ZXZIb090SHozUjhkdUJFTS83VlF4aTBIa0Y2REU4V1JF?=
 =?utf-8?B?RXZham0xdVN6bm5Wbm9zQ2pJR0hRMDN4dzZyeWZYS0JjLzR0cUZuRmRUUzRh?=
 =?utf-8?B?SE1USUx4MCtkU2VMQ3dRdHMxenAxSzBnY295SG9zUHl3MG5HSWpBbG43SlQ4?=
 =?utf-8?B?MENWQzJnVW1tYjZya0tydWxUMGxPV0MxY2toS0FQSmpJM1MyRnpqUWZsSW92?=
 =?utf-8?B?RnRpZXJKWVhwVlBTd1RCaXBtOHdZNmtHUlc5Q3U1RjVpNEt4VDVpclhDRjIw?=
 =?utf-8?B?b2J3cUlhempLZlAyRldoWkFSOE5hQWgzL1YrdjhtNU9hdi85V0pSMzI5UkVj?=
 =?utf-8?B?OUs0ZmpIOUZMbExxZlJWZ0NGK3BsbGFCNm1ON2M2aGZCTmIyR28wUGkxR1VN?=
 =?utf-8?B?SkppWllQa1FxdmFTU21ORzdsVUtDV1d5VWZTblB6RzB1MEVFeXEwbUJROXNK?=
 =?utf-8?B?KzFwVk92bW9HS2kxbEF2cmZ1dzZ3SlB6aE1Bbk9TN0pSYWxHUUVnZnNzMEI2?=
 =?utf-8?B?VjJJVS9yclR1Mm13ZjcreWY1TzE5M2ZCbTd4YWJaelNIZVpjU3Z0M21HUFlz?=
 =?utf-8?B?ckN3aWlUR2RxcEtiV2ovV2lzSzAvT01nUEFNMmwvNTU4cTZ4cWV0Y2lDNG96?=
 =?utf-8?B?cGFWcEJ5WlRSejB5by8raVN1aFZwU2hCWWpwN1EzWk1QbWJHVExzSXYzMzk4?=
 =?utf-8?B?SnFFT3dhSmdPNDBXbVdIVU9hcHBFNkFzNjA5TERFTEo0Y3dVZHdEdmhzV1VB?=
 =?utf-8?B?SjNMdml2eS9CZDB2TExMNGQ4YVNNczlCUFo5WC8wQXl1cE4xRGNBaWN5dXV1?=
 =?utf-8?B?NXFiVURMdVRQV0JEYmxSbGM0MGh4VzBxUlVSdk5vNDJQTGlIZ0lSSzNCS0pp?=
 =?utf-8?Q?wVii9dzhaLHAbcL74VyHCDVvmQMxTnY4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nzhya0dUN2RKQmVsbytyUnNSczRkeVpPV205M1NKYnJNNi9qQVpRNmVPdDh6?=
 =?utf-8?B?VFlPWmg3ZmtpSGR5Tjhub091eUJiOWhZdnNROTl5VUVGanJoNzZKVmdmUm8x?=
 =?utf-8?B?MHoyS1ZZQVU3YTUzbUNtaGtKY3VKZlJoK2poM0xUSzVJK0tJSWg2WGJqRkF0?=
 =?utf-8?B?d3VJdHZHaWFmU0JtQ2tBQ3NEcEdIZC9ZbGNFUVh0MnFFL2cwZjZvMCtWYU1C?=
 =?utf-8?B?ZmhkWE14Q1h6QU9ZT2x1Rk8yeGlGbnFpMHUyOVF3RjlraEVIWkVnZmcwMWtY?=
 =?utf-8?B?aXlzWHpnU2ZOUExsS0dRSzRwdWVYZ2FZbHBMSWVpSFBTNGlMUkNUV0tDNGp5?=
 =?utf-8?B?cnVKc0hIb2VXcFljcG5xMVFMcWlJc2V2UVhKVWNjaDhkOWg1RDJ5QmlseExC?=
 =?utf-8?B?Vm5EczQ5UEhOZlBGRkFKTWtiakRtR0hhU3JYcXlDRmVUSms5OFUvZk1RMy8x?=
 =?utf-8?B?dWNhOGpjU0IrcEhtMGFLL1hoWW1nY1JtMm9ydWk5eld5eCtDT2JXOWQ3bWpO?=
 =?utf-8?B?Z3Y5RzU0d0NBN0p2eXpsZm43NFVwMnAzQkxhNXdWNVZuYUZ1TjNDd1BXSXV2?=
 =?utf-8?B?cmo2RVUxeUhWRmxQbHB1UTJvSE4vRDFrT29tcFJtNVpxZ0lJZFVRWCszUVhk?=
 =?utf-8?B?ak9jUmlzREYwVk1aQjlvTEJwQ1ZMNnV1c1FDN0N0WFU4LzF0SENMeXVaeUVN?=
 =?utf-8?B?UGU2c1FWQ1lRYVpyMGcyRlp5QTlCWnZ3Z0U3djM5TG1yUkt5QWpYNDU4cGRX?=
 =?utf-8?B?ZGlqMVk0bW9jV3hValVzN0N0Y1prWENWdXRVZjYrRWdQWXBhZU1Eek44aHdH?=
 =?utf-8?B?V1gwdHhxM29Zek1KZ3dnbC93V1I1cnVWd3k3QUlkTXpVRzRSdTVJcHZ2Z095?=
 =?utf-8?B?Z0FXSXZkUUhoMjdDeWN5NXZCa0EyRVMzOUJST2MzTlpkVTlIR2QvMTRmWGc3?=
 =?utf-8?B?bzlwTUJpNzByREZHS01PWitUNlltQlpUYUFyYURnaGhnOThEMUNobFdwRU50?=
 =?utf-8?B?S3lkeHVuNlVwaE1JSHJDMi9Qc2hsbEtKTkVzaHdiT2ZQTjQwT2krQnBYb3Zt?=
 =?utf-8?B?ZFFadG5BMmhyTlJwalFlNEJSbC9FbUFDaFdMTnVyMGFoSzhzU1pPSWh4dUJW?=
 =?utf-8?B?L3FkelFuRzM5ZXNtYlg3WmhZS2pvUU1iMlJyQ3h1YnlIZi9Ec1pBaFRrMGp1?=
 =?utf-8?B?RHNQTEJVQ2dSeGt3bU9YVENlUzZ5cEFub1QrVStBbndnL2dVTHlMR013S2Jy?=
 =?utf-8?B?V2o4TzNRdjVHb2NHdG1jK1RkRGkza2ExaTRrcFFyOVdjTVJnRnNuenkvSy91?=
 =?utf-8?B?TmJYQXJXYWIrYjMwTXVUT3N3NHIxSWFUYndyZ2lOckVOcTdPWnB2Zmh5OUsr?=
 =?utf-8?B?dndpVldQa1ova2o0UzdxUHBac0xXQlZFQTJiaWpDcWlwTFVKQVY0NFhYRmIr?=
 =?utf-8?B?Z1VaU2wrckhFZGRURFM1TjNqclY2OHJ2N2tydmk0Y2wySWRleTVkbzJva1N6?=
 =?utf-8?B?MGx2WFA3SmR1R000VWR5MUpIMlpvWGYrNVk1aEo3Nm14UkpQalJoYjJrcnlw?=
 =?utf-8?B?cFhYRFpaYU9yaU9LdHlFSVV3dTF1WXBzUnhLL3JDa1ZNV2RmN0RkYTdkN0ZM?=
 =?utf-8?B?Zkphcml5bllJZ0M4c1ZTZUd3bEh5VThJZklKamNOTHVqT1YxbzJpL0lxMG1K?=
 =?utf-8?B?bXkvN0RsL2lYZ2lCRUhSbExEcXhUNGhya2JZVHlCbThQVE9DOHR1bDUvWjZN?=
 =?utf-8?B?cExvelZDQUs0R3NIZ3hqNG5ienpVVzZFeHlHcHJEYld6TWtKU2JYcDNLemJX?=
 =?utf-8?B?WWh1VG1QU1k5b2pieDhacyt5Z3ExWEpNZEZQczFLUW44SlJQZzZqVzhodkVz?=
 =?utf-8?Q?+D/+kSuVFrTpf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DF5C6B53E240E4F88C57A0593AA2B6F@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 566c9bd6-ad07-4b5e-8b92-08df462f3fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 11:21:25.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA1P291MB063504

VGhhbmsgeW91IGJvdGggZm9yIHRoZSBmZWVkYmFjay4gSSBhZ3JlZSB0aGF0IGhlbHBlciBmdW5j
dGlvbnMgYXJlIGEgbXVjaApiZXR0ZXIgYXBwcm9hY2ggdGhhbiBzcHJlYWRpbmcgKF9fZm9yY2Ug
dTE2KSBjYXN0cyB0aHJvdWdob3V0IHRoZSBjb2RlLgoKVGhlc2UgYXJlIHRoZSBtYWluIHR5cGVz
IG9mIHdhcm5pbmdzIChyb3VnaGx5IDMwIGluIHRvdGFsKSBpbgpkcml2ZXJzL3BjaSwgcnVuIHdp
dGggYG1ha2UgQz0yIGRyaXZlcnMvcGNpL2A6CgotIHdhcm5pbmc6IHJlc3RyaWN0ZWQgcGNpX3Bv
d2VyX3QgZGVncmFkZXMgdG8gaW50ZWdlciAofjI1IGluc3RhbmNlcykKLSB3YXJuaW5nOiBpbmNv
cnJlY3QgdHlwZSBpbiBhc3NpZ25tZW50IChkaWZmZXJlbnQgYmFzZSB0eXBlcykKICAgKH40IGlu
c3RhbmNlcykKLSB3YXJuaW5nOiBpbnZhbGlkIGFzc2lnbm1lbnQ6IHw9ICh+MyBpbnN0YW5jZXMp
CgpUaGUgZm91ciBoZWxwZXJzIHBjaV9wb3dlcl90X2dldCgpLCBwY2lfcG93ZXJfdF9zZXQoKSwg
cGNpX3Bvd2VyX2VxKCkKYW5kIHBjaV9wb3dlcl9ndCgpIHdvdWxkIGNvdmVyIGFsbCB0aHJlZSBn
cm91cHMuCgpJIHdpbGwgcHJlcGFyZSBhIHYyIHBhdGNoIHNlcmllcyB0aGF0IGFkZHMgdGhlIGhl
bHBlcnMgdG8KaW5jbHVkZS9saW51eC9wY2kuaCBhbmQgY29udmVydHMgdGhlIGNhbGwgc2l0ZXMg
aW4gZHJpdmVycy9wY2kvIGFuZAphcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmM6CgotIFBh
dGNoIDE6IGFkZCB0aGUgaGVscGVycwotIFBhdGNoZXMgMi1OOiBjb252ZXJ0IHRoZSBjYWxsIHNp
dGVzCgpSZWdhcmRzLApUw7xya2VyCg==
