Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to  work on both  Zynq and Microblaze
Date: Wed, 27 Jan 2016 14:33:45 +0000
Message-ID: <8520D5D51A55D047800579B09414719825873DA8@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-4-git-send-email-bharatku@xilinx.com>
 <4734542.KZZp0TeeeM@wuerfel>
In-Reply-To: <4734542.KZZp0TeeeM@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver
> to work on both Zynq and Microblaze
> 
> On Tuesday 12 January 2016 23:06:11 Bharat Kumar Gogada wrote:
> > Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
> > Zynq and Microblaze Architectures.
> > With these modifications drivers/pci/host/pcie-xilinx.c, will work on
> > both Zynq and Microblaze Architectures.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> 
> I think this patch should be split into three, as you are doing three unrelated
> things here.
> 
Agreed, will send as different patches in next series.
> > ---
> > --- a/drivers/pci/host/pcie-xilinx.c
> > +++ b/drivers/pci/host/pcie-xilinx.c
> > @@ -92,7 +92,12 @@
> >  #define ECAM_DEV_NUM_SHIFT		12
> >
> >  /* Number of MSI IRQs */
> > -#define XILINX_NUM_MSI_IRQS		128
> > +#define XILINX_NUM_MSI_IRQS	128
> > +#ifdef CONFIG_ARM
> > +#define TOT_NR_IRQS		XILINX_NUM_MSI_IRQS
> > +#else
> > +#define TOT_NR_IRQS		(NR_IRQS + XILINX_NUM_MSI_IRQS)
> > +#endif
> 
> Something looks wrong here in the microblaze variant. What does NR_IRQS
> have to do with it?
> 
> > @@ -238,15 +243,20 @@ static void xilinx_pcie_destroy_msi(unsigned int
> irq)
> >   */
> >  static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)  {
> > +	int irq;
> >  	int pos;
> >
> >  	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
> > -	if (pos < XILINX_NUM_MSI_IRQS)
> > +	irq = pos;
> > +#ifdef CONFIG_MICROBLAZE
> > +	irq = XILINX_NUM_MSI_IRQS + pos;
> > +#endif
> 
> 
> 	if (IS_ENABLED(CONFIG_MICROBLAZE))
> 		irq = XILINX_NUM_MSI_IRQS + pos;
> 
Agreed.
> > @@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct
> > platform_device *pdev)  #endif
> >  	pci_scan_child_bus(bus);
> >  	pci_assign_unassigned_bus_resources(bus);
> > +#ifdef CONFIG_ARM
> >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +#endif
> >  	pci_bus_add_devices(bus);
> >  	platform_set_drvdata(pdev, port);
> 
> Here it looks like microblaze gets it right. I'm not sure why we still need the
> pci_fixup_irqs() on ARM, but my feeling is that this should be fixed in
> common code.
In arm pci_fixup_irqs is called by pci_common_init_dev (arch/arm/kernel/bios32.c), since this API is removed now, I was calling it separately.

Bharat
