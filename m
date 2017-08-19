Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 19 Aug 2017 16:18:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
Subject: Re: [PATCH 2/4] PCI:xilinx-nwl: Correcting Styling checks
Message-ID: <20170819211803.GV28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
 <1502190739-13474-3-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1502190739-13474-3-git-send-email-vjonnal@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, dmaengine@vger.kernel.org,
 paul.gortmaker@windriver.com, bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, vjonnal@xilinx.com,
 linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
 dan.j.williams@intel.com, vinod.koul@intel.com, soren.brinkmann@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 08, 2017 at 04:42:17PM +0530, Ravi Shankar Jonnalagadda wrote:

s/PCI:xilinx-nwl: Correcting Styling checks/PCI: xilinx-nwl: Clean up whitespace/

> Correcting Style checks thrown by checkpatch scripts

s/Correcting Style checks thrown/Correct whitespace errors reported/

> Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 5766582..3c62e3d 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -506,15 +506,15 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
> -				domain->host_data, handle_simple_irq,
> -				NULL, NULL);
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
>  	}
>  	mutex_unlock(&msi->lock);
>  	return 0;
>  }
>  
>  static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> -					unsigned int nr_irqs)
> +				unsigned int nr_irqs)
>  {
>  	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
>  	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> @@ -767,7 +767,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	/* Enable all misc interrupts */
>  	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
>  
> -
>  	/* Disable all legacy interrupts */
>  	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
>  
> @@ -932,4 +931,5 @@ static struct platform_driver nwl_pcie_driver = {
>  	},
>  	.probe = nwl_pcie_probe,
>  };
> +
>  builtin_platform_driver(nwl_pcie_driver);
> -- 
> 2.1.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
