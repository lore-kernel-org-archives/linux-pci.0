Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <bce32071-4159-3bdd-1e03-77f540ee4509@codeaurora.org>
Date: Wed, 28 Feb 2018 15:34:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-3-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +int iommu_sva_unbind_group(struct iommu_group *group, int pasid)
> +{
> +	struct group_device *device;
> +
> +	mutex_lock(&group->mutex);
> +	list_for_each_entry(device, &group->devices, list)
> +		iommu_sva_unbind_device(device->dev, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	return 0;
> +}

I think we should handle the errors returned by iommu_sva_unbind_device() here
or at least print a warning if we want to still continue unbinding. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
