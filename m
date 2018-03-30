Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeC3XWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 19:22:17 -0400
Date: Fri, 30 Mar 2018 18:22:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/IOV: Use VF0 cached config space size for
 other VFs
Message-ID: <20180330232215.GJ9322@bhelgaas-glaptop.roam.corp.google.com>
References: <1521489961-18291-1-git-send-email-karahmed@amazon.de>
 <1521489961-18291-2-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521489961-18291-2-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 19, 2018 at 09:06:01PM +0100, KarimAllah Ahmed wrote:
> Cache the config space size from VF0 and use it for all other VFs instead
> of reading it from the config space of each VF.  We assume that it will be
> the same across all associated VFs.
> 
> This is an optimization when enabling SR-IOV on a device with many VFs.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

I didn't apply this one because:

  - I don't like the "add two leading underscores to the name"
    disease.  I'd really like pci_cfg_space_size() to be able to
    figure out whether this is VF0 and do the right thing.  But I
    don't know if we can tell from the pci_dev whether it is VF0.  We
    do know that every VF is a PCIe device; maybe that's useful
    somehow.

  - Whatever the name ends up being, it should be declared in
    drivers/pci/pci.h, not include/linux/pci.h, because it shouldn't
    be used outside the PCI core.

> ---
>  drivers/pci/iov.c   |  3 +++
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 11 ++++++++++-
>  include/linux/pci.h |  1 +
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 30bf8f7..046e0d3 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -135,6 +135,9 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  			     &physfn->sriov->subsystem_vendor);
>  	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
>  			     &physfn->sriov->subsystem_device);
> +
> +	virtfn->class = physfn->sriov->class;

Oops, where did this come from?  It looks like this belongs in a
different patch because this patch doesn't do anything else with
virtfn->class.

> +	physfn->sriov->cfg_size = __pci_cfg_space_size(virtfn);
>  }
>  
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index bdb4ba2..69da57b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -271,6 +271,7 @@ struct pci_sriov {
>  	u16		driver_max_VFs;	/* Max num VFs driver supports */
>  	struct pci_dev	*dev;		/* Lowest numbered PF */
>  	struct pci_dev	*self;		/* This PF */
> +	u32		cfg_size;	/* VF config space size */
>  	u32		class;		/* VF device */
>  	u8		hdr_type;	/* VF header type */
>  	u16		subsystem_vendor; /* VF subsystem vendor */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 21ee1c3..fd21e2b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1365,7 +1365,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
>  	return PCI_CFG_SPACE_EXP_SIZE;
>  }
>  
> -int pci_cfg_space_size(struct pci_dev *dev)
> +int __pci_cfg_space_size(struct pci_dev *dev)
>  {
>  	int pos;
>  	u32 status;
> @@ -1389,6 +1389,15 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  	return PCI_CFG_SPACE_SIZE;
>  }
>  
> +int pci_cfg_space_size(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_ATS
> +	if (dev->is_virtfn)
> +		return dev->physfn->sriov->cfg_size;
> +#endif
> +	return __pci_cfg_space_size(dev);
> +}
> +
>  static int pci_cfg_space_class(struct pci_dev *dev)
>  {
>  	int class;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1be..fcd5d88 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1290,6 +1290,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>  
>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>  		  void *userdata);
> +int __pci_cfg_space_size(struct pci_dev *dev);
>  int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
> -- 
> 2.7.4
> 
