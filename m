Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 19 May 2016 16:33:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
	kevin.tian@intel.com
Subject: Re: [PATCH v3] vfio-pci: Allow to mmap sub-page MMIO BARs if the
 mmio page is exclusive
Message-ID: <20160519163319.0fdaf76a@ul30vt.home>
In-Reply-To: <1463048451-7086-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1463048451-7086-1-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 12 May 2016 18:20:51 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> Current vfio-pci implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
> page may be shared with other BARs. This will cause some
> performance issues when we passthrough a PCI device with
> this kind of BARs. Guest will be not able to handle the mmio
> accesses to the BARs which leads to mmio emulations in host.
> 
> However, not all sub-page BARs will share page with other BARs.
> We should allow to mmap the sub-page MMIO BARs which we can
> make sure will not share page with other BARs.
> 
> This patch adds support for this case. And we try to add a
> dummy resource to reserve the remainder of the page which
> hot-add device's BAR might be assigned into. But it's not
> necessary to handle the case when the BAR is not page aligned.
> Because we can't expect the BAR will be assigned into the same
> location in a page in guest when we passthrough the BAR. And
> it's hard to access this BAR in userspace because we have
> no way to get the BAR's location in a page.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |   70 +++++++++++++++++++++++++++++++----
>  drivers/vfio/pci/vfio_pci_private.h |    8 ++++
>  2 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 188b1ff..253c22f 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -110,6 +110,50 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>  }
>  
> +static bool vfio_pci_bar_mmap_supported(struct vfio_pci_device *vdev, int index)
> +{
> +	struct resource *res = vdev->pdev->resource + index;
> +	struct vfio_pci_dummy_resource *dummy_res = NULL;
> +
> +	if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP))
> +		return false;
> +
> +	if (!(res->flags & IORESOURCE_MEM))
> +		return false;
> +
> +	/*
> +	 * The PCI core shouldn't set up a resource with a type but
> +	 * zero size. But there may be bugs that cause us to do that.
> +	 */
> +	if (!resource_size(res))
> +		return false;
> +
> +	if (resource_size(res) >= PAGE_SIZE)
> +		return true;
> +
> +	if (!(res->start & ~PAGE_MASK)) {
> +		/*
> +		 * Add a dummy resource to reserve the remainder
> +		 * of the exclusive page in case that hot-add
> +		 * device's bar is assigned into it.
> +		 */
> +		dummy_res = kzalloc(sizeof(*dummy_res), GFP_KERNEL);
> +		if (dummy_res == NULL)
> +			return false;
> +		dummy_res->resource.start = res->end + 1;
> +		dummy_res->resource.end = res->start + PAGE_SIZE - 1;
> +		dummy_res->resource.flags = res->flags;
> +		if (request_resource(res->parent, &dummy_res->resource)) {
> +			kfree(dummy_res);
> +			return false;
> +		}
> +		dummy_res->index = index;
> +		list_add(&dummy_res->res_next, &vdev->dummy_resources_list);
> +		return true;
> +	}
> +	return false;
> +}

The name of this function is vfio_pci_bar_mmap_supported(), which
suggests we should be able to call it at any point to test if mmap is
supported, but that's not what it does.  It's actually a one time setup
function, that also happens to return what it found or managed to
reserve.  If we were to call this a second time, we might get a
different result.  So I think this either needs to change to something
like:

static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)

where it loops through all the BARs and results in a valid
bar_mmap_supported array, or the function should be made smart enough
to identify if the necessary resource has already been allocated such
that it can be call multiple times per BAR, at which point we could
remove the bar_mmap_supported array.

A comment describing why we can only support sub-page mmaps for
resources aligned at the start of a page would also be helpful for
future maintenance here.

> +
>  static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
>  static void vfio_pci_disable(struct vfio_pci_device *vdev);
>  
> @@ -145,10 +189,12 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
>  static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> -	int ret;
> +	int ret, bar;
>  	u16 cmd;
>  	u8 msix_pos;
>  
> +	INIT_LIST_HEAD(&vdev->dummy_resources_list);
> +
>  	pci_set_power_state(pdev, PCI_D0);
>  
>  	/* Don't allow our initial saved state to include busmaster */
> @@ -218,12 +264,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		}
>  	}
>  
> +	for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
> +		vdev->bar_mmap_supported[bar] =
> +				vfio_pci_bar_mmap_supported(vdev, bar);
> +	}
>  	return 0;
>  }
>  
>  static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> +	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>  	int i, bar;
>  
>  	/* Stop the device from further DMA */
> @@ -252,6 +303,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  		vdev->barmap[bar] = NULL;
>  	}
>  
> +	list_for_each_entry_safe(dummy_res, tmp,
> +				 &vdev->dummy_resources_list, res_next) {
> +		list_del(&dummy_res->res_next);
> +		release_resource(&dummy_res->resource);
> +		kfree(dummy_res);
> +	}
> +
>  	vdev->needs_reset = true;
>  
>  	/*
> @@ -623,9 +681,7 @@ static long vfio_pci_ioctl(void *device_data,
>  
>  			info.flags = VFIO_REGION_INFO_FLAG_READ |
>  				     VFIO_REGION_INFO_FLAG_WRITE;
> -			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
> -			    pci_resource_flags(pdev, info.index) &
> -			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
> +			if (vdev->bar_mmap_supported[info.index]) {
>  				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
>  				if (info.index == vdev->msix_bar) {
>  					ret = msix_sparse_mmap_cap(vdev, &caps);
> @@ -1049,16 +1105,16 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if (index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -EINVAL;
> -	if (!(pci_resource_flags(pdev, index) & IORESOURCE_MEM))
> +	if (!vdev->bar_mmap_supported[index])
>  		return -EINVAL;
>  
> -	phys_len = pci_resource_len(pdev, index);
> +	phys_len = PAGE_ALIGN(pci_resource_len(pdev, index));
>  	req_len = vma->vm_end - vma->vm_start;
>  	pgoff = vma->vm_pgoff &
>  		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>  	req_start = pgoff << PAGE_SHIFT;
>  
> -	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
> +	if (req_start + req_len > phys_len)
>  		return -EINVAL;

I'm only able to find your QEMU patch from last year, have you posted a
version making use of this latest proposal?  Is the expectation still
that QEMU modify the BAR size as seen from the guest to the host page
size for sub-page regions exposing the MMAP flag?  Does that result in
any known incompatibilities with drivers in the guest?  Thanks,

Alex

>  
>  	if (index == vdev->msix_bar) {
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 016c14a..2128de8 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -57,9 +57,16 @@ struct vfio_pci_region {
>  	u32				flags;
>  };
>  
> +struct vfio_pci_dummy_resource {
> +	struct resource		resource;
> +	int			index;
> +	struct list_head	res_next;
> +};
> +
>  struct vfio_pci_device {
>  	struct pci_dev		*pdev;
>  	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
> +	bool			bar_mmap_supported[PCI_STD_RESOURCE_END + 1];
>  	u8			*pci_config_map;
>  	u8			*vconfig;
>  	struct perm_bits	*msi_perm;
> @@ -88,6 +95,7 @@ struct vfio_pci_device {
>  	int			refcnt;
>  	struct eventfd_ctx	*err_trigger;
>  	struct eventfd_ctx	*req_trigger;
> +	struct list_head	dummy_resources_list;
>  };
>  
>  #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
