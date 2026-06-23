Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702B37AA75;
	Tue, 23 Jun 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224219; cv=fail; b=Pt/QY0KylkYKCggwribOaY8Ypth4v1Cb1kf9cd+f652uhCB0qDthqhv4CLc3c15YzCBVMfvLELgw5YTiM6wnQ38nWUEHb/r7gT/jmS/cokPTGKEe/Xpbe+BWYnhML4xiqgyPk7p4dhg2fMzXo3okFEpUwaGjHJYXiw/YEJ0tUGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224219; c=relaxed/simple;
	bh=am/IzNxETfFMVj8unKnOJBkFOp7h2oVrNvOj13SNWaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/kc2yUYe7fVF8iwRAoRrTR90AKs4YkT+OhGJuPqZ4mPgsMg6vcHj8hqQIQv29HIuqA5cWFReVPH1mpwPH4gOFMg2d7vPJBqpW9At/RQpusINFN3zOcrxckRc0sB7OUed7GmautI23uoXhh6CpIw3Zn+21smuqwWY7gMP7yQC+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rbjf4rAZ; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rbjf4rAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD7LOO9F1CeYjrHi7quDaXJw3anm1jtxvWWx4cDdCLhLwqhy2hkubiIzWcEoPKClin5hFMUG6bDzYn2V6e+X6R1WWAvcCtfEDxc7UWHA/Eq/KJ9f1TKjikfetLQka4VBcXlwSFSd2mRncLH0EOESJnvNt3QnPM1K2U7PqSLtUNcSrMM8fqZaLQ50/b77vxgtT6ay9Zy/vrXU1ZfQ7ObQKoiGO+KV0NuBbjh4njWQPEOJd2Pn2a714i+yebOX420Wtx5CEnkJNS+OVKRSgtl7pmRfrZDXcfkyPjM6WG0vKWdO850WS/0+xY0JzU7ngyyIo3R2mztmG7Q4TO0i6LWWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l34Z3vNTvq8BWSL9LaZyFuazVUWCjMfKfzKcqf9Qbbk=;
 b=QuijqkD08U8so/YzG/0AWd1KTUPbwH++3BUm+iw2JzYk7lWLpM9EOL+1Ecy+N1KGeOZeAOMnFRo7/McJ8z7taLtsKDk7KLHH5nivcWEnRqBKjWlHHJmiBpwc9cbfpaW4F7V4zqsu7bsVqtFT3MshC3Et8cIF1S2kjagC/PmV1/UUjWzNAEEliBywu8rMfdgphFY99VbRJeRqV4m5CZ/602pzpDmWHumY+jzQgXrHOyoSuBRQ9IkMYkTOjOz1WMHdstDmeB9HkWyl0yQWy+pDq2I//tyImzeNlrLZPCzW4GPYqrl5XxGrVtFEh03S9r9HAPR+Mhc9DvatvGbiP4tDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l34Z3vNTvq8BWSL9LaZyFuazVUWCjMfKfzKcqf9Qbbk=;
 b=Rbjf4rAZfaAANzSJ5t7KoOfuFETxSE9D6xF27EsSYgZZebLmceM6g3fNeUi1XbsO95B/UveYvAlEJVVrhwcVTiphFE1sKp2ATzZapL6y633oeInU9nRdtYWTF2KJ8deFXHIEYAGDOp4AXaYoxfAZuYQZIpC1RTbwd738veEPfts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 14:16:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 14:16:53 +0000
Message-ID: <f4eff053-d37e-4172-ba94-b9ef746b9370@amd.com>
Date: Tue, 23 Jun 2026 07:16:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vgaarb: Include 0x0380 devices in boot VGA
 selection
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, Aaron Ma
 <aaron.ma@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dri-devel <dri-devel@lists.freedesktop.org>
