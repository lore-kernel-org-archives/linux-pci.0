Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0CB48425B
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823118; cv=fail; b=erktVMExUx+F5x0YL9L4xoOKrCn1XIThxg4T4dlYNuXpB/8B0MuEAji4i4Z3sKYMmGWQ/FvIjKMIbu+k5v0JzirQlE8snzNZq1TuHxa1TUWap1IBOWOLbTey5SaiQhB5a4uaNHy1GksTXm+PPRVeo3/JP7p5oq01Il2+53Gqd08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823118; c=relaxed/simple;
	bh=SnbDuuI4wu8jm2PvQT/Q5Eg6fArWkXvyk8vtiSRv0sI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2qiy0e4KtmfYHZixwCfHz6aHuKoX3lprh54S0kWMEAVx5gFSaAXoFKqrBcqZ5+wJrFReKWp4d2Rm1nKBRo6Yo1u75c02OtyVJeta2nm5WU2FhxpsaofEqGUEmQ2GwU/9r/F30oJ8gmwc+N2ZhZbYbfuMhvS3Inqf7vtJrFEd30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsIw+TUF; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsIw+TUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSlxg6WlO3ErV55kvUemTbq3Gb5inuz3ctWy74pPItUz1BVG82yYPszbrUjhCtIW4+p3BnMfp9Qx6EuqTHQ/OVALEDdVFpo/D3hB7Qf66eUpkYaDJVfOm0leH58XpaDodDTECucqL2ukvJXzada5RgnAeV8y4XXRX2FPXuTSuWJWGBmYS+8+VugcKTNMPPU5RxxRY45m5nUugeRdhA5lDLUCJB2EonN/gNHdSkzgXWb7O6eB9LrLT4P2mlMj1ccJuuIOQPEY4CWJsS7o6qakBAMhDcOq/2vdBPCeK8Q7NEKJvPUNFkC7G3uRhJSzy5FpFi3VCJKYOPpiS25AQLnpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbiG7yYQv/0tJ6Rj+au8RrnGBiNIFUCpX1/HXHjFtlo=;
 b=Sxo+75Lp64G9a8LPrAXcGT2BoIkGlVQj6Xf1GaIQdiRqhgP9UIbmIUEM79IDUu+Dta9tU2vzLo6n1CWQ/UUq/ncB+1byYWKeT4e8bMPbYRyv+Cow95w3IAaI1r7FAOmo/lv6moVJhZ9ol6oZylv8nTsLz1Ex8qHUktBBAALRXeqcvajoBXzJw0YqqNPpc6OW+m1ZB31jiSSelIt9oOByBd1IrubJ9w9Wlr+Rs8pHSP5PtqmEXmqXEUzEGAv3TT6wljGOrv82CbItElbGprdUvJOzR0RSQmf54fNtF3o/RqjcaN9K7I0LaR7bT/MwgctcGFFqzYJP1AH6in5yMkfUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbiG7yYQv/0tJ6Rj+au8RrnGBiNIFUCpX1/HXHjFtlo=;
 b=TsIw+TUFWA6Toc/rvZLvQ3Ar4SYDwWiFcIiu99luQIhZMv4iMbrh9SM9YWsqAIaVyOAchSBsUIxD2e2TIOrwnv0rQ6h6KMEmre9Sq6sMoEaROQnp/0FILu0rXm3Gcl778Tpn6wctlM78mQMAqVxMHVZ+aedYt1rRhitxffpdWyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:11:51 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 16:11:50 +0000
