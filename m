Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3E41BA82
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220321; cv=fail; b=tWSrwwyI0mVX8Iepus5qZSk/ko4+6wWpb8mtS/cAbbva4ELgEqk9z4hJa5FQdGAZv27jg3xx1HmVO0EhrOhw2nHAXlAqrKNqmFx/bCW9klsBRft7T0OzKnamePmPX6YbMf4fXf/DQk7l9wY+LouylWamHOlVwjURTviGgfiucgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220321; c=relaxed/simple;
	bh=27BGSGrb7n3akJsxCYf1GNIjQS6M+S7u9+qf9rGa5hM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlJvywSJXy+UyDYNeFfxSxeqODtX9X7M9kShxrPhgoDoy7dy0k4NuDoaVqXlmyD34tDzuISd064UARsdYTCmCj6ze9MSxYbMI2fcJ47oG7bxR3J6vJo1xGdhxkPrVEFDbQIBZ3r5tdC2rK9suvSDY9l4fywrcKxImgWCoQu6GXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbVLXGat; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbVLXGat"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRIgZXOTvcUnqpFFY95PXCRexMaUfKFJ6ynJrqzlZqwz4puDIoTd2wSuVfjf2kQmX2eChoP72IgjQ6S/em2UN0DwaO6wTkY1NjlaDTdHgg5wNwTZo8H/nuZDOQwpzUyfpSQU6NbkzpAu67nbMwWmUE7zXMy4La1cbdBG6MVN6g2ZegqTE3jxZ1x7RowC99P3f5JCye6amWiw3QVUDgFYGNfTNIlezoaf1THPDWiq27zvewBc3OOUVpcjVzF2HqNMSIdLrhIVBVuORQTLAbJhQsO7BbC0VqH7U2RFbmzUObn4y8dLrdIj+lMFrivwmsbotWVVoZRLoOsHtrr4gAh4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9Lx+H7KIepN9XFoJsoPgb9OKjY2DNFotscsbirI7m8=;
 b=Pru5eSTx+gRDSAg1Jga2XbSBvmgD3g0T8lpnzBMbwdd9P3RqJSAtUvMn6TFAm7/x4HwGPe6wdYV61Fe8TqWzJb713+WhLET5W1L/zWB6vVAqd2q2bBuXrcVHHcTHhrQlAQu54ov5nxmeqQXoS14NNLyonPA+26oKY+v+JVUtxDgHlN2Od01lbypWwhKSmMM9nYdI5KvzStWusgeJaYrqDN/UkdIXfn4eDfZY4Ev5iTGb9jTtqxfPgjIKJoncUeZSW4HJcQ8NhX7vAzcmndFMvI67IvFIydudVKaomE+xovCgVcTiAsohywR9u98u82jwvBGxwpWhMeYruldFw5gqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Lx+H7KIepN9XFoJsoPgb9OKjY2DNFotscsbirI7m8=;
 b=pbVLXGatPP8KKdoZ566YMusOirnafaxuIAYTyYmjsCzdDRUWHUFiF5gFSgWDbdI2Z/Y/XZtt8CEYgN3wRYYemlx73M99sbR7rMZ27oeGGV/2tYJokPqeoLcKbnXNIZ+TR+fz4+I2eDRqzn54CGqtsJmGKvajcnYDLm7Kn9w6K0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.12; Mon, 31 Aug 2026 23:51:55 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 23:51:55 +0000
