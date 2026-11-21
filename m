Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795266755;
	b=OTct8fMHyVRQvKi2yKvDRm4ZQtTawzAYoxwlkRrXfiLGUzX8wg0ebq7jYHkWvAFlXqeR
	 2YqiOoziUUd9/YvRHTCDNfqSHk2chfugBaYBQM7zKsCFv1iRUkh3/hQrBQjxP5p5inoEt
	 uC39iKOxZzQ5+OQDUPgapKe4QGJiwZgwWtH+Xuz9GP3vamW4REcRk/awq02j30TlGDrz0
	 muTRdGhXKfynEeK0djdDUuPPNwDMq8My2mPb+HZLBGBcY60W7HhW25nxjZoToEuY/CcYg
	 0wwNCGeWGU1dm8sjjVuwnCTUDshpyltrktodnKWNIhwdwi9+JREdiYj186x2IiSpjJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266755;
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
	bh=Xf1C16mVJgIFlQRzmaQgW7RWW+ZYmZJAFvlXoEiDjWE=;
	b=ZLPYugjfiKXsruy5lik1mJjGtbpkmCXSa0pqApbPyFDT/S/Dyv/wQQ3McDl3Nns6XuOW
	 h23VpvxQNg8PsOLAn3RmGnyYTtV9U1fHaEqYFWLnUJ818t0sAIIUhHeukO5+vyKCQywG5
	 b8LKx74/zi9bCERqcMY20txMZLtH5syhpF7GdZxSxDA0+3qUuFoNLEMRlnTfGnGqMgc6B
	 lD0vfVOA2/C0DFbTMaWoeh96D/PYSX6zyT0WOA1DBDRarfoMXPQpPokz56SqggV4sGNlf
	 Uv9sH2y03NY/N3obdF0kiRQ908zJdu+mZFx+uye4uvS1BMIVM+8KpyMyfkq0KVpEK5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=oRatlOHD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.34
