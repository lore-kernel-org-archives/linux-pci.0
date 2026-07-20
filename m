Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFE432E77;
	Mon, 20 Jul 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560474; cv=fail; b=tXFIokRWdm32eqSP3RUQc1ThFYkFc1cZ1qDt4PyTDLTzYCUbps6MIQfrCtGZkbt95QQTlAjS24nEMGlL1Bwy0tW/2GDTGoxsXZ+neHwyu2mhjtE+RQwfA1S5FQqCKnGLhpT+s4Lgj2DKArgI8gE54xD0/Q6hdS2jgMRe1Zm+VEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560474; c=relaxed/simple;
	bh=sS5xPWRCmrjx4FAp6q4tSF6aK4Bjgm9ptKi/um0kCsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REqYZ6tpoCxV7zEn050onsE9D+kbmizYeYo3MZSOssCmHe1V+UgJGOUedw+ZZKbyyIl7MPSf4PAsJwOik1QHGC5IIWWBBNnbTRH/V5s6U2YnuFq/fW3olExBvogOV5PpYJfJTOoPKNXl//0ssMWtW1vsEpDWFXqirH3NFNgfkOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5NnKrxRY; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5NnKrxRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLG4/DcgUT2Wju2i3QMvANQCYXeehNk8MebrVE0crw1DVnuUbVyvPiXLaTBlwLcEDCU4hFtx3Mo28stXTidhFeHka4FwjEAASTZ4zwHW7aOOEABcVjr015+19wpq3K7z2Uno2iWC+OvAax3ayeJBru2WDdNh+nPWOC5dkwJbICMfCmlYs70hlrU3NYzOng4TzhijaJl8329tfhqT52cAjXDsvnxooGYmYrMCJ4ikHMojo8/1eIrMFRaCvVLaKlAiB6dwdQGU9U+BUVbmUeZVwHn+qhO8fIYOPsCck67Zp2OCljCIESXbIuUPeIfqk2VZrUl/Lo7Ga+2j+NeEZjXr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy9pzGE4pANYrSFk2EUStqoTJ2B++dAn3rBlz0ZZVwg=;
 b=ChH2JPRFlAQJAfP8Yy+lZCGwlbLWoM5qAa0QINOcehSeA1CHsCPYhc4LBu9I4Hj2pP17Wy0Hwcs6CJrUhUKB1gpk/7JGLxcyVGE0kWLrrI3n9oD04XRXk1gj2J2AfMi4NPvA3DGAA/SE5lwgN4MXcp22D9wkic52QSqrm4THzKoorLQI1iO3y32yZfHF3iP/WYKnDH+U1alTpDFjEZVirVIF6XzIfjrU8QXNhk+Mc7HpNxXWmOONV8eN64pnuEqyi12N0+z789oSEyQKY6VIRHP4DjKKFl6Wc7VCJ4cu6FkjLF1WJ/144oq7I4hc482/W6+64tavc711PbaxncDmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy9pzGE4pANYrSFk2EUStqoTJ2B++dAn3rBlz0ZZVwg=;
 b=5NnKrxRYBaE/UkPH9cCYUI9d+Fse2YrqmNTPxg/3vGuT/U5OHMRLxxG6xUASuFjFDLDzOBVh/zGPUDII3upZpk5WHj9IL65yEYz3tGb+v+XvsvWILqlJvFWvIs/aDCr0DaKqzBuJXU7T5RRrbRXp/KgfuLWgTXVxUZVrIAf/8tM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:14:29 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:14:29 +0000
