Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Mar 2018 16:19:31 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
Message-ID: <087d3daa-5b63-038b-a81e-92ab752fdd26@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <5A97A324.9050605@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <5A97A324.9050605@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/18 06:52, Lu Baolu wrote:
> Can the pasid management code be moved into a common library?
> PASID is not stick to SVA. An IOMMU model device could be designed
> to use PASID for second level translation (classical DMA translation)
> as well.

What do you mean by second level translation? Do you see a use-case with
nesting translation within the host?

I agree that PASID + classical DMA is desirable. A device driver would
allocate PASIDs and perform iommu_sva_map(domain, pasid, iova, pa, size,
prot) and iommu_sva_unmap(domain, pasid, iova, size). I'm hoping that we
can also augment the DMA API with PASIDs, and that a driver can use both
shared and private contexts simultaneously. So that it can use a few
PASIDs for management purpose, and assign the rest to userspace.

The intent is for iommu-sva.c to be this common library. Work for
"private" PASID allocation is underway, see Jordan Crouse's series
posted last week https://www.spinics.net/lists/arm-kernel/msg635857.html

Thanks,
Jean


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
