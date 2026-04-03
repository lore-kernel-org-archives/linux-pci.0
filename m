Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245632ED58;
	Fri,  3 Apr 2026 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243506; cv=fail; b=ExIo6pRoXj4U/JA7cvE1x6uWvvSV93KqXOaHKJiMlAJIM8f9EgcG3WcaxhdgXzfT/nFOuOs3YoC0a0giBP5P4smt0jNOZ9jtMAsJ5bpTE8JR90dKP8Ut6AP3tE751e44Yv4sSKb1a7etHKBQ/e9DkiOargwL7RttrComklRzvsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243506; c=relaxed/simple;
	bh=629ojJPJV364HO3CYzLUuGVejtteBgZ4EoX3NmPeqUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qco8vtIl5Rn8zKfWJOMaQ68r3m+1QYs7oamWyke/RLMR/QxSMShHtvx+jzGyHeHq211nzG+HDVdSOP0YgFVPF8L1hOrS+7ZeY5mjhzjNl1KdRn+n7aRBu5/JsN1CqRTKFwLmUHP0V2MRXkFXH43OjJZqgsaqP4kawUIpkKotvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iaf7Aduy; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iaf7Aduy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx1ZNUSVVlXwJtI5iKVN/THbE/qcQRmqlIlmZcZz9e5PlsygslBIP0jFrHVt5gHnD//oRjLxUPnc3btB+fW2b7gOjGfw1rd9ypAm4M7ej67SmhzQ7uHA0PyPaX7Qn4ID4H1d0YEdF5nxo+WQEuCeCTTtuJR/ZxHL+QJoTlcmDDuXtx5BIkxRjSFuSpsW79CGBFiKeaPR+GNStwcNIBFChQ+RL1oaXY0aJ9PudnsMtvxA/jZp4jGmKmGNuyG6602OTDJqFWtmIBFXnlKTXe7tzI7DIhxIvflfsIW1+Es2pletniogjibGf+CFWtI5ammxen8KEN6mGpiKT5o09iFJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPUfx3LI15D0Lbbq3MgJ4NWErTX1/repul4PHd7syu8=;
 b=pUu+jwKLvUSraCkcV1mLB5R9ywe3tG4Aa8aTy7XHaBmyN1hbAGcXtu+I49kAATFL6FLzycDQ61VfyCNDg9asyLB8f+9WwCXujcJprZW8rF6buwKpH1uImSEnVox7dUdTzQWYT0iACxPZ9RJb6uL/h36MTulhL4UqrzXPeyr4HHWxdDr6QKs5EfoH0j28Yv/3643jvSdrr+cQ9zNLGBW3ZSDluujq5qSa5FEQ0z8jg+iPWgS4EVCGrt+lY9oEg63DLL54alYWubG6bPC6DzcwfXbDOnhjIcgkRZPVj5nY7sKdb881f+7OOveAtG1YSblcCMI2PKifzrp+GuGhXJV1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPUfx3LI15D0Lbbq3MgJ4NWErTX1/repul4PHd7syu8=;
 b=Iaf7Aduy1zyEUR9pISJ9bnxzktrWbwHQSocf87GKUmFWxER/zQHLI57JkQGUzZmF5+u3kJkdLpo2mVM8FH/+mWpr0D6JxjKav/9G8pX+oNmCnaGIGWiw+R2CfOgJQRQJTcN3hO/PdFOBfQTe9/rMFKF0hvYneAs8IwA/h2BpDAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.14; Fri, 3 Apr
 2026 19:11:39 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 19:11:39 +0000