Message-ID: <75709fbe-3825-45ea-9a98-884b31430eb6@amd.com>
Date: Mon, 20 Jul 2026 10:14:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL AER
 trace events
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-11-terry.bowman@amd.com>
 <20260717225316.02D321F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260717225316.02D321F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:610:77::28) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: d58d2216-be87-457c-61b4-08dee6719884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	YRQsaXKdQt2bAzbT0DXjfaM3vF6XO0tVdIv6nzM8c7gyorFJIqZQvJgwWzmjrCjqLtuwOowy6xzEfUfGOX59GoLtTw3b4CJwYBa7IWK/G8Ebt1EOw264BFwuABWcV658d6QcecNTVs0EQF9CT7HuV/fCd3Z7XxgOKH13Cq1kgDVg2VwoIQ7pxL1v9dlaYyKVGuHSwyGj5WMiedyTvTR1NBiGUyJzv9OVB9MizkO6CKtqsQgaO4Q5IrXHAJtuJtXflDE++CGtfG4KEd3XNZKmx7pdMA4w8/Zqpxlr/UD6j7EOCv0WZAtewKWutladlPU28IU5JTQ0kAeqitKUs0bGktP4qVoIien4tzcnYEapMbgsK/tX7iYJIMt9+790E+AeQMq69535s+l3Uu/mzohsvUABmFAoA2KDKlpU27yYq2EPMBlQu3mE3cLuRqn+bOs9gR1bt0aVf4BtyywgDgDKc5bGG315Oc+0gcXgcIz3X6ekFFU5zcVN4ZkZlG3VFbR8zVS633JlpK4LltcTrXFvLBk96VOQHRqUM3RAL5qoGsn69c0PIoOD7Q82YdkpONZUob8/KfE5WSD54WHy6QBTVVi8zFSMmyp6trmPw6wH+ZpltaVw9nPF0TPedtM4euQyvu8XqyrHlIWc+y3UEYo/IgqhBgTK/YN06C/DhvB72sc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWZnSkoxWnRjMnFFakh5U1pzTitJQjNZV0dCemUrM1E2VHViSjdGTXBFM29F?=
 =?utf-8?B?d1c3TlNGSHNoMU0rQk8xVExXdzhRaFhBVE5ZVGh2aDhZNHNYa1NZMjRPM0c0?=
 =?utf-8?B?YStacHBqVDVMK0tzZXJURTNmVUd5bnozaytlSzlMOFI1aGNrSDljNE9jRnJX?=
 =?utf-8?B?TTJFRDZSb0FTL1pWeHB1NHRJeVZ6alNWb1dPMjE5ZGI0SVorcjMvUTkvcmFF?=
 =?utf-8?B?YklnN3RHc1JqQThvdzZGK3FRd3lKWEN4cE1mdDYwTnMxY0RBZ0RkKzAzRGph?=
 =?utf-8?B?T0pFS1RDUkdYTDFKNVVtR3J6OFFWQmFHN1d0M1FNRU5KWndiajNQQlBndW85?=
 =?utf-8?B?V2hrTG1meERKTFBrN0cvbE85aHF1L2JzMVgwaE9GcGJHMnhYNTc1QUwxaFNo?=
 =?utf-8?B?czE2Tll1MTdmVzRUOUx0bkJqYlFZeUtwUzgxNGJnSFNVazVuQmh2SzJmWDha?=
 =?utf-8?B?eDVHbitmT1d6TFFxUEN0d2FSK2dEUkI1bHk2dmFuZUg1a3Joa2MwWHVQRTNN?=
 =?utf-8?B?d2lRSjdTQTJwYld6ckpNTnpkTTIyVk01WW9WeERic0dnSVFKN1lGaWpPT2sy?=
 =?utf-8?B?UDV1RU01WFFGVFVZenpiU25XdUtFQ0UzdGg5a1ozU05aNkRTTFVnT09FbGZT?=
 =?utf-8?B?ay8rWDMvT3dSZDRPUm50VHpORUlkbzBzd2o2T3ZDbjc3aUR3aVJPWHNTbHRZ?=
 =?utf-8?B?NUdQQ0t5bm13cm5kK0ppQ3FndmZFbkVJNjNlNzNtUDNFYWlDTWxEbWN0QU5p?=
 =?utf-8?B?WHFEQkUxMi85cm9Da0dkb2wvc095WTZhRnJiOThoR0NIYS8wa043RkdtaGRF?=
 =?utf-8?B?dWpnZisvZSs3VnhjT3lJWDltdGEvMTZDeGJnaDVRM0ZZTk1Gb3JnZ1hhRDZB?=
 =?utf-8?B?YVVYcUN5QzFXTUh3ZWpqQWlWRmx5aDdGTmlSZ0VYajNzT2ZHamd1amRZYnFT?=
 =?utf-8?B?bGVINzFSTC9XaUt0ZkRSOFlPNXNIRkJ5UmVWcWl1dkUvdXIvb2dVdGJobk1G?=
 =?utf-8?B?Wk9uVnIxZ1NiOWpTSnVsQitHU0ZSUFNIUnB3MmRYVnI5OTBOS3lGcS8zVTll?=
 =?utf-8?B?UHBiTTBsbDFoVWwyNFZHT0JuNTRIakVXUHh6LzJoWFdxWXVOczJyUHJnd0NQ?=
 =?utf-8?B?ZkR5ZGZ1VWloVXg5cDFhN3VjS0RadEhRemwveEhiUmh1MFFOM2MwWVZxbm5S?=
 =?utf-8?B?UFdQNllUVjdOVC9NeitkOG9sMUZiajhvc2h2dU1IM1phaGVCL0cyNktNRTRD?=
 =?utf-8?B?WVhEc1lySkU4YzhmcU51TkpWWk44OVN3dTRsWTVmN3lwcEFsblgrYVJ4YVJL?=
 =?utf-8?B?cnBpOGVXQ0NycWsyWnJKUkNacG90dzliT2draERlMzFjTS85RTRDWElPK215?=
 =?utf-8?B?cFo2WEJKMGZIbGUvbnFqTG5YUEJRYzU2YTk4bEx0WmlkZ3VxeFJJRmp0OXBH?=
 =?utf-8?B?NytGVitMT0VmalBqZG1DV3VjSEtzRFowcEMrdWJ1MzJHZ1ZSS0htMmVndEYr?=
 =?utf-8?B?QjUvSG1EeStOOGRyTXYxSjRlMitlSjRrcHA2VjlHbElVZWc2Z3hnNXd0K3dn?=
 =?utf-8?B?dW93amtGQVc5SFdLeVZkeTdjT1VTRkhmNXdPR3NTRmtDSFBPSHBUS3VxSUFH?=
 =?utf-8?B?WjMwOE9kcW05d1R1bTQ0YlFzYWlpME4yamdiUXNYbU02RGU0TkVFVFl0T09J?=
 =?utf-8?B?SkRpSnk1SnVpdEt6Y0RPdFR5VWtSdkZHL0xsa2dXRG5tZEl5eTdRemRzSEZX?=
 =?utf-8?B?eW01ZDI5aFFBZzBoa3NwU04yY1Q0Ukk0bFpVanU5aStzQ2dPaXdCSDg1UGNo?=
 =?utf-8?B?Nzh2OGp5NjFVMGJrbzhpQVRFRXNvWmdIdFZIVDRhOG5ieno1ZkJEeVBtamdh?=
 =?utf-8?B?dGxBUDhXa0M5Sk82WjYvTDcvQ1RXK3dSNk95cFBpVzdBR3pWdUF0QXFReXVw?=
 =?utf-8?B?ZU5FZlM1eTBELy9iK0w4SGptaGs3eUlIQXE4QmVzYS9leWxqZWdLdGV2NVJB?=
 =?utf-8?B?YVlCRjkyUWNGVWdNSTdHK0JTQ1VqYlR1dGlPbjhDY0QzMzNITE00bWlTdFhr?=
 =?utf-8?B?dGtUNzNxMzJmZ1c5Y0lTWVp2cXdDeFd5SzBtekE4TVQxSElSZlRmRXVIUGto?=
 =?utf-8?B?R2RaTUlwU2thbmVYOWdYZVEwV2VMdmttY1JaTnBiaHR5Z29XRnFjd25ybDVk?=
 =?utf-8?B?OGNnV09FOXh6QjdOVERwSmdUck9MeXBQT2xkQmFBQUJnTWp4VXd6SmZMTzdr?=
 =?utf-8?B?UStFQjVWL0xmSlhRLzVlTWtua2pENmt5M1hHRTQ4K2hBenJiOFR1SEVPNEtY?=
 =?utf-8?Q?bi0/Gnx/uHafui+kC5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d2216-be87-457c-61b4-08dee6719884
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:14:29.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVJv4/n70vCOTCsP1aymzgWf6Bps0XOLhOTZPFz+WALLxs4gMuWSjfi/8eHvEc2H84MWTkOCi3gv5XYHd4sGIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On 7/17/2026 5:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Asynchronous CPER error handling races with ACPI driver unbind, causing Use-After-Free of cxl_dport.
This is a false positive.

