Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 7/9] PCI/portdrv: Simplify PCIe feature permission checking
Date: Wed, 07 Mar 2018 12:12:23 +0100
Message-ID: <1968778.zdc3jR63hy@aspire.rjw.lan>
In-Reply-To: <152040324229.240786.12446096160159507017.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040324229.240786.12446096160159507017.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 7, 2018 7:14:02 AM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some PCIe features (AER, DPC, hotplug, PME) can be managed by either the
> platform firmware or the OS, so the host bridge driver may have to request
> permission from the platform before using them.  On ACPI systems, this is
> done by negotiate_os_control() in acpi_pci_root_add().
> 
> The PCIe port driver later uses pcie_port_platform_notify() and
> pcie_port_acpi_setup() to figure out whether it can use these features.
> But all we need is a single bit for each service, so these interfaces are
> needlessly complicated.
> 
> Simplify this by adding bits in the struct pci_host_bridge to show when the
> OS has permission to use each feature:
> 
>   + unsigned int use_aer:1;       /* OS may use PCIe AER */
>   + unsigned int use_hotplug:1;	  /* OS may use PCIe hotplug */
>   + unsigned int use_pme:1;       /* OS may use PCIe PME */
> 
> These are set when we create a host bridge, and the host bridge driver can
> clear the bits corresponding to any feature the platform doesn't want us to
> use.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_root.c         |   13 ++++++++++--
>  drivers/pci/pcie/Makefile       |    1 -
>  drivers/pci/pcie/portdrv.h      |   11 ----------
>  drivers/pci/pcie/portdrv_core.c |   42 ++++++++++++++++++++++++---------------
>  drivers/pci/probe.c             |   10 +++++++++
>  include/linux/pci.h             |    3 +++
>  6 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6fc204a52493..dce53527cdc1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -871,6 +871,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	struct acpi_device *device = root->device;
>  	int node = acpi_get_node(device->handle);
>  	struct pci_bus *bus;
> +	struct pci_host_bridge *host_bridge;
>  
>  	info->root = root;
>  	info->bridge = device;
> @@ -895,9 +896,17 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!bus)
>  		goto out_release_info;
>  
> +	host_bridge = to_pci_host_bridge(bus->bridge);
> +	if (!(root->osc_control_set & PCIE_PORT_SERVICE_HP))
> +		host_bridge->use_hotplug = 0;
> +	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> +		host_bridge->use_aer = 0;
> +	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> +		host_bridge->use_pme = 0;
> +
>  	pci_scan_child_bus(bus);
> -	pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
> -				    acpi_pci_root_release_info, info);
> +	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
> +				    info);
>  	if (node != NUMA_NO_NODE)
>  		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
>  	return bus;
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index e01c10c97b95..11fb633b866c 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -7,7 +7,6 @@
>  obj-$(CONFIG_PCIEASPM)		+= aspm.o
>  
>  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o
> -pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 749d200936d9..2c19cf9ffea2 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -66,15 +66,4 @@ static inline bool pcie_pme_no_msi(void) { return false; }
>  static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
> -#ifdef CONFIG_ACPI
> -void pcie_port_acpi_setup(struct pci_dev *port, int *mask);
> -
> -static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask)
> -{
> -	pcie_port_acpi_setup(port, mask);
> -}
> -#else /* !CONFIG_ACPI */
> -static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
> -#endif /* !CONFIG_ACPI */
> -
>  #endif /* _PORTDRV_H_ */
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 94ce4dc50d1a..29210e9bfbd3 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -207,19 +207,20 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>   */
>  static int get_port_device_capability(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	bool native;
>  	int services = 0;
> -	int cap_mask = 0;
>  
> -	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP;
> -	if (pci_aer_available())
> -		cap_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
> -
> -	if (pcie_ports_auto)
> -		pcie_port_platform_notify(dev, &cap_mask);
> +	/*
> +	 * If the user specified "pcie_ports=native", use the PCIe services
> +	 * regardless of whether the platform has given us permission.  On
> +	 * ACPI systems, this means we ignore _OSC.
> +	 */
> +	native = !pcie_ports_auto;
>  
> -	/* Hot-Plug Capable */
> -	if ((cap_mask & PCIE_PORT_SERVICE_HP) && dev->is_hotplug_bridge) {
> +	if (dev->is_hotplug_bridge && (native || host->use_hotplug)) {
>  		services |= PCIE_PORT_SERVICE_HP;
> +
>  		/*
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
> @@ -227,20 +228,27 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
>  			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
>  	}
> -	/* AER capable */
> -	if ((cap_mask & PCIE_PORT_SERVICE_AER)
> -	    && pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
> +
> +	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR) &&
> +	    pci_aer_available() && (native || host->use_aer)) {
>  		services |= PCIE_PORT_SERVICE_AER;
> +
>  		/*
>  		 * Disable AER on this port in case it's been enabled by the
>  		 * BIOS (the AER service driver will enable it when necessary).
>  		 */
>  		pci_disable_pcie_error_reporting(dev);
>  	}
> -	/* Root ports are capable of generating PME too */
> -	if ((cap_mask & PCIE_PORT_SERVICE_PME)
> -	    && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +
> +	/*
> +	 * Root ports are capable of generating PME too.  Root Complex
> +	 * Event Collectors can also generate PMEs, but we don't handle
> +	 * those yet.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    (native || host->use_pme)) {
>  		services |= PCIE_PORT_SERVICE_PME;
> +
>  		/*
>  		 * Disable PME interrupt on this port in case it's been enabled
>  		 * by the BIOS (the PME service driver will enable it when
> @@ -248,7 +256,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 */
>  		pcie_pme_interrupt_enable(dev, false);
>  	}
> -	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC))
> +
> +	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> +	    pci_aer_available())
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	return services;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef5377438a1e..839fb0059900 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -540,6 +540,16 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  	INIT_LIST_HEAD(&bridge->windows);
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  
> +	/*
> +	 * We assume we can manage these PCIe features.  Some systems may
> +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> +	 * may implement its own AER handling and use _OSC to prevent the
> +	 * OS from interfering.
> +	 */
> +	bridge->use_aer = 1;
> +	bridge->use_hotplug = 1;
> +	bridge->use_pme = 1;
> +
>  	return bridge;
>  }
>  EXPORT_SYMBOL(pci_alloc_host_bridge);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..40aec7a6fdd9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -469,6 +469,9 @@ struct pci_host_bridge {
>  	struct msi_controller *msi;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> +	unsigned int	use_aer:1;		/* OS may use PCIe AER */
> +	unsigned int	use_hotplug:1;		/* OS may use PCIe hotplug */
> +	unsigned int	use_pme:1;		/* OS may use PCIe PME */
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> 
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
