Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9741DDC37
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221238; cv=fail; b=JJ+9mj9RD7iWLVphW9utnZmK2+rx+eBsR2aWVJPt74oxIL2IZGRaiSSrfbrIxzanLh723Y+89sk+qtjnbRabbaO5kUyZidmIS+TZCn7Y3MUdiOCGfYkX1Zdk6c4ZFZg/zqzWtqC8yg1DzSyHyb08hyGKb3WUDxM3hksNyyOp5IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221238; c=relaxed/simple;
	bh=ti7xiVn++7dRn1t4hLWWmB/mK+5obO7t+2vkxjooI24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o3PNlJOv8Qpnkh0Mj8+Vk6ZablQ0bQa2FTjsktLBZ/LzqA9/7rvlKH8z1FDf8OomXEPdjoy4XoRugQ6bminzgt0QmcVE0kmopnQWwpoQpcisV8OMRyABcTks3Ij1hK/2lGzRn6xO1TkYHUaCkQK7PA1BGu+YjQrySbHMeXmzQBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eq9J8SrA; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eq9J8SrA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+S/pf9zrvkMkwhakDR5kC6m7fEGqiDBNb6Ypch3M6/PuIDcV31ndQ/Fu234bhNC6jefXFOBKlQhMm5dH890PD5k7vKb1B5XdwSYvzolOUGVfd3PM3YvDmdINywSnmgyMQjJYvJ61p5WayLMdNgJxNtJOKoTS8yC8iOXca+xY35G5UU9ze9QuKiIkBPfGB3E5AI6AHqWLS1xhHMW8JvAWNdq5VrQ0PykCXSuJ1loRFYkPPRlricW6bj7pZ3PqzfDuQe0I2t+GUcUlh00BBK+/LiBs3NBqk8HFwVEHXEy98ejPZyK1KrUgtTozHeHA79cUcaIDhgT727vaAuOFkngUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwjZAJeSaOY5uEb/+XJnIhHBxnU21eM0VSq2udjN15Q=;
 b=eJh4y+kL1vy26gzaR5Lu23sz4f+h//fQ4j7h0xYR3M2lGg00ybLbgVyxLHxm1DbYYPa17T2X1T62N6iX7dNtYw7PE846iqSZ/vHbaTqf4UE9NO87vo752lv7rRMh8zurEEZjWrKYOnedXjo0p3xdeQHDVanxv/kTJQXsx23KXSfUUQKIzWFjj1dO8dITbddl5N/VxgBEHcLOOdvOeY641qz0bA36SCIqlJkzbLQETiKzmxtQlbSghzG0uUr7s5wVItkxL/Fb/GF0HCyHzwRMMfEyX+4B8otZaqQyZm31d0qY1OqayaDj4bD2xQ52uhxs+OXpoy8H8uC8RLJql5WB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwjZAJeSaOY5uEb/+XJnIhHBxnU21eM0VSq2udjN15Q=;
 b=Eq9J8SrAHB4eV/hF8KaOHlS8w2xvDvpRn4xvvHdwuZD7/JrmGOLhz1hDIiPOgpZoJrIvTDqDaeryIPEb+PQvGz9owVBdzGbPKfUSWc9FBwnIaV38XRNa4MjRfMr/D1YyCe5hzxtiPycvfU76YQW24TnqN36/da0tcw005/1TBUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:07:13 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 00:07:13 +0000
