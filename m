Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36958 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHFBoj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2015 21:44:39 -0400
Message-ID: <55C2BC01.6040801@roeck-us.net>
Date: Wed, 05 Aug 2015 18:44:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net> <CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
In-Reply-To: <CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/05/2015 06:14 PM, Yinghai Lu wrote:
> On Thu, Jul 30, 2015 at 7:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> The PCI subsystem always assumes that I/O is supported on PCIe bridges
>> and tries to assign an I/O window to each child bus even if that is not
>> the case.
>>
>> This may result in messages such as:
>>
>>    pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
>>    pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
>>    pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
>>
>> for each bridge port, even if a bus or its parent does not support I/O in
>> the first place.
>>
>> To avoid this message, check if a bus supports I/O before trying to enable
>> it.  Also check if the root bus has an IO window assigned; if not, it does
>> not make sense to try to assign one to any of its child busses.
>>
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index cefd636681b6..d9e02ba34035 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -332,6 +332,24 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>>          }
>>   }
>>
>> +static int pci_bridge_supports_io(struct pci_dev *bridge)
>> +{
>> +       u16 io;
>> +
>> +       pci_read_config_word(bridge, PCI_IO_BASE, &io);
>> +       if (io)
>> +               return 1;
>> +
>> +       /* IO_BASE/LIMIT is either hard-wired to zero or programmed to zero */
>> +       pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
>> +       pci_read_config_word(bridge, PCI_IO_BASE, &io);
>> +       pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
>> +       if (io)
>> +               return 1;
>> +
>> +       return 0;
>> +}
>> +
>>   static void pci_read_bridge_io(struct pci_bus *child)
>>   {
>>          struct pci_dev *dev = child->self;
>> @@ -340,6 +358,15 @@ static void pci_read_bridge_io(struct pci_bus *child)
>>          struct pci_bus_region region;
>>          struct resource *res;
>>
>> +       if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO))
>> +               return;
>> +
>> +       if (!pci_bridge_supports_io(dev)) {
>> +               dev_printk(KERN_DEBUG, &dev->dev, "  no I/O window\n");
>> +               child->bus_flags &= ~PCI_BUS_FLAGS_SUPPORTS_IO;
>> +               return;
>> +       }
>> +
>
> It only can avoid warning with bridge, and still have warning on
> devices under the bridge.
>
Not really, because children inherit bus_flags.

> also would have problem on transparent bridges, like
>
> BRIDGE_A ---- BRIDGE_AA----DEVICE_AA
>                     |
>                     \-- BRIDGE_AB ---DEVICE_AB
>
> if only BRIDGE_A and BRIDGE_AA are transparent, and BRIDGE_AB is not.
>
> and if pci_bridge_supports_io() return false for BRIDGE_A.
>
> We will have all three bridges have PCI_BUS_FLAGS_SUPPORTS_IO cleared.
> so all will not been sized and will not get assigned io port resource.
>
What is wrong with that ? Doesn't it reflect reality ?

> later DEVICE_AA could root bus io port as parent, and get io resource assigned.
> but DEVICE_AB will not get assigned.
>
> so we should get rid of pci_bridge_supports_io(), and just check root
> resource IO port.
>
You lost me here. That would mean that we would not clear the flag
and claim that a bridge supports IO even if it doesn't, and all ports
and bridges connected to that bridge would try (and fail) to get
IO address assignments.

That does not make much sense to me. What do you expect to do in this case ?

I must admit I have no idea how non-transparent bridges fit
into this picture. However, if Bridge A doesn't support IO,
I don't see how we can get IO anywhere, transparent or not.

Guenter


