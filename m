Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49853366569;
	Fri,  3 Apr 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241671; cv=fail; b=kr9i/wNsB/WBdt88vew9nxAiH48oB9VZZBPmQYoIDNVdQIS0JZlNGXRKkGQttbMmUQFtosbXjHPm7usiHxPGGezLKwJaMgXi7M4og3gcCa7PZK2QgBT1ua1PEg1XwYrtFIPr6moSMw7HoU4o4ln3tIASZyOb6ZtgmblagFP6eLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241671; c=relaxed/simple;
	bh=Fq1ZjmjfuYqaiFQofDub0TMJ4BrCtF9fO9lILu4XZ90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/Uq9KBGCFAFQbhN91Lkb2RRr+EYNOJaJsAdT1BGoALYlJLFiDF56Pg5R/B9u2aaUqjKamz+A82XeI8+tBtuYuOeFRooz1uUm8aDQXXR6SU5RZy2jBMJ6INOhqNbnUTi6p0Yyd/MMOrzra8UUXp7SGJ8Bcq++R0cyJvBq5Ig5hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KTmUVuGW; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KTmUVuGW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBD+kEEjF28DAHUagoBGAJf/d+tPGhvqE++dJfwmpWh0zNqQisbkvywsl3/t3uiHE3EqiGFkz3SXAN51QBJG/3fK2FX5YQYuhWEsjdfgMOx0Z/TYEUsJMBFDRLBpPue7BzPqjvLBxam7BQyvtDFMaRv+v0dyBHfP9o6E626U2eau8j8PEe+mi53umpXW6X2/r2biu+HEjUSpZSuaFc2CxMkPYPByG8L9sak0R49+bxWbOVht/xO/7aJ8Gti8FQEl+sFUkOrLWILlVX+4mYI69WWxez0PiHZ0pvDDJk91JzE7jGHgmq6m4EXkMqZ9iuWc2FL2qB4E8LmE/9gVAab0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhjwHwYTls+CjgEhGJgQ/df2dRbTe2fDTgVh6bljm5A=;
 b=YSrggRFuYbC5I5PSjFk9nwyqd5rcVTmLDCXJzWISNLhOeURENv257GjWpUiA8bZYSnXMfXxVehPIxLjc8QccR4YF9p/4aH21GpJgopEBYO7kWDDf/lvlFuHDhHx4VHIsgdq7VaOpoYzo24okGjTbznnb6m/MAKnYO42mY/6PSDSgNgCmRW8rJszHco+C/pxFAvBrFh3+liOBtjTjLqw5IfPXYHV99w35WZ/kf4A8+swrkFPnqxG8btmAIlSYwTOzo9/p/8Wo/wMP1Ffv5Shg6Nu8JTmOnQdpcpstGCJ15vCanGcEIPOCwm71fVywqU0EFLVspDDe8cpEQKzKcH57Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhjwHwYTls+CjgEhGJgQ/df2dRbTe2fDTgVh6bljm5A=;
 b=KTmUVuGWn/07PY39qjDh1KfOqbuXQmifamfK5dhUQKfT12kZpAIaApQXSaDghXLYUIwekTrwvs1kXAeTw97WFOfDNDD4lhuuqceRKmZcemNHD+Cxf94cWQP6mXgzlIvsV7YxOfU+xkUFKhw+19kME7ZvDJgpl61Eg6tHgxTJTSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 18:41:06 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 18:41:05 +0000
