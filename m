Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:25131
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751613AbaD2DEl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Apr 2014 23:04:41 -0400
Message-ID: <535F16C2.6010509@amd.com>
Date: Mon, 28 Apr 2014 22:04:34 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Myron Stowe <myron.stowe@gmail.com>, Borislav Petkov <bp@suse.de>
CC: Myron Stowe <myron.stowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	<kim.naru@amd.com>, <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, x86 <x86@kernel.org>, <sp@numascale.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] x86/PCI: Support additional MMIO range capabilities
References: <20140419025308.2408.51252.stgit@amt.stowe>
	<20140419025323.2408.88764.stgit@amt.stowe>	<20140419135219.GC8109@pd.tnic>
	<20140420075936.GA19672@pd.tnic>
 <CAL-B5D1rJmf9vLSnV2izsXcbCu1idXsTsnSwoFRKFNTM7BnyfA@mail.gmail.com>
In-Reply-To: <CAL-B5D1rJmf9vLSnV2izsXcbCu1idXsTsnSwoFRKFNTM7BnyfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/25/2014 5:24 PM, Myron Stowe wrote:
> On Sun, Apr 20, 2014 at 1:59 AM, Borislav Petkov <bp@suse.de> wrote:
>> Drop Andreas' old email address from CC as it keeps bouncing.
>>
>> On Sat, Apr 19, 2014 at 03:52:20PM +0200, Borislav Petkov wrote:
>>>> -static void __init pci_enable_pci_io_ecs(void)
>>>> +static void __init pci_enable_pci_io_ecs(u8 bus, u8 slot)
>>>>   {
>>>>   #ifdef CONFIG_AMD_NB
>>>>      unsigned int i, n;
>>>> +   u8 limit;
>>>>
>>>>      for (n = i = 0; !n && amd_nb_bus_dev_ranges[i].dev_limit; ++i) {
>>>> -           u8 bus = amd_nb_bus_dev_ranges[i].bus;
>>>> -           u8 slot = amd_nb_bus_dev_ranges[i].dev_base;
>>>> -           u8 limit = amd_nb_bus_dev_ranges[i].dev_limit;
>>>> +           /* Try matching for the bus range */
>>>> +           if ((bus != amd_nb_bus_dev_ranges[i].bus) ||
>>>> +               (slot != amd_nb_bus_dev_ranges[i].dev_base))
>>>> +                   continue;
>>>> +
>>>> +           limit = amd_nb_bus_dev_ranges[i].dev_limit;
>>>>
>>>> +           /* Setup all northbridges within the range */
>>>>              for (; slot < limit; ++slot) {
>>>>                      u32 val = read_pci_config(bus, slot, 3, 0);
>>>> -
>>>> -                   if (!early_is_amd_nb(val))
>>>> +                   if (!val)
>>>>                              continue;
>>>>
>>>>                      val = read_pci_config(bus, slot, 3, 0x8c);
>>>> @@ -375,13 +457,14 @@ static void __init pci_enable_pci_io_ecs(void)
>>>>                              val |= ENABLE_CF8_EXT_CFG >> 32;
>>>
>>> What a fun shifting!
>>>
>>> Maybe you should do
>>>
>>> #define ENABLE_CF8_EXT_CFG    BIT(46 - 32)
>>>
>>> to show exactly what you mean and how the bit is defined in MSR NB_CFG1
>>> and also show how the high 32-bits are mapped into F3x8c, while at it.
>>>
>>> And then you can drop the shifting at the call site.
>>
>> Ok, I see another fun with this ECS enabling:
>>
>> There's a enable_pci_io_ecs() which enables ECS through the NB_CFG MSR
>> which is called as part of the notifier *and* there's a PCI write to
>> that same bit in pci_enable_pci_io_ecs() which iterates over all NBs.
>>
>> So, AFAICT, we do it twice and the second time is not needed. Which
>> means, you probably can drop pci_enable_pci_io_ecs() completely and use
>> solely the notifier?
>
> It does look as if there is some duplication with respect to setting
> MSR_AMD64_NB_CFG's (which is aliased at D18F3x8c [1])
> ENABLE_CF8_EXT_CFG enable bit but there are at least a couple of
> differences.
>
> enable_pci_io_ecs() only sets the bit on one NB whereas
> pci_enable_pci_io_ecs iterates over all the NBs (as you mentioned
> above).  The other difference has something to do with Xen; see the
> origin of pci_enable_pci_io_ecs - commit 24d9b70b8.
>
>>
>> Yes, no?
>
> Suravee, Kim - either of you want to chime in here?

I believe the notifier is mainly for the cores which are initially 
offline, and then brought up online afterward.

Suravee

