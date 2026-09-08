Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F24A43F0;
	Tue,  8 Sep 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888329; cv=fail; b=CX2OejYsnfKrxPXMBBmQJK0u0x/Cc16FhZGHwGnMysoHKl/qI07BGm7367qU59hxH9Tk3NwT1FtgyTl64kVGTI/WS9BVx4F3sn0qu6mwVmmfUwRsRAOD8BILAG1Afdat8sdQzWvFFPMAVOERvob9cgAXOh1hvacmU3oIW8676Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888329; c=relaxed/simple;
	bh=PfIC3ukcTdP5pK35sJ/NPl9sfDII2hLpRD0FtrqG0B4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYaNBLvWNBCjPdC9i4XugeA+DRIjrdZzBzNiTEVNWCWv1890BQozI5sJ0Yu0dMfeozKRPXTZCWNMfURQiUXhsjqw84yPYtjjPU3gTiX9s8xqgd/2s6ZCa4RSkOOi/3GfddDwK0yR8uMps5MjHi5/pv4wWmIkV+Y3U6Hs5p2VTB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hkdqseKj; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hkdqseKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIGGklWwCy0sy8alfhJ3NKIoFwbd3gZRighwCBu8jxQjbOnyAk4XmTpta3MRdBroh4leO7xGRQH7w1dNaQgJouEScAtmFk4thRgJiSpMvlbuQGsTUSftlr+S3Kjj46amaCQT9R2gsdLfVmlK3BalKpHtqGEiYdQYAzPlNFsLtVLRBAfbUBJYzSFE27/2OHRSAlJB5W+uniqfoWgJu3oNISf9G2mvDAi+EXEHEQZgsDSIEwtOZDI0DdgZB8YVj536lULu/jXYoO1lzID9eTTuuGj1xa96THi3VS5mUqESHJr4nye9Vhn4XxQafM7Y65AWgD6KiisDPE7jfbliiMZq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWJ2Z0nVb2ZjfzzGZ/nTLfCE8RueLnj5pgikAYyul+g=;
 b=pLj5LBLm0JmtGBNTxTF9kaXptBHM/2NQUv5I4Oend5w8YY/HeWn03TcTJMv6RjFcBt8HcTjqP7EfOjCb/9qiUmCf8jLpR+bMPvnZ3xgd0pzL5QYSSVTKc7LstVBH+z5NcCeLA/q9c6kfWZqe7bPnt1MfoINGkfKJY7uOk7kNz7eS4OtAGNGrxBEWrx6TUEiOQtFlPzs4bdkyks6DPJyONCbQGDzAk1UosXl5zmRV864oGS/As3xFnQRWUdX3cqB3NmPx1C73NWcWjNO1lxWIswsbOMHMJ/4Bp6bIqQU60KG3qMwljtJbAw0mrhJRxOALtACHlEme/aEbnTFrji5jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWJ2Z0nVb2ZjfzzGZ/nTLfCE8RueLnj5pgikAYyul+g=;
 b=hkdqseKjgyI0sA3iHu3mz7K/m1Q+zMcp6q0/33dcZAZIB4OXejI/9yPVaQQl0fe8ANq0zaujRERI7aerD8GThTHbJPT7qum9tYK/i5IoFAVa3aJISM/VpaUSVwYlDFSQImKQ+RFhQz7WEfGf13MEhpzWo8Wjr7KrVZuecwPgmA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 17:25:24 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 17:25:24 +0000
Message-ID: <391cde44-dab2-49f1-8f57-bd5ba5314ecf@amd.com>
Date: Tue, 8 Sep 2026 12:25:21 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
 ports
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org,
 linux-pci@vger.kernel.org
