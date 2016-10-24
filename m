Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Mon, 24 Oct 2016 13:56:06 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tomasz Nowicki <tn@semihalf.com>, wangzhou1@hisilicon.com,
	pratyush.anand@gmail.com, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jon Masters <jcm@redhat.com>, gabriele.paoloni@huawei.com,
	charles.chenxin@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>,
	linuxarm@huawei.com
Subject: Re: [PATCH V3 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Message-ID: <20161024125606.GA6918@red-moon>
References: <1476933034-46044-1-git-send-email-liudongdong3@huawei.com>
 <1476933034-46044-3-git-send-email-liudongdong3@huawei.com>
 <CAJZ5v0iHGYCuQmJjkrk1Chu15VMoJSA0yKe14XkSrLV9jX_XNQ@mail.gmail.com>
 <5809B1DC.2070605@huawei.com>
 <20161021160838.GA29335@red-moon>
 <580DB0A5.20406@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <580DB0A5.20406@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 24, 2016 at 02:56:37PM +0800, Dongdong Liu wrote:

[...]

> >The PNP0A08 acpi_device (that is what is pointed at by
> >struct acpi_device = to_acpi_device(pci_config_window.parent)
> >is the respective pci bridge device companion.
> >
> >arch/arm64/kernel/pci.c (pcibios_root_bridge_prepare()).
> >
> >Now for something completely different :), your RES2 pseudo-device.
> >
> >IIUC platform device (physical node) is created by the ACPI enumeration
> >code for your RES2 pseudo-device and its resources are already
> >initialized (by parsing its _CRS) in acpi_create_platform_device().
> 
> This is not right. About RES2 pseudo-device,it's _CID is PNP0C02,
> this will attach acpi_pnp_attach() (drivers/acpi/acpi_pnp.c) .
> acpi_pnp_attach() return 1;ret = acpi_scan_attach_handler() will return 1.
> So this will not call acpi_default_enumeration(),
> this also will not call acpi_create_platform_device().

Ah sorry, that's the correct way of handling things, I missed
the PNP0c02 matching (which by the way it looks like it is the
right solution to this problem), so I think your implementation is
correct from an ACPI point of view (as long as it is valid to have
a sub-device providing a _CRS whose address space is not contained
in its parent device).

Thanks !
Lorenzo

> drivers/acpi/scan.c
> static void acpi_bus_attach(struct acpi_device *device)
> {
> ......
> 	ret = acpi_scan_attach_handler(device);
> 	if (ret < 0)
> 		return;
> 
> 	device->flags.match_driver = true;
> 	if (!ret) {
> 		ret = device_attach(&device->dev);
> 		if (ret < 0)
> 			return;
> 	
> 		if (!ret && device->pnp.type.platform_id)
> 			acpi_default_enumeration(device);
> 	}
> ......
> }
> 
> Dongdong
> Thanks
> >
> >This means that by the time you match the PNP0A03/PNP0A08 child with an
> >acpi_device with _HID == "HISI0081", you can get its associated
> >physical node and get its resources IOMEM through the physical
> >node (ie platform device and related resources) instead of re-parsing
> >the _CRS if I am not mistaken (and that's an IF because I did not
> >test it).
> 
> As above said this does not re-parse the _CRS for RES2 pseudo-device.
> 
> Dongdong
> Thanks
> >
> >Regardless, I am not entirely sure there are kernel drivers/control
> >paths already using this mechanism to handle child devices (keeping in
> >mind that RES2 is not a real device at all, it is there to represent
> >PNP0A03 sub-address space for PCI quirks), so it would be good to get
> >Rafael's agreement on this approach to prevent abusing the current ACPI
> >platform devices glue code assumptions.
> >
> >It would also be good to agree on the whole approach soundness.
> >
> >Thanks,
> >Lorenzo
> >
> >.
> >
> 
