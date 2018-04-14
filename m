Return-Path: <SRS0=hrbt=HD=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=hrbt=HD=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
Date: Sat, 14 Apr 2018 11:53:17 -0400
MIME-Version: 1.0
In-Reply-To: <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Keith, Bjorn;

On 4/12/2018 1:41 PM, Sinan Kaya wrote:
> On 4/12/2018 1:09 PM, Keith Busch wrote:
>> On Thu, Apr 12, 2018 at 12:27:20PM -0400, Sinan Kaya wrote:
>>> On 4/12/2018 11:02 AM, Keith Busch wrote:
>>>>
>>>> Also, I thought the plan was to keep hotplug and non-hotplug the same,
>>>> except for the very end: if not a hotplug bridge, initiate the rescan
>>>> automatically after releasing from containment, otherwise let pciehp
>>>> handle it when the link reactivates.
>>>>
>>>
>>> Hmm...
>>>
>>> AER driver doesn't do stop and rescan approach for fatal errors. AER driver
>>> makes an error callback followed by secondary bus reset and finally driver
>>> the resume callback on the endpoint only if link recovery is successful.
>>> Otherwise, AER driver bails out with recovery unsuccessful message.
>>
>> I'm not sure if that's necessarily true. People have reported AER
>> handling triggers PCIe hotplug events, and creates some interesting race
>> conditions:
> 
> By reading the code, I don't see a stop and rescan in the AER error recovery
> path.
> 
> As both logs indicate, stop and rescan is initiated in response to link down
> and link up interrupts triggered by the secondary bus reset. 
> The SW entity handling these is not AER driver. It is the hotplug driver
> running asynchronous to the AER driver.
> 
> AER driver should have tried a slot reset before attempting to do a secondary
> bus reset.
> 
> /**
>  * pci_reset_slot - reset a PCI slot
>  * @slot: PCI slot to reset
>  *
>  * A PCI bus may host multiple slots, each slot may support a reset mechanism
>  * independent of other slots.  For instance, some slots may support slot power
>  * control.  In the case of a 1:1 bus to slot architecture, this function may
>  * wrap the bus reset to avoid spurious slot related events such as hotplug.
>  * Generally a slot reset should be attempted before a bus reset.  All of the
>  * function of the slot and any subordinate buses behind the slot are reset
>  * through this function.  PCI config space of all devices in the slot and
>  * behind the slot is saved before and restored after reset.
>  *
>  * Return 0 on success, non-zero on error.
>  */
> int pci_reset_slot(struct pci_slot *slot)
> 
> Slot reset is there to mask hotplug interrupts before the reset and unmask them
> after reset.
> 
>>
>> https://marc.info/?l=linux-pci&m=152336615707640&w=2
>>
>> https://www.spinics.net/lists/linux-pci/msg70614.html
>>
>>> Why do we need an additional rescan in the DPC driver if the link is up
>>> and driver resumes operation?
>>
>> I thought the plan was to have DPC always go through the removal path
>> to ensure all devices are properly configured when containment is
>> released. In order to reconfigure those, you'll need to initiate the
>> rescan from somewhere.
>>
> 
> This is where the contradiction is. 
> 
> Bjorn is asking for a unified error handling for both AER and DPC.
> 
> Current AER error recovery framework is error callback + secondary
> bus reset + resume callback.
> 
> How does this stop + rescan model fit?
> 
> Do we want to change the error recovery framework? I suppose this will 
> become a bigger conversation as there are more customers of this.
> 

I also want to highlight that the PCI Error recovery sequence is well
documented here.

https://www.kernel.org/doc/Documentation/PCI/pci-error-recovery.txt

We don't really have to guess what Linux does. 

IMO, the hotplug issues Keith is seeing are orthogonal and needs to be
addressed independent of this series by following the pci slot reset
procedure.

Hotplug driver handles link up/down events due to insertion/removal.
Hotplug driver is expected to do the re-enumeration.

I don't understand why we need to do another re-enumeration if system
observes a PCIe error handled by the AER/DPC driver. 

These two are independent events.

PCIe error recovery framework does the reset callback + SBR + resume
behavior today.

Bjorn,

You indicated that you want to unify the AER and DPC behavior. Let's
settle on what we want to do one more time. We have been going forth
and back on the direction.

We are on V13. I hope we won't hit V20 :)

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
