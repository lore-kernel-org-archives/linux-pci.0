Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794612976;
	b=z5o3j+1N5d3whu1wjeUxHRnLLX8+BGH5Kgh+eqGy3baSH5sY7YCyFRITJFEj+nAMzHp/
	 bxfGxE14q6WMDN4eViZgpfY/wUuQvR4q6ZRNQkx242TEXy6oMml+j0/706FA3BwflwaZI
	 Ro0K6srh883fCFlnE5IZZ/W8hg+m6WSyAE0w42zkc0MimAeN8SaWiF3o40Nytai9dr0yI
	 VLdVmht5LpQPNJGecv5YR6gCnB4HcZ9oxT+qJKZx1qYcNDHtdyuZEm8HsNjHK+9YY2GG4
	 Mtpy5DwgxhrmL8LLh9E15QVR3iMETz/rN6fKaRfzLzHZNny4buZCG0FgiwC0BGMLrUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612976;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=297wT3ncK/IGHr85goDgJc4Bl/qSFWv+ma2lHI/MAoI=;
	b=ivQlZOL+sOv3XBOmul5RvqodfJRJURd2KsASuaUXSj8wQl5E/Ua2bZziXq7uSGULSB9T
	 hR8wc7ay/xCoQxXBYbQQXq2UpnGFyOkRA94hD2Nxmc+wusc1uDgF2Ye9UcIKvi85fWdpf
	 t9nXaddcpRA9eMsNKmjwEmkMb5KRf2tuMO0kTBlWUVTnZ63EubQW66GEOKARyYXEtD0OD
	 g3ZhtaGK/gcRuynsHunEOQuRx6ZhA3hKvonfKf+d9KIj9NhdASnR/o5tAHUexDEVBF9rx
	 nDAVlfkVs987TleWPGPR35hCizlauYtF4swheTgWb8g9iDyViw8y3ORblBK3b+OrtPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iGD5MaSg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.60
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB7606A335;
	Fri, 13 Nov 2026 23:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04DB7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iGD5MaSg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpH7vrfw0hPgjsKiM4/rnOYBnDB1rXECxG3mZ2Q7u7SjoKuNxnLHU4JGRNj7n1YFXzdWxO1Jkaa7/GgNtsfOLmMo3nYr0/5171dwKtM/2bEoOqUCz92iq7ho9fNmhQV7uQLtWoNlWvDRedesJ2OPzOiIIlqrQlG/c/+Azud7s4CPZgROhwYw1HHNa7isK1arDCL21MnrpbOWWmLOdvmiLlScps5n1ILwwBC/83W6DhZ5+nNEjUAx6pMY5IsISbXIwusQT4MUGpGioPJzRPz6UCcnEAagoZCSu0j7z4XBETJdmYdZ09BPJSmM9rw9EDjZ/cEKqmWuyuVz4t2DD0qdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=297wT3ncK/IGHr85goDgJc4Bl/qSFWv+ma2lHI/MAoI=;
 b=cAtuVgJzJ0d5/DnAev6lAAzn2zA/Mi+4Mw/nDxC9wvOhjzC0CY/wMYszAmhnKGF82WWTNnNMNL51Fj4HosY7iUgPTxD5iEkGLAq0qNMQ3Yd7gpLJBAGZ9/9tC08KsnnPZCzxCpHy+qwJdYHFDJzNXD36hPy/RsUMjyM5k6FgTAmSYYzZeGIrVghdgwhuuy4KcE82zGMLCnizHgrqR6fW9b9PX7hXtLFoYYAEQ8aBqrowMw49Oxb7ohGEjdciNy09wmue5r05Jb8qmIPS0cF5ndCpDyxlp5VDfRplZYhL+uPegyDqXSWYDUJDVEm/wGfoRH6xJMzCWsWDRwOW9R7Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=297wT3ncK/IGHr85goDgJc4Bl/qSFWv+ma2lHI/MAoI=;
 b=iGD5MaSgBNK7cjFQvo4HJ3Mk+jFhHP8/nvTO8g7L6q80zwwoolnacSPfYb9ctvYDTwvL18v2qw3EYsvathskAGJyBiaYJcrc5nPVXJUp6dtSbzl6aUeEj5IVUuWry7xCt1LhLK3tHXjx8c8ST9aNaHspjIpjyXibBw5zJoUDK/k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 23:34:10 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 23:34:10 +0000
