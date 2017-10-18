Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Will Deacon <will.deacon@arm.com>
Subject: RE: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Date: Wed, 18 Oct 2017 12:25:09 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838448830@FRAEML521-MBX.china.huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
 <20171013192209.GH30572@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838437676@FRAEML521-MBS.china.huawei.com>
 <20171018105145.GC11669@arm.com>
In-Reply-To: <20171018105145.GC11669@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, John
 Garry <john.garry@huawei.com>, "Guohanjun
 \(Hanjun Guo\)" <guohanjun@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Wednesday, October 18, 2017 11:52 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: lorenzo.pieralisi@arm.com; marc.zyngier@arm.com;
> sudeep.holla@arm.com; robin.murphy@arm.com; joro@8bytes.org;
> bhelgaas@google.com; Gabriele Paoloni <gabriele.paoloni@huawei.com>;
> John Garry <john.garry@huawei.com>; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; devel@acpica.org; Linuxarm <linuxarm@huawei.com>;
> Wangzhou (B) <wangzhou1@hisilicon.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>
> Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers behind
> SMMUv3
> 
> On Sun, Oct 15, 2017 at 07:46:34AM +0000, Shameerali Kolothum Thodi wrote:
> >
> >
> > > -----Original Message-----
> > > From: Will Deacon [mailto:will.deacon@arm.com]
> > > Sent: Friday, October 13, 2017 8:22 PM
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: lorenzo.pieralisi@arm.com; marc.zyngier@arm.com;
> > > sudeep.holla@arm.com; robin.murphy@arm.com; joro@8bytes.org;
> > > bhelgaas@google.com; Gabriele Paoloni <gabriele.paoloni@huawei.com>;
> > > John Garry <john.garry@huawei.com>; iommu@lists.linux-foundation.org;
> > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org; linux-
> > > pci@vger.kernel.org; devel@acpica.org; Linuxarm
> <linuxarm@huawei.com>;
> > > Wangzhou (B) <wangzhou1@hisilicon.com>; Guohanjun (Hanjun Guo)
> > > <guohanjun@huawei.com>
> > > Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
> behind
> > > SMMUv3
> > >
> > > On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > > > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > > > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > > > transactions.
> > > >
> > > > PCIe controller on these platforms has to differentiate the MSI
> > > > payload against other DMA payload and has to modify the MSI payload.
> > > > This basically makes it difficult for this platforms to have a SMMU
> > > > translation for MSI. In order to workaround this, ARM
> > > > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > > > Such a quirk is currently missing for DT based systems and therefore
> > > > we need to blacklist the hip06/hip07 PCIe controllers.
> > > >
> > > > Signed-off-by: Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > >  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> > > > index a201791..6800747 100644
> > > > --- a/drivers/pci/dwc/pcie-hisi.c
> > > > +++ b/drivers/pci/dwc/pcie-hisi.c
> > > > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> > > *pdev)
> > > >  	struct resource *reg;
> > > >  	int ret;
> > > >
> > > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > > +			of_property_read_bool(dev->of_node, "iommu-
> > > map")) {
> > > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > > PCIe controllers behind SMMUv3\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > >  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> > > >  	if (!hisi_pcie)
> > > >  		return -ENOMEM;
> > > > @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct
> > > platform_device *pdev)
> > > >  	struct device *dev = &pdev->dev;
> > > >  	struct pci_ecam_ops *ops;
> > > >
> > > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > > +			of_property_read_bool(dev->of_node, "iommu-
> > > map")) {
> > > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > > PCIe controllers behind SMMUv3\n");
> > > > +		return -ENODEV;
> > > > +	}
> > >
> > > This isn't the right way to solve this problem. I was really hoping you'd
> come
> > > up with a solution for DT, and I know you've been trying, so I suppose for
> > > now we'll just have to go with the ACPI workaround you have and leave DT
> in
> > > the balance. I'm not at all happy with that, but I don't think this patch really
> > > improves things.
> >
> > Yes Will, this is to get the ACPI support enabled for now.
> >
> > > What I think you should do is remove the relevant smmu/iommu-map
> > > entries from the .dts files that are available for these platforms (i.e.
> > > comment them out with a description as to why).
> >
> > We don't have any smmu/iommu-map entries for these platforms in the
> > .dts files [1][2]. We are not aiming for any official DT support for these
> platforms.
> > This patch is to enforce the non-support.
> 
> Understood, but this has dragged on for a while and I don't think this patch
> is the right way to enforce things. The best approach might actually be to
> add the SMMU to the DTs, but commented out with a comment explaining why
> it's not a good idea to enable it.

