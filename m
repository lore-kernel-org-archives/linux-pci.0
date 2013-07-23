Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>
References: <002801ce8376$a807dbf0$f81793d0$@samsung.com>
 <51ED49D6.9050209@ti.com> <000701ce8741$fe47deb0$fad79c10$@samsung.com>
 <51EE22DF.6090902@ti.com>
In-reply-to: <51EE22DF.6090902@ti.com>
Subject: Re: [PATCH V3] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Tue, 23 Jul 2013 17:42:23 +0900
Message-id: <001401ce8780$8d8461f0$a88d25d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 23, 2013 3:30 PM, Kishon Vijay Abraham I wrote:
> On Tuesday 23 July 2013 06:44 AM, Jingoo Han wrote:
> > On Tuesday, July 23, 2013 12:04 AM, Kishon Vijay Abraham I wrote:
> >> On Thursday 18 July 2013 10:51 AM, Jingoo Han wrote:
> >>> Exynos PCIe IP consists of Synopsys specific part and Exynos
> >>> specific part. Only core block is a Synopsys designware part;
> >>> other parts are Exynos specific.
> >>> Also, the Synopsys designware part can be shared with other
> >>> platforms; thus, it can be split two parts such as Synopsys
> >>> designware part and Exynos specific part.
> >>
> >> some more queries and comments..
> >
> .
> .
> <snip>
> .
> .
> >>> +			of_pci_range_to_resource(&range, np, &pp->cfg);
> >>> +			pp->config.cfg0_size = resource_size(&pp->cfg)/2;
> >>> +			pp->config.cfg1_size = resource_size(&pp->cfg)/2;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
> >>> +				resource_size(&pp->cfg));

[.....]

> >
> >> Why should it be same as dbi_base?
> >> AFAIK, jacinto6 has a dedicated configuration/io/memory space that is entirely
> >> different from dbi_base.
> >
> > According to the Synopsys designware PCIe datasheet,
> > in chapter 5.1.1 Register Space Layout,
> > 'Port Logic Registers' are placed between (config space 0x0 + 0x700)
> > and (config space 0x0 + 0xFFF).
> > 'dbi_base' is used for reading/writing 'Port Logic Registers'.
> > Exynos are using 'dbi_base' like this. Thus, the base addresses of
> > both 'dbi_base' and configuration/io/memory space are same.
> >
> > Just now, I looked at Spear PCIe driver.
> > However, in the case of Spear, the base address of configuration/io/memory
> > space is defined as 0x80000000. The base address of 'Port Logic Registers'
> > is defined as 0xb1000000.
> > I think that the situation of 'jacinto6' is similar with Spear, right?
> >
> > Then, I will move pp->dbi_base mapping code from pcie-designware.c
> > to pci-exynos.c.
> 
> I think you need not move this to exynos (since registers in dbi_base is common
> for all platforms) but modify the pcie-designware.c to use different address
> space for dbi_base. In your case, you'll duplicate the address space for
> dbi_base and configuration space.
> 

I will map 'pp->dbi_base' as below:
Also, I referenced SPEAr PCIe patches made by Pratyush Anand.
(http://permalink.gmane.org/gmane.linux.kernel.pci/18400)
(http://permalink.gmane.org/gmane.linux.kernel.pci/18403)


1. The different addresses between dbi_base and configuration space
    : SPEAr PCIe, OMAP PCIe
      'pp->dbi_base' value is come from DT binding, then, 'pp->dbi_base' will
       be mapped in spear_pcie_probe() in pci-spear.c

(arch/arm/boot/dts/spear13xx.dtsi)
		pcie0@b1000000 {
			reg = <0xb1000000 0x2000      <-- dbi register
				 0xb1002000 0x7fdfff   <-- elbi register

(drivers/pci/host/pci-spear.c)
static int __init spear_pcie_probe(struct platform_device *pdev)
{
	struct resource *dbi_base;
	struct resource *elbi_base;

	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);

	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	spear_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);



2. The same addresses between dbi_base and configuration space
    : Exynos PCIe
      'pp->dbi_base' will be mapped in dw_pcie_host_init() of pcie-designware.c.

(drivers/pci/host/pcie-exynos.c)
static int __init exynos_pcie_probe(struct platform_device *pdev)
{
	struct resource *elbi_base;

	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);

(drivers/pci/host/pcie-designware.c)
int dw_pcie_host_init(struct pcie_port *pp)
{
	if (!pp->dbi_base) {
		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
						resource_size(&pp->cfg));
		if (!pp->dbi_base) {
			dev_err(pp->dev, "error with ioremap\n");
			return -ENOMEM;
		}
	}


Best regards,
Jingoo Han


