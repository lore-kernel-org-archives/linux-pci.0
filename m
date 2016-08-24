Return-Path: <scott.branden@broadcom.com>
Return-Path: <scott.branden@broadcom.com>
Subject: Re: [PATCH v2] PCI: altera: Retrain link in rootport mode only
To: Bjorn Helgaas <helgaas@kernel.org>, Ley Foon Tan <lftan@altera.com>
References: <1471595078-26297-1-git-send-email-lftan@altera.com>
 <20160822154738.GB18628@localhost>
 <CAFiDJ5_PnZ-oEj748ZY8dZhnFWMzK-bUYCti2ySFk5ZvLh6idw@mail.gmail.com>
 <20160824175431.GC23914@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <4975a3ff-e04e-a1ac-e6cb-6d1b3e87f377@broadcom.com>
Date: Wed, 24 Aug 2016 11:40:16 -0700
MIME-Version: 1.0
In-Reply-To: <20160824175431.GC23914@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Ray is off this week and will likely have some comments next week.

On 16-08-24 10:54 AM, Bjorn Helgaas wrote:
> [+cc Ray, Scott, Jon, bcm-kernel-feedback-list]
>
> On Wed, Aug 24, 2016 at 03:07:52PM +0800, Ley Foon Tan wrote:
>> On Mon, Aug 22, 2016 at 11:47 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Fri, Aug 19, 2016 at 04:24:38PM +0800, Ley Foon Tan wrote:
>>>> Altera PCIe IP can be configured as rootport or device and they might have
>>>> same vendor ID. It will cause the system hang issue if Altera PCIe is in
>>>> endpoint mode and work with other PCIe rootport that from other vendors.
>>>> So, add the rootport mode checking in link retrain fixup function.
>>>>
>>>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>>>> ---
>>>> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
>>>> ---
>>>>  drivers/pci/host/pcie-altera.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
>>>> index 58eef99..33b6968 100644
>>>> --- a/drivers/pci/host/pcie-altera.c
>>>> +++ b/drivers/pci/host/pcie-altera.c
>>>> @@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct pci_dev *dev)
>>>>       u16 linkcap, linkstat;
>>>>       struct altera_pcie *pcie = dev->bus->sysdata;
>>>>
>>>> +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
>>>> +             return;
>>>> +
>>>>       if (!altera_pcie_link_is_up(pcie))
>>>>               return;
>>>
>>> Instead of making this a PCI fixup, can you make an
>>> altera_pcie_host_init() function, call it from altera_pcie_probe(),
>>> and do the link retrain there?  Then you wouldn't need to worry about
>>> whether this is a Root Port or an Endpoint, plus it would make the
>>> altera driver structure more like the other drivers.
>>>
>>> You would call altera_pcie_host_init() before pci_scan_root_bus(), so
>>> you wouldn't have a pci_dev yet, so you wouldn't be able to use
>>> pcie_capability_set_word() to set the PCI_EXP_LNKCTL_RL bit.  But I
>>> assume there's some device-dependent way to access it using
>>> cra_writel()?
>> We can't use cra_write() to set PCI_EXP_LNKCTL_RL bit.
>
> Why not?  I don't mean it has to be cra_write(), but isn't there some
> way you can write that bit before we scan the root bus?  It doesn't
> make sense that we have to scan the bus before we can train the link.
>
> We want to be able to tell the PCI core "all the device-specific root
> complex initialization has been done, here are the config accessors
> you need, please scan for devices."  I want to keep device-specific
> things like this quirk directly in the driver and out of the
> enumeration process.
>
>> We can use
>> pci_bus_find_capability() and pci_bus_read_config_word() with struct
>> pci_bus instead.
>> But this only can be called after pci_scan_root_bus().
>
>> Found
>> iproc_pcie_check_link() have similar implementation.
>
> You're right, and I don't like iproc_pcie_check_link() either, for the
> same reasons.
>
> The iproc_pcie_check_link() is a little better because it's called
> before enumeration:
>
>   pci_create_root_bus()
>   iproc_pcie_check_link()
>   pci_scan_child_bus()
>
> But it would be a lot better if iproc_pcie_check_link() were done
> first, before pci_create_root_bus().  Then it would be more like the
> structure of other drivers, and we could use pci_scan_root_bus()
> instead.
>
> Comments, iproc folks?
>
> Bjorn
>

Regards,
  Scott
