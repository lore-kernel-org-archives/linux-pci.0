Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9334B1AD
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824419; cv=fail; b=LrySkv1FgmECq/ismfy61fNfZ/5UN8evDU2u9muvQoD8pZB2Qwq56Qb7t5jfcw7ma5xNHIf61vWMfAI+v4Y7IXtcNx81wyMDRYbpa284ZECjqNIGYhlw++/W0U93VmxcKoJUcQCZv2WubSrBMFzW84gmrPAS6ob3IHZnIvNIzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824419; c=relaxed/simple;
	bh=6lJIiRvhP0cxjBbcseb+D/qgngnISKw/Goi/izctQg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i69x29CuTHI9crZZPiIyZbf4xVEdTDqdIKWwMqRLmO7qytj1zxsXVgiTTdjgwQs58S22yP6Nl4HKMqiOIRqNdKrK5ylFFEieuwdQGJpn16A02XoTVrgdxndzYUAAnqCpMTjkcESJoZ+HBX3f9qbGcvO38dnnTDCWW7FuP+XJCPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CslkaXsC; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CslkaXsC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROwhfnk71RCJb52ejkhqgJL1ktjWvoDST3fD538aG4V++aavUwfi8o6/kSG+Pme1vO7a/QcAq4Aql9NAN7Tc/xrIl2IhU7Eku0N58a78yyEP0gsjIahoILNmSgPUt9Nh/vkt+8hylifOKFfQ4KzoBsFLhLlSF7TNKHTiyhDJ4c3NTxDDdiFHMeJAUWu316VIdq+wQhAiurop5WA7bPnnCt4JIWeaTAfHfd1v2gQJ+jGZ3yrvTxE9l9ZetYZgyRKy2C2fzTfuzsEkmppS1IfNVZJyAs6e/uCsD8IcI2rEfcRTT6TEs3Gx2EN5wsJrrRT2L/9GWTCGuawbZPjFozytvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N72kyZh7WOZhlVqBYiOtdCeuES8T3Xp7frjVo3XQrDY=;
 b=dWrFxb1yqeRl6Na8z9eEwU9CFPwyXQhhgOaUAy7CG0R0KRmkS0ifqqvJjwNzoxlARUOyY4Xg3LmLwBgeRBEothemt0wj2MQ03JqIOjysG9R9Oefu14dJgFfLNksuoxgSfYqWLVFX341iGiDle/blf2Oqy9f2fDdMoqZQ9eDK7z7+epkYXaFO/A91sHCPMWKTJFka6Tl6yXVgoBP9HzBT8EBbRhKNXdmDsqnmvXp4GF/d0y45aYZ+0Ze2l0ogpl7BtKvYUSCqbJmfOHGpwoezLY3dnfJeSoBYzcuu0jx1Up7pFCzxM7439gGx5tljec294/NkqJXZ/99FYmgYE2c8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N72kyZh7WOZhlVqBYiOtdCeuES8T3Xp7frjVo3XQrDY=;
 b=CslkaXsCTVe29gFfYnvIvXKBj9PJZCEJBqdhSzEx6HOUWpxMBqzGKMNvGg9bxfr0Smi6FjdbHvbSw3o5T5j3d5TunYryBdAc/csDODZgjV1Qr/C+rgQYt4XD7jqGSGgebWEfyBalNnPPT/S5JcCqgBtBLY5ZSF0pHwwWByfyMkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:33:32 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 16:33:32 +0000
