Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-3-git-send-email-xieyisheng1@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kvm@vger.kernel.org>, <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "Lorenzo Pieralisi" <Lorenzo.Pieralisi@arm.com>,
        <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <tn@semihalf.com>,
        <liubo95@huawei.com>, <thunder.leizhen@huawei.com>,
        <xuzaibo@huawei.com>, <ilias.apalodimas@linaro.org>,
        <jonathan.cameron@huawei.com>, <shunyong.yang@hxt-semitech.com>,
        <nwatters@codeaurora.org>, <okaya@codeaurora.org>,
        <jcrouse@codeaurora.org>, <rfranz@cavium.com>,
        <dwmw2@infradead.org>, <jacob.jun.pan@linux.intel.com>,
        <yi.l.liu@intel.com>, <ashok.raj@intel.com>, <robdclark@gmail.com>,
        <christian.koenig@amd.com>, <bharatku@xilinx.com>,
        <robh@kernel.org>
Message-ID: <63e4b545-c6e5-f4b4-3ba1-cf7a142b64ec@huawei.com>
Date: Thu, 22 Feb 2018 17:03:41 +0800
MIME-Version: 1.0
In-Reply-To: <1519280641-30258-3-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2018/2/22 14:23, Jean-Philippe Brucker wrote:
> @@ -129,7 +439,10 @@ int iommu_sva_device_shutdown(struct device *dev)
>  int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  			  unsigned long flags, void *drvdata)
>  {
> +	int i, ret;
> +	struct io_mm *io_mm = NULL;
>  	struct iommu_domain *domain;
> +	struct iommu_bond *bond = NULL, *tmp;
>  	struct iommu_param *dev_param = dev->iommu_param;
>  
>  	domain = iommu_get_domain_for_dev(dev);
> @@ -145,7 +458,42 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
>  		return -EINVAL;
>  
> -	return -ENOSYS; /* TODO */
> +	/* If an io_mm already exists, use it */
> +	spin_lock(&iommu_sva_lock);
> +	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
> +		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
> +			continue;
> +
> +		/* Is it already bound to this device? */
> +		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
> +			if (tmp->dev != dev)
> +				continue;
> +
> +			bond = tmp;
> +			refcount_inc(&bond->refs);
> +			io_mm_put_locked(io_mm);

Should io_mm->pasid still be set to *pasid when the device already bond? so driver can
always get the right pasid if it bond to a mm multi-times, without keeping the pasid itself?

Thanks
Yisheng
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	if (bond)
> +		return 0;
> +
> +	if (!io_mm) {
> +		io_mm = io_mm_alloc(domain, dev, mm);
> +		if (IS_ERR(io_mm))
> +			return PTR_ERR(io_mm);
> +	}
> +
> +	ret = io_mm_attach(domain, dev, io_mm, drvdata);
> +	if (ret)
> +		io_mm_put(io_mm);
> +	else
> +		*pasid = io_mm->pasid;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_bind_device);

