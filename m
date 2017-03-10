Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755402AbdCJStf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Mar 2017 13:49:35 -0500
Date: Fri, 10 Mar 2017 12:49:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: David Laight <David.Laight@ACULAB.COM>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Neophyte questions about PCIe
Message-ID: <20170310184930.GG19517@bhelgaas-glaptop.roam.corp.google.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 10, 2017 at 04:05:50PM +0100, Mason wrote:
> On 10/03/2017 15:06, David Laight wrote:
> 
> > Robin Murphy wrote:
> >
> >> On 09/03/17 23:43, Mason wrote:
> >>
> >>> I think I'm making progress, in that I now have a better
> >>> idea of what I don't understand. So I'm able to ask
> >>> (hopefully) less vague questions.
> >>>
> >>> Take the USB3 PCIe adapter I've been testing with. At some
> >>> point during init, the XHCI driver request some memory
> >>> (via kmalloc?) in order to exchange data with the host, right?
> >>>
> >>> On my SoC, the RAM used by Linux lives at physical range
> >>> [0x8000_0000, 0x8800_0000[ => 128 MB
> >>>
> >>> How does the XHCI driver make the adapter aware of where
> >>> it can scribble data? The XHCI driver has no notion that
> >>> the device is behind a bus, does it?
> >>>
> >>> At some point, the physical addresses must be converted
> >>> to PCI bus addresses, right? Is it computed subtracting
> >>> the offset defined in the DT?
> > 
> > The driver should call dma_alloc_coherent() which returns both the
> > kernel virtual address and the device (xhci controller) has
> > to use to access it.
> > The cpu physical address is irrelevant (although it might be
> > calculated in the middle somewhere).
> 
> Thank you for that missing piece of the puzzle.
> I see some relevant action in drivers/usb/host/xhci-mem.c
> 
> And I now see this log:
> 
> [    2.499320] xhci_hcd 0000:01:00.0: // Device context base array address = 0x8e07e000 (DMA), d0855000 (virt)
> [    2.509156] xhci_hcd 0000:01:00.0: Allocated command ring at cfb04200
> [    2.515640] xhci_hcd 0000:01:00.0: First segment DMA is 0x8e07f000
> [    2.521863] xhci_hcd 0000:01:00.0: // Setting command ring address to 0x20
> [    2.528786] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr low bits + flags = @00000000
> [    2.537188] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr high bits = @00000000
> [    2.545002] xhci_hcd 0000:01:00.0: // Doorbell array is located at offset 0x800 from cap regs base addr
> [    2.554455] xhci_hcd 0000:01:00.0: // xHCI capability registers at d0852000:
> [    2.561550] xhci_hcd 0000:01:00.0: // @d0852000 = 0x1000020 (CAPLENGTH AND HCIVERSION)
> 
> I believe 0x8e07e000 is a CPU address, not a PCI bus address.

Sounds like you've made good progress since this email, but I think
0x8e07e000 is a PCI bus address, not a CPU address.  The code in
xhci_mem_init() is this:

  xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma, flags);
  xhci->dcbaa->dma = dma;
  xhci_dbg_trace("Device context base array address = 0x%llx (DMA), %p (virt)",
                 (unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);

dma_alloc_coherent() allocates a buffer and returns two values: the
CPU virtual address ("xhci->dcbaa" here) for use by the driver and the
corresponding DMA address the device can use to reach the buffer
("dma").

Documentation/DMA-API-HOWTO.txt has more details that might be useful.
