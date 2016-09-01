Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Thu, 01 Sep 2016 09:41:03 +0200
Message-ID: <5913196.I3zIbc2qla@wuerfel>
In-Reply-To: <57C78CE9.3010707@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <4925807.5nZM1s8II1@wuerfel> <57C78CE9.3010707@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 1, 2016 10:05:29 AM CEST Dongdong Liu wrote:
>=20
> =E5=9C=A8 2016/8/31 19:45, Arnd Bergmann =E5=86=99=E9=81=93:
> > On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
> >> +
> >> +/* HipXX PCIe host only supports 32-bit config access */
> >> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int =
size,
> >> +                             u32 *val)
> >> +{
> >> +       u32 reg;
> >> +       u32 reg_val;
> >> +       void *walker =3D &reg_val;
> >> +
> >> +       walker +=3D (where & 0x3);
> >> +       reg =3D where & ~0x3;
> >> +       reg_val =3D readl(reg_base + reg);
> >> +
> >> +       if (size =3D=3D 1)
> >> +               *val =3D *(u8 __force *) walker;
> >> +       else if (size =3D=3D 2)
> >> +               *val =3D *(u16 __force *) walker;
> >
> > What is the __force for?
>=20
> Hi Arnd, thanks for replying.
>=20
> __force is used to, well, force a conversion, like casting from or to a b=
itwise type, else the Sparse checker will throw a warning.

I know what it's for in general, but in this case there is no __bitwise
or __iomem or any other annotation on either side of the assignment.

> >
> >> +       else if (size =3D=3D 4)
> >> +               *val =3D reg_val;
> >> +       else
> >> +               return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +
> >> +       return PCIBIOS_SUCCESSFUL;
> >
> > It looks like you are reimplementing pci_generic_config_read32/pci_gene=
ric_config_write32
> > read here, better use them directly.
> >
>=20
> For our host bridge, access RC and EP config space are not the same way.
> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
>=20
> hisi_pcie_common_cfg_read is used to read RC config space, only supports =
32-bit config access.
> hisi_pcie_common_cfg_read/hisi_pcie_common_cfg_write may change as below =
will be better.
>=20
> /* HipXX PCIe host only supports 32-bit config access */
> int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
> 			      u32 *val)
> {
> 	void __iomem *addr;
>=20
> 	addr =3D reg_base + (where & ~0x3);
> 	*val =3D readl(addr);
>=20
> 	if (size <=3D 2)
> 		*val =3D (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
>=20
> 	return PCIBIOS_SUCCESSFUL;
> }

My point was: why not call pci_generic_config_read32() when accessing
the RC config space instead of duplicating the code from it?

	Arnd
