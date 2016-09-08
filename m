Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
Subject: Re: [PATCH v2] PCI: altera: Retrain link in rootport mode only
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1471595078-26297-1-git-send-email-lftan@altera.com>
 <20160822154738.GB18628@localhost>
 <CAFiDJ5_PnZ-oEj748ZY8dZhnFWMzK-bUYCti2ySFk5ZvLh6idw@mail.gmail.com>
 <20160824175431.GC23914@localhost>
 <2ffee400-d3bd-4b6e-cb9c-05a0c121b896@broadcom.com>
 <20160830133747.GB16426@localhost>
 <a1688079-6a39-3c25-756f-cd1e1256f468@broadcom.com>
 <20160830170055.GA22908@localhost>
 <8093b687-2d62-73b5-2d67-421eab5b7c27@broadcom.com>
Cc: Ley Foon Tan <lftan@altera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <bd2261f1-f5e0-a1e4-5dd3-a2405596f378@broadcom.com>
Date: Wed, 7 Sep 2016 17:10:10 -0700
MIME-Version: 1.0
In-Reply-To: <8093b687-2d62-73b5-2d67-421eab5b7c27@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 8/30/2016 10:04 AM, Ray Jui wrote:
>
>
> On 8/30/2016 10:00 AM, Bjorn Helgaas wrote:
>> On Tue, Aug 30, 2016 at 09:36:52AM -0700, Ray Jui wrote:
>>>
>>>
>>> On 8/30/2016 6:37 AM, Bjorn Helgaas wrote:
>>>> On Mon, Aug 29, 2016 at 05:37:09PM -0700, Ray Jui wrote:
>>>>> Hi Bjorn,
>>>>>
>>>>> On 8/24/2016 10:54 AM, Bjorn Helgaas wrote:
>>>>>> [+cc Ray, Scott, Jon, bcm-kernel-feedback-list]
>>>>>>
>>>>>> On Wed, Aug 24, 2016 at 03:07:52PM +0800, Ley Foon Tan wrote:
>>>>>>> On Mon, Aug 22, 2016 at 11:47 PM, Bjorn Helgaas
>>>>>>> <helgaas@kernel.org> wrote:
>>>>>>>> On Fri, Aug 19, 2016 at 04:24:38PM +0800, Ley Foon Tan wrote:
>>>>>>>>> Altera PCIe IP can be configured as rootport or device and they
>>>>>>>>> might have
>>>>>>>>> same vendor ID. It will cause the system hang issue if Altera
>>>>>>>>> PCIe is in
>>>>>>>>> endpoint mode and work with other PCIe rootport that from other
>>>>>>>>> vendors.
>>>>>>>>> So, add the rootport mode checking in link retrain fixup function.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>>>>>>>>> ---
>>>>>>>>> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
>>>>>>>>> ---
>>>>>>>>> drivers/pci/host/pcie-altera.c | 3 +++
>>>>>>>>> 1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/host/pcie-altera.c
>>>>>>>>> b/drivers/pci/host/pcie-altera.c
>>>>>>>>> index 58eef99..33b6968 100644
>>>>>>>>> --- a/drivers/pci/host/pcie-altera.c
>>>>>>>>> +++ b/drivers/pci/host/pcie-altera.c
>>>>>>>>> @@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct
>>>>>>>>> pci_dev *dev)
>>>>>>>>>     u16 linkcap, linkstat;
>>>>>>>>>     struct altera_pcie *pcie = dev->bus->sysdata;
>>>>>>>>>
>>>>>>>>> +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
>>>>>>>>> +             return;
>>>>>>>>> +
>>>>>>>>>     if (!altera_pcie_link_is_up(pcie))
>>>>>>>>>             return;
>>>>>>>>
>>>>>>>> Instead of making this a PCI fixup, can you make an
>>>>>>>> altera_pcie_host_init() function, call it from altera_pcie_probe(),
>>>>>>>> and do the link retrain there?  Then you wouldn't need to worry
>>>>>>>> about
>>>>>>>> whether this is a Root Port or an Endpoint, plus it would make the
>>>>>>>> altera driver structure more like the other drivers.
>>>>>>>>
>>>>>>>> You would call altera_pcie_host_init() before
>>>>>>>> pci_scan_root_bus(), so
>>>>>>>> you wouldn't have a pci_dev yet, so you wouldn't be able to use
>>>>>>>> pcie_capability_set_word() to set the PCI_EXP_LNKCTL_RL bit.  But I
>>>>>>>> assume there's some device-dependent way to access it using
>>>>>>>> cra_writel()?
>>>>>>> We can't use cra_write() to set PCI_EXP_LNKCTL_RL bit.
>>>>>>
>>>>>> Why not?  I don't mean it has to be cra_write(), but isn't there some
>>>>>> way you can write that bit before we scan the root bus?  It doesn't
>>>>>> make sense that we have to scan the bus before we can train the link.
>>>>>>
>>>>>> We want to be able to tell the PCI core "all the device-specific root
>>>>>> complex initialization has been done, here are the config accessors
>>>>>> you need, please scan for devices."  I want to keep device-specific
>>>>>> things like this quirk directly in the driver and out of the
>>>>>> enumeration process.
>>>>>>
>>>>>>> We can use
>>>>>>> pci_bus_find_capability() and pci_bus_read_config_word() with struct
>>>>>>> pci_bus instead.
>>>>>>> But this only can be called after pci_scan_root_bus().
>>>>>>
>>>>>>> Found
>>>>>>> iproc_pcie_check_link() have similar implementation.
>>>>>>
>>>>>> You're right, and I don't like iproc_pcie_check_link() either, for
>>>>>> the
>>>>>> same reasons.
>>>>>>
>>>>>> The iproc_pcie_check_link() is a little better because it's called
>>>>>> before enumeration:
>>>>>>
>>>>>> pci_create_root_bus()
>>>>>> iproc_pcie_check_link()
>>>>>> pci_scan_child_bus()
>>>>>>
>>>>>> But it would be a lot better if iproc_pcie_check_link() were done
>>>>>> first, before pci_create_root_bus().  Then it would be more like the
>>>>>> structure of other drivers, and we could use pci_scan_root_bus()
>>>>>> instead.
>>>>>
>>>>> Although not yet tested, I suppose we can do iproc_pcie_check_link
>>>>> before calling pci_scan_root_bus so we can get rid of separate calls
>>>>> to pci_create_root_bus and pci_scan_child_bus. But then we need to
>>>>> create some dummy bus in the iproc_pcie_check_link function to allow
>>>>> access to the root bus for link check, which was the primary reason
>>>>> why we did pci_create_root_bus before iproc_pcie_check_link, i.e.,
>>>>> to avoid the use of dummy root bus.
>>>>
>>>> I don't want a dummy root bus.
>>>
>>> Okay we are on the same page for this.
>>>
>>>> There should be some way to structure that code so you can write the
>>>> class code and the link status stuff without having a struct pci_bus.
>>>> The only reason you need the struct pci_bus in the first place is so
>>>> you can extract the struct iproc_pcie *, and you already have that in
>>>> iproc_pcie_check_link().
>>>>
>>>> No, you won't be able to use pci_bus_find_capability(), but presumably
>>>> you already *know* where the capability is, since you know exactly
>>>> what device this is.
>>>
>>> I'll need to review the check link function carefully and do some
>>> experiment to see what I can do to determine the link status without
>>> accessing any of the configuration registers, which is what you seem
>>> to imply here.
>>
>> No, that's not what I'm trying to say.  You can access the
>> configuration registers if you need to.  But you shouldn't need a
>> struct pci_bus to do that.  All you do with the struct pci_bus is get
>> the corresponding struct iproc_pcie.
>>
>> It will require some restructuring, of course, e.g., making low-level
>> accessors that take the struct iproc_pcie, and wrappers around them
>> that take a struct pci_bus.  The usual config accesses can go through
>> the wrapper, and the iproc-internal accesses can use the low-level
>> accessors directly.
>>
>> Bjorn
>>
>
> Okay I got it. Thanks for the clarifications. I'll look into this when I
> have a chance.
>
> Ray

By looking at the code closer, I found that we have an issue here, i.e., 
currently the iProc PCIe driver accesses the configuration registers 
using the standard struct pci_ops (i.e., pci_generic_config_read32 and 
pci_generic_config_write32). There's no existing iProc specific 
low-level code for configuration register access (well, there actually 
was previously, until we switched to use the generic code). As a result, 
unless we diverge from using the generic code, I cannot think of a way 
to make this work.

Any comment on this?

Regards,

Ray
