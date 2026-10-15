Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976152BE35
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069108; cv=fail; b=qKzQY4Qahyfexh2C3HxlkhjRJE3yPcXv6l+0VmG2inI00UBM227lgT+79SDg3x9+M80hnIdwSPk/frBYSTk4NVRFQGTYvPLwMEfLn0Qp+wa8iC0qBLgcIoF5Rj3eRskVBdk4AbbF8YDe39YdxF/xJOSiOomO9jKCGIY2mnmnxcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069108; c=relaxed/simple;
	bh=0aJzkz+eZkk85EWeH+OIOs1NcymvWa8lSp5zfbhVWlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XIuG0aeB/y2YnKBwLApfpp+HMUWclmesgRuyaS2TxCXjHGEIUtBD7AIXzoxrTn/3S2Za57uE6EAExMqgIBJwZIkoqQYEEFiKeWm/BDhQ4+ZXF5BMAUoNljsyxlKMo8D92Eu0My0fqKU6bntB4oSnCYsxG+6JD0caVnLeigaRZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+bCCGVU; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+bCCGVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzHvSqEFPVUfyt6F31d+K9a0EeK9Mmv1YKmA86dfeDT0J34dd2VvqdmCpZpkSWRA7pNwYoOuNjd7BNKdW8r/A7Pb5XYs6/ZY3bBYwP0YgaMXRqsyMGjj6eb43i42ZZkpxWL4jRte7xoU+O0rBWkrhoKEb+W1t68xsTcGQuCOfxso/LUzA14W81eQ0POp8uXuxsdUxsBpx+x7J/8E3FPfMG3Ji6BgDDbaahdlyWrBF7gotJbvS1FBQSMbPJwPB8gTyIfI6uAtqG+pw/7UKtO41UtztnrzbiRHJjm7FELFeuHYyHuLK2rFpX2/uN13qv7ROM7l+rCG2iupTFdGLHoH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sz3dj6xRBOUHgP8uahuVXXtY7dv8E6sLC7ZphZgEcM=;
 b=nYJV7m1R1TYZbXWArkI6Djdo04+66KkwiNaUz919T9EfMqMo/vrYJM2iC3bRxzxC5adKtJaZnV3VY11HhmtITLH29KA7VDPMombxkJNua+z5+bLBhpN3+Bc9RcviTtcyWa08eTYYV7SwG8ZytnZRpjmNA8bLY55j1Uj9N02BMXKznl4za5HMcj/3mkI6zzcWMheO2syiVdMSTkP8+SrvRIwk0eG7O41B0rcOnU5go0qsCLmsgZHfLutqqg6Pmjy1mMzVVbbLRHg23IE9M+I7YhCuQxZiIvUcetRjIpdaIaZ1ih8ap3GRx7bYt3lC+sGf0VKc19r0ZReIShJxIIwoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sz3dj6xRBOUHgP8uahuVXXtY7dv8E6sLC7ZphZgEcM=;
 b=P+bCCGVUquBMETndqPgK6WgAFjJGAXDkETlZlGZ3gnRxMJ5lFgowpC/H5li6FGcfLVqS1TIfAKILgBVCmUCAlSAxKK2Vy0f1g00f9x4SBtmBKnWHAANMJD3h99leQBUtiXgF11ouLWJwj6ygYtBnC7sw0i9rARPYdu8GTP1rsOg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:58:22 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:58:22 +0000
