Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B436308F
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072853; cv=fail; b=OjCFAvlJ6EnOa1ocKQHw7FwQ+cgSFwmkOjKdS18BHEN4HcRP5FaApLLX0xWWSdqTG34chQcGz6C1zMivhKS5GStS4cdR+rgQ8ljTm7XHPszaASl1WAMHslNsz3txY7PiXIuaibbTORuwEFm8+Ci0QR7yYgAg5V/GyRqki1Att8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072853; c=relaxed/simple;
	bh=qELzXuR32IYjN5a835kP6Xa78deBWyIskCPktfQ45sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=trUqkZiaQFoQGzldAedVAdqwEzUE2g96wCngY0q+4oXRUFxBam4xMGKujJ/FrQ1guVRKpQQoEHZpEEhCAHs2IE0l9nE4L6fUqqHZwZ/NvknkHe1eqMdS/t23nme16fNf78NW7SA9rrRND0OQRWutDi/It/z+4S4VV8Q3WsSFV1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xlgZd6ko; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xlgZd6ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isrHxqaXIRzz5AiUsO5Sf+VpsyBJH1begNogJn2y50asPBfynwH3JK6FX7cqG8Ze9mmPcV7KbrNteJUjF54Z4sd0qnpRSAvwj0ag7SVveit52eJfhfjbD4079MRqqlRb+ggmCIOpOm9SEWYmTUdODzXkw7pqcYuupnKZ0EM1pKvSu1p4rYAKf0w20f+cWFON9azB8wZnKqPQKJI7SoLJCWc3cbOAIxXhD0VwM/MwBVmnLNP6JssVKJjkxGlOkhrAYq0bVa/fq7bGe95D6Mnqo697Dn9Brna/ZYH/grW/hn1RJSL57kf1DUfjXpP8ImMcbtWddhVrGheyjwvM0JjYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imA5OMC0G1CWcqrvxcWw4tFzukJ+2QlHSXSXR8emHlc=;
 b=izs43MqtJ29VKt6XKt6du3+/H17kAHd5d5NQuBLdw8OoY7EL2FK4E3TwKyhFJM/ECu4hfGgolVRkxSbQq7I6jZjRBiJdDTywjvK3hikj9efh+KHXVrT/3EZSDeTeEMIc6YbycU8XKxYz0D9Z+d8uKCA+b/8pzfLCs5LG3RfDa9hViywO1fSB2gwlvtcer29TZUfljut51FPCt5oQW8CopaLgJqyV5kJ7Sf+OcPmdE2f0VQnX62MtSgr0WvaBndff8xUFMM7UK+cLKASF1CZ/DVKGuDkDt5p1KmbM7ylRy73MFOzZarKiW+61xRCygaNgR3L6LoxVcAPk7KnzLzrVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imA5OMC0G1CWcqrvxcWw4tFzukJ+2QlHSXSXR8emHlc=;
 b=xlgZd6ko+/qVZ7G0fDCmOtLyuPMVjq9ZKYGE+0m3WJjsdRnjuuRIi2G26VP0Nl76upIKCM2mnW5AajdDuc1/wpHWbKX3dxA5T4iAZMWBLjGzTMyN4LLZsfGbQUa4H4T293FqP+LitQFM9UBkiaOCzLJKSS0H2Lb0DnV4Qg4jvf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 13:07:29 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:07:29 +0000
