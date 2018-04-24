Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
Date: Mon, 23 Apr 2018 21:32:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 catalin.marinas@arm.com, xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 will.deacon@arm.com, yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
 ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org, bharatku@xilinx.com,
 rfranz@cavium.com, lenb@kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, shunyong.yang@hxt-semitech.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
 robdclark@gmail.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> /**
>   * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
>   * @dev: the device
> @@ -129,7 +439,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
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
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	if (bond)

Please return pasid when you find an io_mm that is already bound. Something like
*pasid = io_mm->pasid should do the work here when bond is true.

> +		return 0;


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
