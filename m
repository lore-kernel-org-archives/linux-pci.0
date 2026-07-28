Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1337BE8E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268699; cv=fail; b=jNWftr5S4DIF5S3g1xa60YIC0bSGAlooasES0tOK9uQ7Ju+t0f8whDH0LAyzxnjIjqlgHE5tk8yjzqbb3jTEn0327q3QnJJxkCYIM4tU2E/AnDBiAl7dHgYOmCkOdNTJRKEOyMqXCjJ6CG6X72QfqX9HL+lP5MhY3U9aQfzJARY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268699; c=relaxed/simple;
	bh=a3EwtuSrUxoW3oOqCJMmQyKNu78431Wzffc3OE5/cWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sO6p7i1/pSXxmO2msihK9txPNBV48yx10KYa3OUZATt+iuDIxamRzPrkbT6lmgbylGFCpcMdPYuyOA1YjCIvpHiDamWKC0KAeyln5pF21iwfnFi5sm3oGLsqSHz3erC1K14pyb75cJp0lDz3Uq702eIuEx4mTtZLefbueza7HH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tj7OGEw9; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tj7OGEw9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtsaO8vGi55aiWOe2vJoD4qN9TcAVPMMJbcytqV2wCje36Hpak2DwoaURhN7J8FXLtzXQLFATtazQHHKfWhaMzp8Kmxp73xZv9V0D2+9qzpH59SKfuWO/LjTZBjV84chBJrAwOvSfYyE6w/4hWHYoToGnR6S55yakDfQKfBEBgy0jrOJVlrx92VYiETd9BL5Wd5J/tq8fhgv2r+sAy+MgPPTEo4Lxsp4QkOWmmH4NJ5LiR46YHJPC73D2l8GoMA2OMP+u5ENzpNF991/5w5OXHZhejdVPZ2EQQXiZOe0t5/i6wL/LaEtvE2RklpdOKZ5oip+ikjN8ZK1/uxwYDcSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzW02hRiNmGZpq+4+KPXB3b/gbXhFle3GEKw3RgYZN4=;
 b=i9c7TxU/faaDXvqr6242Iq/2O6q7tpk9Uuo2j3JpLFQlN2AvcmD5Wkl4J/0uIBOv/Jo8SpU9Y+AlRtyEBViTfo6XL2amkHXUeu0lNCobiiw8T5pDYnyoJxPdWCciulV45UPlXwSRhd/tsGpIcO9b9cesUSykkkVFWXzy/czB3SUYeN3VpIVaFPVlodGotmA/dqvFKsvXYh7pKNEXwBmAlSOxOo3Wp9MxWUnDhONwNMhUCFyE6i5iDvFCPxYxPZ7DWmdsppzYpGNVUqvv/JrYjSWOKeUeOfvBoyd8hyvoXD5vEvjABngxjtILUKS9jWgUiaOb94cDsnwTFG9rb+6AVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzW02hRiNmGZpq+4+KPXB3b/gbXhFle3GEKw3RgYZN4=;
 b=tj7OGEw9z+L5X6zh+6kP/NC6n+sbAbTBIOBNqnBPtYCSv45TcRSlgYjnWv9VScFb3Brk4XdkM7nLBfqi0Z8QHsI2LPJ5o62W9uBE8FbHlfLHKXcCb9IT5fRH5xnOkIgmCugZ1bHnWL+nU/+RMs61JymJxragzE+DxGaLvOyX8W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:58:11 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:58:11 +0000
