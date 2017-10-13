Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 13 Oct 2017 20:22:10 +0100
From: Will Deacon <will.deacon@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Message-ID: <20171013192209.GH30572@arm.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, gabriele.paoloni@huawei.com,
 marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org,
 john.garry@huawei.com, guohanjun@huawei.com, linuxarm@huawei.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 wangzhou1@hisilicon.com, sudeep.holla@arm.com, bhelgaas@google.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> The HiSilicon erratum 161010801 describes the limitation of
> HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> for MSI transactions.
> 
> PCIe controller on these platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI
> payload. This basically makes it difficult for this platforms to
> have a SMMU translation for MSI. In order to workaround this, ARM
> SMMUv3 driver requires a quirk to treat the MSI regions separately.
> Such a quirk is currently missing for DT based systems and therefore
> we need to blacklist the hip06/hip07 PCIe controllers.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index a201791..6800747 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	struct resource *reg;
>  	int ret;
>  
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
>  	if (!hisi_pcie)
>  		return -ENOMEM;
> @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_ecam_ops *ops;
>  
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}

This isn't the right way to solve this problem. I was really hoping you'd
come up with a solution for DT, and I know you've been trying, so I suppose
for now we'll just have to go with the ACPI workaround you have and leave DT
in the balance. I'm not at all happy with that, but I don't think this patch
really improves things.

What I think you should do is remove the relevant smmu/iommu-map entries
from the .dts files that are available for these platforms (i.e. comment
them out with a description as to why).

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
