Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793028815;
	b=EVykCIq+oJLMmEP6UgQn4to0Yrnay6UHj1fjMz0u8PNlWQxEF8ZuE1QsSPLYszPWdIvq
	 hgC10JNzsgv07dWL8/rhnd2Ok7bZAh54xER+R0wvFVYxyu+X2xYUPCSggu38x8+roS4Vk
	 mN8bxLk9HmzME3a4GOi7ZRdP8RZ1+rHrFaaobI8IFdp3INmj+6d7JYks7JUlyLCkJiZmQ
	 qUfDZc438mz+egm43Ss/XmG7pgJVJs3SYex9mEsxJ/I/yYNFu2G71PX0diZrmvog1OAek
	 39FWrDN2KwON7pD/UzezwW1ppgfJ01vpcNnXRDKIIhhbUFONS5TrOfFMVMpkWnxScTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028815;
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
	bh=H/tRL1R0IsMoOHCiUvTXn8/JcRjQxo+pOzEjDh/XYjk=;
	b=V9qXPOibqzJMFdQDAyLQZvppMLHapg2r++iWJahrdL5lBvbKEfVLPdhejm9CYU1iLNPO
	 C5oRCfOGaS/yeIIsKGu9kHNUo1k7wbrwyy3zVJcdeN/OHtOWmTBQRUTI66z5n2DdfHb2j
	 0yHNAvwnlMPaLyIq8qT3XuzZsWP1DL55ctNFKQkEAVdat9uelEsx/60BURsrgS72Jlzb3
	 zs1vC9LnT/CRTEDuVLiB+SUzTak9KpDY8qPcCJW4FM+AV8PtbwmL+YGPaCsCpomUwVtgd
	 Euzy8r3F4aRY2m5LOrx6C+EnYNDp8EfM8dcVdzW5LX89xDl1EfEofQVqH/sfRCMr5wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Db0M3KVM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.34
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83024606A31A;
	Mon, 26 Oct 2026 15:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83024606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Db0M3KVM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0FI/eO++5ZSL5pJPZyHs4cmlT6m+dyMeFxwr8xBDhcqS7yUSGNBslBbmscDB1C67Jqn9XkiJfffox/N98vy89xQ32beOXUqdvR8XtH0b2wjxPyRGQJbkTeTDaUjk14fMJQ8RLmPCPKquLIYactqw7IabOwuYUN7pvPSCwlvTIKcaNouMFW0OX6A4XXXzzP1o+Gt0wTD/NmDCd/hF8bWoP2G6Cr/2pX4LOeoq/chJeUvJ4slktM9Js0E3sUB/r4wrP5pXjowDkjqjBT5ul8uWWf4gJcnx929DzgIEOdnPIkVMih7XPLfUzJKsEnWcjVdE8jwG7Y3u3/4k6WjY/HsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/tRL1R0IsMoOHCiUvTXn8/JcRjQxo+pOzEjDh/XYjk=;
 b=iF9qcbfglKj9+lIdWCXCbxyB/mma9I6SyW723At07zKyyd/gdo4QEzzR2EzDovcbg0FwNzlgUTrPT728WUV+/kCub7b3KPqsNuvhDureMX2/cBYvsgcyPQu6fB5gs+IcCbT60pnODsl0EPXuubNg1cYJtnvmfQvmTxk6zhqwJtkpoNlRbesltr98vMYMpmTEfr6NQj3oWFi58XyZ9FDNq3n1ZGxZlKTGLvUOmIkOvZcvIZEze6JhAScgYJ4SjaGQcJvUsQce7xhZt+Gjijblbr4FMo0D/JMqYeYfFkPftnP+GPcNUccEqLAmkVkXNXzQG9QPiowC6s6d++h0hENZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/tRL1R0IsMoOHCiUvTXn8/JcRjQxo+pOzEjDh/XYjk=;
 b=Db0M3KVMM3z9WPoqbeZjiKmwOMG2ntL7EPIunLpVF571nkW+VO5x0VkDxKS524GH++9pDDxISXN7FhStY3OxQjvu76oHCuD7wC1qO/ltHwoGV5UIKpGL1lm2jcP1bWzatIbbY7LlPQDx9Zg35O5NSgHFMCJ71dc/pt1aYMMs2Pc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 15:33:31 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:33:30 +0000
