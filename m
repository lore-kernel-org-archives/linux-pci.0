Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Tue, 10 May 2016 11:27:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>,
	rafael@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, robert.richter@caviumnetworks.com,
	mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge
 device companion assignment to core code.
Message-ID: <20160510102721.GB15552@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <20160427024537.GH6789@localhost>
 <5729AE92.2090106@semihalf.com>
 <8183907.bBqvG1yEkP@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8183907.bBqvG1yEkP@vostro.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 10, 2016 at 12:18:59AM +0200, Rafael J. Wysocki wrote:

[...]

> > >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > >> index ae3fe4e..4581e0e 100644
> > >> --- a/drivers/acpi/pci_root.c
> > >> +++ b/drivers/acpi/pci_root.c
> > >> @@ -564,6 +564,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
> > >>   		}
> > >>   	}
> > >>
> > >> +	/*
> > >> +	 * pci_create_root_bus() needs to detect the parent device type,
> > >> +	 * so initialize its companion data accordingly.
> > >> +	 */
> > >> +	ACPI_COMPANION_SET(&device->dev, device);
> > >>   	root->device = device;
> > >>   	root->segment = segment & 0xFFFF;
> > >>   	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
> > >> @@ -846,7 +851,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> > >>
> > >>   	pci_acpi_root_add_resources(info);
> > >>   	pci_add_resource(&info->resources, &root->secondary);
> > >> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> > >> +	bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
> > >>   				  sysdata, &info->resources);
> > >
> > > "device" here is a struct acpi_device *.  Rafael, is that the right
> > > thing to do?  I dimly recall proposing something similar long ago and
> > > that it turned out to be a bad idea.
> > >
> > 
> > Joining Bjorn's question. Rafael, do you recall what was the issue here 
> > from the past?
> 
> Yes, I do.
> 
> Anything struct acpi_device doesn't represent a real device.  It
> represents a firmware object that can be associated with a device.
> IOW, nothing under LNXSYSTM\:00/ should ever be used as the parent or
> sibling etc with respect to anything outside of that directory.  In
> fact, the entire LNXSYSTM\:00/ should be located under
> /sys/firmware/acpi/ and it was a mistake to put it under
> /sys/devices/.
> 
> One immediate consequence of the above change, AFAICS, would be that
> the whole PCI hierarchy would now hang under
> /sys/devices/LNXSYSTM\:00/LNXSYBUS\:00/PNP0A08\:00/ which would not
> make any sense whatever, because
> /sys/devices/LNXSYSTM\:00/LNXSYBUS\:00/PNP0A08\:00/physical_node
> already points to /sys/devices/pci0000\:00/.
> 
> IOW, both PNP0A08\:00/ and pci0000\:00/ already represent the same
> thing, ie. the host bridge.
> 
> If you want to have a parent for pci0000\:00/, you need a
> physical_node for LNXSYBUS\:00 and point to that as the parent from
> pci0000\:00/.  That at least will lead to a sysfs hierarchy that makes
> sense, although it may break user space tools I suppose (which may be
> assuming that pci0000\:00/ will always be present directly under
> /sys/devices/).

Ok, I have a question though. As an example, DT based host controllers
(that pass the parent pointer to pci_create_root_bus()), are already
rooted at the respective host controller platform device sysfs path, so
if user space can't cope with that, that is a problem *now* on some
systems unless I am missing something.

Anyway, thanks for clarifying the companion handling mechanism, we
decidedly have to find a proper way to handle it instead of working
around it.

Lorenzo
