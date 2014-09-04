Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:46082 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaIDNQh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 09:16:37 -0400
Received: by mail-qg0-f52.google.com with SMTP id z60so9877077qgd.39
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 06:16:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <540802D9.6000903@huawei.com>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
 <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Sep 2014 07:16:15 -0600
Message-ID: <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 4, 2014 at 12:12 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> + * pcie_bus_update_set - update device mps when device doing hot-add
>>> + * @dev: PCI device to set
>>> + *
>>> + * After device hot add, mps will be set to default(128B), But the
>>> + * upstream port device's mps may be larger than 128B which was set
>>> + * by firmware during system bootup. Then we should update the device
>>> + * mps to equal to its parent mps, Or the device can not work normally.
>>> + */
>>> +static void pcie_bus_update_set(struct pci_dev *dev)
>>> +{
>>> +    int mps, p_mps, mpss;
>>> +    struct pci_dev *parent;
>>> +
>>> +    if (!pci_is_pcie(dev) || !dev->bus->self
>>> +                    || !dev->bus->self->is_hotplug_bridge)
>>
>> Part of this looks redundant because pcie_bus_configure_set() already
>> checks pci_is_pcie().  And I don't know why we need to test
>> is_hotplug_bridge here; MPS settings need to be consistent regardless of
>> whether the upstream bridge supports hotplug.
>
> Hi Bjorn, I added is_hotplug_bridge() here is mainly to touch the hotplug case only.
> It was more like a temporary solution and not perfect one.
>
>>
>>> +            return;
>>> +
>>> +    parent = dev->bus->self;
>>> +    mps = pcie_get_mps(dev);
>>> +    p_mps = pcie_get_mps(parent);
>>> +
>>> +    if (mps >= p_mps)
>>> +            return;
>>> +
>>> +    mpss = 128 << dev->pcie_mpss;
>>> +    if (mpss < p_mps) {
>>> +            dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
>>> +                            "If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
>>> +                            mpss, p_mps);
>>> +            return;
>>
>> Since we can't configure the new device correctly, we really shouldn't
>> allow a driver to bind to it.  The current design doesn't have much
>> provision for doing that, so warning is probably all we can do.
>
> Yes, bind a driver to the device which mps is not correctly set will cause another problem.
>
>>
>>> +    }
>>> +
>>> +    pcie_write_mps(dev, p_mps);
>>> +    dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n",
>>> +                    pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
>>> +}
>>> +
>>>  static void pcie_bus_detect_mps(struct pci_dev *dev)
>>>  {
>>>      struct pci_dev *bridge = dev->bus->self;
>>> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>>>              return 0;
>>>
>>>      if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>> +            pcie_bus_update_set(dev);
>>
>> You're only adding this to the PCIE_BUS_TUNE_OFF path.  Can't the same
>> problem occur for other pcie_bus_config settings?
>
> We only found the problem during PCIE_BUS_TUNE_OFF set. Other mode like PCIE_BUS_SAFE and PCIE_BUS_PEER2PEER.
> This issue won't happen.

Sorry, I can't parse this.  Are you saying the problem won't happen in
the other modes?  Why not?

>>>              pcie_bus_detect_mps(dev);
>>>              return 0;
>>>      }