Message-ID: <6651652a-cab6-4791-a883-2e7de8a009f5@amd.com>
Date: Wed, 6 May 2026 08:07:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after
 ASPM common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stuck-tamer-growl@duck.com, Sanath S <Sanath.S@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, "bjorn@helgaas.com" <bjorn@helgaas.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <20260504184325.GA656008@bhelgaas>
 <AB2EBCFC-663F-48A1-9C11-2DFB7C844B19.1@smtp-inbound1.duck.com>
 <F2774784-D1E3-46C2-8A6A-CC8932884D5F.1@smtp-inbound1.duck.com>
 <8ad6c6c8-48e4-b276-e639-ae9362cc7eff@linux.intel.com>
 <20260506123858.GL6785@black.igk.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260506123858.GL6785@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:806:23::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a37d8e-3d60-4177-8d17-08deab706d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1X6KZNklsemmlDBeyqDGcgKTAhel/TW2t1E6yl52q+rQ3H8zKS6Otf58l9IcG+ed2S5WlOvnc4/gCvZ88TjUQvRI8R+KSrh0IJwHKrV+CUAGbX00FPkIcU+SC0RpPg6AqjEzmVo+NcvbI0SGWrVLDbXW2yyIBgqigUXj3bNF0CUn2xCe54nbM3NyQSOIJt0qyu7TJTzjTiNbXxlVU+fh7DYd90f8hElyOgTf3p7tI9eLDK/aHepCqQwYRKZmDN8EwRUj6fszqHZdDifIN2LRwmhgNSnMrng1/O7MzFOsEbW7aqcJjw3zz5QOYQMMuuUbqId8QHY8HlIVGh6qmobkbCHliBprLf7eHWafzqqIi+Aa30I0Wgg1Qs9aYfYENnB2MJ37yTl1l7IRfoVZH2BbaX5X4k/qzO3VTzPANX1t4gpUSWMy3XFMiQKym1JypPaDuDLpASjQXQx3pZEAi0W4noEyq3NkeYjSdFPEPjRy+BHEdNpaGNwCVocGs5DdMxRKhVawtpSSYUGXJy3jmguqr3Te3uByc5Dzp1jwxRly8xIFd0UBEp6mOK7kC3ro0lmeh+ZMBVhErBVW55dgT6Agptuy11zj39q9WcylszVOkrejsy0EPvau3ZxZRYfz28kCV+S3pGgATVNDKvjOjAXHcGHg4YJsrGqjNIIPIhO8QU2DPyxJnylOo/qoyAICX3+s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9LVTRlSy9PRjdaY0NWcWwxRm1KMFpNNVRNeFhJSHY1UlAvNjZkRTFtYXRh?=
 =?utf-8?B?a2EvMFlsOHB1djcrQzFTOHJrOVlkblB5T0FBeTByUGVVb1ppUnBIa3Qza1ND?=
 =?utf-8?B?SWRlK2NBSlkxWW5MWGg4bkFhcEhtNk9Pd0Q0N0RzMlB2OUxSSzg0SGxUNlM5?=
 =?utf-8?B?a1dCZjJJclNhZXpkN3RQVnl6RGVUU01aODc3MEJCaTQrY2Roa1QxUTZFMGlV?=
 =?utf-8?B?dTQ1dUxYQXFTNXdYOFQ1ZXlHTnY0aUc0TnV1c0pCOE1hK21kWGVUZmorRStM?=
 =?utf-8?B?OEYwQmQ0dkhmb2RSWXRuU2pjWDRZMCtsQ3IzSnAveTJqUmNvczRsOUZXSDQ3?=
 =?utf-8?B?WFhwTGNZUjNObjFubTNKcFNZcXZXY1NNNi9rWUo1YXBZWDRSU0E4dE0vR2hQ?=
 =?utf-8?B?Qk1hbFhUOUNWTmhRWVVTQTFrRURWL0VZRWtuR0IyVEFSNTgwS3c4TWFRRUdF?=
 =?utf-8?B?YWR1NVowNTdSMmVQdjBleDFvMFEyVUg4a2ZKOU9LVnY2UmFCRDVFalZObUhi?=
 =?utf-8?B?M0VGODdzaW1KS0FxSDlKTXVEbTFyQkFhYkFtdGdxN1NMZkNxVjlVWFBKWlpm?=
 =?utf-8?B?OGQ1MnhtM3pndVY5Y0xySWxFYitIcGlnSnNHelU5QUJ2bm9wcXM4d2dYTWoz?=
 =?utf-8?B?YUdZc2ZKdG1DTWdxeit6S3k0eHJLSkh2QjU0SVBNSFBxNTEzMUVPZ1VsOUZx?=
 =?utf-8?B?eWNadmJkVDZPOEk1YzZJWExjZXVvdXBFRnZURlFQazRBTVdqYmFoUEY2Tm1W?=
 =?utf-8?B?RUkvZTVGSkNjdU1SalhsNGlGc1FiVTJwSStTcnd0VzZiVHRiN1BST2orTkt3?=
 =?utf-8?B?OTFLbEV1cUhZdVgxd1BkQzFWR2syNXVaOHlDOXBpVFNIb29aNkJIWFNrZklP?=
 =?utf-8?B?anE3Y2JRK05oSUxzdVBIeStDbjJCUWVxaHJVOWMzSWp5dEpjYVhmbjFQU1ZE?=
 =?utf-8?B?dDZDdW1ITllLemtLOTZNd3h0dldJK0s4UFZNS1Q3ZEFZbFo1MGJrNzRjb0Nl?=
 =?utf-8?B?anFXVnJYWU8xMnhOTCt0TU42YUN2cGpSUDEzQlZFdnloQ3BBeUZYZEF2OGdi?=
 =?utf-8?B?TG55MG93V1JZcmtCQkJWWEhYT0JYR1JxYlpqdi85cW1iNndFSkMxODJ0TGZT?=
 =?utf-8?B?bXdBb0JsVXFJbmk2c2I2TVFrVGJpVTh0aXgrRCtXNEpuaEQzZGNwbmJXaXZi?=
 =?utf-8?B?U0JCR0xJSURTYzN1cEZXamNHZCtmcGV6cUFTcTlyWTV5ZmlnN2tUbHhLaXFt?=
 =?utf-8?B?MVI0aFN4S3dGb0lKbVZQK2lzekxVVTJHQ09SL28zajRWeVVDWFBCWmxIU0ln?=
 =?utf-8?B?YjRBaERLYVlNbjZaK29mSVp0aGZyVnpicTc5anFTc09kYWxUMzNQYytoNm9Q?=
 =?utf-8?B?Qk1vdlVpWDJPTGdGTHVuWWN5VFRTWGJ5U2RjWUdNMmJ5WGQ5L1lPamNCZGQ2?=
 =?utf-8?B?ejZ6aEg5c2dEUTNqTHRHUmttL0VTTFBYV05oQ3VmcmFUaStOVmFZd09FQStK?=
 =?utf-8?B?OEVOUXdpUDUvUWQxTEpkSnFTZDVaZHJLNmVjcDFJSldmT0Q2OHViY3k0cjRq?=
 =?utf-8?B?TWdlU1d4S1h6L09FdmduRDF2T2oxOUZtNUdyWXowNmVGMUhUcThtQW5scEg1?=
 =?utf-8?B?VTlDMktEZ2JCbEJ1QWk4WmE1YTJ0REhPaFpXS2JSVTJJWHZST1R4WkdoT1dP?=
 =?utf-8?B?RnRyNGlvcU12RWVoTm43N2lyRU4wdi9icXQwZzk2ODJaaWdTb0lrSE1VZFhB?=
 =?utf-8?B?Sjk1bGlhOHB4NnFTUTZwVytxOCtuVU5RZEoxa1lxYllpODJTajdHK2tyWUll?=
 =?utf-8?B?N2pnemR4MDRYSllqU25QdkFmdGQ2Y1FrZ2hQVlZma3lUVzBFM2dFVWE0S3FJ?=
 =?utf-8?B?RlVFQW85QzhaTWN6UWpMZHpFZWJ3NzU0VEc3bzhmUlE3djZ3a2k2SzdLMmdJ?=
 =?utf-8?B?OUJpVmJESUJhUGRucm9SUEVxU1l3ZDZCV2hTS1JFOHZBK2gzS0czVEpUWGJr?=
 =?utf-8?B?RUlwNXQ4SHVBbDlBQlY4QnVLOGFmR1R4VXhNS3lZWW53Y21HN2JBcHFoa1dV?=
 =?utf-8?B?OS8xYjJPNkhxV0NjbFVQeGQ0WXBzM25nbHJJRnVOVTZlNWxYQ09iNmlIVlVM?=
 =?utf-8?B?SVN6a2NreTBMOXl4M0wrQWlhN0NwbXIyS09CYUhQeXBHbEk5cVR2MzhHMU9t?=
 =?utf-8?B?SGlzOXVlQjZ4djZ6eENPWnpmcFV0TFE1b3JYaFpNUUFOcGpVVW5JQ2k5R214?=
 =?utf-8?B?b0p0MHFseWZsaC9nZTVnQnFBUnBoVkxYNWIrVW8vNlJ6V2JjdEdEOHVKSUZD?=
 =?utf-8?B?SXc4U282RTZ1NFVlck9Vc1VkSzFXdW5SZkdCc0FyUHM5YjBCT1A3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a37d8e-3d60-4177-8d17-08deab706d37
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:07:29.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NM/QI6m4aYhNBNy+3o/9hrUWAqQN3EI4DL2GqMCTRRIQ0myBbLTzFBcnqa0qwFdLPeJBq9HVA4JuXz150K65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923