Received: from WA1P291CU003.outbound.protection.outlook.com (mail-polandcentralazolkn19011034.outbound.protection.outlook.com [52.103.53.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDC606A685;
	Sat, 21 Nov 2026 13:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BDC606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=oRatlOHD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkRUuwGKOxVWWz0/6bJOFsJHDKzfCqB8Lx8icr8A4vm2BFgIbH5juu+/mvSP4NolPLU+pg5L52InHlyXlsj9ZTfpKlNDckxIIv1Edi5HctENAibKPHU3xoH/6s6ziPoCzEv3yr4NR5aKVGtFVSP8V8AANXAon+e0K2ScZiMmbGL1ZwlTWidsQsa3bRkGcb87MxUC7vyiO/agZ+a6z7t81aJK5L1Vq3bnSgw5BbvmJJwVBTyVjvk33LYZKW13HrWux33pSb9xuXQeq7LnqxRlvUd9821mVbZW8yPR8VOmj3x/eZF+G7SpkovX1txERxvxwjLqsFL3w5tXI7vtMjtr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf1C16mVJgIFlQRzmaQgW7RWW+ZYmZJAFvlXoEiDjWE=;
 b=mLwweRbSi3BzLNXP89/w9kmiUeJDHTfGQnIECb5IPN5H3K11ulgHpB+sM6EmCgzFztwYP0L0Z+VEognOVGLZrlHewMHuUf0BSJlkJ4NPllCr36idJMjHNfrfYNjS6VsbYIPT7fgib3BawkSWQi9Rg/98SbrDXtaRq7U1w2911IZuAbT3+ooJ9e3VWA2D4Hs+oXlPBA6We+/Y63lnCG+bp9KmsMnqJ6gL83M+nm9gUR/bVuE6fviW9iFgGXrAXZmpoHCofHQ7t535UWvDIxem4ARbQru85Co8KcBLvfgLWi5MI60QLNdZfSJJpPgMj16ZI4isCoHBhr+r6zyIH147Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf1C16mVJgIFlQRzmaQgW7RWW+ZYmZJAFvlXoEiDjWE=;
 b=oRatlOHDK2EnD36V0i1+A0wjssDp4tonPXxu3gl3ZRpj1mfTa8BlTlC8oggoMoHUapZdF6CATLSdpgujW5st9atDTGpYeFjHtNuD02v9xMS11GbPWUdzHFepqDZAKiKIXje07TEXJ7AIq1hCkSIgMQx4l8Y516QaHF2+k53NEEM/xFpbZy/UfaqkszdhipHNaGMKp6PIW1gRZ1ygVHl2VxYEiiw899K4DaU0ncFmZYbT+twAYHyOmHvkdIaY7cPeW3LhmuMSNAJnWGXEEqUyxLwfA1zTwRILe4no4X+o0HaNB+5KvSekzqcep+MAfIhEq7TWSviXmMqpjGF8qpMfgw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0097.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Sat, 21 Nov 2026 13:12:32 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 13:12:32 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v4 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v4 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdebn37S+bh8aXN0+hDPburqh/ag==
Date: Sat, 21 Nov 2026 13:12:32 +0000
Message-ID: <20261121130936.53191-3-habilerenturker@hotmail.com>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
In-Reply-To: <20261121130936.53191-2-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0097:EE_
x-ms-office365-filtering-correlation-id: b4a384e0-9241-477a-1876-08df47d11a1f
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|41001999006|15080799012|8062599012|8060799015|19110799012|31061999003|2604032031799003|55001999006|24021099003|16051099003|25010399006|51005399006|102099032|440099028|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVBsVGxoSTU5NTlaUnV5eXdZSE5FT3luenpxTXNmZzhvNzR6TlhqYkNkQUly?=
 =?utf-8?B?VEZYNU9sVEFhNW90YWRicWg5SVZsL1c4VjZkNHlaTFlZNG5LTkJMclZoSkE4?=
 =?utf-8?B?QVhXNXhlK1M0Y2tyTnVSZEZCbEhGTGRiYVErOW8vUUhuVVhUbllEN1VmY0Rx?=
 =?utf-8?B?bXRxaERCNEN2K2dsMVQ2bVptbWNnSkg5MDZXNDVDSnlhT0s2MUlVN0oxeDZ0?=
 =?utf-8?B?M2REZlZJblh0ZXE1L3g0WmNhZWJnaFF0SXFIaDZMcWVxQzQ0dWhJZGRJRWVw?=
 =?utf-8?B?OUdaalZDWk4yeW52NVVqdUhZVHRiRHZMZ3dZYTkwY1drUktVYnVwZHpPOFEv?=
 =?utf-8?B?YlJHa2grYmY1YXhoM2lUalNKNzZkLy94TU1GZk96OVgzQjJjUjdWUHJ5YnZS?=
 =?utf-8?B?K3Z0TnRKVGpZSWZ1R2tEMUtxcnJpeU5lcTNMSmFBY2crMlJ1NUZ5dG4zcnZp?=
 =?utf-8?B?R0pXU2JXd2RmZ29jNEt2bTNjUXpuN3RvMC9IUWsrVHI4VE1NcmgzdlM1VTlv?=
 =?utf-8?B?K2lYZitYdHAxbG5nM0FxTEpVYXJubllJenVnbmpFa2tvQlI5WWNuS1hyREEw?=
 =?utf-8?B?cE44WkNZQmF0eWVUL1M5K0tpdkFZdU5kUy9abkpDNzVoejBVUjBJS2pEZkNx?=
 =?utf-8?B?dCs1cCs3RFp1cmZSa0NQeXBRMHU5N29HTk90NlhRaldvZ2pUNVB4M0hqQ3N4?=
 =?utf-8?B?MU1NOTkxVnYxa2hPVWh1ME1xSTFSbDcvdFN0NDQ2WGY3R2FNRDgvMXFRTzhV?=
 =?utf-8?B?TmdTWHRnL0tGNC9ma2tIRzJyV2VWRlBZeUNLS3c3TEVsSjdJcEcxcWFudVhn?=
 =?utf-8?B?dHRWbXdabW50dE9nK3hRZDBmdG5tQXJJL2lwRGRJOWZUcnlLSkM3OWFUWG5F?=
 =?utf-8?B?aDR4T3NEWWdwRTh6SHpFbG1TbnYvSkwzVXF1Qys4RUJwVlFPSTE5aE4wNTJh?=
 =?utf-8?B?QkVvWnVSb2w3dmh3V3BQaFVUSTYzUGhEaFN6MzlVMjBsYVV0dUtuU3N4VW1G?=
 =?utf-8?B?YVlCM1VlTHpCZFNYMHZGNWRsTXBDTEFGRU80bG5uZzFMaS9WcW5ETkVTNEQ3?=
 =?utf-8?B?ZFltd2NuemdnWDlCNXB5OXVwRy9JUHMvR3VKQXkxbDdGaUhmTWNlRWgwOXZ2?=
 =?utf-8?B?c2YrSXI2cFdRZFZEUExTSi9LRmRVbm5mVHgwbEs2cDErYzVSOXg3c2pVQktE?=
 =?utf-8?B?UkNMTFNMdkkrcDgyNXhJTVRZL0ZVOXlRWlRFVTRrTHVUcSttR3lyWDZwZjhF?=
 =?utf-8?B?N3FjUHFEdVcrNTBtcldVeVJVd3V0TWZ3aS9selV0NEJURS9kdjM5WnVZYlVC?=
 =?utf-8?B?L2JMRHh3N2lZdzJhTXdqRTBqZ0JHbmIreXM4TmsrZk1EY2FoSVNpRW9sOTVr?=
 =?utf-8?B?R20xczJoVTh5Q3FHMU9vdndEQUREOThXY2I2SFVLL3pqOHVXb25DSUxxbVNo?=
 =?utf-8?B?bjNWQWFLWS9sRHVtV0l2dVFkU0FndGIrNUx2L0NnQlo3UXZBbHU4cVY2b002?=
 =?utf-8?B?Um1nclZ1N3p1UkVjVjBPWDF2a3A2eU94YTgwQWtvU2wyTkJGRUFYZkRmR3Y1?=
 =?utf-8?B?Nit6UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2xPbXQwQkFrQlRSckJLZUJTc3d0a0xqR3FJTlNmYjFOWlYwZlY2VFpMY3dW?=
 =?utf-8?B?RW9WdGhIcFZMUzFhK0JnRU8zM2grcXNWenZsOUd2ZEg5R2VQcEh5aFNSdllJ?=
 =?utf-8?B?RW1QTzRkVm5SeWs3ZmFxREsyYWhwQVA0WUptS082SG1YZkVCM2RPS3c0YXUr?=
 =?utf-8?B?V2wwZE5IMDFmM00wZGswRHdFZTAzQTVjSmhET2Z3QS85QXpiMW9YUFJhRXJr?=
 =?utf-8?B?a0YxUFZlWkdjemtIQWwreUw5aklzdVV2TzdBSTRrUVNvVURCZG5mQ0FjZXFq?=
 =?utf-8?B?MnJZUThzRktFNTQvZHMveVJYWjludFQvUUV6dnYvWTJEVG85eTM5eWo4R3Bp?=
 =?utf-8?B?T1B0YUJ0M2t1T3lGWXNGdmVyV1AzbENETnFzeFlNUjNDSFdZV1NrVE1Fb29x?=
 =?utf-8?B?Y3ZRQzJCRlN0OEtia3hxTVNQanpsN2o2UmlOYS9UREEvTUpJSGxtUUJISXd2?=
 =?utf-8?B?U2JQK1FUYjNwNW45bUlwbGh4M2ZsUDB2Zkc0ZG9nSWNWemo1TStXTEFlRDNq?=
 =?utf-8?B?bDNZeS9tMU5jYkZrVjM4cHVMUnNQVGFOMUF5MHJoUUJxNnZCNkprbk5CaTFQ?=
 =?utf-8?B?MGdEZllYTmd0ZlNGRW9UV21jQmNrM3Z6N3BkZjYvckpjTUpUQW94Y0szcFE4?=
 =?utf-8?B?S1Y1b3NwU3dCdzNUU2VRdjdQK1N3V0sxRnFIdGFVWXFzTFBvWVlSVGpNUUlX?=
 =?utf-8?B?d3N1OWQ5SmxYaTJGTXhZN2V6cVlWQzhBSWxybGlBZU5LWUd3cmpBYTlWUWhS?=
 =?utf-8?B?WkxXWmhNMUhOV3c1b0U0b01xZlpiRzRWczRXa25XNjAwa2hJL002ZXAzUGhm?=
 =?utf-8?B?bzZZdFNNL2NVSjZUd0Uvd2MzSXJqSEtVajJWd3plR3pzN21xT1VQSDhSRjUx?=
 =?utf-8?B?K2hNaWtBaGRFV1MvcWxCNUhZd2w2REQ3c3kwekp6SzYyN1BnQUQvQ21LVHZs?=
 =?utf-8?B?Z1hlcER0MGNKbHNBc2gzcHA2ZXJhdTh5K2RENjNUL1hqRmgrYUhxWlI1RTJy?=
 =?utf-8?B?dFVsSE5ReHNwaWNCNE1xaVdBVEM3OGZzVnVVWHB3c0NSL3NpSW0vUGhxMk5V?=
 =?utf-8?B?cys0WjRnNEppTlRuc1l0ZzdVUjhWeGw4MjdHWFo1V1o3ekljTTV5cFF5S1hM?=
 =?utf-8?B?bUwxUXNjZUY1bnlabSs1dmw3bU9wQ0wrV01lbWxYZnpVdkVpTWRxdEdOb0pG?=
 =?utf-8?B?V0NzQTR1Wm5TUXgveHlzZ2JwcmVpU25EU2xUbCtiVTQ4T2lmVTNYUWZHYk55?=
 =?utf-8?B?Si9ESDBMNUl6WWVzaGhaRHBPeUVTWFRTTjBENmJsMHRGbzg3SXk4ODhVcE10?=
 =?utf-8?B?QjBqQ2FtdEpxeTliYXRBcDNuZ1dLNmVTZHhHcVV4M3FqMVYxYWtRQ0x6WFVC?=
 =?utf-8?B?Zm9rK1pVcnY5VS9HWCt1TUwyZnpMNVRCbGFNZzVBVDJRa2R3Z3h4aTdRdWJU?=
 =?utf-8?B?dGpDdUo1K2NYUkhCNDFLTzRRZThYWCt1c2pFRndrY0lqTHFkazhGMHEyOTh0?=
 =?utf-8?B?Z0pMQ0hPdFlVMXg2VE5jNVVEdG5QbUpmbEx3eitJZGZSNFpndnB6ZGFqNlFv?=
 =?utf-8?B?ZkI5emZ1cXJOTzdTOHdVVmRhKzU1cWpJNHNmb0QvZHZTMWEzQlA5WXhhd241?=
 =?utf-8?B?SEU2d2hoWGJGa0Q2dmszYWIzVU44UXJiblZKSGlack0xSmlFSUhSTFA5TENR?=
 =?utf-8?B?NEFqc01FdFdmRG4wbVBadHZLUlNDU0JNZGM2OE1hVG1WbFVJODQ4bHZKZE9F?=
 =?utf-8?B?elBHamxlVDMxTnZWTVA5WjNiaktIMlNJM1ZuZHVvOC9Rb1pQSVpZaEZVM2Qy?=
 =?utf-8?B?RGhVRmtacmN2ZUg2YlJieUFWenhyVlZsYkxqMTU2b2RMYWkxZmhETHA3dkg4?=
 =?utf-8?Q?Yj9ll3NIZvxA7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A098A7ACB400D741A25D6761DBE3ABDA@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a384e0-9241-477a-1876-08df47d11a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 13:12:32.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0097

QWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gZXh0cmFjdCwgc2V0IGFuZCBjb21wYXJlIFBDSSBwb3dl
cgpzdGF0ZXMgaW4gdGhlIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbC9TdGF0dXMgcmVnaXN0ZXIu
CgpTaWduZWQtb2ZmLWJ5OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3Rt
YWlsLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3BjaS5oIHwgMTcgKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKaW5kZXggYWEzNzY1YTIwYTk2Li5iZmFm
ZjBlYTZjMmQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9wY2kuaApAQCAtNDAsNiArNDAsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2lvLmg+CiAjaW5j
bHVkZSA8bGludXgvcmVzb3VyY2VfZXh0Lmg+CiAjaW5jbHVkZSA8bGludXgvbXNpX2FwaS5oPgor
I2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+CiAjaW5jbHVkZSA8dWFwaS9saW51eC9wY2kuaD4K
IAogI2luY2x1ZGUgPGxpbnV4L3BjaV9pZHMuaD4KQEAgLTIwMCw2ICsyMDEsMjIgQEAgc3RhdGlj
IGlubGluZSBjb25zdCBjaGFyICpwY2lfcG93ZXJfbmFtZShwY2lfcG93ZXJfdCBzdGF0ZSkKIAly
ZXR1cm4gcGNpX3Bvd2VyX25hbWVzWzEgKyAoX19mb3JjZSBpbnQpIHN0YXRlXTsKIH0KIAorLyog
SGVscGVyIGZ1bmN0aW9ucyBmb3IgUENJIHBvd2VyIG1hbmFnZW1lbnQgKi8KK3N0YXRpYyBpbmxp
bmUgcGNpX3Bvd2VyX3QgcGNpX3Bvd2VyX3RfZ2V0KHUxNiBjc3IpCit7CisJcmV0dXJuIChwY2lf
cG93ZXJfdCBfX2ZvcmNlKUZJRUxEX0dFVChQQ0lfUE1fQ1RSTF9TVEFURV9NQVNLLCBjc3IpOwor
fQorCitzdGF0aWMgaW5saW5lIHZvaWQgcGNpX3Bvd2VyX3Rfc2V0KHUxNiAqY3NyLCBwY2lfcG93
ZXJfdCBzdGF0ZSkKK3sKKwlGSUVMRF9NT0RJRlkoUENJX1BNX0NUUkxfU1RBVEVfTUFTSywgY3Ny
LCAoX19mb3JjZSB1MTYpc3RhdGUpOworfQorCitzdGF0aWMgaW5saW5lIGJvb2wgcGNpX3Bvd2Vy
X3RfZXEocGNpX3Bvd2VyX3Qgc3RhdGVfYSwgcGNpX3Bvd2VyX3Qgc3RhdGVfYikKK3sKKwlyZXR1
cm4gc3RhdGVfYSA9PSBzdGF0ZV9iOworfQorCiAvKioKICAqIHR5cGVkZWYgcGNpX2NoYW5uZWxf
c3RhdGVfdAogICoKLS0gCjIuNDcuMwoK
