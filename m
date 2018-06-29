Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 29 Jun 2018 14:43:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Subject: Re: [PATCH] PCI: xilinx-nwl: add missing of_node_put()
Message-ID: <20180629134317.GE9643@red-moon>
References: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
In-Reply-To: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2018 at 11:04:34AM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with
> refcount incremented thus it must be explicitly decremented
> here after the last usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
> ---
> 
> Problem found by an experimental cocinelle script
> 
> Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
> COMPILE_TEST=y, PCIE_XILINX_NWL=y
> (one sparse warning though not related to the change proposed though)
> 
> Patch is against 4.17.0 (localversion-next is next-20180613)
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 6a4bbb5..fb32840 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -559,7 +559,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  							PCI_NUM_INTX,
>  							&legacy_domain_ops,
>  							pcie);
> -
> +	of_node_put(legacy_intc_node);
>  	if (!pcie->legacy_irq_domain) {
>  		dev_err(dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
> -- 
> 2.1.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
