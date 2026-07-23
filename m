Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5953E4C66
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823857; cv=fail; b=uX2GgSk/1JlXT2Y36+ZkC+SstDTB8OGS61LietS20wwVrxEC7ha1kfZWCQVCP46S+2EjaDBX+D/qVkaV0G1XbeEj+CScQC/oSiYJ5Z0evIpio6JhleEYopCyt096Bcc/m0Jc/YdxU0dWvUYvhud0UvegNQ+z2TharDMR3RYfKXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823857; c=relaxed/simple;
	bh=Uxub++ge9z3BaBwvYKSMYc/isY0y2d25lxItbFHUHDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJbSG7QQuarZHXNgLqFo+oJO8IzX9NYkJhnAob1reu1FAuXDBP0obB0kN0Rzw0HJQrAqk/zrly3/lihrn9SzlCuuxKm2mxCw+nZphOW/Y+djH3I0oM8JHy2OO2C87d5VhRPRGTNAqMqUhyrGHHPxrTbiVpWKDp6EjYRmI3OpiUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jI0KEPCf; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jI0KEPCf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReXd+RDj3b2nkrkkxQ7SGR1JKwUeBnV59nXiAz/onIdv7KRQsOHllQSA0VhjHnJc7RVLxp2PkDkDY3ZiL2m1gx4WbtLsEOHdkeupvTqCcQbJy2ZrOpyw7BlLUfmU+wopqqK9/q7tqtbOvc66SQ1QrzIZWKmkzc9MIWrj6PT2zsEbyHPGE3m4yplsB02jlaeERurUj8z++d5Ko2QaQUfBPScBuvwfTVlw+ASN4vbxeZ0wensfAu+L/3kEDNXfQZmR4kUz6Z6G0hcE4jIQe93Nm2USKfKyzcOT4olmxNehFd4rVNR18upRe/asiV7OI2UIDRyBMlOYmUa/7xBcFASKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6lsMfMbXjrnGh+Uhj85cPpjnYepUO6LpxNaDnfBrfU=;
 b=I3m1g4YzPDaHVZXon86RCjNq0MMFSd6tCdWwB+3oPb5fVJ5vrOU0lg07zWChpLRHUshIPfYQzo4qLMFRsf6nlPQ5qxzhOhn7EFmKRU5/YvHmn5hJcOAd3VWHWlMDrAlu0bgy1t+vMmHtzSss6xIYy2aZ4q0sCNrQOF1aiRMnk/nkDVrXAQQfrIOvRmxpMQrBXqKICfShkCGGOptft45W9zdVvczg0Ym71jWq4g1ozxGu/Jjdoo6nZPF2v/INUhj0bSSD/XGOVmJ3Kyx2p4ySb+6xkoL8d6HbucmbL1O3sEjpylhffAd1PLWpn4Z0A6PjNszE6NTPhSnvmWSmcfss5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6lsMfMbXjrnGh+Uhj85cPpjnYepUO6LpxNaDnfBrfU=;
 b=jI0KEPCfj5hjcso5M6my2jB6/EUt5+1h4JEUWpPa1IaZpxMzwqBp0qKWBfzEv9h8jl111U8lDwjSOYlyrF+dS9vylmG68EYIUeMNIl1OUi5r8SJ+KOEKU/IsqDKc4uqMsy009KJ+aNE4vqEKvXQs1agF1dcYwRu/yEEFZ3ADdHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:24:03 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 16:24:03 +0000
