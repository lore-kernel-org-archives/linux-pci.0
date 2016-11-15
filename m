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
        Linuxarm <linuxarm@huawei.com>, Jingoo Han
	<jingoohan1@gmail.com>
Subject: RE: [PATCH V4 1/2] PCI: hisi: Add ECAM support for devices that are
 not RC
Date: Tue, 15 Nov 2016 14:38:39 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F914B94@lhreml507-mbx>
References: <1478682897-119874-1-git-send-email-liudongdong3@huawei.com>
 <1478682897-119874-2-git-send-email-liudongdong3@huawei.com>
 <20161114230711.GA30262@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161114230711.GA30262@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many Thanks for your review

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 14 November 2016 23:07
> To: liudongdong (C)
> Cc: arnd@arndb.de; rafael@kernel.org; Lorenzo.Pieralisi@arm.com;
> tn@semihalf.com; Wangzhou (B); pratyush.anand@gmail.com; linux-
> pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; jcm@redhat.com; Gabriele Paoloni; Chenxin
> (Charles); hanjun.guo@linaro.org; Linuxarm; Jingoo Han
> Subject: Re: [PATCH V4 1/2] PCI: hisi: Add ECAM support for devices
> that are not RC
>=20
> [+cc Jingoo]
>=20
> On Wed, Nov 09, 2016 at 05:14:56PM +0800, Dongdong Liu wrote:
> > This patch modifies the current Hip05/Hip06 PCIe host
> > controller driver to add support for 'almost ECAM'
> > compliant platforms. Some controllers are ECAM compliant
> > for all the devices of the hierarchy except the root
> > complex; this patch adds support for such controllers.
> >
> > This is needed in preparation for the ACPI based driver
> > to allow both DT and ACPI drivers to use the same BIOS
> > (that configure the Designware iATUs).
> > This commit doesn't break backward compatibility with
> > previous non-ECAM platforms.
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > ---
> >  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 15 +++++---
> >  drivers/pci/host/Kconfig                           |  4 +-
> >  drivers/pci/host/pcie-designware.c                 |  4 +-
> >  drivers/pci/host/pcie-designware.h                 |  2 +
> >  drivers/pci/host/pcie-hisi.c                       | 45
> ++++++++++++++++++++++
> >  5 files changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > index 59c2f47..87a597a 100644
> > --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > @@ -9,10 +9,13 @@ Additional properties are described here:
> >
> >  Required properties
> >  - compatible: Should contain "hisilicon,hip05-pcie" or
> "hisilicon,hip06-pcie".
> > -- reg: Should contain rc_dbi, config registers location and length.
> > -- reg-names: Must include the following entries:
> > +- reg: Should contain rc_dbi and  either config or ecam-cfg
> registers
> > +       location and length (it depends on the platform BIOS).
> > +- reg-names: Must include
> >    "rc_dbi": controller configuration registers;
> > -  "config": PCIe configuration space registers.
> > +  and one of the following entries:
> > +    "config": PCIe configuration space registers for non-ECAM
> platforms.
> > +    "ecam-cfg": PCIe configuration space registers for ECAM
> platforms
> >  - msi-parent: Should be its_pcie which is an ITS receiving MSI
> interrupts.
> >  - port-id: Should be 0, 1, 2 or 3.
> >
> > @@ -23,8 +26,10 @@ Optional properties:
> >  Hip05 Example (note that Hip06 is the same except compatible):
> >  	pcie@0xb0080000 {
> >  		compatible =3D "hisilicon,hip05-pcie", "snps,dw-pcie";
> > -		reg =3D <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0
> 0x2000>;
> > -		reg-names =3D "rc_dbi", "config";
> > +		reg =3D <0 0xb0080000 0 0x10000>,
> > +		      <0x220 0x00000000 0 0x2000>
> > +		/* or <0x220 0x00100000 0 0x0f00000> for ecam-cfg*/;
>=20
> Add space before closing "*/".

Oops, thanks for spotting

>=20
> > +		reg-names =3D "rc_dbi", "config" /* or "ecam-cfg" */;
> >  		bus-range =3D <0  15>;
> >  		msi-parent =3D <&its_pcie>;
> >  		#address-cells =3D <3>;
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index d7e7c0a..ae98644 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -219,13 +219,13 @@ config PCIE_ALTERA_MSI
> >
> >  config PCI_HISI
> >  	depends on OF && ARM64
> > -	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> > +	bool "HiSilicon Hip05 and Hip06 and Hip07 SoCs PCIe controllers"
> >  	depends on PCI_MSI_IRQ_DOMAIN
> >  	select PCIEPORTBUS
> >  	select PCIE_DW
> >  	help
> >  	  Say Y here if you want PCIe controller support on HiSilicon
> > -	  Hip05 and Hip06 SoCs
> > +	  Hip05 and Hip06 and Hip07 SoCs
> >
> >  config PCIE_QCOM
> >  	bool "Qualcomm PCIe controller"
> > diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> > index 035f50c..da11644 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -101,8 +101,6 @@
> >  #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
> >  #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
> >
> > -static struct pci_ops dw_pcie_ops;
> > -
> >  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> >  {
> >  	if ((uintptr_t)addr & (size - 1)) {
> > @@ -800,7 +798,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus,
> u32 devfn,
> >  	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
> >  }
> >
> > -static struct pci_ops dw_pcie_ops =3D {
> > +struct pci_ops dw_pcie_ops =3D {
> >  	.read =3D dw_pcie_rd_conf,
> >  	.write =3D dw_pcie_wr_conf,
> >  };
> > diff --git a/drivers/pci/host/pcie-designware.h
> b/drivers/pci/host/pcie-designware.h
> > index a567ea2..30d228a 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -83,4 +83,6 @@ struct pcie_host_ops {
> >  void dw_pcie_setup_rc(struct pcie_port *pp);
> >  int dw_pcie_host_init(struct pcie_port *pp);
> >
> > +extern struct pci_ops dw_pcie_ops;
> > +
> >  #endif /* _PCIE_DESIGNWARE_H */
> > diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-
> hisi.c
> > index 56154c2..555c964 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -43,6 +43,34 @@ struct hisi_pcie {
> >  	struct pcie_soc_ops *soc_ops;
> >  };
> >
> > +static inline int hisi_rd_ecam_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> > +				    unsigned int devfn, int where, int size,
> > +				    u32 *value)
> > +{
> > +	return pci_generic_config_read(bus, devfn, where, size, value);
> > +}
> > +
> > +static inline int hisi_wr_ecam_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> > +				    unsigned int devfn, int where, int size,
> > +				    u32 value)
> > +{
> > +	return pci_generic_config_write(bus, devfn, where, size, value);
> > +}
> > +
> > +static void __iomem *hisi_pci_map_cfg_bus_cam(struct pci_bus *bus,
> > +					      unsigned int devfn,
> > +					      int where)
> > +{
> > +	void __iomem *addr;
> > +	struct pcie_port *pp =3D bus->sysdata;
> > +
> > +	addr =3D pp->va_cfg1_base - (pp->busn->start << 20) +
> > +		((bus->number << 20) | (devfn << 12)) +
> > +		where;
> > +
> > +	return addr;
> > +}
> > +
> >  /* HipXX PCIe host only supports 32-bit config access */
> >  static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int
> size,
> >  			      u32 *val)
> > @@ -190,6 +218,23 @@ static int hisi_pcie_probe(struct
> platform_device *pdev)
> >  		return PTR_ERR(pp->dbi_base);
> >  	}
> >
> > +	reg =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam-
> cfg");
> > +	if (reg) {
> > +		/* ECAM driver version */
> > +		hisi_pcie->pp.va_cfg0_base =3D
> > +		devm_ioremap_resource(&pdev->dev, reg);
> > +		if (IS_ERR(hisi_pcie->pp.va_cfg0_base)) {
> > +			dev_err(pp->dev, "cannot get ecam-cfg\n");
> > +			return PTR_ERR(hisi_pcie->pp.va_cfg0_base);
> > +		}
> > +		hisi_pcie->pp.va_cfg1_base =3D hisi_pcie->pp.va_cfg0_base;
> > +
> > +		dw_pcie_ops.map_bus =3D hisi_pci_map_cfg_bus_cam;
>=20
> I don't really like this part.  We're scribbling on dw_pcie_ops, which
> this
> driver does not own.  That breaks the encapsulation and means that
> using
> two different DW-based drivers in the same system (admittedly unlikely)
> would fail mysteriously.
>=20
> I wonder if this could be solved by allowing the DW-based drivers to
> supply
> their own pci_ops.  If we did that, it might let us get rid of the
> rd_own_conf, wr_own_conf, rd_other_conf, and wr_other_conf function
> pointers.  I haven't worked through it, but it's possible the result
> would
> be easier to read.
>=20
> It's also possible it would be a lot of code churn for no real gain,
> and
> breaking the encapsulation makes the most sense.  What do you think?

Yes you're right...

I am thinking that maybe we can split this in few steps:

1) We get the host controllers to pass their own pci_ops ( so we can modify
   dw_pcie_host_init() API to get pci_ops as input ) and move the pci_ops
   definitions to the respective host controller drivers

2) We investigate controller by controller if it makes sense to get rid of
   dw_pcie_rd_conf() and dw_pcie_wr_conf() and which desingware functions
   must be kept (probably dw_pcie_rd_other_conf() and dw_pcie_wr_other_conf=
()
   should be kept and used by the respective controllers)
=09
3) We rework controller by controller

4) We clean up the Designware framework to get rid of the functions not nee=
ded
   anymore

I think that 1) can go into this patchset, whereas 2), 3), 4) may go in a s=
eparate
one....

What do you think?

Thanks

Gab

>=20
> > +
> > +		hisi_pcie_host_ops.rd_other_conf =3D hisi_rd_ecam_conf;
> > +		hisi_pcie_host_ops.wr_other_conf =3D hisi_wr_ecam_conf;
> > +	}
> > +
> >  	ret =3D hisi_add_pcie_port(hisi_pcie, pdev);
> >  	if (ret)
> >  		return ret;
> > --
> > 1.9.1
> >
