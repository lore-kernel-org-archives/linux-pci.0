Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938697AbcKNVTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 16:19:32 -0500
Date: Mon, 14 Nov 2016 15:19:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, bharat.kumar.gogada@xilinx.com,
        robh@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in
 dra7xx_pcie_init_irq_domain()
Message-ID: <20161114211928.GD9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
 <20161111213806.GI9868@bhelgaas-glaptop.roam.corp.google.com>
 <1d95b915-ddc0-b48f-270b-fffb60ecfe5e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1d95b915-ddc0-b48f-270b-fffb60ecfe5e@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Shawn, Heiko, Michal, Soren, Bharat, Rob H, Frank, devicetree@vger]

On Sat, Nov 12, 2016 at 12:39:01PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 12 November 2016 03:08 AM, Bjorn Helgaas wrote:
> > On Mon, Oct 17, 2016 at 02:54:37PM +0000, Wei Yongjun wrote:
> >> From: Wei Yongjun <weiyongjun1@huawei.com>
> >>
> >> This node pointer is returned by of_get_next_child() with refcount
> >> incremented in this function. of_node_put() on it before exitting
> >> this function on error.
> >>
> >> This is detected by Coccinelle semantic patch.
> >>
> >> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > Kishon, this looks correct to me, so I applied it to pci/host-dra7xx for
> > v4.10.  Let me know if you have any issue with it.
> > 
> >> ---
> >>  drivers/pci/host/pci-dra7xx.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> >> index 9595fad..79297e9 100644
> >> --- a/drivers/pci/host/pci-dra7xx.c
> >> +++ b/drivers/pci/host/pci-dra7xx.c
> >> @@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> >>  					       &intx_domain_ops, pp);
> >>  	if (!pp->irq_domain) {
> >>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> >> +		of_node_put(pcie_intc_node);
> 
> I think of_node_put should be used for both the error case and non-error case.

Hmm, OK.  I don't know what the rules are.  Certainly if we made these
drivers modular, I don't think we'd want to leak these references
every time we unload/reload the module.  Should we do the put
immediately here, or in the module remove path, or ...?

Adding other driver and DT folks for comment.

I dropped these patches for now (dra7xx, rockchip, xilinx-nwl,
xilinx).
