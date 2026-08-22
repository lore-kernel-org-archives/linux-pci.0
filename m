Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7935E93B;
	Sat, 22 Aug 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407112; cv=fail; b=hzcUXxKkNCKd1a2XUk75lsC9wPeVUMvr+8WSafSn+p1iife18x5Ac+nOkHvPPGw7FANLlxTaNHnUJazz1ILnxKlNX3SWcrzYhl4TjROQTw49nogMbEdzsStDrRuYTwEYat7A9ozRirRqn5sG7ShDixewc43y5YQU64jw1y8ku0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407112; c=relaxed/simple;
	bh=+Uf+dQg6+43RURSB6DJdZg7PTjFnaWIvpnQ8Z1J1Dbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVl/o16Hr8IzJ0ekOb5UCGIGoMUj9wprcG4iCtsN/qHYvLFeWL77FIapAxdbJL8Z8SWt0sn+dfw5V+ksHi7Ehm557GYWIx8Ft+0R6fuza0en8UZw2UYHpiNhYK+r2KQy0fDNIulX3uohS7XTlwMHokRS8OI4P2kwzh8kLxTsb28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jjLwd8Jl; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jjLwd8Jl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBpR1Ip4e7GG3uqMs9eZcUJ+1hbV24ZTolu2OVMjG5kQEoyAPwtaSuSie9qfQjYTvsSoe/knpmDci/qya56huUjZNE6KtBcaCFdlH+OHzLucTgC7OozKG//heZoG3VhZPKzUrII2TSQxtIVAIkXsMTHY4CK3wabv5CCoN0S05w1m/++L685+sYIoZP0m4YMURCAx5/YVHcaCbZDYN4MQpb5+4Qntw5E1hep0wR5nmpZiVZbox8fRqbecaviKvvhsWRx1hT73+9HO5CMktgk9uMgAe6JmNKbwwj0rYuSrI9qk2EfeKVbovFZcCjROd85oSp8sSn+MVVmj4gpBcqu2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GANrwLC3326ksKBXMd/dKnRnY+8IUoY3X5bFbvImGQY=;
 b=Oj7GwY1D5JQ2fbP+qaDpfbZAldL21HUfxQWc4hrwLYcEZI0TsDRi/cjg28W6opR0i7HnMmWPEE1t061DOw/ZbehD3A4x5vBKuqzkaqaFlN3gE6YBoJd6BD72ByNL8YfVPsHywKRrNXpeRWixxVntWpEOfpx7GGzOnbo+vkR/fih3u04DUqn/+ESHNk0NwxJai5J95UUIT2fW9aW+vjzHdR93D4fQG/6sWRkOMPceWUmf7PHZkFA2KElN6ti3GhUPLNZd8QvpaaV8dbcs2kMvT7Lg6ayFJTc90ASdDU4BS5qlOul/TRxdoFZxjor+9HAvEUrlTQ+/Glnx2/WOSto06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GANrwLC3326ksKBXMd/dKnRnY+8IUoY3X5bFbvImGQY=;
 b=jjLwd8JlvtU+w2J3V1gCY2QNryKPfQs7RhZqPHPbMP5+Mb8MIwzILka2lIs3jVx8VaGkHFe3oZ1w2aTF/yyQCqC7GKS8EU8aF8SAOXRZS6w3LyGbSveZolDL1+V0qmb2vmXnQ9YjrzO010e6234fzXDA6XDBdv2PxAUrEYVgins=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 13:58:28 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 13:58:28 +0000
