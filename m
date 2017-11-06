Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbdKFTzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Nov 2017 14:55:07 -0500
Date: Mon, 6 Nov 2017 13:55:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: alex.williamson@redhat.com,
        Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, alexander.h.duyck@intel.com
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
Message-ID: <20171106195505.GH31930@bhelgaas-glaptop.roam.corp.google.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 24, 2017 at 01:04:26PM -0700, Jeff Kirsher wrote:
> From: Liang-Min Wang <liang-min.wang@intel.com>
> 
> When a SR-IOV supported device is bound with vfio-pci, the driver
> could not create SR-IOV instance through /sys/bus/pci/devices/...
> /sriov_numvfs. This patch re-activates this capability for a PCIe 
> device that supports SR-IOV and is bound with vfio-pci.ko. 
> 
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>

Dropping this for now, given Alex W's issues.  Please address his
concerns and repost as needed.

> ---
>  drivers/vfio/pci/vfio_pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
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
> -- 
> 2.14.2
> 
