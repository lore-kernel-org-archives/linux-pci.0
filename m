Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        "liudongdong (C)"
	<liudongdong3@huawei.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "rafael@kernel.org" <rafael@kernel.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "tn@semihalf.com"
	<tn@semihalf.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "Chenxin (Charles)"
	<charles.chenxin@huawei.com>,
        "hanjun.guo@linaro.org"
	<hanjun.guo@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V5 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Date: Mon, 21 Nov 2016 09:09:28 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9270ED@lhreml507-mbx>
References: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com>
 <1479460951-49281-3-git-send-email-liudongdong3@huawei.com>
 <20161118170821.GH25762@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161118170821.GH25762@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn=20

Many thanks for your review

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: 18 November 2016 17:08
> To: liudongdong (C)
> Cc: arnd@arndb.de; rafael@kernel.org; Lorenzo.Pieralisi@arm.com;
> tn@semihalf.com; Wangzhou (B); pratyush.anand@gmail.com; linux-
> pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; jcm@redhat.com; Gabriele Paoloni; Chenxin
> (Charles); hanjun.guo@linaro.org; Linuxarm
> Subject: Re: [PATCH V5 2/2] PCI/ACPI: hisi: Add ACPI support for
> HiSilicon SoCs Host Controllers
>=20
> Hi guys,
>=20
> On Fri, Nov 18, 2016 at 05:22:31PM +0800, Dongdong Liu wrote:
> > PCIe controller in Hip05/HIP06/HIP07 SoCs is not ECAM compliant.
> > It is non ECAM only for the RC bus config space;for any other bus
> > underneath the root bus we support ECAM access.
> > Add specific quirks for PCI config space accessors.This involves:
> > 1. New initialization call hisi_pcie_init() to obtain rc base
> > addresses from PNP0C02 at the root of the ACPI namespace (under
> \_SB).
> > 2. New entry in common quirk array.
>=20
> This is great!  I think we're almost there.
>=20
> The only real technical issue I see is that based on the logs at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D187961 (thank you very
> much for them!), there is no _CRS description of the ECAM space.
>=20
> You have a PNP0C02 device for every host bridge, which is good.  It
> describes the RC register space, as it should.  But it should *also*
> describe the ECAM space, which it currently does not.
>=20
> The result is this in /proc/iomem:
>=20
>   a0200000-a020ffff : pnp 00:01           # PCI1 registers, from _CRS
>   a0090000-a009ffff : pnp 00:00           # PCI0 registers, from _CRS
>   a00a0000-a00affff : pnp 00:02           # PCI2 registers, from _CRS
>   a8000000-a9ffffff : PCI ECAM            # pci/ecam.c request for PCI2
>   b0000000-b1ffffff : PCI ECAM            # pci/ecam.c request for PCI0
>   be000000-bfffffff : PCI ECAM            # pci/ecam.c request for PCI1
>=20
> We *should* have this:
>=20
>   a0200000-a020ffff : pnp 00:01           # PCI1 registers, from _CRS
>   a0090000-a009ffff : pnp 00:00           # PCI0 registers, from _CRS
>   a00a0000-a00affff : pnp 00:02           # PCI2 registers, from _CRS
>   a8000000-a9ffffff : pnp 00:02           # PCI2 ECAM space, from _CRS
>     a8000000-a9ffffff : PCI ECAM          # pci/ecam.c request for PCI2
>   b0000000-b1ffffff : pnp 00:00           # PCI0 ECAM space, from _CRS
>     b0000000-b1ffffff : PCI ECAM          # pci/ecam.c request for PCI0
>   be000000-bfffffff : pnp 00:01           # PCI1 ECAM space, from _CRS
>     be000000-bfffffff : PCI ECAM          # pci/ecam.c request for PCI1
>=20
> If you add the ECAM space to the HISI0081 _CRS and it doesn't change
> the /proc/iomem contents, don't worry.  Those "pnp 00:xx" reservations
> are done by pnp/system.c, and we currently do those out of order
> (after the ECAM requests), so they might fail.  For example, on my x86
> laptop, I have this:
>=20
>   PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-
> 0xfbffffff] (base 0xf8000000)
>   system 00:01: [mem 0xf8000000-0xfbffffff] could not be reserved

Sure we'll do as you suggested

