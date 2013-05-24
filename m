Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:54641 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab3EXROE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2013 13:14:04 -0400
Received: by mail-vb0-f54.google.com with SMTP id f13so3281284vbg.13
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2013 10:14:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130524025424.GC23166@pek-khao-d1.corp.ad.wrs.com>
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
 <1368536876-27307-3-git-send-email-haokexin@gmail.com> <519506BF.3010400@gmail.com>
 <20130517021128.GB13975@pek-khao-d1.corp.ad.wrs.com> <519643E8.3020102@gmail.com>
 <20130519022445.GA25698@pek-khao-d1.corp.ad.wrs.com> <CAErSpo6vTqgN3MFZ9TmAzHHhnzP5bUip=G=djd80RE-7upJ+gA@mail.gmail.com>
 <20130524025424.GC23166@pek-khao-d1.corp.ad.wrs.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 May 2013 11:13:41 -0600
Message-ID: <CAErSpo5Wzy5wHn4CAfD2HjRZ3dv3To+u=pRAvjC8DaMpR03LFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: unset the resource if we can't get the correct
 CPU address
To: Kevin Hao <haokexin@gmail.com>
Cc: Liu Jiang <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 8:54 PM, Kevin Hao <haokexin@gmail.com> wrote:
> On Thu, May 23, 2013 at 02:22:58PM -0600, Bjorn Helgaas wrote:
>> On Sat, May 18, 2013 at 8:24 PM, Kevin Hao <haokexin@gmail.com> wrote:
>> > On Fri, May 17, 2013 at 10:51:20PM +0800, Liu Jiang wrote:
>> >> On Fri 17 May 2013 10:11:29 AM CST, Kevin Hao wrote:
>> >> >On Fri, May 17, 2013 at 12:18:07AM +0800, Liu Jiang wrote:
>> >> >>On Tue 14 May 2013 09:07:56 PM CST, Kevin Hao wrote:
>> >> >>>In the current kernel, we just set the CPU address to the bus address
>> >> >>>if we can't find the match region for one specific bus address. If BAR
>> >> >>>of one pci device is set to address which happens to be a legitimate
>> >> >>>CPU address by firmware, the kernel will think this resource is legal
>> >> >>>and will not try to reassign later. In cases the CPU address and bus
>> >> >>>address isn't equal, the device will not work. So we should check
>> >> >>>if we can translate the bus address to CPU address correctly. If not,
>> >> >>>we should unset this resource and wish the kernel will reassign it
>> >> >>>later.
>> >> >>>
>> >> >>>Since we will invoke pcibios_bus_to_resource unconditionally if we
>> >> >>>don't goto fail, move it out of if/else wrap.
>> >> >>>
>> >> >>>Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> >> >>>---
>> >> >>>  drivers/pci/probe.c | 9 ++++++---
>> >> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> >> >>>
>> >> >>>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> >> >>>index 70f10fa..c96772f 100644
>> >> >>>--- a/drivers/pci/probe.c
>> >> >>>+++ b/drivers/pci/probe.c
>> >> >>>@@ -250,12 +250,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>> >> >>>                   pci_write_config_dword(dev, pos + 4, 0);
>> >> >>>                   region.start = 0;
>> >> >>>                   region.end = sz64;
>> >> >>>-                  pcibios_bus_to_resource(dev, res, &region);
>> >> >>>                   bar_disabled = true;
>> >> >>>           } else {
>> >> >>>                   region.start = l64;
>> >> >>>                   region.end = l64 + sz64;
>> >> >>>-                  pcibios_bus_to_resource(dev, res, &region);
>> >> >>>           }
>> >> >>>   } else {
>> >> >>>           sz = pci_size(l, sz, mask);
>> >> >>>@@ -265,7 +263,12 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>> >> >>>
>> >> >>>           region.start = l;
>> >> >>>           region.end = l + sz;
>> >> >>>-          pcibios_bus_to_resource(dev, res, &region);
>> >> >>>+  }
>> >> >>>+
>> >> >>>+  if (!pcibios_bus_to_resource(dev, res, &region)) {
>> >> >>>+          res->flags |= IORESOURCE_UNSET;
>> >> >>>+          res->end -= res->start;
>> >> >>>+          res->start = 0;
>> >> >>>   }
>> >> >>>
>> >> >>>   goto out;
>> >> >>
>> >> >>Hi Kevin,
>> >> >>      Will this break subtractive decode PCI bridges and devices?
>> >> >
>> >> >No. A subtractive decode occurs only when no other pci bridge or device
>> >> >claim the transactions. As you can see that when we are trying to translate
>> >> >a bus address to cpu address we search the address regions of pci host
>> >> >bridge instead of a pci bridge. The pci host bridge address regions should
>> >> >cover all the bus address we can use for the pci device or bridge under this
>> >> >pci controller. This definitely also include the bus address regions used by
>> >> >the expansion bus for subtractive decode. So if a pci device use a bus address
>> >> >that is unknown to this pci host bridge, there is definitely something wrong
>> >> >here. This is the case we are trying to fix.
>> >> >
>> >> Hi Kevin,
>> >>       I'm not sure about this assumption "the pci host bridge
>> >> address regions should cover
>> >> all the bus address we can use for the pci device or bridge under
>> >> this pci controller".
>> >> I have a fear that it may cause regressions to some legacy x86
>> >> platforms, such as an AMD
>> >> platform with PCI based IOAPICs, though I have no evidences for it.
>> >
>> > Does any x86 expert can confirm whether the assumption that "the pci host
>> > bridge address regions should cover all the bus address we can use for the
>> > pci device or bridge under this pci host bridge" is true or not on x86?
>> > It seems definitely wrong in logical. But things always happen out of
>> > expectation in reality. :-)
>>
>> You're changing generic code, not x86-specific code, so you need the
>> assumption to hold on all architectures.
>
> Indeed.
>
>>  I don't know off-hand
>> whether it's true or not.
>
> I think it should be true in general. If some architecture or platform
> does break this assumption, we should fix it in architecture or platform
> level, just as what you did for bug 31602.
>
>>
>> Can you save me some time by collecting a full dmesg showing the
>> problem, and maybe one with your fix?
>
> I attached the full kernel and lspci log for the current kernel and the
> one applied my fix.
>
>>  I know there are cases where we
>> notice a BAR assignment that we think is incorrect, e.g.,
>> https://bugzilla.kernel.org/show_bug.cgi?id=31602 (fixed by
>> eb31aae8cb5) and we reassign it, and I want to know how your case is
>> different from that.
>
> The bug 31602 is that the bios doesn't report the memory region claimed
> by the pci host controller correctly. In my case, the bootloader assign
> a wrong bus address to the pci device and this bus address happens to
> be a legal memory address for the kernel. In the current implementation
> of pcibios_bus_to_resource, it can't detect this illegal bus address and
> just use it as the memory address. So the pci subsystem doesn't reassign
> the resource for this pci device and leave a illegal bus address set in
> this pci device BAR, it definitely causes this device not work.
>
> The bootloader assigned the following bus address to device 0000:01:00.0:
>         Region 0: bus address at a0000000 (64-bit, non-prefetchable) [size=128]

