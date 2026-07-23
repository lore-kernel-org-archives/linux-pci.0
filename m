Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88E3515C5
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824381; cv=fail; b=jmhlMmZpB13ji+YB+kUMVX8yRbhGrR2FvENU7s5JM7D//VjlNvniwXiz5DfO3W1ec/8zOuTHsxJkj8EqsaZgZlVk6lxR04+2NZ8yYfSrSU/avqUWO9TwrY8/G3PBxNAAzD+JNnmnF/KHsy5UzdoBGCLUVG/aErYIXMYj6Ymcqqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824381; c=relaxed/simple;
	bh=caACpJQ2FIoz256FqNRROMdqAq2xZv7CYSyyNt9Uw+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bcjGPNT+pdI4JaVmtBAhBPQHxX4BhYb306uqafuN8/4kEz2SJpGkG3/6KdBDFzTT5mNdR+nh6ySJhS/fLUXYB2N/2wWXYYQGM7vDETL1TTfp7LSWfKtqoC5rmNkKmbtkM8A5MB9EJIqDqhfPlwZXNJn/DbaBMyGvQCFmkF8MoyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjDkhZ2t; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjDkhZ2t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvhxK9sQVoI7+XLlpTw1LmztkH1WHQOX9m/m1VM3ZWLgin5B1g0dgYtLd1qzd+WImQhrg+N9ui2UNPZyBcwdDkiWqLUsptngkWV+XBzyJRzJtUykRi9u3rmqvtKo+rEDwQCUl6WDCBOnbicn9MkGApylWZFiBS2mr+/Ht/NiTxrAJnR1WU239BchqeoAYE2oOTh6Mxtr6v9MuG5fcZeSFALC2ZmXpXROypHO8smv2k08R9CfYIlm9P7Iz+33xoP1EogEvW0979fLfRrLpyoZ/Tk+lkYRBBY016IU/9iB2pjiCfbr018pB/Qg6RDOMznH2TWlSD0lFmStpDRzEQ4a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD++actzKdbf0Y7UPej5/ZvJyZLuWBkoKWrfGoMQhcw=;
 b=DgWuPzf8eOyQmt1yrHwAggkJM38LOEOIOKLAtEuLkZYpizQFmnodlXi4CHWdcj+lTL6gSfvlbfMaFgqGhp+nY83W3lbKRsq8Wutpg/yW0PAENQFZ7L4Egz7aXCzBGc7t3BNyLJEEYZPBV7dJ7bUSkh/cKv4OSRwHY2qzOwylNx5oCZOpKKhT9pC880lI6DP/xFtPsviLW04AUMUj0rVQyUHJPPDzD/I876owCCWjgZYzNGVG/K8So2ea2xtVqorx1w8Yp9Ll+zbHrndg/9iUxXC71rkO5lZbV2axZTs1dIvT/7V1nVVN6TszwFoUGdRzkous1uYAirc3OAkfsPNQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD++actzKdbf0Y7UPej5/ZvJyZLuWBkoKWrfGoMQhcw=;
 b=VjDkhZ2tIe1yvW2gDjvZd4/hi5CBv+8xnj96GUEyxhtX8OjhTXVCjreM9NUYfGfJd89ocxckg/YQmqajyfqNuvSS+FL79C47QBc9Npm6XkNyMSxph2KSCxICeDgRSbr2gd+rxPXr4cwvXcgVG6KQ0gN2hTTfhpBTfjNVCVGYGu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:32:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 16:32:52 +0000
