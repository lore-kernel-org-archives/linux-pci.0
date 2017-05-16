Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 16 May 2017 17:15:29 +0200
From: Robert Richter <robert.richter@cavium.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [RFC/RFT PATCH v2 3/3] PCI/ACPI: Add ACPI
 pci_bus_find_numa_node() implementation
Message-ID: <20170516151529.GC658@rric.localdomain>
References: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
 <20170515132205.19622-4-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170515132205.19622-4-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.05.17 14:22:05, Lorenzo Pieralisi wrote:
> The introduction of pci_bus_find_numa_node(pci_bus) allows at PCI
> host bridge registration to detect the NUMA node for a given
> struct pci_bus.dev. Implement an ACPI method that, through
> the struct pci_bus.bridge ACPI companion, retrieve and return
> the NUMA node corresponding to a given struct pci_bus.dev.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-acpi.c | 20 ++++++++++++++++++++
>  drivers/pci/pci.c      |  2 +-
>  include/linux/pci.h    |  6 ++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9803c1..451342d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5406,7 +5406,7 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  
>  int pci_bus_find_numa_node(struct pci_bus *bus)
>  {
> -	return NUMA_NO_NODE;
> +	return acpi_disabled ? NUMA_NO_NODE : acpi_pci_bus_find_numa_node(bus);

I looked into how this works with devicetree.

With ACPI it is set directly in pci_register_host_bridge() with
set_dev_node().

For the DT case the set_dev_node call sets it to NUMA_NO_NODE first.
Since in DT the bridge is a platform device which has the node id
assigned already (if there is one), the bus' node id is set later in
device_add() when deriving it from the parent device which is the
bridge. So this should work.

I have tested it both DT and ACPI.

Thanks,

-Robert

>  }
>  
>  /**