>=20
> Another minor comment/question below.
>=20
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  MAINTAINERS                       |   1 +
> >  drivers/acpi/pci_mcfg.c           |  13 ++++
> >  drivers/pci/host/Kconfig          |   8 +++
> >  drivers/pci/host/Makefile         |   1 +
> >  drivers/pci/host/pcie-hisi-acpi.c | 124
> ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-ecam.h          |   5 ++
> >  6 files changed, 152 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1cd38a7..b224caa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9358,6 +9358,7 @@ L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> >  F:	drivers/pci/host/pcie-hisi.c
> > +F:	drivers/pci/host/pcie-hisi-acpi.c
> >
> >  PCIE DRIVER FOR ROCKCHIP
> >  M:	Shawn Lin <shawn.lin@rock-chips.com>
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index ac21db3..b1b6fc7 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -57,6 +57,19 @@ struct mcfg_fixup {
> >  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
> >  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
> >  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
> > +#ifdef CONFIG_PCI_HISI_ACPI
> > +	#define PCI_ACPI_QUIRK_QUAD_DOM(table_id, seg, ops) \
> > +	{ "HISI  ", table_id, 0, seg + 0, MCFG_BUS_ANY, ops }, \
> > +	{ "HISI  ", table_id, 0, seg + 1, MCFG_BUS_ANY, ops }, \
> > +	{ "HISI  ", table_id, 0, seg + 2, MCFG_BUS_ANY, ops }, \
> > +	{ "HISI  ", table_id, 0, seg + 3, MCFG_BUS_ANY, ops }
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP05   ", 0, &hisi_pcie_ops),
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP06   ", 0, &hisi_pcie_ops),
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 0, &hisi_pcie_ops),
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 4, &hisi_pcie_ops),
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 8, &hisi_pcie_ops),
> > +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
> > +#endif
> >  };
> >
> >  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index ae98644..9ff2bcd 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -227,6 +227,14 @@ config PCI_HISI
> >  	  Say Y here if you want PCIe controller support on HiSilicon
> >  	  Hip05 and Hip06 and Hip07 SoCs
> >
> > +config PCI_HISI_ACPI
> > +	depends on ACPI && ARM64
> > +	bool "HiSilicon Hip05 and Hip06 and Hip07 SoCs ACPI PCIe
> controllers"
> > +	select PNP
> > +	help
> > +	  Say Y here if you want ACPI PCIe controller support on
> HiSilicon
> > +	  Hip05 and Hip06 and Hip07 SoCs
>=20
> I'm not sure about this Kconfig setup.  Do we really want to force
> people to enable a special config option to get this support?
>=20
> I'm comparing it in my mind with other PCI quirks.  They're all
> enabled as a group by CONFIG_PCI_QUIRKS.  Ultimately we want an ACPI
> kernel to work without requiring any platform-specific config options.
>=20
> I'm wondering if we should consolidate all the ECAM quirk code in a
> single place (maybe pci/ecam-quirks.c, pci/ecam.c, or pci/pci-acpi.c),
> under a config option like CONFIG_PCI_ECAM_QUIRKS or maybe even plain
> CONFIG_PCI_QUIRKS (of course, it could still be qualified by
> CONFIG_ACPI and CONFIG_ARM64).

What about having a single config options but keeping separate files
for each vendors (at least as first step)?

Maybe if we see that we can consolidate all the vendors in one file
we can do it as a second step...

Thanks

Gab

