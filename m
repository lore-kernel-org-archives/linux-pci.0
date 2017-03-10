Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: Mason <slash.tmp@free.fr>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
Cc: David Laight <David.Laight@ACULAB.COM>, Bjorn Helgaas
 <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 linux-usb <linux-usb@vger.kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f37cc08-d4fd-b207-63d2-4ac038d2fcec@arm.com>
Date: Fri, 10 Mar 2017 15:23:26 +0000
MIME-Version: 1.0
In-Reply-To: <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/03/17 15:05, Mason wrote:
> On 10/03/2017 15:06, David Laight wrote:
> 
>> Robin Murphy wrote:
>>
>>> On 09/03/17 23:43, Mason wrote:
>>>
>>>> I think I'm making progress, in that I now have a better
>>>> idea of what I don't understand. So I'm able to ask
>>>> (hopefully) less vague questions.
>>>>
>>>> Take the USB3 PCIe adapter I've been testing with. At some
>>>> point during init, the XHCI driver request some memory
>>>> (via kmalloc?) in order to exchange data with the host, right?
>>>>
>>>> On my SoC, the RAM used by Linux lives at physical range
>>>> [0x8000_0000, 0x8800_0000[ => 128 MB
>>>>
>>>> How does the XHCI driver make the adapter aware of where
>>>> it can scribble data? The XHCI driver has no notion that
>>>> the device is behind a bus, does it?
>>>>
>>>> At some point, the physical addresses must be converted
>>>> to PCI bus addresses, right? Is it computed subtracting
>>>> the offset defined in the DT?
>>
>> The driver should call dma_alloc_coherent() which returns both the
>> kernel virtual address and the device (xhci controller) has
>> to use to access it.
>> The cpu physical address is irrelevant (although it might be
>> calculated in the middle somewhere).
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
> 
> 
>>>> Then suppose the USB3 card wants to write to an address
>>>> in RAM. It sends a packet on the PCIe bus, targeting
>>>> the PCI bus address of that RAM, right? Is this address
>>>> supposed to be in BAR0 of the root complex? I guess not,
>>>> since Bjorn said that it was unusual for a RC to have
>>>> a BAR at all. So I'll hand-wave, and decree that, by some
>>>> protocol magic, the packet arrives at the PCIe controller.
>>>> And this controller knows to forward this write request
>>>> over the memory bus. Does that look about right?
>>>
>>> Generally, yes - if an area of memory space *is* claimed by a BAR, then
>>> another PCI device accessing that would be treated as peer-to-peer DMA,
>>> which may or may not be allowed (or supported at all).
>>
>> So PCIe addresses that refer to the host memory addresses are
>> just forwarded to the memory subsystem.
>> In practise this is almost everything.
> 
> My RC drops packets not targeting its BAR0.

OK, so it does sound like you're in a particularly awkward position that
rules out using a sane 1:1 mapping between mem space and the system
address map.

>> The only other PCIe writes the host will see are likely to be associated
>> with MIS and MSI-X interrupt support.
> 
> Rev 1 of the PCIe controller is supposed to forward MSI doorbell
> writes over the global bus to the PCIe controller's MMIO register.
> 
>> Some PCIe root complex support peer-to-peer writes but not reads.
>> Write are normally 'posted' (so are 'fire and forget') reads need the
>> completion TLP (containing the data) sent back - all hard and difficult.
>>
>>> For mem space
>>> which isn't claimed by BARs, it's up to the RC to decide what to do. As
>>> a concrete example (which might possibly be relevant) the PLDA XR3-AXI
>>> IP which we have in the ARM Juno SoC has the ATR_PCIE_WINx registers in
>>> its root port configuration block that control what ranges of mem space
>>> are mapped to the external AXI master interface and how.
>>>
>>>> My problem is that, in the current implementation of the
>>>> PCIe controller, the USB device that wants to write to
>>>> memory is supposed to target BAR0 of the RC.
>>>
>>> That doesn't sound right at all. If the RC has a BAR, I'd expect it to
>>> be for poking the guts of the RC device itself (since this prompted me
>>> to go and compare, I see the Juno RC does indeed have it own enigmatic
>>> 16KB BAR, which reads as ever-changing random junk; no idea what that's
>>> about).
>>>
>>>> Since my mem space is limited to 256 MB, then BAR0 is
>>>> limited to 256 MB (or even 128 MB, since I also need
>>>> to mapthe device's BAR into the same mem space).
>>>
>>> Your window into mem space *from the CPU's point of view* is limited to
>>> 256MB. The relationship between mem space and the system (AXI) memory
>>> map from the point of view of PCI devices is a separate issue; if it's
>>> configurable at all, it probably makes sense to have the firmware set an
>>> outbound window to at least cover DRAM 1:1, then forget about it (this
>>> is essentially what Juno UEFI does, for example).
>>
>> So you have 128MB (max) of system memory that has cpu physical
>> addresses 0x80000000 upwards.
>> I'd expect it all to be accessible from any PCIe card at some PCIe
>> address, it might be at address 0, 0x80000000 or any other offset.
>>
>> I don't know which DT entry controls that offset.
> 
> This is a crucial point, I think.

The appropriate DT property would be "dma-ranges", i.e.

pci@... {
	...
	dma-ranges = <(PCI bus address) (CPU phys address) (size)>;
}

The fun part is that that will only actually match the hardware once the
magic BAR has actually been programmed with (bus address), so you end up
with this part of your DT being more of a prophecy than a property :)

Robin.

> 
> Regards.
> 
