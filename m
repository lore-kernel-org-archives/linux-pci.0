Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65354 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752022Ab2EXPal convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 May 2012 11:30:41 -0400
Received: by lahd3 with SMTP id d3so6007743lah.19
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 08:30:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFeW=pazkYZ9bYZ1uG3hXxSzUC5bD3nOo2KDHLir6=Q7J-O5iw@mail.gmail.com>
References: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
 <20120523043511.13449.22006.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQVs0U62NRxkDYdOC67EUiEBu1f5ojGxGXkdbt0O6XO4uQ@mail.gmail.com>
 <CAFeW=pZiEODGx09=HaJDWujmCc92wCKt2fhZM03yNDb9CSs3gA@mail.gmail.com>
 <CAE9FiQWJcxbUvOcYf-mZYThKMogYzYUwk+w-Oc43dEU9KLA3oQ@mail.gmail.com> <CAFeW=pazkYZ9bYZ1uG3hXxSzUC5bD3nOo2KDHLir6=Q7J-O5iw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 24 May 2012 09:30:19 -0600
Message-ID: <CAErSpo7A27_9GuUX6qT2WQEBaDcoUtLbjBE1LLenkPuatkiZQg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] PCI: acpiphp: remove all functions in slot, even
 without ACPI _EJx
To: Amos Kong <kongjianjun@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	liuj97@gmail.com, qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 1:03 AM, Amos Kong <kongjianjun@gmail.com> wrote:
> On Wed, May 23, 2012 at 1:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Tue, May 22, 2012 at 10:15 PM, Amos Kong <kongjianjun@gmail.com> wrote:
>>> Attached the v7,  test passed.
>>
>> would be better to have break...
>
> Yeah. Otherwise, it will delete from the last function.
> Attached v8, test passed.
>
>
>> +static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
>> +{
>> +       struct pci_bus *bus = slot->bridge->pci_bus;
>> +       struct pci_dev *dev;
>> +       int ret = NULL;
>> +
>> +       down_read(&pci_bus_sem);
>> +       list_for_each_entry(dev, &bus->devices, bus_list)
>> +               if (PCI_SLOT(dev->devfn) == slot->device)
>> +                       ret = pci_dev_get(dev);
>> +       up_read(&pci_bus_sem);
>> +
>> +       return ret;
>> +}
>>
>> ===>
>>
>>
>> +static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
>> +{
>> +       struct pci_bus *bus = slot->bridge->pci_bus;
>> +       struct pci_dev *dev;
>> +       int ret = NULL;
>> +
>> +       down_read(&pci_bus_sem);
>> +       list_for_each_entry(dev, &bus->devices, bus_list)
>> +               if (PCI_SLOT(dev->devfn) == slot->device) {
>> +                       ret = pci_dev_get(dev);
>> +                      break;
>> +              }
>> +       up_read(&pci_bus_sem);
>> +
>> +       return ret;
>> +}

I applied the v6 1/2 and this v8 patch to my "for-3.6" branch.

Thanks for fixing this, Amos!  It's another step towards rationalizing
all the hotplug drivers we have.

Bjorn
