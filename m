Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 21/36] iommu/arm-smmu-v3: Implement process
 operations
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-22-jean-philippe.brucker@arm.com>
CC: <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <hanjun.guo@linaro.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <tn@semihalf.com>,
        <liubo95@huawei.com>, <thunder.leizhen@huawei.com>,
        <gabriele.paoloni@huawei.com>, <nwatters@codeaurora.org>,
        <okaya@codeaurora.org>, <rfranz@cavium.com>, <dwmw2@infradead.org>,
        <jacob.jun.pan@linux.intel.com>, <yi.l.liu@intel.com>,
        <ashok.raj@intel.com>, <robdclark@gmail.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <084b1848-0939-5e73-3890-3aab8dc4bc70@huawei.com>
Date: Thu, 9 Nov 2017 11:32:26 +0800
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-22-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> Hook process operations to support PASID and page table sharing with the
> SMMUv3:
> 
> +
> +static void arm_smmu_process_exit(struct iommu_domain *domain,
> +				  struct iommu_process *process)
> +{
> +	struct arm_smmu_master_data *master;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (!domain->process_exit)
> +		return;

If domain do not set process_exit handler, just return? smmu do not
need invalid ATC, clear cd entry, etc.? Maybe you should check when
call domain->process_exit?

> +
> +	spin_lock(&smmu_domain->devices_lock);
> +	list_for_each_entry(master, &smmu_domain->devices, list) {
> +		if (!master->processes)
> +			continue;
> +
> +		master->processes--;
Add
		if (domain->process_exit)
here?
> +		domain->process_exit(domain, master->dev, process->pasid,
> +				     domain->process_exit_token);
> +
> +		/* TODO: inval ATC */
> +	}
> +	spin_unlock(&smmu_domain->devices_lock);
> +
> +	arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
> +
> +	/* TODO: Invalidate all mappings if not DVM */
> +}
> +
Thanks
Yisheng Xie

