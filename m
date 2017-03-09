Return-Path: <SRS0=fKxC=2S=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=fKxC=2S=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
Date: Fri, 10 Mar 2017 00:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 08/03/2017 16:17, Bjorn Helgaas wrote:
[snip excellent in-depth overview]

I think I'm making progress, in that I now have a better
idea of what I don't understand. So I'm able to ask
(hopefully) less vague questions.

Take the USB3 PCIe adapter I've been testing with. At some
point during init, the XHCI driver request some memory
(via kmalloc?) in order to exchange data with the host, right?

On my SoC, the RAM used by Linux lives at physical range
[0x8000_0000, 0x8800_0000[ => 128 MB

How does the XHCI driver make the adapter aware of where
it can scribble data? The XHCI driver has no notion that
the device is behind a bus, does it?

At some point, the physical addresses must be converted
to PCI bus addresses, right? Is it computed subtracting
the offset defined in the DT?

Then suppose the USB3 card wants to write to an address
in RAM. It sends a packet on the PCIe bus, targeting
the PCI bus address of that RAM, right? Is this address
supposed to be in BAR0 of the root complex? I guess not,
since Bjorn said that it was unusual for a RC to have
a BAR at all. So I'll hand-wave, and decree that, by some
protocol magic, the packet arrives at the PCIe controller.
And this controller knows to forward this write request
over the memory bus. Does that look about right?

My problem is that, in the current implementation of the
PCIe controller, the USB device that wants to write to
memory is supposed to target BAR0 of the RC.

Since my mem space is limited to 256 MB, then BAR0 is
limited to 256 MB (or even 128 MB, since I also need
to mapthe device's BAR into the same mem space).

So, if I understand correctly (which, at this point,
is quite unlikely) PCIe will work correctly for me
only if Linux manages 128 MB or less...

How does it work on systems where the RC has no BAR?
I suppose devices are able to access all of RAM...
because the controller forwards everything? (This may
be where an IOMMU comes handy?)

Is there a way to know, at run-time, where and how big
Linux's dynamic memory pool is? Perhaps the memory pool
itself remains smaller than 128 MB?

I realize that I've asked a million questions. Feel free
to ignore most of them, if you can help with just one,
it would be a tremendous help already.

Regards.