Message-ID: <1e6a0d34-beac-4d04-b2e8-80e13a80db03@amd.com>
Date: Fri, 3 Apr 2026 14:11:36 -0500
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
References: <20260403191020.GA348076@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260403191020.GA348076@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:52::39) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8b19a5-3402-4e65-af2b-08de91b4d578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2/ApiLU6O/k11G3uVK2Nt+ZO3LaY/ABm5fDPj7mzrvd++iObPBIPurL7TT846RTHnmeuw9uKGcW4+gPyQFAECS/JLEDBXT1kgeMI/gy49KR65LniuvetQvPf+4aNrYj+byb6WRvXSZ+4tBzzEO6Qc5+O2aqOR7U28Sv/NhVXR+Aa/yl73khasKHR2NMCjKbum91BA7tWvcfl0CXIgIIFK0SfuXmnFcyI2a+QRe6fgeg+zLdOjOhJ3zw5zCWvql5y7m9ADFfqCjKUL4ZFWX1tPYpctS+RM67r2NLmHva0jfK6F0FpoUvbfk0gL/gJOTmvqpGog1p6P/DcOnofic6684dMP29mLDGNEwZ2GVczn6uwPFL6T2k4KN4ne8aACIc9OOvcwjQcy5sOoDDUzWW/iKNVXpioTqL1p60BGl1rOeh3NTFwSAkkHngliPccRWWyPtkFXuwCJuej78ZZesOOff79H01sC76QP6ni0NCQIB+FHgtrrxKlwyc75aODQZuH3WAdquNTFKvpwyrwTas3yvee69Rl5MdDhiQGQY9g0S0Mcn03wVjavRmHrfBhP2nhLQRfhoUYaSk0kLLRJlaPVEHnhuWRfrguKtBgot8fb0YUVJjPRDQW1cj1HvFCmqjJU66VLMiReDRfa5aplFOGiTQwTXyK/PnNm4ubetvyvD7viA/+F8y3+cKRb6f6QZVJGKzOnKKEXXAKKWv1zV6GudKrhr2p3IMTumOvIagY7v0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJYWGRWUDU5VUtVTEtXby9UZ1VIRTBGWHVHTzZtL2crdHVjZ1lmalYrd3dI?=
 =?utf-8?B?bXVxc1JTR0Rmd2l6SGo5ZTZWTjhKM1VGWTMzVDZpOVIvWTlITjVNdDdnajhG?=
 =?utf-8?B?ejZSbEtWMTVOTC9qRDdHcHFzSDgzdmNqS1ZaQkhMRlhpMlgxZk5VaGJKME9R?=
 =?utf-8?B?VjRPbmVlKzdPZ2paQTR6LzVtMWtSTi92c1IyWHB1aDY3dlVNVVFWMDhicXFO?=
 =?utf-8?B?K011dVQ0UTdzYkJoVVpzUStINEluK24xRXlvVjdBVXNGR1BDN2NJZU1XTjZS?=
 =?utf-8?B?OGFSZlJjZ3BzMGNjZDJQRjg2c0V1cnVKd3c0UjFwd3IxcFpubHIyb2s1M0lt?=
 =?utf-8?B?Y3JONFUxWEIzVnlaT3FLZitwemsrbkZkOWMvRnk5RHFQb2t3VnFqemNTZ1Mx?=
 =?utf-8?B?aUxBUlZ4ZGhCaXllM1ZzdnJFYkpBWFhHSTlseEVnc0MrY1FJTnR1aTByZGhI?=
 =?utf-8?B?TWZtSHZUWjVOTDlNbTFxcVZSK01zUGhKMGxMbXVpNFUyT0xFeEZ2VFZoM1R3?=
 =?utf-8?B?aXhTYWFrZ09DdGNqaTZMcm9YZHQ3RXZCZlBlbXhianYzVlpBazRrdWtpdnpv?=
 =?utf-8?B?L3BUL1k3T3Q5Z2tBUmRzOHhRMlg1WjJhN0dSSnR1RXJtV3kxSlNXRUd2aTY5?=
 =?utf-8?B?RlgvblhjSXVhTk96dFJHWXVxSStadTZ0QXhlR2Rnb0l4QnBpVEdnaFZQL2hI?=
 =?utf-8?B?cGhDd2I0Z0hnL3h6UXlhZkxzSko1ZFQ0NnNHbTNqOUZSQ2c0T1U3b041cVo2?=
 =?utf-8?B?M2xsVGNhamREZFhoUXNYTkROTGFYZ0VmVUFBMjFRQzhxT2RvK0dTRDJtSjY1?=
 =?utf-8?B?K0FESkdlOXE2Q2h1T0JDOVRobFVCRmZjOWJSUWNOVE02M2JNeWNrR1JHTkgw?=
 =?utf-8?B?V241VWQ4VzJtcm45TS9IdHcrKzFBV0FuaHpzYlN1bVlqZjVXdTFaVnhPc2FZ?=
 =?utf-8?B?Z1BXWTNHTnRGN3ErNmRFdnNNRndyNVpXS2p1NDdwOFBHNml3UjVYcVRSMFUy?=
 =?utf-8?B?bzZRbUdKSDVaSTJENTl4OWc3ek5TS0taKzZsSVcxeHYwYTBlbXlGNUN2czJI?=
 =?utf-8?B?Ym5ibFVyMWRsOVdHTHI2NDk3L0lRVFRVRWN0SnNCT3Q1c0NMQnlKbWhBVVZZ?=
 =?utf-8?B?dnFwM2FtL0RFdVJVTkdjWVdYN0RWMGNxQTV2Rkt6Z2cwYXlQeWJ1SmxNMHJ3?=
 =?utf-8?B?RW5yR0NVa3d5YUM3b2FORGFCOVVzMDlkMEJkd0xKWjZrdEZubnNydXp2TkFW?=
 =?utf-8?B?aVB1R2UzUDBiYUVjeEhTYTU2eVRIVG5iay9iVWN4dnphV3VLWWtwZDB6Z2JX?=
 =?utf-8?B?bFFMLzY5czgrK3NndlNCTE5xWHNQZk53UEhzZTVCN1Z0UVhsa0I0eWQxdmlx?=
 =?utf-8?B?SS9hUHo3dGp5dlVCek16MmJIOWc2dHhVZnJ4WGxEdndNaHJlVFdrNlB4a3hx?=
 =?utf-8?B?OXlsMVVhWG9BaUE5MnJHaStPbC92cnZCUnhENW95dEFPanNFeUEvN05YK212?=
 =?utf-8?B?c0NDTHBYQ2p0L3lmL1ZINU1kZm5vL2ZZWC8yUlhxb2N2ZW5tTVZWNVU1Nk9T?=
 =?utf-8?B?V0JKV1hkUy9HWnlQTTlFVnlyZWhyaUFXUk5LNllXQzJ2cklFdE81QkZpMkp2?=
 =?utf-8?B?WDB5QmYxVDFUNklNVTZkazZkcDAwYlh5NVNDQko5VVJ1cEFXRDE2bkQrREJM?=
 =?utf-8?B?MzV4ZGhwb1lpdnFJS1krK0F6eTFtM2sxUmVtc1Bjc1dFMmJJaTk4THp0NGdC?=
 =?utf-8?B?SVc5bFBGOXFsUlJRL0RIb3ZWU05TOThzVkdNMmxNK3hGaUNFck45djFxbXlj?=
 =?utf-8?B?Tk5BYi95ZFQ4TEhCNFgrdytjaXRjUndidkU4MjlGVndjSW5QNlJubll1Mm5i?=
 =?utf-8?B?b0t1anRoWnBkdGl5STRxR0pRb0JHaEp0cnI5aExYa1FHNXZ6WDFwbVFhOXF0?=
 =?utf-8?B?S2szbWtQKzdSSkdmMU5pTnM0NWMzSFRKTTBTZzhtOUo3aWVyY240Wnh1Z0VI?=
 =?utf-8?B?ZG51U2FLNUcxc1VlWE9NVnAwWjAyNEp6bEZ2TFQ5NjluaUJZR0xLTC9vS1Zh?=
 =?utf-8?B?STl6aTQ0Yml0cWVUWmhPbzlza3ZGZkhEVU82eDRtbFBRQnhiamMzWGlhNVhB?=
 =?utf-8?B?K1N0R29NUk83VUFaQWttL1pPeTZvZ2NhcVdIYWUzZXFqQksvN2QxMlZvSE9V?=
 =?utf-8?B?ZEZTS1ZvZVhDakVWcU5zSm9SUXRHaTlxSW1rQnllQW1GR2xaOUx1Zmo2T1VX?=
 =?utf-8?B?N0NSV0FpOEJ6akd2U0JlTVJxcitMaVp5cVhLamtZNG02K3IyQnR0SWdSb05L?=
 =?utf-8?B?dkhUbVZwQTNrTFlzaURZdjZoMTNtaGo3UVZ6eFp4b3FzMVpGU3J5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8b19a5-3402-4e65-af2b-08de91b4d578
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 19:11:39.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPyFzHh3I82ZF6PBKmuihnnR1RyAjLjpqArWQ0gMNwBUANOaYTVxwUzj6BF4LXJzhcF7R9etgIMfM86H93ZUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416

