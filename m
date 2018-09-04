Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeIECDi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 22:03:38 -0400
Date: Tue, 4 Sep 2018 15:38:04 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 10/16] PCI/portdrv: Provide pci error callbacks
Message-ID: <20180904213804.GD18331@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-11-keith.busch@intel.com>
 <20180902101641.v25o44om2ed2sf2a@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180902101641.v25o44om2ed2sf2a@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 02, 2018 at 12:16:41PM +0200, Lukas Wunner wrote:
> On Fri, Aug 31, 2018 at 03:26:33PM -0600, Keith Busch wrote:
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -139,13 +139,45 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> >  	pcie_port_device_remove(dev);
> >  }
> >  
> > +static int detected_iter(struct device *device, void *data)
> > +{
> > +	struct pci_dev *pdev = data;
> > +	struct pcie_port_service_driver *driver;
> > +
> > +	if (device->bus == &pcie_port_bus_type && device->driver) {
> > +		driver = to_service_driver(device->driver);
> > +		if (driver && driver->error_detected)
> > +			driver->error_detected(pdev);
> > +	}
> > +	return 0;
> > +}
> 
> You're passing a pci_dev to the ->error_detected callback and this
> forces the callback to laboriously find its own pcie port service device,
> as visible in patch [13/16], where pciehp_error_detected() contains:
> 
> 	struct device *device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
> 	if (!device)
> 		return;
> 	pcie_dev = to_pcie_device(device);
> 
> This seems backwards, the callbacks should be passed a pcie_device
> instead of a pci_dev.
> 
> Same for the ->slot_reset callback iterator added in this patch.

I agree that is better. I was only trying to stick with the existing
pattern, but I can change that as a prep patch preceeding adding these
error callbacks, no problem.
