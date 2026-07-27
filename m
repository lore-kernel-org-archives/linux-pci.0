Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429D3BCD3A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125967; cv=fail; b=rLAaU3DyKpx07lynoXHpSJPGQvo2oyj7T2XiY1coYdX7xctEw7OAUOtcmIR4awroMqPcmJj3oYQG0XfN1GrsOBMkxMkEPhVzhpWuSEid4EAto0NmnwlYPcHbmoXppzo07ZhibTAjQb/8cAj6zZOAE5z1ZaNpivEtZbQsvUszhiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125967; c=relaxed/simple;
	bh=v1N9xMjbpv2IqVHoEq4Vyo2nUZzt3cFw9YZwicIr7Cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkMvmyezp3nZP90iz30kdL/66UH1HbLvkmbMMR6cVcusedWeXPCIYsgTOEpW2slvSI52l31mzkK76SOqfSiO+Ggz4bNhwnazqaAdYh2RlpkuRvxBnmQJvvO728dhN9qiZ+wRmLYgjppATXMTIAqdQEUuNok8XTDT/NpeiVg3vHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1GWN5xis; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GWN5xis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSqx4hQBeRZ16vYoCkCgqnGHLL8/ywlI0WwAbMsZ+YDO8HoHd2lG6Z3Yb0/CmE6QZResRC1PUdAsmk0x+cgvtwHF4eRu5X7fFViQu6+cBNYe66iaIa4S4+uMGfKHq2QzMXWpfAdoxBitvGovx2BErQwZmcnR0nrM+zvGuUk8Pcm7LEOtkdE1xDh0aL4mHaiXpoHYkQv+GWPoEFitw86n7oLBWSfEtZY6DdYc0rQAcfZoEs7QjjPgPQydjtAzo2Zh6Hqh2FzhCFpGqNX6ENHgw2WZvMEGNmQPJZwR4Qmxtjk0low4X4Xhok5+RrfnJnwjV/nrlX18SY52dfZleL0xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYC5fO9NdAuHNGlM1GkFRasElto80UqJLTVf/OLsxBc=;
 b=AANHu7Wa4oPtxEFYY5YY4czzh0cnrji58Z559V4uU0Gw+TvsoYABNOqOaeWNuG3K43dCGdflD7skIq8WujZ89+1GiCqrZehMgMHrV50kcQCM9jFLU3wHsh8BmPTM1aF/4UV2kGlLSWWctRVlv/H0R45J+vJcmNhdj8wr3uom+75LfnqeVtNGc8jJETj3E/nPfPXHekN/IyzZABdNoEopNRlqiI3DYFPw3esMz/VTWKrrznblnF9r7iwk+xgk4BzDfEvWHsLwlKspf+h5LyvtJzWmJ5ExGk+49CiJ2Z4MSvrtdYpIq7S6Wn/4yRhgwjjTDaiDOcOV4KxCNeh4dipCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYC5fO9NdAuHNGlM1GkFRasElto80UqJLTVf/OLsxBc=;
 b=1GWN5xisOuRonrWHiCPyFCmOezFvST+4VGdNvfx8VHhXcbE9cOYu6TzlObw+f/v/vj5h3510+w8ugkhpEkuZHHoyYAesb3W/5DL7fr0OYc6Qhvjy7fu0ae7MGNDo8sHYokyFMdaFfOFJ5R85Bwms8fsnkmXJ+XuXrMGlmZykMdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 04:19:21 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Mon, 27 Jul 2026
 04:19:21 +0000
