Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150423213015.GA7888@google.com>
References: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
	<CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com>
	<20150423213015.GA7888@google.com>
Date: Thu, 23 Apr 2015 20:55:59 -0400
Message-ID: <CADnq5_PPaFdbVVyMPMDi1NXcTVtDR6YQo68rema0vuR_tyNb0A@mail.gmail.com>
Subject: Re: git pull] drm for v4.1-rc1
From: Alex Deucher <alexdeucher@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Matthew Garrett <mjg59@coreos.com>,
	Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 23, 2015 at 5:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Matthew]
>
> On Tue, Apr 21, 2015 at 09:07:45AM -0700, Linus Torvalds wrote:
>> Hmm. The odd Intel PCI resource mess is back.
>>
>> Or maybe it never went away.
>>
>> I get these when suspending. Things *work*, but it's really spamming
>> my logs a fair bit:
>>
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   pci_bus 0000:01: Allocating resources
>>   pci_bus 0000:02: Allocating resources
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>   i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
>>
>> That resource is complete garbage. "flags 0x2" is not even a valid
>> flag value. I'm *guessing* it might be IORESOURCE_ROM_SHADOW, but if
>> that is valid, then it should also have have had the IORESOURCE_MEM
>> bit, and it doesn't.
>
> Your i915 does not have a ROM BAR in hardware.  If the default video
> device has no ROM BAR, pci_fixup_video() sets IORESOURCE_ROM_SHADOW
> even though the resource flags are zero because the BAR itself doesn't
> exist.
>
> If IORESOURCE_ROM_SHADOW is set, pci_map_rom() assumes there's a
> shadow ROM image at 0xC0000.  Is there a shadow image even if the
> device itself doesn't have a ROM BAR?

Very likely yes.  With integrated APUs and mobile dGPUs, the vbios
image is often stored as part of the system rom rather than as a
dedicated rom for the GPU.  The vbios image is then copied to the
shadow location during sbios init to provide OS access to the rom.

Alex

>
> We could fabricate a resource even if the BAR doesn't exist, e.g.,
> "flags = IORESOURCE_MEM | ... | IORESOURCE_ROM_SHADOW", but that
> would be ugly and error-prone in other places that use the ROM.
>
> Matthew added dev->rom for ROM images supplied by the platform
> (84c1b80e3263 ("PCI: Add support for non-BAR ROMs")).  A shadow
> image seems like a similar thing.  I think it would be cleaner to get
> rid of IORESOURCE_ROM_SHADOW altogether and instead set "dev->rom =
> 0xC0000" if there's a shadow image, e.g.:
>
>   int pcibios_add_device(struct pci_dev *dev)
>   {
>     if (dev-is-default-vga-device) {
>       dev->rom = 0xC0000;
>       dev->romlen = 0x20000;
>     }
>
>     pa_data = boot_params.hdr.setup_data;
>     while (pa_data) {
>       ...
>       if (data->type == SETUP_PCI) {
>         rom = (struct pci_setup_rom *)data;
>
>         if (dev-is-rom-dev) {
>           dev->rom = ...
>           dev->romlen = rom->pcilen;
>         }
>       }
>     }
>
> But the rules for figuring out which image to use seem ...
> complicated.
>
> Bjorn
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