Message-ID: <161936bd-943d-4092-a148-cfdaec6d83c0@amd.com>
Date: Thu, 15 Oct 2026 07:58:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20261015124843.203905-1-mario.limonciello@amd.com>
 <sashiko-outbox-172875@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <sashiko-outbox-172875@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:806:24::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: f65adf6e-1c5a-494c-5f73-08df2abbfe50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|260925021311599003|260925022911599003|11063799006|260925021911599003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	S1KZKHiMPgYRcLrAJUgLwM8AT3rcrgQl5+Zd3MISf3yyf3u9/QimsLphCYtvE7C/TwTuu9lvZw6Q6aGAyMdYXl1lB1afKH6rPrlyL2ug8DWZAE+9xvkgtHqnCvFAOY+ya3xqAYrl9ZmbL9OSsLAAQlY5AFGDGtswGP0D9Ibj1PTpfLncJDZfMuH8VgplM0eTlVLB9UIomDaprykPAxswzrjVZnu0u8TerdATyjHfL/7uyrbBWSshV0Mm6I2IcNHnO3266IKSxnIr6HqeqFNeStgn1BR+VRpT+LrJXwRNOi75JYF0Ee/ZMzegAfwx9iFB2IxnvXeZ+FH73akrcS49FaLuw43Yq3GvmSFE0B9P+Fg94TEfECQbB5PrEMV++gxtSsgOgJ0KBLGY+jthHPQVOHTNmyuCUjQekpyqdsD7SnYJ1uSX3RWC+m18MOV4lmBfcjYjQ8j3DZzN/VW6gcQFjMJAOvB0zMX+yRMJw4AQUrmM8f8kz/PqEACivVFhtaebL+JlKWl+r7lnGJ+9rHofL5YM1pJOdDXXwU3KNAtd2wb4jC3yb8kKHNO7i3ScXrfv7wGiwS20YczpvSneaHdD4zR/sF2O/Gw+56CdIrdEJCCFTn+a+2wkclO3vuw53rIc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(260925021311599003)(260925022911599003)(11063799006)(260925021911599003)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVkczBsOGVBVDRTbk1hSGF1TmlOa0xuVVhmc3hDeXF5ZUR1VkIxMFZEM2ll?=
 =?utf-8?B?YlFkM1hNVFdsOVhTSkNiUGZGWWsyVmJjODNFbmk2dmc3NFdMZzlQUFpWbWg2?=
 =?utf-8?B?NDdnS3d0ZkN4QUNIZDl5QlNPc0daUjBLaFhoSWdNVEUzL01naVJIMW5EdFps?=
 =?utf-8?B?RW9BUGQyWEZCQlIrMGorcGhUSWIyVUltSlFHY3V0akxBQmpHSVBrSFEzc2JK?=
 =?utf-8?B?ci9vVVpEY2tDOUNzbjhTQXk5MnlTbGdLMU5sWDg1SDU5ZXRqU2luTWpJTkdJ?=
 =?utf-8?B?WlVTKys1M3RaU3MycmlHMk1SbTBrZGxzd1BWME4yUDhQMVdCU1FGd3gzMWRR?=
 =?utf-8?B?ZWljL0U3WnRJeldVS0FMNWZpbG11cks2eCt1VndvYlUxTlBwcFVXcHErMWhl?=
 =?utf-8?B?TE9DcnZzNVBUWjR1WFNHRitEemR4S0o3RURCUGFRZDdPdG9vSnoxa2wvYTJC?=
 =?utf-8?B?dU11RUtldndwbnhERVlCcGdmemJveFpBYjVtTUhLbzlnbDA0R0FGOUVlYTB4?=
 =?utf-8?B?eE5NS1hrcDhZcHlXbmMyNGlTVkVwU2thNjY5bStiV01pUHhSNjR6RmptNGFP?=
 =?utf-8?B?THZDV2dQbjFaTitFbWtxSm9ldk9TL25iQXlGcTJQMzFYN3RoMlVwVlVoUFJM?=
 =?utf-8?B?RFFhMmpCcjdKWmVjdUtYcS8rVWpha0EzaE5nRU0zYUFRSWlXdTd3M3hsbU1k?=
 =?utf-8?B?eTNwcUxGcWVQOG0rTmRvUnFDdWEwbmdYeUF0K0tycjh5WDg4VVFpVVhIYmt5?=
 =?utf-8?B?cWVuM25QWEU5T0o4OTRrWkFiOHhCL3NGRU9rWFdwM21HYk42T3hpK0QycjFa?=
 =?utf-8?B?UHErZlJoOGZGM1F4S2ZDUlVBbldoRnFCbk1KSHJGK0REWGMzN0hHdkpjVEtz?=
 =?utf-8?B?bGxLRUJ2WkpUb0UvZW1HYmVISjlhbVJLWUMvWkJLNHB5MHdkYlM1TmRjZDFl?=
 =?utf-8?B?WWNCV2NPYmhVN0t0M0NqaGh6aExjNVRLMGdoY1c1SXg2MVBCbUdjdmpYcXBi?=
 =?utf-8?B?Skg0Nk0wUlE2YmZManRObTdsNG9MMFJCUTZETkVyWVdWUzRSRWJyVnJxWXFK?=
 =?utf-8?B?bWtEbkM4eE50U29VK2pVdU95WnlDY20ydmNJSlphVjJlNnpXelBkN2tyZW1r?=
 =?utf-8?B?dXU2eWl4SDY4QU9aODRmdHU4dUl5Y2VMV3A1SXpJQ2d6TzlQb3N3SXpxTVRE?=
 =?utf-8?B?bjZRN2t6YmRUVUV3cHRmOGJndXp1MmVWWDNYUGdUU2FuWXdzTStLamJ4U3pq?=
 =?utf-8?B?WUF4dmQwckluNTZnMmEwNllVbjRGcWF3L1VqZi9BUWdhK2VIRDRIU3V4RFlj?=
 =?utf-8?B?WFZqU093d0NoVGNUOGs1VVRIZnpwRUNYUUl3bkNZdXNhTEkwZEQwcTRYbExv?=
 =?utf-8?B?bVNPVzgwRkdNRm5UREhoN2JtSCszWmk5WXZDS2dHVy9xYnpnNGY2VDBSWlBW?=
 =?utf-8?B?Q2FRcGhaWk9jbUJCQ2JlYzMzTXNtU0dhT0pkUXFTbGpwZmQxN1c2ZU9EM1Vh?=
 =?utf-8?B?YjNrMjdQNU1haGxhYXBWTlkwUzVRbXlLRkU1MTlSN2VwZTFhbUo1akRWbHlI?=
 =?utf-8?B?MlNOWGhWcENlRk01RTNFQ0RKdDdORVhtNjl5U1ZiaUxqOFdiUEU3aGVoSDFa?=
 =?utf-8?B?Z1VYZHIvczZ5SEllUXh4WitMVmd0SlVmTm41Sk0ydHJTMnNIalJnVFArWHZJ?=
 =?utf-8?B?MDluYXNEbUFIZjhkcXdSK2VTdUlsR3Y5SW10anM5TnlkUGNvcDlySFNaQU1F?=
 =?utf-8?B?Yk5RbjdKbTBOTngzRDlOR25QVEw0QmZWcUtyM080VjBpTmJKblJYakYzN3Fw?=
 =?utf-8?B?SENyRTVnczl4amhZR0NOQWpKOEJlUFB5SllmL1JwWW5vNzNkTkZ2a2pYYmtU?=
 =?utf-8?B?aktOdlZURlZxMW1VelRYL08vNDRIYWhCaXZCNmoyTitIcFBLTVdWTVhDdkh1?=
 =?utf-8?B?NVZiMlloQyt6ZEZmM1loZUFjYy9QckhlemNCdWo3bXZiL2xoQXBNbElnN1ln?=
 =?utf-8?B?UThURzg5TjNXank2Um5IbUtYWE5xRFI2cksycEJhdUhoUUhvK3Z0RGgzeTQz?=
 =?utf-8?B?eVVJL3NvOWQvRTVOQVMxS2t6S0lMV0tWYUlMUVZobTZZNGhnMG4xOHZtcThv?=
 =?utf-8?B?M1k0SzdWNDl4YnVuMEJUOUhtMjVNTXpuVDJJZjVsVmRGOGZtUWRHVFkxTldz?=
 =?utf-8?B?SklyOWtBMWorNnZvc09pQVl2dGF2N3Jrd0p2MzFnNnUrWi9ydE1lT1pkRk83?=
 =?utf-8?B?TDNqait4dWlJcVhWZEFsaTNFMXE2K2pDMWY1VWwrdUVhaThTVHRBQjBOeDRU?=
 =?utf-8?B?RkhjTkk5U0dvNWR2Vm5odGh3UngyUzdWL3pWU0FhV3JWYkwrMGpNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65adf6e-1c5a-494c-5f73-08df2abbfe50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:58:22.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZNoWEwC0GwCyvnLXHhdFHDuwwLlkgZv13B9NRyGbazAtbpBFHzUwsPI1ZolFpSdxPbMDd8p5pqnAO9ufyUslw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659



