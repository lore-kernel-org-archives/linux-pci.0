Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeHORuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2018 13:50:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 15 Aug 2018 20:27:52 +0530
From: poza@codeaurora.org
To: Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <8b8db3c5-e884-d697-6193-b409276f9638@oracle.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <8b8db3c5-e884-d697-6193-b409276f9638@oracle.com>
Message-ID: <fa97a363892f757203ec7209f374a220@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-14 19:21, Thomas Tai wrote:
> On 08/14/2018 05:22 AM, poza@codeaurora.org wrote:
>> On 2018-08-14 14:46, poza@codeaurora.org wrote:
>>> On 2018-08-13 22:21, Thomas Tai wrote:
>>>> In order to prevent the pcie_do_fatal_recovery() from
>>>> using the device after it is removed, the device's
>>>> domain:bus:devfn is stored at the entry of
>>>> pcie_do_fatal_recovery(). After rescanning the bus, the
>>>> stored domain:bus:devfn is used to find the device and
>>>> uses to report pci_info. The original issue only happens
>>>> on an non-bridge device, a local variable is used instead
>>>> of checking the device's header type.
>>>> 
>>>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>>>> ---
>>>>  drivers/pci/pcie/err.c | 33 +++++++++++++++++++++++----------
>>>>  1 file changed, 23 insertions(+), 10 deletions(-)
>>>> 
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index f02e334..3414445 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -287,15 +287,20 @@ void pcie_do_fatal_recovery(struct pci_dev 
>>>> *dev,
>>>> u32 service)
>>>>      struct pci_bus *parent;
>>>>      struct pci_dev *pdev, *temp;
>>>>      pci_ers_result_t result;
>>>> +    bool is_bridge_device = false;
>>>> +    u16 domain = pci_domain_nr(dev->bus);
>>>> +    u8 bus = dev->bus->number;
>>>> +    u8 devfn = dev->devfn;
>>>> 
>>>> -    if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>>>> +    if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>>> +        is_bridge_device = true;
>>>>          udev = dev;
>>>> -    else
>>>> +    } else {
>>>>          udev = dev->bus->self;
>>>> +    }
>>>> 
>>>>      parent = udev->subordinate;
>>>>      pci_lock_rescan_remove();
>>>> -    pci_dev_get(dev);
>>>>      list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>>>>                       bus_list) {
>>>>          pci_dev_get(pdev);
>>>> @@ -309,27 +314,35 @@ void pcie_do_fatal_recovery(struct pci_dev 
>>>> *dev,
>>>> u32 service)
>>>> 
>>>>      result = reset_link(udev, service);
>>>> 
>>>> -    if ((service == PCIE_PORT_SERVICE_AER) &&
>>>> -        (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
>>>> +    if (service == PCIE_PORT_SERVICE_AER && is_bridge_device) {
>>>>          /*
>>>>           * If the error is reported by a bridge, we think this 
>>>> error
>>>>           * is related to the downstream link of the bridge, so we
>>>>           * do error recovery on all subordinates of the bridge 
>>>> instead
>>>>           * of the bridge and clear the error status of the bridge.
>>>>           */
>>>> -        pci_cleanup_aer_uncorrect_error_status(dev);
>>>> +        pci_cleanup_aer_uncorrect_error_status(udev);
>>>>      }
>>>> 
>>>>      if (result == PCI_ERS_RESULT_RECOVERED) {
>>>>          if (pcie_wait_for_link(udev, true))
>>>>              pci_rescan_bus(udev->bus);
>>>> -        pci_info(dev, "Device recovery from fatal error 
>>>> successful\n");
>>>> +        /* find the pci_dev after rescanning the bus */
>>>> +        dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>>> one of the motivations was to remove and re-enumerate rather then
>>> going thorugh driver's recovery sequence
>>> was; it might be possible that hotplug capable bridge, the device
>>> might have changed.
>>> hence this check will fail
> 
> Thanks Oza for your information. Instead of searching for the dev_pci,
> should I just use the stored domain:bus:devfn to printout the info?
> 
>>>> +        if (dev)
>>>> +            pci_info(dev, "Device recovery from fatal error 
>>>> successful\n");
>>>> +        else
>>>> +            pr_err("AER: Can not find pci_dev for 
>>>> %04x:%02x:%02x.%x\n",
>>>> +                   domain, bus,
>>>> +                   PCI_SLOT(devfn), PCI_FUNC(devfn));
>>>> +        pci_dev_put(dev);
> 
> That is, replace above with:
> 
> 	pr_info("AER: Device %04x:%02x:%02x.%x recover from fatal error
> successful\n", domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> 
is this not sufficient to print ?  which is there already.
pci_info(dev, "Device recovery from fatal error successful\n");

> 
>>>>      } else {
>>>> -        pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>>>> -        pci_info(dev, "Device recovery from fatal error failed\n");
>>>> +        if (is_bridge_device)
>>> previously there was no condition.. why is this required now ?
>>> and it was doing on "dev" while you are doing it on "udev"
>> is that the reason we dont watnt o use dev after it is removed ? 
>> instead do pci_uevent_ers on bridge ?
> 
> 
> Yes, that's exactly the reason. I should have written down the reason
> in the commit log. Here is the details explanation for the benefit of
> others. If the failing device is a bridge device, udev is equal to
> dev. So we can use udev in the pci_uevent_ers. But for non bridge
> device the device is already removed from the bus and thus can't send
> pci_uevent_ers.
> 
> Thank you,
> Thomas
> 
>>>> +            pci_uevent_ers(udev, PCI_ERS_RESULT_DISCONNECT);
>>>> +        pr_err("AER: Device %04x:%02x:%02x.%x recovery from fatal 
>>>> error failed\n",
>>>> +               domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>>>>      }
>>>> 
>>>> -    pci_dev_put(dev);
>>>>      pci_unlock_rescan_remove();
>>>>  }
>>> 
>>> Regards,
>>> Oza.
