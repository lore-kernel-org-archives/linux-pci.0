Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD23B813E;
	Mon, 22 Jun 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143932; cv=fail; b=mClP5fh/Iu/p+WJTYAkr6yHuIaLAHXJ8JH4yi9Lfg9SI8WMyU4nwJYx4bNJLsmnx1GlU0UA8p3tuBPnuVuiQgUvPFH9tgrJo1Y6Ef4Pn4uP/O04qdax3JSFaqtQcmvODMrWwI8F4fWBaoJAGKVjQayq4LV9Gr9E2ansDX349R2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143932; c=relaxed/simple;
	bh=JX8riP5BZP4Feix8U5uROpeGg2LVYBGV+ajWhTmzv70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uUFnA93574qwHyX0GP13oaHqk+WbIiZRlPfH4yc6lDGt9Ze9/8Fz3NPCAYxwg7HqqOgvqbpGNj5GmxWVHMO2WBVKvEW+a6RvvE7Uffb/PUctR2O1mgbj4qq0HomeClDQlWEZO/1SUAGl8TkcbrF2ht79mcZJLjOPWaorYwl5Lu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V95q+XY/; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V95q+XY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svndtuZE8XHfnlRxz0PqIb66UThCbypdTp1oaCk/lq5JYX4KCx4RF/udBU9i37XDjkeZnN2KN8UGeSOFzGfgeM7U/BL3KbTKPDDNoHwsGqQMDL+QAfzF4isupIXDcpkARXLRQkiZ73ghLC+0A9ccDOUXaJvg5QYcGcFL8jjyrmKwSrlrXxUVSKWlt784IuU0y81wPHRPYSEdUBiDq5DGv26oyx1aikCdfqnO4VNrLOjJh8iXcBl3llBADQqU3+lUb6m6SdsQpk85UjVwQnT1cRKNQ8b3Swwsmuu71vsrq4hVb87zcq/YpJMYREP4TZT9u1iWDqPEMagQfQXNasERZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmJnCfb3s1XlutAM0dibM2apguLs8V486bLSP/vGoSY=;
 b=ImyPxCq+MhhvtgTCIjHqLAtlOKZzvzOSQwgew47nCYYm9vRIXx1CZZaakFltuJSWSyqtSPlK1i7Jmj/LXTOtisMKWBzStcPZkmWw81a2L/+mEO7AlHTqWc0X8VnmAtqGgNvnjfqRAIVuX18T0v7S64c/nC6vqjed8HRsCpnu5TI10xcK08LA0tetiApCI8+kFXfDLP6F+x7hlgW94A53wbzqtqUltRNb5gHyyx7SbdtOjTqoTdUEVDevh+QSe0c2MagiRlVZvPsMku8ShGhzwB/FSBZX3433jba/UgvLMMw9WQccZu9xVWqrkXs7EfojeC5woafTAyRsbxgghiFuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmJnCfb3s1XlutAM0dibM2apguLs8V486bLSP/vGoSY=;
 b=V95q+XY/cehebpHxsrcc6PaisqB+usE6sKflZmzpLt8c7tOYoCPjYl7PLYxQ9bgu3B0eo+lzVUG0sSOnrn3krdZGBy/AKFl8tj/tmnrU9+3Q39oiQ6+r3ESPqR/9dfLugpesv/sNoI5E7n7m/nqcU4FES9wZTL/kumRbUVcrXTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:58:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 15:58:47 +0000
