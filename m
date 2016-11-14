Return-Path: <heiko@sntech.de>
Return-Path: <heiko@sntech.de>
From: Heiko Stuebner <heiko@sntech.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Wei Yongjun <weiyj.lk@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, bharat.kumar.gogada@xilinx.com, robh@kernel.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in dra7xx_pcie_init_irq_domain()
Date: Mon, 14 Nov 2016 22:37:29 +0100
Message-ID: <6132489.PMT7H6dWFM@phil>
In-Reply-To: <20161114211928.GD9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com> <1d95b915-ddc0-b48f-270b-fffb60ecfe5e@ti.com> <20161114211928.GD9868@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Am Montag, 14. November 2016, 15:19:28 CET schrieb Bjorn Helgaas:
> [+cc Shawn, Heiko, Michal, Soren, Bharat, Rob H, Frank, devicetree@vger]
> 
> On Sat, Nov 12, 2016 at 12:39:01PM +0530, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > On Saturday 12 November 2016 03:08 AM, Bjorn Helgaas wrote:
> > > On Mon, Oct 17, 2016 at 02:54:37PM +0000, Wei Yongjun wrote:
> > >> From: Wei Yongjun <weiyongjun1@huawei.com>
> > >> 
> > >> This node pointer is returned by of_get_next_child() with refcount
> > >> incremented in this function. of_node_put() on it before exitting
> > >> this function on error.
> > >> 
> > >> This is detected by Coccinelle semantic patch.
> > >> 
> > >> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > 
> > > Kishon, this looks correct to me, so I applied it to pci/host-dra7xx for
> > > v4.10.  Let me know if you have any issue with it.
> > > 
> > >> ---
> > >> 
> > >>  drivers/pci/host/pci-dra7xx.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >> 
> > >> diff --git a/drivers/pci/host/pci-dra7xx.c
> > >> b/drivers/pci/host/pci-dra7xx.c
> > >> index 9595fad..79297e9 100644
> > >> --- a/drivers/pci/host/pci-dra7xx.c
> > >> +++ b/drivers/pci/host/pci-dra7xx.c
> > >> @@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct
> > >> pcie_port *pp)> >> 
> > >>  					       &intx_domain_ops, pp);
> > >>  	
> > >>  	if (!pp->irq_domain) {
> > >>  	
> > >>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > >> 
> > >> +		of_node_put(pcie_intc_node);
> > 
> > I think of_node_put should be used for both the error case and non-error
> > case.
> Hmm, OK.  I don't know what the rules are.  Certainly if we made these
> drivers modular, I don't think we'd want to leak these references
> every time we unload/reload the module.  Should we do the put
> immediately here, or in the module remove path, or ...?
> 
> Adding other driver and DT folks for comment.

I think the function above (dra7xx_pcie_init_irq_domain) can do the 
of_node_put at its end in all cases as suggested by Kishon.

of_get_next_child() will increment the refcount
	irq_domain_add_linear()
		__irq_domain_add() also increments the refcount


irq_domain_remove() will decrement the refcount

So it should be safe to decrement the refcount in 
dra7xx_pcie_init_irq_domain() in all cases as the irq-domain internals will 
always keep it above 1 as long as the node is used.


Heiko
