Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Arnd Bergmann <arnd@arndb.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <5224989.KFLmAz9Gqk@wuerfel>
 <4bbc3494-bf95-9765-ccaf-cc3b3e1cd297@cogentembedded.com>
 <2104402.puPT8SttTe@wuerfel>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <412396ac-4535-08a3-e4c7-dd8d0078a518@cogentembedded.com>
Date: Wed, 4 Jan 2017 17:30:19 +0300
MIME-Version: 1.0
In-Reply-To: <2104402.puPT8SttTe@wuerfel>
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

>> For OF platforms, this is called via of_dma_configure(), that checks
>> dma-ranges of node that is *parent* for host bridge. Host bridge
>> currently does not control this at all.
> 
> We need to think about this a bit. Is it actually the PCI host
> bridge that limits the ranges here, or the bus that it is connected
> to. In the latter case, the caller needs to be adapted to handle
> both.

In r-car case, I'm not sure what is the source of limitation at physical
level.

pcie-rcar driver configures ranges for PCIe inbound transactions based
on dma-ranges property in it's device tree node. In the current device
tree for this platform, that only contains one range and it is in lower
memory.

NVMe driver tries i/o to kmalloc()ed area. That returns 0x5xxxxxxxx
addresses here. As a quick experiment, I tried to add second range to
pcie-rcar's dma-ranges to cover 0x5xxxxxxxx area - but that did not make
DMA to high addresses working.

My current understanding is that host bridge hardware module can't
handle inbound transactions to PCI addresses above 4G - and this
limitations comes from host bridge itself.

I've read somewhere in the lists that pcie-rcar hardware is "32-bit" -
but I don't remember where, and don't know lowlevel details. Maybe
somebody from linux-renesas can elaborate?


>> In current device trees no dma-ranges is defined for nodes that are
>> parents to pci host bridges. This will make of_dma_configure() to fall
>> back to 32-bit size for all devices on all current platforms.  Thus
>> applying this patch will immediately break 64-bit dma masks on all
>> hardware that supports it.
> 
> No, it won't break it, it will just fall back to swiotlb for all the
> ones that are lacking the dma-ranges property. I think this is correct
> behavior.

I'd say - for all ones that have parents without dma-ranges property.

As of 4.10-rc2, I see only two definitions of wide parent dma-ranges
under arch/arm64/boot/dts/ - in amd/amd-seattle-soc.dtsi and
apm/apm-storm.dtsi

Are these the only arm64 platforms that can to DMA to high addresses?
I'm not arm64 expert but I'd be surprised if that's the case.


>> Also related: dma-ranges property used by several pci host bridges is
>> *not* compatible with "legacy" dma-ranges parsed by of_get_dma_range() -
>> former uses additional flags word at beginning.
> 
> Can you elaborate? Do we have PCI host bridges that use wrongly formatted
> dma-ranges properties?

of_dma_get_range() expects <dma_addr cpu_addr size> format.

pcie-rcar.c, pci-rcar-gen2.c, pci-xgene.c and pcie-iproc.c from
drivers/pci/host/ all parse dma-ranges using of_pci_range_parser that
uses <flags pci-addr cpu-addr size> format - i.e. something different
from what of_dma_get_range() uses.


Nikita

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
