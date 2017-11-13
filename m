Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55145 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdKMG6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 01:58:30 -0500
Date: Mon, 13 Nov 2017 07:58:26 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20171113065826.zikx5nhsyrwacfg4@verge.net.au>
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
 <20171110085926.kjieahdrxr2euxoq@verge.net.au>
 <f745e84d-858b-ff64-c5e3-b48993fd9691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f745e84d-858b-ff64-c5e3-b48993fd9691@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:14:33PM +0100, Marek Vasut wrote:
> On 11/10/2017 09:59 AM, Simon Horman wrote:
> > Hi Marek,
> 
> Hi Simon,
> 
> > On Wed, Nov 08, 2017 at 10:28:04AM +0100, Marek Vasut wrote:
> >> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >>
> >> Reestablish the PCIe link very early in the resume process in case it
> >> went down to prevent PCI accesses from hanging the bus. Such accesses
> >> can happen early in the PCI resume process, in the resume_noirq, thus
> >> the link must be reestablished in the resume_noirq callback of the
> >> driver.
> >>
> >> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> > 
> > For patch-sets (with more than one patch) please provide a cover-letter.
> > The --cover-letter option to git format-patch can help.
> > 
> >> ---
> >>  drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
> >>  1 file changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> >> index 889603783f01..aa588a7d4811 100644
> >> --- a/drivers/pci/host/pcie-rcar.c
> >> +++ b/drivers/pci/host/pcie-rcar.c
> >> @@ -43,6 +43,7 @@
> >>  
> >>  /* Transfer control */
> >>  #define PCIETCTLR		0x02000
> >> +#define  DL_DOWN		(1 << 3)
> > 
> > Can you use the BIT() macro here?
> 
> Yes, I'll also add a patch to the series to convert all the others to
> the BIT() macro, to keep things consistent.

Great, thanks.

> >>  #define  CFINIT			1
> >>  #define PCIETSTR		0x02004
> >>  #define  DATA_LINK_ACTIVE	1
> >> @@ -529,7 +530,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
> >>  	phy_wait_for_ack(pcie);
> >>  }
> >>  
> >> -static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> >> +static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie, int atomic)
> > 
> > As Sergei mentioned bool seems like a more appropriate type for atomic.
> 
> I can actually get rid of this altogether.

Nice :)

> >>  {
> >>  	unsigned int timeout = 10;
> >>  
> >> @@ -537,7 +538,10 @@ static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
> >>  		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
> >>  			return 0;
> >>  
> >> -		msleep(5);
> >> +		if (atomic)
> >> +			mdelay(5);
> >> +		else
> >> +			msleep(5);
> > 
> > If we must delay, then I suppose this is reasonable.
> 
> See above
> 
> >>  	}
> >>  
> >>  	return -ETIMEDOUT;
> >> @@ -595,7 +599,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
> >>  	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> >>  
> >>  	/* This will timeout if we don't have a link. */
> >> -	err = rcar_pcie_wait_for_dl(pcie);
> >> +	err = rcar_pcie_wait_for_dl(pcie, 0);
> >>  	if (err)
> >>  		return err;
> >>  
> >> @@ -1110,6 +1114,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >>  	pcie = pci_host_bridge_priv(bridge);
> >>  
> >>  	pcie->dev = dev;
> >> +	platform_set_drvdata(pdev, pcie);
> >>  
> >>  	INIT_LIST_HEAD(&pcie->resources);
> >>  
> >> @@ -1173,10 +1178,30 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >>  	return err;
> >>  }
> >>  
> >> +static int rcar_pcie_resume_noirq(struct device *dev)
> >> +{
> >> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
> >> +	u32 val = rcar_pci_read_reg(pcie, PMSR);
> >> +	int ret = 0;
> >> +
> >> +	if ((val == 0) || (rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN)) {
> > 
> > Please remove the unnecessary parentheses from the line above.
> > 
> > Also, I would prefer if the function returned early.
> > Something like (completely untested!):
> 
> This should work.
> 
> > 	if (rcar_pci_read_reg(pcie, PMSR) &&
> > 	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> > 		return 0;
> > 
> > 	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > 	return rcar_pcie_wait_for_dl(pcie, 1);
> > 
> >> +		/* Re-establish the PCIe link */
> >> +		rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> >> +		ret = rcar_pcie_wait_for_dl(pcie, 1);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
> >> +	.resume_noirq = rcar_pcie_resume_noirq,
> >> +};
> >> +
> >>  static struct platform_driver rcar_pcie_driver = {
> >>  	.driver = {
> >>  		.name = "rcar-pcie",
> >>  		.of_match_table = rcar_pcie_of_match,
> >> +		.pm = &rcar_pcie_pm_ops,
> >>  		.suppress_bind_attrs = true,
> >>  	},
> >>  	.probe = rcar_pcie_probe,
> >> -- 
> >> 2.11.0
> >>
> 
> 
> -- 
> Best regards,
> Marek Vasut
> 
