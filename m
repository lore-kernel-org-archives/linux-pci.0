Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9A45D92B;
	Thu, 15 Oct 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095927; cv=fail; b=SjL3fNJF138XW9wjlDgpQ12Sy3r8wTaWL1InNy7toUyPqC4429gbpuq4fNdebjgKtBK3EmlfoAU6Fq9kOjx8XOUsbUfXs64xXMexuAUQrmG3V8U6aDHWOS47a1KLEcXniKIHAJ03PVv5v16ulmWuYwrsLlQ7XfqjrKd9iGSajVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095927; c=relaxed/simple;
	bh=qZhjvwSqjUh7IO/ikXSXzWwYCEHS6GS0unoogFm0NW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eoHH5aHKOFftTbAGGYUNBXTx7M49nnz4HXWbxrf30TSN9AdGVKldwBbm+Z7D1ri6SLwHBxcet6fZlRyeho2cxwvJU/FM6qm3eV194T8hC1jPLw5YiTppxY71hptP7KNLQ/YvlXNFTWjEt8U7XSBnjz1ElSdl1ynB7Q5IY5UvEro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GvZXaCxK; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GvZXaCxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3suzpvhEtJwpCgBP88QnSNZdrkwC1LxLZZXSc1jbeFn5H8QpCj+0FGLJ3TRWuEgi4fjj2g+FvRu9e26jwxes0OVFGuW/bZ56tbb/DQm+scYHgRyhQrk4WpKrfR0rA9wu8PkTm3HLYKzlxcTaHW2wba3T1qrU5PUcYus6aYryY97G+p909ozw9X3vF8shfFU1e/bfgFxY5PQUlZJi1noPpdFeqOwtAvTDPMj4LithaMj1us/A8nTpmBlYWRbUmSGCUilhFJEivdFMGQATTkBGK5EOtbtTG66kWrHL8breW7f+44Baj6EkSittHFxoy4rOxUC410dmDBPwF/S6/TrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ofcBaSiG9GOvkD3xO2mPodTDI6yWISij+GCvjA/hsY=;
 b=s+PHw3HTCrp621YrunbGKt0H0fsTwBKMpLoaWaomsWZDX1jlKYUPSBJ6xcmOgTbvWbQncsl9kLp5+ncbHaNlqF9H498a+obY+VknjAIEVwkYz2/HNCGR6T26QUa7vtEVBrBvbAo0CM9P54pNwkIs4i2EBPzkEjtn0IQxxp6xohmUDC3XXCszzQQJ3MIn8n38LxIFHyi9IQukOmUne/XFjI3S0yxmQznWsG7NBSHL5fSWTtgV/eDjbI6qZmtiGgrd4Rbx6rxFWCYSIjIfzmbucENn57kdt8vX1gzELJSllqaWd/nyXfrSXrQngrx7PZAh/HMnrhzrulypPZXhJec/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ofcBaSiG9GOvkD3xO2mPodTDI6yWISij+GCvjA/hsY=;
 b=GvZXaCxKVjpbLGivaU7OTR6+EK6Atnt+CM+qGuGrA/+CaX+hUAGoJdqaFwC4nGuL/ZX8Z3J6iAOH+7VdJkFqFs2V1rjm3PWj9y4oTCJHLNsoIibqERNwuOj4aIzfhPaY04lyjES27Bb5fJZE/vVqUjjAL2Jug2tVHSty8EPGQNg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 15 Oct
 2026 20:25:21 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 20:25:21 +0000
