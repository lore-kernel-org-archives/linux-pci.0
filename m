Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Arnd Bergmann <arnd@arndb.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <3158203.Yc9Qgx82xo@wuerfel>
 <9d5e32d3-000c-2f95-7ea8-c64d53ab6b56@cogentembedded.com>
 <2723285.JORgusvJv4@wuerfel>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
Date: Fri, 6 Jan 2017 16:47:59 +0300
MIME-Version: 1.0
In-Reply-To: <2723285.JORgusvJv4@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 artemi.ivanov@cogentembedded.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>>> Just a guess, but if the inbound translation windows in the host
>>> bridge are wider than 32-bit, the reason for setting up a single
>>> 32-bit window is probably because that is what the parent bus supports.

I've re-checked rcar-pcie hardware documentation.

It indeed mentions that AXI bus it sits on is 32-bit.


>> Well anyway applying patch similar to your's will fix pcie-rcar + nvme
>> case - thus I don't object :)   But it can break other cases ...
>>
>> But why do you hook at set_dma_mask() and overwrite mask inside, instead
>> of hooking at dma_supported() and rejecting unsupported mask?
>>
>> I think later is better, because it lets drivers to handle unsupported
>> high-dma case, like documented in DMA-API_HOWTO.
> 
> I think the behavior I put in there is required for swiotlb to make
> sense, otherwise you would rely on the driver to handle dma_set_mask()
> failure gracefully with its own bounce buffers (as network and
> scsi drivers do but others don't).
> 
> Having swiotlb or iommu enabled should result in dma_set_mask() always
> succeeding unless the mask is too small to cover the swiotlb
> bounce buffer area or the iommu virtual address space. This behavior
> is particularly important in case the bus address space is narrower
> than 32-bit, as we have to guarantee that the fallback to 32-bit
> DMA always succeeds. There are also a lot of drivers that try to
> set a 64-bit mask but don't implement bounce buffers for streaming
> mappings if that fails, and swiotlb is what we use to make those
> drivers work.
> 
> And yes, the API is a horrible mess.

With my patch applied and thus 32bit dma_mask set for NVMe device, I do
see high addresses passed to dma_map_*() routines and handled by
swiotlb. Thus your statement that behavior "succeed 64bit dma_set_mask()
operation but silently replace mask behind the scene" is required for
swiotlb to be used, does not match reality.

It can be interpreted as a breakage elsewhere, but it's hard to point
particular "root cause". The entire infrastructure to allocate and use
DMA memory is messy.

Still current code does not work, thus fix is needed.

Perhaps need to introduce some generic API to "allocate memory best
suited for DMA to particular device", and fix allocation points (in
drivers, filesystems, etc) to use it. Such an API could try to allocate
area that can be DMAed by hardware, and fallback to other memory that
can be used via swiotlb or other bounce buffer implementation.

But for now, have to stay with dma masks. Will follow-up with a patch
based on your but with coherent mask handling added.

Nikita

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
