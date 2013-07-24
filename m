Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58506 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3GXCEa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 22:04:30 -0400
MIME-Version: 1.0
In-Reply-To: <51EF3570.7030608@huawei.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<51EF3570.7030608@huawei.com>
Date: Tue, 23 Jul 2013 19:04:30 -0700
Message-ID: <CAE9FiQUX7Dx5Z8zgx94bQ5vWTRsExarzG6WB_iuGj1jWkurc4w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 23, 2013 at 7:01 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Hi Yinghai,
>    It seems to have the the same problem in acpiphp,
>
> diable_device(..):
>
>         while ((pdev = dev_in_slot(slot))) {
>                 pci_stop_and_remove_bus_device(pdev);
>                 pci_dev_put(pdev);
>         }
>
>
> static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
> {
>         struct pci_bus *bus = slot->bridge->pci_bus;
>         struct pci_dev *dev;
>         struct pci_dev *ret = NULL;
>
>         down_read(&pci_bus_sem);
>         list_for_each_entry(dev, &bus->devices, bus_list)
>                 if (PCI_SLOT(dev->devfn) == slot->device) {
>                         ret = pci_dev_get(dev);
>                         break;
>                 }
>         up_read(&pci_bus_sem);
>

acpiphp is ok.

dev_in_slot will restart from bus->devices again every time.

Thanks

Yinghai
