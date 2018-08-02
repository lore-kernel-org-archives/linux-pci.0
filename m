Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeHBSq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 14:46:27 -0400
Date: Thu, 2 Aug 2018 17:54:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for
 adding a new device
Message-ID: <20180802165430.GA13725@red-moon>
References: <20180801151403.20660-1-hch@lst.de>
 <20180801151403.20660-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801151403.20660-2-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 05:14:01PM +0200, Christoph Hellwig wrote:
> There is currently no way for a PCIe bridge to impose constraints on
> devices added to it.  For example, the Xilinx PCIe host bridge only
> supports 32-bit physical addresses (due to a limitation on the AXI
> port's address width).  Thus, even devices that claim to support 64-bit
> DMA addresses must be restricted to 32-bit addresses when attached to
> this host controller.
> 
> This patch adds a "add_dev" method  to struct pci_host_bridge that
> allows the host driver to act upon acting adding devices.
> 
> Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/probe.c | 4 ++++
>  include/linux/pci.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e32de4b..8736d78ffc66 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2290,6 +2290,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>  
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
>  	int ret;
>  
>  	pci_configure_device(dev);
> @@ -2331,6 +2332,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	/* Set up MSI IRQ domain */
>  	pci_set_msi_domain(dev);
>  
> +	if (host->add_dev)
> +		host->add_dev(dev);

Hi Christoph,

while at it, IMHO it would be good to match the current
pcibios_add_device() prototype (ie returning an int error value)
so that this change can pave the way to removing yet another
pcibios call.

Actually we could make pcibios_add_device() removal as part of this
series but you would have to patch all related host bridge drivers
initializations so I am happy for this patch to go standalone (I can
patch the rest of the code) - I leave it to Bjorn's decision.

Thanks,
Lorenzo

> +
>  	/* Notifier could use PCI capabilities */
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index abd5d5e17aee..5eedae8e8f2b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -485,6 +485,7 @@ struct pci_host_bridge {
>  			resource_size_t start,
>  			resource_size_t size,
>  			resource_size_t align);
> +	void (*add_dev)(struct pci_dev *dev);
>  	unsigned long	private[0] ____cacheline_aligned;
>  };
>  
> -- 
> 2.18.0
> 