Message-ID: <e9595d4f-419f-4d42-bd22-c3a8964c370b@amd.com>
Date: Thu, 23 Jul 2026 11:32:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <20260723155912.GB836122@bhelgaas>
 <f2242b3c-5d2e-41cf-9136-72a90e86d17b@amd.com>
 <69bea169-ac78-4b33-b9ed-0fe974e0248c@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <69bea169-ac78-4b33-b9ed-0fe974e0248c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::17) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ee43b9-809b-4231-66f8-08dee8d80ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|11063799006|5023799004|4143699003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TcLWgSBUo28RLXuUupVi2m9O7epHJSDgHMhU6xqxX+sAv0fGl9IrjBVbWzgvyEmo8s2QX//X0ZSTNikiIp2lvjZHu85pXOCnThzR+4Ob+c2rXx7efS2rtPkEba4R42lIGF2PykMGbz7lnPXJ4IbBr179kVyRaOmusjCvLPVquc/5q8/fZv9uxlK7Zii3Ikv1YjPx56iA2Zi+qRxYDncyPDSg577QHmPnCTL0Zz50EKx3Qra+iiJ+7FYzlbDkqoWi0c8KwpPkGsFfhsadzxeGKu46G5wEGrAYcaZ0kVkW9lK8Lbt4bRbddLLYj7v5TZuUloQhWcatHsfRLNg9JBNq1dnojUBTuCdBuBdH9gN7Kn6eqgY5ozQ1GdVHYTA8rXRWWUh8hguNKeTc96lCOvu8irz2Y0QrUbTWS6m/C0y6r5yx5D8w8fF7OS4URMK7Yf3B/xx3wUUYkT7VxKdcABP2c+uEpUV7tMBvod+SyTEnKLRSpvCbaMHsMMShV8Bn2+xFBzKiTLS9A7i96ci/1pZ0/680M5FmPmHV2v8N9iwpCBnE5RuWCBHK2ionLlAKN57KWKWQ17iuheYtZkGInHmmwUS1yI8sZlkdDp6d/KcWQAPlOazcOj5rS3dqqbbQ/rf52IWNgfu6Syco1a6OuWaScCqVWWhjDhborYK0uIs+dYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bno2MHF2QjhoeFhWNWxZbmpuMGtaTHp3dDZrcnBmVVJSYXBoLzVnc09QeEZM?=
 =?utf-8?B?aDlTcHlHSk5qR25vUTRjZEhIdHJ2VnBpVjRhK3BJelYwc0ZxUy9hZU01d3gw?=
 =?utf-8?B?ZGNWMzVlV0pYclp4S1NCcEhQNFRYdStycHdNTVVnVFNLY2N4NU9YQWN1Umx2?=
 =?utf-8?B?Zi90QWdOME1iS09ZR2krWUg0UHFuYjdIOFlCYXFQcmhUNFlHbkxTL2pHaG9H?=
 =?utf-8?B?d3hjT3VPV29Bam1tZ1ZQeG9HRU8yQVVPUkozQWdiemFmY1FYSHNvamh6R093?=
 =?utf-8?B?N1YrdEp0U3VlOHB3THd5YzNNNWNmT1FmZE4zYTBwaFpDWCtRamxpVjlSYWJs?=
 =?utf-8?B?ZGhjSFdvTXpNODdHOWd4WDlmdnM0L3JWVVhzYVo5VnpiVit6S21NZ1NuMnNC?=
 =?utf-8?B?VjNtUW1mRXBFRXhqekNHNkU4azZYdTFtY2NSODY2dTFnZVg5QUc5bDZidjU4?=
 =?utf-8?B?bFg4eDZsUldiWU1mRmVSQ3ZoT0NTeVFFRXVCWlR3OHVZdzIxWW1rRGUxSUZQ?=
 =?utf-8?B?TjVZeWlkR1dIV0ExK1RWWkJFU2pMMkRtcmlQRHVLcUFybjV4b2hvNDJUZ3cx?=
 =?utf-8?B?SEhpUTVhVVdXelNsZklTNFBNSytTNmxzajlWZkZpd29pbjZ4SzhQWE51am1y?=
 =?utf-8?B?cW9NOXk4OThra0xpaS9vYTFGOVpFL1FDVVdUUTlQZVYxR0czc2ExNVd5VGlE?=
 =?utf-8?B?S3hFSWYydzNBcUhYQThyY3JNaGgyLzJRZnZLWjdteWNPQVc4Sy9sZzQreldy?=
 =?utf-8?B?MndUVThXckUvNGZJTEY1S29XRGpGdzdBckQrRFY1eFFSd3RBR2kzbzhyWTI5?=
 =?utf-8?B?QU1hY3UvUGNXdHhNdVJ6Mk8zcFVDMVBMVHA4VHJmdE1RdjB1RlN6NmVaTG12?=
 =?utf-8?B?SCs4Y1dlQVloYW15a1ZqSCtMN0x6ekZhaDhGMXorMlAvcXdIYkVXbkl1L3hl?=
 =?utf-8?B?bnN2bkFsNzBMM0tENUFWb1ZSeGRxVFJaQjdSWHhFVzRZUjNFemRwNkdKUGJ1?=
 =?utf-8?B?SDBXM1NnVXNnc3h6TmpzK3ZlRHlVSS8rMXJrNHhsT1BRQk03YmNxOWxxT1du?=
 =?utf-8?B?QXZBWkhtZ1dqVjVnRFpUVUhNNHRDN0doNmp4UG9iRlFjdUhtdGxwTnhxUEpD?=
 =?utf-8?B?MnFCb0xoQXgvNWE0ckNHVkZaNWdudllXRTFsbEdXMkd0b2l5d3RDV0ZDUFZm?=
 =?utf-8?B?M1NwaXpXZkNBWlRIRFY0U2VCczdYQVp5NnBpdkZ2Vk5ZODl4YWs2cHcxQkpk?=
 =?utf-8?B?Z1Q2MEo0dGMycVRueFBOY3BmWHVyWktqMWJob0tybk4zV2Y0YVNEaGFPL2lF?=
 =?utf-8?B?OHZQakhyVmZXR0pJbUV5ajk5dnZkckR1R2ZUWW45bFMzanZMNTVBOEhDZnRh?=
 =?utf-8?B?TzcweUFGUndUaDlzSkYwamJ2Z21hSWxmbjR0YVpNRWRLV3RmbjFwd2pZUEcv?=
 =?utf-8?B?bFB6aWpoWFkyZkVJb25nWnVhTDArV2RvNVRGSGV5dkZLelpyUW9lR3JoTlFV?=
 =?utf-8?B?Z2tJdERKZEVteWZtS2dnUlJ0bFY2OVFGQUtsbXBOQVgrRjVxckh2cDEzdVdv?=
 =?utf-8?B?cmtxeUF3TW5hL1htRWFCRWo5U2lPUktiT0dkQ3pqajBoakFTOXdvT0hWaVFY?=
 =?utf-8?B?N1MwcjB4RGpmU002R0NqbStoMTFXd3p1U3ppaUp3NVh5MGNmOVV3WktOZ3oy?=
 =?utf-8?B?dWNiZmdoKzQ1ZkVQZE1heDdjOWtBVUYzVzk5S25hdVFpQlNOd2RSTitsRWhR?=
 =?utf-8?B?dENpZlFra2VpbzdoVDRoL3YrOG5UZjJERVQzSmlaSFNTWlV1SjZTR1M4RkFn?=
 =?utf-8?B?VVJIM282RWhFNzh0eHFKbXBZTDJ1d3oxS3pSRC96elFlcEtpcWlhQkNPWVZ1?=
 =?utf-8?B?dWdqY2I3ejl0clpXVDR4eHcwdjlRbzBmclNaZ1ZqOCtqcFU5SmJNVnFZWjcw?=
 =?utf-8?B?SFM5VVdzVW1xUVRJejZ1Y3RFdEJtK3dvc3lpWU9BYlZMOEZJTmpyMElNNzdN?=
 =?utf-8?B?YUxPbzZkcWEyblNweU5xOHAydnpnd1hTT293ai9ONHpub3FPRlVLNkZySGo2?=
 =?utf-8?B?M2ZTeHNzQy96NW9KUUl5Z1NOUHYvbU5NOWtWUllyOWlBbjdYekN6WkFYZjdQ?=
 =?utf-8?B?OXo4SGZIcXVheTBNYmZwRGFkVjF5Z3Ftekk0MUxSc0hCRm5IZ2dFZlhpSEhy?=
 =?utf-8?B?ZjV6TmU5c2RsTlZEV0hDTWVjL1ZIVUJxRHFHNk1IdUpQTE1GRS9HTnBaeUxz?=
 =?utf-8?B?L25nckQ1RzJHSEgwbXMxam9SVGlNVHJCU1lPenFZVGppdUxEK1Mvak43bDNI?=
 =?utf-8?B?N2xYc3pQU2hyVTY1Z3V5U3dMRk5mY2UrOVFMalg0bHp1RzY0RXZIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ee43b9-809b-4231-66f8-08dee8d80ac0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:32:52.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OW4SqPTr+8ePC9JDbzj/Q9ZfiNi+5t852sPEZEORMxluLcJo/vrZScrbI6rLRFDVz3q5x6nflyWcJRMh4AuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187