Message-ID: <e4f0f5fb-b6e0-4006-918c-d49f6afc3c99@amd.com>
Date: Mon, 31 Aug 2026 19:07:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: Put PCIe bridges with downstream devices into
 D3 at hibernate
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-4-mario.limonciello@amd.com>
 <20260831222005.E01051F000E9@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260831222005.E01051F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 27246efa-c5a8-47e9-ebfb-08df07bcf984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RKeIRR9u+3TMtQB9gfHVQ/D5ZI6qq219GscoBX0JgIIN4Grk6aOtwjlVReApuGiffYuhSg20qgRM923hE/fgHe3WnaYLlDHYS/fABwvFG3nAmiZjMW5xcSby10fTQzxVv5AZQKYuJ7m8FEJVBppRZ5l8syFa7upvcvxexe1hvuitKOcEZax9pqPxifcRirbK4Z85iipaKLAcGwgGJS6upeosJfPFNvHoE+AmhUOILFiCQiasc9X4rg5Ae1DSMymGPE252Fr9w04zMJWwBK00MLMtwfbRt9z9UO/dycEUmvo3udaf3PEMCTmdQabZBLh00/DYHObOVZsefAREHWE/CbBd+UvfjJJQosi3o24rrEQt7oDTDSqsEBPoFcnCeMZwN7ZLiAysqcX3usCVhVfSCYK8sa0ur+F77KMKpdLQw6f412ZfayRYo1O4/+mfOzxRQTz/lsOTsJdomiiChlFALJ6zHI+/hRe5O/eBH74tc98I+yPLt3XslfHaXrTSAgw+3lhrua+oAhNhScErJfEnpFg/xKZkNYynt5xG7EC91tmPlCUsTBteSv56Tgoaskxx+kBo+rRClaHs+5PxF7X/3XiYvHslJCFkm/eiMUoCQyScvRzMRloVarvEpfTnl2607N5gxS9fZ86aIRNgYp0dL9CFfYBYP543JlzCBbEj1ks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDM5b0pqR0pVTllHMStGRXl4OUdpNGd0RGttQkoyMEVieGpndk4vM01IUVlV?=
 =?utf-8?B?WExxMlQwYUwySklxdXNnWEorK0dFc3krOTFnNVR5RU85QTh0K0JyQ2RKZnFt?=
 =?utf-8?B?bnI4VStpek52eHJUL0ZMY3hSa2dzOTVIclBuRTJqWjk0WHNRbFVCaEJBanJN?=
 =?utf-8?B?aW8vRmtRQWI5MG96RWJpcUtTcGV4LzJZUFVldlhwVVBCMTFXcmo5SHVJWUhT?=
 =?utf-8?B?MjN4cFdhcEJLRm85TE9HVWNDOWJUYlZtU3JtQTYwSEduTWpGNyt6VVNUMVEv?=
 =?utf-8?B?Zjh6enV5T0pVK3B5MFZhS29mQVpia2NGWGlOejF5NVlNRjM2ejRmYlZob1ZM?=
 =?utf-8?B?Q1R2SEQ5NjJycmJRdDBtTzhNUUZlVkcxMU5XeWJjWitzMjBXRncyUEtqT3Bv?=
 =?utf-8?B?cWxNVTg3ZzM5TmJIdXVsd2ZYd3BuSjVQVXVaZjc1bGx6R2lOOUljMWdYTkd5?=
 =?utf-8?B?Y2pZWmd6MU5VSDVyckJoWDZnd3dPOVREU3JTc2ZrNmJhY1VxUXJ5TXVPNTBv?=
 =?utf-8?B?QURtU0E0VlJwS05KM1BVL3I1TDJ5Q29USk9jTEdUZWRKOGxZUVV4R1VHWGll?=
 =?utf-8?B?eW9mSzF4bW1RNjQ0Sm1FR05rS05wTkc1aU1DdGZLbnRoL0F2OGFXQzAzQW5r?=
 =?utf-8?B?U250MHNqZm84UlI2UnN3UHRNNU5CQ0ZHa1ZwZDNoQjJPVE5xQ3RIT0hVNTBw?=
 =?utf-8?B?L2h2elA4dWVOS3Bjd1Z5Q1VEQ1dNN3F5dlNoMFlEc1Vyai80cFJxbHZWSllD?=
 =?utf-8?B?ZFNIZGptR2dFc1N0VTNTYVcrc09JUkRhcDNDUVJQaW5OSVZKL3YxRllacDJa?=
 =?utf-8?B?WkdJOHFOQUtVa3hWUFZVYXFKRk9wcGFHeVpuSnlLd1JqRHJnOEtBZjBlSmh5?=
 =?utf-8?B?dTlrOHlZR1MycXkxYTBSUW5VZ2dvTWV3eHRQYmZkaWJOUlhsc0taYWUvQUQw?=
 =?utf-8?B?aVpia1VERm1ObGJ2TjVRUTkzMU44TTFtelhPMzFtYXY3Q1FOOTdBU29qc2tz?=
 =?utf-8?B?SkV1TkJGYzZySnRUbFNyWUc0dXdNb2YvdFo5UXJRcmlrdkY5M1JzbGpwd0pF?=
 =?utf-8?B?TnFBWTBzMTRUQzBscUNPd01PRC9SeXVzN0M3aHJueTV2cnk4RFMvR0ZXamF3?=
 =?utf-8?B?MDEzM3FGTDYxNUZrLytCOWVEQ1FabmxVMlg4MDk2T0VqT0ZCRmlpc0k3WFNI?=
 =?utf-8?B?RCtaYm9tWlNMMm9zZ3VaaDl2OVdCV015QnVYZk5jNE9HY2QxRCtzSHJWMzNC?=
 =?utf-8?B?dk9KR05kTVVUMmVvSWdlajBKcE9hWFQ0c29OYzNEUHlzNWtzQ2plQWRCUlBH?=
 =?utf-8?B?anR0REJXS1ZISW9wdU9BaDFkM1pjRXBKeW0xbXg2K2hRN0NKOFlmK3JPMzdQ?=
 =?utf-8?B?cnlva0JJMXJEdWpSdnlzNVQ2VjhseFZ0VHZJQzh4M3lMSVFreUZjYnZOVTB5?=
 =?utf-8?B?TjNqUTk0WUtCS2xkdVlFNlA1MjJmWHVJYlh3SDBSSEtxWmdxTS9IT2FFZUky?=
 =?utf-8?B?Uk5JRGhrejA3ekY4MDVoUWFSUGVta1krdVJYT285WXpNNTd0Rlh1d25YaExS?=
 =?utf-8?B?Mi95WmFhbWtQRDF5WmUxaHFjL3RHd0F5M1cwYitIVGlKRCtmUXEzNWREb3lr?=
 =?utf-8?B?bjA0b3JlSlI0bmQzYUZkSTdBMlpKMUc2em00aVpsM0MwYjZYNXFTR3AvWHV3?=
 =?utf-8?B?UE56N0IwcmRhUzdsNUZFc1liZW1tcUFNNWhwd3h3ZS9YYkNQK3ExWmQxWXR3?=
 =?utf-8?B?d29ENjJacFJHSTg4WnBvN2laQVFML0pSTzQrYnFSc28wVXpGam9jemNLQXQ5?=
 =?utf-8?B?QXRkSVZGRjIxWVF1aDh5WDE0dDBkYlBoSmsvNkJiRTJoNVhvYWNvTm5qR1V1?=
 =?utf-8?B?NVFGWUcxOGFpZEFYK3BwYXJXaW5ORUJQVkZ4cHE4TEdGQmx1VFROUHdaWGNt?=
 =?utf-8?B?SCtvOWJNZ2FwOXEveklWVFdKUDNCakFWbmRqUVZHY1ZFNHMyVzRuR1BSMXhQ?=
 =?utf-8?B?QWNpbndTdjN1Ly9IOVNibVhRNE42VXFsSHhuUzFDVThHNUdjWEErUVRJMllM?=
 =?utf-8?B?M1JUYkp5K1hxcWIyVndMeHNHL2I3UURlMUQxTWxSeWNWSkI4djNVTmo2Q29u?=
 =?utf-8?B?bWJQVEhiazdaTDBGL0d2UktVRDdJYmNjaDZDTVpJREphOEJiN0gyVEI4dWV6?=
 =?utf-8?B?cWNMZkRvY2tnSDNmY2tNMkxXYjhUei9MM0VZVFB4MklNT0xQMWdiTnFhcUNh?=
 =?utf-8?B?VE1rc1hZRVU3bEswVHcyQUtHOWFlcW5kZFM3SFZoZEVLbE13NHplM2Z6bFV1?=
 =?utf-8?B?amQ5UzkzdU5ybHVkSGN2SFFZK1JsQ2dZV3g3UGlpRWJZNXM1WkEzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27246efa-c5a8-47e9-ebfb-08df07bcf984
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:07:13.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgyjnZoVQV0/RgmgFadk0HUH7nT3oqv4DmypflJtdoxfUcFWV/eBFaEU8aWZ2RN17f8wEoSRVdplcWxgyMwpRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

