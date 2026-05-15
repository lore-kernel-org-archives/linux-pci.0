Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C33E0244
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834538; cv=fail; b=FI70ACNxK4kel+dEBijeokSgnRrWNbO2UrgUfuONdVruoHk2/l3lAxHs+l25Am5nZ/XYfBghJq/Dc9FqmLQAzq56M80ZtnVNLjZGtg0g/oPCsAxDk+LlgUh1nqrEBeO1rAW1R/3/udzcuSLWi5XqiDvBR/dUp3YKGGzl22JsG+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834538; c=relaxed/simple;
	bh=NoXj/pDYj6cBeSJ9ZKf/7+Nwl5NTNEkRWjByFKyX4XM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tshTKdfHY/6ojFeGIfoNBiI2p/xacCyFfaUJmB1k6YedXymvvk9OG3x7w5sEXoBC9SQ3NMY51M7v1jLHs4glewoTFYKJ5IslDu5k7W3czpV73PfD8jMfTlkTYQA+eX9zSAgsrsSCL9j10B3fYsuVgWIZlNaKAtp2o+OjlC/yrw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wc2dAYHg; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wc2dAYHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8ucz/44Vnb6aYdY0KIe8kivFHAhytVaMYNj1kVH12yw8eHHklYvhQenwv5kUjLbQl/pMPe/8uQ4LRWnHntGI6Qtwnt82xTYhr3jbDze5pZyuEgOqdIHbnTyKnYzt+Atezkm1MBCjlMk+bMOa1DHT5uSfy5+whrQnvXPiBP1HiHteWUOH1j/sy54u77H12l6aloLhB0QFlu6cdDhIFhVFnEcnpAJ93AkKNF8OuB0ybWtq+99MnXXQlrPc6UCDZduTTPOPCY/mxyxbqo42Z7UPQScqg0AZXTF0vgZU7BcT6yQYs3EIfKtnbu7mgFzR6tSCrJ7K9m6KfIpxB8BgT/MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vypN5d38R2Wjsj82fZeEk8grpaER6Uq5dcIGTNCW1YM=;
 b=iqoOeVHcPRh+6GmJHkuu46V6P17gZaVGgECVi32T374rDfqigSphpT+wOU9/ff4W0sdhc/K9rBNfYd2J8zEqykGWjkUn9tH2DpLgokYQz9+QbXAZZ7B7j3i8AfhEEdR6Bgj/qC699FrsCLEk+cj9teZCL5x4glHJ1+WVn+zxPgwA5RjSUWta6tMisXD0NqXRP/j+C2rPzJXep81hnJbZv3O8iGWnwerdCIZoHnvcPPFMXsFqq3iNulqOAF64LznbUOiybN0Emrr21OPtWZjzV1vEe4z6/66+wxwSMf2tUhlwjvX7hvVYE+SnKxtij4wGVa1Nub1WIIcykqM8F06sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vypN5d38R2Wjsj82fZeEk8grpaER6Uq5dcIGTNCW1YM=;
 b=Wc2dAYHgCeSyQo+0UzKB4ZuPb8XBw5vGkYt8P716O78IF9TsLopGKSQ8a2viLPK7BHVP+j+n/tzj0fhco/5fbc3SIWqSxzo2KlphJUFWfEQJuCEc39V/DSxa1BLJEPr0vlOXvNJ3RIWQbGdqnZkAShZgRDid1iVmeP6/HRUmcJHplw1th8eLkMyZm8dqHFrodHGh2DNppzL8oc6QTvS/oP0ZneBwwmGW7XY5FUYi6wqqYu1UZhOiv5eSZUP/58dltbb5caTMFGVHNfk0F5BjtdG43GL5/n3IJdTlLyeeWW3tbzCJglxW0Ot7I9DhZ54+XbwUdaGj9HXxn1oiZBTOyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.12; Fri, 15 May 2026 08:42:13 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 08:42:13 +0000
