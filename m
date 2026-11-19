Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098948;
	b=4MJH5kVrlqKvEqcPspbeduESGodXWRHZUq75hTaPXZjBtAFSERTZTaE4Xc2kLiHi4CeP
	 FBDE2NOb+9Ic7gCWeBHhxj+UxQ/2xEwLg3yr6ZViDYrE3lfEEOR84/F4vDu77gHRyk+Xl
	 LuSccOE9gdojMqhzXqrg5dGg8F1C1dq/ekmQ0cIvYFClAxgwTAbKbVMBf2900wG7N3ejN
	 cIqJg6CBR0TPHy9FnBqNDciTXGBbsNYeLoX26jOFr9DiUE9/kbqs0kW/kpJ7vyBEfIV8B
	 uQ26VGWedL+PJWRuAd3XuEk7z3IaketArns86e9q0NHswopadZZlRjIgTlt+K5SLgvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=sOXu3MlYJcdInDMM07pFpWpad3f+8aMREayAOb1Fexo=;
	b=EX3H3gnKNTqGrGOwEDIBl6t8FKyKeDaJYNyRdWxE1q9rl2qy0eBv1E2I++nZKboh0nP2
	 E/VCjTiNAAKK85g3gw8HflKrKPnXWte4Hm4htYMMT8k2SHQWLMd660GC+kwErVmGRZYpl
	 yCtJupf2z1ez3GKjizx5uX9SrAO1QFfhmsWVUlZjN6KYG+DUJ4S+weDe+9UDY0DVHhQoN
	 CUiHkgeFp53YJOw3nfG2OQoyQwq/R+8RfJhJ+2i/iKSIc6IWAXVcjrYK9rdj6bZ73pu1B
	 KWUNVdNbriJPny/B8zJ8Zo2Ydfc8RbrJVeZhW5GCmDM4wKekbYoN85qjX9jgmyV7p4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LIQSNrog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010002.outbound.protection.outlook.com [52.103.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37281606A320;
	Thu, 19 Nov 2026 14:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37281606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=LIQSNrog
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt74iKoVywHLEg248GkDzJzA9Kv82a9i/7REANMEI9hthJx992mmVq5U2YqI0+WAupjpWDo0J7GQGDzbeqsM03joyh4SsB2ev4cNv66jrtfdzhTTokNDqmANNUgo/osbSkDdjg5Fk62BZCnN9hrJl5fWec0j+02MeP8y77yXz8EOPFnPE+E/uvdJDnGr4uQv8U/1hSOo4OfvU1fDJcUgWaQMGiBXI2vPEUeantTBVp7Bbzvo622+jop98Ef55DAi60TKmJ708v8/+8cOy1sXhhfoLIMQ1UaGZhs1BbqXLAM0bjh+oSMpnI6jsh1xGwrb4KMCSt5N+2wh4UZ1MAne6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOXu3MlYJcdInDMM07pFpWpad3f+8aMREayAOb1Fexo=;
 b=yxcKg8+6aAAYhPS7dZsmoKuNXJXigPl8NrK1u+dfbke44kDwZkKLxqc4FWU+1kXlMUX77A9gRAlUiU8W4Nd9irhvMw/0HsU1WcHFs1q85aRGEq9sSBV4qMQ6Y+liS8nUP9eobL6fTuBvRJkWKpDEdbKRjzU26SOLBWF+hIOlFiQDg3Af0PcwWWeJUj+nr1m4X6VOPPgjpsRFLIKHKWAvO98U5bAMnVq48aeR7tLhDB11G8gazREh6LsDmalF63sv3dRJZ1j/wfOaprj6NBmyUF1V4GjaHuDog62Lia+wtItYq4oY1N7jCRlDoSYpiVq3aimk/YwDd+j0PsdMhAi/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOXu3MlYJcdInDMM07pFpWpad3f+8aMREayAOb1Fexo=;
 b=LIQSNrogkkgZYSEALPmkw0WWPUlQSUuoO0Hc30MvWw1NPlv49SKK/K7CwuPlGgffozKuLbF0x1rmbuAeVNIkppmexxo82KYmQ7jEQ/wyitNGINt4oNx4Tj7JWpwV2S3s/R0XYeJUn5YPFKFLxBMKZRmfCsYZ2jAYpw30+ti0U3gAbDkfjGE2Qe3JI8E4uj86/5dEw6qx312fwl5RsnEoDsDWz7sQvaK6SoHYAy2bBu81SGFIw8BjdWble0+I/NTe6IvEDGleUro5DVzUECTFlLQP2CHjs2V/7j9cn0RT0IXyFHhjUAau3fU5G2VJ23z3MMfCmO4KrrFEyH7hUFl6Zw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB109571.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:35:44 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:35:44 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v2 0/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v2 0/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdeDNC0Wai4ZqXQU+4lsOjqgGk1Q==
Date: Thu, 19 Nov 2026 14:35:44 +0000
Message-ID: <cover.1795097970.git.habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB109571:EE_
x-ms-office365-filtering-correlation-id: 5c27fd43-45f0-4d9a-1d80-08df464a6527
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYAYx1xXrBLUWTP0Nof2HmseO+bytHNCERID3FT5K8qNNxqMXrn+prUqA4NJ8l5tiFc0Uo5npFV96aBQF+xkk+pMY7enW9du4tMzEbbBGSwR+iqBE7moKLp+W2+M9nRYB8g9PEU4pl7x/P6FEbYHL6rQ25PgbxI2OSGXBgX2eehxbZPdAsxK5puQVqeHmTDX3QZFy8E64+ngYsHk4RclIGhRVvtf6kPHri+wyrwcbClFGoLNFX2uFr3uy1PK1B+xJyBbbkaT1atQhCBWq7osp2XE8XmBMKinzCDReZnWeRcUoWOlcUAo8QJvD8+Jmu9hjf/cWFQCPyfNydWYfiLKV602Zzi2JnSh0IhCN5ebhBfH8vCyYnFPajP4ntWb1438T5z1mx5sGjH+zf3Znasn6elkiYvmwh4f2SfLPXcmwJScTtaF3F0XIN5KJRIkoMKODijfpN8q1L7IQcZsuVgt/MvdTzZauZLw5srIJiSa6ZMtOD+ItwnS4FibXYVDz4itoi896rFkU9kprpCuNrdtv3iLjTUa3AF65+6ZUSjqBLThLrlc//td64PLFvzn4aOKiqvmSH4gVYO8j0X5aW/bC1T5Q44wQNHBNLnpf0JdzVYuwQea849ayJFF1pIl27RcQPGu6anIAc7MHvU2XFAMWu9BG1J9Qy0NLqOmrlEay04N2K/5OVAMOtNX/tIIMULNTuwUpFZ9qHuXud3IH8LShQDaaoUDDNYKyNLC5jV0uRJCTTQ1X8dAVp0O1tQVygVR0GSarspYa1dIhDZP6RvLwxLPCM6uHcGUOA8Xhn/Hgaa7M6z5mbnCGsNUwFJ96Daasg3X0ZEURW/rNw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|51005399006|25010399006|24021099003|55001999006|8060799015|38102599003|31061999003|12121999013|41001999006|15080799012|5062599005|1602099012|10035399007|40105399003|102099032|4302099013|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDJYdjc1QUs3ZkNQYkZVQjFLUDdsZDBZU3RPVnpUdTNZeHFDS3pGQ2FvblM3?=
 =?utf-8?B?aDVLY1FMYU5GVXYzRyttZEVKQVFSLzNmVEJKM2pTdTFHanFuRXpjR2FXN1FK?=
 =?utf-8?B?a09mZm1GMEtrRmRnZGJXRjhGaU84Yy83cnlGZ1ZmdGF3VlR3Nkc3bE9ITVVk?=
 =?utf-8?B?a25vUlp6WS9QZW80MEo3SWdmWFZ3L2tQZ25lRjNKa1VSeGFJNExHQVNNeDh1?=
 =?utf-8?B?ZDg3akZoMG51RjhidFY5Szk4eldXa1hzd0hTd2NyUGZ4dWkzWEtKUHFnTlFK?=
 =?utf-8?B?NVNpRmVUbzhIazV6RkNiRTZXRm0wR1haK3psdENkdmVWN1MvVFJ1YXRWYmdt?=
 =?utf-8?B?WlNIWGgxalpmZEI5RGJpVm9rS0dPVXV1NjRNQ0VlN0JKNmkrSEM2bWFwZVBn?=
 =?utf-8?B?K1NwdEpUS1RkU1E2amtRTGQ3cUE3dFFXVXR5cjdLT1FQR1NZUEJHeFFXM0s5?=
 =?utf-8?B?bDArVHB0ZURuckREcEdZUXRLZDV2ZmRnOVFCY2hOMTRBWDZMTjUyVEt5dlhM?=
 =?utf-8?B?V3dqMVh0MTdrM09mSm5JcE8zWEFxVUFuNm5Ka1RDVkNtanZHTFB0VE1xTHJM?=
 =?utf-8?B?UUcyYUNqOUlnbStxWCtVRnpOY2M0amI5UVk4eFYzL0wva2lPcHowUFhva0pP?=
 =?utf-8?B?Skd3V2Exb2xOMW01WTNKNWl3TnVYWkU4WW1haEw4enR0Nk5FSGU4eElGZzhG?=
 =?utf-8?B?SzNPWmFqNGtxOFgrOHdMWnNCZGZ0YU9IRU1hdUd1KytuU0tTWTlYYTdlNlV2?=
 =?utf-8?B?QTVMOG1YWEJabVhUWU5BRlVZWFF1eWNyZlZiUnBHK0lSM1d5Vzl2cFJsRlJC?=
 =?utf-8?B?ek1CM08yMzNCaHBDTGNYclJnSFEycm16Z0tzb2ZVNWY1aG9BZjc1T1VuWVkr?=
 =?utf-8?B?TVhscm9IbHpvQTJLa09yT2xidVZrdzJQWjZ5WnBJdmRTVDBQZjM5SFVJa0xh?=
 =?utf-8?B?bEQ5b1h5U3RScEdnZHRXdmJuMXpaTGREVUxhRHJxMG1IL0dOdEsrRTJ3TTAr?=
 =?utf-8?B?MzRQbThXMDJXTXFIR1hFbUJ4dTZZUFJ6dTROV3JpRzk3RGZGR0JaQTFuM21J?=
 =?utf-8?B?Q2hESVFya0R0RnU1K3NLVUMzVVpNeUEvLzFEbXdGU3AyQUN3aGh3akZYenRv?=
 =?utf-8?B?dFNLeHlmYXF2eGQ0MGsvYVFRQ0tFWm5DenMxcHVmTEFhQTRxVlJvY2hxaU5s?=
 =?utf-8?B?d0NvRmp6WEt4QTJLdHViaHRHRDJadm9KRU93RUdLR1dzN1lKRVcwNVkyWGtX?=
 =?utf-8?B?OVpaanc2bWxvbmdtTWg4TTdqajcxNFhja3ZOdkl3NEUvOHBKTE1NZkZGNEhO?=
 =?utf-8?B?QktWaFRhaGRJK2ZycEYxa3pMU2lwZlM1V083VlZVajVBaU1rbjZFYURFWkcy?=
 =?utf-8?B?RDFUMlY5VTBIOUZ5YmJ2eGRjRkg3c0U1Y1NMVHNnRUJaK21xbjdVdWlLdTJu?=
 =?utf-8?B?K2Y4bSsxeWo2d05Yd3pGTUliUmliUVpGZmRyM1ZRUkM0YzZvOEE3eGIzWVdt?=
 =?utf-8?B?L1M0clVEVERFcGk1Yy9pdGJxTm9odC9uZGVtV2lFMmRkSGlIakFmRmxCMmVP?=
 =?utf-8?Q?WBUxXhrZusH92zlAwrfdoIRgI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWRrbk9ETHY3Vi85dzVmNmVhY1YrYStuN3dVMDFLQk16MkJQVXhNZFQyVHBh?=
 =?utf-8?B?NVNMdDNybWRrcUN3Z0ZVU1ZxRitXV203MDhoSmFpM1BweFBjRVFSMlpad1dD?=
 =?utf-8?B?STNtbkxBVUdUNTZ5bHBia0pPZDFRWGFjeXljMWRTMFUwblBSTTY0UXMyKzBo?=
 =?utf-8?B?aDBDOFArMHlHWitlc1NxemppSkk2dE52Z2ZTaUs2d2hFSjluQXdiclErWE9F?=
 =?utf-8?B?Q2VvdEZadkZXWjJtYjk1SytJdCt1R1Z4Ym5lU3R5cFhoNDl0SndNK2wyS0Nu?=
 =?utf-8?B?Tnh4VW9iejdUWnRhQUJJYno5cjhPVXFtWmxjNGxoT0lvU2VoU1Q2RlgxZ2cw?=
 =?utf-8?B?V2xkakxFU0dEelFHTlJuTVFCUE04SUhOVnM5RW1hblltWlo1cnFPK2dvVklE?=
 =?utf-8?B?MVRXUmw0MEdZS2hYYlJpMnNONVNkcDJxYU4zTUgyVmdjekJ1YS9EZUJ0WXNW?=
 =?utf-8?B?NUN4MitUNTJIUUpWdm04bHVra1BYYWVrQU9BLzlPemJBZk51MmVuYlBXeCsy?=
 =?utf-8?B?ZWVRM1FybWlLUDRaMjJTbGorZHRyT1EzZWpRVHgxUTNEVHNGbXYwb2JxWlhS?=
 =?utf-8?B?bWNrdXRIY0F6Szd4d1cvbTE4d3dndnAwNHlKTjYwb3ZmV1hQOW5pL2RPUHhN?=
 =?utf-8?B?QU1CZWY3OGFXSEd1U3N3ejFCUVl6VFdEcUNuVEY4WVEwMExhZkZqRFk3VGpv?=
 =?utf-8?B?SW91ZkczQTcrRkVBOWVZeUt5VFFNOE5aOEprQjBoTm1oWm4vSUNPZUZCVm5p?=
 =?utf-8?B?TTU1dldZRlZYamdxTWxNMmpncGtrN3Fyb0RPWFVUTmdyYVo3UUQvdlhSSDNE?=
 =?utf-8?B?bStycklWNTc0MDlxeUpVMzMxQTJYVkg1bGl4OW41Rk5zc1ZJUWpiK2xiRXVN?=
 =?utf-8?B?a2swSjFYV0dwZ29aRER0cHhCZjBTaFI0QWJnL3RtWUZ6RmJoWCtGdG9LMjdK?=
 =?utf-8?B?dHArMmdPRm5TRS9QMG5xYW15WTFseDczbjFoSndSNndWRDBQSFFSTURlRU1B?=
 =?utf-8?B?dm9JK2xmeHN3QVYrVkY2VEtsNzJiWUlkejgwNkhxeC9nK2JsYXM5SVZFRk1C?=
 =?utf-8?B?N3IvT3FDY043RlgySlNJcjV3bWxDLy9lekVBdVFML0JiRVozUVhyYTVyTUQ5?=
 =?utf-8?B?NCt1WjVZZnRWbzFXNDBmQitYbFJ5UVE4UThsdWg2TU5PT0tBSFcxR3pvQzBx?=
 =?utf-8?B?N0RvZERUbXB4TUdsano3VlZlbTBuOTdHR1dpeG9LK3NDZVRaQ24reGVWUDdL?=
 =?utf-8?B?dVBLVjZxdW4wVCtVd25pcVh0VWNrZUljWVlqQ1YxMWxGc1R2RU1wa2hhWHVD?=
 =?utf-8?B?R2ZNMFNTSVBCT2x5clR1MXAzNm01NFZ4Wjd5ZUd3WHNlY0xFZVNaYjVFZEI1?=
 =?utf-8?B?ZHJmRExTWGFLa2RnR1F6NjZBbVNUR0VydEhEck5KcldIeWFNVXN2RUI1ZVZZ?=
 =?utf-8?B?SVZjb1plSEtEMmJtejFDYS80NEFRR0hYOU1YeEQrSXc2UW1CeWYvZExvSTFn?=
 =?utf-8?B?b0VLMllLbjIyQ2RRNHlPRmRzd3RCQ0lSN1pLZytwZ2d5OW5XK1g1U1NNbUJD?=
 =?utf-8?B?dnR5VUNUZEk5eWdMUXJmbGxpeVhGczh2bFZDZmYyWTFKaHdnRkhSRi9oQ2hQ?=
 =?utf-8?B?ZjVGRVBOYU91Nm1CeGYxSXFCSTVaNWRiRnFoTGIrN08yWm50YzgvVTVQcUV6?=
 =?utf-8?B?Unk4R3VrQUI4MVJUM2UyWXBvRVVVVmY3b3lSZkFIVlV4V3BQTktld3YxRllZ?=
 =?utf-8?B?azdTYm44VGVlNG5rakxXOGw0N3FhYnFTVndlSUNmSHFnWndwWlhyVHQzSEFU?=
 =?utf-8?B?TEJqZ0RVa0ZtR1lmclJvR3g0dlF4YUQ4RXZ1T0w2bnViS0xDMzBPL0d6blpj?=
 =?utf-8?Q?PujiZ7qgipU+u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <229C4CFEFC6BE942B44E0EAB4A2FC80F@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c27fd43-45f0-4d9a-1d80-08df464a6527
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:35:44.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB109571

VGhpcyBzZXJpZXMgaW50cm9kdWNlcyBoZWxwZXIgZnVuY3Rpb25zIGZvciBhY2Nlc3NpbmcgUENJ
IHBvd2VyCnN0YXRlcyBpbiB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyByZWdp
c3RlciBhbmQKY29udmVydHMgZXhpc3RpbmcgUE1DU1IgYWNjZXNzZXMgdG8gdXNlIHRoZXNlIGhl
bHBlcnMuCgpUaGUgaGVscGVycyBwcm92aWRlIHR5cGVkIGFjY2VzcyB0byB0aGUgUENJIHBvd2Vy
IHN0YXRlIGZpZWxkLAppbmNsdWRpbmcgZXh0cmFjdGlvbiwgc2V0dGluZywgYW5kIGNvbXBhcmlz
b24gb3BlcmF0aW9ucy4KVGhlIHNlcmllcyBhbHNvIHVwZGF0ZXMgdGhlIEFwcGxlIEFpcnBvcnQg
cmVzZXQgcXVpcmsgdG8gdXNlCnRoZSBuZXcgY29tcGFyaXNvbiBoZWxwZXIuCgoqKlNjb3BlKioK
ClRoaXMgc2VyaWVzIGZvY3VzZXMgb24gb3BlcmF0aW9ucyBpbnZvbHZpbmcgcmF3IFBDSSBQTUNT
Ugp2YWx1ZXMuIENvbXBhcmlzb25zIGJldHdlZW4gdmFsdWVzIGFscmVhZHkgdHlwZWQgYXMKYHBj
aV9wb3dlcl90YCBhcmUgaW50ZW50aW9uYWxseSBsZWZ0IHVuY2hhbmdlZCwgYXMgdGhleSBkbwpu
b3QgaW52b2x2ZSByYXcgcmVnaXN0ZXIgdmFsdWVzLgoKSWYgdGhlcmUgaXMgaW50ZXJlc3QgaW4g
aW50cm9kdWNpbmcgYSBzZXBhcmF0ZSBzZXQgb2YKaGVscGVycyBmb3IgY29tcGFyaXNvbnMgYmV0
d2VlbiBgcGNpX3Bvd2VyX3RgIHZhbHVlcywgSSBjYW4KcHJlcGFyZSB0aGF0IGFzIGEgZm9sbG93
LXVwIHNlcmllcy4KClRoZSBjaGFuZ2VzIGZvbGxvdyB0aGUgZGlzY3Vzc2lvbiB3aXRoIEFuZHkg
U2hldmNoZW5rbyBhbmQKQmpvcm4gSGVsZ2FhcyBpbiByZXNwb25zZSB0byB0aGUgb3JpZ2luYWwg
QXBwbGUgQWlycG9ydCBxdWlyawpwYXRjaC4KCkNoYW5nZXMgaW4gdjI6Ci0gQWRkIGhlbHBlcnMg
Zm9yIGNvbXBhcmluZyBQQ0kgcG93ZXIgc3RhdGVzLgotIENvbnZlcnQgUENJIGNvcmUgYW5kIHF1
aXJrIGNvZGUgdG8gdXNlIHRoZSBuZXcgaGVscGVycy4KLSBBZGRyZXNzIHJldmlldyBmZWVkYmFj
ay4KClRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIGZvbGxvd2luZyB0aGUg
b3JpZ2luYWwKQXBwbGUgQWlycG9ydCBxdWlyayBwYXRjaDoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI2MTExODE2MTU1OS42MzYxNy0xLWhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNv
bS8KCkxMTSBhc3Npc3RhbmNlIHdhcyB1c2VkIGZvciBlZGl0aW5nIHRoZSBjb3ZlciBsZXR0ZXIg
YW5kIGNvbW1pdApkZXNjcmlwdGlvbnMuIEFsbCBjaGFuZ2VzIHdlcmUgcmV2aWV3ZWQgYnkgdGhl
IHN1Ym1pdHRlci4KCkhhYmlsIEVyZW4gVMO8cmtlciAoNCk6CiAgUENJOiBBZGQgcGNpX3Bvd2Vy
X3QgaGVscGVyIGZ1bmN0aW9ucwogIFBDSTogQ29udmVydCBwY2kuYyB0byBwY2lfcG93ZXJfdCBo
ZWxwZXJzCiAgUENJOiBDb252ZXJ0IHF1aXJrcy5jIHRvIHBjaV9wb3dlcl90IGhlbHBlcnMKICB4
ODYvcXVpcmtzOiBVc2UgcGNpX3Bvd2VyX2VxKCkgaW4gYXBwbGVfYWlycG9ydF9yZXNldCgpCgog
YXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIHwgIDYgKysrLS0tCiBkcml2ZXJzL3BjaS9w
Y2kuYyAgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogZHJpdmVy
cy9wY2kvcXVpcmtzLmMgICAgICAgICAgIHwgIDIgKy0KIGluY2x1ZGUvbGludXgvcGNpLmggICAg
ICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgNDMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IGMwNTRm
Y2NmZmY3YmExYWQ5ZDg5MTM5MjFmNWE5NTJiYjMyNTEzY2QKLS0gCjIuNDcuMwoK
