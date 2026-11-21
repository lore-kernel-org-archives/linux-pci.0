Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265960;
	b=efc3f5giMJIN9QnLlWKPfp5BysUpJsqhmVmXm5CghGoGA9EjYGMhOlp79caf/jOlcz5b
	 p30sXsG4rlvsG8HtKRYYctWdG41tuA7Xu5DZVqnKgj4lB//7VVklAgBHOGWxBmvmu5q5+
	 guQ5qSGRAiNjK6OXiZvoz81yc+0n0klKaZkmWLs725IH9dmBqW8Q8U/6/tTSxUuZd02e1
	 hPxDjsFYFElz//atu5/HSi3ZU8BwSkelLA7BlbUtV7R2lvNL3apYqY36b9Qa5sc6XwGQg
	 8eEnzBNvGrl1Cb1gn1lyrRINN/CgG5mDDPhuB/DTvYeKaT0M1ZdeiAgkpaLsx9gV29w==
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
	bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
	b=vC/ZqDDjANc+jjom9X4PNcD1nQPK/EiQcyj2TKmUCJjopRi5vV/0N2N3fraKb7VAaMSQ
	 55nPXT6tNrNTC0MQTSlyO8ykvgWMRb2xzxvckrWp9iMTSHa1izEJLp884Cl1mV4LxQ8V9
	 AniXi0I73fbxBzNKCPAyNcXiLjVa7EItRGo6651rY/e6goX4JY2OV258YejGzS5NqviF2
	 Okpb2yKr0jgfOjLrB192s7zVYeyPZHHjnPOA8+PQkPBjeWReF42NiUW31HnQw4I+lWQnT
	 eool3GsXL6ZWyAcXM86CATP7v5A6s5iKGxq42v9YVzRXsdj0vy5YMs4AzTn6ns51iRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=QBUUByi0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010020.outbound.protection.outlook.com [52.103.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052A606A68D;
	Sat, 21 Nov 2026 12:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7052A606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=QBUUByi0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSJmLoOzyvlbwcgJQ9alD2yRuY5wpHQVlQ69w3DrRPWNcc6Bv2KoFn6KLBKnhdXsZY2LRn4gOdK5d8pJM2YCq88iSNn6IbF0bP/PNgngFQ9ULHbnmERkPay2j4x3MQzreiwhhpNhc36ycH4reqWbyROCZ/jqkO24HpN1X4kYtnyM/t6bdLKQ6GQj2Wqhk+LDcPU9jvhZkwxw6sFcEV4pAxIBCdD7JyIgE6LJvxY/mpreLdSI80nnxydrzblZTrPJffgH19JTEYQcv0GGdsqePKlgbNeNiiq5mIU1loIUCtLSiVXQVFQDFPV2aC4fRw8QdPnXHdRCAmhMlqXcMnxFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=B5hsRmZcFCCRbTAhA1R9zZQ8/CBUqQEg5nDaVmaDtzxlAfY4X2ZRDkTWdgyQd47IJvSvmVjvQ1lNclz2H9MKLdAf/6uHA/cQbHkUxceeyHRGMTj5zW75JxjBdco9VlfqZLFJH3jz2p3R9NlyPwIvGaHAvNgiSpaq9Ik6kYhYepuXtuXueKWzqpdTJkKTV20gC+RcidnBgEVoTRWGvzRx2gF1YUWGmxAyYUXCUl21xzjjf9rqNWDRns1rZjHt9HInwO7Dw9O4xuqW4WNz17kVmM6eJZ/vmscY4c6ORMdS+Wdk7MRgkKYFX6KmbW0QQIvxjk9KVepvxuSLwLNTIUgKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TtoXAGrLGvZNFiUnlI2pdg5OXyBDuwUTrMYlPtVyg=;
 b=QBUUByi0JkwkR+y4fxF5AGesRJNi/jKMpTxiEasn9yJi0tdXVeDRqeBiOuOermOIkXf+mGHwiSPIB64dmMJLHKuWcv6uPdNO/bfbH3TlokN99zRhQcf1jIlMGpW/iNvFWOedtoB4MwZpewRNA5ze08zuOm+XFiTyG7boumRepjc2gYx8ONaEkwNLK6Umtw9T+lAbIlbvyMd1cBb5D7o83eIorx/GYQmflTEgUrBMwPMCs/fu4M1H5AKoFy0ro1kVU86J5Eut2hdIaSBVx6gc9ZU8t88Bn7H1++hohjQa48Nr3IlCeeBhMmGdUXM30CePCWIvP0xr8cHiFAPsoZstxA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0248.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 12:59:16 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:59:16 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v3 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Topic: [PATCH v3 3/4] PCI: Convert quirks.c to pci_power_t helpers
Thread-Index: AQHdebgdMqbNZTAUAUqiAaq/HpNRFQ==
Date: Sat, 21 Nov 2026 12:59:16 +0000
Message-ID: <20261121125811.50315-4-habilerenturker@hotmail.com>
References: <20261121125811.50315-1-habilerenturker@hotmail.com>
In-Reply-To: <20261121125811.50315-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0248:EE_
x-ms-office365-filtering-correlation-id: 7466e778-aeaa-4fa9-ada3-08df47cf3fff
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|24021099003|51005399006|15080799012|41001999006|8060799015|19110799012|8062599012|25010399006|55001999006|102099032|3412199025|440099028|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnVUYzloVjd3VDlHVFprU3hpY1EwdHZDd3dib0V6aGRDSEVkSE1WdWJiemw3?=
 =?utf-8?B?Mzc0dXJuLzVwckx3cExOaWlaVllXVnh1RWlvNkJBNzJxQk4vaVZ1MU9GNE1j?=
 =?utf-8?B?VkEwZXlxYk9uWHgwVWJRRnFZaHJ4K2FOR3BxaUw3K0FQczJWVXNqRXNZbnQx?=
 =?utf-8?B?WVd1bE5IejBKUS83ZnlSUytrYU9FenZSSzZpM3Fxd05GelN5andMUDVHL0Jx?=
 =?utf-8?B?T0VsUjl5UUNEQ1ZqT1lJZEQ0dUh2ZG40cWxuZWdtWlRGaWlJNm9weExLdDZP?=
 =?utf-8?B?S3dzQmVrL240c1dWMG8weWUwTS9McHo5K2J1Mm44R2RranQ2S2dyNEh2QVJi?=
 =?utf-8?B?dXkvYmJjVHhGeituNzRKVWlPWnp1WXY5YTQzQWtrSVR6VnJuYUpwVDc0VDRE?=
 =?utf-8?B?em5HcnRvbEozWG8yOHZ6TWFNd1FDUlArK3Q0OWFNNEVLNmFSQzYvSnBBSytn?=
 =?utf-8?B?M0lmTU8yL1Bncm85a3BXVnRibDdoTVY3RDdKRDV1ZlNPcTNOdlo4L2dXQVN5?=
 =?utf-8?B?ZGdNTy9ISTIvOURoUW00dlk4Zi9FYlJBUmZIWVZsTlpNbktmQ1ZUeEQ2SWxz?=
 =?utf-8?B?THpWbWdLcWRsVyt6RFBDM3dqVExxeGRlVit1bnZHSHJ4RE5tUzZYRDdlYSs5?=
 =?utf-8?B?V3BTOUxjL0xMZTV4akhPOTlGd2U0QThnOFRkVmQ1TENRUnRVZWNtQWRLR0ov?=
 =?utf-8?B?Y1hoNWduOUNsSi8vc0FqMlNYR2Q0a0ppN2Z5d29mdEtQVTREVnVRZmhPb2ZF?=
 =?utf-8?B?ckhJa2VzZ2UwaXZ2UGpvaFdZZmZMU1JkcVRra0k4N3RKUkp2ZkMzYkRyaEFW?=
 =?utf-8?B?WXF5Q0twcDU3Rml0T21HQkFvejRzTmZtWE1KUmY2TWFucy80ZnZEYVJRYUQv?=
 =?utf-8?B?dkUwTU9oOHNIMEdEbmM5NnhOUEdXRDhtU1pqeHlDZDIrNVZBaWxJOUtVcFVO?=
 =?utf-8?B?ODZ5N1hkUG44MVQ1bG4zcnF4ekpFUmVRZ3JBWERRdHdGanAxWTZ2VUVSS24r?=
 =?utf-8?B?RkJFNzZ5a3REQVdpc2l2Z1p2Q1lsOFVBVHBOYk9mdkVqb3M3aHJmbXordnkr?=
 =?utf-8?B?ZHVKc2hUMjNQaFJYYWswU1psN3k2QTVJTU5rc3Y1OXFjU2hBYnlSazB4eDlk?=
 =?utf-8?B?emxwdlNIQXMxZWxERWVuT3lCODFWTks5dkJPUXJ6NmFxbDExeVVGV0RLTnhq?=
 =?utf-8?B?YXgrejhEYzd5RmJ0eWJYRUJ3NTFMYWpSNXNhRGJ1Tks2Lzh0Y1JIMUZ6ZnB5?=
 =?utf-8?B?MzRocFFDY1U0bzlUK3A3WnlFVnJjSHFpcjVramRNdUl6a2x1aWMzWllqMTJ1?=
 =?utf-8?B?eTVRVUdOQ3JoT1pBK08xNURPWVBzeE42TEhhL2JRVmFvbE9Jdm5qaEtINExn?=
 =?utf-8?Q?BoUv/C71hTEm3amDthaSGee9hdgNyY+w=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFByd2JWVUY5SDZtZ0w2WEJmUnFVaG9MVnlKMXNuS3pTcnZMR2hBTmE4OGpk?=
 =?utf-8?B?bXJZRG5LVXd5amhxQ2syYWtWOG9VM0NrQWxZbTBMMDhMaURVWUZPQWZJTCtu?=
 =?utf-8?B?aGZEdzlDTENvSUdqV3hYWkJ6ZnZwVE1nNVdYeHFEcU5ZNnRMZ25zdjhkdlZu?=
 =?utf-8?B?RzBYRUFMMEFYZmR1VHdyY3JGemRYMk1hVTB4TjMwc0JTcGdIZTNyYXlLejlo?=
 =?utf-8?B?UXRqVFk1SFNVdmpFV1VsclhYUkdKTHNYRUN1eWhNUFlDeHYvR0VFbjdRdnQ1?=
 =?utf-8?B?dkdZc1ZyK3A3TFhFTkJZdTd4QURPVmo3M09vTytranpxdWU2S3FaMHRsaVBE?=
 =?utf-8?B?c0ZTS1BXSStXOE43Rzd2Vmw4Mzd5cmFnL0pEeTdFb1h3RW1NK3h5N2VuNGRk?=
 =?utf-8?B?dGJVSkFudkdRRDBCd2ZmbktTTFVnR2hCOE9KUUZOSEpHbVFXYlRjeHNWT1N1?=
 =?utf-8?B?d0UzR2QwWC9WTkxHNDh2aEcweFNFSnBJMzJlSTl0SENkQSthVzlXZURxNTdD?=
 =?utf-8?B?QmFxQ1dqQTA3TWF3N0pRbitKeldxV1l2WjJzL3dHdkNnU2daMGhneWJKV2hq?=
 =?utf-8?B?US9Sa1V4NC8wTGRMeHRsSzJWRG5BTTUyNVdpNjBsdzc5RVAyWU5lQ2dwazZu?=
 =?utf-8?B?cXQrOGhKUHVEZGpTYUVjdkxTbDE4K1FDOVJPMTZwckg0c3RlTERlNERXaFA1?=
 =?utf-8?B?Wmg2RWx4SWh6NUluT1pLSVVaQnQ4d0d2UTh2elJNdmVSaXZ6bEpkRTB2N3R2?=
 =?utf-8?B?NHBia3VId25KV1J2OGVHN2o4VmgydWVaU0ZHNWh0WGhNYUZuUlV5R0RIQ3Fu?=
 =?utf-8?B?QmZzTjVFbHRuVlhLSzR4Y2JJTWxIQ21udGZGNGdMMGxsVThHTWZid2ttNnV3?=
 =?utf-8?B?d2xUMjZhc1NybG8xUXIwL2VPQmdNRjZ5UnFaSFVrSERLUlIyak5WNnBheGNP?=
 =?utf-8?B?VUY5ZUZZMmlOMVZxcGxXdEFiVHZiZUJhM2k4cW1LdXQ2Y3BCMDdBM1RkNEZz?=
 =?utf-8?B?eTgvTHlsYVlsREk2VEIzVzlKc0I5K3AwdWtOaU1xQkJ1T0VLVFdsZk0vbjB2?=
 =?utf-8?B?ei9KM3ZHcmFkUnRyNC91dys3NCtoMW5SOWJrYnp3SmY2ZlMxL283RGJRcjNt?=
 =?utf-8?B?RWJkZTU5RzJQZGpDMkp3TUxjaVRZYXJCQ3g1bDBmTithZVNHMU0zU3lwa2tv?=
 =?utf-8?B?ZHloallVN24zV0NTVjRHWTFYRmZyeFkrR0Z0MElPVFJoRmg4T2R4Q3RNeEp5?=
 =?utf-8?B?RCtub3IvYXVQR2J4WVdFUStLS2VZcHN0dTVjay9PTC9qS3J2MTVNcm8yck5M?=
 =?utf-8?B?MVNScnF4ZVF2WmVSOGVFUE1vUEJLZ2pLbFFXMUJHK3RsTXlFZFE4ODhoejN4?=
 =?utf-8?B?MnNWdEFTdFlncGV0bDVYVkN2WUkxQTNNbTFtcUJPaFpyQURHQzhtc0p2MVlD?=
 =?utf-8?B?cmNxZUE3N3IwQk9ydVhJbHBmZlNvcmMxNWQvYnczZ2paYkNGSGJyMmxXQUNn?=
 =?utf-8?B?OFVOdm00QUlJcEd2Q3I5VlZpZmcwN3hnaXdGWEJZY3dlNkJrVHZETGlKUTJh?=
 =?utf-8?B?L3ZtYTdYRVc1aWduMFZUTFhlSm9SbjB2L25jYU9zNmZWUkRlRUlETHUwZlFM?=
 =?utf-8?B?cFFtUk5OeG9paWlHQld6eVZ2VW5yUDRhK3Y3dVArWGh3eXplZm5wQlcwa01T?=
 =?utf-8?B?NlhIWndXb1cxblNNMzA1ZUJuNlVjdG45RFZ1R0ZWcmZyQWtwbFFSUHBRQ0tL?=
 =?utf-8?B?bWRUSWRtYnVBSU5aV1YzY25McWpLRkNSWGEvbWtLZk9YNm9DZkJObFl1ZTFB?=
 =?utf-8?B?a0lsM0MrdXh6eE5RWWo5RmRMTmJ0NERQODZwV0lMTXBOdnMxSThpZzFQTmI3?=
 =?utf-8?Q?Uao+xTlYhlmdG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA74E008EA7CCF4A8FAA41C91E77E3BC@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7466e778-aeaa-4fa9-ada3-08df47cf3fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 12:59:16.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0248

VXNlIHBjaV9wb3dlcl90IGhlbHBlciBmdW5jdGlvbnMgd2hlbiBhY2Nlc3NpbmcgUENJIHBvd2Vy
CnN0YXRlcyBpbiBQQ0kgcXVpcmtzLgoKUmVzb2x2ZWQgU3BhcnNlIHdhcm5pbmc6CgotIGRyaXZl
cnMvcGNpL3F1aXJrcy5jIDogd2FybmluZzogcmVzdHJpY3RlZCBwY2lfcG93ZXJfdAogIGRlZ3Jh
ZGVzIHRvIGludGVnZXIKClNpZ25lZC1vZmYtYnk6IEhhYmlsIEVyZW4gVMO8cmtlciA8aGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCA3ZjFm
NDdlYTJlZTQuLjQ0MTdlZDY0MjJhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMK
KysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTI0ODcsNyArMjQ4Nyw3IEBAIHN0YXRpYyB2
b2lkIHF1aXJrX2UxMDBfaW50ZXJydXB0KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJICovCiAJaWYg
KGRldi0+cG1fY2FwKSB7CiAJCXBjaV9yZWFkX2NvbmZpZ193b3JkKGRldiwgZGV2LT5wbV9jYXAg
KyBQQ0lfUE1fQ1RSTCwgJnBtY3NyKTsKLQkJaWYgKChwbWNzciAmIFBDSV9QTV9DVFJMX1NUQVRF
X01BU0spICE9IFBDSV9EMCkKKwkJaWYgKCFwY2lfcG93ZXJfdF9lcShwY2lfcG93ZXJfdF9nZXQo
cG1jc3IpLCBQQ0lfRDApKQogCQkJcmV0dXJuOwogCX0KIAotLSAKMi40Ny4zCgo=