Message-ID: <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
Date: Mon, 27 Jul 2026 09:49:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, mario.limonciello@amd.com,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <amOBkJ4BaZ4qnkpc@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0223.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::10) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ddea1-308a-4b27-3176-08deeb963bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JSJNjyR+6u2+l6tTZH4DVBvLWL98DCeMC++sSrUNMv1Qn4+kt/eIMWtk35kWC9vj+/UJ3DKHZ0MUnJxsjm9bNLNr+MMJbMmnis3TdWGTstycMUcJvwMVcPJ3BR5hHUvchhVxC+Bj+UIARSigv891MTtFKOLtH/HqvYf84SYNw+QGAal7sV4BAXp2NL8Hl/Gj8VJcEvZFezDaN9s4Td6YYvi756RWETCltZpz5/mbmjm8ZWGDiVORCnF9IHdAXMQz+Ww1pLYgUfX+AGJLNY+vhFA9nd9V4jOaGtqmPFiXFJ0pHkFIbKRQX3scZLkDEkK58RpFC1xbR9bolvDhVVCN/h0vO62pNuVUivgqhcrfORJqp9yv0aPAKWgZ7lYsR9A3UUpQYadmnMbzHqOdDOyE22PP/tzHg7Mj1rwqjTXbajq4ILDX3NgDRT1y9cwEclpa2nVVUTeOpdy5EFsi/PSB5hVGxZTzu6FCRYGOepsVllDju7LlzFMzRrj/HJAUk+7nu8V3SXvLpOt3uTGznsR2C/+f0x3OFGV9+ZKwLg+3oQhLoHZeCZtMr4KQft2V8C1Zv5qkhzAQBxuepnXfArqkRmTg/yNg+060udQK+xO4HmsT5E804i9K+bw1OaKVWCyIR+2JLYWEBojhFCqCIE2gbHwFI+EvSDEzgWPc2WGsGlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFA1cFY0UUVuMHlONkRCNDRJaXo1c3RFSWdUUUY3OEcwZVJqYjJ4dHRyUTRT?=
 =?utf-8?B?Z3pBRXhWNTQ2b3kyUWdMT2RtM0EvSEVrMDEyM3M5SjU3eDh3ajNMYjM5c0Zk?=
 =?utf-8?B?N0VjNVN5Tm82V1RkZEJWdUNwV3l5ay9oRzVQOGlhQ2VDc0crcWVTbG4rSERx?=
 =?utf-8?B?OHRIWDN0N0FiaDN6dmxlMTVUMXZQRXJSQ1NvOVV5ajFoMUYzU1JvcytNZXFn?=
 =?utf-8?B?UGkva0VTN05Ec0lxY05ZSERNeC9CT1IwZldDWUJXNE9mRlVaZklJWUlDQzZ3?=
 =?utf-8?B?MHhhTEo5NWRzNk5yS0xOSElONFNlWDlNRjNXUStQdTY4a1ZoRFlYL1hLQ1I5?=
 =?utf-8?B?Tm1XU0h1NzdOOWVRY3dLVE8ydURTZ1orNDhOWlllUnJxcHJWOXdoK3l2aVBq?=
 =?utf-8?B?a2VuMHoyUC9xd2hqN3dKRWVkelNJc3g5WmM2ZCtrbkV3VG9tZnNoYWxwMnV2?=
 =?utf-8?B?cE9nK1ZJNnUyUk9wYTloeGdqMFVmRVdtV21xTE1JSXFTQVpmRGFIUXZlYkl2?=
 =?utf-8?B?NTFvK2VhWHorZTdybG1pRG1NNHIzSXBDQ0JrMk9pQ3NNMFk4cmFVRzFGYlFx?=
 =?utf-8?B?Rkppb2x5dHROeERzNzZWelJreVJIb2VMZ0ZvMWJPUUh0RS9vcWtpOTdRbGdz?=
 =?utf-8?B?cUM4M3NEVGhvT0dlUzhDQnBlb1JhQkxXdjdnQUxhSjBaSFhvVW9TWmozVG5D?=
 =?utf-8?B?N2VDZjRFSkpvNzVxc0tlWnhXZC9EakU3blV1VGt1MGFHNkgxWVZPMERMVTdZ?=
 =?utf-8?B?cldkYmhrS0VIME1FQmdMWDUyQWlsMisrS3NWVWxiU3ZqUGViU2loZkozSC8w?=
 =?utf-8?B?TGRzNEFmUklhRmNKdU1NL2NERXpvb2dhVGdYV0plOG1XdzNwVjc0U3NCWmFp?=
 =?utf-8?B?MDZOa05BdmFERTBCUU52RzZaem5RV0RJb1BUMUxKeVpjdFdQZEJseGZYOVJq?=
 =?utf-8?B?c0xVSTJTbFczRGxxQ0NKdnpkaFExdVZiaVQrUjV5VDhEWnBzeDlPSW1mc1VW?=
 =?utf-8?B?eGx5ak81UzU0R3oyZ3ZrOHBlcGNpMndXbkVSMm8wODgxclM5eGt4M003Szd3?=
 =?utf-8?B?cGNMRDFnZVZJY3IxTWh5N1lSMVpmeEhOQ0FjVkxGU3cyV2sweDh4U0xxbXRi?=
 =?utf-8?B?Tm1SamUrMWlTcE0xNkxwbjczMUw5UGJzYyttRUZMNWVQNE9SL3pyVklIRUtN?=
 =?utf-8?B?NUZkRTN1UVR3bnVyU25PdnVwUUdxMWU2aGUvbytQWTJtLzM0NnpOaTRYVk1z?=
 =?utf-8?B?ak51RTdlOVpqd1BJc29ZNXd1eXRYa3o2NmYwVXh6c1JlY3BrWG1tdEw0ZHJP?=
 =?utf-8?B?MktiL3FSYktwRjZpSTNGQWk3UWdocVkrQzJyZys5YlN5bzFGMExqR0ZPbGhw?=
 =?utf-8?B?OWpYZ3FscG5JeHFKZitqNzQxdFdJUWxEaldzS2ptdklmMExRTG5nd05Ca0kx?=
 =?utf-8?B?RS9nYm9ZUWMxMXluNDlCNDE5dTU0TzR0WFdIZXlvTzNJNWlRMy9sNjRoS2Uz?=
 =?utf-8?B?YmNYL3pFOWZ0bktRYTRPVlFrVkt4a1R4L01Qd3c1aGhjODUwNXpFeTlKR040?=
 =?utf-8?B?YnVrekQvb1ZIbTVsVDhES20vNDAzT0JqRlgxS3MvOHRsWW9mMzQ5U2R4djcy?=
 =?utf-8?B?VmxVeDBoZ29mM1piZlJqYThWRDJYdTZWN2VFdkkwaWp6T3duZzc4RG40Rjlw?=
 =?utf-8?B?QmZYbURCUndLWTU0VnpSL0g4d2xRdnVmRVFYcnpmNVBWOG5GOWVrQkF2S1Jo?=
 =?utf-8?B?Q3hrdU9aWFBHU0hhc3FtcTFnbmI4QXR5T29aUWxSSWdKZkJzTGlVNDJmLzl0?=
 =?utf-8?B?SHJWUTFGTENHMjNjYTNyRkNtQm1HSTJJenU5WHkrM3kyNGExeUYrbVF1d0NB?=
 =?utf-8?B?ckp5ZS9iVk9QTE5ET3NYb2c0MGtqZmYyWndWTGhRNzFyU1ZGRnJqVktoSU9t?=
 =?utf-8?B?ZVVzNzlKejhIZWVxMGJ2YnV3dDU2WVcyRFdFaVlNYmFtWFdWVlI3K0p2QTFs?=
 =?utf-8?B?dzFpNTdNRFljd1ROdytjZlFoRE1MeG56R1VxczVaTXZsZm9lSzFXMFdWNWtM?=
 =?utf-8?B?aWtSVEs0MUhMUkp0Q21wbTJ1SFMvREZmM3JrSHJwMFhKbWUxdlQwWTBmMVov?=
 =?utf-8?B?SWpRckFlaUxUZkFEdHRVZVB0elFSaUVPOUNrUURBVXFXT2xlcCtmMFd0TGhS?=
 =?utf-8?B?aXBPMGJkUjFQRkFyekt5U0NVcUdqUkVXY0syd3ZWM2hJYTZBamV6c1F4NEt5?=
 =?utf-8?B?c28rOWNGTVMzZHgydTIwZlJtcWllZUJ5Qy9YUnB0bVAvVkJycGZCRkR1NFdy?=
 =?utf-8?B?TG94aFRnL1R3MW1XZGx4dTNhZGFFMGM0elNKYnprSk90RXROeHR6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ddea1-308a-4b27-3176-08deeb963bcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:19:21.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okcngpvip7Kp84nGUybauqIOHPGLfQla/mes8RwEaG6LYTwTkPuG9DG+M+TK4QoTdIIqk0SGJRd7+YCDaAVi3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442



On 7/24/2026 8:45 PM, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
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
> The core code does this, it shouldn't be in a driver?

Right. I didn't realized core has this check. I will drop this check in next
version.

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
> 
> I think this can probably be dropped now? There is no intersection of
> this old broken embedded GPU and a CPU that supports CC right?


I did consider dropping these two checks, but I was not entirely sure. So I kept
as is for now. Once these series settles and I can go with next step of dropping
these two checks.

@Alex, @Mario, Any suggestions ?

-Vasant

> 
>> +
>> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
>> +		if (amd_iommu_snp_en)
>> +			return 0;
> 
> Ditto?
> 
> Jason

