Return-Path: <SRS0=JVz2=IJ=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=JVz2=IJ=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Doug Meyer <dmeyer@gigaio.com>
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
 linux-ntb <linux-ntb@googlegroups.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
 <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
 <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
 <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
 <20180522215126.GA22385@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <598f5880-22b2-bbb4-4a37-5a60bae2348b@deltatee.com>
Date: Tue, 22 May 2018 16:23:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180522215126.GA22385@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
List-ID: <linux-pci.vger.kernel.org>



On 22/05/18 03:51 PM, Bjorn Helgaas wrote:
> I don't think the question of when the aliases need to be added is
> quite closed.  Logan said "it seems pci_add_dma_alias() must be called
> before the driver is initialized and therefore in a quirk", but that
> doesn't make clear *why* the alias needs to be added before the driver
> is initialized.  The alias shouldn't be needed until the device does a
> DMA, and it shouldn't do that until after the driver initializes.

No, Doug tried it in the driver first and it didn't work. The symbol is
also not exported which was probably done because it can't be used in
the driver.

> I suspect the reason the existing quirks are in drivers/pci/quirks.c
> is because the IOMMU driver is in the host OS, but the host may not
> have a driver for the device if the device is passed through to a
> guest OS.  In that case, the only way to add the alias is by using a
> quirk that is always built into the host OS.

Digging into the code a bit, it's not because it must be done by the
Host OS but because it must be done before the IOMMU groups are created.
The IOMMU code registers a bus_notifier and creates the groups based on
the dma_alias mask when it receives the BUS_NOTIFY_ADD_DEVICE event.
This event is notified in device_add() just before a call to
bus_probe_device()[1]. Therefore, if a driver attempts to use
pci_add_dma_alias() as part of it's probe routine, it will be too late
as the IOMMU has already setup the groups based on the original version
of the dma_alias_mask.

I suspect this is by design as the groups must be created before and any
dma_maps are done on the device and some drivers may create dma_maps
during probe.

Logan

[1]
https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/base/core.c#L1863
