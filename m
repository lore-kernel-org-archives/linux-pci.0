Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030974;
	b=Ym7w8OduhzsYg6SbEia9b+G4SjP3f7ifVb0g5buHDkRtvp7zvEwLcL1BdJ5kv1bXC68J
	 +IhYY3dmXLIVRrlstOvZ+kMFA6kWm2qoGHjGZ5C1zQ/X6JIgnsSPqENgRMa9dnWnU58p4
	 GSV80HI/5bxtShugRhy1o7J/08Ve88WPeZz7co63HpkmEJuRv1ficd8xCW3HoTZ4OMM5m
	 tDdQuthML3bpxmbouU6RbS5ePecGFCzKvkrTii4TUXusIOFDr3y6E7YR+BAjx8jNHkff/
	 msltnTZD0sYfLj92CX7m/AIXaXhgsQkDZykmeOmuzSwbnECzpLlEZHT4YVPYBgaA6qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030974;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=h0Ke6N1x7PJK+EQ6eoYCGhcjV/O0T1vXRaN/kaOK4UA=;
	b=EIU8gF8TI6+ht8SaHaIYB/QzfAZYzqQRnlT1Z6XCv137Y92SXPvvmurjR1kjKQ/z95lt
	 jucyeDEWIAyXg+1hQa/6/+8YvDQMf637I4bJ3PHL+Nbn7bk/EFsYnLLvHEA4CYrUhQZN2
	 nirin8/PuSKK2PAqXIcVGJZWdtpwUN10X9EzR4Y77SxNXVAphOIWjUU3ZON1xvf9IYaiW
	 FXMBAp4aWYBNO+P1lja805KoxiA4DQrctEwEJT2NCECJEP9ntjBG7mUYhKn9RyCkwfy//
	 s6kI3T9D4SvukxQGUAE3wUTTfHcwXqA/2Q9iQnqZ3UZHFuOSutpdLMsSVtC+hgp1U2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="qfHGl/Jm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.56
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82024606A31A
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 16:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82024606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qfHGl/Jm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq0Ae1yAn1Q2klc+TW6bvEubjfyfKg9f/Q1TSyol3YFtOosHjjiZhINPLmQqGGL9vmDaVBCp+mFKC8POLnLbSvRBkxb58t8gbxB5u86WjGSnD0UYfR7WuhYPBhRPr906keYofGwOclNOLcV2f1TSuXmHfHH1jCXrRHftvMGFXmlBTFjhQygCGx8Y8GigfJ3layvyCc0cBskF9VJ6T8ZlYU0LDSWM1C8QLOODA2eQGBb23S8sYrlH3K7D4wJGu7se6OmoEd/z+bBgddHCWuyDPBRb8HtE9rwEYUDwmW5CGaVUrbBjmagIDl7L57Vhj0iMTECdUtsAgLyuKVsiomJfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Ke6N1x7PJK+EQ6eoYCGhcjV/O0T1vXRaN/kaOK4UA=;
 b=H+BKJZM3RBwJ0pmDks5vDpq7PWP8owZNfQ4m4eK/2JQdkUlGCCC9WyzuDyM13O4mmfmS8bLO0AyJ1sSE6L5vecbVNbQUIVEUicfg6j9rsJWfMNNDiNbbL1hvYgXDPH7UtMUwED7dJH4mKVDQg48Dala5+A2OFKNmupYRCccIa54gluwiItl8SAvI9yD0LMBC83YAfVPZ6XQs6XpgG85K6gavxfwHQdMZszaabYNNRaujh5OzCSNx+Y/jLetiYnT/wT+Vma4Dt7joDFXOOTJGFNUami47/VGd3FEYYn7YrgLSPUmML2KZ5I+Jo+dfBrc6NCjJApW6LLJWOZ1yzInhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Ke6N1x7PJK+EQ6eoYCGhcjV/O0T1vXRaN/kaOK4UA=;
 b=qfHGl/JmPHbAQ212FRR9otHNiq4T33pABbKtEXz/jgTj8h+JRbrfaBM2E0ohXwrQnqxcUv+t1sMMdyfIDHW8KzqTCfBuNhrK3Zyt0kIqPsNBWKpozy3YC08pD62U9r4c1GIlxHIJHxQT7RrhtcxXVh4e1tm7mGse4UWEwwrX+XA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:09:26 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:09:25 +0000
