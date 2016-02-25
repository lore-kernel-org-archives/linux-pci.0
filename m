Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33519 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760752AbcBYPhb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 10:37:31 -0500
Date: Thu, 25 Feb 2016 09:37:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com
Subject: Re: [RFC V2 2/4] IOMMU: Force the VFs of an untrusted PF device to
 be in the PFs IOMMU group
Message-ID: <20160225153726.GD8120@localhost>
References: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
 <1454574537-123466-3-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454574537-123466-3-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 10:28:55AM +0200, Ilya Lesokhin wrote:
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
>  include/linux/pci.h         | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 049df49..864b459 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -738,6 +738,10 @@ static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
>  	struct iommu_group *group = NULL;
>  	u64 devfns[4] = { 0 };
>  
> +	if (pdev->is_virtfn && 
> +	   (pdev->physfn->dev_flags & PCI_DEV_FLAGS_UNTRUSTED))
> +		return iommu_group_get(&pdev->physfn->dev);
> +	
>  	/*
>  	 * Find the upstream DMA alias for the device.  A device must not
>  	 * be aliased due to topology in order to have its own IOMMU group.
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 964ad57..ddcfd2c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -982,6 +982,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		pci_set_power_state(pdev, PCI_D3hot);
>  	}
>  
> +	pdev->dev_flags |= PCI_DEV_FLAGS_UNTRUSTED;
> +
>  	return ret;
>  }
>  
> @@ -989,6 +991,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  {
>  	struct vfio_pci_device *vdev;
>  
> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_UNTRUSTED;
>  	vdev = vfio_del_group_dev(&pdev->dev);
>  	if (!vdev)
>  		return;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e90eb22..6330327 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -182,6 +182,7 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>  	/* Get VPD from function 0 VPD */
>  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> +	PCI_DEV_FLAGS_UNTRUSTED = (__force pci_dev_flags_t) (1 << 9),

I'm raising my eyebrows a bit at this.  PCI_DEV_FLAGS_UNTRUSTED
doesn't seem like a PCI core property, so it seems like the PCI core
is an innocent bystander here (it neither sets nor checks the flag),
and you're asking it to keep track of bookkeeping details for other
unrelated entities.

>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
