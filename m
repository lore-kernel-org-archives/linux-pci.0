Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 17 May 2017 16:35:58 +0200
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
Message-ID: <20170517143558.GP16981@rric.localdomain>
References: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
 <20170515132205.19622-4-lorenzo.pieralisi@arm.com>
 <20170516151529.GC658@rric.localdomain>
 <20170516180200.GA24458@red-moon>
 <20170517134654.GA8497@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517134654.GA8497@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17.05.17 14:46:54, Lorenzo Pieralisi wrote:

> More explicitly, I think the whole series should work also with the diff
> below applied on top of it. Side note: for consistency, I do not think
> that adding a DT counterpart to pci_bus_find_numa_node() would hurt.
> 
> Thanks !
> Lorenzo
> 
> -- >8 --
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 76c089f..cf0692c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -862,7 +862,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  	 */
>  	child->dev.class = &pcibus_class;
>  	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
> -	set_dev_node(&child->dev, dev_to_node(&parent->dev));
> +

Hmm, in device_add() there is already:

	/* use parent numa_node */
	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
        	set_dev_node(dev, dev_to_node(parent));

So there are cases where the device has a different node than the
parent. I am not sure if we can assume for pci that it maps always.

And since device_add() is called later anyway, the above change might
not necessary at all. But at least we must assign the node id to the
bridge, which is the parent. Maybe just have in
acpi_pci_root_create():

	bridge = get_device(bus->bridge);
	adev = to_acpi_device_node(bridge->fwnode);
	set_dev_node(bridge, acpi_get_node(adev->handle));

-Robert


>  	/*
>  	 * Set up the primary, secondary and subordinate
>  	 * bus numbers.
