Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
From: Bob Liu <liubo95@huawei.com>
Message-ID: <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
Date: Wed, 22 Nov 2017 11:15:24 +0800
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com,
 catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com, dwmw2@infradead.org,
 rjw@rjwysocki.net, robdclark@gmail.com, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, robin.murphy@arm.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hey Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> IOMMU drivers need a way to bind Linux processes to devices. This is used
> for Shared Virtual Memory (SVM), where devices support paging. In that
> mode, DMA can directly target virtual addresses of a process.
> 
> Introduce boilerplate code for allocating process structures and binding
> them to devices. Four operations are added to IOMMU drivers:
> 
> * process_alloc, process_free: to create an iommu_process structure and
>   perform architecture-specific operations required to grab the process
>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>   iommu_process structure per Linux process.
> 

I'm a bit confused here.
The original meaning of iommu_domain is a virtual addrspace defined by a set of io page table.
(fix me if I misunderstood).
Then what's the meaning of iommu_domain and iommu_process after introducing iommu_process?
Could you consider document these concepts? 

Thanks,
Liubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
