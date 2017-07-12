Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753333AbdGLW6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 18:58:46 -0400
Date: Wed, 12 Jul 2017 17:58:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: bhelgaas@google.com, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, bharat.kumar.gogada@xilinx.com,
        po.liu@nxp.com, christophe.jaillet@wanadoo.fr,
        paul.gortmaker@windriver.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] pcie-xilinx: OF-PCIe numbers legacy interrupts from 1
Message-ID: <20170712225833.GA4486@bhelgaas-glaptop.roam.corp.google.com>
References: <20170623215720.27057-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623215720.27057-1-palmer@dabbelt.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Paul]

On Fri, Jun 23, 2017 at 02:57:20PM -0700, Palmer Dabbelt wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
> 
> Without this patch we can't use the 4th legacy PCIe interrupt.  This
> is a workaround: there are only 4 legacy interrupts, but since they're
> numbered starting from 1 instead of 0 this just adds a 5th interrupt.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>

This is a duplicate of Paul Burton's patch, which we're still puzzling
over here:

http://lkml.kernel.org/r/20170712221455.GJ14614@bhelgaas-glaptop.roam.corp.google.com

If you have comments, please chime in on that discussion so it's not
fragmented between two threads.

> ---
>  drivers/pci/host/pcie-xilinx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 2fe2df51f9f8..8804145d399a 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>  				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
>  			generic_handle_irq(irq_find_mapping(port->leg_domain,
> -							    val));
> +							    val + 1));
>  		}
>  	}
>  
> @@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  		return -ENODEV;
>  	}
>  
> -	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
>  						 &intx_domain_ops,
>  						 port);
>  	if (!port->leg_domain) {
> -- 
> 2.13.0
> 