On 10/15/26 07:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] pci: missing EXPORT_SYMBOL for pci_realloc_enabled_by_user() breaks amdgpu
> --
> 
> commit 9eeda1e99dc9a34bbbe5670a252bc894b1208696
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> drm/amdgpu: Gate VFCT bus fallback on pci=realloc
> 
> This patch modifies the soft filter system to gate the VFCT bus fallback
> so it only runs when pci=realloc is explicitly requested by the user. It
> introduces pci_realloc_enabled_by_user() in the PCI core and uses it in
> the AMDGPU driver.
> 
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index f9315e0472fe9..9651260278c18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> [ ... ]
>> @@ -459,7 +457,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>   	if (vhdr->PCIBus == adev->pdev->bus->number)
>>   		return 0;
>>   
>> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
>> +	/* Allow bus renumbering only when the user requested pci=realloc. */
>> +	if (!pci_realloc_enabled_by_user())
>> +		return -ENODEV;
>> +
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index ed16ef7c26fa7..d9450585082c0 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1799,6 +1799,11 @@ static bool pci_realloc_enabled(enum enable_type enable)
>>   	return enable >= user_enabled;
>>   }
>>   
>> +bool pci_realloc_enabled_by_user(void)
>> +{
>> +	return pci_realloc_enable == user_enabled;
>> +}
>> +
> 
> [Severity: Low]
> Will this cause a module build failure (undefined reference) if the amdgpu
> driver is compiled as a loadable module (CONFIG_DRM_AMDGPU=m)?
> 
> Since setup-bus.c is built into the core kernel and pci_realloc_enabled_by_user()
> lacks an EXPORT_SYMBOL or EXPORT_SYMBOL_GPL macro, the linker won't be able
> to resolve this symbol during modpost for amdgpu.ko.
> 

Yeah; this is a valid issue.  If we're aligned directionally on this 
I'll fix that in a v2.