Message-ID: <ce3c582d-de68-4cf9-b547-d5525ef9081b@amd.com>
Date: Thu, 23 Jul 2026 22:03:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, mario.limonciello@amd.com,
 jgg@ziepe.ca, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <20260723155912.GB836122@bhelgaas>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260723155912.GB836122@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: d3126cd9-0e01-4a6c-2981-08dee8d82291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cb0BrDg14VkhZRQILCn62yJOxsk4npY7ZMnNZXD7knTxoi+yhz5ILs16M0V5OKahvGkEPtJKRfahkElR7uV/cURXszakZpaelUD1YfK2rpV60NiXBxxc1f7TWxhi4qXB6GISeZsV9gapbT8PUwGVXIk4nGoNr7CHN3ls9JRup6k/GU1Rm1++8ifterIycMpSv6JbdNHhs+qD84GAFhg9ER5CWidr2Dt4J9oDURrrkyQ+Tj/daCIVuVlU8WzcjZggaD6Tz0M63d6kTUoyBoBC6UZbDy8LMfMuzQ/G+6aBij7IWpRtDaJ6bGWNgwqSbdEci/oc9t0zEpzdkboRmBo+tTwSpqRyfhtwyEBbQFlXqI66ntIKK1koVgxwtchwBC1VLu8XvRWllcUI1qg39N2DdKcUITUv1gLUxPUibMxq81O8E09XtOngL1b35shrRNtopitLU6EuIIznsMCpWqs5wVhBQORm5nXrku2mE0Sd4pluDm7VOxyC1E75pOtJSPrfvvWGC4BteUbfPi0gkawNtZxLbK5JcHgAc8eS7k8rGCPIG/Vh6435aEv/AhzItfLNFtdPmn6tQwvkKXSpYLrtgK7coGOcmaQRckar2QyCzZYrKI8C07wC/eIQnou9Z+/OdY8XGRPXzIsP2rhqxuJisAuERZKWJ5/3TRJ0NAmmu90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXc0OFlXRTFhQlhDaEluOU9hZXJGZjJ0aFRIalF1K3F0QWZLTm4yTlZJUHlP?=
 =?utf-8?B?K3U1UWw5b3k2RzhMMUo2RjNocU1VMXAyaDFOeEM1U0JObFRJMXFWdWp0R2x6?=
 =?utf-8?B?M0JhYU1UbHZYOGIyUWdKMTZZblNlL09RQWRrMFlCUHZWTGlWM3o5UUN1cHJH?=
 =?utf-8?B?Z3NpR3RtdVRoM2QweDB1SmlLNzZ1dytPV1lpamo5U2R3YXRpZlF4QkltR1R3?=
 =?utf-8?B?WlRxMHgrL2tkaUUwVWxucWZMOGo0dGRSNzQ0dk9UZWJyaDUxUFcwWE9kaVE5?=
 =?utf-8?B?VWRQNEw3ZFlWSUZJWVhoVkRieStWblo1VlhNS0VjSVVYRWIyYmd1aTlGaFVD?=
 =?utf-8?B?aUlPdWsxYkN5N3BaVDRHcE1OL1lzWWVhTkpCOTU3cStheDZSVUxDWFAyZ0hE?=
 =?utf-8?B?Rks0N2N2RElsWkpVMUpycUN4cDhVSE1zMktVUlJ5NEMvWUpDWVJsZ3RjZVEw?=
 =?utf-8?B?RVhpUERSZGc2ZUpTYXNZNzNJOHNnMWdIRGpwcFI1b05qSCtUbnU2Sk9BVlQv?=
 =?utf-8?B?TGR0QUtzYjF2OFdjQk51cXJodnhIWkd1N2h3QWhLSTZuNWFJZmRuYXVYVnBa?=
 =?utf-8?B?L2xFRjV0NjlGZnpiZE1KN205ZFVIL05pL2ZNdFRLRTRwUkZGVjlmTXdKNURh?=
 =?utf-8?B?a09KSHBjN09MM3pUTG1RMlZkL3daOHgyWnlzNFZQZmdPbitsTnNYOHZPcVVo?=
 =?utf-8?B?NThCSmhMUTNUaU91TmI0WVJoVVBsRm83d0JPR1FUejFnUFV5c3ZZTHJCdCta?=
 =?utf-8?B?TXZsMkMyS2txZUtqUWk0anozUDJBK3RDYUpHbkwwK2R0amJaUFo2bUNWWE5w?=
 =?utf-8?B?ZnBINTNJZStva09BT0lXK0RJUzd0emZEcXVPWU9qK3h3aERMWlBKRW10NFV5?=
 =?utf-8?B?dmVxSGVyanpXNUg3d2xndm5qTVp3T3Z0c3FuNEE2ak9WQTQrMFZBL29HZC9Q?=
 =?utf-8?B?c3ROYXdUSUEydnpLSndWaVVuWVdVTEU5dVQ3TEpUc1VUWUJlUTFUMFJ6YXRu?=
 =?utf-8?B?NUdSazR5cUhCaW53WHZJUUlLSHdnM0J2REpEdWlMNGZRWUJRMkJGNHlwK2ZT?=
 =?utf-8?B?VEdRU1VkV3hoeEZvVDhJclZrNEViaWovTzNGVStENlZQWURNQVAzV3dnMEs3?=
 =?utf-8?B?bytpUUJIQjdra3dFT0IzSitFZDhtVHlHUVcwS0lKN2tJZGM0VXNmeEdkeGhs?=
 =?utf-8?B?SHgzOUcweG11NWViei9ycCt1VFkwMlVrT3NvL3JwbzRYOXlTSTdJMmpQUDBS?=
 =?utf-8?B?Mi9McFdpNFB0Y1pWeXc1T3VvTmkvQXJkN2ZLcjM3Y1F2RkFCQlRCQXhOZE1x?=
 =?utf-8?B?VDJKZUVsWFlicyszS0FnV1RINzBVS3VTdmJFOWU0K0xCQmpFSlJVS2ZyYjR1?=
 =?utf-8?B?Mi9GWE1xVlpXaGJ0MG5rQ2w0TjJ4MFlyMHYzcHRkZ3JuMS9FNCtwZUlxeXdy?=
 =?utf-8?B?NzREY1JTeDlNOHJscXVVZGd6YklIMTMyeGs1MERUQWYvcjFwblF6SWRKSHpu?=
 =?utf-8?B?WjFxbHVIZ2RxN0lZaSsvOUpneFNmQXgxc0ZQRWpUWGpNNWRIQXVDMjkrSUNj?=
 =?utf-8?B?K21XWUF6MEFSeStCMHdCc3JhR3RnSjQwVDFZZHZ0YUJmUjVoN0twVmU3Zytp?=
 =?utf-8?B?RFIvSDQvdEh5VExFQkZWc3BjZFhYMElIVi9kMldzK0swRXhYNUxXOHpOajFl?=
 =?utf-8?B?OUhqTXVkRnp5eXBXS0dmS0R0NFVzMUM5S0FsV3JOd2diSkh1QWNwd3JlSVZu?=
 =?utf-8?B?WlNyRS9VYVg0UWQ2SGl1T2theDJkakwvZTBxbGVoWjFLbU5yVFVRbHlvSTU0?=
 =?utf-8?B?VmRnb1Y1NERHbHM4NTA5aDJVb3ZDemJsNWdBUUVlNThJNVpaNWJhZDFOVGI3?=
 =?utf-8?B?bjhXUjNUc1cyUXdsQUVpNFNPaHJLQklWV2paSzJvdERuelcwS1ZVS2ZGZVNY?=
 =?utf-8?B?a3FYN1lpSEhOOE5ydnA4NjloOHV4TnBjQ0FtMGF0R3p0bU1GV1lUd2JLaitU?=
 =?utf-8?B?WU02cU56RWRuWkt2a1hhamVQRFJMNWJWK0ZvWDVuNTNUdzR5cTR4VkFkY2Uy?=
 =?utf-8?B?ZGNQWUlES2xpMzNEd0d1Y0EzMVlBWXVpRG9rWHdsdnhHbjJlOTJQUlpYZjd2?=
 =?utf-8?B?cGdPM3lydjRhb3NzTGMvWERoTHlhY3VLeThQUHIrVFVLUElRQ3YvVWljTlFL?=
 =?utf-8?B?b1dKZ20yV2NWSFoycytjZ2FmVkZuSjhFdmhMdE40RmkzVFVoZnZyVUoxRWZC?=
 =?utf-8?B?b2ROOC9LYWU3c2JFNnlnYzVRdVhyWmVxUitGekowbGZwNVNJUnRhN2NmSTJD?=
 =?utf-8?B?ZWN1R09BZ3pMc1hQeVRML2VBLzA2YWdxZDVoNU1pWUZ5S3ErMEU2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3126cd9-0e01-4a6c-2981-08dee8d82291
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:33:32.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAeYoTvKpaz1wLVKjBlsBM1rwVr7xicjWZTZ9MoNQ27r+fnJC25TwS1EspfZC7ZIYBZsMWHMVeZLbRSSyGUWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

