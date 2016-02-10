Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH v3 2/3] PCI: hisi: Add ECAM support to HiSilicon
 PCIe host controller
Date: Wed, 10 Feb 2016 09:39:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1544@lhreml503-mbs>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-3-git-send-email-gabriele.paoloni@huawei.com>
 <20160209181641.GB4348@leverpostej>
In-Reply-To: <20160209181641.GB4348@leverpostej>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark, thanks for reviewing

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Mark Rutland
> Sent: 09 February 2016 18:17
> To: Gabriele Paoloni
> Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> qiujiang; bhelgaas@google.com; arnd@arndb.de;
> Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth); linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [RFC PATCH v3 2/3] PCI: hisi: Add ECAM support to
> HiSilicon PCIe host controller
> 
> On Tue, Feb 09, 2016 at 05:34:19PM +0000, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > This patch modifies the current Hip05/Hip06 PCIe host
> > controller driver to add support for ECAM compliant
> > platforms.
> > This is needed in preparation for the ACPI based driver
> > to allow both DT and ACPI drivers to use the same BIOS
> > (that configure the Designware iATUs).
> > This commit doesn't break backward compatibility with
> > previous non-ECAM platforms.
> 
> Please forgive my ignorance, but if the system can be made ECAM
> compliant, why can the generic ECAM driver not be used in that case?

Sorry, you are right. The thing is that the driver is never
fully ECAM as for the RC config space there it uses 
"hisi_pcie_cfg_read()" and "hisi_pcie_cfg_write"; this is 
because generally Designware based controller are non-ECAM
and this is clear from:

http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L657

Here you can see that if bus->number == root_bus_nr a different
function is used to read/write configuration space registers

This patch implements ECAM support any connected PCIe device that
is not the root complex.

I will rephrase the patch in v4

Thanks

Gab

> 
> That would require no changes to this driver/binding.
> 
> Thanks,
> Mark.
> 
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > ---
> >  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 15 +++++---
> >  drivers/pci/host/pcie-designware.c                 |  4 +--
> >  drivers/pci/host/pcie-designware.h                 |  2 ++
> >  drivers/pci/host/pcie-hisi.c                       | 40
> ++++++++++++++++++++++
> >  4 files changed, 53 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > index b721bea..5a4c1e7 100644
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
> >  		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> > -		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0
> 0x2000>;
> > -		reg-names = "rc_dbi", "config";
> > +		reg = <0 0xb0080000 0 0x10000>,
> > +			  <0x220 0x00000000 0 0x2000>
> > +			/* or <0x220 0x00100000 0 0x0f00000> for ecam-cfg*/;
> > +		reg-names = "rc_dbi", "config" /* or "ecam-cfg" */;
> >  		bus-range = <0  15>;
> >  		msi-parent = <&its_pcie>;
> >  		#address-cells = <3>;
> > diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> > index 2171682..5f19ea4 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -69,8 +69,6 @@
> >  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> >  #define PCIE_ATU_UPPER_TARGET		0x91C
> >
> > -static struct pci_ops dw_pcie_ops;
> > -
> >  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> >  {
> >  	if ((uintptr_t)addr & (size - 1)) {
> > @@ -690,7 +688,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus,
> u32 devfn,
> >  	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
> >  }
> >
> > -static struct pci_ops dw_pcie_ops = {
> > +struct pci_ops dw_pcie_ops = {
> >  	.read = dw_pcie_rd_conf,
> >  	.write = dw_pcie_wr_conf,
> >  };
> > diff --git a/drivers/pci/host/pcie-designware.h
> b/drivers/pci/host/pcie-designware.h
> > index 2356d29..3f42655 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -80,4 +80,6 @@ int dw_pcie_link_up(struct pcie_port *pp);
> >  void dw_pcie_setup_rc(struct pcie_port *pp);
> >  int dw_pcie_host_init(struct pcie_port *pp);
> >
> > +extern struct pci_ops dw_pcie_ops;
> > +
> >  #endif /* _PCIE_DESIGNWARE_H */
> > diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-
> hisi.c
> > index 458d0f8..d3e2047 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -43,6 +43,18 @@ struct pcie_soc_ops {
> >  	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
> >  };
> >
> > +static inline int hisi_rd_ecam_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> > +		unsigned int devfn, int where, int size, u32 *value)
> > +{
> > +	return pci_generic_config_read(bus, devfn, where, size, value);
> > +}
> > +
> > +static inline int hisi_wr_ecam_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> > +		unsigned int devfn, int where, int size, u32 value)
> > +{
> > +	return pci_generic_config_write(bus, devfn, where, size, value);
> > +}
> > +
> >  static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int
> where,
> >  		int size, u32 *val)
> >  {
> > @@ -72,6 +84,17 @@ struct pcie_host_ops hisi_pcie_host_ops = {
> >  		.link_up = hisi_pcie_link_up,
> >  };
> >
> > +static void __iomem *hisi_pci_map_cfg_bus_cam(struct pci_bus *bus,
> > +					     unsigned int devfn,
> > +					     int where)
> > +{
> > +	void __iomem *addr;
> > +	struct pcie_port *pp = bus->sysdata;
> > +
> > +	addr = pp->va_cfg1_base + where;
> > +
> > +	return addr;
> > +}
> >
> >  static int hisi_add_pcie_port(struct pcie_port *pp,
> >  				     struct platform_device *pdev)
> > @@ -137,6 +160,23 @@ static int hisi_pcie_probe(struct
> platform_device *pdev)
> >
> >  	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
> >
> > +	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam-
> cfg");
> > +	if (reg) {
> > +		/* ECAM driver version */
> > +		hisi_pcie->pp.va_cfg0_base =
> > +				devm_ioremap_resource(&pdev->dev, reg);
> > +		if (IS_ERR(hisi_pcie->pp.va_cfg0_base)) {
> > +			dev_err(pp->dev, "cannot get ecam-cfg\n");
> > +			return PTR_ERR(hisi_pcie->pp.va_cfg0_base);
> > +		}
> > +		hisi_pcie->pp.va_cfg1_base = hisi_pcie->pp.va_cfg0_base;
> > +
> > +		dw_pcie_ops.map_bus = hisi_pci_map_cfg_bus_cam;
> > +
> > +		hisi_pcie_host_ops.rd_other_conf = hisi_rd_ecam_conf;
> > +		hisi_pcie_host_ops.wr_other_conf = hisi_wr_ecam_conf;
> > +	}
> > +
> >  	ret = hisi_add_pcie_port(pp, pdev);
> >  	if (ret)
> >  		return ret;
> > --
> > 1.9.1
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
