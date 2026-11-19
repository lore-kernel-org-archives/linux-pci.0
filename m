Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098954;
	b=dhZWnUyjMhzqGF6lRXQiFh+E0kk3RlNXDWNyd6RvhgTdYzH3Td5dFAucJOs94tcDW8Y2
	 2wXMNSyMNIqq+pxSsJx5PJDNzmNvO0VOhA+pM4XlZZk8aNJmFwhAWP6WmF4TEZ+JEMzal
	 dP7tJZY4Rx8y9pSwvYaCLGN8wzxBhCckqM7pzPkrt8PPlErwX4au++K8ZVTvzKk5EuCvH
	 QKtmD9B7HVYUJPBrJa28ESi4F5kMQZzFhHMdi536CxCHaJuQdQ2jn7qXTC9KzZM6Llp7q
	 Y/7CNu/52roO3mnYyUKaNVVL6nX1aoBZP1e4EImFU4GmWPDlbj66tduNo9LDLxxkIIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098954;
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
	bh=JBLwyyY6pv9F5J0Ao1Viy/iSMb98x+mbrEVmnR8YX7o=;
	b=jQteHlIacESyog/Otlz205h6S6Npaz7jpJJtgJLEr2iyPloplMfVGMgbYImBZ+x75vmt
	 5kuXF+mDlRO397RXjrQbMChBA3X9bqWSaavvY32OWjciT4COX+3gf2wnPcLiNJQHtSVYZ
	 UpBApSZ2CCHbQOZv6axz0wOECUBzB92hyb6Cc7O1UzBSU2Bm+2QdyzbU5YTq1+4YPDNvS
	 FATKKReDbN8GylRcT3MwOKDboogY9zN6dHKpflk9T9N+wnW8ACBRlLMYHvxuwdBPDu4kO
	 uKQtebtjAd+uEpeb0+pfLaNVbiFRF+tMT7D7ykVlU0UwRosq0LFsPVkFbDl2wXIEBOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bYrccoN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.21
