Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Jan 2017 12:30:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] PCI: mvebu: Handle changes to the bridge windows while
 enabled
Message-ID: <20170111183055.GD14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20161212183020.GA30274@obsidianresearch.com>
MIME-Version: 1.0
In-Reply-To: <20161212183020.GA30274@obsidianresearch.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 12, 2016 at 11:30:20AM -0700, Jason Gunthorpe wrote:
> The PCI core will write to the bridge window config multiple times
> while they are enabled. This can lead to mbus failures like:
> 
>  mvebu_mbus: cannot add window '4:e8', conflicts with another window
>  mvebu-pcie mbus:pex@e0000000: Could not create MBus window at [mem 0xe0000000-0xe00fffff]: -22
> 
> For me this is happening during a hotplug cycle. The PCI core is
> not changing the values, just writing them twice while active.
> 
> The patch addresses the general case of any change to an active window,
> but not atomically. The code is slightly refactored so io and mem
> can share more of the window logic.

Looks good to me, but I'm waiting for an ack from Thomas or Jason (listed
as maintainers and already cc'd).

> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 101 +++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 307f81d6b479af..af724731b22f53 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -133,6 +133,12 @@ struct mvebu_pcie {
>  	int nports;
>  };
>  
> +struct mvebu_pcie_window {
> +	phys_addr_t base;
> +	phys_addr_t remap;
> +	size_t size;
> +};
> +
>  /* Structure representing one PCIe interface */
>  struct mvebu_pcie_port {
>  	char *name;
> @@ -150,10 +156,8 @@ struct mvebu_pcie_port {
>  	struct mvebu_sw_pci_bridge bridge;
>  	struct device_node *dn;
>  	struct mvebu_pcie *pcie;
> -	phys_addr_t memwin_base;
> -	size_t memwin_size;
> -	phys_addr_t iowin_base;
> -	size_t iowin_size;
> +	struct mvebu_pcie_window memwin;
> +	struct mvebu_pcie_window iowin;
>  	u32 saved_pcie_stat;
>  };
>  
> @@ -379,23 +383,45 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>  	}
>  }
>  
> +static void mvebu_pcie_set_window(struct mvebu_pcie_port *port,
> +				  unsigned int target, unsigned int attribute,
> +				  const struct mvebu_pcie_window *desired,
> +				  struct mvebu_pcie_window *cur)
> +{
> +	if (desired->base == cur->base && desired->remap == cur->remap &&
> +	    desired->size == cur->size)
> +		return;
> +
> +	if (cur->size != 0) {
> +		mvebu_pcie_del_windows(port, cur->base, cur->size);
> +		cur->size = 0;
> +		cur->base = 0;
> +
> +		/*
> +		 * If something tries to change the window while it is enabled
> +		 * the change will not be done atomically. That would be
> +		 * difficult to do in the general case.
> +		 */
> +	}
> +
> +	if (desired->size == 0)
> +		return;
> +
> +	mvebu_pcie_add_windows(port, target, attribute, desired->base,
> +			       desired->size, desired->remap);
> +	*cur = *desired;
> +}
> +
>  static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  {
> -	phys_addr_t iobase;
> +	struct mvebu_pcie_window desired = {};
>  
>  	/* Are the new iobase/iolimit values invalid? */
>  	if (port->bridge.iolimit < port->bridge.iobase ||
>  	    port->bridge.iolimitupper < port->bridge.iobaseupper ||
>  	    !(port->bridge.command & PCI_COMMAND_IO)) {
> -
> -		/* If a window was configured, remove it */
> -		if (port->iowin_base) {
> -			mvebu_pcie_del_windows(port, port->iowin_base,
> -					       port->iowin_size);
> -			port->iowin_base = 0;
> -			port->iowin_size = 0;
> -		}
> -
> +		mvebu_pcie_set_window(port, port->io_target, port->io_attr,
> +				      &desired, &port->iowin);
>  		return;
>  	}
>  
> @@ -412,32 +438,27 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  	 * specifications. iobase is the bus address, port->iowin_base
>  	 * is the CPU address.
>  	 */
> -	iobase = ((port->bridge.iobase & 0xF0) << 8) |
> -		(port->bridge.iobaseupper << 16);
> -	port->iowin_base = port->pcie->io.start + iobase;
> -	port->iowin_size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> -			    (port->bridge.iolimitupper << 16)) -
> -			    iobase) + 1;
> -
> -	mvebu_pcie_add_windows(port, port->io_target, port->io_attr,
> -			       port->iowin_base, port->iowin_size,
> -			       iobase);
> +	desired.remap = ((port->bridge.iobase & 0xF0) << 8) |
> +			(port->bridge.iobaseupper << 16);
> +	desired.base = port->pcie->io.start + desired.remap;
> +	desired.size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> +			 (port->bridge.iolimitupper << 16)) -
> +			desired.remap) +
> +		       1;
> +
> +	mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
> +			      &port->iowin);
>  }
>  
>  static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  {
> +	struct mvebu_pcie_window desired = {.remap = MVEBU_MBUS_NO_REMAP};
> +
>  	/* Are the new membase/memlimit values invalid? */
>  	if (port->bridge.memlimit < port->bridge.membase ||
>  	    !(port->bridge.command & PCI_COMMAND_MEMORY)) {
> -
> -		/* If a window was configured, remove it */
> -		if (port->memwin_base) {
> -			mvebu_pcie_del_windows(port, port->memwin_base,
> -					       port->memwin_size);
> -			port->memwin_base = 0;
> -			port->memwin_size = 0;
> -		}
> -
> +		mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
> +				      &desired, &port->memwin);
>  		return;
>  	}
>  
> @@ -447,14 +468,12 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  	 * window to setup, according to the PCI-to-PCI bridge
>  	 * specifications.
>  	 */
> -	port->memwin_base  = ((port->bridge.membase & 0xFFF0) << 16);
> -	port->memwin_size  =
> -		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> -		port->memwin_base + 1;
> -
> -	mvebu_pcie_add_windows(port, port->mem_target, port->mem_attr,
> -			       port->memwin_base, port->memwin_size,
> -			       MVEBU_MBUS_NO_REMAP);
> +	desired.base = ((port->bridge.membase & 0xFFF0) << 16);
> +	desired.size = (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> +		       desired.base + 1;
> +
> +	mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
> +			      &port->memwin);
>  }
>  
>  /*
> -- 
> 2.7.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
