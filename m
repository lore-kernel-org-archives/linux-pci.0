Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35313 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbGTNrJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 09:47:09 -0400
Received: by igr7 with SMTP id 7so13806683igr.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 06:47:09 -0700 (PDT)
Date: Mon, 20 Jul 2015 08:47:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Cc: Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 1/8] PCI: Allocate ATS struct during enumeration
Message-ID: <20150720134704.GA16841@google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213152.18379.50159.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213152.18379.50159.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:31:52PM -0500, Bjorn Helgaas wrote:
> Previously, we allocated pci_ats structures when an IOMMU driver called
> pci_enable_ats().  An SR-IOV VF shares the STU setting with its PF, so when
> enabling ATS on the VF, we allocated a pci_ats struct for the PF if it
> didn't already have one.  We held the sriov->lock to serialize threads
> concurrently enabling ATS on several VFS so only one would allocate the PF
> pci_ats.
> 
> Gregor reported a deadlock here:
> 
>   pci_enable_sriov
>     sriov_enable
>       virtfn_add
>         mutex_lock(dev->sriov->lock)      # acquire sriov->lock
>         pci_device_add
>           device_add
>             BUS_NOTIFY_ADD_DEVICE notifier chain
>             iommu_bus_notifier
>               amd_iommu_add_device        # iommu_ops.add_device
>                 init_iommu_group
>                   iommu_group_get_for_dev
>                     iommu_group_add_device
>                       __iommu_attach_device
>                         amd_iommu_attach_device  # iommu_ops.attach_device
>                           attach_device
>                             pci_enable_ats
>                               mutex_lock(dev->sriov->lock) # deadlock
> 
> There's no reason to delay allocating the pci_ats struct, and if we
> allocate it for each device at enumeration-time, there's no need for
> locking in pci_enable_ats().
> 
> Allocate pci_ats struct during enumeration, when we initialize other
> capabilities.
> 
> Note that this implementation requires ATS to be enabled on the PF first,
> before on any of the VFs because the PF controls the STU for all the VFs.
> 
> Link: http://permalink.gmane.org/gmane.linux.kernel.iommu/9433
> Reported-by: Gregor Dick <gdick@solarflare.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c       |   81 +++++++++++++++--------------------------------
>  drivers/pci/probe.c     |    3 ++
>  drivers/pci/remove.c    |    1 +
>  include/linux/pci-ats.h |    1 -
>  include/linux/pci.h     |    9 +++++
>  5 files changed, 38 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index a8099d4..923759f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -17,7 +17,7 @@
>  
>  #include "pci.h"
>  
> -static int ats_alloc_one(struct pci_dev *dev, int ps)
> +static void ats_alloc_one(struct pci_dev *dev)
>  {
>  	int pos;
>  	u16 cap;
> @@ -25,20 +25,17 @@ static int ats_alloc_one(struct pci_dev *dev, int ps)
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
>  	if (!pos)
> -		return -ENODEV;
> +		return;
>  
>  	ats = kzalloc(sizeof(*ats), GFP_KERNEL);
>  	if (!ats)
> -		return -ENOMEM;
> +		return;
>  
>  	ats->pos = pos;
> -	ats->stu = ps;
>  	pci_read_config_word(dev, pos + PCI_ATS_CAP, &cap);
>  	ats->qdep = PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
>  					    PCI_ATS_MAX_QDEP;
>  	dev->ats = ats;
> -
> -	return 0;
>  }
>  
>  static void ats_free_one(struct pci_dev *dev)
> @@ -47,6 +44,16 @@ static void ats_free_one(struct pci_dev *dev)
>  	dev->ats = NULL;
>  }
>  
> +void pci_ats_init(struct pci_dev *dev)
> +{
> +	ats_alloc_one(dev);
> +}
> +
> +void pci_ats_free(struct pci_dev *dev)
> +{
> +	ats_free_one(dev);
> +}
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -56,43 +63,29 @@ static void ats_free_one(struct pci_dev *dev)
>   */
>  int pci_enable_ats(struct pci_dev *dev, int ps)
>  {
> -	int rc;
>  	u16 ctrl;
>  
>  	BUG_ON(dev->ats && dev->ats->is_enabled);
>  
> -	if (ps < PCI_ATS_MIN_STU)
> +	if (!dev->ats)
>  		return -EINVAL;
>  
> -	if (dev->is_physfn || dev->is_virtfn) {
> -		struct pci_dev *pdev = dev->is_physfn ? dev : dev->physfn;
> -
> -		mutex_lock(&pdev->sriov->lock);
> -		if (pdev->ats)
> -			rc = pdev->ats->stu == ps ? 0 : -EINVAL;
> -		else
> -			rc = ats_alloc_one(pdev, ps);
> +	if (ps < PCI_ATS_MIN_STU)
> +		return -EINVAL;
>  
> -		if (!rc)
> -			pdev->ats->ref_cnt++;
> -		mutex_unlock(&pdev->sriov->lock);
> -		if (rc)
> -			return rc;
> -	}
> +	ctrl = PCI_ATS_CTRL_ENABLE;
> +	if (dev->is_virtfn) {
> +		struct pci_dev *pdev = dev->physfn;
>  
> -	if (!dev->is_physfn) {
> -		rc = ats_alloc_one(dev, ps);
> -		if (rc)
> -			return rc;
> +		if (pdev->ats->stu != ps)
> +			return -EINVAL;
> +	} else {
> +		dev->ats->stu = ps;
> +		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
>  	}

I forgot to mention in the changelog that this changes the semantics of
pci_enable_ats(): previously, you could enable ATS on a VF before enabling
it on a PF.  The first call on either a PF or VF established the STU, and
subsequent calls for related VFs or PF would fail if they tried to use a
different STU.  If you disabled ATS on all the PF/VFs, you could start over
with a different STU.

With this patch, you have to enable ATS on a PF first, before enabling it
on any of its VFs.  The VFs must use the same STU as the PF.  And there's
no way to change the STU unless the device is removed and re-enumerated.

I think this is sufficient for current usage, but let me know if it's not.

> -
> -	ctrl = PCI_ATS_CTRL_ENABLE;
> -	if (!dev->is_virtfn)
> -		ctrl |= PCI_ATS_CTRL_STU(ps - PCI_ATS_MIN_STU);
>  	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
>  
>  	dev->ats->is_enabled = 1;
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_ats);
> @@ -112,19 +105,6 @@ void pci_disable_ats(struct pci_dev *dev)
>  	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
>  
>  	dev->ats->is_enabled = 0;
> -
> -	if (dev->is_physfn || dev->is_virtfn) {
> -		struct pci_dev *pdev = dev->is_physfn ? dev : dev->physfn;
> -
> -		mutex_lock(&pdev->sriov->lock);
> -		pdev->ats->ref_cnt--;
> -		if (!pdev->ats->ref_cnt)
> -			ats_free_one(pdev);
> -		mutex_unlock(&pdev->sriov->lock);
> -	}
> -
> -	if (!dev->is_physfn)
> -		ats_free_one(dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_ats);
>  
> @@ -140,7 +120,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
>  	ctrl = PCI_ATS_CTRL_ENABLE;
>  	if (!dev->is_virtfn)
>  		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
> -
>  	pci_write_config_word(dev, dev->ats->pos + PCI_ATS_CTRL, ctrl);
>  }
>  EXPORT_SYMBOL_GPL(pci_restore_ats_state);
> @@ -159,23 +138,13 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
>   */
>  int pci_ats_queue_depth(struct pci_dev *dev)
>  {
> -	int pos;
> -	u16 cap;
> -
>  	if (dev->is_virtfn)
>  		return 0;
>  
>  	if (dev->ats)
>  		return dev->ats->qdep;
>  
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> -	if (!pos)
> -		return -ENODEV;
> -
> -	pci_read_config_word(dev, pos + PCI_ATS_CAP, &cap);
> -
> -	return PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
> -				       PCI_ATS_MAX_QDEP;
> +	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..c206398 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1540,6 +1540,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	/* Single Root I/O Virtualization */
>  	pci_iov_init(dev);
>  
> +	/* Address Translation Services */
> +	pci_ats_init(dev);
> +
>  	/* Enable ACS P2P upstream forwarding */
>  	pci_enable_acs(dev);
>  }
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 8a280e9..27617b8 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -26,6 +26,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		dev->is_added = 0;
>  	}
>  
> +	pci_ats_free(dev);
>  	if (dev->bus->self)
>  		pcie_aspm_exit_link_state(dev);
>  }
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 7203178..d2e8170 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -8,7 +8,6 @@ struct pci_ats {
>  	int pos;        /* capability position */
>  	int stu;        /* Smallest Translation Unit */
>  	int qdep;       /* Invalidate Queue Depth */
> -	int ref_cnt;    /* Physical Function reference count */
>  	unsigned int is_enabled:1;      /* Enable bit is set */
>  };
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8a0321a..5c277f1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1294,6 +1294,15 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
>  void ht_destroy_irq(unsigned int irq);
>  #endif /* CONFIG_HT_IRQ */
>  
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +void pci_ats_init(struct pci_dev *dev);
> +void pci_ats_free(struct pci_dev *dev);
> +#else
> +static inline void pci_ats_init(struct pci_dev *) { }
> +static inline void pci_ats_free(struct pci_dev *) { }
> +#endif
> +
>  void pci_cfg_access_lock(struct pci_dev *dev);
>  bool pci_cfg_access_trylock(struct pci_dev *dev);
>  void pci_cfg_access_unlock(struct pci_dev *dev);
> 
