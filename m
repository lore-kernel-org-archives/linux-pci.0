Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdKHXFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Nov 2017 18:05:40 -0500
Date: Wed, 8 Nov 2017 17:05:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
        jjalvare@linux.vnet.ibm.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, linuxppc-devel@lists.ozlabs.org,
        bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
Subject: Re: [PATCH v4 3/3] pci/iov: Expose VF drivers Auto Probe Globally
Message-ID: <20171108230537.GD21597@bhelgaas-glaptop.roam.corp.google.com>
References: <20171031144724.27808-1-bryantly@linux.vnet.ibm.com>
 <20171031144724.27808-4-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031144724.27808-4-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please update the subject line from

  pci/iov: Expose VF drivers Auto Probe Globally

to

  PCI/IOV: Add pci_vf_drivers_autoprobe() interface

so it matches the other changelogs (most of the previous iov.c changes
use just "PCI:", but I think it makes sense to use "PCI/IOV:"
similarly to "PCI/MSI:").

On Tue, Oct 31, 2017 at 09:47:24AM -0500, Bryant G. Ly wrote:
> When SR-IOV is supported in pci_dev struct the
> member variable drivers_autoprobe controls the
> VF drivers auto probe functionality. This
> patch exposes a gloabal function to be used
> if needed when configuring the pci_dev sriov object.

And change the changelog to:

  Add a pci_vf_drivers_autoprobe() interface.  Setting autoprobe to false
  on the PF prevents drivers from binding to VFs when they are enabled.

> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pci.c |  2 ++
>  drivers/pci/iov.c                    | 12 ++++++++++++
>  include/linux/pci.h                  |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 14a90cf471cc..48d3af026f90 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -63,6 +63,7 @@ int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>  {
>  	/* Allocate PCI data */
>  	add_dev_pci_data(pdev);
> +	pci_vf_drivers_autoprobe(pdev, false);
>  	return 0;
>  }
>  
> @@ -70,6 +71,7 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
>  {
>  	/* Release PCI data */
>  	remove_dev_pci_data(pdev);
> +	pci_vf_drivers_autoprobe(pdev, true);
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ac41c8be9200..41465c06975c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -634,6 +634,18 @@ void pci_restore_iov_state(struct pci_dev *dev)
>  }
>  
>  /**
> + * pci_vf_drivers_autoprobe - set pf property drivers_autoprobe for vfs
> + * @dev: the PCI device
> + * @auto_probe: set vf drivers auto probe flag

In the text (not the function name),

s/pf/PF/
s/for vfs//
s/vf/VF/

> + */
> +void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
> +{
> +	if (dev->is_physfn)
> +		dev->sriov->drivers_autoprobe = auto_probe;
> +}
> +EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);

I don't think this needs to be exported.  It's only called from arch
code that cannot be a module.

With these changes,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge these via the powerpc tree.  Let me know if you
need anything else from me.

> +/**
>   * pci_iov_bus_range - find bus range used by Virtual Function
>   * @bus: the PCI bus
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f4f8ee5a7362..17a08554baa2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1965,6 +1965,7 @@ int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
> +void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
>  #else
>  static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>  {
> @@ -1992,6 +1993,7 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>  { return 0; }
>  static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>  { return 0; }
> +static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
>  #endif
>  
>  #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
> -- 
> 2.13.5 (Apple Git-94)
> 
