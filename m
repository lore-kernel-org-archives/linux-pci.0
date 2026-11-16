Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835286;
	b=plYaHknBR1IiHst7fQeLFpXpKuUbfprqJFE9d2id9RPkoPFg/ogkGVdIvU8q9UrrkH6z
	 m9Z9ANMfCMpOD2hIow7+JR5xRE/1pMG9YHgL88MNwFXY/H/T9heQnRljj2llkZit2ffmS
	 oZeRlqmoOSL8yqspSGcAU4EvaUPpm8turO21oF/Hpez30oCc7KByo4ouCzaUpRZNBQNVB
	 Fteb58y63jsF1EVHJVu0EOv4UQb1EIVfW0jW/VJr3mfmG55p4EKXdFiw3Ixy3b0WuEE2C
	 gjECivsvM50fwc8CbhhrAMn6GM8PjiuOpG8XuaakVZNHFteqA9HW0QGoAD89QGaqZCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835286;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=czGVo6sc/VLLyDCkaUbXfNRdbjC3jiOvnk7B0Mk8jno=;
	b=EfNi0U2Po1LHUm3D9uaJ3nslHqwx/1jej3a9eevFUWCO01R3YJPkFq7wqk3OvmA8qWPd
	 ApdwY0QQGFzboHi5nAUI7TilSSQF82L9D6Us6oqyZw1tPoxBnJ6Ov38uSY1MZirq1tOtA
	 IDHI2ieygH30cBWsd7endBioCw63v3orwEJzAPn3euvorl+CslL4lmLFpkK55ga+6Vze4
	 tCO5oX2nYE6++DaKbnGEqBK7DIhmZLSD/QQ5sBr8ZqPlCZPRyG+m+IkdBreH+OY7jQIO4
	 H2Febxp10mbp32+kLyhOlsKpuyiEnJKPwEOuDDkDRr84RsF5XSzSd0tZ5Erp9f5G1SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="Wy/HAWSA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.86
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013086.outbound.protection.outlook.com [52.103.43.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F611606A31C;
	Mon, 16 Nov 2026 13:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F611606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Wy/HAWSA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDg8fykwhbXdwwYJIaUUWSB4cykwoJrPRR4rLzpR1K1dei0InUJtAMPsYb1fHobKkiIGWhqJOg2bdQLWNRGb/zZSqkIdIcGMNTSqZOHedZKq96qDEKOzcuEgQwUJ/LgxtAsEJJNzRNx0ps0vzMx/1FqeU4EPVQnEGfRAaCIgl/R/uyvcuPn/hXTE6pmOlGCeQODUdFV5HEaLp3tdSa4sngtviVoesrH0OmEplFN1LXPuiwZbMgV4+qhec0dTAesOeCjgzlN7HogSixZRWr2PhJW52U23AN3INQfmXG1V8j9PcFN3Js/HD7sWRGa8OfD+aFPb+xxRvJw6ZjxNLBuDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czGVo6sc/VLLyDCkaUbXfNRdbjC3jiOvnk7B0Mk8jno=;
 b=KHqWHKdjs8LXSlxjhS28fNgBpCjSRtb+nF5HEH/dUVN+HONde+KR83OoyB8jHVE5UaVWONjkepsMzBHRIHyv4NMOhBagkHLPOINJpky8r4UWJ7Xs2C8PH1k75S6ARLy/9T21NOOdJSz9QGX9DYLaF6WZX+SXISjHqtzAr683VAuiRdkFE0fX5AfbRE7XwgxX8PEqz/hmRNnONyU0wRA0zDLmt/bVZrzH/OgzVSkBrA01/EeM37jID5Em+EyRgcZL8wHNBET3olpdOTqPD488Ir09HbfakGUcvKI+Y7MQutM6vhtbyNVKRFJXILSS+hNvb9jPO4tobo2RRhT6M7i+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czGVo6sc/VLLyDCkaUbXfNRdbjC3jiOvnk7B0Mk8jno=;
 b=Wy/HAWSAAvLKyVg63Bej0iYMBA9Ne74WC29aM1LMby/bcqwiUfRKNVxOl4L8Dxl3GS2QTYMwqn1a+0Q3zcj12r4Ok0tYBeYoT+98Gvj2gtaMRRChD9V9UZQeOvXBEKumTsTuD3dGhCG5weL/fzW4WdUSBb33Bmua5/aMeg3cuP1ShG9lFgluDTFHY8HuvmVIGHwMKIT/JsBQShS5oH+KPsf3TOPj0Xj/NTNXViZWroiaQAXzPpwG/07HY3JsYoFKeBt8Usj5I3safbbbyAWDT4nxzNiID94gvM+rXPYGS9WvWYKEHuqejWdu0ezbCHQXuwouW5x6BE55bpnYdrQvJg==
Received: from JH0PR01MB5779.apcprd01.prod.exchangelabs.com
 (2603:1096:990:49::9) by TYNPR01MB8269.apcprd01.prod.exchangelabs.com
 (2603:1096:405:3c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:21:17 +0000
Received: from JH0PR01MB5779.apcprd01.prod.exchangelabs.com
 ([fe80::1d17:30a3:e2ff:4f45]) by JH0PR01MB5779.apcprd01.prod.exchangelabs.com
 ([fe80::1d17:30a3:e2ff:4f45%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 13:21:17 +0000
Message-ID:
 <JH0PR01MB57796AD53E6089D3254A76D6DC7C2@JH0PR01MB5779.apcprd01.prod.exchangelabs.com>
Date: Mon, 16 Nov 2026 21:21:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Add ID@path device format for pci= parameters
To: Ben Cressey <ben@cressey.dev>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
References: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SE2P216CA0115.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::16) To JH0PR01MB5779.apcprd01.prod.exchangelabs.com
 (2603:1096:990:49::9)
X-Microsoft-Original-Message-ID:
 <40dd25b9-2b80-462a-9be1-b8daaf4dba30@hotmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR01MB5779:EE_|TYNPR01MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 061dd9bf-f5d9-4224-079d-08df43e47e47
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|37011999003|12121999013|19110799012|41001999006|23021999003|15080799012|6090799003|5072599009|25010399006|4140399003|19101099003|440099028|4302099013|3412199025|1602099012|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzVrUHVWeVZnemFybTRpOENHdzY1azZ0R0lzckxvZm91UGhVdVJOb2NGU0Zi?=
 =?utf-8?B?RGxLMmpDajB0aTlPY0QxSEMyaUZlR2FTYVlmZGJsQkxycnlaaWpUbkpxTVFk?=
 =?utf-8?B?R0owcU9ZT0ZLVVFwQUs2VHdBN2VFUkVDcHFyT2xSMUFjcGN3QXhqektGTlZ0?=
 =?utf-8?B?WEV4cnBRcjBwYVFBRmVoSnNvWktGbTlCbForckoxMGZRd01VK0VjTEFNeWZJ?=
 =?utf-8?B?TGFIVlVoZ1FtNktZUnh5Q1VaWHhJcWplUDQyOUZBbzZrd3BBODVFNGd2dzg2?=
 =?utf-8?B?bE0xTnB2eUthbTBrT1ZGRG9ib2UwajR1OE43cDJNRFMrVDNCRnNsS1RBandC?=
 =?utf-8?B?NzFnR1A5dWlQQkNaVHFPY1JTWUJIUHZZMXVXK0dHNHZTVlNqY1J1aFhnMTdQ?=
 =?utf-8?B?Y3M0VzY2VjdZdlIxVnJVUXpKSUtuRnJhY0Zhakp2dVRQa0QxSG9oN1RGSzNz?=
 =?utf-8?B?eVIrUUlGMEo0UXI4U1B2VnpDQzRzbGd5dGFDWXZtQVpnK0tvVC9lcFEra1Nn?=
 =?utf-8?B?ak5FeTc4bWVMNVhUVGNEcFBBcUpHL096NkFOQnRjUk1IRjNveW4zd1dTZkVo?=
 =?utf-8?B?OWZuZ3l2OXhhVkFPampSaDlWUnZZdFJIQ2pzVlpWTG1JRldtbUJxMFJVWmVF?=
 =?utf-8?B?SHMyL2dxajA0eFJyb2ZhQjNSMElOTlVReFpLSXpFRVFkTWdjdm9SVTVBTWtt?=
 =?utf-8?B?cGFTM3lwc3pkL3RlLzViTk1qZUpJRTd6elNYcGVFczBWZXpVRDRtT3pnSHVa?=
 =?utf-8?B?VC85RVBURjdyQm9uWWtGcm5aU3N5WFBXelZLRzhKbndDVUt6SmJPVHNUdWtM?=
 =?utf-8?B?cUcwUEp5dTNQcEswcWhydTcwUE9yVVdXSFJlMkFEZ3VicVhITDl2aDAzQzR2?=
 =?utf-8?B?a1lqK3A5aTFtZXUxN0ZHVUp1S3ZDN2hoaklOV09oVmNXL2JXT1ZtWk4rMm10?=
 =?utf-8?B?S2JiRTg3TTl3Q2pTQkdoQzZIWVFHVEt0ZUF4MlkxZnN0YU5sTVZXeGRsclg5?=
 =?utf-8?B?ckRFTitabk5lTVhwNVRsQjVubWZSN0dJbnZ2aUIrNDZMMmFtZjJjVXI5Q0Rz?=
 =?utf-8?B?L29Ya2JHT3hLRzVSbTdVNVozOWlqVE5WaFhZRkwzdEsrSE9LWXUySTBYOVRx?=
 =?utf-8?B?YVBnZGhJYkd3UVoxMG1WWGFTaDdHRC9mT29xTzBPNmJOOExVRDFLS1BGQlVx?=
 =?utf-8?B?bmFkeVlqd1NJYjY3UENnekpmMXY0Z3pqd0J3NDdzeFdvL1BJM25HaGJWZXp6?=
 =?utf-8?B?SG1nY0UzY1U5c0FTVHVhd2xpK0w3WXd4K0RYcXZkd1ZNZWRVaFJVMGszQTIv?=
 =?utf-8?B?UWFvUnhkd3BESkxJZ1E2WVR1SHYzOTNRejZzeEx3TkM4WkY2RmVydjRzM1JF?=
 =?utf-8?B?aVc1SmQ1WEZQNStWNUlkS2c4a0VWcVlVUWNXWHFTU0xjdHVRSEJjTWp4OHNV?=
 =?utf-8?B?WTIzV21lNEJNZG9ldVNjUG5DbWtrL3NHM3VWOUF5UlM4ZG5scXJNWHVsUkdV?=
 =?utf-8?Q?ejLpE0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5lWVBFSlZxcG9ya2ZJanJ4Rk52YXVLWGhRcGxQL0ZPTU91dmFhdXdielBY?=
 =?utf-8?B?MTlvNEg2cWI5N0ZDSHdoQXQ1U1Z0aUxzRUpVN29KQk9TeTBlM2t4dTU0Z0x3?=
 =?utf-8?B?cmhTSzQ0T2FIM3pET3VFS0pTWnJ1Zi9ldmkrakRab1NKY25IMlNoRWZ6R2cx?=
 =?utf-8?B?eUUzbEM0aC9taC9jV3NiS1BKYkVVbkJQZFVLQWFoMVpsSVk0MG5EU0tpRytT?=
 =?utf-8?B?NlozYTZ4QUUyOHdTYlBUbWxKYlYzVTd1TVhjQWdoVlkwdGFwOXZXU0VTTlpv?=
 =?utf-8?B?K3lQbkRKaDR5K1RxZlNZMlRqSTdXTU4xTmxlNmI2SllhQldkZ1IyMTBsUFF2?=
 =?utf-8?B?UWxIaTAyTTFveVViSE8raTJGUE40eDRIR3o5UGdrSTc5Z2NKZGw4a1p3T1JS?=
 =?utf-8?B?TVlwSXpSRVhLcXBpMGtQVmd3dGdFY1dack5ZeGN4RVJKVmwzNExPeFV3c3BC?=
 =?utf-8?B?TW05Sm95OG02MklxUjBPNTJVZ3Y1ZktvbG81b2t6QUpZTHZHVkhaMnUyenlu?=
 =?utf-8?B?U0VWTnBuL20xWW4zWXV0WXZWTjJ6eVgrM3kzQVBRUjBWV014VTFuTWxaMWdG?=
 =?utf-8?B?ZE9jVi95VVMzT29IUWZzNzRVbDZueHp1VEl2UklYWFFJemhhNmxENWFUU3Iz?=
 =?utf-8?B?bmdBcS91eWZpbGUwVktpUU9SZWNkOGhZYkh4MDZyTlVzUWdUR05KNkh5V1A1?=
 =?utf-8?B?bTFVbDVXUU1xMDlBaVZJcG8wdXBBZ3h5Z3JOQXRwTDRraDJoY0VuRy91K0d2?=
 =?utf-8?B?ZXhRWWIrYmVnRkVic1VKM0J3SjFVRTFnaTBxQ1BYVXJJbExCSWpKb21Pbjd0?=
 =?utf-8?B?TUF5a3Y3aW9Xa2duTnNIQXIrZk9POS9ZeXdkVVZPVkJyZC9EaFZ4bVhkSnhE?=
 =?utf-8?B?RElSNEJMaDBqcmRyRk9DVlg5SCs4UWtFSUh3Uko1NUY3U1lrNjR1MVdYSU1R?=
 =?utf-8?B?NVpBZ3AweVB4cXRiSUFHd0NaaC9ncVR1Ym44SnY3UWFFSCtZN2x4ZWUwaXFX?=
 =?utf-8?B?RmMyTk43WWRkNlJPY2JwSG1RWDdDdEZNWGRSdUZ0VWJSQTBPU1FsVnZ6RTdH?=
 =?utf-8?B?ZEsrV1JwbmVFSHdmL0lZNUVQVllPTUdKNk91K2ZDbjRQYmVJdDdRYytyUzZl?=
 =?utf-8?B?dzJvRWxKYjZEWUFtVmo5RU5Ga25zUWlLcTdlbkgzc3Jmc2g3OEtZNm51akpF?=
 =?utf-8?B?OHpaSEdvVlJkdG44Qkt6SmphUDhEUHZpa3FyeU84c29mcm9DaVFFVVlCMmZG?=
 =?utf-8?B?b282RmtIQkdvWXRRWllDaTNSQVFDSTcvMUJGdzZybUtON1JGOW1Cd24rRXlU?=
 =?utf-8?B?N0g2Mk9ST0pYK05OM0RRaUJGbjZqWTZjUkdXRVIxU2M5Qk5WWnpVLzl3ZnpK?=
 =?utf-8?B?Y2F6TXZMa3pNSWdqeEZjcFhMUStSSmJzempib1hLNlN1SUEvanBtdjJ1QlRa?=
 =?utf-8?B?Z25FakJhRDladzYyaEZSbkdSVzkyLzYzVUFiUDJQa0g2TUZUd0U3a2xVcG9P?=
 =?utf-8?B?N3BESDJiNnJQNS84WlRkVkVVWVhJVzV5WHU1MU91c2lTcEN2N08yNzZoenEz?=
 =?utf-8?B?NjVUOStoMzRzYkRiSUFUdVpIclNMNmNqSFlhbFNXekFZNklqMG9GbkxSbUU0?=
 =?utf-8?B?eG90N0hZb2RTVXYvQlNaa3ZXMXZvblRzaEhEY0xKbW1JTHplSDRrOW5XczQ5?=
 =?utf-8?B?V1ZBeXkrdkthcng5YTVVdFZBWlc0dmhZZHh0dW1jbjdSbVIxWnRtbWR3RzJK?=
 =?utf-8?B?clVHQis4SThlMUtmS2ZBcWlHbHJmNGM3cTBiOHRqU0QxWE5VMHJzakhoS3Fn?=
 =?utf-8?B?ZEdyL1YvZlh6c0hNV2hvWENhUVlkZmNCUzBvRVh1QlJRWnFtZWlUSERYWHFa?=
 =?utf-8?B?em5JTFQvUkYrRW9mZGZxa29laUhSdU9rdExkRzllYnJBTVZXMFBYL1BlRTZR?=
 =?utf-8?Q?vO7wGVnEW6c70T1FGF6iJtCMBzmnTNIO?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 061dd9bf-f5d9-4224-079d-08df43e47e47
X-MS-Exchange-CrossTenant-AuthSource: JH0PR01MB5779.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:21:17.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR01MB8269

On 2026/11/12 7:36, Ben Cressey wrote:
> The <pci_dev> grammar shared by pci=resource_alignment=,
> pci=disable_acs_redir= and pci=config_acs= names a device either by
> address, with an optional path, or by ID. When one command line serves
> more than one platform, neither form limits an entry to the intended
> device: an address applies to whatever occupies it on each platform, and
> an ID applies to every instance, such as all Downstream Ports of a
> switch rather than the one that needs different ACS settings.
> 
> Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
> <path> is the address format, and match only when both halves match. An
> entry written for one platform is then inert on another where that
> address holds a different device. For example,
> 
>    pci=config_acs=xx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0
> 
> configures ACS on the Downstream Port at that path only if it is a
> PEX 8749 port.
> 
> The path goes last since pci_dev_str_match_path() consumes up to the
> next ';'. The IDs are compared first, and the path is parsed only for a
> device that matches them. The <order>@ and <flags>@ prefixes of
> resource_alignment and config_acs are stripped before
> pci_dev_str_match() is called, so the callers are unchanged.
> 
> Suggested-by: Wei Wang <wei.w.wang@hotmail.com>
> Signed-off-by: Ben Cressey <ben@cressey.dev>
> ---
> Changes in v2:
> - Compare the IDs first and walk the path only for a device that matches
>    them. An entry whose IDs do not match skips its path up to the next
>    ';', so that later entries are still read. Thanks to Wei Wang for the
>    review and the suggestion.
>    https://lore.kernel.org/r/SI2PR01MB4393779B4E590C6D76FD12A3DC822@SI2PR01MB4393.apcprd01.prod.exchangelabs.com
> - A malformed path is now an error only for a device that matches the
>    IDs. Any other device skips it.
> - Rebase onto v7.4-rc1.
> - Drop Anthony Vardaro's Reviewed-by, since the matching logic moved.
> - Drop the Assisted-by tag. The notes below say how tools were used.
> - Link to v1: https://lore.kernel.org/r/20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev
> 
> The ID comparison is assigned to ret with the same lines as Wei Wang's
> "[PATCH v10 3/6] PCI: Consolidate delimiter handling into
> pci_dev_str_match()". The two conflict in that hunk, whichever is
> applied second; on top of 3/6 the hunk is an 8-line insertion.
> https://lore.kernel.org/r/SI2PR01MB4393A855D592C1F484DEF778DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com
> 
> Tested under QEMU (TCG). Each of the three options selected only the
> intended one of several devices with the same ID, and a later entry
> still applied after one that did not match. The two ACS options were
> tested on Root Ports, since QEMU's switch ports have no ACS capability.
> v2 has not been run on hardware; the test on two server models in v1's
> notes was of v1.
> 
> An LLM wrote the patch, the changelog and these notes, wrote and ran
> the QEMU test, and ran W=1 builds of drivers/pci/ for x86_64 and arm64.
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++-
>   drivers/pci/pci.c                               | 28 +++++++++++++++++++------
>   2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..12b91186a1ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5038,6 +5038,7 @@ Kernel parameters
>   
>   				[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
>   				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> +				pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
>   
>   				Note: the first format specifies a PCI
>   				bus/device/function address which may change
> @@ -5052,7 +5053,14 @@ Kernel parameters
>   				renumbering issues).  The second format
>   				selects devices using IDs from the
>   				configuration space which may match multiple
> -				devices in the system.
> +				devices in the system.  The third format
> +				combines the first two: the device must
> +				match the IDs and also be at the address
> +				given by <path>, which takes the first
> +				format.  This allows an entry written for a
> +				device on one system to have no effect on
> +				another system where the same address is
> +				occupied by a different device.
>   
>   		earlydump	dump PCI config space before the kernel
>   				changes anything
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..cd5b627da88d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -343,6 +343,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>    *
>    *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
>    *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> + *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
>    *
>    * The first format specifies a PCI bus/device/function address which
>    * may change if new hardware is inserted, if motherboard firmware changes,
> @@ -359,6 +360,12 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>    * legacy reasons and convenience so users don't have to specify
>    * FFFFFFFFs on the command line.)
>    *
> + * The third format combines the first two: the device must match the IDs
> + * and also be at the address given by <path>, which takes the first
> + * format.  This allows a parameter written for a device at a known
> + * address on one system to have no effect on another system where that
> + * address is occupied by a different device.
> + *
>    * Returns 1 if the string matches the device, 0 if it does not and
>    * a negative error code if the string cannot be parsed.
>    */
> @@ -385,12 +392,21 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>   
>   		p += count;
>   
> -		if ((!vendor || vendor == dev->vendor) &&
> -		    (!device || device == dev->device) &&
> -		    (!subsystem_vendor ||
> -			    subsystem_vendor == dev->subsystem_vendor) &&
> -		    (!subsystem_device ||
> -			    subsystem_device == dev->subsystem_device))
> +		ret = (!vendor || vendor == dev->vendor) &&
> +		      (!device || device == dev->device) &&
> +		      (!subsystem_vendor ||
> +		       subsystem_vendor == dev->subsystem_vendor) &&
> +		      (!subsystem_device ||
> +		       subsystem_device == dev->subsystem_device);
> +
> +		/* Third format: the device must also be at <path> */
> +		if (ret && *p == '@')
> +			ret = pci_dev_str_match_path(dev, p + 1, &p);
> +		else if (*p == '@')
> +			p = strchrnul(p, ';');
> +		if (ret < 0)
> +			return ret;
> +		if (ret)
>   			goto found;

Nit: I think this is more readable with a single '@' check:

                 /* Third format: the device must also be at <path> */
                 if (*p == '@') {
                         if (ret) {
                                 ret = pci_dev_str_match_path(dev, p + 1, &p);
                                 if (ret < 0)
                                         return ret;
                         } else {
                                 /* IDs don't match: skip <path> without parsing it */
                                 p = strchrnul(p, ';');
                         }
                 }

                 if (ret)
                         goto found;

Either way:
Reviewed-by: Wei Wang <wei.w.wang@hotmail.com>


>   	} else {
>   		/*
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20260919-pci-idpath-selector-2847a8afe92c





