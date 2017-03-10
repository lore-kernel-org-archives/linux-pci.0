Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Subject: Re: Neophyte questions about PCIe
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 linux-usb <linux-usb@vger.kernel.org>, David Laight
 <david.laight@aculab.com>, Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
Date: Fri, 10 Mar 2017 13:15:45 +0000
MIME-Version: 1.0
In-Reply-To: <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 09/03/17 23:43, Mason wrote:
> On 08/03/2017 16:17, Bjorn Helgaas wrote:
> [snip excellent in-depth overview]
> 
> I think I'm making progress, in that I now have a better
> idea of what I don't understand. So I'm able to ask
> (hopefully) less vague questions.
> 
> Take the USB3 PCIe adapter I've been testing with. At some
> point during init, the XHCI driver request some memory
> (via kmalloc?) in order to exchange data with the host, right?
> 
> On my SoC, the RAM used by Linux lives at physical range
> [0x8000_0000, 0x8800_0000[ => 128 MB
> 
> How does the XHCI driver make the adapter aware of where
> it can scribble data? The XHCI driver has no notion that
> the device is behind a bus, does it?
> 
> At some point, the physical addresses must be converted
> to PCI bus addresses, right? Is it computed subtracting
> the offset defined in the DT?
> 
> Then suppose the USB3 card wants to write to an address
> in RAM. It sends a packet on the PCIe bus, targeting
> the PCI bus address of that RAM, right? Is this address
> supposed to be in BAR0 of the root complex? I guess not,
> since Bjorn said that it was unusual for a RC to have
> a BAR at all. So I'll hand-wave, and decree that, by some
> protocol magic, the packet arrives at the PCIe controller.
> And this controller knows to forward this write request
> over the memory bus. Does that look about right?

Generally, yes - if an area of memory space *is* claimed by a BAR, then
another PCI device accessing that would be treated as peer-to-peer DMA,
which may or may not be allowed (or supported at all). For mem space
which isn't claimed by BARs, it's up to the RC to decide what to do. As
a concrete example (which might possibly be relevant) the PLDA XR3-AXI
IP which we have in the ARM Juno SoC has the ATR_PCIE_WINx registers in
its root port configuration block that control what ranges of mem space
are mapped to the external AXI master interface and how.

> My problem is that, in the current implementation of the
> PCIe controller, the USB device that wants to write to
> memory is supposed to target BAR0 of the RC.

That doesn't sound right at all. If the RC has a BAR, I'd expect it to
be for poking the guts of the RC device itself (since this prompted me
to go and compare, I see the Juno RC does indeed have it own enigmatic
16KB BAR, which reads as ever-changing random junk; no idea what that's
about).

> Since my mem space is limited to 256 MB, then BAR0 is
> limited to 256 MB (or even 128 MB, since I also need
> to mapthe device's BAR into the same mem space).

Your window into mem space *from the CPU's point of view* is limited to
256MB. The relationship between mem space and the system (AXI) memory
map from the point of view of PCI devices is a separate issue; if it's
configurable at all, it probably makes sense to have the firmware set an
outbound window to at least cover DRAM 1:1, then forget about it (this
is essentially what Juno UEFI does, for example).

Robin.

> So, if I understand correctly (which, at this point,
> is quite unlikely) PCIe will work correctly for me
> only if Linux manages 128 MB or less...
> 
> How does it work on systems where the RC has no BAR?
> I suppose devices are able to access all of RAM...
> because the controller forwards everything? (This may
> be where an IOMMU comes handy?)
> 
> Is there a way to know, at run-time, where and how big
> Linux's dynamic memory pool is? Perhaps the memory pool
> itself remains smaller than 128 MB?
> 
> I realize that I've asked a million questions. Feel free
> to ignore most of them, if you can help with just one,
> it would be a tremendous help already.
> 
> Regards.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
