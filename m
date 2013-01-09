Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:1592 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab3AIHi1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 02:38:27 -0500
Message-ID: <50ED1E28.3010502@huawei.com>
Date: Wed, 9 Jan 2013 15:37:12 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yu Zhao <yu.zhao@intel.com>, <kernel.openeuler@huawei.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 3/3] PCI, pciehp: ARI device hotplug support
References: <1350371420-7888-1-git-send-email-wangyijing@huawei.com> <1350371420-7888-3-git-send-email-wangyijing@huawei.com> <CAErSpo6to+9fpiQU2q59MGg0r8OQm7okLnaDAEaeFYAL5xZEUA@mail.gmail.com>
In-Reply-To: <CAErSpo6to+9fpiQU2q59MGg0r8OQm7okLnaDAEaeFYAL5xZEUA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/1/9 1:44, Bjorn Helgaas wrote:
> [+cc Kenji]
> 
> On Tue, Oct 16, 2012 at 1:10 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> ARI device supports up to 256 Functions, pciehp now only scan and configure
>> Functions from 0 to 7, this patch fix this problem for ARI device hotplug.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/hotplug/pciehp_pci.c |   40 ++++++++++++++++++++++++++-----------
>>  1 files changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>> index 09cecaf..b37e8a0 100644
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -39,7 +39,7 @@ int pciehp_configure_device(struct slot *p_slot)
>>         struct pci_dev *dev;
>>         struct pci_dev *bridge = p_slot->ctrl->pcie->port;
>>         struct pci_bus *parent = bridge->subordinate;
>> -       int num, fn;
>> +       int num, fn = 0;
>>         struct controller *ctrl = p_slot->ctrl;
>>
>>         dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
>> @@ -56,21 +56,31 @@ int pciehp_configure_device(struct slot *p_slot)
>>                 ctrl_err(ctrl, "No new device found\n");
>>                 return -ENODEV;
>>         }
>> -
>> -       for (fn = 0; fn < 8; fn++) {
>> -               dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
>> +
>> +       do {
>> +               if (pci_ari_enabled(parent))
>> +                       dev = pci_get_slot(parent, fn);
>> +               else
>> +                       dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
>> +
>> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
> 
> This doesn't make sense to me.  We just called pci_scan_slot(), which
> already  used pci_next_fn() to find all the functions.  We shouldn't
> have to have the ARI knowledge and pci_next_fn() looping here again
> (and yet again after pci_assign_unassigned_bridge_resources()).
> 
> According to the pci_scan_slot() function comment, all the
> newly-discovered devices should be on the bus->devices list.  And in
> fact, the similar code in acpiphp (enable_device()) *does* use the
> bus->devices list.
> 

Hi Bjorn,
   Thanks for your review and comment! You are right, use bus->devices list is a better solution.
I will update my ARI device hotplug support patchset and send out again.

> I think cpci_configure_slot(), pciehp_configure_device(),
> enable_slot() in sgi_hotplug.c, and shpchp_configure_device() should
> be changed to use the bus->devices list.  In addition, I think the
> refcount management (pci_get_slot()/pci_dev_put()) should be removed.

Remove pci_get_slot()/pci_dev_put() here looks good to me, Because refcount increment when pci_scan_slot,
here remove the refcount management is safe.
I will change this and test in my machine, and send out this patch if test result is ok.


Thanks very much!

Yijing.

> 
>>                 if (!dev)
>>                         continue;
>>                 if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
>>                                 (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
>>                         pci_hp_add_bridge(dev);
>>                 pci_dev_put(dev);
>> -       }
>> +       } while (fn);
>>
>>         pci_assign_unassigned_bridge_resources(bridge);
>>
>> -       for (fn = 0; fn < 8; fn++) {
>> -               dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
>> +       do {
>> +               if (pci_ari_enabled(parent))
>> +                       dev = pci_get_slot(parent, fn);
>> +               else
>> +                       dev = pci_get_slot(parent, PCI_DEVFN(0, fn));
>> +
>> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
>>                 if (!dev)
>>                         continue;
>>                 if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
>> @@ -79,7 +89,7 @@ int pciehp_configure_device(struct slot *p_slot)
>>                 }
>>                 pci_configure_slot(dev);
>>                 pci_dev_put(dev);
>> -       }
>> +       } while (fn);
>>
>>         pci_bus_add_devices(parent);
>>
>> @@ -89,21 +99,27 @@ int pciehp_configure_device(struct slot *p_slot)
>>  int pciehp_unconfigure_device(struct slot *p_slot)
>>  {
>>         int ret, rc = 0;
>> -       int j;
>> +       int fn = 0;
>>         u8 bctl = 0;
>>         u8 presence = 0;
>>         struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
>>         u16 command;
>>         struct controller *ctrl = p_slot->ctrl;
>> +       struct pci_dev *temp;
>>
>>         ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>>                  __func__, pci_domain_nr(parent), parent->number);
>>         ret = pciehp_get_adapter_status(p_slot, &presence);
>>         if (ret)
>>                 presence = 0;
>> +
>> +       do {
>> +               if (pci_ari_enabled(parent))
>> +                       temp = pci_get_slot(parent, fn);
>> +               else
>> +                       temp = pci_get_slot(parent, PCI_DEVFN(0, fn));
>>
>> -       for (j = 0; j < 8; j++) {
>> -               struct pci_dev *temp = pci_get_slot(parent, PCI_DEVFN(0, j));
>> +               fn = pci_next_fn(parent, PCI_DEVFN(0, fn));
>>                 if (!temp)
>>                         continue;
>>                 if (temp->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
>> @@ -129,7 +145,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>>                         pci_write_config_word(temp, PCI_COMMAND, command);
>>                 }
>>                 pci_dev_put(temp);
>> -       }
>> +       } while (fn);
>>
>>         return rc;
>>  }
>> --
>> 1.7.1
>>
>>
> 
> .
> 


-- 
Thanks!
Yijing

