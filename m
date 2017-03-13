Return-Path: <SRS0=bmI6=2W=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=bmI6=2W=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: Robin Murphy <robin.murphy@arm.com>,
 David Laight <david.laight@aculab.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
 <4f37cc08-d4fd-b207-63d2-4ac038d2fcec@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C9B9@AcuExch.aculab.com>
 <504fdb97-f058-e1fb-0fe2-7f01c46db513@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <e31d5d71-cc90-86cf-d8cb-3367d42e1d41@free.fr>
Date: Mon, 13 Mar 2017 11:59:57 +0100
MIME-Version: 1.0
In-Reply-To: <504fdb97-f058-e1fb-0fe2-7f01c46db513@arm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 17:00, Robin Murphy wrote:

> On 10/03/17 15:35, David Laight wrote:
>
>> Robin Murphy wrote:
>> 
>>> The appropriate DT property would be "dma-ranges", i.e.
>>>
>>> pci@... {
>>> 	...
>>> 	dma-ranges = <(PCI bus address) (CPU phys address) (size)>;
>>> }
>>
>> Isn't that just saying which physical addresses the cpu can assign
>> for buffers for those devices?
>> There is also an offset between the 'cpu physical address' and the
>> 'dma address'.
> 
> That offset is inherent in what "dma-ranges" describes. Say (for ease of
> calculation) that BAR0 has been put at a mem space address of 0x20000000
> and maps the first 1GB of physical DRAM. That would give us:
> 
> 	dma-ranges = <0x20000000 0x80000000 0x40000000>;
> 
> Then a "virt = dma_alloc_coherent(..., &handle, ...)", borrowing the
> numbers from earlier in the thread, would automatically end up with:
> 
> 	virt == 0xd0855000;
> 	handle == 0x2e07e000;
> 
> (with the physical address of 0x8e07e000 in between being irrelevant to
> the consuming driver)
> 
> It is true that the device's DMA mask assignment is also part and parcel
> of this, whereby we will limit what physical addresses the kernel
> considers valid for DMA involving devices behind this range to the lower
> 3GB (i.e. 0x80000000 + 0x40000000 - 1). With a bit of luck,
> CONFIG_DMABOUNCE should do the rest of the job of working around that
> where necessary.

AFAICT, the parser for the "dma-ranges" property is implemented
in of_dma_get_range() in drivers/of/address.c

http://lxr.free-electrons.com/source/drivers/of/address.c#L808

/**
 * of_dma_get_range - Get DMA range info
 * @np:		device node to get DMA range info
 * @dma_addr:	pointer to store initial DMA address of DMA range
 * @paddr:	pointer to store initial CPU address of DMA range
 * @size:	pointer to store size of DMA range
 *
 * Look in bottom up direction for the first "dma-ranges" property
 * and parse it.
 *  dma-ranges format:
 *	DMA addr (dma_addr)	: naddr cells
 *	CPU addr (phys_addr_t)	: pna cells
 *	size			: nsize cells
 *
 * It returns -ENODEV if "dma-ranges" property was not found
 * for this device in DT.
 */

I didn't find anything relevant in Documentation/devicetree/bindings
except Documentation/devicetree/bindings/iommu/iommu.txt but I'm not
sure this applies to my SoC.

It's not clear to me how ranges and dma-ranges interact...
Is it perhaps: ranges for cpu-to-bus, dma-ranges for bus-to-cpu?


ePAPR (Version 1.1 -- 08 April) provides a formal definition

2.3.9 dma-ranges

Property: dma-ranges

Value type: <empty> or <prop-encoded-array> encoded as arbitrary number
of triplets of (child-bus-address, parent-bus-address, length).

Description:

The dma-ranges property is used to describe the direct memory access (DMA) structure of a
memory-mapped bus whose device tree parent can be accessed from DMA operations
originating from the bus. It provides a means of defining a mapping or translation between the
physical address space of the bus and the physical address space of the parent of the bus.
The format of the value of the dma-ranges property is an arbitrary number of triplets of
(child-bus-address, parent-bus-address, length). Each triplet specified describes a contiguous
DMA address range.

o The child-bus-address is a physical address within the child bus' address space. The
number of cells to represent the address depends on the bus and can be determined
from the #address-cells of this node (the node in which the dma-ranges property
appears).

o The parent-bus-address is a physical address within the parent bus' address space.
The number of cells to represent the parent address is bus dependent and can be
determined from the #address-cells property of the node that defines the parent's
address space.

o The length specifies the size of the range in the child's address space. The number of
cells to represent the size can be determined from the #size-cells of this node (the
node in which the dma-ranges property appears).


I'm still digging :-)

Regards.
