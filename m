Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B53BBFC2
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536994; cv=fail; b=YfP1WRFXNJcOfP3oK1F3eKtZYLjkiEfsodi53H9fVfWXQB0+9HCAHtQrsnCyPhgyicsyQia2Dx/zkNAN+QpOq7f7hk4vsLYotZziaTIK5Os0iVP8Jm7dH9d8HH8kwdLx8/qfF5fKQPD+3xEtxOJziVIu0P/fpHQFkZeGQxbKRJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536994; c=relaxed/simple;
	bh=LUCO8urux1EZHHB3jLnRj3RJG4EQxaay/20kk24eS98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XpoSNbwp3RuptBRJVwALh1Ma/kCchiuUJKZRJa4HWvkOIPdEFScTOtbO2NyIZ7iFUa2NGWVQeXiKCjCihRl3TAgzbIRmRBe6HkYrYWFG3yX8DPqJwgaUwlI0aYl4e37JKhjfaqIpsMAdL+Wwuh1icuQLVjF7HHYDD2Qpc1AlJUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yiwdKFFS; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yiwdKFFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQtS0vLiS4yJr6D7/6qZo/sSqqcYpmVGV7AWwfTzdJh6kxiL4CIeYXaSLt9vUhZZvBgQI2bf3lNhrPg7aUxh3TWigBqc42hWCPBZ+R1K0BeuoDfnXG2ts5ZRaoxGQh1uuxjTD3XVGAUIB3NBgZr2FJmrz3tVQlSulwI9zU9jk2NHI/Bam1PsJeX7Bbo+VYax0LZreY6RIOjpeLODUGo6AUer/F+2f2/BkhEE0o+ZC7HGG2cPL1FrRiT5k+ZyAZDlBrgBguwU75PHHoSTjYAsR2iwPknJ8I26V+EtHZvJXNjp/bkP3LJmaNZGnJfyher5ve0zKCZxsQWmyK04zvZJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPVfzRsgoeekKfWx/GszvkFF9B06egbHGJtkVqbQ95M=;
 b=k7f6zjNaMazl91RwEh8Mmdf2OEwTDURBZb2fXwUN0s++V9KcEvV/TQVrhggwDu5X30HPxZlernPmJyisXvmnyvdAx/1JBaK31eeNp/xSfxWQU3KovNj2nNEYWZEgfP1Mq0wilTiEsPcfzvi9VwS4+NzvIqJbOjblZmnTqj5ruYNBaOWk3GA3em5MSsFQFo+R05e7S+kgHeu2tP8ff9+I1nbFZcdtAFqp9uCrG9f2QcYjcpB44F9dxAJzD6408We5TUCM840WmVbeEyB3WFolciwBDPUmkhFi7LIfmgJgZioHYM3xtx8XumLYl6i306QyfLQYq1Xi/aRdAcrhxnpH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPVfzRsgoeekKfWx/GszvkFF9B06egbHGJtkVqbQ95M=;
 b=yiwdKFFSZoFpHkNH3N9baQhccP3qldwU+gsK+0THpwTTkpVnNgJSQdQlZ51YAE5DXEkd/1Ul01x5BSnlcxGwBgIjxiJR/cNCcnRgjc147LzaCANcm3NpwjiYN5ttR42lvhmdQsroUqO69QgplGAfswV3lU9EuXUUk+Wm/qed24w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 05:36:30 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 05:36:29 +0000