Message-ID: <a24fd871-2589-46eb-8117-ec8cfa5f720d@amd.com>
Date: Fri, 3 Apr 2026 13:41:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joyful Lee <joy@joyfullee.me>, platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <20260403180422.GA341023@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260403180422.GA341023@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ea02e9-7710-47aa-9079-08de91b0906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vk1iPMpwJSDm+w8+GZ7B6R2awlsE57zFyrgwcUG5Ru7xFS+53ai0ylBvOZBBV2Npb9h8GSQH1Ep4JxbFsPZFr9YEt9DygfKJy8m4AajayYSeJc5+O7nNZOlyB77604myoxvnJPfwc1bA6WT4rTNbmGgiJkuz1/T0f/fLVy/XnfNO7hmSNXMif2+u2bniJddphc8Dz9z9VvD9lhDnFyszfAbfhTd5eAXdcunRIzBmNtp+DsRxglDNuc77sCUjUMvSWwmt4eNWKRDXIhsaVvKy+h3aE9TEE5fL2zER+u4j7Lr4gsLrMTFL9cFDAueVCmM0dh3wlLPPgUgsUMjgPe1p6wUOr6mi05m9hEpAIz50S9iMwtXUI9ia8Mavi1MCM2yCXnKb250LuL00JkZDQtS6UiBgmuPYXt/JvIg+1j5gN91/AE/quWOLPPZSkwtxQZWUDRqsUl4BAJCfYVXmo/YCimpGDreVJ43QT5d4EH4alE+gTVCajx8diRLZxvi/AzStt9xsc/xBJfQ6sCvz4DYfXE0yw/3nXXsbk3EzfwTzP24hJ+CToc46EzqaDyzWyKFsqbh8wrMqdeCocFzogjtxpwV2zpGs8z6De/NkGE4OcmjhEoudCyMzWEFVj6/oCQ+PkPCoVGkunbShmWK6+iblyUzXAihcj9ABmF54+G+N4tfAplteqnPPPLImZyoeiDVwd2FycCOach4DiYZA9JsElojWausiPZdH1gV7rHM731g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3I2dm9LZ3dibjgvZFNLeUNNa1RpTm1PY1pmUjJmZWpBWklOWlZGdTFlOFI0?=
 =?utf-8?B?ZWU4TkdYbnlEQzEvZFNJdG5Vc1VUVkF3Z3plVUxPVk03SE02YnhRL2g4YlU5?=
 =?utf-8?B?bTdQS3k0MnZicFVMdWR4K29DN2I5Yy9RQ1AvQitxeVNPM3VoVEdWUi9MRGhU?=
 =?utf-8?B?RWd6M0VxN0E4REtIbHo1U1dTZUR5c0d4VU85cnRUTlhoQXBCQWZDUXVrYURV?=
 =?utf-8?B?QWcwZFVHTzJrZzB0V1Z2UXNscU43WDFYNnVqZjBCNVpIU0IweWV2ekpoTXo3?=
 =?utf-8?B?M0ZDc2s3QldEUll3aFNYOCtuM3VDUXdyKzJMcEZLcGFjTDJiSDdWbXA0b0wx?=
 =?utf-8?B?cDVDaXRpamtDSiswUWpUU1lYa1pLUktMMGJiTHpEM3RqRnV1SVlhdkR3WXdC?=
 =?utf-8?B?WWZHeVExdG54TXZOa004Z0ViZkM2TDh0RFIrMm9wUTdiaE5PVUF3WkhkZ2Ju?=
 =?utf-8?B?Yjc5WGt1cGl1RUI4c1VVYnNEd2JXb3NLNlNnVWwrV0hqZjhyWnVQS3NaWEQ3?=
 =?utf-8?B?bHNFWmorZHd3Q1VZMHBvbGZsRmljUFBmdTFiOXRUSEE5SEh6eEd3MzhlTDdF?=
 =?utf-8?B?d0gvNnV1RGhNQzk4bHVERFBSOEZxcC9oZ1ZqUnVGZzc0aFRGSStuSm1keVhZ?=
 =?utf-8?B?V0xnY3FUZGVyWHN4TCttYVlqNnVwOG0rR3RiZ2JSaG9KRzZVU21JOXQ0YzVu?=
 =?utf-8?B?U0g5K2pwSExrSXp4SmJPRkJSR3J2MDdBZStuUFFQcXNSMHlZTWxaQTlLTjk5?=
 =?utf-8?B?Vk1MZThlU1hGQ29jZmpmN3NaMGZRSitDelVmalprZVRMMVRpS0k4MVZDSXV3?=
 =?utf-8?B?OWY2WEZ1dlFkZDlSWG92S0RMRDR0RWw5L0dxbkZGcEU1NnI1QWFaakVsZU02?=
 =?utf-8?B?R0oxczJNK1ArRVNlYzhkUEprOUw3elVqZXhzeWk2TnQ1THNoQldFV0NmK3Bs?=
 =?utf-8?B?TnZmMUR6YVVwS2Rna0x3UVhaUWNqek81cTA1eWsrNGpTMHN1aFIxankxRGZH?=
 =?utf-8?B?MlZtbnExemtValgrV2d6NUE2ODBIRUxWdWZScXMrbkRyRGpKTTMyQU5VTTFr?=
 =?utf-8?B?UStzQko4bjMyM2FBQlJJeVZnSFg1dUJybUx2OG4rZWRkbWtTODFXMlh4M05m?=
 =?utf-8?B?TFowSzBRSDdGYXZvWjJvdURqNGtEV1RKckxIa0VzNUFEdkF3RTNhNUZ2L3F3?=
 =?utf-8?B?Z2EzUElXWFBPZkUxWUhDK2RidmJiZnJiOG5pSjlzYTJjOHkzWGczQmIvRWxY?=
 =?utf-8?B?a2dKbWpacG5MVmxXR1FEMXZsa0xZOEh4RU1nb29JSjQ1K0VXUHlQdzRsWlBM?=
 =?utf-8?B?bDNBMzIxQ003ZHE4MGo5NG0ybDdOeGdudDNUQWFkaHliOEhzSWV5bVVWYXpo?=
 =?utf-8?B?bDhwR3RuSGNPSjZoUHhwQUEyRFByR1NxUGcrYW45UUNYOFl0UDFqYlNlcXUw?=
 =?utf-8?B?eEY0aWRSdmM1MUFPTFM0T0xCcGI4NVF3WWJTU201eXlUdHdzTHh1anZrZEVS?=
 =?utf-8?B?cjRZMmd1M2xSV2RjZmJiR0dkZDVQWjhNNVAvVEd0M0VrVTd3Z29UZ1d5YWVl?=
 =?utf-8?B?SmdjbWdKK1Z1MkFTT2NFNHAwOEc1K2tHdGVhQjJHRW0zUE8vQzFFckhXcmZ1?=
 =?utf-8?B?RWtxTjIyR05XMWQ0WEIxTkpUanV2NzN4MWNSMy9idlE3c0o2dDZicFhoSk9u?=
 =?utf-8?B?WG1HZG0wQytyRGQwTHUvb0d1cG1mRUFBM0poZ2xQVWNVa2o1S1ozMEh4WEpn?=
 =?utf-8?B?Z3ViYzBpN25nVGp4cWdTelJWbWV5Y3E2dHdZcmFrOTRZYTAvd3lhVjRPcHQx?=
 =?utf-8?B?dDZORFZtNHh3cEloLy9OcWZ4UWsyMGdVNFR1TVpmUWR5VUxtdlgrcEgySXV2?=
 =?utf-8?B?WHpKak1iWWhCdDRHSjlKWDdSR1Z2YUxkZjJjU2c1a2JzU29EOU9KVlFqNUMx?=
 =?utf-8?B?S21kc3NEdE5zbk5jTDlCUlkxYlovNVJGTTRwcStVMnd1WHM4SVYra09mNWxr?=
 =?utf-8?B?Tzh5a1JReUd0SWxBWFphYk5PbGpleWJ6dnRWRCt2RmlkVm1qT3c4bStKd3RZ?=
 =?utf-8?B?RkNISDE1UlBkUHNoT1BEK202MmpjeDc5N1poemNSTU1xL1dIbkNVM0lCcWhO?=
 =?utf-8?B?U1NmbTFTVUZibUFyRDhLaTdub3FTKzM5M2VCeFJnamV5cERMYmFDZU5VQ1Bp?=
 =?utf-8?B?WTVTN1IwUDVlTHJQR29jYjIrekNicUkrQkZ1RzFiUExVMGdtaVhDYkorMGhK?=
 =?utf-8?B?ZlRYT21qdTFXWHRQdkpXbTlBeGs4cUVjN1ZNOXo0QTZlczQraG1zbmxlM2M2?=
 =?utf-8?B?cE9yeVJ3UFpDUTJ6NG1pTzIxTEZmK2VJVG8zRHBsSzBkT2IxdFgxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ea02e9-7710-47aa-9079-08de91b0906a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 18:41:05.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFeYgLM0eyrZ0AQvShiY5nwRnS6tHHXju4TOJ5z+UGgEJnAe2eK7K/d9RYfxQLnMwJA/iTn4aCBoJ0wOtojOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