References: <20260622061339.3306046-1-aaron.ma@canonical.com>
 <686c79f1-f4d5-4c76-a57d-fd124c0c1af6@amd.com>
 <3045831e-bbc2-43bd-bc47-3cf720fd8a6c@suse.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3045831e-bbc2-43bd-bc47-3cf720fd8a6c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: da755b24-c37c-40d6-9df5-08ded1321306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|13003099007|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	MCQV5HZ+G5owVHUNcwjlhinkBwRPTWd/BdHp7ozYipgc0sBp+gyeyk2/4lX3X/tjmo3RC87r7jMsqPdbQsZwsz6TbArPY5nojmFKf9rBC2nQVbNgqmEJC8HtKKo5rYvaqsEX1K11iviuHBsUb8hA4bCP/JIZy7CWWysMN6UljyFDZ/Ur1p5FRmhsDldmyhT2CtVidh7I5mhL3RuJ0Eqp7jPKNhPNtEDVPLZQMGWy5n7giKu/hp49WZD11TGn/YjBhWGYVOKzNJPQ2c5XL6HkojZSjgmyW9ubIG7IFWjpaMiey887T3xA8h00MHtATobIcVxf0hcSEAfPEeZNLiMvt2cbTDjseNhl/6PZSbke1A7epiCj7wfMUxrfH3OL+zmW8g/YjMXBfvXZaVw6Io91FvIqjhg+9iGxAhZvTuP3XAi4ZPmimw/FUqpu4qMgkjdjhae0KcnRFoOX0wGcOGr2W1vRlKyKIypYm7QBv6ln8g0PJNDv5hAVc+sOYcEEwChVEGvK46VMTnS9pE+2BC2aoyoDZScWuH8j/Gdl3+rLa7RYnFr2b8nuOYNSR13/5Q24En0yLPfDPUc/75OPM6BldBV8BoI7OHzlPMrtw1FK744=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(13003099007)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWt2S0g3bjg0bkN6MUYzd1ZzSHp5Q2dEczV5Qkkza3lWeG55OWdRcUZWRWQw?=
 =?utf-8?B?T1paRUx0aGZpUjRXQUxFQWZWYjdHSjlIUUxKNDhiRzMwcFc5d2FVK2ErVGdX?=
 =?utf-8?B?blgvdkZjaUh5VEtZTkhFR3h2MFN2MFN5ejBBb1pmYmNYV0hiVUpvWnovSXpw?=
 =?utf-8?B?ZDUzY0syT0tSaWN2bk8vVTB6OGJlQ2FpaGdiTDdyc2pIeEl3Y0pIM0MxWTVV?=
 =?utf-8?B?WjNmSFdqTnRSWWlaWDFJR0pyOFBxa21wT2RST3ZDbEtiZ2JCYUdnU1Jtc0Ns?=
 =?utf-8?B?RXNKblh0TDlCWmJBM3J3UTJaN0JabXNJdzlSeDNhSEdMTXl5UitBcDcvV1Qy?=
 =?utf-8?B?WkJWYktReXI4c1hULzdGMnJ3L2hHOFFaMG5VL2J6QzhiRXlTTDJ1bmFlcHhW?=
 =?utf-8?B?Nkp3SFM5b3NKd1NaTTNjTXhVR3lNaGJUUjlzc1U2Uk9sRVF0T0poRXFmMlpW?=
 =?utf-8?B?NTZOeTJsb1RZaU1vMlBPbm5zdEE3Q24veitrRlg2b3NRY3FwQzJ5dTIraFJH?=
 =?utf-8?B?NEl4SFZEUUh5RzJicnFSN1Y5SW9PZlpZWWlNQjFmWUFERExBZWwxMCtIQmln?=
 =?utf-8?B?d3c0OFRPSlQwYU5VbmVDL3pVd2lqYzFBV0JFSy9TM3BhMVA0MmRGQXFtS2FQ?=
 =?utf-8?B?czBCcjdoREhzNFRBUUNoeVZXY25QTjN3TUFRZkFUWTE3OFh6T3p0WUhTOEor?=
 =?utf-8?B?NE5qelJiM2ZTTi9BNVNPNXh0LzZnSE91VjdLN0RsVVB1NlRZZDg2RzVxdENP?=
 =?utf-8?B?TWxQSm5CM29JNk9LQm5qbnFjUDVQY1NhaHJPMTArc1owdSs4Q0NmMDFmRFcv?=
 =?utf-8?B?TFBQc2VFalJqdXpyYUxSZXlXVlN1bEtZRWQrWnpteUJQUnRZVEpqN2JPa1Mw?=
 =?utf-8?B?THBocnRTalpqSmozcGlBYUZFVlByTnUwS3dicTdodS96VDB3Qk9NVW45K3VC?=
 =?utf-8?B?bkJ4TjZpWGpETStwUzdaT29UYmlIU3Jia016dTVlV05qTStXVjN5ZWVUSzJY?=
 =?utf-8?B?TjZVYnpQMnp2aWlUT2lVVlBYd3NSVzd3aUovUGVnVG5kMFBKc0dYRFV6VUlz?=
 =?utf-8?B?WXpycGQyMjR6M2JYbWp6dldmNFh3aDNLN0VNYytCaUI5RDJnbzFjSDdLRlNs?=
 =?utf-8?B?cW9HbzZWWU1YQ2FrNkRJSXZjM0pVRWtkcUJNa1BseUoxQTlOSCtNa0RqYWxS?=
 =?utf-8?B?NXFTQTQrNXM0WTluSHdzVlBJLzg1RlREN0R3RWNIZDF4OUhPajJzZG9iTEMv?=
 =?utf-8?B?NkMyZHo1a085c2U0S0hyRVhVaW9EZUNXT09JaCtqMlFGMHhjMVhGaXpzODNK?=
 =?utf-8?B?WFI0OG9JSENnVVY2akVldTZ3cXQvQ1JRWUh3Q0RSeStETUdsZVN6aGJ1QkY4?=
 =?utf-8?B?dndUWE9nQTdGdUsyQmQxU29adWdpZ01LNi85NnVwbFpWS0xqYUN6TXJ1TWtj?=
 =?utf-8?B?ZW0zZ3I1bFJwMGNjK3lmWmRDNy9NZnZIY0xneUN0QkRBN2ZqbmFRRDZ1b2E5?=
 =?utf-8?B?Skd4SmpQL0hFc0p4N3hmVjBtYTZpakt5YXFzQ3hFZ05aZkxlclhEa1B4WGp6?=
 =?utf-8?B?bFZ4aGlRNHpGbjhHYU1OU0FZZHpzc1hxYmF4V0RzelkrMU1Eak5yOGNYK2Jv?=
 =?utf-8?B?MDZlYUhzZU5xc3NtMXIyMnNBWEZUb0c0TllUMUQvaFlZd1dVOEN0RFFMUWJ5?=
 =?utf-8?B?elFVWjFuRlFZUUdaM25DQWs5eXVtcVZUR1pYSEtOV1JLc2V0Y3Y5MW05MStC?=
 =?utf-8?B?NmUrM3Nxd3hSTGRob0xpaEN4K1M3UXFCTXpKd241SkpQaHdKL0hjZlYvYkRD?=
 =?utf-8?B?U0FjQkswV3V1UFdKZmdYQUR5dWNISXl4bEdEdEFiRHRLWFZiTmJ5eTM5Ukpy?=
 =?utf-8?B?M3dVSmxwaVZSdUVKTWVxK25vSFF6YktJUXRZRHltYkhCOGZVREZmbGJUYllG?=
 =?utf-8?B?TENLemZsS20wdGt0VUVpRVNqeHNlRXd1VjlNeHRLMXBvSUczOWRkQ2JKOWp0?=
 =?utf-8?B?eWh3aHAvMG1WRWZTK2ZpZEg3OHdvU0E3akVjNzFVeU1vNERYS3NGYlZSdUhT?=
 =?utf-8?B?a1k3TmtDM3pWWWZFeks5eXdIWks5SUFzanlZVTA1cnpLSUdRL3VnLzhZNjhT?=
 =?utf-8?B?TEF2dWNNUmtCc3Rtd1BwM1JVZGx1aDFOaGllcjFkN09PRHZ3cTU1eG9DSWVw?=
 =?utf-8?B?cmkrWWNJNGZPZ2RFV21Bd1lMeWlCbkNaZGtPM2NhRGR6akxZWEkvczR3SWh5?=
 =?utf-8?B?aG1QTERlV1RlNnBLZWRjRjNJNXRJSHJSK1pUTkhGNzNXeUx4ZE9NK0hyVWdC?=
 =?utf-8?Q?JTc2lJoErnmS9cT+45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da755b24-c37c-40d6-9df5-08ded1321306
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:16:53.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxvyPfKu09zMFFnrZV/hKDruBluDqoFw2LfzBzADc61+bto6Jbpw1CySP10Ir+7gJD4RlQO7asCp0AwvIjKRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738