Message-ID: <26db05a7-f723-4fb9-9eab-ef6dfaa88482@amd.com>
Date: Mon, 26 Oct 2026 10:33:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261023174746.GA2791886@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261023174746.GA2791886@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To PH7PR12MB9174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d7ed2-6805-4bc1-c1f1-08df33767c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|261021121427099003|261021135927099003|10067099003|56012099006|261026121527099003|261022075727099003|18002099003|22082099003|3023799007|261022105027099003|11063799006|261026140227099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	F6WJPtgSGQZqg12muQ/fdJciwPfJ+kUZFjrYI9Phj7HbHssJh5pCtypzQshmbJIPefnKjpfk9lb3JdCWOnQf+F7l9qoAKCEktCL60N2KFsrN/LckpIHdQrWXH3vW56IpTlhd5yhRtUdJm8mD6kIRaIId8f42VytRAPb8hoLnbx84h13egPtWNPpKD97j3oN1WWTErDSTx+wB2EVzIC/kcxggOFQjuylhAHDzaalSIdsx3nFAoustAq1JqgZpJCCDFE5NzB48dOgd72aovWRzQOx9LvgqunLoliiLdQzvT6F2eroihC6fpU0datovjlycv/GZCz3X+sxFGcRBKS2fbXmttViSs58QilBOhN7/zVIwqTBUKqh8RKlnWq9OzB/b6pcV/2x3qYY9L49n0R1byVgiB4eEGqNp0ukvNiaKVip89+Svdg4rKqAGrdIxwxO9PX9g12kiJwLNgAg4cHxEO9fdLbRi3eyNld3X7LZyEs4TP4TXCq6donOt6CaNpkB2a46R1wXnrLOKkmPa1aBxN8pyODbEIRAgE3XpHiahe/OKfTRUnniprEg0oin81iAE8mPjEoMbJ4hvyZeW7e9Se4usa4p2bUCy4+TcR48lAhmzKwpbL1tzVRl29QDf5wyhLa2+LC4H03LrHCrItDzN3JThanXxSV5XQnk0Rq/6n1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(261021121427099003)(261021135927099003)(10067099003)(56012099006)(261026121527099003)(261022075727099003)(18002099003)(22082099003)(3023799007)(261022105027099003)(11063799006)(261026140227099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRrVUJtZ08rV080V210TUtaQ2NLOUoya0o4T2ZHcnJNdFFhb0xXSk1VdW1i?=
 =?utf-8?B?cHdxRkdSUTBHeTNUem0wOTE2SmlHcnljS0t0MCtvTHhZZm1uSmNhSEZ1RCtF?=
 =?utf-8?B?TkkzRjdVTEV5Z3VEcHNYbXl4NGkvK1BvMUtUYXh4M0ZuSDhEcjRPMzBIWmsy?=
 =?utf-8?B?QittdGlmeTZLVFNteU1vVVRpaFRndFZPbWNQaGsvZHE0RUNmQ2h3VmhjT3M4?=
 =?utf-8?B?UWdSZE9tYy9PUGxJL0FWS0tFMzJhbVVsTFBKcy9TRzByQ01VS1A0dm1nL2pr?=
 =?utf-8?B?MEV4OFhFTXh3ZkpodGhvdnN3NklGN0xta3RPU3VlaU82eTd0L1djOU8veVZi?=
 =?utf-8?B?K0I4dXpSWHBWNzI3R2txNGR4RDJuZlFINFFoV2U4UzBKVk5NMStVcUNRUEll?=
 =?utf-8?B?STBqakF1TXdsMWdqR0dJUXBDYzAza3NZRG8wZUR3RUJMTnFnYVkrUXpmS1E0?=
 =?utf-8?B?TDRZSkNjeXcwNkZoR0NIeDM0WEs0YVZiUGFaT1dndWNSelVNcU1RZUR5WndU?=
 =?utf-8?B?eTRNU0QvcTZRTXFNdUNKVzEzQ3JDMWR4SlNlTitCTmdVc2k2cG84aDIyN3p1?=
 =?utf-8?B?Q3BXQ2pQd2FsRlJsMFRqQUxIRlptYWlMS2pSc0QwWUtGMmEyL2k4WThVZ0Vj?=
 =?utf-8?B?WTJCOFgycXU0bmFheTZRQUtOL1NjZlZkODVjVk1tR1NLcm1IcVRjRW1qaFRv?=
 =?utf-8?B?WlViY1VUMGNwa2dmZzhONTBINlM3SCt6Y00vL01XWTUrT2VEcUtMVGZTcUdU?=
 =?utf-8?B?cjRMaHdRZmxxMHR3d09WS1Z6VVFYeDFWR0VTOU9zNnlXNnVVQ1c1a2NOUTRG?=
 =?utf-8?B?NElmVEF1T3VSV3lmM1pXTG5pRzRTK3RacnVWZk52UmlFSXVISlUzQmdBeWx4?=
 =?utf-8?B?dnJEejRRSHRTZTZQeU02K1ZUYU94bXI3Z1FGOTlNYWtqN2dNUVR0S1UxY2h3?=
 =?utf-8?B?N0FrbmJsSEl1ck5HWTVueFNma3pMNFYzWUdFYkNnVFJSTXZPK2FPVjJPcnZt?=
 =?utf-8?B?NWJkeXVBWlFPWXVrT0JzMmxTV1Q3azdTM2JKVkJzZlR2TXJuR1pUQjRsUkt3?=
 =?utf-8?B?dXdpcWwveTdSY2hQcnBWZHpqYUlYc1lNaWJvSkhYcUpXWnRsUkU5U0NqRDY0?=
 =?utf-8?B?NVZxcEhLdmthOGEwWmtlVEs5RlZiWCtxZVo3bHE5SlBnQUNydGdnSTVBODdU?=
 =?utf-8?B?cGpCeDJQdStOUmd0ZFl0cllTNW82WHhGNjlrb2E4UGsvTlBVaDNVbCtDelQr?=
 =?utf-8?B?OFRZRkNrNTczVnlyM3pYd3U0eXpGRTk2cTg2TWozaG93dmJvN1UrS0FCMXdo?=
 =?utf-8?B?WndLU1RITEdBUndydWtIRXdIalNMQWN4SnV2UEdIRnVmWngyM0t1NWI4U0o3?=
 =?utf-8?B?N2tyUE0zY1J6NGxUdXBiUExRdGVKTUhzRDIxdlRFbDJDUTY1T0xjRWZLUlF5?=
 =?utf-8?B?WHNsd3hGTFJEYjJTbk1mQ25yRkRtdThsR0t6aldibUxPOEhoN2N3Zno0QWo2?=
 =?utf-8?B?c3BNbzdGQXFnajl6YXVaU0Q0ZlRDbmlNR0Z3cXVKZ29oc3o0OUt4RlFIUUR4?=
 =?utf-8?B?cGRGazlCSlQ2eDRHdVozclNWVFhHSjBmV3JxUllDTUgramk2MzEvSVdjbmxo?=
 =?utf-8?B?RjVDNnRJb3c1V1Z6MXJYakJ5Sy9YUUZYbFUzOVhkVGdtNXJ4SWMzTWE3bWZZ?=
 =?utf-8?B?WVhDKytXTVhvMXc4VTlVQW5EU2hKTTdVQ1Z0WDhERktHcnl5eFZPYVFQdnM4?=
 =?utf-8?B?OUdNRkZyS0d3eUVhYW14aDgxem1xbkFqa1lLdUlneUJ4T1AxeDJkd3REY2xX?=
 =?utf-8?B?ZjF4T0pXY0pTQW11cDlqajdrUkt3QjMwN3hIZFBBc3V3VFgzWXZrTm5aWTRZ?=
 =?utf-8?B?b0t4aUcrUzBPREl0ZlRnUklROXRuV2ZXTlJoaUJxa3Eva3ppTDNCcG1DQVN0?=
 =?utf-8?B?MXo0TFpnOVQ1ZVlrKzFpQ3A5WFJIRFFBSGhaZnYxbG5GWUFRTng5STh1OVla?=
 =?utf-8?B?dEFIWWlzMFNobTJjd2lnZFdRTGJZekFRTkFLVTFieEVXcjhDcXdMSjRrSldO?=
 =?utf-8?B?RzU4cGVCcTNOeXg2bWcva3k1RDZ5MXdKWVFZVTNlZmg1aTlqUWVnUC9xOVBa?=
 =?utf-8?B?WTNSOEZOWjVqSmFYYkE0Z0c2K0F2UWgzTUFvcVhwd3VEdk0wSjJuelc1OHlh?=
 =?utf-8?B?TTZwM0xNcHdkRFF0WmJiMXR1TVkzVUtZOEFqU2NWUVhiL2gybGJGd3JKZzQ0?=
 =?utf-8?B?d1c4cU4wUFhKRXVrQTUwbkVqaWdUaE5WQjk2Tzl1UTBRSVR6dG1ETkJLbDZa?=
 =?utf-8?Q?K0X+E2Xm9+jObs2TR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d7ed2-6805-4bc1-c1f1-08df33767c86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:33:30.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C54ZiYpbIYu9iiqgXtdMVzqYCCzXuQFvhkrQqCilZy/U9dxFyIeoUVASzhUo+Jo7KDUuhlf/eJvh1x66AV/yGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093



On 10/23/26 12:47, Bjorn Helgaas wrote:
> On Tue, Oct 20, 2026 at 09:04:40AM -0500, Mario Limonciello wrote:
>> Bridges that need bus reassignment are scanned in two passes. Save
>> the firmware secondary bus number during the first pass, before the
>> bridge is disabled, and carry it to the bus created in the second
>> pass. Initialize pci_dev from this preserved bus number so drivers
>> can match firmware records after PCI bus renumbering.
>>
>> Handle pci_alloc_dev(NULL) as well; some in-tree callers use it to
>> allocate a standalone pci_dev.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/probe.c | 9 +++++++++
>>   include/linux/pci.h | 3 +++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 27008e2ea5afc..4ece4b70cdc15 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   	bus->sysdata = bridge->sysdata;
>>   	bus->ops = bridge->ops;
>>   	bus->number = bus->busn_res.start = bridge->busnr;
>> +	bus->initial_bus_number = bus->number;
>>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>>   	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>>   		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
>> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>   
>>   	/* Set up the primary, secondary and subordinate bus numbers */
>>   	child->number = child->busn_res.start = busnr;
>> +	child->initial_bus_number = busnr;
>>   	child->primary = parent->busn_res.start;
>>   	child->busn_res.end = 0xff;
>>   
>> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   			child = pci_add_new_bus(bus, dev, secondary);
>>   			if (!child)
>>   				goto out;
>> +			child->initial_bus_number = secondary;
>>   			child->primary = primary;
>>   			pci_bus_insert_busn_res(child, secondary, subordinate);
>>   			child->bridge_ctl = bctl;
>> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   		 * do in the second pass.
>>   		 */
>>   		if (!pass) {
>> +			if (!dev->initial_secondary_bus_number)
>> +				dev->initial_secondary_bus_number = secondary;
>>   			if (pcibios_assign_all_busses() || broken)
>>   
>>   				/*
>> @@ -1526,6 +1531,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   			child = pci_add_new_bus(bus, dev, next_busnr);
>>   			if (!child)
>>   				goto out;
>> +			if (dev->initial_secondary_bus_number)
>> +				child->initial_bus_number =
>> +					dev->initial_secondary_bus_number;
>>   			pci_bus_insert_busn_res(child, next_busnr,
>>   						bus->busn_res.end);
>>   		}
>> @@ -2508,6 +2516,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>>   	INIT_LIST_HEAD(&dev->bus_list);
>>   	dev->dev.type = &pci_dev_type;
>>   	dev->bus = pci_bus_get(bus);
>> +	dev->initial_bus_number = bus ? bus->initial_bus_number : 0;
>>   	dev->driver_exclusive_resource = (struct resource) {
>>   		.name = "PCI Exclusive",
>>   		.start = 0,
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 5ffcf5ce8c966..f6b377dcf7a14 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -363,6 +363,8 @@ struct pci_dev {
>>   	struct pci_slot	*slot;		/* Physical slot this device is in */
>>   
>>   	unsigned int	devfn;		/* Encoded device & function index */
>> +	u8		initial_bus_number;	/* Bus number when device was discovered */
>> +	u8		initial_secondary_bus_number;	/* Bus number behind this bridge */
> 
> Why do we need this in the pci_dev?  Is there something about
> pci_scan_bridge_extend() that means it has to be in pci_dev as well as
> pci_bus?  Multiple copies means possible inconsistencies.

Agreed that the initial bus number should have one canonical home. I'll 
remove the copy from pci_dev; the drivers now read it from pdev->bus.

The separate initial_secondary_bus_number is temporary bridge state: 
pci_scan_bridge_extend() captures the firmware value in pass 0, before 
clearing the bridge, then transfers it to the child bus in pass 1 and 
clears it.

> 
>>   	unsigned short	vendor;
>>   	unsigned short	device;
>>   	unsigned short	subsystem_vendor;
>> @@ -724,6 +726,7 @@ struct pci_bus {
>>   	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>>   
>>   	unsigned char	number;		/* Bus number */
>> +	unsigned char	initial_bus_number;	/* Bus number before reassignment */
> 
> I think it should be stylistically similar to the existing
> "pci_bus.number"; adding "initial" before or after is ok, but adding
> both "initial" and "bus" makes them less connected.
> 
> Users would check "vhdr->PCIBus == rdev->pdev->bus->number_initial" or
> similar.

OK, will adjust.

> 
>>   	unsigned char	primary;	/* Number of primary bridge */
>>   	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>>   	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
>>
>> -- 
>> 2.43.0
>>

