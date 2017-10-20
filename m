Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 20 Oct 2017 17:52:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] PCI: hisi: add PCIe driver support for HiSilicon STB SoCs
Message-ID: <20171020225248.GV6332@bhelgaas-glaptop.roam.corp.google.com>
References: <1508043971-23216-1-git-send-email-shawnguo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1508043971-23216-1-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Jianguo Sun <sunjianguo1@huawei.com>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 15, 2017 at 01:06:11PM +0800, Shawn Guo wrote:
> From: Jianguo Sun <sunjianguo1@huawei.com>
> 
> Add PCIe controller driver for HiSilicon STB SoCs,
> the controller is based on the DesignWare's PCIe core.

s/DesignWare's/DesignWare/

> Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/pci/hisilicon-histb-pcie.txt          |  66 +++
>  drivers/pci/dwc/Kconfig                            |  10 +
>  drivers/pci/dwc/Makefile                           |   1 +
>  drivers/pci/dwc/pcie-histb.c                       | 469 +++++++++++++++++++++
>  4 files changed, 546 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
>  create mode 100644 drivers/pci/dwc/pcie-histb.c

Looks beautiful overall!

This needs a MAINTAINERS update so "./scripts/get_maintainer.pl -f" prints
something useful.

A few minor nits below that I would fix myself, but since you need to
supply the MAINTAINERS update anyway, I'll let you do it :)

> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> new file mode 100644
> index 000000000000..9474ad9bc36c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> @@ -0,0 +1,66 @@
> +HiSilicon STB PCIe host bridge DT description
> +
> +HiSilicon STB PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.

s/Designware/DesignWare/ in English text above (not in filenames,
function names, etc).

s/PCI/PCIe/

> +static u32 histb_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)

These should be lined up exactly ("u32" should line up with "struct"
above it).  They are currently off by one.  Similarly for
histb_pcie_write_dbi(), histb_pcie_rd_own_conf(),
histb_pcie_wr_own_conf().

> +	hipcie->aux_clk = devm_clk_get(dev, "aux");
> +	if (IS_ERR(hipcie->aux_clk)) {
> +		dev_err(dev, "Failed to get pcie aux clk\n");

s/pcie/PCIe/ in this message and the ones below.  Also in
histb_pcie_host_enable() comment.

> +		return PTR_ERR(hipcie->aux_clk);
> +	}
> +
> +	hipcie->pipe_clk = devm_clk_get(dev, "pipe");
> +	if (IS_ERR(hipcie->pipe_clk)) {
> +		dev_err(dev, "Failed to get pcie pipe clk\n");
> +		return PTR_ERR(hipcie->pipe_clk);

> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0) {
> +			dev_err(dev, "Failed to get msi irq\n");
> +			return pp->msi_irq;
> +		}
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +				       histb_pcie_msi_irq_handler,
> +				       IRQF_SHARED, "histb-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(dev, "cannot request msi irq\n");

s/msi irq/MSI IRQ/ in the error message.  Also a few lines above.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
