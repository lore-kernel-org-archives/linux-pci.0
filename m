Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Fri, 17 Nov 2017 06:11:17 +0000
Message-ID: <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
In-Reply-To: <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, list)
> +		arm_smmu_atc_inv_master(master, &cmd);
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
> +	return size;
> +}
> +
>  /* IOMMU API */
>  static bool arm_smmu_capable(enum iommu_cap cap)  { @@ -2361,6 +2506,8 @@ static void arm_smmu_detach_dev(struct device *dev)
>  		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
>  
>  	if (smmu_domain) {
> +		arm_smmu_atc_inv_master_all(master, 0);
> +
> In BIND flow, when VFIO_IOMMU_UNBIND is invoked invalidation is sent on allocated PASID for this application.
> When vfio group fd is closed after UNBIND,  arm_smmu_detach_dev is invoked now invalidation is being sent on ssid zero.
> Why  invalidation needs to be sent on ssid zero ?

It's possible to use bind/unbind and map/unmap APIs at the same time on a domain. map/unmap modifies non-ssid mappings as usual, for context descriptor 0. Note that SSID 0 is converted to "no SSID" by arm_smmu_atc_inv_to_cmd.

That said, I think VFIO cleans all DMA mappings when the VFIO group fd is closed, which will send individual ATC invalidation for each mapping. But VFIO may not be the only user of this API, and future users may be less careful. It's safer to send this global invalidation whenever we detach the domain, to ensure we're not leaving stale ATC entries for the next user.

Thanks Jean, I see that currently vfio_group_fops_open does not allow multiple instances. 
If a device supports multiple PASID there might be different applications running parallel. 
So why is multiple instances restricted ?

Regards,
Bharat




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
