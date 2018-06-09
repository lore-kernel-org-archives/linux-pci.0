Return-Path: <SRS0=ytgX=I3=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=ytgX=I3=mobiveil.co.in=l.subrahmanya@kernel.org>
MIME-Version: 1.0
In-Reply-To: <80853b92d0f69f32f2f0e2bbcd106993@codeaurora.org>
References: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
 <20180606125025.GA100923@bhelgaas-glaptop.roam.corp.google.com>
 <CAFZiPx0UUB25kOgSNzUruNLom4=F5y==QbF_Q2g1uPA7csGOHA@mail.gmail.com> <80853b92d0f69f32f2f0e2bbcd106993@codeaurora.org>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Sat, 9 Jun 2018 15:38:28 +0530
Message-ID: <CAFZiPx3oJQpsg3SQ_6ZbLdJto5JHwcpvuh16DOgAK7HbhTuxdg@mail.gmail.com>
Subject: Re: pci_error_handlers for pci_host_bridge ?
To: poza@codeaurora.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Poza,


On Thu, Jun 7, 2018 at 4:20 PM, <poza@codeaurora.org> wrote:
>
> On 2018-06-07 15:45, Subrahmanya Lingappa wrote:
>>
>> Bjorn,
>>
>> On Wed, Jun 6, 2018 at 6:20 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> Hi Subrahmanya,
>>>
>>> On Wed, Jun 06, 2018 at 05:57:17PM +0530, Subrahmanya Lingappa wrote:
>>>>
>>>> Hi,
>>>> according to https://github.com/torvalds/linux/blob/master/Documentation/PCI/pci-error-recovery.txt
>>>>
>>>> as part of AER handling, struct pci_error_handlers{} is implemented by
>>>> endpoint drivers to handle device specific recovery steps for "struct
>>>> pci_driver".
>>>>
>>>> But we have a platform_driver which implements "struct
>>>> pci_host_bridge" which also supports AER capability how can we support
>>>> pci_error_handlers() for the host bridge drivers ?
>>>
>>>
>>> I assume you're referring to Mobiveil.  Can you explain more of the
>>> topology here?  Can you also include "sudo lspci -vv" output?
>>>
>> Yes, it is for Mobiveil's Host bridge driver :
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/host/pcie-mobiveil.c
>> lspci output is now is not available, I'll try to get it sooner.
>>
>> we have an endpoint connected directly to Rootport as follows
>> RC Rootport ----->BUS------> EP
>>
>>> The AER capability is an optional capability of PCIe device functions.
>>> A host bridge is not itself a PCIe function; it's a bridge between a
>>> platform-specific host bus and the PCIe bus.
>>>
>>> Sometimes there is a PCI function that corresponds to the host bridge,
>>> but that's not required by the PCI specs and there is no generic
>>> programming model for it.
>>>
>>> If you have an PCIe function corresponding to the Mobiveil host
>>> bridge, and it has an AER capability, what would you want the error
>>> handlers to do?  This function would not normally be a Root Port or
>>> other type 1 PCI-to-PCI bridge device, so it's not clear how its AER
>>> would integrate with the PCIe hierarchy.
>>>
>> Yes we do have a PCI function with AER capability, after an AER reported by EP,
>> AER driver initiates an hot_reset on subordinate bus, which happens to
>> be downstream port
>> for RC. So we get a downstream port link down happens in this case RC
>> driver needs to follow
>> a specific register restore sequence, which is most of the HW specific
>> initialization done in probe function of the driver  to recover
>> properly.
>
>
> Are you looking at something similar to pci_error_handlers to be called for your RC driver ?
> where probably you are expecting during ERR_NONFATAL recovery you would want to restore some of your platform
> specific registers. I dont think that support exists now. since pci_error_handlers is of struct pci_driver
> while yours is platform driver.
>
Yes, that's why I asked this question here to ask how do we handle in
case of a platform driver.

>
> Although please also note that ERR_FATAL is no more handled with error and recovery callbacks.
> that are just going to be handled with removal, re-enumeration of the devices.
>
> but I suppose in any case you want to restore the registers in any type of uncorrectable error.
>
yes

>
> although this is really platform specific, some sort of quirk I cna think of, but again err.c has to check
> that quirk's existence and calls platform specific callback
> (that again I am not sure because such things do not exist with respect to error/recovery callbacks)
>
can you point me to any other cases this scheme might have been implemented ?

>
> Yeah just re-thinking, this is too specific, not to be addressed by generic framework I think.
>
>> I was wondering if this can be handled by using AER error handlers, or
>> would suggest a better way to handle this ?
>>
>> As of now plan is to handle this situation is by calling a minimal
>> probe recovery sequence after link down interrupt within the
>> driver interrupt service routine.
>
>
> Well I think that is a better place,
> I was wondering why are you loosing registers at the first point ?
> Is because of link down even you are loosing them ? some issue with hw !
>
yes, due to AER FATAL error link reset happens on subordinate bus, in
this case since EP is directly connected to root port,
its a downstream port link down, in this case RC is designed to get
reset to its config registers, though PCI config space remains intact.

Thanks.

>
>
> Lets hear from Bjorn anyway, I am curious.
>
>>
>>> Bjorn
>>
>>
>> Thanks,
