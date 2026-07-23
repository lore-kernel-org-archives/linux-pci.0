Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C76470E92
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821534; cv=fail; b=Ed0kD8A6Whc/Gdv7hpE0UpPEhH0iIO1mzlOkFbgf9m4rrgAxawxMo2RFmDjiUk/syIi8RjB4qvQ6hSWKUH6/DgCGEYJiVk7ABbG+39CEBMFjI8q+6DFitOQxygPC8fzrdc6zBWg6c1RT3bRVNcdKok6ybHbtjGFDJFIlqxIF/s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821534; c=relaxed/simple;
	bh=UefB+dr/10SfOGzMM2nX+6DC2rrdoxMCQ5ZXrn+0m0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ISkE7Pz53kHf/JLLbotn+Du0HXelBc2wbMeHCLiDTAOIyh49XulCPvs1b9prPa9emVvhMYQhPFAQ1OW9eqhUIgGv+muH/hW3H7WEwwYITE2yWA5EvMeF2QFtYkKseJWdgF8rBWgyuLA72mzq/XStILJb2RlszZzsvqX4jyFHDhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bkCXRgPM; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bkCXRgPM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sufSk1hp+ld+NDxW/u0yUDuCsaYiquYw49mc0Lc1ooNy4TYCASEu5xbxfbfW2CJTGM72q+8uOtiXEscHVbZjXRxBrPftipD47VsqJXcQoxXnZG3BH+Ke3lNfmiHU1/6p749tNd/r74uQofrw2p8SGAWwMOgKB5OpbTH/P1P7YND0uy/JErrP0jXA1zLZ9wDfQ5Wwf7NSIdbUsyr2Cc3/dl86iZQqz8nglYJ2HOBQCZ6TEukgvl5tr291etn/oDBr/pOuRYDV6hvZcr6cC2M2qne9XXatVsrUQL7y4CDt2ihGfNJ+trpyIafKC64ymA83g6fG5N/Yb9D5hHf3EN+BWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JwhPeXSgONR0UAyCA2Xhc3+nRdCj6CpXm1ZLHQeCBw=;
 b=mS0L1B29wfj2oJzrAVpOe9Srm8RkPRBEQ2R0yqZ/Ev+leLsPnIRqnUqfNI9Bn2nHp19Y5ojamiFsyqOQdCqxsN9xZ3iV4NvFUPk2D38aAQIBLf2DakOyL2H9k2HOMWiLNlEgBQQ+8bwRjruU2TYiTTKXtRNCBZajhEjhskFGjG4BNXNgjiixSqz4ixi9hJmc1xY6wq9jUEaGalTQZz579RJjQzl69WNItoxRsG4L66arJwncXpaRLq12hGJ8EWFDC6vpuSMRYqGN14+G6Petpbxi/4kAx8Lt2TB3tcNIpx8tqse7pCqhdpgzlm/x2FmydJPoa2G8c7gkPbS3pkAYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JwhPeXSgONR0UAyCA2Xhc3+nRdCj6CpXm1ZLHQeCBw=;
 b=bkCXRgPMcqxKI24OgcQ6q0P/dTSLbxBvUM1k0etYwj9iPHsGm/rvi9sNijujTjMRV1aWBNrXVmiR4YxKiuJcnsBTFM+8dLNRw+T3/bqdDAv9maVwvdkgl4EdI140Fv8kcqk43S5+sHDAgaOkgMJBTGzufW8DZy6pvLhdQIQvQA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:45:27 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:45:27 +0000