Bjorn,


On 7/23/2026 9:29 PM, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>> using PASID check. It worked fine as most GPU's has PASID feature. But
>> this means, identity mode enforcement is done for all PASID capable devices.
> 
> I think it would be useful to know something about *why* these devices
> require identity mode.  And what happens without identity mode, i.e., is
> there a user-visible symptom that happens when the wrong mode is used?

I will have to check with Alex for the details. Will check with him.

> 
> Since the code doesn't test any feature bits, I assume it's because these
> devices have some hardware defect?
> 
> s/GPU's/GPUs/ (twice)
> s/Currently its/Currently it's/
> s/has PASID/have PASID/

Ack. Will fix it in v2.

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
>>  * Guest (v2) page table for PASID capable device
>>  * Host (v1) page table for non-PASID capable device
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 563f9c2672d5..fe642e33c87d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>>  	return dev_data->defer_attach;
>>  }
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

Ack. Will fix it in v2.

> 
>> +	if (root_port->vendor != PCI_VENDOR_ID_ATI)
>> +		return true;
>> +
>> +	/* Rest all are dGPUs and works fine with DMA mode */
>> +	return false;
>> +}
>> +
>>  static int amd_iommu_def_domain_type(struct device *dev)
>>  {
>>  	struct iommu_dev_data *dev_data;
>> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>  	if (!dev_data)
>>  		return 0;
>>  
>> +	if (!dev_is_pci(dev))
>> +		return 0;
>> +
>>  	/* Always use DMA domain for untrusted device */
>> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>> +	if (to_pci_dev(dev)->untrusted)
>>  		return IOMMU_DOMAIN_DMA;
> 
> This seems to apply a different rule to untrusted (e.g., removable) devices
> based on the topology, not the device itself.  What if one of these devices
> is used as an eGPU and thus uses IOMMU_DOMAIN_DMA when it really needs
> IOMMU_DOMAIN_IDENTITY?

I tried to keep the existing order (untested followed by GPU check). As Mario
commented, we need identity for APU only. So this is fine.

-Vasant

