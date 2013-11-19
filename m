Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55885 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab3KSXsi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 18:48:38 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so5017791ieb.8
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 15:48:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUBiocnOhdmK3n4rgmTzdtxxNP93UU+uJvZm56s3VY5GA@mail.gmail.com>
References: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
 <1384843018-9479-2-git-send-email-yan@linux.vnet.ibm.com> <CAE9FiQUBiocnOhdmK3n4rgmTzdtxxNP93UU+uJvZm56s3VY5GA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Nov 2013 16:48:17 -0700
Message-ID: <CAErSpo7Je79ES=AL1LZ1ynVxx=7JfcsjkNP7Kr3ShfDb-2efJw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PCI: do not compare CPU address with PCI address
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 19, 2013 at 12:31 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Nov 18, 2013 at 10:36 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
>> In resource assignment code, limits are exerted to restrict allocated
>> resource range. However these limits are PCI address but compared to
>> CPU address in the end. Translated them before comparing.
>>
>> We can't just use pcibios_bus_to_resource because the limits may not
>> included in the host bridge window. Introduce a help function to
>> do this translation, if address missed, return an approximate one.
>>
>> Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/bus.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 63 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index fc1b740..532c0a4 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -99,6 +99,64 @@ void pci_bus_remove_resources(struct pci_bus *bus)
>>  }
>>
>>  /**
>> + * pci_bus_to_resource
>> + *
>> + * Much like pcibios_bus_to_resource() except it takes a single address
>> + * and returns an approximate one if target address is not included
>> + * in the bridge window. The approximate address is smaller than required
>> + * one is 'bound' is 1, larger than required one if 'bound' is 0.
>> + */
>> +static resource_size_t pci_bus_to_resource(struct pci_bus *bus, int flags,
>> +                                   int mask, resource_size_t addr, int bound)
>> +{
>> +       struct pci_host_bridge *bridge;
>> +       struct pci_host_bridge_window *window, *match = NULL;
>> +       resource_size_t max = 0, min = -1;
>> +       resource_size_t offset = -1, start, end;
>> +
>> +       while (bus->parent)
>> +               bus = bus->parent;
>> +
>> +       bridge = to_pci_host_bridge(bus->bridge);
>> +
>> +       list_for_each_entry(window, &bridge->windows, list) {
>> +               if ((flags ^ window->res->flags) & mask)
>> +                       continue;
>> +
>> +               start = window->res->start - window->offset;
>> +               end = window->res->end - window->offset;
>> +
>> +               if (addr >= start && addr <= end) {
>> +                       offset = window->offset;
>> +                       break;
>> +               }
>> +
>> +               if (bound && addr > end && end > max) {
>> +                       max = end;
>> +                       match = window;
>> +               } else if (!bound && addr < start && start < min) {
>> +                       min = start;
>> +                       match = window;
>> +               }
>> +       }
>> +
>> +       if (offset == -1) {
>> +               /*
>> +                * Not even found the matched type. This may happen,
>> +                * for example, if try to translate IO address in a HB
>> +                * without IO window. Just return the original address,
>> +                * it will fail later anyway.
>> +                */
>> +               if (match == NULL)
>> +                       return addr;
>> +
>> +               return (bound ? max : min) + match->offset;
>> +       }
>> +
>> +       return addr + offset;
>> +}
>
> that is confusing.

I agree, this is way too confusing.

I certainly agree that the current code is wrong -- PCIBIOS_MAX_MEM_32
is a limit on the *bus* address, but we're using it to limit CPU
addresses.  And it's not arch-dependent at all; it's strictly a
function of PCI, so I think you should fix that, too.  Your [2/3]
patch is a start, but I don't think there's any reason to allow an
arch to override it, and it's only used in one place, so it doesn't
need to be in include/linux/pci.h where it's effectively exported to
the world.

It's completely bogus to try to compute "max" outside the loop because
there's no requirement that the translation offset be the same for all
the resources.  But *inside* the loop, you have a valid struct
resource, and you can easily compute the corresponding bus addresses
and determine whether they fit in 32 bits.

Bjorn