Message-ID: <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
Date: Tue, 28 Jul 2026 14:57:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:610:4f::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0f0621-dfe9-461b-ddde-08deece28d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	ztI+ALto4yBRSfKMKtxIgVzGS2/MWykvyq2SuODa0CZgHv0CI7cAt/VPoU2/h5uiotiniKLFyIFZmQGah8o82E7fJEHTPU1QctNLxjdKHHDuOtxg7NrDN59/uVQU01SFMKIxv03yvRbTWbOJh0fcrr5WW7W/y0JprJSWJSzbu9E2hR+2CwTHeu4bpH/4YbQogK7Rkrb4zL+hO3JVabpKemQp2fltu+UJ9CR66bAKn4MhlA4IXSlQA3CafEHOgT2i6rWssxes7T42KrvbNMe/zX/it988sP+bX7gX5vKpsGM1+IMqT+XyLuQk9+N/DfADBfGuKNTojb6LfIg6JvN+eR4bN8yChwaUIEffszFz7eRvs2A9lIaFd9svn+mjM5wrjrRkla/pGQawjDdk4HxQ/LseOogd7KvsgwIcM4UTwy2Cezxe4wUU+K/tTaqsRBmPORUfZCi7VNiz02wbJYobLS8+P/kOMoW7K/m2EmOR8Wbuz97A1ZPgmHOE/VbSPUtKinoXzhKaIKuoTHnvokM2L49UajbFdK8mBFrrkTDhSbq3srjACH4Pr+XCYWs5PfXtJgHDI/VTjdUiK9izVYDgjcKrvtdTBE2jyuntqi7pQLwMF/jRbX76RNcJ/8PzMFbBtzXFJzAVEc2QFpaCcOrDO5q6qxAh2k2u97A7P7MionA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alVEcHBhY2QvSFB5aDRaeUZ5REdyNWluODNwaGdyd0RFVmVOY2xUTWFMV25R?=
 =?utf-8?B?dkRka0ZVSHRvOEVzT3U5S3FDNFI5NGNheWNVY1lCMVR5OC9KRCt4L2VEOS9n?=
 =?utf-8?B?WW8yS3duY3FVaFhRYlp0M1Ztb3VWV3ltZ1g2RCtLUWhTZFkxOXl5bGZYSDVj?=
 =?utf-8?B?VE5SMGVDQU5ZR3F5YzRuTjFXbk1tSGJCTDFEeE9sMTZnd28xU0E4MWhnTDJk?=
 =?utf-8?B?Vm1USjhWdEZLbHZybDlvdExCUitlbEdITHBIK1M3QUwyOFNpckpxbU9SdGFI?=
 =?utf-8?B?SEQxL1Y3WGw4ZncrNFRjU3RwVmZaN0tZOTRnOS9xdGxmN3VTaUlFaDhXUElE?=
 =?utf-8?B?S0sxSUlvVnlVZm1mVzF1Z1pMRGZsUUd6L2Y2azFLU0JZdkdlMW15VnZaL3ly?=
 =?utf-8?B?QjhWa2FVU0ljaTNZSjlCdWdZekIvWU5LZUxOTjM3b2lKblFLVFRmOXFidjdZ?=
 =?utf-8?B?L1ZWYzhVb2pTTzI2T2NwTjZLUUZHUEtxMUJZOW9IOXIzZUo3bnp3dldFY0x5?=
 =?utf-8?B?KzlmWE9rS0tpamFZeFR1OHh2U20yS29qdHQrQVVJOUU0Q2JFMXpkTVhGM0lB?=
 =?utf-8?B?OElPUVllYWlHeitIQlJ2bS9OVUFNd0xQT3ZDTlNqNkY4L2NLYmE5NE9WN2Rz?=
 =?utf-8?B?d2krb2lsRDBJbmI3a0ZhdjlQbmN2b2NFMDFrT1NjZW01V2dzV3RWeVdwNDB1?=
 =?utf-8?B?cmxPa0FIcHRlaWtOMjQ3ZzVvSjNqNEJNMUxvYTFuMUU2RUg5OWlXaWd5Z1Z2?=
 =?utf-8?B?RFBpQU5VYVRncVFaeHhLWnVxMkRiZ3lWWGFBSWFWa3JRcCtVYjFybk5JbVhM?=
 =?utf-8?B?WnV3MlkzQy9VTFFwS3NWU2V5S25GT1BoMFV2cmtYOXZaR3ZDYW0rNGNLQnZO?=
 =?utf-8?B?cXptN3NCdWhxMXJIc001Y2drYUhYblZiYkJ6TjVTdjJvZ0s0bkZsZW1kYlZq?=
 =?utf-8?B?S3MwN3BMeW5DK0tOb2REZ3p1MzVJVU5lUWhVeW1ZV2VwemZ3aWxpSGxBVnlN?=
 =?utf-8?B?c0dkcDZCdmxLRldmRDJHWkZmOXRGSXQxYklYbllTNDN6UTFFQ1UyeUxoT1B6?=
 =?utf-8?B?MDhKWGE0ejMwMmpCMUZzbVpGZjkxZDBHQmJVY3hTT3BsenJqQlhJTkVoejln?=
 =?utf-8?B?cEd1ODRGQzhUZ0RlelhGL3NwNVYrSjdTRzJmdEdSbDlTdlcvaW9UUklHc3Va?=
 =?utf-8?B?MXhXdnJjbW1RZERBcXhHdEw2SkhtWDY1YmJ5cU1zYk5nVXJtTWxrK0tIOFNa?=
 =?utf-8?B?Tk5Wd2ZKajdseE1hYnQvUk84VVB2RkRqMEprOTFGVURQT0JocFVYK09xc0E3?=
 =?utf-8?B?cjF2VHlsaE04SzFpQ1hWVm9EVDNnSWo5Q015cDNGOHZnaGxGa1hiNXd4UHpi?=
 =?utf-8?B?azFWZXBLaDJaSkNaaUJ6NkRpV0kxcmZUUUJoU3BLR01CS3VCNkF3eklHUVNK?=
 =?utf-8?B?bFhyMUhTTGxSR0gvTklsME5nVUczZnhITldPcVNJeVdEOUtKZ2hQOXVLbGVq?=
 =?utf-8?B?dzdyQ1FRcUNvNW5Gb1Z6UkNpL0VsQXFZNFY2R1lVcHNmQXoramd4Tkh1RXRW?=
 =?utf-8?B?clRhczc4eEFPR0VLSnRXU3VhWTFSRXpMdk50eFE0MkJnOC9ZN21NYWx4MEE0?=
 =?utf-8?B?VTYrV3BDbStwb0xxejdwd0FEL3hOeDZ0aHFKUXVvS0NuWjFrSzFpbEo1encz?=
 =?utf-8?B?MEF4bGRIL0JFc3pSUHcvQ3JxWE9Ga01sN2NIeVhjaysyWDZQM2RMcVZuNHVY?=
 =?utf-8?B?OUViMW1GcmZQY0pWRnE3aU10a1B4YzFqclM1b1pncytNU0xNeTFla1NxZ0tr?=
 =?utf-8?B?aGNmMSt6Qi94TmxBRS9GYlFzSjd4YmVGb3NPbEVQSmVTOUwyRzdtZE42WXFF?=
 =?utf-8?B?WXc5YnJ5Wk1iZ2Roa2xFUkRZUE9VWjhMbmN0NjlQdk1aeTJtSldhNXFNeWln?=
 =?utf-8?B?Y2tZVk9oaVV4Y2l0TWxPaWNzMklhZ00xQjJJMy9wOS9jNVJXNFZxazQ2Umpx?=
 =?utf-8?B?blBIUHlQdE9ZdjdiUXBjQlZwNjAraXN0S0NiRzNWZFJHSUV5UzE4VEk0ZFpu?=
 =?utf-8?B?TUlobG5UanRSM0t4YzBoeXErM3ROaVRLcWlYLzJ1NUNiZ1ExZGd4WkZSVmdG?=
 =?utf-8?B?NWFMZVBUQlkra2lQaS9IbHYza3VJK1NMcVRGNERqQ3VYdXRBSnp5cFovVXJt?=
 =?utf-8?B?eW5qcnk2ejlMRDFBcTZBcjlySWdjZ1VTcGlodzVNNklWYnE3bDRtOVl4dXEz?=
 =?utf-8?B?alo4QlZFZHI2VUplZDYzQkt1SGRoTnBaRyt3TFZGc2tlYVM5S1NNejYwK29V?=
 =?utf-8?B?aWhmQkFVVXRNRG9hMEpYTzk4QWZxM2tkcUpCbzR1K2haNWVhN1VnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f0621-dfe9-461b-ddde-08deece28d2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:58:11.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY3VqEY7PhvS4l5XEJVDCf9iOYNNkYrNFRlKqSiGJ/XnD6fFDDrI+D91xlIr4YuAUci/ABP4ATIofiS/E0mNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107



