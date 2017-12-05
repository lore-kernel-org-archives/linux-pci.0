Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
Subject: Re: [Question] Unsupported Request During PCI Enumeration
To: Bjorn Helgaas <helgaas@kernel.org>
References: <26340670-2744-b2e0-eed7-eb8e0ad2bc84@huawei.com>
 <20171128003208.GB11228@bhelgaas-glaptop.roam.corp.google.com>
 <c1235398-9a80-b4f3-94c9-3686651259fc@huawei.com>
 <20171128145748.GD11228@bhelgaas-glaptop.roam.corp.google.com>
 <12079a9c-9018-b1be-1596-8a2f6746677b@huawei.com>
 <20171130231558.GD19640@bhelgaas-glaptop.roam.corp.google.com>
 <b6b7e255-b7c1-d4dc-ba76-fd6ae494befb@huawei.com>
 <20171201145717.GF19640@bhelgaas-glaptop.roam.corp.google.com>
CC: Linux PCI <linux-pci@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <07e1748b-7e6b-eafb-2aef-fcbab90dd2b3@huawei.com>
Date: Tue, 5 Dec 2017 14:18:54 +0800
MIME-Version: 1.0
In-Reply-To: <20171201145717.GF19640@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2017/12/1 22:57, Bjorn Helgaas 写道:
> On Fri, Dec 01, 2017 at 05:30:48PM +0800, Dongdong Liu wrote:
>>
>> 在 2017/12/1 7:15, Bjorn Helgaas 写道:
>>> On Thu, Nov 30, 2017 at 08:47:38PM +0800, Dongdong Liu wrote:
>>>>
>>>>> I do not think drivers should be calling
>>>>> pci_enable_pcie_error_reporting() directly.  And I don't think we
>>>>> should depend on _HPX.  _HPX is intended for *platform-specific*
>>>>> things, and I don't think this is platform-specific.  And of course,
>>>>> _HPX only works on ACPI systems, and we want this to work everywhere.
>>>>>
>>>>> So I think we need a more comprehensive generic solution in Linux.  I
>>>>> think we need several pieces:
>>>>>
>>>>> - Disable UR reporting during enumeration, similar to how we disable
>>>>>   Master Abort reporting.
>>>>>
>>>>> - Restore original UR reporting setting after enumeration.
>>>>>
>>>>> - Clear any logged UR errors after enumeration.
>>>>
>>>> Agree.
>>>>
>>>>>
>>>>> - Enable UR reporting as part of configuring every device, e.g., in
>>>>>   pci_configure_device() or pci_init_capabilities().
>>>>
>>>> Enable UR reporting in pci_configure_device() or pci_init_capabilities() is
>>>> not ok. It will still report UR as it is still in enumeration.
>>>
>>> True.  For bridges, it needs to be after we've enumerated children of
>>> the bridge.
>>>
>>>>> I don't know whether we should enable UR reporting if AER is not
>>>>> present; we'll have to think about that.  We may also have to
>>>>> restructure how the AER driver works, because I think it currently
>>>>> comes into play *after* we call pci_init_capabilities().  There are
>>>>> probably some ordering issues there.
>>>>
>>>> I write a sample code as below, it can avoid report UR during
>>>> enumeration. What do you think about the code ?
>>>
>>> Can you do it the same place we disable and restore Master-Abort Mode,
>>> in pci_scan_bridge_extend()?  That's done for the same reason, so it
>>> would be nice to keep it together.
>>>
>>> Maybe we could have a "pci_disable_enumeration_errors()" that would
>>> disable both Master-Abort Mode and UR reporting, and a corresponding
>>> "pci_restore_enumeration_errors()" that would clear any logged errors
>>> and restore the original settings?
>>
>> Set devctl to disable UR in pci_scan_bridge_extend() can resolve
>> bridge devices UR reporting issue. But for EP devices may still
>> reprot UR, like non-ARI EP devices. So it's better to disable UR
>> reporting in pci_device_add() after calling
>> pci_configure_device(dev) and restore in pci_bus_add_device().  As
>> in pci_configure_device() may parse _HPX to enable UR, disable UR
>> reporting should call after pci_configure_device().
>
> Help me understand this issue with Endpoints and how ARI is involved.
>
> Is this an issue with multi-function devices, where function 0 exists
> and then we try to read the Vendor ID of function 1, 2, ..., until one
> fails to respond?  And when one fails to respond, the Endpoint logs a
> UR error?
Correct.
>
> And I guess the ARI connection is that with ARI, we use the ARI
> Capability to find the next function, so we should never try to read
> the Vendor ID of a non-existent function?
Yes, I think so.
>
> pci_device_add() and pci_bus_add_device() don't have any obvious
> connection to enumeration, so I don't really like those places.  If
> I'm understanding the issue correctly, I'd rather do the error
> disable/restore in pci_scan_slot(), where it's right next to the
> enumeration of additional functions.

Looks good, I will consider this. Many thanks for your suggestion.

Thanks,
Dongdong
>
>>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>>> index bc56cf1..1a46026 100644
>>>> --- a/drivers/pci/bus.c
>>>> +++ b/drivers/pci/bus.c
>>>> @@ -14,6 +14,7 @@
>>>> #include <linux/ioport.h>
>>>> #include <linux/proc_fs.h>
>>>> #include <linux/slab.h>
>>>> +#include <linux/aer.h>
>>>>
>>>> #include "pci.h"
>>>>
>>>> @@ -311,6 +312,16 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>>>> void pci_bus_add_device(struct pci_dev *dev)
>>>> {
>>>>        int retval;
>>>> +       u16 reg16;
>>>> +
>>>> +       /* Clear PCIe Capability's Device Status */
>>>> +       pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
>>>> +       pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
>>>> +       pci_cleanup_aer_error_status_regs(dev);
>>>> +
>>>> +       /* Restore UR reporting */
>>>> +       if (dev->devctl_ur)
>>>> +               pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_URRE);
>>>>
>>>>        /*
>>>>         * Can not put in pci_device_add yet because resources
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 14e0ea1..7b34083 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -2119,9 +2119,21 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>>>> void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>>> {
>>>>        int ret;
>>>> +       u16 reg16;
>>>>
>>>>        pci_configure_device(dev);
>>>>
>>>> +       pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
>>>> +       dev->devctl_ur = reg16 & PCI_EXP_DEVCTL_URRE;
>>>> +       if (dev->devctl_ur) {
>>>> +               /*
>>>> +                * Turn off UR reporting, later restore UR reporting
>>>> +                * after enumeration.
>>>> +                */
>>>> +               reg16 = reg16 & (~PCI_EXP_DEVCTL_URRE);
>>>> +               pcie_capability_write_word(dev, PCI_EXP_DEVCTL, reg16);
>>>> +       }
>>>> +
>>>>        device_initialize(&dev->dev);
>>>>        dev->dev.release = pci_release_dev;
>>>>
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index ae8d2b4..c2a90f1 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -440,6 +440,7 @@ struct pci_dev {
>>>>        char *driver_override; /* Driver name to force a match */
>>>>
>>>>        unsigned long priv_flags; /* Private flags for the pci driver */
>>>> +       u16 devctl_ur;
>>>> };
>
> .
>