Message-ID: <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com>
Date: Sat, 22 Aug 2026 19:28:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-3-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d51969e-6b5c-488f-629e-08df0055710d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MnKjdfKRTXTtuJS1kRbsnL+ylXpcF9wFMYHwc6XvdgfvOVfD0MbFtlXSfmi4Zot6Gx8154zXYK0EgIqp3N+43VuThYc191FT3Sgo9tZJ5dvDA/hcgPQTXMBOB9gE2u6cJrq6R6v7VvjOvGLCM60WnpdIc+qxuFMrdzuVsHY3qrSx73+rqAvfxpWkz4eYViZct+N0n9RndDqm65C+3PCbRo+DPEnCvsFsow0D5GHPBuj7gyfLhraz3S/dmVYvoiDhbKljECAuL6s6MLduFyL4hrd/ngIHJceW4qQQtfdDjFQDy5cOWC2qkGKCPwfXaJnXFrSrWfze8OA+HD0B48gx6/kcP3NpKT1/8rILNfu/MyqYYzgzuNcGY9QanyZM9tzhcnVv+L5LPsdk/RfqqJTWCtITcriTeAmslDtsr6cbFvfRVpkUDWX2kqyn+c0hWWrJFfcs4hB+Q5U6es3F9I8rjfjs7Z6SvxhsQpL1+ad2zprSjjrXDAGEFhJGWU+997ysgTAAb99lagyoM08w9cUtIC1qXeNe6cAxOagO/j0EfF46oYWSsf33OVea3P19Yw42glrxXqAZ3LcQ0IIkGxrLEDG4zhnZGYwCW4wCPgpYvZrhe0YwqCXzM/7FYqE0ha4FfmLWLapcWmeFzH7Yq3ZBfOT225Eplj6tzn66ETd0gHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnQyanpIUUJ6U3Z4WCtuVnV1Ri9JdFMzK25rVW4rQS83Y1p5a1BGb2xQZVBn?=
 =?utf-8?B?MGZ1WkNHODZnMG1UUE9IaEduck9pMkc3T2JwL2I1aGZEdUdrR2o5WDQ5VXFB?=
 =?utf-8?B?cWlXRmRYOVhnUVlLTEpHTHdFNjdSMVMzdkNsRXdEUGlicjQxTU1YdlNLUzMz?=
 =?utf-8?B?VjZvOXZ1VG9CTlBkM1dpMGJCL2NaUWhBZ2R6LzVaY0Z1QjE3SFZobHN0S3p2?=
 =?utf-8?B?dEZNMDQ2NVEyRitJbTMzdVJEZC9mdnFDZ2lWYXNoemg5QnozZ2Qyam44M00y?=
 =?utf-8?B?MjVJVHlZbmhiS3NRVTZaRHpxcWlOK0RGa0t1OEQ2NHMwTjJ0Y29ZcUN1b3BD?=
 =?utf-8?B?U251dmhtOWE5ZUZpKzZzTVdQc1d2eVd2eEdJNnd3ai92T2lzMUxwTTEwT1Bu?=
 =?utf-8?B?bWdObGQyN2EzYmxFRnpMRk1RM0lhSUtLVml4RG1DVkd0dm5XUC93Y29Oczl2?=
 =?utf-8?B?TlFaNFAzWmV6RjZnTXh4TndaeHhOSkdIcVJpNFlSSkxVdkViZkxBMTM2RjdM?=
 =?utf-8?B?cVVnWEJEdVZHK3YwN3N2Nk9zRnZwaFdOOS9MUnNsbG9JdHA0RXdSVVRZcFhr?=
 =?utf-8?B?VlhHcHlmUk91T0ZpczVpUU1vTXo2S29mRitRQTBzdml2eUxzZG5CSXlHVXlo?=
 =?utf-8?B?cG03a2k4Ynh5Y2dpL01hSHM3am1lS3N3UzdNN3VzK2ROcGFUM2dueEVzcklu?=
 =?utf-8?B?VHpOdklKcEhvUTVId3F5QXpzWWZWZllTMURrMFZNSTJuWEdzTWFSd3dBaXRQ?=
 =?utf-8?B?aVBDaTk0b0VOQ3lKRUZKL1hBUFI5ZkkwWGVwTGltL01vUDF2UlJXVnVGc3Ra?=
 =?utf-8?B?M2wwZkI4UzUvMGJVdDQ2YjF4Tmx6ell4ZFlPYWRiZHU5TGxORDIvYjhWdW5s?=
 =?utf-8?B?K2sra2VTS3ROMmJtdXdKNnhMVUdsYnVxdzFuTUJCbUJsY213dWFmckF1SFdP?=
 =?utf-8?B?KzMwdFl0eXVoR1B3dXlFaHFlNmVwMFJyR3psakZoTjhBQUJUVXMzbEEzZWNJ?=
 =?utf-8?B?MVFtTEt5ZTBESzRmRjBLUTZnMG5jOVpJdElBZHQ4ZVY3RkVWOG9tN3oxc3g5?=
 =?utf-8?B?b0pXVjI5amUyb0ZsM1l5eG9QL2hKOGZFZHFhU3lJeEtKQSt4TWxrbDlNOGhT?=
 =?utf-8?B?WGVoai85KzFhZnFZU0p5RlE5dmgyejR0WStMRE9IcHJMZGx5ejNob3dqYXpT?=
 =?utf-8?B?dmdSWDYxTm1UK0dyOEtGUUYxeFBHbHZYZ1htbTNodjl0UjVyc3FxaHlBTjhE?=
 =?utf-8?B?NU1QdTc4VnhKamdmcnJSWW5WdGlWL01ydk9HYUEzRW1IQ3FLbEVYSWZpMHJK?=
 =?utf-8?B?WlF5L0pQb1h5SmprTEI5eWN4YVMxd0QvTzBGSXE3U1JpZjZPMW0rV0loSm9T?=
 =?utf-8?B?eW0yc052U0NUOUEyMFFQNTg3Vk9SaTdnMXlTakpFYitXR05SbnJuUzdFSndL?=
 =?utf-8?B?ajFYTlVkeFZ1Z3c3eU42dUZheDRpS2pGVmdXVHdKRExrWXFWVkNRSjZsd1dK?=
 =?utf-8?B?UmM0ekJ2WXdMM1BUdjZtWThDUXp5bWxPMjFyc0xCVU9kZ25WdXdDR0xvZUJE?=
 =?utf-8?B?RTNTVDVLWWozRWM5cXJXNXM0R054MXJ1cytJa1l3cU1MK0xBVkF4K2oyelJk?=
 =?utf-8?B?SEg0YzRhWUF6RWY2MUE5ZFpoUTVxdWs5Wkp2NHd1UnlhbmoxdmlwdFhMY0J1?=
 =?utf-8?B?dEtnQk12YXdDank0U0p4NU40S0h6a2JSd0F2U2k0eldOK1l6cll0UVR5M0Nz?=
 =?utf-8?B?ZVFlSXVmalRKYkRKSlJ5M1kyeiszakxUbFFPZ1IxNi9XMUorWG9DanlxYmdB?=
 =?utf-8?B?eWNIbFdvUjZ3aFc0LzlYV0hkd0o5TStoaDB3dzRORjQwbnJlWVQveVUyQjNh?=
 =?utf-8?B?amk2N2pvR2d6Y08zM00rajNYWmFVTE1VWHp6Z1Y4YzNlWmd3eFZsaFNBZUFD?=
 =?utf-8?B?ZFhsT3pZN0ZKQnFUZG5zaTJKUnJmVXFwS1VGYlJlNms0cmdGSGEzYVovSFV3?=
 =?utf-8?B?VUJDRUgxWW4wK2RqY015dWsvR2tzTzZMd1FrdVBzbU84VWRRWkdyVHNJVi9S?=
 =?utf-8?B?YTRVRG9jNGg2ZERNRlQ4Q3h2VW5KaS8xK09wV3FBc0VabjRpZkhvVXROdHl1?=
 =?utf-8?B?NFNEMUJkWHRlUmp2MlprRFpyZWl0NlE3T0NTOTVZVEVUdHF6OHBuZkdrWTJU?=
 =?utf-8?B?aklBeUpkOVp5SGRVRUR5RWZIMlJQL2hNcEUzTzBkaXg5cE95aWpoTmdyUmN6?=
 =?utf-8?B?cXZWbWJxY0N4emwveFhHWUJwZk5lN0VYRjYzcDBIVVQ0M2lRaVp5TjJ4WlBq?=
 =?utf-8?B?MWx3VDNWWDQ3R2VUSTgwS1FTZzhnbFdEMmFEemZ6dU9oNWdSbVhpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d51969e-6b5c-488f-629e-08df0055710d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 13:58:27.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyohay75CtA9x90O6viwChq3SGGOqirlowga2NZJGH3vLfL0W8nz+2UTqpzAlbm4mOOXMfyxtzG9V7kFnUnTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> The iommu_ignore_device() function currently uses memset() to manually