Message-ID: <309f3ee4-801d-4b32-82e7-56688207e180@nvidia.com>
Date: Fri, 15 May 2026 14:12:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property
 for L1 entrance latency
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
 <20260513035854.21C09C2BCC9@smtp.kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260513035854.21C09C2BCC9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:8:55::20) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: eedf5201-ed72-4d0d-a76f-08deb25ddc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|11063799003|4143699003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	3U3IoO7Yw0c6tilEKdFd+rFCzd/B7v2TSSkrEKgiF5FvnhR9lHVnNIT8j5YR+YlsKirDQq/R/a3bfF/xHoQhXhcblNBP/W7l6rwQBl8u1VTJfpO0wVSDPvw6+qA9CFYOwsQSEeTxBsUHI09ZvyI8HptcHYh8RFCoOm9nDgDuxqzYSSRnG+zeR/7+9vrPzfsUK3bgYR138ByricqKr1Zdk33TaYdmMo69V4ptkN9NtmS/QnXh6XDD+a1SDafGOR3SDcaNWI9TK9F3ylzLugtqXldbEeFWM5jbXdam1j8sO2IjYU0NMgYpoz/URGEvHf846pIbiHAEBt+FfC7oAayZXQ30aK2oH2nrRaW8Czz904IDseL1PTVcqJPqaz2MNGWcOo6wohJUD05vyMJIx/42Fef+dgeNBig9LXVtjhS+mdJc6R/+/tweQElRWZTtRVjuIBXoF9a2KLj36CtolKGU1bxG2eTUlxLpWbua0TyOrhJrzm6EfcmhRSEIbhgVKC9mEsZAoBNiJWfpz/T/aYwWrVXYEKOpIAJclUxOZ3Xl2awqwi9KEtg6Hb01ZqTj4hBoGZkPet64LlT/HCuLWxrCCa1jf1fyx+CjDWIveZPQRURv2vt+mLrx8jHmRWORSKK/NDTdfqn9oUhy3jGIjVboH0GqgAEhU/ywPThm9RE5BFoplRCNYcuLVOSxUx/c+RhL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(11063799003)(4143699003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHhYVEtkcE5OZURuWklGbXJOUGdwU1V4NGhXTlZKd0t0b3M5bmIyUGRSYXls?=
 =?utf-8?B?eGE2QVNSRTJ2OHpGL0ZsbWY5dmhscEw3S3k1d1NTSjhEQXZLUjVxbzB5Q1hu?=
 =?utf-8?B?NEZ2Y1A0VE1Cbnk5cmVsa1greWRuellRaFh5U2cxWUhGMXZGbXRBZVNieUNC?=
 =?utf-8?B?U1NYditrL1FHRGJjaW1UdkJ2MCtqM3gvK0J3dU9rb21tcjBWR0xhYS8wenNU?=
 =?utf-8?B?clJ2allQRWdTc0YvR1BHWnBnK0xucE9iQ0owa1d6K2pseDRpUWNBQkQwbksz?=
 =?utf-8?B?MGxxdVkrSEZlRzMxKzFHcjk5TWQxMGF5cTVTbHJ5VUNJOE1SWWxiSktHcnZG?=
 =?utf-8?B?TkwxREdaSjdaZ3ZKZGJCU0NkWlM4NmU2QTlsb3BCTGZTbTFSTHVJeWNMWTMv?=
 =?utf-8?B?aFZiejJyd3NEOTQwcXlnQjI4VUxKSEhyd2EvL1pLU0RuOWllZTNncjVFVTBC?=
 =?utf-8?B?UDBpbEgyZlJrQjBnUVlNYVYva1NPYkgwdHRZczV4anZPNXFLUXVoVUhleDFz?=
 =?utf-8?B?VEpxaW80QlJCR1lUczNkRUdXeDROajF2OFhBVzdRNG5KMjNvNTBmVjdRakZh?=
 =?utf-8?B?MEUwdlc1WFk2ZzByc0xYendOT3ZqK2pmRGRDTHU3cVA1c1BDSVhMOEwxY0dR?=
 =?utf-8?B?Mnc5bjVqRzJCdHBCWUR4SzlmazZYNWc3MmpwVUNrSGJ0UnlBV1dqSVdGOGo5?=
 =?utf-8?B?elNUR05mWXg5MS9zTHFzZWdoV2w1bGJhcXdrUERDMHBpdEV5NE96RHNibTRh?=
 =?utf-8?B?THd4TzJjc0tlOWJjYjZXSDhiYUIySmI5QUxPeWx3TWtWd1hUT0dDOUM5WXBv?=
 =?utf-8?B?cFkwbHo5YXNpL2ZwaHZNRGRQZ2VXd3E4TkR6TE5CeHZPcDJOVDRQelVjL2tJ?=
 =?utf-8?B?UHlJWk5CZTVjYnVUdWpLeVhYczgwbWRydjZNVHIzTFZlUUNJRkk0L2RmWFo1?=
 =?utf-8?B?a1NkRGdUaC9IWnd4cVNWdGo4cExNNktMSEFpU0FxbjJHb2Jyb0FjL3RLb3NH?=
 =?utf-8?B?MUdIaGpTSm9EcjZKR2Ewc2FhTHhmVHRSM0ZjME9TL3dRTUNiYnB3UEdORTdi?=
 =?utf-8?B?NEF4dEh0L2hCMTFQZDhpSjJYSmlxdWZ1dXVKWnFFSHBxVnRBNmY0Vlh2M25m?=
 =?utf-8?B?RkZIaDJXRkhxUHJKcFVLOFIvZGJtdiszUHYzYkNRSTI4aEIrTWIzb3JHQjhr?=
 =?utf-8?B?SUVVdm1ncyt3U2twb3JxUmNacWtjc3FoMmlLY1hCWGM2ZDRQblE3OXJyUXg4?=
 =?utf-8?B?Z3d5bjJVUm1iSjVOZFRPL0V2WXA3MTVYbEZxeEJsb0JFMW5JU2dpOHhZcVpK?=
 =?utf-8?B?TnBUbTdYWlBRTnMyZnh4TTJ3MUhYMm5MNU9TTnBBRnNzSzR3ZW1TSXVjVEVt?=
 =?utf-8?B?M3k5QUdhUzBGYkNXRnd5a2ZMQlB6M2JwbkRUUlF5MXRLZ2Z0N3VmUHBpaUcv?=
 =?utf-8?B?cDhqRDZIVXFHS2RwREJtdVVQYmF4cDBjZUdzZUlJRlYzQmxUUmxWRm1TWUQ4?=
 =?utf-8?B?U0g2QXhSZzc0aENwT2tEam5uU1dPUUMyQ1Z4ODlxTWhpL28vTHZtQ3lRTlgy?=
 =?utf-8?B?bXVGOWptTGh0MG5kOElvZW5rUDJTOEF5bzBmeUlqL0p2Y2dKQnJ4dWVGYU5h?=
 =?utf-8?B?clJUb2tEb2RGVXNHa1Y1MHh3L1kvTytOWWw3bVltcGExTVptVGhvZWZGL3dU?=
 =?utf-8?B?WE5YNExOdnU2MkxQODNJbmUxU3dZVHFTOGtKUnFoT3Y1SCtmRUlZZzhtQ2J1?=
 =?utf-8?B?NUpJVmJONlM5MHQzMjVGT1ZNOFdmd2RTS0lNYnNtQmZIQ3lnRkpTRnhJc1hx?=
 =?utf-8?B?R1MwZkZZb29jT3NXaDEwTi9sWGU5eDlYM2x0bVhCREQ1WExWN3hsM2RWZ0c5?=
 =?utf-8?B?Zmw5M1BkVmJzaHQwQzRuc0xXYk1EUUNnS2k4WFNBK0RNMk5aNDNzMkJsbmY4?=
 =?utf-8?B?L0pzcEllRC9KTGhYaVQ2Ukw2eVAvSnV1aDByRkRSMmg5ZW81RUc4bHZTNDd5?=
 =?utf-8?B?eDdqdHhpSzdtTmRCUE15dHI1b2dlN1RCZkEyeHZwdzNFcE5rVTErTS9xak5G?=
 =?utf-8?B?N0tOS2E5bTJoVnVVZVB5WEZ0ckltTkZOV3VTRVEvWndCd04vVDE4aE1oRlNQ?=
 =?utf-8?B?d2MxaFVHTUtsZ0V6Q0U4NzZONlphcHpIR096R1NaUFVlTE5jREV4cjJQQW9F?=
 =?utf-8?B?Zlk0QU1HTmxYMnFOeGNqUlhwK1RnSmRBcU1GRk43cUZlTXdoSVVCOFgyN3Ry?=
 =?utf-8?B?TzhNWFFmT2tzMGMrb2FTRFR5TzkxNnlWVlNjK3FXSVJEREZQY0hmc2liTm8w?=
 =?utf-8?B?eFBoUk1XNVByQVMrbGxnc1NQSCs4bTVIZlhLMzZ1eGw0bnlvaFZTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf5201-ed72-4d0d-a76f-08deb25ddc31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:42:13.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxHh5x6Mkilkq7QBYiUjLN10iPxz2zOHyqTcOoGXzPg1z9IbVbIH38WPJtnkAogyB2su+4hwcrN5CkQqrrxkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060



On 13/05/26 9:28 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] L1 entrance latency calculation prevents programming a hardware value of 0.
> --
> 
> commit 63300af08363595c90cc1e642b1cf857792eae94
> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> 
> PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
> 
> This commit parses the aspm-l1-entry-delay-ns device tree property to
> configure the ASPM L1 entrance latency. It converts the delay from
> nanoseconds to a 3-bit hardware encoding.
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 9dcfa194050e7..c9716d6144517 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> [ ... ]
>> @@ -1141,6 +1146,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   		dev_info(pcie->dev,
>>   			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>>   
>> +	/* Default to max latency of 7. */
>> +	pcie->aspm_l1_enter_lat = 7;
>> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
>> +	if (!ret) {
>> +		u32 us = max(val / 1000, 1U);
>> +
>> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
> 
> The commit message states the value is converted to a hardware encoded 3-bit
> value that is equal to log2(ns/1000) + 1. Does this calculation prevent
> programming a hardware value of 0?
> 
> By using max(val / 1000, 1U), the minimum value for us is 1. Since
> ilog2(1) + 1 is 1, pcie->aspm_l1_enter_lat can never evaluate to 0.
> 
> If the hardware supports an encoded value of 0 to represent delays less than
> 1us, this logic prevents configuring it.
> 
>> +	}
>> +
>>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
> 

Hi,

I published below series to fix this issue.

https://patchwork.ozlabs.org/project/linux-pci/list/?series=504377

- Manikanta

-- 
nvpublic