Message-ID: <4284d6d4-244d-4d49-bbdb-f1bda89fc1e8@amd.com>
Date: Thu, 15 Oct 2026 15:25:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, bhelgaas@google.com,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org
References: <20261015194828.GA1775177@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261015194828.GA1775177@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:408:ec::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d443704-34f8-4bd9-1216-08df2afa6faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|260925022911599003|260925021911599003|10067099003|260925021311599003|22082099003|261009223027099003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	JNFDgrAm9lZWpj5oLE2TFRC6uoYpcXhsN9TwoMNbSuDxBdPpsJfJfCKtvbc101D1CeozlnmGcu6fFlDtbFfgEzpAlYqP/YzdOUblJux0aKR8y+TkNXuTkk2LZWN8dh9BQTS5JQHfAZ9E/Tde9mVPec5/l8GrWfpinfhhy7fOVzd7c6InfvdBpTjdI3jCss6q/fYDdgFMxyBGKOtCWA+6QEQO8yNShe0Z3gN6gFMIponkrd7Q6EASoqEF1H7xftE0SuG1S7U+ars8EkWn8E3l8QK82getG62ow8NlyzNO6+IO6xAKAB0WzZswEESfb/DU0NHIGlkpsghnc2NBDL7VSJvXcOVe8W91nYPdssHB75FXg1pOhgCdE4isblxUJNTNO3hzxAQYrhXbmLrnTjmDAyiQ4yfxDJDZgroXmVI9AlVoecZVRUj3K/VhSVPecs0z1hnWw0a9zfs3m6J5wPXHHdcVVZROtOGosbXzmDJNQhTksSCJX6ARqDe46KqTrzMX1H/DQfhBykozOUh5+WrRSWEUHe//D/cYqvk6hgrUIAgkBE2fvprA+sgHKgkW4F9dyo8AXvZNwhrWke+GFKQuc/HsXWzUo31AT9FXqOww4z2yObAQQxqiDX2z3TrwQytY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(260925022911599003)(260925021911599003)(10067099003)(260925021311599003)(22082099003)(261009223027099003)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3VKa2gvRGg4dkJzNCtEK1Zwci9FODlMc1BwVGp5R0VrV2drY2xzaXNJUGlQ?=
 =?utf-8?B?dGdmdXdhRVhTQjNTSXRRZTdockVhYjljOHE4L3ozTTI0bU1pZWJjaUM5NjZZ?=
 =?utf-8?B?MmVheTdEbnZPS0VPa0JKdzlTanU4aUxZbWtrY2M1WTJHMkhZclIrbXNwdDdy?=
 =?utf-8?B?dDRkTGlqNVFhNW1qYTgyNDJJWW9zdG4rVHdYM05leWorcW9JS0U5d3ZyWDE1?=
 =?utf-8?B?NDhwbWE5UDh6ejNjZUdaUG5sVENQcnRXbVJPT1pLTnhZZVYzSUZTNlBMSTM5?=
 =?utf-8?B?ZlFJcFQ4OUlOa3JEa2JZMkRISXJxNVJQRE5oenNtQXNDaUlsZ2RQZHFDaWh5?=
 =?utf-8?B?clE0TEcyekhqY3hpYnd6TzQwQmg0V1JENnljYjlDSHg2bUh4LzhWQk45aFkr?=
 =?utf-8?B?K09WeitUNEg4cFhUMk9nelBtbE5CMTZTTk0vTGtYc0FYVEw1VzRER2FZK3Az?=
 =?utf-8?B?ZlcyU2k1eEFNNXRNb2kvNWtEUEdzTE11WVJLbG5FK1huZlpnc2xpWWpidkV0?=
 =?utf-8?B?UVRmSHFwVXlCdkNrZ0I0YjN0ajhFZHFJcVluemk0Z05YUmR0aERPRXN6ZnNi?=
 =?utf-8?B?SCsrUFlRc0gwNGluWnVpNEhTU2ZZMldJdFh2STVFS0xrcmpxNytFTzZlSDFn?=
 =?utf-8?B?dW1wd01DK0pRcFdQNXJNZ0hIK0pObFo2S045eWtoY3JrNjFKYU4wRmFYYXVZ?=
 =?utf-8?B?NVZRZXFRbzMyQi85eTFCaEdCenNuVjg4Z2ZTTFliQ0ZDZHdSOTVWUXVHMnI3?=
 =?utf-8?B?cDdxZ1kxdkd0RUU5VG5RR1o0UXBweEdJcjh4d0lZYlVQZTJtUDlrQS9FdGxF?=
 =?utf-8?B?U2tLT21QRWVwZ1JoMDJhWnhBVEhPcUxXdW1sSGhIVm1WSzBjZVJzR0dkM2Vt?=
 =?utf-8?B?MUtkMENHaHVSQ0I3ckQwM2FLQWtMOGVVby9CRU1wTmgxZC9yYy9TUE1hbFl3?=
 =?utf-8?B?bEpLRyt1cW5nMDZLeHZwU2FueFVUK3JERjVUVXNuWHlRd1B3cTJWeEtuMDR0?=
 =?utf-8?B?dEdLUUdNSXNxTGZmemxqeG8xVndDLzBEN1JvNnRpZWowQkVWaVFSM2ZWVUJl?=
 =?utf-8?B?Tlk1cWd5QmROTzg4RXFpQ1dYeS96aStsNzJ2MWh4MDFlSG9JSUxhc2hVcWlu?=
 =?utf-8?B?dGxiY2pScnFuRENTaTNScWZNRXRreUl0R1JmeDZpUGYyZmJRSG81NlZETFdG?=
 =?utf-8?B?Q1JWYnBhdS96WE1ibVBaNFZrOW8ySjVFL0p6bDM0dU1vbkFSWVd3TUI2WWdB?=
 =?utf-8?B?QThuUDNiQmR6RkVhSy80aTlKL0xKSFdpVkFDUXY3bll4NmJmZ1ZjKzBVY1Y2?=
 =?utf-8?B?YUZLR3F2YUF2dUpNTTA1RzVMMi95NWRjVFd4d1U0OXRCTzk2SEd1UG5hWk9E?=
 =?utf-8?B?dEs1Zkt3ZG92TEtyMGJVSWRLZ0xiaGxjRnhvOUVlald3MFdIeWFpaU91aWo1?=
 =?utf-8?B?aEx3NWRkRTRCL0V1MGlCMDhnNDVsRjd0ZFYvdUZKR1l0c2pJK2ZPRzN2eU81?=
 =?utf-8?B?QmdSQk95TmtPaVdlVFcvRFpHOTNxQ1h2L0VoZ3Z4WkxOeWxRb050eGF1d1ZM?=
 =?utf-8?B?eUNPUW9WeSsxVXFsL1YwZGpCeVRjTWZ3WVBjc3BQelo0RHRKNFRBVkxWSEhH?=
 =?utf-8?B?ZTlNSTlyNzkrdnlPaEVTTkw5VmsrN1BoUSs4WnRJMVdqRldhL0hrY2E4Y3V4?=
 =?utf-8?B?azdPRHlGNmNuTlMrSFhGeUozam94WXY2U0RBWDNGRjlFb3JMdGtaWHMxTmJM?=
 =?utf-8?B?ckNMcDNueENJa3hHTkZiZFU2bXZaR1Z3TVd4ODZOcURwc3ZxRkxMbnBiQ0pY?=
 =?utf-8?B?aWcrYzZpdEU3T1VGQ3JBSTAvR2tqRi95UmcrWXorVEU2WUVmZzA3SGlkWDh4?=
 =?utf-8?B?WXZDZlpkNGZuZ2xWNHNsWFBuQVorUitIMXUzTHE2ZDBXL1EzOVhZQ1pXTkxN?=
 =?utf-8?B?eWRSaWFlNkFZQ1pTbDd0M21YK0dINGxjK3VHeDVSMVV3bXZIalJlMHQ2TlRW?=
 =?utf-8?B?cXRPZ2xucndVSnJzeitzeWlneDN4YmtUb1FKaEc0aE9SbkJBT2loVFdVVUFI?=
 =?utf-8?B?Ym5KMWcyWS85aW5hSlpQZEQzNkk1dWNoaTR3MW5oT2RwNHlqVW9aNzFRWUs2?=
 =?utf-8?B?ZzAxUHcyUjFsTUhpUjdnQ1lWa1lTTlFabnM3aGMwaWl4WHRQWlBjRU5LNXht?=
 =?utf-8?B?VEIzT3YzdGsrZFpheS9yY0ZxK0dyMVBqM0tsaDNQeWVxQkNwZ2h4c2JIZExY?=
 =?utf-8?B?WU9oSFlldUxxOFptUzBTZ3EwMGREaDM1S3BCU09ka1RpSU5sZklwb0ZBL1o0?=
 =?utf-8?B?YnRxdVJua2M3WVhEMHBNakNWcXc3VzZveE0ybTNNR3FtYnBFSW9Fdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d443704-34f8-4bd9-1216-08df2afa6faf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 20:25:21.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FztyKrPtpZGJAEBELrPHIwp/3QRwU8G1dDzDsoG8zsdCQGQYz9SNZWpQxyPREabYymq/C9xUiDgtDWBY+k9iXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785



