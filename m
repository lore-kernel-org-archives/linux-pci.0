Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdDMUv3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Apr 2017 16:51:29 -0400
Date: Thu, 13 Apr 2017 15:51:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
        linux-arm-msm@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V8 1/5] PCI/ASPM: introduce pci_aspm_init() and add to
 pci_init_capabilities()
Message-ID: <20170413205125.GC28316@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491627351-1111-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Sat, Apr 08, 2017 at 12:55:47AM -0400, Sinan Kaya wrote:
> We need a callback from pci_init_capabilities function for every
> single new PCI device that is currently being added.
> 
> pci_aspm_init() will be used to save the power on state of the HW.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pcie/aspm.c | 10 ++++++++++
>  drivers/pci/probe.c     |  3 +++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1dfa10c..dc36717 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -827,6 +827,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  }
>  
>  /*
> + * pci_aspm_init: Initiate PCI express link state.
> + * It is called from device_add for every single pci device.
> + * @pdev: all pci devices
> + */
> +int pci_aspm_init(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
> +
> +/*
>   * pcie_aspm_init_link_state: Initiate PCI express link state.
>   * It is called after the pcie and its children devices are scanned.
>   * @pdev: the root port or switch downstream port
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dfc9a27..1e19364 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1847,6 +1847,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  
>  	/* Advanced Error Reporting */
>  	pci_aer_init(dev);
> +
> +	/* Active State Power Management */
> +	pci_aspm_init(dev);
>  }
>  
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eb3da1a..8828dd7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1396,8 +1396,10 @@ static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
>  
>  #ifdef CONFIG_PCIEASPM
>  bool pcie_aspm_support_enabled(void);
> +int pci_aspm_init(struct pci_dev *pdev);

I think these can go in drivers/pci/pci.h instead of the public
include/linux/pci.h.  There's no ASPM section in drivers/pci/pci.h
yet, but I think we should add one.

It looks like the following things from include/linux/pci-aspm.h could
be moved there as well, since they're only used by the PCI core:

  void pcie_aspm_init_link_state(struct pci_dev *pdev);
  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
  void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
  void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);

This would be a separate patch.

>  #else
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
> +static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; }
>  #endif
>  
>  #ifdef CONFIG_PCIEAER
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