Message-ID: <269ba359-9246-44ba-b68b-68334db9ad4a@amd.com>
Date: Wed, 16 Sep 2026 00:36:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: Put PCIe bridges with downstream devices into
 D3 at hibernate
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260916051034.180226-1-mario.limonciello@amd.com>
 <20260916051034.180226-3-mario.limonciello@amd.com>
 <20260916052319.EC3E81F000FF@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260916052319.EC3E81F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8718af9a-f61f-4f07-2f06-08df13b47589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pKBZpnplNaNpiJoO9tqSwyOIb8XSgkR1TtAHJCcWD/RJOjGGbu1L2Qm7bCXQwmyfrlTObz3PyYhwGmm1jXXsbfNIm5kWln6p6+Wts1XDgkSUjvP+SYPmhTqRAZHhEoGug9VEtZ9aJJ8QX6iaUhq2zcguYZnd8zoNyB69g1f5uwKOopYNC0/+emiVShB/2e3cKXmGEqkDBPxjaOBRgtH6cj4JPG+axk7Kt8DhVFbnXOxySIM7663wyLGUtbrC7tpN+oMA+uZS6NTLBtxPYzdoLMmIPEOCTnHotoYJHMQUW//UWH9ujKIMVwfR5EisW+PJVdHmDzaAmw0Hlk4CJityuuRTKcLdcglPAcf7LRN2V3yU3U9cIHZ6JnblyiwFNC48OIvuemXku2mVvkuq4S5BxzDnTV/c2aWCTQS8fqqh/qO0g0tphBx8iw/FczVqEyhjpPKQy2RkZfa5u8cX3IerP3RmuBg3JNuAsakdESFbrxCmfvFH3BWvlfhNswamHoy4JCmJQ77uAPtqb9+st+8Q1DHuGvAh2WrGBSa2881DbNghVyp8EhS7r3No8S8eZ1VEyCsN/IAA0rzwmUwKzEMLQRZjKJqDN1axdYtlpAtpvhPLJPp+YWH2Q+N8To3a1ymn5r41g3ljQ1BsTV+KZrzrCF2S0/7dKOtzIaa45T4TLhg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS80YXRxNEt3c1EydjZ3Qll5aDdJZ2xrRGcreTVybHM0NllKWTFkTE5yTGVs?=
 =?utf-8?B?NzlSYnprWmpnK3BrWjFxNENhREtzMFJxRDE5aUdOcndUREtLR2Q5M1lOaTZ4?=
 =?utf-8?B?SnM2cVBvOEt3Rmh2WVBHRDhVMkhVUlpWSUNWV3VTVTg1ZThCVy9IYVB2eDJG?=
 =?utf-8?B?N1dvdXNNWFZsT0M4MGxXbm5nQzBzaENBKzNBL0V5c0pxcER5YWVreEVCNkNy?=
 =?utf-8?B?VExNNnV5cDU5Y2FoTHdtNGtkUjVzSllVQXpSSkUrcW4vZW83L1A3cklzOEFI?=
 =?utf-8?B?aUkvWWNmWUMwa0QybDNoOTJxZnE2cXRxTjdGU0c1cjZjQVZQUFFMU1V3U3FN?=
 =?utf-8?B?MjFiY040akV0eUFlYlVYWGQ2aGp4cVczakxoampBWkgwbDdsUkg4aklsQzZn?=
 =?utf-8?B?QjI4R3lxakdkeURRa3VkRVV2UmVSZ0JCMU82NHVGV3F4RjlFYnFGNG94ODEr?=
 =?utf-8?B?ZzFDYXVDWUlEalBJRE9CckM4cjhZNkppS0N1U1Rlc1ZPVW85TVFKcnlybUpE?=
 =?utf-8?B?OHBPMmVZaHE1Q3FvN2o3LzFYbU0rZTBucUxqS2ZLcDNzcFZHdlpqM2g4YW5i?=
 =?utf-8?B?cUg1cmZUcjZsVWxIVFRNUjcxTmpvcVVia1U3U0FVeXlCRzBrL3ZqZWlTS1c5?=
 =?utf-8?B?SnhXdXlkOVJ0QU5YdStBQVFiM2hCNTNiVHlmZXRyTzlLd3N4M0R4Z0h2S0pu?=
 =?utf-8?B?dlFiODNUMG1qMDUwcG1rQkhBUlRuRzFEclAvL3ZZL1FtdHVHb0ZHajlFOUZq?=
 =?utf-8?B?czhGb01Fc2dDeHJQcGxneHN0Nndrb25qQkNMRnJqMm5PS0FweTR2MXlnejYw?=
 =?utf-8?B?eXlhRi9HbndycGRseXRBbE5NMFJvZTdEeTZCR1FqZ1N0TTBJTEhGdTYyb2s3?=
 =?utf-8?B?MTRKaHU2d1N0NFNlQ0ZiNG1zUTJxdUoxSmFIQzlUZ2IrMnB6UXNQR0tIVXJI?=
 =?utf-8?B?TFZBU0ZBbitReWYxWVU5RzU0U2t4bXBrVHVwSXpFdGJPQmI2V250S0Jtcmpl?=
 =?utf-8?B?ZjZPdjNJUnMvVFBieG13bnpCUHBaeVk0dEUveEJSMGg2QjFnTXZ6d2l2bXJO?=
 =?utf-8?B?STRQV1MxMGRGVFRUdGN6OEhidVI4TUwrMGYvc1U2QzhDT1lJM3AzdXZNLzVV?=
 =?utf-8?B?OFExYTM4cTBFQ0hyc08vSEdBYmcwSW5pSUZsdjZNdE9CNEJZYndQTzdFdmFy?=
 =?utf-8?B?QXJxQ3BOTVBhRVlQV3EzWFhPUFdqQ3dvZ3htZzJpTkNPNHd4UnZ1WURSZmNK?=
 =?utf-8?B?aWxYRGdKU1g1MXVqK2Erb1pOTzhTM3hFSE56d05hay9wdEt3WWx5aGtsNmN4?=
 =?utf-8?B?cGZuSWFqOEdaWGQra3Q2M3YwWVFrenYyQXJLQnFiYkdtYWpTT1l3cHo4dzB0?=
 =?utf-8?B?ZUpqMDlscUFyN1lyYnJjbTBVc2FjRUdiM2RuNThONUFKRXlwQmZrUzNzaXdi?=
 =?utf-8?B?WW9lRnNWTEZ2YlNuemI1OWxUODFVRmRESmROcktVSGdnSUFrUUp1ckl6RndU?=
 =?utf-8?B?ZVM1alp1WndpRUl6cmtOek5YWktWSEpJLzNKN2ZXRWVxWUNYSXVsOGtlV2p0?=
 =?utf-8?B?dWtWZW56YnVSbXJIWTdZVE5lT3VLZlJpMXJ0dHloNENtcDF4blRrNTF5d1g2?=
 =?utf-8?B?d3dXWGVYK2JvbmtEajhqbHJoa09JbHB6V2pGYzBXMnN2d08xUW5hZjhoMXlj?=
 =?utf-8?B?QzZRSmdFMG1XL0FiQTR1bW1WRTNXNFFScG0rdXJOaDdWaWh6QTA3eGd6a25R?=
 =?utf-8?B?VXEwM2l1YW1GVUd6M09PTG5QVlBOK24rQnh5K1RyWi9oVERvM1NnNmxoQ0Yx?=
 =?utf-8?B?SjZjb3NQN3dTa1ViL0VhRmFJOERIYlIyT1JZUEdXUHNEMldMRllXRXZPWE1i?=
 =?utf-8?B?aDV6OUt5RVdDWnJ2QVpkWXFrZGdqM29sdStvSGFQc2tPRzNOajczem5SOFZJ?=
 =?utf-8?B?MzQ0cnp2TkxPbFI1L0xXWW8vRkMyT2RFQ2lDVXl6MDdJd1VYbVJWZ3BPbW1Y?=
 =?utf-8?B?UGNOLzc0RUtqS0FwZzBJaDNRMldZdHBCVUJoUVp0dFp3WGlxb0hDdXYvdjJR?=
 =?utf-8?B?YTNDNEIraFlhZUpJU2ZrZU45WVhHcTJXeWxiTmpmZGJwdXFiOEVmblVZZDhq?=
 =?utf-8?B?ZkRRVU4zaHo3bGRYdCtZQnZ2TGR3MVdob0VXOVIxb0RGRjZKS2FsTGNpRnZx?=
 =?utf-8?B?YkxoaVNDOXY5cDFDSGdrdE95T2xFdG9BcStTaFhIcEUwS2FWMkJ5eHVPZk9w?=
 =?utf-8?B?aC9jNXA0b015VkJoTXFDWEhCWldKV0ZNVFk4dld5MXB6dHptNFZvV2JNbkdz?=
 =?utf-8?B?YmdRYWduKzkwZ0xZUnhRNkVBQ2M5VmM1WVhIYjZuVU0yNUlmUm5EQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8718af9a-f61f-4f07-2f06-08df13b47589
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:36:29.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YqoEPxZSuIoc7MsryiB6VGuwm8tkPkKodz/PCBwnGZdkLfoVa/gBGgGMmhgqb8nWqs7nJGO5OGJ6mp2CWR4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479



