Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:8228
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752117AbaD2CrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Apr 2014 22:47:22 -0400
Message-ID: <535F12B5.3080209@amd.com>
Date: Mon, 28 Apr 2014 21:47:17 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Myron Stowe <myron.stowe@gmail.com>, Borislav Petkov <bp@alien8.de>
CC: Myron Stowe <myron.stowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	<kim.naru@amd.com>, <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, x86 <x86@kernel.org>,
	Borislav Petkov <bp@suse.de>, <sp@numascale.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] x86/PCI: Support additional MMIO range capabilities
References: <20140419025308.2408.51252.stgit@amt.stowe>
	<20140419025323.2408.88764.stgit@amt.stowe>	<20140419135219.GC8109@pd.tnic>
 <CAL-B5D1UH44DvTyz=FNM-yMnct05p41P_GriUi3fXVN424R2Gg@mail.gmail.com>
In-Reply-To: <CAL-B5D1UH44DvTyz=FNM-yMnct05p41P_GriUi3fXVN424R2Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/28/2014 4:19 PM, Myron Stowe wrote:
> On Sat, Apr 19, 2014 at 7:52 AM, Borislav Petkov <bp@alien8.de> wrote:
>> On Fri, Apr 18, 2014 at 08:53:23PM -0600, Myron Stowe wrote:
>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

.......

>>> @@ -118,6 +154,12 @@ static int __init early_fill_mp_bus_info(void)
>>>
>>>        pr_debug("Found AMD hostbridge at %x:%x.0\n", bus, slot);
>>>
>>> +     /* We enable ECS mode prior to probing MMIO as MMIO related registers
>>> +      * are in the ECS area.
>>> +      */
>>> +     pci_io_ecs_init(bus, slot);
>>
>> Well, if enabling the ECS failed somehow, you probably want to save
>> yourself the _amd_read_pci_config() calls further down.
>>
>> Which means:
>>
>> * you should propagate an error code from that pci_io_ecs_init() function
>>
>> * you can carve out the huge loop iterating over AMD_NB_F1_MMIO_RANGES
>> along with the pci ECS enablement call to pci_io_ecs_init into a
>> separate function and thus slim down that huge early_fill_mp_bus_info()
>> monster a bit.
>>
>
> Yes but this was not trivial since most, if not all, usages ignore any
> return value.
>
> I'm wanting to focus on just fixing the issue for the most part and
> making as few changes as possible.  This is primarly due to:
>    o  The lack of engagement by the AMD engineers (Suravee posted these
> changes but has since been unresponsive),
>    o  As Bjorn just mentioned, we would like to get rid of this entire
> file (as we did in a similar manner with intel_bus) as it is just an
> "endless treadmill" that needs attention with every new HW release,
>    o  I want my name to be minimally related to this  ;)
>
[Suravee] Sorry for late reply and did not follow up on this patch in a 
timely manner.  Also, thank you Myron for helping to follow up with the 
patch set.

Regarding the error code from pci_io_ecs_init(), it is currently always 
return 0 (success).  I am not sure what error code should I 
check/propagate.  Let me know if I am missing something here.

......

>>> -static int __init pci_io_ecs_init(void)
>>> +static int __init pci_io_ecs_init(u8 bus, u8 slot)
>>>   {
>>>        int cpu;
>>>
>>> @@ -389,9 +472,7 @@ static int __init pci_io_ecs_init(void)
>>>           if (boot_cpu_data.x86 < 0x10)
>>>                return 0;
>>>
>>> -     /* Try the PCI method first. */
>>> -     if (early_pci_allowed())
>>> -             pci_enable_pci_io_ecs();
>>
>> Where did the if-check go?
>>
>
> Good catch.  I assume Suravee didn't drop this on purpose?

[SURAVEE] I dropped the "early_pci_allowed()" here since I have moved 
the calling of "pci_io_ecs_init()" into the "early_fill_mp_bus_info()" 
since I would like to enable PCI ecs access at earlier stage. The 
"early_fill_mp_bus_info() has already check for "early_pci_allowed()" 
already at the beginning of the function. So, this should not be needed 
here.

Suravee