Received: from WA1P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19010021.outbound.protection.outlook.com [52.103.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85460A2611;
	Thu, 19 Nov 2026 14:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E85460A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=bYrccoN1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7jem0BGZFV6ittCMNB5xiauyF5r2kUeZGvoh3TNXxW+TbPVYzOVgusySCvZ4EaMRz+B5CQZflz3/0tZYfcYYYT7SukepuCUT7BpbnnWNg8ytFFxfS4+x47NmxdSeyjZQ+OVQL+YcxYhQNvZw3yWVhah0+vsADnnBCA1ZYoiJkeApXXactxbdBlAK0hlgZcNLMivueDz4kysKAWSEUPZE0ht4trzrphNxrJKa8xJZ8O0vy/zpjOB96zu7WR38DBD6hXVVQAC1Vy+VI3UHmiYPyu8VATEgUUP1OFToc5UvkScA1OmK1jyIA4MB/E4ZyTTVF15Zm5WPo/opvmeeO7Xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBLwyyY6pv9F5J0Ao1Viy/iSMb98x+mbrEVmnR8YX7o=;
 b=JMFv91Hx8JjX47bL5oHXJit5eYPLbz3Fcs4s0NrhjlnDURNdhMwIH6NJJZC2I/LYA59W+GuvjeeVpeokWQ3Abzd6N+qlw9xDd9vcnCZmVAWp6DMtoAQKyExRpk+m3rwvPLJ82j3Gut3uH4CZFq90wfRwutqD3r71fNTR6ZerqXfRzwCj5B2d4t3CXIVYGXOCQZSOU5g0NOBVZIsFYMkkLis381a4zX4NB+L4YwDrUg1Tmcm2SUNH7VEcymjjV14WFS9dSitI4l2L7aN0NJlCt8QaS0coB2GWZN5u43H3my8GWUWDzK2CKpozuO2JFCzC0AhuRuTf3731OCFgaKEIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBLwyyY6pv9F5J0Ao1Viy/iSMb98x+mbrEVmnR8YX7o=;
 b=bYrccoN1QRTWaq2ChjEbeJYqqpZ5nA6EmN3SalNTIFgoCDSWBc2vbOU2bEi+MKqNyDV5F42N8OoqWqwBKQc4/tdX5bnhVfXLLrC5p7LHXl8ZlHalbfgJ2QgwP8deDDcgLzUB3w2x/QQmZLxMzfBhag+AgDsERSbm3PMXb7uiBDgSQ/Ql2M0U0pHv7GrkNU1bjx28D3nW7ldBD37aSWNocRyu7/HMgz8QiP9I+DE/oUYxq9nAG4RvvskezKvnvdjmj0dFFqCu579k+ClWv36zykqIFj7qF4Y6f48Im31Hogr289ZlnSceC9O06k5Pf+GeFqHucS4enpAnMPdt+eZbnA==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB109571.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:35:50 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:35:50 +0000
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
Subject: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Topic: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Thread-Index: AQHdeDNGToMhTgBsW0WxP5JvTKrwTg==
Date: Thu, 19 Nov 2026 14:35:50 +0000
Message-ID:
 <b690019334998f34feb12ee06db7e99c76815bbc.1795097970.git.habilerenturker@hotmail.com>
References: <cover.1795097970.git.habilerenturker@hotmail.com>
In-Reply-To: <cover.1795097970.git.habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB109571:EE_
x-ms-office365-filtering-correlation-id: 55e43203-61a8-4a22-bfca-08df464a68ad
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AHliBZFaAR8+eRqjJW6VNAPC15v/xufRLEUOLq511fzWqantG+MuQU79dhu3vjS7zX0e3mHiZ86R0ZA8Hj0WhTHKoyUcfZR3/M0vfuTWXfA5sR8APW0GhltBOVszIFF0S+xygPsCMj42FXrRGpt3YMrH8R2T0NnOloSoT2EE3r4QdVKIQa2t7EdcjCVN701I3axyehp6R+waKRpgXhYYVf3RCTcg2Pan42wcKPUD5s2MIEuHJG1Zuo/bS9fgZsSEf59WT4FBPxW+01vtKiVj3HaZ9uvnFy7063t2/OhqtiBwmGKWPSeAlkbBvAHzX1bsUw/1OQg7r4AOhKgpNG5XwtadML7FUfCnngV1pidMQ91QKA9xkuxbE5p88Fe+R5uogDk/5jUBL7ueS6SAnnFcagVSX5SeMcZSJ34VlC/A2PCgXoScNuu6IosuT4hitx8Lt0y+cTQYeKp9d5Jkah+EOJLr5qCcMuSFswK28DgX5akpBgZ6HrIDNVdb4h17x102dyAG/JW456wkRMX4tSwgbNTCZLlypXstc1UwsMfrYnu5he6EpRkfBMWVKBaPSGG6nJ9VqmuNHsqzLCIa8liPLSDmRCVzd/kW+TslQbcguMYWjiLKxWcpAp1wwgxNUYduqYqUNbyEDY/c2tbnjGuCJI2AcP2YVtNrL7EOid9qHn/zzq8BATWh50nop7D9fNxzpHnRcbkaTT8YLlpdQJwM6hZBMKoLfvoVcISYgp6YdBcFxWxjjD1w1wMb798/Qzspy
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|51005399006|25010399006|24021099003|55001999006|8060799015|38102599003|31061999003|12121999013|41001999006|15080799012|21061999006|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHNISTBDNEV4K0hYbDkrZGg5YVZZMVY1WWcrOFptUzVCN3JWMWRPaUtMaEJh?=
 =?utf-8?B?Tnd1amxncjQrQlZhR0ZHalIwT2prTFBvdmtqaXJCdDNhL2E3T0VXQ3R4S1lQ?=
 =?utf-8?B?UWRkWUR5cWpRcUhSMGE2NHFTak1RYWlpMy9BYnpjSHk0M0p0Mlo1OVg0eFZG?=
 =?utf-8?B?aTY5dTlvMDlBV21WclloQlROSjJsYkdhRGlNVndDOTUyVUlqYy8xcmxkK0I4?=
 =?utf-8?B?anhQRlNBa2Erb1lRMm1jSVpxUWdJV3pjTzNyeURSNnNQY2JxWWtXUWhsYU56?=
 =?utf-8?B?MG1oRGhGSFZ3Qm9XRXR5Nk1IVDI4S2s1T1B3N25CY1F4Ry93Sm9kYW5ib1NK?=
 =?utf-8?B?OUdZdGpSMnI5YWNXZTFlTmhPa1Q0MjhNanFDVXlzTkFkVWVzU0ZuSENFdWF4?=
 =?utf-8?B?NUUyUmxyekdtVmplay9zeHY1ZHVncjhYaGFsWEE0R1dKNjZXYkZ2bG4rSmhZ?=
 =?utf-8?B?ckJtaDFvdXhINFlPZzdVZzRwNSsxc1Vhek9Da3QyUWZmR1l5aTl0Wll0NWI1?=
 =?utf-8?B?ZHkwQ2I5V0tzOFd1QTZHMGpIQlI5KzFQK1pRSStrRll0Rk53R1J4ZzZlL3Nl?=
 =?utf-8?B?SG9mcld1VDh0SnB3d1ArK0NqMys4MzFKWDJ0Um9wMmpKSFdYZWNmdmVTQlk3?=
 =?utf-8?B?cWcyZGVXYTZ1Q3BhZEZ0MGFMT3g0RlAzcUR5MElsbWFOS1ZmZzVsK0o3dk9O?=
 =?utf-8?B?TXNUSm80NWNldG9iVEdOZXROL2NDVlErSDI0cC94MWloY294dENLTzQvSVJ4?=
 =?utf-8?B?MmxxVldTRVFJbENmU3ZncGtqRzFLM1dxZnlJeHgvSGpTN3I1bUZma3Ivb1F5?=
 =?utf-8?B?RUZSS1B0YWYxcE4zYklHUi9PYVF6YUIxSkNJd1p3SzRnVHlObTJsMVg5cGth?=
 =?utf-8?B?aitWZloxMXZTSnFBUWdUSS9wUTBHdWxybjV4UHhLZTc1OXJudEZTdUNqRHh0?=
 =?utf-8?B?UkRhMXk2SkY5QnVnc25EN3NNT09iZ01pdmlJUlZvUFlzQXovTFA1MlI4OHc1?=
 =?utf-8?B?cGlCcjRLTjRYOWhEUU1Ga3RjL0E2ck5xRTVDTExrWkdJemhuT05BcTdZR1RT?=
 =?utf-8?B?YnQwejVwdVpjdUI2R2NJRjBIdjh1ZW0xYXl2SFJRUVA0YURIcnlIRnZOYnky?=
 =?utf-8?B?OFd5ZHE3cVpFc2NWak9UWkpsdXBpY1NiT2VsNUR6Y25nY252NUk5UXg5aFIx?=
 =?utf-8?B?dzlFd0Y1VndoMHJEeXRFUDBoRXFSbTU0aHJWQVNYeFZ3VE5zb2sxWVVOdkRP?=
 =?utf-8?B?WENsL2wvZjdxSFlJQjdsZEpRUUJLSFlUYlNKUVpVbzlSQ1pXVllUaTRtaXR2?=
 =?utf-8?B?dXFSUVFxUTR6Y1ZCV0FkT1N2RUR5UjBaWWxQbGVlRlZNcnVSTWFONFhFbWsx?=
 =?utf-8?B?NVVIYzd5eUVvYlpjMnM4M0M4UmpkZW9OdlphL3V6VkNFTjhOQUVjTTJ1akIx?=
 =?utf-8?B?QmhJMGhGOHZ5L0dTSkUxRU9RZXlZUWRReDUyTERHTVU3VEVKNmlzYW53anVv?=
 =?utf-8?Q?nSd/LFkiVtXNSrSRfH9OQSbQfhg?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uzc2by9JNGVyM0VrTG5LVGtZQS90YnoyV3pQZlcveXlOeUROdU5FMFdvWmdE?=
 =?utf-8?B?Wjh3Z0JuUGplRGFoeVRiTWdmb1ZMZE9PQkZVbmlrUW94aUpXRWdxRzZraFZt?=
 =?utf-8?B?MWVVOGdrZDhTUzVjc2c5aERaUkRFZUlGT2drL1AwNWM1bVArOW1uWTRVVGQ1?=
 =?utf-8?B?akNQUzlHMCtZeC83YVhZSThlZlJzaEJRT0ZvWjdpNnFLL3N2cjVjSGoxbzI4?=
 =?utf-8?B?U0VYNFVzdVNaR004ODNYbWhHL0tNc1ZpU0owYkZFRE9qZitlRk03UHhXNWxj?=
 =?utf-8?B?RVlqVU8vZTNJMnF6c1lGTkJ5Y0c5MXlvVGJUeWFLeVdHclJZM0p5NUxhWVg5?=
 =?utf-8?B?dFRjNlNWMlZiYUlJS1krNG1rZkFHc2xaSlhxVFhxbVpxdXdVK1ViVzNxb1Rl?=
 =?utf-8?B?cDMyWlhxU3A5dDFMYVpzSGhLeEJUS0prRW12NFJRdkE1bnM3MUIxQndvSTRo?=
 =?utf-8?B?aThwbEx5L1ZSdWZOK2NqaCtzQStNa0puMkJNczNVRDRydGVoRlRKWjQ2RXJh?=
 =?utf-8?B?OUFucVN1Rk92MkNCY2pRQTRNOU9JbktBWnJ5aFVGSUlkUUNyMTFESlowSXZG?=
 =?utf-8?B?RXp4eE9sQzlFcmFJZjB4R3prQzFYRnBxaUtTWlhkUXVoQ2djQmphOUZmcml0?=
 =?utf-8?B?ZmIrVjE5QVZ4ZXQ2MWJ1dVEyMFUybnNXeTlPbjNWeEFTVWJQZXJiSTFoRVdm?=
 =?utf-8?B?Ry9BclpWRzZ5ZDRSejkvWm5SNjRoZTc5RFBxNTFlNThaR3JqNk94a3dVczdp?=
 =?utf-8?B?NHlaUlhZUTVRc0FiN0V5L0lnaFVhalM1RDFQTGgyWXRvb3NDYmhVZytpY1lh?=
 =?utf-8?B?ZklNSlQ3NVBTMFlCRHFQRXR3eFhKRkR0YWozeVNrQzZmakE5ejhrQ3B4MTNm?=
 =?utf-8?B?ditiU0JldUt1M2RyNWovRnd0ajJTVStvbnlnMkpzS1JIYVJkSUtudlNVU0dO?=
 =?utf-8?B?L3cwSnQyQ2U1ZS9HZzk5NEpyalVFZW5WNFBVZ2F1a3ZRS1hiZmpJOVB3Zkl3?=
 =?utf-8?B?Q1N5OG5xVkkwSmlmbU03SERFL2RJTTlrazJYazZlQ3k1OWNtN2lRUFhjVUFD?=
 =?utf-8?B?dzZvYWdKbTRhWS82cTdHbHUreStqTVhDbVk2aXRsL0wxVXBFV3hRTklwWEZ4?=
 =?utf-8?B?UG03Q1JmWlJFcVhPWlJ2WVFKUHpJWjFobkxLUWs5RFFXUE1Yd0l5YmNsZE1P?=
 =?utf-8?B?RmYrSFV4ZVYrR3V0TFk0Rkc5RUFyd1hmQWtVMUVsOWR1UmlQN1VMaEU3Vm5D?=
 =?utf-8?B?WUQ5Sm5zOGY3cE5GeWVTVnF0eDM5YVJpYXNXbnRoQ24zaHo1Vm05Mlh2aU5s?=
 =?utf-8?B?RWlWc3hudFNTL0F1MCtQcmQ4Umk0bTdCQ01MMExFU2RuSkpBaWtELzdEV0tN?=
 =?utf-8?B?cGFUbTFlMUlqdGQ4MnJ1SGtsNjdmUVNJRDdNY0Zod3g0OVY1c01ZWlo1WFMy?=
 =?utf-8?B?bFVySEJoN2ViNVhaZXl2NmJld2hoUDlkaXNocDZEQlBLRncyTzIvSm9pdk81?=
 =?utf-8?B?dkgvK1BncXJ2RkM3RVo5K21Da2lHREgvc0locDgvVHJ2SnZ0WFBhSFNZWHUv?=
 =?utf-8?B?TmlMK2tVeGVhNWtkRkliZFQrdTA0alVxZnRkbXhVYlVVaVZuVE95ZWhhc2Nn?=
 =?utf-8?B?R1NsdEU1dUkxbUVGWU01WVhIRUVCdHN0UFI0ZE9jZ3B3U3JidWlkZTZWdzFS?=
 =?utf-8?B?TTgzT2pMT0VnQkEzaVczeE10SnA3anhYRDZ5L2RXNWE3N1ljazlSVk8yVS9s?=
 =?utf-8?B?dzFVcE55c2Nqc056Wmo0VFFKeGRwMGRLYWxlUjN3Mkx2MW11ZFBheFNKbFZs?=
 =?utf-8?B?SU1ScTV2Qkw1TmdaMVRmOHcxNUh5aEFSOHlldytoVUVhZ2V1aWZJaytDMFZa?=
 =?utf-8?Q?sWWyTK79JDVJg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73E06E78F59FF44DAFCF1F89969C341C@POLP291.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e43203-61a8-4a22-bfca-08df464a68ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 14:35:50.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB109571

VXNlIHBjaV9wb3dlcl9lcSgpIHRvIGNoZWNrIHRoZSBQQ0kgcG93ZXIgc3RhdGUgaW4gdGhlCkFw
cGxlIEFpcnBvcnQgcmVzZXQgcXVpcmsuCgpTaWduZWQtb2ZmLWJ5OiBIYWJpbCBFcmVuIFTDvHJr
ZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCiBhcmNoL3g4Ni9rZXJuZWwvZWFy
bHktcXVpcmtzLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtz
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKaW5kZXggNzQ1OWEwNzNjNzRkLi44
MmEzYzdmNzJkMzMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYwor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvZWFybHktcXVpcmtzLmMKQEAgLTY0NCwxMyArNjQ0LDEzIEBA
IHN0YXRpYyB2b2lkIF9faW5pdCBhcHBsZV9haXJwb3J0X3Jlc2V0KGludCBidXMsIGludCBzbG90
LCBpbnQgZnVuYykKIAkvKiBDYXJkIG1heSBoYXZlIGJlZW4gcHV0IGludG8gUENJX0QzaG90IGJ5
IGdydWIgcXVpcmsgKi8KIAlwbWNzciA9IHJlYWRfcGNpX2NvbmZpZ18xNihidXMsIHNsb3QsIGZ1
bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwpOwogCi0JaWYgKChwbWNzciAmIFBDSV9Q
TV9DVFJMX1NUQVRFX01BU0spICE9IChfX2ZvcmNlIHUxNilQQ0lfRDApIHsKLQkJcG1jc3IgJj0g
flBDSV9QTV9DVFJMX1NUQVRFX01BU0s7CisJaWYgKCFwY2lfcG93ZXJfZXEocG1jc3IsIFBDSV9E
MCkpIHsKKwkJcGNpX3Bvd2VyX3Rfc2V0KCZwbWNzciwgUENJX0QwKTsKIAkJd3JpdGVfcGNpX2Nv
bmZpZ18xNihidXMsIHNsb3QsIGZ1bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwsIHBt
Y3NyKTsKIAkJbWRlbGF5KDEwKTsKIAogCQlwbWNzciA9IHJlYWRfcGNpX2NvbmZpZ18xNihidXMs
IHNsb3QsIGZ1bmMsIEJDTTQzMzFfUE1fQ0FQICsgUENJX1BNX0NUUkwpOwotCQlpZiAoKHBtY3Ny
ICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSykgIT0gKF9fZm9yY2UgdTE2KVBDSV9EMCkgeworCQlp
ZiAoIXBjaV9wb3dlcl9lcShwbWNzciwgUENJX0QwKSkgewogCQkJcHJfZXJyKCJwY2kgMDAwMDol
MDJ4OiUwMnguJWQ6IENhbm5vdCBwb3dlciB1cCBBcHBsZSBBaXJQb3J0IGNhcmRcbiIsCiAJCQkg
ICAgICAgYnVzLCBzbG90LCBmdW5jKTsKIAkJCXJldHVybjsKLS0gCjIuNDcuMwoK
