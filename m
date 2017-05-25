Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <09d0c4de-ec01-bcce-9901-5ff36c6c69bd@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <5923F5B1.2080209@huawei.com>
 <09d0c4de-ec01-bcce-9901-5ff36c6c69bd@arm.com>
From: "Roy Franz (Cavium)" <roy.lists@gmail.com>
Date: Thu, 25 May 2017 11:27:18 -0700
Message-ID: <CAK-u0Q=29a3fRQHJiUoDtFO6vc9dbD3KH5zQf=Hpx6hhJhxjYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: roy.franz@cavium.com
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>,
 Will Deacon <will.deacon@arm.com>, LinuxArm <linuxarm@huawei.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 4:21 AM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> On 23/05/17 09:41, Leizhen (ThunderTown) wrote:
>> On 2017/2/28 3:54, Jean-Philippe Brucker wrote:
>>> PCIe devices can implement their own TLB, named Address Translation Cache
>>> (ATC). Steps involved in the use and maintenance of such caches are:
>>>
>>> * Device sends an Address Translation Request for a given IOVA to the
>>>   IOMMU. If the translation succeeds, the IOMMU returns the corresponding
>>>   physical address, which is stored in the device's ATC.
>>>
>>> * Device can then use the physical address directly in a transaction.
>>>   A PCIe device does so by setting the TLP AT field to 0b10 - translated.
>>>   The SMMU might check that the device is allowed to send translated
>>>   transactions, and let it pass through.
>>>
>>> * When an address is unmapped, CPU sends a CMD_ATC_INV command to the
>>>   SMMU, that is relayed to the device.
>>>
>>> In theory, this doesn't require a lot of software intervention. The IOMMU
>>> driver needs to enable ATS when adding a PCI device, and send an
>>> invalidation request when unmapping. Note that this invalidation is
>>> allowed to take up to a minute, according to the PCIe spec. In
>>> addition, the invalidation queue on the ATC side is fairly small, 32 by
>>> default, so we cannot keep many invalidations in flight (see ATS spec
>>> section 3.5, Invalidate Flow Control).
>>>
>>> Handling these constraints properly would require to postpone
>>> invalidations, and keep the stale mappings until we're certain that all
>>> devices forgot about them. This requires major work in the page table
>>> managers, and is therefore not done by this patch.
>>>
>>>   Range calculation
>>>   -----------------
>>>
>>> The invalidation packet itself is a bit awkward: range must be naturally
>>> aligned, which means that the start address is a multiple of the range
>>> size. In addition, the size must be a power of two number of 4k pages. We
>>> have a few options to enforce this constraint:
>>>
>>> (1) Find the smallest naturally aligned region that covers the requested
>>>     range. This is simple to compute and only takes one ATC_INV, but it
>>>     will spill on lots of neighbouring ATC entries.
>>>
>>> (2) Align the start address to the region size (rounded up to a power of
>>>     two), and send a second invalidation for the next range of the same
>>>     size. Still not great, but reduces spilling.
>>>
>>> (3) Cover the range exactly with the smallest number of naturally aligned
>>>     regions. This would be interesting to implement but as for (2),
>>>     requires multiple ATC_INV.
>>>
>>> As I suspect ATC invalidation packets will be a very scarce resource,
>>> we'll go with option (1) for now, and only send one big invalidation.
>>>
>>> Note that with io-pgtable, the unmap function is called for each page, so
>>> this doesn't matter. The problem shows up when sharing page tables with
>>> the MMU.
>> Suppose this is true, I'd like to choose option (2). Because the worst cases of
>> both (1) and (2) will not be happened, but the code of (2) will look clearer.
>> And (2) is technically more acceptable.
>
> I agree that (2) is a bit clearer, but the question is of performance
> rather than readability. I'd like to see some benchmarks or experiment on
> my own before switching to a two-invalidation system.
>
> Intuitively one big invalidation will result in more ATC trashing and will
> bring overall device performance down. But then according to the PCI spec,
> ATC invalidations are grossly expensive, they have an upper bound of a
> minute. I agree that this is highly improbable and might depend on the
> range size, but purely from an architectural standpoint, reducing the
> number of ATC invalidation requests is the priority, because this is much
> worse than any performance slow-down incurred by ATC trashing. And for the
> moment I can only base my decisions on the architecture.
>
> So I'd like to keep (1) for now, and update it to (2) (or even (3)) once
> we have more hardware to experiment with.
>
> Thanks,
> Jean
>

I think (1) is a good place to start, as the same restricted encoding
that is used in
the invalidations is also used in the translation responses - all of
the ATC entries
were created with regions described this way.  We still may end up with nothing
but STU sized ATC entries, as TAs are free to respond to large
translation requests
with multiple STU sized translations, and in some cases this is the
best that they
can do.  Picking the optimal strategy will depend on hardware, and
maybe workload
as well.

Thanks,
Roy


>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