>=20
> >  config PCIE_QCOM
> >  	bool "Qualcomm PCIe controller"
> >  	depends on ARCH_QCOM && OF
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > index 084cb49..9402858 100644
> > --- a/drivers/pci/host/Makefile
> > +++ b/drivers/pci/host/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) +=3D pcie-iproc-bcma.o
> >  obj-$(CONFIG_PCIE_ALTERA) +=3D pcie-altera.o
> >  obj-$(CONFIG_PCIE_ALTERA_MSI) +=3D pcie-altera-msi.o
> >  obj-$(CONFIG_PCI_HISI) +=3D pcie-hisi.o
> > +obj-$(CONFIG_PCI_HISI_ACPI) +=3D pcie-hisi-acpi.o
> >  obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> >  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) +=3D pci-thunder-ecam.o
> >  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) +=3D pci-thunder-pem.o
> > diff --git a/drivers/pci/host/pcie-hisi-acpi.c
> b/drivers/pci/host/pcie-hisi-acpi.c
> > new file mode 100644
> > index 0000000..358c7c9
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-hisi-acpi.c
> > @@ -0,0 +1,124 @@
> > +/*
> > + * PCIe host controller driver for HiSilicon HipXX SoCs
> > + *
> > + * Copyright (C) 2016 HiSilicon Co., Ltd. http://www.hisilicon.com
> > + *
> > + * Author: Dongdong Liu <liudongdong3@huawei.com>
> > + *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/pci.h>
> > +#include <linux/pci-acpi.h>
> > +#include <linux/pci-ecam.h>
> > +#include "../pci.h"
> > +
> > +static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn,
> int where,
> > +				  int size, u32 *val)
> > +{
> > +	struct pci_config_window *cfg =3D bus->sysdata;
> > +	int dev =3D PCI_SLOT(devfn);
> > +
> > +	if (bus->number =3D=3D cfg->busr.start) {
> > +		/* access only one slot on each root port */
> > +		if (dev > 0)
> > +			return PCIBIOS_DEVICE_NOT_FOUND;
> > +		else
> > +			return pci_generic_config_read32(bus, devfn, where,
> > +							 size, val);
> > +	}
> > +
> > +	return pci_generic_config_read(bus, devfn, where, size, val);
> > +}
> > +
> > +static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
> > +				  int where, int size, u32 val)
> > +{
> > +	struct pci_config_window *cfg =3D bus->sysdata;
> > +	int dev =3D PCI_SLOT(devfn);
> > +
> > +	if (bus->number =3D=3D cfg->busr.start) {
> > +		/* access only one slot on each root port */
> > +		if (dev > 0)
> > +			return PCIBIOS_DEVICE_NOT_FOUND;
> > +		else
> > +			return pci_generic_config_write32(bus, devfn, where,
> > +							  size, val);
> > +	}
> > +
> > +	return pci_generic_config_write(bus, devfn, where, size, val);
> > +}
> > +
> > +static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned
> int devfn,
> > +				       int where)
> > +{
> > +	struct pci_config_window *cfg =3D bus->sysdata;
> > +	void __iomem *reg_base =3D cfg->priv;
> > +
> > +	if (bus->number =3D=3D cfg->busr.start)
> > +		return reg_base + where;
> > +	else
> > +		return pci_ecam_map_bus(bus, devfn, where);
> > +}
> > +
> > +/*
> > + * Retrieve RC base and size from PNP0C02 at the root of the ACPI
> namespace
> > + * (under \_SB).
> > + * Scope(_SB)
> > + * {
> > + *   Device (PCI0)
> > + *   {
> > + *     Name(_HID, "PNP0A08")
> > + *     Name(_CID, "PNP0A03")
> > + *     Name(_SEG, 0)
> > + *     ......
> > + *   }
> > + *   Device (RES0)
> > + *   {
> > + *     Name(_HID, "HISI0081")
> > + *     Name(_CID, "PNP0C02")
> > + *     Name(_UID, 0x0)
> > + *     Name(_CRS, ResourceTemplate (){
> > + *       Memory32Fixed (ReadWrite, 0xa0090000, 0x10000)
> > + *     })
> > + *   }
> > + *   ......
> > + * }
> > + */
> > +static int hisi_pcie_init(struct pci_config_window *cfg)
> > +{
> > +	struct acpi_device *adev =3D to_acpi_device(cfg->parent);
> > +	struct acpi_pci_root *root =3D acpi_driver_data(adev);
> > +	void __iomem *reg_base;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	res =3D devm_kzalloc(&adev->dev, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	ret =3D acpi_get_rc_resources("HISI0081", root->segment, res);
> > +	if (ret) {
> > +		dev_err(&adev->dev, "can't get rc base address");
> > +		return ret;
> > +	}
> > +
> > +	reg_base =3D devm_ioremap(&adev->dev, res->start,
> resource_size(res));
> > +	if (!reg_base)
> > +		return -ENOMEM;
> > +
> > +	cfg->priv =3D reg_base;
> > +	return 0;
> > +}
> > +
> > +struct pci_ecam_ops hisi_pcie_ops =3D {
> > +	.bus_shift    =3D 20,
> > +	.init         =3D  hisi_pcie_init,
> > +	.pci_ops      =3D {
> > +		.map_bus    =3D hisi_pcie_map_bus,
> > +		.read       =3D hisi_pcie_acpi_rd_conf,
> > +		.write      =3D hisi_pcie_acpi_wr_conf,
> > +	}
> > +};
> > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > index f5740b7..1b24d97 100644
> > --- a/include/linux/pci-ecam.h
> > +++ b/include/linux/pci-ecam.h
> > @@ -67,4 +67,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus,
> unsigned int devfn,
> >  int pci_host_common_probe(struct platform_device *pdev,
> >  			  struct pci_ecam_ops *ops);
> >  #endif
> > +
> > +#ifdef CONFIG_PCI_HISI_ACPI
> > +extern struct pci_ecam_ops hisi_pcie_ops;
> > +#endif
> > +
> >  #endif
> > --
> > 1.9.1
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
