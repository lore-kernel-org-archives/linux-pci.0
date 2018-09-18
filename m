Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbeIRQbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 12:31:36 -0400
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
To: Stephen Warren <swarren@wwwdotorg.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
Date: Tue, 18 Sep 2018 11:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Stephen,

On 17/09/18 22:36, Stephen Warren wrote:
> Joerg, Christoph, Marek, Robin,
> 
> I believe that the driver for our PCIe endpoint controller hardware will 
> need to explicitly manage its IOVA space more than current APIs allow. 
> I'd like to discuss how to make that possible.
> 
> First some background on our hardware:
> 
> NVIDIA's Xavier SoC contains a Synopsis Designware PCIe controller. This 
> can operate in either root port or endpoint mode. I'm particularly 
> interested in endpoint mode.
> 
> Our particular instantiation of this controller exposes a single 
> function with a single software-controlled PCIe BAR to the PCIe bus 
> (there are also BARs for access to DMA controller registers and outbound 
> MSI configuration, which can both be enabled/disabled but not used for 
> any other purpose). When a transaction is received from the PCIe bus, 
> the following happens:
> 
> 1) Transaction is matched against the BAR base/size (in PCIe address 
> space) to determine whether it "hits" this BAR or not.
> 
> 2) The transaction's address is processed by the PCIe controller's ATU 
> (Address Translation Unit), which can re-write the address that the 
> transaction accesses.
> 
> Our particular instantiation of the hardware only has 2 entries in the 
> ATU mapping table, which gives very little flexibility in setting up a 
> mapping.
> 
> As an FYI, ATU entries can match PCIe transactions either:
> a) Any transaction received on a particular BAR.
> b) Any transaction received within a single contiguous window of PCIe 
> address space. This kind of mapping entry obviously has to be set up 
> after device enumeration is complete so that it can match the correct 
> PCIe address.
> 
> Each ATU entry maps a single contiguous set of PCIe addresses to a 
> single contiguous set of IOVAs which are passed to the IOMMU. 
> Transactions can pass through the ATU without being translated if desired.
> 
> 3) The transaction is passed to the IOMMU, which can again re-write the 
> address that the transaction accesses.
> 
> 4) The transaction is passed to the memory controller and reads/writes 
> DRAM.
> 
> In general, we want to be able to expose a large and dynamic set of data 
> buffers to the PCIe bus; certainly /far/ more than two separate buffers 
> (the number of ATU table entries). With current Linux APIs, these 
> buffers will not be located in contiguous or adjacent physical (DRAM) or 
> virtual (IOVA) addresses, nor in any particular window of physical or 
> IOVA addresses. However, the ATU's mapping from PCIe to IOVA can only 
> expose one or two contiguous ranges of IOVA space. These two sets of 
> requirements are at odds!
> 
> So, I'd like to propose some new APIs that the PCIe endpoint driver can 
> use:
> 
> 1) Allocate/reserve an IOVA range of specified size, but don't map 
> anything into the IOVA range.
> 
> 2) De-allocate the IOVA range allocated in (1).
> 
> 3) Map a specific set (scatter-gather list I suppose) of 
> already-allocated/extant physical addresses into part of an IOVA range 
> allocated in (1).
> 
> 4) Unmap a portion of an IOVA range that was mapped by (3).

That all sounds perfectly reasonable - basically it sounds like the 
endpoint framework wants the option to do the same as VFIO or many DRM 
drivers, i.e. set up its own IOMMU domain, attach the endpoint's group, 
and explicitly manage its mappings via IOMMU API calls. Provided you can 
assume cache-coherent PCI, that should be enough to get things going - 
supporting non-coherent endpoints is a little trickier in terms of 
making sure the endpoint controller and/or device gets the right DMA ops 
to only ever perform cache maintenance once you add streaming DMA 
mappings into the mix, but that's not insurmountable (and I think it's 
something we still need to address for DRM anyway, at least on arm64)

> One final note:
> 
> The memory controller can translate accesses to a small region of DRAM 
> address space into accesses to an interrupt generation module. This 
> allows devices attached to the PCIe bus to generate interrupts to 
> software running on the system with the PCIe endpoint controller. Thus I 
> deliberately described API 3 above as mapping a specific physical 
> address into IOVA space, as opposed to mapping an existing DRAM 
> allocation into IOVA space, in order to allow mapping this interrupt 
> generation address space into IOVA space. If we needed separate APIs to 
> map physical addresses vs. DRAM allocations into IOVA space, that would 
> likely be fine too.

If that's the standard DesignWare MSI dingaling, then all you should 
need to do is ensure you IOVA is reserved in your allocator (if it can 
be entirely outside the EP BAR, even better) - AFAIK the writes get 
completely intercepted such that they never go out to the SMMU side at 
all, and thus no actual mapping is even needed.

> Does this API proposal sound reasonable?

Indeed, as I say apart from using streaming DMA for coherency management 
(which I think could be added in pretty much orthogonally later), this 
sounds like something you could plumb into the endpoint framework right 
now with no dependent changes elsewhere.

> I have heard from some NVIDIA developers that the above APIs rather go 
> against the principle that individual drivers should not be aware of the 
> presence/absence of an IOMMU, and hence direct management of IOVA 
> allocation/layout is deliberately avoided, and hence there hasn't been a 
> need/desire for this kind of API in the past. However, I think our 
> current hardware design and use-case rather requires it. Do you agree?

If there is a principle, it's more the inverse - the point of things 
like SWIOTLB and iommu-dma is that we don't want to *have* to add 
IOMMU-awareness or explicit bounce-buffering to every driver or 
subsystem which might ever find itself on a machine with more memory 
than its device can address natively. Thus drivers which only need to 
use the DMA API can continue to do so and the arch code hooks up this 
stuff automatically to make sure that just works. However, drivers which 
*do* expect their device to have an IOMMU, and have good cause to manage 
it themselves to do things that simple DMA API calls can't, should of 
course be welcome to implement that extra code and depend on IOMMU_API 
if they so wish. Again, DRM drivers are the prime example (er, no pun 
intended) - simple ones let drm_gem_cma_helper et al do all the heavy 
lifting for them, more complex ones get their hands dirty.

Robin.
