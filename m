Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Mar 2016 10:30:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
	mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v4 5/7] vfio-pci: Allow to mmap sub-page MMIO BARs
 if the mmio page is exclusive
Message-ID: <20160316103034.48666ae0@t450s.home>
In-Reply-To: <1457336918-3893-6-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1457336918-3893-6-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon,  7 Mar 2016 15:48:36 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> Current vfio-pci implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
> page may be shared with other BARs.
> 
> But we should allow to mmap these sub-page MMIO BARs if PCI
> resource allocator can make sure these BARs' mmio page will
> not be shared with other BARs.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 1ce1d36..49d7a69 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -589,7 +589,8 @@ static long vfio_pci_ioctl(void *device_data,
>  				     VFIO_REGION_INFO_FLAG_WRITE;
>  			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
>  			    pci_resource_flags(pdev, info.index) &
> -			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
> +			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
> +			    info.index)) {

this would be a preferable line wrap:

                            IORESOURCE_MEM &&
                            !pci_resources_share_page(pdev, info.index)) {

>  				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
>  				if (info.index == vdev->msix_bar) {
>  					ret = msix_sparse_mmap_cap(vdev, &caps);
> @@ -1016,6 +1017,10 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  		return -EINVAL;
>  
>  	phys_len = pci_resource_len(pdev, index);
> +
> +	if (!pci_resources_share_page(pdev, index))
> +		phys_len = PAGE_ALIGN(phys_len);
> +
>  	req_len = vma->vm_end - vma->vm_start;
>  	pgoff = vma->vm_pgoff &
>  		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