On 10/15/26 14:48, Bjorn Helgaas wrote:
> [+cc Alex, Ilpo, Lukas, linux-acpi]
> 
> On Thu, Oct 15, 2026 at 07:48:42AM -0500, Mario Limonciello wrote:
>> The soft filter system introduced by commit 11c141672045f ("drm/amdgpu:
>> Fix VFCT bus number matching with soft filter") has a deficiency that
>> it won't work when there are multiple GPUs of the exact same model.
>>
>> As it was introduced specifically to help the case of pci=realloc, gate
>> it to only run when that's in use.
>>
>> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
>> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 15 ++++++++-------
>>   drivers/pci/setup-bus.c                  |  5 +++++
>>   include/linux/pci.h                      |  1 +
>>   3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index 08ed1eb695586..75af9a59671ae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -384,12 +384,10 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>>    * @vhdr: VFCT image header to check
>>    *
>>    * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>> - * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
>> - * resource conflicts), the runtime bus number may differ from the POST
>> - * value.  Match by device identity (vendor + device + function) and use
>> - * the bus number as a preference: exact bus match is preferred, but when
>> - * the bus numbers disagree we accept the entry if the device identity
>> - * matches.
>> + * On systems where the user requested PCI resource reallocation, the
>> + * runtime bus number may differ from the POST value. Match by device
>> + * identity (vendor + device + function), but only treat the bus number as
>> + * a preference when pci=realloc was explicitly requested.
> 
> This is a generic problem, isn't it?
> 
> I think any table from firmware that has PCI bus numbers in it could
> trip over issues like this.  Seems like we need a more generic
> solution.
> 

