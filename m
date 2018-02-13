Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: RE: [PATCH 04/37] iommu/sva: Add a mm_exit callback for device drivers
Date: Tue, 13 Feb 2018 08:11:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910028F9@SHSMSX101.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-5-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-5-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "tn@semihalf.com" <tn@semihalf.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> From: Jean-Philippe Brucker
> Sent: Tuesday, February 13, 2018 2:33 AM
> 
> When an mm exits, devices that were bound to it must stop performing
> DMA
> on its PASID. Let device drivers register a callback to be notified on mm
> exit. Add the callback to the iommu_param structure attached to struct
> device.

what about registering the callback in sva_device_init? 

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/iommu-sva.c | 54
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h     | 18 ++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index f9af9d66b3ed..90b524c99d3d 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -569,3 +569,57 @@ void __iommu_sva_unbind_dev_all(struct device
> *dev)
>  	spin_unlock(&iommu_sva_lock);
>  }
>  EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
> +
> +/**
> + * iommu_register_mm_exit_handler() - Set a callback for mm exit
> + * @dev: the device
> + * @handler: exit handler
> + *
> + * Users of the bind/unbind API should call this function to set a
> + * device-specific callback telling them when a mm is exiting.
> + *
> + * After the callback returns, the device must not issue any more
> transaction
> + * with the PASID given as argument to the handler. In addition the
> handler gets
> + * an opaque pointer corresponding to the drvdata passed as argument of
> bind().
> + *
> + * The handler itself should return 0 on success, and an appropriate error
> code
> + * otherwise.
> + */
> +int iommu_register_mm_exit_handler(struct device *dev,
> +				   iommu_mm_exit_handler_t handler)
> +{
> +	struct iommu_param *dev_param = dev->iommu_param;
> +
> +	if (!dev_param)
> +		return -EINVAL;
> +
> +	/*
> +	 * FIXME: racy. Same as iommu_sva_device_init, but here we'll
> need a
> +	 * spinlock to call the mm_exit param from atomic context.
> +	 */
> +	if (dev_param->mm_exit)
> +		return -EBUSY;
> +
> +	get_device(dev);
> +	dev_param->mm_exit = handler;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_mm_exit_handler);
> +
> +/**
> + * iommu_unregister_mm_exit_handler() - Remove mm exit callback
> + */
> +int iommu_unregister_mm_exit_handler(struct device *dev)
> +{
> +	struct iommu_param *dev_param = dev->iommu_param;
> +
> +	if (!dev_param || !dev_param->mm_exit)
> +		return -EINVAL;
> +
> +	dev_param->mm_exit = NULL;
> +	put_device(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_mm_exit_handler);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 09d85f44142a..1b1a16892ac1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -65,6 +65,8 @@ typedef int (*iommu_dev_fault_handler_t)(struct
> iommu_fault_event *, void *);
>  /* Request I/O page fault support */
>  #define IOMMU_SVA_FEAT_IOPF		(1 << 1)
> 
> +typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid,
> void *);
> +
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped
> */
>  	dma_addr_t aperture_end;   /* Last address that can be mapped
> */
> @@ -424,6 +426,7 @@ struct iommu_param {
>  	unsigned int min_pasid;
>  	unsigned int max_pasid;
>  	struct list_head mm_list;
> +	iommu_mm_exit_handler_t mm_exit;
>  };
> 
>  int  iommu_device_register(struct iommu_device *iommu);
> @@ -941,6 +944,10 @@ extern int iommu_sva_bind_device(struct device
> *dev, struct mm_struct *mm,
>  				int *pasid, unsigned long flags, void
> *drvdata);
>  extern int iommu_sva_unbind_device(struct device *dev, int pasid);
>  extern void __iommu_sva_unbind_dev_all(struct device *dev);
> +extern int iommu_register_mm_exit_handler(struct device *dev,
> +					  iommu_mm_exit_handler_t
> handler);
> +extern int iommu_unregister_mm_exit_handler(struct device *dev);
> +
>  #else /* CONFIG_IOMMU_SVA */
>  static inline int iommu_sva_device_init(struct device *dev,
>  					unsigned long features,
> @@ -969,6 +976,17 @@ static inline int iommu_sva_unbind_device(struct
> device *dev, int pasid)
>  static inline void __iommu_sva_unbind_dev_all(struct device *dev)
>  {
>  }
> +
> +static inline int iommu_register_mm_exit_handler(struct device *dev,
> +						 iommu_mm_exit_handler_t
> handler)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_mm_exit_handler(struct device *dev)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_IOMMU_SVA */
> 
>  #endif /* __LINUX_IOMMU_H */
> --
> 2.15.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