The Downstream port lifecycle is tied to the Port's xarray and synchronized here using the 
Port's device lock.

> - [High] Live PCI configuration space reads on a potentially frozen or dead link during AER recovery.
This is fixed in patch 11 with introduction of cached PCI DSN.

-Terry

> --
> 
> --- Patch [10]: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL AER trace events ---
> commit 069c60a58d08507582ec548c08666c5374faa22d
> Author: Dan Williams <djbw@kernel.org>
> Subject: cxl: Add port and dport identifiers to CXL AER trace events
> 
> This commit updates the CXL AER trace events to include port and dport
> identifiers instead of deriving a plain device pointer at the caller. It
> replaces the separate uncorrectable and correctable trace events with
> unified cxl_aer_* events. CPER handling is also reworked to use
> find_cxl_port_by_dev() and the unified trace helpers.
> 
>> The serial number is retrieved via pci_get_dsn() which performs live
>> PCI configuration space reads. A following patch ("PCI: Cache PCI
>> DSN into pci_dev->dsn during probe") replaces these with a cached
>> serial number to avoid config space access in error handlers and panic
>> paths.
> 
> [Severity: High]
> Does calling pci_get_dsn() before the follow-up patch is applied risk
> causing a lockup?
> 
> cxl_pci_error_detected() is called during AER recovery, where the link may
> be in the pci_channel_io_frozen state. pci_get_dsn() executes live
> configuration reads (pci_read_config_dword()) to traverse PCIe extended
> capabilities.
> 
> Accessing a frozen link can cause the host bridge to lock up or trigger a
> secondary master abort. Will this cause completion timeouts and prevent
> recovery during the window between this patch and the subsequent caching
> patch?
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d5dc2c22565da..acf40b2396c3b 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> [ ... ]
>> @@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>>  
>>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>>  {
> [ ... ]
>> +	guard(device)(&port->dev);
>> +
>> +	/* dport is NULL for Endpoint and Upstream Port devices */
>> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
> 
> [Severity: High]
> Is it possible for the dport to be freed concurrently here, leading to a
> use-after-free regression?
> 
> While cxl_cper_handle_prot_err() holds the port's device lock, cxl_dport
> structures for root ports are tied to the parent ACPI device's devres
> lifecycle.
> 
> If the parent driver unbinds (e.g., during ACPI hot-remove), it executes
> devres_release_all() under the parent's lock, which frees the dport
> directly via cxl_dport_remove() and free_dport().
> 
> Could cxl_find_dport_by_dev() load this freed pointer, which is then
> dereferenced in the trace event?
> 
> drivers/cxl/core/trace.c:cxl_trace_dport_name() {
>     if (dport)
>         return dev_name(dport->dport_dev);
>     ...
> }
> 
>> -	cxlmd = to_cxl_memdev(mem_dev);
>>  	if (data->severity == AER_CORRECTABLE)
>> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
>> +					     &data->ras_cap);
>>  	else
>> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
>> +					       &data->ras_cap);
>>  }
> [ ... ]
>> @@ -360,7 +306,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>>  		 * cases below handle AER recovery for devices without active
>>  		 * CXL.mem traffic.
>>  		 */
>> -		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
>> +				    pci_get_dsn(pdev));
>>  	}
> 
> [Severity: High]
> Does this live config read trigger the lockups mentioned in the commit
> message? Since cxl_pci_error_detected() executes when the link state is
> potentially pci_channel_io_frozen, the pci_get_dsn() call will traverse
> PCIe extended capabilities on a dead link.
> 