Message-ID: <6b6504f2-7cee-43dd-b253-45d023c4b3ec@amd.com>
Date: Fri, 13 Nov 2026 17:34:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/25] dmaengine: sdxi: Add DMA engine provider
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-25-3668ccc7aab8@amd.com>
 <avdNzgMDdDrcioVf@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avdNzgMDdDrcioVf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:806:126::21) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fe01b2-7d4f-4979-169b-08df41de9e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|261026140227099003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261022105027099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 mVj7KqMDf/rQh/Z4DFMDxv9Y5RvSJFZvTQ+DY4kEzMYTLddDC/daf9mCcPtpia37ItOhkKCNbfCcewBzUz+JED0Xd6nK1vhEtMJ9zn0IHhViFtxhQfBhlG8FVRHfBTzhHJGcQ0ohN7rCtYrqsWiTWVAjAOdrlkZ4CNOW9Cz7AZQx/PPwdInFqf7HNtq9vRNsF86xKUC7rCSn3i7tE2Ps5tU6ozE/JRS4GYjTzdwOYgOvLCknm8HZY95y4wCUBYiGQxN94dPnHdE04XOgNS0zSEK/1WYH3yGmGFS3YYeD+g5HmxHRI3Sj9hCF7Q+KkvijkiqopgfTo0HduK/8lESHS3b0qLfpyTf5fG2ojfGPlP6lcYNhWHunZYc1qFoIqgvmoxzLaInIvoQhq4FRGDFtUEymzLC7MLXDYmRThpCCNd3fzVzzfGIIkf2pClJmgLAkl+0B+LT3HTYtfk8NU3t1tdvaVNnSiU6XcXQsdDFYIFqcnW/T3PIKOaJ4+qis/vMcJY0DM4HWDF8RhoSpdtrm81P9Nso9VRqPW1R0PkmIyXqF+xeIi2wRxpBCYDDxxs7n6ltwNqsELGVYLSHTb6e1JUvvR891VntIi5vZip0YztrkRdaUq+ic6YjvYgUXVxAhZDg+RDBlrJ67EQMHdG8XyAkmh2w48dfYWY3kaaitjSo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L2hzWDFZSXlNdkhvS2VYTVB4UTRsR0ZYdjhhQURVVlpIL2tteU12Q24xWkpw?=
 =?utf-8?B?amFpc0lWZjhtN2YvandLTFpucnZ6SWd2c3FaeFhYN0swczBrYWxBZGJUbFFV?=
 =?utf-8?B?TlFwbTdQYXd0Z1dLMDhOeVZsOVZIdXNKYVZMUHYreG5vT0RZRUt4d1liNHJp?=
 =?utf-8?B?bTBNUjdZd0NlVnVwMXRuSGlhTHVRMkk3Y0tZUHdvQmtOeHk1c3hiY1V4QlZt?=
 =?utf-8?B?ckw3UHg0cmhyMWtLWmNmanZkWVBqL3Z3V0p5M3NXR1l6Mk53UXlQdklXQkxj?=
 =?utf-8?B?UnQ0NnhoN1AzbGhkNmk0Y2VZa2ZHOTduazFjVUs2d21acGNIVlBDOXFKTHFE?=
 =?utf-8?B?LzAwRHZrN0lPRHhkeWR2TDV2Tk03TXdTbE5GVnA2UVJXY01zZUZ4MTE3NWE0?=
 =?utf-8?B?am1OdGtZclJ0Tm5qejR3aGFxb3lNczdBUjVJTFNVSnRUNXo2RHcwYlRadW1H?=
 =?utf-8?B?T0FWM3d6cXhUVHFldzN2T2crMTZ5R0ZHeWpSNHZCQ2R0cVJpbnF6aFhLZGg1?=
 =?utf-8?B?YmpqN2N2QlFNckxYSHh6akdiV3QveW5KcEs1VnJnOGpOMHE1dnVoa3lZcnhX?=
 =?utf-8?B?Sm54c29tSU1RZEVwRmlYMkpTNWg1QzAvTkFuWWdicEpVWElWMkpReTFKSXE3?=
 =?utf-8?B?czk3Y2NFcVJya0NmRDduUHdkcVI5ZTd6SHlOQXJOUkpDc3VpYzRWWWhQOE1X?=
 =?utf-8?B?eXVYc1BOM2E2SGZ3U0pMV0RDK3NJU3QxTEx3OTBFSWpGWmZNeVg5NEs2QVJp?=
 =?utf-8?B?WHlqUFVzTGFiMlR3R0x2S3ZSRTRnaWxndjJYYjZnWUpUU2YwK1h3alBEeldy?=
 =?utf-8?B?ZFV4V3FkbStrZ2t0RElYNlBqeTFOczFWV01CWDFaSTR6cHF4TkVaSkdyS2hy?=
 =?utf-8?B?NHdyS3VIem5MMXlrSlFWZ1BiTlg3NENVRW9OTytxeFFNeVEvUm9KNXVVZ2Y2?=
 =?utf-8?B?ZXhSalcyU1ZrNkpEKzgrUmEva3hFcGQ2dE5oKzJuZm9hV2RsNitWczhWOXVD?=
 =?utf-8?B?WVVvWXNNK01KTTJTbGl2UEM1dElIQy9lb1BiSG5OVWxXYmFMclhQdkV4RFAw?=
 =?utf-8?B?MWtWVlI2RjhpQ2ZTbkRxQTAzUGU2VGFxeG9rSkdlMjF5RFdOYlpwelV1ZXVn?=
 =?utf-8?B?bkFNY25aejNUV0ltZVFOV3dWRy8ySC9QaFRIUFdtUThxQzZTazRGRXlzUmdk?=
 =?utf-8?B?SkFMRG4zQVlMb00xMkhLcm5EK09pZ1BsdmtxME9XTWxnQjVRWDhMUUFvL05L?=
 =?utf-8?B?SHpncU5hNVBxVDZjN0tySWpNMTdva3c1d2UzZ3FlWk9kVGIzbHVYUHY0ZHRp?=
 =?utf-8?B?bGhLL2Q4OFVhTnJ3eWRGeXZTMitBOGNreDhIYlZkdlo4V3BQdUxLQmpvQVl2?=
 =?utf-8?B?eWVTdUNVRWxVSjl1QWx1YmllUm5PRG9va2pUR1RiTXlDeGNGRnpPUmM3c0pH?=
 =?utf-8?B?cC9XaUNRK1NIN3duYjZ6NUpoR0FpM0NMVVhmUXUrdWVSelpyNC9XdzFJU25j?=
 =?utf-8?B?clBIdDBxZXdVNTNTVDVVbTN4SGVZbE1TSFRSdm83VGw2bnMxL0YwQWdVZmJ0?=
 =?utf-8?B?T1I1M1pFR2RDdXdzdjdHQ1l3ekZib3c3ZGxoTG5xNjdpMVRIS2RLV1BYSDVz?=
 =?utf-8?B?a0tDQ2RNcXR2Sy9rQ2l3SEd4eFJmVkZlUkRCU2U5RjRVK3BBNWxKUWQ4SGdH?=
 =?utf-8?B?VWRXdHc4Q0dLTjl5TGh5Y3JSRjIycTF2R25VOEJqck1GRTFnSXk2S2IvTTdp?=
 =?utf-8?B?QS9DZGRMdkdOaFJVTnJ4TXlyRkNRUTB0Y3ljcEZmaVQ0TnN6VE9sRnFGa2Fs?=
 =?utf-8?B?RGYwUHlGV2tickk0c0laeXBLZ1oxUXdQYkhEcUx2eVIvK1k1LzV4NkFzNTk3?=
 =?utf-8?B?WlozQmwzUWwxN05EdEp2Y3NqNnVlWDdScENOZXNMSWx1TTVWMnR6djBFWElV?=
 =?utf-8?B?cWpyMU04NDQzU25GeWQ5RGZ5QzZVTjlrMEhhZGszYXlnYlpYWEVhc0cvZ0ha?=
 =?utf-8?B?MHN6M2lpRXRUUzBHS0FBZ2hBSXUzcGR4RC9MV3IvU2RWMUEzNWUza2ZsK090?=
 =?utf-8?B?ZXVyTVVGV0ZCOUJJeFJnQTdORE5TKzl1NG1OSGt4eUFLWVpremhhOFRwWUFw?=
 =?utf-8?B?OXpaekl6RFB1c2xHOUExSjZrZlFiOHNHWDhBbnkvWjBQUGc4T1ZPM1JiR21h?=
 =?utf-8?B?dEZ6b2hEeml5UmFEVzdMOWl3Q0Fvbnd2a1N2b2lZdVBIUE53eEtIbXFGTi9I?=
 =?utf-8?B?WkZVV2pSVTVDdDFkeGxwQ2d3L29rcnFwa0hGOEMxL2hHd09CQWFzc1hRZWpq?=
 =?utf-8?Q?HtP4O+VNyc2LhIKo1a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fe01b2-7d4f-4979-169b-08df41de9e26
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:34:10.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADLLxQw+wIt/WNthqDQ/gmAVJ1b4y/o0+kQ4YZMBw4kFW8N53+i/xe8FKOPw9HaY++3LEEuSOKOo2Ik7gbkQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
X-OriginatorOrg: amd.com

On 11/13/2026 11:50 AM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:50:06PM -0600, Nathan Lynch wrote:
>> +static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
>> +{
>> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
>> +
>> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
>> +
>> +	list_splice_tail_init(&sdchan->vchan.desc_submitted, &sdchan->pending);
> 
> why not use vchan's desc_issued?

Among issued transactions, the driver needs to distinguish between those
that have actually published descriptors to the ring and those that are
still waiting for room. So it uses this driver-internal pending list for
txds that are waiting and only moves them to vchan->desc_issued once
they have live descriptors.

But I'll look into eliminating the extra list, it looks doable.