Message-ID: <a01af40b-6c1f-4937-8aa2-edf170a1c389@amd.com>
Date: Mon, 22 Jun 2026 08:58:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
Content-Language: en-US
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618081803.2790848-1-aaron.ma@canonical.com>
 <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com>
 <CAJ6xRxXhNmehDjP4Gdx8VM5zh4cXQK8NKWVddL3kEGoroHL6WA@mail.gmail.com>
 <4280751a-87b6-4634-99c2-ed51f74ac29b@amd.com>
 <CAJ6xRxVMQTxV9E5jrbZAjjVv-qUhE6za5e_MjTbjnj9UduLm1Q@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJ6xRxVMQTxV9E5jrbZAjjVv-qUhE6za5e_MjTbjnj9UduLm1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 921dec18-508d-4e27-78e2-08ded07724fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	X5Qe4//iqMtvXv6vUjCCGy+sDJuyH6OIIQbzg/4QkT5SVVP2RRjKR45PuAXD7nsKEM+Ertz2aBAY7HYdrFz39qP+HbETFgSdg8iDkWDRpFI4iP+JWiNXCMvvuAadYbuMan8vEUK/aOvUdWzJTK0TJZKX1BH11rdjTC3+B58iCErZ15EmriOEkKh7PLVMKQJeFIhvM5eGER83w+FztKNKhNv3sIpSFTiJZf3mLVKb0vXhUY3u6lCRwOYgP9js3X6zKIyLgu13LGRL5a3rLB9Wa0ST76TZ17pnNgj7zXDjniUR+8BR9s9s+w+D2ykZ8P9odevBwTBXakXxFsjA19TqdfAWp8ER1+ZQvOh4n0xkyi2NP4+J+5x8wjUxK2RQkCFOz3Ee3rOTUyZP65Uac4ZM47Qx1xj0Hyp3KdJ/Ch7Rk6OnHVgvCjMi8eUG1bsZ4FQaZbOQKzzIDckDmO+KZb9vqduJmIxflvUoCO1TZMqqxOPlKMS6n7uIrbR89qSqyFuN20dqEmAuColbU6Vm7mYGCJNtsN7/yfgeAiJSZEWkT73SL60K7ixn790GKz3gcXLOoWqT7UeoPgZZR2Roaaby1RLcLjQ46N/SAk+ZQatEb9+NDGq4GWVWuXjVO5CB0AKlMZtd1v7RXJB5QF0FLoaFpxNsOTmCvmEKSVXNAEu7jH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXZsQWVyTGhCVWdCcEN1d3hZRnNtY3JzMGtkK2ZiTkViVmdZakNvUmJzT21h?=
 =?utf-8?B?KzhnU21tUG1RSWpXMmhNV29ncXNudzhFU0UvRmpuRktUVjArb3dMSWV6dDFu?=
 =?utf-8?B?YTg0WjBVSkJqUXJHN3lpeDhHWVRzQ2F2UnQ3WldJT0FpQkpybXNWUTZWY016?=
 =?utf-8?B?MTRVbmtWSi9qdHJwRGtmOUJuYnIzQ2tSdmxDR0I3Z3Jtd3k4d0NYTm85bUpt?=
 =?utf-8?B?OHNLQk1BdXVEYTFvdUg3aFVMTkQyd1ZiM1Vialh2ejlLSXFobFh3RG1JU0ZW?=
 =?utf-8?B?cUxGR0FlUTJVcDNRYmlkK243eTdPenJYbUZmbXl4dkhjRGM4N09SWUd1cS9K?=
 =?utf-8?B?RnJuU3ViV3YwVHdsZnJSb014cStzNUhjeUJCMFZrZmZheTlOci93ZVZESHpj?=
 =?utf-8?B?TDZPbWZnelZOS0NjZ3c0eEhFMnhyV1gwTDRZa2hPTUVmU2JiemtoWFY3cFpJ?=
 =?utf-8?B?N2FhVUpCUVk0YWtid0czS3VucEJVaXJUK0EvcXlUanE0d1dPTnBpemcvU3Vw?=
 =?utf-8?B?UU5nMkV5MERNK1NsdnNpMFBrV0VHTHQ5bUhJaXJaUXpDZWxGYy8yYllhVnQ3?=
 =?utf-8?B?Q0psWU5pa2xCYXdiUFBsQTMycURNMHMwcGhLQlRzcnJxUmlkczNWbFQvcVhp?=
 =?utf-8?B?b0s3OG9rOTJoK1RBamt1c1JGbFVVVVhyWk50U0FQU3NuN3QzaFVjeWZDYUNt?=
 =?utf-8?B?L0RjWVNHV3lsOW9iOVlwQm5xMWxaNHA1YUtPMU5uZjdDYkdmbW5SVzhGS1Fx?=
 =?utf-8?B?RHprNnMyUnRQMnViV3lGRUJZWVBHbEt0dEFGTWNOSWJxcGFHZ0ZwcHVNY1Z1?=
 =?utf-8?B?eWlZSzNPVmVMWlFMbEVPb1I1bGJYZG4rMU5Hc2lOODZFbWZJUVhJdGpwRTNz?=
 =?utf-8?B?bTdvTGJwM3dRSTJUVUE0eUdndDVxa3NuSjZLVDN5ZWVhclNZQnNRUUZ6NTFv?=
 =?utf-8?B?dEpqbi84R1BnRHFkL0VEU3l1bE9ZLzJ4L0lvZ0o3Zk5PalJZUWdjaTNmZnM1?=
 =?utf-8?B?NVBvNmJMeDBGSHY2ZUFXRjdLTFdkQ0NGN2JVTjdraFltRS9LZUFzZ2hjbUZU?=
 =?utf-8?B?SGl2SDFNdWRMUEhJeW1IMzEzZDRLZG5RZlk1amhLa2hYZUpOZ0ZIYXlVWGg1?=
 =?utf-8?B?VWx1K0toUmE1eUFaWjQ5aytMSC9ZQWlnc3EwL1AvVVo2bGhNdnFkZHp1SEti?=
 =?utf-8?B?MFJWOGhhNmVwN2ZnVk5QRkRtTFZTOThnVGdCZEdsbGorTWJzUzVjc0RtQStp?=
 =?utf-8?B?eEY3dUNTUGlJa0haMlcvNFRMdldneDNmNzZHMmFiMFNXOXJuRVFzYnAzREJ3?=
 =?utf-8?B?SmF2a3dtUStESTIrVVNiZzgzM3JaZ21TNEFIanV2cC9vb1dETFM2YUJraUNB?=
 =?utf-8?B?V2hpM1Y2V24xQ0Z2TGx1OFVpTGJkNmZSd1d0WmJhYjNvVEk1RTNjclcyN1RM?=
 =?utf-8?B?ZEcvL3hEaGpsL2RmczFzKzlYVEFvbTV5U0dlVkdCYnkrUDVQVkNrYk91MGVu?=
 =?utf-8?B?ZEZxa1FzaXNBSjJXTGhRSU1jWk1oZC9sWDh6cmV5YmNPTWdBUmNRUHViYUVN?=
 =?utf-8?B?TDN4SUN4OW9mSzFXM2x0eDE5c1VKZTZFSVpiazBwLzhRellPd2grVkNCckJ2?=
 =?utf-8?B?b2VqdXJVODl2Z1BvQW5XQjY1ZEFZMWM0UlhLdXpvZ0wwalBDbWRkOE1oWE9M?=
 =?utf-8?B?SkJHNXl6TXJzbi9ueEpwNUJJV2RWMzFTR0lHb21XMVVkaEt0MURvYUhYSVcz?=
 =?utf-8?B?d3hGeXVqMFg2WXVNa3BEY1YwSlJ5ak9hem1oamdHUkJXTHBPdUlJMVkvWGJB?=
 =?utf-8?B?eUl5djcraGNRRUFBbUkyT2wvSUhNY1pVYzFvOGZKa09wa2Y1QjB4S1dQY1RG?=
 =?utf-8?B?b1RVOTYvWVlhRjBMcWJBVEc0MVpiVFBZdVAxRDZiZkVpUk5yeG1KS2ptTnE1?=
 =?utf-8?B?MVZ4TkVtbkJiZFExNElTcHVCNHRreDk2Y2FNU053TTkxTFZid05QMnp0bktO?=
 =?utf-8?B?cnZrcitFZ0k4MFdPQWZMOE1WUmozUUR0OEZTMTJCcjF3QXZWYStmTU5OR1hC?=
 =?utf-8?B?cWlrT1FvN09Ya2MyM1VoWndrWS9NY3ZnQmpmNXNqem40VjBTcnZtT0o3eG9H?=
 =?utf-8?B?cjQzUnp0ZVpmZmU0eXBON3h0cHZHT3MwRlFCclNSZFRjSklCeUFpY3VGcms2?=
 =?utf-8?B?Tk5rVlIyYXRqa2FjalhtcVI5MHNIc3ZCemNyQWxrOStxbURJWjhXVXJVa0Y4?=
 =?utf-8?B?amF0elltZlA1V1ZKbUc5SG1FQXFGZjdnQ1JlUHEvUlpFUE5yTDlhT1l6OXQv?=
 =?utf-8?Q?G2XyINhtaPA0S/9/qr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921dec18-508d-4e27-78e2-08ded07724fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:58:47.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3uN+g3P4Lp2Y85BPADpyn7zdG6uTymNrAPD4hvom3TFT+C/TGbwwHYD6K2suMFhpmZsuw7ncvjx2X5s8MjNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988



