Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:57171 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaDPRHT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 13:07:19 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so1236912igc.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 10:07:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUv7yfUDsTa_N=FFARRYFmrCxRVN-vCp3NikSf+ARkPdA@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx> <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx> <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
 <20140415115450.GA7792@yanx> <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
 <CAE9FiQUv7yfUDsTa_N=FFARRYFmrCxRVN-vCp3NikSf+ARkPdA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 Apr 2014 11:06:58 -0600
Message-ID: <CAErSpo6mLmzFOy4kqBCSTVrbT2_OqfuugZh7bA-kywwSnYto_A@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 15, 2014 at 8:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Apr 15, 2014 at 5:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> It went wrong at the beginning. Note the error message never considers
>>> 64-bit or not, but BAR 15 here has it MEM_64 flag cleared.
>>
>> BAR 15 is a bridge window.  I think its resource flags should reflect
>> the capability of the *window*, even if we disable the window or we
>> happen to assign addresses that are under 4GB.  So I think it's wrong
>> that we clear the MEM_64 flag  in pbus_size_mem() and the IO flag in
>> pbus_size_io().
>
> We keep PCI_PREF_RANGE_TYPE_64 in the flag.

I think we should stop putting PCI_PREF_RANGE_TYPE_64 in res->flags.
I don't think we ever test for PCI_PREF_RANGE_TYPE_64 today, except
for the trivial usage in pci_read_bridge_mmio_pref(), which can be
easily removed.

Everywhere else, we use IORESOURCE_MEM, IORESOURCE_MEM_64, and
IORESOURCE_PREFETCH to keep track of the properties of the hardware
underlying the struct resource, i.e., the BAR.  Why shouldn't we do
the same for bridge windows?

The struct resource flags should tell us the *possible* properties of
the window, e.g., what the bridge can support.  These properties are
fixed by the bridge hardware, regardless of what devices happen to be
below the bridge.  We discover those properties at enumeration-time,
and we shouldn't change them afterwards.

> We should check that before we touch PCI_PREF_LIMIT_UPPER32 BAR in
> pci_setup_bridge_mmio_pref()
>
> like following:
>
> Subject: [PATCH] PCI: only touch upper 32bit for pref64bit bridge bar
>
> If the bridge pref mmio bar does not support 64bit, we should touch
> upper 32bit.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> ---
>  drivers/pci/setup-bus.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -592,23 +592,23 @@ static void pci_setup_bridge_mmio(struct
>  static void pci_setup_bridge_mmio_pref(struct pci_bus *bus)
>  {
>      struct pci_dev *bridge = bus->self;
> -    struct resource *res;
> +    struct resource *res = bus->resource[2];
>      struct pci_bus_region region;
>      u32 l, bu, lu;
>
>      /* Clear out the upper 32 bits of PREF limit.
>         If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
>         disables PREF range, which is ok. */
> -    pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
> +    if (res->flags & PCI_PREF_RANGE_TYPE_64)
> +        pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
>
>      /* Set up PREF base/limit. */
>      bu = lu = 0;
> -    res = bus->resource[2];
>      pcibios_resource_to_bus(bridge->bus, &region, res);
>      if (res->flags & IORESOURCE_PREFETCH) {
>          l = (region.start >> 16) & 0xfff0;
>          l |= region.end & 0xfff00000;
> -        if (res->flags & IORESOURCE_MEM_64) {
> +        if (res->flags & PCI_PREF_RANGE_TYPE_64) {
>              bu = upper_32_bits(region.start);
>              lu = upper_32_bits(region.end);
>          }
> @@ -619,8 +619,10 @@ static void pci_setup_bridge_mmio_pref(s
>      pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
>
>      /* Set the upper 32 bits of PREF base & limit. */
> -    pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
> -    pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
> +    if (res->flags & PCI_PREF_RANGE_TYPE_64) {
> +        pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
> +        pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
> +    }
>  }
>
>  static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