Message-ID: <f2242b3c-5d2e-41cf-9136-72a90e86d17b@amd.com>
Date: Thu, 23 Jul 2026 11:11:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <20260723155912.GB836122@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723155912.GB836122@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0411.namprd03.prod.outlook.com
 (2603:10b6:610:11b::27) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 92320fd8-c45d-4236-3c59-08dee8d51ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jv9l/CJEX4+TDNfufFWUbHsaGp7OjAvL7dfLaIu196OJZy+VlDvdHM5NiFBpcGT3mLAtg3tVGQ7nvVJFQpBqPpPvLcuXTWNdutWOJpTMubS01IPbiupEKwMHi568i8YyPbOYjh5YSi/xrEdbui81VcpI3M9j5fwYxAkdhDlmMgKtZNV3u9spD6+Zy1HImTO3HZOqCQNHWswI7Ow7r+zNYL83Z6ZlyV8MWWuY4XXmfSWVaQc0jfjLblEkJUFADfImiQK/TSMNbnr0aMFvNwoFyXcS1GRLqI9wkDBnVGBuVvaGw/no4nq2lBWMvdoDdghqqrLWu3PSBPW+mE6EFyBfMVNAM5WOZv0fhhVi9y2E3E3HMxLjYCmiPosAiEA5ncbVuFbeSwUpJVR6pamka80AqkfPbzH8uhoXFWB87s2WS0h6Or2KvxFHmRnxf5G9bLkIW/tpxOngnGM2tk7IDyGQdHoriRRsoSr4iigwhR6u/EQheyfVScGk/OPPilF9hZtTTR8jc20pCpN7FDt4TJMQWXwPD2BUvrmmsOMo4swYs3fbMszuf1aKVW+Jg4zxEoegIRbgH4JhEXnC0aTCxEfIGE8eBu7zoZ48qPLFg5OzYQoZ8jcvBDu1wPrUX15ehkjn8cY4GvsTMc72fwjGC5HRehZ/qnmP/ilL6o783VXRqu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2RuOVlLVFdJUlVlMWJ6dUhRNWJobTJTZ0UxcGZLVzE1dmNVbjYxaW80U3RH?=
 =?utf-8?B?eFlQQ21uRHdlanpvbHNWVk9xUHdhVmNVc00rdVh3RndlMnMweGxqanMreDZG?=
 =?utf-8?B?RTFycHVvQ3Z0S0xQMzBhQnhzdWNPZFNEK0RJaTBFbHdyUjBlWkJkMEhPRHQx?=
 =?utf-8?B?WnoxbGhXWnZ5U0R0SW1rZ0JjcVN4aXVHMmxaZHBoeSttWnFPaVBUQ0FnektJ?=
 =?utf-8?B?TXBVWCtxdnFCR2FrQjJmZW5kWTUvY3poNVlJQzJsWDF4Rk9XenlQeHdtaEF2?=
 =?utf-8?B?L3Q5cXVKYlNPTVZvUnFGdW5jMEhxZkVJQ29DVGF3Y0RYeHYrOFJxVWJNNFRU?=
 =?utf-8?B?UzRHWUxXazRFR2R0SjkwcXlOZ3lQT2xxN0JEYThQVzBiZkpyV1FjcHFrY3dn?=
 =?utf-8?B?M20rbGtjbjZVbkh1eFJxU00xK1RJd08wV3dYN0JwcTQrbUNUa3FNa0V6b0Js?=
 =?utf-8?B?ZnJjU1ZnZVl2TkVUVVhuaHJLQXE3eUlUWm1zOTZLMVFIME9ocE8wZEZEWmhS?=
 =?utf-8?B?blByVTliUFpjcVl2aFZLbUlMNXFFdDVuVVBma2ZHUjdjWVQvUHg2TDhXNTl4?=
 =?utf-8?B?cXNJaTdxclMyT1huNjlNWExodTQveG5uOFpvTm0vOHMxVmJZVzg1Uk9JM0Ur?=
 =?utf-8?B?YnFJaXc5SVo3L1hiK2J4by9IZk1TSVFESU1HWUs0MzZVWUpnaVYvbkM1Tk94?=
 =?utf-8?B?NktDMUlhaHlaS1FSYzJUYy9mcElZUURlczNMcEhiTm94R0pPdWs2eUs5RGhQ?=
 =?utf-8?B?ZW9UUmg0VFZhMVNqSzQ4RjNXWGQ1UzBUNUh1dVlBdld1VmhVR1F4dFA4Y2J6?=
 =?utf-8?B?NW5uN0FQcEgvSjdxcXJuQTVNSVFTYlhxZUE2SE9WZ281YXczN0lKRmVZaEVm?=
 =?utf-8?B?aTBkOVZSbm52MHN0TUhBaGpIcERzc3BvdkpHR0xiYncrSGhIQi9maDVJK1Zq?=
 =?utf-8?B?V2JYYzIvTkVXYXUvaXZSOHQ4U3ZtaWUzam5TNGpPNktPMHFHd2QxUFpMS2tU?=
 =?utf-8?B?TmdrdDJjcGJ3SzVwaGt2YjhtcGsrQVIrcEFWdDl5akZ5YW5tWTFGS1o0anVJ?=
 =?utf-8?B?UXJTMHpvbGVCUTYyOXJnaHNoaVhyWW9RWUlNUDRGSlRrOCtwd1B4cEFremxu?=
 =?utf-8?B?ZXZIWlJyNWtFMzl2ZHpJRit2U0xwRE9rVGUrWGRmQ29OWU1uaHhvRjRwSWJp?=
 =?utf-8?B?NUVzM3NQQUxuMVNzaTBwQytYSkpqanJtN2FEMDNZTGVzd2VBbDJuZXdCVzZa?=
 =?utf-8?B?ZVBLS0l3Tm9QaE85SSswZ1dud2RyK2YzelNZczVMSXFKelp6TmJ4OFQ3aFJS?=
 =?utf-8?B?QWx1ZTVzdVRzT2hnWllmTXIyNXJCOUl6MVN5Ri8vZUNvRHNJb0hMUDduNnN3?=
 =?utf-8?B?cXY5emNodzJyejZYa2lmVzRyR0VQalJWUWFYRFVMQjF1UDRGTVpOUFk1UFhI?=
 =?utf-8?B?YVNLTkVlaVZwS29SWVFOcVVlb1FDZkZ1U1pVdVdiMktNeEtqL2IyWEVYUVpE?=
 =?utf-8?B?Vy91VXlvNW9pckZUamg4UktLbjNWSDFEV2FWSVc3blA5ZGt2R25saVNNdHU1?=
 =?utf-8?B?TGV2SUo2MFZJRS91WUpFNEpIenl6dmI2ZVl0ZzZCQmpFWnFBWFZqc1dJOXpD?=
 =?utf-8?B?L1FPRTVjRDAzZ0w3TUtobDRWQURPMVZkQUtXT3dyV0JIcmgzK1VYYlRWR05T?=
 =?utf-8?B?SmxXY3pRNGdXV0F3Zld3a01VeCs1ODUzVHFvMTdtNTVUWTNmQnJJWkdLODZk?=
 =?utf-8?B?eWFxZFZjSlM1MjZBYStJMnFrV3dMNzZiMWxMMWxBTWE4R2h1WUZOT0F4aEM2?=
 =?utf-8?B?eHlmbGlST0pDdUdtTUlCWTZJejlVZTR4TENzTktSOUxObmROcG8wYUM5akhW?=
 =?utf-8?B?R2VSLzNQSDdmbDE0NlJrbHdyVmtQWDBEcnI1cE9adm02b29IMjY4YjBya2hC?=
 =?utf-8?B?ci95QzNGNmVTUVZwZkhOdms5WFNNMmJkd1UybU9HYm1oR2hNR1JPU3I2cVRz?=
 =?utf-8?B?K241NVU1KzBSN1dEeVZyWm8vL2l3L203UWlvdWp3U2QvQTJ5ZjU0RTZhL3pt?=
 =?utf-8?B?VUR0bkJzdTFkNEVsOEx2b1cyRUVsdTBacGpGbmRLYUh6OXNodnlkanZwVWlQ?=
 =?utf-8?B?eXp0Qis2dGdaZVJGRmZ3UFRDZzdFdU44aERnczhNWGhaUlZuYTNCN0ZESTdi?=
 =?utf-8?B?Z0ttSmdTazhTS214NTVyWm54QTQzbjUvenlLZU9MTzFZT2xWQjcxZUU2dTBa?=
 =?utf-8?B?VmFHS2xaL3FnMklpT1ZnQW1rUXUySmlWRzc4YlBEUmd0cUFDKzY3QXByckVV?=
 =?utf-8?B?c2hGNllCZFJmUGZPTjVLMk1VM3RZeVRIbWlKUTF4dFd4b1N6UUdnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92320fd8-c45d-4236-3c59-08dee8d51ab2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:11:50.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZwTYiHwpSkwbgAghH76SBsCDtkYGrZANMhqJjAj7HO2C/PRTRFtt5B6NFgcbMYC3xwPtOZT75VvyK+o3mGO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799