On 4/3/26 2:10 PM, Bjorn Helgaas wrote:
> On Fri, Apr 03, 2026 at 01:41:04PM -0500, Mario Limonciello wrote:
>> On 4/3/26 1:04 PM, Bjorn Helgaas wrote:
>> ...
> 
>>> But as you point out, it doesn't close the issue.  Somebody else is
>>> going to trip over the same issue.  Most likely they will not report
>>> it and have no idea how to fix it.  Even if they do report it, we'll
>>> have to go through this whole debug process again.
>>>
>>> The kernel should work correctly (possibly with increased power
>>> consumption or some other non-functional issue) regardless of whether
>>> CONFIG_HOTPLUG_PCI_PCIE is enabled.
>>
>> I do hope as part of this we can reconsider why CONFIG_HOTPLUG_PCI_PCIE
>> isn't part of the defconfig in the first place.
>>
>> defconfig doesn't work on any hardware of mine by default and it's too much
>> work to figure out what to add to it.  So I always start at distro configs
>> and peel back for my own use.
>>
>> But, if we could actually make defconfig *usable* for general purpose kernel
>> users maybe more people would use it.
>>
>>> How can we make Linux smart enough that if we're lacking pciehp or
>>> whatever is necessary, we automatically avoid s2idle or S0ix or
>>> whatever causes this problem?
>>
>> I suppose we /could/ have CONFIG_AMD_PMC depend on CONFIG_HOTPLUG_PCI_PCIE
>> but it feels like using super glue on a wound until we know why this
>> happens.
> 
> IMO making CONFIG_HOTPLUG_PCI_PCIE part of defconfig is definitely not
> a solution.  It just makes it slightly less likely that people will
> hit this.
> 
> Making CONFIG_AMD_PMC depend on CONFIG_HOTPLUG_PCI_PCIE might be a
> little better, but I agree that it's pretty janky to do that without
> understanding the mechanism.  Seems like we have a good chance to
> understand this better, so I'm not ready to paper over it yet.

To be clear (since my super glue comment wasn't), I don't think we 
should yet either.  I'm just suggesting that if we do eventually decide 
to those are the best options I could come up with.
