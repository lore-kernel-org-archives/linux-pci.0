Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=nDpC=2T=arm.com=robin.murphy@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: David Laight <David.Laight@ACULAB.COM>, Mason <slash.tmp@free.fr>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
 <4f37cc08-d4fd-b207-63d2-4ac038d2fcec@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C9B9@AcuExch.aculab.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 linux-usb <linux-usb@vger.kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <504fdb97-f058-e1fb-0fe2-7f01c46db513@arm.com>
Date: Fri, 10 Mar 2017 16:00:32 +0000
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE7C9B9@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/03/17 15:35, David Laight wrote:
> From: Robin Murphy 
>> Sent: 10 March 2017 15:23
> ...
>>>> So you have 128MB (max) of system memory that has cpu physical
>>>> addresses 0x80000000 upwards.
>>>> I'd expect it all to be accessible from any PCIe card at some PCIe
>>>> address, it might be at address 0, 0x80000000 or any other offset.
>>>>
>>>> I don't know which DT entry controls that offset.
>>>
>>> This is a crucial point, I think.
>>
>> The appropriate DT property would be "dma-ranges", i.e.
>>
>> pci@... {
>> 	...
>> 	dma-ranges = <(PCI bus address) (CPU phys address) (size)>;
>> }
> 
> Isn't that just saying which physical addresses the cpu can assign
> for buffers for those devices?
> There is also an offset between the 'cpu physical address' and the
> 'dma address'.

That offset is inherent in what "dma-ranges" describes. Say (for ease of
calculation) that BAR0 has been put at a mem space address of 0x20000000
and maps the first 1GB of physical DRAM. That would give us:

	dma-ranges = <0x20000000 0x80000000 0x40000000>;

Then a "virt = dma_alloc_coherent(..., &handle, ...)", borrowing the
numbers from earlier in the thread, would automatically end up with:

	virt == 0xd0855000;
	handle == 0x2e07e000;

(with the physical address of 0x8e07e000 in between being irrelevant to
the consuming driver)

It is true that the device's DMA mask assignment is also part and parcel
of this, whereby we will limit what physical addresses the kernel
considers valid for DMA involving devices behind this range to the lower
3GB (i.e. 0x80000000 + 0x40000000 - 1). With a bit of luck,
CONFIG_DMABOUNCE should do the rest of the job of working around that
where necessary.

Robin.

> This might be implicit in the 'BAR0' base address register.
>  
>> The fun part is that that will only actually match the hardware once the
>> magic BAR has actually been programmed with (bus address), so you end up
>> with this part of your DT being more of a prophecy than a property :)
> 
> The BAR0 values could easily be programmed into the cpld/fpga - so
> not need writing by the cpu at all.
> 
> 	David
> 
