Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:36969 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab3GXC0I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 22:26:08 -0400
Message-ID: <51EF3B0E.4050404@huawei.com>
Date: Wed, 24 Jul 2013 10:25:18 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org> <51EF3570.7030608@huawei.com> <CAE9FiQUX7Dx5Z8zgx94bQ5vWTRsExarzG6WB_iuGj1jWkurc4w@mail.gmail.com>
In-Reply-To: <CAE9FiQUX7Dx5Z8zgx94bQ5vWTRsExarzG6WB_iuGj1jWkurc4w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/7/24 10:04, Yinghai Lu wrote:
> On Tue, Jul 23, 2013 at 7:01 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Hi Yinghai,
>>    It seems to have the the same problem in acpiphp,
>>
>> diable_device(..):
>>
>>         while ((pdev = dev_in_slot(slot))) {
>>                 pci_stop_and_remove_bus_device(pdev);
>>                 pci_dev_put(pdev);
>>         }
>>
>>
>> static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
>> {
>>         struct pci_bus *bus = slot->bridge->pci_bus;
>>         struct pci_dev *dev;
>>         struct pci_dev *ret = NULL;
>>
>>         down_read(&pci_bus_sem);
>>         list_for_each_entry(dev, &bus->devices, bus_list)
>>                 if (PCI_SLOT(dev->devfn) == slot->device) {
>>                         ret = pci_dev_get(dev);
>>                         break;
>>                 }
>>         up_read(&pci_bus_sem);
>>
> 
> acpiphp is ok.
> 
> dev_in_slot will restart from bus->devices again every time.

Ah, yes, thanks for explanation.

Thanks!
Yijing.

> 
> 


-- 
Thanks!
Yijing