References: <20260908170035.160166-1-mario.limonciello@amd.com>
 <20260908170035.160166-2-mario.limonciello@amd.com>
 <20260908171427.A111A1F00A3A@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260908171427.A111A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:8:453::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: cb06e26d-6196-460b-0fbe-08df0dce2abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ax79Ff30ifpGtrhT8rFZdgtWTgJE6HB3LupxnNROcK0n6taZK5136k5n8g/cksvAGtUjotdDoAy5yaeZbf2C3CkLBDw8tQTsS6BrXgOVXxEbD64Iy0aUpAxc4D+wmIyrdte84bhB0AlxbYi1kf6E1bs4Xg1bFQfnVoVHMYp/6unDbbUNjGxc//UNiIQXrYKaxZkl8FHrC83KcEhCsIlkKENLQU5kYPkDQAPbLtWa1H0Rt41EoqlenYMjgsgheLLzQ23UNE6aJMrWsDbh9JZqk+tHPZJB0OYdZIebLBXgPXFbfH37deKAt6mfHeFiDA5wWk/MU2dafcRT/TM/xr+HLdCdugBJu5miWsjDftKJ8CmGDX2my/xOrQoe1yWVYnNS7zjIxyGhO/KycVteu13tq6gArHzFL9gdkOa7avA/SHHLqKA6jwI1dbW2tyZHbBbqjfBBhGRAZOZQeq3IUl1dWdRZfklFqwgexeygayqOtbRL0lO27/wlozX9xVZHnq1MtPMW2HKWoxlurClREne6z9B9+qC7R+I86nkqtJzeS2bBMIfNzKeBrekquuPyTCtFg47zgHgUyO+kEKoDFXlQoZeRTGtyU2nUB7XFkckKRSPfudNxpiM+5G3Ceju046+KuFL4meFXg7FbhpYqvyNASebmoqRtp8FfaF4o5aTsYsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3dIcXVqV3IvUlUzR1crM0JJZnNxenRQVjcwNXFocGlxOStPMlVmbWx4bG4z?=
 =?utf-8?B?aU5QSm45eHlqM3lmTXNSNTBEZEpRL0s0Y2drektvdCtacFZPWUJQOFRnOVNr?=
 =?utf-8?B?b2FrVzdMcHN4Mi93ZldEZ0xuci8yelRWNEVmTkhvdnBpTkRrbFNuZ1lMZWNP?=
 =?utf-8?B?YkEzdzAxM1I2WTZJN1BSUm9qOHgvVERPRmhBQTI3VmlzMnNBM3diRDlJTnF1?=
 =?utf-8?B?TnA5NG5IVk5OUDFjNWxSQjBqRzVpVTlOWEdYcFRMMk8wWHZ0ZVBGQXBYMUZ2?=
 =?utf-8?B?bXBGOFA1SkN3WEh5MHF5MG1LZzdjY0JORm1tOXAvV3lTZUV4ZUlMU0ZSOE8y?=
 =?utf-8?B?UWhTNUhMVU5CcjB2TlcwVmZndWFXekVhWktJUDhKVmZvWGplbmtxK08rRm83?=
 =?utf-8?B?U0lOYWUvS2FWdzI2VldON3dWNm5BZ2hjVENaSUhOSXEyQjVqbWgrMUhuZDF4?=
 =?utf-8?B?ajdLc2o5S29sQ2paRk0xZUFSUkFQU1ZVNm91UnROME5mQWgzUnRDdUh4YmR0?=
 =?utf-8?B?YzNVaVhFSUlERVBEZlBsUXJsNGxVWWtmcHBabjJpblEwOWVZN2x0TGpaeEo5?=
 =?utf-8?B?aklUN2dQR0xtaDI4OU9UYmxSMkN6TW5LSk1VM3lkSENYRjQ1UkFKT0N2YjUw?=
 =?utf-8?B?RHc2azBkK0FqdTRDQnI3L2lraml1WnZrVCs1QkFvMzBlczVXNGVhNnJCT2xJ?=
 =?utf-8?B?RE1mM2drR2pXcUF4R1lDcFdMdEdBdkpCMjg1cGhBbStMWVRpNG04V2JwVWcr?=
 =?utf-8?B?SCtzQ3g3bStDM1BmN0dsWTdPaHFyektDRitkV1pFUVVpQkx2bWhBS2J1ZkNK?=
 =?utf-8?B?bGVPU08yT2NkOVIxbm51V3ZLTEpsdFhJdFJ1eVFmMFc0VTdJMW5jS1kyNW14?=
 =?utf-8?B?ZUE5UjFqQTlVZndRU0U3Qkd4UWk3OXRRbmdaU2JFa3FkMFNWZVhMeFpFRzdK?=
 =?utf-8?B?ZkY0Mm9yclRGU284WjJKc3JQWk1MUVdnWWltbUgxaFFBMXJJbGJrYzRCU0dx?=
 =?utf-8?B?ekFEYzZCUHBWZ0V4MkFzVU9abjVYSjlvdnc1NUxXMUk2V0lkNjNWU3JoNmFX?=
 =?utf-8?B?bThVRmRJcXZTaFh1ZUpVZU5uMlVaNzlraVRYenRxR1RkSEt1K2FRbUxGQzUw?=
 =?utf-8?B?dHp0RlpVWTFWdjNIL2QyME9VTFZmRUVjQnIyTnJZUTd4VG5KaXBoK1Z2ello?=
 =?utf-8?B?T1NkZVkrbkl3a2QyMS95MGZScnF6TnF5dTlTTHVjR1JjUW5xdUNra3R1Smd5?=
 =?utf-8?B?cllGYnRaN2xsN3lEaHpRUmRZeHpsaDJCcXl0c3dsdjJvc3dTN1B4TmdjUDJV?=
 =?utf-8?B?NU82SEs3ek0xWHBVZkw0cTVibmc5MG1jMjZFYlRCT2R5dkF3Qk5BcXNSaEo5?=
 =?utf-8?B?bmdBV2E4T0JieGJKZktnNU5jcEVWN3hlZU5EQjgzS0N6bUdSVlM2N0xkMFBO?=
 =?utf-8?B?Nm5RR1duOFd3c04zRU1hWC9KY2E4UTdJYWw4cEg3NEpLNWhSMk9QcUxjTmVE?=
 =?utf-8?B?aCs2WWhIeWFiZkxpdzF0OHk4UnRlUDRXQ0NsS0ZsVW9uSCtIWjd0UzBEeFlP?=
 =?utf-8?B?dDBjNHlNUjZwbDNzOTZXUmJreDVNOGc5TVNRV3lQUitDL2ZsS29JRXp1NjFN?=
 =?utf-8?B?L1E0QVllaTFNWk5MYXJzZDhzbHlOV1pnRkR1NU5acDBDemtwam5KcG82WUE3?=
 =?utf-8?B?SlNpcld3c0JSQSs4NHhPMTRZSmtrYklWcks4Nnh2NjJoMGRsVzVGdjl6d2Vk?=
 =?utf-8?B?T3pSdW1NR1U2VG1VMkxjbUJvbTZLQ2VsckFXQlNpam5LbitpcEN0ckh0Vkl5?=
 =?utf-8?B?RW5UbFJDZ3lqdlJqdGVVQTdUZlQ4aFVCeXppMjlKQTNyQjJmR09xN2duRHNI?=
 =?utf-8?B?a3dFU0cvZENpYWkrdGxTa3ZiaC9UNFpjdElnbzVIWk5iWEk1MVdobGdOdVVk?=
 =?utf-8?B?a0ZEeTJOYzd1SUNmVDhLT2NUQ0xRbXkxMlpDU05GYjREcUJqUW1LRFc0YU5I?=
 =?utf-8?B?SWhWdXg4ZjF5YlozUXFPOWJrZjk3ckN2NDZFamRJVStSSlR3eU5nTXVtZThz?=
 =?utf-8?B?N3FRM2VGalJHRXVzVUNZSVRRQ290VWFXaUJxS3lUb0RiZkZtMnZJQ1I5a0Zt?=
 =?utf-8?B?Nk5xcFpLNHIzMXlDd0Vaa3duVUN3UXdHSDlGYm9RYU02dHlvelBxY0xEZHEx?=
 =?utf-8?B?SzlBbUt5Q0xISUlycDlwamRMaExnU1ZDeVJWa25GN3AyTjBYZnpoK1hkeWV6?=
 =?utf-8?B?aXJBU29LWTlhK3hUTS92ck11UXRRc0k2RDRlUjVXV2pGa1hGVGEzNzNOeVpk?=
 =?utf-8?B?Nk9mQWpzK0VhbFBrZjNvWkIwTmhyVWVPNmNtZ3B6cWtsTUdnSitiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06e26d-6196-460b-0fbe-08df0dce2abd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:25:24.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvKymZbu+y7uZn1M8mIwwWE9vWQv84fW0HhUYqS9JnU/a261VNbqY+8OYGzoBZBkuPaE4fCIqPOGhTsqcuTBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321