Message-ID: <d6d10a47-6524-47d1-8588-fd5099ea6233@amd.com>
Date: Mon, 26 Oct 2026 11:09:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: Preserve the initial bus number in pci_bus
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
 <sashiko-outbox-185478@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <sashiko-outbox-185478@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::22) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c56db1-191b-4148-bea3-08df337b8165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261022075727099003|261026140227099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wF2XAO9HUFz0gAFDna8gsI6scxFl9PlSD4M6gZswvNnBxswMomOYadjOCEzP6UKBcMzyQvWvAOhZ/LjaCGGB4gOrAcOFnY1+zW9KW29wRm2prY4U2iykjwANPTD0n57ESEliU1kecyog4Uj2uXIfISmyEPlvCRjKIWEpr/qgkRvFCv8YyqRmA0e0r34aTku6+Yzwr4YcI2Go+WVXUfU+FnD6MLYks6767IQYknfKhzae1D4ybDn/S+PKjaJAc/KAIOjOMcHqmNLtclidFz2CuKi/sH9wuA7//wWIzzOEDOzgapakzsf0kdpDZ4/YxUdrJfc+YXaZi6iFi5UAJS/bxHOPb/o9x+ec71+m5uajDoioapO1+0a/zn2zYNF1EoW5FbwJDH0FWnkeY9lu18oVAvboLu/kdbR1gGTJho2YT6JlXHeljGJWu8XMpJmR3qMV9uj46DXnmFQvawD6OduIo9iCcLku0szHMqGkhiFVO5kmm5Ipxe0Wjt3SzTai/UnItRQCopktofbtiimiVxWarSRXhig+zELMHwK2r9KUzxgd5W+MUWHlQOyR1TysC+bZjRJ6A59CoMXwSylgm78N6Fab3bFY9WmTq3T5ZaggnLya5gKxny55ViRHnqQGxUClLxuvS4ON/nJJM79TdDi/aOc/lT4GOJ1sFfQ3KD+dptY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261022075727099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXVjNm50dGtDVDR2NXh5UmxDWmpHR0VKWFIzWHJSVTVtT2NRcExOV2pTNm5k?=
 =?utf-8?B?TG93ZjB2akZ5NGt3bmZsdnZITnV1Z0tFUmx3Vkl4UFM2Q1hYT2lJTVVHQkFw?=
 =?utf-8?B?STh3NHVpTDFzcDNsMi94UFI0VGt0UnJGQ3o2NDVwTXdWRGE5REM1RkdWUnI4?=
 =?utf-8?B?OVM4ZHF6R1ZzaWhvOHVlNFlRajA1Q3RiR3lMTWZuWHdld2RSY29ka0YwdGZM?=
 =?utf-8?B?cTIwcGs0WjRnR0M5TXpzN1ozUUlDME9qMHdXN1JtRFlkWFg1OFlQVVRTeGFR?=
 =?utf-8?B?NCtsTnVNZGtXeWd3RXNMOGJBSm4wSWhaRFlrS3pTNGwzMFFiK2pxeG5sUHpw?=
 =?utf-8?B?UVZrLzg0RFpQZStpb1dSNGd3M2FxcnN5Q3hMZSt2TVpENmd5TXZGM0M5V2Zw?=
 =?utf-8?B?MVZOeDNPV0xMcGpVODBSRlRLN2J4Qk9VTThVVGNGeEpGckw4UkdqV0xxZkll?=
 =?utf-8?B?WnU0eGk2M1B4U2pUNHM4ZUxrTnp5ZkdydmdqNVF2WVZ3UU1JNUNNVU0ycTB3?=
 =?utf-8?B?Q0xrWUFvRXB6eVA2OWtDZ0g3YllxRCtSQXQ2WWh1T043aWVEUWpFdFV1NjIv?=
 =?utf-8?B?cS8vcVZVdXkyVC8rUFRUQXRDOEtlU2pZeGRHb1dNRm40ZjFsMDJQbWQ4eFpO?=
 =?utf-8?B?bzhqajZwUE5ia3ljc0NiVkZ4cWJaQUtISUJjUFIyYXNEWERLc1luL1lsZ0FP?=
 =?utf-8?B?aXlEN3RtODREQW13MGxBMW1FUURvL2U4RTNMTXFZVFNPL3hMOXVSUGFpWDVv?=
 =?utf-8?B?cHc2TXhyMEg2VmVrZEVrMkx2Y3BFT01CWGlFNnFrVjhtNEhPZnV1eGFXejh2?=
 =?utf-8?B?aHBvU2kyTGxqdkZqSEt4aFBVV3dra3BIbDNvcGovQlI2S2c3eEtrS3BHT0U0?=
 =?utf-8?B?YnZkRGJxR2ZzVWxLRDdaVXdsYWhpRmQvY21jRFR1OEdjajNid2l6dmVtRFgw?=
 =?utf-8?B?bzI3SSs3SnhMLzBFa3RWZWxBN1JiSFhQQWZha01Md1RzbFZiN1Vhbm9MSEtU?=
 =?utf-8?B?aWRrSi85d2JRbmV2ZGl1dXFaZXVqQzZ0Vy94bzROUHp3cTR4emVvS3hzTDE3?=
 =?utf-8?B?T2NqUGVicXVIQmd3Q2J6YjZEOHBLQnh0Z2UwNUZ1YnlCanFmS3dNRlJxMXhk?=
 =?utf-8?B?cjcza0R0Z2JibjhHS0hJVHM3NzdEejZMYk1yODlhejhCbWhrdnFISGY1Vm5P?=
 =?utf-8?B?ZlJ1Qm1BMXVsNmMwQlg3ekNDTUdUU3NmT3k1Si92bGR3aDN5SEc5VVVuQVh2?=
 =?utf-8?B?UHUydXoyMjFDYTMvckJVVFVudVBnbUJPd1JDLzYvdm1hZHBjb0cwck1maG5j?=
 =?utf-8?B?V2J5Z29sNURDK2owa1Y4YmZKY1F5MytncVdsMG54YTRCbEk2SVUrYlVnNUlK?=
 =?utf-8?B?WGRlWnRMMy9GOEVKWmNPSnFJbVlwcXVJVE45WTgvVWFQNmUxQ1RnRlhSVWlE?=
 =?utf-8?B?VGk4Z0JVOTZRc1d4c0xtVGFaNFN1dGJqbWl5OUxsaUFBWjZlSFRBRDhwWmxW?=
 =?utf-8?B?RkhKZGthYnFBbUlOQlpQdm5CbEg3ZjhCdmJoVkUvVmJOa1FCQVVjUEx2b0VC?=
 =?utf-8?B?dUdwbEVlamduQVNrR3JGSklUcFhXY0gxYXo3V3VNVzFVWGJOaFNhbjJTQjJ0?=
 =?utf-8?B?VVdpYzJoRmhVTExNWmhTZjVSWjBLRHJuZTcvNXY0OHlZUks0ZG5HQ1ZRL05w?=
 =?utf-8?B?M1hxZzVZWEFoUDM4bXN0RzRSdU1lci8yRytROWtDVUQ4dFIrQTI0U2hBTjJK?=
 =?utf-8?B?ZW1DU2pCNzNGNEFUMDJNMjRRczJDWW5VbE12TlN2LzRZSjRHcGFWRzU2cGxK?=
 =?utf-8?B?ZlpHNUhBWERpUWhKbmthZTJwM1kzVWJSMGRlQ2ppTUJYUXRudk4yQVJwS0Fs?=
 =?utf-8?B?ZHJYU3RoNC9nUXNSVFZ5T3Z4cTI2UFEweFdOSGppZytwNHBUUTB4eGx6TTlK?=
 =?utf-8?B?UjNhYjV1TjhuZGoxUk14Mmt4cGYrODh2WHk1d3RJei9uWkw2SGVOdTNablNU?=
 =?utf-8?B?alFVNjdZS0txelUzby80dDk5Mnkrbk5SMWpSdUlwUU9KMmQzWU14RnZCODBn?=
 =?utf-8?B?SzVsZWg3TzFYV1RwQnNzQzd2Wk15U2lkMFVYOHQrY2ovVFV3blh4Z2NuTFpE?=
 =?utf-8?B?eVpCWkdlTDdoeHFtRSttV2gyRUMvSU5iMDQ0YXc5NWw0TzFHV3lzMW5HWGVu?=
 =?utf-8?B?Y3hqU1JyNDJ6c1lIYmY0SU5tNUJMVTlZUUVCakJFM1FBRnorUWhnekRBNVcr?=
 =?utf-8?B?NFU4bHUyMHpGd0FVRHlxSjBJeTlMVTFtZUZoMzlSR0QxT0c4TmNEeXNaTkt0?=
 =?utf-8?Q?xfPGSC+P2VFO+Bf8g/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c56db1-191b-4148-bea3-08df337b8165
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:09:25.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkWvEI6M5X/gCBKvlfyHKv9G7t9G8lc17oU3iIcS05DYUgoLtYeKWDd6Pp8O/ZA8lc2uJL4cCiAYXP0bU4JoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599