Message-ID: <50c2dd39-6e71-4877-84ba-6acabd0df1f4@amd.com>
Date: Mon, 31 Aug 2026 18:51:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI/PM: Run bridge power up actions as part of
 restore phase
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-3-mario.limonciello@amd.com>
 <20260831220657.DB8C31F000E9@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260831220657.DB8C31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: d46768d9-325a-4b29-6719-08df07bad633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|3023799007|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uAWlXtgjjjdOEsYfZngo1BW25I2RQYw/j7ZyPI9nZYOT16AWdEnBOTkEb4LjDBYPEdHREQ9OcU3/cxZ0c9yeRSujEMqXcP8a/V0wKB4uCwf02ImdyGaAv5zSsnvTq/rmD5vDuXeR1oFHZYO7kp8isXXfZOyeaUYH1e4BLulHyYaC9EUtUq5as3Ly/XBDTuyHmBNnMOEjXI/mcftHHMXU7tJbRYDm0m7fQbeMzfa24bo5dreqMxMXpQEvGuMboPkeW0GSrfWhynzVs4DGH/54zCmRyH6DIcmwRkuK5NCP1cTRBagKg1NZbfGAmebCLD6tH3f8lvML8RdZnaUAZ6muZPJXo2eQM8Ng7czTAW+2ihw9wVKl9jEM8f0Lv3OSYZJ7gsuqgnHUt9U3hxkBcXUEOKacdkVYykfiEijSb69RMWzSiqpJDmwGc6unNHGq/oAFzeluYe4VtCXVM1cdk2O+j6wpoldGdYukeV5FRZgbTpaXvo/R6X8kYcdh7sORq3bb8QsWoYI6/D99cDBLDCFtHO6DVi0QQ/4NKDtrWiN+LT13R0M2CoO1y5B9gPqZ1OHuXIuW+Wlve2SkURdFGD7cW4nI26OPUpgRnybHPEKjZl98xUPKF63mBfEXqeT4kcGPSxu59NYj+8XHu6tQ5I8dQY1s63WNbhLxV7kA8bk2EZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUlxcHN3MkNZK0hQNk1LQldHOWZIZEZLZm1sRkREd2FlOWlMK2FEQm8rS0Jw?=
 =?utf-8?B?T2laZDQyWTlZbzZIMFROK2ZtYWNPNnN3UjhudUhIeFgxcnU0UVR2cHk5Z1FL?=
 =?utf-8?B?WmxnVlNDRnUva2pJM2JuV3Zsd3JxTHNFdEJza3VPdHJ0T1JYYmo3QnVKdk9Z?=
 =?utf-8?B?SkJiakkzenRmd2praUFIRnIwSlZNMkRza2RrSzhkUU56UXJSa1pOSWI1S2NL?=
 =?utf-8?B?TzFHbEJ4bjU1Yno3YzVNN0ZqbUFXNkFXME5LRGhOTElJUXl6cE9ldDRXUE9K?=
 =?utf-8?B?ZUl5N1NVTVlqVnFHeVZ4ZEd2TFpVUTlCZXhlNW1CQUdGN0wxc1FwcDdsVjlj?=
 =?utf-8?B?N1p5aVVWM2IvUkhJcnBaeUxCWnZybVNQNUgvODRIcU1YaXBHT1puOFd4eEkw?=
 =?utf-8?B?bmlqVjdteGRyWklzbHIwNlB5ZVVLL3RNclF2a0V0bDI4dXRQOFpEYnY1eks1?=
 =?utf-8?B?L0dTRWoveUkwdzNpZStLazVMbmpiVkQ2dU1SVVU5bE16ZjVsT2U1YUUrSFNr?=
 =?utf-8?B?azk5d29xWms3NUk3TXM0TlJGc2MyL1N2Vm5YMWVVeVVoRjNEMWVTdkZoTWJC?=
 =?utf-8?B?MTB0SGQxeVo0U3BPczM5aVlyZDcwajVObGRRc0pmblVSa1VTREo1aFFlSCtN?=
 =?utf-8?B?MkJsWVFQMEpmbVViUXBPNnZqZUhXVHlha2NaV3M5Y05teDcxV2cweFFKTnVC?=
 =?utf-8?B?RVhwYkpCS2JVbjBLZ2N2ZDVZWHVzdmo4L2tqR0VXbkxXUGZ6V09uRUJFWkM5?=
 =?utf-8?B?REhHMUw0aE9jc1J3ZkFORW5aWkN1SWxsRkVhWGtSTks5V1FRZkhzZGRxbGNp?=
 =?utf-8?B?cmV3Rnl2TGtQVFg1THZ4K2RiN0hCVlc2MGlQcHJncWlsd2VFN3E5TlA0Umg2?=
 =?utf-8?B?OUxiMkZxUWNSY1BlVDlYOC90S0xzYnRySVBwS3VqWjVSR1F0TG5UVXJLY2xm?=
 =?utf-8?B?NHRiZlNGTWtsVllBbmRCZysrY1ZxTUR2RW1qNjFnblV3KzhkbEZiUEp4M2hS?=
 =?utf-8?B?cmNPQUUyRWtSOE5YMWFvL1NzU1cvNlREQTc2RFc0V3BJUmt3Vlp6M2hwUjkw?=
 =?utf-8?B?ZysxdEgwMUFRTWVNKzJaQm45UklxL09lRjlwM3JpeXZCSGtjOGd1VE5WU2ZB?=
 =?utf-8?B?SmhjTjlVbi8yV0w4elV0ZXpLQUR1ZEFUYkg1ZXhDZy9jUEp4am4vOUV0VDdn?=
 =?utf-8?B?Z3doNjViVFU0anJOVVJiZlNuRVV1S0pwVk41ZFVuY1hmbThjN2V1RHd0bG9R?=
 =?utf-8?B?UXd6dEwvUk5KL3Y0TFdGd29GdXNGREdFVHZaYWZZeS9KdVd3aDRHeENUSDlW?=
 =?utf-8?B?WCtvSXRiZXd6TkRmY1J1cEFuNFZ1c2dnZVRNY1NvUkE4V3lYRWF0K0xEYWtK?=
 =?utf-8?B?TUxCL2hWcWVoOXlrbXVHbXZJM3YzcHpFSGhEUWZhMDdjUldWYUk4OWNmNldy?=
 =?utf-8?B?aEt2KzRORmlPbWlPMS9zM3V4akF1a0FkZ3RZblhYd1czanhwTXJmaFhFeE5W?=
 =?utf-8?B?d3AxWUdZYVpYNjlSK012YWRkb1o4c2IxTGU0aUZYcDJ6dVBoWEpRWElUNGlj?=
 =?utf-8?B?ZVp4aGlpSXRWQ1llM3FWNTVRbEFwZGhRSEFVZGtmdTN3eXVJc3YzNy85ZG1G?=
 =?utf-8?B?a1pTVDB6N0pZaDBtQ2JVT1plazlxWDFuM3U5YXYxQjlOUnpKb1RUdndrcEF2?=
 =?utf-8?B?aEJ5a1YyQ3lJV2E2VkwrUFd5eFo5dmhtWXh6MExHTUJzdTNZNU1uQkpVdVZ6?=
 =?utf-8?B?NmJtWFZmT3RMT1lWWUt0aFdUWjVYMmYzMmk4dEMvd3FyU2hRMm5hM282NUVu?=
 =?utf-8?B?NVBxVU9mcXMza2p3VTlKenpHRjc1UWEydzFMRG9RSE5tSkJ4MlZhWjZxekdP?=
 =?utf-8?B?SlowZVRTUVJXOGZmcEZUQXFsUlV1QlpFc3d2YWg3S1pjUVJuazRxdEx1aEZ3?=
 =?utf-8?B?dFFvelV5Sy8rZ1U3SlRjbllnMmZKbG9UYUJ4WmFiOFE1QUVSVDBoMFZPL2sr?=
 =?utf-8?B?RzhvWC9TYnhJTE5GWklVYkp5aU94TDFmSEcxQmdLcXdVVS91KzFxbU41V1RL?=
 =?utf-8?B?blV1UGg3aUtPZEtpQVp6TytjS2RLem5RTERvUDZiMlpvREp0d3FYKzBzM3ZL?=
 =?utf-8?B?eFZtY1Qvb3FXOE9tRGxwQTNyMjU5Q2hDVnJYa1JJMGZtYjVkUzlmZjFQSy8x?=
 =?utf-8?B?UnIxUko3Q1ZpYzlRZlBvdGhBWiszRm1TclRMaVkzc1J5RzdtZGE1WVhwN1hL?=
 =?utf-8?B?OFBuMVN5SkVnQURpLzRmY3dVbWx3ZmlRb3dkMEEwYTI4UXB4R1AwS1gxMk42?=
 =?utf-8?B?MVpvY1J5bXVJdkdmY2xTUVIvYWp5TmZkdFZTa3R2d1Q4UHE4VXdiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46768d9-325a-4b29-6719-08df07bad633
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 23:51:55.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMwCqdRAH/GC7LtLtreM2wcoi19OSiDQHXkpzH9IF500Ga1Bp1iW2/MtU+KSeq8x/qEEbFjErkCiMUi2ieDmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

