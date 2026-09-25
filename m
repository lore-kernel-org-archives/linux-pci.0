Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61430B529;
	Fri, 25 Sep 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366509; cv=fail; b=kpk2xFL227EntIxlVElZk+uYn5JftfbvCnxuSh/3H3qWbY0paiiZW9++BiAWlj9SQXFgSEZF401EWLoTjkK5juH0heAybN4c2ETUkTnjM4gbx7thT2ZgO8aGO++CPM2bSiVGv6QkwsOXCLtwicZmsFvE78HXi0kXc23JPTQu4Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366509; c=relaxed/simple;
	bh=y8cLVRqYDOUmpy87HjPtZzI5fu7dptposrUiHWNw574=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qU9Fq5gTAdii5++hGwC286/yMac7UwvM5K6Xj7w2/9uQb9DJHIWZxmASmj4oEadJj9X7LTo0+a+xPjTohU1iDlfAqry5rY9FT/OErzgN0As5zGGy+qy4H4dyexNYJbybRrzGirntCxWqF5hch9mYJlrcTbbiWAf/k8rm8zJW9XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kmxH3X8J; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kmxH3X8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueBNd0TYEPJtN/sjqGng8dBSopelXdxECOfrqRW0ZACNpvwFjsX0unukIja1AE7LBH6JFadrwYhzZGDnVjXmkSk/rvD5TspGCQKiNSVr9H6lT8fPFwoV7++ZDcbPd6NdLgNhTmMyO5IN8gw6E2AOcN77aD4xh57RFQPkgjXe9uQhHh+BDUUf6S/zlbShFUB1oMITOC127jmQN30uGD7bi9pZcPRSYKPPc2QO8bIzpWuo4OarvcLRXSzVzPCm0aZ2So+wkNtT7lWEin+N0vFfVcX5o6U20AfDN+BPs1P/QITNAvCRUbCSOLL9qZXXrG/RlelcJgbLF4g/LS+f0Urn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtDDuqzTcLaREbTlarVToWHkUb1Hd4FXh4CHBQ6p/ls=;
 b=lBA8xhuW1HASh8TFhzzU4zx3/8f+1gqrmllq2/f6ZzJpyZRmpS30qbwB7aqDNFSc+BBlfMJD7PFuzLUg0JqXxvHCMrNufjkoEdfKecbcSeC1ufIKzHY4eFJPZcTc3eFjN5SJS1KLXV3Ur3X7aQaPkDiPo4Qi6O+j9ygQofOLHiJ8SVmoKLSbZpsVxI1+6Gdxp0GYn5vl7Sl/lZ7BK3oKbwe7h3+NrEy4d6MllP73BHch47FMmOueJz9AL/znqH5de82ciMWVhZKD0aIi50wgcNx2WVFMcsuL+2Fival4G4BkU/miLDy6xNEN28VszWHFpOU4ztc+3Sf9seeKp3ELvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtDDuqzTcLaREbTlarVToWHkUb1Hd4FXh4CHBQ6p/ls=;
 b=kmxH3X8JpPr4Jz6Xo6TynAIP5AU7+Q7YL68tuDHj2JhNWR6U4y7ez8Bc+AarBrlLqILaKNs/f1iL4n1NYN24xVqFNQPTlhWBxCeOHfzmvIad8hl6ZMIEW7mlC5NRHEhK6b/dMTaqxTXbD+EFsNbA+t6410Euz7yHwjd6wTvWugU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB999088.namprd12.prod.outlook.com (2603:10b6:510:38d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:01:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:01:44 +0000
Message-ID: <3cbc91d7-3833-48e4-b21a-ed0f2b1370a7@amd.com>
Date: Fri, 25 Sep 2026 15:01:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, Arthur Husband <artmoty@gmail.com>,
 Roland Waltersson <roland.waltersson@netinsight.net>, snoep <snoepke@live.nl>
References: <20260925194208.GA2072993@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260925194208.GA2072993@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DSSP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:3d3::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB999088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bad0217-a350-4802-b343-08df1b3fd2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DOFYfbLRXb534gwjsAe8yvVbl8SHCfcW86xFa5MCWqz0vIoFP9RoLpQzAMA12SY+T4Xxz0gnCAglZiIuiSvZOouiJFr1koTRYdOoZjksvIuVJipgmdmwHkEmb9kovMl4wy+QZ8PuSOwRFSg/iyh/RL8ibEgdSdrlXY8ckG+PsAKWQeCApvgmk1PFutGPGJeTaQ4rbX5QFk47qbdAZuKj21SSM8as9cEou1urK3t2IapPHctPthGJgp50Z1GutjbmrAVApWsA9DF4ojp5asgdrBfXO7XIxipkOFNzY+OEIpvjXxHjH7U7+JG9OupKM+3Xb+BITJKSrjNo6hyebdO0mDSMO/IOyDuqvdMKjF+HrxaVhhvA28vkXn4/WkwAe9i0uEu+LffpmsxTVBbB2XgR+fnck20wZA/WTGIGaOHaLuXVIOkm1dpBn3hDQ2g4uwW3FVvV+GSVt0LIOGxT3vgYDiFMZVMLSmn24QR+RIg2YuM5fC+9NFtL0I46MHYgjrNv0dAlvUepfKt30P+sFbxDeh19+lVl6v2zScjmWVCnaYPe9a608Zny+CUNuq5HQvYNzcDgsIQFdi6NtYbFzx7VbqphydNtIUHMAppAjMuaGyU0UcI0LZ4saXeaLFP6xMsx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllIU0RFMHg1T1VSOTZYZzlpSVFZUURDUGtkcGJzRDludFcycmlSZGZ2Ujhk?=
 =?utf-8?B?dkk1QVNRd2djaWUyZVlGYkMxYS8rRnMwejFWZ0Nkc1FPQTNqWU9DVVFxdTFz?=
 =?utf-8?B?SHFDa2hESVo3UmFMQ3krQ1pMKzV2Z3JaUVpRcnRrUUk0SGVRdU1lNGxBRzdG?=
 =?utf-8?B?N2hZMVArOWZPQTNuU3h6RDcvY1gvRFRsQzl2RnRiVklqUkRyamFCRk1zSHEr?=
 =?utf-8?B?dHNrZWVrY2JaTDN0WlZQWTNNRlRLRnYwbTBFVFpZbzZOdmcxcHVhWEg4aXU3?=
 =?utf-8?B?NVAyMHQwc242NEN5NUdFRTlvUldCTGZzaTJWYWZRVGJXQjNUVjFEUEl2eTJU?=
 =?utf-8?B?RlBaUkdaNzBTYi9Uc2dKc3N0N2lTZXp3K3M3YlNMZFRSeFFFY2FnM1l5NS9k?=
 =?utf-8?B?eU9rTjFvQUhEZ2VkMmliZkEweXRNcUZ1aTM5VlJoQUVJTjZpMit0RGRkaWN6?=
 =?utf-8?B?TStCUCtFWXhlMzFxMkZML1lNR1V0dG1Gc0UxV0l6MXVVWWpUcFNXSjJpL1p1?=
 =?utf-8?B?Qk1XOVNLRmlRdXl3c3libXBwazF6UEx6WWUxeC8vaGVkdlorQ0h3N2lWRkhC?=
 =?utf-8?B?VnZPSEVyVzM0enphblpBRFFBU1ZZVmZTR2NTYXM1L2ZrOXdyY3U2NFNid29I?=
 =?utf-8?B?bEF3dVZITlRlL1BjTjE0dHpINGRHYlFwRFN1b0IxMnpBUnVYMm9hbWJ1eDU5?=
 =?utf-8?B?cldualdzL2g4VU13a1A0WFdDVFJRa1JxUjBBNmFEQzFyNW5oc1Bobk9ycG0v?=
 =?utf-8?B?YkhaUUhLWHZaRFFJZW5SK0NQeWRBQUJ2OWZ4dXhMc0kva1VWVXBSaThmdXBO?=
 =?utf-8?B?VTBrRDQ5aElnVE96VGpmZXd4YXd6TFhHMHVjcXA5anlxb3ZHdG42UnhSQURy?=
 =?utf-8?B?WWgyNUt3Umx2MlUxL0EveXlQVVdSbytKRDNpWVRWWEoxWnZscld1RW1nc0tx?=
 =?utf-8?B?MnJwNm5nYk9Ua0Y2ckFyZ05mTjNtS2pNV3lSNVprRUhNOUhqZithVFRKOUhs?=
 =?utf-8?B?Vk5wSmJHaVp6ZXRCMEpLVktrZ1ZLS0U3V080MnkyNGozclBucHV4OTBKa1VM?=
 =?utf-8?B?SkJYNmI2YUFKKzZrc3B3SjQ1cHQ2OWloR2R4L3h5R3c1NE1ZM1FNT2QwQW14?=
 =?utf-8?B?TGhZaEVBTXNadHFOT0k3MGZGUGhsc092YUc5WDNoS1c5SjVmczJFT3dXa1g0?=
 =?utf-8?B?Q1QvamVFajlkQ0pIdzRpOEwzSTEybjhPU0tvTWlvcGRGR2FzeGpZditUMmNE?=
 =?utf-8?B?aU5GekdTeUh4TUg4V1BZMTV3NDBkcENQVjA1S1dHMFRENEFieTlQbUducUw2?=
 =?utf-8?B?M245Y05URnVzS1N2cmJ1ME9rMFI1amI4WWNvc2VIc3V2TzRDTzRhaVMrcGtz?=
 =?utf-8?B?RW9XN2dpL01zZE8vUElvRG85dFhyc1MvTlo5elRGekJkOW5BVU1aaklsU1l4?=
 =?utf-8?B?dTR6dm1ZY2tSeGg0VENoZ2NvYzhWQjRST3Fhc2JSVk9jU0FKTGhBTmpPMldF?=
 =?utf-8?B?amU3WkQveXd2WGtTY3A0UnMyaGszYkx5WjVuMmJXNDZhWmNnSE5VSzNLTDdG?=
 =?utf-8?B?WUgvUUhRL3Z5eWtuaDEzZ1RKaUdqbzFHMWY5UG9Od0xXWjg4Y2l3TnlESkpa?=
 =?utf-8?B?Mm1XWGtvMWFPbE1zMHc0ZnF4QlpaaFRUVmhma2xlb05KWmFHTEZPTElJS1FH?=
 =?utf-8?B?ZDlqd3orRVBWN3dUN1RkM3htSUVaQXAreWxNbnlGSTdPZCtwOXI5SlJUUmc2?=
 =?utf-8?B?S3JMQjRxZnpwWngxVEVpLzNkK0pCd25yL2x0WUZySGhmaDEyV1FZekV1ODk2?=
 =?utf-8?B?Ym9NMlRQU1lHaFB3c3BteDQ0RHVNV1lrSGorZndUaFJjQmM5dkNydkgzZEsw?=
 =?utf-8?B?WkkxK05qODF6MXVnTWJlN3QzMHhsWERUdUsySFJPYm13QUJFL3hYWERQU29l?=
 =?utf-8?B?Z0pjd1lpc3QxM1N0eXZ2R0VXUFhOQWRlUkZsSHFOUjRyVmhTNVJyYk1DbUVj?=
 =?utf-8?B?MkwyYXBuNFVPRDJwcFYrZm13TGQrRklGQ1NOQU9UTkJORHpxSGxTaWEzSkxW?=
 =?utf-8?B?YjhVdXpQVjM3ZjhhcUNrU2JudmlyTWhNeDBTdG94VHVobm1NZW9XLzE1MTNC?=
 =?utf-8?B?VGFNdW5DekdhdktCSFBRQ29zWFVtK3VXeDdnNlM0Tm9rOGV3QzRPS2Y4R0w4?=
 =?utf-8?B?bHQyc3B6cC93WHZNUVY3a05wYW5kQ1J6MVBMajZoUm5rN01YdmJFMm5TYytw?=
 =?utf-8?B?alFTUlFKcW04MTIwZk12TjNld1pWTndGbUJ5aTBDQ3RIMkx3d3FqaWpvZ2xy?=
 =?utf-8?Q?dh1kemZviNGF8nSm/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bad0217-a350-4802-b343-08df1b3fd2be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:01:44.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwsyDkjjaHPkAhCBUobVJRIgnvz13gwjs8mvAlDZ7Wd1pyZrrujdExvgGm9MYm5nwbYiPb6jXsPMbPSApHCBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999088



On 9/25/26 14:42, Bjorn Helgaas wrote:
> [+cc Roland, snoep]
> 
> On Tue, Sep 08, 2026 at 02:06:00PM -0500, Mario Limonciello wrote:
>> This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.
>>
>> The issue is actually a problem with BIOS configuaration of PCIe
>> root ports, enabling a feature that causes problems with 64-bit
>> DMA.  It is fixed by adjusting the kernel adjusting the
>> configuration of those root ports.
> 
> I'm a little concerned about doing this revert for v7.3:
> 
>    - The AMD issue should affect any SATA controller, but 105c42566a55
>      ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585") is very
>      specific about JMicron JMB582/JMB585.
> 
>    - The BIOS configuration change only affects AMD NBIO 7.7 and 7.11
>      but the original posting [1] of 105c42566a55 ("ata: ahci: force
>      32-bit DMA for JMicron JMB582/JMB585") mentions Raspberry Pi,
>      which isn't AMD (the Raspberry Pi mention was removed before
>      105c42566a55 was merged).
> 
>    - There are reports of problems on Raspberry Pi 5 JMB585 [2], [3]
>      that don't seem completely resolved.
> 
>    - The revert doesn't seem like it fixes a problem, so I don't know
>      that I can justify it as post-rc1 material for v7.3; maybe the ATA
>      folks should take it for v7.4?
> 
> What if I just merge patch [1/2] ("x86/PCI: Disable enhanced atomics
> on AMD NBIO 7.7 and 7.11") for v7.3?  Would that leave anything
> broken?
> 
> [1] https://lore.kernel.org/all/20260403050225.50186-1-artmoty@gmail.com/t/#u)
> [2] https://forum.radxa.com/t/repeated-ext4-metadata-corruption-on-raspberry-pi-5-with-penta-sata-hat-jmb585-despite-healthy-ssds-and-raid1/31393/10
> [3] https://forums.raspberrypi.com/viewtopic.php?p=2386959#p2386959
> 
>> Cc: Arthur Husband <artmoty@gmail.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think we should let Niklas speak up here because there was 
confirmation on this thread it's an AMD only issue.

https://lore.kernel.org/all/ap6RyP28fxXNjRWS@ryzen/


>> ---
>>   drivers/ata/ahci.c | 18 ------------------
>>   1 file changed, 18 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 9b8c0935001cb..bffe50a109b88 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -68,7 +68,6 @@ enum board_ids {
>>   	/* board IDs for specific chipsets in alphabetical order */
>>   	board_ahci_al,
>>   	board_ahci_avn,
>> -	board_ahci_jmb585,
>>   	board_ahci_mcp65,
>>   	board_ahci_mcp77,
>>   	board_ahci_mcp89,
>> @@ -213,15 +212,6 @@ static const struct ata_port_info ahci_port_info[] = {
>>   		.udma_mask	= ATA_UDMA6,
>>   		.port_ops	= &ahci_avn_ops,
>>   	},
>> -	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
>> -	[board_ahci_jmb585] = {
>> -		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
>> -				 AHCI_HFLAG_32BIT_ONLY),
>> -		.flags		= AHCI_FLAG_COMMON,
>> -		.pio_mask	= ATA_PIO4,
>> -		.udma_mask	= ATA_UDMA6,
>> -		.port_ops	= &ahci_ops,
>> -	},
>>   	[board_ahci_mcp65] = {
>>   		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
>>   				 AHCI_HFLAG_YES_NCQ),
>> @@ -954,14 +944,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>   		/* Elkhart Lake AHCI */
>>   		PCI_VDEVICE(INTEL, 0x4b63),
>>   		.driver_data = board_ahci_pcs_quirk,
>> -	}, {
>> -		/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
>> -		PCI_VDEVICE(JMICRON, 0x0582),
>> -		.driver_data = board_ahci_jmb585,
>> -
>> -	}, {
>> -		PCI_VDEVICE(JMICRON, 0x0585),
>> -		.driver_data = board_ahci_jmb585,
>>   	}, {
>>   		/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>>   		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
>> -- 
>> 2.43.0
>>

