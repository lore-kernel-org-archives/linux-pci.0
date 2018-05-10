Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 May 2018 09:04:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yao Chen <chenyao11@huawei.com>
Subject: Re: [PATCH v2 1/2] PCI: kirin: Add MSI support
Message-ID: <20180510140431.GJ173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525854012-24228-1-git-send-email-chenyao11@huawei.com>
 <1525854012-24228-2-git-send-email-chenyao11@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1525854012-24228-2-git-send-email-chenyao11@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dimitrysh@google.com, guodong.xu@linaro.org, linux-pci@vger.kernel.org,
 catalin.marinas@arm.com, suzhuangluan@hisilicon.com, wangbinghui@hisilicon.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 kongfei@hisilicon.com, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 robh+dt@kernel.org, songxiaowei@hisilicon.com, bhelgaas@google.com,
 Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tejun, Wolfram]

On Wed, May 09, 2018 at 04:20:11PM +0800, Yao Chen wrote:
> Add support for MSI.
> ...

> @@ -448,6 +467,26 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>  				      struct platform_device *pdev)
>  {
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +		if (!pci->pp.msi_irq) {

I think this test is incorrect.  platform_get_irq() returns a negative
errno value when it fails.  Most calls test "irq < 0" to check for failure.

There's a lot of duplicated code like this, so maybe we should consider
putting that check into devm_request_irq(), similar to what
devm_ioremap_resource() does, so the driver code could look like this:

  pci->pp.msi_irq = platform_get_irq(pdev, 0);
  ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq, ...);
  if (ret) {
    dev_err(&pdev->dev, "failed to request MSI IRQ\n");
    return ret;
  }

The basic devm_ioremap_resource() motivation is here: 72f8c0bfa0de ("lib:
devres: add convenience function to remap a resource") and the same
considerations seem to apply here.

But that's more than you need to do for *this* series.  So for now, I would
simply fix the test to check for "irq < 0" and update the messages as I
mention below.

> +			dev_err(&pdev->dev, "failed to get msi irq[%d]\n",
> +				pci->pp.msi_irq);
> +			return -ENODEV;
> +		}
> +		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +				       kirin_pcie_msi_irq_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "kirin_pcie_msi", &pci->pp);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request msi irq[%d]\n",

s/msi irq/MSI IRQ/ in both dev_err() messages above.  This is because the
message is English text (not code), and the convention is that non-words
like these initialisms written in all caps.

I would style the first one as "failed to get MSI IRQ (%d)" because the %d
there is a return code, probably -ENXIO.

The second one should be "failed to request MSI IRQ %d" because here the %d
is the actual IRQ.

> +				pci->pp.msi_irq);
> +			return ret;
> +		}
> +	}
> +
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