On 9/16/26 00:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci: config space corruption on hibernation abort due to missing D3 guard
> --
> 
> commit 99f9dafa720163cc3dfac6ce20da883f888fb896
> Author: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> 
> During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
> downstream devices into a low-power state. This commit aligns the
> hibernate poweroff_noirq flow to use pci_pm_suspend_noirq_common(),
> ensuring bridges with active children are also put into D3.
> 
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
> [ ... ]
>> @@ -1280,8 +1283,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>>   			return error;
>>   	}
>>   
>> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>> -		pci_prepare_to_sleep(pci_dev);
>> +	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
> 
> [Severity: High]
> Could this lead to configuration space corruption if a hibernation aborts?
> 
> If a driver's poweroff_noirq callback puts the device into a low-power
> state (like D3) but fails to save its state, calling
> pci_pm_suspend_noirq_common() here will unconditionally invoke
> pci_save_state().

That seems wrong.  It's gated by if (!pci_dev->state_saved) in the helper..

> 
> Because the device is already in D3, reading the configuration registers
> in pci_save_state() will populate saved_config_space with 0xFFFFFFFF
> garbage.

I think this is true; but only for D3cold, not D3hot.

I'm not sure how exactly this state could actually happen.

> 
> If the hibernation process subsequently aborts, the PM core executes
> pci_pm_restore_noirq(), which will blindly write this 0xFFFFFFFF garbage
> back to the device's configuration registers (BARs, command registers, etc).
> This will likely cause a system crash upon subsequent memory-mapped I/O
> access.
> 

I guess this is reasonable (pci_pm_default_resume_early() -> 
pci_restore_state()).

I suppose I didn't really consider a poweroff abort, which is what would 
be relevant in this case.

> Does pci_pm_poweroff_noirq() need the same explicit D3 safety guard that
> the S3 suspend_noirq path uses to prevent reading config space from a
> powered-down device?
> 

This does sound reasonable at least for the 3rd case.  I'm still not 
sold on the other two that Sashiko called out.