On 10/26/26 11:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] PCI: number_initial clobbered on bus rescan in pci_scan_bridge_extend()
> --
> 
> commit 66abeabff58a043b28934ad23308d764456e9fa4
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> PCI: Preserve the initial bus number in pci_bus
> 
> This commit saves the firmware-assigned secondary bus number before PCI bus
> renumbering and stores it in pci_bus->number_initial so drivers can match
> firmware records against the initial bus number.
> 
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 27008e2ea5afc..9950a9dd1db1f 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
> 
> [ ... ]
> 
>> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>   
>>   	/* Set up the primary, secondary and subordinate bus numbers */
>>   	child->number = child->busn_res.start = busnr;
>> +	child->number_initial = busnr;
>>   	child->primary = parent->busn_res.start;
>>   	child->busn_res.end = 0xff;
>>   
>> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   			child = pci_add_new_bus(bus, dev, secondary);
>>   			if (!child)
>>   				goto out;
>> +			child->number_initial = secondary;
>>   			child->primary = primary;
>>   			pci_bus_insert_busn_res(child, secondary, subordinate);
>>   			child->bridge_ctl = bctl;
>> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   		 * do in the second pass.
>>   		 */
>>   		if (!pass) {
>> +			if (!dev->secondary_busnr)
>> +				dev->secondary_busnr = secondary;
>>   			if (pcibios_assign_all_busses() || broken)
>>   
>>   				/*
>> @@ -1529,6 +1534,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   			pci_bus_insert_busn_res(child, next_busnr,
>>   						bus->busn_res.end);
>>   		}
>> +		if (dev->secondary_busnr) {
>> +			child->number_initial = dev->secondary_busnr;
>> +			dev->secondary_busnr = 0;
>> +		}
> 
> [Severity: Medium]
> Can this overwrite child->number_initial with the reassigned runtime bus
> number during a subsequent PCI bus rescan when pcibios_assign_all_busses()
> is enabled?
> 
> During the initial scan of a bridge taking the bus reassignment branch in
> pci_scan_bridge_extend(), pass 0 saves the firmware secondary bus number in
> dev->secondary_busnr. Pass 1 then transfers it to child->number_initial,
> resets dev->secondary_busnr to 0, and writes the newly assigned bus number
> (next_busnr) into the bridge's PCI_PRIMARY_BUS register:
> 
> drivers/pci/probe.c:pci_scan_bridge_extend() {
>      ...
> 		buses = (buses & PCI_SEC_LATENCY_TIMER_MASK) |
> 			FIELD_PREP(PCI_PRIMARY_BUS_MASK, child->primary) |
> 			FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
> 			FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);
> 
> 		/* We need to blast all three values with a single write */
> 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
>      ...
> }
> 
> When a later bus rescan occurs (for example via pci_rescan_bus(),
> /sys/bus/pci/rescan, pci_rescan_bus_bridge_resize(), or hotplug), pass 0
> reads PCI_PRIMARY_BUS again, where secondary is now the reassigned bus
> number. Because dev->secondary_busnr was reset to 0 in the first scan,
> !dev->secondary_busnr is true and dev->secondary_busnr is set to the
> reassigned bus number.
> 
> In pass 1 of the rescan, pci_find_bus(pci_domain_nr(bus), next_busnr) finds
> the existing child bus, and the block after if (!child) overwrites
> child->number_initial with the reassigned bus number. A similar overwrite
> can occur if pci_find_bus() finds an already-existing bus during hotplug.
> 
> Also, in the new-bus case, pci_add_new_bus() calls pci_alloc_child_bus(),
> which sets child->number_initial = busnr (next_busnr) before calling
> device_register(&child->dev), pcibios_add_bus(child), and
> child->ops->add_bus(child), so those callbacks see the reassigned bus
> number in child->number_initial before pci_scan_bridge_extend() updates it
> from dev->secondary_busnr.
> 

I'll dig in.  I initially think this one is true.
