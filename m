Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 16:19:47 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
Message-ID: <20150721211947.GI21967@google.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-5-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436962613-17359-5-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 15, 2015 at 01:16:38PM +0100, Marc Zyngier wrote:
> In order to be able to populate the device msi_domain field,
> add the necesary hooks to propagate the host bridge msi_domain

s/necesary/necessary/

> across secondary busses to devices.
> 
> So far, nobody populates the initial msi_domain.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..376f6fa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -661,6 +661,20 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>  	}
>  }
>  
> +void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
> +{
> +}
> +
> +static void pci_set_bus_msi_domain(struct pci_bus *bus)
> +{
> +	struct pci_dev *bridge = bus->self;
> +
> +	if (!bridge)
> +		pcibios_set_host_bridge_msi_domain(bus);

I would use pci_is_root_bus() here instead of testing "!bridge".

> +	else
> +		dev_set_msi_domain(&bus->dev, dev_get_msi_domain(&bridge->dev));
> +}
> +
>  static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  					   struct pci_dev *bridge, int busnr)
>  {
> @@ -714,6 +728,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  	bridge->subordinate = child;
>  
>  add_dev:
> +	pci_set_bus_msi_domain(child);
>  	ret = device_register(&child->dev);
>  	WARN_ON(ret < 0);
>  
> @@ -1544,6 +1559,17 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  }
>  
> +static void pci_set_msi_domain(struct pci_dev *dev)
> +{
> +	/*
> +	 * If no domain has been set through the pcibios callback,
> +	 * inherit the default from the bus device.
> +	 */
> +	if (!dev_get_msi_domain(&dev->dev))
> +		dev_set_msi_domain(&dev->dev,
> +				   dev_get_msi_domain(&dev->bus->dev));
> +}
> +
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -1585,6 +1611,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	ret = pcibios_add_device(dev);
>  	WARN_ON(ret < 0);
>  
> +	/* Setup MSI irq domain */
> +	pci_set_msi_domain(dev);
> +
>  	/* Notifier could use PCI capabilities */
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
> @@ -1975,6 +2004,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	b->bridge = get_device(&bridge->dev);
>  	device_enable_async_suspend(b->bridge);
>  	pci_set_bus_of_node(b);
> +	pci_set_bus_msi_domain(b);
>  
>  	if (!parent)
>  		set_dev_node(b->bridge, pcibus_to_node(b));
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fbf245f..fe0825f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1644,6 +1644,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
>  int pcibios_add_device(struct pci_dev *dev);
>  void pcibios_release_device(struct pci_dev *dev);
>  void pcibios_penalize_isa_irq(int irq, int active);
> +void pcibios_set_host_bridge_msi_domain(struct pci_bus *bus);
>  
>  #ifdef CONFIG_HIBERNATE_CALLBACKS
>  extern struct dev_pm_ops pcibios_pm_ops;
> -- 
> 2.1.4
> 