> clear the primary Device Table Entry (DTE), which risks torn writes as
> the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
> the primary devid in the lookup table before calling setup_aliases()
> causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
> the DTEs for DMA aliases.
> 
> Fix this by replacing the manual memset with a dedicated helper that
> invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
> first, followed by the upper 128 bits. The cleared state is then
> explicitly cloned to all aliases before the lookup tables are nullified.
> 
> Rename the function to iommu_disable_device_dma() more accurately
> reflects its intent, as we still support IRQ remapping for these devices)
> 
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 9b8ad131ba79..911a95527d74 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -728,22 +728,6 @@ static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
>  	return dev_data;
>  }
>  
> -static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
> -{
> -	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> -	int devid, sbdf;
> -
> -	sbdf = get_device_sbdf_id(dev);
> -	if (sbdf < 0)
> -		return;
> -
> -	devid = PCI_SBDF_TO_DEVID(sbdf);
> -	pci_seg->rlookup_table[devid] = NULL;
> -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> -
> -	setup_aliases(iommu, dev);
> -}
>  
>  
>  /****************************************************************************
> @@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
>  		clear_dte_entry(iommu, dev_data);
>  }
>  
> +/*
> + * Invalidate a DTE by clearing the Valid bit first.
> + * Note: Not to be used on a fully probed device with
> + * live dev_data.
> + */
> +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> +{
> +	struct dev_table_entry new = {};
> +
> +	write_dte_lower128(ptr, &new);
> +	write_dte_upper128(ptr, &new);
> +}
> +
> +static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)

This will disable interrupt remapping support as well. May be we should rename
this function.

Otherwise patch looks good.

-Vasant