Ok. Just to clarify, you would like to replace this patch with another 
one with smmu entries in dts and commenting/disabling them with explanation.
Or you would like to have that in addition to this one?

Please take a look at below snippet where I have added the smmu dts nodes
and disabled them with comments.

If this looks ok, I can sent it out soon. Please let me know.

Many Thanks,
Shameer

-- >8 --
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index a049b64..b561ac6 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -291,6 +291,20 @@
 			#interrupt-cells = <2>;
 			num-pins = <128>;
 		};
+
+		mbigen_pcie0: intc_pcie0 {
+			msi-parent = <&its_dsa 0x40085>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <10>;
+		};
+
+		mbigen_smmu_pcie_intc: intc_smmu_pcie {
+			msi-parent = <&its_dsa 0x40b0c>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <3>;
+		};
 	};
 
 	mbigen_dsa@c0080000 {
@@ -312,6 +326,27 @@
 		};
 	};
 
+	/** HiSilicon erratum 161010801: Please make sure that
+	 *  the smmu (pcie) node on hip06 is disabled as this will
+	 *  break the PCIe functionality when iommu-map entry
+	 *  is used along with the PCIe node.
+	 */
+	smmu0: smmu_pcie {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xa0040000 0x0 0x20000>;
+		interrupt-parent  = <&mbigen_smmu_pcie_intc>;
+		interrupts = <871 1>,
+			<872 1>,
+			<873 1>;
+
+		interrupt-names = "eventq", "gerror", "cmdq-sync";
+		#iommu-cells = <1>;
+		dma-coherent;
+		smmu-cb-memtype = <0x0 0x1>;
+		hisilicon,broken-prefetch-cmd;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -676,6 +711,29 @@
 				     <637 1>,<638 1>,<639 1>;
 			status = "disabled";
 		};
+
+		pcie0: pcie@a0090000 {
+			compatible = "hisilicon,pcie-almost-ecam";
+			reg = <0 0xb0000000 0 0x2000000>, <0 0xa0090000 0 0x10000>;
+			bus-range = <0  31>;
+			msi-map = <0x0000 &its_dsa 0x0000 0x2000>;
+			msi-map-mask = <0xffff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			/*iommu-map = <0x0 &smmu0 0x0 0x10000>;*/
+			ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0 0x5ff0000
+				  0x01000000 0 0 0 0xb7ff0000 0 0x10000>;
+			#interrupt-cells = <1>;
+                        interrupt-map-mask = <0xf800 0 0 7>;
+                        interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
+                                         0x0 0 0 2 &mbigen_pcie0 650 4
+                                         0x0 0 0 3 &mbigen_pcie0 650 4
+                                         0x0 0 0 4 &mbigen_pcie0 650 4>;
+			status = "disabled";
+		};
+
 	};
 
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 2c01a21..a483325 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1083,6 +1083,26 @@
 		};
 	};
 
+	/** HiSilicon erratum 161010801: Please make sure that
+	 *  the smmu (pcie) node on hip07 is disabled as this will
+	 *  break the PCIe functionality when iommu-map entry
+	 *  is used along with the PCIe node.
+	 */
+	smmu0: smmu_pcie {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xa0040000 0x0 0x20000>;
+		interrupt-parent  = <&mbigen_smmu_pcie>;
+		interrupts = <871 1>,
+			<872 1>,
+			<873 1>;
+		interrupt-names = "eventq", "gerror", "cmdq-sync";
+		#iommu-cells = <1>;
+		dma-coherent;
+		smmu-cb-memtype = <0x0 0x1>;
+		hisilicon,broken-prefetch-cmd;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -1546,6 +1566,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			/*iommu-map = <0x0 &smmu0 0x20000 0x10000>;*/
 			ranges = <0x02000000 0 0xa8000000 0 0xa8000000 0 0x77f0000
 				  0x01000000 0 0 0 0xaf7f0000 0 0x10000>;
 			#interrupt-cells = <1>;
-- >8 --


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
