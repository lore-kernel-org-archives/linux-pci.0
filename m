Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <683a518d-0e22-c855-2416-2e097ec3291d@codeaurora.org>
Date: Sat, 21 Oct 2017 11:47:53 -0400
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just some improvement suggestions.

On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
> +	spin_lock(&iommu_process_lock);
> +	idr_for_each_entry(&iommu_process_idr, process, i) {
> +		if (process->pid != pid)
> +			continue;
if you see this construct a lot, this could be a for_each_iommu_process.

> +
> +		if (!iommu_process_get_locked(process)) {
> +			/* Process is defunct, create a new one */
> +			process = NULL;
> +			break;
> +		}
> +
> +		/* Great, is it also bound to this domain? */
> +		list_for_each_entry(cur_context, &process->domains,
> +				    process_head) {
> +			if (cur_context->domain != domain)
> +				continue;
if you see this construct a lot, this could be a for_each_iommu_process_domain.

> +
> +			context = cur_context;
> +			*pasid = process->pasid;
> +
> +			/* Splendid, tell the driver and increase the ref */
> +			err = iommu_process_attach_locked(context, dev);
> +			if (err)
> +				iommu_process_put_locked(process);
> +
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_process_lock);
> +	put_pid(pid);
> +
> +	if (context)
> +		return err;

I think you should make the section above a independent function and return here when the
context is found.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