On 6/23/26 00:32, Thomas Zimmermann wrote:
> (cc dri-devel)
> 
> Hi Mario et al
> 
> Am 22.06.26 um 18:09 schrieb Mario Limonciello:
>> +Thomas Zimmermann
> 
> Thanks.
> 
>>
>> Here is the lore link for you for full context.
>>
>> Aaron's v1: https://lore.kernel.org/linux- 
>> pci/20260618081803.2790848-1-aaron.ma@canonical.com/
>> My proposal: https://lore.kernel.org/linux- 
>> pci/20260621175230.1453114-1-mario.limonciello@amd.com/
> 
> I saw this patch. I was slightly confused, because it says 'fbcon'.
> 
>> Aaron's v2: https://lore.kernel.org/linux- 
>> pci/20260622061339.3306046-1-aaron.ma@canonical.com/
>>
>> On 6/21/26 23:13, Aaron Ma wrote:
>>> Some firmware boot displays use PCI class 0x0380
>>> (PCI_CLASS_DISPLAY_OTHER). vgaarb only registers pci_is_vga()
>>> devices, so those devices are skipped by vga_is_firmware_default()
>>> and cannot become vga_default_device().
> 
> I think the current behavior is correct. The vgaarb is for mediating 
> VGA's hard-coded I/O addresses among multiple devices. IMHO the module 
> should not manage other graphics devices.
> 
> IOW, I think a fix should mostly be outside of vgaarb.c.
> 
>>>
>>> On hybrid systems this can leave a discrete VGA GPU as
>>> vga_default_device() even when the firmware framebuffer is on the
>>> 0x0380 device. That makes boot_vga point at the wrong GPU and can
>>> make boot_display report multiple devices through different paths.
> 
> I assume that boot_display is true for both cards because one device has 
> the screen_info settings,  and the other is the 'vga_default_device', 
> Right?
> 
>>>
>>> Register legacy VGA and 0x0380 display devices for default selection
>>> and boot_vga visibility. Keep legacy VGA decode ownership limited to
>>> pci_is_vga() devices so 0x0380 devices are not treated as legacy VGA
>>> decoders.
>>>
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>> Changes in v2:
>>> - Keep legacy VGA decodes and owns limited to pci_is_vga() devices.
>>> - Keep 0x0380 devices eligible for firmware/default selection and
>>>    boot_vga visibility without treating them as legacy VGA decoders.
>>> - Update the commit message to describe the boot_vga compatibility goal.
>>
>> I really think dropping the fallback path (we found nothing, so this 
>> VGA thing must be it) is the right direction.
>>
>> I'd like Thomas' comments about that though.
>>
>> If we must keep that path, how about instead modify how 
>> vga_is_firmware_default() works.  We could instead have 
>> vga_has_firmware_default() and vga_is_firmware_default() both.
>>
>> If the system vga_has_firmware_default() then no longer activate the 
>> fallback path.
>>
>>>
>>>   drivers/pci/pci-sysfs.c |  3 ++-
>>>   drivers/pci/vgaarb.c    | 27 +++++++++++++++------------
>>>   include/linux/pci.h     | 14 ++++++++++++++
>>>   3 files changed, 31 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>> index d37860841260c..843d83ec9550a 100644
>>> --- a/drivers/pci/pci-sysfs.c
>>> +++ b/drivers/pci/pci-sysfs.c
>>> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct 
>>> kobject *kobj,
>>>       struct device *dev = kobj_to_dev(kobj);
>>>       struct pci_dev *pdev = to_pci_dev(dev);
>>>   -    if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>>> +    if (a == &dev_attr_boot_vga.attr &&
>>> +        pci_is_vga_or_other_display(pdev))
>>>           return a->mode;
>>
>> I really don't think we want boot_vga exported on a non-VGA device.
>> Even if the rest of the PR hangs around, this hunk I think should go.
> 
> I agree. Boot_vga does not mean that there's a mode installed, but 
> rather that the VGA device got posted by the BIOS/UEFI. That's clearly 
> not the case for the other-display device.
> 
> 
>>
>>>       if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>> index c360eee11dd9e..56a86779e6d28 100644
>>> --- a/drivers/pci/vgaarb.c
>>> +++ b/drivers/pci/vgaarb.c
>>> @@ -741,6 +741,7 @@ static bool vga_arbiter_add_pci_device(struct 
>>> pci_dev *pdev)
>>>       unsigned long flags;
>>>       struct pci_bus *bus;
>>>       struct pci_dev *bridge;
>>> +    bool legacy_vga = pci_is_vga(pdev);
> 
> Just a word on terminology. AFAIU in this context 'legacy' does not mean 
> that VGA is legacy. Legacy refers to VGA's original hard-coded I/O 
> ranges (e.g, 0xa0000, 0x3c2, etc.) .
> 
> 
> 
> I think Mario's suggestion at [1] might be a better way forward than 
> modifying vgaarb. For boot_vga, we want a VGA device. For the primary 
> device, we want the device with the pre-configured framebuffer on it. So 
> I'd do something like this in video_is_primary_device():
> 
> if (screen_info is_valid) {
>      // do the screen_info test from [2]
> } else {
>      // fall back to the default vga device. [3]
> }
> 
> This should get us at most one primary graphics device; preferably the 
> one with the framebuffer. With no framebuffer set up, using the default 
> VGA seems a sensible choice. We can still have distinct boot_display and 
> boot_vga flags, because this is what the system looks like.
> 
> And with that, another patch has to go into the Xorg server. Support for 
> boot_display got added in commit 41c58693c ("Add check for 
> `pci_device_linux_sysfs_boot_display()`") [4] AFAICT.  This needs to be 
> reworks a bit, so that it first tests for boot_display; and then falls 
> back to boot_vga if the former did not exist.

Makes sense.

Here is an updated kernel patch:

https://lore.kernel.org/linux-pci/20260623141505.1816786-1-mario.limonciello@amd.com/T/#u

Here is a change to xserver:

https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/2242
