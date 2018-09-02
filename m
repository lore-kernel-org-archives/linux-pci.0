Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56039 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBOb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 10:31:58 -0400
Date: Sun, 2 Sep 2018 12:16:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 10/16] PCI/portdrv: Provide pci error callbacks
Message-ID: <20180902101641.v25o44om2ed2sf2a@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-11-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-11-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:33PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -139,13 +139,45 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	pcie_port_device_remove(dev);
>  }
>  
> +static int detected_iter(struct device *device, void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pcie_port_service_driver *driver;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		driver = to_service_driver(device->driver);
> +		if (driver && driver->error_detected)
> +			driver->error_detected(pdev);
> +	}
> +	return 0;
> +}

You're passing a pci_dev to the ->error_detected callback and this
forces the callback to laboriously find its own pcie port service device,
as visible in patch [13/16], where pciehp_error_detected() contains:

	struct device *device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
	if (!device)
		return;
	pcie_dev = to_pcie_device(device);

This seems backwards, the callbacks should be passed a pcie_device
instead of a pci_dev.

Same for the ->slot_reset callback iterator added in this patch.

Thanks,

Lukas