Based on the feedback (the robot was correct!) I'm going to drop this 
patch from the series and adjust patch 3/3 slightly.

On 8/31/26 17:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The condition `prev_state == PCI_D3cold` in `pci_pm_restore_noirq()` will always evaluate to false for devices active before hibernation, causing bridge power-up actions to be incorrectly skipped.
> - [High] `skip_bus_pm` evaluates to stale or uninitialized values during hibernation restore.
> --
> 
> commit bf2b47aa05ce71a85384cc813156b2a5ff4653d5
> Author: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> PCI/PM: Run bridge power up actions as part of restore phase
> 
> This commit adds bridge power up actions to the hibernate restore phase in
> pci_pm_restore_noirq(), gated by the previous power state and whether bus PM
> was skipped. This aims to ensure mandatory link training delays are observed
> before downstream devices are accessed, mirroring the S3 suspend path.
> 
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index e3d352c7b31d4..d15b3eb55ec53 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -1297,10 +1297,15 @@ static int pci_pm_restore_noirq(struct device *dev)
>>   {
>>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>>   	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +	pci_power_t prev_state = pci_dev->current_state;
> 
> [Severity: High]
> Will prev_state always evaluate to PCI_UNKNOWN instead of PCI_D3cold?
> 
> During hibernation, the memory snapshot is taken in the FREEZE phase.
> pci_pm_freeze() resumes devices to PCI_D0, and pci_pm_freeze_noirq()
> subsequently sets their current_state to PCI_UNKNOWN.
> 
> This PCI_UNKNOWN state is what gets saved in the memory snapshot and restored
> here. Although devices are put in PCI_D3cold during the POWEROFF phase, this
> occurs after the snapshot has already been captured and written to disk.
> 

The robot looks right here.

>> +	bool skip_bus_pm = pci_dev->skip_bus_pm;
> 
> [Severity: High]
> Could pci_dev->skip_bus_pm evaluate to a stale or uninitialized value here?
> 
> The hibernation snapshot is captured during the FREEZE phase, where neither
> pci_pm_freeze() nor pci_pm_freeze_noirq() initialize or update skip_bus_pm.
> The snapshot merely captures whatever stale value it had, such as from a prior
> S3 suspend.
> 
> While skip_bus_pm is initialized in pci_pm_poweroff(), that function runs in
> the POWEROFF phase after the hibernation snapshot has been completed, so the
> initialized value is never saved to the image.


The robot looks right here too.

> 
>>   
>>   	pci_pm_default_resume_early(pci_dev);
>>   	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>>   
>> +	if (!skip_bus_pm && prev_state == PCI_D3cold)
>> +		pci_pm_bridge_power_up_actions(pci_dev);
> 
> [Severity: High]
> Since prev_state is PCI_UNKNOWN and skip_bus_pm may be stale, is it possible
> that this condition will always fail and cause the required bridge retraining
> to be skipped?
> 
> This could lead to accessing downstream devices before the bridge link is
> retrained, resulting in PCIe errors or system crashes on hibernation resume.
> 
>> +
>>   	if (pci_has_legacy_pm_support(pci_dev))
>>   		return 0;
>>
> 