On 4/3/26 1:04 PM, Bjorn Helgaas wrote:
> [+cc Lukas, pciehp expert, beginning of thread with full dmesg/lspci at
> https://lore.kernel.org/all/CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com]
> 
> On Fri, Apr 03, 2026 at 11:48:15AM -0500, Mario Limonciello wrote:
>> On 4/3/26 11:19 AM, Joyful Lee wrote:
>>> On Fri, Apr 3, 2026 at 10:25 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> That's really unfortunate to hear.  If I was in your shoes - If not
>>>> solved by the end of the return period I would return the machine and
>>>> purchase one from a vendor that has been testing, fixing BIOS issues and
>>>> supporting Linux.
>>>>
>>>> I'm not going to pick favorites, but Dell, Framework, HP, and Lenovo all
>>>> have offerings that they do this.
>>>>
>>>> By chance does the BIOS offer access to "AMD PBS" or "AMD CBS" menus?
>>>> If so, there may be an option nestled in there for dGPU D3 behavior.
>>>
>>> I got it working. My kernel, which I build up from defconfig, was
>>> missing CONFIG_HOTPLUG_PCI_PCIE. It makes sense, but I wish there was
>>> more evidence that pointed me to this option. At least we can close the
>>> loop here in case anyone else runs into this problem. As a side benefit,
>>> enabling this option also got the dGPU to enter D3cold where before the
>>> lowest it would get is D3hot.
>>
>> That's great news!  I'll add a check to flag this in amd-debug-tools too to
>> help anyone else in the future.
> 
> That is indeed great news.
> 
> But as you point out, it doesn't close the issue.  Somebody else is
> going to trip over the same issue.  Most likely they will not report
> it and have no idea how to fix it.  Even if they do report it, we'll
> have to go through this whole debug process again.
> 
> The kernel should work correctly (possibly with increased power
> consumption or some other non-functional issue) regardless of whether
> CONFIG_HOTPLUG_PCI_PCIE is enabled.

I do hope as part of this we can reconsider why CONFIG_HOTPLUG_PCI_PCIE 
isn't part of the defconfig in the first place.

defconfig doesn't work on any hardware of mine by default and it's too 
much work to figure out what to add to it.  So I always start at distro 
configs and peel back for my own use.

But, if we could actually make defconfig *usable* for general purpose 
kernel users maybe more people would use it.

> 
> How can we make Linux smart enough that if we're lacking pciehp or
> whatever is necessary, we automatically avoid s2idle or S0ix or
> whatever causes this problem?

I suppose we /could/ have CONFIG_AMD_PMC depend on 
CONFIG_HOTPLUG_PCI_PCIE but it feels like using super glue on a wound 
until we know why this happens.

> 
> Here are the obvious clues in dmesg during resume from S0ix:
> 
>    pci 0000:00:03.1: [1022:150b] type 01 class 0x060400 PCIe Root Port
>    pci 0000:00:03.1: PCI bridge to [bus c4]
>    pci 0000:c4:00.0: [10de:28a1] type 00 class 0x030000 PCIe Legacy Endpoint
>    pci 0000:c4:00.1: [10de:22be] type 00 class 0x040300 PCIe Endpoint
>    pci 0000:c4:00.1: extending delay after power-on from D3hot to 20 msec
>    pci 0000:c4:00.1: D0 power state depends on 0000:c4:00.0
>    pci 0000:c4:00.0: Unable to change power state from D0 to D0, device inaccessible
>    snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot to D0, device inaccessible
> 
> It looks like something is wrong with the 00:03.1 Root Port config
> space after S0ix, e.g., the HwInit Port Number is non-sensical:
> 
>    00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge
>    -               LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM not supported
>    +               LnkCap: Port #247, Speed 16GT/s, Width x8, ASPM not supported
> 
> but the c4:00 device below it seems completely inaccessible; maybe the
> link is down or the endpoint is in D3cold so config reads return ~0:
> 
>    c4:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD107M
>    +       !!! Unknown header type 7f
>    +       Interrupt: pin ? routed to IRQ 255
> 
> I don't know what pciehp is doing that avoids this issue.
> Understanding that seems like the first step in avoiding or fixing the
> problem.

If I was to guess what's happening here is the firmware* has never been 
tested with the PcieHotplug _OSC negotiation failing and there is an 
implicit assumption on that working.  All Windows testing has that in 
place, and our internal Linux testing has always been on kernels with it 
too (see defconfig comment above).

> 
> Joyful, could you collect a dmesg log with pciehp enabled and with
> this kernel parameter (the quotes are a required part of the
> parameter):
> 
>    dyndbg="file drivers/pci/* +p"

* I don't know if this is an ASUS firmware or AMD (AGESA) firmware issue.