Message-ID: <2a9f85b9-7fa3-41ab-9383-ffa1f44bbfd8@amd.com>
Date: Thu, 23 Jul 2026 10:45:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Mark Radeon Pro WX 4100 ATS as broken
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-2-vasant.hegde@amd.com>
 <20260723154259.GA836122@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723154259.GA836122@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: f77acc41-7523-4080-b748-08dee8d16af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4OjpjXHcsbl2sCK+LZS7iJ0NADkioHUs5idgELVwOBavdORHhZjg2g6VZcsMXMcLtjCO1C4N5KBq/hmWjIUCHUIng3RgXwGZkzbypLmDaC2xMTnrANqOkYclQlFbCX6cCHLA5JZ/yihPG2/L77EDlSknnT9S+e7gG4PClJ5PCJsePjzKLb5cEWrvYOigdd2iUVOeV+80U8OdAjICqIdXt3sjjX/M0geDcT+8P6BH2WeNjXN14bM60xSD7D8PxqXGEKPlhiMuoM8cNRmroe03RbdbgtN/UyPhLOLarMtBTsJW5VlkcaWeF5V11Dknb/94ko1HOrmyoP0Iu6z/2Z6tmS2Cy8LJR4n5+vKeGwYaKouOQhCnDIktPIvgqq+hjvyzBorFH42eJVDoi+0fBu/zusvjwfEu2XUkWqIwzSTgw+7BwE2P18Nz8eOQdQzXkw68ymITxxf1R4V/OUBVRRQHny/BxNFRfuwZxs4gUFPnHr/dikTL9wAKwtAm7HECXMxe/9hS4eR6KnKw5Tk8RGiSTgbZzXQETFnXVYNywqLgDinAClrjfr+o+d+WHsmGmvorgeTqPGlHe7L5Y+VX6LuDqQZUwvyD2dxU8jl19wjS4EKGzpmQYKc2YO2kVcNVgU7mtz3Qc5q7vlK0K58qpyzcgO3YQeH4Tishdxng0jyNiHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJzY0swRXptQ1dYY2tQV0lNRkNuRE9HVCs2ZlQ2RW9pOHllZGxURFVoUUFh?=
 =?utf-8?B?ZVY2TUhBTUtLZkpzRVdpdFZXL3lkZ1ZKMXNjU0RzT21YMHk1djZCbnYyNkI1?=
 =?utf-8?B?ay9qVERoMnRqWW1pQ3dKem1RUURDQlpwdmhWQ2VwVTdrbm5JYWFmN3RtSHFz?=
 =?utf-8?B?WTM3dURya1JYbGp1SWw0Qyt3NmcwYnM5NGNyQk9yTnhkVEpPamhCVnNXVlFL?=
 =?utf-8?B?ZnlDRGJoSSszOHhiczZadlNxbFhoaGsyZFNHN0E5RjNmQWtNWjdYd01SYmhr?=
 =?utf-8?B?aUw4Y21mcTdBYytDcXh4L0tLaldRZ2JlN3lWcEMxTWhQaXp0Tmk5b253Z1hP?=
 =?utf-8?B?M1lINGFZWnBXZHlGZmFWakF0aDNVdzJNWk9hYUNFS294Sjl4eFFiaE9RL0RD?=
 =?utf-8?B?Vkp3RkVsdjdNQk1HSitHTVhmWFFqRTFwRUd2MW42KzA1c2F3Q1ZrQ0I4RVpv?=
 =?utf-8?B?bEgvNU5GN1l4L2NKTTZrSlBKY2xGTnFyb3Z3T3FvUC9HUDNQUDEvOWZWZlRZ?=
 =?utf-8?B?NFNVZm1ZUlp1ZFY1OFB4dThMNnNlTzJaeE1IdnZlT3d0MjdtbG11T2wyNXlL?=
 =?utf-8?B?UFRXL3Nsa05vWHN5dlJWNFlkbEVMTHNvUnlZL0VmRXVDWEdIdmo5c3BoOFlC?=
 =?utf-8?B?QkltdTJtYkVTRGFxRk9EQk1sbEMzVWdLZDBGUTNUVTJvTDMzLzAxSE9xQVhH?=
 =?utf-8?B?bkpvK29ZSjZtNnNkdmtKQzloY3drbzFqRDdoSTI4WHhqR1JicFVnb3hLcmVw?=
 =?utf-8?B?d2FycjMxUDdHOU9DWWNjMVlHRDVseEoxbUp3QkQwdVBsM3lJS25GSytFTGxv?=
 =?utf-8?B?OXhOZ0VGK0R5UXJRb3paUzdEWTVjWFB1eVlJT3RCQzVsRmFsR0JleUJOcEpD?=
 =?utf-8?B?MTZDKzhkbGpHSGRRb0k5M0QwUXgySkw2SnVJR3FSaGtQWmlBSWhqQW90c3BW?=
 =?utf-8?B?TmJ1VXZnS0Mvdll5bkh5ODkvVFZvbkxyMlU4V2JOcDZCQUFFOGlLUHhqZXNl?=
 =?utf-8?B?VWNDNkVKbHF5eGxMMmtmMXVWSFFSQ3pCVGtFVDN2bDN1cDlnekZCVndUTWZW?=
 =?utf-8?B?NVAvRGpPSTBPdjhZSkpzRUhDNnlpY1pTdHF3ZnNKTjBxRnpYY0NWVm9TRGd0?=
 =?utf-8?B?MEdrRi9mK2tjUWU2QWJvYktZYmIwK3pkTFZIZllBN29KQ0dnbXJKeGQ5dVJC?=
 =?utf-8?B?Rmd0cTA1My9LVWNkVitwbUd4UCtJMU5uSWswRjhzU1BLU2s4QlcxTHgydThw?=
 =?utf-8?B?OCs4S09UanJwNGxxSHd4c3dzaFB2LzQwOWduY2lGV0M3WHVuK2dscTJjck1N?=
 =?utf-8?B?NUNSRGYrZFNCd21jMUl5bGtiNHFYeFFtM004WG43Vjl1U2NOczFEMmpzeCtx?=
 =?utf-8?B?eXg4QjZHaE9kS2JROHJFYlhaZ2NiVmZPUlpXV0l5ekp0MXlpa1AxUlpSYlp2?=
 =?utf-8?B?MlR1UStzSFhBNHJGUmdtTkNsNWN6by9UVXNzT1QwamxqVGFDOHc2Uy9tOWZs?=
 =?utf-8?B?TitaUCs3SDYwd3lQUGN5Q0h2QW1adzlUV0FVT0pMcS81RVJJbkJZZEh4NzEw?=
 =?utf-8?B?QjExVW1HRWlwYUZqdFdWVnptV2g3SXA4R0xhNFovcjQ5RC81SXlCcmhTeG9O?=
 =?utf-8?B?eGh1K2U0cW9DYnNRb1JHY25PaWhOdmFvaHhiTWo4OGRwSFp2dmFtNHdUeXR1?=
 =?utf-8?B?RGd2eVNhdXZZS09GUkIwbUt5OThpODNaTnNPT21uOTNaQlozWXdiaS9aTVNN?=
 =?utf-8?B?TzRnb1ZuWTZ5MGlDYnJFZmRpVk5WUThwZlF6c294cG9ybmVPSWZYSDFXS3Ir?=
 =?utf-8?B?NmZHYllBaENBTkJxOGFzME12bTN3TTFDUlN3VG1KWkZrdGFkR0dNbzVGNmtL?=
 =?utf-8?B?Szl0ajN1QzMrQ1p4ZUk2bkJDVVBtcTVIS3VOUjhNVEowSDh3TGNFZkxva2tM?=
 =?utf-8?B?ejd2V25jQnE1alJhTElVZ3FKTmhOZjlvVm9YU2l0b2ROaUZtOVVnZW95T0NR?=
 =?utf-8?B?TkFmdmhHWXI0Y01FWlBNZ0R0bXJrTUV4RFd2aFBNK3JuMG9HeEFnY0xRWUtJ?=
 =?utf-8?B?WFBLNWpmMFRQNytXYzJQd25PSEdYUFUzSURkQzJ5UzhVRk5xYW85b09WS2Y0?=
 =?utf-8?B?eDEvNGxuOFkySFpteUJzRTBZdmI5SEZGTElrTDk4WE9aWXhUdjFseFI1VG5q?=
 =?utf-8?B?VUIyVEpBb2FxNkVhek52R0VQcnNMSEt1aU8wakNLdlo0WEJrNVhDSjVyQXVx?=
 =?utf-8?B?bzdUKzllbzJHNmpob3k5T3l3Wks0bXQwRTJzWUVwZlplTjhRdFhHRzdIZEZ4?=
 =?utf-8?B?NGNrL1h0ZGFaSTJ1VnhTa2lCbkkxZUJGN2lyQ25DeHBrWmpuWXd1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77acc41-7523-4080-b748-08dee8d16af4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:45:27.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5C7axwVU42vQ532g2QgAcNChArlLOFTIUyp7n8nMe6hJ9CjN8szRZtxrgjXp5+K29+g+anLtLyEUzX9bAusKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948



On 7/23/26 10:42, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2026 at 06:15:47AM +0000, Vasant Hegde wrote:
>> If ATS is enabled then IOMMU logs below error and GPU fails to
>> initialize.
>>
>> [  103.687137] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=0000:c4:00.0 address=0x1080006060]
> 
> Is this a published erratum?
> 
> Is there enough benefit to using ATS to make it worthwhile?  It would have
> to be a pretty substantial benefit to outweigh the end-user frustration of
> defects like this.
> 
> If ATS isn't going to be validated by vendors, maybe we should disable it
> on all AMD/ATI devices?  Or maybe only the GPUs?

Isn't that a pretty big performance impact to have ATS disabled?

At least I don't think I would want a blanket policy without data 
supporting it's a good idea.

> 
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/pci/quirks.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b09f27f7846f..d55657347d88 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5686,6 +5686,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
>> +/* Radeon Pro WX 4100 */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x67e3, quirk_amd_harvest_no_ats);
>>   /* AMD Raven platform iGPU */
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>>   
>> -- 
>> 2.31.1
>>