Your dmesg log show this:

pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus
address [0xe0000000-0xffffffff])
pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xa000007f 64bit]

There are two ways this could happen:

  1) The BAR contained 0xe0000000 and we translated it to a legal
resource value of 0xa0000000, or
  2) The BAR contained 0xa0000000, we found no matching host bridge
window, and we assumed an offset of zero and again translated it to a
resource value of 0xa0000000.

There's no information to distinguish these (lspci shows resource
values, not bus addresses, by default), but in your case, it must be
2), based on the fact that the device doesn't work unless we reassign
the BAR.  When we reassign it, we apply the translation and compute a
BAR value in the [0xe0000000-0xffffffff] range, which *does* work.

We should be able to detect this problem even without assuming we know
about all the host bridge windows.  The bus-to-resource conversion
should be invertible.  In case 2), bus_to_resource(0xa0000000) gave us
0xa0000000, but resource_to_bus(0xa0000000) will give us 0xe0000000,
so we won't get back what we started with.

I think I'd rather use this strategy than changing
pcibios_bus_to_resource().  I would also put a note in dmesg about the
fact that we're throwing away the BAR value put there by firmware (and
why), just for future debugging efforts.  Would you mind also
splitting the "move the pcibios_bus_to_resource() call out of the
if/else wrap" change into its own tiny patch since it's a separate
logical change?

Bjorn

> In the current kernel, the pci host bridge use the following address regions:
>   pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus address [0xe0000000-0xffffffff])
>
> And no reassign for device 0000:01:00.0.
>
> With my fix, the device 0000:01:00.0 is reassigned with the correct bus address:
>   pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus address [0xe0000000-0xffffffff])
>   pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa007ffff pref]
>   pci 0000:01:00.0: BAR 2: assigned [mem 0xa0080000-0xa0083fff 64bit]
>   pci 0000:01:00.0: BAR 0: assigned [mem 0xa0084000-0xa008407f 64bit]
>
> As you can see in the current kernel the pci subsystem doesn't detect
> this wrong bus address and don't try a reassign what it should do.
> My patches is trying to fix this issue.
>
> Thanks,
> Kevin
>>
>> Bjorn