Message-ID: <69bea169-ac78-4b33-b9ed-0fe974e0248c@amd.com>
Date: Thu, 23 Jul 2026 21:53:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <20260723155912.GB836122@bhelgaas>
 <f2242b3c-5d2e-41cf-9136-72a90e86d17b@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <f2242b3c-5d2e-41cf-9136-72a90e86d17b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0345.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::14) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 63976b40-eb5b-44d4-d573-08dee8d6cf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nR2t2oZ3G27avkdo7yP0PD/0ZM1yTjGGL1EqfUdHTr46rOaW2Yoz+lA1bOCSBiIUpv8wDWdTaRUk7/IAXOLlEeqZbuEUFf2XqFQtjACBZdBcQf41QEGhXoEqnL16ffj43silNxHNIx6dh9wNCxxJCpzb+4kU9mNpXYdGU6JasHaQXPSAi4uIJVpO3NEaNRRfwjVGhpPmAIoWoovi5bliRxH1xUfhqayw7YcvKQVTDqmwIn6Kvtc71dkxPzvixeFoU+Eyt4w+bBb7Fg5jgJMdaFhoX2DNNoatyckNSD0rfvjyrsd3uICRvxFC1tWgiWVNk+EINhVM2uB7X6hqObGceogjSWgCgdU//Johvdd3T4FtjlSi4pN4rLccO6PmJxvGLvYV/48AWRyGPKA7t4ZJVc8z0nnYrpKI1RtGTUKgoX9W7Iios7GRKESPqu5uas0jODId+dJDW2De21gBXXxbv62cj/LMa5HRk5g9ZA6z31FcfToHJPSq7SiHlb5xs8jPGEYoPgRcR0cmu/sSVECqpbeMoNWduQtvaOmcxL/Se43iE/qOWVE4ivYE+61qv0LJ8W8qv1un8tTLRmJBCG5JoMieQz25Dr3hdHmDxL9odrvkuyTuBs02bN21zdNEpkWV/FZJwKVsAqhQOqVx79q+duiPlQ7GwhfJaIe3JydBa8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckErVWFGZnNuSUQ0cTdveCtjNHZTaCtsS29xZVZuUHp4VUVtNFY2VXJMK3ZJ?=
 =?utf-8?B?NVZQc2RIM1Z3T1pNbDE3VjlYMW8wajhadkZ3NGhBTlpsUlhnRjlXcnNFbEt4?=
 =?utf-8?B?dVVUZEVnU3FlSXJ3Zll1VG1Xb1M0KzR2cDJLTHYxbnhUc0pyc0hlc2ZPQThZ?=
 =?utf-8?B?UlBEZVFuVEtVSk9TVjV5d0NNcWNreUlrT3dmV05ESGpZR0l3RiszSjBhQURh?=
 =?utf-8?B?d0gyUHRGWVpDam05bUc2U2h3MWZGZmlmV3ZGbU1aaVpOVUxOL0h0cythSjNq?=
 =?utf-8?B?RDF2VDBjaFNDVU5LdzhxSW5OSHh0WnYwZW40dk9LdmpHOU5DWktQZFBaenNS?=
 =?utf-8?B?RHpod0JZcjY3MFo1YktUZFMrbXJqQk1PUkJlNjVsUHppOGtpTmsyQkszYkpz?=
 =?utf-8?B?czBac0VZNzhibEhrNkZqalF0NEc5d3JWY2hjQ0tLc0lkaDZ5eFFVY2hzNk5W?=
 =?utf-8?B?bGk4ZHYzcTlRSEpGeVh5MmJWL296RVBrVFNiQWFGSWxPMU9KS2cxdnFXMnJW?=
 =?utf-8?B?V3Q0TVM3YzhwRVRGNzhtN0RoNWdYM3pmaGswMVl5d1U4WWo4WmVyN3JVU2ww?=
 =?utf-8?B?blZmc0FId2JEMGlCclM0ZWR4K0sxNjhwYXF3K2ROK3g1UGE3Mkh5UGRBWUQr?=
 =?utf-8?B?RDREYUVMdFMrZFJMZDhCN1JBbTh3Tjh5M0NDS0thcitlT09ERTd3ZDdjZFV2?=
 =?utf-8?B?emcwYkZzM254Q0I1ZmhXYllYd3ZXVTlhY1dIWmZ4WkY0bjBzUys0NUsrNE5q?=
 =?utf-8?B?WE9TUjI1OGlvQ1UwVS9lakdGMXVRajY1b3lqNGdJL0RqVkRGTTFyWTFaTXhS?=
 =?utf-8?B?dUVFVlZTMlJEZ3pvbGdaMmN5RFNsL3VTMUgzYjZvc09RcnUrU1NzaWpJWUFm?=
 =?utf-8?B?UE9qbDAwRDdDTGJsd2RMNnBEZmo2ZTJjV21aRmhRZVphVElsczBMRmN1N01T?=
 =?utf-8?B?WVVBVHUyaE5EYXVhVjN2T3BybUcyY21qdDFjNVluSFhadTNVTm9DMHVJUks4?=
 =?utf-8?B?STNOQmJ4b09LaXBRdFo2bVVnUWE5MHdWVWVSc1ViRnJJNmRwdVozK3pRU3l3?=
 =?utf-8?B?ZVlUMHlzaFFka25pT200OElneFlrdnl4UnhOUVgwVHBGWjRld3I4SytyWlFS?=
 =?utf-8?B?OHRpOUh0allZeE10SXBORVNrUXZta0d1RUpScHZXWTlqVzlQZWJpRUNDVjM1?=
 =?utf-8?B?emo3STFXNWdqRTAyUmV0NGtqMlZSc1VGbmJXOURxcGRpRXB4OENTUTl5SEps?=
 =?utf-8?B?QUlxYWZPU3dLeXh2M0N3bXNBMFNYMndKa3pISWVaR3JOdVFKTDRsU01iSGRm?=
 =?utf-8?B?UkRYamZMMU9SNmtQVzQ2MUVJZ3dkUEsyS1lrQTJMSFZHdzdWRk9vOWNWRWVy?=
 =?utf-8?B?b1c2K2JvN3J3V2I0T2t1RFNLanB3U1F4MnUvZVhhbzA4TVpCRW9mTytmdE5Y?=
 =?utf-8?B?cEZkOTAyT2xxM2F3TVUvTTAzdzcvQ3F1aHdzaW1ONkNVTjl0eFFLQlFUYU40?=
 =?utf-8?B?OCtxeUx0dUpWNkhsQk9jc0UxUlphNkNHcDJrUmVhQkJuWWdaMHVzU21aRWZV?=
 =?utf-8?B?VzZXUXBCbzM5N1ZQSDZWdUhxUUZmdklFNVBIdUlzVk9DeHZjSHE5SVlZTmFr?=
 =?utf-8?B?bWJwc3dvODAxYlQrbUJ5R1pnTTBxbFErUWxDS2xMais0RDdNRkJiT3pmaWdz?=
 =?utf-8?B?b3ZlbkZGc2MzaCtxdDZXV3dwdHlDcDRrN0NEZ0FpVjlURnY3YUFHclBCc25J?=
 =?utf-8?B?dFEydXlsVHREbkVCSEl2eWhTL1E2ZXJaYjZwZExEZ21DMXdhN3Rud09kRHB3?=
 =?utf-8?B?aEtGZFNiTkxLZHZvWHNWcWN1TTFPclcreDByeUtpYzNNb0NVcXRianRGZTdn?=
 =?utf-8?B?TTA2bFBzSmdPYzVxSDNadS8rY3JpRUlKMXMwRUpWdWZYb3pSYzhLS2RwOWdS?=
 =?utf-8?B?YldVdVMrbkhQOGhmWUFmNDNKV0NKMzdUNjlkZWlSS0VvS2Q4ZXBJaTlNcmh5?=
 =?utf-8?B?dUhoSGN3cVhEOTN2eWcwSC9SeVIrRlhhQXczYzBvb0ZQMXNJNGoyRlhERFBZ?=
 =?utf-8?B?a1lSSVh3T3Q3U1FNTWdEaDd4cGtjM1RBUDQ5ZzlsTmxUN1MvWWxBMnhsajFT?=
 =?utf-8?B?emoyUTM2UGY4MUJ4TmU3V3RjS1cvYTBZYloyR1g1YjJNZkVaanFKN0RYNWM5?=
 =?utf-8?B?cU9TZnBKK0FzdVhUcFU4cy8rUGpkL3NGUnZTRXloSHFIL25YL3Y0WXdDcm1u?=
 =?utf-8?B?N09GYURUSHdwbUhTTzNOT0syZlNmVVROQlhWdWt0OER2SFlLelJGc1M1SzJa?=
 =?utf-8?B?SzZmOEJpVUJJWEp6YXAwbFZsYlBWYUNtSkllMG5tb2J3NkxjbW1RZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63976b40-eb5b-44d4-d573-08dee8d6cf24
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:24:03.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xdBRXU6TJ9v4L6FcWHZQujiLjkPWhcWS0JVHG68iy709fq2B9hxFFKRRodXnlCmpBrTiwzQlmoqzETlMyxavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

