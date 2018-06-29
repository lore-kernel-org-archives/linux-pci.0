Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 29 Jun 2018 14:42:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Subject: Re: [PATCH] PCI: xilinx: add missing of_node_put()
Message-ID: <20180629134217.GD9643@red-moon>
References: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
In-Reply-To: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
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

On Wed, Jun 13, 2018 at 07:20:44PM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here after the last
> usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
> ---
> 
> Problem found by an experimental cocinelle script
> 
> Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
> COMPILE_TEST=y, PCIE_XILINX=y
> (with one sparse warning though not related to the change proposed)
> 
> Patch is against 4.17.0 (localversion-next is next-20180613)
> 
>  drivers/pci/controller/pcie-xilinx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index b110a3a..7b1389d 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -509,6 +509,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						 &intx_domain_ops,
>  						 port);
> +	of_node_put(pcie_intc_node);
>  	if (!port->leg_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENODEV;
> -- 
> 2.1.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