On 7/23/26 10:59, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>> using PASID check. It worked fine as most GPU's has PASID feature. But
>> this means, identity mode enforcement is done for all PASID capable devices.
> 
> I think it would be useful to know something about *why* these devices
> require identity mode.  And what happens without identity mode, i.e., is
> there a user-visible symptom that happens when the wrong mode is used?
> 
> Since the code doesn't test any feature bits, I assume it's because these
> devices have some hardware defect?
> 
> s/GPU's/GPUs/ (twice)
> s/Currently its/Currently it's/
> s/has PASID/have PASID/
> 
>> Previously it made sense as domain allocation API
>> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
>> check device capability and decide best suited page table type (v1 or
>> v2). With recent enhancement to driver code, it uses
>> domain_alloc_paging_flags() ops for all paging mode domain allocation.
>> This can check device/flags and allocate best suited page table (v1 or v2).
>> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
>> GPUs only.
>>
>> With this change system booted with DMA translation mode will select:
>>   * Guest (v2) page table for PASID capable device
>>   * Host (v1) page table for non-PASID capable device
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>>   1 file changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 563f9c2672d5..fe642e33c87d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>>   	return dev_data->defer_attach;
>>   }
>>   
>> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *root_port;
>> +	int class = pdev->class >> 8;
>> +
>> +	/* AMD GPU vendor ID */
>> +	if (pdev->vendor != PCI_VENDOR_ID_ATI)
>> +		return false;
>> +
>> +	/* GPU class */
>> +	if (class != PCI_CLASS_DISPLAY_VGA &&
>> +	    class != PCI_CLASS_DISPLAY_OTHER)
>> +		return false;
>> +
>> +	root_port = pcie_find_root_port(pdev);
>> +	if (!root_port)
>> +		return false;
>> +
>> +	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */
> 
> s/its/it's/  "it's" == "it is"; "its" shows ownership
> 
>> +	if (root_port->vendor != PCI_VENDOR_ID_ATI)
>> +		return true;

