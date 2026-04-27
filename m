Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949B1A6819;
	Mon, 27 Apr 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293819; cv=fail; b=QSi5gT3A9dkJe2GuPoCLQPgzoLbotlpYdOl6NiQCfn5fBwfDLYHrClIvFozknYl27Ht0zgWH850yRHs+L2zzFxdiT40C0hTzaebD7+dTFNPHKl520nYZ+QcMT2oyeEqXjCGZ1nnzAla5ChT9EYtNNml4cpv8lF5EYtLcanL8tWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293819; c=relaxed/simple;
	bh=qkwIs3/mDO0Tg84Q9DdCy3TuXNnEPeBQJkCLGGepUfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AarpeFvhEdYUG6zWR0r5j0kfL3iNbLbOdnZQDeVdTOAqbYJ2t6p80z9n0wqOt/LuFSkdlYzu6TiyNDHRRJT5HBLkBuuGRJAIxcV+u/JZNEsOu3MoAfx07m0g0F6m+Oh4Ss0NAd6zJ+AVoL1sWHfMWttv94HMfjFtm2ZYIGL2F4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Etqmlq6V; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Etqmlq6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCFnmOZLBpQxTzVInOnHBOy/u9+g3vpZ0Pq0dB3N65986095mbz8p7abtpI+9t/xRPu7hWXROmkem0nvMzgj1kr80HL7FFAey5SdI5P5YpOCPj+cM9Pw1VJD69lAg/7IV0tDA5z52l/ZjdfvuDSoTlWQjQohlBDW1EYbTjkReJ9+JRHRkdtZWOdbSixEL3noCPCwDWQASIjKmg7l2cvfOiMGJS/s+5heKB6ZzN9dRCsUs/DLiPABX1VTXd0nAiGjqbtZCj1BItrU17k0XsFH63nxoTrM7TfYkiX1o/xpZjrQZTNCOT1rWj2lVNnNasHWcdIWRVmLyFxgBab0J0FJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlZGMJqWNYFJ67vmrM8METi/Hr8Rqc1KdJtJLCIbdww=;
 b=rM2s4gdSJmA2Y0hu9+vvJPWfQuer0qegUeTPa+sqzY03qNkkMdhIrn/tDVZBLHnEtIIWvFmHYo839zGEqmTDwebeXQOEY8Ma2RvjLPF5duALVInIk1+GULdGk6s845Jx1X+B2/n/wOlCcbCl9jldhJYpGyuv1ck6UKoHNK9MQeNHvJeMU3dqbPYDiQoYQSWqNpIKBz7n8V7b5Jt3PrDIJ5BAaPPBjRWipKLcwwuCjPcwm3M+rgs6wO/o21opTwXL8rh2onhUnvxFrpfHtc8iI7dIMTW5mbZiXzr57qSazQz9aJpVY7C4+Bker76koet+6tfBoGxHrq5foF45Q2vHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZGMJqWNYFJ67vmrM8METi/Hr8Rqc1KdJtJLCIbdww=;
 b=Etqmlq6V75XfMi8qeU8jWB+lGIhRCCGwvqN2mTULy1ahHpp6Z8a5r/jt/KgxMXTw+4wA+M0pXQHryD4a017/E7rA4bm4EgsTSWRAzrOEI1OsQyP1TnEf5xLRznN9EZECDhx2CA/JYzaSpLJhZgmUf6eXfRvRbW3sK2dXd8iIgTXjtU4/XWOmmfo2ZobrbnGl5LSEFl206nX0QFhl9Z5vW9MeOKmvzpy0m5VkdmUcQi76Gbj5nR50XFBPT6tY3f7+iolTqyn7zX4PFUBEtRtEG9Ca/1N7Cd7RuCXjLvGNZ49PLJPg0rES6I+pnZlekrP4Ie9nL9NwYvUh6oYmQbeeWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by PH7PR03MB7300.namprd03.prod.outlook.com (2603:10b6:510:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:43:32 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:43:32 +0000
Message-ID: <87cb3c2d-ff99-444b-b95a-973f91606ff6@altera.com>
Date: Mon, 27 Apr 2026 18:13:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: PCI: altera: add binding for Agilex 5
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com,
 dinguyen@kernel.org
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
 <20260424094913.522123-2-mahesh.vaidya@altera.com>
 <20260425-witty-heron-of-perfection-cedddd@quoll>
Content-Language: en-US
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
In-Reply-To: <20260425-witty-heron-of-perfection-cedddd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::7) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|PH7PR03MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 61076461-127b-47db-929c-08dea45a9742
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QPYB4dXGkgovooC0DUwRGHCzXN94ijP6amIOsk6GsGo/s8WHsbPhY/cQlv7WeLnVcxpeNK1MSUFy5pBnrK8DPYvhmFhQxY9Ib0V8pWbsB7AlRle+YMdcn5RZeWUppLYRK2Fysf5dl4VQBs+6gWVriRwRGcJ4NohVFtG7Nl9RnLixpv4VcM/aEHz0YF4uIIJTHZ4DbtrZDVoCZdnsUKcxTiXMoM3XXd1XumFOxk1DEHCHsCDEJ+2jy549Pkw+ivvG3RHDQ+AxRjZMUjyyHiQ5w0VR0XFlimR2DmzR4cRtHJC0Qsg5g1I/Yc6JTQV1LA4TDpL2yyr9UNhOLhhetSbGg01XyJG5i4QspxWEA9iMg88/tsiB4IKVIfhmaKjlsTZOQKxgj1A7teCULVQAp25O/9pWpBGrIZ4VMmZaUn6cxUuFOzBCs5Ax4tBtaLjRapg0VZ2AHRHDONdkSdspgkOlKILZ3rKRUnqadjAnrXaP9TG4KxVSacaAZa/RlFxs2j8gGlvsAExHVrWRuHvXfPJGJntK89ppWNaKEY+ua3S+iGhBpJFwe60n50iysNhRmp5a78L3AdYFOQBScRv09mjUyYEH8gQOaqXnhq1nHtVe5sj0t0pXs7jyE07bLr3L64Gnj2uwY4OlvEAcSG5s5JVYDpTRyd/2KRJIdtEV8k3URyK5sIS6natMrHLKXroogNt8Ny2kdpQHI065fBcZg6wrZ2hdJnZaVE/BreXrOqux1bQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGVoaU5jc3NBYmlETlFreldvdWVnb3Z2aWs4REtCVGFGR1RXM0toMC9XNWhx?=
 =?utf-8?B?R0hTanFrNWpEeTJ0L1Qrak0yWWFmd3MvdngwdEFTUjUxd3lQVm52MkMwODFQ?=
 =?utf-8?B?NVFxS0NOQzErcWFidWtCaXE0aW4rbXJucFFWUDNxQXUyTkJmeDNPZ0R5enlw?=
 =?utf-8?B?dG5uRkcrMlB5TFVRQmN2eXdpZHlmN0N4WlA0MnFEUEN1YXcxNzA3TU1YZnZq?=
 =?utf-8?B?Ymt3UmRucFo3SFZNUGtCWTBpZWJ6cmpvQXFSYzJLc0lBT2Qrdll1S0ttTTR0?=
 =?utf-8?B?dkFQeEoxZU9qcGNKaWNpWVIyT1dFVGlkTWlLS3lUZnBtL0MyN1ZBM2JrTHEy?=
 =?utf-8?B?azh4MUhmeXVsSUtaM21HUlhKQnRwa0pMbmYrMmdkWVk1Z0xTcDJjQTJtTzhN?=
 =?utf-8?B?QmN0QVZCUDhXVEdnZzFIQjV2ZVYxcHBVZWZJSldVSExjVm1NenV1MzZsczhC?=
 =?utf-8?B?YnRrUUtYL050aVJTYVB2R0JRdW1XWFVpQ1RGOWFlVnZ5WEtseDRhNi9qcCts?=
 =?utf-8?B?K1pQVHdOYThXaFNwclFpMHJuWU1NM3grTWNRSGw3MDJnNUpIUkNZN1dPdkhF?=
 =?utf-8?B?MFVsVWZIc2RtM3FSSHBPY2ZtdW0wbUs1TWxCbVdkYmJiektQeWlTaUJkSy9J?=
 =?utf-8?B?dFFEbHhScFREZjRnaXVML0JYZGNiVFEzLy9sUEtuT3N0cUtsaFFOeG8yWG96?=
 =?utf-8?B?cUhMUEJYWTJtMXI0WWN1U0loY2lSS0N1QWhXV2dNOTZvQWttM3hxVFdRcjhk?=
 =?utf-8?B?Y2hHb2lKRlV1bGdrb2YxcThnNzlOUlBESGZjSGRWcnNQTGwzQ3VoT2tZb0ls?=
 =?utf-8?B?NmowdG5zWlB5NG13SXVVUHVsTGsydFEvUUx4Tnk1eUtsQzlRZjV4ZVhlRHJD?=
 =?utf-8?B?eFk2UlJxbVZXcmJsSElQay85ekJodm9zd2VObTVFSEt2UlVUcUNPdWNHRmxm?=
 =?utf-8?B?czNjZnY2dGY5Ty9GT1FSV3JEdkgyaW41MDVwNEt0bmwwOUorc0ZkYXZ1clEy?=
 =?utf-8?B?d1oxS0dsUXo3ZWp4MTlRRHNVaFVuT3ZDbFNod1JTTWdhV0VwSU9VTkNJaU42?=
 =?utf-8?B?MnFlR293clFDQzdPMXVCUGpWTWNVblJoWGRCR0plajVXbU54WWRuVWdrcVp5?=
 =?utf-8?B?L0NvVjhzUmR4anh3S2VIMFlBbm9zY0Jsa3pMelNJaGIxTVBPTG9JRitGNHFE?=
 =?utf-8?B?MU4yc3FOcWhiZ1dkMFJTb0dTSFFYMi9qaHFXODg3K1AyNnpkZm9ONTkzUmpr?=
 =?utf-8?B?UFN3bFQ4UFEwMFc3K2IvL1kxV25LVGhwSy80eTgvalk0cHhmeFJQYVE3RHVh?=
 =?utf-8?B?bzlSYVFBa3hFSkFZN0VWYzNpSi9lMkhLSUVXd2lrRmV3SjRmSFk0UlNXYnZU?=
 =?utf-8?B?UVdGajRaRVY1eHdOdlozcDhJT0Q5bS81elBQckhjM2tpTDF2Sml0WjhXeHF1?=
 =?utf-8?B?Y2dISXFBKzQya0JHNkxTTnN6eWkzZ2tVdkJHYkwxTWZPV3lQbVNnb0pqS21W?=
 =?utf-8?B?bkMwWHEyRDZxMTJjTk50TkJhMG5wL2VVd0crWGYreEhHNnhzK3dUdDNBaStT?=
 =?utf-8?B?UHUvM2FGMllTbWI3WXU2a0UyVHVwVFZOY0lBWmYyUFVNV0ZFUzJHSUZZMU5M?=
 =?utf-8?B?SU5rSC8xUjFsOFgxcEpUNjM2bzlIc2lRdC83T0E2a2lTOGU2Sk04clhJblVK?=
 =?utf-8?B?a3o0RGg2T2tZSkxjYXM3eXFGZTVtZy9xckg1Zkk4K3ZYbkozSEl1Mmpxcm5C?=
 =?utf-8?B?cDRHVklqZDdkTXlYQm1MRTRZcklIL1cySjYvZGw1Mi9lQkphOWk0RDlWRmJK?=
 =?utf-8?B?YkVMM2FmZitYMWtEd2pNWEFZd3loT1AwRVVpVUJDYW03ZE9FcnlHbm93U0oy?=
 =?utf-8?B?cm9za3RaejdaMzh2TG53eGNIZXVjWWF3UjVHaW9Ja0dueW1Ub2VNYjRJS01o?=
 =?utf-8?B?ODk2bmRiV0xpZmZpc2pJaVRmVytkenczcVBPVGU0d3FpYzE4NWVQcDV3K2da?=
 =?utf-8?B?dm9KNlYzZWlLYU16NjFXTE5lTFpTd1BsbjVJTWVkMUorQWtYTTRiV215WEd3?=
 =?utf-8?B?T283TU1NekpMQW85SFpMTWRlUG9SN0twd3F6TnhXeGxIenRlV1JNbG1vcWVO?=
 =?utf-8?B?M0xXdnA5NE8rVThTODdwaW8zSEZXNXZERTNITDIzQUltUnBVRzZoZysrOWx6?=
 =?utf-8?B?a1g1WVNFTG1LMFNHU1g1NFZmVkxSSEF4ZVhldTNRM3ZHMStLRlY0VlE2c2dT?=
 =?utf-8?B?TnR0R2NueDZDTUZrR2hyQWtTRi9EUGhYM0V4aFNxcC8wVkpldi80TGs0cU51?=
 =?utf-8?B?Q2RaMWhLdEcvUnFxQWltZ0R6SXhBZEhzeGxwbHZSUCtac2p2TUFFWlFRdEFS?=
 =?utf-8?Q?tY+/pml93G9G5Hj4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61076461-127b-47db-929c-08dea45a9742
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:43:32.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwqv+yaVJHHQQm9IxVKd+fxZS1eLE+9NqGmZAVSUMZxf6iaUnJVZBE8WYnl+GT9Th/JFhPlkblMQbpdyl4mRzkNkG/T5d/7S1DKBx46V1iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7300



On 25-04-2026 15:52, Krzysztof Kozlowski wrote:
> On Fri, Apr 24, 2026 at 02:49:11AM -0700, Mahesh Vaidya wrote:
>>       enum:
>>         - altr,pcie-root-port-1.0
>> @@ -25,20 +26,15 @@ properties:
>>         - altr,pcie-root-port-3.0-f-tile
>>         - altr,pcie-root-port-3.0-p-tile
>>         - altr,pcie-root-port-3.0-r-tile
>> +      - altr,pcie-root-port-4.0
>>   
>>     reg:
>> -    items:
>> -      - description: TX slave port region
>> -      - description: Control register access region
>> -      - description: Hard IP region
> 
> I don't understand why you are removing this.
Yes, you are right. I will only keep the agilex5 enabling changes, rest 
all are not required. Later I will post a patch separately adding more 
documentation where ever required.