On 7/23/26 11:23, Vasant Hegde wrote:
> Mario,
> 
> 
> On 7/23/2026 9:41 PM, Mario Limonciello wrote:
>>
>>
>> On 7/23/26 10:59, Bjorn Helgaas wrote:
>>> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>>>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>>>> using PASID check. It worked fine as most GPU's has PASID feature. But
>>>> this means, identity mode enforcement is done for all PASID capable devices.
>>>
>>> I think it would be useful to know something about *why* these devices
>>> require identity mode.  And what happens without identity mode, i.e., is
>>> there a user-visible symptom that happens when the wrong mode is used?
>>>
>>> Since the code doesn't test any feature bits, I assume it's because these
>>> devices have some hardware defect?
>>>
>>> s/GPU's/GPUs/ (twice)
>>> s/Currently its/Currently it's/
>>> s/has PASID/have PASID/
>>>
>>>> Previously it made sense as domain allocation API
>>>> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
>>>> check device capability and decide best suited page table type (v1 or
>>>> v2). With recent enhancement to driver code, it uses
>>>> domain_alloc_paging_flags() ops for all paging mode domain allocation.
>>>> This can check device/flags and allocate best suited page table (v1 or v2).
>>>> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
>>>> GPUs only.
>>>>
>>>> With this change system booted with DMA translation mode will select:
>>>>    * Guest (v2) page table for PASID capable device
>>>>    * Host (v1) page table for non-PASID capable device
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
>>>> ---
>>>>    drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>>>>    1 file changed, 45 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>>> index 563f9c2672d5..fe642e33c87d 100644
>>>> --- a/drivers/iommu/amd/iommu.c
>>>> +++ b/drivers/iommu/amd/iommu.c
>>>> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device
>>>> *dev)
>>>>        return dev_data->defer_attach;
>>>>    }
>>>>    +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>>>> +{
>>>> +    struct pci_dev *root_port;
>>>> +    int class = pdev->class >> 8;
>>>> +
>>>> +    /* AMD GPU vendor ID */
>>>> +    if (pdev->vendor != PCI_VENDOR_ID_ATI)
>>>> +        return false;
>>>> +
>>>> +    /* GPU class */
>>>> +    if (class != PCI_CLASS_DISPLAY_VGA &&
>>>> +        class != PCI_CLASS_DISPLAY_OTHER)
>>>> +        return false;
>>>> +
>>>> +    root_port = pcie_find_root_port(pdev);
>>>> +    if (!root_port)
>>>> +        return false;
>>>> +
>>>> +    /* If bridge vendor is not ATI then its APU and force IDENTITY mode */
>>>
>>> s/its/it's/  "it's" == "it is"; "its" shows ownership
>>>
>>>> +    if (root_port->vendor != PCI_VENDOR_ID_ATI)
>>>> +        return true;
>>
>> This logic I believe is wrong.  You're trying to look at the parent of the
>> display device (which is an internal PCIe switch for a dGPU).
> 
> You are right. It got inverted while I was fine tuning the code.
> 
>>
>> You basically want a similar implementation to amdgpu_device_find_parent() which
>> figures out first device outside of the dGPU.
> 
> Ack.
> 
>>
>>>> +
>>>> +    /* Rest all are dGPUs and works fine with DMA mode */
>>>> +    return false;
>>
>> Mostly for code flow, I think it would make sense the force_identity_mapping
>> fallback is purely for APU.
>>
>> IE something like this:
>>
>> if (vendor != PCI_VENDOR_ATI)
>>      return false;
>> if (class != display)
>>      return false;
>> if (pci_upstream_bridge()->vendor == PCI_VENDOR_ATI)
>>      return false;
>>
>> /* rest are APUs, force identity */
>> return true;
> 
> Makes sense. And pci_upstream_bridge() return NULL, then return true? (something
> like below) ?

Bascially; yeah.  But one comment below.

> 
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
> +       struct pci_dev *root_port;
> +       int class = pdev->class >> 8;
> +
> +       /* AMD GPU vendor ID */
> +       if (pdev->vendor != PCI_VENDOR_ID_ATI)
> +               return false;
> +
> +       /* GPU class */
> +       if (class != PCI_CLASS_DISPLAY_VGA &&
> +           class != PCI_CLASS_DISPLAY_OTHER)
> +               return false;
> +
> +       if (pci_upstream_bridge(pdev) &&

I don't think you need to check for pci_upstream_bridge() to be 
non-NULL.  You already checked that it's an endpoint by looking at the 
class.  So an endpoint will be connected to a bridge of some sort 
(either a switch internal to the dGPU or to a root port).

> +           pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
> +               return false;
> +

Make sure you leave a comment here about what true means (/* it is the 
GPU in an APU */) so that if we need to add more cases later it's 
obvious without having to dig up this thread again.

> +       return true;
> +}
> +
> 
> -Vasant
> 

