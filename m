Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 1/9] PCI/PM: Move pcie_clear_root_pme_status() to core
Date: Wed, 07 Mar 2018 11:24:24 +0100
Message-ID: <10009696.o2NQuGtdHo@aspire.rjw.lan>
In-Reply-To: <152040320934.240786.9241781859071768363.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040320934.240786.9241781859071768363.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 7, 2018 7:13:29 AM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Move pcie_clear_root_pme_status() from the port driver to the PCI core so
> it will be available even when the port driver isn't present.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c              |    9 +++++++++
>  drivers/pci/pci.h              |    1 +
>  drivers/pci/pcie/portdrv.h     |    2 --
>  drivers/pci/pcie/portdrv_pci.c |    9 ---------
>  4 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..120e3393fc35 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1683,6 +1683,15 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>  }
>  EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  
> +/**
> + * pcie_clear_root_pme_status - Clear root port PME interrupt status.
> + * @dev: PCIe root port or event collector.
> + */
> +void pcie_clear_root_pme_status(struct pci_dev *dev)
> +{
> +	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
> +}
> +
>  /**
>   * pci_check_pme_status - Check if given device has generated PME.
>   * @dev: Device to check.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fcd81911b127..813ca2c895d8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -71,6 +71,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_power_up(struct pci_dev *dev);
>  void pci_disable_enabled_device(struct pci_dev *dev);
>  int pci_finish_runtime_suspend(struct pci_dev *dev);
> +void pcie_clear_root_pme_status(struct pci_dev *dev);
>  int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
>  void pci_pme_restore(struct pci_dev *dev);
>  bool pci_dev_keep_suspended(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index a854bc569117..a4fc44d52206 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -34,8 +34,6 @@ void pcie_port_bus_unregister(void);
>  
>  struct pci_dev;
>  
> -void pcie_clear_root_pme_status(struct pci_dev *dev);
> -
>  #ifdef CONFIG_HOTPLUG_PCI_PCIE
>  extern bool pciehp_msi_disabled;
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index fb1c1bb87316..4413dd85e923 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -50,15 +50,6 @@ __setup("pcie_ports=", pcie_port_setup);
>  
>  /* global data */
>  
> -/**
> - * pcie_clear_root_pme_status - Clear root port PME interrupt status.
> - * @dev: PCIe root port or event collector.
> - */
> -void pcie_clear_root_pme_status(struct pci_dev *dev)
> -{
> -	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
> -}
> -
>  static int pcie_portdrv_restore_config(struct pci_dev *dev)
>  {
>  	int retval;
> 
> 