This logic I believe is wrong.  You're trying to look at the parent of 
the display device (which is an internal PCIe switch for a dGPU).

You basically want a similar implementation to 
amdgpu_device_find_parent() which figures out first device outside of 
the dGPU.

>> +
>> +	/* Rest all are dGPUs and works fine with DMA mode */
>> +	return false;

Mostly for code flow, I think it would make sense the 
force_identity_mapping fallback is purely for APU.

IE something like this:

if (vendor != PCI_VENDOR_ATI)
	return false;
if (class != display)
	return false;
if (pci_upstream_bridge()->vendor == PCI_VENDOR_ATI)
	return false;

/* rest are APUs, force identity */
return true;

>> +}
>> +
>>   static int amd_iommu_def_domain_type(struct device *dev)
>>   {
>>   	struct iommu_dev_data *dev_data;
>> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>   	if (!dev_data)
>>   		return 0;
>>   
>> +	if (!dev_is_pci(dev))
>> +		return 0;
>> +
>>   	/* Always use DMA domain for untrusted device */
>> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>> +	if (to_pci_dev(dev)->untrusted)
>>   		return IOMMU_DOMAIN_DMA;
> 
> This seems to apply a different rule to untrusted (e.g., removable) devices
> based on the topology, not the device itself.  What if one of these devices
> is used as an eGPU and thus uses IOMMU_DOMAIN_DMA when it really needs
> IOMMU_DOMAIN_IDENTITY?

I believe the identity domain mapping is only needed for APUs, which 
can't be put into an eGPU enclosure.

> 
>> -	/*
>> -	 * Do not identity map IOMMUv2 capable devices when:
>> -	 *  - memory encryption is active, because some of those devices
>> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
>> -	 *    and require remapping.
>> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>> -	 */
>> -	if (pdev_pasid_supported(dev_data) &&
>> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>> -	    !amd_iommu_snp_en) {
>> +	/* Apply device specific quirks */
>> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
>> +
>> +		/*
>> +		 * When memory encryption is active, some of these devices
>> +		 * don't have the encryption bit in their DMA-mask and
>> +		 * require remapping.
>> +		 */
>> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +			return 0;
>> +
>> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
>> +		if (amd_iommu_snp_en)
>> +			return 0;
>> +
>>   		return IOMMU_DOMAIN_IDENTITY;
>>   	}
>>   
>> -- 
>> 2.31.1
>>