On 6/21/26 23:12, Aaron Ma wrote:
> On Mon, Jun 22, 2026 at 12:00 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 6/21/26 20:50, Aaron Ma wrote:
>>> On Mon, Jun 22, 2026 at 1:15 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/18/26 01:18, Aaron Ma wrote:
>>>>> Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
>>>>> instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
>>>>> devices, so those GPUs are not considered by vga_is_firmware_default().
>>>>>
>>>>> On these systems the AMD GPU matches the EFI framebuffer but is
>>>>> excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
>>>>> does not match the EFI framebuffer but becomes vga_default_device()
>>>>> through the vgaarb's enabled-device fallback.
>>>>>
>>>>> Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
>>>>> for the same set of devices, so the firmware default device can be
>>>>> selected correctly.
>>>>>
>>>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>>>> ---
>>>>>     drivers/pci/pci-sysfs.c |  3 ++-
>>>>>     drivers/pci/vgaarb.c    | 10 +++++-----
>>>>>     include/linux/pci.h     | 14 ++++++++++++++
>>>>>     3 files changed, 21 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>>> index d37860841260c..843d83ec9550a 100644
>>>>> --- a/drivers/pci/pci-sysfs.c
>>>>> +++ b/drivers/pci/pci-sysfs.c
>>>>> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>>>>         struct device *dev = kobj_to_dev(kobj);
>>>>>         struct pci_dev *pdev = to_pci_dev(dev);
>>>>>
>>>>> -     if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>>>>> +     if (a == &dev_attr_boot_vga.attr &&
>>>>> +         pci_is_vga_or_other_display(pdev))
>>>>>                 return a->mode;
>>>>    >   >          if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
>>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>>>> index c360eee11dd9e..0e0878189e3d8 100644
>>>>> --- a/drivers/pci/vgaarb.c
>>>>> +++ b/drivers/pci/vgaarb.c
>>>>> @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>>>>>         }
>>>>>
>>>>>         if (vga_is_boot_device(vgadev)) {
>>>>> -             vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
>>>>> +             vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>>>>>                             vga_default_device() ?
>>>>>                             " (overriding previous)" : "");
>>>>>                 vga_set_default_device(pdev);
>>>>> @@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>>>>>
>>>>>         vgaarb_dbg(dev, "%s\n", __func__);
>>>>>
>>>>> -     /* Only deal with VGA class devices */
>>>>> -     if (!pci_is_vga(pdev))
>>>>> +     /* Only deal with legacy VGA and other display controller devices */
>>>>> +     if (!pci_is_vga_or_other_display(pdev)) >               return 0;
>>>>>
>>>>>         /*
>>>>> @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
>>>>>
>>>>>         bus_register_notifier(&pci_bus_type, &pci_notifier);
>>>>>
>>>>> -     /* Add all VGA class PCI devices by default */
>>>>> +     /* Add legacy VGA and other display controller PCI devices by default */
>>>>>         pdev = NULL;
>>>>>         while ((pdev =
>>>>>                 pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>>>                                PCI_ANY_ID, pdev)) != NULL) {
>>>>> -             if (pci_is_vga(pdev))
>>>>> +             if (pci_is_vga_or_other_display(pdev))
>>>>>                         vga_arbiter_add_pci_device(pdev);
>>>>>         }
>>>>>
>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>> index 2c4454583c115..195ec1bdac863 100644
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>>>>         return false;
>>>>>     }
>>>>>
>>>>> +/**
>>>>> + * pci_is_vga_or_other_display - check if the PCI device is VGA or 0x0380
>>>>> + * @pdev: PCI device
>>>>> + *
>>>>> + * Return true for legacy VGA-compatible devices and for "other display
>>>>> + * controller" devices.  Some firmware-selected boot display devices expose
>>>>> + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
>>>>> + */
>>>>> +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
>>>>> +{
>>>>> +     return pci_is_vga(pdev) ||
>>>>> +             (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * pci_is_display - check if the PCI device is a display controller
>>>>>      * @pdev: PCI device
>>>>
>>>>
>>>> This patch doesn't seem correct to me.  It's overloading the purpose of
>>>> boot_vga to cover non VGA devices.  We should be using boot_display.
>>>>
>>>> Trying to hypothesize what's going on here - I guess you're seeing
>>>> boot_display set for more than one device due to enumeration order.
>>>>
>>>> Can you see if this helps instead?
>>>>
>>>> ╰─❯ git diff
>>>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>>>> index 152789f00fcda..9440eb3a7b15d 100644
>>>> --- a/arch/x86/video/video-common.c
>>>> +++ b/arch/x86/video/video-common.c
>>>> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
>>>>            if (!pci_is_display(pdev))
>>>>                    return false;
>>>>
>>>> -       if (pdev == vga_default_device())
>>>> -               return true;
>>>> -
>>>>     #ifdef CONFIG_SCREEN_INFO
>>>>            numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>>>>            for (i = 0; i < numres; ++i) {
>>>
>>> Hi Mario,
>>>
>>> I tested your change. boot_display becomes correct, but the issue is not fixed.
>>>
>>> The kernel state becomes:
>>>
>>>     AMD:    boot_display=1, boot_vga absent
>>>     NVIDIA: boot_display absent, boot_vga=1
>>>
>>> Current Xorg checks boot_display || boot_vga, so both GPUs still match.
>>> The selected primary GPU still depends on Xorg's DRM device enumeration order.
>>>
>>> So boot_vga is still wrong, and that still matters. The kernel should not
>>> expose boot_vga=1 for NVIDIA when the firmware framebuffer is on AMD.
>>>
>>> My patch makes boot_vga and boot_display agree on the AMD boot display.
>>>
>>> Thanks,
>>> Aaron
>>
>> Got it.  I still don't think it's correct to overload boot_vga.  It
>> would be better for us to not show boot_vga at all - because it's not
>> correct.
>>
>> Maybe we should drop the fallback code in VGA arbiter that is setting
>> NVIDIA as boot_vga at all.
>>
>> Could you look at doing that?
>>
> 
> Hi Mario,
> 
> I looked at dropping the fallback. I don't think we should remove it globally;
> old systems may still need vga_default_device() when no firmware framebuffer
> owner can be identified.
> 

What exactly happens on such old systems?  Any chance you have anything 
in your cert lab that's really old you could try?

I have to wonder if the boot_display code will work on them at least and 
we can just rely upon that.

I don't want to keep this fallback path around as tech debt if we don't 
need it and it's actively causing problems.

> For v2 I will keep the fallback, but avoid the wrong result on this system. The
> 0x0380 firmware display can become the default/boot_vga device, while legacy
> VGA decoding and ownership stay limited to pci_is_vga() devices.
> 
> So this keeps compatibility, but avoids reporting NVIDIA as boot_vga when the
> firmware framebuffer is on AMD.
> 

I'll look over the patch.