On 9/8/26 12:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Hardware state loss across suspend/resume causing data corruption
> --
> 
> commit 6c1c185449d3f44e1db8d42c0f5b1f2a64c2eeb8
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> x86/PCI: Disable enhanced atomics on some AMD PCIe ports
> 
> This commit disables enhanced atomic operations on PCIe ports for AMD
> NBIO 7.7 and 7.11 based models to prevent data corruption with 64-bit DMA.
> The issue occurs when the 32-bit IOVA space is exhausted on certain BIOSes.
> 
> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
> 
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b301c6c8df753..0857fd9365ec2 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
> 
> [ ... ]
> 
>> +/* Phoenix, Hawk Point (NBIO 7.7) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
>> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
>> +
>> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> 
> [Severity: Critical]
> Is this fixup lost across suspend and resume cycles?
> 
> Because the quirk is only registered for the final boot phase using
> DECLARE_PCI_FIXUP_FINAL, the PCI core will not re-apply it during system
> wake (which relies on DECLARE_PCI_FIXUP_RESUME).
> 
> If the system suspends to S3 or s2idle, the NBIO power domain is gated and
> SMN registers lose their state. When the system resumes, the firmware
> re-initializes these SMN registers to their default state (which has
> enhanced atomics enabled).
> 
> Because the kernel does not re-apply the quirk on resume, any subsequent
> 64-bit DMA traffic after waking from sleep could trigger the data
> corruption this code is intended to prevent.
> 
> Should these quirks also be registered with DECLARE_PCI_FIXUP_RESUME?
> 

This looks like valid feedback.  I checked and these registers don't 
surive suspend/resume.  I'll modify it for a v2.