Yeah; it's a generic issue which was triggered by pci=realloc which is 
why I did a soft filter in 11c141672045f.

But this causes problems when you have two (or more) of the exact same 
device.  You might match the wrong thing.

>>    *
>>    * Returns: 0 on match, -ENODEV on no match
>>    */
>> @@ -409,7 +407,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>   	if (vhdr->PCIBus == adev->pdev->bus->number)
>>   		return 0;
>>   
>> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
>> +	/* Allow bus renumbering only when the user requested pci=realloc. */
>> +	if (!pci_realloc_enabled_by_user())
>> +		return -ENODEV;
>> +
>>   	dev_notice(adev->dev,
>>   		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
>>   		   vhdr->PCIBus, adev->pdev->bus->number,
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
> 
> I don't like this.  I think the same bus renumbering can happen in the
> "auto_enabled" case, and I don't think we set pci_realloc_enable in
> that case.
> 
> But more generally, I think ultimately the PCI core should be able to
> reassign bus numbers arbitrarily to accommodate hotplugs (given the
> appropriate driver support to tolerate that, of course).
> 

Could we keep track of the original perhaps?  Then drivers can know what 
it was reassigned from?

>>   #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
>>   static int iov_resources_unassigned(struct pci_dev *dev, void *data)
>>   {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d31a8d107b1ef..844734da9250f 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -610,6 +610,7 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>>   }
>>   
>>   struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
>> +bool pci_realloc_enabled_by_user(void);
>>   
>>   #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
>>   #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>> -- 
>> 2.43.0
>>

