Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Thu, 01 Sep 2016 16:02:19 +0200
Message-ID: <6532722.cVEMfv9Kqj@wuerfel>
In-Reply-To: <57C822C1.9000203@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <5913196.I3zIbc2qla@wuerfel> <57C822C1.9000203@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 1, 2016 8:44:49 PM CEST Dongdong Liu wrote:
> =E5=9C=A8 2016/9/1 15:41, Arnd Bergmann =E5=86=99=E9=81=93:
> > On Thursday, September 1, 2016 10:05:29 AM CEST Dongdong Liu wrote:
> >> =E5=9C=A8 2016/8/31 19:45, Arnd Bergmann =E5=86=99=E9=81=93:
> >>> On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
> I know your point.
>=20
> 1. For our host bridge , ".map_bus =3D pci_ecam_map_bus" is only suitable=
 for
> accessing the EP config space.
> pci_generic_config_read32() need to call "addr =3D bus->ops->map_bus(bus,=
 devfn, where & ~0x3);",
>=20
> drivers/pci/host/pcie-hisi-acpi.c
> static struct pci_ops hisi_pcie_ops =3D {
> 	.map_bus =3D pci_ecam_map_bus,
> 	.read =3D hisi_pcie_acpi_rd_conf,
> 	.write =3D hisi_pcie_acpi_wr_conf,
> };
>=20
> Yes, we can change ".map_bus =3D pci_ecam_map_bus" to ".map_bus =3D hisi_=
pci_map_bus", and implentment hisi_pci_map_bus as below,
> then we will not need to call hisi_pcie_common_cfg_read().
>=20
> void __iomem *hisi_pci_map_bus(struct pci_bus *bus, unsigned int devfn, i=
nt where)
> {
> 	struct pci_config_window *cfg =3D bus->sysdata;
> 	void __iomem *reg_base =3D cfg->priv;
>=20
> 	/* for RC config access*/
> 	if (bus->number =3D=3D cfg->busr.start)
> 		return reg_base + (where & ~0x3);
> 	else
> 		/* for EP config access */
> 		return pci_ecam_map_bus(bus, devfn, where);
> }
>=20
> and hisi_pcie_acpi_rd_conf() need to change as below.
> static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int whe=
re,
> 				  int size, u32 *val)
> {
> 	struct pci_config_window *cfg =3D bus->sysdata;
>=20
> 	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) =3D=3D 0)
> 		return PCIBIOS_DEVICE_NOT_FOUND;
> =09
> 	/* access RC config space */
> 	if (bus->number =3D=3D cfg->busr.start)
> 		return pci_generic_config_read32(bus, devfn, where, size, val);
> =09
> 	/* access EP config space */
> 	return pci_generic_config_read(bus, devfn, where, size, val);
> }

Right, this is what I had in mind.


> 2. We need to backward compatible with the old dt way config access as be=
low code,
> so we have to call hisi_pcie_common_cfg_read() when accessing the RC conf=
ig space.
> For this, we have to call hisi_pcie_common_cfg_read().
>=20
> drivers/pci/host/pcie-hisi.c
> static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
> 		int size, u32 *val)
> {
> 	struct hisi_pcie *pcie =3D to_hisi_pcie(pp);
>=20
> 	return hisi_pcie_common_cfg_read(pcie->reg_base, where, size, val);
> }
>=20
> static struct pcie_host_ops hisi_pcie_host_ops =3D {
> 	.rd_own_conf =3D hisi_pcie_cfg_read,
> 	.wr_own_conf =3D hisi_pcie_cfg_write,
> 	.link_up =3D hisi_pcie_link_up,
> };

I think this would be easier if you separate the ACPI code from the
DT code and not try to have a common file used for both.

Sharing the config space accessors really isn't worth it when both
variants are fairly simple to do, but they don't fit in a common
model because one is called from the ACPI quirks and the other
is called from the dw-pcie driver with completely different calling
conventions.

	ARnd