I think this one is a false positive based upon an incorrect premise 
because hibernate-to-disk power-cycles the entire machine.

Only after all that does the image load, atomic-restore, and 
restore_noirq run — against hardware whose links are already up and trained.

I'll adjust commit message with v4 for patch 3/3 (and drop patch 2/3).

On 8/31/26 17:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Hibernation restore skips mandatory PCIe bridge link retraining delays due to snapshot state mismatch, leading to fatal PCIe errors when downstream devices are accessed.
> --
> 
> commit daecc28d1bb864ce78fb9c9df2c8ecd53a30fb12
> Author: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> 
> This commit aligns the hibernation path with the S3 suspend path by making
> pci_pm_poweroff_noirq() use pci_pm_suspend_noirq_common(). This allows PCIe
> bridges with downstream devices to enter low-power states like D3cold during
> hibernation.
> 
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index d15b3eb55ec53..a6fb731378d9c 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
> 
> [ ... ]
> 
>> @@ -1278,8 +1281,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>>   			return error;
>>   	}
>>   
>> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>> -		pci_prepare_to_sleep(pci_dev);
>> +	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
>> +	if (skip_bus_pm)
>> +		goto Fixup;
> 
> [Severity: High]
> Does this cause mandatory PCIe bridge link retraining delays to be skipped on
> resume from hibernation?
> 
> During hibernation, pci_pm_freeze_noirq() sets the device state to PCI_UNKNOWN
> via pci_pm_set_unknown_state() just before the memory snapshot is taken. The
> snapshot therefore records the state as PCI_UNKNOWN.
> 
> Later in the hibernation process, pci_pm_suspend_noirq_common() powers the
> bridge down to D3cold.
> 
> On system resume, the boot kernel loads the memory snapshot, reverting the
> in-memory state back to PCI_UNKNOWN.
> 
> When pci_pm_restore_noirq() executes, it skips the bridge power up actions
> because the restored state doesn't match PCI_D3cold:
> 
>      if (!skip_bus_pm && prev_state == PCI_D3cold)
>          pci_pm_bridge_power_up_actions(pci_dev);
> 
> Can this state mismatch lead to downstream device accesses failing with fatal
> PCIe errors on resume?
> 
>>   
>>   	/*
>>   	 * The reason for doing this here is the same as for the analogous code
> 

