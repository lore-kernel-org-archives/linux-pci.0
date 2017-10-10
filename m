Return-Path: <SRS0=KAGr=BJ=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=KAGr=BJ=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 10 Oct 2017 11:06:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	John Garry <john.garry@huawei.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	Linuxarm <linuxarm@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devel@acpica.org" <devel@acpica.org>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Message-ID: <20171010100630.GA764@red-moon>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
 <20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
 <5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 10, 2017 at 09:42:30AM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> > > index a201791..6800747 100644
> > > --- a/drivers/pci/dwc/pcie-hisi.c
> > > +++ b/drivers/pci/dwc/pcie-hisi.c
> > > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> > *pdev)
> > >  	struct resource *reg;
> > >  	int ret;
> > >
> > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > +			of_property_read_bool(dev->of_node, "iommu-
> > map")) {
> > 
> > Does the presence of "iommu-map" tell you this is an SMMUv3?  Could it
> > have a different type of IOMMU?  I can't tell from reading
> > Documentation/devicetree/bindings/pci/pci-iommu.txt.
> 
> Only if the SMMUv3 driver is loaded and iommu-map binding property present,
> the pcie devices will use SMMU translated iova for MSI doorbell addresses.

And the iommu-map property _actually_ points at an OF node with an
SMMUv3 compatible string - the sheer fact that the SMMUv3 driver
is compiled in is not sufficient IIUC.

Lorenzo

> > Why do you care whether CONFIG_ARM_SMMU_V3 is set?  Does MSI work
> > correctly if SMMUv3 is present but not used?
> 
> Yes. MSI will work if no SMMUv3 is used.
> 
> > Is it really necessary to ignore the PCIe controller completely?
> > Could you use the devices below it as long as you disable MSI for them?  I
> > know there are probably devices that require MSI, so maybe it's easier to
> > just ignore everything than to respond to reports of "my device doesn't work
> > because it requires MSI."
> 
> We are blacklisting MSI for PCIe only if the kernel is using DT and is configured
> to use SMMUv3. Otherwise it is fine. And as I said above DT is not officially
> supported on these platforms.
> 
> Thanks,
> Shameer
> 
> 1. [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
> https://www.spinics.net/lists/arm-kernel/msg602873.html
> 2. [PATCH v8 3/5] iommu/of: Add msi address regions reservation helper
> https://www.spinics.net/lists/arm-kernel/msg609431.html
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
