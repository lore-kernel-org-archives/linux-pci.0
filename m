Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 16 May 2015 09:02:30 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v1] ARM: pci: add call to pcie_bus_configure_settings()
Message-ID: <20150516140230.GF31666@google.com>
References: <1401297293-3950-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401297293-3950-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 28, 2014 at 01:14:53PM -0400, Murali Karicheri wrote:
> Call pcie_bus_configure_settings on ARM, like for other platforms.
> pcie_bus_configure_settings makes sure the MPS across the bus is
> uniform and provides the ability to tune the MRSS and MPS to higher
> performance values. This is particularly important for embedded where
> there is no firmware to program these PCI-E settings for the OS.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  - Fixed comments against initial version
>  arch/arm/kernel/bios32.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 16d43cd..17a26c1 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -545,6 +545,18 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  		 */
>  		pci_bus_add_devices(bus);
>  	}
> +
> +	list_for_each_entry(sys, &head, node) {
> +		struct pci_bus *bus = sys->bus;
> +
> +		/* Configure PCI Express settings */
> +		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> +			struct pci_bus *child;
> +
> +			list_for_each_entry(child, &bus->children, node)
> +				pcie_bus_configure_settings(child);

This patch (8b5742ad156d ("ARM/PCI: Call pcie_bus_configure_settings() to
set MPS")) has been upstream since v3.16-rc1, but I think we goofed.

The MPS configuration should be done *before* pci_bus_add_devices().  After
pci_bus_add_devices(), drivers may be bound to devices, and the PCI core
shouldn't touch device configuration while a driver owns the device.

Looking at the code, it seems like it would have been simpler to do this in
the existing loop:

  list_for_each_entry(sys, &head, node) {
    struct pci_bus *bus = sys->bus;

    if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
      pci_bus_size_bridges(bus);
      pci_bus_assign_resources(bus);
      list_for_each_entry(child, &bus->children, node)
        pcie_bus_configure_settings(child);
    }

    pci_bus_add_devices(bus);
  }

so maybe there's some reason I'm not aware of for not doing it that way?

> +		}
> +	}
>  }
>  
>  #ifndef CONFIG_PCI_HOST_ITE8152
> -- 
> 1.7.9.5
> 
