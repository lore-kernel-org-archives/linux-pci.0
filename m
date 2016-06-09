Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41622 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbcFIWVW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jun 2016 18:21:22 -0400
Date: Thu, 9 Jun 2016 16:21:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, noaos@mellanox.com, haggaie@mellanox.com,
	ogerlitz@mellanox.com, liranl@mellanox.com
Subject: Re: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF device to
 be in the PFs IOMMU group
Message-ID: <20160609162120.43082847@ul30vt.home>
In-Reply-To: <1465474173-53960-3-git-send-email-ilyal@mellanox.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
	<1465474173-53960-3-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu,  9 Jun 2016 15:09:30 +0300
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Add a new PCI_DEV_FLAGS_UNTRUSTED to indicate that a PCI device
> is probed by a driver that gives untrusted entities access to that device.
> Make iommu_group_get_for_pci_dev check the new flag when an IOMMU
> group is selected for a virtual function.
> Mark VFIO devices with the new flag.
> 
> Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
> ---
>  drivers/iommu/iommu.c       | 4 ++++
>  drivers/vfio/pci/vfio_pci.c | 3 +++
>  include/linux/pci.h         | 3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3000051..9bb914c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -749,6 +749,10 @@ struct iommu_group *pci_device_group(struct device *dev)
>  	struct pci_bus *bus;
>  	struct iommu_group *group = NULL;
>  	u64 devfns[4] = { 0 };
> +	
> +	if (pdev->is_virtfn && 
> +	   (pdev->physfn->dev_flags & PCI_DEV_FLAGS_UNTRUSTED))
> +		return iommu_group_get(&pdev->physfn->dev);

This deserves a comment in the code as well as the commit log, but more
importantly the side effect of this is that the user can't make use of
separate IOMMU domains for the PF vs the VF.  I think this ends up
making the entire solution incompatible with things like vIOMMU since
we really need to be able to create separate address spaces per device
to make that work.  What's the point of enabling SR-IOV from userspace
if we can't do things like assign VFs to nested guests or userspace in
the guest?  This is an incomplete feature with that restriction.
Thanks,

Alex

>  
>  	if (WARN_ON(!dev_is_pci(dev)))
>  		return ERR_PTR(-EINVAL);
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 188b1ff..72d048e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1180,6 +1180,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		pci_set_power_state(pdev, PCI_D3hot);
>  	}
>  
> +	pdev->dev_flags |= PCI_DEV_FLAGS_UNTRUSTED;
> +
>  	return ret;
>  }
>  
> @@ -1187,6 +1189,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  {
>  	struct vfio_pci_device *vdev;
>  
> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_UNTRUSTED;
>  	vdev = vfio_del_group_dev(&pdev->dev);
>  	if (!vdev)
>  		return;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..bef9115 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -174,6 +174,9 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>  	/* Get VPD from function 0 VPD */
>  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> +	/* Untrusted software controls this device
> +	 * The VFs of this device should be put in the device's IOMMUs group*/
> +	PCI_DEV_FLAGS_UNTRUSTED = (__force pci_dev_flags_t) (1 << 9),
>  };
>  
>  enum pci_irq_reroute_variant {

