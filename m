Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36099 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeCSKen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 06:34:43 -0400
Date: Mon, 19 Mar 2018 11:34:39 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Use runtime PM to control controller clock
Message-ID: <20180319103439.t6idzboizjtt4sgn@verge.net.au>
References: <20180318105209.5922-1-marek.vasut+renesas@gmail.com>
 <20180319084447.ce44arxneqd6i3bj@verge.net.au>
 <834f8473-3e3b-98b2-56e1-55a3c40aa2dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <834f8473-3e3b-98b2-56e1-55a3c40aa2dc@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:54:47AM +0100, Marek Vasut wrote:
> On 03/19/2018 09:44 AM, Simon Horman wrote:
> > On Sun, Mar 18, 2018 at 11:52:09AM +0100, Marek Vasut wrote:
> >> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> >>
> >> The controller clock can be switched off during suspend/resume,
> >> let runtime PM take care of that.
> >>
> >> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> >> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> To: linux-pci@vger.kernel.org
> >> ---
> >> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
> >>       reordering of function calls in probe
> >>     - Dispose of fail_clk in rcar_pcie_get_resources()
> >> V3: - Fix up the failpath in probe function
> >> V4: - Rebase on recent linux-next
> >> ---
> >>  drivers/pci/host/pcie-rcar.c | 40 ++++++++++++----------------------------
> >>  1 file changed, 12 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> >> index b4c4aad2cf66..93d59f15c589 100644
> >> --- a/drivers/pci/host/pcie-rcar.c
> >> +++ b/drivers/pci/host/pcie-rcar.c
> >> @@ -142,7 +142,6 @@ struct rcar_pcie {
> >>  	void __iomem		*base;
> >>  	struct list_head	resources;
> >>  	int			root_bus_nr;
> >> -	struct clk		*clk;
> >>  	struct clk		*bus_clk;
> >>  	struct			rcar_msi msi;
> >>  };
> >> @@ -914,24 +913,14 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
> >>  	if (IS_ERR(pcie->base))
> >>  		return PTR_ERR(pcie->base);
> >>  
> >> -	pcie->clk = devm_clk_get(dev, "pcie");
> >> -	if (IS_ERR(pcie->clk)) {
> >> -		dev_err(dev, "cannot get platform clock\n");
> >> -		return PTR_ERR(pcie->clk);
> >> -	}
> >> -	err = clk_prepare_enable(pcie->clk);
> >> -	if (err)
> >> -		return err;
> >> -
> >>  	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
> >>  	if (IS_ERR(pcie->bus_clk)) {
> >>  		dev_err(dev, "cannot get pcie bus clock\n");
> >> -		err = PTR_ERR(pcie->bus_clk);
> >> -		goto fail_clk;
> >> +		return PTR_ERR(pcie->bus_clk);
> >>  	}
> >>  	err = clk_prepare_enable(pcie->bus_clk);
> >>  	if (err)
> >> -		goto fail_clk;
> >> +		return err;
> >>  
> >>  	i = irq_of_parse_and_map(dev->of_node, 0);
> >>  	if (!i) {
> >> @@ -953,8 +942,6 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
> >>  
> >>  err_map_reg:
> >>  	clk_disable_unprepare(pcie->bus_clk);
> >> -fail_clk:
> >> -	clk_disable_unprepare(pcie->clk);
> >>  
> >>  	return err;
> >>  }
> >> @@ -1124,22 +1111,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >>  	if (err)
> >>  		goto err_free_bridge;
> > 
> > This error path now calls pci_free_resource_list() and in this case
> > the path is taken if rcar_pcie_parse_request_of_pci_ranges() fails.
> > Is that ok?
> 
> I think so, or did I miss something obvious?

I feel that I am the one missing something obvious.
But here is what I am worried about:

1. rcar_pcie_probe() calls rcar_pcie_parse_request_of_pci_ranges()
2. rcar_pcie_parse_request_of_pci_ranges() calls
   devm_request_pci_bus_resources() but that fails so
   pci_free_resource_list() is called and an error is returned.
3. rcar_pcie_probe() branches to err_free_bridge and calls
   pci_free_resource_list() again.

> 
> -- 
> Best regards,
> Marek Vasut
> 
