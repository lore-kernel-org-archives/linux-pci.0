Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 0/7] Add PCI ATS support to SMMUv3
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
From: Nate Watterson <nwatters@codeaurora.org>
Message-ID: <2ae88519-7dbb-97ee-1ef9-8a92c31472d5@codeaurora.org>
Date: Wed, 31 May 2017 11:27:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, will.deacon@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, okaya@codeaurora.org, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,

On 5/24/2017 2:01 PM, Jean-Philippe Brucker wrote:
> PCIe devices can implement their own TLB, named Address Translation Cache
> (ATC). In order to support Address Translation Service (ATS), the
> following changes are needed in software:
> 
> * Enable ATS on endpoints when the system supports it. Both PCI root
>    complex and associated SMMU must implement the ATS protocol.
> 
> * When unmapping an IOVA, send an ATC invalidate request to the endpoint
>    in addition to the usual SMMU IOTLB invalidations.
> 
> I previously sent this as part of a lengthy RFC [1] adding SVM (ATS +
> PASID + PRI) support to SMMUv3. The next PASID/PRI version is almost
> ready, but isn't likely to get merged because it needs hardware testing,
> so I will send it later. PRI depends on ATS, but ATS should be useful on
> its own.
> 
> Without PASID and PRI, ATS is used for accelerating transactions. Instead
> of having all memory accesses go through SMMU translation, the endpoint
> can translate IOVA->PA once, store the result in its ATC, then issue
> subsequent transactions using the PA, partially bypassing the SMMU. So in
> theory it should be faster while keeping the advantages of an IOMMU,
> namely scatter-gather and access control.
> 
> The ATS patches can now be tested on some hardware, even though the lack
> of compatible PCI endpoints makes it difficult to assess what performance
> optimizations we need. That's why the ATS implementation is a bit rough at
> the moment, and we will work on optimizing things like invalidation ranges
> later.

Sinan and I have tested this series on a QDF2400 development platform
using a PCIe exerciser card as the ATS capable endpoint. We were able
to verify that ATS requests complete with a valid translated address
and that DMA transactions using the pre-translated address "bypass"
the SMMU. Testing ATC invalidations was a bit more difficult as we
could not figure out how to get the exerciser card to automatically
send the completion message. We ended up having to write a debugger
script that would monitor the CMDQ and tell the exerciser to send
the completion when a hanging CMD_SYNC following a CMD_ATC_INV was
detected. Hopefully we'll get some real ATS capable endpoints to
test with soon.

> 
> Since the RFC [1]:
> * added DT and ACPI patches,
> * added invalidate-all on domain detach,
> * removed smmu_group again,
> * removed invalidation print from the fast path,
> * disabled tagged pointers for good,
> * some style changes.
> 
> These patches are based on Linux v4.12-rc2
> 
> [1] https://www.spinics.net/lists/linux-pci/msg58650.html
> 
> Jean-Philippe Brucker (7):
>    PCI: Move ATS declarations outside of CONFIG_PCI
>    dt-bindings: PCI: Describe ATS property for root complex nodes
>    iommu/of: Check ATS capability in root complex nodes
>    ACPI/IORT: Check ATS capability in root complex nodes
>    iommu/arm-smmu-v3: Link domains and devices
>    iommu/arm-smmu-v3: Add support for PCI ATS
>    iommu/arm-smmu-v3: Disable tagged pointers
> 
>   .../devicetree/bindings/pci/pci-iommu.txt          |   8 +
>   drivers/acpi/arm64/iort.c                          |  10 +
>   drivers/iommu/arm-smmu-v3.c                        | 258 ++++++++++++++++++++-
>   drivers/iommu/of_iommu.c                           |   8 +
>   include/linux/iommu.h                              |   4 +
>   include/linux/pci.h                                |  26 +--
>   6 files changed, 293 insertions(+), 21 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
