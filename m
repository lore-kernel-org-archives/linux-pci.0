Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795265957;
	b=NTAH3cEcc2+BTjNJg3D7rLWQwL7+dQPdUAg7Bgv1wRGiQE+AAImwQV/09kg8bvhrlCBY
	 iVwvlkFn+WfzBW2lRGzGj48+9/xweUc0H6jQSZDcEXCeAweZaFaseCENjzc036qg8xn0y
	 /mshy1IhR8a9bRTKrfYljCX/rIHwmqU2lgzL6zM+pjybpySHgfETaMxAIGWvXGSo8P2y7
	 KQcotjpW21K71yDgj8y6c8b2ANsvZ7PHWPsSuQ7qxzSJXQBq4JmsZJ1YTN4t09G/HZYd2
	 XJprFfzgLdsxqPyZ3nxMlD2CQ0lXMpXSuN5ofeeq3VoYyL5uw5VKJg6TTrP5eHr8n8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265957;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=67dtFrjw81GM7OAQfDqBKxQBlg13FFQLTqvMvE1y9tM=;
	b=wQ6FwPHsOXHhUZdqEGUzfcfkCFud9BUNhDkbuxhCOWaiGevkgAvBivVlREw6CcTIvxdW
	 QinL5oVEs3MEv8CdiTf8lu9n/hE+zBILHT0DqvtcJG6IXlqlGIvzLOBYc1XRY4WQnNgBI
	 dxgJ+7OOnMi2RJvSfRiIM8IzNHxHt98NZNXoEl28LPEVjB+PRQz9u7OfjDTgPiZwDLYJU
	 HX3q1N5lgBi31y2HbREIiRzq/llK6ptCD141y2lc3WTK+GpcNQNGeNEEPIFtqlS7V/xnE
	 OTYzoUKTYukX4PZqrgp5uqLcu9zze3o1yCiW7A1O58e2yJPUYJQR4f2MfJbGN4Fogsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=V+zUTjBa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.20
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010020.outbound.protection.outlook.com [52.103.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A54606A320;
	Sat, 21 Nov 2026 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A54606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=V+zUTjBa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adB9MCoLLpInCm5/+lBe1WVIjezspABKP2/x+35oFsaJM0ldSdN1siQIgbbPBhlozq8/m7ZKfp+fChSeCX4lChOcknSlVi/rX3rWj/Ishyig2UzF9meKw6wkdI8oTy7oXd7NVaE44vA0JiTWjHJMHIxVwB5eRemSK45dYqzK4DVrpGSQWqv5i9o1Wp1vVF2ygrBxGvgx72rAGV0aT/POMXMQy6B8hzOznRUUvKPRqyd0CbY+qCAoC+e3U5/U88vK+HaAipnzsmOmqnxJUM5gyfJ3REbHrc5odC5bSg3ROiwIs8gY20dwFPm700LNHuXLJ4naYQ59RNdyJvmGYtG9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67dtFrjw81GM7OAQfDqBKxQBlg13FFQLTqvMvE1y9tM=;
 b=QLFFSZFgMdwoqKoK7533Zkc9q27vjDx70Tbm07CfGvflwGQ8cJSraqgNzEU+6gQ6bzT+zeJSBBPkL7Mxl6RdwiL+7LVucaVl6cKzYZPQ6oCUFMS0N9G7eU+E0VRmZDiISITFpImoHWMEGYsuAAxPiLn86fpDQGF+y8MedO1Qhr40qvWbGChLugB6Y3pOe/GEXf9/umWtPeYQ0FN54xjsdcGbNP6petUD7Kr7Jp0zwqfbEuf2q61bG8ezU+Phe0uZ9l7mpiwiUVV41bl5HRMSlw+um+pq14aQAX0xpvAXBFyvyBZ0+Vnpre9c+HTS4pg8EsJBuJIipAq/8OGu1N4vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67dtFrjw81GM7OAQfDqBKxQBlg13FFQLTqvMvE1y9tM=;
 b=V+zUTjBa+AtNffXqynuaWggWy8nECTIXs/ZNbHSQBKicuhXLUjrLKTa2NVsW5lGPSZH3d+O7HvekdO1dh9c7s0VXxcVCZwYNTCmVhYCntIrZd6I6+/3vg/KseutJXUSqCQtVmRG5EIYpqvaNQPWPvXF4m2ZeqbAP+4QO4xhauswf2scj6EByeyXpVIjGbUY91W+ksfCvoEAbklVxNzmEY0rhlxi2JQskwCB0QLzpEDArMzIxoxckEVclkveSiEdR/T+HNXbwzbUSv2eeeA2pp29WpI+2tX79WMHM/vwgK+8xSVQcLgO81u7T4DTmY6AmslJQ7WBmkcXNtMTcf9Idmg==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA0P291MB0248.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 12:59:13 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 12:59:12 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?=
	<habilerenturker@hotmail.com>
Subject: [PATCH v3 0/4] PCI: Add pci_power_t helper functions
Thread-Topic: [PATCH v3 0/4] PCI: Add pci_power_t helper functions
Thread-Index: AQHdebgbqVYS3RnPfEqs5OViS2d3Tg==
Date: Sat, 21 Nov 2026 12:59:12 +0000
Message-ID: <20261121125811.50315-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA0P291MB0248:EE_
x-ms-office365-filtering-correlation-id: e1fa2e7c-51be-4e47-f47a-08df47cf3daa
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|24021099003|5062599005|51005399006|15080799012|41001999006|8060799015|19110799012|8062599012|25010399006|55001999006|102099032|4302099013|3412199025|440099028|1602099012|10035399007|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFdNZldEeEsyZCtqdnJaTS9DWWlsdndzZ2JKVjdkbVZOU1hMT0JSNXNJeDJO?=
 =?utf-8?B?NElyQVp3QUNPWWlrMFVHS1htWU43NmpzWHU5NmhGc2d3bklhSUo3Q2xzQk5z?=
 =?utf-8?B?TnhoalI4KzZxTGk5c2FwckdKRXB4QWpOczlOVThOeGxoNGtydW9ueGJVanUy?=
 =?utf-8?B?S3NMbWRNWEdBNnRpd0M1UXZuems2N0d1Ym9aZEd5Yi9UeEk3Q1owczd3aU1N?=
 =?utf-8?B?d3NJYXhGV2lhVVMwWjA4N2pPNGljYVJib2l6SGppVmp4MVFRbWZpam84OGg4?=
 =?utf-8?B?T29TK2lzSXZ5V3V6cDZ0ZWhCTXFOMGNsYmZWREZPY0d4N0U1U050MU1NRWhy?=
 =?utf-8?B?ajdWaE8rVStrQzZuenJyQzJmVVlBZFVqTUN0c2haM0hiMU5sQXpJZ3pvSzB0?=
 =?utf-8?B?SDNWYzZXWk5BamZ5VlZVc1ppSGJOR1JGQzBZNU1CQTN2VVRiYTU2OG1wUTV4?=
 =?utf-8?B?bjJUekJJK0p5aHFTNzM0Uzl5QzdVM1FrRXlVd1B0WG0wZFV4YUJwTEpvcEJ5?=
 =?utf-8?B?eHRCZUxmQTZaWlN2ZXJHbHkwQnlFRDROdDBVNmJVd3RDcDJ0WTZyVGNldHd2?=
 =?utf-8?B?UTRqS29uempvTisyOUdlQXdtQTVQSStuSmFnczRqYVYxOWo0K2dRMlRJUUJn?=
 =?utf-8?B?Si9rVnF2d0Q1T2w5b2FQMGtiZys3Yi9HdmRDV1Z5bElrMkk4U204SmNCdkhj?=
 =?utf-8?B?cjN2dUxReUhNSnN3alRQZTlwUnFkaDJla0oxSy8zTEZoaWlPenNTOGEvOUE0?=
 =?utf-8?B?dG5LRTBsamt3bERBcFRKM09zWFkyMTZFa2t0SUJoeWtlRkkxbVJlOVd2N2Vn?=
 =?utf-8?B?UnZUYnB0dm92NlN1K0hXMmozMTlLcE11WWZyRWZsMDl1MEpZYXVGTzdJM0h6?=
 =?utf-8?B?NGVvZmNJRlBPa1ZISFdPclJDcEhFaFRxTFYrYW93S0RUaUlYc3ZpZ1R4aERQ?=
 =?utf-8?B?R0hVaDNNWENFWjNUdzJlZ01HakJFK3J6WHQ2cWRqVkVxVE9wcEFoOE9SamhT?=
 =?utf-8?B?QThQZlpVMW5oTWU4WnlkRVNzeUlZMFZIVUxwWnJHSWRsSzl3Y2loTjdyM0ta?=
 =?utf-8?B?NURqWkpubGtGOGI3NVB3OG1yY3dHYkxCajdncXZEVkthc3J3RG54TXZza244?=
 =?utf-8?B?ckZ4QmZyTmY3SFhUOHJyZ1IzVitoU0dyUDhCTHN3S1JHc2UwRWRPaU9YUndO?=
 =?utf-8?B?UDgzZEZjeFg4MlFUamhleXlLUGs2ZjBad0JvOTM5bnpyQjczNDdGa0xsOWRZ?=
 =?utf-8?B?R3FQTnZna3FNY3l6UkxGNnlvUkZLTitpOWR2WElYN1RLSXFzMFU4bkI2Tm83?=
 =?utf-8?B?a0lkL0VkYWhNNVJKaXF0OUJuWlVwTXB0UktIUWNoa2VUaEkvUUkyVi9vb2U0?=
 =?utf-8?B?czdULzFQR0VvckpCTHRCUkJQeEo2OGlqcGVUd1JKVUpIZzcwSXN4T0JVZjZs?=
 =?utf-8?B?RlE4N0txZkJtcUROcWUrcDJGb05XTUVzZ3FyV3JOaDNSMDRmckVoSENhOG03?=
 =?utf-8?Q?aEf5vuvXFVRBlZGf/cAPyyP5YWu?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T01HYWt5eE12OThra1hzU3VSdUh5d1hNZUl5aDIvWU1mdGNJUERDbEoxYS9P?=
 =?utf-8?B?Q3dCQXdlSDVzSnFib3AzaXQvQm9aQW5uazhPVlRtNytMMFJYRXc5SmpEcjlE?=
 =?utf-8?B?a01UQWVDVEhwdGMyQk9CSERJdGVEMUV6L3g4UWJENzFuUUNxUEhoYVhDTDRY?=
 =?utf-8?B?UldnWmp6SnpoUmxBR1ZrK2c5cExPVE9nT2QySEczalJGR3VvWjVyaE5GLzc1?=
 =?utf-8?B?MUxtcnc5Rmtma25BZjAwbldpL2R5d2RFYWFFbU9NUGg2KytpQ3NZdW1nT2k1?=
 =?utf-8?B?WjNGNkdyUFpnVXlIZjM4TmJlMUlaUENvTGlTQkJNazYxdmx5N1lUcUtsaU42?=
 =?utf-8?B?eHpRZGIrS3c5VjRZbzV5M2NjNXJSRWlzNmdoUnBSWjBENU5XWU1YY25XQmk5?=
 =?utf-8?B?TEZRc1FwRGwrUm12YUI5RnJKY0NhaWNzdG5HdXpzVVZZUTlpUTV2MnprR0Zn?=
 =?utf-8?B?NGVvcEpyRHBIVGI4K3Y4eFBCNExWSG5td3E2MTY1M0R2TDVVY2lLa3F0cEg1?=
 =?utf-8?B?RWRuczRLdTRyaURpSkgzSlkwSUJvOW03N2hvUmFEK3BGU21ESUJnaGU3MHhG?=
 =?utf-8?B?YjgzNUlnTm9YMFRDMmZxV1VkZi9acFhGTzN3T0xDcE9zdnpFazUyWUZhaWZC?=
 =?utf-8?B?NDVURmhQalBOSVBjQUd4NWlDUWw4SVhwcS9ZTUYzTWR4a3ByYnlXVDFjRmUr?=
 =?utf-8?B?aWF6a1dMYk83bkV2WS9LWTNGSy9sQmhLclVIdSthV3FBSnpCOVV6d1FuVVRK?=
 =?utf-8?B?aUVFVXNRMGtwMWlvNWlpTThlQnc5SkNlejZSMjRNVG5lbndndFU0VVlnNWV6?=
 =?utf-8?B?NzNWYk1MV1pCMlZIUTZ6U0doQ0dmL0JmejcrNjZEQzBZSGVqYmZ4U0lqQ3RR?=
 =?utf-8?B?SG1Da29Xb3dvR1NXaEdXMDBoRVlTcE9saS9CL3p1Q0REWlhjV0ExM0Z6amNz?=
 =?utf-8?B?TXVvL0g5bnNNRkZJcnlsZ3h0NnJadnZ3MUFaZXZXcm11eVc2NlhLd2VYVU5o?=
 =?utf-8?B?S0k3UEFJY2grZjh4d2pOTXpZaGFSUmY4aUx1Y1V5bDA2L1NPbHp6bTd2Mk5w?=
 =?utf-8?B?VVRyQ1lTZGJJMWZPS2duaUxLZVA4aVo4OVkwNTdlcHFYYmk0T1daQnQrVlNh?=
 =?utf-8?B?cDhncEpGUzlaRGY2d05OVGNkTU12R3AxV0t1ZUtYczZ2VGM0ZGIvd256amkz?=
 =?utf-8?B?b0Q2cHd3cWdpUENCenBGdmt5U0ZCYkhlNmZmK1k1b1Roa1d5Y2N4VmVLSFM0?=
 =?utf-8?B?c3VERDZFYU9yUkE3SzJSVGZUTGo4dlN4VjlsMXI3MHU4eDNNazhvcFZvK2Zx?=
 =?utf-8?B?Rk9DOFA1dGlseTVJRDhZeVlkb3lYbFJJRzJMY2dnMnpkZk1CWG5mOUFLMVVu?=
 =?utf-8?B?MkxVK0g3bW0yYUJDejdjWkZBOVZQZDJYWXhPUHNWSVBaZm1Ta2VFMUlrQmZl?=
 =?utf-8?B?RVZkMGRwUHhFMjBrRGdKYTUzb2phN0xyRy9MNDRuVHJlRlo3MjErOUIxYUk4?=
 =?utf-8?B?MU5aOGhwTXdDVURHVnlnWUd6OFUzeEYzUUQ5WnVabXB5WFVaOXZuOWpuYWx3?=
 =?utf-8?B?REtwUWFPWC96ZWVTeG1INzNxVWlxMFQ2dTBwVFBqOHAzc25lY29BbnU0T3dE?=
 =?utf-8?B?L1NYVlRleHY0WDhpWDlxRUFGRWZ5ZEdHdEsyNXhmaTRXUmc1L1ZCdUUrQUQ2?=
 =?utf-8?B?K0p6YWZWWEdEbjlvcm91ejYvb3VlL0RuK0VZMXBJSXpQYU9oTWQzZUdQL0Ns?=
 =?utf-8?B?SGN1R2phS0xYeUFFR3FZNjNoVC9mVVgvTWoxYjlPaGlSRWFQdldQU2xobmZ3?=
 =?utf-8?B?dXFNWUM3WjAvanVRWmpndmIwK3FxbG5GQzFRVTBVU1hpanplZU8wZFkvakhF?=
 =?utf-8?Q?UjTtt4IpmZWkQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <306C17A71F610148BB7F5FB742460E60@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fa2e7c-51be-4e47-f47a-08df47cf3daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 12:59:12.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA0P291MB0248

VGhpcyBzZXJpZXMgaW50cm9kdWNlcyBoZWxwZXIgZnVuY3Rpb25zIGZvciBhY2Nlc3NpbmcgUENJ
IHBvd2VyCnN0YXRlcyBpbiB0aGUgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sL1N0YXR1cyByZWdp
c3RlciBhbmQKY29udmVydHMgZXhpc3RpbmcgUE1DU1IgYWNjZXNzZXMgdG8gdXNlIHRoZXNlIGhl
bHBlcnMuCgpUaGUgaGVscGVycyBwcm92aWRlIHR5cGVkIGFjY2VzcyB0byB0aGUgUENJIHBvd2Vy
IHN0YXRlIGZpZWxkLAppbmNsdWRpbmcgZXh0cmFjdGlvbiwgc2V0dGluZywgYW5kIGNvbXBhcmlz
b24gb3BlcmF0aW9ucy4KVGhlIHNlcmllcyBhbHNvIHVwZGF0ZXMgdGhlIEFwcGxlIEFpcnBvcnQg
cmVzZXQgcXVpcmsgdG8gdXNlCnRoZSBuZXcgY29tcGFyaXNvbiBoZWxwZXIuCgpUaGlzIGZvbGxv
d3MgdGhlIGRpc2N1c3Npb24gd2l0aCBBbmR5IFNoZXZjaGVua28gYW5kCkJqb3JuIEhlbGdhYXMg
aW4gcmVzcG9uc2UgdG8gIng4Ni9xdWlya3M6IENhc3QgUENJX0QwCnRvIHUxNiBpbiBhcHBsZV9h
aXJwb3J0X3Jlc2V0KCkiIFsxXS4KCkNoYW5nZXMgaW4gdjI6Ci0gQWRkIGhlbHBlcnMgZm9yIGNv
bXBhcmluZyBQQ0kgcG93ZXIgc3RhdGVzLgotIENvbnZlcnQgUENJIGNvcmUgYW5kIHF1aXJrIGNv
ZGUgdG8gdXNlIHRoZSBuZXcgaGVscGVycy4KLSBBZGRyZXNzIHJldmlldyBmZWVkYmFjay4KCkNo
YW5nZXMgaW4gdjM6Ci0gTW92ZSBoZWxwZXJzJyBwb3NpdGlvbnMgdG8gdXBwZXIgbGluZXMgb2Yg
dGhlIHBjaS5oIHdpdGgKICBoZWFkZXIgaW5jbHVkZS4KLSBGaXggaW5kZW50YXRpb24gaW4gcGNp
LmMuCi0gUmVuYW1lIGZ1bmN0aW9uIGBwY2lfcG93ZXJfZXEoKWAgdG8gYHBjaV9wb3dlcl90X2Vx
KClgIGZvcgogIEFQSSBuYW1lIGNvbnNpc3RlbmN5LgotIFJld3JpdGUgcGNpX3Bvd2VyX3RfZXEo
KSBwYXJhbWV0ZXJzIGZvciBjb21wYXJpc29uIG9mCiAgdHdvIGBwY2lfcG93ZXJfdGAgdHlwZSB2
YXJpYWJsZXMuCi0gTW9kaWZ5IGBwY2lfcG93ZXJfdF9zZXRgIHRvIHVzZSBgdTE2ICpjc3JgIGlu
c3RlYWQgb2YKICB1MzIuCi0gVXNlIGBGSUVMRF9NT0RJRlkoKWAgaW4gYHBjaV9wb3dlcl90X3Nl
dCgpYC4KLSBSZW1vdmUgYHBjaV9wb3dlcl9ndGAgYW5kIGBwY2lfcG93ZXJfbHRgLgotIEFkZCBy
ZXNvbHZlZCBTcGFyc2Ugd2FybmluZ3MgdG8gY29tbWl0IG1lc3NhZ2VzLgotIExpbmsgdG8gdjI6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTc5NTA5Nzk3MC5naXQuaGFiaWxl
cmVudHVya2VyQGhvdG1haWwuY29tLwoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDI2MTExODE2MTU1OS42MzYxNy0xLWhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbS8gWzFd
CgpOb3RlOiBMTE0gYXNzaXN0YW5jZSB3YXMgdXNlZCBmb3IgZWRpdGluZyB0aGUgY292ZXIgbGV0
dGVyIGFuZApjb21taXQgZGVzY3JpcHRpb25zLiBBTGwgY2hhbmdlcyB3ZXJlIHJldmlld2VkIGJ5
IHRoZSBzdWJtaXR0ZXIuCgpIYWJpbCBFcmVuIFTDvHJrZXIgKDQpOgogIFBDSTogQWRkIHBjaV9w
b3dlcl90IGhlbHBlciBmdW5jdGlvbnMKICBQQ0k6IENvbnZlcnQgcGNpLmMgdG8gcGNpX3Bvd2Vy
X3QgaGVscGVycwogIFBDSTogQ29udmVydCBxdWlya3MuYyB0byBwY2lfcG93ZXJfdCBoZWxwZXJz
CiAgeDg2L3F1aXJrczogVXNlIHBjaV9wb3dlcl90X2VxKCkgaW4gYXBwbGVfYWlycG9ydF9yZXNl
dCgpCgogYXJjaC94ODYva2VybmVsL2Vhcmx5LXF1aXJrcy5jIHwgIDYgKysrLS0tCiBkcml2ZXJz
L3BjaS9wY2kuYyAgICAgICAgICAgICAgfCAyOCArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
CiBkcml2ZXJzL3BjaS9xdWlya3MuYyAgICAgICAgICAgfCAgMiArLQogaW5jbHVkZS9saW51eC9w
Y2kuaCAgICAgICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgotLSAKMi40Ny4zCgo=
