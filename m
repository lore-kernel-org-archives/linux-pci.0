Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 May 2018 07:56:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yao Chen <chenyao11@huawei.com>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
Message-ID: <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dimitrysh@google.com, guodong.xu@linaro.org, linux-pci@vger.kernel.org,
 catalin.marinas@arm.com, wangbinghui@hisilicon.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 Stanimir Varbanov <svarbanov@mm-sol.com>, Jianguo Sun <sunjianguo1@huawei.com>,
 robh+dt@kernel.org, songxiaowei@hisilicon.com, bhelgaas@google.com,
 Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Stanimir, Jianguo, Shawn for qcom, histb comments below]

On Tue, May 08, 2018 at 03:03:48PM +0800, Yao Chen wrote:
> This patch adds kirin pcie msi feature.

Thanks for the patch!  Please update your subject and changelog like this:

  PCI: kirin: Add MSI support

  Add support for MSI.

You can figure out what style to use for the subject by running:

  git log --oneline drivers/pci/dwc/pcie-kirin.c

Then follow the existing style.

> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
>  drivers/pci/dwc/pcie-kirin.c              | 38 +++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ec3eb8e..4ef684f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -872,6 +872,8 @@
>  				  0x0 0x02000000>;
>  			num-lanes = <1>;
>  			#interrupt-cells = <1>;
> +			interrupts = <0 283 4>;
> +			interrupts-names = "msi";
>  			interrupt-map-mask = <0xf800 0 0 7>;
>  			interrupt-map = <0x0 0 0 1
>  					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a0..2319c9c 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static void kirin_pcie_msi_init(struct pcie_port *pp)
> +{
> +	dw_pcie_msi_init(pp);
> +}
> +
> +static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
> +{
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		kirin_pcie_msi_init(pp);
> +}
> +
>  static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>  	kirin_pcie_establish_link(pp);
> +	kirin_pcie_enable_interrupts(pp);
>  
>  	return 0;
>  }
> @@ -448,6 +467,25 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>  				      struct platform_device *pdev)
>  {
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +		if (!pci->pp.msi_irq) {
> +			dev_err(&pdev->dev, "failed to get msi irq\n");

s/msi irq/MSI IRQ/

> +			return -ENODEV;
> +		}
> +		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +				       kirin_pcie_msi_irq_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "kirin_pcie_msi", &pci->pp);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request msi irq\n");

s/msi irq/MSI IRQ/
Also, please include the IRQ number (pci->pp.msi_irq) in the message.

> +			return ret;
> +		}
> +	}
> +
> +	pci->pp.root_bus_nr = -1;

Setting root_bus_nr looks like an unrelated change that should be in a
separate patch.

But I'm not sure why you need to set root_bus_nr at all, since
dw_pcie_host_init() always sets it.

Some other callers of dw_pcie_host_init() do set it:

  exynos_add_pcie_port()
  imx6_add_pcie_port()
  armada8k_add_pcie_port()
  artpec6_add_pcie_port()
  dw_plat_add_pcie_port()
  histb_pcie_probe()
  qcom_pcie_probe()
  spear13xx_add_pcie_port()

But I don't see *why* any of these need to set it.  If they don't need to
set it, they shouldn't.

And it would be nice if histb and qcom followed the structure and naming
conventions of the other drivers, i.e., they should have
histb_add_pcie_port() and qcom_add_pcie_port().

>  	pci->pp.ops = &kirin_pcie_host_ops;
>  
>  	return dw_pcie_host_init(&pci->pp);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