On 5/6/26 07:38, Mika Westerberg wrote:
> Hi,
> 
> On Wed, May 06, 2026 at 03:26:43PM +0300, Ilpo Järvinen wrote:
>> On Wed, 6 May 2026, stuck-tamer-growl@duck.com wrote:
>>
>>> Bjorn and All,
>>>
>>> Attached
>>>
>>> pristine.dmesg.txt and pristine.lspci-vv.txt
>>> cmdline "quiet splash", same kernel/hardware as the report.
>>>                                                                                                                                          
>>> Many thanks!
>>>
>>> Peter / stuck-tamer-growl
>>>
>>>
>>>
>>> On Monday, May 4th, 2026 at 2:43 PM, Bjorn Helgaas <helgaas_at_kernel.org_stuck-tamer-growl@duck.com> wrote:
>>>
>>>> [+bcc reporter]
>>>>
>>>> On Mon, May 04, 2026 at 01:29:28PM -0500, Bjorn Helgaas wrote:
>>>>> ---------- Forwarded message ---------
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=221457
>>>>> ...
>>>>> SUMMARY
>>>>>
>>>>> Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
>>>>> Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
>>>>> common-clock reconfigure on the host root port, the downstream bridges go
>>>>> through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
>>>>> MB.
>>>>
>>>> stuck-tamer-growl: Thanks for the report.  Would you mind collect the
>>>> complete dmesg log and the output of "sudo lspci -vv" and posting them
>>>> here (or in the bugzilla if you prefer)?
>>
>> Hi,
>>
>> To me it looks the ASPM/CCC is a red herring (or another problem unrelated
>> to the ReBAR size issue).
>>
>> What happens here is the entire PCIe topology is reset:
>>
>> [    1.121434] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Down
>> [    1.121439] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card not present
>> [    5.804638] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Card present
>> [    5.804643] kernel: pcieport 0000:00:07.2: pciehp: Slot(14): Link Up
>>
>> I recalled Mika Westerberg mentioned some time back Thunderbolt is
>> starting to reset things on boot so this might be related to that.
>>
>> As the hotplug tears down everything on PCI side, there's nothing to hold
>> the ReBAR size information across as far as PCI core is concerned.
>>
>> Thunderbolt reset on boot was (probably) introduced by this commit:
>>
>> 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
>>
>>
>> I don't know if the nvidia out-of-tree driver does attempt BAR resize on
>> its own (some in-kernel GPU driver do on their own outside of PCI core's
>> resource fitting algorithm). At least there's no indication in the log
>> that would point to even a resize attempt happening.
>>
>>
>> My resizable BAR aware resource fitting would eventually solve this but
>> it's not yet ready. I'm currently trying to fix pci=realloc not detecting
>> need to resize anything if the current ReBAR size fits just fine.
> 
> One temporary workaround until your code is ready is passing
> "thunderbolt.host_reset=0" in the command line. That will skip the reset.

A few background things of that host reset:

1. BIOS won't reserve enough MMIO resources for downstream device in 
PCIe tunnel to be able to hotplug.  If Linux inherits assignments you 
get in a bad situation.

For example:
Boot with a dock connected and no downstream storage.
Try to hotplug downstream storage.
Downstream storage doesn't work in Linux.

Boot with dock connected and downstream storage connected.
Downstream storage does work in Linux.

2. Windows does the same thing.

