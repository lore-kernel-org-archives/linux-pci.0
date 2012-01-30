Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7ji9R3azc7Xiu8K-=QXm26w=0oSWmcBh=j8dy=MttEvg@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
	<1327718971-9598-3-git-send-email-yinghai@kernel.org>
	<CAErSpo7ji9R3azc7Xiu8K-=QXm26w=0oSWmcBh=j8dy=MttEvg@mail.gmail.com>
Date: Mon, 30 Jan 2012 10:32:09 -0800
Message-ID: <CAE9FiQVDaA-aO6tFq0gmmDZRydUF6oLrAsARQWH6OOAEqFhRbQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] PCI: Add busn_res operation functions
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2012 at 7:28 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> will use them insert/update busn res in pci_bus
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/probe.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h |    3 +++
>>  2 files changed, 47 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index a114173..71261da 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1622,6 +1622,50 @@ err_out:
>>        return NULL;
>>  }
>>
>> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
>> +{
>> +       struct resource *res = &b->busn_res;
>> +       struct resource *parent_res = &iobusn_resource;
>> +       int ret;
>> +
>> +       res->start = (pci_domain_nr(b) << 8) | bus;
>> +       res->end = (pci_domain_nr(b) << 8) | bus_max;
>> +       res->flags = IORESOURCE_BUS;
>> +
>> +       if (!pci_is_root_bus(b))
>> +               parent_res = &b->parent->busn_res;
>> +
>> +       ret = insert_resource(parent_res, res);
>> +
>> +       dev_printk(KERN_DEBUG, &b->dev,
>> +        "busn_res: %06llx-%06llx %s inserted under %06llx-%06llx\n",
>> +                       (unsigned long long)res->start,
>> +                       (unsigned long long)res->end,
>> +                        ret ? "can not be" : "is",
>> +                       (unsigned long long)parent_res->start,
>> +                       (unsigned long long)parent_res->end);
>
> Please update the %pR implementation so you can use it instead of
> having to fiddle around with start/end separately and casts.

ok, will check that. to make it support extra domain number there.

>
>> +}
>> +
>> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
>> +{
>> +       struct resource *res = &b->busn_res;
>> +       unsigned long long old_end = res->end;
>> +
>> +       res->end &= ~0xff;
>> +       res->end |= bus_max;
>
> This updates a resource in place, without removing it from the
> resource tree and re-inserting it.  Doesn't this make it possible to
> corrupt the resource tree?  For example, let's say you have this tree:
>
>    00-3f : host bridge A
>      00-1f : P2P bridge B
>    40-7f : host bridge C
>
> Now you use pci_bus_update_busn_res_end() to update the resource for
> P2P bridge B,  setting its end to 5f.  I think the resource tree is
> now corrupted.

for expanding, We will make sure expanded range is safe and verified.

another use case is for unknown peer root buses that can not tell end
before scanning,
will assume we are handing those kind of peer root bus for low to high.

Yinghai