On 7/28/26 14:10, Kuehling, Felix wrote:
> On 2026-07-28 01:31, Mario Limonciello wrote:
>> +Felix
>>
>> On 7/27/26 23:52, Vasant Hegde wrote:
>>> Mario,
>>>
>>>
>>> On 7/27/2026 8:15 PM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 7/26/26 23:19, Vasant Hegde wrote:
>>>>>
>>>>>
>>>
>>> .../...
>>>
>>>>>>
>>>>>> I think this can probably be dropped now? There is no intersection of
>>>>>> this old broken embedded GPU and a CPU that supports CC right?
>>>>>
>>>>>
>>>>> I did consider dropping these two checks, but I was not entirely 
>>>>> sure. So I kept
>>>>> as is for now. Once these series settles and I can go with next 
>>>>> step of dropping
>>>>> these two checks.
>>>>>
>>>>> @Alex, @Mario, Any suggestions ?
>>>>>
>>>>
>>>> The background comes from this series:
>>>>
>>>> https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
>>>
>>>
>>> Thanks for old link. So it looks like we are good to drop SME check?
>>
>> Yeah I think so.
>>
>>>
>>> Also is it safe to assume SNP is not enabled on these platform and 
>>> drop that
>>> check? Anyway SNP requirement (which doesn't support identity 
>>> mapping) and APU
>>> requirement (needs identity mapping) is conflicting.
>>>
>>
>> The current platforms I think this is a safe assumption.
>>
>> Felix,
>>
>> Can we revisit the requirement of identity mapping for APU?  Does it 
>> still hold with the current hardware and software?
> 
> I'm not sure what this means. Is Identity mode something like pass- 
> through? I don't know why this is required on APUs. If it's related to 
> IOMMUv2 support, then it's probably no longer needed. We're not using 
> IOMMUv2 on our APUs any more. Support for that was removed from the 
> amdgpu driver a few years ago.
> 

Hmm, I just had a try with this on a few years old APU (PHX).  It's 
flicker central with this (7.2-rc5~ish tree):

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29dc18d3d22e5..1e792cee7f4cd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3134,19 +3134,6 @@ static int amd_iommu_def_domain_type(struct 
device *dev)
         if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
                 return IOMMU_DOMAIN_DMA;

-       /*
-        * Do not identity map IOMMUv2 capable devices when:
-        *  - memory encryption is active, because some of those devices
-        *    (AMD GPUs) don't have the encryption bit in their DMA-mask
-        *    and require remapping.
-        *  - SNP is enabled, because it prohibits DTE[Mode]=0.
-        */
-       if (pdev_pasid_supported(dev_data) &&
-           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
-           !amd_iommu_snp_en) {
-               return IOMMU_DOMAIN_IDENTITY;
-       }
-
         return 0;
  }

The flicking is reminencent of issues moving BOs between VRAM and GTT 
from a few years ago.

So I don't think it can be dropped (just) yet.
