Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdJXVoR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 17:44:17 -0400
Date: Tue, 24 Oct 2017 23:43:51 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, alexander.h.duyck@intel.com
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
Message-ID: <20171024234351.0af0ff4a@t450s.home>
In-Reply-To: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Oct 2017 13:04:26 -0700
Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:

> From: Liang-Min Wang <liang-min.wang@intel.com>
> 
> When a SR-IOV supported device is bound with vfio-pci, the driver
> could not create SR-IOV instance through /sys/bus/pci/devices/...
> /sriov_numvfs. This patch re-activates this capability for a PCIe 
> device that supports SR-IOV and is bound with vfio-pci.ko. 
> 
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)


Why?  The PF bound to vfio-pci can be assigned to a user.  PFs often
have backdoors into the VF.  Therefore this enables creation of a VF in
the host that may be snooped or manipulated by a user.  This clearly
seems like a security issue.  Thanks,

Alex

 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index f041b1a6cf66..8fbd362607e1 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1256,6 +1256,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  	if (!vdev)
>  		return;
>  
> +	pci_disable_sriov(pdev);
>  	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
>  	kfree(vdev->region);
>  	kfree(vdev);
> @@ -1303,12 +1304,23 @@ static const struct pci_error_handlers vfio_err_handlers = {
>  	.error_detected = vfio_pci_aer_err_detected,
>  };
>  
> +static int vfio_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	if (!num_vfs) {
> +		pci_disable_sriov(pdev);
> +		return 0;
> +	}
> +
> +	return pci_enable_sriov(pdev, num_vfs);
> +}
> +
>  static struct pci_driver vfio_pci_driver = {
>  	.name		= "vfio-pci",
>  	.id_table	= NULL, /* only dynamic ids */
>  	.probe		= vfio_pci_probe,
>  	.remove		= vfio_pci_remove,
>  	.err_handler	= &vfio_err_handlers,
> +	.sriov_configure = vfio_sriov_configure,
>  };
>  
>  struct vfio_devices {
