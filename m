Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098949;
	b=O8KLzbBXhWuFpwoyIlCjoVU3sceMi9yx/+dvkQx2HYZOUVPMVM3Ir8xQNJKbRxgy4kSC
	 jz9pEHX+F8p6x5rUkAhTjKBs8H9NPWJkDfX+AZt8cTcjRLEdpR+AzMznpcosUaNoRWBA1
	 INSYWlknpMdjkcDNl5YgEWEAVyy435xxddUPPxjfRioGmlb9ymZKQBsIpRZdiGdYM43aT
	 SWdcUKlC85IdtsSWdB0+ViXy6ZaW4kBFawRvQholQ7vyzg1iEBEocDjsm206ZVQIwlosn
	 5yVpz91mzDKB6hdA2Cls0heFAo407AZyotaVf3WuuHu4Mbe+UVVKlDxlhrjUAGWlALA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098949;
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
	bh=vQTtR5BCf0rMModOlewN1vEpsQDRmoJ+gQcIoF8IwSo=;
	b=b65iOpLcvsddnXv+fo8c9F4KOaVDB01XGq9pgBLEbM76LTZyoQvFhsF46oy/peNaMHN7
	 MN68KbGRylJM9kTaUdff0SgmBHIRaBzfar1gFkkMByG9tMewCh4GZAFPiKeXw2EktsRf+
	 B8EmMbH2StM9gNbUrUbLRI8ZuuNM4S91YJqmX4nWwWb5dARsDT0Wwpki0ZlyELXjDwIf3
	 GQ1NWPVGVccovEbRZi5Tf+PD2XYVlbCpFRTiH56peiqJB/Y5ew3/fGkBF/ltYiZBBhk/i
	 x0cuuk8Jve2vZ5ZwZXmUp/+CIOcaPeSNFITNBSdN+xL+t4W3gLRhZfynOx3LbQQTnBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=O8FsqUZm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.2
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010002.outbound.protection.outlook.com [52.103.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B015606A32C;
	Thu, 19 Nov 2026 14:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B015606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=O8FsqUZm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz+P8NK72U0W6Ylitbg3fDyMNi/KLtn958aXy0BHePWseXiM/trcEOH77ZOZXo2RbB0CT3/cn2uqMmOis+e+T27R023WzSMSz7xNuv9aA5FPHlBG6P3SYKo9K3ysjoKmnYD0mnzNL4QLiyT1PgmfMn9q6ejLh5HGlOJOMfEHpg09s7w5mRHn1wKgjQeyPrad0cea9l2DrsE/rf4YhVhQMkN7h2J7PnspWu0GVUa0HlhWCWGtZheuCVpUVassXYru62xSMuf6OqpjqVSVnnllbZvHoFCjR8Khg4PrR838yEVF5glrOIQ2XMnnoKXtHU41noLH1ZmvuVdSdqaAfdPceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQTtR5BCf0rMModOlewN1vEpsQDRmoJ+gQcIoF8IwSo=;
 b=okVuSywIq2jeBjYIDdsK6Xi2u/N0H78u0erRK7hC91Hbds8GI660BnHryfAkFw4SyjlXWeFX8RQatMcllJFQhLbODhHdJZy+msqAHXMCK+wtu8ZJtB6T+o9inUZLWtDWBxXycPosm0k+eLSypJF8AiGgJxhvE7Ey+F7jIQnCoP7y1rISp+YYxQ3gB4OtLb06NUYpkuzXM3Aku6ciuudaIe6wChn6u0qT/xJ9e/w31WQr0oz+DlMhLO20Al8NoC+wOynXD++gIHxiXBcMam78f0bdCai0L348DWeV2U7j+q+VcUpoZSwFI2JtqmUmiIKmQCVBAmpeOTpwy94hoN0kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQTtR5BCf0rMModOlewN1vEpsQDRmoJ+gQcIoF8IwSo=;
 b=O8FsqUZmyMxU9ZjCYpgxpRybSnRhlFZVBrJVRYIQRDPTPKD+4K1IS5QeRW1N0i/Xjifiw02SAdLYjhfUCEhKwcGPzYisax82gK3HxyGpdy52zXml9ldlmLVGXikFaVL5m+aKnXrIOB49htihX1YKXOJBS6vfZAO7Wv0ebe+8ICkMBz4hq2CP+nwvwMt+CNRQEKPpK62lTW30tA2+eij452ueGkCTo3TEwxvSvC3aPl9MDEH7gCZeqvxadwPYprcw3Q3F6NAKtiGRj8pHfVe+46jrpfJ1jmdJnTJMTVJGEvq/8PsZRbULexyfrbeZFIoBeCUc7gj4eWBfFWv60e6zTw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB109571.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:35:46 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:35:46 +0000
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
Subject: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdeDNDxGPpnfUHUki782tDVkNO4w==
Date: Thu, 19 Nov 2026 14:35:46 +0000
Message-ID:
 <29fcfa729d7f687f66578781c2e23db9e3367c86.1795097970.git.habilerenturker@hotmail.com>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
In-Reply-To: <cover.1795097970.git.habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB109571:EE_
x-ms-office365-filtering-correlation-id: 7b6ff115-d0ef-4a39-f09e-08df464a664a
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYAYx1xXrBLUWTP0Nof2HmseO+bytHNCERID3FT5K8qNNxqMXrn+prUqA4NJ8l5tiFc0Uo5npFV96aBQF+xkk+pMY7enW9du4tMzEbbBGSwR+iqBE7moKLp+W2+M9nRYB8gD0Iu7Bct/Y3Vh32/deY7CLI9lbZtc1Anmq6M4ZixO1leYRe9/KlSLiU5yNw0ofI0HCAvBW4tsuItVZh9aT8hQsuLdAM8ShvZzDrzXiVpub40BKdSO/9WDH8AGD5EuIiIbH4grhELecjgOusLOzaHVNhurITCe3z0q+bDgLbOy2l1ut7lgkdpVrxbU4Y59lERPrfs3BRrv3aO2l3PJb+Jdcx22aqq4ShXKIqLZw+rilgv2oj16sB2GXTSpntGsKcD+MVWR49Q1zEQsXbSHwLGjaXCpmuqYHlrtGfhbOc887MOlXIPSsKrh0plzW3BCtr0gJIFoOjMF5gucSKEFvOQCY4+bVGeneggQ99rSmHCRQGIf+AEeapp0uMFcn9kObsrZZB9lJ0VNQc3KqyfNPYHca/w/3vnnW658EDL6Zckyex350MsLUyJ301M394VYjW9m/O7MkBvV4DgjjoKauTKzOzhjtgRj2+xdOzbR2pt46MjDuAivDl4ViBKkVp1Y11/Egc8FIMlIMlVQPBFlLtf2DYH7bW2dxjyblXeRK/RLVOKgW87NbowCcDg8HbWjsPpIH1gdNaCBxjyFmv/bkRONaDrGqQtMQs4MBoTI09GpSZK4aBnaQEeWDgrLlz/U+GjDtY327+aHHIiBTCiG11willmtTIwNHvPf1LRCeps0MSeJM668THtNwmhhzxOdfOqYYbpEPCmYSg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|51005399006|25010399006|24021099003|55001999006|8060799015|38102599003|31061999003|41001999006|15080799012|1602099012|10035399007|40105399003|102099032|4302099013|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?czZKR3M5NkVMVGpaeExSQ05SY3ErTXlsa04vMFdIeUJMSXNGVWdzWVBuZGdS?=
 =?utf-8?B?eUZzWi9qTS95cG5SbDAvaTZqOUZkTmlFVGJBL21uVkQwZXNLMHVRUWMxZlVD?=
 =?utf-8?B?cG1nZ3IvV3hxbzNUdFdzSlYyQ3ZaTG5nK1RDdWhtYXM0UUMrWmttTTRhMExZ?=
 =?utf-8?B?SGJ2Mlc2MTBLTHdFM2ZvS2ZiMVhrekpZazgxNTNrSTBZc08zaFJnMFpKdTdZ?=
 =?utf-8?B?dDRhcEFFODNuVHdranBLcU9kWDd0OU5lWVkySDdFcWJNdWJaMGIvWmVTbXA0?=
 =?utf-8?B?dXU5dHg5RUZ3dEZkRlVWRlRnSXNPOGxhRlQzSkNEL1JoYXBrMlUwZkJ0WkxE?=
 =?utf-8?B?RUJZaXdORXB3OGcwMFR0ZDhJK2IxODV6YWdXOENJRll2NTZ4Q0xTNTVoSFY1?=
 =?utf-8?B?RkdJVnM2a0lnRHlDTlRhMWJ2S2M4ai90UU56SzFTVk9QYSsvU0RBeU1DTFdz?=
 =?utf-8?B?bUxvbWpQZzg0QUlRYTY1ZXJxZXNIa2NMYmFjRE9maU9oWFpFZzhvSWN1bFUw?=
 =?utf-8?B?NEZFcnJVU01VUllXVWNHbHBDNitWSkJVNWhuQ0tud24wUVFUNTI2bUVEWkxX?=
 =?utf-8?B?QkVpL2M4R21nazhENnhoNEZ2ZGxyeGdjRzlzVmMwTWQwK0pZcm8xUVJhLzJL?=
 =?utf-8?B?QkU1ei9rTzdwalVpNGQxTXFwZVRtcWhaMnQzdk81eFdlakpBRFZHT3dLL3pt?=
 =?utf-8?B?ZFFuQUdYRTZCWmcyY3NIU29kZXdabTJrZVV4L3kzNGhHeEtJMTR0bllPRWFm?=
 =?utf-8?B?a0dsK01oai9MOFhBUEd3UWVpTE1KaFR5U1JDVEdJQ2Z0ckJvYW1oWlVyQURn?=
 =?utf-8?B?R2xiemQwSkhseE9PQXZDV01XdkJjMzBZQloyQzEwZ0RpRWRzVlhCN1VkNkdo?=
 =?utf-8?B?OFdJZGhraVd5NElBZnk5U2txVC9QaHFZLzM4dXFoYmhJQ3QwOFdSUW83djlt?=
 =?utf-8?B?N1BQakp5bWxxUkhpc1VDTDV5c2toSS9sRE56dnRsdDZOODhMT0M3L0RGL0Fo?=
 =?utf-8?B?SUk1YzhkMWhGSjkxU29LRm12eFhsTjIySDBZYkx3MEpFUXI3RUU5SnFIWklV?=
 =?utf-8?B?Qnh0SURYVkJ5TVdCMzRvOThRS3dzOFhES2hvSUdWUmZvMHpQaCtHVzFHYXR2?=
 =?utf-8?B?Njc2ek5PWkJTRlZBUlYwTENrS29LRGRiL0ViWXpXdW9Va242d0pUUDdMWmxC?=
 =?utf-8?B?Y2wwcTNmbDdEVVFZRlNXS1JMWjFwR2xSWjhUZmkvNDluV2tiMUNFTmU4QVNt?=
 =?utf-8?B?R3VvQS9hS0VkcFBkUTYxVXFoSm1PQm85SmVjQ0QrcytrNTlCSUZiTGRlZjRw?=
 =?utf-8?B?RFdIV1hHM0FOV2lVY1JZL1JLRDZsNXo3TGFJa29RVFpTdzQyWnh6NDZTK1ZM?=
 =?utf-8?B?NGdqWEVwYURlS0JlekNXYTBJc0tjb29qcncxRlFNSXFSeGIzNnpUTHhHNVRQ?=
 =?utf-8?B?dEVCNGFvSW8xVFo5dDZQQ2greUtrb3RTaXd1djJvY090SS9iN3FjeDh5bVhE?=
 =?utf-8?Q?kraWmw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGtjR21HRks1Z2JqamxMQlQyeHpMSWR3ZjFtZ3Ivd1VDNkIrU3YxTHY1eHZU?=
 =?utf-8?B?bGxOeEF3YzZwY3lwcElwWmhRdWRJd3gvSHFkak1Ea1A1UkRzYmJGNGVPMWtT?=
 =?utf-8?B?dmFhdUc1ZXdXZVp6RmI0RFlrUENZQmRIWnVjMEg1SGJ4bENCMktCY3lmTElW?=
 =?utf-8?B?VWorQWhmY0lvWDg1ZTE0ZUlKNW1YUkNxWU5DK1Jnd2JyNHU0SHdKVkcwVDZr?=
 =?utf-8?B?WVBTUXNmWkZKOFJQa1A0b2lRVVRiclhQQ0h0YVZrY0FiNVFmS3RrSVoxd0Zz?=
 =?utf-8?B?S0ZFY3BKd3dleXFkMURFV2JZM2FvQW1RVXB2bjlEQk01M0E0M0R2UkhwSkpV?=
 =?utf-8?B?TjVqYlpOWlNvTHVMNTJia3VNeU5wMDR1aUd6Yy9qWlEwZTVVdDE3bDJtSWN3?=
 =?utf-8?B?RVVMUzdEUlh3cUduT1IwcUsvOFl3VzJ3eWU2czQwSHJMbjhkakI1ZEh1akRp?=
 =?utf-8?B?VGp0VERIMnE2S0NKekNBQ3QzWmJwVHV0VlE0eTZlOCtoUUxrK3ExNEM5Qk5t?=
 =?utf-8?B?eVNqNTJ0aWFxT0ZkazlXYUhjNzZkWnlCSEsyYTlmbVpSUjVsNm1CSnBOVEox?=
 =?utf-8?B?cG1CajhHeEhMQzR4RW91Y0I1WGpDTStab0l0dEExMURYc0Y5UlhJeHdPS0Vk?=
 =?utf-8?B?bG9uWGU2QlpJS2FzbnBNSUNIZW1jbDcweTlScE1PRGRFRXBPUXVxSXdEUEtn?=
 =?utf-8?B?QXVGeUpEN3ZNeHBoMWtmQlVtY0dTdFl5NzRyUjJ2QkluRzRabnlyZWhOMUJ6?=
 =?utf-8?B?K0dwTk5GL3RJcXB4blZnckFJNmhDQmxxcEpocGF3Zi8rTTlMbVZ6U1d4Q0Va?=
 =?utf-8?B?em1YL3hyQi9DZFdMWEltbFQxTFhhNGpxZTFSdC8wY2ZnYUVlbnBtVStERDJZ?=
 =?utf-8?B?MXlGOFhFWkR5cVhHUURaVnl5N1BDaUFXQURFNUc2bmhQV1c2S2t4M01TUWVF?=
 =?utf-8?B?NkVFTXlURlQ5TG1UTHp6MktFRkZ0TnZEbmNKSWZhWHdRUFkvVCtXaVdpZm5F?=
 =?utf-8?B?ak1CbG9PTWZvQXZHNXkxYzQ5RkkwQ3JPOG5GYjNzOHFBMmlMZXMvbXBDU28x?=
 =?utf-8?B?dk1wckE5d0lTT1lJV1U0MlB0U3dON3dmTlVGcitmbGlxSUpaaEJTVHBiSmV6?=
 =?utf-8?B?MThMZ3VYL1hzMHpxc0xlQUlrQkx2dVYwMEhiV0lmdkYwMmFjTVZGbmhNV0Nk?=
 =?utf-8?B?b0pRQnRIYXVCdWVzNjdrNjdnd0JXYmpGbjVBeGJVTVozSDRYYU1TUXBIVVVB?=
 =?utf-8?B?MGlISVZicm80TXpXOFJ5bWtaRVNnd252NVdad0QrK1dCVzNSdU51OGlBYnRM?=
 =?utf-8?B?TmhWOHNZM0tKZVc5SDVMbk8yVjJhWGZWOUpCZUJ6cjV0TjRrbVl6ejRZWSti?=
 =?utf-8?B?eHFFeHdNL3AyNVdGejg3SGJYeHlhWHA3U09zQllFY0ZhRFhtWTR4N3BxOElM?=
 =?utf-8?B?VldkQmRpSW1PZFhjUURKQ0UxdmhSY3lhN2pVZTNPRS9JejFkNUlCcHFCMnhw?=
 =?utf-8?B?Vk1zeEkrQzEzZ0ZDeGNwOVZoaHY4SmxhR0J3QklyQTJhdGJ4M2I0aUI0QkhQ?=
 =?utf-8?B?QjBLa05GcGl6ZWMxelh5SGhtYVd1OGVsL1gzc3hnM3Y5dEpjUGVNajA5NzRn?=
 =?utf-8?B?VzcvQnp2UloybUJpRUc5cGZ4eGd6MGo5QmNoWno5cjVPZlV2WDZtRnZRVnBV?=
 =?utf-8?B?by9wbW45YzNpY3M1M2huNU1jZlVDL3BCZHp3cGVuL1JXcUNaNm03OHJHTGx6?=
 =?utf-8?B?ZUFNckV2RUNlSklCNkJuTmN6T3BXWkMxV29DRUEwVHpnWElWYVlrbExlc1l3?=
 =?utf-8?B?SGYrMVdtT1BPM25OakNnWUZiWHlWQjU5eG1KaFZ6Rm1Vc00ra1lXQnRRcXNm?=
 =?utf-8?Q?kKaNN3G4clurd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D3DD9EEAA69C4294A4C427B35E1CD1@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ff115-d0ef-4a39-f09e-08df464a664a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:35:46.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB109571

QWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gZXh0cmFjdCwgc2V0IGFuZCBjb21wYXJlIFBDSSBwb3dl
cgpzdGF0ZXMgaW4gdGhlIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbC9TdGF0dXMgcmVnaXN0ZXIu
CgpUaGlzIGZvbGxvd3MgdGhlIGRpc2N1c3Npb24gd2l0aCBBbmR5IFNoZXZjaGVua28gYW5kCkJq
b3JuIEhlbGdhYXMgaW4gcmVzcG9uc2UgdG86CgoiW1BBVENIXSB4ODYvcXVpcmtzOiBDYXN0IFBD
SV9EMCB0byB1MTYgaW4gYXBwbGVfYWlycG9ydF9yZXNldCgpIgpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzIwMjYxMTE4MTYxNTU5LjYzNjE3LTEtaGFiaWxlcmVudHVya2VyQGhvdG1haWwu
Y29tLwoKU2lnbmVkLW9mZi1ieTogSGFiaWwgRXJlbiBUw7xya2VyIDxoYWJpbGVyZW50dXJrZXJA
aG90bWFpbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9wY2kuaCB8IDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKaW5kZXggYWEz
NzY1YTIwYTk2Li42ZWZkMTNlNzYwZDcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgK
KysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtNDMsNiArNDMsNyBAQAogI2luY2x1ZGUgPHVh
cGkvbGludXgvcGNpLmg+CiAKICNpbmNsdWRlIDxsaW51eC9wY2lfaWRzLmg+CisjaW5jbHVkZSA8
bGludXgvYml0ZmllbGQuaD4KIAogI2RlZmluZSBQQ0lfU1RBVFVTX0VSUk9SX0JJVFMgKFBDSV9T
VEFUVVNfREVURUNURURfUEFSSVRZICB8IFwKIAkJCSAgICAgICBQQ0lfU1RBVFVTX1NJR19TWVNU
RU1fRVJST1IgfCBcCkBAIC0yOTUzLDQgKzI5NTQsMzEgQEAgdm9pZCBwY2lfdWV2ZW50X2Vycyhz
dHJ1Y3QgcGNpX2RldiAqcGRldiwgZW51bSAgcGNpX2Vyc19yZXN1bHQgZXJyX3R5cGUpOwogCVdB
Uk5fT05DRShjb25kaXRpb24sICIlcyAlczogIiBmbXQsIFwKIAkJICBkZXZfZHJpdmVyX3N0cmlu
ZygmKHBkZXYpLT5kZXYpLCBwY2lfbmFtZShwZGV2KSwgIyNhcmcpCiAKKy8qIEhlbHBlciBmdW5j
dGlvbnMgZm9yIFBDSSBwb3dlciBtYW5hZ2VtZW50ICovCitzdGF0aWMgaW5saW5lIHBjaV9wb3dl
cl90IHBjaV9wb3dlcl90X2dldCh1MzIgY3NyKQoreworCXJldHVybiAocGNpX3Bvd2VyX3QgX19m
b3JjZSlGSUVMRF9HRVQoUENJX1BNX0NUUkxfU1RBVEVfTUFTSywgY3NyKTsKK30KKworc3RhdGlj
IGlubGluZSB2b2lkIHBjaV9wb3dlcl90X3NldCh1MTYgKmNzciwgcGNpX3Bvd2VyX3Qgc3RhdGUp
Cit7CisJKmNzciAmPSB+UENJX1BNX0NUUkxfU1RBVEVfTUFTSzsKKwkqY3NyIHw9IEZJRUxEX1BS
RVAoUENJX1BNX0NUUkxfU1RBVEVfTUFTSywgKF9fZm9yY2UgdTMyKXN0YXRlKTsKK30KKworc3Rh
dGljIGlubGluZSBib29sIHBjaV9wb3dlcl9lcSh1MzIgY3NyLCBwY2lfcG93ZXJfdCBzdGF0ZSkK
K3sKKwlyZXR1cm4gcGNpX3Bvd2VyX3RfZ2V0KGNzcikgPT0gc3RhdGU7Cit9CisKK3N0YXRpYyBp
bmxpbmUgYm9vbCBwY2lfcG93ZXJfZ3QodTMyIGNzciwgcGNpX3Bvd2VyX3Qgc3RhdGUpCit7CisJ
cmV0dXJuIHBjaV9wb3dlcl90X2dldChjc3IpID4gc3RhdGU7Cit9CisKK3N0YXRpYyBpbmxpbmUg
Ym9vbCBwY2lfcG93ZXJfbHQodTMyIGNzciwgcGNpX3Bvd2VyX3Qgc3RhdGUpCit7CisJcmV0dXJu
IHBjaV9wb3dlcl90X2dldChjc3IpIDwgc3RhdGU7Cit9CisKICNlbmRpZiAvKiBMSU5VWF9QQ0lf
SCAqLwotLSAKMi40Ny4zCgo=