Mario,


On 7/23/2026 9:41 PM, Mario Limonciello wrote:
> 
> 
> On 7/23/26 10:59, Bjorn Helgaas wrote:
>> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>>> using PASID check. It worked fine as most GPU's has PASID feature. But
>>> this means, identity mode enforcement is done for all PASID capable devices.
>>
>> I think it would be useful to know something about *why* these devices
>> require identity mode.  And what happens without identity mode, i.e., is
>> there a user-visible symptom that happens when the wrong mode is used?
>>
>> Since the code doesn't test any feature bits, I assume it's because these
>> devices have some hardware defect?
>>
>> s/GPU's/GPUs/ (twice)
>> s/Currently its/Currently it's/
>> s/has PASID/have PASID/
>>
>>> Previously it made sense as domain allocation API
>>> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
>>> check device capability and decide best suited page table type (v1 or
>>> v2). With recent enhancement to driver code, it uses
>>> domain_alloc_paging_flags() ops for all paging mode domain allocation.
>>> This can check device/flags and allocate best suited page table (v1 or v2).
>>> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
>>> GPUs only.
>>>
>>> With this change system booted with DMA translation mode will select:
>>>   * Guest (v2) page table for PASID capable device
>>>   * Host (v1) page table for non-PASID capable device
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
>>> ---
>>>   drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>>>   1 file changed, 45 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>> index 563f9c2672d5..fe642e33c87d 100644
>>> --- a/drivers/iommu/amd/iommu.c
>>> +++ b/drivers/iommu/amd/iommu.c
>>> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device
>>> *dev)
>>>       return dev_data->defer_attach;
>>>   }
>>>   +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>>> +{
>>> +    struct pci_dev *root_port;
>>> +    int class = pdev->class >> 8;
>>> +
>>> +    /* AMD GPU vendor ID */
>>> +    if (pdev->vendor != PCI_VENDOR_ID_ATI)
>>> +        return false;
>>> +
>>> +    /* GPU class */
>>> +    if (class != PCI_CLASS_DISPLAY_VGA &&
>>> +        class != PCI_CLASS_DISPLAY_OTHER)
>>> +        return false;
>>> +
>>> +    root_port = pcie_find_root_port(pdev);
>>> +    if (!root_port)
>>> +        return false;
>>> +
>>> +    /* If bridge vendor is not ATI then its APU and force IDENTITY mode */
>>
>> s/its/it's/  "it's" == "it is"; "its" shows ownership
>>
>>> +    if (root_port->vendor != PCI_VENDOR_ID_ATI)
>>> +        return true;
> 
> This logic I believe is wrong.  You're trying to look at the parent of the
> display device (which is an internal PCIe switch for a dGPU).

You are right. It got inverted while I was fine tuning the code.

> 
> You basically want a similar implementation to amdgpu_device_find_parent() which
> figures out first device outside of the dGPU.

Ack.

> 
>>> +
>>> +    /* Rest all are dGPUs and works fine with DMA mode */
>>> +    return false;
> 
> Mostly for code flow, I think it would make sense the force_identity_mapping
> fallback is purely for APU.
> 
> IE something like this:
> 
> if (vendor != PCI_VENDOR_ATI)
>     return false;
> if (class != display)
>     return false;
> if (pci_upstream_bridge()->vendor == PCI_VENDOR_ATI)
>     return false;
> 
> /* rest are APUs, force identity */
> return true;

Makes sense. And pci_upstream_bridge() return NULL, then return true? (something
like below) ?

+static bool quirks_force_identity_mapping(struct pci_dev *pdev)
+{
+       struct pci_dev *root_port;
+       int class = pdev->class >> 8;
+
+       /* AMD GPU vendor ID */
+       if (pdev->vendor != PCI_VENDOR_ID_ATI)
+               return false;
+
+       /* GPU class */
+       if (class != PCI_CLASS_DISPLAY_VGA &&
+           class != PCI_CLASS_DISPLAY_OTHER)
+               return false;
+
+       if (pci_upstream_bridge(pdev) &&
+           pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
+               return false;
+
+       return true;
+}
+

-Vasant

